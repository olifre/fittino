#include "Plotter.h"
#include "Tool.h"
#include "TROOT.h"
#include <iostream>

Fittino::Plotter::Plotter(const boost::property_tree::ptree& ptree )
:Tool( nullptr, ptree )
{
    
    for( const auto& node : ptree) {
        
        if ( node.first == "Plot" ) {
        _plots.push_back( Plot( node.second ) );
        
    }
        
    }
    
    _fittinoStyle = new TStyle( "FITTINO", "Fittino style" ) ;
    _fittinoStyle->SetOptTitle( 0 );
    _fittinoStyle->SetOptStat( 0 );
    
//    _fittinoStyle->SetTextFont( _textFont );
//    _fittinoStyle->SetLabelFont( _textFont, "x" );
//    _fittinoStyle->SetTitleFont( _textFont, "x" );
//    _fittinoStyle->SetLabelFont( _textFont, "y" );
//    _fittinoStyle->SetTitleFont( _textFont, "y" );
//    _fittinoStyle->SetLabelFont( _textFont, "z" );
//    _fittinoStyle->SetTitleFont( _textFont, "z" );
//
//    _fittinoStyle->SetTextSize( _textSize );
//    _fittinoStyle->SetLabelSize( _textSize, "x" );
//    _fittinoStyle->SetTitleSize( _textSize, "x" );
//    _fittinoStyle->SetLabelSize( _textSize, "y" );
//    _fittinoStyle->SetTitleSize( _textSize, "y" );
//    _fittinoStyle->SetLabelSize( _textSize, "z" );
//    _fittinoStyle->SetTitleSize( _textSize, "z" );
    
    _fittinoStyle->SetTitleOffset( 1.3, "x" );
    _fittinoStyle->SetTitleOffset( 1.3, "y" );
    _fittinoStyle->SetTitleOffset( 1.3, "z" );
    
    _fittinoStyle->SetFrameBorderMode( 0 );
    
    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();
    
    
}

Fittino::Plotter::~Plotter(){
    
    
}

void Fittino::Plotter::Execute(){
    
    std::cout<<"I'm the plotter"<<std::endl;
    
    for( auto plot : _plots ) {
        
        plot.Create();
        
    }

}

void Fittino::Plotter::InitializeTool(){
    
    
}

void Fittino::Plotter::PrintResult() const {
    
    
}

void Fittino::Plotter::Terminate(){
    
    
}

void Fittino::Plotter::WriteResultToFile() const {
    
    
}

void Fittino::Plotter::UpdateModel() {
    
    
}
