#ifndef FITTINO_RPVCALCULATOR_H
#define FITTINO_RPVCALCULATOR_H

#include "CalculatorBase.h"
#include <complex>

namespace Fittino {
    
    class Executor;
    
    class RPVCalculator : public CalculatorBase {
        
        public:
        
        
        RPVCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
        ~RPVCalculator();
        private:
        std::complex<double>          Vud;
        std::complex<double>          Vus;
        std::complex<double>          Vub;
        std::complex<double>          Vcd;
        std::complex<double>          Vcs;
        std::complex<double>          Vcb;
        std::complex<double>          Vtd;
        std::complex<double>          Vts;
        std::complex<double>          Vtb;
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
        
    private:
        
        void InitializeCKMMatrix();

    
    };
    
}

#endif
