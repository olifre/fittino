/* $Id: Simple1DHistogramMaker.h 1899 2014-02-15 12:57:55Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Simple1DHistogramMaker.h                                         *
*                                                                              *
* Description Class for simple 1D histogram maker                              *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLE1DHISTOGRAMMAKER_H
#define FITTINO_SIMPLE1DHISTOGRAMMAKER_H

#include "HistogramMakerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Class for simple 1D histogram maker.
   */
  class Simple1DHistogramMaker : public HistogramMakerBase {

    public:
      /*!
       *  Standard constructor.
       */
      Simple1DHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Simple1DHistogramMaker();

      /*! \cond UML */
    private:
      void UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_SIMPLE1DHISTOGRAMMAKER_H
