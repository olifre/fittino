/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsCalculator.h                                        *
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

#ifndef FITTINO_FEYNHIGGSCALCULATOR_H
#define FITTINO_FEYNHIGGSCALCULATOR_H

#include "FeynHiggsTypes.h"
#include "CalculatorBase.h"
#include "Collection.h"
#include "PtreeForwardDeclaration.h"
#include "FeynHiggsCrossSection.h"


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;
    class FeynHiggsChannel;
    class SLHADataStorageBase;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree, std::string inputMethod );
      /*!
       *  Standard destructor.
       */
      virtual ~FeynHiggsCalculator();

      void CalculatePredictions();

    protected:
      int         _error;
      std::string _fileName;

      /*! \cond UML */

      double _mass_h0;
      double _mass_H0;
      double _mass_A0;
      double _mass_Hp;

      double _GammaTotal_h0;
      double _GammaTotal_H0;
      double _GammaTotal_A0;
      double _GammaTotal_Hp;

      double _NormSM_GammaTotal_h0;
      double _NormSM_GammaTotal_H0;
      double _NormSM_GammaTotal_A0;
      
      double _SM_GammaTotal_h0;
      double _SM_GammaTotal_H0;
      double _SM_GammaTotal_A0;

      double _Norm_CrossSection_LEP_Hp_Hm;
      double _Mass_Z0;
      double _GF;

      double _Norm_g_Abs2_h0_h0_Z0;
      double _Norm_g_Abs2_h0_H0_Z0;
      double _Norm_g_Abs2_h0_A0_Z0;

      double _Norm_g_Abs2_H0_h0_Z0;
      double _Norm_g_Abs2_H0_H0_Z0;
      double _Norm_g_Abs2_H0_A0_Z0;

      double _Norm_g_Abs2_A0_h0_Z0;
      double _Norm_g_Abs2_A0_H0_Z0;
      double _Norm_g_Abs2_A0_A0_Z0;

  private:
      void AddChannel( std::string higgsName, std::string channelName, int channelNumber, bool fermionic, bool SM );
      void AddChannels_H0SfSf  ( int iHiggs, std::string higgsName, unsigned int type, std::string* names );
      void AddChannels_HpSfSf  ( unsigned int type, std::string* names1, std::string* names2 );
      void AddChannels_HpFF    ( unsigned int type, std::string* names1, std::string* names2 );
      void AddChannels_H0FF    ( unsigned int iHiggs, std::string higgsName, unsigned type, std::string* names );
      void AddChannels_H0HH    ( unsigned int iHiggs, std::string higgsName );
      void AddChannels_H0VV    ( unsigned int iHiggs, std::string higgsName );
      void AddChannels_H0HV    ( unsigned int iHiggs, std::string higgsName );
      void AddChannels_H0NeuNeu( unsigned int iHiggs, std::string higgsName );
      void AddChannels_H0ChaCha( unsigned int iHiggs, std::string higgsName );
      void AddChannels_HpHV();
      void AddChannels_HpNeuCha();

      std::vector< FeynHiggsChannel* > _channels;
      FHRealType*    gammas; // name required by FH
      FHRealType*    gammasms; // name required by FH
      FHComplexType* _couplings;
      FHComplexType* _couplingsms;

      std::string _inputMethod;

      // FH flavor
      double _bsgammaMSSM;
      double _bsgammaSM;
      double _deltaMsMSSM;
      double _deltaMsSM;
      double _bsmumuMSSM;
      double _bsmumuSM;

      // FH constraints
      double _ccb;
      double _gm2;
      double _Deltarho;
      double _MWMSSM;
      double _MWSM;
      double _SW2MSSM;
      double _SW2SM;
      double _edmeTh;
      double _edmn;
      double _edmHg;

      // FH get para

      double _Abs_Delta_b;
      double _Arg_Delta_b;
      double _SAtree;

      // FH HiggsCorr

      double _Abs_sinAlpha;
      double _Arg_sinAlpha;
      
      std::string _higgs [5];
      std::string _nu    [4];
      std::string _lepton[4];
      std::string _up    [4];
      std::string _down  [4];
      std::string _neu   [5];
      std::string _cha   [3];

      Collection<SimplePrediction*> _input;

      SLHADataStorageBase* _slhadatastorageSPheno;
      SLHADataStorageBase* _slhadatastorageFeynHiggs;

      bool _smallObsSet;

      double _warning_ZHiggs;
      double _warning_ExtParQ;
      double _warning_gmin2;
      double _warning_Ab;
      double _warning_other;

      std::vector<FeynHiggsCrossSection*> _crossSections;


      /*! \endcond UML */

  };


}

#endif
