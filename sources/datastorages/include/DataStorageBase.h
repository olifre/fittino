/* $Id: DataStorageBase.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        DataStorageBase.h                                                *
*                                                                              *
* Description Base class for data storages                                     *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_DATASTORAGEBASE_H
#define FITTINO_DATASTORAGEBASE_H

class TString;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup datastorages
   */
  /*!
   *  \ingroup filehandlers
   *  \brief Base class for data storages.
   */
  class DataStorageBase {

    public:
      /*!
       *  Standard constructor.
       */
                   DataStorageBase();
      /*!
       *  Standard destructor.
       */
      virtual      ~DataStorageBase();
      /*!
       *  Parses the input file given as an argument. After calling this method the Configuration\n
       *  instance is initialized and the steering parameters specified in the input file can be\n
       *  retrieved via dedicated getter functions.
       */
      virtual void ReadFile( const TString& xmlInputFileName ) const = 0;

  };

}

#endif // FITTINO_DATASTORAGEBASE_H
