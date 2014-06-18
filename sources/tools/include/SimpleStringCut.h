/* $Id: SimpleStringCut.h 2150 2014-05-05 18:40:38Z mhamer $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleStringCut.h                                                      *
*                                                                              *
* Description Base class for spline cuts                                       *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLESTRINGCUT_H
#define FITTINO_SIMPLESTRINGCUT_H

#include "ModelBase.h"
#include "PtreeForwardDeclaration.h"
#include "CutBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {
    
  /*!
   *  \ingroup tools
   *  \brief Base class for spline cuts.
   */
  class SimpleStringCut : public CutBase {

    public:
      /*!
       *  Standard constructor.
       */
      SimpleStringCut( ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~SimpleStringCut();

      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool        IsPassed();
      
      const std::string&        _testValue;
      std::vector<std::string>  _cutValues;
      bool                      _mustMatch;

  };

}

#endif // FITTINO_SIMPLESTRINGCUT_H
