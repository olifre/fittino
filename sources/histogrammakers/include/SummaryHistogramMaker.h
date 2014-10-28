/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SummaryHistogramMaker.h                                          *
*                                                                              *
* Description Class for summary histogram maker                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SUMMARYHISTOGRAMMAKER_H
#define FITTINO_SUMMARYHISTOGRAMMAKER_H

#include "Tool.h"

class TGaxis;
class TGraph;
class TH1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PlotterBase;

  /*!
   *  \defgroup histogrammakers
   */
  /*!
   *  \ingroup histogrammakers
   *  \brief Class for summary histogram maker.
   */
  class SummaryHistogramMaker : public Tool {

    public:
      /*!
       *  Standard constructor.
       */
      SummaryHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SummaryHistogramMaker();

    protected:
      /*!
       *  Stores whether or not the histogram axis is set to logscale.
       */
      bool                      _logScale;
      /*!
       *  Stores the lower bound of the histogram.
       */
      double                    _lowerBound;
      /*!
       *  Stores the upper bound of the histogram.
       */
      double                    _upperBound;
       /*!
       *  Stores the number of histogram bins.
       */
      unsigned int              _numberOfBins;
      /*!
       *  Stores the index of a quantity in the model's list of quantities.
       */
      std::vector<unsigned int> _quantityIndex;
      /*!
       *  Stores the formatted axis label of a quantity.
       */
      std::vector<std::string>  _plotName;
      /*!
       *  Stores the name of a quantity.
       */
      std::vector<std::string>  _quantityName;
      TH2D*                     _histogram1Sigma;
      TH2D*                     _histogram2Sigma;
      /*!
       *  Stores the histogram to be made. Needed for compatibility with plotters.
       */
      std::vector<TH1*>         _histogramVector;
      std::vector<TGraph*>       _graphVector;
      PlotterBase*              _plotter;

      /*! \cond UML */
    private:
      bool                      _spacing;
      bool                      _borders;
      double                    _lowestChi2;
      unsigned int              _bestFitEntry;
      TGaxis*                   _globalAxis;

    private:
      int                       FindBin( double value );
      int                       FindBinY( int iQuantity );
      void                      Execute();
      void                      InitializeTool();
      void                      PrintResult() const;
      void                      PrintSteeringParameters() const;
      void                      Terminate();
      void                      UpdateModel();
      void                      WriteResultToFile() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_SUMMARYHISTOGRAMMAKER_H
