/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsTypes                                                   *
 *                                                                              *
 * Description This file contains typedefs consistent with CFeynHiggs.h.        *
 *             Using it allows to use these types without including             *
 *             CFeynHiggs.h. This is sometimes needed because CFeynHiggs.h      *
 *             contains preprocessor directives which easily lead to conflicts. * 
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include<complex>

#if QUAD  

typedef long double FHRealType;

#else

typedef double FHRealType;

#endif

typedef std::complex<FHRealType> FHComplexType;
