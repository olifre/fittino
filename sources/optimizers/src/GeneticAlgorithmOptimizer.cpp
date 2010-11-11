/* $Id: GeneticAlgorithmOptimizer.cpp, v1.0  2010-11-04 09:42:00Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GeneticAlgorithmOptimizer.cpp                                    *
*                                                                              *
* Description Class for genetic algorithm optimizer                            *
*                                                                              *
* Authors     Bjoern Sarrazin <bjoern.sarrazin@desy.de                         *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "GeneticAlgorithmOptimizer.h"
#include "Configuration.h"

Fittino::GeneticAlgorithmOptimizer::GeneticAlgorithmOptimizer( Fittino::ModelBase* model )
        : OptimizerBase( model ) {

    _name = "genetic algorithm optimizer";

    _mutationRate = Configuration::GetInstance()->GetSteeringParameter( "MutationRate", 0.5 );
    _sizeOfPopulation = Configuration::GetInstance()->GetSteeringParameter( "SizeOfPopulation", 20 );
    _numberOfFamilies = ( unsigned int )( double( _sizeOfPopulation ) / 4 );
    _numberOfSurvivors = _sizeOfPopulation - 2 * _numberOfFamilies;
    _numberOfGenes = model->GetNumberOfParameters();
    _population.resize( _sizeOfPopulation );
    _fathers.resize( _numberOfFamilies );
    _mothers.resize( _numberOfFamilies );
    _firstChilds.resize( _numberOfFamilies );
    _secondChilds.resize( _numberOfFamilies );
    CumMaitingProbabilities.resize( _numberOfFamilies + 1 );
    MaitingProbabilities.resize( _numberOfFamilies );

    for ( unsigned int i = 0; i < _sizeOfPopulation; i++ ) {
        int seed = _randomGenerator.Integer( 10000 );
        Individual* individual = new Individual(  _model, _mutationRate, seed );
        _population[i] = individual;
    }
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        int seed = _randomGenerator.Integer( 10000 );
        Individual* individual = new Individual(  _model, _mutationRate, seed );
        _fathers[i] = individual;
    }
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        int seed = _randomGenerator.Integer( 10000 );
        Individual* individual = new Individual(  _model, _mutationRate, seed );
        _mothers[i] = individual;
    }
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        int seed = _randomGenerator.Integer( 10000 );
        Individual* individual = new Individual(  _model, _mutationRate, seed );
        _firstChilds[i] = individual;
    }
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        int seed = _randomGenerator.Integer( 10000 );
        Individual* individual = new Individual(  _model, _mutationRate, seed );
        _secondChilds[i] = individual;
    }



    SortPopulation();
    _population[0]->UpdateModel();

}

Fittino::GeneticAlgorithmOptimizer::~GeneticAlgorithmOptimizer() {

}

void Fittino::GeneticAlgorithmOptimizer::PrintSteeringParameters() const {

    std::cout << "    Mutation rate                " << _mutationRate << std::endl;
    std::cout << "    Size of population           " << _sizeOfPopulation << std::endl;

}

void Fittino::GeneticAlgorithmOptimizer::UpdateModel() {

    CalculateMaitingProbabilities();
    Pairing();
    Crossover();
    Replacement();
    Mutation();

    for ( unsigned int i = 0; i < _sizeOfPopulation; i++ ) {
        if  ( _population[i]->_mutatedIndividual == true || i >= _numberOfSurvivors ) {
            _population[i]->UpdateModel();
            _population[i]->SetChi2();
        }
    }
    SortPopulation();
//   std::cout<<_population[0]->_chi2<<std::endl;
//   std::cout<<_population[0]->_genes[0]<<std::endl;
//   std::cout<<_population[0]->_genes[1]<<std::endl;
//   for (unsigned int k=0;k<_sizeOfPopulation;k++){
//    std::cout<<_population[k]->_chi2<<std::endl;
// }
    _population[0]->UpdateModel();
}


void Fittino::GeneticAlgorithmOptimizer::Crossover() {

    int crossoverpoint;
    double weight;

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {

        crossoverpoint = gRandom->Integer( _numberOfGenes );

        weight = gRandom->Uniform( 0, 1 );

        for ( int j = 0; j < crossoverpoint; j++ ) {
            _firstChilds[i]->_genes[j] = _mothers[i]->_genes[j];
            _secondChilds[i]->_genes[j] = _fathers[i]->_genes[j];
        }

        _firstChilds[i]->_genes[crossoverpoint] = _mothers[i]->_genes[crossoverpoint] - weight * ( _mothers[i]->_genes[crossoverpoint] - _fathers[i]->_genes[crossoverpoint] );
        _secondChilds[i]->_genes[crossoverpoint] = _fathers[i]->_genes[crossoverpoint] + weight * ( _mothers[i]->_genes[crossoverpoint] - _fathers[i]->_genes[crossoverpoint] );

        for ( unsigned int j = crossoverpoint + 1; j < _numberOfGenes; j++ ) {
            _firstChilds[i]->_genes[j] = _fathers[i]->_genes[j];
            _secondChilds[i]->_genes[j] = _mothers[i]->_genes[j];
        }


    }



//   int r;

//   for (unsigned int i=0; i<_numberOfFamilies;i++){
//     for (unsigned int j=0;j<_numberOfGenes;j++){
//       r=gRandom->Integer(1);
//       if (r==0){
// 	_firstChilds[i]->_genes[j]=_mothers[i]->_genes[j];
// 	_secondChilds[i]->_genes[j]=_fathers[i]->_genes[j];
//       }
//       if (r==1){
// 	_firstChilds[i]->_genes[j]=_fathers[i]->_genes[j];
// 	_secondChilds[i]->_genes[j]=_mothers[i]->_genes[j];
//       }
//     }
//   }
}


void Fittino::GeneticAlgorithmOptimizer::Pairing() {
    double r1;
    double r2;
    bool father_equals_mother;
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        father_equals_mother = true;
        r1 = gRandom->Uniform( 0, 1 );
        for ( unsigned int j = 0; j < _numberOfFamilies; j++ ) {
            if ( CumMaitingProbabilities[j] < r1 && r1 <= CumMaitingProbabilities[j+1] ) {
                *_mothers[i] = *_population[j];
                while ( father_equals_mother == true ) {
                    r2 = gRandom->Uniform( 0, 1 );
                    if ( r2 > CumMaitingProbabilities[j+1] || r2 <= CumMaitingProbabilities[j] ) {
                        father_equals_mother = false;
                        for ( unsigned int k = 0; k < _numberOfFamilies; k++ ) {
                            if ( CumMaitingProbabilities[k] < r2 && r2 <= CumMaitingProbabilities[k+1] ) {
                                *_fathers[i] = *_population[k];
                            }
                        }
                    }
                }
            }
        }
    }
}


void Fittino::GeneticAlgorithmOptimizer::Replacement() {
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        *_population[_numberOfSurvivors+i] = *_firstChilds[i];
    }
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        *_population[_numberOfSurvivors+_numberOfFamilies+i] = *_secondChilds[i];
    }
}



void Fittino::GeneticAlgorithmOptimizer::Mutation() {

    for ( unsigned int i = 1; i < _sizeOfPopulation; i++ ) {
        _population[i]->_mutatedIndividual = false;
        _population[i]->Mutation();
    }
}



void Fittino::GeneticAlgorithmOptimizer::SortPopulation() {
    //sort(_population.begin(), _population.end(),CompareIndividuals());
}



void Fittino::GeneticAlgorithmOptimizer::CalculateMaitingProbabilities() {
    CumMaitingProbabilities[0] = 0;


    double sum = 0;
    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        MaitingProbabilities[i] = _numberOfGenes - i;
        sum = sum + MaitingProbabilities[i];
    }

    for ( unsigned int i = 0; i < _numberOfFamilies; i++ ) {
        MaitingProbabilities[i] = MaitingProbabilities[i] / sum;
        CumMaitingProbabilities[i+1] = CumMaitingProbabilities[i] + MaitingProbabilities[i];
    }

}
