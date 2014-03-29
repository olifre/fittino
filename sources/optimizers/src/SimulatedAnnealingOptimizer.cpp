/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimulatedAnnealingOptimizer.cpp                                  *
*                                                                              *
* Description Class for simulated annealing optimization                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include "ModelBase.h"
#include "ModelParameter.h"
#include "SimulatedAnnealingOptimizer.h"

Fittino::SimulatedAnnealingOptimizer::SimulatedAnnealingOptimizer( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : _initialTemperature        ( ptree.get<double>( "InitialTemperature",         5.  ) ),
      _temperatureReductionFactor( ptree.get<double>( "TemperatureReductionFactor", 0.5 ) ),
      _temperature( _initialTemperature ),
      OptimizerBase( model, ptree ) {

    _name = ptree.get<std::string>( "Name", "simulated annealing optimization algorithm" );

    throw ConfigurationException( "WARNING: Optimizer does not work because of broken Model::Clone(). Fix that first!" );

}

Fittino::SimulatedAnnealingOptimizer::~SimulatedAnnealingOptimizer() {

}

void Fittino::SimulatedAnnealingOptimizer::PrintSteeringParameters() const {

    PrintItem( "NumberOfIterations",         _numberOfIterations         );
    PrintItem( "AbortCriterium",             _abortCriterium             );
    PrintItem( "InitialTemperature",         _initialTemperature         );
    PrintItem( "TemperatureReductionFactor", _temperatureReductionFactor );

}

void Fittino::SimulatedAnnealingOptimizer::UpdateModel() {

    std::vector<double> stepWidth;

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        stepWidth.push_back( 1. );

    }

    // The candidate for the new model is taken as the best model out of a number of trials which is
    // equal to 3 times the number of parameters of the model, but at least 60.

    unsigned int numberOfTrials = 60;

    if ( _model->GetNumberOfParameters() >= 20 ) {

        numberOfTrials = 3 * _model->GetNumberOfParameters();

    }

    // The actual best model and chi2 are stored here for future reference.

    ModelBase* bestModel = _model->Clone();
    double bestChi2 = bestModel->GetChi2();

    for ( unsigned int i = 0; i < numberOfTrials; i++ ) {

        // Within every trial, each parameter is varied one after another and the number of accepted
        // parameter variations is counted. A parameter variation is accepted if the new model has a
        // better chi2 value or if it fulfills the Metropolis criterium. This is repeated 20 times.
        // After that the step width for the next iteration of variations is updated for each
        // parameter individually.

        std::vector<int> numberOfAcceptedVariations;

        // Reset of the counter.

        for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

            numberOfAcceptedVariations.push_back( 0 );

        }

        for ( unsigned int j = 0; j < 20; j++ ) {

            // Variation of one parameter at a time.

            for ( unsigned int k = 0; k < _model->GetNumberOfParameters(); k++ ) {

                ModelBase* oldModel = _model->Clone();
                double oldChi2 = oldModel->GetChi2();

                // Update of the model.

                _model->GetCollectionOfParameters().At( k )->SetValue( _model->GetCollectionOfParameters().At( k )->GetValue() + _randomGenerator.Uniform( -1, 1 ) * stepWidth[k] );

                double newChi2 = _model->GetChi2();

                if ( newChi2 > oldChi2 ) {

                    // This is the Metropolis criterium.

                    double acceptance = exp( -( newChi2 - oldChi2 ) / _temperature );
                    double randomThreshold = _randomGenerator.Uniform( 0, 1 );

                    if ( acceptance > randomThreshold ) {

                        numberOfAcceptedVariations[k]++;

                    }
                    else {

                        _model = oldModel;

                    }

                }
                else {

                    numberOfAcceptedVariations[k]++;

                    // If the model has the lowest chi2 so far, the bestChi2 and bestModel are
                    // updated, respectively.

                    if ( newChi2 < bestChi2 ) {

                        bestChi2 = newChi2;
                        bestModel = _model->Clone();

                    }

                }

            }

        }

        // Adjustment of the stepWidth.

        for ( unsigned int iParameter = 0; iParameter < _model->GetNumberOfParameters(); iParameter++ ) {

            double samplingEfficiency = static_cast<double>( numberOfAcceptedVariations[iParameter] ) / 20.;

            if ( samplingEfficiency > 0.6 ) {

                stepWidth[iParameter] *= 2. * ( samplingEfficiency - 0.6 ) / 0.4 + 1.;

            }
            else if ( samplingEfficiency < 0.4 ) {

                stepWidth[iParameter] /= 2. * ( 0.4 - samplingEfficiency ) / 0.4 + 1.;

            }

        }

    }

    // Reduction of the temperature.

    _temperature *= _temperatureReductionFactor;

}
