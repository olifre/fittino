! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Glu_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Glu_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Glu(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,             & 
& MSe2OS,MhhOS,Mhh2OS,MAhOS,MAh2OS,MHpmOS,MHpm2OS,MChiOS,MChi2OS,MChaOS,MCha2OS,         & 
& MFeOS,MFe2OS,MFdOS,MFd2OS,MFuOS,MFu2OS,MGluOS,MGlu2OS,MVZOS,MVZ2OS,MVWmOS,             & 
& MVWm2OS,ZDOS,ZVOS,ZUOS,ZEOS,ZHOS,ZAOS,ZPOS,ZNOS,UMOS,UPOS,ZELOS,ZEROS,ZDLOS,           & 
& ZDROS,ZULOS,ZUROS,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,MVWm,               & 
& MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,ZUR,             & 
& ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,mq2,               & 
& ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,dg1,dg2,dg3,dMu,dBmu,dYd,dTd,dYe,             & 
& dTe,dL1,dT1,dL2,dT2,dYu,dTu,dmq2,dml2,dmHd2,dmHu2,dmd2,dmu2,dme2,dM1,dM2,              & 
& dM3,dvd,dvu,dpG,dZD,dZV,dZU,dZE,dZH,dZA,dZP,dZN,dUM,dUP,dZEL,dZER,dZDL,dZDR,           & 
& dZUL,dZUR,dSinTW,dCosTW,dTanTW,ZfVG,ZffG,ZfFvL,ZfVP,ZfVZ,ZfVWm,ZfSd,ZfSv,              & 
& ZfSu,ZfSe,Zfhh,ZfAh,ZfHpm,ZfL0,ZfLm,ZfLp,ZfFEL,ZfFER,ZfFDL,ZfFDR,ZfFUL,ZfFUR,          & 
& ZfVPVZ,ZfVZVP,cplAhSdcSd,cplAhSucSu,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdChiSdL,          & 
& cplcFdChiSdR,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,        & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFuFuAhL,       & 
& cplcFuFuAhR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplChaFucSdL,            & 
& cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,            & 
& cplGluFucSuR,cplGluGluVGL,cplGluGluVGR,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,              & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSecSu,cplSdcSucVWm,    & 
& cplSdSvcSd,cplSeSucSd,cplSucSdVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplVGVGVG,          & 
& ctcplGluFdcSdL,ctcplGluFdcSdR,ctcplGluFucSuL,ctcplGluFucSuR,ctcplGluGluVGL,            & 
& ctcplGluGluVGR,ZcplAhSdcSd,ZcplAhSucSu,ZcplcFdChiSdL,ZcplcFdChiSdR,ZcplcFdFdAhL,       & 
& ZcplcFdFdAhR,ZcplcFdFdhhL,ZcplcFdFdhhR,ZcplcFdFdSvL,ZcplcFdFdSvR,ZcplcFdFdVGL,         & 
& ZcplcFdFdVGR,ZcplcFdFdVPL,ZcplcFdFdVPR,ZcplcFdFdVZL,ZcplcFdFdVZR,ZcplcFdFvSdL,         & 
& ZcplcFdFvSdR,ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuChiSuL,ZcplcFuChiSuR,ZcplcFuFuAhL,     & 
& ZcplcFuFuAhR,ZcplcFuFuhhL,ZcplcFuFuhhR,ZcplcFuFuVGL,ZcplcFuFuVGR,ZcplcFuFuVPL,         & 
& ZcplcFuFuVPR,ZcplcFuFuVZL,ZcplcFuFuVZR,ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplChiFdcSdL,      & 
& ZcplChiFdcSdR,ZcplChiFucSuL,ZcplChiFucSuR,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplGluFdcSdL,     & 
& ZcplGluFdcSdR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplGluGluVGL,ZcplGluGluVGR,ZcplhhSdcSd,     & 
& ZcplhhSucSu,ZcplSdcSdVG,ZcplSdcSdVP,ZcplSdcSdVZ,ZcplSdSvcSd,ZcplSucSuVG,               & 
& ZcplSucSuVP,ZcplSucSuVZ,ZcplVGVGVG,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,          & 
& ZRUZN,ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,em,gs,             & 
& deltaM,kont,gP1LGlu)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Real(dp),Intent(in) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp),Intent(in) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

Real(dp),Intent(in) :: dg1,dg2,dg3,dmHd2,dmHu2,dvd,dvu,dZH(2,2),dZA(2,2),dZP(2,2),dSinTW,dCosTW,dTanTW

Complex(dp),Intent(in) :: dMu,dBmu,dYd(3,3),dTd(3,3),dYe(3,3),dTe(3,3),dL1(3,3,3),dT1(3,3,3),dL2(3,3,3),        & 
& dT2(3,3,3),dYu(3,3),dTu(3,3),dmq2(3,3),dml2(3,3),dmd2(3,3),dmu2(3,3),dme2(3,3),        & 
& dM1,dM2,dM3,dpG,dZD(6,6),dZV(3,3),dZU(6,6),dZE(6,6),dZN(4,4),dUM(2,2),dUP(2,2),        & 
& dZEL(3,3),dZER(3,3),dZDL(3,3),dZDR(3,3),dZUL(3,3),dZUR(3,3)

Complex(dp),Intent(in) :: cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),        & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),         & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),               & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFuHpmL(3,3,2),& 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),           & 
& cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuChiSuL(3,4,6),         & 
& cplcFuChiSuR(3,4,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),     & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcFuFuAhL(3,3,2),          & 
& cplcFuFuAhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),             & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),  & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),       & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),           & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),               & 
& cplGluGluVGL,cplGluGluVGR,cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),      & 
& cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),& 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSdSvcSd(6,3,6),cplSeSucSd(6,6,6),              & 
& cplSucSdVWm(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplVGVGVG,            & 
& ctcplGluFdcSdL(3,6),ctcplGluFdcSdR(3,6),ctcplGluFucSuL(3,6),ctcplGluFucSuR(3,6),       & 
& ctcplGluGluVGL,ctcplGluGluVGR,ZcplAhSdcSd(2,6,6),ZcplAhSucSu(2,6,6),ZcplcFdChiSdL(3,4,6),& 
& ZcplcFdChiSdR(3,4,6),ZcplcFdFdAhL(3,3,2),ZcplcFdFdAhR(3,3,2),ZcplcFdFdhhL(3,3,2),      & 
& ZcplcFdFdhhR(3,3,2),ZcplcFdFdSvL(3,3,3),ZcplcFdFdSvR(3,3,3),ZcplcFdFdVGL(3,3),         & 
& ZcplcFdFdVGR(3,3),ZcplcFdFdVPL(3,3),ZcplcFdFdVPR(3,3),ZcplcFdFdVZL(3,3),               & 
& ZcplcFdFdVZR(3,3),ZcplcFdFvSdL(3,3,6),ZcplcFdFvSdR(3,3,6),ZcplcFdGluSdL(3,6),          & 
& ZcplcFdGluSdR(3,6),ZcplcFuChiSuL(3,4,6),ZcplcFuChiSuR(3,4,6),ZcplcFuFuAhL(3,3,2),      & 
& ZcplcFuFuAhR(3,3,2),ZcplcFuFuhhL(3,3,2),ZcplcFuFuhhR(3,3,2),ZcplcFuFuVGL(3,3),         & 
& ZcplcFuFuVGR(3,3),ZcplcFuFuVPL(3,3),ZcplcFuFuVPR(3,3),ZcplcFuFuVZL(3,3),               & 
& ZcplcFuFuVZR(3,3),ZcplcFuGluSuL(3,6),ZcplcFuGluSuR(3,6),ZcplChiFdcSdL(4,3,6),          & 
& ZcplChiFdcSdR(4,3,6),ZcplChiFucSuL(4,3,6),ZcplChiFucSuR(4,3,6),ZcplFvFdcSdL(3,3,6),    & 
& ZcplFvFdcSdR(3,3,6),ZcplGluFdcSdL(3,6),ZcplGluFdcSdR(3,6),ZcplGluFucSuL(3,6),          & 
& ZcplGluFucSuR(3,6),ZcplGluGluVGL,ZcplGluGluVGR,ZcplhhSdcSd(2,6,6),ZcplhhSucSu(2,6,6),  & 
& ZcplSdcSdVG(6,6),ZcplSdcSdVP(6,6),ZcplSdcSdVZ(6,6),ZcplSdSvcSd(6,3,6),ZcplSucSuVG(6,6),& 
& ZcplSucSuVP(6,6),ZcplSucSuVZ(6,6),ZcplVGVGVG

Real(dp), Intent(in) :: em, gs 
Complex(dp),Intent(in) :: ZfVG,ZffG,ZfFvL(3,3),ZfVP,ZfVZ,ZfVWm,ZfSd(6,6),ZfSv(3,3),ZfSu(6,6),ZfSe(6,6),         & 
& Zfhh(2,2),ZfAh(2,2),ZfHpm(2,2),ZfL0(4,4),ZfLm(2,2),ZfLp(2,2),ZfFEL(3,3),               & 
& ZfFER(3,3),ZfFDL(3,3),ZfFDR(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfVPVZ,ZfVZVP

Real(dp),Intent(in) :: MSdOS(6),MSd2OS(6),MSvOS(3),MSv2OS(3),MSuOS(6),MSu2OS(6),MSeOS(6),MSe2OS(6),          & 
& MhhOS(2),Mhh2OS(2),MAhOS(2),MAh2OS(2),MHpmOS(2),MHpm2OS(2),MChiOS(4),MChi2OS(4),       & 
& MChaOS(2),MCha2OS(2),MFeOS(3),MFe2OS(3),MFdOS(3),MFd2OS(3),MFuOS(3),MFu2OS(3),         & 
& MGluOS,MGlu2OS,MVZOS,MVZ2OS,MVWmOS,MVWm2OS,ZHOS(2,2),ZAOS(2,2),ZPOS(2,2)

Complex(dp),Intent(in) :: ZDOS(6,6),ZVOS(3,3),ZUOS(6,6),ZEOS(6,6),ZNOS(4,4),UMOS(2,2),UPOS(2,2),ZELOS(3,3),     & 
& ZEROS(3,3),ZDLOS(3,3),ZDROS(3,3),ZULOS(3,3),ZUROS(3,3)

Complex(dp),Intent(in) :: ZRUZD(6,6),ZRUZV(3,3),ZRUZU(6,6),ZRUZE(6,6),ZRUZH(2,2),ZRUZA(2,2),ZRUZP(2,2),         & 
& ZRUZN(4,4),ZRUUM(2,2),ZRUUP(2,2),ZRUZEL(3,3),ZRUZER(3,3),ZRUZDL(3,3),ZRUZDR(3,3),      & 
& ZRUZUL(3,3),ZRUZUR(3,3)

Real(dp), Intent(in) :: MLambda, deltaM 
Real(dp), Intent(out) :: gP1LGlu(1,52) 
Integer, Intent(out) :: kont 
Real(dp) :: MVG,MVP,MVG2,MVP2, helfactor, phasespacefactor 
Integer :: i1,i2,i3,i4, isave, gt1, gt2, gt3 

Complex(dp) :: ZRUZDc(6, 6) 
Complex(dp) :: ZRUZVc(3, 3) 
Complex(dp) :: ZRUZUc(6, 6) 
Complex(dp) :: ZRUZEc(6, 6) 
Complex(dp) :: ZRUZHc(2, 2) 
Complex(dp) :: ZRUZAc(2, 2) 
Complex(dp) :: ZRUZPc(2, 2) 
Complex(dp) :: ZRUZNc(4, 4) 
Complex(dp) :: ZRUUMc(2, 2) 
Complex(dp) :: ZRUUPc(2, 2) 
Complex(dp) :: ZRUZELc(3, 3) 
Complex(dp) :: ZRUZERc(3, 3) 
Complex(dp) :: ZRUZDLc(3, 3) 
Complex(dp) :: ZRUZDRc(3, 3) 
Complex(dp) :: ZRUZULc(3, 3) 
Complex(dp) :: ZRUZURc(3, 3) 
Real(dp) :: MRPGluToFdcSd(3,6),MRGGluToFdcSd(3,6), MRPZGluToFdcSd(3,6),MRGZGluToFdcSd(3,6) 
Real(dp) :: MVPGluToFdcSd(3,6) 
Real(dp) :: RMsqTreeGluToFdcSd(3,6),RMsqWaveGluToFdcSd(3,6),RMsqVertexGluToFdcSd(3,6) 
Complex(dp) :: AmpTreeGluToFdcSd(2,3,6),AmpWaveGluToFdcSd(2,3,6),AmpVertexGluToFdcSd(2,3,6)& 
 & ,AmpVertexIRosGluToFdcSd(2,3,6),AmpVertexIRdrGluToFdcSd(2,3,6), AmpSumGluToFdcSd(2,3,6), AmpSum2GluToFdcSd(2,3,6) 
Complex(dp) :: AmpTreeZGluToFdcSd(2,3,6),AmpWaveZGluToFdcSd(2,3,6),AmpVertexZGluToFdcSd(2,3,6) 
Real(dp) :: AmpSqGluToFdcSd(3,6),  AmpSqTreeGluToFdcSd(3,6) 
Real(dp) :: MRPGluToFucSu(3,6),MRGGluToFucSu(3,6), MRPZGluToFucSu(3,6),MRGZGluToFucSu(3,6) 
Real(dp) :: MVPGluToFucSu(3,6) 
Real(dp) :: RMsqTreeGluToFucSu(3,6),RMsqWaveGluToFucSu(3,6),RMsqVertexGluToFucSu(3,6) 
Complex(dp) :: AmpTreeGluToFucSu(2,3,6),AmpWaveGluToFucSu(2,3,6),AmpVertexGluToFucSu(2,3,6)& 
 & ,AmpVertexIRosGluToFucSu(2,3,6),AmpVertexIRdrGluToFucSu(2,3,6), AmpSumGluToFucSu(2,3,6), AmpSum2GluToFucSu(2,3,6) 
Complex(dp) :: AmpTreeZGluToFucSu(2,3,6),AmpWaveZGluToFucSu(2,3,6),AmpVertexZGluToFucSu(2,3,6) 
Real(dp) :: AmpSqGluToFucSu(3,6),  AmpSqTreeGluToFucSu(3,6) 
Real(dp) :: MRPGluToChiVG(4),MRGGluToChiVG(4), MRPZGluToChiVG(4),MRGZGluToChiVG(4) 
Real(dp) :: MVPGluToChiVG(4) 
Real(dp) :: RMsqTreeGluToChiVG(4),RMsqWaveGluToChiVG(4),RMsqVertexGluToChiVG(4) 
Complex(dp) :: AmpTreeGluToChiVG(4,4),AmpWaveGluToChiVG(4,4),AmpVertexGluToChiVG(4,4)& 
 & ,AmpVertexIRosGluToChiVG(4,4),AmpVertexIRdrGluToChiVG(4,4), AmpSumGluToChiVG(4,4), AmpSum2GluToChiVG(4,4) 
Complex(dp) :: AmpTreeZGluToChiVG(4,4),AmpWaveZGluToChiVG(4,4),AmpVertexZGluToChiVG(4,4) 
Real(dp) :: AmpSqGluToChiVG(4),  AmpSqTreeGluToChiVG(4) 
Real(dp) :: MRPGluToFvVG(3),MRGGluToFvVG(3), MRPZGluToFvVG(3),MRGZGluToFvVG(3) 
Real(dp) :: MVPGluToFvVG(3) 
Real(dp) :: RMsqTreeGluToFvVG(3),RMsqWaveGluToFvVG(3),RMsqVertexGluToFvVG(3) 
Complex(dp) :: AmpTreeGluToFvVG(4,3),AmpWaveGluToFvVG(4,3),AmpVertexGluToFvVG(4,3)& 
 & ,AmpVertexIRosGluToFvVG(4,3),AmpVertexIRdrGluToFvVG(4,3), AmpSumGluToFvVG(4,3), AmpSum2GluToFvVG(4,3) 
Complex(dp) :: AmpTreeZGluToFvVG(4,3),AmpWaveZGluToFvVG(4,3),AmpVertexZGluToFvVG(4,3) 
Real(dp) :: AmpSqGluToFvVG(3),  AmpSqTreeGluToFvVG(3) 
Real(dp) :: MRPGluToGluAh(2),MRGGluToGluAh(2), MRPZGluToGluAh(2),MRGZGluToGluAh(2) 
Real(dp) :: MVPGluToGluAh(2) 
Real(dp) :: RMsqTreeGluToGluAh(2),RMsqWaveGluToGluAh(2),RMsqVertexGluToGluAh(2) 
Complex(dp) :: AmpTreeGluToGluAh(2,2),AmpWaveGluToGluAh(2,2),AmpVertexGluToGluAh(2,2)& 
 & ,AmpVertexIRosGluToGluAh(2,2),AmpVertexIRdrGluToGluAh(2,2), AmpSumGluToGluAh(2,2), AmpSum2GluToGluAh(2,2) 
Complex(dp) :: AmpTreeZGluToGluAh(2,2),AmpWaveZGluToGluAh(2,2),AmpVertexZGluToGluAh(2,2) 
Real(dp) :: AmpSqGluToGluAh(2),  AmpSqTreeGluToGluAh(2) 
Real(dp) :: MRPGluToGluhh(2),MRGGluToGluhh(2), MRPZGluToGluhh(2),MRGZGluToGluhh(2) 
Real(dp) :: MVPGluToGluhh(2) 
Real(dp) :: RMsqTreeGluToGluhh(2),RMsqWaveGluToGluhh(2),RMsqVertexGluToGluhh(2) 
Complex(dp) :: AmpTreeGluToGluhh(2,2),AmpWaveGluToGluhh(2,2),AmpVertexGluToGluhh(2,2)& 
 & ,AmpVertexIRosGluToGluhh(2,2),AmpVertexIRdrGluToGluhh(2,2), AmpSumGluToGluhh(2,2), AmpSum2GluToGluhh(2,2) 
Complex(dp) :: AmpTreeZGluToGluhh(2,2),AmpWaveZGluToGluhh(2,2),AmpVertexZGluToGluhh(2,2) 
Real(dp) :: AmpSqGluToGluhh(2),  AmpSqTreeGluToGluhh(2) 
Real(dp) :: MRPGluToGluSv(3),MRGGluToGluSv(3), MRPZGluToGluSv(3),MRGZGluToGluSv(3) 
Real(dp) :: MVPGluToGluSv(3) 
Real(dp) :: RMsqTreeGluToGluSv(3),RMsqWaveGluToGluSv(3),RMsqVertexGluToGluSv(3) 
Complex(dp) :: AmpTreeGluToGluSv(2,3),AmpWaveGluToGluSv(2,3),AmpVertexGluToGluSv(2,3)& 
 & ,AmpVertexIRosGluToGluSv(2,3),AmpVertexIRdrGluToGluSv(2,3), AmpSumGluToGluSv(2,3), AmpSum2GluToGluSv(2,3) 
Complex(dp) :: AmpTreeZGluToGluSv(2,3),AmpWaveZGluToGluSv(2,3),AmpVertexZGluToGluSv(2,3) 
Real(dp) :: AmpSqGluToGluSv(3),  AmpSqTreeGluToGluSv(3) 
Real(dp) :: MRPGluToGluVG,MRGGluToGluVG, MRPZGluToGluVG,MRGZGluToGluVG 
Real(dp) :: MVPGluToGluVG 
Real(dp) :: RMsqTreeGluToGluVG,RMsqWaveGluToGluVG,RMsqVertexGluToGluVG 
Complex(dp) :: AmpTreeGluToGluVG(4),AmpWaveGluToGluVG(4),AmpVertexGluToGluVG(4)& 
 & ,AmpVertexIRosGluToGluVG(4),AmpVertexIRdrGluToGluVG(4), AmpSumGluToGluVG(4), AmpSum2GluToGluVG(4) 
Complex(dp) :: AmpTreeZGluToGluVG(4),AmpWaveZGluToGluVG(4),AmpVertexZGluToGluVG(4) 
Real(dp) :: AmpSqGluToGluVG,  AmpSqTreeGluToGluVG 
Real(dp) :: MRPGluToGluVP,MRGGluToGluVP, MRPZGluToGluVP,MRGZGluToGluVP 
Real(dp) :: MVPGluToGluVP 
Real(dp) :: RMsqTreeGluToGluVP,RMsqWaveGluToGluVP,RMsqVertexGluToGluVP 
Complex(dp) :: AmpTreeGluToGluVP(4),AmpWaveGluToGluVP(4),AmpVertexGluToGluVP(4)& 
 & ,AmpVertexIRosGluToGluVP(4),AmpVertexIRdrGluToGluVP(4), AmpSumGluToGluVP(4), AmpSum2GluToGluVP(4) 
Complex(dp) :: AmpTreeZGluToGluVP(4),AmpWaveZGluToGluVP(4),AmpVertexZGluToGluVP(4) 
Real(dp) :: AmpSqGluToGluVP,  AmpSqTreeGluToGluVP 
Real(dp) :: MRPGluToGluVZ,MRGGluToGluVZ, MRPZGluToGluVZ,MRGZGluToGluVZ 
Real(dp) :: MVPGluToGluVZ 
Real(dp) :: RMsqTreeGluToGluVZ,RMsqWaveGluToGluVZ,RMsqVertexGluToGluVZ 
Complex(dp) :: AmpTreeGluToGluVZ(4),AmpWaveGluToGluVZ(4),AmpVertexGluToGluVZ(4)& 
 & ,AmpVertexIRosGluToGluVZ(4),AmpVertexIRdrGluToGluVZ(4), AmpSumGluToGluVZ(4), AmpSum2GluToGluVZ(4) 
Complex(dp) :: AmpTreeZGluToGluVZ(4),AmpWaveZGluToGluVZ(4),AmpVertexZGluToGluVZ(4) 
Real(dp) :: AmpSqGluToGluVZ,  AmpSqTreeGluToGluVZ 
Write(*,*) "Calculating one-loop decays of Glu " 
kont = 0 
MVG = MLambda 
MVP = MLambda 
MVG2 = MLambda**2 
MVP2 = MLambda**2 

ZRUZDc = Conjg(ZRUZD)
ZRUZVc = Conjg(ZRUZV)
ZRUZUc = Conjg(ZRUZU)
ZRUZEc = Conjg(ZRUZE)
ZRUZHc = Conjg(ZRUZH)
ZRUZAc = Conjg(ZRUZA)
ZRUZPc = Conjg(ZRUZP)
ZRUZNc = Conjg(ZRUZN)
ZRUUMc = Conjg(ZRUUM)
ZRUUPc = Conjg(ZRUUP)
ZRUZELc = Conjg(ZRUZEL)
ZRUZERc = Conjg(ZRUZER)
ZRUZDLc = Conjg(ZRUZDL)
ZRUZDRc = Conjg(ZRUZDR)
ZRUZULc = Conjg(ZRUZUL)
ZRUZURc = Conjg(ZRUZUR)

 ! Counter 
isave = 1 

If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fd Conjg(Sd)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_GluToFdcSd(cplGluFdcSdL,cplGluFdcSdR,MFd,              & 
& MGlu,MSd,MFd2,MGlu2,MSd2,AmpTreeGluToFdcSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_GluToFdcSd(ZcplGluFdcSdL,ZcplGluFdcSdR,MFd,            & 
& MGlu,MSd,MFd2,MGlu2,MSd2,AmpTreeGluToFdcSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_GluToFdcSd(MLambda,em,gs,cplGluFdcSdL,cplGluFdcSdR,        & 
& MFdOS,MGluOS,MSdOS,MRPGluToFdcSd,MRGGluToFdcSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_GluToFdcSd(MLambda,em,gs,ZcplGluFdcSdL,ZcplGluFdcSdR,      & 
& MFdOS,MGluOS,MSdOS,MRPGluToFdcSd,MRGGluToFdcSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_GluToFdcSd(MLambda,em,gs,cplGluFdcSdL,cplGluFdcSdR,        & 
& MFd,MGlu,MSd,MRPGluToFdcSd,MRGGluToFdcSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_GluToFdcSd(MLambda,em,gs,ZcplGluFdcSdL,ZcplGluFdcSdR,      & 
& MFd,MGlu,MSd,MRPGluToFdcSd,MRGGluToFdcSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToFdcSd(cplGluFdcSdL,cplGluFdcSdR,ctcplGluFdcSdL,   & 
& ctcplGluFdcSdR,MFd,MFd2,MGlu,MGlu2,MSd,MSd2,ZfFDL,ZfFDR,ZffG,ZfSd,AmpWaveGluToFdcSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToFdcSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplFvFdcSdL,            & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplGluGluVGL,          & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,           & 
& cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,        & 
& cplSucSdVWm,AmpVertexGluToFdcSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,        & 
& cplSeSucSd,cplSucSdVWm,AmpVertexIRdrGluToFdcSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,      & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& ZcplGluFdcSdL,ZcplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,           & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplGluGluVGL,cplGluGluVGR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplHpmSucSd,            & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,        & 
& AmpVertexIRosGluToFdcSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplFvFdcSdL,cplFvFdcSdR,ZcplGluFdcSdL,ZcplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,        & 
& cplSeSucSd,cplSucSdVWm,AmpVertexIRosGluToFdcSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,      & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplGluGluVGL,cplGluGluVGR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplHpmSucSd,            & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,        & 
& AmpVertexIRosGluToFdcSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,        & 
& cplSeSucSd,cplSucSdVWm,AmpVertexIRosGluToFdcSd)

 End if 
 End if 
AmpVertexGluToFdcSd = AmpVertexGluToFdcSd -  AmpVertexIRdrGluToFdcSd! +  AmpVertexIRosGluToFdcSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Final State 1 
AmpWaveZGluToFdcSd=0._dp 
AmpVertexZGluToFdcSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZGluToFdcSd(1,gt2,:) = AmpWaveZGluToFdcSd(1,gt2,:)+ZRUZDL(gt2,gt1)*AmpWaveGluToFdcSd(1,gt1,:) 
AmpVertexZGluToFdcSd(1,gt2,:)= AmpVertexZGluToFdcSd(1,gt2,:)+ZRUZDL(gt2,gt1)*AmpVertexGluToFdcSd(1,gt1,:) 
AmpWaveZGluToFdcSd(2,gt2,:) = AmpWaveZGluToFdcSd(2,gt2,:)+ZRUZDRc(gt2,gt1)*AmpWaveGluToFdcSd(2,gt1,:) 
AmpVertexZGluToFdcSd(2,gt2,:)= AmpVertexZGluToFdcSd(2,gt2,:)+ZRUZDRc(gt2,gt1)*AmpVertexGluToFdcSd(2,gt1,:) 
 End Do 
End Do 
AmpWaveGluToFdcSd=AmpWaveZGluToFdcSd 
AmpVertexGluToFdcSd= AmpVertexZGluToFdcSd
! Final State 2 
AmpWaveZGluToFdcSd=0._dp 
AmpVertexZGluToFdcSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZGluToFdcSd(:,:,gt2) = AmpWaveZGluToFdcSd(:,:,gt2)+ZRUZDc(gt2,gt1)*AmpWaveGluToFdcSd(:,:,gt1) 
AmpVertexZGluToFdcSd(:,:,gt2)= AmpVertexZGluToFdcSd(:,:,gt2)+ZRUZDc(gt2,gt1)*AmpVertexGluToFdcSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveGluToFdcSd=AmpWaveZGluToFdcSd 
AmpVertexGluToFdcSd= AmpVertexZGluToFdcSd
End if
If (ShiftIRdiv) Then 
AmpVertexGluToFdcSd = AmpVertexGluToFdcSd  +  AmpVertexIRosGluToFdcSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Fd conj[Sd] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumGluToFdcSd = AmpTreeGluToFdcSd 
 AmpSum2GluToFdcSd = AmpTreeGluToFdcSd + 2._dp*AmpWaveGluToFdcSd + 2._dp*AmpVertexGluToFdcSd  
Else 
 AmpSumGluToFdcSd = AmpTreeGluToFdcSd + AmpWaveGluToFdcSd + AmpVertexGluToFdcSd
 AmpSum2GluToFdcSd = AmpTreeGluToFdcSd + AmpWaveGluToFdcSd + AmpVertexGluToFdcSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToFdcSd = AmpTreeGluToFdcSd
 AmpSum2GluToFdcSd = AmpTreeGluToFdcSd 
End if 
gt1=1 
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MGluOS.gt.(MFdOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MGlu.gt.(MFd(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt2, gt3 
  AmpSum2GluToFdcSd = AmpTreeGluToFdcSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFdOS(gt2),MSdOS(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFd(gt2),MSd(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqGluToFdcSd(gt2, gt3) 
  AmpSum2GluToFdcSd = 2._dp*AmpWaveGluToFdcSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFdOS(gt2),MSdOS(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFd(gt2),MSd(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqGluToFdcSd(gt2, gt3) 
  AmpSum2GluToFdcSd = 2._dp*AmpVertexGluToFdcSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFdOS(gt2),MSdOS(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFd(gt2),MSd(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqGluToFdcSd(gt2, gt3) 
  AmpSum2GluToFdcSd = AmpTreeGluToFdcSd + 2._dp*AmpWaveGluToFdcSd + 2._dp*AmpVertexGluToFdcSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFdOS(gt2),MSdOS(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFd(gt2),MSd(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqGluToFdcSd(gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2GluToFdcSd = AmpTreeGluToFdcSd
  Call SquareAmp_FtoFS(MGluOS,MFdOS(gt2),MSdOS(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
  AmpSqTreeGluToFdcSd(gt2, gt3) = (1._dp/2._dp)*AmpSqGluToFdcSd(gt2, gt3)  
  AmpSum2GluToFdcSd = + 2._dp*AmpWaveGluToFdcSd + 2._dp*AmpVertexGluToFdcSd
  Call SquareAmp_FtoFS(MGluOS,MFdOS(gt2),MSdOS(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
  AmpSqGluToFdcSd(gt2, gt3) = AmpSqGluToFdcSd(gt2, gt3) + AmpSqTreeGluToFdcSd(gt2, gt3)  
Else  
  AmpSum2GluToFdcSd = AmpTreeGluToFdcSd
  Call SquareAmp_FtoFS(MGlu,MFd(gt2),MSd(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
  AmpSqTreeGluToFdcSd(gt2, gt3) = (1._dp/2._dp)*AmpSqGluToFdcSd(gt2, gt3)  
  AmpSum2GluToFdcSd = + 2._dp*AmpWaveGluToFdcSd + 2._dp*AmpVertexGluToFdcSd
  Call SquareAmp_FtoFS(MGlu,MFd(gt2),MSd(gt3),AmpSumGluToFdcSd(:,gt2, gt3),AmpSum2GluToFdcSd(:,gt2, gt3),AmpSqGluToFdcSd(gt2, gt3)) 
  AmpSqGluToFdcSd(gt2, gt3) = AmpSqGluToFdcSd(gt2, gt3) + AmpSqTreeGluToFdcSd(gt2, gt3)  
End if  
Else  
  AmpSqGluToFdcSd(gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToFdcSd(gt2, gt3).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 2*GammaTPS(MGluOS,MFdOS(gt2),MSdOS(gt3),helfactor*AmpSqGluToFdcSd(gt2, gt3))
Else 
  gP1LGlu(gt1,i4) = 2*GammaTPS(MGlu,MFd(gt2),MSd(gt3),helfactor*AmpSqGluToFdcSd(gt2, gt3))
End if 
If ((Abs(MRPGluToFdcSd(gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToFdcSd(gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPGluToFdcSd(gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToFdcSd(gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPGluToFdcSd(gt2, gt3) + MRGGluToFdcSd(gt2, gt3)) 
  gP1LGlu(gt1,i4) = gP1LGlu(gt1,i4) + phasespacefactor*1*helfactor*(MRPGluToFdcSd(gt2, gt3) + MRGGluToFdcSd(gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LGlu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
isave = i4 
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fu Conjg(Su)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_GluToFucSu(cplGluFucSuL,cplGluFucSuR,MFu,              & 
& MGlu,MSu,MFu2,MGlu2,MSu2,AmpTreeGluToFucSu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_GluToFucSu(ZcplGluFucSuL,ZcplGluFucSuR,MFu,            & 
& MGlu,MSu,MFu2,MGlu2,MSu2,AmpTreeGluToFucSu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_GluToFucSu(MLambda,em,gs,cplGluFucSuL,cplGluFucSuR,        & 
& MFuOS,MGluOS,MSuOS,MRPGluToFucSu,MRGGluToFucSu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_GluToFucSu(MLambda,em,gs,ZcplGluFucSuL,ZcplGluFucSuR,      & 
& MFuOS,MGluOS,MSuOS,MRPGluToFucSu,MRGGluToFucSu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_GluToFucSu(MLambda,em,gs,cplGluFucSuL,cplGluFucSuR,        & 
& MFu,MGlu,MSu,MRPGluToFucSu,MRGGluToFucSu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_GluToFucSu(MLambda,em,gs,ZcplGluFucSuL,ZcplGluFucSuR,      & 
& MFu,MGlu,MSu,MRPGluToFucSu,MRGGluToFucSu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToFucSu(cplGluFucSuL,cplGluFucSuR,ctcplGluFucSuL,   & 
& ctcplGluFucSuR,MFu,MFu2,MGlu,MGlu2,MSu,MSu2,ZffG,ZfFUL,ZfFUR,ZfSu,AmpWaveGluToFucSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToFucSu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,     & 
& cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,cplGluFdcSdR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplSdcHpmcSu,           & 
& cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexGluToFucSu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRdrGluToFucSu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChaFucSdL,       & 
& cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,cplGluFdcSdR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,ZcplGluFucSuL,         & 
& ZcplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,           & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,           & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosGluToFucSu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,ZcplGluFucSuL,ZcplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosGluToFucSu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChaFucSdL,       & 
& cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,cplGluFdcSdR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,           & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosGluToFucSu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosGluToFucSu)

 End if 
 End if 
AmpVertexGluToFucSu = AmpVertexGluToFucSu -  AmpVertexIRdrGluToFucSu! +  AmpVertexIRosGluToFucSu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Final State 1 
AmpWaveZGluToFucSu=0._dp 
AmpVertexZGluToFucSu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZGluToFucSu(1,gt2,:) = AmpWaveZGluToFucSu(1,gt2,:)+ZRUZUL(gt2,gt1)*AmpWaveGluToFucSu(1,gt1,:) 
AmpVertexZGluToFucSu(1,gt2,:)= AmpVertexZGluToFucSu(1,gt2,:)+ZRUZUL(gt2,gt1)*AmpVertexGluToFucSu(1,gt1,:) 
AmpWaveZGluToFucSu(2,gt2,:) = AmpWaveZGluToFucSu(2,gt2,:)+ZRUZURc(gt2,gt1)*AmpWaveGluToFucSu(2,gt1,:) 
AmpVertexZGluToFucSu(2,gt2,:)= AmpVertexZGluToFucSu(2,gt2,:)+ZRUZURc(gt2,gt1)*AmpVertexGluToFucSu(2,gt1,:) 
 End Do 
End Do 
AmpWaveGluToFucSu=AmpWaveZGluToFucSu 
AmpVertexGluToFucSu= AmpVertexZGluToFucSu
! Final State 2 
AmpWaveZGluToFucSu=0._dp 
AmpVertexZGluToFucSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZGluToFucSu(:,:,gt2) = AmpWaveZGluToFucSu(:,:,gt2)+ZRUZUc(gt2,gt1)*AmpWaveGluToFucSu(:,:,gt1) 
AmpVertexZGluToFucSu(:,:,gt2)= AmpVertexZGluToFucSu(:,:,gt2)+ZRUZUc(gt2,gt1)*AmpVertexGluToFucSu(:,:,gt1) 
 End Do 
End Do 
AmpWaveGluToFucSu=AmpWaveZGluToFucSu 
AmpVertexGluToFucSu= AmpVertexZGluToFucSu
End if
If (ShiftIRdiv) Then 
AmpVertexGluToFucSu = AmpVertexGluToFucSu  +  AmpVertexIRosGluToFucSu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Fu conj[Su] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumGluToFucSu = AmpTreeGluToFucSu 
 AmpSum2GluToFucSu = AmpTreeGluToFucSu + 2._dp*AmpWaveGluToFucSu + 2._dp*AmpVertexGluToFucSu  
Else 
 AmpSumGluToFucSu = AmpTreeGluToFucSu + AmpWaveGluToFucSu + AmpVertexGluToFucSu
 AmpSum2GluToFucSu = AmpTreeGluToFucSu + AmpWaveGluToFucSu + AmpVertexGluToFucSu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToFucSu = AmpTreeGluToFucSu
 AmpSum2GluToFucSu = AmpTreeGluToFucSu 
End if 
gt1=1 
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MGluOS.gt.(MFuOS(gt2)+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MGlu.gt.(MFu(gt2)+MSu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt2, gt3 
  AmpSum2GluToFucSu = AmpTreeGluToFucSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFuOS(gt2),MSuOS(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFu(gt2),MSu(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqGluToFucSu(gt2, gt3) 
  AmpSum2GluToFucSu = 2._dp*AmpWaveGluToFucSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFuOS(gt2),MSuOS(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFu(gt2),MSu(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqGluToFucSu(gt2, gt3) 
  AmpSum2GluToFucSu = 2._dp*AmpVertexGluToFucSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFuOS(gt2),MSuOS(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFu(gt2),MSu(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqGluToFucSu(gt2, gt3) 
  AmpSum2GluToFucSu = AmpTreeGluToFucSu + 2._dp*AmpWaveGluToFucSu + 2._dp*AmpVertexGluToFucSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MFuOS(gt2),MSuOS(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MFu(gt2),MSu(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqGluToFucSu(gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2GluToFucSu = AmpTreeGluToFucSu
  Call SquareAmp_FtoFS(MGluOS,MFuOS(gt2),MSuOS(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
  AmpSqTreeGluToFucSu(gt2, gt3) = (1._dp/2._dp)*AmpSqGluToFucSu(gt2, gt3)  
  AmpSum2GluToFucSu = + 2._dp*AmpWaveGluToFucSu + 2._dp*AmpVertexGluToFucSu
  Call SquareAmp_FtoFS(MGluOS,MFuOS(gt2),MSuOS(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
  AmpSqGluToFucSu(gt2, gt3) = AmpSqGluToFucSu(gt2, gt3) + AmpSqTreeGluToFucSu(gt2, gt3)  
Else  
  AmpSum2GluToFucSu = AmpTreeGluToFucSu
  Call SquareAmp_FtoFS(MGlu,MFu(gt2),MSu(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
  AmpSqTreeGluToFucSu(gt2, gt3) = (1._dp/2._dp)*AmpSqGluToFucSu(gt2, gt3)  
  AmpSum2GluToFucSu = + 2._dp*AmpWaveGluToFucSu + 2._dp*AmpVertexGluToFucSu
  Call SquareAmp_FtoFS(MGlu,MFu(gt2),MSu(gt3),AmpSumGluToFucSu(:,gt2, gt3),AmpSum2GluToFucSu(:,gt2, gt3),AmpSqGluToFucSu(gt2, gt3)) 
  AmpSqGluToFucSu(gt2, gt3) = AmpSqGluToFucSu(gt2, gt3) + AmpSqTreeGluToFucSu(gt2, gt3)  
End if  
Else  
  AmpSqGluToFucSu(gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToFucSu(gt2, gt3).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 2*GammaTPS(MGluOS,MFuOS(gt2),MSuOS(gt3),helfactor*AmpSqGluToFucSu(gt2, gt3))
Else 
  gP1LGlu(gt1,i4) = 2*GammaTPS(MGlu,MFu(gt2),MSu(gt3),helfactor*AmpSqGluToFucSu(gt2, gt3))
End if 
If ((Abs(MRPGluToFucSu(gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToFucSu(gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPGluToFucSu(gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToFucSu(gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPGluToFucSu(gt2, gt3) + MRGGluToFucSu(gt2, gt3)) 
  gP1LGlu(gt1,i4) = gP1LGlu(gt1,i4) + phasespacefactor*1*helfactor*(MRPGluToFucSu(gt2, gt3) + MRGGluToFucSu(gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LGlu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
isave = i4 
End If 
!---------------- 
! Chi VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToChiVG(MChiOS,MChi2OS,MGluOS,MGlu2OS,              & 
& MVG,MVG2,ZffG,ZfL0,ZfVG,AmpWaveGluToChiVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToChiVG(MChiOS,MChi2OS,MGluOS,MGlu2OS,              & 
& MVG,MVG2,ZffG,ZfL0,ZfVG,AmpWaveGluToChiVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToChiVG(MChiOS,MFdOS,MFuOS,MGluOS,MSdOS,          & 
& MSuOS,MVG,MChi2OS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVG2,ZcplChiFdcSdL,              & 
& ZcplChiFdcSdR,ZcplChiFucSuL,ZcplChiFucSuR,ZcplcFdChiSdL,ZcplcFdChiSdR,ZcplcFuChiSuL,   & 
& ZcplcFuChiSuR,ZcplGluFdcSdL,ZcplGluFdcSdR,ZcplcFdFdVGL,ZcplcFdFdVGR,ZcplGluFucSuL,     & 
& ZcplGluFucSuR,ZcplcFuFuVGL,ZcplcFuFuVGR,ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuGluSuL,     & 
& ZcplcFuGluSuR,ZcplSdcSdVG,ZcplSucSuVG,AmpVertexGluToChiVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToChiVG(MChiOS,MFdOS,MFuOS,MGluOS,MSdOS,          & 
& MSuOS,MVG,MChi2OS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVG2,cplChiFdcSdL,               & 
& cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplGluFucSuL,           & 
& cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,           & 
& cplcFuGluSuR,cplSdcSdVG,cplSucSuVG,AmpVertexGluToChiVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToChiVG(MChi,MChi2,MGlu,MGlu2,MVG,MVG2,             & 
& ZffG,ZfL0,ZfVG,AmpWaveGluToChiVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToChiVG(MChi,MFd,MFu,MGlu,MSd,MSu,MVG,            & 
& MChi2,MFd2,MFu2,MGlu2,MSd2,MSu2,MVG2,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,           & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,         & 
& cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,            & 
& cplcFuFuVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,            & 
& cplSucSuVG,AmpVertexGluToChiVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Chi VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToChiVG = 0._dp 
 AmpSum2GluToChiVG = 0._dp  
Else 
 AmpSumGluToChiVG = AmpVertexGluToChiVG + AmpWaveGluToChiVG
 AmpSum2GluToChiVG = AmpVertexGluToChiVG + AmpWaveGluToChiVG 
End If 
gt1=1 
i4 = isave 
  Do gt2=1,4
If (((OSkinematics).and.(MGluOS.gt.(MChiOS(gt2)+0.))).or.((.not.OSkinematics).and.(MGlu.gt.(MChi(gt2)+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MGluOS,MChiOS(gt2),0._dp,AmpSumGluToChiVG(:,gt2),AmpSum2GluToChiVG(:,gt2),AmpSqGluToChiVG(gt2)) 
Else  
  Call SquareAmp_FtoFV(MGlu,MChi(gt2),MVG,AmpSumGluToChiVG(:,gt2),AmpSum2GluToChiVG(:,gt2),AmpSqGluToChiVG(gt2)) 
End if  
Else  
  AmpSqGluToChiVG(gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToChiVG(gt2).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,MChiOS(gt2),0._dp,helfactor*AmpSqGluToChiVG(gt2))
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,MChi(gt2),MVG,helfactor*AmpSqGluToChiVG(gt2))
End if 
If ((Abs(MRPGluToChiVG(gt2)).gt.1.0E-20_dp).or.(Abs(MRGGluToChiVG(gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

  End do
isave = i4 
!---------------- 
! Fv VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToFvVG(MGluOS,MGlu2OS,MVG,MVG2,ZffG,ZfFvL,          & 
& ZfVG,AmpWaveGluToFvVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToFvVG(MGluOS,MGlu2OS,MVG,MVG2,ZffG,ZfFvL,          & 
& ZfVG,AmpWaveGluToFvVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToFvVG(MFdOS,MGluOS,MSdOS,MVG,MFd2OS,             & 
& MGlu2OS,MSd2OS,MVG2,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplGluFdcSdL,ZcplGluFdcSdR,             & 
& ZcplcFdFdVGL,ZcplcFdFdVGR,ZcplcFdFvSdL,ZcplcFdFvSdR,ZcplcFdGluSdL,ZcplcFdGluSdR,       & 
& ZcplSdcSdVG,AmpVertexGluToFvVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToFvVG(MFdOS,MGluOS,MSdOS,MVG,MFd2OS,             & 
& MGlu2OS,MSd2OS,MVG2,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,     & 
& cplcFdFdVGR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplSdcSdVG,              & 
& AmpVertexGluToFvVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToFvVG(MGlu,MGlu2,MVG,MVG2,ZffG,ZfFvL,              & 
& ZfVG,AmpWaveGluToFvVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToFvVG(MFd,MGlu,MSd,MVG,MFd2,MGlu2,               & 
& MSd2,MVG2,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,               & 
& cplcFdFdVGR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplSdcSdVG,              & 
& AmpVertexGluToFvVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Fv VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToFvVG = 0._dp 
 AmpSum2GluToFvVG = 0._dp  
Else 
 AmpSumGluToFvVG = AmpVertexGluToFvVG + AmpWaveGluToFvVG
 AmpSum2GluToFvVG = AmpVertexGluToFvVG + AmpWaveGluToFvVG 
End If 
gt1=1 
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MGluOS.gt.(0.+0.))).or.((.not.OSkinematics).and.(MGlu.gt.(0.+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MGluOS,0._dp,0._dp,AmpSumGluToFvVG(:,gt2),AmpSum2GluToFvVG(:,gt2),AmpSqGluToFvVG(gt2)) 
Else  
  Call SquareAmp_FtoFV(MGlu,0._dp,MVG,AmpSumGluToFvVG(:,gt2),AmpSum2GluToFvVG(:,gt2),AmpSqGluToFvVG(gt2)) 
End if  
Else  
  AmpSqGluToFvVG(gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToFvVG(gt2).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,0._dp,0._dp,helfactor*AmpSqGluToFvVG(gt2))
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,0._dp,MVG,helfactor*AmpSqGluToFvVG(gt2))
End if 
If ((Abs(MRPGluToFvVG(gt2)).gt.1.0E-20_dp).or.(Abs(MRGGluToFvVG(gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

  End do
isave = i4 
!---------------- 
! Glu Ah
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluAh(MAhOS,MAh2OS,MGluOS,MGlu2OS,ZfAh,           & 
& ZffG,AmpWaveGluToGluAh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluAh(MAhOS,MAh2OS,MGluOS,MGlu2OS,ZfAh,           & 
& ZffG,AmpWaveGluToGluAh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluAh(MAhOS,MFdOS,MFuOS,MGluOS,MSdOS,           & 
& MSuOS,MAh2OS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,ZcplcFdFdAhL,ZcplcFdFdAhR,            & 
& ZcplcFuFuAhL,ZcplcFuFuAhR,ZcplAhSdcSd,ZcplAhSucSu,ZcplGluFdcSdL,ZcplGluFdcSdR,         & 
& ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuGluSuL,ZcplcFuGluSuR,   & 
& AmpVertexGluToGluAh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluAh(MAhOS,MFdOS,MFuOS,MGluOS,MSdOS,           & 
& MSuOS,MAh2OS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,               & 
& cplGluFucSuL,cplGluFucSuR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& AmpVertexGluToGluAh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluAh(MAh,MAh2,MGlu,MGlu2,ZfAh,ZffG,              & 
& AmpWaveGluToGluAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluAh(MAh,MFd,MFu,MGlu,MSd,MSu,MAh2,            & 
& MFd2,MFu2,MGlu2,MSd2,MSu2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,             & 
& cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,AmpVertexGluToGluAh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Glu Ah -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToGluAh = 0._dp 
 AmpSum2GluToGluAh = 0._dp  
Else 
 AmpSumGluToGluAh = AmpVertexGluToGluAh + AmpWaveGluToGluAh
 AmpSum2GluToGluAh = AmpVertexGluToGluAh + AmpWaveGluToGluAh 
End If 
gt1=1 
i4 = isave 
    Do gt3=2,2
If (((OSkinematics).and.(MGluOS.gt.(MGluOS+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MGlu.gt.(MGlu+MAh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MGluOS,MAhOS(gt3),AmpSumGluToGluAh(:,gt3),AmpSum2GluToGluAh(:,gt3),AmpSqGluToGluAh(gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MGlu,MAh(gt3),AmpSumGluToGluAh(:,gt3),AmpSum2GluToGluAh(:,gt3),AmpSqGluToGluAh(gt3)) 
End if  
Else  
  AmpSqGluToGluAh(gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToGluAh(gt3).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,MGluOS,MAhOS(gt3),helfactor*AmpSqGluToGluAh(gt3))
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,MGlu,MAh(gt3),helfactor*AmpSqGluToGluAh(gt3))
End if 
If ((Abs(MRPGluToGluAh(gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToGluAh(gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

    End do
isave = i4 
!---------------- 
! Glu hh
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluhh(MGluOS,MGlu2OS,MhhOS,Mhh2OS,ZffG,           & 
& Zfhh,AmpWaveGluToGluhh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluhh(MGluOS,MGlu2OS,MhhOS,Mhh2OS,ZffG,           & 
& Zfhh,AmpWaveGluToGluhh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluhh(MFdOS,MFuOS,MGluOS,MhhOS,MSdOS,           & 
& MSuOS,MFd2OS,MFu2OS,MGlu2OS,Mhh2OS,MSd2OS,MSu2OS,ZcplGluFdcSdL,ZcplGluFdcSdR,          & 
& ZcplcFdFdhhL,ZcplcFdFdhhR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFuFuhhL,ZcplcFuFuhhR,       & 
& ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplhhSdcSd,ZcplhhSucSu,       & 
& AmpVertexGluToGluhh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluhh(MFdOS,MFuOS,MGluOS,MhhOS,MSdOS,           & 
& MSuOS,MFd2OS,MFu2OS,MGlu2OS,Mhh2OS,MSd2OS,MSu2OS,cplGluFdcSdL,cplGluFdcSdR,            & 
& cplcFdFdhhL,cplcFdFdhhR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,             & 
& AmpVertexGluToGluhh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluhh(MGlu,MGlu2,Mhh,Mhh2,ZffG,Zfhh,              & 
& AmpWaveGluToGluhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluhh(MFd,MFu,MGlu,Mhh,MSd,MSu,MFd2,            & 
& MFu2,MGlu2,Mhh2,MSd2,MSu2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,AmpVertexGluToGluhh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Glu hh -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToGluhh = 0._dp 
 AmpSum2GluToGluhh = 0._dp  
Else 
 AmpSumGluToGluhh = AmpVertexGluToGluhh + AmpWaveGluToGluhh
 AmpSum2GluToGluhh = AmpVertexGluToGluhh + AmpWaveGluToGluhh 
End If 
gt1=1 
i4 = isave 
    Do gt3=1,2
If (((OSkinematics).and.(MGluOS.gt.(MGluOS+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MGlu.gt.(MGlu+Mhh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MGluOS,MhhOS(gt3),AmpSumGluToGluhh(:,gt3),AmpSum2GluToGluhh(:,gt3),AmpSqGluToGluhh(gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MGlu,Mhh(gt3),AmpSumGluToGluhh(:,gt3),AmpSum2GluToGluhh(:,gt3),AmpSqGluToGluhh(gt3)) 
End if  
Else  
  AmpSqGluToGluhh(gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToGluhh(gt3).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,MGluOS,MhhOS(gt3),helfactor*AmpSqGluToGluhh(gt3))
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,MGlu,Mhh(gt3),helfactor*AmpSqGluToGluhh(gt3))
End if 
If ((Abs(MRPGluToGluhh(gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToGluhh(gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

    End do
isave = i4 
!---------------- 
! Glu Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluSv(MGluOS,MGlu2OS,MSvOS,MSv2OS,ZffG,           & 
& ZfSv,AmpWaveGluToGluSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluSv(MGluOS,MGlu2OS,MSvOS,MSv2OS,ZffG,           & 
& ZfSv,AmpWaveGluToGluSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluSv(MFdOS,MGluOS,MSdOS,MSvOS,MFd2OS,          & 
& MGlu2OS,MSd2OS,MSv2OS,ZcplGluFdcSdL,ZcplGluFdcSdR,ZcplcFdFdSvL,ZcplcFdFdSvR,           & 
& ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplSdSvcSd,AmpVertexGluToGluSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluSv(MFdOS,MGluOS,MSdOS,MSvOS,MFd2OS,          & 
& MGlu2OS,MSd2OS,MSv2OS,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,cplcFdFdSvR,               & 
& cplcFdGluSdL,cplcFdGluSdR,cplSdSvcSd,AmpVertexGluToGluSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluSv(MGlu,MGlu2,MSv,MSv2,ZffG,ZfSv,              & 
& AmpWaveGluToGluSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluSv(MFd,MGlu,MSd,MSv,MFd2,MGlu2,              & 
& MSd2,MSv2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,cplcFdFdSvR,cplcFdGluSdL,              & 
& cplcFdGluSdR,cplSdSvcSd,AmpVertexGluToGluSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Glu Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToGluSv = 0._dp 
 AmpSum2GluToGluSv = 0._dp  
Else 
 AmpSumGluToGluSv = AmpVertexGluToGluSv + AmpWaveGluToGluSv
 AmpSum2GluToGluSv = AmpVertexGluToGluSv + AmpWaveGluToGluSv 
End If 
gt1=1 
i4 = isave 
    Do gt3=1,3
If (((OSkinematics).and.(MGluOS.gt.(MGluOS+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MGlu.gt.(MGlu+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MGluOS,MGluOS,MSvOS(gt3),AmpSumGluToGluSv(:,gt3),AmpSum2GluToGluSv(:,gt3),AmpSqGluToGluSv(gt3)) 
Else  
  Call SquareAmp_FtoFS(MGlu,MGlu,MSv(gt3),AmpSumGluToGluSv(:,gt3),AmpSum2GluToGluSv(:,gt3),AmpSqGluToGluSv(gt3)) 
End if  
Else  
  AmpSqGluToGluSv(gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToGluSv(gt3).eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 2*GammaTPS(MGluOS,MGluOS,MSvOS(gt3),helfactor*AmpSqGluToGluSv(gt3))
Else 
  gP1LGlu(gt1,i4) = 2*GammaTPS(MGlu,MGlu,MSv(gt3),helfactor*AmpSqGluToGluSv(gt3))
End if 
If ((Abs(MRPGluToGluSv(gt3)).gt.1.0E-20_dp).or.(Abs(MRGGluToGluSv(gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

    End do
isave = i4 
!---------------- 
! Glu VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVG(ZcplGluGluVGL,ZcplGluGluVGR,ctcplGluGluVGL, & 
& ctcplGluGluVGR,MGluOS,MGlu2OS,MVG,MVG2,ZffG,ZfVG,AmpWaveGluToGluVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVG(cplGluGluVGL,cplGluGluVGR,ctcplGluGluVGL,   & 
& ctcplGluGluVGR,MGluOS,MGlu2OS,MVG,MVG2,ZffG,ZfVG,AmpWaveGluToGluVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVG(MFdOS,MFuOS,MGluOS,MSdOS,MSuOS,           & 
& MVG,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVG2,ZcplGluFdcSdL,ZcplGluFdcSdR,              & 
& ZcplcFdFdVGL,ZcplcFdFdVGR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFuFuVGL,ZcplcFuFuVGR,       & 
& ZcplGluGluVGL,ZcplGluGluVGR,ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuGluSuL,ZcplcFuGluSuR,   & 
& ZcplSdcSdVG,ZcplSucSuVG,ZcplVGVGVG,AmpVertexGluToGluVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVG(MFdOS,MFuOS,MGluOS,MSdOS,MSuOS,           & 
& MVG,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVG2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,    & 
& cplcFdFdVGR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,           & 
& cplSucSuVG,cplVGVGVG,AmpVertexGluToGluVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVG(cplGluGluVGL,cplGluGluVGR,ctcplGluGluVGL,   & 
& ctcplGluGluVGR,MGlu,MGlu2,MVG,MVG2,ZffG,ZfVG,AmpWaveGluToGluVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVG(MFd,MFu,MGlu,MSd,MSu,MVG,MFd2,            & 
& MFu2,MGlu2,MSd2,MSu2,MVG2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,cplSucSuVG,             & 
& cplVGVGVG,AmpVertexGluToGluVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Glu VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToGluVG = 0._dp 
 AmpSum2GluToGluVG = 0._dp  
Else 
 AmpSumGluToGluVG = AmpVertexGluToGluVG + AmpWaveGluToGluVG
 AmpSum2GluToGluVG = AmpVertexGluToGluVG + AmpWaveGluToGluVG 
End If 
gt1=1 
i4 = isave 
If (((OSkinematics).and.(MGluOS.gt.(MGluOS+0.))).or.((.not.OSkinematics).and.(MGlu.gt.(MGlu+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MGluOS,MGluOS,0._dp,AmpSumGluToGluVG(:),AmpSum2GluToGluVG(:),AmpSqGluToGluVG) 
Else  
  Call SquareAmp_FtoFV(MGlu,MGlu,MVG,AmpSumGluToGluVG(:),AmpSum2GluToGluVG(:),AmpSqGluToGluVG) 
End if  
Else  
  AmpSqGluToGluVG = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToGluVG.eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,MGluOS,0._dp,helfactor*AmpSqGluToGluVG)
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,MGlu,MVG,helfactor*AmpSqGluToGluVG)
End if 
If ((Abs(MRPGluToGluVG).gt.1.0E-20_dp).or.(Abs(MRGGluToGluVG).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

isave = i4 
!---------------- 
! Glu VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVP(MGluOS,MGlu2OS,MVP,MVP2,ZffG,               & 
& ZfVP,AmpWaveGluToGluVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVP(MGluOS,MGlu2OS,MVP,MVP2,ZffG,               & 
& ZfVP,AmpWaveGluToGluVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVP(MFdOS,MFuOS,MGluOS,MSdOS,MSuOS,           & 
& MVP,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVP2,ZcplGluFdcSdL,ZcplGluFdcSdR,              & 
& ZcplcFdFdVPL,ZcplcFdFdVPR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFuFuVPL,ZcplcFuFuVPR,       & 
& ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplSdcSdVP,ZcplSucSuVP,       & 
& AmpVertexGluToGluVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVP(MFdOS,MFuOS,MGluOS,MSdOS,MSuOS,           & 
& MVP,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVP2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,    & 
& cplcFdFdVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVPL,cplcFuFuVPR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVP,cplSucSuVP,AmpVertexGluToGluVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVP(MGlu,MGlu2,MVP,MVP2,ZffG,ZfVP,              & 
& AmpWaveGluToGluVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVP(MFd,MFu,MGlu,MSd,MSu,MVP,MFd2,            & 
& MFu2,MGlu2,MSd2,MSu2,MVP2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,cplcFdFdVPR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuVPL,cplcFuFuVPR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVP,cplSucSuVP,AmpVertexGluToGluVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Glu VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToGluVP = 0._dp 
 AmpSum2GluToGluVP = 0._dp  
Else 
 AmpSumGluToGluVP = AmpVertexGluToGluVP + AmpWaveGluToGluVP
 AmpSum2GluToGluVP = AmpVertexGluToGluVP + AmpWaveGluToGluVP 
End If 
gt1=1 
i4 = isave 
If (((OSkinematics).and.(MGluOS.gt.(MGluOS+0.))).or.((.not.OSkinematics).and.(MGlu.gt.(MGlu+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MGluOS,MGluOS,0._dp,AmpSumGluToGluVP(:),AmpSum2GluToGluVP(:),AmpSqGluToGluVP) 
Else  
  Call SquareAmp_FtoFV(MGlu,MGlu,MVP,AmpSumGluToGluVP(:),AmpSum2GluToGluVP(:),AmpSqGluToGluVP) 
End if  
Else  
  AmpSqGluToGluVP = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToGluVP.eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,MGluOS,0._dp,helfactor*AmpSqGluToGluVP)
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,MGlu,MVP,helfactor*AmpSqGluToGluVP)
End if 
If ((Abs(MRPGluToGluVP).gt.1.0E-20_dp).or.(Abs(MRGGluToGluVP).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

isave = i4 
!---------------- 
! Glu VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVZ(MGluOS,MGlu2OS,MVZOS,MVZ2OS,ZffG,           & 
& ZfVZ,AmpWaveGluToGluVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVZ(MGluOS,MGlu2OS,MVZOS,MVZ2OS,ZffG,           & 
& ZfVZ,AmpWaveGluToGluVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVZ(MFdOS,MFuOS,MGluOS,MSdOS,MSuOS,           & 
& MVZOS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVZ2OS,ZcplGluFdcSdL,ZcplGluFdcSdR,          & 
& ZcplcFdFdVZL,ZcplcFdFdVZR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFuFuVZL,ZcplcFuFuVZR,       & 
& ZcplcFdGluSdL,ZcplcFdGluSdR,ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplSdcSdVZ,ZcplSucSuVZ,       & 
& AmpVertexGluToGluVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVZ(MFdOS,MFuOS,MGluOS,MSdOS,MSuOS,           & 
& MVZOS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,MVZ2OS,cplGluFdcSdL,cplGluFdcSdR,            & 
& cplcFdFdVZL,cplcFdFdVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVZ,cplSucSuVZ,             & 
& AmpVertexGluToGluVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_GluToGluVZ(MGlu,MGlu2,MVZ,MVZ2,ZffG,ZfVZ,              & 
& AmpWaveGluToGluVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_GluToGluVZ(MFd,MFu,MGlu,MSd,MSu,MVZ,MFd2,            & 
& MFu2,MGlu2,MSd2,MSu2,MVZ2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVZ,cplSucSuVZ,AmpVertexGluToGluVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Glu->Glu VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumGluToGluVZ = 0._dp 
 AmpSum2GluToGluVZ = 0._dp  
Else 
 AmpSumGluToGluVZ = AmpVertexGluToGluVZ + AmpWaveGluToGluVZ
 AmpSum2GluToGluVZ = AmpVertexGluToGluVZ + AmpWaveGluToGluVZ 
End If 
gt1=1 
i4 = isave 
If (((OSkinematics).and.(MGluOS.gt.(MGluOS+MVZOS))).or.((.not.OSkinematics).and.(MGlu.gt.(MGlu+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MGluOS,MGluOS,MVZOS,AmpSumGluToGluVZ(:),AmpSum2GluToGluVZ(:),AmpSqGluToGluVZ) 
Else  
  Call SquareAmp_FtoFV(MGlu,MGlu,MVZ,AmpSumGluToGluVZ(:),AmpSum2GluToGluVZ(:),AmpSqGluToGluVZ) 
End if  
Else  
  AmpSqGluToGluVZ = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqGluToGluVZ.eq.0._dp) Then 
  gP1LGlu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGluOS,MGluOS,MVZOS,helfactor*AmpSqGluToGluVZ)
Else 
  gP1LGlu(gt1,i4) = 1*GammaTPS(MGlu,MGlu,MVZ,helfactor*AmpSqGluToGluVZ)
End if 
If ((Abs(MRPGluToGluVZ).gt.1.0E-20_dp).or.(Abs(MRGGluToGluVZ).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LGlu(gt1,i4) 
End if 
i4=i4+1

isave = i4 
End Subroutine OneLoopDecay_Glu

End Module Wrapper_OneLoopDecay_Glu_MSSMTriLnV
