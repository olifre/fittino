/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AbsoluteUncertainty.h                                            *
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

#ifndef FITTINO_ABSOLUTEUNCERTAINTY_H
#define FITTINO_ABSOLUTEUNCERTAINTY_H

#include "UncertaintyBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

/*!
 *  \ingroup calculators
 *  \brief .
 */

    class AbsoluteUncertainty : public UncertaintyBase {

    public:
        AbsoluteUncertainty(ModelBase const *model, const Measurement *measurement, const boost::property_tree::ptree &ptree);
        ~AbsoluteUncertainty();

        void Update();

    private:

        double _valueMinus;
        double _valuePlus;

    };

}
#endif
