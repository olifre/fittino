
/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RelativeTheoryUncertainty.h                                      *
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

#ifndef FITTINO_RELATIVETHEORYUNCERTAINTY_H
#define FITTINO_RELATIVETHEORYUNCERTAINTY_H

#include "UncertaintyBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

/*!
 *  \ingroup calculators
 *  \brief .
 */

    class RelativeTheoryUncertainty : public UncertaintyBase {

    public:
        RelativeTheoryUncertainty(ModelBase const *model, const Measurement *measurement, const boost::property_tree::ptree &ptree);
        ~RelativeTheoryUncertainty();

        void Update();

    private:

        double _relativeValue;

    };

}
#endif