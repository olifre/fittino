#ifndef FITTINO_MINIMUM_CALCULATOR_H
#define FITTINO_MINIMUM_CALCULATOR_H

#include <boost/regex.hpp>

#include "CalculatorBase.h"

namespace Fittino {

    class MinimumCalculator : public CalculatorBase {
        
    public:
        MinimumCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
        ~MinimumCalculator();
        
        void CalculatePredictions();
        
    private:
        
        std::vector<const Quantity*> _quantities;
        double _value;
        std::string _name;
        boost::regex _regex;
        
    };
    
}

#endif
