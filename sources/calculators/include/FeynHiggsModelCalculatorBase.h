/* $Id: FeynHiggsModelCalculator.h 1835 2014-01-30 11:13:34Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculatorBase.h                                   *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSMODELCALCULATORBASE_H
#define FITTINO_FEYNHIGGSMODELCALCULATORBASE_H

#include <complex>

#include "Collection.h"
#include "ModelCalculatorBase.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare >
      class basic_ptree;

    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsModelCalculatorBase : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsModelCalculatorBase( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual ~FeynHiggsModelCalculatorBase();
      
      virtual void CalculatePredictions();
      virtual void Initialize() const;

      /*! \cond UML */
    private:
      virtual void ConfigureInput() =0;

    private:  
      int    _error;

      double _m_h;

      double _normSM_sigma_ggh;
      double _normSM_sigma_ggh_2;
      double _normSM_sigma_bbh;
      double _normSM_sigma_qqh;
      double _normSM_sigma_tth;
      double _normSM_sigma_Wh;
      double _normSM_sigma_Zh;

      double _normSM_Gamma_h_tau_tau;
      double _normSM_Gamma_h_c_c;
      double _normSM_Gamma_h_s_s;
      double _normSM_Gamma_h_b_b;
      double _normSM_Gamma_h_gamma_gamma;
      double _normSM_Gamma_h_Z_gamma;
      double _normSM_Gamma_h_Z_Z;
      double _normSM_Gamma_h_W_W;
      double _normSM_Gamma_h_g_g;
      double _normSM_Gamma_h_total;
      
      Collection<SimplePrediction*> _input;
      
      /*! \endcond UML */

  };

}

#endif 
