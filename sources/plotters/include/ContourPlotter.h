/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ContourPlotter.h                                                 *
*                                                                              *
* Description Class for plotting 2D contour plots                              *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CONTOURPLOTTER_H
#define FITTINO_CONTOURPLOTTER_H

#include "TString.h"

#include "PlotterBase.h"

class TLegend;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \defgroup plotters
   */
  /*!
   *  \ingroup plotters
   *  \brief Class for plotting 2D contour plots.
   */
  class ContourPlotter : public PlotterBase {

    public:
      /*!
       *  Constructor documentation.
       */
      ContourPlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ContourPlotter();

      /*! \endcond UML */
    private:
      bool        _legendFrame;
      double      _legendX1;
      double      _legendX2;
      double      _legendY1;
      double      _legendY2;
      int         _contour1SigmaFillColor;
      int         _contour1SigmaLineColor;
      int         _contour1SigmaLineStyle;
      int         _contour2SigmaFillColor;
      int         _contour2SigmaLineColor;
      int         _contour2SigmaLineStyle;
      int         _totalNumberOfContourLevels;
      std::string _legendPosition;
      std::string _style;
      TString     _legendOption;
      TLegend*    _legend;

    private:
      void        Plot( unsigned int iHistogram );
      void        PrintSteeringParameters() const;
      void        SetClassicStyle();
      void        SetPeachStyle();
      void        SetPlainStyle();

      /*! \endcond UML */

  };

}

#endif // FITTINO_CONTOURPLOTTER_H
