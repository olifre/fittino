/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsFermionicChannel                                        *
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

#ifndef FITTINO_FEYNHIGGSFERMIONICCHANNEL_H
#define FITTINO_FEYNHIGGSFERMIONICCHANNEL_H

#include "FeynHiggsChannel.h"
#include "FeynHiggsTypes.h"
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */

namespace Fittino {

    class SimplePrediction;
    /*!
     *  \ingroup calculators
     *  \brief Wrapper class for FeynHiggs.
     */
    class FeynHiggsFermionicChannel : public FeynHiggsChannel {

    public:
        /*!
         *  Standard constructor.
         */
        FeynHiggsFermionicChannel( FHRealType* gammas, FHRealType* gammasms, FHComplexType* couplings, FHComplexType* couplingsms, std::string higgsName, std::string channelName, int channelNumber, bool SM );
        /*!
         *  Standard destructor.
         */
        virtual ~FeynHiggsFermionicChannel();

        void CalculatePredictions();
        /*! \cond UML */
    private:

        double _model_gs2;
        double _model_gp2;
        double _model_gsPhi;
        double _model_gpPhi;

        double _sm_gs2;
        double _sm_gp2;
        double _sm_gsPhi;
        double _sm_gpPhi;

        double _normSM_gs2;
        double _normSM_gp2;
        double _normSM_Norm_gs;
        double _normSM_Norm_gp;
        double _normSM_gsPhi;
        double _normSM_gpPhi;

        /*! \endcond UML */
        
    };
    
}

#endif
