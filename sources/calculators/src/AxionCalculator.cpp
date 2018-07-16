#include "AxionCalculator.h"

Fittino::AxionCalculator::AxionCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
: CalculatorBase( model, &ptree )
{
    
    // do here  stuff which only have to be done once during the initialization of Fittino

    
    SetName( "AxionCalculator" );
    
    AddInput( "D1"  );
    AddInput( "D2"  );
    AddInput( "D3"  );
    AddInput( "D4"  );
    AddInput( "D5"  );
    
    AddOutput( "MyOutputQuantity" );
    
    

}

Fittino::AxionCalculator::~AxionCalculator() {
    

    
}

void Fittino::AxionCalculator::CalculatePredictions() {
    
        // do here stuff  which has to be done for each parameter point, e.g. calculation of output quantity
    
    UpdateInput();
    
    
    double output = GetInput( "D1" ) + GetInput( "D2" );
    
    SetOutput( "MyOutputQuantity", output );
    
    // you will find value of output  for each parameter point in Tree in Fittino  ROOT file ( Branch name AxionCalculator_MyOutputQuantity)
    
    
}
