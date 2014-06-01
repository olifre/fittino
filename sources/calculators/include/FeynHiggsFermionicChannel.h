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

        double _model_gs_Abs;
        double _model_gp_Abs;
        double _model_gs_Arg;
        double _model_gp_Arg;

        double _sm_gs_Abs;
        double _sm_gp_Abs;
        double _sm_gs_Arg;
        double _sm_gp_Arg;

        double _normSM_gs_Abs;
        double _normSM_gp_Abs;
        double _normSM_g_Abs;
        double _normSM_g_Abs2;

        /*! \endcond UML */
        
    };
    
}

#endif
