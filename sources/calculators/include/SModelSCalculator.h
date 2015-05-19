#ifndef FITTINO_SMODELSCALCULATOR_H
#define FITTINO_SMODELSCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {
  class SModelSCalculator : public CalculatorBase {
    
  public:
    
    SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~SModelSCalculator();

  public:
    
    virtual void CalculatePredictions();
    virtual void Initialize();

  private:

    double _r;
    
    double _theo;
    double _obs;
    double _exp;
    double _chi2;
    
    double _value1;
    double _value0;

    std::string name1;
    std::string name2;
    std::string name3;
    std::string name4;
                                                                                                                  
    };


}
#endif // FITTINO_SMODELSCALCULATOR_H

