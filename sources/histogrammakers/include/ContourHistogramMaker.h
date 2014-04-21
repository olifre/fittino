/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ContourHistogramMaker.h                                          *
*                                                                              *
* Description Class for contour histogram maker                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CONTOURHISTOGRAMMAKER_H
#define FITTINO_CONTOURHISTOGRAMMAKER_H

#include "HistogramMakerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup histogrammakers
   */
  /*!
   *  \ingroup histogrammakers
   *  \brief Class for 2D chi2 profile histogram maker.
   */
  class ContourHistogramMaker : public HistogramMakerBase {

    public:
      /*!
       *  Standard constructor.
       */
      ContourHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ContourHistogramMaker();

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

#endif // FITTINO_CONTOURHISTOGRAMMAKER_H
