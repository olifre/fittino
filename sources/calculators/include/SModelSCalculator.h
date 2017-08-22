#ifndef FITTINO_SMODELSCALCULATOR_H
#define FITTINO_SMODELSCALCULATOR_H

#include "CalculatorBase.h"
#include "boost/python.hpp"
#include <set>

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
      std::string _fileName;
      std::string _databaseVersion;
      std::string _parameterFile;
      double _rValue;
      boost::python::object _parser;
      boost::python::object _fileList;
      boost::python::object _listOfExpRes;
      boost::python::object _testPoints;

      std::set<std::string> _txNamesWithResults;
      std::set<std::string> _txNames;

      std::vector<std::string> _missingModels_TxNames;
      std::vector<double> _missingModels_Weights;
      bool _individualMissingWeights;

      void ReadXML();

      unsigned int _numberOfMissingModelsConsidered;
      double _numberOfMissingModelsDetermined;

  };

}

#endif
