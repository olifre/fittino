#include "Hypothesis.h"
//#include "ModelParameterBase.h"
#include <vector>
#include <cmath>
using namespace Fittino;

//Constructor
Fittino::Hypothesis::Hypothesis()
{
    this->_fitness = -INFINITY;
}

//Destructor
Fittino::Hypothesis::~Hypothesis()
{
    //dtor
}

//Parameter vector getter/setter
std::vector<ModelParameterBase> Fittino::Hypothesis::getParameterVector(){
    return this->_parameterVector;
}

void Fittino::Hypothesis::setParameterVector(int i, double value){
    this->getParameterVector().at(i).SetValue(value);
}

//Fitness getter/setter
double Fittino::Hypothesis::getFitness(){
    return this->_fitness;
}

void Fittino::Hypothesis::setFitness(double value){
    this->_fitness = value;
}


