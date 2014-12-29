/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsSLHACalculator.h                                      *
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

#ifndef FITTINO_HIGGSBOUNDSSLHACALCULATOR_H
#define FITTINO_HIGGSBOUNDSSLHACALCULATOR_H

#include "HiggsBoundsCalculator.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsBounds.
   */
  class HiggsBoundsSLHACalculator : public HiggsBoundsCalculator {

    public:
      /*!
       *  Standard constructor.
       */
      HiggsBoundsSLHACalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HiggsBoundsSLHACalculator();

      /*! \cond UML */
    private:
      virtual void setupHiggsBounds();

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGGSBOUNDSSLHACALCULATOR_H
