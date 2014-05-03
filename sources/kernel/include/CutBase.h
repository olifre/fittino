/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CutBase.h                                                        *
*                                                                              *
* Description Base class for cuts                                              *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CUTBASE_H
#define FITTINO_CUTBASE_H

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Base class for cuts.
   */
  class CutBase {

    public:
      /*!
       *  Standard constructor.
       */
      CutBase();

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~CutBase();
      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool IsPassed() = 0;

  };

}

#endif // FITTINO_CUTBASE_H
