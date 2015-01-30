/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleStringCut.h                                                *
*                                                                              *
* Description Class for cuts on string variables                               *
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

#include "CutBase.h"
#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup tools
   *  \brief Class for cuts on string variables.
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
      virtual                  ~SimpleStringCut();
      /*!
       * Determines whether a cut is passed or not.
       */
      virtual bool             IsPassed();

    private:
      const std::string&       _testValue;
      bool                     _mustMatch;
      std::vector<std::string> _cutValues;

  };

}

#endif // FITTINO_SIMPLESTRINGCUT_H
