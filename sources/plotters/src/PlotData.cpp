#include "PlotData.h"

Fittino::PlotData::PlotData( const boost::property_tree::ptree& ptree) {
    
    
    
}

Fittino::PlotData::~PlotData(){
    
}

double Fittino::PlotData::GetXmin(){
    
    return _xmin;
    
}
double Fittino::PlotData::GetXmax(){
    
    return _xmax;
    
}
double Fittino::PlotData::GetYmin(){
    
    return _ymin;
    
}
double Fittino::PlotData::GetYmax(){
    
    return _ymax;
    
}
