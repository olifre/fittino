
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <iostream>
#include "ModelBase.h"
#include "RPVCalculator.h"

Fittino::RPVCalculator::RPVCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree)
        : CalculatorBase(model, &ptree) {


}



Fittino::RPVCalculator::~RPVCalculator() {

}

void Fittino::RPVCalculator::CalculatePredictions() {

    double mbR = _model->GetCollectionOfQuantities().At("mbR")->GetValue();

std::cout<<"Callng RPV Caculator: mbr="<<mbR<<std::endl;

}

void Fittino::RPVCalculator::Initialize() {


}



