


#ifndef FITTINO_CHECKMATE2CALCULATOR_H
#define FITTINO_CHECKMATE2CALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"

namespace Fittino{
  class CheckMATE2Calculator : public CalculatorBase {

  public:
    CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~CheckMATE2Calculator();
    
  public:
    virtual void CalculatePredictions();
    virtual void SetupMeasuredValues();
    virtual void Initialize();

  private:
    double _r_CheckMATE;

  };

}
#endif //Fittino_CheckMATE2CALCULATOR_H
