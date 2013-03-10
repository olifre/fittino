/* $Id: SLHAeaSLHADataStorage.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAeaSLHADataStorage.h                                          *
*                                                                              *
* Description Wrapper class for SLHAea SLHA data storages                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAEASLHADATASTORAGE_H
#define FITTINO_SLHAEASLHADATASTORAGE_H

#include "slhaea.h"

#include "SLHADataStorageBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup datastorages
   *  \brief Wrapper class for SLHAea SLHA data storages.
   */
  class SLHAeaSLHADataStorage : public SLHADataStorageBase {

    public:
      /*!
       *  Standard constructor.
       */
                     SLHAeaSLHADataStorage();
      /*!
       *  Standard destructor.
       */
                     ~SLHAeaSLHADataStorage();
      virtual double GetEntry( const std::string& blockName, const int firstIndex, const int secondIndex );
      virtual void   AddBlock( const std::string& path );
      virtual void   AddLine( const std::string& path );
      virtual void   ReadFile( const TString& slhaInputFileName );
      virtual void   WriteFile( const TString& slhaOutputFileName ) const;

    public:
      SLHAea::Coll   _slhaeaDataStorage;

  };

}

#endif // FITTINO_SLHAEASLHADATASTORAGE_H
