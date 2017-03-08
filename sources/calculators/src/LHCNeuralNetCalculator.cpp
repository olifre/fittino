/* $Id: LHCNeuralNetCalculator.cpp 2383 2014-12-29 13:52:26Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCNeuralNetCalculator.cpp                                       *
*                                                                              *
* Description Calculator for python scripts                                    *          
*                                                                              *
* Authors     Matthias Hamer <matthias.hamer@cern.ch>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#define BOOST_NO_CXX11_SCOPED_ENUMS

#include <boost/python.hpp>

#include "LHCNeuralNetCalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "ModelParameter.h"

#include "Python.h"
#include <boost/python/object.hpp>

Fittino::LHCNeuralNetCalculator::LHCNeuralNetCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ) 
{
    
    if ( _name.empty() ) { 

    _tag  = "SCYNet";
    _name = "SCYNet";

   }
    
    AddOutput( "Chi2_8TeV", _chi2_8TeV );

    Py_Initialize();

    //PyObject* myModuleString = PyString_FromString( (char*) "scynet.scynet" );
    //PyObject* scynet_module = PyImport_Import(myModuleString);
    //PyObject* scynet_class = PyObject_GetAttrString(scynet_module, "SCYNet");
    //PyObject* scynet_instance = PyInstance_New( scynet_class, NULL, NULL); 
    //PyObject *ret = PyObject_CallMethod(scynet_instance, "startSession", "i", 8);
    //assert( ret != NULL );

    boost::python::object scynet_module = boost::python::import("scynet.scynet");
    boost::python::object scynet_class = scynet_module.attr( "SCYNet" );
    PyObject* scynet_instance = PyInstance_New( scynet_class.ptr(), NULL, NULL); 
    boost::python::handle<> handle(scynet_instance);
    _scynet_8TeV = new boost::python::object(handle);
    _scynet_8TeV->attr("startSession")(8);

    AddInput( "M1"  );
    AddInput( "M2"  );
    AddInput( "M3"  );
    AddInput( "MQ1" );
    AddInput( "MQ3" );
    AddInput( "ML1" );
    AddInput( "ML3" );
    AddInput( "MA0" );
    AddInput( "Mu" );
    AddInput( "TanBeta" );
    AddInput( "A" );

}

Fittino::LHCNeuralNetCalculator::~LHCNeuralNetCalculator() {

//  _scynet_8TeV->closeSession();
  delete _scynet_8TeV;

}

void Fittino::LHCNeuralNetCalculator::CalculatePredictions() {

   UpdateInput();

    boost::python::list point = boost::python::list();

//    point.append(-1682.23027931);
 //   point.append(3465.09031358);
 //   point.append(1237.59831623);
 //   point.append(2429.59820408);
 //   point.append(3450.31039446);
 //   point.append(2169.17885836);
 //   point.append(1800.49227919);
 //   point.append(1271.54318728);
 //   point.append(-4832.47899659);
 //   point.append(-610.85511464);
 //   point.append(33.96309872);

    point.append( GetInput( "M1" ) );
    point.append( GetInput( "M2" ) );
    point.append( GetInput( "M3" ) );
    point.append( GetInput( "MQ1" ) );
    point.append( GetInput( "MQ3" ) );
    point.append( GetInput( "ML1" ) );
    point.append( GetInput( "ML3" ) );
    point.append( GetInput( "MA0" ) );
    point.append( GetInput( "A" ) );
    point.append( GetInput( "Mu" ) );
    point.append( GetInput( "TanBeta" ) );

    _chi2_8TeV = boost::python::extract<double>( _scynet_8TeV->attr("chi2")(point) );

}
