#include "InputFile.h"
#include "ModelBase.h"
#include "FormulaQuantity.h"
#include "boost/property_tree/ptree.hpp"
#include <boost/algorithm/string.hpp>
#include <limits>
#include <fstream>
#include <sstream>
#include <set>

Fittino::InputFile::InputFile( const boost::property_tree::ptree& ptree, const ModelBase* model) {

    _name = ptree.get<std::string>( "Name" );  
    _template = ptree.get<std::string>( "Template" );  

    std::set<std::string> names;   

    for( const auto& node : ptree ) {

        if( node.first != "Quantity" ) continue;

        std::string name = node.second.get<std::string>( "Name" );
        std::string value = node.second.get<std::string>( "Value" );
        FormulaQuantity* f = new FormulaQuantity( name, value, model );

        if( ! names.insert(name).second )  {

            throw ConfigurationException( "Quantity of " + name + " configured multiple times." );

        }

        _formulas.push_back( f );

    }

}

Fittino::InputFile::~InputFile() {

}

std::string Fittino::InputFile::GetName() {

    return _name;
}

void Fittino::InputFile::Write() {

    std::map<std::string, std::string> values;

    for ( auto formula : _formulas ) {

        formula->Update();

        std::ostringstream ss;
        ss << std::scientific << std::setprecision( std::numeric_limits<double>::max_digits10 ) << formula->GetValue();

        values[formula->GetName()] = ss.str();

    }

    std::ifstream in( _template );
    if ( !in.is_open() ) throw ConfigurationException( "Can't open file " + _template + "." );

    std::ofstream out( _name );
    if ( !out.is_open() ) throw ConfigurationException( "Can't open file " + _name + "." );

    std::string line;

    while( getline( in, line ) ) {

        for ( auto formula : values ) {

            boost::replace_all( line, formula.first, formula.second  );

        }

        out << line << std::endl;

    }

}
