/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsCalculatorBase.h                                        *
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

#ifndef FITTINO_FEYNHIGGSCALCULATORBASE_H
#define FITTINO_FEYNHIGGSCALCULATORBASE_H

#include "FeynHiggsTypes.h"
#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;
    class FeynHiggsChannel;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsCalculatorBase : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsCalculatorBase( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual ~FeynHiggsCalculatorBase();

      void CalculatePredictions();

    protected:
      int         _error;
      std::string _fileName;

      /*! \cond UML */

      double _mass_h;

  private:
      void AddChannel( std::string higgsName, std::string channelName, int channelNumber, bool SM );

      std::vector< FeynHiggsChannel* > _channels;
      FHRealType*    _gammas;
      FHRealType*    _gammasms;
      FHComplexType* _couplings;
      FHComplexType* _couplingsms;

      double _normSM_sigma_ggh;
      double _normSM_sigma_ggh_2;
      double _normSM_sigma_bbh;
      double _normSM_sigma_qqh;
      double _normSM_sigma_tth;
      double _normSM_sigma_Wh;
      double _normSM_sigma_Zh;

      virtual void ConfigureInput() = 0;
      virtual void WriteOutput() = 0;

      /*! \endcond UML */

  };


}

#endif
