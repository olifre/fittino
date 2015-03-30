#include <Python.h>

#include <boost/python.hpp>

#include "SModelSCalculator.h"

Fittino::SModelSCalculator::SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree) : CalculatorBase( model ) {

}
Fittino::SModelSCalculator::~SModelSCalculator(){
}

void Fittino::SModelSCalculator::CalculatePredictions() {
  Py_Initialize();
  
  const char* pythonScript = "print 'hello world!'\n";
  int result = PyRun_SimpleString(pythonScript);

  Py_Finalize();

}


void Fittino::SModelSCalculator::Initialize() {

}
