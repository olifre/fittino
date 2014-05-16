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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PLOTTERBASE_H
#define FITTINO_PLOTTERBASE_H

#include <string>
#include <vector>

#include "PtreeForwardDeclaration.h"

class TCanvas;
class TH1;
class TPad;
class TStyle;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Base class for plotters.
   */
  class PlotterBase {

    public:
      /*!
       *  Constructor documentation.
       */
      PlotterBase( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~PlotterBase();
      void               MakePlots();

    protected:
      double             _textSize;
      int                _textFont;
      std::string        _format;
      std::string        _name;
      std::string        _version;
      TCanvas*           _canvas;
      TPad*              _pad;
      TStyle*            _fittinoStyle;
      std::vector<TH1*>& _histogramVector;

    protected:
      void               PrintSteeringParameters() const;

      /*! \endcond UML */
    private:
      virtual void       Plot( unsigned int iHistogram ) = 0;

      /*! \endcond UML */

  };

}

#endif // FITTINO_PLOTTERBASE_H
