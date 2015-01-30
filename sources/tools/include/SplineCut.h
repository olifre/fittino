/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SplineCut.h                                                      *
*                                                                              *
* Description Class for cuts on splines                                        *
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

#include "CutBase.h"
#include "ModelBase.h"

class TSpline3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup tools
   *  \brief Class for cuts on splines.
   */
  class SplineCut : public CutBase {

    public:
      /*!
       *  Standard constructor.
       */
      SplineCut( ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual       ~SplineCut();
      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool  IsPassed();

    private:
      const double& _xValue;
      const double& _yValue;
      bool          _isUpperBound;
      TSpline3*     _spline;

  };

}

#endif // FITTINO_SPLINECUT_H
