#ifndef FITTINO_HEPMCSPLITCALCULATOR_H
#define FITTINO_HEPMCSPLITCALCULATOR_H

#include <set>
#include <vector>
#include <string>
#include "boost/filesystem.hpp"

#include "CalculatorBase.h"

namespace Fittino {
  class HepMCSplitCalculator : public CalculatorBase {
    
  public:

    HepMCSplitCalculator( const ModelBase*, const boost::property_tree::ptree& ptree );
    ~HepMCSplitCalculator();

  public:

    virtual void CalculatePredictions();

 private:
    std::set<int> _squarks;
    boost::filesystem::path _hepMCFile;
    std::string _rootFile;
    std::string _tree;
    std::string _eventNumber;
    std::vector<std::string> _pdgIDs;
    double index;
    double _n_gg;
    double _n_sg;
    double _n_ss;
    double _n_sb;
    double _n_tb1;
    double _n_tb2;

    double _n_ng1;
    double _n_ng2;
    double _n_ng3;
    double _n_ng4;
    double _n_ng5;
    double _n_ng6;
    double _n_ng7;
    double _n_ng8;

    double _n_ns1;
    double _n_ns2;
    double _n_ns3;
    double _n_ns4;
    double _n_ns5;
    double _n_ns6;
    double _n_ns7;
    double _n_ns8;

  };
}

#endif 
