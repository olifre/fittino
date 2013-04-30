/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        XMLDataStorage.h                                                 *
*                                                                              *
* Description Class for XML data storage                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_XMLDATASTORAGE_H
#define FITTINO_XMLDATASTORAGE_H

#include "DataStorageBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class DataStorageBase;

  /*!
   *  \ingroup datastorages
   *  \brief Class for XML data storage.
   */
  class XMLDataStorage : public DataStorageBase {

    public:
      /*!
       *  Standard constructor.
       */
                   XMLDataStorage();
      /*!
       *  Standard destructor.
       */
                   ~XMLDataStorage();
      /*!
       *  Parses the input file given as an argument. After calling this method the Configuration\n
       *  instance is initialized and the steering parameters specified in the input file can be\n
       *  retrieved via dedicated getter functions.
       */
      virtual void ReadFile( const std::string& xmlInputFileName ) const;

  };

}

#endif // FITTINO_XMLDATASTORAGE_H
