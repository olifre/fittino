/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsChannel                                                 *
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

#ifndef FITTINO_FEYNHIGGSCHANNEL_H
#define FITTINO_FEYNHIGGSCHANNEL_H

#include "CalculatorBase.h"
#include "FeynHiggsTypes.h"

/*!
 *  \brief Fittino namespace.
 */

namespace Fittino {

    class SimplePrediction;
    /*!
     *  \ingroup calculators
     *  \brief Wrapper class for FeynHiggs.
     */
    class FeynHiggsChannel : public CalculatorBase {

    public:
        /*!
         *  Standard constructor.
         */
        FeynHiggsChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM );
        /*!
         *  Standard destructor.
         */
        virtual ~FeynHiggsChannel();

        virtual void CalculatePredictions();

    protected:
        int         _error;

        /*! \cond UML */
    protected:

        FHRealType*    gammas;           // FeynHiggs requires to use this name
        FHRealType*    gammasms;         // FeynHiggs requires to use this name
        FHComplexType* couplings;     // FeynHiggs requires to use this name
        FHComplexType* couplingsms;   // FeynHiggs requires to use this name

        int         _channel;
        bool        _doSM;
        std::string _higgsName;
        std::string _channelName;

    private:
        double _normSM_Gamma;
        double _model_Gamma;
        double _sm_Gamma;

        double _normSM_BR;
        double _model_BR;
        double _sm_BR;


        /*! \endcond UML */

};

}

#endif
