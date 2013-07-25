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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SUMMARYPLOTTER_H
#define FITTINO_SUMMARYPLOTTER_H

#include "PlotterBase.h"

class TTree;

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
                   SummaryPlotter( ModelBase* model, std::string& dataFileName );
      /*!
       *  Standard destructor.
       */
                   ~SummaryPlotter();
      //void         PerformAnalysis();

    protected:
      virtual void Execute();
      virtual void PrintResult() const;
      virtual void PrintSteeringParameters() const;
      virtual void UpdateModel();

  };

}

#endif // FITTINO_SUMMARYPLOTTER_H
