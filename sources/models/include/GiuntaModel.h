/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GiuntaModel.h                                                    *
*                                                                              *
* Description Implementation of an n-dimensional GiuntaModel function          *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>                                *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_GiuntaModel_H
#define FITTINO_GiuntaModel_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class GiuntaModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      GiuntaModel( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~GiuntaModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual GiuntaModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();
      virtual double           ToRadians(double x);

      /*! \endcond UML */

  };

}

#endif // FITTINO_GiuntaModel_H
