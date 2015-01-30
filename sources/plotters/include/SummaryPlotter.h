/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SummaryPlotter.h                                                 *
*                                                                              *
* Description Class for plotting a summary of the fitted quantities            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SUMMARYPLOTTER_H
#define FITTINO_SUMMARYPLOTTER_H

#include "PlotterBase.h"

class TGraphAsymmErrors;
class TLegend;
class TLine;
class TMarker;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup plotters
   *  \brief Class for plotting a summary of the fitted quantities.
   */
  class SummaryPlotter : public PlotterBase {

    public:
      /*!
       *  Constructor documentation.
       */
      SummaryPlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SummaryPlotter();

      /*! \endcond UML */
    private:
      bool               _labelsLeft;
      double             _labelOffset;
      double             _labelSize;
      int                _color1;
      int                _color2;
      int                _ndivisions;
      std::string        _title;
      TGraphAsymmErrors* _data;
      TH2D*              _emptyHistogram;
      TLegend*           _legend;
      TLegend*           _legend2;
      TLine*             _line;
      TMarker*           _bestFitValue;


    private:
      void               Plot( unsigned int iHistogram );
      void               PrintSteeringParameters() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_SUMMARYPLOTTER_H
