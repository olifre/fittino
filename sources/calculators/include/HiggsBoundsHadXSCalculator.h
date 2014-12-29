/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsHadXSCalculator.h                                     *
*                                                                              *
* Description Wrapper class for HiggsBounds                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSBOUNDSHADXSCALCULATOR_H
#define FITTINO_HIGGSBOUNDSHADXSCALCULATOR_H

#include "HiggsBoundsCalculator.h"
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsBounds.
   */
  class HiggsBoundsHadXSCalculator : public HiggsBoundsCalculator { 

    public:
      /*!
       *  Standard constructor.
       */
      HiggsBoundsHadXSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HiggsBoundsHadXSCalculator();

      /*! \cond UML */
    private:
      virtual void setupHiggsBounds();

    private:  
      double _BR_hbb;
      double _BR_hcc;
      double _BR_hgaga;
      double _BR_hgg;
      double _BR_hHH;
      double _BR_hInvisible;
      double _BR_hmumu;
      double _BR_hss;
      double _BR_htautau;
      double _BR_hWW;
      double _BR_hZga;
      double _BR_hZZ;
      double _CP;
      double _Gamma_hbb;
      double _Gamma_hcc;
      double _Gamma_hgaga;
      double _Gamma_hgg;
      double _Gamma_hmumu;
      double _Gamma_hss;
      double _Gamma_htautau;
      double _Gamma_hTotal;
      double _Gamma_hWW;
      double _Gamma_hZga;
      double _Gamma_hZZ;
      double _normSM_BR_hbb;
      double _normSM_BR_hcc;
      double _normSM_BR_hgaga;
      double _normSM_BR_hgg;
      double _normSM_BR_hmumu;
      double _normSM_BR_hss;
      double _normSM_BR_htautau;
      double _normSM_BR_hWW;
      double _normSM_BR_hZga;
      double _normSM_BR_hZZ;
      double _normSM_Gamma_hTotal;
      double _normSM_xs_h;
      double _normSM_xs_lep;
      double _normSM_xs_tev;
      double _SM_BR_hbb;
      double _SM_BR_hcc;
      double _SM_BR_hgaga;
      double _SM_BR_hgg;
      double _SM_BR_hmumu;
      double _SM_BR_hss;
      double _SM_BR_htautau;
      double _SM_BR_hWW;
      double _SM_BR_hZga;
      double _SM_BR_hZZ;
      double _SM_Gamma_hbb;
      double _SM_Gamma_hcc;
      double _SM_Gamma_hgaga;
      double _SM_Gamma_hgg;
      double _SM_Gamma_hmumu;
      double _SM_Gamma_hss;
      double _SM_Gamma_htautau;
      double _SM_Gamma_hTotal;
      double _SM_Gamma_hWW;
      double _SM_Gamma_hZga;
      double _SM_Gamma_hZZ;
      double _SM_xs_bbh;
      double _SM_xs_ggh;
      double _SM_xs_h;
      double _weight_xs_bbh;
      double _weight_xs_ggh;
    
    private:
      const double& _mass_h;
      const double& _normSM_Gamma_hbb;
      const double& _normSM_Gamma_hcc;
      const double& _normSM_Gamma_hgaga;
      const double& _normSM_Gamma_hgg;
      const double& _normSM_Gamma_hmumu;
      const double& _normSM_Gamma_hss;
      const double& _normSM_Gamma_htautau;
      const double& _normSM_Gamma_hWW;
      const double& _normSM_Gamma_hZga;
      const double& _normSM_Gamma_hZZ;
      const double& _normSM_xs_bbh;
      const double& _normSM_xs_bh;
      const double& _normSM_xs_ggh;
      const double& _normSM_xs_qqh;
      const double& _normSM_xs_tth;
      const double& _normSM_xs_Wh;
      const double& _normSM_xs_Zh;

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGGSBOUNDSHADXSCALCULATOR_H
