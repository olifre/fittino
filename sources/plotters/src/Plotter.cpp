#include "Plotter.h"
#include "Tool.h"
#include <iostream>

Fittino::Plotter::Plotter(const boost::property_tree::ptree& ptree )
:Tool( nullptr, ptree )
{
    
    for( const auto& node : ptree) {
        
        if ( node.first == "Plot" ) {
        _plots.push_back( Plot( node.second ) );
        
    }
        
    }
    
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
