
#include <iostream>
#include "Plot.h"
#include "PlotData.h"
#include "ScatterData.h"

#include "TCanvas.h"
#include "TH2D.h"


Fittino::Plot::Plot( const boost::property_tree::ptree& ptree ):
_ptree( ptree ){

_name = ptree.get<std::string>( "Name" );
    _canvas = new TCanvas();

    gPad->SetLogx( _ptree.get<bool>( "LogX", 0 ) );
    gPad->SetLogy( _ptree.get<bool>( "LogY", 0 ) );
    
   
    
for ( const auto& node : ptree ) {

if( node.first == "ScatterData" ) {

_data.push_back( new ScatterData( node.second ) );

}

}


CalculateLimits();

}

Fittino::Plot::~Plot(){


}

void Fittino::Plot::Create(){



TH2D* hist = new TH2D("", "", 100, _xmin, _xmax,100, _ymin, _ymax);
    
    _canvas->cd();


hist->Draw();
    
    for( const auto& d : _data ) {
        
        d->Draw();
        
    }
    
   // hist->GetXaxis()->SetLimits(_xmin,_xmax);
    
_canvas->SaveAs( _name.c_str() );
delete hist;
delete _canvas;

}

void Fittino::Plot::CalculateLimits() {

_xmin = std::numeric_limits<double>::max();
_xmax = std::numeric_limits<double>::lowest();

_ymin = std::numeric_limits<double>::max();
_ymax = std::numeric_limits<double>::lowest();


for ( auto d : _data ) {

    if( d->GetXmin() < _xmin ) _xmin = d->GetXmin();
    if( d->GetXmax() > _xmax ) _xmax = d->GetXmax();

    if( d->GetYmin() < _ymin ) _ymin = d->GetYmin();
    if( d->GetYmax() > _ymax ) _ymax = d->GetYmax();
    
}
    
    double xwidth = TMath::Abs(_xmax - _xmin );
    _xmax += 0.1*xwidth;
    _xmin -= 0.1*xwidth;
    
    double ywidth = TMath::Abs(_ymax - _ymin );
    _ymax += 0.1*ywidth;
    _ymin -= 0.1*ywidth;
    

}
