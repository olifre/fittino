/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HistogramMakerBase.h                                             *
*                                                                              *
* Description Base class for histogram makers                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HISTOGRAMMAKERBASE_H
#define FITTINO_HISTOGRAMMAKERBASE_H

#include "Tool.h"

class TGaxis;
class TH1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PlotterBase;

  /*!
   *  \ingroup kernel
   *  \brief Base class for histogram makers.
   */
  class HistogramMakerBase : public Tool {

    public:
      /*!
       *  Standard constructor.
       */
      HistogramMakerBase( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HistogramMakerBase();

    protected:
      /*!
       *  Entry in the input file tree.
       */
      unsigned int              _iEntry;
      /*!
       *  Stores whether or not a quantity's axis is set to logscale.
       */
      std::vector<bool>         _logScale;
      /*!
       *  Stores the lower bound of a quantity.
       */
      std::vector<double>       _lowerBound;
      /*!
       *  Stores the upper bound of a quantity.
       */
      std::vector<double>       _upperBound;
      /*!
       *  Stores the number of histogram bins.
       */
      std::vector<unsigned int> _numberOfBins;
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
      /*!
       *  Stores the histograms to be made.
       */
      std::vector<TH1*>         _histogramVector;
      /*!
       *  Number of Iterations to be processed; 
       */
      int                       _numberOfPointsToProcess;
      PlotterBase*              _plotter;

    protected:
      void                      PrintSteeringParameters() const;

      /*! \cond UML */
    private:
      TGaxis*                   _globalAxis;

    private:
      void                      Execute();
      void                      InitializeTool();
      void                      PrintResult() const;
      void                      Terminate();
      void                      WriteResultToFile() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_HISTOGRAMMAKERBASE_H
