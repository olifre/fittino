/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ContourPlotter.h                                                 *
*                                                                              *
* Description Class plotting 2D contour plots                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CONTOURPLOTTER_H
#define FITTINO_CONTOURPLOTTER_H

#include "PlotterBase.h"

class TTree;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup plotters
   *  \brief Class for plotting 2D contour plots.
   */
  class ContourPlotter : public PlotterBase {

    public:
      /*!
       *  Constructor documentation.
       */
                   ContourPlotter( ModelBase* model, std::string& dataFileName );
      /*!
       *  Standard destructor.
       */
                   ~ContourPlotter();
      //void         PerformAnalysis();

    protected:
      virtual void Execute();
      virtual void PrintResult() const;
      virtual void PrintSteeringParameters() const;
      virtual void UpdateModel();

    private:  
      bool         _logX;
      bool         _logY;
  };

}

#endif // FITTINO_CONTOURPLOTTER_H
