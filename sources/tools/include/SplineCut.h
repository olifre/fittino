/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SplineCut.h                                                      *
*                                                                              *
* Description Base class for spline cuts                                       *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SPLINECUT_H
#define FITTINO_SPLINECUT_H

#include "ModelBase.h"
#include "PtreeForwardDeclaration.h"

class TSpline3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup tools
   *  \brief Base class for spline cuts.
   */
  class SplineCut {

    public:
      /*!
       *  Standard constructor.
       */
      SplineCut( ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~SplineCut();

      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool        IsPassed();

      const double&       _xValue;
      const double&       _yValue;
      TSpline3*           _spline;
      bool                _isUpperBound;

  };

}

#endif // FITTINO_SPLINECUT_H
