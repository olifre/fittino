#ifndef FITTINO_Hypothesis_H
#define FITTINO_Hypothesis_H

//#include "ModelParameterBase.h"
#include <vector>

namespace Fittino {

    class Hypothesis{

        public:
            Hypothesis();
            virtual ~Hypothesis();

            std::vector<ModelParameterBase> getParameterVector();
            void setParameterVector(int i, double value);

            double getFitness();
            void setFitness(double value);

        protected:

        private:
            std::vector<ModelParameterBase> _parameterVector;
            double _fitness;

    };

}

#endif // HYPOTHESIS_H
