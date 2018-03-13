
#ifndef PLOT_DATA_H
#define PLOT_DATA_H

#include <boost/property_tree/ptree.hpp>

namespace Fittino {

class PlotData{
    
public:
    PlotData( const boost::property_tree::ptree& ptree );
    ~PlotData();
    double GetXmin();
    double GetXmax();
    double GetYmin();
    double GetYmax();
    virtual void Draw() = 0;
    
protected:
    double _xmin;
    double _xmax;
    double _ymin;
    double _ymax;
    
};
    
}

#endif
