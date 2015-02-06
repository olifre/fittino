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

#include <boost/property_tree/ptree_fwd.hpp>

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
      /*!
       *  Get the unique number of the cut.
       */
      unsigned int        GetCutNumber();
      /*!
       *  Get the name of the cut.
       */
      std::string         GetName();

    public:
      /*!
       *  Standard destructor.
       */
      virtual             ~CutBase();
      /*!
       *  Determines whether a cut is passed or not.
       */
      virtual bool        IsPassed() = 0;

    protected:
      static unsigned int _cutCounter;

    protected:
      unsigned int        _cutNumber;
      std::string         _name;

  };

}

#endif // FITTINO_CUTBASE_H
