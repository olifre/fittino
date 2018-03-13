#ifndef PLOT_H
#define PLOT_H

#include <boost/property_tree/ptree.hpp>

class TCanvas;

namespace Fittino {
    
    class PlotData;

    class Plot {
        
    public:
        Plot( const boost::property_tree::ptree& ptree );
        ~Plot();
    
        void Create();
        
    private:
        std::string _name;
        double _xmin;
        double _xmax;
        double _ymin;
        double _ymax;
        const boost::property_tree::ptree& _ptree;
        TCanvas* _canvas;
        
    private:
        void CalculateLimits();
        std::vector<PlotData*> _data;
        
    };
    
}

#endif
