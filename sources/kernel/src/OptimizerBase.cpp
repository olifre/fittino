/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerBase.cpp                                                *
*                                                                              *
* Description Base class for Fittino parameter optimizers                      *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelBase.h"
#include "ModelParameter.h"
#include "OptimizerBase.h"

Fittino::OptimizerBase::OptimizerBase( ModelBase* model, const boost::property_tree::ptree& ptree )
    : _abortCriterium    ( ptree.get<double>( "AbortCriterium",     0.000001 ) ),
      _numberOfIterations( ptree.get<int>   ( "NumberOfIterations", 10000    ) ),
      AnalysisTool       ( model, ptree ) {

    _name = ptree.get<std::string>( "Name", "optimizer" );

}

Fittino::OptimizerBase::~OptimizerBase() {

}

void Fittino::OptimizerBase::Execute() {

    this->FillMetaDataTree();

    while ( _chi2 > _abortCriterium && _iterationCounter < _numberOfIterations ) {

        _iterationCounter++;

        _chi2 = _model->GetChi2();

        AnalysisTool::PrintStatus();

        this->UpdateModel();

    }

}

void Fittino::OptimizerBase::PrintResult() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Optimization converged after " << _iterationCounter << " iterations" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Optimization results" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "   Final set of " << _model->GetName() << " parameters" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    for ( unsigned int i = 0; i < _model->GetNumberOfParameters(); i++ ) {

        messenger << Messenger::ALWAYS
                  << "    "
                  << std::left
                  << std::setw( 11 )
                  << _model->GetCollectionOfParameters().At( i )->GetName()
                  << std::right
                  << std::setw( 9 )
                  << _model->GetCollectionOfParameters().At( i )->GetValue()
                  << Messenger::Endl;

    }

    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;

}

void Fittino::OptimizerBase::Terminate() {

    FillTree();

}
