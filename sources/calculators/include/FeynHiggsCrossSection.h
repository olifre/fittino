/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsCrossSection.h                                          *
 *                                                                              *
 * Description Wrapper class for FeynHiggs                                      *
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#ifndef FITTINO_FEYNHIGGSCROSSSECTION_H
#define FITTINO_FEYNHIGGSCROSSSECTION_H

#include "CalculatorBase.h"
#include "FeynHiggsNeutralHiggsCrossSection.h"
#include "FeynHiggsTypes.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    /*!
     *  \ingroup calculators
     *  \brief Wrapper class for FeynHiggs
     */
    class FeynHiggsCrossSection : public CalculatorBase {

    public:

        FeynHiggsCrossSection( std::string sqrts );
        ~FeynHiggsCrossSection();

        void CalculatePredictions();

    private:

        int _error;

        double      _sqrts;
        FHRealType* prodxs; // name required by FH

        FeynHiggsNeutralHiggsCrossSection _h0;
        FeynHiggsNeutralHiggsCrossSection _H0;
        FeynHiggsNeutralHiggsCrossSection _A0;

        double _tHm;
        double _tHm2;
        double _tHm2lo;
        double _tHm2hi;
    };

}

#endif