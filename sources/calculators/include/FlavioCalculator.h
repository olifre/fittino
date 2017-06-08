#ifndef FITTINO_FLAVIOCALCULATOR_H
#define FITTINO_FLAVIOCALCULATOR_H

#include "CalculatorBase.h"

#include <string>

// https://mail.python.org/pipermail/python-dev/2003-August/037601.html
#ifndef PyObject_HEAD
struct _object;
typedef _object PyObject;
#endif

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Calculator for Flavor Observables
   */
  class FlavioCalculator : public CalculatorBase {

    public:

      FlavioCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree  );
      ~FlavioCalculator();


    private:

      void     CalculatePredictions();
      void     ReadSLHAFile();
      void     AddBinnedPrediction(std::string name, std::string id, double qmin, double qmax );
     // void     AddInclusivePrediction();
    
    private:

      PyObject* _readWilson;
      PyObject* _npPrediction;
      PyObject* _smPrediction;

      PyObject* _wc;

      std::vector<PyObject*> _npargs;
      PyObject* npargs;
      std::vector<PyObject*> _smargs;
      std::vector<std::string> _id;
      std::vector<std::string> _predictions;

  };

}

#endif
