#include "ScatterData.h"
#include "TFile.h"
#include "TTree.h"
#include "TMath.h"

#include <iostream>

Fittino::ScatterData::ScatterData( const boost::property_tree::ptree& ptree )
:PlotData( ptree ) {
    
    std::string fileName = ptree.get<std::string>( "File" );
    
    _file = new TFile( fileName.c_str() );
    
    std::string treeName =
    ptree.get<std::string>( "Tree" );
    
    _tree = static_cast<TTree*>( _file->Get( treeName.c_str() ) );
    _tree->SetEstimate(-1);
    
    _x = ptree.get<std::string>( "X" );
    _y = ptree.get<std::string>( "Y" );
    
    unsigned int N = _tree->Draw( _x.c_str() ,"","goff" );
    _xmin = TMath::MinElement(N,_tree->GetV1());
    std::cout<<"xmin="<<_xmin<<std::endl;
    _xmax = TMath::MaxElement(N,_tree->GetV1());
    std::cout<<"xmax="<<_xmax<<std::endl;

    N = _tree->Draw( _y.c_str() ,"", "goff" );
    _ymin = TMath::MinElement(N,_tree->GetV1());
    _ymax = TMath::MaxElement(N,_tree->GetV1());
    
}

void Fittino::ScatterData::Draw() {
    
    _tree->SetMarkerStyle(12);
    _tree->Draw( (_y + ":" + _x ).c_str(), "", "SAME" );
    
}

Fittino::ScatterData::~ScatterData() {
    
    
}
