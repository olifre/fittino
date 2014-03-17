/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SuperIsoCalculator.h                                             *
*                                                                              *
* Description Wrapper class for HDim6                                          *
*                                                                              *
* Authors     Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SUPERISOCALCULATOR_H
#define FITTINO_SUPERISOCALCULATOR_H

#include "CalculatorBase.h"

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
   *  \brief Wrapper class for SuperIso
   */
  class SuperIsoCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    SuperIsoCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual                  ~SuperIsoCalculator();

      virtual void             CalculatePredictions();

    private:
      std::string _slhafile;

      double _amu;
      double _delta0;
      double _bsgamma;
      double _bsmumu;
      double _bsmumu_untag;
      double _bdmumu;
      double _btaunu;
      double _normSM_btaunu;
      double _bdtaunu;
      double _bdtaunu_bdenu;
      double _dmunu;
      double _dsmunu;
      double _dstaunu;
      double _kmunu_pimunu;
      double _rmu23;
      double _excludedHiggsMass;
      double _excludedSusyMass;
      double _nmssmColliderExcluded;
      double _nmssmTheoryExcluded;
      double _chargedLSP;

  };

}

#endif
