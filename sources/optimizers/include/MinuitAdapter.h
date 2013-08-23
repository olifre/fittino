/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MinuitAdapter.h                                                  *
*                                                                              *
* Description Adapter class for Minuit                                         *
*                                                                              *
* Authors     Peter Wienemann <wienemann@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MINUITADAPTER_H
#define FITTINO_MINUITADAPTER_H

#include "Minuit2/FCNBase.h"

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup optimizers
   *  \brief Class for Minuit adapter
   */
  class MinuitAdapter : public ROOT::Minuit2::FCNBase {

    public:
      /*!
       *  Standard constructor.
       */
                        MinuitAdapter( ModelBase* model );
      /*!
       *  Standard destructor.
       */
    virtual             ~MinuitAdapter() {;}
      /*!
       *  Error definition
       */
    virtual double	Up() const { return _errorDef; }
      /*!
       *  Set error definition
       */
    virtual void	SetErrorDef( double err ) { _errorDef = err; }
      /*!
       *  Function to be minimized
       */
    virtual double	operator()( const std::vector< double >& parameterVector ) const;

      /*! \cond UML */
    private:
    double              _errorDef;
    Fittino::ModelBase*	_model;

      /*! \endcond UML */
  };

}

#endif // FITTINO_MINUITADAPTER_H
