#ifndef FITTINO_LHCNEURALNET2CALCULATOR_H
#define FITTINO_LHCNEURALNET2CALCULATOR_H

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
  class LHCNeuralNet2Calculator : public CalculatorBase {

    public:

      LHCNeuralNet2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree  );
      ~LHCNeuralNet2Calculator();


    private:

      void     CalculatePredictions();
    
    private:

//      double _chi2_8;
//      double _chi2_13;
      double _chi2;
      std::string _scynet;
      std::string _scynet_out;
//      boost::python::api::object* _scynet_8;
//      boost::python::api::object* _scynet_13;

  };

}

#endif
