#include "MinimumCalculator.h"
#include "ModelBase.h"
#include "TMath.h"

Fittino::MinimumCalculator::MinimumCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree)
:Fittino::CalculatorBase( model, &ptree ){
    
    SetName( "MinimumCalculator" );
    
    _regex = ptree.get<std::string>( "Regex" );
    
    const auto col = _model->GetCollectionOfQuantities();
    
    for( unsigned int i = 0; i < col.GetNumberOfElements(); ++i ) {
        
        if( boost::regex_match( col.At( i )->GetName(), _regex ) ) {
      
        _quantities.push_back( col.At( i ) );
        
        }
        
    }
    
    AddOutput( "Value", _value );
    AddStringVariable( "Name", _name );

}

Fittino::MinimumCalculator::~MinimumCalculator(){
    
}

void Fittino::MinimumCalculator::CalculatePredictions(){
    
    _value = std::numeric_limits<double>::infinity();
    _name = "";
    
    for( const auto q : _quantities ) {
        
        if( TMath::Abs( q->GetValue() ) < _value ) {
            
            _value = q->GetValue();
            _name = q->GetName();
            
        }
        
    }
    
}
