#ifndef FITTINO_INPUTFILE
#define FITTINO_INPUTFILE

#include <vector>
#include <string>
#include "boost/property_tree/ptree_fwd.hpp"

namespace Fittino {

    class FormulaQuantity;
    class ModelBase;

    class InputFile {

        public:
            InputFile( const boost::property_tree::ptree& ptree, const ModelBase* model );
            ~InputFile();
            void Write();
            std::string GetName();

        private:
            std::string _name;
            std::string _template;
            std::vector<FormulaQuantity*> _formulas;

    };

}

#endif
