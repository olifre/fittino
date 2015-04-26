#ifndef FITTINO_HEPMCSPLITCALCULATOR_H
#define FITTINO_HEPMCSPLITCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {
  class HepMCSplitCalculator : public CalculatorBase {
    
  public:

    HepMCSplitCalculator( const ModelBase*, const boost::property_tree::ptree& ptree );
    ~HepMCSplitCalculator();

  public:

    virtual void CalculatePredictions();
    virtual void Initialize();

  };
}

#endif // FITTINO_HEPMCSPLITCALCULATOR_H
