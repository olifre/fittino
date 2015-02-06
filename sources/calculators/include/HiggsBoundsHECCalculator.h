/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsHECCalculator.h                                       *
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

#ifndef FITTINO_HIGGSBOUNDSHECCALCULATOR_H
#define FITTINO_HIGGSBOUNDSHECCALCULATOR_H

#include "HiggsBoundsCalculator.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsBounds.
   */
  class HiggsBoundsHECCalculator : public HiggsBoundsCalculator { 

    public:
      /*!
       *  Standard constructor.
       */
      HiggsBoundsHECCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HiggsBoundsHECCalculator();

      /*! \cond UML */
    private:
      virtual void setupHiggsBounds();

    private:
      double const& _BR_hihjhj;
      double const& _g_hiss_s;
      double const& _g_hiss_p;
      double const& _g_hicc_s;
      double const& _g_hicc_p;
      double const& _g_hibb_s;
      double const& _g_hibb_p;
      double const& _g_hitt_s;
      double const& _g_hitt_p;
      double const& _g_himumu_s;
      double const& _g_himumu_p;
      double const& _g_hitautau_s;
      double const& _g_hitautau_p;
      double const& _g_hiWW;
      double const& _g_hiZZ;
      double const& _g_hiZga;
      double const& _g_higaga;
      double const& _g_higg;
      double const& _g_higgZ;
      double const& _g_hihjZ;
      double const& _GammaInvisible;
      double const& _mass_h;
      
      double        _BR_hInvisible;
      double        _Gamma_hTotal;

    private:
      // for details on this function, see HiggsSignalsSLHACalculator. I'll replicate the code here for the time, but maybe we can think of a better solution.
      double        CalculateBRhInvisible( double Gamma_hTotal, double Gamma_hInvisible );
      double        CalculateGammahTotal  ( double mass_h,
                                            double g2_hiss_s,
                                            double g2_hicc_s,
                                            double g2_hibb_s,
                                            double g2_hitt_s,
                                            double g2_himumu_s,
                                            double g2_hitautau_s,
                                            double g2_hiWW,
                                            double g2_hiZZ,
                                            double g2_hiZga,
                                            double g2_higaga,
                                            double g2_higg,
                                            double Gamma_hInvisible );

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGGSBOUNDSHECCALCULATOR_H
