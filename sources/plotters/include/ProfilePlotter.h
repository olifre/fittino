/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ProfilePlotter.h                                                 *
*                                                                              *
* Description Class for plotting chi2 profile plots                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PROFILEPLOTTER_H
#define FITTINO_PROFILEPLOTTER_H

#include "PlotterBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup plotters
   *  \brief Class for plotting chi2 profile plots.
   */
  class ProfilePlotter : public PlotterBase {

    public:
      /*!
       *  Constructor documentation.
       */
      ProfilePlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ProfilePlotter();

      /*! \endcond UML */
    private:
      void Plot( unsigned int iHistogram );
      void PrintSteeringParameters() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_PROFILEPLOTTER_H
