! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:00 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Sd_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Sd_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Sd(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& ZfVPVZ,ZfVZVP,cplAhAhhh,cplAhAhSdcSdaa,cplAhcHpmVWm,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSd,cplAhSdcSdcSvaa,              & 
& cplAhSdcSecSuaa,cplAhSdSvcSdaa,cplAhSecSe,cplAhSeSucSdaa,cplAhSucSu,cplcChacFuSdL,     & 
& cplcChacFuSdR,cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,   & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,               & 
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
& cplcFuGluSuR,cplChaFucSdL,cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplcHpmVPVWm,           & 
& cplcHpmVWmVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,           & 
& cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,              & 
& cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,cplGluGluVGL,cplGluGluVGR,cplhhcHpmVWm,         & 
& cplhhcVWmVWm,cplhhhhhh,cplhhhhSdcSdaa,cplhhHpmcHpm,cplhhHpmcVWm,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSd,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSdSvcSdaa,            & 
& cplhhSecSe,cplhhSeSucSdaa,cplhhSucSu,cplhhSvcSv,cplhhVZVZ,cplHpmcHpmVP,cplHpmcHpmVZ,   & 
& cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,cplHpmSucHpmcSuaa,        & 
& cplHpmSucSd,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplHpmSuSvcSdaa,cplHpmSvcSe,             & 
& cplSdcHpmcSu,cplSdcHpmcSucSvaa,cplSdcSdcSv,cplSdcSdcVWmVWmaa,cplSdcSdVG,               & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVP,cplSdcSdVPVPaa,           & 
& cplSdcSdVPVZaa,cplSdcSdVZ,cplSdcSdVZVZaa,cplSdcSecSu,cplSdcSucVWm,cplSdcSucVWmVGLamct4ct2ct1,& 
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdSdcSdcSdabab,cplSdSdcSdcSdabba,cplSdSecHpmcSdaa,& 
& cplSdSecSdcSeaa,cplSdSucSdcSuabab,cplSdSucSdcSuabba,cplSdSvcHpmcSuaa,cplSdSvcSd,       & 
& cplSdSvcSdcSvaa,cplSdSvcSecSuaa,cplSecHpmcSv,cplSecSecSv,cplSecSeVP,cplSecSeVZ,        & 
& cplSecSvcVWm,cplSeSucHpmcSuaa,cplSeSucSd,cplSeSucSdcSvaa,cplSeSucSecSuaa,              & 
& cplSeSvcSe,cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWm,cplSucSdVWmVZaa,      & 
& cplSucSucVWmVWmaa,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,             & 
& cplVGVGVG,ctcplAhSdcSd,ctcplChaFucSdL,ctcplChaFucSdR,ctcplChiFdcSdL,ctcplChiFdcSdR,    & 
& ctcplFeFucSdL,ctcplFeFucSdR,ctcplFvFdcSdL,ctcplFvFdcSdR,ctcplGluFdcSdL,ctcplGluFdcSdR, & 
& ctcplhhSdcSd,ctcplHpmSucSd,ctcplSdcSdcSv,ctcplSdcSdVG,ctcplSdcSdVP,ctcplSdcSdVZ,       & 
& ctcplSdSvcSd,ctcplSeSucSd,ctcplSucSdVWm,GcplcHpmVPVWm,GcplHpmcVWmVP,GcplHpmSucSd,      & 
& GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,GosZcplHpmSucSd,GZcplcHpmVPVWm,GZcplHpmcVWmVP,       & 
& GZcplHpmSucSd,ZcplAhSdcSd,ZcplChaFucSdL,ZcplChaFucSdR,ZcplChiFdcSdL,ZcplChiFdcSdR,     & 
& ZcplFeFucSdL,ZcplFeFucSdR,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplGluFdcSdL,ZcplGluFdcSdR,       & 
& ZcplhhSdcSd,ZcplHpmSucSd,ZcplSdcSdcSv,ZcplSdcSdVZ,ZcplSdSvcSd,ZcplSeSucSd,             & 
& ZcplSucSdVWm,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,ZRUUM,ZRUUP,              & 
& ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,em,gs,deltaM,kont,gP1LSd)

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

Complex(dp),Intent(in) :: cplAhAhhh(2,2,2),cplAhAhSdcSdaa(2,2,6,6),cplAhcHpmVWm(2,2),cplAhhhVZ(2,2),            & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhHpmSucSdaa(2,2,6,6),cplAhSdcHpmcSuaa(2,6,2,6),& 
& cplAhSdcSd(2,6,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSdcSecSuaa(2,6,6,6),cplAhSdSvcSdaa(2,6,3,6),& 
& cplAhSecSe(2,6,6),cplAhSeSucSdaa(2,6,6,6),cplAhSucSu(2,6,6),cplcChacFuSdL(2,3,6),      & 
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
& cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,          & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6)

Complex(dp),Intent(in) :: cplGluFucSuR(3,6),cplGluGluVGL,cplGluGluVGR,cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),         & 
& cplhhhhhh(2,2,2),cplhhhhSdcSdaa(2,2,6,6),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),        & 
& cplhhHpmSucSdaa(2,2,6,6),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSd(2,6,6),cplhhSdcSdcSvaa(2,6,6,3),& 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSdSvcSdaa(2,6,3,6),cplhhSecSe(2,6,6),cplhhSeSucSdaa(2,6,6,6),& 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhVZVZ(2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),  & 
& cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSdcSdcSeaa(2,6,6,6),  & 
& cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSucSd(2,6,6),cplHpmSucSdcSvaa(2,6,6,3),               & 
& cplHpmSucSecSuaa(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),cplHpmSvcSe(2,3,6),cplSdcHpmcSu(6,2,6),& 
& cplSdcHpmcSucSvaa(6,2,6,3),cplSdcSdcSv(6,6,3),cplSdcSdcVWmVWmaa(6,6),cplSdcSdVG(6,6),  & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),& 
& cplSdcSdVGVPLamct3ct2ct1(6,6),cplSdcSdVGVZLamct3ct2ct1(6,6),cplSdcSdVP(6,6),           & 
& cplSdcSdVPVPaa(6,6),cplSdcSdVPVZaa(6,6),cplSdcSdVZ(6,6),cplSdcSdVZVZaa(6,6),           & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSdcSucVWmVPaa(6,6),& 
& cplSdcSucVWmVZaa(6,6),cplSdSdcSdcSdabab(6,6,6,6),cplSdSdcSdcSdabba(6,6,6,6),           & 
& cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),         & 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),cplSdSvcSd(6,3,6),cplSdSvcSdcSvaa(6,3,6,3),& 
& cplSdSvcSecSuaa(6,3,6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSeVP(6,6),       & 
& cplSecSeVZ(6,6),cplSecSvcVWm(6,3),cplSeSucHpmcSuaa(6,6,2,6),cplSeSucSd(6,6,6),         & 
& cplSeSucSdcSvaa(6,6,6,3),cplSeSucSecSuaa(6,6,6,6),cplSeSvcSe(6,3,6),cplSucSdVGVWmLamct3ct2ct1(6,6),& 
& cplSucSdVPVWmaa(6,6),cplSucSdVWm(6,6),cplSucSdVWmVZaa(6,6),cplSucSucVWmVWmaa(6,6),     & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),      & 
& cplVGVGVG,ctcplAhSdcSd(2,6,6),ctcplChaFucSdL(2,3,6),ctcplChaFucSdR(2,3,6),             & 
& ctcplChiFdcSdL(4,3,6),ctcplChiFdcSdR(4,3,6),ctcplFeFucSdL(3,3,6),ctcplFeFucSdR(3,3,6), & 
& ctcplFvFdcSdL(3,3,6),ctcplFvFdcSdR(3,3,6),ctcplGluFdcSdL(3,6),ctcplGluFdcSdR(3,6),     & 
& ctcplhhSdcSd(2,6,6),ctcplHpmSucSd(2,6,6),ctcplSdcSdcSv(6,6,3),ctcplSdcSdVG(6,6),       & 
& ctcplSdcSdVP(6,6),ctcplSdcSdVZ(6,6),ctcplSdSvcSd(6,3,6),ctcplSeSucSd(6,6,6),           & 
& ctcplSucSdVWm(6,6),GcplcHpmVPVWm(2),GcplHpmcVWmVP(2),GcplHpmSucSd(2,6,6),              & 
& GosZcplcHpmVPVWm(2),GosZcplHpmcVWmVP(2),GosZcplHpmSucSd(2,6,6),GZcplcHpmVPVWm(2),      & 
& GZcplHpmcVWmVP(2),GZcplHpmSucSd(2,6,6),ZcplAhSdcSd(2,6,6),ZcplChaFucSdL(2,3,6),        & 
& ZcplChaFucSdR(2,3,6),ZcplChiFdcSdL(4,3,6),ZcplChiFdcSdR(4,3,6),ZcplFeFucSdL(3,3,6),    & 
& ZcplFeFucSdR(3,3,6),ZcplFvFdcSdL(3,3,6),ZcplFvFdcSdR(3,3,6),ZcplGluFdcSdL(3,6),        & 
& ZcplGluFdcSdR(3,6),ZcplhhSdcSd(2,6,6),ZcplHpmSucSd(2,6,6),ZcplSdcSdcSv(6,6,3),         & 
& ZcplSdcSdVZ(6,6),ZcplSdSvcSd(6,3,6),ZcplSeSucSd(6,6,6),ZcplSucSdVWm(6,6)

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
Real(dp), Intent(out) :: gP1LSd(6,159) 
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
Real(dp) :: MRPSdToSdAh(6,6,2),MRGSdToSdAh(6,6,2), MRPZSdToSdAh(6,6,2),MRGZSdToSdAh(6,6,2) 
Real(dp) :: MVPSdToSdAh(6,6,2) 
Real(dp) :: RMsqTreeSdToSdAh(6,6,2),RMsqWaveSdToSdAh(6,6,2),RMsqVertexSdToSdAh(6,6,2) 
Complex(dp) :: AmpTreeSdToSdAh(6,6,2),AmpWaveSdToSdAh(6,6,2),AmpVertexSdToSdAh(6,6,2)& 
 & ,AmpVertexIRosSdToSdAh(6,6,2),AmpVertexIRdrSdToSdAh(6,6,2), AmpSumSdToSdAh(6,6,2), AmpSum2SdToSdAh(6,6,2) 
Complex(dp) :: AmpTreeZSdToSdAh(6,6,2),AmpWaveZSdToSdAh(6,6,2),AmpVertexZSdToSdAh(6,6,2) 
Real(dp) :: AmpSqSdToSdAh(6,6,2),  AmpSqTreeSdToSdAh(6,6,2) 
Real(dp) :: MRPSdToFuCha(6,3,2),MRGSdToFuCha(6,3,2), MRPZSdToFuCha(6,3,2),MRGZSdToFuCha(6,3,2) 
Real(dp) :: MVPSdToFuCha(6,3,2) 
Real(dp) :: RMsqTreeSdToFuCha(6,3,2),RMsqWaveSdToFuCha(6,3,2),RMsqVertexSdToFuCha(6,3,2) 
Complex(dp) :: AmpTreeSdToFuCha(2,6,3,2),AmpWaveSdToFuCha(2,6,3,2),AmpVertexSdToFuCha(2,6,3,2)& 
 & ,AmpVertexIRosSdToFuCha(2,6,3,2),AmpVertexIRdrSdToFuCha(2,6,3,2), AmpSumSdToFuCha(2,6,3,2), AmpSum2SdToFuCha(2,6,3,2) 
Complex(dp) :: AmpTreeZSdToFuCha(2,6,3,2),AmpWaveZSdToFuCha(2,6,3,2),AmpVertexZSdToFuCha(2,6,3,2) 
Real(dp) :: AmpSqSdToFuCha(6,3,2),  AmpSqTreeSdToFuCha(6,3,2) 
Real(dp) :: MRPSdToFdChi(6,3,4),MRGSdToFdChi(6,3,4), MRPZSdToFdChi(6,3,4),MRGZSdToFdChi(6,3,4) 
Real(dp) :: MVPSdToFdChi(6,3,4) 
Real(dp) :: RMsqTreeSdToFdChi(6,3,4),RMsqWaveSdToFdChi(6,3,4),RMsqVertexSdToFdChi(6,3,4) 
Complex(dp) :: AmpTreeSdToFdChi(2,6,3,4),AmpWaveSdToFdChi(2,6,3,4),AmpVertexSdToFdChi(2,6,3,4)& 
 & ,AmpVertexIRosSdToFdChi(2,6,3,4),AmpVertexIRdrSdToFdChi(2,6,3,4), AmpSumSdToFdChi(2,6,3,4), AmpSum2SdToFdChi(2,6,3,4) 
Complex(dp) :: AmpTreeZSdToFdChi(2,6,3,4),AmpWaveZSdToFdChi(2,6,3,4),AmpVertexZSdToFdChi(2,6,3,4) 
Real(dp) :: AmpSqSdToFdChi(6,3,4),  AmpSqTreeSdToFdChi(6,3,4) 
Real(dp) :: MRPSdToFvFd(6,3,3),MRGSdToFvFd(6,3,3), MRPZSdToFvFd(6,3,3),MRGZSdToFvFd(6,3,3) 
Real(dp) :: MVPSdToFvFd(6,3,3) 
Real(dp) :: RMsqTreeSdToFvFd(6,3,3),RMsqWaveSdToFvFd(6,3,3),RMsqVertexSdToFvFd(6,3,3) 
Complex(dp) :: AmpTreeSdToFvFd(2,6,3,3),AmpWaveSdToFvFd(2,6,3,3),AmpVertexSdToFvFd(2,6,3,3)& 
 & ,AmpVertexIRosSdToFvFd(2,6,3,3),AmpVertexIRdrSdToFvFd(2,6,3,3), AmpSumSdToFvFd(2,6,3,3), AmpSum2SdToFvFd(2,6,3,3) 
Complex(dp) :: AmpTreeZSdToFvFd(2,6,3,3),AmpWaveZSdToFvFd(2,6,3,3),AmpVertexZSdToFvFd(2,6,3,3) 
Real(dp) :: AmpSqSdToFvFd(6,3,3),  AmpSqTreeSdToFvFd(6,3,3) 
Real(dp) :: MRPSdToGluFd(6,3),MRGSdToGluFd(6,3), MRPZSdToGluFd(6,3),MRGZSdToGluFd(6,3) 
Real(dp) :: MVPSdToGluFd(6,3) 
Real(dp) :: RMsqTreeSdToGluFd(6,3),RMsqWaveSdToGluFd(6,3),RMsqVertexSdToGluFd(6,3) 
Complex(dp) :: AmpTreeSdToGluFd(2,6,3),AmpWaveSdToGluFd(2,6,3),AmpVertexSdToGluFd(2,6,3)& 
 & ,AmpVertexIRosSdToGluFd(2,6,3),AmpVertexIRdrSdToGluFd(2,6,3), AmpSumSdToGluFd(2,6,3), AmpSum2SdToGluFd(2,6,3) 
Complex(dp) :: AmpTreeZSdToGluFd(2,6,3),AmpWaveZSdToGluFd(2,6,3),AmpVertexZSdToGluFd(2,6,3) 
Real(dp) :: AmpSqSdToGluFd(6,3),  AmpSqTreeSdToGluFd(6,3) 
Real(dp) :: MRPSdToFuFe(6,3,3),MRGSdToFuFe(6,3,3), MRPZSdToFuFe(6,3,3),MRGZSdToFuFe(6,3,3) 
Real(dp) :: MVPSdToFuFe(6,3,3) 
Real(dp) :: RMsqTreeSdToFuFe(6,3,3),RMsqWaveSdToFuFe(6,3,3),RMsqVertexSdToFuFe(6,3,3) 
Complex(dp) :: AmpTreeSdToFuFe(2,6,3,3),AmpWaveSdToFuFe(2,6,3,3),AmpVertexSdToFuFe(2,6,3,3)& 
 & ,AmpVertexIRosSdToFuFe(2,6,3,3),AmpVertexIRdrSdToFuFe(2,6,3,3), AmpSumSdToFuFe(2,6,3,3), AmpSum2SdToFuFe(2,6,3,3) 
Complex(dp) :: AmpTreeZSdToFuFe(2,6,3,3),AmpWaveZSdToFuFe(2,6,3,3),AmpVertexZSdToFuFe(2,6,3,3) 
Real(dp) :: AmpSqSdToFuFe(6,3,3),  AmpSqTreeSdToFuFe(6,3,3) 
Real(dp) :: MRPSdToSdhh(6,6,2),MRGSdToSdhh(6,6,2), MRPZSdToSdhh(6,6,2),MRGZSdToSdhh(6,6,2) 
Real(dp) :: MVPSdToSdhh(6,6,2) 
Real(dp) :: RMsqTreeSdToSdhh(6,6,2),RMsqWaveSdToSdhh(6,6,2),RMsqVertexSdToSdhh(6,6,2) 
Complex(dp) :: AmpTreeSdToSdhh(6,6,2),AmpWaveSdToSdhh(6,6,2),AmpVertexSdToSdhh(6,6,2)& 
 & ,AmpVertexIRosSdToSdhh(6,6,2),AmpVertexIRdrSdToSdhh(6,6,2), AmpSumSdToSdhh(6,6,2), AmpSum2SdToSdhh(6,6,2) 
Complex(dp) :: AmpTreeZSdToSdhh(6,6,2),AmpWaveZSdToSdhh(6,6,2),AmpVertexZSdToSdhh(6,6,2) 
Real(dp) :: AmpSqSdToSdhh(6,6,2),  AmpSqTreeSdToSdhh(6,6,2) 
Real(dp) :: MRPSdToSuHpm(6,6,2),MRGSdToSuHpm(6,6,2), MRPZSdToSuHpm(6,6,2),MRGZSdToSuHpm(6,6,2) 
Real(dp) :: MVPSdToSuHpm(6,6,2) 
Real(dp) :: RMsqTreeSdToSuHpm(6,6,2),RMsqWaveSdToSuHpm(6,6,2),RMsqVertexSdToSuHpm(6,6,2) 
Complex(dp) :: AmpTreeSdToSuHpm(6,6,2),AmpWaveSdToSuHpm(6,6,2),AmpVertexSdToSuHpm(6,6,2)& 
 & ,AmpVertexIRosSdToSuHpm(6,6,2),AmpVertexIRdrSdToSuHpm(6,6,2), AmpSumSdToSuHpm(6,6,2), AmpSum2SdToSuHpm(6,6,2) 
Complex(dp) :: AmpTreeZSdToSuHpm(6,6,2),AmpWaveZSdToSuHpm(6,6,2),AmpVertexZSdToSuHpm(6,6,2) 
Real(dp) :: AmpSqSdToSuHpm(6,6,2),  AmpSqTreeSdToSuHpm(6,6,2) 
Real(dp) :: MRPSdToSvSd(6,3,6),MRGSdToSvSd(6,3,6), MRPZSdToSvSd(6,3,6),MRGZSdToSvSd(6,3,6) 
Real(dp) :: MVPSdToSvSd(6,3,6) 
Real(dp) :: RMsqTreeSdToSvSd(6,3,6),RMsqWaveSdToSvSd(6,3,6),RMsqVertexSdToSvSd(6,3,6) 
Complex(dp) :: AmpTreeSdToSvSd(6,3,6),AmpWaveSdToSvSd(6,3,6),AmpVertexSdToSvSd(6,3,6)& 
 & ,AmpVertexIRosSdToSvSd(6,3,6),AmpVertexIRdrSdToSvSd(6,3,6), AmpSumSdToSvSd(6,3,6), AmpSum2SdToSvSd(6,3,6) 
Complex(dp) :: AmpTreeZSdToSvSd(6,3,6),AmpWaveZSdToSvSd(6,3,6),AmpVertexZSdToSvSd(6,3,6) 
Real(dp) :: AmpSqSdToSvSd(6,3,6),  AmpSqTreeSdToSvSd(6,3,6) 
Real(dp) :: MRPSdToSdVZ(6,6),MRGSdToSdVZ(6,6), MRPZSdToSdVZ(6,6),MRGZSdToSdVZ(6,6) 
Real(dp) :: MVPSdToSdVZ(6,6) 
Real(dp) :: RMsqTreeSdToSdVZ(6,6),RMsqWaveSdToSdVZ(6,6),RMsqVertexSdToSdVZ(6,6) 
Complex(dp) :: AmpTreeSdToSdVZ(2,6,6),AmpWaveSdToSdVZ(2,6,6),AmpVertexSdToSdVZ(2,6,6)& 
 & ,AmpVertexIRosSdToSdVZ(2,6,6),AmpVertexIRdrSdToSdVZ(2,6,6), AmpSumSdToSdVZ(2,6,6), AmpSum2SdToSdVZ(2,6,6) 
Complex(dp) :: AmpTreeZSdToSdVZ(2,6,6),AmpWaveZSdToSdVZ(2,6,6),AmpVertexZSdToSdVZ(2,6,6) 
Real(dp) :: AmpSqSdToSdVZ(6,6),  AmpSqTreeSdToSdVZ(6,6) 
Real(dp) :: MRPSdTocSvSd(6,3,6),MRGSdTocSvSd(6,3,6), MRPZSdTocSvSd(6,3,6),MRGZSdTocSvSd(6,3,6) 
Real(dp) :: MVPSdTocSvSd(6,3,6) 
Real(dp) :: RMsqTreeSdTocSvSd(6,3,6),RMsqWaveSdTocSvSd(6,3,6),RMsqVertexSdTocSvSd(6,3,6) 
Complex(dp) :: AmpTreeSdTocSvSd(6,3,6),AmpWaveSdTocSvSd(6,3,6),AmpVertexSdTocSvSd(6,3,6)& 
 & ,AmpVertexIRosSdTocSvSd(6,3,6),AmpVertexIRdrSdTocSvSd(6,3,6), AmpSumSdTocSvSd(6,3,6), AmpSum2SdTocSvSd(6,3,6) 
Complex(dp) :: AmpTreeZSdTocSvSd(6,3,6),AmpWaveZSdTocSvSd(6,3,6),AmpVertexZSdTocSvSd(6,3,6) 
Real(dp) :: AmpSqSdTocSvSd(6,3,6),  AmpSqTreeSdTocSvSd(6,3,6) 
Real(dp) :: MRPSdToSuSe(6,6,6),MRGSdToSuSe(6,6,6), MRPZSdToSuSe(6,6,6),MRGZSdToSuSe(6,6,6) 
Real(dp) :: MVPSdToSuSe(6,6,6) 
Real(dp) :: RMsqTreeSdToSuSe(6,6,6),RMsqWaveSdToSuSe(6,6,6),RMsqVertexSdToSuSe(6,6,6) 
Complex(dp) :: AmpTreeSdToSuSe(6,6,6),AmpWaveSdToSuSe(6,6,6),AmpVertexSdToSuSe(6,6,6)& 
 & ,AmpVertexIRosSdToSuSe(6,6,6),AmpVertexIRdrSdToSuSe(6,6,6), AmpSumSdToSuSe(6,6,6), AmpSum2SdToSuSe(6,6,6) 
Complex(dp) :: AmpTreeZSdToSuSe(6,6,6),AmpWaveZSdToSuSe(6,6,6),AmpVertexZSdToSuSe(6,6,6) 
Real(dp) :: AmpSqSdToSuSe(6,6,6),  AmpSqTreeSdToSuSe(6,6,6) 
Real(dp) :: MRPSdToSuVWm(6,6),MRGSdToSuVWm(6,6), MRPZSdToSuVWm(6,6),MRGZSdToSuVWm(6,6) 
Real(dp) :: MVPSdToSuVWm(6,6) 
Real(dp) :: RMsqTreeSdToSuVWm(6,6),RMsqWaveSdToSuVWm(6,6),RMsqVertexSdToSuVWm(6,6) 
Complex(dp) :: AmpTreeSdToSuVWm(2,6,6),AmpWaveSdToSuVWm(2,6,6),AmpVertexSdToSuVWm(2,6,6)& 
 & ,AmpVertexIRosSdToSuVWm(2,6,6),AmpVertexIRdrSdToSuVWm(2,6,6), AmpSumSdToSuVWm(2,6,6), AmpSum2SdToSuVWm(2,6,6) 
Complex(dp) :: AmpTreeZSdToSuVWm(2,6,6),AmpWaveZSdToSuVWm(2,6,6),AmpVertexZSdToSuVWm(2,6,6) 
Real(dp) :: AmpSqSdToSuVWm(6,6),  AmpSqTreeSdToSuVWm(6,6) 
Real(dp) :: MRPSdToSdVG(6,6),MRGSdToSdVG(6,6), MRPZSdToSdVG(6,6),MRGZSdToSdVG(6,6) 
Real(dp) :: MVPSdToSdVG(6,6) 
Real(dp) :: RMsqTreeSdToSdVG(6,6),RMsqWaveSdToSdVG(6,6),RMsqVertexSdToSdVG(6,6) 
Complex(dp) :: AmpTreeSdToSdVG(2,6,6),AmpWaveSdToSdVG(2,6,6),AmpVertexSdToSdVG(2,6,6)& 
 & ,AmpVertexIRosSdToSdVG(2,6,6),AmpVertexIRdrSdToSdVG(2,6,6), AmpSumSdToSdVG(2,6,6), AmpSum2SdToSdVG(2,6,6) 
Complex(dp) :: AmpTreeZSdToSdVG(2,6,6),AmpWaveZSdToSdVG(2,6,6),AmpVertexZSdToSdVG(2,6,6) 
Real(dp) :: AmpSqSdToSdVG(6,6),  AmpSqTreeSdToSdVG(6,6) 
Real(dp) :: MRPSdToSdVP(6,6),MRGSdToSdVP(6,6), MRPZSdToSdVP(6,6),MRGZSdToSdVP(6,6) 
Real(dp) :: MVPSdToSdVP(6,6) 
Real(dp) :: RMsqTreeSdToSdVP(6,6),RMsqWaveSdToSdVP(6,6),RMsqVertexSdToSdVP(6,6) 
Complex(dp) :: AmpTreeSdToSdVP(2,6,6),AmpWaveSdToSdVP(2,6,6),AmpVertexSdToSdVP(2,6,6)& 
 & ,AmpVertexIRosSdToSdVP(2,6,6),AmpVertexIRdrSdToSdVP(2,6,6), AmpSumSdToSdVP(2,6,6), AmpSum2SdToSdVP(2,6,6) 
Complex(dp) :: AmpTreeZSdToSdVP(2,6,6),AmpWaveZSdToSdVP(2,6,6),AmpVertexZSdToSdVP(2,6,6) 
Real(dp) :: AmpSqSdToSdVP(6,6),  AmpSqTreeSdToSdVP(6,6) 
Write(*,*) "Calculating one-loop decays of Sd " 
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
! Sd Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSdAh(cplAhSdcSd,MAh,MSd,MAh2,MSd2,AmpTreeSdToSdAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSdAh(ZcplAhSdcSd,MAh,MSd,MAh2,MSd2,AmpTreeSdToSdAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdAh(MLambda,em,gs,cplAhSdcSd,MAhOS,MSdOS,             & 
& MRPSdToSdAh,MRGSdToSdAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdAh(MLambda,em,gs,ZcplAhSdcSd,MAhOS,MSdOS,            & 
& MRPSdToSdAh,MRGSdToSdAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSdAh(MLambda,em,gs,cplAhSdcSd,MAh,MSd,MRPSdToSdAh,     & 
& MRGSdToSdAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdAh(MLambda,em,gs,ZcplAhSdcSd,MAh,MSd,MRPSdToSdAh,    & 
& MRGSdToSdAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdAh(cplAhSdcSd,ctcplAhSdcSd,MAh,MAh2,             & 
& MSd,MSd2,ZfAh,ZfSd,AmpWaveSdToSdAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdAh(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,            & 
& cplAhHpmSucSdaa,cplAhSdSvcSdaa,cplAhSdcHpmcSuaa,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,       & 
& cplAhSeSucSdaa,cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexSdToSdAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,            & 
& cplAhHpmSucSdaa,cplAhSdSvcSdaa,cplAhSdcHpmcSuaa,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,       & 
& cplAhSeSucSdaa,cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexIRdrSdToSdAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,   & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,ZcplAhSdcSd,               & 
& cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,             & 
& cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,             & 
& cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,       & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,        & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplAhHpmSucSdaa,        & 
& cplAhSdSvcSdaa,cplAhSdcHpmcSuaa,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,        & 
& cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,& 
& cplSdSucSdcSuabab,AmpVertexIRosSdToSdAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& ZcplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,            & 
& cplAhHpmSucSdaa,cplAhSdSvcSdaa,cplAhSdcHpmcSuaa,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,       & 
& cplAhSeSucSdaa,cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexIRosSdToSdAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,   & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,      & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplAhHpmSucSdaa,cplAhSdSvcSdaa,     & 
& cplAhSdcHpmcSuaa,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSdcHpmcSdaa,     & 
& cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,& 
& AmpVertexIRosSdToSdAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,            & 
& cplAhHpmSucSdaa,cplAhSdSvcSdaa,cplAhSdcHpmcSuaa,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,       & 
& cplAhSeSucSdaa,cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexIRosSdToSdAh)

 End if 
 End if 
AmpVertexSdToSdAh = AmpVertexSdToSdAh -  AmpVertexIRdrSdToSdAh! +  AmpVertexIRosSdToSdAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSdAh=0._dp 
AmpVertexZSdToSdAh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSdAh(gt2,:,:) = AmpWaveZSdToSdAh(gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSdAh(gt1,:,:) 
AmpVertexZSdToSdAh(gt2,:,:)= AmpVertexZSdToSdAh(gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSdAh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToSdAh=AmpWaveZSdToSdAh 
AmpVertexSdToSdAh= AmpVertexZSdToSdAh
! Final State 1 
AmpWaveZSdToSdAh=0._dp 
AmpVertexZSdToSdAh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSdAh(:,gt2,:) = AmpWaveZSdToSdAh(:,gt2,:)+ZRUZD(gt2,gt1)*AmpWaveSdToSdAh(:,gt1,:) 
AmpVertexZSdToSdAh(:,gt2,:)= AmpVertexZSdToSdAh(:,gt2,:)+ZRUZD(gt2,gt1)*AmpVertexSdToSdAh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSdAh=AmpWaveZSdToSdAh 
AmpVertexSdToSdAh= AmpVertexZSdToSdAh
! Final State 2 
AmpWaveZSdToSdAh=0._dp 
AmpVertexZSdToSdAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSdToSdAh(:,:,gt2) = AmpWaveZSdToSdAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveSdToSdAh(:,:,gt1) 
AmpVertexZSdToSdAh(:,:,gt2)= AmpVertexZSdToSdAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexSdToSdAh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSdAh=AmpWaveZSdToSdAh 
AmpVertexSdToSdAh= AmpVertexZSdToSdAh
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSdAh = AmpVertexSdToSdAh  +  AmpVertexIRosSdToSdAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Sd Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSdAh = AmpTreeSdToSdAh 
 AmpSum2SdToSdAh = AmpTreeSdToSdAh + 2._dp*AmpWaveSdToSdAh + 2._dp*AmpVertexSdToSdAh  
Else 
 AmpSumSdToSdAh = AmpTreeSdToSdAh + AmpWaveSdToSdAh + AmpVertexSdToSdAh
 AmpSum2SdToSdAh = AmpTreeSdToSdAh + AmpWaveSdToSdAh + AmpVertexSdToSdAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSdAh = AmpTreeSdToSdAh
 AmpSum2SdToSdAh = AmpTreeSdToSdAh 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=2,2
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSdOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSd(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToSdAh = AmpTreeSdToSdAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),MAh(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSdAh(gt1, gt2, gt3) 
  AmpSum2SdToSdAh = 2._dp*AmpWaveSdToSdAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),MAh(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSdAh(gt1, gt2, gt3) 
  AmpSum2SdToSdAh = 2._dp*AmpVertexSdToSdAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),MAh(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSdAh(gt1, gt2, gt3) 
  AmpSum2SdToSdAh = AmpTreeSdToSdAh + 2._dp*AmpWaveSdToSdAh + 2._dp*AmpVertexSdToSdAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),MAh(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSdAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSdAh = AmpTreeSdToSdAh
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
  AmpSqTreeSdToSdAh(gt1, gt2, gt3) = (1)*AmpSqSdToSdAh(gt1, gt2, gt3)  
  AmpSum2SdToSdAh = + 2._dp*AmpWaveSdToSdAh + 2._dp*AmpVertexSdToSdAh
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
  AmpSqSdToSdAh(gt1, gt2, gt3) = AmpSqSdToSdAh(gt1, gt2, gt3) + AmpSqTreeSdToSdAh(gt1, gt2, gt3)  
Else  
  AmpSum2SdToSdAh = AmpTreeSdToSdAh
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),MAh(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
  AmpSqTreeSdToSdAh(gt1, gt2, gt3) = (1)*AmpSqSdToSdAh(gt1, gt2, gt3)  
  AmpSum2SdToSdAh = + 2._dp*AmpWaveSdToSdAh + 2._dp*AmpVertexSdToSdAh
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),MAh(gt3),AmpSumSdToSdAh(gt1, gt2, gt3),AmpSum2SdToSdAh(gt1, gt2, gt3),AmpSqSdToSdAh(gt1, gt2, gt3)) 
  AmpSqSdToSdAh(gt1, gt2, gt3) = AmpSqSdToSdAh(gt1, gt2, gt3) + AmpSqTreeSdToSdAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToSdAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSdAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSdOS(gt2),MAhOS(gt3),helfactor*AmpSqSdToSdAh(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSd(gt2),MAh(gt3),helfactor*AmpSqSdToSdAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToSdAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSdAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSdAh(gt1, gt2, gt3) + MRGSdToSdAh(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSdAh(gt1, gt2, gt3) + MRGSdToSdAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fu Cha
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToFuCha(cplChaFucSdL,cplChaFucSdR,MCha,              & 
& MFu,MSd,MCha2,MFu2,MSd2,AmpTreeSdToFuCha)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToFuCha(ZcplChaFucSdL,ZcplChaFucSdR,MCha,            & 
& MFu,MSd,MCha2,MFu2,MSd2,AmpTreeSdToFuCha)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFuCha(MLambda,em,gs,cplChaFucSdL,cplChaFucSdR,         & 
& MChaOS,MFuOS,MSdOS,MRPSdToFuCha,MRGSdToFuCha)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFuCha(MLambda,em,gs,ZcplChaFucSdL,ZcplChaFucSdR,       & 
& MChaOS,MFuOS,MSdOS,MRPSdToFuCha,MRGSdToFuCha)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToFuCha(MLambda,em,gs,cplChaFucSdL,cplChaFucSdR,         & 
& MCha,MFu,MSd,MRPSdToFuCha,MRGSdToFuCha)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFuCha(MLambda,em,gs,ZcplChaFucSdL,ZcplChaFucSdR,       & 
& MCha,MFu,MSd,MRPSdToFuCha,MRGSdToFuCha)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToFuCha(cplChaFucSdL,cplChaFucSdR,ctcplChaFucSdL,    & 
& ctcplChaFucSdR,MCha,MCha2,MFu,MFu2,MSd,MSd2,ZfFUL,ZfFUR,ZfLm,ZfLp,ZfSd,AmpWaveSdToFuCha)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToFuCha(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,       & 
& AmpVertexSdToFuCha)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,       & 
& AmpVertexIRdrSdToFuCha)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,ZcplChaFucSdL,ZcplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,    & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,      & 
& cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,            & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSdcSd,              & 
& cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,AmpVertexIRosSdToFuCha)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiChacVWmL,cplChiChacVWmR,ZcplChaFucSdL,ZcplChaFucSdR,cplFvChacSeL,cplFvChacSeR,   & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,       & 
& AmpVertexIRosSdToFuCha)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,       & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,      & 
& cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,            & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSdcSd,              & 
& cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,AmpVertexIRosSdToFuCha)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,       & 
& AmpVertexIRosSdToFuCha)

 End if 
 End if 
AmpVertexSdToFuCha = AmpVertexSdToFuCha -  AmpVertexIRdrSdToFuCha! +  AmpVertexIRosSdToFuCha ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToFuCha=0._dp 
AmpVertexZSdToFuCha=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToFuCha(:,gt2,:,:) = AmpWaveZSdToFuCha(:,gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToFuCha(:,gt1,:,:) 
AmpVertexZSdToFuCha(:,gt2,:,:)= AmpVertexZSdToFuCha(:,gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToFuCha(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToFuCha=AmpWaveZSdToFuCha 
AmpVertexSdToFuCha= AmpVertexZSdToFuCha
! Final State 1 
AmpWaveZSdToFuCha=0._dp 
AmpVertexZSdToFuCha=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToFuCha(1,:,gt2,:) = AmpWaveZSdToFuCha(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpWaveSdToFuCha(1,:,gt1,:) 
AmpVertexZSdToFuCha(1,:,gt2,:)= AmpVertexZSdToFuCha(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpVertexSdToFuCha(1,:,gt1,:) 
AmpWaveZSdToFuCha(2,:,gt2,:) = AmpWaveZSdToFuCha(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpWaveSdToFuCha(2,:,gt1,:) 
AmpVertexZSdToFuCha(2,:,gt2,:)= AmpVertexZSdToFuCha(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpVertexSdToFuCha(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToFuCha=AmpWaveZSdToFuCha 
AmpVertexSdToFuCha= AmpVertexZSdToFuCha
! Final State 2 
AmpWaveZSdToFuCha=0._dp 
AmpVertexZSdToFuCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSdToFuCha(1,:,:,gt2) = AmpWaveZSdToFuCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpWaveSdToFuCha(1,:,:,gt1) 
AmpVertexZSdToFuCha(1,:,:,gt2)= AmpVertexZSdToFuCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexSdToFuCha(1,:,:,gt1) 
AmpWaveZSdToFuCha(2,:,:,gt2) = AmpWaveZSdToFuCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpWaveSdToFuCha(2,:,:,gt1) 
AmpVertexZSdToFuCha(2,:,:,gt2)= AmpVertexZSdToFuCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpVertexSdToFuCha(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToFuCha=AmpWaveZSdToFuCha 
AmpVertexSdToFuCha= AmpVertexZSdToFuCha
End if
If (ShiftIRdiv) Then 
AmpVertexSdToFuCha = AmpVertexSdToFuCha  +  AmpVertexIRosSdToFuCha
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Fu Cha -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToFuCha = AmpTreeSdToFuCha 
 AmpSum2SdToFuCha = AmpTreeSdToFuCha + 2._dp*AmpWaveSdToFuCha + 2._dp*AmpVertexSdToFuCha  
Else 
 AmpSumSdToFuCha = AmpTreeSdToFuCha + AmpWaveSdToFuCha + AmpVertexSdToFuCha
 AmpSum2SdToFuCha = AmpTreeSdToFuCha + AmpWaveSdToFuCha + AmpVertexSdToFuCha 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToFuCha = AmpTreeSdToFuCha
 AmpSum2SdToFuCha = AmpTreeSdToFuCha 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,2
If (((OSkinematics).and.(MSdOS(gt1).gt.(MFuOS(gt2)+MChaOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MFu(gt2)+MCha(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToFuCha = AmpTreeSdToFuCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MCha(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToFuCha(gt1, gt2, gt3) 
  AmpSum2SdToFuCha = 2._dp*AmpWaveSdToFuCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MCha(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToFuCha(gt1, gt2, gt3) 
  AmpSum2SdToFuCha = 2._dp*AmpVertexSdToFuCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MCha(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToFuCha(gt1, gt2, gt3) 
  AmpSum2SdToFuCha = AmpTreeSdToFuCha + 2._dp*AmpWaveSdToFuCha + 2._dp*AmpVertexSdToFuCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MCha(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToFuCha(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToFuCha = AmpTreeSdToFuCha
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
  AmpSqTreeSdToFuCha(gt1, gt2, gt3) = (1)*AmpSqSdToFuCha(gt1, gt2, gt3)  
  AmpSum2SdToFuCha = + 2._dp*AmpWaveSdToFuCha + 2._dp*AmpVertexSdToFuCha
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
  AmpSqSdToFuCha(gt1, gt2, gt3) = AmpSqSdToFuCha(gt1, gt2, gt3) + AmpSqTreeSdToFuCha(gt1, gt2, gt3)  
Else  
  AmpSum2SdToFuCha = AmpTreeSdToFuCha
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MCha(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
  AmpSqTreeSdToFuCha(gt1, gt2, gt3) = (1)*AmpSqSdToFuCha(gt1, gt2, gt3)  
  AmpSum2SdToFuCha = + 2._dp*AmpWaveSdToFuCha + 2._dp*AmpVertexSdToFuCha
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MCha(gt3),AmpSumSdToFuCha(:,gt1, gt2, gt3),AmpSum2SdToFuCha(:,gt1, gt2, gt3),AmpSqSdToFuCha(gt1, gt2, gt3)) 
  AmpSqSdToFuCha(gt1, gt2, gt3) = AmpSqSdToFuCha(gt1, gt2, gt3) + AmpSqTreeSdToFuCha(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToFuCha(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSdToFuCha(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MFuOS(gt2),MChaOS(gt3),helfactor*AmpSqSdToFuCha(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MFu(gt2),MCha(gt3),helfactor*AmpSqSdToFuCha(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToFuCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFuCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToFuCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFuCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFuCha(gt1, gt2, gt3) + MRGSdToFuCha(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFuCha(gt1, gt2, gt3) + MRGSdToFuCha(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fd Chi
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToFdChi(cplChiFdcSdL,cplChiFdcSdR,MChi,              & 
& MFd,MSd,MChi2,MFd2,MSd2,AmpTreeSdToFdChi)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToFdChi(ZcplChiFdcSdL,ZcplChiFdcSdR,MChi,            & 
& MFd,MSd,MChi2,MFd2,MSd2,AmpTreeSdToFdChi)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFdChi(MLambda,em,gs,cplChiFdcSdL,cplChiFdcSdR,         & 
& MChiOS,MFdOS,MSdOS,MRPSdToFdChi,MRGSdToFdChi)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFdChi(MLambda,em,gs,ZcplChiFdcSdL,ZcplChiFdcSdR,       & 
& MChiOS,MFdOS,MSdOS,MRPSdToFdChi,MRGSdToFdChi)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToFdChi(MLambda,em,gs,cplChiFdcSdL,cplChiFdcSdR,         & 
& MChi,MFd,MSd,MRPSdToFdChi,MRGSdToFdChi)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFdChi(MLambda,em,gs,ZcplChiFdcSdL,ZcplChiFdcSdR,       & 
& MChi,MFd,MSd,MRPSdToFdChi,MRGSdToFdChi)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToFdChi(cplChiFdcSdL,cplChiFdcSdR,ctcplChiFdcSdL,    & 
& ctcplChiFdcSdR,MChi,MChi2,MFd,MFd2,MSd,MSd2,ZfFDL,ZfFDR,ZfL0,ZfSd,AmpWaveSdToFdChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToFdChi(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,   & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,       & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,       & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,        & 
& cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexSdToFdChi)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,           & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,       & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRdrSdToFdChi)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,               & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,ZcplChiFdcSdL,ZcplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,       & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,       & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,       & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,        & 
& cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToFdChi)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,           & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,ZcplChiFdcSdL,ZcplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,       & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,       & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToFdChi)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,               & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,       & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,       & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,        & 
& cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToFdChi)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,           & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,       & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToFdChi)

 End if 
 End if 
AmpVertexSdToFdChi = AmpVertexSdToFdChi -  AmpVertexIRdrSdToFdChi! +  AmpVertexIRosSdToFdChi ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToFdChi=0._dp 
AmpVertexZSdToFdChi=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToFdChi(:,gt2,:,:) = AmpWaveZSdToFdChi(:,gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToFdChi(:,gt1,:,:) 
AmpVertexZSdToFdChi(:,gt2,:,:)= AmpVertexZSdToFdChi(:,gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToFdChi(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToFdChi=AmpWaveZSdToFdChi 
AmpVertexSdToFdChi= AmpVertexZSdToFdChi
! Final State 1 
AmpWaveZSdToFdChi=0._dp 
AmpVertexZSdToFdChi=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToFdChi(1,:,gt2,:) = AmpWaveZSdToFdChi(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpWaveSdToFdChi(1,:,gt1,:) 
AmpVertexZSdToFdChi(1,:,gt2,:)= AmpVertexZSdToFdChi(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpVertexSdToFdChi(1,:,gt1,:) 
AmpWaveZSdToFdChi(2,:,gt2,:) = AmpWaveZSdToFdChi(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpWaveSdToFdChi(2,:,gt1,:) 
AmpVertexZSdToFdChi(2,:,gt2,:)= AmpVertexZSdToFdChi(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpVertexSdToFdChi(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToFdChi=AmpWaveZSdToFdChi 
AmpVertexSdToFdChi= AmpVertexZSdToFdChi
! Final State 2 
AmpWaveZSdToFdChi=0._dp 
AmpVertexZSdToFdChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZSdToFdChi(1,:,:,gt2) = AmpWaveZSdToFdChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSdToFdChi(1,:,:,gt1) 
AmpVertexZSdToFdChi(1,:,:,gt2)= AmpVertexZSdToFdChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSdToFdChi(1,:,:,gt1) 
AmpWaveZSdToFdChi(2,:,:,gt2) = AmpWaveZSdToFdChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSdToFdChi(2,:,:,gt1) 
AmpVertexZSdToFdChi(2,:,:,gt2)= AmpVertexZSdToFdChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSdToFdChi(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToFdChi=AmpWaveZSdToFdChi 
AmpVertexSdToFdChi= AmpVertexZSdToFdChi
End if
If (ShiftIRdiv) Then 
AmpVertexSdToFdChi = AmpVertexSdToFdChi  +  AmpVertexIRosSdToFdChi
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Fd Chi -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToFdChi = AmpTreeSdToFdChi 
 AmpSum2SdToFdChi = AmpTreeSdToFdChi + 2._dp*AmpWaveSdToFdChi + 2._dp*AmpVertexSdToFdChi  
Else 
 AmpSumSdToFdChi = AmpTreeSdToFdChi + AmpWaveSdToFdChi + AmpVertexSdToFdChi
 AmpSum2SdToFdChi = AmpTreeSdToFdChi + AmpWaveSdToFdChi + AmpVertexSdToFdChi 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToFdChi = AmpTreeSdToFdChi
 AmpSum2SdToFdChi = AmpTreeSdToFdChi 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,4
If (((OSkinematics).and.(MSdOS(gt1).gt.(MFdOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MFd(gt2)+MChi(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToFdChi = AmpTreeSdToFdChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFd(gt2),MChi(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToFdChi(gt1, gt2, gt3) 
  AmpSum2SdToFdChi = 2._dp*AmpWaveSdToFdChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFd(gt2),MChi(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToFdChi(gt1, gt2, gt3) 
  AmpSum2SdToFdChi = 2._dp*AmpVertexSdToFdChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFd(gt2),MChi(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToFdChi(gt1, gt2, gt3) 
  AmpSum2SdToFdChi = AmpTreeSdToFdChi + 2._dp*AmpWaveSdToFdChi + 2._dp*AmpVertexSdToFdChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFd(gt2),MChi(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToFdChi(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToFdChi = AmpTreeSdToFdChi
  Call SquareAmp_StoFF(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
  AmpSqTreeSdToFdChi(gt1, gt2, gt3) = (1)*AmpSqSdToFdChi(gt1, gt2, gt3)  
  AmpSum2SdToFdChi = + 2._dp*AmpWaveSdToFdChi + 2._dp*AmpVertexSdToFdChi
  Call SquareAmp_StoFF(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
  AmpSqSdToFdChi(gt1, gt2, gt3) = AmpSqSdToFdChi(gt1, gt2, gt3) + AmpSqTreeSdToFdChi(gt1, gt2, gt3)  
Else  
  AmpSum2SdToFdChi = AmpTreeSdToFdChi
  Call SquareAmp_StoFF(MSd(gt1),MFd(gt2),MChi(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
  AmpSqTreeSdToFdChi(gt1, gt2, gt3) = (1)*AmpSqSdToFdChi(gt1, gt2, gt3)  
  AmpSum2SdToFdChi = + 2._dp*AmpWaveSdToFdChi + 2._dp*AmpVertexSdToFdChi
  Call SquareAmp_StoFF(MSd(gt1),MFd(gt2),MChi(gt3),AmpSumSdToFdChi(:,gt1, gt2, gt3),AmpSum2SdToFdChi(:,gt1, gt2, gt3),AmpSqSdToFdChi(gt1, gt2, gt3)) 
  AmpSqSdToFdChi(gt1, gt2, gt3) = AmpSqSdToFdChi(gt1, gt2, gt3) + AmpSqTreeSdToFdChi(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToFdChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSdToFdChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MFdOS(gt2),MChiOS(gt3),helfactor*AmpSqSdToFdChi(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MFd(gt2),MChi(gt3),helfactor*AmpSqSdToFdChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToFdChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFdChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToFdChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFdChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFdChi(gt1, gt2, gt3) + MRGSdToFdChi(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFdChi(gt1, gt2, gt3) + MRGSdToFdChi(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fv Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToFvFd(cplFvFdcSdL,cplFvFdcSdR,MFd,MSd,              & 
& MFd2,MSd2,AmpTreeSdToFvFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToFvFd(ZcplFvFdcSdL,ZcplFvFdcSdR,MFd,MSd,            & 
& MFd2,MSd2,AmpTreeSdToFvFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFvFd(MLambda,em,gs,cplFvFdcSdL,cplFvFdcSdR,            & 
& MFdOS,MSdOS,MRPSdToFvFd,MRGSdToFvFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFvFd(MLambda,em,gs,ZcplFvFdcSdL,ZcplFvFdcSdR,          & 
& MFdOS,MSdOS,MRPSdToFvFd,MRGSdToFvFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToFvFd(MLambda,em,gs,cplFvFdcSdL,cplFvFdcSdR,            & 
& MFd,MSd,MRPSdToFvFd,MRGSdToFvFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFvFd(MLambda,em,gs,ZcplFvFdcSdL,ZcplFvFdcSdR,          & 
& MFd,MSd,MRPSdToFvFd,MRGSdToFvFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToFvFd(cplFvFdcSdL,cplFvFdcSdR,ctcplFvFdcSdL,        & 
& ctcplFvFdcSdR,MFd,MFd2,MSd,MSd2,ZfFDL,ZfFDR,ZfFvL,ZfSd,AmpWaveSdToFvFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToFvFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplChiFdcSdL,           & 
& cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,            & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,           & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,              & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexSdToFvFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,            & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,              & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,        & 
& AmpVertexIRdrSdToFvFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,      & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,ZcplFvFdcSdL,ZcplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,             & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToFvFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,            & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& ZcplFvFdcSdL,ZcplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,              & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,        & 
& AmpVertexIRosSdToFvFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,      & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,             & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,             & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToFvFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,            & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,              & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,        & 
& AmpVertexIRosSdToFvFd)

 End if 
 End if 
AmpVertexSdToFvFd = AmpVertexSdToFvFd -  AmpVertexIRdrSdToFvFd! +  AmpVertexIRosSdToFvFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToFvFd=0._dp 
AmpVertexZSdToFvFd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToFvFd(:,gt2,:,:) = AmpWaveZSdToFvFd(:,gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToFvFd(:,gt1,:,:) 
AmpVertexZSdToFvFd(:,gt2,:,:)= AmpVertexZSdToFvFd(:,gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToFvFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToFvFd=AmpWaveZSdToFvFd 
AmpVertexSdToFvFd= AmpVertexZSdToFvFd
! Final State 1 
AmpWaveZSdToFvFd=0._dp 
AmpVertexZSdToFvFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToFvFd(1,:,gt2,:) = AmpWaveZSdToFvFd(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpWaveSdToFvFd(1,:,gt1,:) 
AmpVertexZSdToFvFd(1,:,gt2,:)= AmpVertexZSdToFvFd(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpVertexSdToFvFd(1,:,gt1,:) 
AmpWaveZSdToFvFd(2,:,gt2,:) = AmpWaveZSdToFvFd(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpWaveSdToFvFd(2,:,gt1,:) 
AmpVertexZSdToFvFd(2,:,gt2,:)= AmpVertexZSdToFvFd(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpVertexSdToFvFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToFvFd=AmpWaveZSdToFvFd 
AmpVertexSdToFvFd= AmpVertexZSdToFvFd
! Final State 2 
AmpWaveZSdToFvFd=0._dp 
AmpVertexZSdToFvFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToFvFd(1,:,:,gt2) = AmpWaveZSdToFvFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveSdToFvFd(1,:,:,gt1) 
AmpVertexZSdToFvFd(1,:,:,gt2)= AmpVertexZSdToFvFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexSdToFvFd(1,:,:,gt1) 
AmpWaveZSdToFvFd(2,:,:,gt2) = AmpWaveZSdToFvFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveSdToFvFd(2,:,:,gt1) 
AmpVertexZSdToFvFd(2,:,:,gt2)= AmpVertexZSdToFvFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexSdToFvFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToFvFd=AmpWaveZSdToFvFd 
AmpVertexSdToFvFd= AmpVertexZSdToFvFd
End if
If (ShiftIRdiv) Then 
AmpVertexSdToFvFd = AmpVertexSdToFvFd  +  AmpVertexIRosSdToFvFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Fv Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToFvFd = AmpTreeSdToFvFd 
 AmpSum2SdToFvFd = AmpTreeSdToFvFd + 2._dp*AmpWaveSdToFvFd + 2._dp*AmpVertexSdToFvFd  
Else 
 AmpSumSdToFvFd = AmpTreeSdToFvFd + AmpWaveSdToFvFd + AmpVertexSdToFvFd
 AmpSum2SdToFvFd = AmpTreeSdToFvFd + AmpWaveSdToFvFd + AmpVertexSdToFvFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToFvFd = AmpTreeSdToFvFd
 AmpSum2SdToFvFd = AmpTreeSdToFvFd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSdOS(gt1).gt.(0.+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(0.+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToFvFd = AmpTreeSdToFvFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),0._dp,MFdOS(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),0._dp,MFd(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToFvFd(gt1, gt2, gt3) 
  AmpSum2SdToFvFd = 2._dp*AmpWaveSdToFvFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),0._dp,MFdOS(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),0._dp,MFd(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToFvFd(gt1, gt2, gt3) 
  AmpSum2SdToFvFd = 2._dp*AmpVertexSdToFvFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),0._dp,MFdOS(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),0._dp,MFd(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToFvFd(gt1, gt2, gt3) 
  AmpSum2SdToFvFd = AmpTreeSdToFvFd + 2._dp*AmpWaveSdToFvFd + 2._dp*AmpVertexSdToFvFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),0._dp,MFdOS(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),0._dp,MFd(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToFvFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToFvFd = AmpTreeSdToFvFd
  Call SquareAmp_StoFF(MSdOS(gt1),0._dp,MFdOS(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
  AmpSqTreeSdToFvFd(gt1, gt2, gt3) = (1)*AmpSqSdToFvFd(gt1, gt2, gt3)  
  AmpSum2SdToFvFd = + 2._dp*AmpWaveSdToFvFd + 2._dp*AmpVertexSdToFvFd
  Call SquareAmp_StoFF(MSdOS(gt1),0._dp,MFdOS(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
  AmpSqSdToFvFd(gt1, gt2, gt3) = AmpSqSdToFvFd(gt1, gt2, gt3) + AmpSqTreeSdToFvFd(gt1, gt2, gt3)  
Else  
  AmpSum2SdToFvFd = AmpTreeSdToFvFd
  Call SquareAmp_StoFF(MSd(gt1),0._dp,MFd(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
  AmpSqTreeSdToFvFd(gt1, gt2, gt3) = (1)*AmpSqSdToFvFd(gt1, gt2, gt3)  
  AmpSum2SdToFvFd = + 2._dp*AmpWaveSdToFvFd + 2._dp*AmpVertexSdToFvFd
  Call SquareAmp_StoFF(MSd(gt1),0._dp,MFd(gt3),AmpSumSdToFvFd(:,gt1, gt2, gt3),AmpSum2SdToFvFd(:,gt1, gt2, gt3),AmpSqSdToFvFd(gt1, gt2, gt3)) 
  AmpSqSdToFvFd(gt1, gt2, gt3) = AmpSqSdToFvFd(gt1, gt2, gt3) + AmpSqTreeSdToFvFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToFvFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSdToFvFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),0._dp,MFdOS(gt3),helfactor*AmpSqSdToFvFd(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),0._dp,MFd(gt3),helfactor*AmpSqSdToFvFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToFvFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFvFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToFvFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFvFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFvFd(gt1, gt2, gt3) + MRGSdToFvFd(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFvFd(gt1, gt2, gt3) + MRGSdToFvFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Glu Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToGluFd(cplGluFdcSdL,cplGluFdcSdR,MFd,               & 
& MGlu,MSd,MFd2,MGlu2,MSd2,AmpTreeSdToGluFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToGluFd(ZcplGluFdcSdL,ZcplGluFdcSdR,MFd,             & 
& MGlu,MSd,MFd2,MGlu2,MSd2,AmpTreeSdToGluFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToGluFd(MLambda,em,gs,cplGluFdcSdL,cplGluFdcSdR,         & 
& MFdOS,MGluOS,MSdOS,MRPSdToGluFd,MRGSdToGluFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToGluFd(MLambda,em,gs,ZcplGluFdcSdL,ZcplGluFdcSdR,       & 
& MFdOS,MGluOS,MSdOS,MRPSdToGluFd,MRGSdToGluFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToGluFd(MLambda,em,gs,cplGluFdcSdL,cplGluFdcSdR,         & 
& MFd,MGlu,MSd,MRPSdToGluFd,MRGSdToGluFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToGluFd(MLambda,em,gs,ZcplGluFdcSdL,ZcplGluFdcSdR,       & 
& MFd,MGlu,MSd,MRPSdToGluFd,MRGSdToGluFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToGluFd(cplGluFdcSdL,cplGluFdcSdR,ctcplGluFdcSdL,    & 
& ctcplGluFdcSdR,MFd,MFd2,MGlu,MGlu2,MSd,MSd2,ZfFDL,ZfFDR,ZffG,ZfSd,AmpWaveSdToGluFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToGluFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSucSdVWm,AmpVertexSdToGluFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSeSucSd,cplSucSdVWm,AmpVertexIRdrSdToGluFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& AmpVertexIRosSdToGluFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToGluFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& AmpVertexIRosSdToGluFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSeSucSd,cplSucSdVWm,AmpVertexIRosSdToGluFd)

 End if 
 End if 
AmpVertexSdToGluFd = AmpVertexSdToGluFd -  AmpVertexIRdrSdToGluFd! +  AmpVertexIRosSdToGluFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToGluFd=0._dp 
AmpVertexZSdToGluFd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToGluFd(:,gt2,:) = AmpWaveZSdToGluFd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToGluFd(:,gt1,:) 
AmpVertexZSdToGluFd(:,gt2,:)= AmpVertexZSdToGluFd(:,gt2,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToGluFd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToGluFd=AmpWaveZSdToGluFd 
AmpVertexSdToGluFd= AmpVertexZSdToGluFd
! Final State 2 
AmpWaveZSdToGluFd=0._dp 
AmpVertexZSdToGluFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToGluFd(1,:,gt2) = AmpWaveZSdToGluFd(1,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveSdToGluFd(1,:,gt1) 
AmpVertexZSdToGluFd(1,:,gt2)= AmpVertexZSdToGluFd(1,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexSdToGluFd(1,:,gt1) 
AmpWaveZSdToGluFd(2,:,gt2) = AmpWaveZSdToGluFd(2,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveSdToGluFd(2,:,gt1) 
AmpVertexZSdToGluFd(2,:,gt2)= AmpVertexZSdToGluFd(2,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexSdToGluFd(2,:,gt1) 
 End Do 
End Do 
AmpWaveSdToGluFd=AmpWaveZSdToGluFd 
AmpVertexSdToGluFd= AmpVertexZSdToGluFd
End if
If (ShiftIRdiv) Then 
AmpVertexSdToGluFd = AmpVertexSdToGluFd  +  AmpVertexIRosSdToGluFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Glu Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToGluFd = AmpTreeSdToGluFd 
 AmpSum2SdToGluFd = AmpTreeSdToGluFd + 2._dp*AmpWaveSdToGluFd + 2._dp*AmpVertexSdToGluFd  
Else 
 AmpSumSdToGluFd = AmpTreeSdToGluFd + AmpWaveSdToGluFd + AmpVertexSdToGluFd
 AmpSum2SdToGluFd = AmpTreeSdToGluFd + AmpWaveSdToGluFd + AmpVertexSdToGluFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToGluFd = AmpTreeSdToGluFd
 AmpSum2SdToGluFd = AmpTreeSdToGluFd 
End if 
Do gt1=1,6
i4 = isave 
    Do gt3=1,3
If (((OSkinematics).and.(MSdOS(gt1).gt.(MGluOS+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MGlu+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt3 
  AmpSum2SdToGluFd = AmpTreeSdToGluFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MGluOS,MFdOS(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MGlu,MFd(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToGluFd(gt1, gt3) 
  AmpSum2SdToGluFd = 2._dp*AmpWaveSdToGluFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MGluOS,MFdOS(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MGlu,MFd(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToGluFd(gt1, gt3) 
  AmpSum2SdToGluFd = 2._dp*AmpVertexSdToGluFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MGluOS,MFdOS(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MGlu,MFd(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToGluFd(gt1, gt3) 
  AmpSum2SdToGluFd = AmpTreeSdToGluFd + 2._dp*AmpWaveSdToGluFd + 2._dp*AmpVertexSdToGluFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MGluOS,MFdOS(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MGlu,MFd(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToGluFd(gt1, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToGluFd = AmpTreeSdToGluFd
  Call SquareAmp_StoFF(MSdOS(gt1),MGluOS,MFdOS(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
  AmpSqTreeSdToGluFd(gt1, gt3) = (4._dp/3._dp)*AmpSqSdToGluFd(gt1, gt3)  
  AmpSum2SdToGluFd = + 2._dp*AmpWaveSdToGluFd + 2._dp*AmpVertexSdToGluFd
  Call SquareAmp_StoFF(MSdOS(gt1),MGluOS,MFdOS(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
  AmpSqSdToGluFd(gt1, gt3) = AmpSqSdToGluFd(gt1, gt3) + AmpSqTreeSdToGluFd(gt1, gt3)  
Else  
  AmpSum2SdToGluFd = AmpTreeSdToGluFd
  Call SquareAmp_StoFF(MSd(gt1),MGlu,MFd(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
  AmpSqTreeSdToGluFd(gt1, gt3) = (4._dp/3._dp)*AmpSqSdToGluFd(gt1, gt3)  
  AmpSum2SdToGluFd = + 2._dp*AmpWaveSdToGluFd + 2._dp*AmpVertexSdToGluFd
  Call SquareAmp_StoFF(MSd(gt1),MGlu,MFd(gt3),AmpSumSdToGluFd(:,gt1, gt3),AmpSum2SdToGluFd(:,gt1, gt3),AmpSqSdToGluFd(gt1, gt3)) 
  AmpSqSdToGluFd(gt1, gt3) = AmpSqSdToGluFd(gt1, gt3) + AmpSqTreeSdToGluFd(gt1, gt3)  
End if  
Else  
  AmpSqSdToGluFd(gt1, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSdToGluFd(gt1, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MGluOS,MFdOS(gt3),helfactor*AmpSqSdToGluFd(gt1, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MGlu,MFd(gt3),helfactor*AmpSqSdToGluFd(gt1, gt3))
End if 
If ((Abs(MRPSdToGluFd(gt1, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToGluFd(gt1, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToGluFd(gt1, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToGluFd(gt1, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToGluFd(gt1, gt3) + MRGSdToGluFd(gt1, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToGluFd(gt1, gt3) + MRGSdToGluFd(gt1, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Fu Fe
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToFuFe(cplFeFucSdL,cplFeFucSdR,MFe,MFu,              & 
& MSd,MFe2,MFu2,MSd2,AmpTreeSdToFuFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToFuFe(ZcplFeFucSdL,ZcplFeFucSdR,MFe,MFu,            & 
& MSd,MFe2,MFu2,MSd2,AmpTreeSdToFuFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFuFe(MLambda,em,gs,cplFeFucSdL,cplFeFucSdR,            & 
& MFeOS,MFuOS,MSdOS,MRPSdToFuFe,MRGSdToFuFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFuFe(MLambda,em,gs,ZcplFeFucSdL,ZcplFeFucSdR,          & 
& MFeOS,MFuOS,MSdOS,MRPSdToFuFe,MRGSdToFuFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToFuFe(MLambda,em,gs,cplFeFucSdL,cplFeFucSdR,            & 
& MFe,MFu,MSd,MRPSdToFuFe,MRGSdToFuFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToFuFe(MLambda,em,gs,ZcplFeFucSdL,ZcplFeFucSdR,          & 
& MFe,MFu,MSd,MRPSdToFuFe,MRGSdToFuFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToFuFe(cplFeFucSdL,cplFeFucSdR,ctcplFeFucSdL,        & 
& ctcplFeFucSdR,MFe,MFe2,MFu,MFu2,MSd,MSd2,ZfFEL,ZfFER,ZfFUL,ZfFUR,ZfSd,AmpWaveSdToFuFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToFuFe(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,             & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,           & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSdcSd,              & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,AmpVertexSdToFuFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,             & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,           & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,         & 
& AmpVertexIRdrSdToFuFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,ZcplFeFucSdL,ZcplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSdcSd,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,AmpVertexIRosSdToFuFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,ZcplFeFucSdL,ZcplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,           & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,         & 
& AmpVertexIRosSdToFuFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,     & 
& cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSdcSd,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,AmpVertexIRosSdToFuFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,             & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,           & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,         & 
& AmpVertexIRosSdToFuFe)

 End if 
 End if 
AmpVertexSdToFuFe = AmpVertexSdToFuFe -  AmpVertexIRdrSdToFuFe! +  AmpVertexIRosSdToFuFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToFuFe=0._dp 
AmpVertexZSdToFuFe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToFuFe(:,gt2,:,:) = AmpWaveZSdToFuFe(:,gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToFuFe(:,gt1,:,:) 
AmpVertexZSdToFuFe(:,gt2,:,:)= AmpVertexZSdToFuFe(:,gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToFuFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToFuFe=AmpWaveZSdToFuFe 
AmpVertexSdToFuFe= AmpVertexZSdToFuFe
! Final State 1 
AmpWaveZSdToFuFe=0._dp 
AmpVertexZSdToFuFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToFuFe(1,:,gt2,:) = AmpWaveZSdToFuFe(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpWaveSdToFuFe(1,:,gt1,:) 
AmpVertexZSdToFuFe(1,:,gt2,:)= AmpVertexZSdToFuFe(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpVertexSdToFuFe(1,:,gt1,:) 
AmpWaveZSdToFuFe(2,:,gt2,:) = AmpWaveZSdToFuFe(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpWaveSdToFuFe(2,:,gt1,:) 
AmpVertexZSdToFuFe(2,:,gt2,:)= AmpVertexZSdToFuFe(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpVertexSdToFuFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToFuFe=AmpWaveZSdToFuFe 
AmpVertexSdToFuFe= AmpVertexZSdToFuFe
! Final State 2 
AmpWaveZSdToFuFe=0._dp 
AmpVertexZSdToFuFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToFuFe(1,:,:,gt2) = AmpWaveZSdToFuFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWaveSdToFuFe(1,:,:,gt1) 
AmpVertexZSdToFuFe(1,:,:,gt2)= AmpVertexZSdToFuFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexSdToFuFe(1,:,:,gt1) 
AmpWaveZSdToFuFe(2,:,:,gt2) = AmpWaveZSdToFuFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWaveSdToFuFe(2,:,:,gt1) 
AmpVertexZSdToFuFe(2,:,:,gt2)= AmpVertexZSdToFuFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexSdToFuFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToFuFe=AmpWaveZSdToFuFe 
AmpVertexSdToFuFe= AmpVertexZSdToFuFe
End if
If (ShiftIRdiv) Then 
AmpVertexSdToFuFe = AmpVertexSdToFuFe  +  AmpVertexIRosSdToFuFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Fu Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToFuFe = AmpTreeSdToFuFe 
 AmpSum2SdToFuFe = AmpTreeSdToFuFe + 2._dp*AmpWaveSdToFuFe + 2._dp*AmpVertexSdToFuFe  
Else 
 AmpSumSdToFuFe = AmpTreeSdToFuFe + AmpWaveSdToFuFe + AmpVertexSdToFuFe
 AmpSum2SdToFuFe = AmpTreeSdToFuFe + AmpWaveSdToFuFe + AmpVertexSdToFuFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToFuFe = AmpTreeSdToFuFe
 AmpSum2SdToFuFe = AmpTreeSdToFuFe 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSdOS(gt1).gt.(MFuOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MFu(gt2)+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToFuFe = AmpTreeSdToFuFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MFe(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToFuFe(gt1, gt2, gt3) 
  AmpSum2SdToFuFe = 2._dp*AmpWaveSdToFuFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MFe(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToFuFe(gt1, gt2, gt3) 
  AmpSum2SdToFuFe = 2._dp*AmpVertexSdToFuFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MFe(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToFuFe(gt1, gt2, gt3) 
  AmpSum2SdToFuFe = AmpTreeSdToFuFe + 2._dp*AmpWaveSdToFuFe + 2._dp*AmpVertexSdToFuFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MFe(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToFuFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToFuFe = AmpTreeSdToFuFe
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
  AmpSqTreeSdToFuFe(gt1, gt2, gt3) = (1)*AmpSqSdToFuFe(gt1, gt2, gt3)  
  AmpSum2SdToFuFe = + 2._dp*AmpWaveSdToFuFe + 2._dp*AmpVertexSdToFuFe
  Call SquareAmp_StoFF(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
  AmpSqSdToFuFe(gt1, gt2, gt3) = AmpSqSdToFuFe(gt1, gt2, gt3) + AmpSqTreeSdToFuFe(gt1, gt2, gt3)  
Else  
  AmpSum2SdToFuFe = AmpTreeSdToFuFe
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MFe(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
  AmpSqTreeSdToFuFe(gt1, gt2, gt3) = (1)*AmpSqSdToFuFe(gt1, gt2, gt3)  
  AmpSum2SdToFuFe = + 2._dp*AmpWaveSdToFuFe + 2._dp*AmpVertexSdToFuFe
  Call SquareAmp_StoFF(MSd(gt1),MFu(gt2),MFe(gt3),AmpSumSdToFuFe(:,gt1, gt2, gt3),AmpSum2SdToFuFe(:,gt1, gt2, gt3),AmpSqSdToFuFe(gt1, gt2, gt3)) 
  AmpSqSdToFuFe(gt1, gt2, gt3) = AmpSqSdToFuFe(gt1, gt2, gt3) + AmpSqTreeSdToFuFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToFuFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSdToFuFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MFuOS(gt2),MFeOS(gt3),helfactor*AmpSqSdToFuFe(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MFu(gt2),MFe(gt3),helfactor*AmpSqSdToFuFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToFuFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFuFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToFuFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToFuFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFuFe(gt1, gt2, gt3) + MRGSdToFuFe(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToFuFe(gt1, gt2, gt3) + MRGSdToFuFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Sd hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSdhh(cplhhSdcSd,Mhh,MSd,Mhh2,MSd2,AmpTreeSdToSdhh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSdhh(ZcplhhSdcSd,Mhh,MSd,Mhh2,MSd2,AmpTreeSdToSdhh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdhh(MLambda,em,gs,cplhhSdcSd,MhhOS,MSdOS,             & 
& MRPSdToSdhh,MRGSdToSdhh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdhh(MLambda,em,gs,ZcplhhSdcSd,MhhOS,MSdOS,            & 
& MRPSdToSdhh,MRGSdToSdhh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSdhh(MLambda,em,gs,cplhhSdcSd,Mhh,MSd,MRPSdToSdhh,     & 
& MRGSdToSdhh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdhh(MLambda,em,gs,ZcplhhSdcSd,Mhh,MSd,MRPSdToSdhh,    & 
& MRGSdToSdhh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdhh(cplhhSdcSd,ctcplhhSdcSd,Mhh,Mhh2,             & 
& MSd,MSd2,Zfhh,ZfSd,AmpWaveSdToSdhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdhh(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,         & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,         & 
& cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFvSdL,               & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,             & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,   & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,cplhhSdSvcSdaa,   & 
& cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSdcHpmcSdaa,     & 
& cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,& 
& cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexSdToSdhh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,       & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,     & 
& cplhhSdSvcSdaa,cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,        & 
& cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,& 
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRdrSdToSdhh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhSdcSd,          & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFeFucSdL,cplFeFucSdR,             & 
& cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,ZcplhhSdcSd,             & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,      & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,               & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,cplhhSdSvcSdaa,   & 
& cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSdcHpmcSdaa,     & 
& cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,& 
& cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRosSdToSdhh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,ZcplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,   & 
& cplhhVZVZ,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,       & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,     & 
& cplhhSdSvcSdaa,cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,        & 
& cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,& 
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRosSdToSdhh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhSdcSd,          & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFeFucSdL,cplFeFucSdR,             & 
& cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,              & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,      & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,               & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,cplhhSdSvcSdaa,   & 
& cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSdcHpmcSdaa,     & 
& cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,& 
& cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRosSdToSdhh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,       & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,     & 
& cplhhSdSvcSdaa,cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,        & 
& cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,& 
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRosSdToSdhh)

 End if 
 End if 
AmpVertexSdToSdhh = AmpVertexSdToSdhh -  AmpVertexIRdrSdToSdhh! +  AmpVertexIRosSdToSdhh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSdhh=0._dp 
AmpVertexZSdToSdhh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSdhh(gt2,:,:) = AmpWaveZSdToSdhh(gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSdhh(gt1,:,:) 
AmpVertexZSdToSdhh(gt2,:,:)= AmpVertexZSdToSdhh(gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSdhh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToSdhh=AmpWaveZSdToSdhh 
AmpVertexSdToSdhh= AmpVertexZSdToSdhh
! Final State 1 
AmpWaveZSdToSdhh=0._dp 
AmpVertexZSdToSdhh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSdhh(:,gt2,:) = AmpWaveZSdToSdhh(:,gt2,:)+ZRUZD(gt2,gt1)*AmpWaveSdToSdhh(:,gt1,:) 
AmpVertexZSdToSdhh(:,gt2,:)= AmpVertexZSdToSdhh(:,gt2,:)+ZRUZD(gt2,gt1)*AmpVertexSdToSdhh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSdhh=AmpWaveZSdToSdhh 
AmpVertexSdToSdhh= AmpVertexZSdToSdhh
! Final State 2 
AmpWaveZSdToSdhh=0._dp 
AmpVertexZSdToSdhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSdToSdhh(:,:,gt2) = AmpWaveZSdToSdhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveSdToSdhh(:,:,gt1) 
AmpVertexZSdToSdhh(:,:,gt2)= AmpVertexZSdToSdhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexSdToSdhh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSdhh=AmpWaveZSdToSdhh 
AmpVertexSdToSdhh= AmpVertexZSdToSdhh
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSdhh = AmpVertexSdToSdhh  +  AmpVertexIRosSdToSdhh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Sd hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSdhh = AmpTreeSdToSdhh 
 AmpSum2SdToSdhh = AmpTreeSdToSdhh + 2._dp*AmpWaveSdToSdhh + 2._dp*AmpVertexSdToSdhh  
Else 
 AmpSumSdToSdhh = AmpTreeSdToSdhh + AmpWaveSdToSdhh + AmpVertexSdToSdhh
 AmpSum2SdToSdhh = AmpTreeSdToSdhh + AmpWaveSdToSdhh + AmpVertexSdToSdhh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSdhh = AmpTreeSdToSdhh
 AmpSum2SdToSdhh = AmpTreeSdToSdhh 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,2
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSdOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSd(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToSdhh = AmpTreeSdToSdhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),Mhh(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSdhh(gt1, gt2, gt3) 
  AmpSum2SdToSdhh = 2._dp*AmpWaveSdToSdhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),Mhh(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSdhh(gt1, gt2, gt3) 
  AmpSum2SdToSdhh = 2._dp*AmpVertexSdToSdhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),Mhh(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSdhh(gt1, gt2, gt3) 
  AmpSum2SdToSdhh = AmpTreeSdToSdhh + 2._dp*AmpWaveSdToSdhh + 2._dp*AmpVertexSdToSdhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),Mhh(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSdhh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSdhh = AmpTreeSdToSdhh
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
  AmpSqTreeSdToSdhh(gt1, gt2, gt3) = (1)*AmpSqSdToSdhh(gt1, gt2, gt3)  
  AmpSum2SdToSdhh = + 2._dp*AmpWaveSdToSdhh + 2._dp*AmpVertexSdToSdhh
  Call SquareAmp_StoSS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
  AmpSqSdToSdhh(gt1, gt2, gt3) = AmpSqSdToSdhh(gt1, gt2, gt3) + AmpSqTreeSdToSdhh(gt1, gt2, gt3)  
Else  
  AmpSum2SdToSdhh = AmpTreeSdToSdhh
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),Mhh(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
  AmpSqTreeSdToSdhh(gt1, gt2, gt3) = (1)*AmpSqSdToSdhh(gt1, gt2, gt3)  
  AmpSum2SdToSdhh = + 2._dp*AmpWaveSdToSdhh + 2._dp*AmpVertexSdToSdhh
  Call SquareAmp_StoSS(MSd(gt1),MSd(gt2),Mhh(gt3),AmpSumSdToSdhh(gt1, gt2, gt3),AmpSum2SdToSdhh(gt1, gt2, gt3),AmpSqSdToSdhh(gt1, gt2, gt3)) 
  AmpSqSdToSdhh(gt1, gt2, gt3) = AmpSqSdToSdhh(gt1, gt2, gt3) + AmpSqTreeSdToSdhh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToSdhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSdhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSdOS(gt2),MhhOS(gt3),helfactor*AmpSqSdToSdhh(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSd(gt2),Mhh(gt3),helfactor*AmpSqSdToSdhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToSdhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSdhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSdhh(gt1, gt2, gt3) + MRGSdToSdhh(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSdhh(gt1, gt2, gt3) + MRGSdToSdhh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Su Hpm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSuHpm(cplHpmSucSd,MHpm,MSd,MSu,MHpm2,              & 
& MSd2,MSu2,AmpTreeSdToSuHpm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSuHpm(ZcplHpmSucSd,MHpm,MSd,MSu,MHpm2,             & 
& MSd2,MSu2,AmpTreeSdToSuHpm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuHpm(MLambda,em,gs,cplHpmSucSd,MHpmOS,MSdOS,          & 
& MSuOS,MRPSdToSuHpm,MRGSdToSuHpm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuHpm(MLambda,em,gs,ZcplHpmSucSd,MHpmOS,               & 
& MSdOS,MSuOS,MRPSdToSuHpm,MRGSdToSuHpm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSuHpm(MLambda,em,gs,cplHpmSucSd,MHpm,MSd,              & 
& MSu,MRPSdToSuHpm,MRGSdToSuHpm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuHpm(MLambda,em,gs,ZcplHpmSucSd,MHpm,MSd,             & 
& MSu,MRPSdToSuHpm,MRGSdToSuHpm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSuHpm(cplHpmSucSd,ctcplHpmSucSd,MHpm,              & 
& MHpm2,MSd,MSd2,MSu,MSu2,ZfHpm,ZfSd,ZfSu,AmpWaveSdToSuHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSuHpm(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,             & 
& cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,cplcFuChiSuR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,               & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,             & 
& cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,        & 
& cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,         & 
& cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba, & 
& cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,AmpVertexSdToSuHpm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,           & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,             & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,     & 
& cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,              & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,            & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,         & 
& cplSucSdVWm,cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,              & 
& cplHpmSdcSdcSeaa,cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,   & 
& AmpVertexIRdrSdToSuHpm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,             & 
& cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,cplcFuChiSuR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,ZcplHpmSucSd,cplHpmSvcSe,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,             & 
& cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,        & 
& cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,         & 
& cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba, & 
& cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,AmpVertexIRosSdToSuHpm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,           & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,             & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,     & 
& cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,ZcplHpmSucSd,             & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,            & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,         & 
& cplSucSdVWm,cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,              & 
& cplHpmSdcSdcSeaa,cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,   & 
& AmpVertexIRosSdToSuHpm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,             & 
& cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,cplcFuChiSuR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,               & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,             & 
& cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,        & 
& cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,         & 
& cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba, & 
& cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,AmpVertexIRosSdToSuHpm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,           & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,             & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,     & 
& cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,              & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,            & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,         & 
& cplSucSdVWm,cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,              & 
& cplHpmSdcSdcSeaa,cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,   & 
& AmpVertexIRosSdToSuHpm)

 End if 
 End if 
AmpVertexSdToSuHpm = AmpVertexSdToSuHpm -  AmpVertexIRdrSdToSuHpm! +  AmpVertexIRosSdToSuHpm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSuHpm=0._dp 
AmpVertexZSdToSuHpm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuHpm(gt2,:,:) = AmpWaveZSdToSuHpm(gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSuHpm(gt1,:,:) 
AmpVertexZSdToSuHpm(gt2,:,:)= AmpVertexZSdToSuHpm(gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSuHpm(gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToSuHpm=AmpWaveZSdToSuHpm 
AmpVertexSdToSuHpm= AmpVertexZSdToSuHpm
! Final State 1 
AmpWaveZSdToSuHpm=0._dp 
AmpVertexZSdToSuHpm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuHpm(:,gt2,:) = AmpWaveZSdToSuHpm(:,gt2,:)+ZRUZU(gt2,gt1)*AmpWaveSdToSuHpm(:,gt1,:) 
AmpVertexZSdToSuHpm(:,gt2,:)= AmpVertexZSdToSuHpm(:,gt2,:)+ZRUZU(gt2,gt1)*AmpVertexSdToSuHpm(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSuHpm=AmpWaveZSdToSuHpm 
AmpVertexSdToSuHpm= AmpVertexZSdToSuHpm
! Final State 2 
AmpWaveZSdToSuHpm=0._dp 
AmpVertexZSdToSuHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSdToSuHpm(:,:,gt2) = AmpWaveZSdToSuHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveSdToSuHpm(:,:,gt1) 
AmpVertexZSdToSuHpm(:,:,gt2)= AmpVertexZSdToSuHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexSdToSuHpm(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSuHpm=AmpWaveZSdToSuHpm 
AmpVertexSdToSuHpm= AmpVertexZSdToSuHpm
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSuHpm = AmpVertexSdToSuHpm  +  AmpVertexIRosSdToSuHpm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Su Hpm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSuHpm = AmpTreeSdToSuHpm 
 AmpSum2SdToSuHpm = AmpTreeSdToSuHpm + 2._dp*AmpWaveSdToSuHpm + 2._dp*AmpVertexSdToSuHpm  
Else 
 AmpSumSdToSuHpm = AmpTreeSdToSuHpm + AmpWaveSdToSuHpm + AmpVertexSdToSuHpm
 AmpSum2SdToSuHpm = AmpTreeSdToSuHpm + AmpWaveSdToSuHpm + AmpVertexSdToSuHpm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSuHpm = AmpTreeSdToSuHpm
 AmpSum2SdToSuHpm = AmpTreeSdToSuHpm 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=2,2
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSuOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSu(gt2)+MHpm(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToSuHpm = AmpTreeSdToSuHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MHpm(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSuHpm(gt1, gt2, gt3) 
  AmpSum2SdToSuHpm = 2._dp*AmpWaveSdToSuHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MHpm(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSuHpm(gt1, gt2, gt3) 
  AmpSum2SdToSuHpm = 2._dp*AmpVertexSdToSuHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MHpm(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSuHpm(gt1, gt2, gt3) 
  AmpSum2SdToSuHpm = AmpTreeSdToSuHpm + 2._dp*AmpWaveSdToSuHpm + 2._dp*AmpVertexSdToSuHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MHpm(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSuHpm(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSuHpm = AmpTreeSdToSuHpm
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
  AmpSqTreeSdToSuHpm(gt1, gt2, gt3) = (1)*AmpSqSdToSuHpm(gt1, gt2, gt3)  
  AmpSum2SdToSuHpm = + 2._dp*AmpWaveSdToSuHpm + 2._dp*AmpVertexSdToSuHpm
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
  AmpSqSdToSuHpm(gt1, gt2, gt3) = AmpSqSdToSuHpm(gt1, gt2, gt3) + AmpSqTreeSdToSuHpm(gt1, gt2, gt3)  
Else  
  AmpSum2SdToSuHpm = AmpTreeSdToSuHpm
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MHpm(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
  AmpSqTreeSdToSuHpm(gt1, gt2, gt3) = (1)*AmpSqSdToSuHpm(gt1, gt2, gt3)  
  AmpSum2SdToSuHpm = + 2._dp*AmpWaveSdToSuHpm + 2._dp*AmpVertexSdToSuHpm
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MHpm(gt3),AmpSumSdToSuHpm(gt1, gt2, gt3),AmpSum2SdToSuHpm(gt1, gt2, gt3),AmpSqSdToSuHpm(gt1, gt2, gt3)) 
  AmpSqSdToSuHpm(gt1, gt2, gt3) = AmpSqSdToSuHpm(gt1, gt2, gt3) + AmpSqTreeSdToSuHpm(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToSuHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSuHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSuOS(gt2),MHpmOS(gt3),helfactor*AmpSqSdToSuHpm(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSu(gt2),MHpm(gt3),helfactor*AmpSqSdToSuHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToSuHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSuHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSuHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSuHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSuHpm(gt1, gt2, gt3) + MRGSdToSuHpm(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSuHpm(gt1, gt2, gt3) + MRGSdToSuHpm(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Sv Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSvSd(cplSdSvcSd,MSd,MSv,MSd2,MSv2,AmpTreeSdToSvSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSvSd(ZcplSdSvcSd,MSd,MSv,MSd2,MSv2,AmpTreeSdToSvSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSvSd(MLambda,em,gs,cplSdSvcSd,MSdOS,MSvOS,             & 
& MRPSdToSvSd,MRGSdToSvSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSvSd(MLambda,em,gs,ZcplSdSvcSd,MSdOS,MSvOS,            & 
& MRPSdToSvSd,MRGSdToSvSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSvSd(MLambda,em,gs,cplSdSvcSd,MSd,MSv,MRPSdToSvSd,     & 
& MRGSdToSvSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSvSd(MLambda,em,gs,ZcplSdSvcSd,MSd,MSv,MRPSdToSvSd,    & 
& MRGSdToSvSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSvSd(cplSdSvcSd,ctcplSdSvcSd,MSd,MSd2,             & 
& MSv,MSv2,ZfSd,ZfSv,AmpWaveSdToSvSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSvSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplcFeChaSvL,     & 
& cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplcFdChiSdL,           & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFvSdL,               & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,               & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,   & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,cplhhSdSvcSdaa,            & 
& cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,cplSdSecSdcSeaa,  & 
& cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,AmpVertexSdToSvSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,     & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,              & 
& cplhhSdSvcSdaa,cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,   & 
& cplSdSecSdcSeaa,cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,AmpVertexIRdrSdToSvSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,    & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplcFdChiSdL,cplcFdChiSdR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,               & 
& ZcplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,              & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,cplhhSdSvcSdaa,            & 
& cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,cplSdSecSdcSeaa,  & 
& cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,AmpVertexIRosSdToSvSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplHpmSvcSe,ZcplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,    & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,              & 
& cplhhSdSvcSdaa,cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,   & 
& cplSdSecSdcSeaa,cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,AmpVertexIRosSdToSvSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,    & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplcFdChiSdL,cplcFdChiSdR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,               & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,               & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,cplhhSdSvcSdaa,            & 
& cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,cplSdSecSdcSeaa,  & 
& cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,AmpVertexIRosSdToSvSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,     & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,              & 
& cplhhSdSvcSdaa,cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,   & 
& cplSdSecSdcSeaa,cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,AmpVertexIRosSdToSvSd)

 End if 
 End if 
AmpVertexSdToSvSd = AmpVertexSdToSvSd -  AmpVertexIRdrSdToSvSd! +  AmpVertexIRosSdToSvSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSvSd=0._dp 
AmpVertexZSdToSvSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSvSd(gt2,:,:) = AmpWaveZSdToSvSd(gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSvSd(gt1,:,:) 
AmpVertexZSdToSvSd(gt2,:,:)= AmpVertexZSdToSvSd(gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSvSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToSvSd=AmpWaveZSdToSvSd 
AmpVertexSdToSvSd= AmpVertexZSdToSvSd
! Final State 1 
AmpWaveZSdToSvSd=0._dp 
AmpVertexZSdToSvSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdToSvSd(:,gt2,:) = AmpWaveZSdToSvSd(:,gt2,:)+ZRUZV(gt2,gt1)*AmpWaveSdToSvSd(:,gt1,:) 
AmpVertexZSdToSvSd(:,gt2,:)= AmpVertexZSdToSvSd(:,gt2,:)+ZRUZV(gt2,gt1)*AmpVertexSdToSvSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSvSd=AmpWaveZSdToSvSd 
AmpVertexSdToSvSd= AmpVertexZSdToSvSd
! Final State 2 
AmpWaveZSdToSvSd=0._dp 
AmpVertexZSdToSvSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSvSd(:,:,gt2) = AmpWaveZSdToSvSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSdToSvSd(:,:,gt1) 
AmpVertexZSdToSvSd(:,:,gt2)= AmpVertexZSdToSvSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSdToSvSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSvSd=AmpWaveZSdToSvSd 
AmpVertexSdToSvSd= AmpVertexZSdToSvSd
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSvSd = AmpVertexSdToSvSd  +  AmpVertexIRosSdToSvSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Sv Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSvSd = AmpTreeSdToSvSd 
 AmpSum2SdToSvSd = AmpTreeSdToSvSd + 2._dp*AmpWaveSdToSvSd + 2._dp*AmpVertexSdToSvSd  
Else 
 AmpSumSdToSvSd = AmpTreeSdToSvSd + AmpWaveSdToSvSd + AmpVertexSdToSvSd
 AmpSum2SdToSvSd = AmpTreeSdToSvSd + AmpWaveSdToSvSd + AmpVertexSdToSvSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSvSd = AmpTreeSdToSvSd
 AmpSum2SdToSvSd = AmpTreeSdToSvSd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSvOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSv(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToSvSd = AmpTreeSdToSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSvSd(gt1, gt2, gt3) 
  AmpSum2SdToSvSd = 2._dp*AmpWaveSdToSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSvSd(gt1, gt2, gt3) 
  AmpSum2SdToSvSd = 2._dp*AmpVertexSdToSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSvSd(gt1, gt2, gt3) 
  AmpSum2SdToSvSd = AmpTreeSdToSvSd + 2._dp*AmpWaveSdToSvSd + 2._dp*AmpVertexSdToSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSvSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSvSd = AmpTreeSdToSvSd
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
  AmpSqTreeSdToSvSd(gt1, gt2, gt3) = (1)*AmpSqSdToSvSd(gt1, gt2, gt3)  
  AmpSum2SdToSvSd = + 2._dp*AmpWaveSdToSvSd + 2._dp*AmpVertexSdToSvSd
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
  AmpSqSdToSvSd(gt1, gt2, gt3) = AmpSqSdToSvSd(gt1, gt2, gt3) + AmpSqTreeSdToSvSd(gt1, gt2, gt3)  
Else  
  AmpSum2SdToSvSd = AmpTreeSdToSvSd
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
  AmpSqTreeSdToSvSd(gt1, gt2, gt3) = (1)*AmpSqSdToSvSd(gt1, gt2, gt3)  
  AmpSum2SdToSvSd = + 2._dp*AmpWaveSdToSvSd + 2._dp*AmpVertexSdToSvSd
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdToSvSd(gt1, gt2, gt3),AmpSum2SdToSvSd(gt1, gt2, gt3),AmpSqSdToSvSd(gt1, gt2, gt3)) 
  AmpSqSdToSvSd(gt1, gt2, gt3) = AmpSqSdToSvSd(gt1, gt2, gt3) + AmpSqTreeSdToSvSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToSvSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSvSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),helfactor*AmpSqSdToSvSd(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSv(gt2),MSd(gt3),helfactor*AmpSqSdToSvSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSvSd(gt1, gt2, gt3) + MRGSdToSvSd(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSvSd(gt1, gt2, gt3) + MRGSdToSvSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Sd VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSdVZ(cplSdcSdVZ,MSd,MVZ,MSd2,MVZ2,AmpTreeSdToSdVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSdVZ(ZcplSdcSdVZ,MSd,MVZ,MSd2,MVZ2,AmpTreeSdToSdVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdVZ(MLambda,em,gs,cplSdcSdVZ,MSdOS,MVZOS,             & 
& MRPSdToSdVZ,MRGSdToSdVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdVZ(MLambda,em,gs,ZcplSdcSdVZ,MSdOS,MVZOS,            & 
& MRPSdToSdVZ,MRGSdToSdVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSdVZ(MLambda,em,gs,cplSdcSdVZ,MSd,MVZ,MRPSdToSdVZ,     & 
& MRGSdToSdVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSdVZ(MLambda,em,gs,ZcplSdcSdVZ,MSd,MVZ,MRPSdToSdVZ,    & 
& MRGSdToSdVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVZ(cplSdcSdVP,cplSdcSdVZ,ctcplSdcSdVP,           & 
& ctcplSdcSdVZ,MSd,MSd2,MVP,MVP2,MVZ,MVZ2,ZfSd,ZfVPVZ,ZfVZ,AmpWaveSdToSdVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVZ(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSdcSd,        & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,cplFeFucSdR,             & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,     & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,   & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,  & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,     & 
& cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,               & 
& cplSucSdVWmVZaa,AmpVertexSdToSdVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,              & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,         & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,     & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,    & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,  & 
& cplSucSdVWmVZaa,AmpVertexIRdrSdToSdVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,       & 
& cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,       & 
& cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,              & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,     & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,ZcplSdcSdVZ,cplcChacFuSdL,               & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,  & 
& cplSucSdVWmVZaa,AmpVertexIRosSdToSdVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,              & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,         & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,     & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,    & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,ZcplSdcSdVZ,cplcChacFuSdL,  & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,  & 
& cplSucSdVWmVZaa,AmpVertexIRosSdToSdVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,       & 
& cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,       & 
& cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,              & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,     & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,  & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,     & 
& cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,               & 
& cplSucSdVWmVZaa,AmpVertexIRosSdToSdVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,              & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,         & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,     & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,    & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,  & 
& cplSucSdVWmVZaa,AmpVertexIRosSdToSdVZ)

 End if 
 End if 
AmpVertexSdToSdVZ = AmpVertexSdToSdVZ -  AmpVertexIRdrSdToSdVZ! +  AmpVertexIRosSdToSdVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSdVZ=0._dp 
AmpVertexZSdToSdVZ=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSdVZ(:,gt2,:) = AmpWaveZSdToSdVZ(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSdVZ(:,gt1,:) 
AmpVertexZSdToSdVZ(:,gt2,:)= AmpVertexZSdToSdVZ(:,gt2,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSdVZ(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSdVZ=AmpWaveZSdToSdVZ 
AmpVertexSdToSdVZ= AmpVertexZSdToSdVZ
! Final State 1 
AmpWaveZSdToSdVZ=0._dp 
AmpVertexZSdToSdVZ=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSdVZ(:,:,gt2) = AmpWaveZSdToSdVZ(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSdToSdVZ(:,:,gt1) 
AmpVertexZSdToSdVZ(:,:,gt2)= AmpVertexZSdToSdVZ(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSdToSdVZ(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSdVZ=AmpWaveZSdToSdVZ 
AmpVertexSdToSdVZ= AmpVertexZSdToSdVZ
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSdVZ = AmpVertexSdToSdVZ  +  AmpVertexIRosSdToSdVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Sd VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSdVZ = AmpTreeSdToSdVZ 
 AmpSum2SdToSdVZ = AmpTreeSdToSdVZ + 2._dp*AmpWaveSdToSdVZ + 2._dp*AmpVertexSdToSdVZ  
Else 
 AmpSumSdToSdVZ = AmpTreeSdToSdVZ + AmpWaveSdToSdVZ + AmpVertexSdToSdVZ
 AmpSum2SdToSdVZ = AmpTreeSdToSdVZ + AmpWaveSdToSdVZ + AmpVertexSdToSdVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSdVZ = AmpTreeSdToSdVZ
 AmpSum2SdToSdVZ = AmpTreeSdToSdVZ 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSdOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSd(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SdToSdVZ = AmpTreeSdToSdVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),MVZOS,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVZ,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSdVZ(gt1, gt2) 
  AmpSum2SdToSdVZ = 2._dp*AmpWaveSdToSdVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),MVZOS,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVZ,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSdVZ(gt1, gt2) 
  AmpSum2SdToSdVZ = 2._dp*AmpVertexSdToSdVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),MVZOS,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVZ,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSdVZ(gt1, gt2) 
  AmpSum2SdToSdVZ = AmpTreeSdToSdVZ + 2._dp*AmpWaveSdToSdVZ + 2._dp*AmpVertexSdToSdVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),MVZOS,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVZ,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSdVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSdVZ = AmpTreeSdToSdVZ
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),MVZOS,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
  AmpSqTreeSdToSdVZ(gt1, gt2) = (1)*AmpSqSdToSdVZ(gt1, gt2)  
  AmpSum2SdToSdVZ = + 2._dp*AmpWaveSdToSdVZ + 2._dp*AmpVertexSdToSdVZ
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),MVZOS,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
  AmpSqSdToSdVZ(gt1, gt2) = AmpSqSdToSdVZ(gt1, gt2) + AmpSqTreeSdToSdVZ(gt1, gt2)  
Else  
  AmpSum2SdToSdVZ = AmpTreeSdToSdVZ
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVZ,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
  AmpSqTreeSdToSdVZ(gt1, gt2) = (1)*AmpSqSdToSdVZ(gt1, gt2)  
  AmpSum2SdToSdVZ = + 2._dp*AmpWaveSdToSdVZ + 2._dp*AmpVertexSdToSdVZ
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVZ,AmpSumSdToSdVZ(:,gt1, gt2),AmpSum2SdToSdVZ(:,gt1, gt2),AmpSqSdToSdVZ(gt1, gt2)) 
  AmpSqSdToSdVZ(gt1, gt2) = AmpSqSdToSdVZ(gt1, gt2) + AmpSqTreeSdToSdVZ(gt1, gt2)  
End if  
Else  
  AmpSqSdToSdVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSdVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSdOS(gt2),MVZOS,helfactor*AmpSqSdToSdVZ(gt1, gt2))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSd(gt2),MVZ,helfactor*AmpSqSdToSdVZ(gt1, gt2))
End if 
If ((Abs(MRPSdToSdVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSdVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSdToSdVZ(gt1, gt2) + MRGSdToSdVZ(gt1, gt2)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1*helfactor*(MRPSdToSdVZ(gt1, gt2) + MRGSdToSdVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Conjg(Sv) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdTocSvSd(cplSdcSdcSv,MSd,MSv,MSd2,MSv2,               & 
& AmpTreeSdTocSvSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdTocSvSd(ZcplSdcSdcSv,MSd,MSv,MSd2,MSv2,              & 
& AmpTreeSdTocSvSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdTocSvSd(MLambda,em,gs,cplSdcSdcSv,MSdOS,MSvOS,           & 
& MRPSdTocSvSd,MRGSdTocSvSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdTocSvSd(MLambda,em,gs,ZcplSdcSdcSv,MSdOS,MSvOS,          & 
& MRPSdTocSvSd,MRGSdTocSvSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdTocSvSd(MLambda,em,gs,cplSdcSdcSv,MSd,MSv,               & 
& MRPSdTocSvSd,MRGSdTocSvSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdTocSvSd(MLambda,em,gs,ZcplSdcSdcSv,MSd,MSv,              & 
& MRPSdTocSvSd,MRGSdTocSvSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdTocSvSd(cplSdcSdcSv,ctcplSdcSdcSv,MSd,               & 
& MSd2,MSv,MSv2,ZfSd,ZfSv,AmpWaveSdTocSvSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdTocSvSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplChaFucSdL,     & 
& cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,           & 
& cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,             & 
& cplhhSvcSv,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcFecFuSdL,       & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSecHpmcSv,             & 
& cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,cplhhSdcSdcSvaa,       & 
& cplHpmSdcSdcSeaa,cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa, & 
& cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexSdTocSvSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,             & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,          & 
& cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab, & 
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRdrSdTocSvSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,    & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,     & 
& cplSdcHpmcSu,ZcplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSecHpmcSv,cplSecSecSv,             & 
& cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,  & 
& cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSvcSdcSvaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSdTocSvSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,ZcplSdcSdcSv,cplSdcSecSu,cplSeSucSd,            & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,          & 
& cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab, & 
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSdTocSvSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,    & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,     & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSecHpmcSv,cplSecSecSv,              & 
& cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,  & 
& cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSvcSdcSvaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSdTocSvSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,             & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,          & 
& cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab, & 
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSdTocSvSd)

 End if 
 End if 
AmpVertexSdTocSvSd = AmpVertexSdTocSvSd -  AmpVertexIRdrSdTocSvSd! +  AmpVertexIRosSdTocSvSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdTocSvSd=0._dp 
AmpVertexZSdTocSvSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdTocSvSd(gt2,:,:) = AmpWaveZSdTocSvSd(gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdTocSvSd(gt1,:,:) 
AmpVertexZSdTocSvSd(gt2,:,:)= AmpVertexZSdTocSvSd(gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdTocSvSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveSdTocSvSd=AmpWaveZSdTocSvSd 
AmpVertexSdTocSvSd= AmpVertexZSdTocSvSd
! Final State 1 
AmpWaveZSdTocSvSd=0._dp 
AmpVertexZSdTocSvSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSdTocSvSd(:,gt2,:) = AmpWaveZSdTocSvSd(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpWaveSdTocSvSd(:,gt1,:) 
AmpVertexZSdTocSvSd(:,gt2,:)= AmpVertexZSdTocSvSd(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpVertexSdTocSvSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdTocSvSd=AmpWaveZSdTocSvSd 
AmpVertexSdTocSvSd= AmpVertexZSdTocSvSd
! Final State 2 
AmpWaveZSdTocSvSd=0._dp 
AmpVertexZSdTocSvSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdTocSvSd(:,:,gt2) = AmpWaveZSdTocSvSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSdTocSvSd(:,:,gt1) 
AmpVertexZSdTocSvSd(:,:,gt2)= AmpVertexZSdTocSvSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSdTocSvSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdTocSvSd=AmpWaveZSdTocSvSd 
AmpVertexSdTocSvSd= AmpVertexZSdTocSvSd
End if
If (ShiftIRdiv) Then 
AmpVertexSdTocSvSd = AmpVertexSdTocSvSd  +  AmpVertexIRosSdTocSvSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->conj[Sv] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdTocSvSd = AmpTreeSdTocSvSd 
 AmpSum2SdTocSvSd = AmpTreeSdTocSvSd + 2._dp*AmpWaveSdTocSvSd + 2._dp*AmpVertexSdTocSvSd  
Else 
 AmpSumSdTocSvSd = AmpTreeSdTocSvSd + AmpWaveSdTocSvSd + AmpVertexSdTocSvSd
 AmpSum2SdTocSvSd = AmpTreeSdTocSvSd + AmpWaveSdTocSvSd + AmpVertexSdTocSvSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdTocSvSd = AmpTreeSdTocSvSd
 AmpSum2SdTocSvSd = AmpTreeSdTocSvSd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSvOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSv(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdTocSvSd = AmpTreeSdTocSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdTocSvSd(gt1, gt2, gt3) 
  AmpSum2SdTocSvSd = 2._dp*AmpWaveSdTocSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdTocSvSd(gt1, gt2, gt3) 
  AmpSum2SdTocSvSd = 2._dp*AmpVertexSdTocSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdTocSvSd(gt1, gt2, gt3) 
  AmpSum2SdTocSvSd = AmpTreeSdTocSvSd + 2._dp*AmpWaveSdTocSvSd + 2._dp*AmpVertexSdTocSvSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdTocSvSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdTocSvSd = AmpTreeSdTocSvSd
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
  AmpSqTreeSdTocSvSd(gt1, gt2, gt3) = (1)*AmpSqSdTocSvSd(gt1, gt2, gt3)  
  AmpSum2SdTocSvSd = + 2._dp*AmpWaveSdTocSvSd + 2._dp*AmpVertexSdTocSvSd
  Call SquareAmp_StoSS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
  AmpSqSdTocSvSd(gt1, gt2, gt3) = AmpSqSdTocSvSd(gt1, gt2, gt3) + AmpSqTreeSdTocSvSd(gt1, gt2, gt3)  
Else  
  AmpSum2SdTocSvSd = AmpTreeSdTocSvSd
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
  AmpSqTreeSdTocSvSd(gt1, gt2, gt3) = (1)*AmpSqSdTocSvSd(gt1, gt2, gt3)  
  AmpSum2SdTocSvSd = + 2._dp*AmpWaveSdTocSvSd + 2._dp*AmpVertexSdTocSvSd
  Call SquareAmp_StoSS(MSd(gt1),MSv(gt2),MSd(gt3),AmpSumSdTocSvSd(gt1, gt2, gt3),AmpSum2SdTocSvSd(gt1, gt2, gt3),AmpSqSdTocSvSd(gt1, gt2, gt3)) 
  AmpSqSdTocSvSd(gt1, gt2, gt3) = AmpSqSdTocSvSd(gt1, gt2, gt3) + AmpSqTreeSdTocSvSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdTocSvSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdTocSvSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSvOS(gt2),MSdOS(gt3),helfactor*AmpSqSdTocSvSd(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSv(gt2),MSd(gt3),helfactor*AmpSqSdTocSvSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdTocSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdTocSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdTocSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdTocSvSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdTocSvSd(gt1, gt2, gt3) + MRGSdTocSvSd(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdTocSvSd(gt1, gt2, gt3) + MRGSdTocSvSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Su Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSuSe(cplSeSucSd,MSd,MSe,MSu,MSd2,MSe2,             & 
& MSu2,AmpTreeSdToSuSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSuSe(ZcplSeSucSd,MSd,MSe,MSu,MSd2,MSe2,            & 
& MSu2,AmpTreeSdToSuSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuSe(MLambda,em,gs,cplSeSucSd,MSdOS,MSeOS,             & 
& MSuOS,MRPSdToSuSe,MRGSdToSuSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuSe(MLambda,em,gs,ZcplSeSucSd,MSdOS,MSeOS,            & 
& MSuOS,MRPSdToSuSe,MRGSdToSuSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSuSe(MLambda,em,gs,cplSeSucSd,MSd,MSe,MSu,             & 
& MRPSdToSuSe,MRGSdToSuSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuSe(MLambda,em,gs,ZcplSeSucSd,MSd,MSe,MSu,            & 
& MRPSdToSuSe,MRGSdToSuSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSuSe(cplSeSucSd,ctcplSeSucSd,MSd,MSd2,             & 
& MSe,MSe2,MSu,MSu2,ZfSd,ZfSe,ZfSu,AmpWaveSdToSuSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSuSe(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplAhSecSe,       & 
& cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcFeChiSeL,           & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFuGluSuL,            & 
& cplcFuGluSuR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,       & 
& cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,         & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,               & 
& cplSucSuVZ,cplAhSeSucSdaa,cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,             & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,  & 
& cplSeSucSecSuaa,AmpVertexSdToSuSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,             & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,     & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,         & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhSeSucSdaa,cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,             & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,  & 
& cplSeSucSecSuaa,AmpVertexIRdrSdToSuSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplAhSecSe,cplAhSucSu,        & 
& cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuSeL,cplcFdFuSeR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplSdcSdcSv,ZcplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,      & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhSeSucSdaa,  & 
& cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,     & 
& cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,cplSeSucSecSuaa,AmpVertexIRosSdToSuSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,             & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,     & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,ZcplSeSucSd,cplSeSvcSe,cplSecSeVP,        & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhSeSucSdaa,cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,             & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,  & 
& cplSeSucSecSuaa,AmpVertexIRosSdToSuSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplAhSecSe,cplAhSucSu,        & 
& cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuSeL,cplcFdFuSeR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhSeSucSdaa,  & 
& cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,     & 
& cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,cplSeSucSecSuaa,AmpVertexIRosSdToSuSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,             & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,     & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,         & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhSeSucSdaa,cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,             & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,  & 
& cplSeSucSecSuaa,AmpVertexIRosSdToSuSe)

 End if 
 End if 
AmpVertexSdToSuSe = AmpVertexSdToSuSe -  AmpVertexIRdrSdToSuSe! +  AmpVertexIRosSdToSuSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSuSe=0._dp 
AmpVertexZSdToSuSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuSe(gt2,:,:) = AmpWaveZSdToSuSe(gt2,:,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSuSe(gt1,:,:) 
AmpVertexZSdToSuSe(gt2,:,:)= AmpVertexZSdToSuSe(gt2,:,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSuSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveSdToSuSe=AmpWaveZSdToSuSe 
AmpVertexSdToSuSe= AmpVertexZSdToSuSe
! Final State 1 
AmpWaveZSdToSuSe=0._dp 
AmpVertexZSdToSuSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuSe(:,gt2,:) = AmpWaveZSdToSuSe(:,gt2,:)+ZRUZU(gt2,gt1)*AmpWaveSdToSuSe(:,gt1,:) 
AmpVertexZSdToSuSe(:,gt2,:)= AmpVertexZSdToSuSe(:,gt2,:)+ZRUZU(gt2,gt1)*AmpVertexSdToSuSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSuSe=AmpWaveZSdToSuSe 
AmpVertexSdToSuSe= AmpVertexZSdToSuSe
! Final State 2 
AmpWaveZSdToSuSe=0._dp 
AmpVertexZSdToSuSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuSe(:,:,gt2) = AmpWaveZSdToSuSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSdToSuSe(:,:,gt1) 
AmpVertexZSdToSuSe(:,:,gt2)= AmpVertexZSdToSuSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSdToSuSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSuSe=AmpWaveZSdToSuSe 
AmpVertexSdToSuSe= AmpVertexZSdToSuSe
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSuSe = AmpVertexSdToSuSe  +  AmpVertexIRosSdToSuSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Su Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSuSe = AmpTreeSdToSuSe 
 AmpSum2SdToSuSe = AmpTreeSdToSuSe + 2._dp*AmpWaveSdToSuSe + 2._dp*AmpVertexSdToSuSe  
Else 
 AmpSumSdToSuSe = AmpTreeSdToSuSe + AmpWaveSdToSuSe + AmpVertexSdToSuSe
 AmpSum2SdToSuSe = AmpTreeSdToSuSe + AmpWaveSdToSuSe + AmpVertexSdToSuSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSuSe = AmpTreeSdToSuSe
 AmpSum2SdToSuSe = AmpTreeSdToSuSe 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSuOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSu(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SdToSuSe = AmpTreeSdToSuSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MSe(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSuSe(gt1, gt2, gt3) 
  AmpSum2SdToSuSe = 2._dp*AmpWaveSdToSuSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MSe(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSuSe(gt1, gt2, gt3) 
  AmpSum2SdToSuSe = 2._dp*AmpVertexSdToSuSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MSe(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSuSe(gt1, gt2, gt3) 
  AmpSum2SdToSuSe = AmpTreeSdToSuSe + 2._dp*AmpWaveSdToSuSe + 2._dp*AmpVertexSdToSuSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MSe(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSuSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSuSe = AmpTreeSdToSuSe
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
  AmpSqTreeSdToSuSe(gt1, gt2, gt3) = (1)*AmpSqSdToSuSe(gt1, gt2, gt3)  
  AmpSum2SdToSuSe = + 2._dp*AmpWaveSdToSuSe + 2._dp*AmpVertexSdToSuSe
  Call SquareAmp_StoSS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
  AmpSqSdToSuSe(gt1, gt2, gt3) = AmpSqSdToSuSe(gt1, gt2, gt3) + AmpSqTreeSdToSuSe(gt1, gt2, gt3)  
Else  
  AmpSum2SdToSuSe = AmpTreeSdToSuSe
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MSe(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
  AmpSqTreeSdToSuSe(gt1, gt2, gt3) = (1)*AmpSqSdToSuSe(gt1, gt2, gt3)  
  AmpSum2SdToSuSe = + 2._dp*AmpWaveSdToSuSe + 2._dp*AmpVertexSdToSuSe
  Call SquareAmp_StoSS(MSd(gt1),MSu(gt2),MSe(gt3),AmpSumSdToSuSe(gt1, gt2, gt3),AmpSum2SdToSuSe(gt1, gt2, gt3),AmpSqSdToSuSe(gt1, gt2, gt3)) 
  AmpSqSdToSuSe(gt1, gt2, gt3) = AmpSqSdToSuSe(gt1, gt2, gt3) + AmpSqTreeSdToSuSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSdToSuSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSuSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSuOS(gt2),MSeOS(gt3),helfactor*AmpSqSdToSuSe(gt1, gt2, gt3))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSu(gt2),MSe(gt3),helfactor*AmpSqSdToSuSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSdToSuSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSuSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSuSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSdToSuSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSuSe(gt1, gt2, gt3) + MRGSdToSuSe(gt1, gt2, gt3)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSdToSuSe(gt1, gt2, gt3) + MRGSdToSuSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Su VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SdToSuVWm(cplSucSdVWm,MSd,MSu,MVWm,MSd2,               & 
& MSu2,MVWm2,AmpTreeSdToSuVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SdToSuVWm(ZcplSucSdVWm,MSd,MSu,MVWm,MSd2,              & 
& MSu2,MVWm2,AmpTreeSdToSuVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuVWm(MLambda,em,gs,cplSucSdVWm,MSdOS,MSuOS,           & 
& MVWmOS,MRPSdToSuVWm,MRGSdToSuVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuVWm(MLambda,em,gs,ZcplSucSdVWm,MSdOS,MSuOS,          & 
& MVWmOS,MRPSdToSuVWm,MRGSdToSuVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SdToSuVWm(MLambda,em,gs,cplSucSdVWm,MSd,MSu,               & 
& MVWm,MRPSdToSuVWm,MRGSdToSuVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SdToSuVWm(MLambda,em,gs,ZcplSucSdVWm,MSd,MSu,              & 
& MVWm,MRPSdToSuVWm,MRGSdToSuVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSuVWm(cplSucSdVWm,ctcplSucSdVWm,MSd,               & 
& MSd2,MSu,MSu2,MVWm,MVWm2,ZfSd,ZfSu,ZfVWm,AmpWaveSdToSuVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSuVWm(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplAhSucSu,       & 
& cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,      & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuVWmL,            & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,           & 
& cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,     & 
& cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,       & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,cplSucSdVGVWmLamct3ct2ct1,& 
& cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,AmpVertexSdToSuVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,        & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,     & 
& cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,           & 
& AmpVertexIRdrSdToSuVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,      & 
& cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,GosZcplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,            & 
& cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,ZcplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,      & 
& GosZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,             & 
& cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,           & 
& AmpVertexIRosSdToSuVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,GZcplHpmSucSd,cplSdcSdVG,              & 
& cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,ZcplSucSdVWm,       & 
& cplSucSuVZ,cplSvcSeVWm,GZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,          & 
& cplSdcSdcVWmVWmaa,cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWmVZaa,           & 
& cplSucSucVWmVWmaa,AmpVertexIRosSdToSuVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,      & 
& cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,GcplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,               & 
& cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,       & 
& GcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,cplSucSdVGVWmLamct3ct2ct1,& 
& cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,AmpVertexIRosSdToSuVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,        & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,     & 
& cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,           & 
& AmpVertexIRosSdToSuVWm)

 End if 
 End if 
AmpVertexSdToSuVWm = AmpVertexSdToSuVWm -  AmpVertexIRdrSdToSuVWm! +  AmpVertexIRosSdToSuVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSdToSuVWm=0._dp 
AmpVertexZSdToSuVWm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuVWm(:,gt2,:) = AmpWaveZSdToSuVWm(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpWaveSdToSuVWm(:,gt1,:) 
AmpVertexZSdToSuVWm(:,gt2,:)= AmpVertexZSdToSuVWm(:,gt2,:) + ZRUZDc(gt2,gt1)*AmpVertexSdToSuVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveSdToSuVWm=AmpWaveZSdToSuVWm 
AmpVertexSdToSuVWm= AmpVertexZSdToSuVWm
! Final State 1 
AmpWaveZSdToSuVWm=0._dp 
AmpVertexZSdToSuVWm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSdToSuVWm(:,:,gt2) = AmpWaveZSdToSuVWm(:,:,gt2)+ZRUZU(gt2,gt1)*AmpWaveSdToSuVWm(:,:,gt1) 
AmpVertexZSdToSuVWm(:,:,gt2)= AmpVertexZSdToSuVWm(:,:,gt2)+ZRUZU(gt2,gt1)*AmpVertexSdToSuVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveSdToSuVWm=AmpWaveZSdToSuVWm 
AmpVertexSdToSuVWm= AmpVertexZSdToSuVWm
End if
If (ShiftIRdiv) Then 
AmpVertexSdToSuVWm = AmpVertexSdToSuVWm  +  AmpVertexIRosSdToSuVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Su VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSdToSuVWm = AmpTreeSdToSuVWm 
 AmpSum2SdToSuVWm = AmpTreeSdToSuVWm + 2._dp*AmpWaveSdToSuVWm + 2._dp*AmpVertexSdToSuVWm  
Else 
 AmpSumSdToSuVWm = AmpTreeSdToSuVWm + AmpWaveSdToSuVWm + AmpVertexSdToSuVWm
 AmpSum2SdToSuVWm = AmpTreeSdToSuVWm + AmpWaveSdToSuVWm + AmpVertexSdToSuVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSuVWm = AmpTreeSdToSuVWm
 AmpSum2SdToSuVWm = AmpTreeSdToSuVWm 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSuOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSu(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SdToSuVWm = AmpTreeSdToSuVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSuOS(gt2),MVWmOS,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSu(gt2),MVWm,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSdToSuVWm(gt1, gt2) 
  AmpSum2SdToSuVWm = 2._dp*AmpWaveSdToSuVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSuOS(gt2),MVWmOS,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSu(gt2),MVWm,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSdToSuVWm(gt1, gt2) 
  AmpSum2SdToSuVWm = 2._dp*AmpVertexSdToSuVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSuOS(gt2),MVWmOS,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSu(gt2),MVWm,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSdToSuVWm(gt1, gt2) 
  AmpSum2SdToSuVWm = AmpTreeSdToSuVWm + 2._dp*AmpWaveSdToSuVWm + 2._dp*AmpVertexSdToSuVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSuOS(gt2),MVWmOS,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSu(gt2),MVWm,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSdToSuVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SdToSuVWm = AmpTreeSdToSuVWm
  Call SquareAmp_StoSV(MSdOS(gt1),MSuOS(gt2),MVWmOS,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
  AmpSqTreeSdToSuVWm(gt1, gt2) = (1)*AmpSqSdToSuVWm(gt1, gt2)  
  AmpSum2SdToSuVWm = + 2._dp*AmpWaveSdToSuVWm + 2._dp*AmpVertexSdToSuVWm
  Call SquareAmp_StoSV(MSdOS(gt1),MSuOS(gt2),MVWmOS,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
  AmpSqSdToSuVWm(gt1, gt2) = AmpSqSdToSuVWm(gt1, gt2) + AmpSqTreeSdToSuVWm(gt1, gt2)  
Else  
  AmpSum2SdToSuVWm = AmpTreeSdToSuVWm
  Call SquareAmp_StoSV(MSd(gt1),MSu(gt2),MVWm,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
  AmpSqTreeSdToSuVWm(gt1, gt2) = (1)*AmpSqSdToSuVWm(gt1, gt2)  
  AmpSum2SdToSuVWm = + 2._dp*AmpWaveSdToSuVWm + 2._dp*AmpVertexSdToSuVWm
  Call SquareAmp_StoSV(MSd(gt1),MSu(gt2),MVWm,AmpSumSdToSuVWm(:,gt1, gt2),AmpSum2SdToSuVWm(:,gt1, gt2),AmpSqSdToSuVWm(gt1, gt2)) 
  AmpSqSdToSuVWm(gt1, gt2) = AmpSqSdToSuVWm(gt1, gt2) + AmpSqTreeSdToSuVWm(gt1, gt2)  
End if  
Else  
  AmpSqSdToSuVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSuVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSuOS(gt2),MVWmOS,helfactor*AmpSqSdToSuVWm(gt1, gt2))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSu(gt2),MVWm,helfactor*AmpSqSdToSuVWm(gt1, gt2))
End if 
If ((Abs(MRPSdToSuVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSdToSuVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSdToSuVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSdToSuVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSdToSuVWm(gt1, gt2) + MRGSdToSuVWm(gt1, gt2)) 
  gP1LSd(gt1,i4) = gP1LSd(gt1,i4) + phasespacefactor*1*helfactor*(MRPSdToSuVWm(gt1, gt2) + MRGSdToSuVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSd(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
End If 
!---------------- 
! Sd VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVG(cplSdcSdVG,ctcplSdcSdVG,MSdOS,MSd2OS,         & 
& MVG,MVG2,ZfSd,ZfVG,AmpWaveSdToSdVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVG(cplSdcSdVG,ctcplSdcSdVG,MSdOS,MSd2OS,         & 
& MVG,MVG2,ZfSd,ZfVG,AmpWaveSdToSdVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVG(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplFeFucSdL,cplFeFucSdR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFdFvSdL,cplcFdFvSdR,cplGluGluVGL,cplGluGluVGR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSdVWm,cplVGVGVG,      & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVGVZLamct3ct2ct1,cplSdcSucVWmVGLamct4ct2ct1,          & 
& cplSucSdVGVWmLamct3ct2ct1,AmpVertexSdToSdVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVG(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplFeFucSdL,cplFeFucSdR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFdFvSdL,cplcFdFvSdR,cplGluGluVGL,cplGluGluVGR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSdVWm,cplVGVGVG,      & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVGVZLamct3ct2ct1,cplSdcSucVWmVGLamct4ct2ct1,          & 
& cplSucSdVGVWmLamct3ct2ct1,AmpVertexSdToSdVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVG(cplSdcSdVG,ctcplSdcSdVG,MSd,MSd2,             & 
& MVG,MVG2,ZfSd,ZfVG,AmpWaveSdToSdVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVG(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplChaFucSdL,     & 
& cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFuFuVGL,cplcFuFuVGR,cplcFdFvSdL,cplcFdFvSdR,cplGluGluVGL,              & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,              & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,             & 
& cplSucSuVG,cplSucSdVWm,cplVGVGVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,            & 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVGVZLamct3ct2ct1,& 
& cplSdcSucVWmVGLamct4ct2ct1,cplSucSdVGVWmLamct3ct2ct1,AmpVertexSdToSdVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Sd VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSdVG = 0._dp 
 AmpSum2SdToSdVG = 0._dp  
Else 
 AmpSumSdToSdVG = AmpVertexSdToSdVG + AmpWaveSdToSdVG
 AmpSum2SdToSdVG = AmpVertexSdToSdVG + AmpWaveSdToSdVG 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSdOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSd(gt2)+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),0._dp,AmpSumSdToSdVG(:,gt1, gt2),AmpSum2SdToSdVG(:,gt1, gt2),AmpSqSdToSdVG(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVG,AmpSumSdToSdVG(:,gt1, gt2),AmpSum2SdToSdVG(:,gt1, gt2),AmpSqSdToSdVG(gt1, gt2)) 
End if  
Else  
  AmpSqSdToSdVG(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSdVG(gt1, gt2).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSdOS(gt2),0._dp,helfactor*AmpSqSdToSdVG(gt1, gt2))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSd(gt2),MVG,helfactor*AmpSqSdToSdVG(gt1, gt2))
End if 
If ((Abs(MRPSdToSdVG(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdVG(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Sd VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVP(cplSdcSdVP,cplSdcSdVZ,ctcplSdcSdVP,           & 
& ctcplSdcSdVZ,MSdOS,MSd2OS,MVP,MVP2,ZfSd,ZfVP,ZfVZVP,AmpWaveSdToSdVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVP(cplSdcSdVP,cplSdcSdVZ,ctcplSdcSdVP,           & 
& ctcplSdcSdVZ,MSdOS,MSd2OS,MVP,MVP2,ZfSd,ZfVP,ZfVZVP,AmpWaveSdToSdVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,           & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,       & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,cplcFdFdVPR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVP,cplSucSdVWm,cplcHpmVPVWm,cplcVWmVPVWm,   & 
& cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVPVPaa,cplSdcSdVPVZaa,cplSdcSucVWmVPaa,               & 
& cplSucSdVPVWmaa,AmpVertexSdToSdVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,           & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,       & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,cplcFdFdVPR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVP,cplSucSdVWm,cplcHpmVPVWm,cplcVWmVPVWm,   & 
& cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVPVPaa,cplSdcSdVPVZaa,cplSdcSucVWmVPaa,               & 
& cplSucSdVPVWmaa,AmpVertexSdToSdVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SdToSdVP(cplSdcSdVP,cplSdcSdVZ,ctcplSdcSdVP,           & 
& ctcplSdcSdVZ,MSd,MSd2,MVP,MVP2,ZfSd,ZfVP,ZfVZVP,AmpWaveSdToSdVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SdToSdVP(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplChaFucSdL,     & 
& cplChaFucSdR,cplcChaChaVPL,cplcChaChaVPR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,       & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,            & 
& cplcFdFdVPR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,              & 
& cplHpmSucSd,cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,     & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,        & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVP,cplSucSdVWm,cplcHpmVPVWm,    & 
& cplcVWmVPVWm,cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVPVPaa,cplSdcSdVPVZaa,cplSdcSucVWmVPaa,  & 
& cplSucSdVPVWmaa,AmpVertexSdToSdVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sd->Sd VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSdToSdVP = 0._dp 
 AmpSum2SdToSdVP = 0._dp  
Else 
 AmpSumSdToSdVP = AmpVertexSdToSdVP + AmpWaveSdToSdVP
 AmpSum2SdToSdVP = AmpVertexSdToSdVP + AmpWaveSdToSdVP 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSdOS(gt1).gt.(MSdOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSd(gt1).gt.(MSd(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSdOS(gt1),MSdOS(gt2),0._dp,AmpSumSdToSdVP(:,gt1, gt2),AmpSum2SdToSdVP(:,gt1, gt2),AmpSqSdToSdVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSd(gt1),MSd(gt2),MVP,AmpSumSdToSdVP(:,gt1, gt2),AmpSum2SdToSdVP(:,gt1, gt2),AmpSqSdToSdVP(gt1, gt2)) 
End if  
Else  
  AmpSqSdToSdVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSdToSdVP(gt1, gt2).eq.0._dp) Then 
  gP1LSd(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSdOS(gt1),MSdOS(gt2),0._dp,helfactor*AmpSqSdToSdVP(gt1, gt2))
Else 
  gP1LSd(gt1,i4) = 1*GammaTPS(MSd(gt1),MSd(gt2),MVP,helfactor*AmpSqSdToSdVP(gt1, gt2))
End if 
If ((Abs(MRPSdToSdVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSdToSdVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSd(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
End Subroutine OneLoopDecay_Sd

End Module Wrapper_OneLoopDecay_Sd_MSSMTriLnV
