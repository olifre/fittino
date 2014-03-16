/* $Id$ */

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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAEASLHADATASTORAGE_H
#define FITTINO_SLHAEASLHADATASTORAGE_H

#include "SLHADataStorageBase.h"

namespace SLHAea {

  class Coll;

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHALine;

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

    public:
      virtual double GetEntry( const std::string& blockName, const std::string& firstIndex, const int secondIndex );
      virtual double GetEntry( const std::string& blockName, const std::string& firstIndex, const std::string& secondIndex, const int thirdIndex );
      virtual double GetEntry( const std::string& blockName, const int columnIndex, const std::string& firstIndex, const std::string& secondIndex, const std::string& thirdIndex, const std::string fourthIndex );
      virtual void   AddBlock( const std::string& path );
      virtual void   AddLine( const std::string& path );
      virtual void   AddLine( const SLHALine& line );
      virtual void   Clear();
      virtual void   ReadFile( const std::string& slhaInputFileName ) const;
      virtual void   SetEntry( double value, const std::string& blockName, const int columnIndex, const std::string& firstIndex, const std::string& secondIndex, const std::string& thirdIndex, const std::string fourthIndex );
      virtual void   WriteFile( const std::string& slhaOutputFileName ) const;

    private:
      SLHAea::Coll*  _slhaeaDataStorage;

  };

}

#endif // FITTINO_SLHAEASLHADATASTORAGE_H
