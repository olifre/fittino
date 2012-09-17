/* $Id: XMLFittinoFileHandler.h 542 2009-12-23 14:59:43Z wiene $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        XMLFittinoFileHandler.h                                          *
*                                                                              *
* Description Class for reading and interpreting Fittino input files in XML    *
*             format                                                           *
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

#ifndef FITTINO_XMLFITTINOFILEHANDLER_H
#define FITTINO_XMLFITTINOFILEHANDLER_H

#include "FittinoFileHandlerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup filehandlers
   *  \brief Class for reading and interpreting Fittino input files in XML format.
   */
  class XMLFittinoFileHandler : public FittinoFileHandlerBase {

    public:
      /*!
       *  Standard constructor.
       */
                   XMLFittinoFileHandler();
      /*!
       *  Standard destructor.
       */
      virtual      ~XMLFittinoFileHandler();
      /*!
       *  Parses the input file given as an argument. After calling this method the Configuration\n
       *  instance is initialized and the steering parameters specified in the input file can be\n
       *  retrieved via dedicated getter functions.
       */
      virtual void ReadFile( const TString& xmlInputFileName ) const;

  };

}

#endif // FITTINO_XMLFITTINOFILEHANDLER_H
