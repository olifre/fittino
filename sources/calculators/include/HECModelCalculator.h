/* $Id: $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HECModelCalculator.h                                             *
*                                                                              *
* Description Converts the HEC model parameters into the HiggsSignals input    *
*             variables                                                        *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HECMODELCALCULATOR_H
#define FITTINO_HECMODELCALCULATOR_H

#include "ModelCalculatorBase.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare > class basic_ptree;
    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Converts the HEC model parameters into the HiggsSignals input
   *  variables
   *
   *  Converts the HEC model parameters into the HiggsSignals input variables\n
   *  according to the formula
   *  \n\n
   *  \f$ g(hxx)_y = 1+\Delta(hxx)_y \f$.
   *  \n\n
   *  Note: HiggsSignals takes mostly the squared coupling constants \f$ g^2 \f$ as\n
   *  input. However, in order to be able to calculate quantities where\n
   *  interference terms may play a role, the original coupling constants are\n
   *  passed as arguments.
   */
  class HECModelCalculator : public ModelCalculatorBase {

    public:
      /*!
       *
       */
      HECModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HECModelCalculator();

    public:
      virtual void  CalculatePredictions();
      virtual void  Initialize() const;

      /*! \cond UML */
    private:
      double        _g_hiss_s;
      double        _g_hiss_p;
      double        _g_hicc_s;
      double        _g_hicc_p;
      double        _g_hibb_s;
      double        _g_hibb_p;
      double        _g_hitt_s;
      double        _g_hitt_p;
      double        _g_himumu_s;
      double        _g_himumu_p;
      double        _g_hitautau_s;
      double        _g_hitautau_p;
      double        _g_hiWW;
      double        _g_hiZZ;
      double        _g_hiZga;
      double        _g_higaga;
      double        _g_higg;
      double        _g_higgZ;
      double        _g_hihjZ;

    private:
      const double& _Delta_hss_s;
      const double& _Delta_hss_p;
      const double& _Delta_hcc_s;
      const double& _Delta_hcc_p;
      const double& _Delta_hbb_s;
      const double& _Delta_hbb_p;
      const double& _Delta_htt_s;
      const double& _Delta_htt_p;
      const double& _Delta_hmumu_s;
      const double& _Delta_hmumu_p;
      const double& _Delta_htautau_s;
      const double& _Delta_htautau_p;
      const double& _Delta_hWW;
      const double& _Delta_hZZ;
      const double& _Delta_hZgamma;
      const double& _Delta_hgammagamma;
      const double& _Delta_hgg;
      const double& _Delta_hggZ;
      const double& _Delta_hihjZ;

    private:
      virtual void  CallExecutable();
      virtual void  CallFunction();
      virtual void  ConfigureInput();

      /*! \endcond UML */

  };

}

#endif // FITTINO_HECMODELCALCULATOR_H
