#ifndef FITTINO_LHCNEURALNETCALCULATOR_H
#define FITTINO_LHCNEURALNETCALCULATOR_H

#include "CalculatorBase.h"

namespace boost {

  namespace python {

      namespace api {

          class object;

      }

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Calculator for MSSM11 LHC Neural Net 
   */
  class LHCNeuralNetCalculator : public CalculatorBase {

    public:

      LHCNeuralNetCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree  );
      ~LHCNeuralNetCalculator();


    private:

      void     CalculatePredictions();
    
    private:

      double _chi2_8;
      double _chi2_13;
      double _chi2_total;

      boost::python::api::object* _scynet_8;
      boost::python::api::object* _scynet_13;

  };

}

#endif
