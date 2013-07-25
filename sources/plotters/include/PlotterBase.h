/* $Id: PlotterBase.h 1309 2013-04-11 17:26:34Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PlotterBase.h                                                    *
*                                                                              *
* Description Base class for plotting                                          *
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

#include "TCanvas.h"
#include "TLegend.h"
#include "TPad.h"

#include "AnalysisTool.h"

class TTree;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;
  class Quantity;

  /*!
   *  \ingroup plotters
   *  \brief Base class for plotting.
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
      std::string               _dataFileName;
      std::map<std::string,int> _leafMap;
      std::vector<float>        _leafVector;
      std::vector<std::string>  _activeQuantityVector;
      TCanvas                   _canvas;
      TFile*                    _dataFile;
      TLegend                   _legend;
      TPad*                     _pad;
      TTree*                    _tree;
      std::vector<Quantity*>    _quantityVector;

    protected:
      virtual void              PrintResult() const;
      virtual void              PrintSteeringParameters() const;
      virtual void              UpdateModel();

  };

}

#endif // FITTINO_PLOTTERBASE_H
