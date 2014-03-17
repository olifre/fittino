/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHADataStorageBase.h                                            *
*                                                                              *
* Description Base class for data storages respecting the SLHA format          *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHADATASTORAGEBASE_H
#define FITTINO_SLHADATASTORAGEBASE_H

#include "DataStorageBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHALine;

  /*!
   *  \ingroup kernel
   *  \brief Base class for data storages respecting the SLHA format.
   */
  class SLHADataStorageBase : public DataStorageBase {

    public:
      /*!
       *  Standard constructor.
       */
      SLHADataStorageBase();
      /*!
       *  Standard destructor.
       */
      ~SLHADataStorageBase();

    public:
      virtual double GetEntry( const std::string& blockName, const std::string& firstIndex, const std::string& secondIndex, const int thirdIndex ) = 0;
      virtual double GetEntry( const std::string& blockName, const int columnIndex, const std::string& firstIndex, const std::string& secondIndex, const std::string& thirdIndex, const std::string fourthIndex ) = 0;
      virtual void   AddBlock( const std::string& path ) = 0;
      virtual void   AddLine( const std::string& path ) = 0;
      virtual void   AddLine( const SLHALine& line ) = 0;
      virtual void   Clear() = 0;
      virtual void   SetEntry( double value, const std::string& blockName, const int columnIndex, const std::string& firstIndex, const std::string& secondIndex, const std::string& thirdIndex,  const std::string fourthIndex ) = 0;
      virtual void   WriteFile( const std::string& slhaOutputFileName ) const = 0;

  };

}

#endif // FITTINO_SLHADATASTORAGEBASE_H
