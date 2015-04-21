#ifndef FITTINO_NLLFASTCALCULATOR_H
#define FITTINO_NLLFASTCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {
  class NLLFastCalculator : public CalculatorBase {
    
  public:
    
    NLLFastCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
    ~NLLFastCalculator();

  public:

    virtual void CalculatePredictions();
    virtual void Initialize();

  };

}


#endif //FITTINO_NLLFASTCALCULATOR_H
