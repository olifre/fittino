#ifndef SCATTERDATA_H
#define SCATTERDATA_H

#include <boost/property_tree/ptree.hpp>

#include "PlotData.h"

class TFile;
class TTree;

namespace Fittino {

class ScatterData : public PlotData {
    
public:
    ScatterData( const boost::property_tree::ptree& ptree );
    ~ScatterData();
    void Draw();
    
private:
    
    TFile* _file;
    TTree* _tree;
    std::string _x;
    std::string _y;
    
    
};
    
}

#endif
