#ifndef FITTINO_AXIONCALCULATOR_H
#define FITTINO_AXIONCALCULATOR_H

#include "CalculatorBase.h"


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {
    
    /*!
     *  \ingroup calculators
     *  \brief Calculates efficiency of a planned Axion experiment.
     */
    class AxionCalculator : public CalculatorBase {
        
        public:
        /*!
         *  Standard constructor.
         */
        AxionCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree);
        
        public:
        /*!
         *  Standard destructor.
         */
        virtual       ~AxionCalculator();
        virtual void  CalculatePredictions();
        
    };
    
}

#endif 
