/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.cpp                                                    *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Matthias  Hamer       <mhamer@gwdg.de>                           *
*             Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "CalculatorBase.h"
#include "CalculatorException.h"
#include "Factory.h"
#include "FormulaQuantity.h"
#include "ModelBase.h"
#include "ModelParameter.h"
#include "SimplePrediction.h"
#include "PhysicsModel.h"
#include "../../variables/include/ReferenceVariable.h"

Fittino::ModelBase::ModelBase( boost::property_tree::ptree& ptree )
    : _name( "" ),
      _ptree ( ptree ) {

    _chi2 = 0;

    InitializeParameters( ptree );

    //todo initialize the last evaluated parameter values

    InitializeCalculators( ptree );

    InitializeChi2Contributions();

    std::string tag = ptree.get<std::string>( "Tag", "" );

    std::string chi2Name       = "Chi2";
    std::string errorName      = "Error";
    std::string terminatorName = "Terminator";

    if ( !tag.empty() ) {

        chi2Name = tag + "_" + chi2Name;
        terminatorName = tag + "_" + terminatorName;
        errorName = tag + "_" + errorName;

    }

    AddPrediction( new SimplePrediction( chi2Name     , "", _chi2      ) );


        _collectionOfStringVariables.AddElement( errorName     , new ReferenceVariable<std::string>( errorName, _error ) );
        _collectionOfStringVariables.AddElement( terminatorName, new ReferenceVariable<std::string>( terminatorName, _terminator ) );

}

Fittino::ModelBase::~ModelBase() {

    _collectionOfQuantities.Delete();
    _collectionOfMetaDataDoubleVariables.Delete();
    _collectionOfStringVariables.Delete();

}

double Fittino::ModelBase::GetChi2() {

    // todo remove the Update() call when all tools call Update() properly
    Update();
    return _chi2;

}

int Fittino::ModelBase::GetNumberOfParameters() const {

    return GetCollectionOfParameters().GetNumberOfElements();

}

void Fittino::ModelBase::UpdatePropertyTree() {

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        GetCollectionOfParameters().At( i )->UpdatePropertyTree();

    }

}

std::string Fittino::ModelBase::GetName() const {

    return _name;

}

boost::property_tree::ptree Fittino::ModelBase::GetPropertyTree() {

    UpdatePropertyTree();
    return _ptree;

}

const Fittino::Collection<Fittino::ModelParameter*>& Fittino::ModelBase::GetCollectionOfParameters() const {

    return _collectionOfParameters;

}

const Fittino::Collection<Fittino::Quantity*>& Fittino::ModelBase::GetCollectionOfPredictions() const {

    return _collectionOfPredictions;

}

const Fittino::Collection<const Fittino::Quantity*>& Fittino::ModelBase::GetCollectionOfQuantities() const {

    return _collectionOfQuantities;

}

const Fittino::Collection<const Fittino::VariableBase<double>*>& Fittino::ModelBase::GetCollectionOfMetaDataDoubleVariables() const {

    return _collectionOfMetaDataDoubleVariables;

}

const Fittino::Collection<const Fittino::VariableBase<std::string>*>& Fittino::ModelBase::GetCollectionOfStringVariables() const {

    return _collectionOfStringVariables;

}

void Fittino::ModelBase::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO << Messenger::Endl;
    messenger << Messenger::INFO << "   Set of the " << this->GetName() << " parameters:" << Messenger::Endl;
    messenger << Messenger::INFO << Messenger::Endl;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); ++i ) {

        GetCollectionOfParameters().At( i )->PrintStatus();

    }

    if ( _collectionOfPredictions.GetNumberOfElements() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of the " << this->GetName() << " predictions:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _collectionOfPredictions.GetNumberOfElements(); ++i ) {

            _collectionOfPredictions.At( i )->PrintStatus();

        }

    }

    if ( _collectionOfStringVariables.GetNumberOfElements() != 0 ) {

        messenger << Messenger::Endl;
        messenger << Messenger::INFO << "   Summary of string variables:"  << Messenger::Endl;
        messenger << Messenger::Endl;

        for ( unsigned int i = 0; i < _collectionOfStringVariables.GetNumberOfElements(); ++i ) {

            _collectionOfStringVariables.At( i )->PrintStatus();

        }

    }

}

Fittino::ModelBase *Fittino::ModelBase::Clone() {

    return new ModelBase( *this );

}

const std::vector<Fittino::Observable*>* Fittino::ModelBase::GetObservableVector() const {

    return &_observableVector;

}

void Fittino::ModelBase::AddPrediction( Quantity* prediction ) {

    _collectionOfPredictions.AddElement( prediction );
    _collectionOfQuantities.AddElement( prediction );

}

void Fittino::ModelBase::Initialize() {

}

int Fittino::ModelBase::GetNumberOfPredictions() const {

    return _collectionOfPredictions.GetNumberOfElements();

}

void Fittino::ModelBase::AddCalculator( CalculatorBase* calculator ) {

    _calculators.push_back( calculator );

    const Collection<Quantity*>& col = calculator->GetCollectionOfQuantities();

    for ( unsigned int i = 0; i < col.GetNumberOfElements(); i++ ) {

        AddPrediction( col.At( i ) );

    }

    const auto& stringCol = calculator->GetCollectionOfStringVariables();

    for( unsigned int i = 0; i < stringCol.GetNumberOfElements(); ++i ){

        _collectionOfStringVariables.AddElement( stringCol.At(i) );

    }

}

void Fittino::ModelBase::AddParameter( ModelParameter* parameter ) {

    if ( ! parameter->IsFixed() ) {

        _collectionOfParameters.AddElement( parameter->GetName(), parameter );

    }

    _collectionOfQuantities.AddElement( parameter->GetName(), parameter );

}

void Fittino::ModelBase::InitializeCalculators( boost::property_tree::ptree &ptree ) {

    Factory factory;

    BOOST_FOREACH( boost::property_tree::ptree::value_type & node, ptree.get_child( "Calculators" ) ) {

        AddCalculator( factory.CreateCalculator( node.first, this, node.second ) );

    }

}

void Fittino::ModelBase::InitializeParameters( boost::property_tree::ptree& ptree ) {

    BOOST_FOREACH( boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "ModelParameter" ) {

            AddParameter( new ModelParameter( node.second ) );

        }

    }

}

void Fittino::ModelBase::Evaluate() {

    _terminator = "";
    _error      = "";

    _chi2 = 0;

    try {

        for ( unsigned int i = 0; i < _calculators.size(); ++i ) {

            _calculators[i]->CalculatePredictions();

        }

    }
    catch ( const CalculatorException& exception ) {

        _chi2 = std::numeric_limits<double>::infinity();
        _terminator = exception.GetCalculator();
        _error       = exception.GetError();
        return;

    }

    for ( unsigned int i = 0; i < _chi2Contributions.size(); ++i ) {
        _chi2Contributions[i]->Update();
        _chi2 += _chi2Contributions[i]->GetValue();

    }

}

void Fittino::ModelBase::Update() {

    // todo: When all calculators are properly initialized, this should be decided by comparing to the last evaluated parameter point
    bool evaluate = false;

    for ( unsigned int i = 0; i < GetNumberOfParameters(); i++ ) {

        if ( GetCollectionOfParameters().At( i )->IsUpdated() ) {

            evaluate = true;
            GetCollectionOfParameters().At( i )->SetUpdated( false );

        }

    }


    if ( evaluate ) {

        Evaluate();

    }

}

void Fittino::ModelBase::InitializeChi2Contributions() {

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, _ptree ) {

        if ( node.first != "Chi2Contribution" ) continue;

        FormulaQuantity* contribution = new FormulaQuantity( "", node.second.get_value<std::string>(), this );

        _chi2 += contribution->GetValue();
        _chi2Contributions.push_back( contribution );

    }

}
