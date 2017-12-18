! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Fu_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Fu_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Fu(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& ZfVPVZ,ZfVZVP,cplAhAhhh,cplAhcHpmVWm,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcChacFuSdL,cplcChacFuSdR,cplcChaChaAhL,            & 
& cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,   & 
& cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,             & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,     & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFdFdAhL,cplcFdFdAhR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFecFuSdL,cplcFecFuSdR,cplcFeChaSvL,cplcFeChaSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFeAhL,cplcFeFeAhR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFuFuAhL,cplcFuFuAhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplChaFucSdL,cplChaFucSdR,           & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChiChiAhL,              & 
& cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcHpmVPVWm,         & 
& cplcHpmVWmVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,           & 
& cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplGluGluVGL,cplGluGluVGR,cplhhcHpmVWm,cplhhcVWmVWm,cplhhhhhh,            & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhVZVZ,cplHpmcHpmVP,     & 
& cplHpmcHpmVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,           & 
& cplSdcSdcSv,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSecSu,cplSdcSucVWm,cplSdSvcSd,      & 
& cplSecHpmcSv,cplSecSecSv,cplSecSeVP,cplSecSeVZ,cplSecSvcVWm,cplSeSucSd,cplSeSvcSe,     & 
& cplSucSdVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplSvcSeVWm,cplVGVGVG,ctcplcChacFuSdL,    & 
& ctcplcChacFuSdR,ctcplcFecFuSdL,ctcplcFecFuSdR,ctcplcFuChiSuL,ctcplcFuChiSuR,           & 
& ctcplcFuFdcHpmL,ctcplcFuFdcHpmR,ctcplcFuFdcSeL,ctcplcFuFdcSeR,ctcplcFuFdcVWmL,         & 
& ctcplcFuFdcVWmR,ctcplcFuFuAhL,ctcplcFuFuAhR,ctcplcFuFuhhL,ctcplcFuFuhhR,               & 
& ctcplcFuFuVGL,ctcplcFuFuVGR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,   & 
& ctcplcFuGluSuL,ctcplcFuGluSuR,GcplcFuFdcHpmL,GcplcFuFdcHpmR,GcplcHpmVPVWm,             & 
& GcplHpmcVWmVP,GosZcplcFuFdcHpmL,GosZcplcFuFdcHpmR,GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,   & 
& GZcplcFuFdcHpmL,GZcplcFuFdcHpmR,GZcplcHpmVPVWm,GZcplHpmcVWmVP,ZcplcChacFuSdL,          & 
& ZcplcChacFuSdR,ZcplcChaChaVPL,ZcplcChaChaVPR,ZcplcChaFecSvL,ZcplcChaFecSvR,            & 
& ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplcFdChaSuL,ZcplcFdChaSuR,ZcplcFdFdcSvL,ZcplcFdFdcSvR,   & 
& ZcplcFdFdSvL,ZcplcFdFdSvR,ZcplcFdFdVGL,ZcplcFdFdVGR,ZcplcFdFdVPL,ZcplcFdFdVPR,         & 
& ZcplcFdFeSuL,ZcplcFdFeSuR,ZcplcFdFuHpmL,ZcplcFdFuHpmR,ZcplcFdFuSeL,ZcplcFdFuSeR,       & 
& ZcplcFdFuVWmL,ZcplcFdFuVWmR,ZcplcFdFvSdL,ZcplcFdFvSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,     & 
& ZcplcFeChaSvL,ZcplcFeChaSvR,ZcplcFeFecSvL,ZcplcFeFecSvR,ZcplcFeFeSvL,ZcplcFeFeSvR,     & 
& ZcplcFeFeVPL,ZcplcFeFeVPR,ZcplcFeFvHpmL,ZcplcFeFvHpmR,ZcplcFeFvSeL,ZcplcFeFvSeR,       & 
& ZcplcFeFvVWmL,ZcplcFeFvVWmR,ZcplcFuChiSuL,ZcplcFuChiSuR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR, & 
& ZcplcFuFdcSeL,ZcplcFuFdcSeR,ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,ZcplcFuFuAhL,ZcplcFuFuAhR,   & 
& ZcplcFuFuhhL,ZcplcFuFuhhR,ZcplcFuFuVGL,ZcplcFuFuVGR,ZcplcFuFuVPL,ZcplcFuFuVPR,         & 
& ZcplcFuFuVZL,ZcplcFuFuVZR,ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplChaFucSdL,ZcplChaFucSdR,     & 
& ZcplChiFucSuL,ZcplChiFucSuR,ZcplcHpmVPVWm,ZcplcVWmVPVWm,ZcplFeFucSdL,ZcplFeFucSdR,     & 
& ZcplFvChacSeL,ZcplFvChacSeR,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplFvFecHpmL,ZcplFvFecHpmR,     & 
& ZcplFvFecSeL,ZcplFvFecSeR,ZcplFvFecVWmL,ZcplFvFecVWmR,ZcplGluFucSuL,ZcplGluFucSuR,     & 
& ZcplGluGluVGL,ZcplGluGluVGR,ZcplHpmcHpmVP,ZcplHpmcVWmVP,ZcplHpmSucSd,ZcplHpmSvcSe,     & 
& ZcplSdcSdcSv,ZcplSdcSdVG,ZcplSdcSdVP,ZcplSdSvcSd,ZcplSecHpmcSv,ZcplSecSecSv,           & 
& ZcplSecSeVP,ZcplSecSvcVWm,ZcplSeSucSd,ZcplSeSvcSe,ZcplSucSdVWm,ZcplSucSuVG,            & 
& ZcplSucSuVP,ZcplSvcSeVWm,ZcplVGVGVG,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,               & 
& ZRUZP,ZRUZN,ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,             & 
& em,gs,deltaM,kont,gP1LFu)

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

Complex(dp),Intent(in) :: cplAhAhhh(2,2,2),cplAhcHpmVWm(2,2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),& 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplcChacFuSdL(2,3,6),            & 
& cplcChacFuSdR(2,3,6),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcChaChahhL(2,2,2),   & 
& cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),         & 
& cplcChaChaVZR(2,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),    & 
& cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),    & 
& cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFdChaSuL(3,2,6),      & 
& cplcFdChaSuR(3,2,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFdAhL(3,3,2),        & 
& cplcFdFdAhR(3,3,2),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),         & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),             & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFvHpmL(3,3,2),& 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFuFdcHpmL(3,3,2),        & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcFuFuhhL(3,3,2),           & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplChaFucSdL(2,3,6),& 
& cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),   & 
& cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),               & 
& cplGluGluVGL,cplGluGluVGR,cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhhhhh(2,2,2),          & 
& cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),             & 
& cplhhSucSu(2,6,6),cplhhVZVZ(2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplHpmcVWmVP(2)

Complex(dp),Intent(in) :: cplHpmcVWmVZ(2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcHpmcSu(6,2,6),             & 
& cplSdcSdcSv(6,6,3),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6), & 
& cplSdcSucVWm(6,6),cplSdSvcSd(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSvcVWm(6,3),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6), & 
& cplSucSdVWm(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),     & 
& cplVGVGVG,ctcplcChacFuSdL(2,3,6),ctcplcChacFuSdR(2,3,6),ctcplcFecFuSdL(3,3,6),         & 
& ctcplcFecFuSdR(3,3,6),ctcplcFuChiSuL(3,4,6),ctcplcFuChiSuR(3,4,6),ctcplcFuFdcHpmL(3,3,2),& 
& ctcplcFuFdcHpmR(3,3,2),ctcplcFuFdcSeL(3,3,6),ctcplcFuFdcSeR(3,3,6),ctcplcFuFdcVWmL(3,3),& 
& ctcplcFuFdcVWmR(3,3),ctcplcFuFuAhL(3,3,2),ctcplcFuFuAhR(3,3,2),ctcplcFuFuhhL(3,3,2),   & 
& ctcplcFuFuhhR(3,3,2),ctcplcFuFuVGL(3,3),ctcplcFuFuVGR(3,3),ctcplcFuFuVPL(3,3),         & 
& ctcplcFuFuVPR(3,3),ctcplcFuFuVZL(3,3),ctcplcFuFuVZR(3,3),ctcplcFuGluSuL(3,6),          & 
& ctcplcFuGluSuR(3,6),GcplcFuFdcHpmL(3,3,2),GcplcFuFdcHpmR(3,3,2),GcplcHpmVPVWm(2),      & 
& GcplHpmcVWmVP(2),GosZcplcFuFdcHpmL(3,3,2),GosZcplcFuFdcHpmR(3,3,2),GosZcplcHpmVPVWm(2),& 
& GosZcplHpmcVWmVP(2),GZcplcFuFdcHpmL(3,3,2),GZcplcFuFdcHpmR(3,3,2),GZcplcHpmVPVWm(2),   & 
& GZcplHpmcVWmVP(2),ZcplcChacFuSdL(2,3,6),ZcplcChacFuSdR(2,3,6),ZcplcChaChaVPL(2,2),     & 
& ZcplcChaChaVPR(2,2),ZcplcChaFecSvL(2,3,3),ZcplcChaFecSvR(2,3,3),ZcplcChaFvSeL(2,3,6),  & 
& ZcplcChaFvSeR(2,3,6),ZcplcFdChaSuL(3,2,6),ZcplcFdChaSuR(3,2,6),ZcplcFdFdcSvL(3,3,3),   & 
& ZcplcFdFdcSvR(3,3,3),ZcplcFdFdSvL(3,3,3),ZcplcFdFdSvR(3,3,3),ZcplcFdFdVGL(3,3),        & 
& ZcplcFdFdVGR(3,3),ZcplcFdFdVPL(3,3),ZcplcFdFdVPR(3,3),ZcplcFdFeSuL(3,3,6),             & 
& ZcplcFdFeSuR(3,3,6),ZcplcFdFuHpmL(3,3,2),ZcplcFdFuHpmR(3,3,2),ZcplcFdFuSeL(3,3,6),     & 
& ZcplcFdFuSeR(3,3,6),ZcplcFdFuVWmL(3,3),ZcplcFdFuVWmR(3,3),ZcplcFdFvSdL(3,3,6),         & 
& ZcplcFdFvSdR(3,3,6),ZcplcFecFuSdL(3,3,6),ZcplcFecFuSdR(3,3,6),ZcplcFeChaSvL(3,2,3),    & 
& ZcplcFeChaSvR(3,2,3),ZcplcFeFecSvL(3,3,3),ZcplcFeFecSvR(3,3,3),ZcplcFeFeSvL(3,3,3),    & 
& ZcplcFeFeSvR(3,3,3),ZcplcFeFeVPL(3,3),ZcplcFeFeVPR(3,3),ZcplcFeFvHpmL(3,3,2),          & 
& ZcplcFeFvHpmR(3,3,2),ZcplcFeFvSeL(3,3,6),ZcplcFeFvSeR(3,3,6),ZcplcFeFvVWmL(3,3),       & 
& ZcplcFeFvVWmR(3,3),ZcplcFuChiSuL(3,4,6),ZcplcFuChiSuR(3,4,6),ZcplcFuFdcHpmL(3,3,2),    & 
& ZcplcFuFdcHpmR(3,3,2),ZcplcFuFdcSeL(3,3,6),ZcplcFuFdcSeR(3,3,6),ZcplcFuFdcVWmL(3,3),   & 
& ZcplcFuFdcVWmR(3,3),ZcplcFuFuAhL(3,3,2),ZcplcFuFuAhR(3,3,2),ZcplcFuFuhhL(3,3,2),       & 
& ZcplcFuFuhhR(3,3,2),ZcplcFuFuVGL(3,3),ZcplcFuFuVGR(3,3),ZcplcFuFuVPL(3,3),             & 
& ZcplcFuFuVPR(3,3),ZcplcFuFuVZL(3,3),ZcplcFuFuVZR(3,3),ZcplcFuGluSuL(3,6),              & 
& ZcplcFuGluSuR(3,6),ZcplChaFucSdL(2,3,6),ZcplChaFucSdR(2,3,6),ZcplChiFucSuL(4,3,6),     & 
& ZcplChiFucSuR(4,3,6),ZcplcHpmVPVWm(2),ZcplcVWmVPVWm,ZcplFeFucSdL(3,3,6),               & 
& ZcplFeFucSdR(3,3,6),ZcplFvChacSeL(3,2,6),ZcplFvChacSeR(3,2,6),ZcplFvFdcSdL(3,3,6),     & 
& ZcplFvFdcSdR(3,3,6),ZcplFvFecHpmL(3,3,2),ZcplFvFecHpmR(3,3,2),ZcplFvFecSeL(3,3,6),     & 
& ZcplFvFecSeR(3,3,6),ZcplFvFecVWmL(3,3),ZcplFvFecVWmR(3,3),ZcplGluFucSuL(3,6),          & 
& ZcplGluFucSuR(3,6),ZcplGluGluVGL,ZcplGluGluVGR,ZcplHpmcHpmVP(2,2),ZcplHpmcVWmVP(2),    & 
& ZcplHpmSucSd(2,6,6),ZcplHpmSvcSe(2,3,6),ZcplSdcSdcSv(6,6,3),ZcplSdcSdVG(6,6)

Complex(dp),Intent(in) :: ZcplSdcSdVP(6,6),ZcplSdSvcSd(6,3,6),ZcplSecHpmcSv(6,2,3),ZcplSecSecSv(6,6,3),          & 
& ZcplSecSeVP(6,6),ZcplSecSvcVWm(6,3),ZcplSeSucSd(6,6,6),ZcplSeSvcSe(6,3,6),             & 
& ZcplSucSdVWm(6,6),ZcplSucSuVG(6,6),ZcplSucSuVP(6,6),ZcplSvcSeVWm(3,6),ZcplVGVGVG

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
Real(dp), Intent(out) :: gP1LFu(3,138) 
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
Real(dp) :: MRPFuToFuAh(3,3,2),MRGFuToFuAh(3,3,2), MRPZFuToFuAh(3,3,2),MRGZFuToFuAh(3,3,2) 
Real(dp) :: MVPFuToFuAh(3,3,2) 
Real(dp) :: RMsqTreeFuToFuAh(3,3,2),RMsqWaveFuToFuAh(3,3,2),RMsqVertexFuToFuAh(3,3,2) 
Complex(dp) :: AmpTreeFuToFuAh(2,3,3,2),AmpWaveFuToFuAh(2,3,3,2),AmpVertexFuToFuAh(2,3,3,2)& 
 & ,AmpVertexIRosFuToFuAh(2,3,3,2),AmpVertexIRdrFuToFuAh(2,3,3,2), AmpSumFuToFuAh(2,3,3,2), AmpSum2FuToFuAh(2,3,3,2) 
Complex(dp) :: AmpTreeZFuToFuAh(2,3,3,2),AmpWaveZFuToFuAh(2,3,3,2),AmpVertexZFuToFuAh(2,3,3,2) 
Real(dp) :: AmpSqFuToFuAh(3,3,2),  AmpSqTreeFuToFuAh(3,3,2) 
Real(dp) :: MRPFuToChiSu(3,4,6),MRGFuToChiSu(3,4,6), MRPZFuToChiSu(3,4,6),MRGZFuToChiSu(3,4,6) 
Real(dp) :: MVPFuToChiSu(3,4,6) 
Real(dp) :: RMsqTreeFuToChiSu(3,4,6),RMsqWaveFuToChiSu(3,4,6),RMsqVertexFuToChiSu(3,4,6) 
Complex(dp) :: AmpTreeFuToChiSu(2,3,4,6),AmpWaveFuToChiSu(2,3,4,6),AmpVertexFuToChiSu(2,3,4,6)& 
 & ,AmpVertexIRosFuToChiSu(2,3,4,6),AmpVertexIRdrFuToChiSu(2,3,4,6), AmpSumFuToChiSu(2,3,4,6), AmpSum2FuToChiSu(2,3,4,6) 
Complex(dp) :: AmpTreeZFuToChiSu(2,3,4,6),AmpWaveZFuToChiSu(2,3,4,6),AmpVertexZFuToChiSu(2,3,4,6) 
Real(dp) :: AmpSqFuToChiSu(3,4,6),  AmpSqTreeFuToChiSu(3,4,6) 
Real(dp) :: MRPFuToFdcHpm(3,3,2),MRGFuToFdcHpm(3,3,2), MRPZFuToFdcHpm(3,3,2),MRGZFuToFdcHpm(3,3,2) 
Real(dp) :: MVPFuToFdcHpm(3,3,2) 
Real(dp) :: RMsqTreeFuToFdcHpm(3,3,2),RMsqWaveFuToFdcHpm(3,3,2),RMsqVertexFuToFdcHpm(3,3,2) 
Complex(dp) :: AmpTreeFuToFdcHpm(2,3,3,2),AmpWaveFuToFdcHpm(2,3,3,2),AmpVertexFuToFdcHpm(2,3,3,2)& 
 & ,AmpVertexIRosFuToFdcHpm(2,3,3,2),AmpVertexIRdrFuToFdcHpm(2,3,3,2), AmpSumFuToFdcHpm(2,3,3,2), AmpSum2FuToFdcHpm(2,3,3,2) 
Complex(dp) :: AmpTreeZFuToFdcHpm(2,3,3,2),AmpWaveZFuToFdcHpm(2,3,3,2),AmpVertexZFuToFdcHpm(2,3,3,2) 
Real(dp) :: AmpSqFuToFdcHpm(3,3,2),  AmpSqTreeFuToFdcHpm(3,3,2) 
Real(dp) :: MRPFuToFdcSe(3,3,6),MRGFuToFdcSe(3,3,6), MRPZFuToFdcSe(3,3,6),MRGZFuToFdcSe(3,3,6) 
Real(dp) :: MVPFuToFdcSe(3,3,6) 
Real(dp) :: RMsqTreeFuToFdcSe(3,3,6),RMsqWaveFuToFdcSe(3,3,6),RMsqVertexFuToFdcSe(3,3,6) 
Complex(dp) :: AmpTreeFuToFdcSe(2,3,3,6),AmpWaveFuToFdcSe(2,3,3,6),AmpVertexFuToFdcSe(2,3,3,6)& 
 & ,AmpVertexIRosFuToFdcSe(2,3,3,6),AmpVertexIRdrFuToFdcSe(2,3,3,6), AmpSumFuToFdcSe(2,3,3,6), AmpSum2FuToFdcSe(2,3,3,6) 
Complex(dp) :: AmpTreeZFuToFdcSe(2,3,3,6),AmpWaveZFuToFdcSe(2,3,3,6),AmpVertexZFuToFdcSe(2,3,3,6) 
Real(dp) :: AmpSqFuToFdcSe(3,3,6),  AmpSqTreeFuToFdcSe(3,3,6) 
Real(dp) :: MRPFuToFdcVWm(3,3),MRGFuToFdcVWm(3,3), MRPZFuToFdcVWm(3,3),MRGZFuToFdcVWm(3,3) 
Real(dp) :: MVPFuToFdcVWm(3,3) 
Real(dp) :: RMsqTreeFuToFdcVWm(3,3),RMsqWaveFuToFdcVWm(3,3),RMsqVertexFuToFdcVWm(3,3) 
Complex(dp) :: AmpTreeFuToFdcVWm(4,3,3),AmpWaveFuToFdcVWm(4,3,3),AmpVertexFuToFdcVWm(4,3,3)& 
 & ,AmpVertexIRosFuToFdcVWm(4,3,3),AmpVertexIRdrFuToFdcVWm(4,3,3), AmpSumFuToFdcVWm(4,3,3), AmpSum2FuToFdcVWm(4,3,3) 
Complex(dp) :: AmpTreeZFuToFdcVWm(4,3,3),AmpWaveZFuToFdcVWm(4,3,3),AmpVertexZFuToFdcVWm(4,3,3) 
Real(dp) :: AmpSqFuToFdcVWm(3,3),  AmpSqTreeFuToFdcVWm(3,3) 
Real(dp) :: MRPFuToFuhh(3,3,2),MRGFuToFuhh(3,3,2), MRPZFuToFuhh(3,3,2),MRGZFuToFuhh(3,3,2) 
Real(dp) :: MVPFuToFuhh(3,3,2) 
Real(dp) :: RMsqTreeFuToFuhh(3,3,2),RMsqWaveFuToFuhh(3,3,2),RMsqVertexFuToFuhh(3,3,2) 
Complex(dp) :: AmpTreeFuToFuhh(2,3,3,2),AmpWaveFuToFuhh(2,3,3,2),AmpVertexFuToFuhh(2,3,3,2)& 
 & ,AmpVertexIRosFuToFuhh(2,3,3,2),AmpVertexIRdrFuToFuhh(2,3,3,2), AmpSumFuToFuhh(2,3,3,2), AmpSum2FuToFuhh(2,3,3,2) 
Complex(dp) :: AmpTreeZFuToFuhh(2,3,3,2),AmpWaveZFuToFuhh(2,3,3,2),AmpVertexZFuToFuhh(2,3,3,2) 
Real(dp) :: AmpSqFuToFuhh(3,3,2),  AmpSqTreeFuToFuhh(3,3,2) 
Real(dp) :: MRPFuToFuVZ(3,3),MRGFuToFuVZ(3,3), MRPZFuToFuVZ(3,3),MRGZFuToFuVZ(3,3) 
Real(dp) :: MVPFuToFuVZ(3,3) 
Real(dp) :: RMsqTreeFuToFuVZ(3,3),RMsqWaveFuToFuVZ(3,3),RMsqVertexFuToFuVZ(3,3) 
Complex(dp) :: AmpTreeFuToFuVZ(4,3,3),AmpWaveFuToFuVZ(4,3,3),AmpVertexFuToFuVZ(4,3,3)& 
 & ,AmpVertexIRosFuToFuVZ(4,3,3),AmpVertexIRdrFuToFuVZ(4,3,3), AmpSumFuToFuVZ(4,3,3), AmpSum2FuToFuVZ(4,3,3) 
Complex(dp) :: AmpTreeZFuToFuVZ(4,3,3),AmpWaveZFuToFuVZ(4,3,3),AmpVertexZFuToFuVZ(4,3,3) 
Real(dp) :: AmpSqFuToFuVZ(3,3),  AmpSqTreeFuToFuVZ(3,3) 
Real(dp) :: MRPFuToGluSu(3,6),MRGFuToGluSu(3,6), MRPZFuToGluSu(3,6),MRGZFuToGluSu(3,6) 
Real(dp) :: MVPFuToGluSu(3,6) 
Real(dp) :: RMsqTreeFuToGluSu(3,6),RMsqWaveFuToGluSu(3,6),RMsqVertexFuToGluSu(3,6) 
Complex(dp) :: AmpTreeFuToGluSu(2,3,6),AmpWaveFuToGluSu(2,3,6),AmpVertexFuToGluSu(2,3,6)& 
 & ,AmpVertexIRosFuToGluSu(2,3,6),AmpVertexIRdrFuToGluSu(2,3,6), AmpSumFuToGluSu(2,3,6), AmpSum2FuToGluSu(2,3,6) 
Complex(dp) :: AmpTreeZFuToGluSu(2,3,6),AmpWaveZFuToGluSu(2,3,6),AmpVertexZFuToGluSu(2,3,6) 
Real(dp) :: AmpSqFuToGluSu(3,6),  AmpSqTreeFuToGluSu(3,6) 
Real(dp) :: MRPFuTocChaSd(3,2,6),MRGFuTocChaSd(3,2,6), MRPZFuTocChaSd(3,2,6),MRGZFuTocChaSd(3,2,6) 
Real(dp) :: MVPFuTocChaSd(3,2,6) 
Real(dp) :: RMsqTreeFuTocChaSd(3,2,6),RMsqWaveFuTocChaSd(3,2,6),RMsqVertexFuTocChaSd(3,2,6) 
Complex(dp) :: AmpTreeFuTocChaSd(2,3,2,6),AmpWaveFuTocChaSd(2,3,2,6),AmpVertexFuTocChaSd(2,3,2,6)& 
 & ,AmpVertexIRosFuTocChaSd(2,3,2,6),AmpVertexIRdrFuTocChaSd(2,3,2,6), AmpSumFuTocChaSd(2,3,2,6), AmpSum2FuTocChaSd(2,3,2,6) 
Complex(dp) :: AmpTreeZFuTocChaSd(2,3,2,6),AmpWaveZFuTocChaSd(2,3,2,6),AmpVertexZFuTocChaSd(2,3,2,6) 
Real(dp) :: AmpSqFuTocChaSd(3,2,6),  AmpSqTreeFuTocChaSd(3,2,6) 
Real(dp) :: MRPFuTocFeSd(3,3,6),MRGFuTocFeSd(3,3,6), MRPZFuTocFeSd(3,3,6),MRGZFuTocFeSd(3,3,6) 
Real(dp) :: MVPFuTocFeSd(3,3,6) 
Real(dp) :: RMsqTreeFuTocFeSd(3,3,6),RMsqWaveFuTocFeSd(3,3,6),RMsqVertexFuTocFeSd(3,3,6) 
Complex(dp) :: AmpTreeFuTocFeSd(2,3,3,6),AmpWaveFuTocFeSd(2,3,3,6),AmpVertexFuTocFeSd(2,3,3,6)& 
 & ,AmpVertexIRosFuTocFeSd(2,3,3,6),AmpVertexIRdrFuTocFeSd(2,3,3,6), AmpSumFuTocFeSd(2,3,3,6), AmpSum2FuTocFeSd(2,3,3,6) 
Complex(dp) :: AmpTreeZFuTocFeSd(2,3,3,6),AmpWaveZFuTocFeSd(2,3,3,6),AmpVertexZFuTocFeSd(2,3,3,6) 
Real(dp) :: AmpSqFuTocFeSd(3,3,6),  AmpSqTreeFuTocFeSd(3,3,6) 
Real(dp) :: MRPFuToFuSv(3,3,3),MRGFuToFuSv(3,3,3), MRPZFuToFuSv(3,3,3),MRGZFuToFuSv(3,3,3) 
Real(dp) :: MVPFuToFuSv(3,3,3) 
Real(dp) :: RMsqTreeFuToFuSv(3,3,3),RMsqWaveFuToFuSv(3,3,3),RMsqVertexFuToFuSv(3,3,3) 
Complex(dp) :: AmpTreeFuToFuSv(2,3,3,3),AmpWaveFuToFuSv(2,3,3,3),AmpVertexFuToFuSv(2,3,3,3)& 
 & ,AmpVertexIRosFuToFuSv(2,3,3,3),AmpVertexIRdrFuToFuSv(2,3,3,3), AmpSumFuToFuSv(2,3,3,3), AmpSum2FuToFuSv(2,3,3,3) 
Complex(dp) :: AmpTreeZFuToFuSv(2,3,3,3),AmpWaveZFuToFuSv(2,3,3,3),AmpVertexZFuToFuSv(2,3,3,3) 
Real(dp) :: AmpSqFuToFuSv(3,3,3),  AmpSqTreeFuToFuSv(3,3,3) 
Real(dp) :: MRPFuToFuVG(3,3),MRGFuToFuVG(3,3), MRPZFuToFuVG(3,3),MRGZFuToFuVG(3,3) 
Real(dp) :: MVPFuToFuVG(3,3) 
Real(dp) :: RMsqTreeFuToFuVG(3,3),RMsqWaveFuToFuVG(3,3),RMsqVertexFuToFuVG(3,3) 
Complex(dp) :: AmpTreeFuToFuVG(4,3,3),AmpWaveFuToFuVG(4,3,3),AmpVertexFuToFuVG(4,3,3)& 
 & ,AmpVertexIRosFuToFuVG(4,3,3),AmpVertexIRdrFuToFuVG(4,3,3), AmpSumFuToFuVG(4,3,3), AmpSum2FuToFuVG(4,3,3) 
Complex(dp) :: AmpTreeZFuToFuVG(4,3,3),AmpWaveZFuToFuVG(4,3,3),AmpVertexZFuToFuVG(4,3,3) 
Real(dp) :: AmpSqFuToFuVG(3,3),  AmpSqTreeFuToFuVG(3,3) 
Real(dp) :: MRPFuToFuVP(3,3),MRGFuToFuVP(3,3), MRPZFuToFuVP(3,3),MRGZFuToFuVP(3,3) 
Real(dp) :: MVPFuToFuVP(3,3) 
Real(dp) :: RMsqTreeFuToFuVP(3,3),RMsqWaveFuToFuVP(3,3),RMsqVertexFuToFuVP(3,3) 
Complex(dp) :: AmpTreeFuToFuVP(4,3,3),AmpWaveFuToFuVP(4,3,3),AmpVertexFuToFuVP(4,3,3)& 
 & ,AmpVertexIRosFuToFuVP(4,3,3),AmpVertexIRdrFuToFuVP(4,3,3), AmpSumFuToFuVP(4,3,3), AmpSum2FuToFuVP(4,3,3) 
Complex(dp) :: AmpTreeZFuToFuVP(4,3,3),AmpWaveZFuToFuVP(4,3,3),AmpVertexZFuToFuVP(4,3,3) 
Real(dp) :: AmpSqFuToFuVP(3,3),  AmpSqTreeFuToFuVP(3,3) 
Real(dp) :: MRPFuToFucSv(3,3,3),MRGFuToFucSv(3,3,3), MRPZFuToFucSv(3,3,3),MRGZFuToFucSv(3,3,3) 
Real(dp) :: MVPFuToFucSv(3,3,3) 
Real(dp) :: RMsqTreeFuToFucSv(3,3,3),RMsqWaveFuToFucSv(3,3,3),RMsqVertexFuToFucSv(3,3,3) 
Complex(dp) :: AmpTreeFuToFucSv(2,3,3,3),AmpWaveFuToFucSv(2,3,3,3),AmpVertexFuToFucSv(2,3,3,3)& 
 & ,AmpVertexIRosFuToFucSv(2,3,3,3),AmpVertexIRdrFuToFucSv(2,3,3,3), AmpSumFuToFucSv(2,3,3,3), AmpSum2FuToFucSv(2,3,3,3) 
Complex(dp) :: AmpTreeZFuToFucSv(2,3,3,3),AmpWaveZFuToFucSv(2,3,3,3),AmpVertexZFuToFucSv(2,3,3,3) 
Real(dp) :: AmpSqFuToFucSv(3,3,3),  AmpSqTreeFuToFucSv(3,3,3) 
Real(dp) :: MRPFuToFvSu(3,3,6),MRGFuToFvSu(3,3,6), MRPZFuToFvSu(3,3,6),MRGZFuToFvSu(3,3,6) 
Real(dp) :: MVPFuToFvSu(3,3,6) 
Real(dp) :: RMsqTreeFuToFvSu(3,3,6),RMsqWaveFuToFvSu(3,3,6),RMsqVertexFuToFvSu(3,3,6) 
Complex(dp) :: AmpTreeFuToFvSu(2,3,3,6),AmpWaveFuToFvSu(2,3,3,6),AmpVertexFuToFvSu(2,3,3,6)& 
 & ,AmpVertexIRosFuToFvSu(2,3,3,6),AmpVertexIRdrFuToFvSu(2,3,3,6), AmpSumFuToFvSu(2,3,3,6), AmpSum2FuToFvSu(2,3,3,6) 
Complex(dp) :: AmpTreeZFuToFvSu(2,3,3,6),AmpWaveZFuToFvSu(2,3,3,6),AmpVertexZFuToFvSu(2,3,3,6) 
Real(dp) :: AmpSqFuToFvSu(3,3,6),  AmpSqTreeFuToFvSu(3,3,6) 
Write(*,*) "Calculating one-loop decays of Fu " 
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
! Fu Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToFuAh(cplcFuFuAhL,cplcFuFuAhR,MAh,MFu,              & 
& MAh2,MFu2,AmpTreeFuToFuAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToFuAh(ZcplcFuFuAhL,ZcplcFuFuAhR,MAh,MFu,            & 
& MAh2,MFu2,AmpTreeFuToFuAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuAh(MLambda,em,gs,cplcFuFuAhL,cplcFuFuAhR,            & 
& MAhOS,MFuOS,MRPFuToFuAh,MRGFuToFuAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuAh(MLambda,em,gs,ZcplcFuFuAhL,ZcplcFuFuAhR,          & 
& MAhOS,MFuOS,MRPFuToFuAh,MRGFuToFuAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToFuAh(MLambda,em,gs,cplcFuFuAhL,cplcFuFuAhR,            & 
& MAh,MFu,MRPFuToFuAh,MRGFuToFuAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuAh(MLambda,em,gs,ZcplcFuFuAhL,ZcplcFuFuAhR,          & 
& MAh,MFu,MRPFuToFuAh,MRGFuToFuAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuAh(cplcFuFuAhL,cplcFuFuAhR,ctcplcFuFuAhL,        & 
& ctcplcFuFuAhR,MAh,MAh2,MFu,MFu2,ZfAh,ZfFUL,ZfFUR,AmpWaveFuToFuAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuAh(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,           & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,         & 
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexFuToFuAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRdrFuToFuAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,ZcplcFuFuAhL,             & 
& ZcplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,     & 
& cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,        & 
& cplcFecFuSdR,AmpVertexIRosFuToFuAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,ZcplcFuFuAhL,ZcplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,             & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosFuToFuAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,        & 
& cplcFecFuSdR,AmpVertexIRosFuToFuAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosFuToFuAh)

 End if 
 End if 
AmpVertexFuToFuAh = AmpVertexFuToFuAh -  AmpVertexIRdrFuToFuAh! +  AmpVertexIRosFuToFuAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToFuAh=0._dp 
AmpVertexZFuToFuAh=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFuAh(1,gt2,:,:) = AmpWaveZFuToFuAh(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFuAh(1,gt1,:,:) 
AmpVertexZFuToFuAh(1,gt2,:,:)= AmpVertexZFuToFuAh(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFuAh(1,gt1,:,:) 
AmpWaveZFuToFuAh(2,gt2,:,:) = AmpWaveZFuToFuAh(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFuAh(2,gt1,:,:) 
AmpVertexZFuToFuAh(2,gt2,:,:)= AmpVertexZFuToFuAh(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFuAh(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuToFuAh=AmpWaveZFuToFuAh 
AmpVertexFuToFuAh= AmpVertexZFuToFuAh
! Final State 1 
AmpWaveZFuToFuAh=0._dp 
AmpVertexZFuToFuAh=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFuAh(1,:,gt2,:) = AmpWaveZFuToFuAh(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpWaveFuToFuAh(1,:,gt1,:) 
AmpVertexZFuToFuAh(1,:,gt2,:)= AmpVertexZFuToFuAh(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpVertexFuToFuAh(1,:,gt1,:) 
AmpWaveZFuToFuAh(2,:,gt2,:) = AmpWaveZFuToFuAh(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpWaveFuToFuAh(2,:,gt1,:) 
AmpVertexZFuToFuAh(2,:,gt2,:)= AmpVertexZFuToFuAh(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpVertexFuToFuAh(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuToFuAh=AmpWaveZFuToFuAh 
AmpVertexFuToFuAh= AmpVertexZFuToFuAh
! Final State 2 
AmpWaveZFuToFuAh=0._dp 
AmpVertexZFuToFuAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZFuToFuAh(:,:,:,gt2) = AmpWaveZFuToFuAh(:,:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveFuToFuAh(:,:,:,gt1) 
AmpVertexZFuToFuAh(:,:,:,gt2)= AmpVertexZFuToFuAh(:,:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexFuToFuAh(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuToFuAh=AmpWaveZFuToFuAh 
AmpVertexFuToFuAh= AmpVertexZFuToFuAh
End if
If (ShiftIRdiv) Then 
AmpVertexFuToFuAh = AmpVertexFuToFuAh  +  AmpVertexIRosFuToFuAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToFuAh = AmpTreeFuToFuAh 
 AmpSum2FuToFuAh = AmpTreeFuToFuAh + 2._dp*AmpWaveFuToFuAh + 2._dp*AmpVertexFuToFuAh  
Else 
 AmpSumFuToFuAh = AmpTreeFuToFuAh + AmpWaveFuToFuAh + AmpVertexFuToFuAh
 AmpSum2FuToFuAh = AmpTreeFuToFuAh + AmpWaveFuToFuAh + AmpVertexFuToFuAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFuAh = AmpTreeFuToFuAh
 AmpSum2FuToFuAh = AmpTreeFuToFuAh 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=2,2
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuToFuAh = AmpTreeFuToFuAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MAh(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToFuAh(gt1, gt2, gt3) 
  AmpSum2FuToFuAh = 2._dp*AmpWaveFuToFuAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MAh(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToFuAh(gt1, gt2, gt3) 
  AmpSum2FuToFuAh = 2._dp*AmpVertexFuToFuAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MAh(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToFuAh(gt1, gt2, gt3) 
  AmpSum2FuToFuAh = AmpTreeFuToFuAh + 2._dp*AmpWaveFuToFuAh + 2._dp*AmpVertexFuToFuAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MAh(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToFuAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToFuAh = AmpTreeFuToFuAh
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
  AmpSqTreeFuToFuAh(gt1, gt2, gt3) = (1)*AmpSqFuToFuAh(gt1, gt2, gt3)  
  AmpSum2FuToFuAh = + 2._dp*AmpWaveFuToFuAh + 2._dp*AmpVertexFuToFuAh
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
  AmpSqFuToFuAh(gt1, gt2, gt3) = AmpSqFuToFuAh(gt1, gt2, gt3) + AmpSqTreeFuToFuAh(gt1, gt2, gt3)  
Else  
  AmpSum2FuToFuAh = AmpTreeFuToFuAh
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MAh(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
  AmpSqTreeFuToFuAh(gt1, gt2, gt3) = (1)*AmpSqFuToFuAh(gt1, gt2, gt3)  
  AmpSum2FuToFuAh = + 2._dp*AmpWaveFuToFuAh + 2._dp*AmpVertexFuToFuAh
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MAh(gt3),AmpSumFuToFuAh(:,gt1, gt2, gt3),AmpSum2FuToFuAh(:,gt1, gt2, gt3),AmpSqFuToFuAh(gt1, gt2, gt3)) 
  AmpSqFuToFuAh(gt1, gt2, gt3) = AmpSqFuToFuAh(gt1, gt2, gt3) + AmpSqTreeFuToFuAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuToFuAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFuAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),MAhOS(gt3),helfactor*AmpSqFuToFuAh(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),MAh(gt3),helfactor*AmpSqFuToFuAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFuAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToFuAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFuAh(gt1, gt2, gt3) + MRGFuToFuAh(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFuAh(gt1, gt2, gt3) + MRGFuToFuAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Chi Su
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToChiSu(cplcFuChiSuL,cplcFuChiSuR,MChi,              & 
& MFu,MSu,MChi2,MFu2,MSu2,AmpTreeFuToChiSu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToChiSu(ZcplcFuChiSuL,ZcplcFuChiSuR,MChi,            & 
& MFu,MSu,MChi2,MFu2,MSu2,AmpTreeFuToChiSu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToChiSu(MLambda,em,gs,cplcFuChiSuL,cplcFuChiSuR,         & 
& MChiOS,MFuOS,MSuOS,MRPFuToChiSu,MRGFuToChiSu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToChiSu(MLambda,em,gs,ZcplcFuChiSuL,ZcplcFuChiSuR,       & 
& MChiOS,MFuOS,MSuOS,MRPFuToChiSu,MRGFuToChiSu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToChiSu(MLambda,em,gs,cplcFuChiSuL,cplcFuChiSuR,         & 
& MChi,MFu,MSu,MRPFuToChiSu,MRGFuToChiSu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToChiSu(MLambda,em,gs,ZcplcFuChiSuL,ZcplcFuChiSuR,       & 
& MChi,MFu,MSu,MRPFuToChiSu,MRGFuToChiSu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToChiSu(cplcFuChiSuL,cplcFuChiSuR,ctcplcFuChiSuL,    & 
& ctcplcFuChiSuR,MChi,MChi2,MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,ZfL0,ZfSu,AmpWaveFuToChiSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToChiSu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,              & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,    & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,              & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexFuToChiSu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,    & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,              & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRdrFuToChiSu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcFdChaSuL,   & 
& cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,       & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,ZcplcFuChiSuL,      & 
& ZcplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,               & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,              & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,cplSucSuVG,           & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToChiSu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,ZcplcFuChiSuL,ZcplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,  & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,              & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToChiSu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcFdChaSuL,   & 
& cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,       & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,   & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,cplcFuFuhhL,          & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,            & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,cplSucSuVG,cplSucSuVP,              & 
& cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToChiSu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,    & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,              & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToChiSu)

 End if 
 End if 
AmpVertexFuToChiSu = AmpVertexFuToChiSu -  AmpVertexIRdrFuToChiSu! +  AmpVertexIRosFuToChiSu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToChiSu=0._dp 
AmpVertexZFuToChiSu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToChiSu(1,gt2,:,:) = AmpWaveZFuToChiSu(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToChiSu(1,gt1,:,:) 
AmpVertexZFuToChiSu(1,gt2,:,:)= AmpVertexZFuToChiSu(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToChiSu(1,gt1,:,:) 
AmpWaveZFuToChiSu(2,gt2,:,:) = AmpWaveZFuToChiSu(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToChiSu(2,gt1,:,:) 
AmpVertexZFuToChiSu(2,gt2,:,:)= AmpVertexZFuToChiSu(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToChiSu(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuToChiSu=AmpWaveZFuToChiSu 
AmpVertexFuToChiSu= AmpVertexZFuToChiSu
! Final State 1 
AmpWaveZFuToChiSu=0._dp 
AmpVertexZFuToChiSu=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZFuToChiSu(1,:,gt2,:) = AmpWaveZFuToChiSu(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpWaveFuToChiSu(1,:,gt1,:) 
AmpVertexZFuToChiSu(1,:,gt2,:)= AmpVertexZFuToChiSu(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpVertexFuToChiSu(1,:,gt1,:) 
AmpWaveZFuToChiSu(2,:,gt2,:) = AmpWaveZFuToChiSu(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpWaveFuToChiSu(2,:,gt1,:) 
AmpVertexZFuToChiSu(2,:,gt2,:)= AmpVertexZFuToChiSu(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpVertexFuToChiSu(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuToChiSu=AmpWaveZFuToChiSu 
AmpVertexFuToChiSu= AmpVertexZFuToChiSu
! Final State 2 
AmpWaveZFuToChiSu=0._dp 
AmpVertexZFuToChiSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZFuToChiSu(:,:,:,gt2) = AmpWaveZFuToChiSu(:,:,:,gt2)+ZRUZU(gt2,gt1)*AmpWaveFuToChiSu(:,:,:,gt1) 
AmpVertexZFuToChiSu(:,:,:,gt2)= AmpVertexZFuToChiSu(:,:,:,gt2)+ZRUZU(gt2,gt1)*AmpVertexFuToChiSu(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuToChiSu=AmpWaveZFuToChiSu 
AmpVertexFuToChiSu= AmpVertexZFuToChiSu
End if
If (ShiftIRdiv) Then 
AmpVertexFuToChiSu = AmpVertexFuToChiSu  +  AmpVertexIRosFuToChiSu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Chi Su -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToChiSu = AmpTreeFuToChiSu 
 AmpSum2FuToChiSu = AmpTreeFuToChiSu + 2._dp*AmpWaveFuToChiSu + 2._dp*AmpVertexFuToChiSu  
Else 
 AmpSumFuToChiSu = AmpTreeFuToChiSu + AmpWaveFuToChiSu + AmpVertexFuToChiSu
 AmpSum2FuToChiSu = AmpTreeFuToChiSu + AmpWaveFuToChiSu + AmpVertexFuToChiSu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToChiSu = AmpTreeFuToChiSu
 AmpSum2FuToChiSu = AmpTreeFuToChiSu 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,4
    Do gt3=1,6
If (((OSkinematics).and.(MFuOS(gt1).gt.(MChiOS(gt2)+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MChi(gt2)+MSu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuToChiSu = AmpTreeFuToChiSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MChi(gt2),MSu(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToChiSu(gt1, gt2, gt3) 
  AmpSum2FuToChiSu = 2._dp*AmpWaveFuToChiSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MChi(gt2),MSu(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToChiSu(gt1, gt2, gt3) 
  AmpSum2FuToChiSu = 2._dp*AmpVertexFuToChiSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MChi(gt2),MSu(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToChiSu(gt1, gt2, gt3) 
  AmpSum2FuToChiSu = AmpTreeFuToChiSu + 2._dp*AmpWaveFuToChiSu + 2._dp*AmpVertexFuToChiSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MChi(gt2),MSu(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToChiSu(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToChiSu = AmpTreeFuToChiSu
  Call SquareAmp_FtoFS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
  AmpSqTreeFuToChiSu(gt1, gt2, gt3) = (1)*AmpSqFuToChiSu(gt1, gt2, gt3)  
  AmpSum2FuToChiSu = + 2._dp*AmpWaveFuToChiSu + 2._dp*AmpVertexFuToChiSu
  Call SquareAmp_FtoFS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
  AmpSqFuToChiSu(gt1, gt2, gt3) = AmpSqFuToChiSu(gt1, gt2, gt3) + AmpSqTreeFuToChiSu(gt1, gt2, gt3)  
Else  
  AmpSum2FuToChiSu = AmpTreeFuToChiSu
  Call SquareAmp_FtoFS(MFu(gt1),MChi(gt2),MSu(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
  AmpSqTreeFuToChiSu(gt1, gt2, gt3) = (1)*AmpSqFuToChiSu(gt1, gt2, gt3)  
  AmpSum2FuToChiSu = + 2._dp*AmpWaveFuToChiSu + 2._dp*AmpVertexFuToChiSu
  Call SquareAmp_FtoFS(MFu(gt1),MChi(gt2),MSu(gt3),AmpSumFuToChiSu(:,gt1, gt2, gt3),AmpSum2FuToChiSu(:,gt1, gt2, gt3),AmpSqFuToChiSu(gt1, gt2, gt3)) 
  AmpSqFuToChiSu(gt1, gt2, gt3) = AmpSqFuToChiSu(gt1, gt2, gt3) + AmpSqTreeFuToChiSu(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuToChiSu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToChiSu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MChiOS(gt2),MSuOS(gt3),helfactor*AmpSqFuToChiSu(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MChi(gt2),MSu(gt3),helfactor*AmpSqFuToChiSu(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToChiSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToChiSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToChiSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToChiSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToChiSu(gt1, gt2, gt3) + MRGFuToChiSu(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToChiSu(gt1, gt2, gt3) + MRGFuToChiSu(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fd Conjg(Hpm)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToFdcHpm(cplcFuFdcHpmL,cplcFuFdcHpmR,MFd,            & 
& MFu,MHpm,MFd2,MFu2,MHpm2,AmpTreeFuToFdcHpm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToFdcHpm(ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,              & 
& MFd,MFu,MHpm,MFd2,MFu2,MHpm2,AmpTreeFuToFdcHpm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcHpm(MLambda,em,gs,cplcFuFdcHpmL,cplcFuFdcHpmR,      & 
& MFdOS,MFuOS,MHpmOS,MRPFuToFdcHpm,MRGFuToFdcHpm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcHpm(MLambda,em,gs,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,    & 
& MFdOS,MFuOS,MHpmOS,MRPFuToFdcHpm,MRGFuToFdcHpm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToFdcHpm(MLambda,em,gs,cplcFuFdcHpmL,cplcFuFdcHpmR,      & 
& MFd,MFu,MHpm,MRPFuToFdcHpm,MRGFuToFdcHpm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcHpm(MLambda,em,gs,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,    & 
& MFd,MFu,MHpm,MRPFuToFdcHpm,MRGFuToFdcHpm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFdcHpm(cplcFuFdcHpmL,cplcFuFdcHpmR,ctcplcFuFdcHpmL,& 
& ctcplcFuFdcHpmR,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,ZfFDL,ZfFDR,ZfFUL,ZfFUR,ZfHpm,            & 
& AmpWaveFuToFdcHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFdcHpm(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
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
& cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexFuToFdcHpm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRdrFuToFdcHpm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplcHpmVWmVZ,AmpVertexIRosFuToFdcHpm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosFuToFdcHpm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplcHpmVWmVZ,AmpVertexIRosFuToFdcHpm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,AmpVertexIRosFuToFdcHpm)

 End if 
 End if 
AmpVertexFuToFdcHpm = AmpVertexFuToFdcHpm -  AmpVertexIRdrFuToFdcHpm! +  AmpVertexIRosFuToFdcHpm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToFdcHpm=0._dp 
AmpVertexZFuToFdcHpm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFdcHpm(1,gt2,:,:) = AmpWaveZFuToFdcHpm(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFdcHpm(1,gt1,:,:) 
AmpVertexZFuToFdcHpm(1,gt2,:,:)= AmpVertexZFuToFdcHpm(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFdcHpm(1,gt1,:,:) 
AmpWaveZFuToFdcHpm(2,gt2,:,:) = AmpWaveZFuToFdcHpm(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFdcHpm(2,gt1,:,:) 
AmpVertexZFuToFdcHpm(2,gt2,:,:)= AmpVertexZFuToFdcHpm(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFdcHpm(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuToFdcHpm=AmpWaveZFuToFdcHpm 
AmpVertexFuToFdcHpm= AmpVertexZFuToFdcHpm
! Final State 1 
AmpWaveZFuToFdcHpm=0._dp 
AmpVertexZFuToFdcHpm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFdcHpm(1,:,gt2,:) = AmpWaveZFuToFdcHpm(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpWaveFuToFdcHpm(1,:,gt1,:) 
AmpVertexZFuToFdcHpm(1,:,gt2,:)= AmpVertexZFuToFdcHpm(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpVertexFuToFdcHpm(1,:,gt1,:) 
AmpWaveZFuToFdcHpm(2,:,gt2,:) = AmpWaveZFuToFdcHpm(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpWaveFuToFdcHpm(2,:,gt1,:) 
AmpVertexZFuToFdcHpm(2,:,gt2,:)= AmpVertexZFuToFdcHpm(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpVertexFuToFdcHpm(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuToFdcHpm=AmpWaveZFuToFdcHpm 
AmpVertexFuToFdcHpm= AmpVertexZFuToFdcHpm
! Final State 2 
AmpWaveZFuToFdcHpm=0._dp 
AmpVertexZFuToFdcHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZFuToFdcHpm(:,:,:,gt2) = AmpWaveZFuToFdcHpm(:,:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveFuToFdcHpm(:,:,:,gt1) 
AmpVertexZFuToFdcHpm(:,:,:,gt2)= AmpVertexZFuToFdcHpm(:,:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexFuToFdcHpm(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuToFdcHpm=AmpWaveZFuToFdcHpm 
AmpVertexFuToFdcHpm= AmpVertexZFuToFdcHpm
End if
If (ShiftIRdiv) Then 
AmpVertexFuToFdcHpm = AmpVertexFuToFdcHpm  +  AmpVertexIRosFuToFdcHpm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fd conj[Hpm] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToFdcHpm = AmpTreeFuToFdcHpm 
 AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm + 2._dp*AmpWaveFuToFdcHpm + 2._dp*AmpVertexFuToFdcHpm  
Else 
 AmpSumFuToFdcHpm = AmpTreeFuToFdcHpm + AmpWaveFuToFdcHpm + AmpVertexFuToFdcHpm
 AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm + AmpWaveFuToFdcHpm + AmpVertexFuToFdcHpm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFdcHpm = AmpTreeFuToFdcHpm
 AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=2,2
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFdOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFd(gt2)+MHpm(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MHpm(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToFdcHpm(gt1, gt2, gt3) 
  AmpSum2FuToFdcHpm = 2._dp*AmpWaveFuToFdcHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MHpm(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToFdcHpm(gt1, gt2, gt3) 
  AmpSum2FuToFdcHpm = 2._dp*AmpVertexFuToFdcHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MHpm(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToFdcHpm(gt1, gt2, gt3) 
  AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm + 2._dp*AmpWaveFuToFdcHpm + 2._dp*AmpVertexFuToFdcHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MHpm(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToFdcHpm(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
  AmpSqTreeFuToFdcHpm(gt1, gt2, gt3) = (1)*AmpSqFuToFdcHpm(gt1, gt2, gt3)  
  AmpSum2FuToFdcHpm = + 2._dp*AmpWaveFuToFdcHpm + 2._dp*AmpVertexFuToFdcHpm
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
  AmpSqFuToFdcHpm(gt1, gt2, gt3) = AmpSqFuToFdcHpm(gt1, gt2, gt3) + AmpSqTreeFuToFdcHpm(gt1, gt2, gt3)  
Else  
  AmpSum2FuToFdcHpm = AmpTreeFuToFdcHpm
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MHpm(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
  AmpSqTreeFuToFdcHpm(gt1, gt2, gt3) = (1)*AmpSqFuToFdcHpm(gt1, gt2, gt3)  
  AmpSum2FuToFdcHpm = + 2._dp*AmpWaveFuToFdcHpm + 2._dp*AmpVertexFuToFdcHpm
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MHpm(gt3),AmpSumFuToFdcHpm(:,gt1, gt2, gt3),AmpSum2FuToFdcHpm(:,gt1, gt2, gt3),AmpSqFuToFdcHpm(gt1, gt2, gt3)) 
  AmpSqFuToFdcHpm(gt1, gt2, gt3) = AmpSqFuToFdcHpm(gt1, gt2, gt3) + AmpSqTreeFuToFdcHpm(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuToFdcHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFdcHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFdOS(gt2),MHpmOS(gt3),helfactor*AmpSqFuToFdcHpm(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFd(gt2),MHpm(gt3),helfactor*AmpSqFuToFdcHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFdcHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFdcHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToFdcHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFdcHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFdcHpm(gt1, gt2, gt3) + MRGFuToFdcHpm(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFdcHpm(gt1, gt2, gt3) + MRGFuToFdcHpm(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fd Conjg(Se)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToFdcSe(cplcFuFdcSeL,cplcFuFdcSeR,MFd,               & 
& MFu,MSe,MFd2,MFu2,MSe2,AmpTreeFuToFdcSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToFdcSe(ZcplcFuFdcSeL,ZcplcFuFdcSeR,MFd,             & 
& MFu,MSe,MFd2,MFu2,MSe2,AmpTreeFuToFdcSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcSe(MLambda,em,gs,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& MFdOS,MFuOS,MSeOS,MRPFuToFdcSe,MRGFuToFdcSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcSe(MLambda,em,gs,ZcplcFuFdcSeL,ZcplcFuFdcSeR,       & 
& MFdOS,MFuOS,MSeOS,MRPFuToFdcSe,MRGFuToFdcSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToFdcSe(MLambda,em,gs,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& MFd,MFu,MSe,MRPFuToFdcSe,MRGFuToFdcSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcSe(MLambda,em,gs,ZcplcFuFdcSeL,ZcplcFuFdcSeR,       & 
& MFd,MFu,MSe,MRPFuToFdcSe,MRGFuToFdcSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFdcSe(cplcFuFdcSeL,cplcFuFdcSeR,ctcplcFuFdcSeL,    & 
& ctcplcFuFdcSeR,MFd,MFd2,MFu,MFu2,MSe,MSe2,ZfFDL,ZfFDR,ZfFUL,ZfFUR,ZfSe,AmpWaveFuToFdcSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFdcSe(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFdcSdL,             & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,         & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecSeL,       & 
& cplFvFecSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSecSe,              & 
& cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSecSu,         & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexFuToFdcSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,             & 
& cplhhSecSe,cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRdrFuToFdcSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& ZcplcFuFdcSeL,ZcplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecSeL,cplFvFecSeR,       & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSecSe,cplHpmSvcSe,              & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSecSu,cplSeSvcSe,          & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosFuToFdcSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,ZcplcFuFdcSeL,ZcplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,   & 
& cplFvFecSeL,cplFvFecSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,             & 
& cplhhSecSe,cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosFuToFdcSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecSeL,cplFvFecSeR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSecSe,cplHpmSvcSe,              & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSecSu,cplSeSvcSe,          & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosFuToFdcSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,             & 
& cplhhSecSe,cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosFuToFdcSe)

 End if 
 End if 
AmpVertexFuToFdcSe = AmpVertexFuToFdcSe -  AmpVertexIRdrFuToFdcSe! +  AmpVertexIRosFuToFdcSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToFdcSe=0._dp 
AmpVertexZFuToFdcSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFdcSe(1,gt2,:,:) = AmpWaveZFuToFdcSe(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFdcSe(1,gt1,:,:) 
AmpVertexZFuToFdcSe(1,gt2,:,:)= AmpVertexZFuToFdcSe(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFdcSe(1,gt1,:,:) 
AmpWaveZFuToFdcSe(2,gt2,:,:) = AmpWaveZFuToFdcSe(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFdcSe(2,gt1,:,:) 
AmpVertexZFuToFdcSe(2,gt2,:,:)= AmpVertexZFuToFdcSe(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFdcSe(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuToFdcSe=AmpWaveZFuToFdcSe 
AmpVertexFuToFdcSe= AmpVertexZFuToFdcSe
! Final State 1 
AmpWaveZFuToFdcSe=0._dp 
AmpVertexZFuToFdcSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFdcSe(1,:,gt2,:) = AmpWaveZFuToFdcSe(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpWaveFuToFdcSe(1,:,gt1,:) 
AmpVertexZFuToFdcSe(1,:,gt2,:)= AmpVertexZFuToFdcSe(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpVertexFuToFdcSe(1,:,gt1,:) 
AmpWaveZFuToFdcSe(2,:,gt2,:) = AmpWaveZFuToFdcSe(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpWaveFuToFdcSe(2,:,gt1,:) 
AmpVertexZFuToFdcSe(2,:,gt2,:)= AmpVertexZFuToFdcSe(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpVertexFuToFdcSe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuToFdcSe=AmpWaveZFuToFdcSe 
AmpVertexFuToFdcSe= AmpVertexZFuToFdcSe
! Final State 2 
AmpWaveZFuToFdcSe=0._dp 
AmpVertexZFuToFdcSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZFuToFdcSe(:,:,:,gt2) = AmpWaveZFuToFdcSe(:,:,:,gt2)+ZRUZEc(gt2,gt1)*AmpWaveFuToFdcSe(:,:,:,gt1) 
AmpVertexZFuToFdcSe(:,:,:,gt2)= AmpVertexZFuToFdcSe(:,:,:,gt2)+ZRUZEc(gt2,gt1)*AmpVertexFuToFdcSe(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuToFdcSe=AmpWaveZFuToFdcSe 
AmpVertexFuToFdcSe= AmpVertexZFuToFdcSe
End if
If (ShiftIRdiv) Then 
AmpVertexFuToFdcSe = AmpVertexFuToFdcSe  +  AmpVertexIRosFuToFdcSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fd conj[Se] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToFdcSe = AmpTreeFuToFdcSe 
 AmpSum2FuToFdcSe = AmpTreeFuToFdcSe + 2._dp*AmpWaveFuToFdcSe + 2._dp*AmpVertexFuToFdcSe  
Else 
 AmpSumFuToFdcSe = AmpTreeFuToFdcSe + AmpWaveFuToFdcSe + AmpVertexFuToFdcSe
 AmpSum2FuToFdcSe = AmpTreeFuToFdcSe + AmpWaveFuToFdcSe + AmpVertexFuToFdcSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFdcSe = AmpTreeFuToFdcSe
 AmpSum2FuToFdcSe = AmpTreeFuToFdcSe 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFdOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFd(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuToFdcSe = AmpTreeFuToFdcSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MSe(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToFdcSe(gt1, gt2, gt3) 
  AmpSum2FuToFdcSe = 2._dp*AmpWaveFuToFdcSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MSe(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToFdcSe(gt1, gt2, gt3) 
  AmpSum2FuToFdcSe = 2._dp*AmpVertexFuToFdcSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MSe(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToFdcSe(gt1, gt2, gt3) 
  AmpSum2FuToFdcSe = AmpTreeFuToFdcSe + 2._dp*AmpWaveFuToFdcSe + 2._dp*AmpVertexFuToFdcSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MSe(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToFdcSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToFdcSe = AmpTreeFuToFdcSe
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
  AmpSqTreeFuToFdcSe(gt1, gt2, gt3) = (1)*AmpSqFuToFdcSe(gt1, gt2, gt3)  
  AmpSum2FuToFdcSe = + 2._dp*AmpWaveFuToFdcSe + 2._dp*AmpVertexFuToFdcSe
  Call SquareAmp_FtoFS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
  AmpSqFuToFdcSe(gt1, gt2, gt3) = AmpSqFuToFdcSe(gt1, gt2, gt3) + AmpSqTreeFuToFdcSe(gt1, gt2, gt3)  
Else  
  AmpSum2FuToFdcSe = AmpTreeFuToFdcSe
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MSe(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
  AmpSqTreeFuToFdcSe(gt1, gt2, gt3) = (1)*AmpSqFuToFdcSe(gt1, gt2, gt3)  
  AmpSum2FuToFdcSe = + 2._dp*AmpWaveFuToFdcSe + 2._dp*AmpVertexFuToFdcSe
  Call SquareAmp_FtoFS(MFu(gt1),MFd(gt2),MSe(gt3),AmpSumFuToFdcSe(:,gt1, gt2, gt3),AmpSum2FuToFdcSe(:,gt1, gt2, gt3),AmpSqFuToFdcSe(gt1, gt2, gt3)) 
  AmpSqFuToFdcSe(gt1, gt2, gt3) = AmpSqFuToFdcSe(gt1, gt2, gt3) + AmpSqTreeFuToFdcSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuToFdcSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFdcSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFdOS(gt2),MSeOS(gt3),helfactor*AmpSqFuToFdcSe(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFd(gt2),MSe(gt3),helfactor*AmpSqFuToFdcSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFdcSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFdcSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToFdcSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFdcSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFdcSe(gt1, gt2, gt3) + MRGFuToFdcSe(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFdcSe(gt1, gt2, gt3) + MRGFuToFdcSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fd Conjg(VWm)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToFdcVWm(cplcFuFdcVWmL,cplcFuFdcVWmR,MFd,            & 
& MFu,MVWm,MFd2,MFu2,MVWm2,AmpTreeFuToFdcVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToFdcVWm(ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,              & 
& MFd,MFu,MVWm,MFd2,MFu2,MVWm2,AmpTreeFuToFdcVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcVWm(MLambda,em,gs,cplcFuFdcVWmL,cplcFuFdcVWmR,      & 
& MFdOS,MFuOS,MVWmOS,MRPFuToFdcVWm,MRGFuToFdcVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcVWm(MLambda,em,gs,ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,    & 
& MFdOS,MFuOS,MVWmOS,MRPFuToFdcVWm,MRGFuToFdcVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToFdcVWm(MLambda,em,gs,cplcFuFdcVWmL,cplcFuFdcVWmR,      & 
& MFd,MFu,MVWm,MRPFuToFdcVWm,MRGFuToFdcVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFdcVWm(MLambda,em,gs,ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,    & 
& MFd,MFu,MVWm,MRPFuToFdcVWm,MRGFuToFdcVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFdcVWm(cplcFuFdcVWmL,cplcFuFdcVWmR,ctcplcFuFdcVWmL,& 
& ctcplcFuFdcVWmR,MFd,MFd2,MFu,MFu2,MVWm,MVWm2,ZfFDL,ZfFDR,ZfFUL,ZfFUR,ZfVWm,            & 
& AmpWaveFuToFdcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplChiFdcSdL,       & 
& cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,     & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,              & 
& cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplcChacFuSdL,        & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,        & 
& cplcVWmVWmVZ,AmpVertexFuToFdcVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,        & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,cplcFuFuhhR,         & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,cplSecSvcVWm,       & 
& cplcVWmVPVWm,cplcVWmVWmVZ,AmpVertexIRdrFuToFdcVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplChiFdcSdL,cplChiFdcSdR,      & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,               & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& GosZcplcFuFdcHpmL,GosZcplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,ZcplcFuFdcVWmL,          & 
& ZcplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,          & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,              & 
& cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,GosZcplHpmcVWmVP,cplHpmcVWmVZ,cplcChacFuSdL,    & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,        & 
& cplcVWmVWmVZ,AmpVertexIRosFuToFdcVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,        & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,GZcplcFuFdcHpmL,GZcplcFuFdcHpmR,cplcFuFdcSeL,              & 
& cplcFuFdcSeR,ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,      & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,GZcplHpmcVWmVP,        & 
& cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,       & 
& cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,AmpVertexIRosFuToFdcVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplChiFdcSdL,cplChiFdcSdR,      & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,               & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& GcplcFuFdcHpmL,GcplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,   & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,             & 
& cplhhHpmcVWm,cplhhcVWmVWm,GcplHpmcVWmVP,cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,      & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,         & 
& AmpVertexIRosFuToFdcVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,        & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,cplcFuFuhhR,         & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,cplSecSvcVWm,       & 
& cplcVWmVPVWm,cplcVWmVWmVZ,AmpVertexIRosFuToFdcVWm)

 End if 
 End if 
AmpVertexFuToFdcVWm = AmpVertexFuToFdcVWm -  AmpVertexIRdrFuToFdcVWm! +  AmpVertexIRosFuToFdcVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToFdcVWm=0._dp 
AmpVertexZFuToFdcVWm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFdcVWm(1,gt2,:) = AmpWaveZFuToFdcVWm(1,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFdcVWm(1,gt1,:) 
AmpVertexZFuToFdcVWm(1,gt2,:)= AmpVertexZFuToFdcVWm(1,gt2,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFdcVWm(1,gt1,:) 
AmpWaveZFuToFdcVWm(2,gt2,:) = AmpWaveZFuToFdcVWm(2,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFdcVWm(2,gt1,:) 
AmpVertexZFuToFdcVWm(2,gt2,:)= AmpVertexZFuToFdcVWm(2,gt2,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFdcVWm(2,gt1,:) 
AmpWaveZFuToFdcVWm(3,gt2,:) = AmpWaveZFuToFdcVWm(3,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFdcVWm(3,gt1,:) 
AmpVertexZFuToFdcVWm(3,gt2,:)= AmpVertexZFuToFdcVWm(3,gt2,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFdcVWm(3,gt1,:) 
AmpWaveZFuToFdcVWm(4,gt2,:) = AmpWaveZFuToFdcVWm(4,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFdcVWm(4,gt1,:) 
AmpVertexZFuToFdcVWm(4,gt2,:)= AmpVertexZFuToFdcVWm(4,gt2,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFdcVWm(4,gt1,:) 
 End Do 
End Do 
AmpWaveFuToFdcVWm=AmpWaveZFuToFdcVWm 
AmpVertexFuToFdcVWm= AmpVertexZFuToFdcVWm
! Final State 1 
AmpWaveZFuToFdcVWm=0._dp 
AmpVertexZFuToFdcVWm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFdcVWm(1,:,gt2) = AmpWaveZFuToFdcVWm(1,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveFuToFdcVWm(1,:,gt1) 
AmpVertexZFuToFdcVWm(1,:,gt2)= AmpVertexZFuToFdcVWm(1,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexFuToFdcVWm(1,:,gt1) 
AmpWaveZFuToFdcVWm(2,:,gt2) = AmpWaveZFuToFdcVWm(2,:,gt2)+ZRUZDRc(gt2,gt1)*AmpWaveFuToFdcVWm(2,:,gt1) 
AmpVertexZFuToFdcVWm(2,:,gt2)= AmpVertexZFuToFdcVWm(2,:,gt2)+ZRUZDRc(gt2,gt1)*AmpVertexFuToFdcVWm(2,:,gt1) 
AmpWaveZFuToFdcVWm(3,:,gt2) = AmpWaveZFuToFdcVWm(3,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveFuToFdcVWm(3,:,gt1) 
AmpVertexZFuToFdcVWm(3,:,gt2)= AmpVertexZFuToFdcVWm(3,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexFuToFdcVWm(3,:,gt1) 
AmpWaveZFuToFdcVWm(4,:,gt2) = AmpWaveZFuToFdcVWm(4,:,gt2)+ZRUZDRc(gt2,gt1)*AmpWaveFuToFdcVWm(4,:,gt1) 
AmpVertexZFuToFdcVWm(4,:,gt2)= AmpVertexZFuToFdcVWm(4,:,gt2)+ZRUZDRc(gt2,gt1)*AmpVertexFuToFdcVWm(4,:,gt1) 
 End Do 
End Do 
AmpWaveFuToFdcVWm=AmpWaveZFuToFdcVWm 
AmpVertexFuToFdcVWm= AmpVertexZFuToFdcVWm
End if
If (ShiftIRdiv) Then 
AmpVertexFuToFdcVWm = AmpVertexFuToFdcVWm  +  AmpVertexIRosFuToFdcVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fd conj[VWm] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToFdcVWm = AmpTreeFuToFdcVWm 
 AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm + 2._dp*AmpWaveFuToFdcVWm + 2._dp*AmpVertexFuToFdcVWm  
Else 
 AmpSumFuToFdcVWm = AmpTreeFuToFdcVWm + AmpWaveFuToFdcVWm + AmpVertexFuToFdcVWm
 AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm + AmpWaveFuToFdcVWm + AmpVertexFuToFdcVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFdcVWm = AmpTreeFuToFdcVWm
 AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFdOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFd(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFdOS(gt2),MVWmOS,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFd(gt2),MVWm,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToFdcVWm(gt1, gt2) 
  AmpSum2FuToFdcVWm = 2._dp*AmpWaveFuToFdcVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFdOS(gt2),MVWmOS,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFd(gt2),MVWm,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToFdcVWm(gt1, gt2) 
  AmpSum2FuToFdcVWm = 2._dp*AmpVertexFuToFdcVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFdOS(gt2),MVWmOS,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFd(gt2),MVWm,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToFdcVWm(gt1, gt2) 
  AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm + 2._dp*AmpWaveFuToFdcVWm + 2._dp*AmpVertexFuToFdcVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFdOS(gt2),MVWmOS,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFd(gt2),MVWm,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToFdcVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm
  Call SquareAmp_FtoFV(MFuOS(gt1),MFdOS(gt2),MVWmOS,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
  AmpSqTreeFuToFdcVWm(gt1, gt2) = (1)*AmpSqFuToFdcVWm(gt1, gt2)  
  AmpSum2FuToFdcVWm = + 2._dp*AmpWaveFuToFdcVWm + 2._dp*AmpVertexFuToFdcVWm
  Call SquareAmp_FtoFV(MFuOS(gt1),MFdOS(gt2),MVWmOS,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
  AmpSqFuToFdcVWm(gt1, gt2) = AmpSqFuToFdcVWm(gt1, gt2) + AmpSqTreeFuToFdcVWm(gt1, gt2)  
Else  
  AmpSum2FuToFdcVWm = AmpTreeFuToFdcVWm
  Call SquareAmp_FtoFV(MFu(gt1),MFd(gt2),MVWm,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
  AmpSqTreeFuToFdcVWm(gt1, gt2) = (1)*AmpSqFuToFdcVWm(gt1, gt2)  
  AmpSum2FuToFdcVWm = + 2._dp*AmpWaveFuToFdcVWm + 2._dp*AmpVertexFuToFdcVWm
  Call SquareAmp_FtoFV(MFu(gt1),MFd(gt2),MVWm,AmpSumFuToFdcVWm(:,gt1, gt2),AmpSum2FuToFdcVWm(:,gt1, gt2),AmpSqFuToFdcVWm(gt1, gt2)) 
  AmpSqFuToFdcVWm(gt1, gt2) = AmpSqFuToFdcVWm(gt1, gt2) + AmpSqTreeFuToFdcVWm(gt1, gt2)  
End if  
Else  
  AmpSqFuToFdcVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFdcVWm(gt1, gt2).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFdOS(gt2),MVWmOS,helfactor*AmpSqFuToFdcVWm(gt1, gt2))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFd(gt2),MVWm,helfactor*AmpSqFuToFdcVWm(gt1, gt2))
End if 
If ((Abs(MRPFuToFdcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGFuToFdcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToFdcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGFuToFdcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFdcVWm(gt1, gt2) + MRGFuToFdcVWm(gt1, gt2)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFdcVWm(gt1, gt2) + MRGFuToFdcVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fu hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToFuhh(cplcFuFuhhL,cplcFuFuhhR,MFu,Mhh,              & 
& MFu2,Mhh2,AmpTreeFuToFuhh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToFuhh(ZcplcFuFuhhL,ZcplcFuFuhhR,MFu,Mhh,            & 
& MFu2,Mhh2,AmpTreeFuToFuhh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuhh(MLambda,em,gs,cplcFuFuhhL,cplcFuFuhhR,            & 
& MFuOS,MhhOS,MRPFuToFuhh,MRGFuToFuhh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuhh(MLambda,em,gs,ZcplcFuFuhhL,ZcplcFuFuhhR,          & 
& MFuOS,MhhOS,MRPFuToFuhh,MRGFuToFuhh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToFuhh(MLambda,em,gs,cplcFuFuhhL,cplcFuFuhhR,            & 
& MFu,Mhh,MRPFuToFuhh,MRGFuToFuhh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuhh(MLambda,em,gs,ZcplcFuFuhhL,ZcplcFuFuhhR,          & 
& MFu,Mhh,MRPFuToFuhh,MRGFuToFuhh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuhh(cplcFuFuhhL,cplcFuFuhhR,ctcplcFuFuhhL,        & 
& ctcplcFuFuhhR,MFu,MFu2,Mhh,Mhh2,ZfFUL,ZfFUR,Zfhh,AmpWaveFuToFuhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuhh(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFuFuAhL,cplcFuFuAhR,      & 
& cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdhhL,          & 
& cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplGluFucSuL,            & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,              & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,               & 
& cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& AmpVertexFuToFuhh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& AmpVertexIRdrFuToFuhh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,           & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplGluFucSuL,cplGluFucSuR,             & 
& ZcplcFuFuhhL,ZcplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,           & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosFuToFuhh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,           & 
& cplGluFucSuL,cplGluFucSuR,ZcplcFuFuhhL,ZcplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& AmpVertexIRosFuToFuhh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,           & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosFuToFuhh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& AmpVertexIRosFuToFuhh)

 End if 
 End if 
AmpVertexFuToFuhh = AmpVertexFuToFuhh -  AmpVertexIRdrFuToFuhh! +  AmpVertexIRosFuToFuhh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToFuhh=0._dp 
AmpVertexZFuToFuhh=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFuhh(1,gt2,:,:) = AmpWaveZFuToFuhh(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFuhh(1,gt1,:,:) 
AmpVertexZFuToFuhh(1,gt2,:,:)= AmpVertexZFuToFuhh(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFuhh(1,gt1,:,:) 
AmpWaveZFuToFuhh(2,gt2,:,:) = AmpWaveZFuToFuhh(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFuhh(2,gt1,:,:) 
AmpVertexZFuToFuhh(2,gt2,:,:)= AmpVertexZFuToFuhh(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFuhh(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuToFuhh=AmpWaveZFuToFuhh 
AmpVertexFuToFuhh= AmpVertexZFuToFuhh
! Final State 1 
AmpWaveZFuToFuhh=0._dp 
AmpVertexZFuToFuhh=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFuhh(1,:,gt2,:) = AmpWaveZFuToFuhh(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpWaveFuToFuhh(1,:,gt1,:) 
AmpVertexZFuToFuhh(1,:,gt2,:)= AmpVertexZFuToFuhh(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpVertexFuToFuhh(1,:,gt1,:) 
AmpWaveZFuToFuhh(2,:,gt2,:) = AmpWaveZFuToFuhh(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpWaveFuToFuhh(2,:,gt1,:) 
AmpVertexZFuToFuhh(2,:,gt2,:)= AmpVertexZFuToFuhh(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpVertexFuToFuhh(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuToFuhh=AmpWaveZFuToFuhh 
AmpVertexFuToFuhh= AmpVertexZFuToFuhh
! Final State 2 
AmpWaveZFuToFuhh=0._dp 
AmpVertexZFuToFuhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZFuToFuhh(:,:,:,gt2) = AmpWaveZFuToFuhh(:,:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveFuToFuhh(:,:,:,gt1) 
AmpVertexZFuToFuhh(:,:,:,gt2)= AmpVertexZFuToFuhh(:,:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexFuToFuhh(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuToFuhh=AmpWaveZFuToFuhh 
AmpVertexFuToFuhh= AmpVertexZFuToFuhh
End if
If (ShiftIRdiv) Then 
AmpVertexFuToFuhh = AmpVertexFuToFuhh  +  AmpVertexIRosFuToFuhh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToFuhh = AmpTreeFuToFuhh 
 AmpSum2FuToFuhh = AmpTreeFuToFuhh + 2._dp*AmpWaveFuToFuhh + 2._dp*AmpVertexFuToFuhh  
Else 
 AmpSumFuToFuhh = AmpTreeFuToFuhh + AmpWaveFuToFuhh + AmpVertexFuToFuhh
 AmpSum2FuToFuhh = AmpTreeFuToFuhh + AmpWaveFuToFuhh + AmpVertexFuToFuhh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFuhh = AmpTreeFuToFuhh
 AmpSum2FuToFuhh = AmpTreeFuToFuhh 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,2
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuToFuhh = AmpTreeFuToFuhh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),Mhh(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToFuhh(gt1, gt2, gt3) 
  AmpSum2FuToFuhh = 2._dp*AmpWaveFuToFuhh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),Mhh(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToFuhh(gt1, gt2, gt3) 
  AmpSum2FuToFuhh = 2._dp*AmpVertexFuToFuhh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),Mhh(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToFuhh(gt1, gt2, gt3) 
  AmpSum2FuToFuhh = AmpTreeFuToFuhh + 2._dp*AmpWaveFuToFuhh + 2._dp*AmpVertexFuToFuhh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),Mhh(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToFuhh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToFuhh = AmpTreeFuToFuhh
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
  AmpSqTreeFuToFuhh(gt1, gt2, gt3) = (1)*AmpSqFuToFuhh(gt1, gt2, gt3)  
  AmpSum2FuToFuhh = + 2._dp*AmpWaveFuToFuhh + 2._dp*AmpVertexFuToFuhh
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
  AmpSqFuToFuhh(gt1, gt2, gt3) = AmpSqFuToFuhh(gt1, gt2, gt3) + AmpSqTreeFuToFuhh(gt1, gt2, gt3)  
Else  
  AmpSum2FuToFuhh = AmpTreeFuToFuhh
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),Mhh(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
  AmpSqTreeFuToFuhh(gt1, gt2, gt3) = (1)*AmpSqFuToFuhh(gt1, gt2, gt3)  
  AmpSum2FuToFuhh = + 2._dp*AmpWaveFuToFuhh + 2._dp*AmpVertexFuToFuhh
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),Mhh(gt3),AmpSumFuToFuhh(:,gt1, gt2, gt3),AmpSum2FuToFuhh(:,gt1, gt2, gt3),AmpSqFuToFuhh(gt1, gt2, gt3)) 
  AmpSqFuToFuhh(gt1, gt2, gt3) = AmpSqFuToFuhh(gt1, gt2, gt3) + AmpSqTreeFuToFuhh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuToFuhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFuhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),MhhOS(gt3),helfactor*AmpSqFuToFuhh(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),Mhh(gt3),helfactor*AmpSqFuToFuhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFuhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToFuhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFuhh(gt1, gt2, gt3) + MRGFuToFuhh(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFuhh(gt1, gt2, gt3) + MRGFuToFuhh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fu VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToFuVZ(cplcFuFuVZL,cplcFuFuVZR,MFu,MVZ,              & 
& MFu2,MVZ2,AmpTreeFuToFuVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToFuVZ(ZcplcFuFuVZL,ZcplcFuFuVZR,MFu,MVZ,            & 
& MFu2,MVZ2,AmpTreeFuToFuVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuVZ(MLambda,em,gs,cplcFuFuVZL,cplcFuFuVZR,            & 
& MFuOS,MVZOS,MRPFuToFuVZ,MRGFuToFuVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuVZ(MLambda,em,gs,ZcplcFuFuVZL,ZcplcFuFuVZR,          & 
& MFuOS,MVZOS,MRPFuToFuVZ,MRGFuToFuVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToFuVZ(MLambda,em,gs,cplcFuFuVZL,cplcFuFuVZR,            & 
& MFu,MVZ,MRPFuToFuVZ,MRGFuToFuVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToFuVZ(MLambda,em,gs,ZcplcFuFuVZL,ZcplcFuFuVZR,          & 
& MFu,MVZ,MRPFuToFuVZ,MRGFuToFuVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVZ(cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,          & 
& cplcFuFuVZR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,MFu,               & 
& MFu2,MVP,MVP2,MVZ,MVZ2,ZfFUL,ZfFUR,ZfVPVZ,ZfVZ,AmpWaveFuToFuVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVZ(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,      & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,cplHpmcHpmVZ,              & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,         & 
& cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexFuToFuVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,          & 
& cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,          & 
& cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,            & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,              & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRdrFuToFuVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,        & 
& cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFucSuL,       & 
& cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,ZcplcFuFuVZL,            & 
& ZcplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,            & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSecSeVZ,           & 
& cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosFuToFuVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,          & 
& cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,          & 
& cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,            & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,ZcplcFuFuVZL,ZcplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,            & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosFuToFuVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,        & 
& cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFucSuL,       & 
& cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,             & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSecSeVZ,           & 
& cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosFuToFuVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,          & 
& cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,          & 
& cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,            & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,              & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosFuToFuVZ)

 End if 
 End if 
AmpVertexFuToFuVZ = AmpVertexFuToFuVZ -  AmpVertexIRdrFuToFuVZ! +  AmpVertexIRosFuToFuVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToFuVZ=0._dp 
AmpVertexZFuToFuVZ=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFuVZ(1,gt2,:) = AmpWaveZFuToFuVZ(1,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFuVZ(1,gt1,:) 
AmpVertexZFuToFuVZ(1,gt2,:)= AmpVertexZFuToFuVZ(1,gt2,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFuVZ(1,gt1,:) 
AmpWaveZFuToFuVZ(2,gt2,:) = AmpWaveZFuToFuVZ(2,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFuVZ(2,gt1,:) 
AmpVertexZFuToFuVZ(2,gt2,:)= AmpVertexZFuToFuVZ(2,gt2,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFuVZ(2,gt1,:) 
AmpWaveZFuToFuVZ(3,gt2,:) = AmpWaveZFuToFuVZ(3,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToFuVZ(3,gt1,:) 
AmpVertexZFuToFuVZ(3,gt2,:)= AmpVertexZFuToFuVZ(3,gt2,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToFuVZ(3,gt1,:) 
AmpWaveZFuToFuVZ(4,gt2,:) = AmpWaveZFuToFuVZ(4,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToFuVZ(4,gt1,:) 
AmpVertexZFuToFuVZ(4,gt2,:)= AmpVertexZFuToFuVZ(4,gt2,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToFuVZ(4,gt1,:) 
 End Do 
End Do 
AmpWaveFuToFuVZ=AmpWaveZFuToFuVZ 
AmpVertexFuToFuVZ= AmpVertexZFuToFuVZ
! Final State 1 
AmpWaveZFuToFuVZ=0._dp 
AmpVertexZFuToFuVZ=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToFuVZ(1,:,gt2) = AmpWaveZFuToFuVZ(1,:,gt2)+ZRUZUL(gt2,gt1)*AmpWaveFuToFuVZ(1,:,gt1) 
AmpVertexZFuToFuVZ(1,:,gt2)= AmpVertexZFuToFuVZ(1,:,gt2)+ZRUZUL(gt2,gt1)*AmpVertexFuToFuVZ(1,:,gt1) 
AmpWaveZFuToFuVZ(2,:,gt2) = AmpWaveZFuToFuVZ(2,:,gt2)+ZRUZURc(gt2,gt1)*AmpWaveFuToFuVZ(2,:,gt1) 
AmpVertexZFuToFuVZ(2,:,gt2)= AmpVertexZFuToFuVZ(2,:,gt2)+ZRUZURc(gt2,gt1)*AmpVertexFuToFuVZ(2,:,gt1) 
AmpWaveZFuToFuVZ(3,:,gt2) = AmpWaveZFuToFuVZ(3,:,gt2)+ZRUZUL(gt2,gt1)*AmpWaveFuToFuVZ(3,:,gt1) 
AmpVertexZFuToFuVZ(3,:,gt2)= AmpVertexZFuToFuVZ(3,:,gt2)+ZRUZUL(gt2,gt1)*AmpVertexFuToFuVZ(3,:,gt1) 
AmpWaveZFuToFuVZ(4,:,gt2) = AmpWaveZFuToFuVZ(4,:,gt2)+ZRUZURc(gt2,gt1)*AmpWaveFuToFuVZ(4,:,gt1) 
AmpVertexZFuToFuVZ(4,:,gt2)= AmpVertexZFuToFuVZ(4,:,gt2)+ZRUZURc(gt2,gt1)*AmpVertexFuToFuVZ(4,:,gt1) 
 End Do 
End Do 
AmpWaveFuToFuVZ=AmpWaveZFuToFuVZ 
AmpVertexFuToFuVZ= AmpVertexZFuToFuVZ
End if
If (ShiftIRdiv) Then 
AmpVertexFuToFuVZ = AmpVertexFuToFuVZ  +  AmpVertexIRosFuToFuVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToFuVZ = AmpTreeFuToFuVZ 
 AmpSum2FuToFuVZ = AmpTreeFuToFuVZ + 2._dp*AmpWaveFuToFuVZ + 2._dp*AmpVertexFuToFuVZ  
Else 
 AmpSumFuToFuVZ = AmpTreeFuToFuVZ + AmpWaveFuToFuVZ + AmpVertexFuToFuVZ
 AmpSum2FuToFuVZ = AmpTreeFuToFuVZ + AmpWaveFuToFuVZ + AmpVertexFuToFuVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFuVZ = AmpTreeFuToFuVZ
 AmpSum2FuToFuVZ = AmpTreeFuToFuVZ 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2FuToFuVZ = AmpTreeFuToFuVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),MVZOS,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVZ,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToFuVZ(gt1, gt2) 
  AmpSum2FuToFuVZ = 2._dp*AmpWaveFuToFuVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),MVZOS,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVZ,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToFuVZ(gt1, gt2) 
  AmpSum2FuToFuVZ = 2._dp*AmpVertexFuToFuVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),MVZOS,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVZ,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToFuVZ(gt1, gt2) 
  AmpSum2FuToFuVZ = AmpTreeFuToFuVZ + 2._dp*AmpWaveFuToFuVZ + 2._dp*AmpVertexFuToFuVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),MVZOS,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVZ,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToFuVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToFuVZ = AmpTreeFuToFuVZ
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),MVZOS,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
  AmpSqTreeFuToFuVZ(gt1, gt2) = (1)*AmpSqFuToFuVZ(gt1, gt2)  
  AmpSum2FuToFuVZ = + 2._dp*AmpWaveFuToFuVZ + 2._dp*AmpVertexFuToFuVZ
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),MVZOS,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
  AmpSqFuToFuVZ(gt1, gt2) = AmpSqFuToFuVZ(gt1, gt2) + AmpSqTreeFuToFuVZ(gt1, gt2)  
Else  
  AmpSum2FuToFuVZ = AmpTreeFuToFuVZ
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVZ,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
  AmpSqTreeFuToFuVZ(gt1, gt2) = (1)*AmpSqFuToFuVZ(gt1, gt2)  
  AmpSum2FuToFuVZ = + 2._dp*AmpWaveFuToFuVZ + 2._dp*AmpVertexFuToFuVZ
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVZ,AmpSumFuToFuVZ(:,gt1, gt2),AmpSum2FuToFuVZ(:,gt1, gt2),AmpSqFuToFuVZ(gt1, gt2)) 
  AmpSqFuToFuVZ(gt1, gt2) = AmpSqFuToFuVZ(gt1, gt2) + AmpSqTreeFuToFuVZ(gt1, gt2)  
End if  
Else  
  AmpSqFuToFuVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFuVZ(gt1, gt2).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),MVZOS,helfactor*AmpSqFuToFuVZ(gt1, gt2))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),MVZ,helfactor*AmpSqFuToFuVZ(gt1, gt2))
End if 
If ((Abs(MRPFuToFuVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToFuVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFuVZ(gt1, gt2) + MRGFuToFuVZ(gt1, gt2)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToFuVZ(gt1, gt2) + MRGFuToFuVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Glu Su
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuToGluSu(cplcFuGluSuL,cplcFuGluSuR,MFu,               & 
& MGlu,MSu,MFu2,MGlu2,MSu2,AmpTreeFuToGluSu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuToGluSu(ZcplcFuGluSuL,ZcplcFuGluSuR,MFu,             & 
& MGlu,MSu,MFu2,MGlu2,MSu2,AmpTreeFuToGluSu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToGluSu(MLambda,em,gs,cplcFuGluSuL,cplcFuGluSuR,         & 
& MFuOS,MGluOS,MSuOS,MRPFuToGluSu,MRGFuToGluSu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToGluSu(MLambda,em,gs,ZcplcFuGluSuL,ZcplcFuGluSuR,       & 
& MFuOS,MGluOS,MSuOS,MRPFuToGluSu,MRGFuToGluSu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuToGluSu(MLambda,em,gs,cplcFuGluSuL,cplcFuGluSuR,         & 
& MFu,MGlu,MSu,MRPFuToGluSu,MRGFuToGluSu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuToGluSu(MLambda,em,gs,ZcplcFuGluSuL,ZcplcFuGluSuR,       & 
& MFu,MGlu,MSu,MRPFuToGluSu,MRGFuToGluSu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToGluSu(cplcFuGluSuL,cplcFuGluSuR,ctcplcFuGluSuL,    & 
& ctcplcFuGluSuR,MFu,MFu2,MGlu,MGlu2,MSu,MSu2,ZffG,ZfFUL,ZfFUR,ZfSu,AmpWaveFuToGluSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToGluSu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,     & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,cplGluFdcSdR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexFuToGluSu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,          & 
& cplcFecFuSdR,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRdrFuToGluSu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,cplGluFdcSdR,cplcFuFdcHpmL,        & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,              & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,ZcplcFuGluSuL,ZcplcFuGluSuR,cplhhSucSu,         & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToGluSu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,ZcplcFuGluSuL,         & 
& ZcplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToGluSu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,cplGluFdcSdR,cplcFuFdcHpmL,        & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,              & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToGluSu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,          & 
& cplcFecFuSdR,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,AmpVertexIRosFuToGluSu)

 End if 
 End if 
AmpVertexFuToGluSu = AmpVertexFuToGluSu -  AmpVertexIRdrFuToGluSu! +  AmpVertexIRosFuToGluSu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuToGluSu=0._dp 
AmpVertexZFuToGluSu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuToGluSu(1,gt2,:) = AmpWaveZFuToGluSu(1,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveFuToGluSu(1,gt1,:) 
AmpVertexZFuToGluSu(1,gt2,:)= AmpVertexZFuToGluSu(1,gt2,:) + ZRUZUR(gt2,gt1)*AmpVertexFuToGluSu(1,gt1,:) 
AmpWaveZFuToGluSu(2,gt2,:) = AmpWaveZFuToGluSu(2,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveFuToGluSu(2,gt1,:) 
AmpVertexZFuToGluSu(2,gt2,:)= AmpVertexZFuToGluSu(2,gt2,:) + ZRUZULc(gt2,gt1)*AmpVertexFuToGluSu(2,gt1,:) 
 End Do 
End Do 
AmpWaveFuToGluSu=AmpWaveZFuToGluSu 
AmpVertexFuToGluSu= AmpVertexZFuToGluSu
! Final State 2 
AmpWaveZFuToGluSu=0._dp 
AmpVertexZFuToGluSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZFuToGluSu(:,:,gt2) = AmpWaveZFuToGluSu(:,:,gt2)+ZRUZU(gt2,gt1)*AmpWaveFuToGluSu(:,:,gt1) 
AmpVertexZFuToGluSu(:,:,gt2)= AmpVertexZFuToGluSu(:,:,gt2)+ZRUZU(gt2,gt1)*AmpVertexFuToGluSu(:,:,gt1) 
 End Do 
End Do 
AmpWaveFuToGluSu=AmpWaveZFuToGluSu 
AmpVertexFuToGluSu= AmpVertexZFuToGluSu
End if
If (ShiftIRdiv) Then 
AmpVertexFuToGluSu = AmpVertexFuToGluSu  +  AmpVertexIRosFuToGluSu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Glu Su -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuToGluSu = AmpTreeFuToGluSu 
 AmpSum2FuToGluSu = AmpTreeFuToGluSu + 2._dp*AmpWaveFuToGluSu + 2._dp*AmpVertexFuToGluSu  
Else 
 AmpSumFuToGluSu = AmpTreeFuToGluSu + AmpWaveFuToGluSu + AmpVertexFuToGluSu
 AmpSum2FuToGluSu = AmpTreeFuToGluSu + AmpWaveFuToGluSu + AmpVertexFuToGluSu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToGluSu = AmpTreeFuToGluSu
 AmpSum2FuToGluSu = AmpTreeFuToGluSu 
End if 
Do gt1=1,3
i4 = isave 
    Do gt3=1,6
If (((OSkinematics).and.(MFuOS(gt1).gt.(MGluOS+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MGlu+MSu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt3 
  AmpSum2FuToGluSu = AmpTreeFuToGluSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MGluOS,MSuOS(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MGlu,MSu(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuToGluSu(gt1, gt3) 
  AmpSum2FuToGluSu = 2._dp*AmpWaveFuToGluSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MGluOS,MSuOS(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MGlu,MSu(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuToGluSu(gt1, gt3) 
  AmpSum2FuToGluSu = 2._dp*AmpVertexFuToGluSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MGluOS,MSuOS(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MGlu,MSu(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuToGluSu(gt1, gt3) 
  AmpSum2FuToGluSu = AmpTreeFuToGluSu + 2._dp*AmpWaveFuToGluSu + 2._dp*AmpVertexFuToGluSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MGluOS,MSuOS(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MGlu,MSu(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuToGluSu(gt1, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuToGluSu = AmpTreeFuToGluSu
  Call SquareAmp_FtoFS(MFuOS(gt1),MGluOS,MSuOS(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
  AmpSqTreeFuToGluSu(gt1, gt3) = (4._dp/3._dp)*AmpSqFuToGluSu(gt1, gt3)  
  AmpSum2FuToGluSu = + 2._dp*AmpWaveFuToGluSu + 2._dp*AmpVertexFuToGluSu
  Call SquareAmp_FtoFS(MFuOS(gt1),MGluOS,MSuOS(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
  AmpSqFuToGluSu(gt1, gt3) = AmpSqFuToGluSu(gt1, gt3) + AmpSqTreeFuToGluSu(gt1, gt3)  
Else  
  AmpSum2FuToGluSu = AmpTreeFuToGluSu
  Call SquareAmp_FtoFS(MFu(gt1),MGlu,MSu(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
  AmpSqTreeFuToGluSu(gt1, gt3) = (4._dp/3._dp)*AmpSqFuToGluSu(gt1, gt3)  
  AmpSum2FuToGluSu = + 2._dp*AmpWaveFuToGluSu + 2._dp*AmpVertexFuToGluSu
  Call SquareAmp_FtoFS(MFu(gt1),MGlu,MSu(gt3),AmpSumFuToGluSu(:,gt1, gt3),AmpSum2FuToGluSu(:,gt1, gt3),AmpSqFuToGluSu(gt1, gt3)) 
  AmpSqFuToGluSu(gt1, gt3) = AmpSqFuToGluSu(gt1, gt3) + AmpSqTreeFuToGluSu(gt1, gt3)  
End if  
Else  
  AmpSqFuToGluSu(gt1, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToGluSu(gt1, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MGluOS,MSuOS(gt3),helfactor*AmpSqFuToGluSu(gt1, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MGlu,MSu(gt3),helfactor*AmpSqFuToGluSu(gt1, gt3))
End if 
If ((Abs(MRPFuToGluSu(gt1, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToGluSu(gt1, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuToGluSu(gt1, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToGluSu(gt1, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToGluSu(gt1, gt3) + MRGFuToGluSu(gt1, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuToGluSu(gt1, gt3) + MRGFuToGluSu(gt1, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! bar(Cha) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuTocChaSd(cplcChacFuSdL,cplcChacFuSdR,MCha,           & 
& MFu,MSd,MCha2,MFu2,MSd2,AmpTreeFuTocChaSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuTocChaSd(ZcplcChacFuSdL,ZcplcChacFuSdR,              & 
& MCha,MFu,MSd,MCha2,MFu2,MSd2,AmpTreeFuTocChaSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuTocChaSd(MLambda,em,gs,cplcChacFuSdL,cplcChacFuSdR,      & 
& MChaOS,MFuOS,MSdOS,MRPFuTocChaSd,MRGFuTocChaSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuTocChaSd(MLambda,em,gs,ZcplcChacFuSdL,ZcplcChacFuSdR,    & 
& MChaOS,MFuOS,MSdOS,MRPFuTocChaSd,MRGFuTocChaSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuTocChaSd(MLambda,em,gs,cplcChacFuSdL,cplcChacFuSdR,      & 
& MCha,MFu,MSd,MRPFuTocChaSd,MRGFuTocChaSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuTocChaSd(MLambda,em,gs,ZcplcChacFuSdL,ZcplcChacFuSdR,    & 
& MCha,MFu,MSd,MRPFuTocChaSd,MRGFuTocChaSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuTocChaSd(cplcChacFuSdL,cplcChacFuSdR,ctcplcChacFuSdL,& 
& ctcplcChacFuSdR,MCha,MCha2,MFu,MFu2,MSd,MSd2,ZfFUL,ZfFUR,ZfLm,ZfLp,ZfSd,               & 
& AmpWaveFuTocChaSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuTocChaSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,       & 
& AmpVertexFuTocChaSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,       & 
& AmpVertexIRdrFuTocChaSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,          & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,               & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,     & 
& AmpVertexIRosFuTocChaSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,     & 
& AmpVertexIRosFuTocChaSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,          & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,               & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,       & 
& AmpVertexIRosFuTocChaSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,       & 
& AmpVertexIRosFuTocChaSd)

 End if 
 End if 
AmpVertexFuTocChaSd = AmpVertexFuTocChaSd -  AmpVertexIRdrFuTocChaSd! +  AmpVertexIRosFuTocChaSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuTocChaSd=0._dp 
AmpVertexZFuTocChaSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuTocChaSd(1,gt2,:,:) = AmpWaveZFuTocChaSd(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuTocChaSd(1,gt1,:,:) 
AmpVertexZFuTocChaSd(1,gt2,:,:)= AmpVertexZFuTocChaSd(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuTocChaSd(1,gt1,:,:) 
AmpWaveZFuTocChaSd(2,gt2,:,:) = AmpWaveZFuTocChaSd(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuTocChaSd(2,gt1,:,:) 
AmpVertexZFuTocChaSd(2,gt2,:,:)= AmpVertexZFuTocChaSd(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuTocChaSd(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuTocChaSd=AmpWaveZFuTocChaSd 
AmpVertexFuTocChaSd= AmpVertexZFuTocChaSd
! Final State 1 
AmpWaveZFuTocChaSd=0._dp 
AmpVertexZFuTocChaSd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZFuTocChaSd(1,:,gt2,:) = AmpWaveZFuTocChaSd(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveFuTocChaSd(1,:,gt1,:) 
AmpVertexZFuTocChaSd(1,:,gt2,:)= AmpVertexZFuTocChaSd(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpVertexFuTocChaSd(1,:,gt1,:) 
AmpWaveZFuTocChaSd(2,:,gt2,:) = AmpWaveZFuTocChaSd(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveFuTocChaSd(2,:,gt1,:) 
AmpVertexZFuTocChaSd(2,:,gt2,:)= AmpVertexZFuTocChaSd(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpVertexFuTocChaSd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuTocChaSd=AmpWaveZFuTocChaSd 
AmpVertexFuTocChaSd= AmpVertexZFuTocChaSd
! Final State 2 
AmpWaveZFuTocChaSd=0._dp 
AmpVertexZFuTocChaSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZFuTocChaSd(:,:,:,gt2) = AmpWaveZFuTocChaSd(:,:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveFuTocChaSd(:,:,:,gt1) 
AmpVertexZFuTocChaSd(:,:,:,gt2)= AmpVertexZFuTocChaSd(:,:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexFuTocChaSd(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuTocChaSd=AmpWaveZFuTocChaSd 
AmpVertexFuTocChaSd= AmpVertexZFuTocChaSd
End if
If (ShiftIRdiv) Then 
AmpVertexFuTocChaSd = AmpVertexFuTocChaSd  +  AmpVertexIRosFuTocChaSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->bar[Cha] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuTocChaSd = AmpTreeFuTocChaSd 
 AmpSum2FuTocChaSd = AmpTreeFuTocChaSd + 2._dp*AmpWaveFuTocChaSd + 2._dp*AmpVertexFuTocChaSd  
Else 
 AmpSumFuTocChaSd = AmpTreeFuTocChaSd + AmpWaveFuTocChaSd + AmpVertexFuTocChaSd
 AmpSum2FuTocChaSd = AmpTreeFuTocChaSd + AmpWaveFuTocChaSd + AmpVertexFuTocChaSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuTocChaSd = AmpTreeFuTocChaSd
 AmpSum2FuTocChaSd = AmpTreeFuTocChaSd 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,2
    Do gt3=1,6
If (((OSkinematics).and.(MFuOS(gt1).gt.(MChaOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MCha(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuTocChaSd = AmpTreeFuTocChaSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MCha(gt2),MSd(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuTocChaSd(gt1, gt2, gt3) 
  AmpSum2FuTocChaSd = 2._dp*AmpWaveFuTocChaSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MCha(gt2),MSd(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuTocChaSd(gt1, gt2, gt3) 
  AmpSum2FuTocChaSd = 2._dp*AmpVertexFuTocChaSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MCha(gt2),MSd(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuTocChaSd(gt1, gt2, gt3) 
  AmpSum2FuTocChaSd = AmpTreeFuTocChaSd + 2._dp*AmpWaveFuTocChaSd + 2._dp*AmpVertexFuTocChaSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MCha(gt2),MSd(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuTocChaSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuTocChaSd = AmpTreeFuTocChaSd
  Call SquareAmp_FtoFS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
  AmpSqTreeFuTocChaSd(gt1, gt2, gt3) = (1)*AmpSqFuTocChaSd(gt1, gt2, gt3)  
  AmpSum2FuTocChaSd = + 2._dp*AmpWaveFuTocChaSd + 2._dp*AmpVertexFuTocChaSd
  Call SquareAmp_FtoFS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
  AmpSqFuTocChaSd(gt1, gt2, gt3) = AmpSqFuTocChaSd(gt1, gt2, gt3) + AmpSqTreeFuTocChaSd(gt1, gt2, gt3)  
Else  
  AmpSum2FuTocChaSd = AmpTreeFuTocChaSd
  Call SquareAmp_FtoFS(MFu(gt1),MCha(gt2),MSd(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
  AmpSqTreeFuTocChaSd(gt1, gt2, gt3) = (1)*AmpSqFuTocChaSd(gt1, gt2, gt3)  
  AmpSum2FuTocChaSd = + 2._dp*AmpWaveFuTocChaSd + 2._dp*AmpVertexFuTocChaSd
  Call SquareAmp_FtoFS(MFu(gt1),MCha(gt2),MSd(gt3),AmpSumFuTocChaSd(:,gt1, gt2, gt3),AmpSum2FuTocChaSd(:,gt1, gt2, gt3),AmpSqFuTocChaSd(gt1, gt2, gt3)) 
  AmpSqFuTocChaSd(gt1, gt2, gt3) = AmpSqFuTocChaSd(gt1, gt2, gt3) + AmpSqTreeFuTocChaSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuTocChaSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuTocChaSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MChaOS(gt2),MSdOS(gt3),helfactor*AmpSqFuTocChaSd(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MCha(gt2),MSd(gt3),helfactor*AmpSqFuTocChaSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuTocChaSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuTocChaSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuTocChaSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuTocChaSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuTocChaSd(gt1, gt2, gt3) + MRGFuTocChaSd(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuTocChaSd(gt1, gt2, gt3) + MRGFuTocChaSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! bar(Fe) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_FuTocFeSd(cplcFecFuSdL,cplcFecFuSdR,MFe,               & 
& MFu,MSd,MFe2,MFu2,MSd2,AmpTreeFuTocFeSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_FuTocFeSd(ZcplcFecFuSdL,ZcplcFecFuSdR,MFe,             & 
& MFu,MSd,MFe2,MFu2,MSd2,AmpTreeFuTocFeSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_FuTocFeSd(MLambda,em,gs,cplcFecFuSdL,cplcFecFuSdR,         & 
& MFeOS,MFuOS,MSdOS,MRPFuTocFeSd,MRGFuTocFeSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuTocFeSd(MLambda,em,gs,ZcplcFecFuSdL,ZcplcFecFuSdR,       & 
& MFeOS,MFuOS,MSdOS,MRPFuTocFeSd,MRGFuTocFeSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_FuTocFeSd(MLambda,em,gs,cplcFecFuSdL,cplcFecFuSdR,         & 
& MFe,MFu,MSd,MRPFuTocFeSd,MRGFuTocFeSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_FuTocFeSd(MLambda,em,gs,ZcplcFecFuSdL,ZcplcFecFuSdR,       & 
& MFe,MFu,MSd,MRPFuTocFeSd,MRGFuTocFeSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuTocFeSd(cplcFecFuSdL,cplcFecFuSdR,ctcplcFecFuSdL,    & 
& ctcplcFecFuSdR,MFe,MFe2,MFu,MFu2,MSd,MSd2,ZfFEL,ZfFER,ZfFUL,ZfFUR,ZfSd,AmpWaveFuTocFeSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuTocFeSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,cplcFdChiSdL,             & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFeFdcSuL,         & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,             & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,     & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,AmpVertexFuTocFeSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,           & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,         & 
& AmpVertexIRdrFuTocFeSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,cplcFdChiSdL,cplcFdChiSdR,            & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,    & 
& ZcplcFecFuSdL,ZcplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,AmpVertexIRosFuTocFeSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,           & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,       & 
& AmpVertexIRosFuTocFeSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,cplcFdChiSdL,cplcFdChiSdR,            & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,    & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,AmpVertexIRosFuTocFeSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,           & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,         & 
& AmpVertexIRosFuTocFeSd)

 End if 
 End if 
AmpVertexFuTocFeSd = AmpVertexFuTocFeSd -  AmpVertexIRdrFuTocFeSd! +  AmpVertexIRosFuTocFeSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZFuTocFeSd=0._dp 
AmpVertexZFuTocFeSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuTocFeSd(1,gt2,:,:) = AmpWaveZFuTocFeSd(1,gt2,:,:)+ZRUZUR(gt2,gt1)*AmpWaveFuTocFeSd(1,gt1,:,:) 
AmpVertexZFuTocFeSd(1,gt2,:,:)= AmpVertexZFuTocFeSd(1,gt2,:,:) + ZRUZUR(gt2,gt1)*AmpVertexFuTocFeSd(1,gt1,:,:) 
AmpWaveZFuTocFeSd(2,gt2,:,:) = AmpWaveZFuTocFeSd(2,gt2,:,:)+ZRUZULc(gt2,gt1)*AmpWaveFuTocFeSd(2,gt1,:,:) 
AmpVertexZFuTocFeSd(2,gt2,:,:)= AmpVertexZFuTocFeSd(2,gt2,:,:) + ZRUZULc(gt2,gt1)*AmpVertexFuTocFeSd(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveFuTocFeSd=AmpWaveZFuTocFeSd 
AmpVertexFuTocFeSd= AmpVertexZFuTocFeSd
! Final State 1 
AmpWaveZFuTocFeSd=0._dp 
AmpVertexZFuTocFeSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZFuTocFeSd(1,:,gt2,:) = AmpWaveZFuTocFeSd(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpWaveFuTocFeSd(1,:,gt1,:) 
AmpVertexZFuTocFeSd(1,:,gt2,:)= AmpVertexZFuTocFeSd(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpVertexFuTocFeSd(1,:,gt1,:) 
AmpWaveZFuTocFeSd(2,:,gt2,:) = AmpWaveZFuTocFeSd(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpWaveFuTocFeSd(2,:,gt1,:) 
AmpVertexZFuTocFeSd(2,:,gt2,:)= AmpVertexZFuTocFeSd(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpVertexFuTocFeSd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveFuTocFeSd=AmpWaveZFuTocFeSd 
AmpVertexFuTocFeSd= AmpVertexZFuTocFeSd
! Final State 2 
AmpWaveZFuTocFeSd=0._dp 
AmpVertexZFuTocFeSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZFuTocFeSd(:,:,:,gt2) = AmpWaveZFuTocFeSd(:,:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveFuTocFeSd(:,:,:,gt1) 
AmpVertexZFuTocFeSd(:,:,:,gt2)= AmpVertexZFuTocFeSd(:,:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexFuTocFeSd(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveFuTocFeSd=AmpWaveZFuTocFeSd 
AmpVertexFuTocFeSd= AmpVertexZFuTocFeSd
End if
If (ShiftIRdiv) Then 
AmpVertexFuTocFeSd = AmpVertexFuTocFeSd  +  AmpVertexIRosFuTocFeSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->bar[Fe] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumFuTocFeSd = AmpTreeFuTocFeSd 
 AmpSum2FuTocFeSd = AmpTreeFuTocFeSd + 2._dp*AmpWaveFuTocFeSd + 2._dp*AmpVertexFuTocFeSd  
Else 
 AmpSumFuTocFeSd = AmpTreeFuTocFeSd + AmpWaveFuTocFeSd + AmpVertexFuTocFeSd
 AmpSum2FuTocFeSd = AmpTreeFuTocFeSd + AmpWaveFuTocFeSd + AmpVertexFuTocFeSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuTocFeSd = AmpTreeFuTocFeSd
 AmpSum2FuTocFeSd = AmpTreeFuTocFeSd 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFeOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFe(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2FuTocFeSd = AmpTreeFuTocFeSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFe(gt2),MSd(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqFuTocFeSd(gt1, gt2, gt3) 
  AmpSum2FuTocFeSd = 2._dp*AmpWaveFuTocFeSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFe(gt2),MSd(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqFuTocFeSd(gt1, gt2, gt3) 
  AmpSum2FuTocFeSd = 2._dp*AmpVertexFuTocFeSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFe(gt2),MSd(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqFuTocFeSd(gt1, gt2, gt3) 
  AmpSum2FuTocFeSd = AmpTreeFuTocFeSd + 2._dp*AmpWaveFuTocFeSd + 2._dp*AmpVertexFuTocFeSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFe(gt2),MSd(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqFuTocFeSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2FuTocFeSd = AmpTreeFuTocFeSd
  Call SquareAmp_FtoFS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
  AmpSqTreeFuTocFeSd(gt1, gt2, gt3) = (1)*AmpSqFuTocFeSd(gt1, gt2, gt3)  
  AmpSum2FuTocFeSd = + 2._dp*AmpWaveFuTocFeSd + 2._dp*AmpVertexFuTocFeSd
  Call SquareAmp_FtoFS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
  AmpSqFuTocFeSd(gt1, gt2, gt3) = AmpSqFuTocFeSd(gt1, gt2, gt3) + AmpSqTreeFuTocFeSd(gt1, gt2, gt3)  
Else  
  AmpSum2FuTocFeSd = AmpTreeFuTocFeSd
  Call SquareAmp_FtoFS(MFu(gt1),MFe(gt2),MSd(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
  AmpSqTreeFuTocFeSd(gt1, gt2, gt3) = (1)*AmpSqFuTocFeSd(gt1, gt2, gt3)  
  AmpSum2FuTocFeSd = + 2._dp*AmpWaveFuTocFeSd + 2._dp*AmpVertexFuTocFeSd
  Call SquareAmp_FtoFS(MFu(gt1),MFe(gt2),MSd(gt3),AmpSumFuTocFeSd(:,gt1, gt2, gt3),AmpSum2FuTocFeSd(:,gt1, gt2, gt3),AmpSqFuTocFeSd(gt1, gt2, gt3)) 
  AmpSqFuTocFeSd(gt1, gt2, gt3) = AmpSqFuTocFeSd(gt1, gt2, gt3) + AmpSqTreeFuTocFeSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqFuTocFeSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuTocFeSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFeOS(gt2),MSdOS(gt3),helfactor*AmpSqFuTocFeSd(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFe(gt2),MSd(gt3),helfactor*AmpSqFuTocFeSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuTocFeSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuTocFeSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPFuTocFeSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuTocFeSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPFuTocFeSd(gt1, gt2, gt3) + MRGFuTocFeSd(gt1, gt2, gt3)) 
  gP1LFu(gt1,i4) = gP1LFu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPFuTocFeSd(gt1, gt2, gt3) + MRGFuTocFeSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LFu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End If 
!---------------- 
! Fu Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuSv(MFuOS,MFu2OS,MSvOS,MSv2OS,ZfFUL,              & 
& ZfFUR,ZfSv,AmpWaveFuToFuSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuSv(MFuOS,MFu2OS,MSvOS,MSv2OS,ZfFUL,              & 
& ZfFUR,ZfSv,AmpWaveFuToFuSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuSv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSv2OS,MVWm2OS,ZcplChaFucSdL,ZcplChaFucSdR,ZcplcFeChaSvL,ZcplcFeChaSvR,ZcplcFdFdSvL,   & 
& ZcplcFdFdSvR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,ZcplcFuFdcSeL,ZcplcFuFdcSeR,ZcplcFuFdcVWmL, & 
& ZcplcFuFdcVWmR,ZcplFeFucSdL,ZcplFeFucSdR,ZcplcFeFeSvL,ZcplcFeFeSvR,ZcplcFdFuHpmL,      & 
& ZcplcFdFuHpmR,ZcplcFdFuSeL,ZcplcFdFuSeR,ZcplcFdFuVWmL,ZcplcFdFuVWmR,ZcplHpmSvcSe,      & 
& ZcplSdSvcSd,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,ZcplSeSvcSe,     & 
& ZcplSvcSeVWm,AmpVertexFuToFuSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuSv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSv2OS,MVWm2OS,cplChaFucSdL,cplChaFucSdR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplHpmSvcSe,            & 
& cplSdSvcSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSvcSe,           & 
& cplSvcSeVWm,AmpVertexFuToFuSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuSv(MFu,MFu2,MSv,MSv2,ZfFUL,ZfFUR,ZfSv,           & 
& AmpWaveFuToFuSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuSv(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,              & 
& MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,cplChaFucSdR,    & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplHpmSvcSe,cplSdSvcSd,cplcChacFuSdL,cplcChacFuSdR,          & 
& cplcFecFuSdL,cplcFecFuSdR,cplSeSvcSe,cplSvcSeVWm,AmpVertexFuToFuSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFuSv = 0._dp 
 AmpSum2FuToFuSv = 0._dp  
Else 
 AmpSumFuToFuSv = AmpVertexFuToFuSv + AmpWaveFuToFuSv
 AmpSum2FuToFuSv = AmpVertexFuToFuSv + AmpWaveFuToFuSv 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MSvOS(gt3),AmpSumFuToFuSv(:,gt1, gt2, gt3),AmpSum2FuToFuSv(:,gt1, gt2, gt3),AmpSqFuToFuSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MSv(gt3),AmpSumFuToFuSv(:,gt1, gt2, gt3),AmpSum2FuToFuSv(:,gt1, gt2, gt3),AmpSqFuToFuSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqFuToFuSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFuSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),MSvOS(gt3),helfactor*AmpSqFuToFuSv(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),MSv(gt3),helfactor*AmpSqFuToFuSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFuSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Fu VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVG(ZcplcFuFuVGL,ZcplcFuFuVGR,ctcplcFuFuVGL,      & 
& ctcplcFuFuVGR,MFuOS,MFu2OS,MVG,MVG2,ZfFUL,ZfFUR,ZfVG,AmpWaveFuToFuVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVG(cplcFuFuVGL,cplcFuFuVGR,ctcplcFuFuVGL,        & 
& ctcplcFuFuVGR,MFuOS,MFu2OS,MVG,MVG2,ZfFUL,ZfFUR,ZfVG,AmpWaveFuToFuVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVG(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,ZcplcFuFuAhL,ZcplcFuFuAhR,ZcplChaFucSdL,               & 
& ZcplChaFucSdR,ZcplChiFucSuL,ZcplChiFucSuR,ZcplcFuChiSuL,ZcplcFuChiSuR,ZcplcFdFdVGL,    & 
& ZcplcFdFdVGR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,ZcplcFuFdcSeL,ZcplcFuFdcSeR,ZcplcFuFdcVWmL, & 
& ZcplcFuFdcVWmR,ZcplFeFucSdL,ZcplFeFucSdR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFuFuhhL,     & 
& ZcplcFuFuhhR,ZcplcFdFuHpmL,ZcplcFdFuHpmR,ZcplcFdFuSeL,ZcplcFdFuSeR,ZcplcFuFuVGL,       & 
& ZcplcFuFuVGR,ZcplcFuFuVPL,ZcplcFuFuVPR,ZcplcFdFuVWmL,ZcplcFdFuVWmR,ZcplcFuFuVZL,       & 
& ZcplcFuFuVZR,ZcplGluGluVGL,ZcplGluGluVGR,ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplSdcSdVG,      & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,ZcplSucSuVG,ZcplVGVGVG,      & 
& AmpVertexFuToFuVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVG(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,cplChaFucSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,cplcFdFdVGR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSucSuVG,cplVGVGVG,AmpVertexFuToFuVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVG(cplcFuFuVGL,cplcFuFuVGR,ctcplcFuFuVGL,        & 
& ctcplcFuFuVGR,MFu,MFu2,MVG,MVG2,ZfFUL,ZfFUR,ZfVG,AmpWaveFuToFuVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVG(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,   & 
& cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,          & 
& cplcFdFdVGR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,            & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSucSuVG,cplVGVGVG,            & 
& AmpVertexFuToFuVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFuVG = 0._dp 
 AmpSum2FuToFuVG = 0._dp  
Else 
 AmpSumFuToFuVG = AmpVertexFuToFuVG + AmpWaveFuToFuVG
 AmpSum2FuToFuVG = AmpVertexFuToFuVG + AmpWaveFuToFuVG 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+0.))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),0._dp,AmpSumFuToFuVG(:,gt1, gt2),AmpSum2FuToFuVG(:,gt1, gt2),AmpSqFuToFuVG(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVG,AmpSumFuToFuVG(:,gt1, gt2),AmpSum2FuToFuVG(:,gt1, gt2),AmpSqFuToFuVG(gt1, gt2)) 
End if  
Else  
  AmpSqFuToFuVG(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFuVG(gt1, gt2).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),0._dp,helfactor*AmpSqFuToFuVG(gt1, gt2))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),MVG,helfactor*AmpSqFuToFuVG(gt1, gt2))
End if 
If ((Abs(MRPFuToFuVG(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuVG(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Fu VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVP(ZcplcFuFuVPL,ZcplcFuFuVPR,ZcplcFuFuVZL,       & 
& ZcplcFuFuVZR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,MFuOS,            & 
& MFu2OS,MVP,MVP2,ZfFUL,ZfFUR,ZfVP,ZfVZVP,AmpWaveFuToFuVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVP(cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,          & 
& cplcFuFuVZR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,MFuOS,             & 
& MFu2OS,MVP,MVP2,ZfFUL,ZfFUR,ZfVP,ZfVZVP,AmpWaveFuToFuVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,ZcplcFuFuAhL,ZcplcFuFuAhR,ZcplChaFucSdL,               & 
& ZcplChaFucSdR,ZcplcChaChaVPL,ZcplcChaChaVPR,ZcplChiFucSuL,ZcplChiFucSuR,               & 
& ZcplcFuChiSuL,ZcplcFuChiSuR,ZcplcFdFdVPL,ZcplcFdFdVPR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,   & 
& ZcplcFuFdcSeL,ZcplcFuFdcSeR,ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,ZcplFeFucSdL,ZcplFeFucSdR,   & 
& ZcplcFeFeVPL,ZcplcFeFeVPR,ZcplGluFucSuL,ZcplGluFucSuR,ZcplcFuFuhhL,ZcplcFuFuhhR,       & 
& ZcplcFdFuHpmL,ZcplcFdFuHpmR,ZcplcFdFuSeL,ZcplcFdFuSeR,ZcplcFuFuVGL,ZcplcFuFuVGR,       & 
& ZcplcFuFuVPL,ZcplcFuFuVPR,ZcplcFdFuVWmL,ZcplcFdFuVWmR,ZcplcFuFuVZL,ZcplcFuFuVZR,       & 
& ZcplcFuGluSuL,ZcplcFuGluSuR,ZcplHpmcHpmVP,ZcplHpmcVWmVP,ZcplSdcSdVP,ZcplcChacFuSdL,    & 
& ZcplcChacFuSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,ZcplSecSeVP,ZcplSucSuVP,ZcplcHpmVPVWm,      & 
& ZcplcVWmVPVWm,AmpVertexFuToFuVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,cplChaFucSdR,     & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,cplcFeFeVPR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,AmpVertexFuToFuVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFuVP(cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,          & 
& cplcFuFuVZR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,MFu,               & 
& MFu2,MVP,MVP2,ZfFUL,ZfFUR,ZfVP,ZfVZVP,AmpWaveFuToFuVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFuVP(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,   & 
& cplChaFucSdR,cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,         & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,          & 
& cplcFeFeVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,            & 
& cplcFuGluSuR,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplcChacFuSdL,cplcChacFuSdR,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,             & 
& AmpVertexFuToFuVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFuVP = 0._dp 
 AmpSum2FuToFuVP = 0._dp  
Else 
 AmpSumFuToFuVP = AmpVertexFuToFuVP + AmpWaveFuToFuVP
 AmpSum2FuToFuVP = AmpVertexFuToFuVP + AmpWaveFuToFuVP 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+0.))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MFuOS(gt1),MFuOS(gt2),0._dp,AmpSumFuToFuVP(:,gt1, gt2),AmpSum2FuToFuVP(:,gt1, gt2),AmpSqFuToFuVP(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MFu(gt1),MFu(gt2),MVP,AmpSumFuToFuVP(:,gt1, gt2),AmpSum2FuToFuVP(:,gt1, gt2),AmpSqFuToFuVP(gt1, gt2)) 
End if  
Else  
  AmpSqFuToFuVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFuVP(gt1, gt2).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),0._dp,helfactor*AmpSqFuToFuVP(gt1, gt2))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),MVP,helfactor*AmpSqFuToFuVP(gt1, gt2))
End if 
If ((Abs(MRPFuToFuVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGFuToFuVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Fu Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_FuToFucSv(MFuOS,MFu2OS,MSvOS,MSv2OS,ZfFUL,             & 
& ZfFUR,ZfSv,AmpWaveFuToFucSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_FuToFucSv(MFuOS,MFu2OS,MSvOS,MSv2OS,ZfFUL,             & 
& ZfFUR,ZfSv,AmpWaveFuToFucSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFucSv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,           & 
& MSdOS,MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSv2OS,MVWm2OS,ZcplChaFucSdL,ZcplChaFucSdR,ZcplcFdFdcSvL,ZcplcFdFdcSvR,ZcplcFuFdcHpmL, & 
& ZcplcFuFdcHpmR,ZcplcFuFdcSeL,ZcplcFuFdcSeR,ZcplcFuFdcVWmL,ZcplcFuFdcVWmR,              & 
& ZcplFeFucSdL,ZcplFeFucSdR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFeFecSvL,ZcplcFeFecSvR,   & 
& ZcplcFdFuHpmL,ZcplcFdFuHpmR,ZcplcFdFuSeL,ZcplcFdFuSeR,ZcplcFdFuVWmL,ZcplcFdFuVWmR,     & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,ZcplSdcSdcSv,ZcplSecHpmcSv,  & 
& ZcplSecSecSv,ZcplSecSvcVWm,AmpVertexFuToFucSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFucSv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,           & 
& MSdOS,MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSv2OS,MVWm2OS,cplChaFucSdL,cplChaFucSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,          & 
& cplSecSvcVWm,AmpVertexFuToFucSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFucSv(MFu,MFu2,MSv,MSv2,ZfFUL,ZfFUR,               & 
& ZfSv,AmpWaveFuToFucSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFucSv(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,             & 
& MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,cplChaFucSdR,    & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,           & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,AmpVertexFuToFucSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fu conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFucSv = 0._dp 
 AmpSum2FuToFucSv = 0._dp  
Else 
 AmpSumFuToFucSv = AmpVertexFuToFucSv + AmpWaveFuToFucSv
 AmpSum2FuToFucSv = AmpVertexFuToFucSv + AmpWaveFuToFucSv 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MFuOS(gt1).gt.(MFuOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(MFu(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),MFuOS(gt2),MSvOS(gt3),AmpSumFuToFucSv(:,gt1, gt2, gt3),AmpSum2FuToFucSv(:,gt1, gt2, gt3),AmpSqFuToFucSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),MFu(gt2),MSv(gt3),AmpSumFuToFucSv(:,gt1, gt2, gt3),AmpSum2FuToFucSv(:,gt1, gt2, gt3),AmpSqFuToFucSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqFuToFucSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFucSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),MFuOS(gt2),MSvOS(gt3),helfactor*AmpSqFuToFucSv(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),MFu(gt2),MSv(gt3),helfactor*AmpSqFuToFucSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFucSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFucSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Fv Su
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_FuToFvSu(MFuOS,MFu2OS,MSuOS,MSu2OS,ZfFUL,              & 
& ZfFUR,ZfFvL,ZfSu,AmpWaveFuToFvSu)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_FuToFvSu(MFuOS,MFu2OS,MSuOS,MSu2OS,ZfFUL,              & 
& ZfFUR,ZfFvL,ZfSu,AmpWaveFuToFvSu)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFvSu(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSu2OS,MVWm2OS,ZcplFvChacSeL,ZcplFvChacSeR,ZcplcFdChaSuL,ZcplcFdChaSuR,ZcplFvFdcSdL,   & 
& ZcplFvFdcSdR,ZcplcFuFdcHpmL,ZcplcFuFdcHpmR,ZcplcFuFdcSeL,ZcplcFuFdcSeR,ZcplcFuFdcVWmL, & 
& ZcplcFuFdcVWmR,ZcplFvFecHpmL,ZcplFvFecHpmR,ZcplFvFecSeL,ZcplFvFecSeR,ZcplFvFecVWmL,    & 
& ZcplFvFecVWmR,ZcplcFdFeSuL,ZcplcFdFeSuR,ZcplcFeFvHpmL,ZcplcFeFvHpmR,ZcplcFdFvSdL,      & 
& ZcplcFdFvSdR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplcFeFvSeL,ZcplcFeFvSeR,ZcplcFeFvVWmL,      & 
& ZcplcFeFvVWmR,ZcplHpmSucSd,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplcFecFuSdL,ZcplcFecFuSdR,  & 
& ZcplSeSucSd,ZcplSucSdVWm,AmpVertexFuToFvSu)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFvSu(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSu2OS,MVWm2OS,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,          & 
& cplFvFecVWmR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,        & 
& cplSeSucSd,cplSucSdVWm,AmpVertexFuToFvSu)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_FuToFvSu(MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,ZfFvL,          & 
& ZfSu,AmpWaveFuToFvSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_FuToFvSu(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,              & 
& MSu,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,cplFvChacSeL,cplFvChacSeR,    & 
& cplcFdChaSuL,cplcFdChaSuR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplHpmSucSd,cplcChacFuSdL,           & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,cplSucSdVWm,AmpVertexFuToFvSu)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Fu->Fv Su -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumFuToFvSu = 0._dp 
 AmpSum2FuToFvSu = 0._dp  
Else 
 AmpSumFuToFvSu = AmpVertexFuToFvSu + AmpWaveFuToFvSu
 AmpSum2FuToFvSu = AmpVertexFuToFvSu + AmpWaveFuToFvSu 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MFuOS(gt1).gt.(0.+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MFu(gt1).gt.(0.+MSu(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MFuOS(gt1),0._dp,MSuOS(gt3),AmpSumFuToFvSu(:,gt1, gt2, gt3),AmpSum2FuToFvSu(:,gt1, gt2, gt3),AmpSqFuToFvSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MFu(gt1),0._dp,MSu(gt3),AmpSumFuToFvSu(:,gt1, gt2, gt3),AmpSum2FuToFvSu(:,gt1, gt2, gt3),AmpSqFuToFvSu(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqFuToFvSu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqFuToFvSu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LFu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFuOS(gt1),0._dp,MSuOS(gt3),helfactor*AmpSqFuToFvSu(gt1, gt2, gt3))
Else 
  gP1LFu(gt1,i4) = 1*GammaTPS(MFu(gt1),0._dp,MSu(gt3),helfactor*AmpSqFuToFvSu(gt1, gt2, gt3))
End if 
If ((Abs(MRPFuToFvSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGFuToFvSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LFu(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
End Subroutine OneLoopDecay_Fu

End Module Wrapper_OneLoopDecay_Fu_MSSMTriLnV
