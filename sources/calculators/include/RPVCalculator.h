#ifndef FITTINO_RPVCALCULATOR_H
#define FITTINO_RPVCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {
    
    class Executor;
    
    class RPVCalculator : public CalculatorBase {
        
        public:
        
        RPVCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
        ~RPVCalculator();
        private:
        double          Vud;
        double          Vus;
        double          Vub;
        double          Vcd;
        double          Vcs;
        double          Vcb;
        double          Vtd;
        double          Vts;
        double          Vtb;
        double          s_Wsq;
        double          alpha_em;
        double          X_t;
        double          m_t;
        double          R_D_Relation;
        double          R_Dstar_Relation;
        double          B_tau_nu_relation;
        double          B_K_relation;
        double          B_pi_relation;
        double          f_Z;
        double          Z_coupling_relation;
        double          f_W;
        double          W_coupling_relation;


        
        public:
        
        virtual void CalculatePredictions();
        virtual void Initialize();
        
        
        
        
        
    };
    
}

#endif
