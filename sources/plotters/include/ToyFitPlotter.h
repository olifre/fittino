/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ToyFitPlotter.h                                                  *
*                                                                              *
* Description Class for plotting toy fit distributions                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_TOYFITPLOTTER_H
#define FITTINO_TOYFITPLOTTER_H

#include "PlotterBase.h"

#include "TString.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup plotters
   *  \brief Class for plotting toy fit distributions.
   */
  class ToyFitPlotter : public PlotterBase {

    public:
      /*!
       *  Standard constructor.
       */
      ToyFitPlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ToyFitPlotter();

      /*! \endcond UML */
    private:
      int     _fillColor;
      int     _fillStyle;
      int     _lineColor;
      TString _option;

    private:
      void    Plot( unsigned int iHistogram );
      void    PrintSteeringParameters() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_TOYFITPLOTTER_H
