
#ifndef FITTINO_PLOTTER_H
#define FITTINO_PLOTTER_H

#include "Tool.h"
#include "Plot.h"
#include "TStyle.h"

namespace Fittino {
    
    class Plotter : public Tool
    {
    
public:
    Plotter( const boost::property_tree::ptree& ptree );
    virtual ~Plotter();
        
    protected:
        void UpdateModel();
        
    private:
       
         void Execute();
         void InitializeTool();
         void PrintResult() const;
         void Terminate();
         void WriteResultToFile() const;
        
    private:
        std::vector<Plot> _plots;
        TStyle*  _fittinoStyle;

};

}

#endif
