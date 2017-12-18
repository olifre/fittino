! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Hpm_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Hpm_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Hpm(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,             & 
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
& ZfVPVZ,ZfVZVP,cplAhAhcVWmVWm1,cplAhAhhh,cplAhAhHpmcHpm1,cplAhcHpmVPVWm1,               & 
& cplAhcHpmVWm,cplAhcHpmVWmVZ1,cplAhhhHpmcHpm1,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,      & 
& cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcHpmcSuaa,       & 
& cplAhSdcSd,cplAhSecHpmcSv1,cplAhSecSe,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSucSu,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,   & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,               & 
& cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFdChiSdL,        & 
& cplcFdChiSdR,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,              & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFeChaSvL,          & 
& cplcFeChaSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFeAhL,          & 
& cplcFeFeAhR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFvHpmL,              & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuChiSuL,           & 
& cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFuFuAhL,cplcFuFuAhR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,              & 
& cplcFuGluSuR,cplcgAgWpCVWm,cplcgWmgWmAh,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWmgWmVZ,        & 
& cplcgWmgZHpm,cplcgWmgZVWm,cplcgWpCgAcHpm,cplcgWpCgWpCAh,cplcgWpCgWpChh,cplcgWpCgWpCVP, & 
& cplcgWpCgWpCVZ,cplcgWpCgZcHpm,cplcgZgAhh,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgZgWpCVWm,    & 
& cplcgZgZhh,cplChaFucSdL,cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,     & 
& cplChiChacVWmR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplcHpmVPVWm,           & 
& cplcHpmVWmVZ,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVPVWm3Q,cplcVWmVPVWm,          & 
& cplcVWmVPVWmVZ1Q,cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ3Q,cplcVWmVWmVZ,cplcVWmVWmVZVZ1Q,      & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,   & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,cplGluFdcSdR,             & 
& cplGluFucSuL,cplGluFucSuR,cplhhcHpmVPVWm1,cplhhcHpmVWm,cplhhcHpmVWmVZ1,cplhhcVWmVWm,   & 
& cplhhhhcVWmVWm1,cplhhhhhh,cplhhhhHpmcHpm1,cplhhHpmcHpm,cplhhHpmcVWm,cplhhHpmcVWmVP1,   & 
& cplhhHpmcVWmVZ1,cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcHpmcSuaa,cplhhSdcSd,            & 
& cplhhSecHpmcSv1,cplhhSecSe,cplhhSeSucSdaa,cplhhSeSvcSe1,cplhhSucSu,cplhhSvcSv,         & 
& cplhhVZVZ,cplHpmcHpmcVWmVWm1,cplHpmcHpmVP,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,             & 
& cplHpmcHpmVZ,cplHpmcHpmVZVZ1,cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmHpmcHpmcHpm1,             & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,cplHpmSucSd,cplHpmSucSdcSvaa,     & 
& cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSe,cplHpmSvcSecSv1,cplSdcHpmcSu,             & 
& cplSdcHpmcSucSvaa,cplSdcSdcSv,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdSecHpmcSdaa,cplSdSucSdcSuabab,     & 
& cplSdSucSdcSuabba,cplSdSvcHpmcSuaa,cplSdSvcSd,cplSdSvcSecSuaa,cplSecHpmcSv,            & 
& cplSecSecSv,cplSecSeVP,cplSecSeVZ,cplSecSvcVWm,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,        & 
& cplSeSecHpmcSe1,cplSeSucHpmcSuaa,cplSeSucSd,cplSeSucSdcSvaa,cplSeSvcHpmcSv1,           & 
& cplSeSvcSe,cplSeSvcSecSv1,cplSucSdVPVWmaa,cplSucSdVWm,cplSucSdVWmVZaa,cplSucSuVG,      & 
& cplSucSuVP,cplSucSuVZ,cplSvcSeVPVWm1,cplSvcSeVWm,cplSvcSeVWmVZ1,cplSvcSvVZ,            & 
& ctcplAhcHpmVWm,ctcplAhHpmcHpm,ctcplcFuFdcHpmL,ctcplcFuFdcHpmR,ctcplChiChacHpmL,        & 
& ctcplChiChacHpmR,ctcplcHpmVPVWm,ctcplcHpmVWmVZ,ctcplFvFecHpmL,ctcplFvFecHpmR,          & 
& ctcplhhcHpmVWm,ctcplhhHpmcHpm,ctcplHpmcHpmVP,ctcplHpmcHpmVZ,ctcplSdcHpmcSu,            & 
& ctcplSecHpmcSv,GcplAhHpmcHpm,GcplcHpmVPVWm,GcplhhHpmcHpm,GcplHpmcHpmVZ,GcplHpmcVWmVP,  & 
& GosZcplAhHpmcHpm,GosZcplcHpmVPVWm,GosZcplhhHpmcHpm,GosZcplHpmcHpmVZ,GosZcplHpmcVWmVP,  & 
& GZcplAhHpmcHpm,GZcplcHpmVPVWm,GZcplhhHpmcHpm,GZcplHpmcHpmVZ,GZcplHpmcVWmVP,            & 
& ZcplAhcHpmVWm,ZcplAhHpmcHpm,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,ZcplChiChacHpmL,             & 
& ZcplChiChacHpmR,ZcplcHpmVWmVZ,ZcplFvFecHpmL,ZcplFvFecHpmR,ZcplhhcHpmVWm,               & 
& ZcplhhHpmcHpm,ZcplHpmcHpmVZ,ZcplSdcHpmcSu,ZcplSecHpmcSv,ZRUZD,ZRUZV,ZRUZU,             & 
& ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,          & 
& ZRUZUR,MLambda,em,gs,deltaM,kont,gP1LHpm)

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

Complex(dp),Intent(in) :: cplAhAhcVWmVWm1(2,2),cplAhAhhh(2,2,2),cplAhAhHpmcHpm1(2,2,2,2),cplAhcHpmVPVWm1(2,2),  & 
& cplAhcHpmVWm(2,2),cplAhcHpmVWmVZ1(2,2),cplAhhhHpmcHpm1(2,2,2,2),cplAhhhVZ(2,2),        & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),       & 
& cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhSdcHpmcSuaa(2,6,2,6),            & 
& cplAhSdcSd(2,6,6),cplAhSecHpmcSv1(2,6,2,3),cplAhSecSe(2,6,6),cplAhSeSucSdaa(2,6,6,6),  & 
& cplAhSeSvcSe1(2,6,3,6),cplAhSucSu(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),    & 
& cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),   & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),   & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),   & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),       & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),         & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),               & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFeSuL(3,3,6),& 
& cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),             & 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFecFuSdL(3,3,6),            & 
& cplcFecFuSdR(3,3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFeFeAhL(3,3,2),        & 
& cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),         & 
& cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),             & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),& 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcgAgWpCVWm,cplcgWmgWmAh(2),    & 
& cplcgWmgWmhh(2),cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWmgZHpm(2),cplcgWmgZVWm,cplcgWpCgAcHpm(2),& 
& cplcgWpCgWpCAh(2),cplcgWpCgWpChh(2),cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplcgWpCgZcHpm(2),   & 
& cplcgZgAhh(2),cplcgZgWmcHpm(2),cplcgZgWpCHpm(2),cplcgZgWpCVWm,cplcgZgZhh(2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),   & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),       & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Complex(dp),Intent(in) :: cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVPVWm1Q,& 
& cplcVWmVPVPVWm2Q,cplcVWmVPVPVWm3Q,cplcVWmVPVWm,cplcVWmVPVWmVZ1Q,cplcVWmVPVWmVZ2Q,      & 
& cplcVWmVPVWmVZ3Q,cplcVWmVWmVZ,cplcVWmVWmVZVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,      & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6), & 
& cplGluFucSuR(3,6),cplhhcHpmVPVWm1(2,2),cplhhcHpmVWm(2,2),cplhhcHpmVWmVZ1(2,2),         & 
& cplhhcVWmVWm(2),cplhhhhcVWmVWm1(2,2),cplhhhhhh(2,2,2),cplhhhhHpmcHpm1(2,2,2,2),        & 
& cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhHpmcVWmVP1(2,2),cplhhHpmcVWmVZ1(2,2),       & 
& cplhhHpmSucSdaa(2,2,6,6),cplhhHpmSvcSe1(2,2,3,6),cplhhSdcHpmcSuaa(2,6,2,6),            & 
& cplhhSdcSd(2,6,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSe(2,6,6),cplhhSeSucSdaa(2,6,6,6),  & 
& cplhhSeSvcSe1(2,6,3,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhVZVZ(2),               & 
& cplHpmcHpmcVWmVWm1(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVPVP1(2,2),cplHpmcHpmVPVZ1(2,2),   & 
& cplHpmcHpmVZ(2,2),cplHpmcHpmVZVZ1(2,2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplHpmHpmcHpmcHpm1(2,2,2,2),& 
& cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSecHpmcSe1(2,6,2,6),cplHpmSucHpmcSuaa(2,6,2,6),       & 
& cplHpmSucSd(2,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplHpmSuSvcSdaa(2,6,3,6),cplHpmSvcHpmcSv1(2,3,2,3),& 
& cplHpmSvcSe(2,3,6),cplHpmSvcSecSv1(2,3,6,3),cplSdcHpmcSu(6,2,6),cplSdcHpmcSucSvaa(6,2,6,3),& 
& cplSdcSdcSv(6,6,3),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6), & 
& cplSdcSucVWm(6,6),cplSdcSucVWmVPaa(6,6),cplSdcSucVWmVZaa(6,6),cplSdSecHpmcSdaa(6,6,2,6),& 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),       & 
& cplSdSvcSd(6,3,6),cplSdSvcSecSuaa(6,3,6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),     & 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSvcVWm(6,3),cplSecSvcVWmVP1(6,3),cplSecSvcVWmVZ1(6,3),& 
& cplSeSecHpmcSe1(6,6,2,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSucSd(6,6,6),cplSeSucSdcSvaa(6,6,6,3),& 
& cplSeSvcHpmcSv1(6,3,2,3),cplSeSvcSe(6,3,6),cplSeSvcSecSv1(6,3,6,3),cplSucSdVPVWmaa(6,6),& 
& cplSucSdVWm(6,6),cplSucSdVWmVZaa(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6), & 
& cplSvcSeVPVWm1(3,6),cplSvcSeVWm(3,6),cplSvcSeVWmVZ1(3,6),cplSvcSvVZ(3,3),              & 
& ctcplAhcHpmVWm(2,2),ctcplAhHpmcHpm(2,2,2),ctcplcFuFdcHpmL(3,3,2),ctcplcFuFdcHpmR(3,3,2),& 
& ctcplChiChacHpmL(4,2,2),ctcplChiChacHpmR(4,2,2),ctcplcHpmVPVWm(2),ctcplcHpmVWmVZ(2),   & 
& ctcplFvFecHpmL(3,3,2),ctcplFvFecHpmR(3,3,2),ctcplhhcHpmVWm(2,2),ctcplhhHpmcHpm(2,2,2), & 
& ctcplHpmcHpmVP(2,2),ctcplHpmcHpmVZ(2,2),ctcplSdcHpmcSu(6,2,6),ctcplSecHpmcSv(6,2,3),   & 
& GcplAhHpmcHpm(2,2,2),GcplcHpmVPVWm(2),GcplhhHpmcHpm(2,2,2),GcplHpmcHpmVZ(2,2),         & 
& GcplHpmcVWmVP(2),GosZcplAhHpmcHpm(2,2,2),GosZcplcHpmVPVWm(2),GosZcplhhHpmcHpm(2,2,2),  & 
& GosZcplHpmcHpmVZ(2,2),GosZcplHpmcVWmVP(2),GZcplAhHpmcHpm(2,2,2),GZcplcHpmVPVWm(2),     & 
& GZcplhhHpmcHpm(2,2,2),GZcplHpmcHpmVZ(2,2),GZcplHpmcVWmVP(2),ZcplAhcHpmVWm(2,2),        & 
& ZcplAhHpmcHpm(2,2,2),ZcplcFuFdcHpmL(3,3,2),ZcplcFuFdcHpmR(3,3,2),ZcplChiChacHpmL(4,2,2),& 
& ZcplChiChacHpmR(4,2,2),ZcplcHpmVWmVZ(2),ZcplFvFecHpmL(3,3,2),ZcplFvFecHpmR(3,3,2)

Complex(dp),Intent(in) :: ZcplhhcHpmVWm(2,2),ZcplhhHpmcHpm(2,2,2),ZcplHpmcHpmVZ(2,2),ZcplSdcHpmcSu(6,2,6),       & 
& ZcplSecHpmcSv(6,2,3)

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
Real(dp), Intent(out) :: gP1LHpm(2,168) 
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
Real(dp) :: MRPHpmToHpmAh(2,2,2),MRGHpmToHpmAh(2,2,2), MRPZHpmToHpmAh(2,2,2),MRGZHpmToHpmAh(2,2,2) 
Real(dp) :: MVPHpmToHpmAh(2,2,2) 
Real(dp) :: RMsqTreeHpmToHpmAh(2,2,2),RMsqWaveHpmToHpmAh(2,2,2),RMsqVertexHpmToHpmAh(2,2,2) 
Complex(dp) :: AmpTreeHpmToHpmAh(2,2,2),AmpWaveHpmToHpmAh(2,2,2),AmpVertexHpmToHpmAh(2,2,2)& 
 & ,AmpVertexIRosHpmToHpmAh(2,2,2),AmpVertexIRdrHpmToHpmAh(2,2,2), AmpSumHpmToHpmAh(2,2,2), AmpSum2HpmToHpmAh(2,2,2) 
Complex(dp) :: AmpTreeZHpmToHpmAh(2,2,2),AmpWaveZHpmToHpmAh(2,2,2),AmpVertexZHpmToHpmAh(2,2,2) 
Real(dp) :: AmpSqHpmToHpmAh(2,2,2),  AmpSqTreeHpmToHpmAh(2,2,2) 
Real(dp) :: MRPHpmToAhVWm(2,2),MRGHpmToAhVWm(2,2), MRPZHpmToAhVWm(2,2),MRGZHpmToAhVWm(2,2) 
Real(dp) :: MVPHpmToAhVWm(2,2) 
Real(dp) :: RMsqTreeHpmToAhVWm(2,2),RMsqWaveHpmToAhVWm(2,2),RMsqVertexHpmToAhVWm(2,2) 
Complex(dp) :: AmpTreeHpmToAhVWm(2,2,2),AmpWaveHpmToAhVWm(2,2,2),AmpVertexHpmToAhVWm(2,2,2)& 
 & ,AmpVertexIRosHpmToAhVWm(2,2,2),AmpVertexIRdrHpmToAhVWm(2,2,2), AmpSumHpmToAhVWm(2,2,2), AmpSum2HpmToAhVWm(2,2,2) 
Complex(dp) :: AmpTreeZHpmToAhVWm(2,2,2),AmpWaveZHpmToAhVWm(2,2,2),AmpVertexZHpmToAhVWm(2,2,2) 
Real(dp) :: AmpSqHpmToAhVWm(2,2),  AmpSqTreeHpmToAhVWm(2,2) 
Real(dp) :: MRPHpmToChiCha(2,4,2),MRGHpmToChiCha(2,4,2), MRPZHpmToChiCha(2,4,2),MRGZHpmToChiCha(2,4,2) 
Real(dp) :: MVPHpmToChiCha(2,4,2) 
Real(dp) :: RMsqTreeHpmToChiCha(2,4,2),RMsqWaveHpmToChiCha(2,4,2),RMsqVertexHpmToChiCha(2,4,2) 
Complex(dp) :: AmpTreeHpmToChiCha(2,2,4,2),AmpWaveHpmToChiCha(2,2,4,2),AmpVertexHpmToChiCha(2,2,4,2)& 
 & ,AmpVertexIRosHpmToChiCha(2,2,4,2),AmpVertexIRdrHpmToChiCha(2,2,4,2), AmpSumHpmToChiCha(2,2,4,2), AmpSum2HpmToChiCha(2,2,4,2) 
Complex(dp) :: AmpTreeZHpmToChiCha(2,2,4,2),AmpWaveZHpmToChiCha(2,2,4,2),AmpVertexZHpmToChiCha(2,2,4,2) 
Real(dp) :: AmpSqHpmToChiCha(2,4,2),  AmpSqTreeHpmToChiCha(2,4,2) 
Real(dp) :: MRPHpmTocFuFd(2,3,3),MRGHpmTocFuFd(2,3,3), MRPZHpmTocFuFd(2,3,3),MRGZHpmTocFuFd(2,3,3) 
Real(dp) :: MVPHpmTocFuFd(2,3,3) 
Real(dp) :: RMsqTreeHpmTocFuFd(2,3,3),RMsqWaveHpmTocFuFd(2,3,3),RMsqVertexHpmTocFuFd(2,3,3) 
Complex(dp) :: AmpTreeHpmTocFuFd(2,2,3,3),AmpWaveHpmTocFuFd(2,2,3,3),AmpVertexHpmTocFuFd(2,2,3,3)& 
 & ,AmpVertexIRosHpmTocFuFd(2,2,3,3),AmpVertexIRdrHpmTocFuFd(2,2,3,3), AmpSumHpmTocFuFd(2,2,3,3), AmpSum2HpmTocFuFd(2,2,3,3) 
Complex(dp) :: AmpTreeZHpmTocFuFd(2,2,3,3),AmpWaveZHpmTocFuFd(2,2,3,3),AmpVertexZHpmTocFuFd(2,2,3,3) 
Real(dp) :: AmpSqHpmTocFuFd(2,3,3),  AmpSqTreeHpmTocFuFd(2,3,3) 
Real(dp) :: MRPHpmToFvFe(2,3,3),MRGHpmToFvFe(2,3,3), MRPZHpmToFvFe(2,3,3),MRGZHpmToFvFe(2,3,3) 
Real(dp) :: MVPHpmToFvFe(2,3,3) 
Real(dp) :: RMsqTreeHpmToFvFe(2,3,3),RMsqWaveHpmToFvFe(2,3,3),RMsqVertexHpmToFvFe(2,3,3) 
Complex(dp) :: AmpTreeHpmToFvFe(2,2,3,3),AmpWaveHpmToFvFe(2,2,3,3),AmpVertexHpmToFvFe(2,2,3,3)& 
 & ,AmpVertexIRosHpmToFvFe(2,2,3,3),AmpVertexIRdrHpmToFvFe(2,2,3,3), AmpSumHpmToFvFe(2,2,3,3), AmpSum2HpmToFvFe(2,2,3,3) 
Complex(dp) :: AmpTreeZHpmToFvFe(2,2,3,3),AmpWaveZHpmToFvFe(2,2,3,3),AmpVertexZHpmToFvFe(2,2,3,3) 
Real(dp) :: AmpSqHpmToFvFe(2,3,3),  AmpSqTreeHpmToFvFe(2,3,3) 
Real(dp) :: MRPHpmToHpmhh(2,2,2),MRGHpmToHpmhh(2,2,2), MRPZHpmToHpmhh(2,2,2),MRGZHpmToHpmhh(2,2,2) 
Real(dp) :: MVPHpmToHpmhh(2,2,2) 
Real(dp) :: RMsqTreeHpmToHpmhh(2,2,2),RMsqWaveHpmToHpmhh(2,2,2),RMsqVertexHpmToHpmhh(2,2,2) 
Complex(dp) :: AmpTreeHpmToHpmhh(2,2,2),AmpWaveHpmToHpmhh(2,2,2),AmpVertexHpmToHpmhh(2,2,2)& 
 & ,AmpVertexIRosHpmToHpmhh(2,2,2),AmpVertexIRdrHpmToHpmhh(2,2,2), AmpSumHpmToHpmhh(2,2,2), AmpSum2HpmToHpmhh(2,2,2) 
Complex(dp) :: AmpTreeZHpmToHpmhh(2,2,2),AmpWaveZHpmToHpmhh(2,2,2),AmpVertexZHpmToHpmhh(2,2,2) 
Real(dp) :: AmpSqHpmToHpmhh(2,2,2),  AmpSqTreeHpmToHpmhh(2,2,2) 
Real(dp) :: MRPHpmTohhVWm(2,2),MRGHpmTohhVWm(2,2), MRPZHpmTohhVWm(2,2),MRGZHpmTohhVWm(2,2) 
Real(dp) :: MVPHpmTohhVWm(2,2) 
Real(dp) :: RMsqTreeHpmTohhVWm(2,2),RMsqWaveHpmTohhVWm(2,2),RMsqVertexHpmTohhVWm(2,2) 
Complex(dp) :: AmpTreeHpmTohhVWm(2,2,2),AmpWaveHpmTohhVWm(2,2,2),AmpVertexHpmTohhVWm(2,2,2)& 
 & ,AmpVertexIRosHpmTohhVWm(2,2,2),AmpVertexIRdrHpmTohhVWm(2,2,2), AmpSumHpmTohhVWm(2,2,2), AmpSum2HpmTohhVWm(2,2,2) 
Complex(dp) :: AmpTreeZHpmTohhVWm(2,2,2),AmpWaveZHpmTohhVWm(2,2,2),AmpVertexZHpmTohhVWm(2,2,2) 
Real(dp) :: AmpSqHpmTohhVWm(2,2),  AmpSqTreeHpmTohhVWm(2,2) 
Real(dp) :: MRPHpmToHpmVZ(2,2),MRGHpmToHpmVZ(2,2), MRPZHpmToHpmVZ(2,2),MRGZHpmToHpmVZ(2,2) 
Real(dp) :: MVPHpmToHpmVZ(2,2) 
Real(dp) :: RMsqTreeHpmToHpmVZ(2,2),RMsqWaveHpmToHpmVZ(2,2),RMsqVertexHpmToHpmVZ(2,2) 
Complex(dp) :: AmpTreeHpmToHpmVZ(2,2,2),AmpWaveHpmToHpmVZ(2,2,2),AmpVertexHpmToHpmVZ(2,2,2)& 
 & ,AmpVertexIRosHpmToHpmVZ(2,2,2),AmpVertexIRdrHpmToHpmVZ(2,2,2), AmpSumHpmToHpmVZ(2,2,2), AmpSum2HpmToHpmVZ(2,2,2) 
Complex(dp) :: AmpTreeZHpmToHpmVZ(2,2,2),AmpWaveZHpmToHpmVZ(2,2,2),AmpVertexZHpmToHpmVZ(2,2,2) 
Real(dp) :: AmpSqHpmToHpmVZ(2,2),  AmpSqTreeHpmToHpmVZ(2,2) 
Real(dp) :: MRPHpmTocSuSd(2,6,6),MRGHpmTocSuSd(2,6,6), MRPZHpmTocSuSd(2,6,6),MRGZHpmTocSuSd(2,6,6) 
Real(dp) :: MVPHpmTocSuSd(2,6,6) 
Real(dp) :: RMsqTreeHpmTocSuSd(2,6,6),RMsqWaveHpmTocSuSd(2,6,6),RMsqVertexHpmTocSuSd(2,6,6) 
Complex(dp) :: AmpTreeHpmTocSuSd(2,6,6),AmpWaveHpmTocSuSd(2,6,6),AmpVertexHpmTocSuSd(2,6,6)& 
 & ,AmpVertexIRosHpmTocSuSd(2,6,6),AmpVertexIRdrHpmTocSuSd(2,6,6), AmpSumHpmTocSuSd(2,6,6), AmpSum2HpmTocSuSd(2,6,6) 
Complex(dp) :: AmpTreeZHpmTocSuSd(2,6,6),AmpWaveZHpmTocSuSd(2,6,6),AmpVertexZHpmTocSuSd(2,6,6) 
Real(dp) :: AmpSqHpmTocSuSd(2,6,6),  AmpSqTreeHpmTocSuSd(2,6,6) 
Real(dp) :: MRPHpmTocSvSe(2,3,6),MRGHpmTocSvSe(2,3,6), MRPZHpmTocSvSe(2,3,6),MRGZHpmTocSvSe(2,3,6) 
Real(dp) :: MVPHpmTocSvSe(2,3,6) 
Real(dp) :: RMsqTreeHpmTocSvSe(2,3,6),RMsqWaveHpmTocSvSe(2,3,6),RMsqVertexHpmTocSvSe(2,3,6) 
Complex(dp) :: AmpTreeHpmTocSvSe(2,3,6),AmpWaveHpmTocSvSe(2,3,6),AmpVertexHpmTocSvSe(2,3,6)& 
 & ,AmpVertexIRosHpmTocSvSe(2,3,6),AmpVertexIRdrHpmTocSvSe(2,3,6), AmpSumHpmTocSvSe(2,3,6), AmpSum2HpmTocSvSe(2,3,6) 
Complex(dp) :: AmpTreeZHpmTocSvSe(2,3,6),AmpWaveZHpmTocSvSe(2,3,6),AmpVertexZHpmTocSvSe(2,3,6) 
Real(dp) :: AmpSqHpmTocSvSe(2,3,6),  AmpSqTreeHpmTocSvSe(2,3,6) 
Real(dp) :: MRPHpmToVZVWm(2),MRGHpmToVZVWm(2), MRPZHpmToVZVWm(2),MRGZHpmToVZVWm(2) 
Real(dp) :: MVPHpmToVZVWm(2) 
Real(dp) :: RMsqTreeHpmToVZVWm(2),RMsqWaveHpmToVZVWm(2),RMsqVertexHpmToVZVWm(2) 
Complex(dp) :: AmpTreeHpmToVZVWm(2,2),AmpWaveHpmToVZVWm(2,2),AmpVertexHpmToVZVWm(2,2)& 
 & ,AmpVertexIRosHpmToVZVWm(2,2),AmpVertexIRdrHpmToVZVWm(2,2), AmpSumHpmToVZVWm(2,2), AmpSum2HpmToVZVWm(2,2) 
Complex(dp) :: AmpTreeZHpmToVZVWm(2,2),AmpWaveZHpmToVZVWm(2,2),AmpVertexZHpmToVZVWm(2,2) 
Real(dp) :: AmpSqHpmToVZVWm(2),  AmpSqTreeHpmToVZVWm(2) 
Real(dp) :: MRPHpmToAhSe(2,2,6),MRGHpmToAhSe(2,2,6), MRPZHpmToAhSe(2,2,6),MRGZHpmToAhSe(2,2,6) 
Real(dp) :: MVPHpmToAhSe(2,2,6) 
Real(dp) :: RMsqTreeHpmToAhSe(2,2,6),RMsqWaveHpmToAhSe(2,2,6),RMsqVertexHpmToAhSe(2,2,6) 
Complex(dp) :: AmpTreeHpmToAhSe(2,2,6),AmpWaveHpmToAhSe(2,2,6),AmpVertexHpmToAhSe(2,2,6)& 
 & ,AmpVertexIRosHpmToAhSe(2,2,6),AmpVertexIRdrHpmToAhSe(2,2,6), AmpSumHpmToAhSe(2,2,6), AmpSum2HpmToAhSe(2,2,6) 
Complex(dp) :: AmpTreeZHpmToAhSe(2,2,6),AmpWaveZHpmToAhSe(2,2,6),AmpVertexZHpmToAhSe(2,2,6) 
Real(dp) :: AmpSqHpmToAhSe(2,2,6),  AmpSqTreeHpmToAhSe(2,2,6) 
Real(dp) :: MRPHpmToChaFv(2,2,3),MRGHpmToChaFv(2,2,3), MRPZHpmToChaFv(2,2,3),MRGZHpmToChaFv(2,2,3) 
Real(dp) :: MVPHpmToChaFv(2,2,3) 
Real(dp) :: RMsqTreeHpmToChaFv(2,2,3),RMsqWaveHpmToChaFv(2,2,3),RMsqVertexHpmToChaFv(2,2,3) 
Complex(dp) :: AmpTreeHpmToChaFv(2,2,2,3),AmpWaveHpmToChaFv(2,2,2,3),AmpVertexHpmToChaFv(2,2,2,3)& 
 & ,AmpVertexIRosHpmToChaFv(2,2,2,3),AmpVertexIRdrHpmToChaFv(2,2,2,3), AmpSumHpmToChaFv(2,2,2,3), AmpSum2HpmToChaFv(2,2,2,3) 
Complex(dp) :: AmpTreeZHpmToChaFv(2,2,2,3),AmpWaveZHpmToChaFv(2,2,2,3),AmpVertexZHpmToChaFv(2,2,2,3) 
Real(dp) :: AmpSqHpmToChaFv(2,2,3),  AmpSqTreeHpmToChaFv(2,2,3) 
Real(dp) :: MRPHpmToChiFe(2,4,3),MRGHpmToChiFe(2,4,3), MRPZHpmToChiFe(2,4,3),MRGZHpmToChiFe(2,4,3) 
Real(dp) :: MVPHpmToChiFe(2,4,3) 
Real(dp) :: RMsqTreeHpmToChiFe(2,4,3),RMsqWaveHpmToChiFe(2,4,3),RMsqVertexHpmToChiFe(2,4,3) 
Complex(dp) :: AmpTreeHpmToChiFe(2,2,4,3),AmpWaveHpmToChiFe(2,2,4,3),AmpVertexHpmToChiFe(2,2,4,3)& 
 & ,AmpVertexIRosHpmToChiFe(2,2,4,3),AmpVertexIRdrHpmToChiFe(2,2,4,3), AmpSumHpmToChiFe(2,2,4,3), AmpSum2HpmToChiFe(2,2,4,3) 
Complex(dp) :: AmpTreeZHpmToChiFe(2,2,4,3),AmpWaveZHpmToChiFe(2,2,4,3),AmpVertexZHpmToChiFe(2,2,4,3) 
Real(dp) :: AmpSqHpmToChiFe(2,4,3),  AmpSqTreeHpmToChiFe(2,4,3) 
Real(dp) :: MRPHpmTohhSe(2,2,6),MRGHpmTohhSe(2,2,6), MRPZHpmTohhSe(2,2,6),MRGZHpmTohhSe(2,2,6) 
Real(dp) :: MVPHpmTohhSe(2,2,6) 
Real(dp) :: RMsqTreeHpmTohhSe(2,2,6),RMsqWaveHpmTohhSe(2,2,6),RMsqVertexHpmTohhSe(2,2,6) 
Complex(dp) :: AmpTreeHpmTohhSe(2,2,6),AmpWaveHpmTohhSe(2,2,6),AmpVertexHpmTohhSe(2,2,6)& 
 & ,AmpVertexIRosHpmTohhSe(2,2,6),AmpVertexIRdrHpmTohhSe(2,2,6), AmpSumHpmTohhSe(2,2,6), AmpSum2HpmTohhSe(2,2,6) 
Complex(dp) :: AmpTreeZHpmTohhSe(2,2,6),AmpWaveZHpmTohhSe(2,2,6),AmpVertexZHpmTohhSe(2,2,6) 
Real(dp) :: AmpSqHpmTohhSe(2,2,6),  AmpSqTreeHpmTohhSe(2,2,6) 
Real(dp) :: MRPHpmToHpmSv(2,2,3),MRGHpmToHpmSv(2,2,3), MRPZHpmToHpmSv(2,2,3),MRGZHpmToHpmSv(2,2,3) 
Real(dp) :: MVPHpmToHpmSv(2,2,3) 
Real(dp) :: RMsqTreeHpmToHpmSv(2,2,3),RMsqWaveHpmToHpmSv(2,2,3),RMsqVertexHpmToHpmSv(2,2,3) 
Complex(dp) :: AmpTreeHpmToHpmSv(2,2,3),AmpWaveHpmToHpmSv(2,2,3),AmpVertexHpmToHpmSv(2,2,3)& 
 & ,AmpVertexIRosHpmToHpmSv(2,2,3),AmpVertexIRdrHpmToHpmSv(2,2,3), AmpSumHpmToHpmSv(2,2,3), AmpSum2HpmToHpmSv(2,2,3) 
Complex(dp) :: AmpTreeZHpmToHpmSv(2,2,3),AmpWaveZHpmToHpmSv(2,2,3),AmpVertexZHpmToHpmSv(2,2,3) 
Real(dp) :: AmpSqHpmToHpmSv(2,2,3),  AmpSqTreeHpmToHpmSv(2,2,3) 
Real(dp) :: MRPHpmToHpmVP(2,2),MRGHpmToHpmVP(2,2), MRPZHpmToHpmVP(2,2),MRGZHpmToHpmVP(2,2) 
Real(dp) :: MVPHpmToHpmVP(2,2) 
Real(dp) :: RMsqTreeHpmToHpmVP(2,2),RMsqWaveHpmToHpmVP(2,2),RMsqVertexHpmToHpmVP(2,2) 
Complex(dp) :: AmpTreeHpmToHpmVP(2,2,2),AmpWaveHpmToHpmVP(2,2,2),AmpVertexHpmToHpmVP(2,2,2)& 
 & ,AmpVertexIRosHpmToHpmVP(2,2,2),AmpVertexIRdrHpmToHpmVP(2,2,2), AmpSumHpmToHpmVP(2,2,2), AmpSum2HpmToHpmVP(2,2,2) 
Complex(dp) :: AmpTreeZHpmToHpmVP(2,2,2),AmpWaveZHpmToHpmVP(2,2,2),AmpVertexZHpmToHpmVP(2,2,2) 
Real(dp) :: AmpSqHpmToHpmVP(2,2),  AmpSqTreeHpmToHpmVP(2,2) 
Real(dp) :: MRPHpmToHpmcSv(2,2,3),MRGHpmToHpmcSv(2,2,3), MRPZHpmToHpmcSv(2,2,3),MRGZHpmToHpmcSv(2,2,3) 
Real(dp) :: MVPHpmToHpmcSv(2,2,3) 
Real(dp) :: RMsqTreeHpmToHpmcSv(2,2,3),RMsqWaveHpmToHpmcSv(2,2,3),RMsqVertexHpmToHpmcSv(2,2,3) 
Complex(dp) :: AmpTreeHpmToHpmcSv(2,2,3),AmpWaveHpmToHpmcSv(2,2,3),AmpVertexHpmToHpmcSv(2,2,3)& 
 & ,AmpVertexIRosHpmToHpmcSv(2,2,3),AmpVertexIRdrHpmToHpmcSv(2,2,3), AmpSumHpmToHpmcSv(2,2,3), AmpSum2HpmToHpmcSv(2,2,3) 
Complex(dp) :: AmpTreeZHpmToHpmcSv(2,2,3),AmpWaveZHpmToHpmcSv(2,2,3),AmpVertexZHpmToHpmcSv(2,2,3) 
Real(dp) :: AmpSqHpmToHpmcSv(2,2,3),  AmpSqTreeHpmToHpmcSv(2,2,3) 
Real(dp) :: MRPHpmToSeSv(2,6,3),MRGHpmToSeSv(2,6,3), MRPZHpmToSeSv(2,6,3),MRGZHpmToSeSv(2,6,3) 
Real(dp) :: MVPHpmToSeSv(2,6,3) 
Real(dp) :: RMsqTreeHpmToSeSv(2,6,3),RMsqWaveHpmToSeSv(2,6,3),RMsqVertexHpmToSeSv(2,6,3) 
Complex(dp) :: AmpTreeHpmToSeSv(2,6,3),AmpWaveHpmToSeSv(2,6,3),AmpVertexHpmToSeSv(2,6,3)& 
 & ,AmpVertexIRosHpmToSeSv(2,6,3),AmpVertexIRdrHpmToSeSv(2,6,3), AmpSumHpmToSeSv(2,6,3), AmpSum2HpmToSeSv(2,6,3) 
Complex(dp) :: AmpTreeZHpmToSeSv(2,6,3),AmpWaveZHpmToSeSv(2,6,3),AmpVertexZHpmToSeSv(2,6,3) 
Real(dp) :: AmpSqHpmToSeSv(2,6,3),  AmpSqTreeHpmToSeSv(2,6,3) 
Real(dp) :: MRPHpmToSeVP(2,6),MRGHpmToSeVP(2,6), MRPZHpmToSeVP(2,6),MRGZHpmToSeVP(2,6) 
Real(dp) :: MVPHpmToSeVP(2,6) 
Real(dp) :: RMsqTreeHpmToSeVP(2,6),RMsqWaveHpmToSeVP(2,6),RMsqVertexHpmToSeVP(2,6) 
Complex(dp) :: AmpTreeHpmToSeVP(2,2,6),AmpWaveHpmToSeVP(2,2,6),AmpVertexHpmToSeVP(2,2,6)& 
 & ,AmpVertexIRosHpmToSeVP(2,2,6),AmpVertexIRdrHpmToSeVP(2,2,6), AmpSumHpmToSeVP(2,2,6), AmpSum2HpmToSeVP(2,2,6) 
Complex(dp) :: AmpTreeZHpmToSeVP(2,2,6),AmpWaveZHpmToSeVP(2,2,6),AmpVertexZHpmToSeVP(2,2,6) 
Real(dp) :: AmpSqHpmToSeVP(2,6),  AmpSqTreeHpmToSeVP(2,6) 
Real(dp) :: MRPHpmToSeVZ(2,6),MRGHpmToSeVZ(2,6), MRPZHpmToSeVZ(2,6),MRGZHpmToSeVZ(2,6) 
Real(dp) :: MVPHpmToSeVZ(2,6) 
Real(dp) :: RMsqTreeHpmToSeVZ(2,6),RMsqWaveHpmToSeVZ(2,6),RMsqVertexHpmToSeVZ(2,6) 
Complex(dp) :: AmpTreeHpmToSeVZ(2,2,6),AmpWaveHpmToSeVZ(2,2,6),AmpVertexHpmToSeVZ(2,2,6)& 
 & ,AmpVertexIRosHpmToSeVZ(2,2,6),AmpVertexIRdrHpmToSeVZ(2,2,6), AmpSumHpmToSeVZ(2,2,6), AmpSum2HpmToSeVZ(2,2,6) 
Complex(dp) :: AmpTreeZHpmToSeVZ(2,2,6),AmpWaveZHpmToSeVZ(2,2,6),AmpVertexZHpmToSeVZ(2,2,6) 
Real(dp) :: AmpSqHpmToSeVZ(2,6),  AmpSqTreeHpmToSeVZ(2,6) 
Real(dp) :: MRPHpmToSvVWm(2,3),MRGHpmToSvVWm(2,3), MRPZHpmToSvVWm(2,3),MRGZHpmToSvVWm(2,3) 
Real(dp) :: MVPHpmToSvVWm(2,3) 
Real(dp) :: RMsqTreeHpmToSvVWm(2,3),RMsqWaveHpmToSvVWm(2,3),RMsqVertexHpmToSvVWm(2,3) 
Complex(dp) :: AmpTreeHpmToSvVWm(2,2,3),AmpWaveHpmToSvVWm(2,2,3),AmpVertexHpmToSvVWm(2,2,3)& 
 & ,AmpVertexIRosHpmToSvVWm(2,2,3),AmpVertexIRdrHpmToSvVWm(2,2,3), AmpSumHpmToSvVWm(2,2,3), AmpSum2HpmToSvVWm(2,2,3) 
Complex(dp) :: AmpTreeZHpmToSvVWm(2,2,3),AmpWaveZHpmToSvVWm(2,2,3),AmpVertexZHpmToSvVWm(2,2,3) 
Real(dp) :: AmpSqHpmToSvVWm(2,3),  AmpSqTreeHpmToSvVWm(2,3) 
Real(dp) :: MRPHpmToVPVWm(2),MRGHpmToVPVWm(2), MRPZHpmToVPVWm(2),MRGZHpmToVPVWm(2) 
Real(dp) :: MVPHpmToVPVWm(2) 
Real(dp) :: RMsqTreeHpmToVPVWm(2),RMsqWaveHpmToVPVWm(2),RMsqVertexHpmToVPVWm(2) 
Complex(dp) :: AmpTreeHpmToVPVWm(2,2),AmpWaveHpmToVPVWm(2,2),AmpVertexHpmToVPVWm(2,2)& 
 & ,AmpVertexIRosHpmToVPVWm(2,2),AmpVertexIRdrHpmToVPVWm(2,2), AmpSumHpmToVPVWm(2,2), AmpSum2HpmToVPVWm(2,2) 
Complex(dp) :: AmpTreeZHpmToVPVWm(2,2),AmpWaveZHpmToVPVWm(2,2),AmpVertexZHpmToVPVWm(2,2) 
Real(dp) :: AmpSqHpmToVPVWm(2),  AmpSqTreeHpmToVPVWm(2) 
Real(dp) :: MRPHpmTocSvVWm(2,3),MRGHpmTocSvVWm(2,3), MRPZHpmTocSvVWm(2,3),MRGZHpmTocSvVWm(2,3) 
Real(dp) :: MVPHpmTocSvVWm(2,3) 
Real(dp) :: RMsqTreeHpmTocSvVWm(2,3),RMsqWaveHpmTocSvVWm(2,3),RMsqVertexHpmTocSvVWm(2,3) 
Complex(dp) :: AmpTreeHpmTocSvVWm(2,2,3),AmpWaveHpmTocSvVWm(2,2,3),AmpVertexHpmTocSvVWm(2,2,3)& 
 & ,AmpVertexIRosHpmTocSvVWm(2,2,3),AmpVertexIRdrHpmTocSvVWm(2,2,3), AmpSumHpmTocSvVWm(2,2,3), AmpSum2HpmTocSvVWm(2,2,3) 
Complex(dp) :: AmpTreeZHpmTocSvVWm(2,2,3),AmpWaveZHpmTocSvVWm(2,2,3),AmpVertexZHpmTocSvVWm(2,2,3) 
Real(dp) :: AmpSqHpmTocSvVWm(2,3),  AmpSqTreeHpmTocSvVWm(2,3) 
Write(*,*) "Calculating one-loop decays of Hpm " 
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
! Hpm Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToHpmAh(cplAhHpmcHpm,MAh,MHpm,MAh2,MHpm2,           & 
& AmpTreeHpmToHpmAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToHpmAh(ZcplAhHpmcHpm,MAh,MHpm,MAh2,MHpm2,          & 
& AmpTreeHpmToHpmAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmAh(MLambda,em,gs,cplAhHpmcHpm,MAhOS,               & 
& MHpmOS,MRPHpmToHpmAh,MRGHpmToHpmAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmAh(MLambda,em,gs,ZcplAhHpmcHpm,MAhOS,              & 
& MHpmOS,MRPHpmToHpmAh,MRGHpmToHpmAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToHpmAh(MLambda,em,gs,cplAhHpmcHpm,MAh,MHpm,            & 
& MRPHpmToHpmAh,MRGHpmToHpmAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmAh(MLambda,em,gs,ZcplAhHpmcHpm,MAh,MHpm,           & 
& MRPHpmToHpmAh,MRGHpmToHpmAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmAh(cplAhHpmcHpm,ctcplAhHpmcHpm,MAh,            & 
& MAh2,MHpm,MHpm2,ZfAh,ZfHpm,AmpWaveHpmToHpmAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmAh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhcHpmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,      & 
& cplAhhhHpmcHpm1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,        & 
& cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,   & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexHpmToHpmAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhcHpmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,      & 
& cplAhhhHpmcHpm1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,        & 
& cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,   & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexIRdrHpmToHpmAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,ZcplAhHpmcHpm,cplAhHpmcVWm,          & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,   & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgWmcHpm,cplcgZgWpCHpm,       & 
& cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplHpmSucSd,        & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,          & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplAhHpmSucSdaa,& 
& cplAhHpmSvcSe1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,       & 
& cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1, & 
& cplHpmSucHpmcSuaa,AmpVertexIRosHpmToHpmAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,ZcplAhHpmcHpm,           & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhcHpmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,      & 
& cplAhhhHpmcHpm1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,        & 
& cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,   & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexIRosHpmToHpmAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,   & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgWmcHpm,cplcgZgWpCHpm,       & 
& cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplHpmSucSd,        & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,          & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplAhHpmSucSdaa,& 
& cplAhHpmSvcSe1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,       & 
& cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1, & 
& cplHpmSucHpmcSuaa,AmpVertexIRosHpmToHpmAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhcHpmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,      & 
& cplAhhhHpmcHpm1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,        & 
& cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,   & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexIRosHpmToHpmAh)

 End if 
 End if 
AmpVertexHpmToHpmAh = AmpVertexHpmToHpmAh -  AmpVertexIRdrHpmToHpmAh! +  AmpVertexIRosHpmToHpmAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToHpmAh=0._dp 
AmpVertexZHpmToHpmAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmAh(gt2,:,:) = AmpWaveZHpmToHpmAh(gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToHpmAh(gt1,:,:) 
AmpVertexZHpmToHpmAh(gt2,:,:)= AmpVertexZHpmToHpmAh(gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmToHpmAh(gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmToHpmAh=AmpWaveZHpmToHpmAh 
AmpVertexHpmToHpmAh= AmpVertexZHpmToHpmAh
! Final State 1 
AmpWaveZHpmToHpmAh=0._dp 
AmpVertexZHpmToHpmAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmAh(:,gt2,:) = AmpWaveZHpmToHpmAh(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToHpmAh(:,gt1,:) 
AmpVertexZHpmToHpmAh(:,gt2,:)= AmpVertexZHpmToHpmAh(:,gt2,:)+ZRUZP(gt2,gt1)*AmpVertexHpmToHpmAh(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmToHpmAh=AmpWaveZHpmToHpmAh 
AmpVertexHpmToHpmAh= AmpVertexZHpmToHpmAh
! Final State 2 
AmpWaveZHpmToHpmAh=0._dp 
AmpVertexZHpmToHpmAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmAh(:,:,gt2) = AmpWaveZHpmToHpmAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveHpmToHpmAh(:,:,gt1) 
AmpVertexZHpmToHpmAh(:,:,gt2)= AmpVertexZHpmToHpmAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexHpmToHpmAh(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmToHpmAh=AmpWaveZHpmToHpmAh 
AmpVertexHpmToHpmAh= AmpVertexZHpmToHpmAh
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToHpmAh = AmpVertexHpmToHpmAh  +  AmpVertexIRosHpmToHpmAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Hpm Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToHpmAh = AmpTreeHpmToHpmAh 
 AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh + 2._dp*AmpWaveHpmToHpmAh + 2._dp*AmpVertexHpmToHpmAh  
Else 
 AmpSumHpmToHpmAh = AmpTreeHpmToHpmAh + AmpWaveHpmToHpmAh + AmpVertexHpmToHpmAh
 AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh + AmpWaveHpmToHpmAh + AmpVertexHpmToHpmAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToHpmAh = AmpTreeHpmToHpmAh
 AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=2,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MHpmOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MHpm(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MAh(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToHpmAh(gt1, gt2, gt3) 
  AmpSum2HpmToHpmAh = 2._dp*AmpWaveHpmToHpmAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MAh(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToHpmAh(gt1, gt2, gt3) 
  AmpSum2HpmToHpmAh = 2._dp*AmpVertexHpmToHpmAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MAh(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToHpmAh(gt1, gt2, gt3) 
  AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh + 2._dp*AmpWaveHpmToHpmAh + 2._dp*AmpVertexHpmToHpmAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MAh(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToHpmAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
  AmpSqTreeHpmToHpmAh(gt1, gt2, gt3) = (1)*AmpSqHpmToHpmAh(gt1, gt2, gt3)  
  AmpSum2HpmToHpmAh = + 2._dp*AmpWaveHpmToHpmAh + 2._dp*AmpVertexHpmToHpmAh
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
  AmpSqHpmToHpmAh(gt1, gt2, gt3) = AmpSqHpmToHpmAh(gt1, gt2, gt3) + AmpSqTreeHpmToHpmAh(gt1, gt2, gt3)  
Else  
  AmpSum2HpmToHpmAh = AmpTreeHpmToHpmAh
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MAh(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
  AmpSqTreeHpmToHpmAh(gt1, gt2, gt3) = (1)*AmpSqHpmToHpmAh(gt1, gt2, gt3)  
  AmpSum2HpmToHpmAh = + 2._dp*AmpWaveHpmToHpmAh + 2._dp*AmpVertexHpmToHpmAh
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MAh(gt3),AmpSumHpmToHpmAh(gt1, gt2, gt3),AmpSum2HpmToHpmAh(gt1, gt2, gt3),AmpSqHpmToHpmAh(gt1, gt2, gt3)) 
  AmpSqHpmToHpmAh(gt1, gt2, gt3) = AmpSqHpmToHpmAh(gt1, gt2, gt3) + AmpSqTreeHpmToHpmAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmToHpmAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToHpmAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MHpmOS(gt2),MAhOS(gt3),helfactor*AmpSqHpmToHpmAh(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MHpm(gt2),MAh(gt3),helfactor*AmpSqHpmToHpmAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToHpmAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToHpmAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToHpmAh(gt1, gt2, gt3) + MRGHpmToHpmAh(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToHpmAh(gt1, gt2, gt3) + MRGHpmToHpmAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Ah VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToAhVWm(cplAhcHpmVWm,MAh,MHpm,MVWm,MAh2,            & 
& MHpm2,MVWm2,AmpTreeHpmToAhVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToAhVWm(ZcplAhcHpmVWm,MAh,MHpm,MVWm,MAh2,           & 
& MHpm2,MVWm2,AmpTreeHpmToAhVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToAhVWm(MLambda,em,gs,cplAhcHpmVWm,MAhOS,               & 
& MHpmOS,MVWmOS,MRPHpmToAhVWm,MRGHpmToAhVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToAhVWm(MLambda,em,gs,ZcplAhcHpmVWm,MAhOS,              & 
& MHpmOS,MVWmOS,MRPHpmToAhVWm,MRGHpmToAhVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToAhVWm(MLambda,em,gs,cplAhcHpmVWm,MAh,MHpm,            & 
& MVWm,MRPHpmToAhVWm,MRGHpmToAhVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToAhVWm(MLambda,em,gs,ZcplAhcHpmVWm,MAh,MHpm,           & 
& MVWm,MRPHpmToAhVWm,MRGHpmToAhVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToAhVWm(cplAhcHpmVWm,ctcplAhcHpmVWm,MAh,            & 
& MAh2,MHpm,MHpm2,MVWm,MVWm2,ZfAh,ZfHpm,ZfVWm,AmpWaveHpmToAhVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToAhVWm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWpCgAcHpm,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,  & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexHpmToAhVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWpCgAcHpm,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,  & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexIRdrHpmToAhVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,GosZcplAhHpmcHpm,cplAhHpmcVWm,       & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,ZcplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,          & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,   & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgZgWmcHpm,      & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,          & 
& cplSvcSeVWm,GosZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhcVWmVWm1,   & 
& cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmToAhVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,GZcplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,ZcplAhcHpmVWm,cplChiChacHpmL,            & 
& cplChiChacHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWpCgAcHpm,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,  & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,GZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,         & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmToAhVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,GcplAhHpmcHpm,cplAhHpmcVWm,          & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,           & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,   & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgZgWmcHpm,      & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,          & 
& cplSvcSeVWm,GcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhcVWmVWm1,      & 
& cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmToAhVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWpCgAcHpm,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,  & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmToAhVWm)

 End if 
 End if 
AmpVertexHpmToAhVWm = AmpVertexHpmToAhVWm -  AmpVertexIRdrHpmToAhVWm! +  AmpVertexIRosHpmToAhVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToAhVWm=0._dp 
AmpVertexZHpmToAhVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToAhVWm(:,gt2,:) = AmpWaveZHpmToAhVWm(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToAhVWm(:,gt1,:) 
AmpVertexZHpmToAhVWm(:,gt2,:)= AmpVertexZHpmToAhVWm(:,gt2,:) + ZRUZP(gt2,gt1)*AmpVertexHpmToAhVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmToAhVWm=AmpWaveZHpmToAhVWm 
AmpVertexHpmToAhVWm= AmpVertexZHpmToAhVWm
! Final State 1 
AmpWaveZHpmToAhVWm=0._dp 
AmpVertexZHpmToAhVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToAhVWm(:,:,gt2) = AmpWaveZHpmToAhVWm(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveHpmToAhVWm(:,:,gt1) 
AmpVertexZHpmToAhVWm(:,:,gt2)= AmpVertexZHpmToAhVWm(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexHpmToAhVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmToAhVWm=AmpWaveZHpmToAhVWm 
AmpVertexHpmToAhVWm= AmpVertexZHpmToAhVWm
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToAhVWm = AmpVertexHpmToAhVWm  +  AmpVertexIRosHpmToAhVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Ah VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToAhVWm = AmpTreeHpmToAhVWm 
 AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm + 2._dp*AmpWaveHpmToAhVWm + 2._dp*AmpVertexHpmToAhVWm  
Else 
 AmpSumHpmToAhVWm = AmpTreeHpmToAhVWm + AmpWaveHpmToAhVWm + AmpVertexHpmToAhVWm
 AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm + AmpWaveHpmToAhVWm + AmpVertexHpmToAhVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToAhVWm = AmpTreeHpmToAhVWm
 AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MAhOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MAh(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MAhOS(gt2),MVWmOS,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MAh(gt2),MVWm,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToAhVWm(gt1, gt2) 
  AmpSum2HpmToAhVWm = 2._dp*AmpWaveHpmToAhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MAhOS(gt2),MVWmOS,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MAh(gt2),MVWm,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToAhVWm(gt1, gt2) 
  AmpSum2HpmToAhVWm = 2._dp*AmpVertexHpmToAhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MAhOS(gt2),MVWmOS,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MAh(gt2),MVWm,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToAhVWm(gt1, gt2) 
  AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm + 2._dp*AmpWaveHpmToAhVWm + 2._dp*AmpVertexHpmToAhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MAhOS(gt2),MVWmOS,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MAh(gt2),MVWm,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToAhVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm
  Call SquareAmp_StoSV(MHpmOS(gt1),MAhOS(gt2),MVWmOS,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
  AmpSqTreeHpmToAhVWm(gt1, gt2) = (1)*AmpSqHpmToAhVWm(gt1, gt2)  
  AmpSum2HpmToAhVWm = + 2._dp*AmpWaveHpmToAhVWm + 2._dp*AmpVertexHpmToAhVWm
  Call SquareAmp_StoSV(MHpmOS(gt1),MAhOS(gt2),MVWmOS,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
  AmpSqHpmToAhVWm(gt1, gt2) = AmpSqHpmToAhVWm(gt1, gt2) + AmpSqTreeHpmToAhVWm(gt1, gt2)  
Else  
  AmpSum2HpmToAhVWm = AmpTreeHpmToAhVWm
  Call SquareAmp_StoSV(MHpm(gt1),MAh(gt2),MVWm,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
  AmpSqTreeHpmToAhVWm(gt1, gt2) = (1)*AmpSqHpmToAhVWm(gt1, gt2)  
  AmpSum2HpmToAhVWm = + 2._dp*AmpWaveHpmToAhVWm + 2._dp*AmpVertexHpmToAhVWm
  Call SquareAmp_StoSV(MHpm(gt1),MAh(gt2),MVWm,AmpSumHpmToAhVWm(:,gt1, gt2),AmpSum2HpmToAhVWm(:,gt1, gt2),AmpSqHpmToAhVWm(gt1, gt2)) 
  AmpSqHpmToAhVWm(gt1, gt2) = AmpSqHpmToAhVWm(gt1, gt2) + AmpSqTreeHpmToAhVWm(gt1, gt2)  
End if  
Else  
  AmpSqHpmToAhVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToAhVWm(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MAhOS(gt2),MVWmOS,helfactor*AmpSqHpmToAhVWm(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MAh(gt2),MVWm,helfactor*AmpSqHpmToAhVWm(gt1, gt2))
End if 
If ((Abs(MRPHpmToAhVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToAhVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToAhVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToAhVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPHpmToAhVWm(gt1, gt2) + MRGHpmToAhVWm(gt1, gt2)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1*helfactor*(MRPHpmToAhVWm(gt1, gt2) + MRGHpmToAhVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Chi Cha
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToChiCha(cplChiChacHpmL,cplChiChacHpmR,             & 
& MCha,MChi,MHpm,MCha2,MChi2,MHpm2,AmpTreeHpmToChiCha)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToChiCha(ZcplChiChacHpmL,ZcplChiChacHpmR,           & 
& MCha,MChi,MHpm,MCha2,MChi2,MHpm2,AmpTreeHpmToChiCha)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToChiCha(MLambda,em,gs,cplChiChacHpmL,cplChiChacHpmR,   & 
& MChaOS,MChiOS,MHpmOS,MRPHpmToChiCha,MRGHpmToChiCha)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToChiCha(MLambda,em,gs,ZcplChiChacHpmL,ZcplChiChacHpmR, & 
& MChaOS,MChiOS,MHpmOS,MRPHpmToChiCha,MRGHpmToChiCha)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToChiCha(MLambda,em,gs,cplChiChacHpmL,cplChiChacHpmR,   & 
& MCha,MChi,MHpm,MRPHpmToChiCha,MRGHpmToChiCha)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToChiCha(MLambda,em,gs,ZcplChiChacHpmL,ZcplChiChacHpmR, & 
& MCha,MChi,MHpm,MRPHpmToChiCha,MRGHpmToChiCha)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChiCha(cplChiChacHpmL,cplChiChacHpmR,             & 
& ctcplChiChacHpmL,ctcplChiChacHpmR,MCha,MCha2,MChi,MChi2,MHpm,MHpm2,ZfHpm,              & 
& ZfL0,ZfLm,ZfLp,AmpWaveHpmToChiCha)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChiCha(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,      & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,   & 
& cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexHpmToChiCha)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,      & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,   & 
& cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRdrHpmToChiCha)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,      & 
& cplAhHpmcHpm,cplAhcHpmVWm,ZcplChiChacHpmL,ZcplChiChacHpmR,cplChiChacVWmL,              & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,      & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,   & 
& cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToChiCha)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhcHpmVWm,ZcplChiChacHpmL,ZcplChiChacHpmR,cplChiChacVWmL, & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,      & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,   & 
& cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToChiCha)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,      & 
& cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,   & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,         & 
& cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToChiCha)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,      & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,   & 
& cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToChiCha)

 End if 
 End if 
AmpVertexHpmToChiCha = AmpVertexHpmToChiCha -  AmpVertexIRdrHpmToChiCha! +  AmpVertexIRosHpmToChiCha ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToChiCha=0._dp 
AmpVertexZHpmToChiCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToChiCha(:,gt2,:,:) = AmpWaveZHpmToChiCha(:,gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToChiCha(:,gt1,:,:) 
AmpVertexZHpmToChiCha(:,gt2,:,:)= AmpVertexZHpmToChiCha(:,gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmToChiCha(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmToChiCha=AmpWaveZHpmToChiCha 
AmpVertexHpmToChiCha= AmpVertexZHpmToChiCha
! Final State 1 
AmpWaveZHpmToChiCha=0._dp 
AmpVertexZHpmToChiCha=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZHpmToChiCha(1,:,gt2,:) = AmpWaveZHpmToChiCha(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpWaveHpmToChiCha(1,:,gt1,:) 
AmpVertexZHpmToChiCha(1,:,gt2,:)= AmpVertexZHpmToChiCha(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpVertexHpmToChiCha(1,:,gt1,:) 
AmpWaveZHpmToChiCha(2,:,gt2,:) = AmpWaveZHpmToChiCha(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpWaveHpmToChiCha(2,:,gt1,:) 
AmpVertexZHpmToChiCha(2,:,gt2,:)= AmpVertexZHpmToChiCha(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpVertexHpmToChiCha(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmToChiCha=AmpWaveZHpmToChiCha 
AmpVertexHpmToChiCha= AmpVertexZHpmToChiCha
! Final State 2 
AmpWaveZHpmToChiCha=0._dp 
AmpVertexZHpmToChiCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToChiCha(1,:,:,gt2) = AmpWaveZHpmToChiCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpWaveHpmToChiCha(1,:,:,gt1) 
AmpVertexZHpmToChiCha(1,:,:,gt2)= AmpVertexZHpmToChiCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexHpmToChiCha(1,:,:,gt1) 
AmpWaveZHpmToChiCha(2,:,:,gt2) = AmpWaveZHpmToChiCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpWaveHpmToChiCha(2,:,:,gt1) 
AmpVertexZHpmToChiCha(2,:,:,gt2)= AmpVertexZHpmToChiCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpVertexHpmToChiCha(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmToChiCha=AmpWaveZHpmToChiCha 
AmpVertexHpmToChiCha= AmpVertexZHpmToChiCha
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToChiCha = AmpVertexHpmToChiCha  +  AmpVertexIRosHpmToChiCha
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Chi Cha -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToChiCha = AmpTreeHpmToChiCha 
 AmpSum2HpmToChiCha = AmpTreeHpmToChiCha + 2._dp*AmpWaveHpmToChiCha + 2._dp*AmpVertexHpmToChiCha  
Else 
 AmpSumHpmToChiCha = AmpTreeHpmToChiCha + AmpWaveHpmToChiCha + AmpVertexHpmToChiCha
 AmpSum2HpmToChiCha = AmpTreeHpmToChiCha + AmpWaveHpmToChiCha + AmpVertexHpmToChiCha 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToChiCha = AmpTreeHpmToChiCha
 AmpSum2HpmToChiCha = AmpTreeHpmToChiCha 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=1,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MChiOS(gt2)+MChaOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MChi(gt2)+MCha(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmToChiCha = AmpTreeHpmToChiCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MCha(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToChiCha(gt1, gt2, gt3) 
  AmpSum2HpmToChiCha = 2._dp*AmpWaveHpmToChiCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MCha(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToChiCha(gt1, gt2, gt3) 
  AmpSum2HpmToChiCha = 2._dp*AmpVertexHpmToChiCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MCha(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToChiCha(gt1, gt2, gt3) 
  AmpSum2HpmToChiCha = AmpTreeHpmToChiCha + 2._dp*AmpWaveHpmToChiCha + 2._dp*AmpVertexHpmToChiCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MCha(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToChiCha(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToChiCha = AmpTreeHpmToChiCha
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
  AmpSqTreeHpmToChiCha(gt1, gt2, gt3) = (1)*AmpSqHpmToChiCha(gt1, gt2, gt3)  
  AmpSum2HpmToChiCha = + 2._dp*AmpWaveHpmToChiCha + 2._dp*AmpVertexHpmToChiCha
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
  AmpSqHpmToChiCha(gt1, gt2, gt3) = AmpSqHpmToChiCha(gt1, gt2, gt3) + AmpSqTreeHpmToChiCha(gt1, gt2, gt3)  
Else  
  AmpSum2HpmToChiCha = AmpTreeHpmToChiCha
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MCha(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
  AmpSqTreeHpmToChiCha(gt1, gt2, gt3) = (1)*AmpSqHpmToChiCha(gt1, gt2, gt3)  
  AmpSum2HpmToChiCha = + 2._dp*AmpWaveHpmToChiCha + 2._dp*AmpVertexHpmToChiCha
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MCha(gt3),AmpSumHpmToChiCha(:,gt1, gt2, gt3),AmpSum2HpmToChiCha(:,gt1, gt2, gt3),AmpSqHpmToChiCha(gt1, gt2, gt3)) 
  AmpSqHpmToChiCha(gt1, gt2, gt3) = AmpSqHpmToChiCha(gt1, gt2, gt3) + AmpSqTreeHpmToChiCha(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmToChiCha(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqHpmToChiCha(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MChiOS(gt2),MChaOS(gt3),helfactor*AmpSqHpmToChiCha(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MChi(gt2),MCha(gt3),helfactor*AmpSqHpmToChiCha(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToChiCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToChiCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToChiCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToChiCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToChiCha(gt1, gt2, gt3) + MRGHpmToChiCha(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToChiCha(gt1, gt2, gt3) + MRGHpmToChiCha(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! bar(Fu) Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmTocFuFd(cplcFuFdcHpmL,cplcFuFdcHpmR,MFd,            & 
& MFu,MHpm,MFd2,MFu2,MHpm2,AmpTreeHpmTocFuFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmTocFuFd(ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,              & 
& MFd,MFu,MHpm,MFd2,MFu2,MHpm2,AmpTreeHpmTocFuFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocFuFd(MLambda,em,gs,cplcFuFdcHpmL,cplcFuFdcHpmR,      & 
& MFdOS,MFuOS,MHpmOS,MRPHpmTocFuFd,MRGHpmTocFuFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocFuFd(MLambda,em,gs,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,    & 
& MFdOS,MFuOS,MHpmOS,MRPHpmTocFuFd,MRGHpmTocFuFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmTocFuFd(MLambda,em,gs,cplcFuFdcHpmL,cplcFuFdcHpmR,      & 
& MFd,MFu,MHpm,MRPHpmTocFuFd,MRGHpmTocFuFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocFuFd(MLambda,em,gs,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,    & 
& MFd,MFu,MHpm,MRPHpmTocFuFd,MRGHpmTocFuFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmTocFuFd(cplcFuFdcHpmL,cplcFuFdcHpmR,ctcplcFuFdcHpmL,& 
& ctcplcFuFdcHpmR,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,ZfFDL,ZfFDR,ZfFUL,ZfFUR,ZfHpm,            & 
& AmpWaveHpmTocFuFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,       & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,cplcFuFuhhR,         & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSecHpmcSv,       & 
& cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexHpmTocFuFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,          & 
& cplChiChacHpmR,cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,      & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,        & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,          & 
& cplHpmcHpmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,       & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRdrHpmTocFuFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFdcSdL,      & 
& cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,   & 
& cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,              & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplcChacFuSdL,        & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,        & 
& cplcHpmVWmVZ,AmpVertexIRosHpmTocFuFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,          & 
& cplChiChacHpmR,cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,cplcFuFdcSeL,    & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,        & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,          & 
& cplHpmcHpmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,       & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmTocFuFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFdcSdL,      & 
& cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,     & 
& cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,              & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplcChacFuSdL,        & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,        & 
& cplcHpmVWmVZ,AmpVertexIRosHpmTocFuFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,          & 
& cplChiChacHpmR,cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,      & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,        & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,          & 
& cplHpmcHpmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,       & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmTocFuFd)

 End if 
 End if 
AmpVertexHpmTocFuFd = AmpVertexHpmTocFuFd -  AmpVertexIRdrHpmTocFuFd! +  AmpVertexIRosHpmTocFuFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmTocFuFd=0._dp 
AmpVertexZHpmTocFuFd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmTocFuFd(:,gt2,:,:) = AmpWaveZHpmTocFuFd(:,gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmTocFuFd(:,gt1,:,:) 
AmpVertexZHpmTocFuFd(:,gt2,:,:)= AmpVertexZHpmTocFuFd(:,gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmTocFuFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmTocFuFd=AmpWaveZHpmTocFuFd 
AmpVertexHpmTocFuFd= AmpVertexZHpmTocFuFd
! Final State 1 
AmpWaveZHpmTocFuFd=0._dp 
AmpVertexZHpmTocFuFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZHpmTocFuFd(1,:,gt2,:) = AmpWaveZHpmTocFuFd(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveHpmTocFuFd(1,:,gt1,:) 
AmpVertexZHpmTocFuFd(1,:,gt2,:)= AmpVertexZHpmTocFuFd(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpVertexHpmTocFuFd(1,:,gt1,:) 
AmpWaveZHpmTocFuFd(2,:,gt2,:) = AmpWaveZHpmTocFuFd(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveHpmTocFuFd(2,:,gt1,:) 
AmpVertexZHpmTocFuFd(2,:,gt2,:)= AmpVertexZHpmTocFuFd(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpVertexHpmTocFuFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmTocFuFd=AmpWaveZHpmTocFuFd 
AmpVertexHpmTocFuFd= AmpVertexZHpmTocFuFd
! Final State 2 
AmpWaveZHpmTocFuFd=0._dp 
AmpVertexZHpmTocFuFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZHpmTocFuFd(1,:,:,gt2) = AmpWaveZHpmTocFuFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveHpmTocFuFd(1,:,:,gt1) 
AmpVertexZHpmTocFuFd(1,:,:,gt2)= AmpVertexZHpmTocFuFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexHpmTocFuFd(1,:,:,gt1) 
AmpWaveZHpmTocFuFd(2,:,:,gt2) = AmpWaveZHpmTocFuFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveHpmTocFuFd(2,:,:,gt1) 
AmpVertexZHpmTocFuFd(2,:,:,gt2)= AmpVertexZHpmTocFuFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexHpmTocFuFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmTocFuFd=AmpWaveZHpmTocFuFd 
AmpVertexHpmTocFuFd= AmpVertexZHpmTocFuFd
End if
If (ShiftIRdiv) Then 
AmpVertexHpmTocFuFd = AmpVertexHpmTocFuFd  +  AmpVertexIRosHpmTocFuFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->bar[Fu] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmTocFuFd = AmpTreeHpmTocFuFd 
 AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd + 2._dp*AmpWaveHpmTocFuFd + 2._dp*AmpVertexHpmTocFuFd  
Else 
 AmpSumHpmTocFuFd = AmpTreeHpmTocFuFd + AmpWaveHpmTocFuFd + AmpVertexHpmTocFuFd
 AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd + AmpWaveHpmTocFuFd + AmpVertexHpmTocFuFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmTocFuFd = AmpTreeHpmTocFuFd
 AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MFuOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MFu(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MFu(gt2),MFd(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmTocFuFd(gt1, gt2, gt3) 
  AmpSum2HpmTocFuFd = 2._dp*AmpWaveHpmTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MFu(gt2),MFd(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmTocFuFd(gt1, gt2, gt3) 
  AmpSum2HpmTocFuFd = 2._dp*AmpVertexHpmTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MFu(gt2),MFd(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmTocFuFd(gt1, gt2, gt3) 
  AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd + 2._dp*AmpWaveHpmTocFuFd + 2._dp*AmpVertexHpmTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MFu(gt2),MFd(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmTocFuFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd
  Call SquareAmp_StoFF(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
  AmpSqTreeHpmTocFuFd(gt1, gt2, gt3) = (3)*AmpSqHpmTocFuFd(gt1, gt2, gt3)  
  AmpSum2HpmTocFuFd = + 2._dp*AmpWaveHpmTocFuFd + 2._dp*AmpVertexHpmTocFuFd
  Call SquareAmp_StoFF(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
  AmpSqHpmTocFuFd(gt1, gt2, gt3) = AmpSqHpmTocFuFd(gt1, gt2, gt3) + AmpSqTreeHpmTocFuFd(gt1, gt2, gt3)  
Else  
  AmpSum2HpmTocFuFd = AmpTreeHpmTocFuFd
  Call SquareAmp_StoFF(MHpm(gt1),MFu(gt2),MFd(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
  AmpSqTreeHpmTocFuFd(gt1, gt2, gt3) = (3)*AmpSqHpmTocFuFd(gt1, gt2, gt3)  
  AmpSum2HpmTocFuFd = + 2._dp*AmpWaveHpmTocFuFd + 2._dp*AmpVertexHpmTocFuFd
  Call SquareAmp_StoFF(MHpm(gt1),MFu(gt2),MFd(gt3),AmpSumHpmTocFuFd(:,gt1, gt2, gt3),AmpSum2HpmTocFuFd(:,gt1, gt2, gt3),AmpSqHpmTocFuFd(gt1, gt2, gt3)) 
  AmpSqHpmTocFuFd(gt1, gt2, gt3) = AmpSqHpmTocFuFd(gt1, gt2, gt3) + AmpSqTreeHpmTocFuFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmTocFuFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqHpmTocFuFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MFuOS(gt2),MFdOS(gt3),helfactor*AmpSqHpmTocFuFd(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MFu(gt2),MFd(gt3),helfactor*AmpSqHpmTocFuFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmTocFuFd(gt1, gt2, gt3) + MRGHpmTocFuFd(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmTocFuFd(gt1, gt2, gt3) + MRGHpmTocFuFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fv Fe
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToFvFe(cplFvFecHpmL,cplFvFecHpmR,MFe,               & 
& MHpm,MFe2,MHpm2,AmpTreeHpmToFvFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToFvFe(ZcplFvFecHpmL,ZcplFvFecHpmR,MFe,             & 
& MHpm,MFe2,MHpm2,AmpTreeHpmToFvFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToFvFe(MLambda,em,gs,cplFvFecHpmL,cplFvFecHpmR,         & 
& MFeOS,MHpmOS,MRPHpmToFvFe,MRGHpmToFvFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToFvFe(MLambda,em,gs,ZcplFvFecHpmL,ZcplFvFecHpmR,       & 
& MFeOS,MHpmOS,MRPHpmToFvFe,MRGHpmToFvFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToFvFe(MLambda,em,gs,cplFvFecHpmL,cplFvFecHpmR,         & 
& MFe,MHpm,MRPHpmToFvFe,MRGHpmToFvFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToFvFe(MLambda,em,gs,ZcplFvFecHpmL,ZcplFvFecHpmR,       & 
& MFe,MHpm,MRPHpmToFvFe,MRGHpmToFvFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToFvFe(cplFvFecHpmL,cplFvFecHpmR,ctcplFvFecHpmL,    & 
& ctcplFvFecHpmR,MFe,MFe2,MHpm,MHpm2,ZfFEL,ZfFER,ZfFvL,ZfHpm,AmpWaveHpmToFvFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,              & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,      & 
& cplChiFvSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,           & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,             & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexHpmToFvFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,        & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,      & 
& cplChiFvSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,           & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,             & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRdrHpmToFvFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,cplAhcHpmVWm,          & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,       & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,cplFeFucSdR,           & 
& ZcplFvFecHpmL,ZcplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,         & 
& cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToFvFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,        & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,      & 
& cplChiFvSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,           & 
& cplFeFucSdR,ZcplFvFecHpmL,ZcplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,          & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,             & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToFvFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,cplAhcHpmVWm,          & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,       & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,         & 
& cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToFvFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,        & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,      & 
& cplChiFvSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,           & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,             & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosHpmToFvFe)

 End if 
 End if 
AmpVertexHpmToFvFe = AmpVertexHpmToFvFe -  AmpVertexIRdrHpmToFvFe! +  AmpVertexIRosHpmToFvFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToFvFe=0._dp 
AmpVertexZHpmToFvFe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToFvFe(:,gt2,:,:) = AmpWaveZHpmToFvFe(:,gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToFvFe(:,gt1,:,:) 
AmpVertexZHpmToFvFe(:,gt2,:,:)= AmpVertexZHpmToFvFe(:,gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmToFvFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmToFvFe=AmpWaveZHpmToFvFe 
AmpVertexHpmToFvFe= AmpVertexZHpmToFvFe
! Final State 1 
AmpWaveZHpmToFvFe=0._dp 
AmpVertexZHpmToFvFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZHpmToFvFe(1,:,gt2,:) = AmpWaveZHpmToFvFe(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpWaveHpmToFvFe(1,:,gt1,:) 
AmpVertexZHpmToFvFe(1,:,gt2,:)= AmpVertexZHpmToFvFe(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpVertexHpmToFvFe(1,:,gt1,:) 
AmpWaveZHpmToFvFe(2,:,gt2,:) = AmpWaveZHpmToFvFe(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpWaveHpmToFvFe(2,:,gt1,:) 
AmpVertexZHpmToFvFe(2,:,gt2,:)= AmpVertexZHpmToFvFe(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpVertexHpmToFvFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmToFvFe=AmpWaveZHpmToFvFe 
AmpVertexHpmToFvFe= AmpVertexZHpmToFvFe
! Final State 2 
AmpWaveZHpmToFvFe=0._dp 
AmpVertexZHpmToFvFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZHpmToFvFe(1,:,:,gt2) = AmpWaveZHpmToFvFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWaveHpmToFvFe(1,:,:,gt1) 
AmpVertexZHpmToFvFe(1,:,:,gt2)= AmpVertexZHpmToFvFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexHpmToFvFe(1,:,:,gt1) 
AmpWaveZHpmToFvFe(2,:,:,gt2) = AmpWaveZHpmToFvFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWaveHpmToFvFe(2,:,:,gt1) 
AmpVertexZHpmToFvFe(2,:,:,gt2)= AmpVertexZHpmToFvFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexHpmToFvFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmToFvFe=AmpWaveZHpmToFvFe 
AmpVertexHpmToFvFe= AmpVertexZHpmToFvFe
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToFvFe = AmpVertexHpmToFvFe  +  AmpVertexIRosHpmToFvFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Fv Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToFvFe = AmpTreeHpmToFvFe 
 AmpSum2HpmToFvFe = AmpTreeHpmToFvFe + 2._dp*AmpWaveHpmToFvFe + 2._dp*AmpVertexHpmToFvFe  
Else 
 AmpSumHpmToFvFe = AmpTreeHpmToFvFe + AmpWaveHpmToFvFe + AmpVertexHpmToFvFe
 AmpSum2HpmToFvFe = AmpTreeHpmToFvFe + AmpWaveHpmToFvFe + AmpVertexHpmToFvFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToFvFe = AmpTreeHpmToFvFe
 AmpSum2HpmToFvFe = AmpTreeHpmToFvFe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(0.+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(0.+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmToFvFe = AmpTreeHpmToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),0._dp,MFeOS(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),0._dp,MFe(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToFvFe(gt1, gt2, gt3) 
  AmpSum2HpmToFvFe = 2._dp*AmpWaveHpmToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),0._dp,MFeOS(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),0._dp,MFe(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToFvFe(gt1, gt2, gt3) 
  AmpSum2HpmToFvFe = 2._dp*AmpVertexHpmToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),0._dp,MFeOS(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),0._dp,MFe(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToFvFe(gt1, gt2, gt3) 
  AmpSum2HpmToFvFe = AmpTreeHpmToFvFe + 2._dp*AmpWaveHpmToFvFe + 2._dp*AmpVertexHpmToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),0._dp,MFeOS(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),0._dp,MFe(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToFvFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToFvFe = AmpTreeHpmToFvFe
  Call SquareAmp_StoFF(MHpmOS(gt1),0._dp,MFeOS(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
  AmpSqTreeHpmToFvFe(gt1, gt2, gt3) = (1)*AmpSqHpmToFvFe(gt1, gt2, gt3)  
  AmpSum2HpmToFvFe = + 2._dp*AmpWaveHpmToFvFe + 2._dp*AmpVertexHpmToFvFe
  Call SquareAmp_StoFF(MHpmOS(gt1),0._dp,MFeOS(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
  AmpSqHpmToFvFe(gt1, gt2, gt3) = AmpSqHpmToFvFe(gt1, gt2, gt3) + AmpSqTreeHpmToFvFe(gt1, gt2, gt3)  
Else  
  AmpSum2HpmToFvFe = AmpTreeHpmToFvFe
  Call SquareAmp_StoFF(MHpm(gt1),0._dp,MFe(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
  AmpSqTreeHpmToFvFe(gt1, gt2, gt3) = (1)*AmpSqHpmToFvFe(gt1, gt2, gt3)  
  AmpSum2HpmToFvFe = + 2._dp*AmpWaveHpmToFvFe + 2._dp*AmpVertexHpmToFvFe
  Call SquareAmp_StoFF(MHpm(gt1),0._dp,MFe(gt3),AmpSumHpmToFvFe(:,gt1, gt2, gt3),AmpSum2HpmToFvFe(:,gt1, gt2, gt3),AmpSqHpmToFvFe(gt1, gt2, gt3)) 
  AmpSqHpmToFvFe(gt1, gt2, gt3) = AmpSqHpmToFvFe(gt1, gt2, gt3) + AmpSqTreeHpmToFvFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmToFvFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqHpmToFvFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),0._dp,MFeOS(gt3),helfactor*AmpSqHpmToFvFe(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),0._dp,MFe(gt3),helfactor*AmpSqHpmToFvFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToFvFe(gt1, gt2, gt3) + MRGHpmToFvFe(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToFvFe(gt1, gt2, gt3) + MRGHpmToFvFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Hpm hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToHpmhh(cplhhHpmcHpm,Mhh,MHpm,Mhh2,MHpm2,           & 
& AmpTreeHpmToHpmhh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToHpmhh(ZcplhhHpmcHpm,Mhh,MHpm,Mhh2,MHpm2,          & 
& AmpTreeHpmToHpmhh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmhh(MLambda,em,gs,cplhhHpmcHpm,MhhOS,               & 
& MHpmOS,MRPHpmToHpmhh,MRGHpmToHpmhh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmhh(MLambda,em,gs,ZcplhhHpmcHpm,MhhOS,              & 
& MHpmOS,MRPHpmToHpmhh,MRGHpmToHpmhh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToHpmhh(MLambda,em,gs,cplhhHpmcHpm,Mhh,MHpm,            & 
& MRPHpmToHpmhh,MRGHpmToHpmhh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmhh(MLambda,em,gs,ZcplhhHpmcHpm,Mhh,MHpm,           & 
& MRPHpmToHpmhh,MRGHpmToHpmhh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmhh(cplhhHpmcHpm,ctcplhhHpmcHpm,Mhh,            & 
& Mhh2,MHpm,MHpm2,Zfhh,ZfHpm,AmpWaveHpmToHpmhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmhh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,     & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmhh,          & 
& cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcHpm,     & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,              & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,         & 
& cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhHpmSucSdaa,          & 
& cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,cplhhSecHpmcSv1,       & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1, & 
& cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,AmpVertexHpmToHpmhh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,   & 
& cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,cplcgWmgZHpm,       & 
& cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,              & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,     & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,         & 
& cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,             & 
& cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,       & 
& cplhhSecHpmcSv1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,  & 
& cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,& 
& AmpVertexIRdrHpmToHpmhh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmhh,          & 
& cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcHpm,     & 
& cplhhhhhh,ZcplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,      & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,              & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,         & 
& cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhHpmSucSdaa,          & 
& cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,cplhhSecHpmcSv1,       & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1, & 
& cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,AmpVertexIRosHpmToHpmhh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,   & 
& cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,cplcgWmgZHpm,       & 
& cplcgWpCgZcHpm,cplhhhhhh,ZcplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,             & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,     & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,         & 
& cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,             & 
& cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,       & 
& cplhhSecHpmcSv1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,  & 
& cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,& 
& AmpVertexIRosHpmToHpmhh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmhh,          & 
& cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcHpm,     & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,              & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,         & 
& cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhHpmSucSdaa,          & 
& cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,cplhhSecHpmcSv1,       & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1, & 
& cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,AmpVertexIRosHpmToHpmhh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,   & 
& cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,cplcgWmgZHpm,       & 
& cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,              & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,     & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,         & 
& cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,             & 
& cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,       & 
& cplhhSecHpmcSv1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,  & 
& cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,& 
& AmpVertexIRosHpmToHpmhh)

 End if 
 End if 
AmpVertexHpmToHpmhh = AmpVertexHpmToHpmhh -  AmpVertexIRdrHpmToHpmhh! +  AmpVertexIRosHpmToHpmhh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToHpmhh=0._dp 
AmpVertexZHpmToHpmhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmhh(gt2,:,:) = AmpWaveZHpmToHpmhh(gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToHpmhh(gt1,:,:) 
AmpVertexZHpmToHpmhh(gt2,:,:)= AmpVertexZHpmToHpmhh(gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmToHpmhh(gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmToHpmhh=AmpWaveZHpmToHpmhh 
AmpVertexHpmToHpmhh= AmpVertexZHpmToHpmhh
! Final State 1 
AmpWaveZHpmToHpmhh=0._dp 
AmpVertexZHpmToHpmhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmhh(:,gt2,:) = AmpWaveZHpmToHpmhh(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToHpmhh(:,gt1,:) 
AmpVertexZHpmToHpmhh(:,gt2,:)= AmpVertexZHpmToHpmhh(:,gt2,:)+ZRUZP(gt2,gt1)*AmpVertexHpmToHpmhh(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmToHpmhh=AmpWaveZHpmToHpmhh 
AmpVertexHpmToHpmhh= AmpVertexZHpmToHpmhh
! Final State 2 
AmpWaveZHpmToHpmhh=0._dp 
AmpVertexZHpmToHpmhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmhh(:,:,gt2) = AmpWaveZHpmToHpmhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveHpmToHpmhh(:,:,gt1) 
AmpVertexZHpmToHpmhh(:,:,gt2)= AmpVertexZHpmToHpmhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexHpmToHpmhh(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmToHpmhh=AmpWaveZHpmToHpmhh 
AmpVertexHpmToHpmhh= AmpVertexZHpmToHpmhh
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToHpmhh = AmpVertexHpmToHpmhh  +  AmpVertexIRosHpmToHpmhh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Hpm hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToHpmhh = AmpTreeHpmToHpmhh 
 AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh + 2._dp*AmpWaveHpmToHpmhh + 2._dp*AmpVertexHpmToHpmhh  
Else 
 AmpSumHpmToHpmhh = AmpTreeHpmToHpmhh + AmpWaveHpmToHpmhh + AmpVertexHpmToHpmhh
 AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh + AmpWaveHpmToHpmhh + AmpVertexHpmToHpmhh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToHpmhh = AmpTreeHpmToHpmhh
 AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MHpmOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MHpm(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),Mhh(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToHpmhh(gt1, gt2, gt3) 
  AmpSum2HpmToHpmhh = 2._dp*AmpWaveHpmToHpmhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),Mhh(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToHpmhh(gt1, gt2, gt3) 
  AmpSum2HpmToHpmhh = 2._dp*AmpVertexHpmToHpmhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),Mhh(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToHpmhh(gt1, gt2, gt3) 
  AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh + 2._dp*AmpWaveHpmToHpmhh + 2._dp*AmpVertexHpmToHpmhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),Mhh(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToHpmhh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
  AmpSqTreeHpmToHpmhh(gt1, gt2, gt3) = (1)*AmpSqHpmToHpmhh(gt1, gt2, gt3)  
  AmpSum2HpmToHpmhh = + 2._dp*AmpWaveHpmToHpmhh + 2._dp*AmpVertexHpmToHpmhh
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
  AmpSqHpmToHpmhh(gt1, gt2, gt3) = AmpSqHpmToHpmhh(gt1, gt2, gt3) + AmpSqTreeHpmToHpmhh(gt1, gt2, gt3)  
Else  
  AmpSum2HpmToHpmhh = AmpTreeHpmToHpmhh
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),Mhh(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
  AmpSqTreeHpmToHpmhh(gt1, gt2, gt3) = (1)*AmpSqHpmToHpmhh(gt1, gt2, gt3)  
  AmpSum2HpmToHpmhh = + 2._dp*AmpWaveHpmToHpmhh + 2._dp*AmpVertexHpmToHpmhh
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),Mhh(gt3),AmpSumHpmToHpmhh(gt1, gt2, gt3),AmpSum2HpmToHpmhh(gt1, gt2, gt3),AmpSqHpmToHpmhh(gt1, gt2, gt3)) 
  AmpSqHpmToHpmhh(gt1, gt2, gt3) = AmpSqHpmToHpmhh(gt1, gt2, gt3) + AmpSqTreeHpmToHpmhh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmToHpmhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToHpmhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MHpmOS(gt2),MhhOS(gt3),helfactor*AmpSqHpmToHpmhh(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MHpm(gt2),Mhh(gt3),helfactor*AmpSqHpmToHpmhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToHpmhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToHpmhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToHpmhh(gt1, gt2, gt3) + MRGHpmToHpmhh(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmToHpmhh(gt1, gt2, gt3) + MRGHpmToHpmhh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! hh VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmTohhVWm(cplhhcHpmVWm,Mhh,MHpm,MVWm,Mhh2,            & 
& MHpm2,MVWm2,AmpTreeHpmTohhVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmTohhVWm(ZcplhhcHpmVWm,Mhh,MHpm,MVWm,Mhh2,           & 
& MHpm2,MVWm2,AmpTreeHpmTohhVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTohhVWm(MLambda,em,gs,cplhhcHpmVWm,MhhOS,               & 
& MHpmOS,MVWmOS,MRPHpmTohhVWm,MRGHpmTohhVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTohhVWm(MLambda,em,gs,ZcplhhcHpmVWm,MhhOS,              & 
& MHpmOS,MVWmOS,MRPHpmTohhVWm,MRGHpmTohhVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmTohhVWm(MLambda,em,gs,cplhhcHpmVWm,Mhh,MHpm,            & 
& MVWm,MRPHpmTohhVWm,MRGHpmTohhVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTohhVWm(MLambda,em,gs,ZcplhhcHpmVWm,Mhh,MHpm,           & 
& MVWm,MRPHpmTohhVWm,MRGHpmTohhVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmTohhVWm(cplhhcHpmVWm,ctcplhhcHpmVWm,Mhh,            & 
& Mhh2,MHpm,MHpm2,MVWm,MVWm2,Zfhh,ZfHpm,ZfVWm,AmpWaveHpmTohhVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTohhVWm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,     & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,cplcgWpCgAcHpm,         & 
& cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,      & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,            & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVP,     & 
& cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,           & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1,cplhhcHpmVPVWm1,& 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexHpmTohhVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWpCgAcHpm,cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,  & 
& cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,           & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRdrHpmTohhVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,              & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,cplcgWpCgAcHpm,         & 
& cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,      & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,GosZcplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,        & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,ZcplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVP,    & 
& cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,GosZcplcHpmVPVWm,       & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1,cplhhcHpmVPVWm1,& 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmTohhVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWpCgAcHpm,cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,  & 
& cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,GZcplhhHpmcHpm,cplhhHpmcVWm,          & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,ZcplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,      & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,           & 
& GZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1, & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmTohhVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,              & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,cplcgWpCgAcHpm,         & 
& cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,      & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,GcplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,           & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVP,     & 
& cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,GcplcHpmVPVWm,          & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1,cplhhcHpmVPVWm1,& 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmTohhVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWpCgAcHpm,cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,  & 
& cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,           & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosHpmTohhVWm)

 End if 
 End if 
AmpVertexHpmTohhVWm = AmpVertexHpmTohhVWm -  AmpVertexIRdrHpmTohhVWm! +  AmpVertexIRosHpmTohhVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmTohhVWm=0._dp 
AmpVertexZHpmTohhVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmTohhVWm(:,gt2,:) = AmpWaveZHpmTohhVWm(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveHpmTohhVWm(:,gt1,:) 
AmpVertexZHpmTohhVWm(:,gt2,:)= AmpVertexZHpmTohhVWm(:,gt2,:) + ZRUZP(gt2,gt1)*AmpVertexHpmTohhVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmTohhVWm=AmpWaveZHpmTohhVWm 
AmpVertexHpmTohhVWm= AmpVertexZHpmTohhVWm
! Final State 1 
AmpWaveZHpmTohhVWm=0._dp 
AmpVertexZHpmTohhVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmTohhVWm(:,:,gt2) = AmpWaveZHpmTohhVWm(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveHpmTohhVWm(:,:,gt1) 
AmpVertexZHpmTohhVWm(:,:,gt2)= AmpVertexZHpmTohhVWm(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexHpmTohhVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmTohhVWm=AmpWaveZHpmTohhVWm 
AmpVertexHpmTohhVWm= AmpVertexZHpmTohhVWm
End if
If (ShiftIRdiv) Then 
AmpVertexHpmTohhVWm = AmpVertexHpmTohhVWm  +  AmpVertexIRosHpmTohhVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->hh VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmTohhVWm = AmpTreeHpmTohhVWm 
 AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm + 2._dp*AmpWaveHpmTohhVWm + 2._dp*AmpVertexHpmTohhVWm  
Else 
 AmpSumHpmTohhVWm = AmpTreeHpmTohhVWm + AmpWaveHpmTohhVWm + AmpVertexHpmTohhVWm
 AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm + AmpWaveHpmTohhVWm + AmpVertexHpmTohhVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmTohhVWm = AmpTreeHpmTohhVWm
 AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MhhOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(Mhh(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MhhOS(gt2),MVWmOS,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),Mhh(gt2),MVWm,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmTohhVWm(gt1, gt2) 
  AmpSum2HpmTohhVWm = 2._dp*AmpWaveHpmTohhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MhhOS(gt2),MVWmOS,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),Mhh(gt2),MVWm,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmTohhVWm(gt1, gt2) 
  AmpSum2HpmTohhVWm = 2._dp*AmpVertexHpmTohhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MhhOS(gt2),MVWmOS,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),Mhh(gt2),MVWm,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmTohhVWm(gt1, gt2) 
  AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm + 2._dp*AmpWaveHpmTohhVWm + 2._dp*AmpVertexHpmTohhVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MhhOS(gt2),MVWmOS,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),Mhh(gt2),MVWm,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmTohhVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm
  Call SquareAmp_StoSV(MHpmOS(gt1),MhhOS(gt2),MVWmOS,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
  AmpSqTreeHpmTohhVWm(gt1, gt2) = (1)*AmpSqHpmTohhVWm(gt1, gt2)  
  AmpSum2HpmTohhVWm = + 2._dp*AmpWaveHpmTohhVWm + 2._dp*AmpVertexHpmTohhVWm
  Call SquareAmp_StoSV(MHpmOS(gt1),MhhOS(gt2),MVWmOS,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
  AmpSqHpmTohhVWm(gt1, gt2) = AmpSqHpmTohhVWm(gt1, gt2) + AmpSqTreeHpmTohhVWm(gt1, gt2)  
Else  
  AmpSum2HpmTohhVWm = AmpTreeHpmTohhVWm
  Call SquareAmp_StoSV(MHpm(gt1),Mhh(gt2),MVWm,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
  AmpSqTreeHpmTohhVWm(gt1, gt2) = (1)*AmpSqHpmTohhVWm(gt1, gt2)  
  AmpSum2HpmTohhVWm = + 2._dp*AmpWaveHpmTohhVWm + 2._dp*AmpVertexHpmTohhVWm
  Call SquareAmp_StoSV(MHpm(gt1),Mhh(gt2),MVWm,AmpSumHpmTohhVWm(:,gt1, gt2),AmpSum2HpmTohhVWm(:,gt1, gt2),AmpSqHpmTohhVWm(gt1, gt2)) 
  AmpSqHpmTohhVWm(gt1, gt2) = AmpSqHpmTohhVWm(gt1, gt2) + AmpSqTreeHpmTohhVWm(gt1, gt2)  
End if  
Else  
  AmpSqHpmTohhVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmTohhVWm(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MhhOS(gt2),MVWmOS,helfactor*AmpSqHpmTohhVWm(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),Mhh(gt2),MVWm,helfactor*AmpSqHpmTohhVWm(gt1, gt2))
End if 
If ((Abs(MRPHpmTohhVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmTohhVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmTohhVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmTohhVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPHpmTohhVWm(gt1, gt2) + MRGHpmTohhVWm(gt1, gt2)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1*helfactor*(MRPHpmTohhVWm(gt1, gt2) + MRGHpmTohhVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Hpm VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToHpmVZ(cplHpmcHpmVZ,MHpm,MVZ,MHpm2,MVZ2,           & 
& AmpTreeHpmToHpmVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToHpmVZ(ZcplHpmcHpmVZ,MHpm,MVZ,MHpm2,               & 
& MVZ2,AmpTreeHpmToHpmVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmVZ(MLambda,em,gs,cplHpmcHpmVZ,MHpmOS,              & 
& MVZOS,MRPHpmToHpmVZ,MRGHpmToHpmVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmVZ(MLambda,em,gs,ZcplHpmcHpmVZ,MHpmOS,             & 
& MVZOS,MRPHpmToHpmVZ,MRGHpmToHpmVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToHpmVZ(MLambda,em,gs,cplHpmcHpmVZ,MHpm,MVZ,            & 
& MRPHpmToHpmVZ,MRGHpmToHpmVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToHpmVZ(MLambda,em,gs,ZcplHpmcHpmVZ,MHpm,               & 
& MVZ,MRPHpmToHpmVZ,MRGHpmToHpmVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmVZ(cplHpmcHpmVP,cplHpmcHpmVZ,ctcplHpmcHpmVP,   & 
& ctcplHpmcHpmVZ,MHpm,MHpm2,MVP,MVP2,MVZ,MVZ2,ZfHpm,ZfVPVZ,ZfVZ,AmpWaveHpmToHpmVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,     & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,           & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,            & 
& cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,AmpVertexHpmToHpmVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,     & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,           & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,            & 
& cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,AmpVertexIRdrHpmToHpmVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhcHpmVWm,           & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,               & 
& cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,cplcgWpCgZcHpm,   & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,ZcplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,          & 
& cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,AmpVertexIRosHpmToHpmVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,     & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,           & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,ZcplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,           & 
& cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,AmpVertexIRosHpmToHpmVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhcHpmVWm,           & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,               & 
& cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,cplcgWpCgZcHpm,   & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,cplHpmSvcSe,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,           & 
& cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,AmpVertexIRosHpmToHpmVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,     & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,           & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,            & 
& cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,AmpVertexIRosHpmToHpmVZ)

 End if 
 End if 
AmpVertexHpmToHpmVZ = AmpVertexHpmToHpmVZ -  AmpVertexIRdrHpmToHpmVZ! +  AmpVertexIRosHpmToHpmVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToHpmVZ=0._dp 
AmpVertexZHpmToHpmVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmVZ(:,gt2,:) = AmpWaveZHpmToHpmVZ(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveHpmToHpmVZ(:,gt1,:) 
AmpVertexZHpmToHpmVZ(:,gt2,:)= AmpVertexZHpmToHpmVZ(:,gt2,:) + ZRUZP(gt2,gt1)*AmpVertexHpmToHpmVZ(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmToHpmVZ=AmpWaveZHpmToHpmVZ 
AmpVertexHpmToHpmVZ= AmpVertexZHpmToHpmVZ
! Final State 1 
AmpWaveZHpmToHpmVZ=0._dp 
AmpVertexZHpmToHpmVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToHpmVZ(:,:,gt2) = AmpWaveZHpmToHpmVZ(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveHpmToHpmVZ(:,:,gt1) 
AmpVertexZHpmToHpmVZ(:,:,gt2)= AmpVertexZHpmToHpmVZ(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexHpmToHpmVZ(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmToHpmVZ=AmpWaveZHpmToHpmVZ 
AmpVertexHpmToHpmVZ= AmpVertexZHpmToHpmVZ
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToHpmVZ = AmpVertexHpmToHpmVZ  +  AmpVertexIRosHpmToHpmVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Hpm VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToHpmVZ = AmpTreeHpmToHpmVZ 
 AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ + 2._dp*AmpWaveHpmToHpmVZ + 2._dp*AmpVertexHpmToHpmVZ  
Else 
 AmpSumHpmToHpmVZ = AmpTreeHpmToHpmVZ + AmpWaveHpmToHpmVZ + AmpVertexHpmToHpmVZ
 AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ + AmpWaveHpmToHpmVZ + AmpVertexHpmToHpmVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToHpmVZ = AmpTreeHpmToHpmVZ
 AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MHpmOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MHpm(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),MVZOS,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVZ,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToHpmVZ(gt1, gt2) 
  AmpSum2HpmToHpmVZ = 2._dp*AmpWaveHpmToHpmVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),MVZOS,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVZ,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToHpmVZ(gt1, gt2) 
  AmpSum2HpmToHpmVZ = 2._dp*AmpVertexHpmToHpmVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),MVZOS,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVZ,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToHpmVZ(gt1, gt2) 
  AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ + 2._dp*AmpWaveHpmToHpmVZ + 2._dp*AmpVertexHpmToHpmVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),MVZOS,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVZ,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToHpmVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),MVZOS,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
  AmpSqTreeHpmToHpmVZ(gt1, gt2) = (1)*AmpSqHpmToHpmVZ(gt1, gt2)  
  AmpSum2HpmToHpmVZ = + 2._dp*AmpWaveHpmToHpmVZ + 2._dp*AmpVertexHpmToHpmVZ
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),MVZOS,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
  AmpSqHpmToHpmVZ(gt1, gt2) = AmpSqHpmToHpmVZ(gt1, gt2) + AmpSqTreeHpmToHpmVZ(gt1, gt2)  
Else  
  AmpSum2HpmToHpmVZ = AmpTreeHpmToHpmVZ
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVZ,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
  AmpSqTreeHpmToHpmVZ(gt1, gt2) = (1)*AmpSqHpmToHpmVZ(gt1, gt2)  
  AmpSum2HpmToHpmVZ = + 2._dp*AmpWaveHpmToHpmVZ + 2._dp*AmpVertexHpmToHpmVZ
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVZ,AmpSumHpmToHpmVZ(:,gt1, gt2),AmpSum2HpmToHpmVZ(:,gt1, gt2),AmpSqHpmToHpmVZ(gt1, gt2)) 
  AmpSqHpmToHpmVZ(gt1, gt2) = AmpSqHpmToHpmVZ(gt1, gt2) + AmpSqTreeHpmToHpmVZ(gt1, gt2)  
End if  
Else  
  AmpSqHpmToHpmVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToHpmVZ(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MHpmOS(gt2),MVZOS,helfactor*AmpSqHpmToHpmVZ(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MHpm(gt2),MVZ,helfactor*AmpSqHpmToHpmVZ(gt1, gt2))
End if 
If ((Abs(MRPHpmToHpmVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToHpmVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPHpmToHpmVZ(gt1, gt2) + MRGHpmToHpmVZ(gt1, gt2)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1*helfactor*(MRPHpmToHpmVZ(gt1, gt2) + MRGHpmToHpmVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Conjg(Su) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmTocSuSd(cplSdcHpmcSu,MHpm,MSd,MSu,MHpm2,            & 
& MSd2,MSu2,AmpTreeHpmTocSuSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmTocSuSd(ZcplSdcHpmcSu,MHpm,MSd,MSu,MHpm2,           & 
& MSd2,MSu2,AmpTreeHpmTocSuSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocSuSd(MLambda,em,gs,cplSdcHpmcSu,MHpmOS,              & 
& MSdOS,MSuOS,MRPHpmTocSuSd,MRGHpmTocSuSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocSuSd(MLambda,em,gs,ZcplSdcHpmcSu,MHpmOS,             & 
& MSdOS,MSuOS,MRPHpmTocSuSd,MRGHpmTocSuSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmTocSuSd(MLambda,em,gs,cplSdcHpmcSu,MHpm,MSd,            & 
& MSu,MRPHpmTocSuSd,MRGHpmTocSuSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocSuSd(MLambda,em,gs,ZcplSdcHpmcSu,MHpm,               & 
& MSd,MSu,MRPHpmTocSuSd,MRGHpmTocSuSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmTocSuSd(cplSdcHpmcSu,ctcplSdcHpmcSu,MHpm,           & 
& MHpm2,MSd,MSd2,MSu,MSu2,ZfHpm,ZfSd,ZfSu,AmpWaveHpmTocSuSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSdcSd,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,cplChiFucSuR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,cplGluFucSuR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,cplhhSdcSd,             & 
& cplhhSucSu,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,cplSdcSdVG,               & 
& cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSdcSecSu,cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,   & 
& cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,cplHpmSucHpmcSuaa,    & 
& cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa, & 
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,AmpVertexHpmTocSuSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,           & 
& cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,       & 
& cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,           & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,             & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,               & 
& cplSucSuVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,& 
& cplHpmSucHpmcSuaa,cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,& 
& cplSdSvcSecSuaa,cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,  & 
& AmpVertexIRdrHpmTocSuSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhSdcSd,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,     & 
& cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,         & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,cplhhSdcSd,cplhhSucSu,              & 
& cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,               & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,ZcplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,cplHpmSucHpmcSuaa,    & 
& cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa, & 
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,AmpVertexIRosHpmTocSuSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,           & 
& cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,       & 
& cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,           & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,ZcplSdcHpmcSu,            & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,               & 
& cplSucSuVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,& 
& cplHpmSucHpmcSuaa,cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,& 
& cplSdSvcSecSuaa,cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,  & 
& AmpVertexIRosHpmTocSuSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhSdcSd,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,     & 
& cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,         & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,cplhhSdcSd,cplhhSucSu,              & 
& cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,               & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,           & 
& cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,cplHpmSucHpmcSuaa,    & 
& cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa, & 
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,AmpVertexIRosHpmTocSuSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,           & 
& cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,       & 
& cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,           & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,             & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,               & 
& cplSucSuVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,& 
& cplHpmSucHpmcSuaa,cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,& 
& cplSdSvcSecSuaa,cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,  & 
& AmpVertexIRosHpmTocSuSd)

 End if 
 End if 
AmpVertexHpmTocSuSd = AmpVertexHpmTocSuSd -  AmpVertexIRdrHpmTocSuSd! +  AmpVertexIRosHpmTocSuSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmTocSuSd=0._dp 
AmpVertexZHpmTocSuSd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmTocSuSd(gt2,:,:) = AmpWaveZHpmTocSuSd(gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmTocSuSd(gt1,:,:) 
AmpVertexZHpmTocSuSd(gt2,:,:)= AmpVertexZHpmTocSuSd(gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmTocSuSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmTocSuSd=AmpWaveZHpmTocSuSd 
AmpVertexHpmTocSuSd= AmpVertexZHpmTocSuSd
! Final State 1 
AmpWaveZHpmTocSuSd=0._dp 
AmpVertexZHpmTocSuSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZHpmTocSuSd(:,gt2,:) = AmpWaveZHpmTocSuSd(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWaveHpmTocSuSd(:,gt1,:) 
AmpVertexZHpmTocSuSd(:,gt2,:)= AmpVertexZHpmTocSuSd(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpVertexHpmTocSuSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmTocSuSd=AmpWaveZHpmTocSuSd 
AmpVertexHpmTocSuSd= AmpVertexZHpmTocSuSd
! Final State 2 
AmpWaveZHpmTocSuSd=0._dp 
AmpVertexZHpmTocSuSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZHpmTocSuSd(:,:,gt2) = AmpWaveZHpmTocSuSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveHpmTocSuSd(:,:,gt1) 
AmpVertexZHpmTocSuSd(:,:,gt2)= AmpVertexZHpmTocSuSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexHpmTocSuSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmTocSuSd=AmpWaveZHpmTocSuSd 
AmpVertexHpmTocSuSd= AmpVertexZHpmTocSuSd
End if
If (ShiftIRdiv) Then 
AmpVertexHpmTocSuSd = AmpVertexHpmTocSuSd  +  AmpVertexIRosHpmTocSuSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->conj[Su] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmTocSuSd = AmpTreeHpmTocSuSd 
 AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd + 2._dp*AmpWaveHpmTocSuSd + 2._dp*AmpVertexHpmTocSuSd  
Else 
 AmpSumHpmTocSuSd = AmpTreeHpmTocSuSd + AmpWaveHpmTocSuSd + AmpVertexHpmTocSuSd
 AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd + AmpWaveHpmTocSuSd + AmpVertexHpmTocSuSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmTocSuSd = AmpTreeHpmTocSuSd
 AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSuOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSu(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSu(gt2),MSd(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmTocSuSd(gt1, gt2, gt3) 
  AmpSum2HpmTocSuSd = 2._dp*AmpWaveHpmTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSu(gt2),MSd(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmTocSuSd(gt1, gt2, gt3) 
  AmpSum2HpmTocSuSd = 2._dp*AmpVertexHpmTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSu(gt2),MSd(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmTocSuSd(gt1, gt2, gt3) 
  AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd + 2._dp*AmpWaveHpmTocSuSd + 2._dp*AmpVertexHpmTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSu(gt2),MSd(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmTocSuSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd
  Call SquareAmp_StoSS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
  AmpSqTreeHpmTocSuSd(gt1, gt2, gt3) = (3)*AmpSqHpmTocSuSd(gt1, gt2, gt3)  
  AmpSum2HpmTocSuSd = + 2._dp*AmpWaveHpmTocSuSd + 2._dp*AmpVertexHpmTocSuSd
  Call SquareAmp_StoSS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
  AmpSqHpmTocSuSd(gt1, gt2, gt3) = AmpSqHpmTocSuSd(gt1, gt2, gt3) + AmpSqTreeHpmTocSuSd(gt1, gt2, gt3)  
Else  
  AmpSum2HpmTocSuSd = AmpTreeHpmTocSuSd
  Call SquareAmp_StoSS(MHpm(gt1),MSu(gt2),MSd(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
  AmpSqTreeHpmTocSuSd(gt1, gt2, gt3) = (3)*AmpSqHpmTocSuSd(gt1, gt2, gt3)  
  AmpSum2HpmTocSuSd = + 2._dp*AmpWaveHpmTocSuSd + 2._dp*AmpVertexHpmTocSuSd
  Call SquareAmp_StoSS(MHpm(gt1),MSu(gt2),MSd(gt3),AmpSumHpmTocSuSd(gt1, gt2, gt3),AmpSum2HpmTocSuSd(gt1, gt2, gt3),AmpSqHpmTocSuSd(gt1, gt2, gt3)) 
  AmpSqHpmTocSuSd(gt1, gt2, gt3) = AmpSqHpmTocSuSd(gt1, gt2, gt3) + AmpSqTreeHpmTocSuSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmTocSuSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmTocSuSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSuOS(gt2),MSdOS(gt3),helfactor*AmpSqHpmTocSuSd(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSu(gt2),MSd(gt3),helfactor*AmpSqHpmTocSuSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmTocSuSd(gt1, gt2, gt3) + MRGHpmTocSuSd(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmTocSuSd(gt1, gt2, gt3) + MRGHpmTocSuSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Conjg(Sv) Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmTocSvSe(cplSecHpmcSv,MHpm,MSe,MSv,MHpm2,            & 
& MSe2,MSv2,AmpTreeHpmTocSvSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmTocSvSe(ZcplSecHpmcSv,MHpm,MSe,MSv,MHpm2,           & 
& MSe2,MSv2,AmpTreeHpmTocSvSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocSvSe(MLambda,em,gs,cplSecHpmcSv,MHpmOS,              & 
& MSeOS,MSvOS,MRPHpmTocSvSe,MRGHpmTocSvSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocSvSe(MLambda,em,gs,ZcplSecHpmcSv,MHpmOS,             & 
& MSeOS,MSvOS,MRPHpmTocSvSe,MRGHpmTocSvSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmTocSvSe(MLambda,em,gs,cplSecHpmcSv,MHpm,MSe,            & 
& MSv,MRPHpmTocSvSe,MRGHpmTocSvSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmTocSvSe(MLambda,em,gs,ZcplSecHpmcSv,MHpm,               & 
& MSe,MSv,MRPHpmTocSvSe,MRGHpmTocSvSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmTocSvSe(cplSecHpmcSv,ctcplSecHpmcSv,MHpm,           & 
& MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,ZfSe,ZfSv,AmpWaveHpmTocSvSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,              & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,             & 
& cplhhSvcSv,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1, & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexHpmTocSvSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,        & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,             & 
& cplhhSvcSv,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1, & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRdrHpmTocSvSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,cplChiChacHpmL,        & 
& cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,cplSeSucSd,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,ZcplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1, & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosHpmTocSvSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,        & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,             & 
& cplhhSvcSv,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,ZcplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,    & 
& cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1, & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosHpmTocSvSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,cplChiChacHpmL,        & 
& cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,cplSeSucSd,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,     & 
& cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1,            & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosHpmTocSvSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,        & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,             & 
& cplhhSvcSv,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1, & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosHpmTocSvSe)

 End if 
 End if 
AmpVertexHpmTocSvSe = AmpVertexHpmTocSvSe -  AmpVertexIRdrHpmTocSvSe! +  AmpVertexIRosHpmTocSvSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmTocSvSe=0._dp 
AmpVertexZHpmTocSvSe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmTocSvSe(gt2,:,:) = AmpWaveZHpmTocSvSe(gt2,:,:)+ZRUZP(gt2,gt1)*AmpWaveHpmTocSvSe(gt1,:,:) 
AmpVertexZHpmTocSvSe(gt2,:,:)= AmpVertexZHpmTocSvSe(gt2,:,:) + ZRUZP(gt2,gt1)*AmpVertexHpmTocSvSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveHpmTocSvSe=AmpWaveZHpmTocSvSe 
AmpVertexHpmTocSvSe= AmpVertexZHpmTocSvSe
! Final State 1 
AmpWaveZHpmTocSvSe=0._dp 
AmpVertexZHpmTocSvSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZHpmTocSvSe(:,gt2,:) = AmpWaveZHpmTocSvSe(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpWaveHpmTocSvSe(:,gt1,:) 
AmpVertexZHpmTocSvSe(:,gt2,:)= AmpVertexZHpmTocSvSe(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpVertexHpmTocSvSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveHpmTocSvSe=AmpWaveZHpmTocSvSe 
AmpVertexHpmTocSvSe= AmpVertexZHpmTocSvSe
! Final State 2 
AmpWaveZHpmTocSvSe=0._dp 
AmpVertexZHpmTocSvSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZHpmTocSvSe(:,:,gt2) = AmpWaveZHpmTocSvSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveHpmTocSvSe(:,:,gt1) 
AmpVertexZHpmTocSvSe(:,:,gt2)= AmpVertexZHpmTocSvSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexHpmTocSvSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveHpmTocSvSe=AmpWaveZHpmTocSvSe 
AmpVertexHpmTocSvSe= AmpVertexZHpmTocSvSe
End if
If (ShiftIRdiv) Then 
AmpVertexHpmTocSvSe = AmpVertexHpmTocSvSe  +  AmpVertexIRosHpmTocSvSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->conj[Sv] Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmTocSvSe = AmpTreeHpmTocSvSe 
 AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe + 2._dp*AmpWaveHpmTocSvSe + 2._dp*AmpVertexHpmTocSvSe  
Else 
 AmpSumHpmTocSvSe = AmpTreeHpmTocSvSe + AmpWaveHpmTocSvSe + AmpVertexHpmTocSvSe
 AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe + AmpWaveHpmTocSvSe + AmpVertexHpmTocSvSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmTocSvSe = AmpTreeHpmTocSvSe
 AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSvOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSv(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSv(gt2),MSe(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmTocSvSe(gt1, gt2, gt3) 
  AmpSum2HpmTocSvSe = 2._dp*AmpWaveHpmTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSv(gt2),MSe(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmTocSvSe(gt1, gt2, gt3) 
  AmpSum2HpmTocSvSe = 2._dp*AmpVertexHpmTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSv(gt2),MSe(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmTocSvSe(gt1, gt2, gt3) 
  AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe + 2._dp*AmpWaveHpmTocSvSe + 2._dp*AmpVertexHpmTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSv(gt2),MSe(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmTocSvSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe
  Call SquareAmp_StoSS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
  AmpSqTreeHpmTocSvSe(gt1, gt2, gt3) = (1)*AmpSqHpmTocSvSe(gt1, gt2, gt3)  
  AmpSum2HpmTocSvSe = + 2._dp*AmpWaveHpmTocSvSe + 2._dp*AmpVertexHpmTocSvSe
  Call SquareAmp_StoSS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
  AmpSqHpmTocSvSe(gt1, gt2, gt3) = AmpSqHpmTocSvSe(gt1, gt2, gt3) + AmpSqTreeHpmTocSvSe(gt1, gt2, gt3)  
Else  
  AmpSum2HpmTocSvSe = AmpTreeHpmTocSvSe
  Call SquareAmp_StoSS(MHpm(gt1),MSv(gt2),MSe(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
  AmpSqTreeHpmTocSvSe(gt1, gt2, gt3) = (1)*AmpSqHpmTocSvSe(gt1, gt2, gt3)  
  AmpSum2HpmTocSvSe = + 2._dp*AmpWaveHpmTocSvSe + 2._dp*AmpVertexHpmTocSvSe
  Call SquareAmp_StoSS(MHpm(gt1),MSv(gt2),MSe(gt3),AmpSumHpmTocSvSe(gt1, gt2, gt3),AmpSum2HpmTocSvSe(gt1, gt2, gt3),AmpSqHpmTocSvSe(gt1, gt2, gt3)) 
  AmpSqHpmTocSvSe(gt1, gt2, gt3) = AmpSqHpmTocSvSe(gt1, gt2, gt3) + AmpSqTreeHpmTocSvSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqHpmTocSvSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmTocSvSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSvOS(gt2),MSeOS(gt3),helfactor*AmpSqHpmTocSvSe(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSv(gt2),MSe(gt3),helfactor*AmpSqHpmTocSvSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmTocSvSe(gt1, gt2, gt3) + MRGHpmTocSvSe(gt1, gt2, gt3)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPHpmTocSvSe(gt1, gt2, gt3) + MRGHpmTocSvSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! VZ VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_HpmToVZVWm(cplcHpmVWmVZ,MHpm,MVWm,MVZ,MHpm2,           & 
& MVWm2,MVZ2,AmpTreeHpmToVZVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_HpmToVZVWm(ZcplcHpmVWmVZ,MHpm,MVWm,MVZ,MHpm2,          & 
& MVWm2,MVZ2,AmpTreeHpmToVZVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToVZVWm(MLambda,em,gs,cplcHpmVWmVZ,MHpmOS,              & 
& MVWmOS,MVZOS,MRPHpmToVZVWm,MRGHpmToVZVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToVZVWm(MLambda,em,gs,ZcplcHpmVWmVZ,MHpmOS,             & 
& MVWmOS,MVZOS,MRPHpmToVZVWm,MRGHpmToVZVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_HpmToVZVWm(MLambda,em,gs,cplcHpmVWmVZ,MHpm,MVWm,           & 
& MVZ,MRPHpmToVZVWm,MRGHpmToVZVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_HpmToVZVWm(MLambda,em,gs,ZcplcHpmVWmVZ,MHpm,               & 
& MVWm,MVZ,MRPHpmToVZVWm,MRGHpmToVZVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToVZVWm(cplcHpmVPVWm,cplcHpmVWmVZ,ctcplcHpmVPVWm,   & 
& ctcplcHpmVWmVZ,MHpm,MHpm2,MVP,MVP2,MVWm,MVWm2,MVZ,MVZ2,ZfHpm,ZfVWm,ZfVZ,               & 
& AmpWaveHpmToVZVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToVZVWm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,               & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,               & 
& cplcgWpCgAcHpm,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,          & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,             & 
& cplSecHpmcSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,& 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,  & 
& AmpVertexHpmToVZVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,         & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,               & 
& cplcgWpCgAcHpm,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,          & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,             & 
& cplSecHpmcSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,& 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,  & 
& AmpVertexIRdrHpmToVZVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,         & 
& cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcChaChiVWmL,   & 
& cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,            & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,            & 
& cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,cplcgWmgZVWm,    & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVP,          & 
& GosZcplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,         & 
& cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,GosZcplcHpmVPVWm,cplcVWmVPVWm,           & 
& ZcplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,            & 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,  & 
& AmpVertexIRosHpmToVZVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,         & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,               & 
& cplcgWpCgAcHpm,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,          & 
& cplHpmcHpmVP,GZcplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,           & 
& cplSecHpmcSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,GZcplcHpmVPVWm,             & 
& cplcVWmVPVWm,ZcplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,               & 
& cplHpmcHpmVPVZ1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,     & 
& cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,  & 
& cplcVWmVWmVZVZ1Q,AmpVertexIRosHpmToVZVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,         & 
& cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcChaChiVWmL,   & 
& cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,            & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,            & 
& cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,cplcgWmgZVWm,    & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVP,          & 
& GcplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,            & 
& cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,GcplcHpmVPVWm,cplcVWmVPVWm,              & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,             & 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,  & 
& AmpVertexIRosHpmToVZVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,         & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,               & 
& cplcgWpCgAcHpm,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,          & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,             & 
& cplSecHpmcSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,& 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,  & 
& AmpVertexIRosHpmToVZVWm)

 End if 
 End if 
AmpVertexHpmToVZVWm = AmpVertexHpmToVZVWm -  AmpVertexIRdrHpmToVZVWm! +  AmpVertexIRosHpmToVZVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZHpmToVZVWm=0._dp 
AmpVertexZHpmToVZVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZHpmToVZVWm(:,gt2) = AmpWaveZHpmToVZVWm(:,gt2)+ZRUZP(gt2,gt1)*AmpWaveHpmToVZVWm(:,gt1) 
AmpVertexZHpmToVZVWm(:,gt2)= AmpVertexZHpmToVZVWm(:,gt2) + ZRUZP(gt2,gt1)*AmpVertexHpmToVZVWm(:,gt1) 
 End Do 
End Do 
AmpWaveHpmToVZVWm=AmpWaveZHpmToVZVWm 
AmpVertexHpmToVZVWm= AmpVertexZHpmToVZVWm
End if
If (ShiftIRdiv) Then 
AmpVertexHpmToVZVWm = AmpVertexHpmToVZVWm  +  AmpVertexIRosHpmToVZVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->VZ VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumHpmToVZVWm = AmpTreeHpmToVZVWm 
 AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm + 2._dp*AmpWaveHpmToVZVWm + 2._dp*AmpVertexHpmToVZVWm  
Else 
 AmpSumHpmToVZVWm = AmpTreeHpmToVZVWm + AmpWaveHpmToVZVWm + AmpVertexHpmToVZVWm
 AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm + AmpWaveHpmToVZVWm + AmpVertexHpmToVZVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToVZVWm = AmpTreeHpmToVZVWm
 AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm 
End if 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MVZOS+MVWmOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MVZ+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1 
  AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MHpmOS(gt1),MVZOS,MVWmOS,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MHpm(gt1),MVZ,MVWm,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqHpmToVZVWm(gt1) 
  AmpSum2HpmToVZVWm = 2._dp*AmpWaveHpmToVZVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MHpmOS(gt1),MVZOS,MVWmOS,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MHpm(gt1),MVZ,MVWm,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqHpmToVZVWm(gt1) 
  AmpSum2HpmToVZVWm = 2._dp*AmpVertexHpmToVZVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MHpmOS(gt1),MVZOS,MVWmOS,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MHpm(gt1),MVZ,MVWm,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqHpmToVZVWm(gt1) 
  AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm + 2._dp*AmpWaveHpmToVZVWm + 2._dp*AmpVertexHpmToVZVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MHpmOS(gt1),MVZOS,MVWmOS,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MHpm(gt1),MVZ,MVWm,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqHpmToVZVWm(gt1) 
 End if 
If (OSkinematics) Then 
  AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm
  Call SquareAmp_StoVV(MHpmOS(gt1),MVZOS,MVWmOS,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
  AmpSqTreeHpmToVZVWm(gt1) = (1)*AmpSqHpmToVZVWm(gt1)  
  AmpSum2HpmToVZVWm = + 2._dp*AmpWaveHpmToVZVWm + 2._dp*AmpVertexHpmToVZVWm
  Call SquareAmp_StoVV(MHpmOS(gt1),MVZOS,MVWmOS,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
  AmpSqHpmToVZVWm(gt1) = AmpSqHpmToVZVWm(gt1) + AmpSqTreeHpmToVZVWm(gt1)  
Else  
  AmpSum2HpmToVZVWm = AmpTreeHpmToVZVWm
  Call SquareAmp_StoVV(MHpm(gt1),MVZ,MVWm,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
  AmpSqTreeHpmToVZVWm(gt1) = (1)*AmpSqHpmToVZVWm(gt1)  
  AmpSum2HpmToVZVWm = + 2._dp*AmpWaveHpmToVZVWm + 2._dp*AmpVertexHpmToVZVWm
  Call SquareAmp_StoVV(MHpm(gt1),MVZ,MVWm,AmpSumHpmToVZVWm(:,gt1),AmpSum2HpmToVZVWm(:,gt1),AmpSqHpmToVZVWm(gt1)) 
  AmpSqHpmToVZVWm(gt1) = AmpSqHpmToVZVWm(gt1) + AmpSqTreeHpmToVZVWm(gt1)  
End if  
Else  
  AmpSqHpmToVZVWm(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToVZVWm(gt1).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 2*GammaTPS(MHpmOS(gt1),MVZOS,MVWmOS,helfactor*AmpSqHpmToVZVWm(gt1))
Else 
  gP1LHpm(gt1,i4) = 2*GammaTPS(MHpm(gt1),MVZ,MVWm,helfactor*AmpSqHpmToVZVWm(gt1))
End if 
If ((Abs(MRPHpmToVZVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGHpmToVZVWm(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPHpmToVZVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGHpmToVZVWm(gt1)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*2*helfactor*(MRPHpmToVZVWm(gt1) + MRGHpmToVZVWm(gt1)) 
  gP1LHpm(gt1,i4) = gP1LHpm(gt1,i4) + phasespacefactor*2*helfactor*(MRPHpmToVZVWm(gt1) + MRGHpmToVZVWm(gt1))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LHpm(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
End If 
!---------------- 
! Ah Se
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToAhSe(MAhOS,MAh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,ZfAh,ZfHpm,ZfSe,AmpWaveHpmToAhSe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToAhSe(MAhOS,MAh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,ZfAh,ZfHpm,ZfSe,AmpWaveHpmToAhSe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToAhSe(MAhOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplAhSdcHpmcSuaa,cplAhSeSucSdaa,       & 
& cplAhSeSvcSe1,cplAhSecHpmcSv1,cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,       & 
& AmpVertexHpmToAhSe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToAhSe(MAhOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplAhSdcHpmcSuaa,cplAhSeSucSdaa,       & 
& cplAhSeSvcSe1,cplAhSecHpmcSv1,cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,       & 
& AmpVertexHpmToAhSe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToAhSe(MAh,MAh2,MHpm,MHpm2,MSe,MSe2,ZfAh,           & 
& ZfHpm,ZfSe,AmpWaveHpmToAhSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToAhSe(MAh,MFd,MFe,MFu,MHpm,MSd,MSe,              & 
& MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,               & 
& cplAhSdcHpmcSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplSdSecHpmcSdaa,        & 
& cplSeSecHpmcSe1,cplSeSucHpmcSuaa,AmpVertexHpmToAhSe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Ah Se -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToAhSe = 0._dp 
 AmpSum2HpmToAhSe = 0._dp  
Else 
 AmpSumHpmToAhSe = AmpVertexHpmToAhSe + AmpWaveHpmToAhSe
 AmpSum2HpmToAhSe = AmpVertexHpmToAhSe + AmpWaveHpmToAhSe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,6
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MAhOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MAh(gt2)+MSe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MAhOS(gt2),MSeOS(gt3),AmpSumHpmToAhSe(gt1, gt2, gt3),AmpSum2HpmToAhSe(gt1, gt2, gt3),AmpSqHpmToAhSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MAh(gt2),MSe(gt3),AmpSumHpmToAhSe(gt1, gt2, gt3),AmpSum2HpmToAhSe(gt1, gt2, gt3),AmpSqHpmToAhSe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmToAhSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToAhSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MAhOS(gt2),MSeOS(gt3),helfactor*AmpSqHpmToAhSe(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MAh(gt2),MSe(gt3),helfactor*AmpSqHpmToAhSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToAhSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToAhSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Cha Fv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChaFv(MChaOS,MCha2OS,MHpmOS,MHpm2OS,              & 
& ZfFvL,ZfHpm,ZfLm,ZfLp,AmpWaveHpmToChaFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChaFv(MChaOS,MCha2OS,MHpmOS,MHpm2OS,              & 
& ZfFvL,ZfHpm,ZfLm,ZfLp,AmpWaveHpmToChaFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChaFv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,        & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,           & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplSdcHpmcSu,cplSecHpmcSv,AmpVertexHpmToChaFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChaFv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,        & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,           & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplSdcHpmcSu,cplSecHpmcSv,AmpVertexHpmToChaFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChaFv(MCha,MCha2,MHpm,MHpm2,ZfFvL,ZfHpm,          & 
& ZfLm,ZfLp,AmpWaveHpmToChaFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChaFv(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,      & 
& cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplSdcHpmcSu,cplSecHpmcSv,AmpVertexHpmToChaFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Cha Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToChaFv = 0._dp 
 AmpSum2HpmToChaFv = 0._dp  
Else 
 AmpSumHpmToChaFv = AmpVertexHpmToChaFv + AmpWaveHpmToChaFv
 AmpSum2HpmToChaFv = AmpVertexHpmToChaFv + AmpWaveHpmToChaFv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MChaOS(gt2)+0.))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MCha(gt2)+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MChaOS(gt2),0._dp,AmpSumHpmToChaFv(:,gt1, gt2, gt3),AmpSum2HpmToChaFv(:,gt1, gt2, gt3),AmpSqHpmToChaFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MCha(gt2),0._dp,AmpSumHpmToChaFv(:,gt1, gt2, gt3),AmpSum2HpmToChaFv(:,gt1, gt2, gt3),AmpSqHpmToChaFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmToChaFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqHpmToChaFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MChaOS(gt2),0._dp,helfactor*AmpSqHpmToChaFv(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MCha(gt2),0._dp,helfactor*AmpSqHpmToChaFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToChaFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToChaFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Chi Fe
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChiFe(MChiOS,MChi2OS,MFeOS,MFe2OS,MHpmOS,         & 
& MHpm2OS,ZfFEL,ZfFER,ZfHpm,ZfL0,AmpWaveHpmToChiFe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChiFe(MChiOS,MChi2OS,MFeOS,MFe2OS,MHpmOS,         & 
& MHpm2OS,ZfFEL,ZfFER,ZfHpm,ZfL0,AmpWaveHpmToChiFe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChiFe(MChiOS,MFdOS,MFeOS,MFuOS,MHpmOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,        & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,           & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,        & 
& cplcFuFdcHpmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFecSvL,              & 
& cplcFeFecSvR,cplSdcHpmcSu,cplSecHpmcSv,AmpVertexHpmToChiFe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChiFe(MChiOS,MFdOS,MFeOS,MFuOS,MHpmOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,        & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,           & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,        & 
& cplcFuFdcHpmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFecSvL,              & 
& cplcFeFecSvR,cplSdcHpmcSu,cplSecHpmcSv,AmpVertexHpmToChiFe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToChiFe(MChi,MChi2,MFe,MFe2,MHpm,MHpm2,             & 
& ZfFEL,ZfFER,ZfHpm,ZfL0,AmpWaveHpmToChiFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToChiFe(MChi,MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChiFdcSdL,cplChiFdcSdR,      & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcHpmcSu,cplSecHpmcSv,           & 
& AmpVertexHpmToChiFe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Chi Fe -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToChiFe = 0._dp 
 AmpSum2HpmToChiFe = 0._dp  
Else 
 AmpSumHpmToChiFe = AmpVertexHpmToChiFe + AmpWaveHpmToChiFe
 AmpSum2HpmToChiFe = AmpVertexHpmToChiFe + AmpWaveHpmToChiFe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MChiOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MChi(gt2)+MFe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MHpmOS(gt1),MChiOS(gt2),MFeOS(gt3),AmpSumHpmToChiFe(:,gt1, gt2, gt3),AmpSum2HpmToChiFe(:,gt1, gt2, gt3),AmpSqHpmToChiFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MHpm(gt1),MChi(gt2),MFe(gt3),AmpSumHpmToChiFe(:,gt1, gt2, gt3),AmpSum2HpmToChiFe(:,gt1, gt2, gt3),AmpSqHpmToChiFe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmToChiFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqHpmToChiFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MChiOS(gt2),MFeOS(gt3),helfactor*AmpSqHpmToChiFe(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MChi(gt2),MFe(gt3),helfactor*AmpSqHpmToChiFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToChiFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToChiFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! hh Se
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmTohhSe(MhhOS,Mhh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,Zfhh,ZfHpm,ZfSe,AmpWaveHpmTohhSe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmTohhSe(MhhOS,Mhh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,Zfhh,ZfHpm,ZfSe,AmpWaveHpmTohhSe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTohhSe(MFdOS,MFeOS,MFuOS,MhhOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,        & 
& cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplhhSdcHpmcSuaa,cplhhSeSucSdaa,       & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,       & 
& cplSeSvcHpmcSv1,AmpVertexHpmTohhSe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTohhSe(MFdOS,MFeOS,MFuOS,MhhOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,        & 
& cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplhhSdcHpmcSuaa,cplhhSeSucSdaa,       & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,       & 
& cplSeSvcHpmcSv1,AmpVertexHpmTohhSe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmTohhSe(Mhh,Mhh2,MHpm,MHpm2,MSe,MSe2,Zfhh,           & 
& ZfHpm,ZfSe,AmpWaveHpmTohhSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTohhSe(MFd,MFe,MFu,Mhh,MHpm,MSd,MSe,              & 
& MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,cplcFdFdhhR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,        & 
& cplSecHpmcSv,cplhhSdcHpmcSuaa,cplhhSeSucSdaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,            & 
& cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,cplSeSvcHpmcSv1,AmpVertexHpmTohhSe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->hh Se -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmTohhSe = 0._dp 
 AmpSum2HpmTohhSe = 0._dp  
Else 
 AmpSumHpmTohhSe = AmpVertexHpmTohhSe + AmpWaveHpmTohhSe
 AmpSum2HpmTohhSe = AmpVertexHpmTohhSe + AmpWaveHpmTohhSe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,6
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MhhOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(Mhh(gt2)+MSe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MhhOS(gt2),MSeOS(gt3),AmpSumHpmTohhSe(gt1, gt2, gt3),AmpSum2HpmTohhSe(gt1, gt2, gt3),AmpSqHpmTohhSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),Mhh(gt2),MSe(gt3),AmpSumHpmTohhSe(gt1, gt2, gt3),AmpSum2HpmTohhSe(gt1, gt2, gt3),AmpSqHpmTohhSe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmTohhSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmTohhSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MhhOS(gt2),MSeOS(gt3),helfactor*AmpSqHpmTohhSe(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),Mhh(gt2),MSe(gt3),helfactor*AmpSqHpmTohhSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmTohhSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmTohhSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Hpm Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmSv(MHpmOS,MHpm2OS,MSvOS,MSv2OS,ZfHpm,          & 
& ZfSv,AmpWaveHpmToHpmSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmSv(MHpmOS,MHpm2OS,MSvOS,MSv2OS,ZfHpm,          & 
& ZfSv,AmpWaveHpmToHpmSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmSv(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,               & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSuSvcSdaa,cplSdSvcHpmcSuaa,cplSeSvcHpmcSv1,   & 
& AmpVertexHpmToHpmSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmSv(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,               & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSuSvcSdaa,cplSdSvcHpmcSuaa,cplSeSvcHpmcSv1,   & 
& AmpVertexHpmToHpmSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmSv(MHpm,MHpm2,MSv,MSv2,ZfHpm,ZfSv,             & 
& AmpWaveHpmToHpmSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmSv(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,             & 
& MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,    & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,             & 
& cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,               & 
& cplHpmSuSvcSdaa,cplSdSvcHpmcSuaa,cplSeSvcHpmcSv1,AmpVertexHpmToHpmSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Hpm Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToHpmSv = 0._dp 
 AmpSum2HpmToHpmSv = 0._dp  
Else 
 AmpSumHpmToHpmSv = AmpVertexHpmToHpmSv + AmpWaveHpmToHpmSv
 AmpSum2HpmToHpmSv = AmpVertexHpmToHpmSv + AmpWaveHpmToHpmSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MHpmOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MHpm(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MSvOS(gt3),AmpSumHpmToHpmSv(gt1, gt2, gt3),AmpSum2HpmToHpmSv(gt1, gt2, gt3),AmpSqHpmToHpmSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MSv(gt3),AmpSumHpmToHpmSv(gt1, gt2, gt3),AmpSum2HpmToHpmSv(gt1, gt2, gt3),AmpSqHpmToHpmSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmToHpmSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToHpmSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MHpmOS(gt2),MSvOS(gt3),helfactor*AmpSqHpmToHpmSv(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MHpm(gt2),MSv(gt3),helfactor*AmpSqHpmToHpmSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToHpmSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Hpm VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmVP(cplHpmcHpmVP,cplHpmcHpmVZ,ctcplHpmcHpmVP,   & 
& ctcplHpmcHpmVZ,MHpmOS,MHpm2OS,MVP,MVP2,ZfHpm,ZfVP,ZfVZVP,AmpWaveHpmToHpmVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmVP(cplHpmcHpmVP,cplHpmcHpmVZ,ctcplHpmcHpmVP,   & 
& ctcplHpmcHpmVZ,MHpmOS,MHpm2OS,MVP,MVP2,ZfHpm,ZfVP,ZfVZVP,AmpWaveHpmToHpmVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,          & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiHpmL,cplcChaChiHpmR,              & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,cplcFuFuVPR,             & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVP,     & 
& cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplHpmSucSd,        & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,            & 
& cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,             & 
& cplcHpmVWmVZ,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,          & 
& cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,AmpVertexHpmToHpmVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,          & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiHpmL,cplcChaChiHpmR,              & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,cplcFuFuVPR,             & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVP,     & 
& cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplHpmSucSd,        & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,            & 
& cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,             & 
& cplcHpmVWmVZ,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,          & 
& cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,AmpVertexHpmToHpmVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmVP(cplHpmcHpmVP,cplHpmcHpmVZ,ctcplHpmcHpmVP,   & 
& ctcplHpmcHpmVZ,MHpm,MHpm2,MVP,MVP2,ZfHpm,ZfVP,ZfVZVP,AmpWaveHpmToHpmVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVP(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,cplAhcHpmVWm,            & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiHpmL,              & 
& cplcChaChiHpmR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,            & 
& cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgZgWpCHpm,        & 
& cplcgWpCgWpCVP,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,     & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSdVP,cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,             & 
& cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,AmpVertexHpmToHpmVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Hpm VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToHpmVP = 0._dp 
 AmpSum2HpmToHpmVP = 0._dp  
Else 
 AmpSumHpmToHpmVP = AmpVertexHpmToHpmVP + AmpWaveHpmToHpmVP
 AmpSum2HpmToHpmVP = AmpVertexHpmToHpmVP + AmpWaveHpmToHpmVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MHpmOS(gt2)+0.))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MHpm(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MHpmOS(gt2),0._dp,AmpSumHpmToHpmVP(:,gt1, gt2),AmpSum2HpmToHpmVP(:,gt1, gt2),AmpSqHpmToHpmVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MHpm(gt2),MVP,AmpSumHpmToHpmVP(:,gt1, gt2),AmpSum2HpmToHpmVP(:,gt1, gt2),AmpSqHpmToHpmVP(gt1, gt2)) 
End if  
Else  
  AmpSqHpmToHpmVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToHpmVP(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MHpmOS(gt2),0._dp,helfactor*AmpSqHpmToHpmVP(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MHpm(gt2),MVP,helfactor*AmpSqHpmToHpmVP(gt1, gt2))
End if 
If ((Abs(MRPHpmToHpmVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Hpm Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmcSv(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& ZfHpm,ZfSv,AmpWaveHpmToHpmcSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmcSv(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& ZfHpm,ZfSv,AmpWaveHpmToHpmcSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmcSv(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa, & 
& AmpVertexHpmToHpmcSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmcSv(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa, & 
& AmpVertexHpmToHpmcSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToHpmcSv(MHpm,MHpm2,MSv,MSv2,ZfHpm,ZfSv,            & 
& AmpWaveHpmToHpmcSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToHpmcSv(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,            & 
& MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,  & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,           & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,               & 
& cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa,AmpVertexHpmToHpmcSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Hpm conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToHpmcSv = 0._dp 
 AmpSum2HpmToHpmcSv = 0._dp  
Else 
 AmpSumHpmToHpmcSv = AmpVertexHpmToHpmcSv + AmpWaveHpmToHpmcSv
 AmpSum2HpmToHpmcSv = AmpVertexHpmToHpmcSv + AmpWaveHpmToHpmcSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MHpmOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MHpm(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MHpmOS(gt2),MSvOS(gt3),AmpSumHpmToHpmcSv(gt1, gt2, gt3),AmpSum2HpmToHpmcSv(gt1, gt2, gt3),AmpSqHpmToHpmcSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MHpm(gt2),MSv(gt3),AmpSumHpmToHpmcSv(gt1, gt2, gt3),AmpSum2HpmToHpmcSv(gt1, gt2, gt3),AmpSqHpmToHpmcSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmToHpmcSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToHpmcSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MHpmOS(gt2),MSvOS(gt3),helfactor*AmpSqHpmToHpmcSv(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MHpm(gt2),MSv(gt3),helfactor*AmpSqHpmToHpmcSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToHpmcSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToHpmcSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Se Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeSv(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MSvOS,           & 
& MSv2OS,ZfHpm,ZfSe,ZfSv,AmpWaveHpmToSeSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeSv(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MSvOS,           & 
& MSv2OS,ZfHpm,ZfSe,ZfSv,AmpWaveHpmToSeSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeSv(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,           & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,           & 
& MSd2OS,MSe2OS,MSu2OS,MSv2OS,cplChiChacHpmL,cplChiChacHpmR,cplcFeChaSvL,cplcFeChaSvR,   & 
& cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplSdSvcSd,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSdSecHpmcSdaa,           & 
& cplSdSvcHpmcSuaa,cplSeSecHpmcSe1,cplSeSvcHpmcSv1,AmpVertexHpmToSeSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeSv(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,           & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,           & 
& MSd2OS,MSe2OS,MSu2OS,MSv2OS,cplChiChacHpmL,cplChiChacHpmR,cplcFeChaSvL,cplcFeChaSvR,   & 
& cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplSdSvcSd,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSdSecHpmcSdaa,           & 
& cplSdSvcHpmcSuaa,cplSeSecHpmcSe1,cplSeSvcHpmcSv1,AmpVertexHpmToSeSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeSv(MHpm,MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,          & 
& ZfSe,ZfSv,AmpWaveHpmToSeSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeSv(MCha,MChi,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChiChacHpmL,       & 
& cplChiChacHpmR,cplcFeChaSvL,cplcFeChaSvR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,         & 
& cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplSdSvcSd,cplSdcHpmcSu,cplSeSucSd,               & 
& cplSeSvcSe,cplSecHpmcSv,cplSdSecHpmcSdaa,cplSdSvcHpmcSuaa,cplSeSecHpmcSe1,             & 
& cplSeSvcHpmcSv1,AmpVertexHpmToSeSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Se Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToSeSv = 0._dp 
 AmpSum2HpmToSeSv = 0._dp  
Else 
 AmpSumHpmToSeSv = AmpVertexHpmToSeSv + AmpWaveHpmToSeSv
 AmpSum2HpmToSeSv = AmpVertexHpmToSeSv + AmpWaveHpmToSeSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSeOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSe(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MHpmOS(gt1),MSeOS(gt2),MSvOS(gt3),AmpSumHpmToSeSv(gt1, gt2, gt3),AmpSum2HpmToSeSv(gt1, gt2, gt3),AmpSqHpmToSeSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MHpm(gt1),MSe(gt2),MSv(gt3),AmpSumHpmToSeSv(gt1, gt2, gt3),AmpSum2HpmToSeSv(gt1, gt2, gt3),AmpSqHpmToSeSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqHpmToSeSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToSeSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSeOS(gt2),MSvOS(gt3),helfactor*AmpSqHpmToSeSv(gt1, gt2, gt3))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSe(gt2),MSv(gt3),helfactor*AmpSqHpmToSeSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPHpmToSeSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGHpmToSeSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Se VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeVP(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVP,             & 
& MVP2,ZfHpm,ZfSe,ZfVP,AmpWaveHpmToSeVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeVP(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVP,             & 
& MVP2,ZfHpm,ZfSe,ZfVP,AmpWaveHpmToSeVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeVP(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVP,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,               & 
& MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,          & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFeFvSeL,cplcFeFvSeR,cplSdcSdVP,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,     & 
& cplSecSeVP,cplSecHpmcSv,cplSucSuVP,AmpVertexHpmToSeVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeVP(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVP,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,               & 
& MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,          & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFeFvSeL,cplcFeFvSeR,cplSdcSdVP,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,     & 
& cplSecSeVP,cplSecHpmcSv,cplSucSuVP,AmpVertexHpmToSeVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeVP(MHpm,MHpm2,MSe,MSe2,MVP,MVP2,ZfHpm,          & 
& ZfSe,ZfVP,AmpWaveHpmToSeVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeVP(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,              & 
& MSv,MVP,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplSdcSdVP,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,      & 
& AmpVertexHpmToSeVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Se VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToSeVP = 0._dp 
 AmpSum2HpmToSeVP = 0._dp  
Else 
 AmpSumHpmToSeVP = AmpVertexHpmToSeVP + AmpWaveHpmToSeVP
 AmpSum2HpmToSeVP = AmpVertexHpmToSeVP + AmpWaveHpmToSeVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSeOS(gt2)+0.))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSe(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MSeOS(gt2),0._dp,AmpSumHpmToSeVP(:,gt1, gt2),AmpSum2HpmToSeVP(:,gt1, gt2),AmpSqHpmToSeVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MSe(gt2),MVP,AmpSumHpmToSeVP(:,gt1, gt2),AmpSum2HpmToSeVP(:,gt1, gt2),AmpSqHpmToSeVP(gt1, gt2)) 
End if  
Else  
  AmpSqHpmToSeVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToSeVP(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSeOS(gt2),0._dp,helfactor*AmpSqHpmToSeVP(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSe(gt2),MVP,helfactor*AmpSqHpmToSeVP(gt1, gt2))
End if 
If ((Abs(MRPHpmToSeVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToSeVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Se VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeVZ(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVZOS,           & 
& MVZ2OS,ZfHpm,ZfSe,ZfVZ,AmpWaveHpmToSeVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeVZ(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVZOS,           & 
& MVZ2OS,ZfHpm,ZfSe,ZfVZ,AmpWaveHpmToSeVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeVZ(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVZOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,        & 
& cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVZL,              & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvSeL,cplcFeFvSeR,cplSdcSdVZ,cplSdcHpmcSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,AmpVertexHpmToSeVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeVZ(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVZOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,        & 
& cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVZL,              & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvSeL,cplcFeFvSeR,cplSdcSdVZ,cplSdcHpmcSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,AmpVertexHpmToSeVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSeVZ(MHpm,MHpm2,MSe,MSe2,MVZ,MVZ2,ZfHpm,          & 
& ZfSe,ZfVZ,AmpWaveHpmToSeVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSeVZ(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,              & 
& MSv,MVZ,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvSeL,     & 
& cplcFeFvSeR,cplSdcSdVZ,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSucSuVZ,cplSvcSvVZ,AmpVertexHpmToSeVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Se VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToSeVZ = 0._dp 
 AmpSum2HpmToSeVZ = 0._dp  
Else 
 AmpSumHpmToSeVZ = AmpVertexHpmToSeVZ + AmpWaveHpmToSeVZ
 AmpSum2HpmToSeVZ = AmpVertexHpmToSeVZ + AmpWaveHpmToSeVZ 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSeOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSe(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MSeOS(gt2),MVZOS,AmpSumHpmToSeVZ(:,gt1, gt2),AmpSum2HpmToSeVZ(:,gt1, gt2),AmpSqHpmToSeVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MSe(gt2),MVZ,AmpSumHpmToSeVZ(:,gt1, gt2),AmpSum2HpmToSeVZ(:,gt1, gt2),AmpSqHpmToSeVZ(gt1, gt2)) 
End if  
Else  
  AmpSqHpmToSeVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToSeVZ(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSeOS(gt2),MVZOS,helfactor*AmpSqHpmToSeVZ(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSe(gt2),MVZ,helfactor*AmpSqHpmToSeVZ(gt1, gt2))
End if 
If ((Abs(MRPHpmToSeVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToSeVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Sv VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSvVWm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,MVWmOS,         & 
& MVWm2OS,ZfHpm,ZfSv,ZfVWm,AmpWaveHpmToSvVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSvVWm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,MVWmOS,         & 
& MVWm2OS,ZfHpm,ZfSv,ZfVWm,AmpWaveHpmToSvVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSvVWm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,           & 
& cplcFeFvVWmR,cplSdSvcSd,cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplSucSdVWm,              & 
& cplSvcSeVWm,AmpVertexHpmToSvVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSvVWm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,           & 
& cplcFeFvVWmR,cplSdSvcSd,cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplSucSdVWm,              & 
& cplSvcSeVWm,AmpVertexHpmToSvVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToSvVWm(MHpm,MHpm2,MSv,MSv2,MVWm,MVWm2,             & 
& ZfHpm,ZfSv,ZfVWm,AmpWaveHpmToSvVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToSvVWm(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,             & 
& MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdSvL,cplcFdFdSvR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,         & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdSvcSd,cplSdcHpmcSu,           & 
& cplSeSvcSe,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexHpmToSvVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->Sv VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToSvVWm = 0._dp 
 AmpSum2HpmToSvVWm = 0._dp  
Else 
 AmpSumHpmToSvVWm = AmpVertexHpmToSvVWm + AmpWaveHpmToSvVWm
 AmpSum2HpmToSvVWm = AmpVertexHpmToSvVWm + AmpWaveHpmToSvVWm 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSvOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSv(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MSvOS(gt2),MVWmOS,AmpSumHpmToSvVWm(:,gt1, gt2),AmpSum2HpmToSvVWm(:,gt1, gt2),AmpSqHpmToSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MSv(gt2),MVWm,AmpSumHpmToSvVWm(:,gt1, gt2),AmpSum2HpmToSvVWm(:,gt1, gt2),AmpSqHpmToSvVWm(gt1, gt2)) 
End if  
Else  
  AmpSqHpmToSvVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToSvVWm(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSvOS(gt2),MVWmOS,helfactor*AmpSqHpmToSvVWm(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSv(gt2),MVWm,helfactor*AmpSqHpmToSvVWm(gt1, gt2))
End if 
If ((Abs(MRPHpmToSvVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmToSvVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VP VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmToVPVWm(cplcHpmVPVWm,cplcHpmVWmVZ,ctcplcHpmVPVWm,   & 
& ctcplcHpmVWmVZ,MHpmOS,MHpm2OS,MVP,MVP2,MVWmOS,MVWm2OS,ZfHpm,ZfVP,ZfVWm,AmpWaveHpmToVPVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmToVPVWm(cplcHpmVPVWm,cplcHpmVWmVZ,ctcplcHpmVPVWm,   & 
& ctcplcHpmVWmVZ,MHpmOS,MHpm2OS,MVP,MVP2,MVWmOS,MVWm2OS,ZfHpm,ZfVP,ZfVWm,AmpWaveHpmToVPVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToVPVWm(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,          & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,           & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVPL,cplcFdFdVPR,     & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,         & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplcgWpCgAcHpm,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgWpCgWpCVP,cplcgAgWpCVWm,cplcgZgWpCVWm,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,       & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplSdcSdVP,cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,             & 
& cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,             & 
& cplcVWmVWmVZ,cplAhcHpmVPVWm1,cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,          & 
& cplHpmcHpmcVWmVWm1,cplSucSdVPVWmaa,cplSvcSeVPVWm1,cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,   & 
& cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,AmpVertexHpmToVPVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToVPVWm(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,          & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,           & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVPL,cplcFdFdVPR,     & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,         & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplcgWpCgAcHpm,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgWpCgWpCVP,cplcgAgWpCVWm,cplcgZgWpCVWm,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,       & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplSdcSdVP,cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,             & 
& cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,             & 
& cplcVWmVWmVZ,cplAhcHpmVPVWm1,cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,          & 
& cplHpmcHpmcVWmVWm1,cplSucSdVPVWmaa,cplSvcSeVPVWm1,cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,   & 
& cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,AmpVertexHpmToVPVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmToVPVWm(cplcHpmVPVWm,cplcHpmVWmVZ,ctcplcHpmVPVWm,   & 
& ctcplcHpmVWmVZ,MHpm,MHpm2,MVP,MVP2,MVWm,MVWm2,ZfHpm,ZfVP,ZfVWm,AmpWaveHpmToVPVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmToVPVWm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,          & 
& cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiVWmL,cplcChaChiVWmR,              & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgWpCgWpCVP,    & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplSdcSdVP,cplSdcHpmcSu,           & 
& cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVPVWm1,cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,& 
& cplHpmcHpmVPVZ1,cplHpmcHpmcVWmVWm1,cplSucSdVPVWmaa,cplSvcSeVPVWm1,cplcVWmVPVPVWm3Q,    & 
& cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,  & 
& AmpVertexHpmToVPVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->VP VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmToVPVWm = 0._dp 
 AmpSum2HpmToVPVWm = 0._dp  
Else 
 AmpSumHpmToVPVWm = AmpVertexHpmToVPVWm + AmpWaveHpmToVPVWm
 AmpSum2HpmToVPVWm = AmpVertexHpmToVPVWm + AmpWaveHpmToVPVWm 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MHpmOS(gt1).gt.(0.+MVWmOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MVP+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MHpmOS(gt1),0._dp,MVWmOS,AmpSumHpmToVPVWm(:,gt1),AmpSum2HpmToVPVWm(:,gt1),AmpSqHpmToVPVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MHpm(gt1),MVP,MVWm,AmpSumHpmToVPVWm(:,gt1),AmpSum2HpmToVPVWm(:,gt1),AmpSqHpmToVPVWm(gt1)) 
End if  
Else  
  AmpSqHpmToVPVWm(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmToVPVWm(gt1).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 2*GammaTPS(MHpmOS(gt1),0._dp,MVWmOS,helfactor*AmpSqHpmToVPVWm(gt1))
Else 
  gP1LHpm(gt1,i4) = 2*GammaTPS(MHpm(gt1),MVP,MVWm,helfactor*AmpSqHpmToVPVWm(gt1))
End if 
If ((Abs(MRPHpmToVPVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGHpmToVPVWm(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Conjg(Sv) VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_HpmTocSvVWm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& MVWmOS,MVWm2OS,ZfHpm,ZfSv,ZfVWm,AmpWaveHpmTocSvVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_HpmTocSvVWm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& MVWmOS,MVWm2OS,ZfHpm,ZfSv,ZfVWm,AmpWaveHpmTocSvVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTocSvVWm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,     & 
& cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,         & 
& cplcFeFvVWmR,cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSucSdVWm,            & 
& cplSvcSeVWm,AmpVertexHpmTocSvVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTocSvVWm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,     & 
& cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,         & 
& cplcFeFvVWmR,cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSucSdVWm,            & 
& cplSvcSeVWm,AmpVertexHpmTocSvVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_HpmTocSvVWm(MHpm,MHpm2,MSv,MSv2,MVWm,MVWm2,            & 
& ZfHpm,ZfSv,ZfVWm,AmpWaveHpmTocSvVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_HpmTocSvVWm(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,            & 
& MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,cplcFdFdcSvR,     & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,cplSdcSdcSv,          & 
& cplSecHpmcSv,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexHpmTocSvVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Hpm->conj[Sv] VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumHpmTocSvVWm = 0._dp 
 AmpSum2HpmTocSvVWm = 0._dp  
Else 
 AmpSumHpmTocSvVWm = AmpVertexHpmTocSvVWm + AmpWaveHpmTocSvVWm
 AmpSum2HpmTocSvVWm = AmpVertexHpmTocSvVWm + AmpWaveHpmTocSvVWm 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MHpmOS(gt1).gt.(MSvOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MHpm(gt1).gt.(MSv(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MHpmOS(gt1),MSvOS(gt2),MVWmOS,AmpSumHpmTocSvVWm(:,gt1, gt2),AmpSum2HpmTocSvVWm(:,gt1, gt2),AmpSqHpmTocSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MHpm(gt1),MSv(gt2),MVWm,AmpSumHpmTocSvVWm(:,gt1, gt2),AmpSum2HpmTocSvVWm(:,gt1, gt2),AmpSqHpmTocSvVWm(gt1, gt2)) 
End if  
Else  
  AmpSqHpmTocSvVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqHpmTocSvVWm(gt1, gt2).eq.0._dp) Then 
  gP1LHpm(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpmOS(gt1),MSvOS(gt2),MVWmOS,helfactor*AmpSqHpmTocSvVWm(gt1, gt2))
Else 
  gP1LHpm(gt1,i4) = 1*GammaTPS(MHpm(gt1),MSv(gt2),MVWm,helfactor*AmpSqHpmTocSvVWm(gt1, gt2))
End if 
If ((Abs(MRPHpmTocSvVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGHpmTocSvVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LHpm(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
End Subroutine OneLoopDecay_Hpm

End Module Wrapper_OneLoopDecay_Hpm_MSSMTriLnV
