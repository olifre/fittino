! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:00 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Su_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Su_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Su(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& ZfVPVZ,ZfVZVP,cplAhAhhh,cplAhAhSucSuaa,cplAhcHpmVWm,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSd,cplAhSdcSecSuaa,              & 
& cplAhSecSe,cplAhSeSucSdaa,cplAhSucSu,cplcChacFuSdL,cplcChacFuSdR,cplcChaChaAhL,        & 
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
& cplhhhhSucSuaa,cplhhHpmcHpm,cplhhHpmcVWm,cplhhHpmSucSdaa,cplhhSdcHpmcSuaa,             & 
& cplhhSdcSd,cplhhSdcSecSuaa,cplhhSecSe,cplhhSeSucSdaa,cplhhSucSu,cplhhSvcSv,            & 
& cplhhVZVZ,cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmSdcHpmcSdaa,       & 
& cplHpmSdcSdcSeaa,cplHpmSucHpmcSuaa,cplHpmSucSd,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,      & 
& cplHpmSuSvcSdaa,cplHpmSvcSe,cplSdcHpmcSu,cplSdcHpmcSucSvaa,cplSdcSdcSv,cplSdcSdcVWmVWmaa,& 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSecSu,cplSdcSucVWm,cplSdcSucVWmVGLamct4ct2ct1,  & 
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdSecHpmcSdaa,cplSdSecSdcSeaa,cplSdSucSdcSuabab,  & 
& cplSdSucSdcSuabba,cplSdSvcHpmcSuaa,cplSdSvcSd,cplSdSvcSecSuaa,cplSecHpmcSv,            & 
& cplSecSecSv,cplSecSeVP,cplSecSeVZ,cplSecSvcVWm,cplSeSucHpmcSuaa,cplSeSucSd,            & 
& cplSeSucSdcSvaa,cplSeSucSecSuaa,cplSeSvcSe,cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,  & 
& cplSucSdVWm,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,cplSucSuVG,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSucSuVGVPLamct3ct2ct1,cplSucSuVGVZLamct3ct2ct1,& 
& cplSucSuVP,cplSucSuVPVPaa,cplSucSuVPVZaa,cplSucSuVZ,cplSucSuVZVZaa,cplSuSucSucSuabab,  & 
& cplSuSucSucSuabba,cplSuSvcSucSvaa,cplSvcSeVWm,cplVGVGVG,ctcplAhSucSu,ctcplcChaFdcSuL,  & 
& ctcplcChaFdcSuR,ctcplcFeFdcSuL,ctcplcFeFdcSuR,ctcplChiFucSuL,ctcplChiFucSuR,           & 
& ctcplGluFucSuL,ctcplGluFucSuR,ctcplhhSucSu,ctcplSdcHpmcSu,ctcplSdcSecSu,               & 
& ctcplSdcSucVWm,ctcplSucSuVG,ctcplSucSuVP,ctcplSucSuVZ,GcplcHpmVPVWm,GcplHpmcVWmVP,     & 
& GcplSdcHpmcSu,GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,GosZcplSdcHpmcSu,GZcplcHpmVPVWm,       & 
& GZcplHpmcVWmVP,GZcplSdcHpmcSu,ZcplAhSucSu,ZcplcChaFdcSuL,ZcplcChaFdcSuR,               & 
& ZcplcFeFdcSuL,ZcplcFeFdcSuR,ZcplChiFucSuL,ZcplChiFucSuR,ZcplGluFucSuL,ZcplGluFucSuR,   & 
& ZcplhhSucSu,ZcplSdcHpmcSu,ZcplSdcSecSu,ZcplSdcSucVWm,ZcplSucSuVZ,ZRUZD,ZRUZV,          & 
& ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,           & 
& ZRUZUL,ZRUZUR,MLambda,em,gs,deltaM,kont,gP1LSu)

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

Complex(dp),Intent(in) :: cplAhAhhh(2,2,2),cplAhAhSucSuaa(2,2,6,6),cplAhcHpmVWm(2,2),cplAhhhVZ(2,2),            & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhHpmSucSdaa(2,2,6,6),cplAhSdcHpmcSuaa(2,6,2,6),& 
& cplAhSdcSd(2,6,6),cplAhSdcSecSuaa(2,6,6,6),cplAhSecSe(2,6,6),cplAhSeSucSdaa(2,6,6,6),  & 
& cplAhSucSu(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcChaChaAhL(2,2,2),      & 
& cplcChaChaAhR(2,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),     & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplcChaChiHpmL(2,4,2),        & 
& cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),    & 
& cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),    & 
& cplcChaFvSeR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFdChiSdL(3,4,6),       & 
& cplcFdChiSdR(3,4,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdFdcSvL(3,3,3),         & 
& cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),          & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),               & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),             & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),           & 
& cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),         & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),             & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplChaFucSdL(2,3,6),              & 
& cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),   & 
& cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),               & 
& cplGluGluVGL,cplGluGluVGR,cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhhhhh(2,2,2)

Complex(dp),Intent(in) :: cplhhhhSucSuaa(2,2,6,6),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhHpmSucSdaa(2,2,6,6),& 
& cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSd(2,6,6),cplhhSdcSecSuaa(2,6,6,6),cplhhSecSe(2,6,6),& 
& cplhhSeSucSdaa(2,6,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhVZVZ(2),              & 
& cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplHpmSdcHpmcSdaa(2,6,2,6),& 
& cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSucSd(2,6,6),               & 
& cplHpmSucSdcSvaa(2,6,6,3),cplHpmSucSecSuaa(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),          & 
& cplHpmSvcSe(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcHpmcSucSvaa(6,2,6,3),cplSdcSdcSv(6,6,3),  & 
& cplSdcSdcVWmVWmaa(6,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),& 
& cplSdcSucVWm(6,6),cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSdcSucVWmVPaa(6,6),               & 
& cplSdcSucVWmVZaa(6,6),cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),              & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),       & 
& cplSdSvcSd(6,3,6),cplSdSvcSecSuaa(6,3,6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),     & 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSvcVWm(6,3),cplSeSucHpmcSuaa(6,6,2,6),           & 
& cplSeSucSd(6,6,6),cplSeSucSdcSvaa(6,6,6,3),cplSeSucSecSuaa(6,6,6,6),cplSeSvcSe(6,3,6), & 
& cplSucSdVGVWmLamct3ct2ct1(6,6),cplSucSdVPVWmaa(6,6),cplSucSdVWm(6,6),cplSucSdVWmVZaa(6,6),& 
& cplSucSucVWmVWmaa(6,6),cplSucSuVG(6,6),cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6), & 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSucSuVGVPLamct3ct2ct1(6,6),          & 
& cplSucSuVGVZLamct3ct2ct1(6,6),cplSucSuVP(6,6),cplSucSuVPVPaa(6,6),cplSucSuVPVZaa(6,6), & 
& cplSucSuVZ(6,6),cplSucSuVZVZaa(6,6),cplSuSucSucSuabab(6,6,6,6),cplSuSucSucSuabba(6,6,6,6),& 
& cplSuSvcSucSvaa(6,3,6,3),cplSvcSeVWm(3,6),cplVGVGVG,ctcplAhSucSu(2,6,6),               & 
& ctcplcChaFdcSuL(2,3,6),ctcplcChaFdcSuR(2,3,6),ctcplcFeFdcSuL(3,3,6),ctcplcFeFdcSuR(3,3,6),& 
& ctcplChiFucSuL(4,3,6),ctcplChiFucSuR(4,3,6),ctcplGluFucSuL(3,6),ctcplGluFucSuR(3,6),   & 
& ctcplhhSucSu(2,6,6),ctcplSdcHpmcSu(6,2,6),ctcplSdcSecSu(6,6,6),ctcplSdcSucVWm(6,6),    & 
& ctcplSucSuVG(6,6),ctcplSucSuVP(6,6),ctcplSucSuVZ(6,6),GcplcHpmVPVWm(2),GcplHpmcVWmVP(2),& 
& GcplSdcHpmcSu(6,2,6),GosZcplcHpmVPVWm(2),GosZcplHpmcVWmVP(2),GosZcplSdcHpmcSu(6,2,6),  & 
& GZcplcHpmVPVWm(2),GZcplHpmcVWmVP(2),GZcplSdcHpmcSu(6,2,6),ZcplAhSucSu(2,6,6),          & 
& ZcplcChaFdcSuL(2,3,6),ZcplcChaFdcSuR(2,3,6),ZcplcFeFdcSuL(3,3,6),ZcplcFeFdcSuR(3,3,6), & 
& ZcplChiFucSuL(4,3,6),ZcplChiFucSuR(4,3,6),ZcplGluFucSuL(3,6),ZcplGluFucSuR(3,6),       & 
& ZcplhhSucSu(2,6,6),ZcplSdcHpmcSu(6,2,6),ZcplSdcSecSu(6,6,6),ZcplSdcSucVWm(6,6),        & 
& ZcplSucSuVZ(6,6)

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
Real(dp), Intent(out) :: gP1LSu(6,159) 
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
Real(dp) :: MRPSuToSuAh(6,6,2),MRGSuToSuAh(6,6,2), MRPZSuToSuAh(6,6,2),MRGZSuToSuAh(6,6,2) 
Real(dp) :: MVPSuToSuAh(6,6,2) 
Real(dp) :: RMsqTreeSuToSuAh(6,6,2),RMsqWaveSuToSuAh(6,6,2),RMsqVertexSuToSuAh(6,6,2) 
Complex(dp) :: AmpTreeSuToSuAh(6,6,2),AmpWaveSuToSuAh(6,6,2),AmpVertexSuToSuAh(6,6,2)& 
 & ,AmpVertexIRosSuToSuAh(6,6,2),AmpVertexIRdrSuToSuAh(6,6,2), AmpSumSuToSuAh(6,6,2), AmpSum2SuToSuAh(6,6,2) 
Complex(dp) :: AmpTreeZSuToSuAh(6,6,2),AmpWaveZSuToSuAh(6,6,2),AmpVertexZSuToSuAh(6,6,2) 
Real(dp) :: AmpSqSuToSuAh(6,6,2),  AmpSqTreeSuToSuAh(6,6,2) 
Real(dp) :: MRPSuToFuChi(6,3,4),MRGSuToFuChi(6,3,4), MRPZSuToFuChi(6,3,4),MRGZSuToFuChi(6,3,4) 
Real(dp) :: MVPSuToFuChi(6,3,4) 
Real(dp) :: RMsqTreeSuToFuChi(6,3,4),RMsqWaveSuToFuChi(6,3,4),RMsqVertexSuToFuChi(6,3,4) 
Complex(dp) :: AmpTreeSuToFuChi(2,6,3,4),AmpWaveSuToFuChi(2,6,3,4),AmpVertexSuToFuChi(2,6,3,4)& 
 & ,AmpVertexIRosSuToFuChi(2,6,3,4),AmpVertexIRdrSuToFuChi(2,6,3,4), AmpSumSuToFuChi(2,6,3,4), AmpSum2SuToFuChi(2,6,3,4) 
Complex(dp) :: AmpTreeZSuToFuChi(2,6,3,4),AmpWaveZSuToFuChi(2,6,3,4),AmpVertexZSuToFuChi(2,6,3,4) 
Real(dp) :: AmpSqSuToFuChi(6,3,4),  AmpSqTreeSuToFuChi(6,3,4) 
Real(dp) :: MRPSuTocChaFd(6,2,3),MRGSuTocChaFd(6,2,3), MRPZSuTocChaFd(6,2,3),MRGZSuTocChaFd(6,2,3) 
Real(dp) :: MVPSuTocChaFd(6,2,3) 
Real(dp) :: RMsqTreeSuTocChaFd(6,2,3),RMsqWaveSuTocChaFd(6,2,3),RMsqVertexSuTocChaFd(6,2,3) 
Complex(dp) :: AmpTreeSuTocChaFd(2,6,2,3),AmpWaveSuTocChaFd(2,6,2,3),AmpVertexSuTocChaFd(2,6,2,3)& 
 & ,AmpVertexIRosSuTocChaFd(2,6,2,3),AmpVertexIRdrSuTocChaFd(2,6,2,3), AmpSumSuTocChaFd(2,6,2,3), AmpSum2SuTocChaFd(2,6,2,3) 
Complex(dp) :: AmpTreeZSuTocChaFd(2,6,2,3),AmpWaveZSuTocChaFd(2,6,2,3),AmpVertexZSuTocChaFd(2,6,2,3) 
Real(dp) :: AmpSqSuTocChaFd(6,2,3),  AmpSqTreeSuTocChaFd(6,2,3) 
Real(dp) :: MRPSuTocFeFd(6,3,3),MRGSuTocFeFd(6,3,3), MRPZSuTocFeFd(6,3,3),MRGZSuTocFeFd(6,3,3) 
Real(dp) :: MVPSuTocFeFd(6,3,3) 
Real(dp) :: RMsqTreeSuTocFeFd(6,3,3),RMsqWaveSuTocFeFd(6,3,3),RMsqVertexSuTocFeFd(6,3,3) 
Complex(dp) :: AmpTreeSuTocFeFd(2,6,3,3),AmpWaveSuTocFeFd(2,6,3,3),AmpVertexSuTocFeFd(2,6,3,3)& 
 & ,AmpVertexIRosSuTocFeFd(2,6,3,3),AmpVertexIRdrSuTocFeFd(2,6,3,3), AmpSumSuTocFeFd(2,6,3,3), AmpSum2SuTocFeFd(2,6,3,3) 
Complex(dp) :: AmpTreeZSuTocFeFd(2,6,3,3),AmpWaveZSuTocFeFd(2,6,3,3),AmpVertexZSuTocFeFd(2,6,3,3) 
Real(dp) :: AmpSqSuTocFeFd(6,3,3),  AmpSqTreeSuTocFeFd(6,3,3) 
Real(dp) :: MRPSuToGluFu(6,3),MRGSuToGluFu(6,3), MRPZSuToGluFu(6,3),MRGZSuToGluFu(6,3) 
Real(dp) :: MVPSuToGluFu(6,3) 
Real(dp) :: RMsqTreeSuToGluFu(6,3),RMsqWaveSuToGluFu(6,3),RMsqVertexSuToGluFu(6,3) 
Complex(dp) :: AmpTreeSuToGluFu(2,6,3),AmpWaveSuToGluFu(2,6,3),AmpVertexSuToGluFu(2,6,3)& 
 & ,AmpVertexIRosSuToGluFu(2,6,3),AmpVertexIRdrSuToGluFu(2,6,3), AmpSumSuToGluFu(2,6,3), AmpSum2SuToGluFu(2,6,3) 
Complex(dp) :: AmpTreeZSuToGluFu(2,6,3),AmpWaveZSuToGluFu(2,6,3),AmpVertexZSuToGluFu(2,6,3) 
Real(dp) :: AmpSqSuToGluFu(6,3),  AmpSqTreeSuToGluFu(6,3) 
Real(dp) :: MRPSuToSuhh(6,6,2),MRGSuToSuhh(6,6,2), MRPZSuToSuhh(6,6,2),MRGZSuToSuhh(6,6,2) 
Real(dp) :: MVPSuToSuhh(6,6,2) 
Real(dp) :: RMsqTreeSuToSuhh(6,6,2),RMsqWaveSuToSuhh(6,6,2),RMsqVertexSuToSuhh(6,6,2) 
Complex(dp) :: AmpTreeSuToSuhh(6,6,2),AmpWaveSuToSuhh(6,6,2),AmpVertexSuToSuhh(6,6,2)& 
 & ,AmpVertexIRosSuToSuhh(6,6,2),AmpVertexIRdrSuToSuhh(6,6,2), AmpSumSuToSuhh(6,6,2), AmpSum2SuToSuhh(6,6,2) 
Complex(dp) :: AmpTreeZSuToSuhh(6,6,2),AmpWaveZSuToSuhh(6,6,2),AmpVertexZSuToSuhh(6,6,2) 
Real(dp) :: AmpSqSuToSuhh(6,6,2),  AmpSqTreeSuToSuhh(6,6,2) 
Real(dp) :: MRPSuTocHpmSd(6,2,6),MRGSuTocHpmSd(6,2,6), MRPZSuTocHpmSd(6,2,6),MRGZSuTocHpmSd(6,2,6) 
Real(dp) :: MVPSuTocHpmSd(6,2,6) 
Real(dp) :: RMsqTreeSuTocHpmSd(6,2,6),RMsqWaveSuTocHpmSd(6,2,6),RMsqVertexSuTocHpmSd(6,2,6) 
Complex(dp) :: AmpTreeSuTocHpmSd(6,2,6),AmpWaveSuTocHpmSd(6,2,6),AmpVertexSuTocHpmSd(6,2,6)& 
 & ,AmpVertexIRosSuTocHpmSd(6,2,6),AmpVertexIRdrSuTocHpmSd(6,2,6), AmpSumSuTocHpmSd(6,2,6), AmpSum2SuTocHpmSd(6,2,6) 
Complex(dp) :: AmpTreeZSuTocHpmSd(6,2,6),AmpWaveZSuTocHpmSd(6,2,6),AmpVertexZSuTocHpmSd(6,2,6) 
Real(dp) :: AmpSqSuTocHpmSd(6,2,6),  AmpSqTreeSuTocHpmSd(6,2,6) 
Real(dp) :: MRPSuTocSeSd(6,6,6),MRGSuTocSeSd(6,6,6), MRPZSuTocSeSd(6,6,6),MRGZSuTocSeSd(6,6,6) 
Real(dp) :: MVPSuTocSeSd(6,6,6) 
Real(dp) :: RMsqTreeSuTocSeSd(6,6,6),RMsqWaveSuTocSeSd(6,6,6),RMsqVertexSuTocSeSd(6,6,6) 
Complex(dp) :: AmpTreeSuTocSeSd(6,6,6),AmpWaveSuTocSeSd(6,6,6),AmpVertexSuTocSeSd(6,6,6)& 
 & ,AmpVertexIRosSuTocSeSd(6,6,6),AmpVertexIRdrSuTocSeSd(6,6,6), AmpSumSuTocSeSd(6,6,6), AmpSum2SuTocSeSd(6,6,6) 
Complex(dp) :: AmpTreeZSuTocSeSd(6,6,6),AmpWaveZSuTocSeSd(6,6,6),AmpVertexZSuTocSeSd(6,6,6) 
Real(dp) :: AmpSqSuTocSeSd(6,6,6),  AmpSqTreeSuTocSeSd(6,6,6) 
Real(dp) :: MRPSuToSdcVWm(6,6),MRGSuToSdcVWm(6,6), MRPZSuToSdcVWm(6,6),MRGZSuToSdcVWm(6,6) 
Real(dp) :: MVPSuToSdcVWm(6,6) 
Real(dp) :: RMsqTreeSuToSdcVWm(6,6),RMsqWaveSuToSdcVWm(6,6),RMsqVertexSuToSdcVWm(6,6) 
Complex(dp) :: AmpTreeSuToSdcVWm(2,6,6),AmpWaveSuToSdcVWm(2,6,6),AmpVertexSuToSdcVWm(2,6,6)& 
 & ,AmpVertexIRosSuToSdcVWm(2,6,6),AmpVertexIRdrSuToSdcVWm(2,6,6), AmpSumSuToSdcVWm(2,6,6), AmpSum2SuToSdcVWm(2,6,6) 
Complex(dp) :: AmpTreeZSuToSdcVWm(2,6,6),AmpWaveZSuToSdcVWm(2,6,6),AmpVertexZSuToSdcVWm(2,6,6) 
Real(dp) :: AmpSqSuToSdcVWm(6,6),  AmpSqTreeSuToSdcVWm(6,6) 
Real(dp) :: MRPSuToSuVZ(6,6),MRGSuToSuVZ(6,6), MRPZSuToSuVZ(6,6),MRGZSuToSuVZ(6,6) 
Real(dp) :: MVPSuToSuVZ(6,6) 
Real(dp) :: RMsqTreeSuToSuVZ(6,6),RMsqWaveSuToSuVZ(6,6),RMsqVertexSuToSuVZ(6,6) 
Complex(dp) :: AmpTreeSuToSuVZ(2,6,6),AmpWaveSuToSuVZ(2,6,6),AmpVertexSuToSuVZ(2,6,6)& 
 & ,AmpVertexIRosSuToSuVZ(2,6,6),AmpVertexIRdrSuToSuVZ(2,6,6), AmpSumSuToSuVZ(2,6,6), AmpSum2SuToSuVZ(2,6,6) 
Complex(dp) :: AmpTreeZSuToSuVZ(2,6,6),AmpWaveZSuToSuVZ(2,6,6),AmpVertexZSuToSuVZ(2,6,6) 
Real(dp) :: AmpSqSuToSuVZ(6,6),  AmpSqTreeSuToSuVZ(6,6) 
Real(dp) :: MRPSuToFuFv(6,3,3),MRGSuToFuFv(6,3,3), MRPZSuToFuFv(6,3,3),MRGZSuToFuFv(6,3,3) 
Real(dp) :: MVPSuToFuFv(6,3,3) 
Real(dp) :: RMsqTreeSuToFuFv(6,3,3),RMsqWaveSuToFuFv(6,3,3),RMsqVertexSuToFuFv(6,3,3) 
Complex(dp) :: AmpTreeSuToFuFv(2,6,3,3),AmpWaveSuToFuFv(2,6,3,3),AmpVertexSuToFuFv(2,6,3,3)& 
 & ,AmpVertexIRosSuToFuFv(2,6,3,3),AmpVertexIRdrSuToFuFv(2,6,3,3), AmpSumSuToFuFv(2,6,3,3), AmpSum2SuToFuFv(2,6,3,3) 
Complex(dp) :: AmpTreeZSuToFuFv(2,6,3,3),AmpWaveZSuToFuFv(2,6,3,3),AmpVertexZSuToFuFv(2,6,3,3) 
Real(dp) :: AmpSqSuToFuFv(6,3,3),  AmpSqTreeSuToFuFv(6,3,3) 
Real(dp) :: MRPSuToSuSv(6,6,3),MRGSuToSuSv(6,6,3), MRPZSuToSuSv(6,6,3),MRGZSuToSuSv(6,6,3) 
Real(dp) :: MVPSuToSuSv(6,6,3) 
Real(dp) :: RMsqTreeSuToSuSv(6,6,3),RMsqWaveSuToSuSv(6,6,3),RMsqVertexSuToSuSv(6,6,3) 
Complex(dp) :: AmpTreeSuToSuSv(6,6,3),AmpWaveSuToSuSv(6,6,3),AmpVertexSuToSuSv(6,6,3)& 
 & ,AmpVertexIRosSuToSuSv(6,6,3),AmpVertexIRdrSuToSuSv(6,6,3), AmpSumSuToSuSv(6,6,3), AmpSum2SuToSuSv(6,6,3) 
Complex(dp) :: AmpTreeZSuToSuSv(6,6,3),AmpWaveZSuToSuSv(6,6,3),AmpVertexZSuToSuSv(6,6,3) 
Real(dp) :: AmpSqSuToSuSv(6,6,3),  AmpSqTreeSuToSuSv(6,6,3) 
Real(dp) :: MRPSuToSuVG(6,6),MRGSuToSuVG(6,6), MRPZSuToSuVG(6,6),MRGZSuToSuVG(6,6) 
Real(dp) :: MVPSuToSuVG(6,6) 
Real(dp) :: RMsqTreeSuToSuVG(6,6),RMsqWaveSuToSuVG(6,6),RMsqVertexSuToSuVG(6,6) 
Complex(dp) :: AmpTreeSuToSuVG(2,6,6),AmpWaveSuToSuVG(2,6,6),AmpVertexSuToSuVG(2,6,6)& 
 & ,AmpVertexIRosSuToSuVG(2,6,6),AmpVertexIRdrSuToSuVG(2,6,6), AmpSumSuToSuVG(2,6,6), AmpSum2SuToSuVG(2,6,6) 
Complex(dp) :: AmpTreeZSuToSuVG(2,6,6),AmpWaveZSuToSuVG(2,6,6),AmpVertexZSuToSuVG(2,6,6) 
Real(dp) :: AmpSqSuToSuVG(6,6),  AmpSqTreeSuToSuVG(6,6) 
Real(dp) :: MRPSuToSuVP(6,6),MRGSuToSuVP(6,6), MRPZSuToSuVP(6,6),MRGZSuToSuVP(6,6) 
Real(dp) :: MVPSuToSuVP(6,6) 
Real(dp) :: RMsqTreeSuToSuVP(6,6),RMsqWaveSuToSuVP(6,6),RMsqVertexSuToSuVP(6,6) 
Complex(dp) :: AmpTreeSuToSuVP(2,6,6),AmpWaveSuToSuVP(2,6,6),AmpVertexSuToSuVP(2,6,6)& 
 & ,AmpVertexIRosSuToSuVP(2,6,6),AmpVertexIRdrSuToSuVP(2,6,6), AmpSumSuToSuVP(2,6,6), AmpSum2SuToSuVP(2,6,6) 
Complex(dp) :: AmpTreeZSuToSuVP(2,6,6),AmpWaveZSuToSuVP(2,6,6),AmpVertexZSuToSuVP(2,6,6) 
Real(dp) :: AmpSqSuToSuVP(6,6),  AmpSqTreeSuToSuVP(6,6) 
Real(dp) :: MRPSuToSucSv(6,6,3),MRGSuToSucSv(6,6,3), MRPZSuToSucSv(6,6,3),MRGZSuToSucSv(6,6,3) 
Real(dp) :: MVPSuToSucSv(6,6,3) 
Real(dp) :: RMsqTreeSuToSucSv(6,6,3),RMsqWaveSuToSucSv(6,6,3),RMsqVertexSuToSucSv(6,6,3) 
Complex(dp) :: AmpTreeSuToSucSv(6,6,3),AmpWaveSuToSucSv(6,6,3),AmpVertexSuToSucSv(6,6,3)& 
 & ,AmpVertexIRosSuToSucSv(6,6,3),AmpVertexIRdrSuToSucSv(6,6,3), AmpSumSuToSucSv(6,6,3), AmpSum2SuToSucSv(6,6,3) 
Complex(dp) :: AmpTreeZSuToSucSv(6,6,3),AmpWaveZSuToSucSv(6,6,3),AmpVertexZSuToSucSv(6,6,3) 
Real(dp) :: AmpSqSuToSucSv(6,6,3),  AmpSqTreeSuToSucSv(6,6,3) 
Write(*,*) "Calculating one-loop decays of Su " 
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
! Su Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuToSuAh(cplAhSucSu,MAh,MSu,MAh2,MSu2,AmpTreeSuToSuAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuToSuAh(ZcplAhSucSu,MAh,MSu,MAh2,MSu2,AmpTreeSuToSuAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuAh(MLambda,em,gs,cplAhSucSu,MAhOS,MSuOS,             & 
& MRPSuToSuAh,MRGSuToSuAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuAh(MLambda,em,gs,ZcplAhSucSu,MAhOS,MSuOS,            & 
& MRPSuToSuAh,MRGSuToSuAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuToSuAh(MLambda,em,gs,cplAhSucSu,MAh,MSu,MRPSuToSuAh,     & 
& MRGSuToSuAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuAh(MLambda,em,gs,ZcplAhSucSu,MAh,MSu,MRPSuToSuAh,    & 
& MRGSuToSuAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuAh(cplAhSucSu,ctcplAhSucSu,MAh,MAh2,             & 
& MSu,MSu2,ZfAh,ZfSu,AmpWaveSuToSuAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuAh(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,cplChiFucSuL,cplChiFucSuR,           & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhSucSu,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,               & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplAhHpmSucSdaa,           & 
& cplAhSdcHpmcSuaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,AmpVertexSuToSuAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,   & 
& cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,& 
& AmpVertexIRdrSuToSuAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,ZcplAhSucSu,     & 
& cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,        & 
& cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,            & 
& cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,               & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,     & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,  & 
& cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,AmpVertexIRosSuToSuAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,ZcplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,              & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,   & 
& cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,& 
& AmpVertexIRosSuToSuAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,        & 
& cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,            & 
& cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,               & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,     & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,  & 
& cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,AmpVertexIRosSuToSuAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,   & 
& cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,& 
& AmpVertexIRosSuToSuAh)

 End if 
 End if 
AmpVertexSuToSuAh = AmpVertexSuToSuAh -  AmpVertexIRdrSuToSuAh! +  AmpVertexIRosSuToSuAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuToSuAh=0._dp 
AmpVertexZSuToSuAh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSuAh(gt2,:,:) = AmpWaveZSuToSuAh(gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuToSuAh(gt1,:,:) 
AmpVertexZSuToSuAh(gt2,:,:)= AmpVertexZSuToSuAh(gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuToSuAh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSuToSuAh=AmpWaveZSuToSuAh 
AmpVertexSuToSuAh= AmpVertexZSuToSuAh
! Final State 1 
AmpWaveZSuToSuAh=0._dp 
AmpVertexZSuToSuAh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSuAh(:,gt2,:) = AmpWaveZSuToSuAh(:,gt2,:)+ZRUZU(gt2,gt1)*AmpWaveSuToSuAh(:,gt1,:) 
AmpVertexZSuToSuAh(:,gt2,:)= AmpVertexZSuToSuAh(:,gt2,:)+ZRUZU(gt2,gt1)*AmpVertexSuToSuAh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuToSuAh=AmpWaveZSuToSuAh 
AmpVertexSuToSuAh= AmpVertexZSuToSuAh
! Final State 2 
AmpWaveZSuToSuAh=0._dp 
AmpVertexZSuToSuAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSuToSuAh(:,:,gt2) = AmpWaveZSuToSuAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveSuToSuAh(:,:,gt1) 
AmpVertexZSuToSuAh(:,:,gt2)= AmpVertexZSuToSuAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexSuToSuAh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSuToSuAh=AmpWaveZSuToSuAh 
AmpVertexSuToSuAh= AmpVertexZSuToSuAh
End if
If (ShiftIRdiv) Then 
AmpVertexSuToSuAh = AmpVertexSuToSuAh  +  AmpVertexIRosSuToSuAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuToSuAh = AmpTreeSuToSuAh 
 AmpSum2SuToSuAh = AmpTreeSuToSuAh + 2._dp*AmpWaveSuToSuAh + 2._dp*AmpVertexSuToSuAh  
Else 
 AmpSumSuToSuAh = AmpTreeSuToSuAh + AmpWaveSuToSuAh + AmpVertexSuToSuAh
 AmpSum2SuToSuAh = AmpTreeSuToSuAh + AmpWaveSuToSuAh + AmpVertexSuToSuAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSuAh = AmpTreeSuToSuAh
 AmpSum2SuToSuAh = AmpTreeSuToSuAh 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=2,2
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuToSuAh = AmpTreeSuToSuAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MAh(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuToSuAh(gt1, gt2, gt3) 
  AmpSum2SuToSuAh = 2._dp*AmpWaveSuToSuAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MAh(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuToSuAh(gt1, gt2, gt3) 
  AmpSum2SuToSuAh = 2._dp*AmpVertexSuToSuAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MAh(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuToSuAh(gt1, gt2, gt3) 
  AmpSum2SuToSuAh = AmpTreeSuToSuAh + 2._dp*AmpWaveSuToSuAh + 2._dp*AmpVertexSuToSuAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MAh(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuToSuAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuToSuAh = AmpTreeSuToSuAh
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
  AmpSqTreeSuToSuAh(gt1, gt2, gt3) = (1)*AmpSqSuToSuAh(gt1, gt2, gt3)  
  AmpSum2SuToSuAh = + 2._dp*AmpWaveSuToSuAh + 2._dp*AmpVertexSuToSuAh
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
  AmpSqSuToSuAh(gt1, gt2, gt3) = AmpSqSuToSuAh(gt1, gt2, gt3) + AmpSqTreeSuToSuAh(gt1, gt2, gt3)  
Else  
  AmpSum2SuToSuAh = AmpTreeSuToSuAh
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MAh(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
  AmpSqTreeSuToSuAh(gt1, gt2, gt3) = (1)*AmpSqSuToSuAh(gt1, gt2, gt3)  
  AmpSum2SuToSuAh = + 2._dp*AmpWaveSuToSuAh + 2._dp*AmpVertexSuToSuAh
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MAh(gt3),AmpSumSuToSuAh(gt1, gt2, gt3),AmpSum2SuToSuAh(gt1, gt2, gt3),AmpSqSuToSuAh(gt1, gt2, gt3)) 
  AmpSqSuToSuAh(gt1, gt2, gt3) = AmpSqSuToSuAh(gt1, gt2, gt3) + AmpSqTreeSuToSuAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuToSuAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSuAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),MAhOS(gt3),helfactor*AmpSqSuToSuAh(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),MAh(gt3),helfactor*AmpSqSuToSuAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuToSuAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuToSuAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToSuAh(gt1, gt2, gt3) + MRGSuToSuAh(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToSuAh(gt1, gt2, gt3) + MRGSuToSuAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Fu Chi
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuToFuChi(cplChiFucSuL,cplChiFucSuR,MChi,              & 
& MFu,MSu,MChi2,MFu2,MSu2,AmpTreeSuToFuChi)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuToFuChi(ZcplChiFucSuL,ZcplChiFucSuR,MChi,            & 
& MFu,MSu,MChi2,MFu2,MSu2,AmpTreeSuToFuChi)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToFuChi(MLambda,em,gs,cplChiFucSuL,cplChiFucSuR,         & 
& MChiOS,MFuOS,MSuOS,MRPSuToFuChi,MRGSuToFuChi)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToFuChi(MLambda,em,gs,ZcplChiFucSuL,ZcplChiFucSuR,       & 
& MChiOS,MFuOS,MSuOS,MRPSuToFuChi,MRGSuToFuChi)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuToFuChi(MLambda,em,gs,cplChiFucSuL,cplChiFucSuR,         & 
& MChi,MFu,MSu,MRPSuToFuChi,MRGSuToFuChi)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToFuChi(MLambda,em,gs,ZcplChiFucSuL,ZcplChiFucSuR,       & 
& MChi,MFu,MSu,MRPSuToFuChi,MRGSuToFuChi)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToFuChi(cplChiFucSuL,cplChiFucSuR,ctcplChiFucSuL,    & 
& ctcplChiFucSuR,MChi,MChi2,MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,ZfL0,ZfSu,AmpWaveSuToFuChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToFuChi(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,              & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,              & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexSuToFuChi)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,              & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRdrSuToFuChi)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,   & 
& cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,ZcplChiFucSuL,ZcplChiFucSuR,cplcChaChiHpmL,     & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,   & 
& cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,               & 
& cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToFuChi)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,ZcplChiFucSuL,        & 
& ZcplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,    & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,              & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToFuChi)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,   & 
& cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,       & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,   & 
& cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,             & 
& cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,               & 
& cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToFuChi)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,              & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToFuChi)

 End if 
 End if 
AmpVertexSuToFuChi = AmpVertexSuToFuChi -  AmpVertexIRdrSuToFuChi! +  AmpVertexIRosSuToFuChi ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuToFuChi=0._dp 
AmpVertexZSuToFuChi=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToFuChi(:,gt2,:,:) = AmpWaveZSuToFuChi(:,gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuToFuChi(:,gt1,:,:) 
AmpVertexZSuToFuChi(:,gt2,:,:)= AmpVertexZSuToFuChi(:,gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuToFuChi(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSuToFuChi=AmpWaveZSuToFuChi 
AmpVertexSuToFuChi= AmpVertexZSuToFuChi
! Final State 1 
AmpWaveZSuToFuChi=0._dp 
AmpVertexZSuToFuChi=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSuToFuChi(1,:,gt2,:) = AmpWaveZSuToFuChi(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpWaveSuToFuChi(1,:,gt1,:) 
AmpVertexZSuToFuChi(1,:,gt2,:)= AmpVertexZSuToFuChi(1,:,gt2,:)+ZRUZUL(gt2,gt1)*AmpVertexSuToFuChi(1,:,gt1,:) 
AmpWaveZSuToFuChi(2,:,gt2,:) = AmpWaveZSuToFuChi(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpWaveSuToFuChi(2,:,gt1,:) 
AmpVertexZSuToFuChi(2,:,gt2,:)= AmpVertexZSuToFuChi(2,:,gt2,:)+ZRUZURc(gt2,gt1)*AmpVertexSuToFuChi(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSuToFuChi=AmpWaveZSuToFuChi 
AmpVertexSuToFuChi= AmpVertexZSuToFuChi
! Final State 2 
AmpWaveZSuToFuChi=0._dp 
AmpVertexZSuToFuChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZSuToFuChi(1,:,:,gt2) = AmpWaveZSuToFuChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSuToFuChi(1,:,:,gt1) 
AmpVertexZSuToFuChi(1,:,:,gt2)= AmpVertexZSuToFuChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSuToFuChi(1,:,:,gt1) 
AmpWaveZSuToFuChi(2,:,:,gt2) = AmpWaveZSuToFuChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSuToFuChi(2,:,:,gt1) 
AmpVertexZSuToFuChi(2,:,:,gt2)= AmpVertexZSuToFuChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSuToFuChi(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSuToFuChi=AmpWaveZSuToFuChi 
AmpVertexSuToFuChi= AmpVertexZSuToFuChi
End if
If (ShiftIRdiv) Then 
AmpVertexSuToFuChi = AmpVertexSuToFuChi  +  AmpVertexIRosSuToFuChi
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Fu Chi -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuToFuChi = AmpTreeSuToFuChi 
 AmpSum2SuToFuChi = AmpTreeSuToFuChi + 2._dp*AmpWaveSuToFuChi + 2._dp*AmpVertexSuToFuChi  
Else 
 AmpSumSuToFuChi = AmpTreeSuToFuChi + AmpWaveSuToFuChi + AmpVertexSuToFuChi
 AmpSum2SuToFuChi = AmpTreeSuToFuChi + AmpWaveSuToFuChi + AmpVertexSuToFuChi 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToFuChi = AmpTreeSuToFuChi
 AmpSum2SuToFuChi = AmpTreeSuToFuChi 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,4
If (((OSkinematics).and.(MSuOS(gt1).gt.(MFuOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MFu(gt2)+MChi(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuToFuChi = AmpTreeSuToFuChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),MChi(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuToFuChi(gt1, gt2, gt3) 
  AmpSum2SuToFuChi = 2._dp*AmpWaveSuToFuChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),MChi(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuToFuChi(gt1, gt2, gt3) 
  AmpSum2SuToFuChi = 2._dp*AmpVertexSuToFuChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),MChi(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuToFuChi(gt1, gt2, gt3) 
  AmpSum2SuToFuChi = AmpTreeSuToFuChi + 2._dp*AmpWaveSuToFuChi + 2._dp*AmpVertexSuToFuChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),MChi(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuToFuChi(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuToFuChi = AmpTreeSuToFuChi
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
  AmpSqTreeSuToFuChi(gt1, gt2, gt3) = (1)*AmpSqSuToFuChi(gt1, gt2, gt3)  
  AmpSum2SuToFuChi = + 2._dp*AmpWaveSuToFuChi + 2._dp*AmpVertexSuToFuChi
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
  AmpSqSuToFuChi(gt1, gt2, gt3) = AmpSqSuToFuChi(gt1, gt2, gt3) + AmpSqTreeSuToFuChi(gt1, gt2, gt3)  
Else  
  AmpSum2SuToFuChi = AmpTreeSuToFuChi
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),MChi(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
  AmpSqTreeSuToFuChi(gt1, gt2, gt3) = (1)*AmpSqSuToFuChi(gt1, gt2, gt3)  
  AmpSum2SuToFuChi = + 2._dp*AmpWaveSuToFuChi + 2._dp*AmpVertexSuToFuChi
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),MChi(gt3),AmpSumSuToFuChi(:,gt1, gt2, gt3),AmpSum2SuToFuChi(:,gt1, gt2, gt3),AmpSqSuToFuChi(gt1, gt2, gt3)) 
  AmpSqSuToFuChi(gt1, gt2, gt3) = AmpSqSuToFuChi(gt1, gt2, gt3) + AmpSqTreeSuToFuChi(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuToFuChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSuToFuChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MFuOS(gt2),MChiOS(gt3),helfactor*AmpSqSuToFuChi(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MFu(gt2),MChi(gt3),helfactor*AmpSqSuToFuChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuToFuChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToFuChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuToFuChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToFuChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToFuChi(gt1, gt2, gt3) + MRGSuToFuChi(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToFuChi(gt1, gt2, gt3) + MRGSuToFuChi(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! bar(Cha) Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuTocChaFd(cplcChaFdcSuL,cplcChaFdcSuR,MCha,           & 
& MFd,MSu,MCha2,MFd2,MSu2,AmpTreeSuTocChaFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuTocChaFd(ZcplcChaFdcSuL,ZcplcChaFdcSuR,              & 
& MCha,MFd,MSu,MCha2,MFd2,MSu2,AmpTreeSuTocChaFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocChaFd(MLambda,em,gs,cplcChaFdcSuL,cplcChaFdcSuR,      & 
& MChaOS,MFdOS,MSuOS,MRPSuTocChaFd,MRGSuTocChaFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocChaFd(MLambda,em,gs,ZcplcChaFdcSuL,ZcplcChaFdcSuR,    & 
& MChaOS,MFdOS,MSuOS,MRPSuTocChaFd,MRGSuTocChaFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuTocChaFd(MLambda,em,gs,cplcChaFdcSuL,cplcChaFdcSuR,      & 
& MCha,MFd,MSu,MRPSuTocChaFd,MRGSuTocChaFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocChaFd(MLambda,em,gs,ZcplcChaFdcSuL,ZcplcChaFdcSuR,    & 
& MCha,MFd,MSu,MRPSuTocChaFd,MRGSuTocChaFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuTocChaFd(cplcChaFdcSuL,cplcChaFdcSuR,ctcplcChaFdcSuL,& 
& ctcplcChaFdcSuR,MCha,MCha2,MFd,MFd2,MSu,MSu2,ZfFDL,ZfFDR,ZfLm,ZfLp,ZfSu,               & 
& AmpWaveSuTocChaFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuTocChaFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR, & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,AmpVertexSuTocChaFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR, & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,AmpVertexIRdrSuTocChaFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,          & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,      & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,              & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,AmpVertexIRosSuTocChaFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR, & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,AmpVertexIRosSuTocChaFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,          & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,      & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,              & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,AmpVertexIRosSuTocChaFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,          & 
& cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR, & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,AmpVertexIRosSuTocChaFd)

 End if 
 End if 
AmpVertexSuTocChaFd = AmpVertexSuTocChaFd -  AmpVertexIRdrSuTocChaFd! +  AmpVertexIRosSuTocChaFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuTocChaFd=0._dp 
AmpVertexZSuTocChaFd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocChaFd(:,gt2,:,:) = AmpWaveZSuTocChaFd(:,gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuTocChaFd(:,gt1,:,:) 
AmpVertexZSuTocChaFd(:,gt2,:,:)= AmpVertexZSuTocChaFd(:,gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuTocChaFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSuTocChaFd=AmpWaveZSuTocChaFd 
AmpVertexSuTocChaFd= AmpVertexZSuTocChaFd
! Final State 1 
AmpWaveZSuTocChaFd=0._dp 
AmpVertexZSuTocChaFd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSuTocChaFd(1,:,gt2,:) = AmpWaveZSuTocChaFd(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveSuTocChaFd(1,:,gt1,:) 
AmpVertexZSuTocChaFd(1,:,gt2,:)= AmpVertexZSuTocChaFd(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpVertexSuTocChaFd(1,:,gt1,:) 
AmpWaveZSuTocChaFd(2,:,gt2,:) = AmpWaveZSuTocChaFd(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveSuTocChaFd(2,:,gt1,:) 
AmpVertexZSuTocChaFd(2,:,gt2,:)= AmpVertexZSuTocChaFd(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpVertexSuTocChaFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSuTocChaFd=AmpWaveZSuTocChaFd 
AmpVertexSuTocChaFd= AmpVertexZSuTocChaFd
! Final State 2 
AmpWaveZSuTocChaFd=0._dp 
AmpVertexZSuTocChaFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSuTocChaFd(1,:,:,gt2) = AmpWaveZSuTocChaFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveSuTocChaFd(1,:,:,gt1) 
AmpVertexZSuTocChaFd(1,:,:,gt2)= AmpVertexZSuTocChaFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexSuTocChaFd(1,:,:,gt1) 
AmpWaveZSuTocChaFd(2,:,:,gt2) = AmpWaveZSuTocChaFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveSuTocChaFd(2,:,:,gt1) 
AmpVertexZSuTocChaFd(2,:,:,gt2)= AmpVertexZSuTocChaFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexSuTocChaFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSuTocChaFd=AmpWaveZSuTocChaFd 
AmpVertexSuTocChaFd= AmpVertexZSuTocChaFd
End if
If (ShiftIRdiv) Then 
AmpVertexSuTocChaFd = AmpVertexSuTocChaFd  +  AmpVertexIRosSuTocChaFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->bar[Cha] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuTocChaFd = AmpTreeSuTocChaFd 
 AmpSum2SuTocChaFd = AmpTreeSuTocChaFd + 2._dp*AmpWaveSuTocChaFd + 2._dp*AmpVertexSuTocChaFd  
Else 
 AmpSumSuTocChaFd = AmpTreeSuTocChaFd + AmpWaveSuTocChaFd + AmpVertexSuTocChaFd
 AmpSum2SuTocChaFd = AmpTreeSuTocChaFd + AmpWaveSuTocChaFd + AmpVertexSuTocChaFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuTocChaFd = AmpTreeSuTocChaFd
 AmpSum2SuTocChaFd = AmpTreeSuTocChaFd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MSuOS(gt1).gt.(MChaOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MCha(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuTocChaFd = AmpTreeSuTocChaFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MCha(gt2),MFd(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuTocChaFd(gt1, gt2, gt3) 
  AmpSum2SuTocChaFd = 2._dp*AmpWaveSuTocChaFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MCha(gt2),MFd(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuTocChaFd(gt1, gt2, gt3) 
  AmpSum2SuTocChaFd = 2._dp*AmpVertexSuTocChaFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MCha(gt2),MFd(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuTocChaFd(gt1, gt2, gt3) 
  AmpSum2SuTocChaFd = AmpTreeSuTocChaFd + 2._dp*AmpWaveSuTocChaFd + 2._dp*AmpVertexSuTocChaFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MCha(gt2),MFd(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuTocChaFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuTocChaFd = AmpTreeSuTocChaFd
  Call SquareAmp_StoFF(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocChaFd(gt1, gt2, gt3) = (1)*AmpSqSuTocChaFd(gt1, gt2, gt3)  
  AmpSum2SuTocChaFd = + 2._dp*AmpWaveSuTocChaFd + 2._dp*AmpVertexSuTocChaFd
  Call SquareAmp_StoFF(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
  AmpSqSuTocChaFd(gt1, gt2, gt3) = AmpSqSuTocChaFd(gt1, gt2, gt3) + AmpSqTreeSuTocChaFd(gt1, gt2, gt3)  
Else  
  AmpSum2SuTocChaFd = AmpTreeSuTocChaFd
  Call SquareAmp_StoFF(MSu(gt1),MCha(gt2),MFd(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocChaFd(gt1, gt2, gt3) = (1)*AmpSqSuTocChaFd(gt1, gt2, gt3)  
  AmpSum2SuTocChaFd = + 2._dp*AmpWaveSuTocChaFd + 2._dp*AmpVertexSuTocChaFd
  Call SquareAmp_StoFF(MSu(gt1),MCha(gt2),MFd(gt3),AmpSumSuTocChaFd(:,gt1, gt2, gt3),AmpSum2SuTocChaFd(:,gt1, gt2, gt3),AmpSqSuTocChaFd(gt1, gt2, gt3)) 
  AmpSqSuTocChaFd(gt1, gt2, gt3) = AmpSqSuTocChaFd(gt1, gt2, gt3) + AmpSqTreeSuTocChaFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuTocChaFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSuTocChaFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MChaOS(gt2),MFdOS(gt3),helfactor*AmpSqSuTocChaFd(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MCha(gt2),MFd(gt3),helfactor*AmpSqSuTocChaFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuTocChaFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocChaFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuTocChaFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocChaFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocChaFd(gt1, gt2, gt3) + MRGSuTocChaFd(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocChaFd(gt1, gt2, gt3) + MRGSuTocChaFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! bar(Fe) Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuTocFeFd(cplcFeFdcSuL,cplcFeFdcSuR,MFd,               & 
& MFe,MSu,MFd2,MFe2,MSu2,AmpTreeSuTocFeFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuTocFeFd(ZcplcFeFdcSuL,ZcplcFeFdcSuR,MFd,             & 
& MFe,MSu,MFd2,MFe2,MSu2,AmpTreeSuTocFeFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocFeFd(MLambda,em,gs,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& MFdOS,MFeOS,MSuOS,MRPSuTocFeFd,MRGSuTocFeFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocFeFd(MLambda,em,gs,ZcplcFeFdcSuL,ZcplcFeFdcSuR,       & 
& MFdOS,MFeOS,MSuOS,MRPSuTocFeFd,MRGSuTocFeFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuTocFeFd(MLambda,em,gs,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& MFd,MFe,MSu,MRPSuTocFeFd,MRGSuTocFeFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocFeFd(MLambda,em,gs,ZcplcFeFdcSuL,ZcplcFeFdcSuR,       & 
& MFd,MFe,MSu,MRPSuTocFeFd,MRGSuTocFeFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuTocFeFd(cplcFeFdcSuL,cplcFeFdcSuR,ctcplcFeFdcSuL,    & 
& ctcplcFeFdcSuR,MFd,MFd2,MFe,MFe2,MSu,MSu2,ZfFDL,ZfFDR,ZfFEL,ZfFER,ZfSu,AmpWaveSuTocFeFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuTocFeFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,             & 
& cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,            & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,              & 
& cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,          & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,cplcFecFuSdR,            & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexSuTocFeFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,              & 
& cplSucSuVZ,AmpVertexIRdrSuTocFeFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,     & 
& cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,ZcplcFeFdcSuL,ZcplcFeFdcSuR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,           & 
& cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuTocFeFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& ZcplcFeFdcSuL,ZcplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,              & 
& cplSucSuVZ,AmpVertexIRosSuTocFeFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,     & 
& cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,           & 
& cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuTocFeFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,              & 
& cplSucSuVZ,AmpVertexIRosSuTocFeFd)

 End if 
 End if 
AmpVertexSuTocFeFd = AmpVertexSuTocFeFd -  AmpVertexIRdrSuTocFeFd! +  AmpVertexIRosSuTocFeFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuTocFeFd=0._dp 
AmpVertexZSuTocFeFd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocFeFd(:,gt2,:,:) = AmpWaveZSuTocFeFd(:,gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuTocFeFd(:,gt1,:,:) 
AmpVertexZSuTocFeFd(:,gt2,:,:)= AmpVertexZSuTocFeFd(:,gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuTocFeFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSuTocFeFd=AmpWaveZSuTocFeFd 
AmpVertexSuTocFeFd= AmpVertexZSuTocFeFd
! Final State 1 
AmpWaveZSuTocFeFd=0._dp 
AmpVertexZSuTocFeFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSuTocFeFd(1,:,gt2,:) = AmpWaveZSuTocFeFd(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpWaveSuTocFeFd(1,:,gt1,:) 
AmpVertexZSuTocFeFd(1,:,gt2,:)= AmpVertexZSuTocFeFd(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpVertexSuTocFeFd(1,:,gt1,:) 
AmpWaveZSuTocFeFd(2,:,gt2,:) = AmpWaveZSuTocFeFd(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpWaveSuTocFeFd(2,:,gt1,:) 
AmpVertexZSuTocFeFd(2,:,gt2,:)= AmpVertexZSuTocFeFd(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpVertexSuTocFeFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSuTocFeFd=AmpWaveZSuTocFeFd 
AmpVertexSuTocFeFd= AmpVertexZSuTocFeFd
! Final State 2 
AmpWaveZSuTocFeFd=0._dp 
AmpVertexZSuTocFeFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSuTocFeFd(1,:,:,gt2) = AmpWaveZSuTocFeFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveSuTocFeFd(1,:,:,gt1) 
AmpVertexZSuTocFeFd(1,:,:,gt2)= AmpVertexZSuTocFeFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexSuTocFeFd(1,:,:,gt1) 
AmpWaveZSuTocFeFd(2,:,:,gt2) = AmpWaveZSuTocFeFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveSuTocFeFd(2,:,:,gt1) 
AmpVertexZSuTocFeFd(2,:,:,gt2)= AmpVertexZSuTocFeFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexSuTocFeFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSuTocFeFd=AmpWaveZSuTocFeFd 
AmpVertexSuTocFeFd= AmpVertexZSuTocFeFd
End if
If (ShiftIRdiv) Then 
AmpVertexSuTocFeFd = AmpVertexSuTocFeFd  +  AmpVertexIRosSuTocFeFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->bar[Fe] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuTocFeFd = AmpTreeSuTocFeFd 
 AmpSum2SuTocFeFd = AmpTreeSuTocFeFd + 2._dp*AmpWaveSuTocFeFd + 2._dp*AmpVertexSuTocFeFd  
Else 
 AmpSumSuTocFeFd = AmpTreeSuTocFeFd + AmpWaveSuTocFeFd + AmpVertexSuTocFeFd
 AmpSum2SuTocFeFd = AmpTreeSuTocFeFd + AmpWaveSuTocFeFd + AmpVertexSuTocFeFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuTocFeFd = AmpTreeSuTocFeFd
 AmpSum2SuTocFeFd = AmpTreeSuTocFeFd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSuOS(gt1).gt.(MFeOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MFe(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuTocFeFd = AmpTreeSuTocFeFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFe(gt2),MFd(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuTocFeFd(gt1, gt2, gt3) 
  AmpSum2SuTocFeFd = 2._dp*AmpWaveSuTocFeFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFe(gt2),MFd(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuTocFeFd(gt1, gt2, gt3) 
  AmpSum2SuTocFeFd = 2._dp*AmpVertexSuTocFeFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFe(gt2),MFd(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuTocFeFd(gt1, gt2, gt3) 
  AmpSum2SuTocFeFd = AmpTreeSuTocFeFd + 2._dp*AmpWaveSuTocFeFd + 2._dp*AmpVertexSuTocFeFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFe(gt2),MFd(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuTocFeFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuTocFeFd = AmpTreeSuTocFeFd
  Call SquareAmp_StoFF(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocFeFd(gt1, gt2, gt3) = (1)*AmpSqSuTocFeFd(gt1, gt2, gt3)  
  AmpSum2SuTocFeFd = + 2._dp*AmpWaveSuTocFeFd + 2._dp*AmpVertexSuTocFeFd
  Call SquareAmp_StoFF(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
  AmpSqSuTocFeFd(gt1, gt2, gt3) = AmpSqSuTocFeFd(gt1, gt2, gt3) + AmpSqTreeSuTocFeFd(gt1, gt2, gt3)  
Else  
  AmpSum2SuTocFeFd = AmpTreeSuTocFeFd
  Call SquareAmp_StoFF(MSu(gt1),MFe(gt2),MFd(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocFeFd(gt1, gt2, gt3) = (1)*AmpSqSuTocFeFd(gt1, gt2, gt3)  
  AmpSum2SuTocFeFd = + 2._dp*AmpWaveSuTocFeFd + 2._dp*AmpVertexSuTocFeFd
  Call SquareAmp_StoFF(MSu(gt1),MFe(gt2),MFd(gt3),AmpSumSuTocFeFd(:,gt1, gt2, gt3),AmpSum2SuTocFeFd(:,gt1, gt2, gt3),AmpSqSuTocFeFd(gt1, gt2, gt3)) 
  AmpSqSuTocFeFd(gt1, gt2, gt3) = AmpSqSuTocFeFd(gt1, gt2, gt3) + AmpSqTreeSuTocFeFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuTocFeFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSuTocFeFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MFeOS(gt2),MFdOS(gt3),helfactor*AmpSqSuTocFeFd(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MFe(gt2),MFd(gt3),helfactor*AmpSqSuTocFeFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuTocFeFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocFeFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuTocFeFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocFeFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocFeFd(gt1, gt2, gt3) + MRGSuTocFeFd(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocFeFd(gt1, gt2, gt3) + MRGSuTocFeFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Glu Fu
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuToGluFu(cplGluFucSuL,cplGluFucSuR,MFu,               & 
& MGlu,MSu,MFu2,MGlu2,MSu2,AmpTreeSuToGluFu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuToGluFu(ZcplGluFucSuL,ZcplGluFucSuR,MFu,             & 
& MGlu,MSu,MFu2,MGlu2,MSu2,AmpTreeSuToGluFu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToGluFu(MLambda,em,gs,cplGluFucSuL,cplGluFucSuR,         & 
& MFuOS,MGluOS,MSuOS,MRPSuToGluFu,MRGSuToGluFu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToGluFu(MLambda,em,gs,ZcplGluFucSuL,ZcplGluFucSuR,       & 
& MFuOS,MGluOS,MSuOS,MRPSuToGluFu,MRGSuToGluFu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuToGluFu(MLambda,em,gs,cplGluFucSuL,cplGluFucSuR,         & 
& MFu,MGlu,MSu,MRPSuToGluFu,MRGSuToGluFu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToGluFu(MLambda,em,gs,ZcplGluFucSuL,ZcplGluFucSuR,       & 
& MFu,MGlu,MSu,MRPSuToGluFu,MRGSuToGluFu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToGluFu(cplGluFucSuL,cplGluFucSuR,ctcplGluFucSuL,    & 
& ctcplGluFucSuR,MFu,MFu2,MGlu,MGlu2,MSu,MSu2,ZffG,ZfFUL,ZfFUR,ZfSu,AmpWaveSuToGluFu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToGluFu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,     & 
& cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,cplGluFdcSdR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplSdcHpmcSu,           & 
& cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexSuToGluFu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRdrSuToGluFu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChaFucSdL,       & 
& cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,cplGluFdcSdR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,ZcplGluFucSuL,         & 
& ZcplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,           & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,           & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToGluFu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,ZcplGluFucSuL,ZcplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToGluFu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChaFucSdL,       & 
& cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,cplGluFdcSdR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,           & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToGluFu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,AmpVertexIRosSuToGluFu)

 End if 
 End if 
AmpVertexSuToGluFu = AmpVertexSuToGluFu -  AmpVertexIRdrSuToGluFu! +  AmpVertexIRosSuToGluFu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuToGluFu=0._dp 
AmpVertexZSuToGluFu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToGluFu(:,gt2,:) = AmpWaveZSuToGluFu(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWaveSuToGluFu(:,gt1,:) 
AmpVertexZSuToGluFu(:,gt2,:)= AmpVertexZSuToGluFu(:,gt2,:) + ZRUZUc(gt2,gt1)*AmpVertexSuToGluFu(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuToGluFu=AmpWaveZSuToGluFu 
AmpVertexSuToGluFu= AmpVertexZSuToGluFu
! Final State 2 
AmpWaveZSuToGluFu=0._dp 
AmpVertexZSuToGluFu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSuToGluFu(1,:,gt2) = AmpWaveZSuToGluFu(1,:,gt2)+ZRUZUL(gt2,gt1)*AmpWaveSuToGluFu(1,:,gt1) 
AmpVertexZSuToGluFu(1,:,gt2)= AmpVertexZSuToGluFu(1,:,gt2)+ZRUZUL(gt2,gt1)*AmpVertexSuToGluFu(1,:,gt1) 
AmpWaveZSuToGluFu(2,:,gt2) = AmpWaveZSuToGluFu(2,:,gt2)+ZRUZUR(gt2,gt1)*AmpWaveSuToGluFu(2,:,gt1) 
AmpVertexZSuToGluFu(2,:,gt2)= AmpVertexZSuToGluFu(2,:,gt2)+ZRUZUR(gt2,gt1)*AmpVertexSuToGluFu(2,:,gt1) 
 End Do 
End Do 
AmpWaveSuToGluFu=AmpWaveZSuToGluFu 
AmpVertexSuToGluFu= AmpVertexZSuToGluFu
End if
If (ShiftIRdiv) Then 
AmpVertexSuToGluFu = AmpVertexSuToGluFu  +  AmpVertexIRosSuToGluFu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Glu Fu -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuToGluFu = AmpTreeSuToGluFu 
 AmpSum2SuToGluFu = AmpTreeSuToGluFu + 2._dp*AmpWaveSuToGluFu + 2._dp*AmpVertexSuToGluFu  
Else 
 AmpSumSuToGluFu = AmpTreeSuToGluFu + AmpWaveSuToGluFu + AmpVertexSuToGluFu
 AmpSum2SuToGluFu = AmpTreeSuToGluFu + AmpWaveSuToGluFu + AmpVertexSuToGluFu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToGluFu = AmpTreeSuToGluFu
 AmpSum2SuToGluFu = AmpTreeSuToGluFu 
End if 
Do gt1=1,6
i4 = isave 
    Do gt3=1,3
If (((OSkinematics).and.(MSuOS(gt1).gt.(MGluOS+MFuOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MGlu+MFu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt3 
  AmpSum2SuToGluFu = AmpTreeSuToGluFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MGluOS,MFuOS(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MGlu,MFu(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuToGluFu(gt1, gt3) 
  AmpSum2SuToGluFu = 2._dp*AmpWaveSuToGluFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MGluOS,MFuOS(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MGlu,MFu(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuToGluFu(gt1, gt3) 
  AmpSum2SuToGluFu = 2._dp*AmpVertexSuToGluFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MGluOS,MFuOS(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MGlu,MFu(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuToGluFu(gt1, gt3) 
  AmpSum2SuToGluFu = AmpTreeSuToGluFu + 2._dp*AmpWaveSuToGluFu + 2._dp*AmpVertexSuToGluFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MGluOS,MFuOS(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MGlu,MFu(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuToGluFu(gt1, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuToGluFu = AmpTreeSuToGluFu
  Call SquareAmp_StoFF(MSuOS(gt1),MGluOS,MFuOS(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
  AmpSqTreeSuToGluFu(gt1, gt3) = (4._dp/3._dp)*AmpSqSuToGluFu(gt1, gt3)  
  AmpSum2SuToGluFu = + 2._dp*AmpWaveSuToGluFu + 2._dp*AmpVertexSuToGluFu
  Call SquareAmp_StoFF(MSuOS(gt1),MGluOS,MFuOS(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
  AmpSqSuToGluFu(gt1, gt3) = AmpSqSuToGluFu(gt1, gt3) + AmpSqTreeSuToGluFu(gt1, gt3)  
Else  
  AmpSum2SuToGluFu = AmpTreeSuToGluFu
  Call SquareAmp_StoFF(MSu(gt1),MGlu,MFu(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
  AmpSqTreeSuToGluFu(gt1, gt3) = (4._dp/3._dp)*AmpSqSuToGluFu(gt1, gt3)  
  AmpSum2SuToGluFu = + 2._dp*AmpWaveSuToGluFu + 2._dp*AmpVertexSuToGluFu
  Call SquareAmp_StoFF(MSu(gt1),MGlu,MFu(gt3),AmpSumSuToGluFu(:,gt1, gt3),AmpSum2SuToGluFu(:,gt1, gt3),AmpSqSuToGluFu(gt1, gt3)) 
  AmpSqSuToGluFu(gt1, gt3) = AmpSqSuToGluFu(gt1, gt3) + AmpSqTreeSuToGluFu(gt1, gt3)  
End if  
Else  
  AmpSqSuToGluFu(gt1, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSuToGluFu(gt1, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MGluOS,MFuOS(gt3),helfactor*AmpSqSuToGluFu(gt1, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MGlu,MFu(gt3),helfactor*AmpSqSuToGluFu(gt1, gt3))
End if 
If ((Abs(MRPSuToGluFu(gt1, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToGluFu(gt1, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuToGluFu(gt1, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToGluFu(gt1, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToGluFu(gt1, gt3) + MRGSuToGluFu(gt1, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToGluFu(gt1, gt3) + MRGSuToGluFu(gt1, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Su hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuToSuhh(cplhhSucSu,Mhh,MSu,Mhh2,MSu2,AmpTreeSuToSuhh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuToSuhh(ZcplhhSucSu,Mhh,MSu,Mhh2,MSu2,AmpTreeSuToSuhh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuhh(MLambda,em,gs,cplhhSucSu,MhhOS,MSuOS,             & 
& MRPSuToSuhh,MRGSuToSuhh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuhh(MLambda,em,gs,ZcplhhSucSu,MhhOS,MSuOS,            & 
& MRPSuToSuhh,MRGSuToSuhh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuToSuhh(MLambda,em,gs,cplhhSucSu,Mhh,MSu,MRPSuToSuhh,     & 
& MRGSuToSuhh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuhh(MLambda,em,gs,ZcplhhSucSu,Mhh,MSu,MRPSuToSuhh,    & 
& MRGSuToSuhh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuhh(cplhhSucSu,ctcplhhSucSu,Mhh,Mhh2,             & 
& MSu,MSu2,Zfhh,ZfSu,AmpWaveSuToSuhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuhh(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,         & 
& cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,         & 
& cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdhhL,          & 
& cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFehhL,         & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,             & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,               & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa, & 
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexSuToSuhh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,     & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa, & 
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexIRdrSuToSuhh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhSucSu,          & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,              & 
& cplhhSecSe,ZcplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,     & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,cplhhSdcHpmcSuaa,             & 
& cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,  & 
& cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa,cplSucSucVWmVWmaa, & 
& cplSucSuVZVZaa,AmpVertexIRosSuToSuhh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,ZcplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,   & 
& cplhhVZVZ,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,     & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa, & 
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexIRosSuToSuhh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhSucSu,          & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,              & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,      & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,cplhhSdcHpmcSuaa,             & 
& cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,  & 
& cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa,cplSucSucVWmVWmaa, & 
& cplSucSuVZVZaa,AmpVertexIRosSuToSuhh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,     & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa, & 
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexIRosSuToSuhh)

 End if 
 End if 
AmpVertexSuToSuhh = AmpVertexSuToSuhh -  AmpVertexIRdrSuToSuhh! +  AmpVertexIRosSuToSuhh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuToSuhh=0._dp 
AmpVertexZSuToSuhh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSuhh(gt2,:,:) = AmpWaveZSuToSuhh(gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuToSuhh(gt1,:,:) 
AmpVertexZSuToSuhh(gt2,:,:)= AmpVertexZSuToSuhh(gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuToSuhh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSuToSuhh=AmpWaveZSuToSuhh 
AmpVertexSuToSuhh= AmpVertexZSuToSuhh
! Final State 1 
AmpWaveZSuToSuhh=0._dp 
AmpVertexZSuToSuhh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSuhh(:,gt2,:) = AmpWaveZSuToSuhh(:,gt2,:)+ZRUZU(gt2,gt1)*AmpWaveSuToSuhh(:,gt1,:) 
AmpVertexZSuToSuhh(:,gt2,:)= AmpVertexZSuToSuhh(:,gt2,:)+ZRUZU(gt2,gt1)*AmpVertexSuToSuhh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuToSuhh=AmpWaveZSuToSuhh 
AmpVertexSuToSuhh= AmpVertexZSuToSuhh
! Final State 2 
AmpWaveZSuToSuhh=0._dp 
AmpVertexZSuToSuhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSuToSuhh(:,:,gt2) = AmpWaveZSuToSuhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveSuToSuhh(:,:,gt1) 
AmpVertexZSuToSuhh(:,:,gt2)= AmpVertexZSuToSuhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexSuToSuhh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSuToSuhh=AmpWaveZSuToSuhh 
AmpVertexSuToSuhh= AmpVertexZSuToSuhh
End if
If (ShiftIRdiv) Then 
AmpVertexSuToSuhh = AmpVertexSuToSuhh  +  AmpVertexIRosSuToSuhh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuToSuhh = AmpTreeSuToSuhh 
 AmpSum2SuToSuhh = AmpTreeSuToSuhh + 2._dp*AmpWaveSuToSuhh + 2._dp*AmpVertexSuToSuhh  
Else 
 AmpSumSuToSuhh = AmpTreeSuToSuhh + AmpWaveSuToSuhh + AmpVertexSuToSuhh
 AmpSum2SuToSuhh = AmpTreeSuToSuhh + AmpWaveSuToSuhh + AmpVertexSuToSuhh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSuhh = AmpTreeSuToSuhh
 AmpSum2SuToSuhh = AmpTreeSuToSuhh 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,2
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuToSuhh = AmpTreeSuToSuhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),Mhh(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuToSuhh(gt1, gt2, gt3) 
  AmpSum2SuToSuhh = 2._dp*AmpWaveSuToSuhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),Mhh(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuToSuhh(gt1, gt2, gt3) 
  AmpSum2SuToSuhh = 2._dp*AmpVertexSuToSuhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),Mhh(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuToSuhh(gt1, gt2, gt3) 
  AmpSum2SuToSuhh = AmpTreeSuToSuhh + 2._dp*AmpWaveSuToSuhh + 2._dp*AmpVertexSuToSuhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),Mhh(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuToSuhh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuToSuhh = AmpTreeSuToSuhh
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
  AmpSqTreeSuToSuhh(gt1, gt2, gt3) = (1)*AmpSqSuToSuhh(gt1, gt2, gt3)  
  AmpSum2SuToSuhh = + 2._dp*AmpWaveSuToSuhh + 2._dp*AmpVertexSuToSuhh
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
  AmpSqSuToSuhh(gt1, gt2, gt3) = AmpSqSuToSuhh(gt1, gt2, gt3) + AmpSqTreeSuToSuhh(gt1, gt2, gt3)  
Else  
  AmpSum2SuToSuhh = AmpTreeSuToSuhh
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),Mhh(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
  AmpSqTreeSuToSuhh(gt1, gt2, gt3) = (1)*AmpSqSuToSuhh(gt1, gt2, gt3)  
  AmpSum2SuToSuhh = + 2._dp*AmpWaveSuToSuhh + 2._dp*AmpVertexSuToSuhh
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),Mhh(gt3),AmpSumSuToSuhh(gt1, gt2, gt3),AmpSum2SuToSuhh(gt1, gt2, gt3),AmpSqSuToSuhh(gt1, gt2, gt3)) 
  AmpSqSuToSuhh(gt1, gt2, gt3) = AmpSqSuToSuhh(gt1, gt2, gt3) + AmpSqTreeSuToSuhh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuToSuhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSuhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),MhhOS(gt3),helfactor*AmpSqSuToSuhh(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),Mhh(gt3),helfactor*AmpSqSuToSuhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuToSuhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuToSuhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToSuhh(gt1, gt2, gt3) + MRGSuToSuhh(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuToSuhh(gt1, gt2, gt3) + MRGSuToSuhh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Conjg(Hpm) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuTocHpmSd(cplSdcHpmcSu,MHpm,MSd,MSu,MHpm2,            & 
& MSd2,MSu2,AmpTreeSuTocHpmSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuTocHpmSd(ZcplSdcHpmcSu,MHpm,MSd,MSu,MHpm2,           & 
& MSd2,MSu2,AmpTreeSuTocHpmSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocHpmSd(MLambda,em,gs,cplSdcHpmcSu,MHpmOS,              & 
& MSdOS,MSuOS,MRPSuTocHpmSd,MRGSuTocHpmSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocHpmSd(MLambda,em,gs,ZcplSdcHpmcSu,MHpmOS,             & 
& MSdOS,MSuOS,MRPSuTocHpmSd,MRGSuTocHpmSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuTocHpmSd(MLambda,em,gs,cplSdcHpmcSu,MHpm,MSd,            & 
& MSu,MRPSuTocHpmSd,MRGSuTocHpmSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocHpmSd(MLambda,em,gs,ZcplSdcHpmcSu,MHpm,               & 
& MSd,MSu,MRPSuTocHpmSd,MRGSuTocHpmSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuTocHpmSd(cplSdcHpmcSu,ctcplSdcHpmcSu,MHpm,           & 
& MHpm2,MSd,MSd2,MSu,MSu2,ZfHpm,ZfSd,ZfSu,AmpWaveSuTocHpmSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuTocHpmSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
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
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,AmpVertexSuTocHpmSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRdrSuTocHpmSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,AmpVertexIRosSuTocHpmSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRosSuTocHpmSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,AmpVertexIRosSuTocHpmSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRosSuTocHpmSd)

 End if 
 End if 
AmpVertexSuTocHpmSd = AmpVertexSuTocHpmSd -  AmpVertexIRdrSuTocHpmSd! +  AmpVertexIRosSuTocHpmSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuTocHpmSd=0._dp 
AmpVertexZSuTocHpmSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocHpmSd(gt2,:,:) = AmpWaveZSuTocHpmSd(gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuTocHpmSd(gt1,:,:) 
AmpVertexZSuTocHpmSd(gt2,:,:)= AmpVertexZSuTocHpmSd(gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuTocHpmSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveSuTocHpmSd=AmpWaveZSuTocHpmSd 
AmpVertexSuTocHpmSd= AmpVertexZSuTocHpmSd
! Final State 1 
AmpWaveZSuTocHpmSd=0._dp 
AmpVertexZSuTocHpmSd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSuTocHpmSd(:,gt2,:) = AmpWaveZSuTocHpmSd(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveSuTocHpmSd(:,gt1,:) 
AmpVertexZSuTocHpmSd(:,gt2,:)= AmpVertexZSuTocHpmSd(:,gt2,:)+ZRUZP(gt2,gt1)*AmpVertexSuTocHpmSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuTocHpmSd=AmpWaveZSuTocHpmSd 
AmpVertexSuTocHpmSd= AmpVertexZSuTocHpmSd
! Final State 2 
AmpWaveZSuTocHpmSd=0._dp 
AmpVertexZSuTocHpmSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocHpmSd(:,:,gt2) = AmpWaveZSuTocHpmSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSuTocHpmSd(:,:,gt1) 
AmpVertexZSuTocHpmSd(:,:,gt2)= AmpVertexZSuTocHpmSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSuTocHpmSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveSuTocHpmSd=AmpWaveZSuTocHpmSd 
AmpVertexSuTocHpmSd= AmpVertexZSuTocHpmSd
End if
If (ShiftIRdiv) Then 
AmpVertexSuTocHpmSd = AmpVertexSuTocHpmSd  +  AmpVertexIRosSuTocHpmSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->conj[Hpm] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuTocHpmSd = AmpTreeSuTocHpmSd 
 AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd + 2._dp*AmpWaveSuTocHpmSd + 2._dp*AmpVertexSuTocHpmSd  
Else 
 AmpSumSuTocHpmSd = AmpTreeSuTocHpmSd + AmpWaveSuTocHpmSd + AmpVertexSuTocHpmSd
 AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd + AmpWaveSuTocHpmSd + AmpVertexSuTocHpmSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuTocHpmSd = AmpTreeSuTocHpmSd
 AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=2,2
    Do gt3=1,6
If (((OSkinematics).and.(MSuOS(gt1).gt.(MHpmOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MHpm(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MHpm(gt2),MSd(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuTocHpmSd(gt1, gt2, gt3) 
  AmpSum2SuTocHpmSd = 2._dp*AmpWaveSuTocHpmSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MHpm(gt2),MSd(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuTocHpmSd(gt1, gt2, gt3) 
  AmpSum2SuTocHpmSd = 2._dp*AmpVertexSuTocHpmSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MHpm(gt2),MSd(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuTocHpmSd(gt1, gt2, gt3) 
  AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd + 2._dp*AmpWaveSuTocHpmSd + 2._dp*AmpVertexSuTocHpmSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MHpm(gt2),MSd(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuTocHpmSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd
  Call SquareAmp_StoSS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocHpmSd(gt1, gt2, gt3) = (1)*AmpSqSuTocHpmSd(gt1, gt2, gt3)  
  AmpSum2SuTocHpmSd = + 2._dp*AmpWaveSuTocHpmSd + 2._dp*AmpVertexSuTocHpmSd
  Call SquareAmp_StoSS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
  AmpSqSuTocHpmSd(gt1, gt2, gt3) = AmpSqSuTocHpmSd(gt1, gt2, gt3) + AmpSqTreeSuTocHpmSd(gt1, gt2, gt3)  
Else  
  AmpSum2SuTocHpmSd = AmpTreeSuTocHpmSd
  Call SquareAmp_StoSS(MSu(gt1),MHpm(gt2),MSd(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocHpmSd(gt1, gt2, gt3) = (1)*AmpSqSuTocHpmSd(gt1, gt2, gt3)  
  AmpSum2SuTocHpmSd = + 2._dp*AmpWaveSuTocHpmSd + 2._dp*AmpVertexSuTocHpmSd
  Call SquareAmp_StoSS(MSu(gt1),MHpm(gt2),MSd(gt3),AmpSumSuTocHpmSd(gt1, gt2, gt3),AmpSum2SuTocHpmSd(gt1, gt2, gt3),AmpSqSuTocHpmSd(gt1, gt2, gt3)) 
  AmpSqSuTocHpmSd(gt1, gt2, gt3) = AmpSqSuTocHpmSd(gt1, gt2, gt3) + AmpSqTreeSuTocHpmSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuTocHpmSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuTocHpmSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MHpmOS(gt2),MSdOS(gt3),helfactor*AmpSqSuTocHpmSd(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MHpm(gt2),MSd(gt3),helfactor*AmpSqSuTocHpmSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuTocHpmSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocHpmSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuTocHpmSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocHpmSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocHpmSd(gt1, gt2, gt3) + MRGSuTocHpmSd(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocHpmSd(gt1, gt2, gt3) + MRGSuTocHpmSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Conjg(Se) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuTocSeSd(cplSdcSecSu,MSd,MSe,MSu,MSd2,MSe2,           & 
& MSu2,AmpTreeSuTocSeSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuTocSeSd(ZcplSdcSecSu,MSd,MSe,MSu,MSd2,               & 
& MSe2,MSu2,AmpTreeSuTocSeSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocSeSd(MLambda,em,gs,cplSdcSecSu,MSdOS,MSeOS,           & 
& MSuOS,MRPSuTocSeSd,MRGSuTocSeSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocSeSd(MLambda,em,gs,ZcplSdcSecSu,MSdOS,MSeOS,          & 
& MSuOS,MRPSuTocSeSd,MRGSuTocSeSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuTocSeSd(MLambda,em,gs,cplSdcSecSu,MSd,MSe,               & 
& MSu,MRPSuTocSeSd,MRGSuTocSeSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuTocSeSd(MLambda,em,gs,ZcplSdcSecSu,MSd,MSe,              & 
& MSu,MRPSuTocSeSd,MRGSuTocSeSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuTocSeSd(cplSdcSecSu,ctcplSdcSecSu,MSd,               & 
& MSd2,MSe,MSe2,MSu,MSu2,ZfSd,ZfSe,ZfSu,AmpWaveSuTocSeSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuTocSeSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,cplAhSecSe,       & 
& cplAhSucSu,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,           & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplGluFucSuL,           & 
& cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,             & 
& cplhhSecSe,cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,cplSucSuVZ,         & 
& cplSvcSeVWm,cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,cplHpmSucSecSuaa,         & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,cplSdcHpmcSucSvaa, & 
& cplSeSucSecSuaa,AmpVertexSuTocSeSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,             & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,       & 
& cplSucSuVZ,cplSvcSeVWm,cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,               & 
& cplHpmSucSecSuaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,AmpVertexIRdrSuTocSeSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplAhSecSe,cplAhSucSu,        & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSecSe,               & 
& cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcFecFuSdL,       & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,ZcplSdcSecSu,cplSdcSucVWm,cplSeSvcSe,            & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplSvcSeVWm,        & 
& cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,cplHpmSucSecSuaa,cplSdSecSdcSeaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,cplSdcHpmcSucSvaa,cplSeSucSecSuaa, & 
& AmpVertexIRosSuTocSeSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,             & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,ZcplSdcSecSu,            & 
& cplSdcSucVWm,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,       & 
& cplSucSuVZ,cplSvcSeVWm,cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,               & 
& cplHpmSucSecSuaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,AmpVertexIRosSuTocSeSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSdcSd,cplAhSecSe,cplAhSucSu,        & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSecSe,               & 
& cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcFecFuSdL,       & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSvcSe,             & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplSvcSeVWm,        & 
& cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,cplHpmSucSecSuaa,cplSdSecSdcSeaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,cplSdcHpmcSucSvaa,cplSeSucSecSuaa, & 
& AmpVertexIRosSuTocSeSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,             & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,       & 
& cplSucSuVZ,cplSvcSeVWm,cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,               & 
& cplHpmSucSecSuaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,AmpVertexIRosSuTocSeSd)

 End if 
 End if 
AmpVertexSuTocSeSd = AmpVertexSuTocSeSd -  AmpVertexIRdrSuTocSeSd! +  AmpVertexIRosSuTocSeSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuTocSeSd=0._dp 
AmpVertexZSuTocSeSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocSeSd(gt2,:,:) = AmpWaveZSuTocSeSd(gt2,:,:)+ZRUZUc(gt2,gt1)*AmpWaveSuTocSeSd(gt1,:,:) 
AmpVertexZSuTocSeSd(gt2,:,:)= AmpVertexZSuTocSeSd(gt2,:,:) + ZRUZUc(gt2,gt1)*AmpVertexSuTocSeSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveSuTocSeSd=AmpWaveZSuTocSeSd 
AmpVertexSuTocSeSd= AmpVertexZSuTocSeSd
! Final State 1 
AmpWaveZSuTocSeSd=0._dp 
AmpVertexZSuTocSeSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocSeSd(:,gt2,:) = AmpWaveZSuTocSeSd(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpWaveSuTocSeSd(:,gt1,:) 
AmpVertexZSuTocSeSd(:,gt2,:)= AmpVertexZSuTocSeSd(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpVertexSuTocSeSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuTocSeSd=AmpWaveZSuTocSeSd 
AmpVertexSuTocSeSd= AmpVertexZSuTocSeSd
! Final State 2 
AmpWaveZSuTocSeSd=0._dp 
AmpVertexZSuTocSeSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuTocSeSd(:,:,gt2) = AmpWaveZSuTocSeSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSuTocSeSd(:,:,gt1) 
AmpVertexZSuTocSeSd(:,:,gt2)= AmpVertexZSuTocSeSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSuTocSeSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveSuTocSeSd=AmpWaveZSuTocSeSd 
AmpVertexSuTocSeSd= AmpVertexZSuTocSeSd
End if
If (ShiftIRdiv) Then 
AmpVertexSuTocSeSd = AmpVertexSuTocSeSd  +  AmpVertexIRosSuTocSeSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->conj[Se] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuTocSeSd = AmpTreeSuTocSeSd 
 AmpSum2SuTocSeSd = AmpTreeSuTocSeSd + 2._dp*AmpWaveSuTocSeSd + 2._dp*AmpVertexSuTocSeSd  
Else 
 AmpSumSuTocSeSd = AmpTreeSuTocSeSd + AmpWaveSuTocSeSd + AmpVertexSuTocSeSd
 AmpSum2SuTocSeSd = AmpTreeSuTocSeSd + AmpWaveSuTocSeSd + AmpVertexSuTocSeSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuTocSeSd = AmpTreeSuTocSeSd
 AmpSum2SuTocSeSd = AmpTreeSuTocSeSd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSeOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSe(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SuTocSeSd = AmpTreeSuTocSeSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSe(gt2),MSd(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuTocSeSd(gt1, gt2, gt3) 
  AmpSum2SuTocSeSd = 2._dp*AmpWaveSuTocSeSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSe(gt2),MSd(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuTocSeSd(gt1, gt2, gt3) 
  AmpSum2SuTocSeSd = 2._dp*AmpVertexSuTocSeSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSe(gt2),MSd(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuTocSeSd(gt1, gt2, gt3) 
  AmpSum2SuTocSeSd = AmpTreeSuTocSeSd + 2._dp*AmpWaveSuTocSeSd + 2._dp*AmpVertexSuTocSeSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSe(gt2),MSd(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuTocSeSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuTocSeSd = AmpTreeSuTocSeSd
  Call SquareAmp_StoSS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocSeSd(gt1, gt2, gt3) = (1)*AmpSqSuTocSeSd(gt1, gt2, gt3)  
  AmpSum2SuTocSeSd = + 2._dp*AmpWaveSuTocSeSd + 2._dp*AmpVertexSuTocSeSd
  Call SquareAmp_StoSS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
  AmpSqSuTocSeSd(gt1, gt2, gt3) = AmpSqSuTocSeSd(gt1, gt2, gt3) + AmpSqTreeSuTocSeSd(gt1, gt2, gt3)  
Else  
  AmpSum2SuTocSeSd = AmpTreeSuTocSeSd
  Call SquareAmp_StoSS(MSu(gt1),MSe(gt2),MSd(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
  AmpSqTreeSuTocSeSd(gt1, gt2, gt3) = (1)*AmpSqSuTocSeSd(gt1, gt2, gt3)  
  AmpSum2SuTocSeSd = + 2._dp*AmpWaveSuTocSeSd + 2._dp*AmpVertexSuTocSeSd
  Call SquareAmp_StoSS(MSu(gt1),MSe(gt2),MSd(gt3),AmpSumSuTocSeSd(gt1, gt2, gt3),AmpSum2SuTocSeSd(gt1, gt2, gt3),AmpSqSuTocSeSd(gt1, gt2, gt3)) 
  AmpSqSuTocSeSd(gt1, gt2, gt3) = AmpSqSuTocSeSd(gt1, gt2, gt3) + AmpSqTreeSuTocSeSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSuTocSeSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuTocSeSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSeOS(gt2),MSdOS(gt3),helfactor*AmpSqSuTocSeSd(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSe(gt2),MSd(gt3),helfactor*AmpSqSuTocSeSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuTocSeSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocSeSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuTocSeSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuTocSeSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocSeSd(gt1, gt2, gt3) + MRGSuTocSeSd(gt1, gt2, gt3)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSuTocSeSd(gt1, gt2, gt3) + MRGSuTocSeSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Sd Conjg(VWm)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuToSdcVWm(cplSdcSucVWm,MSd,MSu,MVWm,MSd2,             & 
& MSu2,MVWm2,AmpTreeSuToSdcVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuToSdcVWm(ZcplSdcSucVWm,MSd,MSu,MVWm,MSd2,            & 
& MSu2,MVWm2,AmpTreeSuToSdcVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSdcVWm(MLambda,em,gs,cplSdcSucVWm,MSdOS,               & 
& MSuOS,MVWmOS,MRPSuToSdcVWm,MRGSuToSdcVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSdcVWm(MLambda,em,gs,ZcplSdcSucVWm,MSdOS,              & 
& MSuOS,MVWmOS,MRPSuToSdcVWm,MRGSuToSdcVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuToSdcVWm(MLambda,em,gs,cplSdcSucVWm,MSd,MSu,             & 
& MVWm,MRPSuToSdcVWm,MRGSuToSdcVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSdcVWm(MLambda,em,gs,ZcplSdcSucVWm,MSd,MSu,            & 
& MVWm,MRPSuToSdcVWm,MRGSuToSdcVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSdcVWm(cplSdcSucVWm,ctcplSdcSucVWm,MSd,            & 
& MSd2,MSu,MSu2,MVWm,MVWm2,ZfSd,ZfSu,ZfVWm,AmpWaveSuToSdcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSdcSd,     & 
& cplAhSucSu,cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,       & 
& cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,         & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,              & 
& cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,               & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,          & 
& cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,cplcVWmVWmVZ,               & 
& cplSdcSucVWmVGLamct4ct2ct1,cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,cplSdcSucVWmVZaa,        & 
& cplSucSucVWmVWmaa,AmpVertexSuToSdcVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSucSu,cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,             & 
& cplhhSucSu,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,               & 
& cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,               & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1,cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,            & 
& cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,AmpVertexIRdrSuToSdcVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,      & 
& cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplhhcVWmVWm,             & 
& GosZcplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,             & 
& cplcChacFuSdL,cplcChacFuSdR,GosZcplSdcHpmcSu,cplSdcSecSu,ZcplSdcSucVWm,cplSecSvcVWm,   & 
& cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1, & 
& cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,AmpVertexIRosSuToSdcVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSucSu,cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,             & 
& cplhhSucSu,cplhhcVWmVWm,GZcplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,             & 
& cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,GZcplSdcHpmcSu,cplSdcSecSu,          & 
& ZcplSdcSucVWm,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,              & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1,cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,            & 
& cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,AmpVertexIRosSuToSdcVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,      & 
& cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplhhcVWmVWm,             & 
& GcplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,  & 
& cplcChacFuSdR,GcplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSecSvcVWm,cplSucSuVG,          & 
& cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1,            & 
& cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,AmpVertexIRosSuToSdcVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSucSu,cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,             & 
& cplhhSucSu,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,               & 
& cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,               & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1,cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,            & 
& cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,AmpVertexIRosSuToSdcVWm)

 End if 
 End if 
AmpVertexSuToSdcVWm = AmpVertexSuToSdcVWm -  AmpVertexIRdrSuToSdcVWm! +  AmpVertexIRosSuToSdcVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuToSdcVWm=0._dp 
AmpVertexZSuToSdcVWm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSdcVWm(:,gt2,:) = AmpWaveZSuToSdcVWm(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWaveSuToSdcVWm(:,gt1,:) 
AmpVertexZSuToSdcVWm(:,gt2,:)= AmpVertexZSuToSdcVWm(:,gt2,:) + ZRUZUc(gt2,gt1)*AmpVertexSuToSdcVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuToSdcVWm=AmpWaveZSuToSdcVWm 
AmpVertexSuToSdcVWm= AmpVertexZSuToSdcVWm
! Final State 1 
AmpWaveZSuToSdcVWm=0._dp 
AmpVertexZSuToSdcVWm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSdcVWm(:,:,gt2) = AmpWaveZSuToSdcVWm(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSuToSdcVWm(:,:,gt1) 
AmpVertexZSuToSdcVWm(:,:,gt2)= AmpVertexZSuToSdcVWm(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSuToSdcVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveSuToSdcVWm=AmpWaveZSuToSdcVWm 
AmpVertexSuToSdcVWm= AmpVertexZSuToSdcVWm
End if
If (ShiftIRdiv) Then 
AmpVertexSuToSdcVWm = AmpVertexSuToSdcVWm  +  AmpVertexIRosSuToSdcVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Sd conj[VWm] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuToSdcVWm = AmpTreeSuToSdcVWm 
 AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm + 2._dp*AmpWaveSuToSdcVWm + 2._dp*AmpVertexSuToSdcVWm  
Else 
 AmpSumSuToSdcVWm = AmpTreeSuToSdcVWm + AmpWaveSuToSdcVWm + AmpVertexSuToSdcVWm
 AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm + AmpWaveSuToSdcVWm + AmpVertexSuToSdcVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSdcVWm = AmpTreeSuToSdcVWm
 AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSdOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSd(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSdOS(gt2),MVWmOS,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSd(gt2),MVWm,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuToSdcVWm(gt1, gt2) 
  AmpSum2SuToSdcVWm = 2._dp*AmpWaveSuToSdcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSdOS(gt2),MVWmOS,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSd(gt2),MVWm,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuToSdcVWm(gt1, gt2) 
  AmpSum2SuToSdcVWm = 2._dp*AmpVertexSuToSdcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSdOS(gt2),MVWmOS,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSd(gt2),MVWm,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuToSdcVWm(gt1, gt2) 
  AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm + 2._dp*AmpWaveSuToSdcVWm + 2._dp*AmpVertexSuToSdcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSdOS(gt2),MVWmOS,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSd(gt2),MVWm,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuToSdcVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm
  Call SquareAmp_StoSV(MSuOS(gt1),MSdOS(gt2),MVWmOS,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
  AmpSqTreeSuToSdcVWm(gt1, gt2) = (1)*AmpSqSuToSdcVWm(gt1, gt2)  
  AmpSum2SuToSdcVWm = + 2._dp*AmpWaveSuToSdcVWm + 2._dp*AmpVertexSuToSdcVWm
  Call SquareAmp_StoSV(MSuOS(gt1),MSdOS(gt2),MVWmOS,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
  AmpSqSuToSdcVWm(gt1, gt2) = AmpSqSuToSdcVWm(gt1, gt2) + AmpSqTreeSuToSdcVWm(gt1, gt2)  
Else  
  AmpSum2SuToSdcVWm = AmpTreeSuToSdcVWm
  Call SquareAmp_StoSV(MSu(gt1),MSd(gt2),MVWm,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
  AmpSqTreeSuToSdcVWm(gt1, gt2) = (1)*AmpSqSuToSdcVWm(gt1, gt2)  
  AmpSum2SuToSdcVWm = + 2._dp*AmpWaveSuToSdcVWm + 2._dp*AmpVertexSuToSdcVWm
  Call SquareAmp_StoSV(MSu(gt1),MSd(gt2),MVWm,AmpSumSuToSdcVWm(:,gt1, gt2),AmpSum2SuToSdcVWm(:,gt1, gt2),AmpSqSuToSdcVWm(gt1, gt2)) 
  AmpSqSuToSdcVWm(gt1, gt2) = AmpSqSuToSdcVWm(gt1, gt2) + AmpSqTreeSuToSdcVWm(gt1, gt2)  
End if  
Else  
  AmpSqSuToSdcVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSdcVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSdOS(gt2),MVWmOS,helfactor*AmpSqSuToSdcVWm(gt1, gt2))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSd(gt2),MVWm,helfactor*AmpSqSuToSdcVWm(gt1, gt2))
End if 
If ((Abs(MRPSuToSdcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSuToSdcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuToSdcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSuToSdcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSuToSdcVWm(gt1, gt2) + MRGSuToSdcVWm(gt1, gt2)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1*helfactor*(MRPSuToSdcVWm(gt1, gt2) + MRGSuToSdcVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
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
! Su VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SuToSuVZ(cplSucSuVZ,MSu,MVZ,MSu2,MVZ2,AmpTreeSuToSuVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SuToSuVZ(ZcplSucSuVZ,MSu,MVZ,MSu2,MVZ2,AmpTreeSuToSuVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuVZ(MLambda,em,gs,cplSucSuVZ,MSuOS,MVZOS,             & 
& MRPSuToSuVZ,MRGSuToSuVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuVZ(MLambda,em,gs,ZcplSucSuVZ,MSuOS,MVZOS,            & 
& MRPSuToSuVZ,MRGSuToSuVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SuToSuVZ(MLambda,em,gs,cplSucSuVZ,MSu,MVZ,MRPSuToSuVZ,     & 
& MRGSuToSuVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SuToSuVZ(MLambda,em,gs,ZcplSucSuVZ,MSu,MVZ,MRPSuToSuVZ,    & 
& MRGSuToSuVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVZ(cplSucSuVP,cplSucSuVZ,ctcplSucSuVP,           & 
& ctcplSucSuVZ,MSu,MSu2,MVP,MVP2,MVZ,MVZ2,ZfSu,ZfVPVZ,ZfVZ,AmpWaveSuToSuVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVZ(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSucSu,cplcFdChaSuL,      & 
& cplcFdChaSuR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFucSuL,       & 
& cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeVZL,           & 
& cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,            & 
& cplcFuGluSuR,cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,cplHpmcVWmVZ,               & 
& cplSdcSdVZ,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSuVG,     & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSucVWmVZaa,          & 
& cplSucSuVGVZLamct3ct2ct1,cplSucSuVPVZaa,cplSucSdVWmVZaa,cplSucSuVZVZaa,AmpVertexSuToSuVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSucSu,             & 
& cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,     & 
& cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,cplSucSuVPVZaa,cplSucSdVWmVZaa,              & 
& cplSucSuVZVZaa,AmpVertexIRdrSuToSuVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,        & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,       & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,    & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,      & 
& ZcplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,       & 
& cplSucSuVPVZaa,cplSucSdVWmVZaa,cplSucSuVZVZaa,AmpVertexIRosSuToSuVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSucSu,             & 
& cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,ZcplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,    & 
& cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,cplSucSuVPVZaa,cplSucSdVWmVZaa,              & 
& cplSucSuVZVZaa,AmpVertexIRosSuToSuVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,         & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,        & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,       & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,    & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,      & 
& cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,        & 
& cplSucSuVPVZaa,cplSucSdVWmVZaa,cplSucSuVZVZaa,AmpVertexIRosSuToSuVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSucSu,             & 
& cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,     & 
& cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,cplSucSuVPVZaa,cplSucSdVWmVZaa,              & 
& cplSucSuVZVZaa,AmpVertexIRosSuToSuVZ)

 End if 
 End if 
AmpVertexSuToSuVZ = AmpVertexSuToSuVZ -  AmpVertexIRdrSuToSuVZ! +  AmpVertexIRosSuToSuVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSuToSuVZ=0._dp 
AmpVertexZSuToSuVZ=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSuVZ(:,gt2,:) = AmpWaveZSuToSuVZ(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWaveSuToSuVZ(:,gt1,:) 
AmpVertexZSuToSuVZ(:,gt2,:)= AmpVertexZSuToSuVZ(:,gt2,:) + ZRUZUc(gt2,gt1)*AmpVertexSuToSuVZ(:,gt1,:) 
 End Do 
End Do 
AmpWaveSuToSuVZ=AmpWaveZSuToSuVZ 
AmpVertexSuToSuVZ= AmpVertexZSuToSuVZ
! Final State 1 
AmpWaveZSuToSuVZ=0._dp 
AmpVertexZSuToSuVZ=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSuToSuVZ(:,:,gt2) = AmpWaveZSuToSuVZ(:,:,gt2)+ZRUZU(gt2,gt1)*AmpWaveSuToSuVZ(:,:,gt1) 
AmpVertexZSuToSuVZ(:,:,gt2)= AmpVertexZSuToSuVZ(:,:,gt2)+ZRUZU(gt2,gt1)*AmpVertexSuToSuVZ(:,:,gt1) 
 End Do 
End Do 
AmpWaveSuToSuVZ=AmpWaveZSuToSuVZ 
AmpVertexSuToSuVZ= AmpVertexZSuToSuVZ
End if
If (ShiftIRdiv) Then 
AmpVertexSuToSuVZ = AmpVertexSuToSuVZ  +  AmpVertexIRosSuToSuVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSuToSuVZ = AmpTreeSuToSuVZ 
 AmpSum2SuToSuVZ = AmpTreeSuToSuVZ + 2._dp*AmpWaveSuToSuVZ + 2._dp*AmpVertexSuToSuVZ  
Else 
 AmpSumSuToSuVZ = AmpTreeSuToSuVZ + AmpWaveSuToSuVZ + AmpVertexSuToSuVZ
 AmpSum2SuToSuVZ = AmpTreeSuToSuVZ + AmpWaveSuToSuVZ + AmpVertexSuToSuVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSuVZ = AmpTreeSuToSuVZ
 AmpSum2SuToSuVZ = AmpTreeSuToSuVZ 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SuToSuVZ = AmpTreeSuToSuVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),MVZOS,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVZ,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSuToSuVZ(gt1, gt2) 
  AmpSum2SuToSuVZ = 2._dp*AmpWaveSuToSuVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),MVZOS,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVZ,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSuToSuVZ(gt1, gt2) 
  AmpSum2SuToSuVZ = 2._dp*AmpVertexSuToSuVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),MVZOS,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVZ,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSuToSuVZ(gt1, gt2) 
  AmpSum2SuToSuVZ = AmpTreeSuToSuVZ + 2._dp*AmpWaveSuToSuVZ + 2._dp*AmpVertexSuToSuVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),MVZOS,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVZ,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSuToSuVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SuToSuVZ = AmpTreeSuToSuVZ
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),MVZOS,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
  AmpSqTreeSuToSuVZ(gt1, gt2) = (1)*AmpSqSuToSuVZ(gt1, gt2)  
  AmpSum2SuToSuVZ = + 2._dp*AmpWaveSuToSuVZ + 2._dp*AmpVertexSuToSuVZ
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),MVZOS,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
  AmpSqSuToSuVZ(gt1, gt2) = AmpSqSuToSuVZ(gt1, gt2) + AmpSqTreeSuToSuVZ(gt1, gt2)  
Else  
  AmpSum2SuToSuVZ = AmpTreeSuToSuVZ
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVZ,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
  AmpSqTreeSuToSuVZ(gt1, gt2) = (1)*AmpSqSuToSuVZ(gt1, gt2)  
  AmpSum2SuToSuVZ = + 2._dp*AmpWaveSuToSuVZ + 2._dp*AmpVertexSuToSuVZ
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVZ,AmpSumSuToSuVZ(:,gt1, gt2),AmpSum2SuToSuVZ(:,gt1, gt2),AmpSqSuToSuVZ(gt1, gt2)) 
  AmpSqSuToSuVZ(gt1, gt2) = AmpSqSuToSuVZ(gt1, gt2) + AmpSqTreeSuToSuVZ(gt1, gt2)  
End if  
Else  
  AmpSqSuToSuVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSuVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),MVZOS,helfactor*AmpSqSuToSuVZ(gt1, gt2))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),MVZ,helfactor*AmpSqSuToSuVZ(gt1, gt2))
End if 
If ((Abs(MRPSuToSuVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSuToSuVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSuToSuVZ(gt1, gt2) + MRGSuToSuVZ(gt1, gt2)) 
  gP1LSu(gt1,i4) = gP1LSu(gt1,i4) + phasespacefactor*1*helfactor*(MRPSuToSuVZ(gt1, gt2) + MRGSuToSuVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSu(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
End If 
!---------------- 
! Fu Fv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SuToFuFv(MFuOS,MFu2OS,MSuOS,MSu2OS,ZfFUL,              & 
& ZfFUR,ZfFvL,ZfSu,AmpWaveSuToFuFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SuToFuFv(MFuOS,MFu2OS,MSuOS,MSu2OS,ZfFUL,              & 
& ZfFUR,ZfFvL,ZfSu,AmpWaveSuToFuFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SuToFuFv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSu2OS,MVWm2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,         & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,           & 
& cplcFdFuVWmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,           & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,           & 
& cplSdcSecSu,cplSdcSucVWm,AmpVertexSuToFuFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SuToFuFv(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSu2OS,MVWm2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,         & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,           & 
& cplcFdFuVWmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,           & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,           & 
& cplSdcSecSu,cplSdcSucVWm,AmpVertexSuToFuFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToFuFv(MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,ZfFvL,          & 
& ZfSu,AmpWaveSuToFuFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToFuFv(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,              & 
& MSu,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,cplChaFucSdL,cplChaFucSdR,    & 
& cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,AmpVertexSuToFuFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Fu Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToFuFv = 0._dp 
 AmpSum2SuToFuFv = 0._dp  
Else 
 AmpSumSuToFuFv = AmpVertexSuToFuFv + AmpWaveSuToFuFv
 AmpSum2SuToFuFv = AmpVertexSuToFuFv + AmpWaveSuToFuFv 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSuOS(gt1).gt.(MFuOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MFu(gt2)+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSuOS(gt1),MFuOS(gt2),0._dp,AmpSumSuToFuFv(:,gt1, gt2, gt3),AmpSum2SuToFuFv(:,gt1, gt2, gt3),AmpSqSuToFuFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSu(gt1),MFu(gt2),0._dp,AmpSumSuToFuFv(:,gt1, gt2, gt3),AmpSum2SuToFuFv(:,gt1, gt2, gt3),AmpSqSuToFuFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSuToFuFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSuToFuFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MFuOS(gt2),0._dp,helfactor*AmpSqSuToFuFv(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MFu(gt2),0._dp,helfactor*AmpSqSuToFuFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuToFuFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToFuFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Su Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuSv(MSuOS,MSu2OS,MSvOS,MSv2OS,ZfSu,               & 
& ZfSv,AmpWaveSuToSuSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuSv(MSuOS,MSu2OS,MSvOS,MSv2OS,ZfSu,               & 
& ZfSv,AmpWaveSuToSuSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,           & 
& MSv2OS,MVWm2OS,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,   & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSucSdVWm,cplSvcSeVWm,cplHpmSuSvcSdaa,& 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa,cplSeSucHpmcSuaa, & 
& cplSeSucSecSuaa,AmpVertexSuToSuSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,           & 
& MSv2OS,MVWm2OS,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,   & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSucSdVWm,cplSvcSeVWm,cplHpmSuSvcSdaa,& 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa,cplSeSucHpmcSuaa, & 
& cplSeSucSecSuaa,AmpVertexSuToSuSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuSv(MSu,MSu2,MSv,MSv2,ZfSu,ZfSv,AmpWaveSuToSuSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuSv(MCha,MFd,MFe,MHpm,MSd,MSe,MSu,              & 
& MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,cplcFdChaSuR,    & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,              & 
& cplSeSucSd,cplSeSvcSe,cplSucSdVWm,cplSvcSeVWm,cplHpmSuSvcSdaa,cplSdSucSdcSuabba,       & 
& cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa,cplSeSucHpmcSuaa,cplSeSucSecSuaa,   & 
& AmpVertexSuToSuSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSuSv = 0._dp 
 AmpSum2SuToSuSv = 0._dp  
Else 
 AmpSumSuToSuSv = AmpVertexSuToSuSv + AmpWaveSuToSuSv
 AmpSum2SuToSuSv = AmpVertexSuToSuSv + AmpWaveSuToSuSv 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,3
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MSvOS(gt3),AmpSumSuToSuSv(gt1, gt2, gt3),AmpSum2SuToSuSv(gt1, gt2, gt3),AmpSqSuToSuSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MSv(gt3),AmpSumSuToSuSv(gt1, gt2, gt3),AmpSum2SuToSuSv(gt1, gt2, gt3),AmpSqSuToSuSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSuToSuSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSuSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),MSvOS(gt3),helfactor*AmpSqSuToSuSv(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),MSv(gt3),helfactor*AmpSqSuToSuSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuToSuSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Su VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVG(cplSucSuVG,ctcplSucSuVG,MSuOS,MSu2OS,         & 
& MVG,MVG2,ZfSu,ZfVG,AmpWaveSuToSuVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVG(cplSucSuVG,ctcplSucSuVG,MSuOS,MSu2OS,         & 
& MVG,MVG2,ZfSu,ZfVG,AmpWaveSuToSuVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVG(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFucSuL,     & 
& cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,cplcFdFdVGR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL,           & 
& cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcSdVG,cplSdcHpmcSu,cplSdcSecSu,               & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplVGVGVG,        & 
& cplSdcSucVWmVGLamct4ct2ct1,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVPLamct3ct2ct1,cplSucSdVGVWmLamct3ct2ct1,cplSucSuVGVZLamct3ct2ct1,           & 
& AmpVertexSuToSuVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVG(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFucSuL,     & 
& cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,cplcFdFdVGR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL,           & 
& cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcSdVG,cplSdcHpmcSu,cplSdcSecSu,               & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplVGVGVG,        & 
& cplSdcSucVWmVGLamct4ct2ct1,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVPLamct3ct2ct1,cplSucSdVGVWmLamct3ct2ct1,cplSucSuVGVZLamct3ct2ct1,           & 
& AmpVertexSuToSuVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVG(cplSucSuVG,ctcplSucSuVG,MSu,MSu2,             & 
& MVG,MVG2,ZfSu,ZfVG,AmpWaveSuToSuVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVG(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,   & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,cplcFdFdVGR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcSdVG,cplSdcHpmcSu,              & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,      & 
& cplVGVGVG,cplSdcSucVWmVGLamct4ct2ct1,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,        & 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSucSuVGVPLamct3ct2ct1,cplSucSdVGVWmLamct3ct2ct1,& 
& cplSucSuVGVZLamct3ct2ct1,AmpVertexSuToSuVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSuVG = 0._dp 
 AmpSum2SuToSuVG = 0._dp  
Else 
 AmpSumSuToSuVG = AmpVertexSuToSuVG + AmpWaveSuToSuVG
 AmpSum2SuToSuVG = AmpVertexSuToSuVG + AmpWaveSuToSuVG 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),0._dp,AmpSumSuToSuVG(:,gt1, gt2),AmpSum2SuToSuVG(:,gt1, gt2),AmpSqSuToSuVG(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVG,AmpSumSuToSuVG(:,gt1, gt2),AmpSum2SuToSuVG(:,gt1, gt2),AmpSqSuToSuVG(gt1, gt2)) 
End if  
Else  
  AmpSqSuToSuVG(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSuVG(gt1, gt2).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),0._dp,helfactor*AmpSqSuToSuVG(gt1, gt2))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),MVG,helfactor*AmpSqSuToSuVG(gt1, gt2))
End if 
If ((Abs(MRPSuToSuVG(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuVG(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Su VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVP(cplSucSuVP,cplSucSuVZ,ctcplSucSuVP,           & 
& ctcplSucSuVZ,MSuOS,MSu2OS,MVP,MVP2,ZfSu,ZfVP,ZfVZVP,AmpWaveSuToSuVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVP(cplSucSuVP,cplSucSuVZ,ctcplSucSuVP,           & 
& ctcplSucSuVZ,MSuOS,MSu2OS,MVP,MVP2,ZfSu,ZfVP,ZfVZVP,AmpWaveSuToSuVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVPL,    & 
& cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVPL,         & 
& cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVPL,             & 
& cplcFuFuVPR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplHpmcHpmVP,             & 
& cplHpmcVWmVP,cplSdcSdVP,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVP,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,     & 
& cplSdcSucVWmVPaa,cplSucSuVGVPLamct3ct2ct1,cplSucSuVPVPaa,cplSucSdVPVWmaa,              & 
& cplSucSuVPVZaa,AmpVertexSuToSuVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVG,MVP,MVWmOS,MVZOS,MAh2OS,               & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVPL,    & 
& cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVPL,         & 
& cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVPL,             & 
& cplcFuFuVPR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplHpmcHpmVP,             & 
& cplHpmcVWmVP,cplSdcSdVP,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVP,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,     & 
& cplSdcSucVWmVPaa,cplSucSuVGVPLamct3ct2ct1,cplSucSuVPVPaa,cplSucSdVPVWmaa,              & 
& cplSucSuVPVZaa,AmpVertexSuToSuVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSuVP(cplSucSuVP,cplSucSuVZ,ctcplSucSuVP,           & 
& ctcplSucSuVZ,MSu,MSu2,MVP,MVP2,ZfSu,ZfVP,ZfVZVP,AmpWaveSuToSuVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSuVP(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MGlu2,           & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,   & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,            & 
& cplSeSucSd,cplSecSeVP,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVPVWm,       & 
& cplcVWmVPVWm,cplSdcSucVWmVPaa,cplSucSuVGVPLamct3ct2ct1,cplSucSuVPVPaa,cplSucSdVPVWmaa, & 
& cplSucSuVPVZaa,AmpVertexSuToSuVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSuVP = 0._dp 
 AmpSum2SuToSuVP = 0._dp  
Else 
 AmpSumSuToSuVP = AmpVertexSuToSuVP + AmpWaveSuToSuVP
 AmpSum2SuToSuVP = AmpVertexSuToSuVP + AmpWaveSuToSuVP 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSuOS(gt1),MSuOS(gt2),0._dp,AmpSumSuToSuVP(:,gt1, gt2),AmpSum2SuToSuVP(:,gt1, gt2),AmpSqSuToSuVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSu(gt1),MSu(gt2),MVP,AmpSumSuToSuVP(:,gt1, gt2),AmpSum2SuToSuVP(:,gt1, gt2),AmpSqSuToSuVP(gt1, gt2)) 
End if  
Else  
  AmpSqSuToSuVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSuVP(gt1, gt2).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),0._dp,helfactor*AmpSqSuToSuVP(gt1, gt2))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),MVP,helfactor*AmpSqSuToSuVP(gt1, gt2))
End if 
If ((Abs(MRPSuToSuVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSuToSuVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Su Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SuToSucSv(MSuOS,MSu2OS,MSvOS,MSv2OS,ZfSu,              & 
& ZfSv,AmpWaveSuToSucSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SuToSucSv(MSuOS,MSu2OS,MSvOS,MSv2OS,ZfSu,              & 
& ZfSv,AmpWaveSuToSucSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSucSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,           & 
& MSv2OS,MVWm2OS,cplcFdChaSuL,cplcFdChaSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,     & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,          & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,             & 
& cplSucSdVWm,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,     & 
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,cplSeSucSecSuaa,AmpVertexSuToSucSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSucSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,           & 
& MSv2OS,MVWm2OS,cplcFdChaSuL,cplcFdChaSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,     & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,          & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,             & 
& cplSucSdVWm,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,     & 
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,cplSeSucSecSuaa,AmpVertexSuToSucSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SuToSucSv(MSu,MSu2,MSv,MSv2,ZfSu,ZfSv,AmpWaveSuToSucSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SuToSucSv(MCha,MFd,MFe,MHpm,MSd,MSe,MSu,             & 
& MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,cplcFdChaSuR,    & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,   & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,cplSeSucSecSuaa, & 
& AmpVertexSuToSucSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Su->Su conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSuToSucSv = 0._dp 
 AmpSum2SuToSucSv = 0._dp  
Else 
 AmpSumSuToSucSv = AmpVertexSuToSucSv + AmpWaveSuToSucSv
 AmpSum2SuToSucSv = AmpVertexSuToSucSv + AmpWaveSuToSucSv 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,3
If (((OSkinematics).and.(MSuOS(gt1).gt.(MSuOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MSu(gt1).gt.(MSu(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSuOS(gt1),MSuOS(gt2),MSvOS(gt3),AmpSumSuToSucSv(gt1, gt2, gt3),AmpSum2SuToSucSv(gt1, gt2, gt3),AmpSqSuToSucSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSu(gt1),MSu(gt2),MSv(gt3),AmpSumSuToSucSv(gt1, gt2, gt3),AmpSum2SuToSucSv(gt1, gt2, gt3),AmpSqSuToSucSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSuToSucSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSuToSucSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSu(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSuOS(gt1),MSuOS(gt2),MSvOS(gt3),helfactor*AmpSqSuToSucSv(gt1, gt2, gt3))
Else 
  gP1LSu(gt1,i4) = 1*GammaTPS(MSu(gt1),MSu(gt2),MSv(gt3),helfactor*AmpSqSuToSucSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSuToSucSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSuToSucSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSu(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
End Subroutine OneLoopDecay_Su

End Module Wrapper_OneLoopDecay_Su_MSSMTriLnV
