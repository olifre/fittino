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

#include <fstream>

#include "boost/filesystem.hpp"
#include <boost/python.hpp>

#include "LHCNeuralNetCalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"
#include "TimeoutExecutorException.h"
#include "ModelParameter.h"

#include "Python.h"
#include <boost/python/object.hpp>
#include <assert.h>

Fittino::LHCNeuralNetCalculator::LHCNeuralNetCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _executor( "./chi2_LHCNN.py", "chi2_LHCNN.py" ) {
     
    _tag  = "LHCNN";
    _name = "LHCNeuralNetCalculator";
    
    AddQuantity( new SimplePrediction( "TotalChi2",                                   "", _lhcNNChi2                  ) );

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
    boost::python::object scynet(handle);
    scynet.attr("startSession")(8);
    double chi2 = -199;
    boost::python::list point = boost::python::list();
    point.append(-1682.23027931);
    point.append(3465.09031358);
    point.append(1237.59831623);
    point.append(2429.59820408);
    point.append(3450.31039446);
    point.append(2169.17885836);
    point.append(1800.49227919);
    point.append(1271.54318728);
    point.append(-4832.47899659);
    point.append(-610.85511464);
    point.append(33.96309872);
    chi2 = boost::python::extract<double>( scynet.attr("chi2")(point) );
    std::cout<<chi2<<std::endl;

    _arguments.push_back( "M_1" );
    _arguments.push_back( "M_2" );
    _arguments.push_back( "M_3" );
    _arguments.push_back( "M_Q1" );
    _arguments.push_back( "M_Q3" );
    _arguments.push_back( "M_L1" );
    _arguments.push_back( "M_L3" );
    _arguments.push_back( "M_A0" );
    _arguments.push_back( "A" );
    _arguments.push_back( "mu" );
    _arguments.push_back( "TanBeta" );

   // AddInput( "M1"  );
   // AddInput( "M2"  );
    //AddInput( "M3"  );
   // AddInput( "MQ1" );
   // AddInput( "MQ3" );
   // AddInput( "ML1" );
   // AddInput( "ML3" );
   // AddInput( "MA0" );
   // AddInput( "A" );
   // AddInput( "Mu" );
   // AddInput( "TanBeta" );
    
    



}

Fittino::LHCNeuralNetCalculator::~LHCNeuralNetCalculator() {

}

void Fittino::LHCNeuralNetCalculator::CalculatePredictions() {

   UpdateInput();
   //PyObject_CallMethod(scynet, "Chi2", "(ddddddddddd)", 
   


}
