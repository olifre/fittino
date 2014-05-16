/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimplePlotter.h                                                  *
*                                                                              *
* Description Class for plotting simple quantity distributions                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLEPLOTTER_H
#define FITTINO_SIMPLEPLOTTER_H

#include "PlotterBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup plotters
   *  \brief Class for plotting simple quantity distributions.
   */
  class SimplePlotter : public PlotterBase {

    public:
      /*!
       *  Standard constructor.
       */
      SimplePlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SimplePlotter();

      /*! \endcond UML */
    private:
      void Plot( unsigned int iHistogram );
      void PrintSteeringParameters() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_SIMPLEPLOTTER_H
