/* $Id: ScatterPlotter.h 1309 2013-04-11 17:26:34Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ScatterPlotter.h                                                 *
*                                                                              *
* Description Class plotting 2D scatter plots                                  *
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

class TTree;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup kernel
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
      //void         PerformAnalysis();

    protected:
      virtual void Execute();
      virtual void PrintResult() const;
      virtual void PrintSteeringParameters() const;
      virtual void UpdateModel();

  };

}

#endif // FITTINO_SCATTERPLOTTER_H
