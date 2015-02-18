/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AstroUncertainty.h                                               *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ASTROEXCLUSION_H
#define FITTINO_ASTROEXCLUSION_H

#include "UncertaintyBase.h"

class TGraph;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Quantity;

/*!
 *  \ingroup calculators
 *  \brief .
 */

    class AstroUncertainty : public UncertaintyBase {

    public:
        AstroUncertainty(ModelBase const *model, const Measurement *measurement, const boost::property_tree::ptree &ptree);
        ~AstroUncertainty();

        void Update();

    private:

        TGraph* _graph;
        double  _quantile;
        const Quantity* _mass;

    };

}
#endif