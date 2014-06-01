/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsNeutralHiggsCrossSection.h                              *
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

#ifndef FITTINO_FEYNHIGGSNEUTRALHIGGSCROSSSECTION_H
#define FITTINO_FEYNHIGGSNEUTRALHIGGSCROSSSECTION_H

#include "CalculatorBase.h"
#include "FeynHiggsTypes.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    /*!
     *  \ingroup calculators
     *  \brief Wrapper class for FeynHiggs
     */
    class FeynHiggsNeutralHiggsCrossSection : public CalculatorBase {

    public:
        FeynHiggsNeutralHiggsCrossSection( FHRealType* prodxs, int higgs, std::string sqrts);
        ~FeynHiggsNeutralHiggsCrossSection();
        void CalculatePredictions();

    private:

        FHRealType* prodxs; // name required by FeynHiggs
        int _higgs;
        std::string _quantityname;

        double _bbh;
        double _btagbh;
        double _ggh;
        double _ggh2;
        double _qqh;
        double _tth;
        double _Wh;
        double _Zh;
        double _StSth;

        double _bbhSM;
        double _btagbhSM;
        double _gghSM;
        double _qqhSM;
        double _tthSM;
        double _WhSM;
        double _ZhSM;

        double _bbhNormSM;
        double _btagbhNormSM;
        double _gghNormSM;
        double _ggh2NormSM;
        double _qqhNormSM;
        double _tthNormSM;
        double _WhNormSM;
        double _ZhNormSM;

        double _singleh;
        double _singlehSM;
        double _singlehNormSM;
        double _singleh2;
        double _singleh2NormSM;

        void AddChannel( std::string name, const double& value, const double& valueSM, const double& ratio );

    };
}

#endif
