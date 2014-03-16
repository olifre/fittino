/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAPrediction.h                                                 *
*                                                                              *
* Description Class for SLHA predicitions                                      *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAPREDICTION_H
#define FITTINO_SLHAPREDICTION_H

#include "PredictionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHADataStorageBase;

  /*!
   *  \ingroup models
   *  \brief Class for SLHA observables.
   */
  class SLHAPrediction : public PredictionBase {

    public:
      SLHAPrediction( std::string         name,
                      std::string         unit,
                      SLHADataStorageBase* slhadatastorage,
                      std::string         blockName,
                      int                 columnIndex,
                      std::string         firstId,
                      std::string         secondId,
                      std::string         thirdId,
                      std::string          fourthId        );

      SLHAPrediction( std::string         name,
                      std::string         unit,
                      SLHADataStorageBase* slhadatastorage,
                      std::string         blockName,
                      int                 columnIndex,
                     std::string         firstId,
                     std::string         secondId,
                     std::string         thirdId,
                     std::string         fourthId,
                     double              defaultValue );


      /*!
       *  Standard Constructor
       */
      SLHAPrediction( const boost::property_tree::ptree& ptree, SLHADataStorageBase* slhadatastorage );
      /*!
       *  Standard destructor.
       */
      ~SLHAPrediction();

    public:
      virtual void        Update();

    private:
      bool                _useDefaultValue;
      double              _defaultValue;
      int                 _columnIndex;
      std::string         _firstId;
      std::string         _secondId;
      std::string         _thirdId;
      std::string         _fourthId;
      std::string         _blockName;
      SLHADataStorageBase* _slhadatastorage;

  };

}

#endif // FITTINO_SLHAPREDICTION_H
