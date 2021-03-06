/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ProfileHistogramMaker.h                                          *
*                                                                              *
* Description Class for profile histogram maker                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PROFILEHISTOGRAMMAKER_H
#define FITTINO_PROFILEHISTOGRAMMAKER_H

#include "Simple1DHistogramMaker.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup histogrammakers
   *  \brief Class for profile histogram maker.
   */
  class ProfileHistogramMaker : public Simple1DHistogramMaker {

    public:
      /*!
       *  Standard constructor.
       */
      ProfileHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ProfileHistogramMaker();

      /*! \cond UML */
    private:
      double       _lowestChi2;
      unsigned int _bestFitEntry;

    private:
      void         PrintSteeringParameters() const;
      void         UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_PROFILEHISTOGRAMMAKER_H
