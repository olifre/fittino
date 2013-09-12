/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PlotterBase.h                                                    *
*                                                                              *
* Description Base class for plotters                                          *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PLOTTERBASE_H
#define FITTINO_PLOTTERBASE_H

#include <map>
#include <string>

#include "AnalysisTool.h"

class TCanvas;
class TPad;
class TStyle;
class TTree;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;
  class Quantity;

  /*!
   *  \defgroup plotters
   */
  /*!
   *  \ingroup plotters
   *  \brief Base class for plotters.
   */
  class PlotterBase : public AnalysisTool {

    public:
      /*!
       *  Constructor documentation.
       */
                                 PlotterBase( ModelBase* model, std::string& dataFileName );
      /*!
       *  Standard destructor.
       */
                                 ~PlotterBase();

    protected:
      std::string                _dataFileName;
      std::map<std::string, int> _leafMap;
      std::vector<float>         _leafVector;
      std::vector<std::string>   _activeQuantityVector;
      TCanvas*                   _canvas;
      TFile*                     _dataFile;
      TPad*                      _pad;
      TStyle*                    _fittinoStyle;
      TTree*                     _tree;
      std::vector<Quantity*>     _quantityVector;

    protected:
      virtual void               PrintResult() const;
      virtual void               PrintSteeringParameters() const;
      virtual void               UpdateModel();

  };

}

#endif // FITTINO_PLOTTERBASE_H
