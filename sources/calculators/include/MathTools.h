/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MathTools.h                                                      *
*                                                                              *
* Description Collection of useful math functions                              *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*    	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MATHTOOLS_H
#define FITTINO_MATHTOOLS_H

#include <vector>


class THnSparse;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  namespace MathTools {
 
    double InterpolateND( THnSparse*, std::vector<double> );
 
  }

}
#endif // FITTINO_MATHTOOLS_H
