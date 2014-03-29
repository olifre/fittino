/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GeneticAlgorithmOptimizer.cpp                                    *
*                                                                              *
* Description Class for genetic algorithm optimizer                            *
*                                                                              *
* Authors     Bjoern Sarrazin  <bjoern.sarrazin@desy.de                        *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <algorithm>

#include "GeneticAlgorithmOptimizer.h"
#include "ModelBase.h"

Fittino::GeneticAlgorithmOptimizer::GeneticAlgorithmOptimizer( Fittino::ModelBase* model, const boost::property_tree::ptree& ptree )
    : _mutationRate    ( ptree.get<double>( "MutationRate",     0.5 ) ),
      _sizeOfPopulation( ptree.get<int>   ( "SizeOfPopulation", 20  ) ),
      OptimizerBase    ( model, ptree ) {

    _abortCriterium     = ptree.get<double>     ( "AbortCriterium",     0.00001                       );
    _name               = ptree.get<std::string>( "Name",               "Genetic Algorithm optimizer" );
    _numberOfIterations = ptree.get<int>        ( "NumberOfIterations", 500                           );

    _numberOfFamilies = ( unsigned int )( double( _sizeOfPopulation ) / 4 );
    _numberOfSurvivors = _sizeOfPopulation - 2 * _numberOfFamilies;
    _numberOfGenes = model->GetNumberOfParameters();
    _cumulativeMatingProbabilities.resize( _numberOfFamilies + 1 );
    _matingProbabilities.resize( _numberOfFamilies );

    for ( unsigned int i = 0; i < _sizeOfPopulation; i++ ) {

        _population.push_back( Individual( _model, _mutationRate, _randomGenerator.Integer( 10000 ) ) );

    }

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        _mothers.push_back( Individual( _model, _mutationRate, _randomGenerator.Integer( 10000 ) ) );
        _fathers.push_back( Individual( _model, _mutationRate, _randomGenerator.Integer( 10000 ) ) );
        _firstChildren.push_back( Individual( _model, _mutationRate, _randomGenerator.Integer( 10000 ) ) );
        _secondChildren.push_back( Individual( _model, _mutationRate, _randomGenerator.Integer( 10000 ) ) );

    }

    SortPopulation();
    _population[0].UpdateModel();

}

Fittino::GeneticAlgorithmOptimizer::~GeneticAlgorithmOptimizer() {

}

void Fittino::GeneticAlgorithmOptimizer::CalculateMatingProbabilities() {

    _cumulativeMatingProbabilities[0] = 0;
    double sum = 0;

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        _matingProbabilities[i] = _numberOfFamilies - i;
        sum = sum + _matingProbabilities[i];

    }

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        _matingProbabilities[i] = _matingProbabilities[i] / sum;
        _cumulativeMatingProbabilities[i + 1] = _cumulativeMatingProbabilities[i] + _matingProbabilities[i];

    }

}

void Fittino::GeneticAlgorithmOptimizer::CrossOver() {

    int crossoverpoint;
    double weight;

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        crossoverpoint = gRandom->Integer( _numberOfGenes );
        weight = gRandom->Uniform( 0, 1 );

        for ( int j = 0; j < crossoverpoint; j++ ) {

            _firstChildren[i].SetGene( j,  _mothers[i].GetGene( j ) );
            _secondChildren[i].SetGene( j, _fathers[i].GetGene( j ) );

        }

        _firstChildren[i].SetGene( crossoverpoint, _mothers[i].GetGene( crossoverpoint ) - weight * ( _mothers[i].GetGene( crossoverpoint ) - _fathers[i].GetGene( crossoverpoint ) ) );
        _secondChildren[i].SetGene( crossoverpoint, _fathers[i].GetGene( crossoverpoint ) + weight * ( _mothers[i].GetGene( crossoverpoint ) - _fathers[i].GetGene( crossoverpoint ) ) );

        for ( unsigned int j = crossoverpoint + 1; j < _numberOfGenes; j++ ) {

            _firstChildren[i].SetGene( j, _fathers[i].GetGene( j ) );
            _secondChildren[i].SetGene( j, _mothers[i].GetGene( j ) );

        }

    }

}

void Fittino::GeneticAlgorithmOptimizer::MutatePopulation() {

    for ( unsigned int i = 1; i < _sizeOfPopulation; i++ ) {

        _population[i].Mutation();

    }

}

void Fittino::GeneticAlgorithmOptimizer::Pair() {

    double r1;
    double r2;
    bool father_equals_mother;

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        father_equals_mother = true;
        r1 = gRandom->Uniform( 0, 1 );

        for ( unsigned int j = 0; j < _numberOfFamilies; j++ ) {

            if ( _cumulativeMatingProbabilities[j] < r1 && r1 <= _cumulativeMatingProbabilities[j + 1] ) {

                _mothers[i] = _population[j];

                while ( father_equals_mother == true ) {

                    r2 = gRandom->Uniform( 0, 1 );

                    if ( r2 > _cumulativeMatingProbabilities[j + 1] || r2 <= _cumulativeMatingProbabilities[j] ) {

                        father_equals_mother = false;

                        for ( unsigned int k = 0; k < _numberOfFamilies; k++ ) {

                            if ( _cumulativeMatingProbabilities[k] < r2 && r2 <= _cumulativeMatingProbabilities[k + 1] ) {

                                _fathers[i] = _population[k];

                            }

                        }

                    }

                }

            }

        }

    }

}

void Fittino::GeneticAlgorithmOptimizer::Replace() {

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        _population[_numberOfSurvivors + i] = _firstChildren[i];
        _population[_numberOfSurvivors + _numberOfFamilies + i] = _secondChildren[i];

    }

}

void Fittino::GeneticAlgorithmOptimizer::SortPopulation() {

    sort( _population.begin(), _population.end() );

}

void Fittino::GeneticAlgorithmOptimizer::PrintSteeringParameters() const {

    PrintItem( "NumberOfIterations", _numberOfIterations );
    PrintItem( "AbortCriterium",     _abortCriterium     );
    PrintItem( "MutationRate",       _mutationRate       );
    PrintItem( "SizeOfPopulation",   _sizeOfPopulation   );

}

void Fittino::GeneticAlgorithmOptimizer::UpdateModel() {

    CalculateMatingProbabilities();
    Pair();
    CrossOver();
    Replace();
    MutatePopulation();

    for ( unsigned int i = 0; i < _sizeOfPopulation; i++ ) {

        if  ( !_population[i].UpdatedChi2() ) {

            _population[i].UpdateChi2();

        }

    }

    SortPopulation();
    _population[0].UpdateModel();

}
