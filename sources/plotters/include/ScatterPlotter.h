/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ScatterPlotter.h                                                 *
*                                                                              *
* Description Class for plotting 2D scatter plots                              *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SCATTERPLOTTER_H
#define FITTINO_SCATTERPLOTTER_H

#include "PlotterBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup plotters
   *  \brief Class for plotting 2D scatter plots.
   */
  class ScatterPlotter : public PlotterBase {

    public:
      /*!
       *  Constructor documentation.
       */
                   ScatterPlotter( ModelBase* model, std::string& dataFileName );
      /*!
       *  Standard destructor.
       */
                   ~ScatterPlotter();
      //void       PerformAnalysis();

    protected:
      virtual void Execute();
      virtual void PrintResult() const;
      virtual void PrintSteeringParameters() const;
      virtual void UpdateModel();

    private:
      bool         _xLogScale;

  };

}

#endif // FITTINO_SCATTERPLOTTER_H
