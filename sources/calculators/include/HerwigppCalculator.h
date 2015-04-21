#ifndef FITTINO_HERWIGPPCALCULATOR_H
#define FITTINO_HERWIGPPCALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "Executor.h"
#include "CalculatorBase.h"

namespace Fittino {
  class HerwigppCalculator : public CalculatorBase {
    
  public:
    
    HerwigppCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
    ~HerwigppCalculator();

  public:

    virtual void CalculatePredictions();    
    virtual void Initialize();

  };


}

#endif // FITTINO_HERWIGPPCALCULATOR_H
