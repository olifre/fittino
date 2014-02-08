/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleDataStorage.h                                              *
*                                                                              *
* Description Class for storage of doubles                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLEDATASTORAGE_H
#define FITTINO_SIMPLEDATASTORAGE_H

#include <map>
#include <string>

#include "DataStorageBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup datastorages
   */
  /*!
   *  \ingroup datastorages
   *  \brief Class for storage of doubles.
   */
  class SimpleDataStorage : public DataStorageBase {

    public:
      /*!
       *  Standard constructor.
       */
                                           SimpleDataStorage();
      /*!
       *  Standard destructor.
       */
                                           ~SimpleDataStorage();
      /*!
       *  Adds an non yet existing entry.
       */

      void                                 AddEntry(std::string name, double value);
      /*!
       *  Returns the map containing the stored doubles.
       */
      std::map<std::string, double>*       GetMap();

    public:  
      /*!
       *  Returns the map containing the stored doubles.
       */
      const std::map<std::string, double>* GetMap() const;

    public:    		   
      /*!
       *  Dummy function. 
       */
      virtual void                         ReadFile( const std::string& inputFileName ) const;

    private:  
      std::map<std::string, double>*       _map;

  };

}

#endif // FITTINO_SIMPLEDATASTORAGE_H
