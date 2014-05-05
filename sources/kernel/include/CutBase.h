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

#include <string>

#include "PtreeForwardDeclaration.h"

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
      CutBase( const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~CutBase();
      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool IsPassed() = 0;
      /*!
       * Get the name of the cut
       */
      std::string  GetName();
      /*!
       * Get the unique number of the cut
       */
      unsigned int GetCutNumber();

    protected:
      std::string                _name;
      unsigned int               _cutNumber;
      static unsigned int        _cutCounter;

  };

}

#endif // FITTINO_CUTBASE_H
