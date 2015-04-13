#include <Python.h>
#include <boost/python.hpp>
#include "SModelSCalculator.h"
#include "Executor.h"

Fittino::SModelSCalculator::SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree) : CalculatorBase( model ) {

}
Fittino::SModelSCalculator::~SModelSCalculator() {

}

void Fittino::SModelSCalculator::CalculatePredictions() {

  std::string inputfile = "/lustre/user/range/fittino/bin/SPheno.spc";

  Executor executor( "/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2/runTools.py", "runTools" );
  executor.AddArgument( "xseccomputer" );
  executor.AddArgument( "-f" );
  executor.AddArgument( inputfile );
  executor.AddArgument( "-p" );  
  executor.Execute();

  Py_Initialize();
  
  PyObject* sysPath = PySys_GetObject("path");
  PyList_Insert( sysPath, 0, PyString_FromString("/lustre/fittino/group/external/Python-2.7/lib/python2.7/site-packages"));
  PyList_Insert( sysPath, 0, PyString_FromString("/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2"));

  boost::python::object main_module = boost::python::import("__main__");
  boost::python::object main_namespace = main_module.attr("__dict__"); 
  
  boost::python::str filename = "/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2/runSModelS.py";
  try{
    boost::python::object SModelS = boost::python::exec_file( filename, main_namespace, main_namespace);  
  }
  catch(boost::python::error_already_set& e)
  {
    PyErr_Print();
  }

  Py_Finalize();

}



void Fittino::SModelSCalculator::Initialize() {

}
