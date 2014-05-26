/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Alpine2Model.h                                                   *
*                                                                              *
* Description Implementation of an n-dimensional Alpine2Model function         *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>                                *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_Alpine2Model_H
#define FITTINO_Alpine2Model_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class Alpine2Model : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      Alpine2Model( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Alpine2Model();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual Alpine2Model* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();

      /*! \endcond UML */

  };

}

#endif // FITTINO_Alpine2Model_H
