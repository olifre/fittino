/***************************************************************************
                                    misc.h
                             -------------------    
    Miscellaneous definitions of general use.
                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : September 14, 2003
    authors              : Philip Bechtle, Peter Wienemann
    email                : philip.bechtle@desy.de, peter.wienemann@desy.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef FITTINO_MISC_H
#define FITTINO_MISC_H

#include <string>
#include <iostream>
//#include <stream.h>
#include <vector>
#include <map>
#include <utility>
#include <TVectorD.h>
#include <TMatrixD.h>
#include <TMatrixDSym.h>
#include <TH1.h>
#include<leshouches.h>
#include <math.h>
#include<sstream> 


using namespace std;

#define sqr(x) ((x)*(x))


// Paricle IDs
#define ID_d      1
#define ID_u      2
#define ID_s      3
#define ID_c      4
#define ID_b      5
#define ID_t      6

#define ID_e     11
#define ID_nue   12
#define ID_mu    13
#define ID_numu  14
#define ID_tau   15
#define ID_nutau 16

#define ID_g     21
#define ID_gamma 22
#define ID_Z     23
#define ID_W     24

// for NMSSM
#define ID_H1    25
#define ID_H2    35
#define ID_H3    45
#define ID_A1    36
#define ID_A2    46
// else
#define ID_h     25
#define ID_H     35
#define ID_A     36
#define ID_Hplus 37
#define ID_G     39

#define ID_sdL     1000001
#define ID_suL     1000002
#define ID_ssL     1000003
#define ID_scL     1000004
#define ID_sb1     1000005
#define ID_st1     1000006

#define ID_seL     1000011
#define ID_snueL   1000012
#define ID_smuL    1000013
#define ID_snumuL  1000014
#define ID_stau1   1000015
#define ID_snutauL 1000016

#define ID_sdR     2000001
#define ID_suR     2000002
#define ID_ssR     2000003
#define ID_scR     2000004
#define ID_sb2     2000005
#define ID_st2     2000006
		   
#define ID_seR     2000011
#define ID_snueR   2000012
#define ID_smuR    2000013
#define ID_snumuR  2000014
#define ID_stau2   2000015
#define ID_snutauR 2000016

#define ID_gluino  1000021
#define ID_chi01   1000022
#define ID_chi02   1000023
#define ID_chip1   1000024
#define ID_chi03   1000025
#define ID_chi04   1000035
#define ID_chi05   1000045 // for NMSSM
#define ID_chip2   1000037
#define ID_gravitino   1000039


enum SwitchState    { off, on };
enum Calculator     { SPHENO, SUSPECT, SPHENO_FH, SOFTSUSY };
enum HiggsCalculator { NOHIGGSCALCULATOR, FEYNHIGGS, HBSLHAINPUTBLOCKSFROMFH };
enum HiggsBRCalculator { NOHIGGSBRCALCULATOR, HDECAY };
enum FlavourCalculator { NOFLAVOURCALCULATOR, SUPERISO };
enum DecayCalculator		{ SUSYHIT, NONE};
enum RelicDensityCalculator { NORELICDENSITYCALCULATOR, MICROMEGAS };
enum LEOCalculator  { NOLEOCALCULATOR, NPFITTER };
enum ObservableType { mass, Pwidth, xsection, br, xsectionbr, Pedge, xsbr, brratio, brsum, LEObs, brprod, tauFromStau1Polarisation, tauFromNeutralino2Polarisation, SMPrecision, other, weighted, LHCRate, FineTuningParameter };
//   LEObservables  { bsg,                                           gmin2,          drho, omega };
enum LHCRatetypes { fully_inclusive, os_sf, four_b, /* <- old sRates signals */
                    Atlas4jMET0l7TeV, Atlas3jMET1l7TeV /* <- new LHC-FASER signals */ };
enum LEObservables  { bsg, bsmm, B_smm, B_utn, dMB_d, dMB_s, gmin2e, gmin2m, gmin2t, drho, omega, Bsg_npf, dm_s_npf, B_smm_npf, Btn_npf, B_sXsll_npf, Klnu_npf, gmin2m_npf, MassW_npf, sin_th_eff_npf, GammaZ_npf, R_l_npf, R_b_npf, R_c_npf, A_fbb_npf, A_fbc_npf, A_b_npf, A_c_npf, A_l_npf, Massh0_npf, MassH0_npf, MassA0_npf, MassHpm_npf, Omega_npf, A_tau_npf, A_fbl_npf, sigma_had0_npf, dm_d_npf, dm_k_npf, Kppinn_npf, B_dll_npf, DmsDmd_npf, D_0_npf, bsg_npf};
enum SMPrecisionObservables { alphas, alphaem, gf };
enum FitModel       { MSSM, mSUGRA, GMSB, AMSB, NMSSM, XMSUGRA, NONUNIVSIMPLIFIED, NUHM1, NUHM2 };
enum higgsLimitProcesses 
  { Zh_Zbb, 
    Zh_Ztt,
    Zh_ZAA_Zbbbb,
    Zh_ZAA_Ztttt,
    Ah_bbbb,
    Ah_bbtt,
    Ah_ttbb,
    Ah_tttt,
    Ah_AAA_bbbbbb,
    Ah_AAA_tttttt,
    higgsLimitProcessesLast
  };

extern bool         yyUseLoopCorrections;
extern bool         yyUseNLO;
extern bool         yyCalcPullDist;
extern bool         yyScanParameters;
extern unsigned int yyCalculator;
extern unsigned int yyHiggsCalculator;
extern unsigned int yyFlavourCalculator;
extern unsigned int yyDecayCalculator;
extern unsigned int yyRelicDensityCalculator;
extern unsigned int yyLEOCalculator;
extern map<int,string> yyParticleNames;
extern map<string,int> yyParticleIDs;

extern vector<doubleVec_t> CrossSectionProduction;

struct MeasuredValue {
  double          value;
  double          error;  // total error (added in quadrature)
  double          staterr; // statistical error
  map<string, double> correrror;
  int             position;
  double          theovalue;
  bool            theoset;
  bool            first;
  bool            hasbeenset;
  operator        double() const { return value; }
  string          name;
  int             id;
  bool            bound;
  double          bound_low;
  double          bound_up;
  ObservableType  type;
  int             alias;
  vector<int>     daughters;
  vector<int>     products;
  double          sqrts;
  double          polarisation1;
  double          polarisation2;
  bool            nofit;
  double          positive_error;
  double          negative_error;
  string          universality;
  string          calculator;
  bool            temp_nofit;
  double          scaling;
  bool            setScaling;
};

struct ScanParameter {
  string          name;
  double          min;
  double          max;
  unsigned int    numberOfSteps;
};

struct InputFileLine {
  string          prevalue;
  string          postvalue;
  double          value;
  vector<double>  error;
};

extern MeasuredValue fitterM1;
extern MeasuredValue fitterM2;
extern MeasuredValue fitterAbsM3;
extern MeasuredValue fitterMassA0;
extern MeasuredValue fitterTanBeta;
extern MeasuredValue fitterMu;
extern MeasuredValue fitterMassSelR;
extern MeasuredValue fitterMassSelL;
extern MeasuredValue fitterMassSupR;
extern MeasuredValue fitterMassSupL;
extern MeasuredValue fitterA;
extern MeasuredValue fitterMassTop;

// observables received from suspect:
extern double        sRecMassChargino1;
extern double        sRecMassChargino2;
extern double        sRecMassNeutralino1;
extern double        sRecMassNeutralino2;
extern double        sRecMassNeutralino3;
extern double        sRecMassNeutralino4;
extern double        sRecMassGluino;
extern double        sRecMassh0;
extern double        sRecMassH0;
extern double        sRecMassA0;
extern double        sRecMassHpm;
extern double        sRecMassSelR;
extern double        sRecMassSelL;
extern double        sRecMassSupR;
extern double        sRecMassSupL;
extern double        sRecCos2PhiL;
extern double        sRecCos2PhiR;
extern double        sRecMassTop;

class TagMap : public map<string, vector<MeasuredValue*> > {
   private:
      vector<MeasuredValue>* fMeasuredVector;
   public:
      TagMap(vector<MeasuredValue>* measuredvector);
      void Print();
};

class CorrelationMatrix {
   protected:
      const vector<MeasuredValue>* fMeasuredVector;
      TagMap*                      fTagMap;
      TMatrixDSym*                 fInverseCovarianceMatrix;
      TMatrixDSym*                 fCorrelationMatrix;
      TMatrixDSym*                 fCovarianceMatrix;
   public:
      CorrelationMatrix(); 
      CorrelationMatrix(const vector<MeasuredValue>* measuredvector);
      CorrelationMatrix(const vector<MeasuredValue>* measuredvector, TagMap* tagmap);
      CorrelationMatrix(const CorrelationMatrix& another);

      virtual ~CorrelationMatrix();

      const double& operator()(int rown, int coln) const;
      CorrelationMatrix& operator=(const CorrelationMatrix& source);

      const TMatrixDSym& GetCovarianceMatrix() const;
      double GetCorrelation(const string& name1, const string& name2) const;
      double GetCorrelation(unsigned int index1, unsigned int index2) const;
      double GetCovariance(const string& name1, const string& name2) const;
      double GetCovariance(unsigned int index1, unsigned int index2) const;
      double GetInverseCovariance(const string& name1, const string& name2) const;
      double GetInverseCovariance(unsigned int index1, unsigned int index2) const;
      void add(const string& name1, const string& name2, double entry);
      void add(unsigned int index1, unsigned int index2, double entry);
      void AddCovariance(const string& name1, const string& name2, double entry);
      void AddCovariance(unsigned int index1, unsigned int index2, double entry);
      void Calculate();
      void CalculateCovarianceMatrix();
      void Print();
      void PrintCovariance();
      void PrintInverseCovariance();
      void AddFullCovarianceMatrix(const CorrelationMatrix& addedCovarianceMatrix);
      void TransformCovarianceMatrixIntoCorrelationMatrix();
      void CalculateInverseCovarianceMatrix();
      bool TestCovarianceMatrixExistence();
};

TVectorD getCorrelatedRandomNumbers(const TVectorD& mean, const TMatrixDSym& covarianceMatrix);

double BilinearInterpolator(double m0, double m12, int bin, std::map< std::pair<int,int>, TH1D*>& xs);


double
BicubicInterpolator( double x_value, // M_0, when used for Die Frage
		     double y_value, // M_1/2, when used for Die Frage
		     int requested_bin,
		     std::map< std::pair< int, int >, TH1F* >& data_grid );
/* this is an extension by Ben O'Leary (benjamin.oleary@gmail.com) to
 * BilinearInterpolator above to use a fit to cubic polynomials as an
 * interpolation on a grid of histograms.
 */

double
BOL_QuadraticInterpolate( double input_z,
			  // the distance along from origin_z to be
			  // interpolated.
			  // the lower-value co-ordinate & its value:
			  double left_z,
			  double left_value,
			  // the origin-value co-ordinate & its value:
			  double origin_z,
			  double origin_value,
			  // the higher-value co-ordinate & its value:
			  double right_z,
			  double right_value );
/* this is to aid BicubicInterpolate by fitting a quadratic function to the
 * given arguments in order & returning the interpolated value.
 * (Ben O'Leary (benjamin.oleary@gmail.com) to be blamed for this function.)
 * this will break if any 2 of { left_z, origin_z, right_z } or all 3 are
 * equal, but I should not ever have done that in BicubicInterpolate().
 */

double
BOL_CubicInterpolate( double input_z,
		      // the distance along from near_left_z to be interpolated.
		      // the lowest-value co-ordinate & its value:
		      double far_left_z,
		      double far_left_value,
		      // the 2nd-lowest-value co-ordinate & its value:
		      double near_left_z,
		      double near_left_value,
		      // the 2nd-highest-value co-ordinate & its value:
		      double near_right_z,
		      double near_right_value,
		      // the highest-value co-ordinate & its value:
		      double far_right_z,
		      double far_right_value );
/* this is to aid BicubicInterpolate by fitting a cubic function to the
 * given arguments in order & returning the interpolated value.
 * (Ben O'Leary (benjamin.oleary@gmail.com) to be blamed for this function.)
 * this will break if any 2 or more of
 * { far_left_z, near_left_z, near_right_z, far_right_z } are equal,
 * but I should not ever have done that in BicubicInterpolate().
 */


double LogLikelihoodRatio(const TH1D* hs, const TH1D* hb, const TH1D* hd, double relsigsys, double relbkgdsys, const char* option);

//BS: this function splits string s according to char delim and return the splitted parts as vector
vector<string> split(const string &s, char delim); 



#endif
