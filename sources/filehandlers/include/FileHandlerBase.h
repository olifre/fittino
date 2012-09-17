/* $Id: FileHandlerBase.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FileHandlerBase.h                                                *
*                                                                              *
* Description Base class for file handlers                                     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FILEHANDLERBASE_H
#define FITTINO_FILEHANDLERBASE_H

class TString;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup filehandlers
   */
  /*!
   *  \ingroup filehandlers
   *  \brief Base class for file handlers.
   */
  class FileHandlerBase {

    public:
      /*!
       *  Standard constructor.
       */
                   FileHandlerBase();
      /*!
       *  Standard destructor.
       */
      virtual      ~FileHandlerBase();
      /*!
       *  \todo Short-term: Discuss usage of TString (instead of std::string) here.
       */
      virtual void ReadFile( const TString& inputFileName ) const = 0;
      virtual void WriteFile( const TString& outputFileName ) const = 0;

  };

}

#endif // FITTINO_FILEHANDLERBASE_H
