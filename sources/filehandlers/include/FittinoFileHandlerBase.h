/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoFileHandlerBase.h                                         *
*                                                                              *
* Description Base class for reading and interpreting Fittino input files      *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FITTINOFILEHANDLERBASE_H
#define FITTINO_FITTINOFILEHANDLERBASE_H

#include "FileHandlerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup filehandlers
   *  \brief Base class for reading and interpreting Fittino input files.
   */
  class FittinoFileHandlerBase : public FileHandlerBase {

    public:
      /*!
       *  Standard constructor.
       */
                   FittinoFileHandlerBase();
      /*!
       *  Standard destructor.
       */
      virtual      ~FittinoFileHandlerBase();
      virtual void WriteFile( const TString& outputFileName ) const;

  };

}

#endif // FITTINO_FITTINOFILEHANDLERBASE_H
