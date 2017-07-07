#ifndef FITTINO_RPVCALCULATOR_H
#define FITTINO_RPVCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {

    class Executor;

  class RPVCalculator : public CalculatorBase {
    
  public:
    
    RPVCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~RPVCalculator();

  public:
    
    virtual void CalculatePredictions();
    virtual void Initialize();



  };

}

#endif
