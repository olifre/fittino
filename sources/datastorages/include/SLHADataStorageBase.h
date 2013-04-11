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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHADATASTORAGEBASE_H
#define FITTINO_SLHADATASTORAGEBASE_H

#include <string>

#include "DataStorageBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PhysicsModelBase;

  /*!
   *  \ingroup datastorages
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
      virtual double GetEntry( const std::string& blockName, const std::string& firstIndex, const int secondIndex ) = 0;
      virtual double GetEntry( const std::string& blockName, const std::string& firstIndex, const std::string& secondIndex, const int thirdIndex ) = 0;
      virtual void   AddBlock( const std::string& path ) = 0;
      virtual void   AddLine( const std::string& path ) = 0;
      virtual void   ReadFile( const TString& slhaInputFileName ) = 0;
      virtual void   ReadFile( const TString& slhaInputFileName ) const;
      virtual void   WriteFile( const TString& slhaOutputFileName ) const = 0;

  };

}

#endif // FITTINO_SLHADATASTORAGEBASE_H
