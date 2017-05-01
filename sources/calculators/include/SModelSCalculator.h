#ifndef FITTINO_SMODELSCALCULATOR_H
#define FITTINO_SMODELSCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {

    class Executor;

  class SModelSCalculator : public CalculatorBase {
    
  public:
    
    SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~SModelSCalculator();

  public:
    
    virtual void CalculatePredictions();
    virtual void Initialize();

  private:

      Executor* _crossSections_LO;
      Executor* _crossSections_NLL;

      std::string _xmlFile;
      double _rValue;

      void ReadXML();

  };

}

#endif
