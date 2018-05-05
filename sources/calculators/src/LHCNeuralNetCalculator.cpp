#define BOOST_NO_CXX11_SCOPED_ENUMS

#include <boost/python.hpp>
#include <boost/python/object.hpp>
#include "Python.h"
#include "LHCNeuralNetCalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "ModelParameter.h"

Fittino::LHCNeuralNetCalculator::LHCNeuralNetCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ) 
{
    
    if ( _name.empty() ) { 

    _tag  = "SCYNet";
    _name = "SCYNet";

   }
    
    AddOutput( "Chi2_8TeV", _chi2_8 );
    AddOutput( "Chi2_13TeV", _chi2_13 );
    AddOutput( "Chi2_Total", _chi2_total );

    //PyObject* myModuleString = PyString_FromString( (char*) "scynet.scynet" );
    //PyObject* module = PyImport_Import(myModuleString);
    //PyObject* scynetClass = PyObject_GetAttrString(module, "SCYNet");
    //PyObject* instance_8 = PyInstance_New( scynetClass, NULL, NULL);
    //PyObject *ret = PyObject_CallMethod(instance_8, "startSession", "i", 8);
    //assert( ret != NULL );

    boost::python::object scynetModule = boost::python::import("scynet.scynet");
    boost::python::object scynetClass = scynetModule.attr( "SCYNet" );

    PyObject* instance_8 = PyInstance_New( scynetClass.ptr(), NULL, NULL);
    boost::python::handle<> handle_8(instance_8);
    _scynet_8 = new boost::python::object(handle_8);
    _scynet_8->attr("startSession")(8);

    PyObject* instance_13 = PyInstance_New( scynetClass.ptr(), NULL, NULL);
    boost::python::handle<> handle_13(instance_13);
    _scynet_13 = new boost::python::object(handle_13);
    _scynet_13->attr("startSession")(13);

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

    delete _scynet_8;
    delete _scynet_13;

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

    _chi2_8 = boost::python::extract<double>( _scynet_8->attr("chi2")(point) );
    _chi2_13 = boost::python::extract<double>( _scynet_13->attr("chi2")(point) );
    _chi2_total = _chi2_8 + _chi2_13;

}
