/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleDoubleCut.h                                                *
*                                                                              *
* Description Class for cuts on floating point variables                       *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLEDOUBLECUT_H
#define FITTINO_SIMPLEDOUBLECUT_H

#include "CutBase.h"
#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup tools
   *  \brief Class for cuts on floating point variables.
   */
  class SimpleDoubleCut : public CutBase {

    public:
      /*!
       *  Standard constructor.
       */
      SimpleDoubleCut( ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual       ~SimpleDoubleCut();
      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool  IsPassed();

    private:
      const double& _testValue;
      double        _lowerBound;
      double        _upperBound;

  };

}

#endif // FITTINO_SIMPLEDOUBLECUT_H
