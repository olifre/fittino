! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_hh_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_hh_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_hh(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& ZfVPVZ,ZfVZVP,cplAhAhAhAh1,cplAhAhcVWmVWm1,cplAhAhhh,cplAhAhhhhh1,cplAhAhHpmcHpm1,     & 
& cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhVZVZ1,cplAhcHpmVPVWm1,& 
& cplAhcHpmVWm,cplAhcHpmVWmVZ1,cplAhhhHpmcHpm1,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,      & 
& cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhSdcSd,cplAhSdSvcSdaa,cplAhSecSe,cplAhSeSvcSe1,    & 
& cplAhSucSu,cplcChacFuSdL,cplcChacFuSdR,cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,      & 
& cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,  & 
& cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,              & 
& cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcFdChaSuL,cplcFdChaSuR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,               & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplcFecFuSdL,cplcFecFuSdR,           & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFuFuAhL,cplcFuFuAhR,cplcFuFuhhL,cplcFuFuhhR,           & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFuGluSuL,cplcFuGluSuR,cplcgAgWmcVWm,cplcgAgWpCVWm,cplcgWmgAHpm,cplcgWmgAVWm,       & 
& cplcgWmgWmAh,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWmgZHpm,cplcgWmgZVWm,         & 
& cplcgWpCgAcVWm,cplcgWpCgWpCAh,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplcgWpCgWpCVZ,            & 
& cplcgWpCgZcHpm,cplcgWpCgZcVWm,cplcgZgAhh,cplcgZgWmcHpm,cplcgZgWmcVWm,cplcgZgWpCHpm,    & 
& cplcgZgWpCVWm,cplcgZgZhh,cplChaFucSdL,cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,      & 
& cplChiChacVWmL,cplChiChacVWmR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcHpmVPVWm,cplcHpmVWmVZ,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q, & 
& cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVPVWm3Q,cplcVWmVPVWm,cplcVWmVPVWmVZ1Q,      & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ3Q,cplcVWmVWmVZ,cplcVWmVWmVZVZ1Q,cplcVWmVWmVZVZ2Q,      & 
& cplcVWmVWmVZVZ3Q,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,             & 
& cplGluFucSuR,cplhhcHpmVPVWm1,cplhhcHpmVWm,cplhhcHpmVWmVZ1,cplhhcVWmVWm,cplhhhhcVWmVWm1,& 
& cplhhhhhh,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSucSuaa,    & 
& cplhhhhSvcSv1,cplhhhhVZVZ1,cplhhHpmcHpm,cplhhHpmcVWm,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,  & 
& cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcHpmcSuaa,cplhhSdcSd,cplhhSdcSdcSvaa,            & 
& cplhhSdcSecSuaa,cplhhSdSvcSdaa,cplhhSecHpmcSv1,cplhhSecSe,cplhhSecSecSv1,              & 
& cplhhSeSucSdaa,cplhhSeSvcSe1,cplhhSucSu,cplhhSvcSv,cplhhVZVZ,cplHpmcHpmcVWmVWm1,       & 
& cplHpmcHpmVP,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,cplHpmcHpmVZ,cplHpmcHpmVZVZ1,             & 
& cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,       & 
& cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSucHpmcSuaa,cplHpmSucSd,cplHpmSucSecSuaa,       & 
& cplHpmSvcHpmcSv1,cplHpmSvcSe,cplHpmSvcSecSv1,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSdcVWmVWmaa,& 
& cplSdcSdVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSdcSdVP,cplSdcSdVPVPaa,cplSdcSdVPVZaa,cplSdcSdVZ,cplSdcSdVZVZaa,cplSdcSecSu,        & 
& cplSdcSucVWm,cplSdSdcSdcSdabab,cplSdSdcSdcSdabba,cplSdSecSdcSeaa,cplSdSucSdcSuabab,    & 
& cplSdSucSdcSuabba,cplSdSvcSd,cplSdSvcSdcSvaa,cplSecHpmcSv,cplSecSecSv,cplSecSecVWmVWm1,& 
& cplSecSeVP,cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSeVZ,cplSecSeVZVZ1,cplSecSvcVWm,          & 
& cplSeSecSecSe1,cplSeSucSd,cplSeSucSecSuaa,cplSeSvcSe,cplSeSvcSecSv1,cplSucSdVWm,       & 
& cplSucSucVWmVWmaa,cplSucSuVG,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVP,cplSucSuVPVPaa,cplSucSuVPVZaa,cplSucSuVZ,cplSucSuVZVZaa,cplSuSucSucSuabab,  & 
& cplSuSucSucSuabba,cplSuSvcSucSvaa,cplSvcSeVWm,cplSvcSvcVWmVWm1,cplSvcSvVZ,             & 
& cplSvcSvVZVZ1,cplSvSvcSvcSv1,ctcplAhAhhh,ctcplAhhhVZ,ctcplcChaChahhL,ctcplcChaChahhR,  & 
& ctcplcFdFdhhL,ctcplcFdFdhhR,ctcplcFeFehhL,ctcplcFeFehhR,ctcplcFuFuhhL,ctcplcFuFuhhR,   & 
& ctcplChiChihhL,ctcplChiChihhR,ctcplhhcVWmVWm,ctcplhhhhhh,ctcplhhHpmcHpm,               & 
& ctcplhhHpmcVWm,ctcplhhSdcSd,ctcplhhSecSe,ctcplhhSucSu,ctcplhhSvcSv,ctcplhhVZVZ,        & 
& GcplcHpmVPVWm,GcplhhcHpmVWm,GcplhhHpmcHpm,GcplhhHpmcVWm,GcplHpmcVWmVP,GosZcplcHpmVPVWm,& 
& GosZcplhhcHpmVWm,GosZcplhhHpmcHpm,GosZcplhhHpmcVWm,GosZcplHpmcVWmVP,GZcplcHpmVPVWm,    & 
& GZcplhhcHpmVWm,GZcplhhHpmcHpm,GZcplhhHpmcVWm,GZcplHpmcVWmVP,ZcplAhAhhh,ZcplAhhhVZ,     & 
& ZcplcChaChahhL,ZcplcChaChahhR,ZcplcFdFdhhL,ZcplcFdFdhhR,ZcplcFeFehhL,ZcplcFeFehhR,     & 
& ZcplcFuFuhhL,ZcplcFuFuhhR,ZcplChiChihhL,ZcplChiChihhR,ZcplhhcVWmVWm,Zcplhhhhhh,        & 
& ZcplhhHpmcHpm,ZcplhhHpmcVWm,ZcplhhSdcSd,ZcplhhSecSe,ZcplhhSucSu,ZcplhhSvcSv,           & 
& ZcplhhVZVZ,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,ZRUUM,ZRUUP,ZRUZEL,         & 
& ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,em,gs,deltaM,kont,gP1Lhh)

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

Complex(dp),Intent(in) :: cplAhAhAhAh1(2,2,2,2),cplAhAhcVWmVWm1(2,2),cplAhAhhh(2,2,2),cplAhAhhhhh1(2,2,2,2),    & 
& cplAhAhHpmcHpm1(2,2,2,2),cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),               & 
& cplAhAhSucSuaa(2,2,6,6),cplAhAhSvcSv1(2,2,3,3),cplAhAhVZVZ1(2,2),cplAhcHpmVPVWm1(2,2), & 
& cplAhcHpmVWm(2,2),cplAhcHpmVWmVZ1(2,2),cplAhhhHpmcHpm1(2,2,2,2),cplAhhhVZ(2,2),        & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),       & 
& cplAhSdcSd(2,6,6),cplAhSdSvcSdaa(2,6,3,6),cplAhSecSe(2,6,6),cplAhSeSvcSe1(2,6,3,6),    & 
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
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcgAgWmcVWm,cplcgAgWpCVWm,      & 
& cplcgWmgAHpm(2),cplcgWmgAVWm,cplcgWmgWmAh(2),cplcgWmgWmhh(2),cplcgWmgWmVP,             & 
& cplcgWmgWmVZ,cplcgWmgZHpm(2),cplcgWmgZVWm,cplcgWpCgAcVWm,cplcgWpCgWpCAh(2),            & 
& cplcgWpCgWpChh(2),cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplcgWpCgZcHpm(2),cplcgWpCgZcVWm,      & 
& cplcgZgAhh(2),cplcgZgWmcHpm(2),cplcgZgWmcVWm,cplcgZgWpCHpm(2),cplcgZgWpCVWm,           & 
& cplcgZgZhh(2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),     & 
& cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4)

Complex(dp),Intent(in) :: cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),         & 
& cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),       & 
& cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcHpmVPVWm(2),             & 
& cplcHpmVWmVZ(2),cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q,           & 
& cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVPVWm3Q,cplcVWmVPVWm,cplcVWmVPVWmVZ1Q,      & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ3Q,cplcVWmVWmVZ,cplcVWmVWmVZVZ1Q,cplcVWmVWmVZVZ2Q,      & 
& cplcVWmVWmVZVZ3Q,cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),            & 
& cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),         & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6), & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplhhcHpmVPVWm1(2,2),cplhhcHpmVWm(2,2),            & 
& cplhhcHpmVWmVZ1(2,2),cplhhcVWmVWm(2),cplhhhhcVWmVWm1(2,2),cplhhhhhh(2,2,2),            & 
& cplhhhhhhhh1(2,2,2,2),cplhhhhHpmcHpm1(2,2,2,2),cplhhhhSdcSdaa(2,2,6,6),cplhhhhSecSe1(2,2,6,6),& 
& cplhhhhSucSuaa(2,2,6,6),cplhhhhSvcSv1(2,2,3,3),cplhhhhVZVZ1(2,2),cplhhHpmcHpm(2,2,2),  & 
& cplhhHpmcVWm(2,2),cplhhHpmcVWmVP1(2,2),cplhhHpmcVWmVZ1(2,2),cplhhHpmSucSdaa(2,2,6,6),  & 
& cplhhHpmSvcSe1(2,2,3,6),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSd(2,6,6),cplhhSdcSdcSvaa(2,6,6,3),& 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSdSvcSdaa(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),             & 
& cplhhSecSe(2,6,6),cplhhSecSecSv1(2,6,6,3),cplhhSeSucSdaa(2,6,6,6),cplhhSeSvcSe1(2,6,3,6),& 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhVZVZ(2),cplHpmcHpmcVWmVWm1(2,2),              & 
& cplHpmcHpmVP(2,2),cplHpmcHpmVPVP1(2,2),cplHpmcHpmVPVZ1(2,2),cplHpmcHpmVZ(2,2),         & 
& cplHpmcHpmVZVZ1(2,2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplHpmHpmcHpmcHpm1(2,2,2,2),      & 
& cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSecHpmcSe1(2,6,2,6),        & 
& cplHpmSecSecSe1(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSucSd(2,6,6),cplHpmSucSecSuaa(2,6,6,6),& 
& cplHpmSvcHpmcSv1(2,3,2,3),cplHpmSvcSe(2,3,6),cplHpmSvcSecSv1(2,3,6,3),cplSdcHpmcSu(6,2,6),& 
& cplSdcSdcSv(6,6,3),cplSdcSdcVWmVWmaa(6,6),cplSdcSdVG(6,6),cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSdcSdVP(6,6),cplSdcSdVPVPaa(6,6),    & 
& cplSdcSdVPVZaa(6,6),cplSdcSdVZ(6,6),cplSdcSdVZVZaa(6,6),cplSdcSecSu(6,6,6),            & 
& cplSdcSucVWm(6,6),cplSdSdcSdcSdabab(6,6,6,6),cplSdSdcSdcSdabba(6,6,6,6),               & 
& cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),        & 
& cplSdSvcSd(6,3,6),cplSdSvcSdcSvaa(6,3,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),     & 
& cplSecSecVWmVWm1(6,6),cplSecSeVP(6,6),cplSecSeVPVP1(6,6),cplSecSeVPVZ1(6,6),           & 
& cplSecSeVZ(6,6),cplSecSeVZVZ1(6,6),cplSecSvcVWm(6,3),cplSeSecSecSe1(6,6,6,6),          & 
& cplSeSucSd(6,6,6),cplSeSucSecSuaa(6,6,6,6),cplSeSvcSe(6,3,6),cplSeSvcSecSv1(6,3,6,3),  & 
& cplSucSdVWm(6,6),cplSucSucVWmVWmaa(6,6),cplSucSuVG(6,6),cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSucSuVP(6,6),cplSucSuVPVPaa(6,6),    & 
& cplSucSuVPVZaa(6,6),cplSucSuVZ(6,6),cplSucSuVZVZaa(6,6),cplSuSucSucSuabab(6,6,6,6),    & 
& cplSuSucSucSuabba(6,6,6,6),cplSuSvcSucSvaa(6,3,6,3),cplSvcSeVWm(3,6),cplSvcSvcVWmVWm1(3,3)

Complex(dp),Intent(in) :: cplSvcSvVZ(3,3),cplSvcSvVZVZ1(3,3),cplSvSvcSvcSv1(3,3,3,3),ctcplAhAhhh(2,2,2),         & 
& ctcplAhhhVZ(2,2),ctcplcChaChahhL(2,2,2),ctcplcChaChahhR(2,2,2),ctcplcFdFdhhL(3,3,2),   & 
& ctcplcFdFdhhR(3,3,2),ctcplcFeFehhL(3,3,2),ctcplcFeFehhR(3,3,2),ctcplcFuFuhhL(3,3,2),   & 
& ctcplcFuFuhhR(3,3,2),ctcplChiChihhL(4,4,2),ctcplChiChihhR(4,4,2),ctcplhhcVWmVWm(2),    & 
& ctcplhhhhhh(2,2,2),ctcplhhHpmcHpm(2,2,2),ctcplhhHpmcVWm(2,2),ctcplhhSdcSd(2,6,6),      & 
& ctcplhhSecSe(2,6,6),ctcplhhSucSu(2,6,6),ctcplhhSvcSv(2,3,3),ctcplhhVZVZ(2),            & 
& GcplcHpmVPVWm(2),GcplhhcHpmVWm(2,2),GcplhhHpmcHpm(2,2,2),GcplhhHpmcVWm(2,2),           & 
& GcplHpmcVWmVP(2),GosZcplcHpmVPVWm(2),GosZcplhhcHpmVWm(2,2),GosZcplhhHpmcHpm(2,2,2),    & 
& GosZcplhhHpmcVWm(2,2),GosZcplHpmcVWmVP(2),GZcplcHpmVPVWm(2),GZcplhhcHpmVWm(2,2),       & 
& GZcplhhHpmcHpm(2,2,2),GZcplhhHpmcVWm(2,2),GZcplHpmcVWmVP(2),ZcplAhAhhh(2,2,2),         & 
& ZcplAhhhVZ(2,2),ZcplcChaChahhL(2,2,2),ZcplcChaChahhR(2,2,2),ZcplcFdFdhhL(3,3,2),       & 
& ZcplcFdFdhhR(3,3,2),ZcplcFeFehhL(3,3,2),ZcplcFeFehhR(3,3,2),ZcplcFuFuhhL(3,3,2),       & 
& ZcplcFuFuhhR(3,3,2),ZcplChiChihhL(4,4,2),ZcplChiChihhR(4,4,2),ZcplhhcVWmVWm(2),        & 
& Zcplhhhhhh(2,2,2),ZcplhhHpmcHpm(2,2,2),ZcplhhHpmcVWm(2,2),ZcplhhSdcSd(2,6,6),          & 
& ZcplhhSecSe(2,6,6),ZcplhhSucSu(2,6,6),ZcplhhSvcSv(2,3,3),ZcplhhVZVZ(2)

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
Real(dp), Intent(out) :: gP1Lhh(2,239) 
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
Real(dp) :: MRPhhToAhAh(2,2,2),MRGhhToAhAh(2,2,2), MRPZhhToAhAh(2,2,2),MRGZhhToAhAh(2,2,2) 
Real(dp) :: MVPhhToAhAh(2,2,2) 
Real(dp) :: RMsqTreehhToAhAh(2,2,2),RMsqWavehhToAhAh(2,2,2),RMsqVertexhhToAhAh(2,2,2) 
Complex(dp) :: AmpTreehhToAhAh(2,2,2),AmpWavehhToAhAh(2,2,2),AmpVertexhhToAhAh(2,2,2)& 
 & ,AmpVertexIRoshhToAhAh(2,2,2),AmpVertexIRdrhhToAhAh(2,2,2), AmpSumhhToAhAh(2,2,2), AmpSum2hhToAhAh(2,2,2) 
Complex(dp) :: AmpTreeZhhToAhAh(2,2,2),AmpWaveZhhToAhAh(2,2,2),AmpVertexZhhToAhAh(2,2,2) 
Real(dp) :: AmpSqhhToAhAh(2,2,2),  AmpSqTreehhToAhAh(2,2,2) 
Real(dp) :: MRPhhToAhVZ(2,2),MRGhhToAhVZ(2,2), MRPZhhToAhVZ(2,2),MRGZhhToAhVZ(2,2) 
Real(dp) :: MVPhhToAhVZ(2,2) 
Real(dp) :: RMsqTreehhToAhVZ(2,2),RMsqWavehhToAhVZ(2,2),RMsqVertexhhToAhVZ(2,2) 
Complex(dp) :: AmpTreehhToAhVZ(2,2,2),AmpWavehhToAhVZ(2,2,2),AmpVertexhhToAhVZ(2,2,2)& 
 & ,AmpVertexIRoshhToAhVZ(2,2,2),AmpVertexIRdrhhToAhVZ(2,2,2), AmpSumhhToAhVZ(2,2,2), AmpSum2hhToAhVZ(2,2,2) 
Complex(dp) :: AmpTreeZhhToAhVZ(2,2,2),AmpWaveZhhToAhVZ(2,2,2),AmpVertexZhhToAhVZ(2,2,2) 
Real(dp) :: AmpSqhhToAhVZ(2,2),  AmpSqTreehhToAhVZ(2,2) 
Real(dp) :: MRPhhTocChaCha(2,2,2),MRGhhTocChaCha(2,2,2), MRPZhhTocChaCha(2,2,2),MRGZhhTocChaCha(2,2,2) 
Real(dp) :: MVPhhTocChaCha(2,2,2) 
Real(dp) :: RMsqTreehhTocChaCha(2,2,2),RMsqWavehhTocChaCha(2,2,2),RMsqVertexhhTocChaCha(2,2,2) 
Complex(dp) :: AmpTreehhTocChaCha(2,2,2,2),AmpWavehhTocChaCha(2,2,2,2),AmpVertexhhTocChaCha(2,2,2,2)& 
 & ,AmpVertexIRoshhTocChaCha(2,2,2,2),AmpVertexIRdrhhTocChaCha(2,2,2,2), AmpSumhhTocChaCha(2,2,2,2), AmpSum2hhTocChaCha(2,2,2,2) 
Complex(dp) :: AmpTreeZhhTocChaCha(2,2,2,2),AmpWaveZhhTocChaCha(2,2,2,2),AmpVertexZhhTocChaCha(2,2,2,2) 
Real(dp) :: AmpSqhhTocChaCha(2,2,2),  AmpSqTreehhTocChaCha(2,2,2) 
Real(dp) :: MRPhhToChiChi(2,4,4),MRGhhToChiChi(2,4,4), MRPZhhToChiChi(2,4,4),MRGZhhToChiChi(2,4,4) 
Real(dp) :: MVPhhToChiChi(2,4,4) 
Real(dp) :: RMsqTreehhToChiChi(2,4,4),RMsqWavehhToChiChi(2,4,4),RMsqVertexhhToChiChi(2,4,4) 
Complex(dp) :: AmpTreehhToChiChi(2,2,4,4),AmpWavehhToChiChi(2,2,4,4),AmpVertexhhToChiChi(2,2,4,4)& 
 & ,AmpVertexIRoshhToChiChi(2,2,4,4),AmpVertexIRdrhhToChiChi(2,2,4,4), AmpSumhhToChiChi(2,2,4,4), AmpSum2hhToChiChi(2,2,4,4) 
Complex(dp) :: AmpTreeZhhToChiChi(2,2,4,4),AmpWaveZhhToChiChi(2,2,4,4),AmpVertexZhhToChiChi(2,2,4,4) 
Real(dp) :: AmpSqhhToChiChi(2,4,4),  AmpSqTreehhToChiChi(2,4,4) 
Real(dp) :: MRPhhTocFdFd(2,3,3),MRGhhTocFdFd(2,3,3), MRPZhhTocFdFd(2,3,3),MRGZhhTocFdFd(2,3,3) 
Real(dp) :: MVPhhTocFdFd(2,3,3) 
Real(dp) :: RMsqTreehhTocFdFd(2,3,3),RMsqWavehhTocFdFd(2,3,3),RMsqVertexhhTocFdFd(2,3,3) 
Complex(dp) :: AmpTreehhTocFdFd(2,2,3,3),AmpWavehhTocFdFd(2,2,3,3),AmpVertexhhTocFdFd(2,2,3,3)& 
 & ,AmpVertexIRoshhTocFdFd(2,2,3,3),AmpVertexIRdrhhTocFdFd(2,2,3,3), AmpSumhhTocFdFd(2,2,3,3), AmpSum2hhTocFdFd(2,2,3,3) 
Complex(dp) :: AmpTreeZhhTocFdFd(2,2,3,3),AmpWaveZhhTocFdFd(2,2,3,3),AmpVertexZhhTocFdFd(2,2,3,3) 
Real(dp) :: AmpSqhhTocFdFd(2,3,3),  AmpSqTreehhTocFdFd(2,3,3) 
Real(dp) :: MRPhhTocFeFe(2,3,3),MRGhhTocFeFe(2,3,3), MRPZhhTocFeFe(2,3,3),MRGZhhTocFeFe(2,3,3) 
Real(dp) :: MVPhhTocFeFe(2,3,3) 
Real(dp) :: RMsqTreehhTocFeFe(2,3,3),RMsqWavehhTocFeFe(2,3,3),RMsqVertexhhTocFeFe(2,3,3) 
Complex(dp) :: AmpTreehhTocFeFe(2,2,3,3),AmpWavehhTocFeFe(2,2,3,3),AmpVertexhhTocFeFe(2,2,3,3)& 
 & ,AmpVertexIRoshhTocFeFe(2,2,3,3),AmpVertexIRdrhhTocFeFe(2,2,3,3), AmpSumhhTocFeFe(2,2,3,3), AmpSum2hhTocFeFe(2,2,3,3) 
Complex(dp) :: AmpTreeZhhTocFeFe(2,2,3,3),AmpWaveZhhTocFeFe(2,2,3,3),AmpVertexZhhTocFeFe(2,2,3,3) 
Real(dp) :: AmpSqhhTocFeFe(2,3,3),  AmpSqTreehhTocFeFe(2,3,3) 
Real(dp) :: MRPhhTocFuFu(2,3,3),MRGhhTocFuFu(2,3,3), MRPZhhTocFuFu(2,3,3),MRGZhhTocFuFu(2,3,3) 
Real(dp) :: MVPhhTocFuFu(2,3,3) 
Real(dp) :: RMsqTreehhTocFuFu(2,3,3),RMsqWavehhTocFuFu(2,3,3),RMsqVertexhhTocFuFu(2,3,3) 
Complex(dp) :: AmpTreehhTocFuFu(2,2,3,3),AmpWavehhTocFuFu(2,2,3,3),AmpVertexhhTocFuFu(2,2,3,3)& 
 & ,AmpVertexIRoshhTocFuFu(2,2,3,3),AmpVertexIRdrhhTocFuFu(2,2,3,3), AmpSumhhTocFuFu(2,2,3,3), AmpSum2hhTocFuFu(2,2,3,3) 
Complex(dp) :: AmpTreeZhhTocFuFu(2,2,3,3),AmpWaveZhhTocFuFu(2,2,3,3),AmpVertexZhhTocFuFu(2,2,3,3) 
Real(dp) :: AmpSqhhTocFuFu(2,3,3),  AmpSqTreehhTocFuFu(2,3,3) 
Real(dp) :: MRPhhTohhhh(2,2,2),MRGhhTohhhh(2,2,2), MRPZhhTohhhh(2,2,2),MRGZhhTohhhh(2,2,2) 
Real(dp) :: MVPhhTohhhh(2,2,2) 
Real(dp) :: RMsqTreehhTohhhh(2,2,2),RMsqWavehhTohhhh(2,2,2),RMsqVertexhhTohhhh(2,2,2) 
Complex(dp) :: AmpTreehhTohhhh(2,2,2),AmpWavehhTohhhh(2,2,2),AmpVertexhhTohhhh(2,2,2)& 
 & ,AmpVertexIRoshhTohhhh(2,2,2),AmpVertexIRdrhhTohhhh(2,2,2), AmpSumhhTohhhh(2,2,2), AmpSum2hhTohhhh(2,2,2) 
Complex(dp) :: AmpTreeZhhTohhhh(2,2,2),AmpWaveZhhTohhhh(2,2,2),AmpVertexZhhTohhhh(2,2,2) 
Real(dp) :: AmpSqhhTohhhh(2,2,2),  AmpSqTreehhTohhhh(2,2,2) 
Real(dp) :: MRPhhTocHpmHpm(2,2,2),MRGhhTocHpmHpm(2,2,2), MRPZhhTocHpmHpm(2,2,2),MRGZhhTocHpmHpm(2,2,2) 
Real(dp) :: MVPhhTocHpmHpm(2,2,2) 
Real(dp) :: RMsqTreehhTocHpmHpm(2,2,2),RMsqWavehhTocHpmHpm(2,2,2),RMsqVertexhhTocHpmHpm(2,2,2) 
Complex(dp) :: AmpTreehhTocHpmHpm(2,2,2),AmpWavehhTocHpmHpm(2,2,2),AmpVertexhhTocHpmHpm(2,2,2)& 
 & ,AmpVertexIRoshhTocHpmHpm(2,2,2),AmpVertexIRdrhhTocHpmHpm(2,2,2), AmpSumhhTocHpmHpm(2,2,2), AmpSum2hhTocHpmHpm(2,2,2) 
Complex(dp) :: AmpTreeZhhTocHpmHpm(2,2,2),AmpWaveZhhTocHpmHpm(2,2,2),AmpVertexZhhTocHpmHpm(2,2,2) 
Real(dp) :: AmpSqhhTocHpmHpm(2,2,2),  AmpSqTreehhTocHpmHpm(2,2,2) 
Real(dp) :: MRPhhToHpmcVWm(2,2),MRGhhToHpmcVWm(2,2), MRPZhhToHpmcVWm(2,2),MRGZhhToHpmcVWm(2,2) 
Real(dp) :: MVPhhToHpmcVWm(2,2) 
Real(dp) :: RMsqTreehhToHpmcVWm(2,2),RMsqWavehhToHpmcVWm(2,2),RMsqVertexhhToHpmcVWm(2,2) 
Complex(dp) :: AmpTreehhToHpmcVWm(2,2,2),AmpWavehhToHpmcVWm(2,2,2),AmpVertexhhToHpmcVWm(2,2,2)& 
 & ,AmpVertexIRoshhToHpmcVWm(2,2,2),AmpVertexIRdrhhToHpmcVWm(2,2,2), AmpSumhhToHpmcVWm(2,2,2), AmpSum2hhToHpmcVWm(2,2,2) 
Complex(dp) :: AmpTreeZhhToHpmcVWm(2,2,2),AmpWaveZhhToHpmcVWm(2,2,2),AmpVertexZhhToHpmcVWm(2,2,2) 
Real(dp) :: AmpSqhhToHpmcVWm(2,2),  AmpSqTreehhToHpmcVWm(2,2) 
Real(dp) :: MRPhhTocSdSd(2,6,6),MRGhhTocSdSd(2,6,6), MRPZhhTocSdSd(2,6,6),MRGZhhTocSdSd(2,6,6) 
Real(dp) :: MVPhhTocSdSd(2,6,6) 
Real(dp) :: RMsqTreehhTocSdSd(2,6,6),RMsqWavehhTocSdSd(2,6,6),RMsqVertexhhTocSdSd(2,6,6) 
Complex(dp) :: AmpTreehhTocSdSd(2,6,6),AmpWavehhTocSdSd(2,6,6),AmpVertexhhTocSdSd(2,6,6)& 
 & ,AmpVertexIRoshhTocSdSd(2,6,6),AmpVertexIRdrhhTocSdSd(2,6,6), AmpSumhhTocSdSd(2,6,6), AmpSum2hhTocSdSd(2,6,6) 
Complex(dp) :: AmpTreeZhhTocSdSd(2,6,6),AmpWaveZhhTocSdSd(2,6,6),AmpVertexZhhTocSdSd(2,6,6) 
Real(dp) :: AmpSqhhTocSdSd(2,6,6),  AmpSqTreehhTocSdSd(2,6,6) 
Real(dp) :: MRPhhTocSeSe(2,6,6),MRGhhTocSeSe(2,6,6), MRPZhhTocSeSe(2,6,6),MRGZhhTocSeSe(2,6,6) 
Real(dp) :: MVPhhTocSeSe(2,6,6) 
Real(dp) :: RMsqTreehhTocSeSe(2,6,6),RMsqWavehhTocSeSe(2,6,6),RMsqVertexhhTocSeSe(2,6,6) 
Complex(dp) :: AmpTreehhTocSeSe(2,6,6),AmpWavehhTocSeSe(2,6,6),AmpVertexhhTocSeSe(2,6,6)& 
 & ,AmpVertexIRoshhTocSeSe(2,6,6),AmpVertexIRdrhhTocSeSe(2,6,6), AmpSumhhTocSeSe(2,6,6), AmpSum2hhTocSeSe(2,6,6) 
Complex(dp) :: AmpTreeZhhTocSeSe(2,6,6),AmpWaveZhhTocSeSe(2,6,6),AmpVertexZhhTocSeSe(2,6,6) 
Real(dp) :: AmpSqhhTocSeSe(2,6,6),  AmpSqTreehhTocSeSe(2,6,6) 
Real(dp) :: MRPhhTocSuSu(2,6,6),MRGhhTocSuSu(2,6,6), MRPZhhTocSuSu(2,6,6),MRGZhhTocSuSu(2,6,6) 
Real(dp) :: MVPhhTocSuSu(2,6,6) 
Real(dp) :: RMsqTreehhTocSuSu(2,6,6),RMsqWavehhTocSuSu(2,6,6),RMsqVertexhhTocSuSu(2,6,6) 
Complex(dp) :: AmpTreehhTocSuSu(2,6,6),AmpWavehhTocSuSu(2,6,6),AmpVertexhhTocSuSu(2,6,6)& 
 & ,AmpVertexIRoshhTocSuSu(2,6,6),AmpVertexIRdrhhTocSuSu(2,6,6), AmpSumhhTocSuSu(2,6,6), AmpSum2hhTocSuSu(2,6,6) 
Complex(dp) :: AmpTreeZhhTocSuSu(2,6,6),AmpWaveZhhTocSuSu(2,6,6),AmpVertexZhhTocSuSu(2,6,6) 
Real(dp) :: AmpSqhhTocSuSu(2,6,6),  AmpSqTreehhTocSuSu(2,6,6) 
Real(dp) :: MRPhhTocSvSv(2,3,3),MRGhhTocSvSv(2,3,3), MRPZhhTocSvSv(2,3,3),MRGZhhTocSvSv(2,3,3) 
Real(dp) :: MVPhhTocSvSv(2,3,3) 
Real(dp) :: RMsqTreehhTocSvSv(2,3,3),RMsqWavehhTocSvSv(2,3,3),RMsqVertexhhTocSvSv(2,3,3) 
Complex(dp) :: AmpTreehhTocSvSv(2,3,3),AmpWavehhTocSvSv(2,3,3),AmpVertexhhTocSvSv(2,3,3)& 
 & ,AmpVertexIRoshhTocSvSv(2,3,3),AmpVertexIRdrhhTocSvSv(2,3,3), AmpSumhhTocSvSv(2,3,3), AmpSum2hhTocSvSv(2,3,3) 
Complex(dp) :: AmpTreeZhhTocSvSv(2,3,3),AmpWaveZhhTocSvSv(2,3,3),AmpVertexZhhTocSvSv(2,3,3) 
Real(dp) :: AmpSqhhTocSvSv(2,3,3),  AmpSqTreehhTocSvSv(2,3,3) 
Real(dp) :: MRPhhTocVWmVWm(2),MRGhhTocVWmVWm(2), MRPZhhTocVWmVWm(2),MRGZhhTocVWmVWm(2) 
Real(dp) :: MVPhhTocVWmVWm(2) 
Real(dp) :: RMsqTreehhTocVWmVWm(2),RMsqWavehhTocVWmVWm(2),RMsqVertexhhTocVWmVWm(2) 
Complex(dp) :: AmpTreehhTocVWmVWm(2,2),AmpWavehhTocVWmVWm(2,2),AmpVertexhhTocVWmVWm(2,2)& 
 & ,AmpVertexIRoshhTocVWmVWm(2,2),AmpVertexIRdrhhTocVWmVWm(2,2), AmpSumhhTocVWmVWm(2,2), AmpSum2hhTocVWmVWm(2,2) 
Complex(dp) :: AmpTreeZhhTocVWmVWm(2,2),AmpWaveZhhTocVWmVWm(2,2),AmpVertexZhhTocVWmVWm(2,2) 
Real(dp) :: AmpSqhhTocVWmVWm(2),  AmpSqTreehhTocVWmVWm(2) 
Real(dp) :: MRPhhToVZVZ(2),MRGhhToVZVZ(2), MRPZhhToVZVZ(2),MRGZhhToVZVZ(2) 
Real(dp) :: MVPhhToVZVZ(2) 
Real(dp) :: RMsqTreehhToVZVZ(2),RMsqWavehhToVZVZ(2),RMsqVertexhhToVZVZ(2) 
Complex(dp) :: AmpTreehhToVZVZ(2,2),AmpWavehhToVZVZ(2,2),AmpVertexhhToVZVZ(2,2)& 
 & ,AmpVertexIRoshhToVZVZ(2,2),AmpVertexIRdrhhToVZVZ(2,2), AmpSumhhToVZVZ(2,2), AmpSum2hhToVZVZ(2,2) 
Complex(dp) :: AmpTreeZhhToVZVZ(2,2),AmpWaveZhhToVZVZ(2,2),AmpVertexZhhToVZVZ(2,2) 
Real(dp) :: AmpSqhhToVZVZ(2),  AmpSqTreehhToVZVZ(2) 
Real(dp) :: MRPhhToAhhh(2,2,2),MRGhhToAhhh(2,2,2), MRPZhhToAhhh(2,2,2),MRGZhhToAhhh(2,2,2) 
Real(dp) :: MVPhhToAhhh(2,2,2) 
Real(dp) :: RMsqTreehhToAhhh(2,2,2),RMsqWavehhToAhhh(2,2,2),RMsqVertexhhToAhhh(2,2,2) 
Complex(dp) :: AmpTreehhToAhhh(2,2,2),AmpWavehhToAhhh(2,2,2),AmpVertexhhToAhhh(2,2,2)& 
 & ,AmpVertexIRoshhToAhhh(2,2,2),AmpVertexIRdrhhToAhhh(2,2,2), AmpSumhhToAhhh(2,2,2), AmpSum2hhToAhhh(2,2,2) 
Complex(dp) :: AmpTreeZhhToAhhh(2,2,2),AmpWaveZhhToAhhh(2,2,2),AmpVertexZhhToAhhh(2,2,2) 
Real(dp) :: AmpSqhhToAhhh(2,2,2),  AmpSqTreehhToAhhh(2,2,2) 
Real(dp) :: MRPhhToAhSv(2,2,3),MRGhhToAhSv(2,2,3), MRPZhhToAhSv(2,2,3),MRGZhhToAhSv(2,2,3) 
Real(dp) :: MVPhhToAhSv(2,2,3) 
Real(dp) :: RMsqTreehhToAhSv(2,2,3),RMsqWavehhToAhSv(2,2,3),RMsqVertexhhToAhSv(2,2,3) 
Complex(dp) :: AmpTreehhToAhSv(2,2,3),AmpWavehhToAhSv(2,2,3),AmpVertexhhToAhSv(2,2,3)& 
 & ,AmpVertexIRoshhToAhSv(2,2,3),AmpVertexIRdrhhToAhSv(2,2,3), AmpSumhhToAhSv(2,2,3), AmpSum2hhToAhSv(2,2,3) 
Complex(dp) :: AmpTreeZhhToAhSv(2,2,3),AmpWaveZhhToAhSv(2,2,3),AmpVertexZhhToAhSv(2,2,3) 
Real(dp) :: AmpSqhhToAhSv(2,2,3),  AmpSqTreehhToAhSv(2,2,3) 
Real(dp) :: MRPhhToAhVP(2,2),MRGhhToAhVP(2,2), MRPZhhToAhVP(2,2),MRGZhhToAhVP(2,2) 
Real(dp) :: MVPhhToAhVP(2,2) 
Real(dp) :: RMsqTreehhToAhVP(2,2),RMsqWavehhToAhVP(2,2),RMsqVertexhhToAhVP(2,2) 
Complex(dp) :: AmpTreehhToAhVP(2,2,2),AmpWavehhToAhVP(2,2,2),AmpVertexhhToAhVP(2,2,2)& 
 & ,AmpVertexIRoshhToAhVP(2,2,2),AmpVertexIRdrhhToAhVP(2,2,2), AmpSumhhToAhVP(2,2,2), AmpSum2hhToAhVP(2,2,2) 
Complex(dp) :: AmpTreeZhhToAhVP(2,2,2),AmpWaveZhhToAhVP(2,2,2),AmpVertexZhhToAhVP(2,2,2) 
Real(dp) :: AmpSqhhToAhVP(2,2),  AmpSqTreehhToAhVP(2,2) 
Real(dp) :: MRPhhToChacFe(2,2,3),MRGhhToChacFe(2,2,3), MRPZhhToChacFe(2,2,3),MRGZhhToChacFe(2,2,3) 
Real(dp) :: MVPhhToChacFe(2,2,3) 
Real(dp) :: RMsqTreehhToChacFe(2,2,3),RMsqWavehhToChacFe(2,2,3),RMsqVertexhhToChacFe(2,2,3) 
Complex(dp) :: AmpTreehhToChacFe(2,2,2,3),AmpWavehhToChacFe(2,2,2,3),AmpVertexhhToChacFe(2,2,2,3)& 
 & ,AmpVertexIRoshhToChacFe(2,2,2,3),AmpVertexIRdrhhToChacFe(2,2,2,3), AmpSumhhToChacFe(2,2,2,3), AmpSum2hhToChacFe(2,2,2,3) 
Complex(dp) :: AmpTreeZhhToChacFe(2,2,2,3),AmpWaveZhhToChacFe(2,2,2,3),AmpVertexZhhToChacFe(2,2,2,3) 
Real(dp) :: AmpSqhhToChacFe(2,2,3),  AmpSqTreehhToChacFe(2,2,3) 
Real(dp) :: MRPhhToChiFv(2,4,3),MRGhhToChiFv(2,4,3), MRPZhhToChiFv(2,4,3),MRGZhhToChiFv(2,4,3) 
Real(dp) :: MVPhhToChiFv(2,4,3) 
Real(dp) :: RMsqTreehhToChiFv(2,4,3),RMsqWavehhToChiFv(2,4,3),RMsqVertexhhToChiFv(2,4,3) 
Complex(dp) :: AmpTreehhToChiFv(2,2,4,3),AmpWavehhToChiFv(2,2,4,3),AmpVertexhhToChiFv(2,2,4,3)& 
 & ,AmpVertexIRoshhToChiFv(2,2,4,3),AmpVertexIRdrhhToChiFv(2,2,4,3), AmpSumhhToChiFv(2,2,4,3), AmpSum2hhToChiFv(2,2,4,3) 
Complex(dp) :: AmpTreeZhhToChiFv(2,2,4,3),AmpWaveZhhToChiFv(2,2,4,3),AmpVertexZhhToChiFv(2,2,4,3) 
Real(dp) :: AmpSqhhToChiFv(2,4,3),  AmpSqTreehhToChiFv(2,4,3) 
Real(dp) :: MRPhhToFvFv(2,3,3),MRGhhToFvFv(2,3,3), MRPZhhToFvFv(2,3,3),MRGZhhToFvFv(2,3,3) 
Real(dp) :: MVPhhToFvFv(2,3,3) 
Real(dp) :: RMsqTreehhToFvFv(2,3,3),RMsqWavehhToFvFv(2,3,3),RMsqVertexhhToFvFv(2,3,3) 
Complex(dp) :: AmpTreehhToFvFv(2,2,3,3),AmpWavehhToFvFv(2,2,3,3),AmpVertexhhToFvFv(2,2,3,3)& 
 & ,AmpVertexIRoshhToFvFv(2,2,3,3),AmpVertexIRdrhhToFvFv(2,2,3,3), AmpSumhhToFvFv(2,2,3,3), AmpSum2hhToFvFv(2,2,3,3) 
Complex(dp) :: AmpTreeZhhToFvFv(2,2,3,3),AmpWaveZhhToFvFv(2,2,3,3),AmpVertexZhhToFvFv(2,2,3,3) 
Real(dp) :: AmpSqhhToFvFv(2,3,3),  AmpSqTreehhToFvFv(2,3,3) 
Real(dp) :: MRPhhToGluGlu(2),MRGhhToGluGlu(2), MRPZhhToGluGlu(2),MRGZhhToGluGlu(2) 
Real(dp) :: MVPhhToGluGlu(2) 
Real(dp) :: RMsqTreehhToGluGlu(2),RMsqWavehhToGluGlu(2),RMsqVertexhhToGluGlu(2) 
Complex(dp) :: AmpTreehhToGluGlu(2,2),AmpWavehhToGluGlu(2,2),AmpVertexhhToGluGlu(2,2)& 
 & ,AmpVertexIRoshhToGluGlu(2,2),AmpVertexIRdrhhToGluGlu(2,2), AmpSumhhToGluGlu(2,2), AmpSum2hhToGluGlu(2,2) 
Complex(dp) :: AmpTreeZhhToGluGlu(2,2),AmpWaveZhhToGluGlu(2,2),AmpVertexZhhToGluGlu(2,2) 
Real(dp) :: AmpSqhhToGluGlu(2),  AmpSqTreehhToGluGlu(2) 
Real(dp) :: MRPhhTohhSv(2,2,3),MRGhhTohhSv(2,2,3), MRPZhhTohhSv(2,2,3),MRGZhhTohhSv(2,2,3) 
Real(dp) :: MVPhhTohhSv(2,2,3) 
Real(dp) :: RMsqTreehhTohhSv(2,2,3),RMsqWavehhTohhSv(2,2,3),RMsqVertexhhTohhSv(2,2,3) 
Complex(dp) :: AmpTreehhTohhSv(2,2,3),AmpWavehhTohhSv(2,2,3),AmpVertexhhTohhSv(2,2,3)& 
 & ,AmpVertexIRoshhTohhSv(2,2,3),AmpVertexIRdrhhTohhSv(2,2,3), AmpSumhhTohhSv(2,2,3), AmpSum2hhTohhSv(2,2,3) 
Complex(dp) :: AmpTreeZhhTohhSv(2,2,3),AmpWaveZhhTohhSv(2,2,3),AmpVertexZhhTohhSv(2,2,3) 
Real(dp) :: AmpSqhhTohhSv(2,2,3),  AmpSqTreehhTohhSv(2,2,3) 
Real(dp) :: MRPhhTohhVP(2,2),MRGhhTohhVP(2,2), MRPZhhTohhVP(2,2),MRGZhhTohhVP(2,2) 
Real(dp) :: MVPhhTohhVP(2,2) 
Real(dp) :: RMsqTreehhTohhVP(2,2),RMsqWavehhTohhVP(2,2),RMsqVertexhhTohhVP(2,2) 
Complex(dp) :: AmpTreehhTohhVP(2,2,2),AmpWavehhTohhVP(2,2,2),AmpVertexhhTohhVP(2,2,2)& 
 & ,AmpVertexIRoshhTohhVP(2,2,2),AmpVertexIRdrhhTohhVP(2,2,2), AmpSumhhTohhVP(2,2,2), AmpSum2hhTohhVP(2,2,2) 
Complex(dp) :: AmpTreeZhhTohhVP(2,2,2),AmpWaveZhhTohhVP(2,2,2),AmpVertexZhhTohhVP(2,2,2) 
Real(dp) :: AmpSqhhTohhVP(2,2),  AmpSqTreehhTohhVP(2,2) 
Real(dp) :: MRPhhTohhVZ(2,2),MRGhhTohhVZ(2,2), MRPZhhTohhVZ(2,2),MRGZhhTohhVZ(2,2) 
Real(dp) :: MVPhhTohhVZ(2,2) 
Real(dp) :: RMsqTreehhTohhVZ(2,2),RMsqWavehhTohhVZ(2,2),RMsqVertexhhTohhVZ(2,2) 
Complex(dp) :: AmpTreehhTohhVZ(2,2,2),AmpWavehhTohhVZ(2,2,2),AmpVertexhhTohhVZ(2,2,2)& 
 & ,AmpVertexIRoshhTohhVZ(2,2,2),AmpVertexIRdrhhTohhVZ(2,2,2), AmpSumhhTohhVZ(2,2,2), AmpSum2hhTohhVZ(2,2,2) 
Complex(dp) :: AmpTreeZhhTohhVZ(2,2,2),AmpWaveZhhTohhVZ(2,2,2),AmpVertexZhhTohhVZ(2,2,2) 
Real(dp) :: AmpSqhhTohhVZ(2,2),  AmpSqTreehhTohhVZ(2,2) 
Real(dp) :: MRPhhToHpmcSe(2,2,6),MRGhhToHpmcSe(2,2,6), MRPZhhToHpmcSe(2,2,6),MRGZhhToHpmcSe(2,2,6) 
Real(dp) :: MVPhhToHpmcSe(2,2,6) 
Real(dp) :: RMsqTreehhToHpmcSe(2,2,6),RMsqWavehhToHpmcSe(2,2,6),RMsqVertexhhToHpmcSe(2,2,6) 
Complex(dp) :: AmpTreehhToHpmcSe(2,2,6),AmpWavehhToHpmcSe(2,2,6),AmpVertexhhToHpmcSe(2,2,6)& 
 & ,AmpVertexIRoshhToHpmcSe(2,2,6),AmpVertexIRdrhhToHpmcSe(2,2,6), AmpSumhhToHpmcSe(2,2,6), AmpSum2hhToHpmcSe(2,2,6) 
Complex(dp) :: AmpTreeZhhToHpmcSe(2,2,6),AmpWaveZhhToHpmcSe(2,2,6),AmpVertexZhhToHpmcSe(2,2,6) 
Real(dp) :: AmpSqhhToHpmcSe(2,2,6),  AmpSqTreehhToHpmcSe(2,2,6) 
Real(dp) :: MRPhhToSecVWm(2,6),MRGhhToSecVWm(2,6), MRPZhhToSecVWm(2,6),MRGZhhToSecVWm(2,6) 
Real(dp) :: MVPhhToSecVWm(2,6) 
Real(dp) :: RMsqTreehhToSecVWm(2,6),RMsqWavehhToSecVWm(2,6),RMsqVertexhhToSecVWm(2,6) 
Complex(dp) :: AmpTreehhToSecVWm(2,2,6),AmpWavehhToSecVWm(2,2,6),AmpVertexhhToSecVWm(2,2,6)& 
 & ,AmpVertexIRoshhToSecVWm(2,2,6),AmpVertexIRdrhhToSecVWm(2,2,6), AmpSumhhToSecVWm(2,2,6), AmpSum2hhToSecVWm(2,2,6) 
Complex(dp) :: AmpTreeZhhToSecVWm(2,2,6),AmpWaveZhhToSecVWm(2,2,6),AmpVertexZhhToSecVWm(2,2,6) 
Real(dp) :: AmpSqhhToSecVWm(2,6),  AmpSqTreehhToSecVWm(2,6) 
Real(dp) :: MRPhhToSvSv(2,3,3),MRGhhToSvSv(2,3,3), MRPZhhToSvSv(2,3,3),MRGZhhToSvSv(2,3,3) 
Real(dp) :: MVPhhToSvSv(2,3,3) 
Real(dp) :: RMsqTreehhToSvSv(2,3,3),RMsqWavehhToSvSv(2,3,3),RMsqVertexhhToSvSv(2,3,3) 
Complex(dp) :: AmpTreehhToSvSv(2,3,3),AmpWavehhToSvSv(2,3,3),AmpVertexhhToSvSv(2,3,3)& 
 & ,AmpVertexIRoshhToSvSv(2,3,3),AmpVertexIRdrhhToSvSv(2,3,3), AmpSumhhToSvSv(2,3,3), AmpSum2hhToSvSv(2,3,3) 
Complex(dp) :: AmpTreeZhhToSvSv(2,3,3),AmpWaveZhhToSvSv(2,3,3),AmpVertexZhhToSvSv(2,3,3) 
Real(dp) :: AmpSqhhToSvSv(2,3,3),  AmpSqTreehhToSvSv(2,3,3) 
Real(dp) :: MRPhhToSvVP(2,3),MRGhhToSvVP(2,3), MRPZhhToSvVP(2,3),MRGZhhToSvVP(2,3) 
Real(dp) :: MVPhhToSvVP(2,3) 
Real(dp) :: RMsqTreehhToSvVP(2,3),RMsqWavehhToSvVP(2,3),RMsqVertexhhToSvVP(2,3) 
Complex(dp) :: AmpTreehhToSvVP(2,2,3),AmpWavehhToSvVP(2,2,3),AmpVertexhhToSvVP(2,2,3)& 
 & ,AmpVertexIRoshhToSvVP(2,2,3),AmpVertexIRdrhhToSvVP(2,2,3), AmpSumhhToSvVP(2,2,3), AmpSum2hhToSvVP(2,2,3) 
Complex(dp) :: AmpTreeZhhToSvVP(2,2,3),AmpWaveZhhToSvVP(2,2,3),AmpVertexZhhToSvVP(2,2,3) 
Real(dp) :: AmpSqhhToSvVP(2,3),  AmpSqTreehhToSvVP(2,3) 
Real(dp) :: MRPhhToSvVZ(2,3),MRGhhToSvVZ(2,3), MRPZhhToSvVZ(2,3),MRGZhhToSvVZ(2,3) 
Real(dp) :: MVPhhToSvVZ(2,3) 
Real(dp) :: RMsqTreehhToSvVZ(2,3),RMsqWavehhToSvVZ(2,3),RMsqVertexhhToSvVZ(2,3) 
Complex(dp) :: AmpTreehhToSvVZ(2,2,3),AmpWavehhToSvVZ(2,2,3),AmpVertexhhToSvVZ(2,2,3)& 
 & ,AmpVertexIRoshhToSvVZ(2,2,3),AmpVertexIRdrhhToSvVZ(2,2,3), AmpSumhhToSvVZ(2,2,3), AmpSum2hhToSvVZ(2,2,3) 
Complex(dp) :: AmpTreeZhhToSvVZ(2,2,3),AmpWaveZhhToSvVZ(2,2,3),AmpVertexZhhToSvVZ(2,2,3) 
Real(dp) :: AmpSqhhToSvVZ(2,3),  AmpSqTreehhToSvVZ(2,3) 
Real(dp) :: MRPhhToVGVG(2),MRGhhToVGVG(2), MRPZhhToVGVG(2),MRGZhhToVGVG(2) 
Real(dp) :: MVPhhToVGVG(2) 
Real(dp) :: RMsqTreehhToVGVG(2),RMsqWavehhToVGVG(2),RMsqVertexhhToVGVG(2) 
Complex(dp) :: AmpTreehhToVGVG(2,2),AmpWavehhToVGVG(2,2),AmpVertexhhToVGVG(2,2)& 
 & ,AmpVertexIRoshhToVGVG(2,2),AmpVertexIRdrhhToVGVG(2,2), AmpSumhhToVGVG(2,2), AmpSum2hhToVGVG(2,2) 
Complex(dp) :: AmpTreeZhhToVGVG(2,2),AmpWaveZhhToVGVG(2,2),AmpVertexZhhToVGVG(2,2) 
Real(dp) :: AmpSqhhToVGVG(2),  AmpSqTreehhToVGVG(2) 
Real(dp) :: MRPhhToVPVP(2),MRGhhToVPVP(2), MRPZhhToVPVP(2),MRGZhhToVPVP(2) 
Real(dp) :: MVPhhToVPVP(2) 
Real(dp) :: RMsqTreehhToVPVP(2),RMsqWavehhToVPVP(2),RMsqVertexhhToVPVP(2) 
Complex(dp) :: AmpTreehhToVPVP(2,2),AmpWavehhToVPVP(2,2),AmpVertexhhToVPVP(2,2)& 
 & ,AmpVertexIRoshhToVPVP(2,2),AmpVertexIRdrhhToVPVP(2,2), AmpSumhhToVPVP(2,2), AmpSum2hhToVPVP(2,2) 
Complex(dp) :: AmpTreeZhhToVPVP(2,2),AmpWaveZhhToVPVP(2,2),AmpVertexZhhToVPVP(2,2) 
Real(dp) :: AmpSqhhToVPVP(2),  AmpSqTreehhToVPVP(2) 
Real(dp) :: MRPhhToVPVZ(2),MRGhhToVPVZ(2), MRPZhhToVPVZ(2),MRGZhhToVPVZ(2) 
Real(dp) :: MVPhhToVPVZ(2) 
Real(dp) :: RMsqTreehhToVPVZ(2),RMsqWavehhToVPVZ(2),RMsqVertexhhToVPVZ(2) 
Complex(dp) :: AmpTreehhToVPVZ(2,2),AmpWavehhToVPVZ(2,2),AmpVertexhhToVPVZ(2,2)& 
 & ,AmpVertexIRoshhToVPVZ(2,2),AmpVertexIRdrhhToVPVZ(2,2), AmpSumhhToVPVZ(2,2), AmpSum2hhToVPVZ(2,2) 
Complex(dp) :: AmpTreeZhhToVPVZ(2,2),AmpWaveZhhToVPVZ(2,2),AmpVertexZhhToVPVZ(2,2) 
Real(dp) :: AmpSqhhToVPVZ(2),  AmpSqTreehhToVPVZ(2) 
Write(*,*) "Calculating one-loop decays of hh " 
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
isave = 5

If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! Ah Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhToAhAh(cplAhAhhh,MAh,Mhh,MAh2,Mhh2,AmpTreehhToAhAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhToAhAh(ZcplAhAhhh,MAh,Mhh,MAh2,Mhh2,AmpTreehhToAhAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToAhAh(MLambda,em,gs,cplAhAhhh,MAhOS,MhhOS,              & 
& MRPhhToAhAh,MRGhhToAhAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToAhAh(MLambda,em,gs,ZcplAhAhhh,MAhOS,MhhOS,             & 
& MRPhhToAhAh,MRGhhToAhAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhToAhAh(MLambda,em,gs,cplAhAhhh,MAh,Mhh,MRPhhToAhAh,      & 
& MRGhhToAhAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToAhAh(MLambda,em,gs,ZcplAhAhhh,MAh,Mhh,MRPhhToAhAh,     & 
& MRGhhToAhAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhAh(cplAhAhhh,ctcplAhAhhh,MAh,MAh2,               & 
& Mhh,Mhh2,ZfAh,Zfhh,AmpWavehhToAhAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhAh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,     & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,            & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,      & 
& cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,             & 
& AmpVertexhhToAhAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,     & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,            & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,      & 
& cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,             & 
& AmpVertexIRdrhhToAhAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,ZcplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,       & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,            & 
& cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,           & 
& cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,              & 
& cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSucSuaa, & 
& cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,AmpVertexIRoshhToAhAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,ZcplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,            & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,      & 
& cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,             & 
& AmpVertexIRoshhToAhAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,            & 
& cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,           & 
& cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,              & 
& cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSucSuaa, & 
& cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,AmpVertexIRoshhToAhAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,     & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,            & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,      & 
& cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,             & 
& AmpVertexIRoshhToAhAh)

 End if 
 End if 
AmpVertexhhToAhAh = AmpVertexhhToAhAh -  AmpVertexIRdrhhToAhAh! +  AmpVertexIRoshhToAhAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhToAhAh=0._dp 
AmpVertexZhhToAhAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToAhAh(gt2,:,:) = AmpWaveZhhToAhAh(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhToAhAh(gt1,:,:) 
AmpVertexZhhToAhAh(gt2,:,:)= AmpVertexZhhToAhAh(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhToAhAh(gt1,:,:) 
 End Do 
End Do 
AmpWavehhToAhAh=AmpWaveZhhToAhAh 
AmpVertexhhToAhAh= AmpVertexZhhToAhAh
! Final State 1 
AmpWaveZhhToAhAh=0._dp 
AmpVertexZhhToAhAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToAhAh(:,gt2,:) = AmpWaveZhhToAhAh(:,gt2,:)+ZRUZA(gt2,gt1)*AmpWavehhToAhAh(:,gt1,:) 
AmpVertexZhhToAhAh(:,gt2,:)= AmpVertexZhhToAhAh(:,gt2,:)+ZRUZA(gt2,gt1)*AmpVertexhhToAhAh(:,gt1,:) 
 End Do 
End Do 
AmpWavehhToAhAh=AmpWaveZhhToAhAh 
AmpVertexhhToAhAh= AmpVertexZhhToAhAh
! Final State 2 
AmpWaveZhhToAhAh=0._dp 
AmpVertexZhhToAhAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToAhAh(:,:,gt2) = AmpWaveZhhToAhAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWavehhToAhAh(:,:,gt1) 
AmpVertexZhhToAhAh(:,:,gt2)= AmpVertexZhhToAhAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexhhToAhAh(:,:,gt1) 
 End Do 
End Do 
AmpWavehhToAhAh=AmpWaveZhhToAhAh 
AmpVertexhhToAhAh= AmpVertexZhhToAhAh
End if
If (ShiftIRdiv) Then 
AmpVertexhhToAhAh = AmpVertexhhToAhAh  +  AmpVertexIRoshhToAhAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Ah Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhToAhAh = AmpTreehhToAhAh 
 AmpSum2hhToAhAh = AmpTreehhToAhAh + 2._dp*AmpWavehhToAhAh + 2._dp*AmpVertexhhToAhAh  
Else 
 AmpSumhhToAhAh = AmpTreehhToAhAh + AmpWavehhToAhAh + AmpVertexhhToAhAh
 AmpSum2hhToAhAh = AmpTreehhToAhAh + AmpWavehhToAhAh + AmpVertexhhToAhAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToAhAh = AmpTreehhToAhAh
 AmpSum2hhToAhAh = AmpTreehhToAhAh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=gt2,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MAhOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MAh(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhToAhAh = AmpTreehhToAhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MAh(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhToAhAh(gt1, gt2, gt3) 
  AmpSum2hhToAhAh = 2._dp*AmpWavehhToAhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MAh(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhToAhAh(gt1, gt2, gt3) 
  AmpSum2hhToAhAh = 2._dp*AmpVertexhhToAhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MAh(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhToAhAh(gt1, gt2, gt3) 
  AmpSum2hhToAhAh = AmpTreehhToAhAh + 2._dp*AmpWavehhToAhAh + 2._dp*AmpVertexhhToAhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MAh(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhToAhAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhToAhAh = AmpTreehhToAhAh
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
  AmpSqTreehhToAhAh(gt1, gt2, gt3) = (1)*AmpSqhhToAhAh(gt1, gt2, gt3)  
  AmpSum2hhToAhAh = + 2._dp*AmpWavehhToAhAh + 2._dp*AmpVertexhhToAhAh
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
  AmpSqhhToAhAh(gt1, gt2, gt3) = AmpSqhhToAhAh(gt1, gt2, gt3) + AmpSqTreehhToAhAh(gt1, gt2, gt3)  
Else  
  AmpSum2hhToAhAh = AmpTreehhToAhAh
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MAh(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
  AmpSqTreehhToAhAh(gt1, gt2, gt3) = (1)*AmpSqhhToAhAh(gt1, gt2, gt3)  
  AmpSum2hhToAhAh = + 2._dp*AmpWavehhToAhAh + 2._dp*AmpVertexhhToAhAh
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MAh(gt3),AmpSumhhToAhAh(gt1, gt2, gt3),AmpSum2hhToAhAh(gt1, gt2, gt3),AmpSqhhToAhAh(gt1, gt2, gt3)) 
  AmpSqhhToAhAh(gt1, gt2, gt3) = AmpSqhhToAhAh(gt1, gt2, gt3) + AmpSqTreehhToAhAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhToAhAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqhhToAhAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(MhhOS(gt1),MAhOS(gt2),MAhOS(gt3),helfactor*AmpSqhhToAhAh(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(Mhh(gt1),MAh(gt2),MAh(gt3),helfactor*AmpSqhhToAhAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/4._dp*helfactor*(MRPhhToAhAh(gt1, gt2, gt3) + MRGhhToAhAh(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/4._dp*helfactor*(MRPhhToAhAh(gt1, gt2, gt3) + MRGhhToAhAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Ah VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhToAhVZ(cplAhhhVZ,MAh,Mhh,MVZ,MAh2,Mhh2,              & 
& MVZ2,AmpTreehhToAhVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhToAhVZ(ZcplAhhhVZ,MAh,Mhh,MVZ,MAh2,Mhh2,             & 
& MVZ2,AmpTreehhToAhVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToAhVZ(MLambda,em,gs,cplAhhhVZ,MAhOS,MhhOS,              & 
& MVZOS,MRPhhToAhVZ,MRGhhToAhVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToAhVZ(MLambda,em,gs,ZcplAhhhVZ,MAhOS,MhhOS,             & 
& MVZOS,MRPhhToAhVZ,MRGhhToAhVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhToAhVZ(MLambda,em,gs,cplAhhhVZ,MAh,Mhh,MVZ,              & 
& MRPhhToAhVZ,MRGhhToAhVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToAhVZ(MLambda,em,gs,ZcplAhhhVZ,MAh,Mhh,MVZ,             & 
& MRPhhToAhVZ,MRGhhToAhVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhVZ(cplAhhhVZ,ctcplAhhhVZ,MAh,MAh2,               & 
& Mhh,Mhh2,MVZ,MVZ2,ZfAh,Zfhh,ZfVZ,AmpWavehhToAhVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhVZ(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,             & 
& MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,               & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplAhAhVZVZ1,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,& 
& cplhhcHpmVWmVZ1,AmpVertexhhToAhVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,          & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplAhAhVZVZ1,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,& 
& cplhhcHpmVWmVZ1,AmpVertexIRdrhhToAhVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,        & 
& MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,               & 
& cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,           & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,ZcplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,             & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,       & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVZ,             & 
& cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,          & 
& cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,   & 
& cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhVZVZ1,               & 
& cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,          & 
& AmpVertexIRoshhToAhVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,          & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,ZcplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,          & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplAhAhVZVZ1,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,& 
& cplhhcHpmVWmVZ1,AmpVertexIRoshhToAhVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,        & 
& MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,               & 
& cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,           & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,              & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,       & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVZ,             & 
& cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,          & 
& cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,   & 
& cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhVZVZ1,               & 
& cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,          & 
& AmpVertexIRoshhToAhVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToAhVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,          & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplAhAhVZVZ1,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,& 
& cplhhcHpmVWmVZ1,AmpVertexIRoshhToAhVZ)

 End if 
 End if 
AmpVertexhhToAhVZ = AmpVertexhhToAhVZ -  AmpVertexIRdrhhToAhVZ! +  AmpVertexIRoshhToAhVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhToAhVZ=0._dp 
AmpVertexZhhToAhVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToAhVZ(:,gt2,:) = AmpWaveZhhToAhVZ(:,gt2,:)+ZRUZH(gt2,gt1)*AmpWavehhToAhVZ(:,gt1,:) 
AmpVertexZhhToAhVZ(:,gt2,:)= AmpVertexZhhToAhVZ(:,gt2,:) + ZRUZH(gt2,gt1)*AmpVertexhhToAhVZ(:,gt1,:) 
 End Do 
End Do 
AmpWavehhToAhVZ=AmpWaveZhhToAhVZ 
AmpVertexhhToAhVZ= AmpVertexZhhToAhVZ
! Final State 1 
AmpWaveZhhToAhVZ=0._dp 
AmpVertexZhhToAhVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToAhVZ(:,:,gt2) = AmpWaveZhhToAhVZ(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWavehhToAhVZ(:,:,gt1) 
AmpVertexZhhToAhVZ(:,:,gt2)= AmpVertexZhhToAhVZ(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexhhToAhVZ(:,:,gt1) 
 End Do 
End Do 
AmpWavehhToAhVZ=AmpWaveZhhToAhVZ 
AmpVertexhhToAhVZ= AmpVertexZhhToAhVZ
End if
If (ShiftIRdiv) Then 
AmpVertexhhToAhVZ = AmpVertexhhToAhVZ  +  AmpVertexIRoshhToAhVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Ah VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhToAhVZ = AmpTreehhToAhVZ 
 AmpSum2hhToAhVZ = AmpTreehhToAhVZ + 2._dp*AmpWavehhToAhVZ + 2._dp*AmpVertexhhToAhVZ  
Else 
 AmpSumhhToAhVZ = AmpTreehhToAhVZ + AmpWavehhToAhVZ + AmpVertexhhToAhVZ
 AmpSum2hhToAhVZ = AmpTreehhToAhVZ + AmpWavehhToAhVZ + AmpVertexhhToAhVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToAhVZ = AmpTreehhToAhVZ
 AmpSum2hhToAhVZ = AmpTreehhToAhVZ 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MAhOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MAh(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2hhToAhVZ = AmpTreehhToAhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),MVZOS,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVZ,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhToAhVZ(gt1, gt2) 
  AmpSum2hhToAhVZ = 2._dp*AmpWavehhToAhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),MVZOS,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVZ,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhToAhVZ(gt1, gt2) 
  AmpSum2hhToAhVZ = 2._dp*AmpVertexhhToAhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),MVZOS,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVZ,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhToAhVZ(gt1, gt2) 
  AmpSum2hhToAhVZ = AmpTreehhToAhVZ + 2._dp*AmpWavehhToAhVZ + 2._dp*AmpVertexhhToAhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),MVZOS,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVZ,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhToAhVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhToAhVZ = AmpTreehhToAhVZ
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),MVZOS,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
  AmpSqTreehhToAhVZ(gt1, gt2) = (1)*AmpSqhhToAhVZ(gt1, gt2)  
  AmpSum2hhToAhVZ = + 2._dp*AmpWavehhToAhVZ + 2._dp*AmpVertexhhToAhVZ
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),MVZOS,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
  AmpSqhhToAhVZ(gt1, gt2) = AmpSqhhToAhVZ(gt1, gt2) + AmpSqTreehhToAhVZ(gt1, gt2)  
Else  
  AmpSum2hhToAhVZ = AmpTreehhToAhVZ
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVZ,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
  AmpSqTreehhToAhVZ(gt1, gt2) = (1)*AmpSqhhToAhVZ(gt1, gt2)  
  AmpSum2hhToAhVZ = + 2._dp*AmpWavehhToAhVZ + 2._dp*AmpVertexhhToAhVZ
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVZ,AmpSumhhToAhVZ(:,gt1, gt2),AmpSum2hhToAhVZ(:,gt1, gt2),AmpSqhhToAhVZ(gt1, gt2)) 
  AmpSqhhToAhVZ(gt1, gt2) = AmpSqhhToAhVZ(gt1, gt2) + AmpSqTreehhToAhVZ(gt1, gt2)  
End if  
Else  
  AmpSqhhToAhVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToAhVZ(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MAhOS(gt2),MVZOS,helfactor*AmpSqhhToAhVZ(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MAh(gt2),MVZ,helfactor*AmpSqhhToAhVZ(gt1, gt2))
End if 
If ((Abs(MRPhhToAhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhToAhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPhhToAhVZ(gt1, gt2) + MRGhhToAhVZ(gt1, gt2)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1*helfactor*(MRPhhToAhVZ(gt1, gt2) + MRGhhToAhVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! bar(Cha) Cha
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocChaCha(cplcChaChahhL,cplcChaChahhR,               & 
& MCha,Mhh,MCha2,Mhh2,AmpTreehhTocChaCha)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocChaCha(ZcplcChaChahhL,ZcplcChaChahhR,             & 
& MCha,Mhh,MCha2,Mhh2,AmpTreehhTocChaCha)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocChaCha(MLambda,em,gs,cplcChaChahhL,cplcChaChahhR,     & 
& MChaOS,MhhOS,MRPhhTocChaCha,MRGhhTocChaCha)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocChaCha(MLambda,em,gs,ZcplcChaChahhL,ZcplcChaChahhR,   & 
& MChaOS,MhhOS,MRPhhTocChaCha,MRGhhTocChaCha)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocChaCha(MLambda,em,gs,cplcChaChahhL,cplcChaChahhR,     & 
& MCha,Mhh,MRPhhTocChaCha,MRGhhTocChaCha)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocChaCha(MLambda,em,gs,ZcplcChaChahhL,ZcplcChaChahhR,   & 
& MCha,Mhh,MRPhhTocChaCha,MRGhhTocChaCha)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocChaCha(cplcChaChahhL,cplcChaChahhR,               & 
& ctcplcChaChahhL,ctcplcChaChahhR,MCha,MCha2,Mhh,Mhh2,Zfhh,ZfLm,ZfLp,AmpWavehhTocChaCha)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplAhhhVZ,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,    & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexhhTocChaCha)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplAhhhVZ,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,    & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexIRdrhhTocChaCha)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocChaCha(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,            & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,ZcplcChaChahhL,ZcplcChaChahhR,cplcFdChaSuL,     & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexIRoshhTocChaCha)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplAhhhVZ,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,    & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,ZcplcChaChahhL,ZcplcChaChahhR,cplcFdChaSuL,     & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexIRoshhTocChaCha)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocChaCha(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,            & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexIRoshhTocChaCha)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplAhhhVZ,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,    & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexIRoshhTocChaCha)

 End if 
 End if 
AmpVertexhhTocChaCha = AmpVertexhhTocChaCha -  AmpVertexIRdrhhTocChaCha! +  AmpVertexIRoshhTocChaCha ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocChaCha=0._dp 
AmpVertexZhhTocChaCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocChaCha(:,gt2,:,:) = AmpWaveZhhTocChaCha(:,gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocChaCha(:,gt1,:,:) 
AmpVertexZhhTocChaCha(:,gt2,:,:)= AmpVertexZhhTocChaCha(:,gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocChaCha(:,gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocChaCha=AmpWaveZhhTocChaCha 
AmpVertexhhTocChaCha= AmpVertexZhhTocChaCha
! Final State 1 
AmpWaveZhhTocChaCha=0._dp 
AmpVertexZhhTocChaCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocChaCha(1,:,gt2,:) = AmpWaveZhhTocChaCha(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpWavehhTocChaCha(1,:,gt1,:) 
AmpVertexZhhTocChaCha(1,:,gt2,:)= AmpVertexZhhTocChaCha(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpVertexhhTocChaCha(1,:,gt1,:) 
AmpWaveZhhTocChaCha(2,:,gt2,:) = AmpWaveZhhTocChaCha(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpWavehhTocChaCha(2,:,gt1,:) 
AmpVertexZhhTocChaCha(2,:,gt2,:)= AmpVertexZhhTocChaCha(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpVertexhhTocChaCha(2,:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocChaCha=AmpWaveZhhTocChaCha 
AmpVertexhhTocChaCha= AmpVertexZhhTocChaCha
! Final State 2 
AmpWaveZhhTocChaCha=0._dp 
AmpVertexZhhTocChaCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocChaCha(1,:,:,gt2) = AmpWaveZhhTocChaCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpWavehhTocChaCha(1,:,:,gt1) 
AmpVertexZhhTocChaCha(1,:,:,gt2)= AmpVertexZhhTocChaCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexhhTocChaCha(1,:,:,gt1) 
AmpWaveZhhTocChaCha(2,:,:,gt2) = AmpWaveZhhTocChaCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpWavehhTocChaCha(2,:,:,gt1) 
AmpVertexZhhTocChaCha(2,:,:,gt2)= AmpVertexZhhTocChaCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpVertexhhTocChaCha(2,:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocChaCha=AmpWaveZhhTocChaCha 
AmpVertexhhTocChaCha= AmpVertexZhhTocChaCha
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocChaCha = AmpVertexhhTocChaCha  +  AmpVertexIRoshhTocChaCha
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->bar[Cha] Cha -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocChaCha = AmpTreehhTocChaCha 
 AmpSum2hhTocChaCha = AmpTreehhTocChaCha + 2._dp*AmpWavehhTocChaCha + 2._dp*AmpVertexhhTocChaCha  
Else 
 AmpSumhhTocChaCha = AmpTreehhTocChaCha + AmpWavehhTocChaCha + AmpVertexhhTocChaCha
 AmpSum2hhTocChaCha = AmpTreehhTocChaCha + AmpWavehhTocChaCha + AmpVertexhhTocChaCha 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocChaCha = AmpTreehhTocChaCha
 AmpSum2hhTocChaCha = AmpTreehhTocChaCha 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MChaOS(gt2)+MChaOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MCha(gt2)+MCha(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocChaCha = AmpTreehhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MCha(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocChaCha(gt1, gt2, gt3) 
  AmpSum2hhTocChaCha = 2._dp*AmpWavehhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MCha(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocChaCha(gt1, gt2, gt3) 
  AmpSum2hhTocChaCha = 2._dp*AmpVertexhhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MCha(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocChaCha(gt1, gt2, gt3) 
  AmpSum2hhTocChaCha = AmpTreehhTocChaCha + 2._dp*AmpWavehhTocChaCha + 2._dp*AmpVertexhhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MCha(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocChaCha(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocChaCha = AmpTreehhTocChaCha
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
  AmpSqTreehhTocChaCha(gt1, gt2, gt3) = (1)*AmpSqhhTocChaCha(gt1, gt2, gt3)  
  AmpSum2hhTocChaCha = + 2._dp*AmpWavehhTocChaCha + 2._dp*AmpVertexhhTocChaCha
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
  AmpSqhhTocChaCha(gt1, gt2, gt3) = AmpSqhhTocChaCha(gt1, gt2, gt3) + AmpSqTreehhTocChaCha(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocChaCha = AmpTreehhTocChaCha
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MCha(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
  AmpSqTreehhTocChaCha(gt1, gt2, gt3) = (1)*AmpSqhhTocChaCha(gt1, gt2, gt3)  
  AmpSum2hhTocChaCha = + 2._dp*AmpWavehhTocChaCha + 2._dp*AmpVertexhhTocChaCha
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MCha(gt3),AmpSumhhTocChaCha(:,gt1, gt2, gt3),AmpSum2hhTocChaCha(:,gt1, gt2, gt3),AmpSqhhTocChaCha(gt1, gt2, gt3)) 
  AmpSqhhTocChaCha(gt1, gt2, gt3) = AmpSqhhTocChaCha(gt1, gt2, gt3) + AmpSqTreehhTocChaCha(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocChaCha(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhTocChaCha(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MChaOS(gt2),MChaOS(gt3),helfactor*AmpSqhhTocChaCha(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MCha(gt2),MCha(gt3),helfactor*AmpSqhhTocChaCha(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocChaCha(gt1, gt2, gt3) + MRGhhTocChaCha(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocChaCha(gt1, gt2, gt3) + MRGhhTocChaCha(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Chi Chi
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhToChiChi(cplChiChihhL,cplChiChihhR,MChi,             & 
& Mhh,MChi2,Mhh2,AmpTreehhToChiChi)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhToChiChi(ZcplChiChihhL,ZcplChiChihhR,MChi,           & 
& Mhh,MChi2,Mhh2,AmpTreehhToChiChi)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToChiChi(MLambda,em,gs,cplChiChihhL,cplChiChihhR,        & 
& MChiOS,MhhOS,MRPhhToChiChi,MRGhhToChiChi)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToChiChi(MLambda,em,gs,ZcplChiChihhL,ZcplChiChihhR,      & 
& MChiOS,MhhOS,MRPhhToChiChi,MRGhhToChiChi)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhToChiChi(MLambda,em,gs,cplChiChihhL,cplChiChihhR,        & 
& MChi,Mhh,MRPhhToChiChi,MRGhhToChiChi)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToChiChi(MLambda,em,gs,ZcplChiChihhL,ZcplChiChihhR,      & 
& MChi,Mhh,MRPhhToChiChi,MRGhhToChiChi)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToChiChi(cplChiChihhL,cplChiChihhR,ctcplChiChihhL,   & 
& ctcplChiChihhR,MChi,MChi2,Mhh,Mhh2,Zfhh,ZfL0,AmpWavehhToChiChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplChiChiAhL,cplChiChiAhR,cplAhhhVZ,          & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,             & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,      & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexhhToChiChi)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplChiChiAhL,cplChiChiAhR,cplAhhhVZ,          & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,             & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,      & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRdrhhToChiChi)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToChiChi(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplChiChiAhL,cplChiChiAhR,cplAhhhVZ,cplChiChacHpmL,           & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,              & 
& ZcplChiChihhL,ZcplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,       & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhToChiChi)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplChiChiAhL,cplChiChiAhR,cplAhhhVZ,          & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,             & 
& cplcChaChahhR,ZcplChiChihhL,ZcplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,      & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,      & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhToChiChi)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToChiChi(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplChiChiAhL,cplChiChiAhR,cplAhhhVZ,cplChiChacHpmL,           & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhToChiChi)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplChiChiAhL,cplChiChiAhR,cplAhhhVZ,          & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,             & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,      & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhToChiChi)

 End if 
 End if 
AmpVertexhhToChiChi = AmpVertexhhToChiChi -  AmpVertexIRdrhhToChiChi! +  AmpVertexIRoshhToChiChi ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhToChiChi=0._dp 
AmpVertexZhhToChiChi=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToChiChi(:,gt2,:,:) = AmpWaveZhhToChiChi(:,gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhToChiChi(:,gt1,:,:) 
AmpVertexZhhToChiChi(:,gt2,:,:)= AmpVertexZhhToChiChi(:,gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhToChiChi(:,gt1,:,:) 
 End Do 
End Do 
AmpWavehhToChiChi=AmpWaveZhhToChiChi 
AmpVertexhhToChiChi= AmpVertexZhhToChiChi
! Final State 1 
AmpWaveZhhToChiChi=0._dp 
AmpVertexZhhToChiChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZhhToChiChi(1,:,gt2,:) = AmpWaveZhhToChiChi(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpWavehhToChiChi(1,:,gt1,:) 
AmpVertexZhhToChiChi(1,:,gt2,:)= AmpVertexZhhToChiChi(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpVertexhhToChiChi(1,:,gt1,:) 
AmpWaveZhhToChiChi(2,:,gt2,:) = AmpWaveZhhToChiChi(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpWavehhToChiChi(2,:,gt1,:) 
AmpVertexZhhToChiChi(2,:,gt2,:)= AmpVertexZhhToChiChi(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpVertexhhToChiChi(2,:,gt1,:) 
 End Do 
End Do 
AmpWavehhToChiChi=AmpWaveZhhToChiChi 
AmpVertexhhToChiChi= AmpVertexZhhToChiChi
! Final State 2 
AmpWaveZhhToChiChi=0._dp 
AmpVertexZhhToChiChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZhhToChiChi(1,:,:,gt2) = AmpWaveZhhToChiChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWavehhToChiChi(1,:,:,gt1) 
AmpVertexZhhToChiChi(1,:,:,gt2)= AmpVertexZhhToChiChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexhhToChiChi(1,:,:,gt1) 
AmpWaveZhhToChiChi(2,:,:,gt2) = AmpWaveZhhToChiChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWavehhToChiChi(2,:,:,gt1) 
AmpVertexZhhToChiChi(2,:,:,gt2)= AmpVertexZhhToChiChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexhhToChiChi(2,:,:,gt1) 
 End Do 
End Do 
AmpWavehhToChiChi=AmpWaveZhhToChiChi 
AmpVertexhhToChiChi= AmpVertexZhhToChiChi
End if
If (ShiftIRdiv) Then 
AmpVertexhhToChiChi = AmpVertexhhToChiChi  +  AmpVertexIRoshhToChiChi
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Chi Chi -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhToChiChi = AmpTreehhToChiChi 
 AmpSum2hhToChiChi = AmpTreehhToChiChi + 2._dp*AmpWavehhToChiChi + 2._dp*AmpVertexhhToChiChi  
Else 
 AmpSumhhToChiChi = AmpTreehhToChiChi + AmpWavehhToChiChi + AmpVertexhhToChiChi
 AmpSum2hhToChiChi = AmpTreehhToChiChi + AmpWavehhToChiChi + AmpVertexhhToChiChi 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToChiChi = AmpTreehhToChiChi
 AmpSum2hhToChiChi = AmpTreehhToChiChi 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=gt2,4
If (((OSkinematics).and.(MhhOS(gt1).gt.(MChiOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MChi(gt2)+MChi(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhToChiChi = AmpTreehhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),MChi(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhToChiChi(gt1, gt2, gt3) 
  AmpSum2hhToChiChi = 2._dp*AmpWavehhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),MChi(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhToChiChi(gt1, gt2, gt3) 
  AmpSum2hhToChiChi = 2._dp*AmpVertexhhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),MChi(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhToChiChi(gt1, gt2, gt3) 
  AmpSum2hhToChiChi = AmpTreehhToChiChi + 2._dp*AmpWavehhToChiChi + 2._dp*AmpVertexhhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),MChi(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhToChiChi(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhToChiChi = AmpTreehhToChiChi
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
  AmpSqTreehhToChiChi(gt1, gt2, gt3) = (1)*AmpSqhhToChiChi(gt1, gt2, gt3)  
  AmpSum2hhToChiChi = + 2._dp*AmpWavehhToChiChi + 2._dp*AmpVertexhhToChiChi
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
  AmpSqhhToChiChi(gt1, gt2, gt3) = AmpSqhhToChiChi(gt1, gt2, gt3) + AmpSqTreehhToChiChi(gt1, gt2, gt3)  
Else  
  AmpSum2hhToChiChi = AmpTreehhToChiChi
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),MChi(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
  AmpSqTreehhToChiChi(gt1, gt2, gt3) = (1)*AmpSqhhToChiChi(gt1, gt2, gt3)  
  AmpSum2hhToChiChi = + 2._dp*AmpWavehhToChiChi + 2._dp*AmpVertexhhToChiChi
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),MChi(gt3),AmpSumhhToChiChi(:,gt1, gt2, gt3),AmpSum2hhToChiChi(:,gt1, gt2, gt3),AmpSqhhToChiChi(gt1, gt2, gt3)) 
  AmpSqhhToChiChi(gt1, gt2, gt3) = AmpSqhhToChiChi(gt1, gt2, gt3) + AmpSqTreehhToChiChi(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhToChiChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqhhToChiChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(MhhOS(gt1),MChiOS(gt2),MChiOS(gt3),helfactor*AmpSqhhToChiChi(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(Mhh(gt1),MChi(gt2),MChi(gt3),helfactor*AmpSqhhToChiChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/4._dp*helfactor*(MRPhhToChiChi(gt1, gt2, gt3) + MRGhhToChiChi(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/4._dp*helfactor*(MRPhhToChiChi(gt1, gt2, gt3) + MRGhhToChiChi(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! bar(Fd) Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocFdFd(cplcFdFdhhL,cplcFdFdhhR,MFd,Mhh,             & 
& MFd2,Mhh2,AmpTreehhTocFdFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocFdFd(ZcplcFdFdhhL,ZcplcFdFdhhR,MFd,               & 
& Mhh,MFd2,Mhh2,AmpTreehhTocFdFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFdFd(MLambda,em,gs,cplcFdFdhhL,cplcFdFdhhR,           & 
& MFdOS,MhhOS,MRPhhTocFdFd,MRGhhTocFdFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFdFd(MLambda,em,gs,ZcplcFdFdhhL,ZcplcFdFdhhR,         & 
& MFdOS,MhhOS,MRPhhTocFdFd,MRGhhTocFdFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocFdFd(MLambda,em,gs,cplcFdFdhhL,cplcFdFdhhR,           & 
& MFd,Mhh,MRPhhTocFdFd,MRGhhTocFdFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFdFd(MLambda,em,gs,ZcplcFdFdhhL,ZcplcFdFdhhR,         & 
& MFd,Mhh,MRPhhTocFdFd,MRGhhTocFdFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocFdFd(cplcFdFdhhL,cplcFdFdhhR,ctcplcFdFdhhL,       & 
& ctcplcFdFdhhR,MFd,MFd2,Mhh,Mhh2,ZfFDL,ZfFDR,Zfhh,AmpWavehhTocFdFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,           & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexhhTocFdFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,            & 
& cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,       & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRdrhhTocFdFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFdFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcFdFdAhL,cplcFdFdAhR,       & 
& cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,ZcplcFdFdhhL,ZcplcFdFdhhR,cplcFdFdSvL,           & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,            & 
& cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,              & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhTocFdFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,            & 
& cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,ZcplcFdFdhhL,           & 
& ZcplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,              & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,       & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhTocFdFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFdFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcFdFdAhL,cplcFdFdAhR,       & 
& cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,            & 
& cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,              & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhTocFdFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,            & 
& cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,       & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexIRoshhTocFdFd)

 End if 
 End if 
AmpVertexhhTocFdFd = AmpVertexhhTocFdFd -  AmpVertexIRdrhhTocFdFd! +  AmpVertexIRoshhTocFdFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocFdFd=0._dp 
AmpVertexZhhTocFdFd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocFdFd(:,gt2,:,:) = AmpWaveZhhTocFdFd(:,gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocFdFd(:,gt1,:,:) 
AmpVertexZhhTocFdFd(:,gt2,:,:)= AmpVertexZhhTocFdFd(:,gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocFdFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocFdFd=AmpWaveZhhTocFdFd 
AmpVertexhhTocFdFd= AmpVertexZhhTocFdFd
! Final State 1 
AmpWaveZhhTocFdFd=0._dp 
AmpVertexZhhTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocFdFd(1,:,gt2,:) = AmpWaveZhhTocFdFd(1,:,gt2,:)+ZRUZDR(gt2,gt1)*AmpWavehhTocFdFd(1,:,gt1,:) 
AmpVertexZhhTocFdFd(1,:,gt2,:)= AmpVertexZhhTocFdFd(1,:,gt2,:)+ZRUZDR(gt2,gt1)*AmpVertexhhTocFdFd(1,:,gt1,:) 
AmpWaveZhhTocFdFd(2,:,gt2,:) = AmpWaveZhhTocFdFd(2,:,gt2,:)+ZRUZDLc(gt2,gt1)*AmpWavehhTocFdFd(2,:,gt1,:) 
AmpVertexZhhTocFdFd(2,:,gt2,:)= AmpVertexZhhTocFdFd(2,:,gt2,:)+ZRUZDLc(gt2,gt1)*AmpVertexhhTocFdFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocFdFd=AmpWaveZhhTocFdFd 
AmpVertexhhTocFdFd= AmpVertexZhhTocFdFd
! Final State 2 
AmpWaveZhhTocFdFd=0._dp 
AmpVertexZhhTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocFdFd(1,:,:,gt2) = AmpWaveZhhTocFdFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWavehhTocFdFd(1,:,:,gt1) 
AmpVertexZhhTocFdFd(1,:,:,gt2)= AmpVertexZhhTocFdFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexhhTocFdFd(1,:,:,gt1) 
AmpWaveZhhTocFdFd(2,:,:,gt2) = AmpWaveZhhTocFdFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWavehhTocFdFd(2,:,:,gt1) 
AmpVertexZhhTocFdFd(2,:,:,gt2)= AmpVertexZhhTocFdFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexhhTocFdFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocFdFd=AmpWaveZhhTocFdFd 
AmpVertexhhTocFdFd= AmpVertexZhhTocFdFd
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocFdFd = AmpVertexhhTocFdFd  +  AmpVertexIRoshhTocFdFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->bar[Fd] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocFdFd = AmpTreehhTocFdFd 
 AmpSum2hhTocFdFd = AmpTreehhTocFdFd + 2._dp*AmpWavehhTocFdFd + 2._dp*AmpVertexhhTocFdFd  
Else 
 AmpSumhhTocFdFd = AmpTreehhTocFdFd + AmpWavehhTocFdFd + AmpVertexhhTocFdFd
 AmpSum2hhTocFdFd = AmpTreehhTocFdFd + AmpWavehhTocFdFd + AmpVertexhhTocFdFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocFdFd = AmpTreehhTocFdFd
 AmpSum2hhTocFdFd = AmpTreehhTocFdFd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MFdOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MFd(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocFdFd = AmpTreehhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFd(gt2),MFd(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocFdFd(gt1, gt2, gt3) 
  AmpSum2hhTocFdFd = 2._dp*AmpWavehhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFd(gt2),MFd(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocFdFd(gt1, gt2, gt3) 
  AmpSum2hhTocFdFd = 2._dp*AmpVertexhhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFd(gt2),MFd(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocFdFd(gt1, gt2, gt3) 
  AmpSum2hhTocFdFd = AmpTreehhTocFdFd + 2._dp*AmpWavehhTocFdFd + 2._dp*AmpVertexhhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFd(gt2),MFd(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocFdFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocFdFd = AmpTreehhTocFdFd
  Call SquareAmp_StoFF(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
  AmpSqTreehhTocFdFd(gt1, gt2, gt3) = (3)*AmpSqhhTocFdFd(gt1, gt2, gt3)  
  AmpSum2hhTocFdFd = + 2._dp*AmpWavehhTocFdFd + 2._dp*AmpVertexhhTocFdFd
  Call SquareAmp_StoFF(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
  AmpSqhhTocFdFd(gt1, gt2, gt3) = AmpSqhhTocFdFd(gt1, gt2, gt3) + AmpSqTreehhTocFdFd(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocFdFd = AmpTreehhTocFdFd
  Call SquareAmp_StoFF(Mhh(gt1),MFd(gt2),MFd(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
  AmpSqTreehhTocFdFd(gt1, gt2, gt3) = (3)*AmpSqhhTocFdFd(gt1, gt2, gt3)  
  AmpSum2hhTocFdFd = + 2._dp*AmpWavehhTocFdFd + 2._dp*AmpVertexhhTocFdFd
  Call SquareAmp_StoFF(Mhh(gt1),MFd(gt2),MFd(gt3),AmpSumhhTocFdFd(:,gt1, gt2, gt3),AmpSum2hhTocFdFd(:,gt1, gt2, gt3),AmpSqhhTocFdFd(gt1, gt2, gt3)) 
  AmpSqhhTocFdFd(gt1, gt2, gt3) = AmpSqhhTocFdFd(gt1, gt2, gt3) + AmpSqTreehhTocFdFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocFdFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhTocFdFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MFdOS(gt2),MFdOS(gt3),helfactor*AmpSqhhTocFdFd(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MFd(gt2),MFd(gt3),helfactor*AmpSqhhTocFdFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocFdFd(gt1, gt2, gt3) + MRGhhTocFdFd(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocFdFd(gt1, gt2, gt3) + MRGhhTocFdFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! bar(Fe) Fe
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocFeFe(cplcFeFehhL,cplcFeFehhR,MFe,Mhh,             & 
& MFe2,Mhh2,AmpTreehhTocFeFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocFeFe(ZcplcFeFehhL,ZcplcFeFehhR,MFe,               & 
& Mhh,MFe2,Mhh2,AmpTreehhTocFeFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFeFe(MLambda,em,gs,cplcFeFehhL,cplcFeFehhR,           & 
& MFeOS,MhhOS,MRPhhTocFeFe,MRGhhTocFeFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFeFe(MLambda,em,gs,ZcplcFeFehhL,ZcplcFeFehhR,         & 
& MFeOS,MhhOS,MRPhhTocFeFe,MRGhhTocFeFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocFeFe(MLambda,em,gs,cplcFeFehhL,cplcFeFehhR,           & 
& MFe,Mhh,MRPhhTocFeFe,MRGhhTocFeFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFeFe(MLambda,em,gs,ZcplcFeFehhL,ZcplcFeFehhR,         & 
& MFe,Mhh,MRPhhTocFeFe,MRGhhTocFeFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocFeFe(cplcFeFehhL,cplcFeFehhR,ctcplcFeFehhL,       & 
& ctcplcFeFehhR,MFe,MFe2,Mhh,Mhh2,ZfFEL,ZfFER,Zfhh,AmpWavehhTocFeFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,       & 
& cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,              & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcFecFuSdL,     & 
& cplcFecFuSdR,AmpVertexhhTocFeFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,          & 
& cplcFdFdhhR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,             & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRdrhhTocFeFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFeFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplcChaChahhL,  & 
& cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFecSeL,        & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFdcSuL,           & 
& cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,ZcplcFeFehhL,ZcplcFeFehhR,cplcFdFeSuL,           & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcFecFuSdL,cplcFecFuSdR,              & 
& AmpVertexIRoshhTocFeFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,          & 
& cplcFdFdhhR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,ZcplcFeFehhL,           & 
& ZcplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,              & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,             & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRoshhTocFeFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFeFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplcChaChahhL,  & 
& cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFecSeL,        & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFdcSuL,           & 
& cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,             & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcFecFuSdL,cplcFecFuSdR,              & 
& AmpVertexIRoshhTocFeFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,          & 
& cplcFdFdhhR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,             & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRoshhTocFeFe)

 End if 
 End if 
AmpVertexhhTocFeFe = AmpVertexhhTocFeFe -  AmpVertexIRdrhhTocFeFe! +  AmpVertexIRoshhTocFeFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocFeFe=0._dp 
AmpVertexZhhTocFeFe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocFeFe(:,gt2,:,:) = AmpWaveZhhTocFeFe(:,gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocFeFe(:,gt1,:,:) 
AmpVertexZhhTocFeFe(:,gt2,:,:)= AmpVertexZhhTocFeFe(:,gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocFeFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocFeFe=AmpWaveZhhTocFeFe 
AmpVertexhhTocFeFe= AmpVertexZhhTocFeFe
! Final State 1 
AmpWaveZhhTocFeFe=0._dp 
AmpVertexZhhTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocFeFe(1,:,gt2,:) = AmpWaveZhhTocFeFe(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpWavehhTocFeFe(1,:,gt1,:) 
AmpVertexZhhTocFeFe(1,:,gt2,:)= AmpVertexZhhTocFeFe(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpVertexhhTocFeFe(1,:,gt1,:) 
AmpWaveZhhTocFeFe(2,:,gt2,:) = AmpWaveZhhTocFeFe(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpWavehhTocFeFe(2,:,gt1,:) 
AmpVertexZhhTocFeFe(2,:,gt2,:)= AmpVertexZhhTocFeFe(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpVertexhhTocFeFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocFeFe=AmpWaveZhhTocFeFe 
AmpVertexhhTocFeFe= AmpVertexZhhTocFeFe
! Final State 2 
AmpWaveZhhTocFeFe=0._dp 
AmpVertexZhhTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocFeFe(1,:,:,gt2) = AmpWaveZhhTocFeFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWavehhTocFeFe(1,:,:,gt1) 
AmpVertexZhhTocFeFe(1,:,:,gt2)= AmpVertexZhhTocFeFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexhhTocFeFe(1,:,:,gt1) 
AmpWaveZhhTocFeFe(2,:,:,gt2) = AmpWaveZhhTocFeFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWavehhTocFeFe(2,:,:,gt1) 
AmpVertexZhhTocFeFe(2,:,:,gt2)= AmpVertexZhhTocFeFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexhhTocFeFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocFeFe=AmpWaveZhhTocFeFe 
AmpVertexhhTocFeFe= AmpVertexZhhTocFeFe
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocFeFe = AmpVertexhhTocFeFe  +  AmpVertexIRoshhTocFeFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->bar[Fe] Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocFeFe = AmpTreehhTocFeFe 
 AmpSum2hhTocFeFe = AmpTreehhTocFeFe + 2._dp*AmpWavehhTocFeFe + 2._dp*AmpVertexhhTocFeFe  
Else 
 AmpSumhhTocFeFe = AmpTreehhTocFeFe + AmpWavehhTocFeFe + AmpVertexhhTocFeFe
 AmpSum2hhTocFeFe = AmpTreehhTocFeFe + AmpWavehhTocFeFe + AmpVertexhhTocFeFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocFeFe = AmpTreehhTocFeFe
 AmpSum2hhTocFeFe = AmpTreehhTocFeFe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MFeOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MFe(gt2)+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocFeFe = AmpTreehhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFe(gt2),MFe(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocFeFe(gt1, gt2, gt3) 
  AmpSum2hhTocFeFe = 2._dp*AmpWavehhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFe(gt2),MFe(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocFeFe(gt1, gt2, gt3) 
  AmpSum2hhTocFeFe = 2._dp*AmpVertexhhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFe(gt2),MFe(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocFeFe(gt1, gt2, gt3) 
  AmpSum2hhTocFeFe = AmpTreehhTocFeFe + 2._dp*AmpWavehhTocFeFe + 2._dp*AmpVertexhhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFe(gt2),MFe(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocFeFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocFeFe = AmpTreehhTocFeFe
  Call SquareAmp_StoFF(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
  AmpSqTreehhTocFeFe(gt1, gt2, gt3) = (1)*AmpSqhhTocFeFe(gt1, gt2, gt3)  
  AmpSum2hhTocFeFe = + 2._dp*AmpWavehhTocFeFe + 2._dp*AmpVertexhhTocFeFe
  Call SquareAmp_StoFF(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
  AmpSqhhTocFeFe(gt1, gt2, gt3) = AmpSqhhTocFeFe(gt1, gt2, gt3) + AmpSqTreehhTocFeFe(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocFeFe = AmpTreehhTocFeFe
  Call SquareAmp_StoFF(Mhh(gt1),MFe(gt2),MFe(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
  AmpSqTreehhTocFeFe(gt1, gt2, gt3) = (1)*AmpSqhhTocFeFe(gt1, gt2, gt3)  
  AmpSum2hhTocFeFe = + 2._dp*AmpWavehhTocFeFe + 2._dp*AmpVertexhhTocFeFe
  Call SquareAmp_StoFF(Mhh(gt1),MFe(gt2),MFe(gt3),AmpSumhhTocFeFe(:,gt1, gt2, gt3),AmpSum2hhTocFeFe(:,gt1, gt2, gt3),AmpSqhhTocFeFe(gt1, gt2, gt3)) 
  AmpSqhhTocFeFe(gt1, gt2, gt3) = AmpSqhhTocFeFe(gt1, gt2, gt3) + AmpSqTreehhTocFeFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocFeFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhTocFeFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MFeOS(gt2),MFeOS(gt3),helfactor*AmpSqhhTocFeFe(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MFe(gt2),MFe(gt3),helfactor*AmpSqhhTocFeFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocFeFe(gt1, gt2, gt3) + MRGhhTocFeFe(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocFeFe(gt1, gt2, gt3) + MRGhhTocFeFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! bar(Fu) Fu
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocFuFu(cplcFuFuhhL,cplcFuFuhhR,MFu,Mhh,             & 
& MFu2,Mhh2,AmpTreehhTocFuFu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocFuFu(ZcplcFuFuhhL,ZcplcFuFuhhR,MFu,               & 
& Mhh,MFu2,Mhh2,AmpTreehhTocFuFu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFuFu(MLambda,em,gs,cplcFuFuhhL,cplcFuFuhhR,           & 
& MFuOS,MhhOS,MRPhhTocFuFu,MRGhhTocFuFu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFuFu(MLambda,em,gs,ZcplcFuFuhhL,ZcplcFuFuhhR,         & 
& MFuOS,MhhOS,MRPhhTocFuFu,MRGhhTocFuFu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocFuFu(MLambda,em,gs,cplcFuFuhhL,cplcFuFuhhR,           & 
& MFu,Mhh,MRPhhTocFuFu,MRGhhTocFuFu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocFuFu(MLambda,em,gs,ZcplcFuFuhhL,ZcplcFuFuhhR,         & 
& MFu,Mhh,MRPhhTocFuFu,MRGhhTocFuFu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocFuFu(cplcFuFuhhL,cplcFuFuhhR,ctcplcFuFuhhL,       & 
& ctcplcFuFuhhR,MFu,MFu2,Mhh,Mhh2,ZfFUL,ZfFUR,Zfhh,AmpWavehhTocFuFu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& AmpVertexhhTocFuFu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& AmpVertexIRdrhhTocFuFu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFuFu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRoshhTocFuFu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& AmpVertexIRoshhTocFuFu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFuFu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRoshhTocFuFu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& AmpVertexIRoshhTocFuFu)

 End if 
 End if 
AmpVertexhhTocFuFu = AmpVertexhhTocFuFu -  AmpVertexIRdrhhTocFuFu! +  AmpVertexIRoshhTocFuFu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocFuFu=0._dp 
AmpVertexZhhTocFuFu=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocFuFu(:,gt2,:,:) = AmpWaveZhhTocFuFu(:,gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocFuFu(:,gt1,:,:) 
AmpVertexZhhTocFuFu(:,gt2,:,:)= AmpVertexZhhTocFuFu(:,gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocFuFu(:,gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocFuFu=AmpWaveZhhTocFuFu 
AmpVertexhhTocFuFu= AmpVertexZhhTocFuFu
! Final State 1 
AmpWaveZhhTocFuFu=0._dp 
AmpVertexZhhTocFuFu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocFuFu(1,:,gt2,:) = AmpWaveZhhTocFuFu(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpWavehhTocFuFu(1,:,gt1,:) 
AmpVertexZhhTocFuFu(1,:,gt2,:)= AmpVertexZhhTocFuFu(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpVertexhhTocFuFu(1,:,gt1,:) 
AmpWaveZhhTocFuFu(2,:,gt2,:) = AmpWaveZhhTocFuFu(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpWavehhTocFuFu(2,:,gt1,:) 
AmpVertexZhhTocFuFu(2,:,gt2,:)= AmpVertexZhhTocFuFu(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpVertexhhTocFuFu(2,:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocFuFu=AmpWaveZhhTocFuFu 
AmpVertexhhTocFuFu= AmpVertexZhhTocFuFu
! Final State 2 
AmpWaveZhhTocFuFu=0._dp 
AmpVertexZhhTocFuFu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocFuFu(1,:,:,gt2) = AmpWaveZhhTocFuFu(1,:,:,gt2)+ZRUZUL(gt2,gt1)*AmpWavehhTocFuFu(1,:,:,gt1) 
AmpVertexZhhTocFuFu(1,:,:,gt2)= AmpVertexZhhTocFuFu(1,:,:,gt2)+ZRUZUL(gt2,gt1)*AmpVertexhhTocFuFu(1,:,:,gt1) 
AmpWaveZhhTocFuFu(2,:,:,gt2) = AmpWaveZhhTocFuFu(2,:,:,gt2)+ZRUZUR(gt2,gt1)*AmpWavehhTocFuFu(2,:,:,gt1) 
AmpVertexZhhTocFuFu(2,:,:,gt2)= AmpVertexZhhTocFuFu(2,:,:,gt2)+ZRUZUR(gt2,gt1)*AmpVertexhhTocFuFu(2,:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocFuFu=AmpWaveZhhTocFuFu 
AmpVertexhhTocFuFu= AmpVertexZhhTocFuFu
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocFuFu = AmpVertexhhTocFuFu  +  AmpVertexIRoshhTocFuFu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->bar[Fu] Fu -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocFuFu = AmpTreehhTocFuFu 
 AmpSum2hhTocFuFu = AmpTreehhTocFuFu + 2._dp*AmpWavehhTocFuFu + 2._dp*AmpVertexhhTocFuFu  
Else 
 AmpSumhhTocFuFu = AmpTreehhTocFuFu + AmpWavehhTocFuFu + AmpVertexhhTocFuFu
 AmpSum2hhTocFuFu = AmpTreehhTocFuFu + AmpWavehhTocFuFu + AmpVertexhhTocFuFu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocFuFu = AmpTreehhTocFuFu
 AmpSum2hhTocFuFu = AmpTreehhTocFuFu 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MFuOS(gt2)+MFuOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MFu(gt2)+MFu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocFuFu = AmpTreehhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFu(gt2),MFu(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocFuFu(gt1, gt2, gt3) 
  AmpSum2hhTocFuFu = 2._dp*AmpWavehhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFu(gt2),MFu(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocFuFu(gt1, gt2, gt3) 
  AmpSum2hhTocFuFu = 2._dp*AmpVertexhhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFu(gt2),MFu(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocFuFu(gt1, gt2, gt3) 
  AmpSum2hhTocFuFu = AmpTreehhTocFuFu + 2._dp*AmpWavehhTocFuFu + 2._dp*AmpVertexhhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MFu(gt2),MFu(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocFuFu(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocFuFu = AmpTreehhTocFuFu
  Call SquareAmp_StoFF(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
  AmpSqTreehhTocFuFu(gt1, gt2, gt3) = (3)*AmpSqhhTocFuFu(gt1, gt2, gt3)  
  AmpSum2hhTocFuFu = + 2._dp*AmpWavehhTocFuFu + 2._dp*AmpVertexhhTocFuFu
  Call SquareAmp_StoFF(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
  AmpSqhhTocFuFu(gt1, gt2, gt3) = AmpSqhhTocFuFu(gt1, gt2, gt3) + AmpSqTreehhTocFuFu(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocFuFu = AmpTreehhTocFuFu
  Call SquareAmp_StoFF(Mhh(gt1),MFu(gt2),MFu(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
  AmpSqTreehhTocFuFu(gt1, gt2, gt3) = (3)*AmpSqhhTocFuFu(gt1, gt2, gt3)  
  AmpSum2hhTocFuFu = + 2._dp*AmpWavehhTocFuFu + 2._dp*AmpVertexhhTocFuFu
  Call SquareAmp_StoFF(Mhh(gt1),MFu(gt2),MFu(gt3),AmpSumhhTocFuFu(:,gt1, gt2, gt3),AmpSum2hhTocFuFu(:,gt1, gt2, gt3),AmpSqhhTocFuFu(gt1, gt2, gt3)) 
  AmpSqhhTocFuFu(gt1, gt2, gt3) = AmpSqhhTocFuFu(gt1, gt2, gt3) + AmpSqTreehhTocFuFu(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocFuFu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhTocFuFu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MFuOS(gt2),MFuOS(gt3),helfactor*AmpSqhhTocFuFu(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MFu(gt2),MFu(gt3),helfactor*AmpSqhhTocFuFu(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocFuFu(gt1, gt2, gt3) + MRGhhTocFuFu(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocFuFu(gt1, gt2, gt3) + MRGhhTocFuFu(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! hh hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTohhhh(cplhhhhhh,Mhh,Mhh2,AmpTreehhTohhhh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTohhhh(Zcplhhhhhh,Mhh,Mhh2,AmpTreehhTohhhh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTohhhh(MLambda,em,gs,cplhhhhhh,MhhOS,MRPhhTohhhh,        & 
& MRGhhTohhhh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTohhhh(MLambda,em,gs,Zcplhhhhhh,MhhOS,MRPhhTohhhh,       & 
& MRGhhTohhhh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTohhhh(MLambda,em,gs,cplhhhhhh,Mhh,MRPhhTohhhh,          & 
& MRGhhTohhhh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTohhhh(MLambda,em,gs,Zcplhhhhhh,Mhh,MRPhhTohhhh,         & 
& MRGhhTohhhh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhhh(cplhhhhhh,ctcplhhhhhh,Mhh,Mhh2,               & 
& Zfhh,AmpWavehhTohhhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhhh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplcgZgZhh,cplhhhhhh,              & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplAhAhhhhh1,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,       & 
& cplhhhhSecSe1,cplhhhhSucSuaa,cplhhhhSvcSv1,cplhhhhcVWmVWm1,cplhhhhVZVZ1,               & 
& AmpVertexhhTohhhh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTohhhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplcgZgZhh,cplhhhhhh,              & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplAhAhhhhh1,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,       & 
& cplhhhhSecSe1,cplhhhhSucSuaa,cplhhhhSvcSv1,cplhhhhcVWmVWm1,cplhhhhVZVZ1,               & 
& AmpVertexIRdrhhTohhhh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTohhhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,           & 
& cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,              & 
& cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplcgZgZhh,Zcplhhhhhh,cplhhHpmcHpm,            & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhhhhh1,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,      & 
& cplhhhhSucSuaa,cplhhhhSvcSv1,cplhhhhcVWmVWm1,cplhhhhVZVZ1,AmpVertexIRoshhTohhhh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTohhhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplcgZgZhh,Zcplhhhhhh,             & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplAhAhhhhh1,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,       & 
& cplhhhhSecSe1,cplhhhhSucSuaa,cplhhhhSvcSv1,cplhhhhcVWmVWm1,cplhhhhVZVZ1,               & 
& AmpVertexIRoshhTohhhh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTohhhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,           & 
& cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,              & 
& cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplcgZgZhh,cplhhhhhh,cplhhHpmcHpm,             & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhhhhh1,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,      & 
& cplhhhhSucSuaa,cplhhhhSvcSv1,cplhhhhcVWmVWm1,cplhhhhVZVZ1,AmpVertexIRoshhTohhhh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTohhhh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplcgZgZhh,cplhhhhhh,              & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplAhAhhhhh1,cplhhhhhhhh1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,       & 
& cplhhhhSecSe1,cplhhhhSucSuaa,cplhhhhSvcSv1,cplhhhhcVWmVWm1,cplhhhhVZVZ1,               & 
& AmpVertexIRoshhTohhhh)

 End if 
 End if 
AmpVertexhhTohhhh = AmpVertexhhTohhhh -  AmpVertexIRdrhhTohhhh! +  AmpVertexIRoshhTohhhh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTohhhh=0._dp 
AmpVertexZhhTohhhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTohhhh(gt2,:,:) = AmpWaveZhhTohhhh(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTohhhh(gt1,:,:) 
AmpVertexZhhTohhhh(gt2,:,:)= AmpVertexZhhTohhhh(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTohhhh(gt1,:,:) 
 End Do 
End Do 
AmpWavehhTohhhh=AmpWaveZhhTohhhh 
AmpVertexhhTohhhh= AmpVertexZhhTohhhh
! Final State 1 
AmpWaveZhhTohhhh=0._dp 
AmpVertexZhhTohhhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTohhhh(:,gt2,:) = AmpWaveZhhTohhhh(:,gt2,:)+ZRUZH(gt2,gt1)*AmpWavehhTohhhh(:,gt1,:) 
AmpVertexZhhTohhhh(:,gt2,:)= AmpVertexZhhTohhhh(:,gt2,:)+ZRUZH(gt2,gt1)*AmpVertexhhTohhhh(:,gt1,:) 
 End Do 
End Do 
AmpWavehhTohhhh=AmpWaveZhhTohhhh 
AmpVertexhhTohhhh= AmpVertexZhhTohhhh
! Final State 2 
AmpWaveZhhTohhhh=0._dp 
AmpVertexZhhTohhhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTohhhh(:,:,gt2) = AmpWaveZhhTohhhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWavehhTohhhh(:,:,gt1) 
AmpVertexZhhTohhhh(:,:,gt2)= AmpVertexZhhTohhhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexhhTohhhh(:,:,gt1) 
 End Do 
End Do 
AmpWavehhTohhhh=AmpWaveZhhTohhhh 
AmpVertexhhTohhhh= AmpVertexZhhTohhhh
End if
If (ShiftIRdiv) Then 
AmpVertexhhTohhhh = AmpVertexhhTohhhh  +  AmpVertexIRoshhTohhhh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->hh hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTohhhh = AmpTreehhTohhhh 
 AmpSum2hhTohhhh = AmpTreehhTohhhh + 2._dp*AmpWavehhTohhhh + 2._dp*AmpVertexhhTohhhh  
Else 
 AmpSumhhTohhhh = AmpTreehhTohhhh + AmpWavehhTohhhh + AmpVertexhhTohhhh
 AmpSum2hhTohhhh = AmpTreehhTohhhh + AmpWavehhTohhhh + AmpVertexhhTohhhh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTohhhh = AmpTreehhTohhhh
 AmpSum2hhTohhhh = AmpTreehhTohhhh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=gt2,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MhhOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(Mhh(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTohhhh = AmpTreehhTohhhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),Mhh(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTohhhh(gt1, gt2, gt3) 
  AmpSum2hhTohhhh = 2._dp*AmpWavehhTohhhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),Mhh(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTohhhh(gt1, gt2, gt3) 
  AmpSum2hhTohhhh = 2._dp*AmpVertexhhTohhhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),Mhh(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTohhhh(gt1, gt2, gt3) 
  AmpSum2hhTohhhh = AmpTreehhTohhhh + 2._dp*AmpWavehhTohhhh + 2._dp*AmpVertexhhTohhhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),Mhh(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTohhhh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTohhhh = AmpTreehhTohhhh
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
  AmpSqTreehhTohhhh(gt1, gt2, gt3) = (1)*AmpSqhhTohhhh(gt1, gt2, gt3)  
  AmpSum2hhTohhhh = + 2._dp*AmpWavehhTohhhh + 2._dp*AmpVertexhhTohhhh
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
  AmpSqhhTohhhh(gt1, gt2, gt3) = AmpSqhhTohhhh(gt1, gt2, gt3) + AmpSqTreehhTohhhh(gt1, gt2, gt3)  
Else  
  AmpSum2hhTohhhh = AmpTreehhTohhhh
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),Mhh(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
  AmpSqTreehhTohhhh(gt1, gt2, gt3) = (1)*AmpSqhhTohhhh(gt1, gt2, gt3)  
  AmpSum2hhTohhhh = + 2._dp*AmpWavehhTohhhh + 2._dp*AmpVertexhhTohhhh
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),Mhh(gt3),AmpSumhhTohhhh(gt1, gt2, gt3),AmpSum2hhTohhhh(gt1, gt2, gt3),AmpSqhhTohhhh(gt1, gt2, gt3)) 
  AmpSqhhTohhhh(gt1, gt2, gt3) = AmpSqhhTohhhh(gt1, gt2, gt3) + AmpSqTreehhTohhhh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTohhhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqhhTohhhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(MhhOS(gt1),MhhOS(gt2),MhhOS(gt3),helfactor*AmpSqhhTohhhh(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(Mhh(gt1),Mhh(gt2),Mhh(gt3),helfactor*AmpSqhhTohhhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/4._dp*helfactor*(MRPhhTohhhh(gt1, gt2, gt3) + MRGhhTohhhh(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/4._dp*helfactor*(MRPhhTohhhh(gt1, gt2, gt3) + MRGhhTohhhh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Conjg(Hpm) Hpm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocHpmHpm(cplhhHpmcHpm,Mhh,MHpm,Mhh2,MHpm2,          & 
& AmpTreehhTocHpmHpm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocHpmHpm(ZcplhhHpmcHpm,Mhh,MHpm,Mhh2,               & 
& MHpm2,AmpTreehhTocHpmHpm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocHpmHpm(MLambda,em,gs,cplhhHpmcHpm,MhhOS,              & 
& MHpmOS,MRPhhTocHpmHpm,MRGhhTocHpmHpm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocHpmHpm(MLambda,em,gs,ZcplhhHpmcHpm,MhhOS,             & 
& MHpmOS,MRPhhTocHpmHpm,MRGhhTocHpmHpm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocHpmHpm(MLambda,em,gs,cplhhHpmcHpm,Mhh,MHpm,           & 
& MRPhhTocHpmHpm,MRGhhTocHpmHpm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocHpmHpm(MLambda,em,gs,ZcplhhHpmcHpm,Mhh,               & 
& MHpm,MRPhhTocHpmHpm,MRGhhTocHpmHpm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocHpmHpm(cplhhHpmcHpm,ctcplhhHpmcHpm,               & 
& Mhh,Mhh2,MHpm,MHpm2,Zfhh,ZfHpm,AmpWavehhTocHpmHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexhhTocHpmHpm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& AmpVertexIRdrhhTocHpmHpm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocHpmHpm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
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
& cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,AmpVertexIRoshhTocHpmHpm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& AmpVertexIRoshhTocHpmHpm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocHpmHpm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
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
& cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,AmpVertexIRoshhTocHpmHpm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& AmpVertexIRoshhTocHpmHpm)

 End if 
 End if 
AmpVertexhhTocHpmHpm = AmpVertexhhTocHpmHpm -  AmpVertexIRdrhhTocHpmHpm! +  AmpVertexIRoshhTocHpmHpm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocHpmHpm=0._dp 
AmpVertexZhhTocHpmHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocHpmHpm(gt2,:,:) = AmpWaveZhhTocHpmHpm(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocHpmHpm(gt1,:,:) 
AmpVertexZhhTocHpmHpm(gt2,:,:)= AmpVertexZhhTocHpmHpm(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocHpmHpm(gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocHpmHpm=AmpWaveZhhTocHpmHpm 
AmpVertexhhTocHpmHpm= AmpVertexZhhTocHpmHpm
! Final State 1 
AmpWaveZhhTocHpmHpm=0._dp 
AmpVertexZhhTocHpmHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocHpmHpm(:,gt2,:) = AmpWaveZhhTocHpmHpm(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWavehhTocHpmHpm(:,gt1,:) 
AmpVertexZhhTocHpmHpm(:,gt2,:)= AmpVertexZhhTocHpmHpm(:,gt2,:)+ZRUZP(gt2,gt1)*AmpVertexhhTocHpmHpm(:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocHpmHpm=AmpWaveZhhTocHpmHpm 
AmpVertexhhTocHpmHpm= AmpVertexZhhTocHpmHpm
! Final State 2 
AmpWaveZhhTocHpmHpm=0._dp 
AmpVertexZhhTocHpmHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocHpmHpm(:,:,gt2) = AmpWaveZhhTocHpmHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWavehhTocHpmHpm(:,:,gt1) 
AmpVertexZhhTocHpmHpm(:,:,gt2)= AmpVertexZhhTocHpmHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexhhTocHpmHpm(:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocHpmHpm=AmpWaveZhhTocHpmHpm 
AmpVertexhhTocHpmHpm= AmpVertexZhhTocHpmHpm
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocHpmHpm = AmpVertexhhTocHpmHpm  +  AmpVertexIRoshhTocHpmHpm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->conj[Hpm] Hpm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocHpmHpm = AmpTreehhTocHpmHpm 
 AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm + 2._dp*AmpWavehhTocHpmHpm + 2._dp*AmpVertexhhTocHpmHpm  
Else 
 AmpSumhhTocHpmHpm = AmpTreehhTocHpmHpm + AmpWavehhTocHpmHpm + AmpVertexhhTocHpmHpm
 AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm + AmpWavehhTocHpmHpm + AmpVertexhhTocHpmHpm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocHpmHpm = AmpTreehhTocHpmHpm
 AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=2,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MHpmOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MHpm(gt2)+MHpm(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MHpm(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocHpmHpm(gt1, gt2, gt3) 
  AmpSum2hhTocHpmHpm = 2._dp*AmpWavehhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MHpm(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocHpmHpm(gt1, gt2, gt3) 
  AmpSum2hhTocHpmHpm = 2._dp*AmpVertexhhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MHpm(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocHpmHpm(gt1, gt2, gt3) 
  AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm + 2._dp*AmpWavehhTocHpmHpm + 2._dp*AmpVertexhhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MHpm(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocHpmHpm(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqTreehhTocHpmHpm(gt1, gt2, gt3) = (1)*AmpSqhhTocHpmHpm(gt1, gt2, gt3)  
  AmpSum2hhTocHpmHpm = + 2._dp*AmpWavehhTocHpmHpm + 2._dp*AmpVertexhhTocHpmHpm
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqhhTocHpmHpm(gt1, gt2, gt3) = AmpSqhhTocHpmHpm(gt1, gt2, gt3) + AmpSqTreehhTocHpmHpm(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocHpmHpm = AmpTreehhTocHpmHpm
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MHpm(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqTreehhTocHpmHpm(gt1, gt2, gt3) = (1)*AmpSqhhTocHpmHpm(gt1, gt2, gt3)  
  AmpSum2hhTocHpmHpm = + 2._dp*AmpWavehhTocHpmHpm + 2._dp*AmpVertexhhTocHpmHpm
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MHpm(gt3),AmpSumhhTocHpmHpm(gt1, gt2, gt3),AmpSum2hhTocHpmHpm(gt1, gt2, gt3),AmpSqhhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqhhTocHpmHpm(gt1, gt2, gt3) = AmpSqhhTocHpmHpm(gt1, gt2, gt3) + AmpSqTreehhTocHpmHpm(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocHpmHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTocHpmHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),helfactor*AmpSqhhTocHpmHpm(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MHpm(gt2),MHpm(gt3),helfactor*AmpSqhhTocHpmHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocHpmHpm(gt1, gt2, gt3) + MRGhhTocHpmHpm(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocHpmHpm(gt1, gt2, gt3) + MRGhhTocHpmHpm(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Hpm Conjg(VWm)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhToHpmcVWm(cplhhHpmcVWm,Mhh,MHpm,MVWm,Mhh2,           & 
& MHpm2,MVWm2,AmpTreehhToHpmcVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhToHpmcVWm(ZcplhhHpmcVWm,Mhh,MHpm,MVWm,               & 
& Mhh2,MHpm2,MVWm2,AmpTreehhToHpmcVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToHpmcVWm(MLambda,em,gs,cplhhHpmcVWm,MhhOS,              & 
& MHpmOS,MVWmOS,MRPhhToHpmcVWm,MRGhhToHpmcVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToHpmcVWm(MLambda,em,gs,ZcplhhHpmcVWm,MhhOS,             & 
& MHpmOS,MVWmOS,MRPhhToHpmcVWm,MRGhhToHpmcVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhToHpmcVWm(MLambda,em,gs,cplhhHpmcVWm,Mhh,MHpm,           & 
& MVWm,MRPhhToHpmcVWm,MRGhhToHpmcVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToHpmcVWm(MLambda,em,gs,ZcplhhHpmcVWm,Mhh,               & 
& MHpm,MVWm,MRPhhToHpmcVWm,MRGhhToHpmcVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToHpmcVWm(cplhhHpmcVWm,ctcplhhHpmcVWm,               & 
& Mhh,Mhh2,MHpm,MHpm2,MVWm,MVWm2,Zfhh,ZfHpm,ZfVWm,AmpWavehhToHpmcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgAhh,            & 
& cplcgWmgAHpm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgZgWpCHpm,    & 
& cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexhhToHpmcVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgAhh,            & 
& cplcgWmgAHpm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgZgWpCHpm,    & 
& cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRdrhhToHpmcVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToHpmcVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgAhh,cplcgWmgAHpm,           & 
& cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,      & 
& cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhhhhh,GosZcplhhHpmcHpm,ZcplhhHpmcVWm,cplhhSdcSd,       & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,      & 
& cplHpmSvcSe,cplHpmcHpmVP,GosZcplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,      & 
& cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,& 
& cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRoshhToHpmcVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgAhh,            & 
& cplcgWmgAHpm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgZgWpCHpm,    & 
& cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhhhhh,GZcplhhHpmcHpm,ZcplhhHpmcVWm,         & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,GZcplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,         & 
& cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRoshhToHpmcVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToHpmcVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgAhh,cplcgWmgAHpm,           & 
& cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,      & 
& cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhhhhh,GcplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,           & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,      & 
& cplHpmSvcSe,cplHpmcHpmVP,GcplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,         & 
& cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,& 
& cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRoshhToHpmcVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgZgAhh,            & 
& cplcgWmgAHpm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgZgWpCHpm,    & 
& cplcgZgZhh,cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRoshhToHpmcVWm)

 End if 
 End if 
AmpVertexhhToHpmcVWm = AmpVertexhhToHpmcVWm -  AmpVertexIRdrhhToHpmcVWm! +  AmpVertexIRoshhToHpmcVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhToHpmcVWm=0._dp 
AmpVertexZhhToHpmcVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToHpmcVWm(:,gt2,:) = AmpWaveZhhToHpmcVWm(:,gt2,:)+ZRUZH(gt2,gt1)*AmpWavehhToHpmcVWm(:,gt1,:) 
AmpVertexZhhToHpmcVWm(:,gt2,:)= AmpVertexZhhToHpmcVWm(:,gt2,:) + ZRUZH(gt2,gt1)*AmpVertexhhToHpmcVWm(:,gt1,:) 
 End Do 
End Do 
AmpWavehhToHpmcVWm=AmpWaveZhhToHpmcVWm 
AmpVertexhhToHpmcVWm= AmpVertexZhhToHpmcVWm
! Final State 1 
AmpWaveZhhToHpmcVWm=0._dp 
AmpVertexZhhToHpmcVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToHpmcVWm(:,:,gt2) = AmpWaveZhhToHpmcVWm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWavehhToHpmcVWm(:,:,gt1) 
AmpVertexZhhToHpmcVWm(:,:,gt2)= AmpVertexZhhToHpmcVWm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexhhToHpmcVWm(:,:,gt1) 
 End Do 
End Do 
AmpWavehhToHpmcVWm=AmpWaveZhhToHpmcVWm 
AmpVertexhhToHpmcVWm= AmpVertexZhhToHpmcVWm
End if
If (ShiftIRdiv) Then 
AmpVertexhhToHpmcVWm = AmpVertexhhToHpmcVWm  +  AmpVertexIRoshhToHpmcVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Hpm conj[VWm] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhToHpmcVWm = AmpTreehhToHpmcVWm 
 AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm + 2._dp*AmpWavehhToHpmcVWm + 2._dp*AmpVertexhhToHpmcVWm  
Else 
 AmpSumhhToHpmcVWm = AmpTreehhToHpmcVWm + AmpWavehhToHpmcVWm + AmpVertexhhToHpmcVWm
 AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm + AmpWavehhToHpmcVWm + AmpVertexhhToHpmcVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToHpmcVWm = AmpTreehhToHpmcVWm
 AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MHpmOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MHpm(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MHpm(gt2),MVWm,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhToHpmcVWm(gt1, gt2) 
  AmpSum2hhToHpmcVWm = 2._dp*AmpWavehhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MHpm(gt2),MVWm,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhToHpmcVWm(gt1, gt2) 
  AmpSum2hhToHpmcVWm = 2._dp*AmpVertexhhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MHpm(gt2),MVWm,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhToHpmcVWm(gt1, gt2) 
  AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm + 2._dp*AmpWavehhToHpmcVWm + 2._dp*AmpVertexhhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MHpm(gt2),MVWm,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhToHpmcVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm
  Call SquareAmp_StoSV(MhhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
  AmpSqTreehhToHpmcVWm(gt1, gt2) = (1)*AmpSqhhToHpmcVWm(gt1, gt2)  
  AmpSum2hhToHpmcVWm = + 2._dp*AmpWavehhToHpmcVWm + 2._dp*AmpVertexhhToHpmcVWm
  Call SquareAmp_StoSV(MhhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
  AmpSqhhToHpmcVWm(gt1, gt2) = AmpSqhhToHpmcVWm(gt1, gt2) + AmpSqTreehhToHpmcVWm(gt1, gt2)  
Else  
  AmpSum2hhToHpmcVWm = AmpTreehhToHpmcVWm
  Call SquareAmp_StoSV(Mhh(gt1),MHpm(gt2),MVWm,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
  AmpSqTreehhToHpmcVWm(gt1, gt2) = (1)*AmpSqhhToHpmcVWm(gt1, gt2)  
  AmpSum2hhToHpmcVWm = + 2._dp*AmpWavehhToHpmcVWm + 2._dp*AmpVertexhhToHpmcVWm
  Call SquareAmp_StoSV(Mhh(gt1),MHpm(gt2),MVWm,AmpSumhhToHpmcVWm(:,gt1, gt2),AmpSum2hhToHpmcVWm(:,gt1, gt2),AmpSqhhToHpmcVWm(gt1, gt2)) 
  AmpSqhhToHpmcVWm(gt1, gt2) = AmpSqhhToHpmcVWm(gt1, gt2) + AmpSqTreehhToHpmcVWm(gt1, gt2)  
End if  
Else  
  AmpSqhhToHpmcVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToHpmcVWm(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MHpmOS(gt2),MVWmOS,helfactor*AmpSqhhToHpmcVWm(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MHpm(gt2),MVWm,helfactor*AmpSqhhToHpmcVWm(gt1, gt2))
End if 
If ((Abs(MRPhhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*2*helfactor*(MRPhhToHpmcVWm(gt1, gt2) + MRGhhToHpmcVWm(gt1, gt2)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*2*helfactor*(MRPhhToHpmcVWm(gt1, gt2) + MRGhhToHpmcVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Conjg(Sd) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocSdSd(cplhhSdcSd,Mhh,MSd,Mhh2,MSd2,AmpTreehhTocSdSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocSdSd(ZcplhhSdcSd,Mhh,MSd,Mhh2,MSd2,               & 
& AmpTreehhTocSdSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSdSd(MLambda,em,gs,cplhhSdcSd,MhhOS,MSdOS,            & 
& MRPhhTocSdSd,MRGhhTocSdSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSdSd(MLambda,em,gs,ZcplhhSdcSd,MhhOS,MSdOS,           & 
& MRPhhTocSdSd,MRGhhTocSdSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocSdSd(MLambda,em,gs,cplhhSdcSd,Mhh,MSd,MRPhhTocSdSd,   & 
& MRGhhTocSdSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSdSd(MLambda,em,gs,ZcplhhSdcSd,Mhh,MSd,               & 
& MRPhhTocSdSd,MRGhhTocSdSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocSdSd(cplhhSdcSd,ctcplhhSdcSd,Mhh,Mhh2,            & 
& MSd,MSd2,Zfhh,ZfSd,AmpWavehhTocSdSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexhhTocSdSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRdrhhTocSdSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSdSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRoshhTocSdSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRoshhTocSdSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSdSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRoshhTocSdSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,AmpVertexIRoshhTocSdSd)

 End if 
 End if 
AmpVertexhhTocSdSd = AmpVertexhhTocSdSd -  AmpVertexIRdrhhTocSdSd! +  AmpVertexIRoshhTocSdSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocSdSd=0._dp 
AmpVertexZhhTocSdSd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocSdSd(gt2,:,:) = AmpWaveZhhTocSdSd(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocSdSd(gt1,:,:) 
AmpVertexZhhTocSdSd(gt2,:,:)= AmpVertexZhhTocSdSd(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocSdSd(gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocSdSd=AmpWaveZhhTocSdSd 
AmpVertexhhTocSdSd= AmpVertexZhhTocSdSd
! Final State 1 
AmpWaveZhhTocSdSd=0._dp 
AmpVertexZhhTocSdSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZhhTocSdSd(:,gt2,:) = AmpWaveZhhTocSdSd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpWavehhTocSdSd(:,gt1,:) 
AmpVertexZhhTocSdSd(:,gt2,:)= AmpVertexZhhTocSdSd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpVertexhhTocSdSd(:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocSdSd=AmpWaveZhhTocSdSd 
AmpVertexhhTocSdSd= AmpVertexZhhTocSdSd
! Final State 2 
AmpWaveZhhTocSdSd=0._dp 
AmpVertexZhhTocSdSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZhhTocSdSd(:,:,gt2) = AmpWaveZhhTocSdSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWavehhTocSdSd(:,:,gt1) 
AmpVertexZhhTocSdSd(:,:,gt2)= AmpVertexZhhTocSdSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexhhTocSdSd(:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocSdSd=AmpWaveZhhTocSdSd 
AmpVertexhhTocSdSd= AmpVertexZhhTocSdSd
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocSdSd = AmpVertexhhTocSdSd  +  AmpVertexIRoshhTocSdSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->conj[Sd] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocSdSd = AmpTreehhTocSdSd 
 AmpSum2hhTocSdSd = AmpTreehhTocSdSd + 2._dp*AmpWavehhTocSdSd + 2._dp*AmpVertexhhTocSdSd  
Else 
 AmpSumhhTocSdSd = AmpTreehhTocSdSd + AmpWavehhTocSdSd + AmpVertexhhTocSdSd
 AmpSum2hhTocSdSd = AmpTreehhTocSdSd + AmpWavehhTocSdSd + AmpVertexhhTocSdSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocSdSd = AmpTreehhTocSdSd
 AmpSum2hhTocSdSd = AmpTreehhTocSdSd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSdOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSd(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocSdSd = AmpTreehhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSd(gt2),MSd(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocSdSd(gt1, gt2, gt3) 
  AmpSum2hhTocSdSd = 2._dp*AmpWavehhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSd(gt2),MSd(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocSdSd(gt1, gt2, gt3) 
  AmpSum2hhTocSdSd = 2._dp*AmpVertexhhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSd(gt2),MSd(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocSdSd(gt1, gt2, gt3) 
  AmpSum2hhTocSdSd = AmpTreehhTocSdSd + 2._dp*AmpWavehhTocSdSd + 2._dp*AmpVertexhhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSd(gt2),MSd(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocSdSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocSdSd = AmpTreehhTocSdSd
  Call SquareAmp_StoSS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
  AmpSqTreehhTocSdSd(gt1, gt2, gt3) = (3)*AmpSqhhTocSdSd(gt1, gt2, gt3)  
  AmpSum2hhTocSdSd = + 2._dp*AmpWavehhTocSdSd + 2._dp*AmpVertexhhTocSdSd
  Call SquareAmp_StoSS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
  AmpSqhhTocSdSd(gt1, gt2, gt3) = AmpSqhhTocSdSd(gt1, gt2, gt3) + AmpSqTreehhTocSdSd(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocSdSd = AmpTreehhTocSdSd
  Call SquareAmp_StoSS(Mhh(gt1),MSd(gt2),MSd(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
  AmpSqTreehhTocSdSd(gt1, gt2, gt3) = (3)*AmpSqhhTocSdSd(gt1, gt2, gt3)  
  AmpSum2hhTocSdSd = + 2._dp*AmpWavehhTocSdSd + 2._dp*AmpVertexhhTocSdSd
  Call SquareAmp_StoSS(Mhh(gt1),MSd(gt2),MSd(gt3),AmpSumhhTocSdSd(gt1, gt2, gt3),AmpSum2hhTocSdSd(gt1, gt2, gt3),AmpSqhhTocSdSd(gt1, gt2, gt3)) 
  AmpSqhhTocSdSd(gt1, gt2, gt3) = AmpSqhhTocSdSd(gt1, gt2, gt3) + AmpSqTreehhTocSdSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocSdSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTocSdSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MSdOS(gt2),MSdOS(gt3),helfactor*AmpSqhhTocSdSd(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MSd(gt2),MSd(gt3),helfactor*AmpSqhhTocSdSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSdSd(gt1, gt2, gt3) + MRGhhTocSdSd(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSdSd(gt1, gt2, gt3) + MRGhhTocSdSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Conjg(Se) Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocSeSe(cplhhSecSe,Mhh,MSe,Mhh2,MSe2,AmpTreehhTocSeSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocSeSe(ZcplhhSecSe,Mhh,MSe,Mhh2,MSe2,               & 
& AmpTreehhTocSeSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSeSe(MLambda,em,gs,cplhhSecSe,MhhOS,MSeOS,            & 
& MRPhhTocSeSe,MRGhhTocSeSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSeSe(MLambda,em,gs,ZcplhhSecSe,MhhOS,MSeOS,           & 
& MRPhhTocSeSe,MRGhhTocSeSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocSeSe(MLambda,em,gs,cplhhSecSe,Mhh,MSe,MRPhhTocSeSe,   & 
& MRGhhTocSeSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSeSe(MLambda,em,gs,ZcplhhSecSe,Mhh,MSe,               & 
& MRPhhTocSeSe,MRGhhTocSeSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocSeSe(cplhhSecSe,ctcplhhSecSe,Mhh,Mhh2,            & 
& MSe,MSe2,Zfhh,ZfSe,AmpWavehhTocSeSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,       & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiFecSeL,       & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,              & 
& cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,             & 
& cplcFeFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,      & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,     & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,    & 
& cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa,             & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,          & 
& AmpVertexhhTocSeSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhSecSe,              & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,     & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa, & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,          & 
& AmpVertexIRdrhhTocSeSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSeSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,   & 
& cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiFecSeL,cplChiFecSeR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,ZcplhhSecSe,cplhhSucSu,cplhhSvcSv,      & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,     & 
& cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,               & 
& cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa,             & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,          & 
& AmpVertexIRoshhTocSeSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhSecSe,              & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,ZcplhhSecSe,    & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa, & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,          & 
& AmpVertexIRoshhTocSeSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSeSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,   & 
& cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiFecSeL,cplChiFecSeR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,     & 
& cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,               & 
& cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa,             & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,          & 
& AmpVertexIRoshhTocSeSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhSecSe,              & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,     & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa, & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,          & 
& AmpVertexIRoshhTocSeSe)

 End if 
 End if 
AmpVertexhhTocSeSe = AmpVertexhhTocSeSe -  AmpVertexIRdrhhTocSeSe! +  AmpVertexIRoshhTocSeSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocSeSe=0._dp 
AmpVertexZhhTocSeSe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocSeSe(gt2,:,:) = AmpWaveZhhTocSeSe(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocSeSe(gt1,:,:) 
AmpVertexZhhTocSeSe(gt2,:,:)= AmpVertexZhhTocSeSe(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocSeSe(gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocSeSe=AmpWaveZhhTocSeSe 
AmpVertexhhTocSeSe= AmpVertexZhhTocSeSe
! Final State 1 
AmpWaveZhhTocSeSe=0._dp 
AmpVertexZhhTocSeSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZhhTocSeSe(:,gt2,:) = AmpWaveZhhTocSeSe(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpWavehhTocSeSe(:,gt1,:) 
AmpVertexZhhTocSeSe(:,gt2,:)= AmpVertexZhhTocSeSe(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpVertexhhTocSeSe(:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocSeSe=AmpWaveZhhTocSeSe 
AmpVertexhhTocSeSe= AmpVertexZhhTocSeSe
! Final State 2 
AmpWaveZhhTocSeSe=0._dp 
AmpVertexZhhTocSeSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZhhTocSeSe(:,:,gt2) = AmpWaveZhhTocSeSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWavehhTocSeSe(:,:,gt1) 
AmpVertexZhhTocSeSe(:,:,gt2)= AmpVertexZhhTocSeSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexhhTocSeSe(:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocSeSe=AmpWaveZhhTocSeSe 
AmpVertexhhTocSeSe= AmpVertexZhhTocSeSe
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocSeSe = AmpVertexhhTocSeSe  +  AmpVertexIRoshhTocSeSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->conj[Se] Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocSeSe = AmpTreehhTocSeSe 
 AmpSum2hhTocSeSe = AmpTreehhTocSeSe + 2._dp*AmpWavehhTocSeSe + 2._dp*AmpVertexhhTocSeSe  
Else 
 AmpSumhhTocSeSe = AmpTreehhTocSeSe + AmpWavehhTocSeSe + AmpVertexhhTocSeSe
 AmpSum2hhTocSeSe = AmpTreehhTocSeSe + AmpWavehhTocSeSe + AmpVertexhhTocSeSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocSeSe = AmpTreehhTocSeSe
 AmpSum2hhTocSeSe = AmpTreehhTocSeSe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSeOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSe(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocSeSe = AmpTreehhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSe(gt2),MSe(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocSeSe(gt1, gt2, gt3) 
  AmpSum2hhTocSeSe = 2._dp*AmpWavehhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSe(gt2),MSe(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocSeSe(gt1, gt2, gt3) 
  AmpSum2hhTocSeSe = 2._dp*AmpVertexhhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSe(gt2),MSe(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocSeSe(gt1, gt2, gt3) 
  AmpSum2hhTocSeSe = AmpTreehhTocSeSe + 2._dp*AmpWavehhTocSeSe + 2._dp*AmpVertexhhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSe(gt2),MSe(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocSeSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocSeSe = AmpTreehhTocSeSe
  Call SquareAmp_StoSS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
  AmpSqTreehhTocSeSe(gt1, gt2, gt3) = (1)*AmpSqhhTocSeSe(gt1, gt2, gt3)  
  AmpSum2hhTocSeSe = + 2._dp*AmpWavehhTocSeSe + 2._dp*AmpVertexhhTocSeSe
  Call SquareAmp_StoSS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
  AmpSqhhTocSeSe(gt1, gt2, gt3) = AmpSqhhTocSeSe(gt1, gt2, gt3) + AmpSqTreehhTocSeSe(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocSeSe = AmpTreehhTocSeSe
  Call SquareAmp_StoSS(Mhh(gt1),MSe(gt2),MSe(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
  AmpSqTreehhTocSeSe(gt1, gt2, gt3) = (1)*AmpSqhhTocSeSe(gt1, gt2, gt3)  
  AmpSum2hhTocSeSe = + 2._dp*AmpWavehhTocSeSe + 2._dp*AmpVertexhhTocSeSe
  Call SquareAmp_StoSS(Mhh(gt1),MSe(gt2),MSe(gt3),AmpSumhhTocSeSe(gt1, gt2, gt3),AmpSum2hhTocSeSe(gt1, gt2, gt3),AmpSqhhTocSeSe(gt1, gt2, gt3)) 
  AmpSqhhTocSeSe(gt1, gt2, gt3) = AmpSqhhTocSeSe(gt1, gt2, gt3) + AmpSqTreehhTocSeSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocSeSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTocSeSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MSeOS(gt2),MSeOS(gt3),helfactor*AmpSqhhTocSeSe(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MSe(gt2),MSe(gt3),helfactor*AmpSqhhTocSeSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSeSe(gt1, gt2, gt3) + MRGhhTocSeSe(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSeSe(gt1, gt2, gt3) + MRGhhTocSeSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Conjg(Su) Su
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocSuSu(cplhhSucSu,Mhh,MSu,Mhh2,MSu2,AmpTreehhTocSuSu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocSuSu(ZcplhhSucSu,Mhh,MSu,Mhh2,MSu2,               & 
& AmpTreehhTocSuSu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSuSu(MLambda,em,gs,cplhhSucSu,MhhOS,MSuOS,            & 
& MRPhhTocSuSu,MRGhhTocSuSu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSuSu(MLambda,em,gs,ZcplhhSucSu,MhhOS,MSuOS,           & 
& MRPhhTocSuSu,MRGhhTocSuSu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocSuSu(MLambda,em,gs,cplhhSucSu,Mhh,MSu,MRPhhTocSuSu,   & 
& MRGhhTocSuSu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSuSu(MLambda,em,gs,ZcplhhSucSu,Mhh,MSu,               & 
& MRPhhTocSuSu,MRGhhTocSuSu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocSuSu(cplhhSucSu,ctcplhhSucSu,Mhh,Mhh2,            & 
& MSu,MSu2,Zfhh,ZfSu,AmpWavehhTocSuSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexhhTocSuSu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexIRdrhhTocSuSu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSuSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSucSuVZVZaa,AmpVertexIRoshhTocSuSu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexIRoshhTocSuSu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSuSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSucSuVZVZaa,AmpVertexIRoshhTocSuSu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,AmpVertexIRoshhTocSuSu)

 End if 
 End if 
AmpVertexhhTocSuSu = AmpVertexhhTocSuSu -  AmpVertexIRdrhhTocSuSu! +  AmpVertexIRoshhTocSuSu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocSuSu=0._dp 
AmpVertexZhhTocSuSu=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocSuSu(gt2,:,:) = AmpWaveZhhTocSuSu(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocSuSu(gt1,:,:) 
AmpVertexZhhTocSuSu(gt2,:,:)= AmpVertexZhhTocSuSu(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocSuSu(gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocSuSu=AmpWaveZhhTocSuSu 
AmpVertexhhTocSuSu= AmpVertexZhhTocSuSu
! Final State 1 
AmpWaveZhhTocSuSu=0._dp 
AmpVertexZhhTocSuSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZhhTocSuSu(:,gt2,:) = AmpWaveZhhTocSuSu(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWavehhTocSuSu(:,gt1,:) 
AmpVertexZhhTocSuSu(:,gt2,:)= AmpVertexZhhTocSuSu(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpVertexhhTocSuSu(:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocSuSu=AmpWaveZhhTocSuSu 
AmpVertexhhTocSuSu= AmpVertexZhhTocSuSu
! Final State 2 
AmpWaveZhhTocSuSu=0._dp 
AmpVertexZhhTocSuSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZhhTocSuSu(:,:,gt2) = AmpWaveZhhTocSuSu(:,:,gt2)+ZRUZU(gt2,gt1)*AmpWavehhTocSuSu(:,:,gt1) 
AmpVertexZhhTocSuSu(:,:,gt2)= AmpVertexZhhTocSuSu(:,:,gt2)+ZRUZU(gt2,gt1)*AmpVertexhhTocSuSu(:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocSuSu=AmpWaveZhhTocSuSu 
AmpVertexhhTocSuSu= AmpVertexZhhTocSuSu
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocSuSu = AmpVertexhhTocSuSu  +  AmpVertexIRoshhTocSuSu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->conj[Su] Su -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocSuSu = AmpTreehhTocSuSu 
 AmpSum2hhTocSuSu = AmpTreehhTocSuSu + 2._dp*AmpWavehhTocSuSu + 2._dp*AmpVertexhhTocSuSu  
Else 
 AmpSumhhTocSuSu = AmpTreehhTocSuSu + AmpWavehhTocSuSu + AmpVertexhhTocSuSu
 AmpSum2hhTocSuSu = AmpTreehhTocSuSu + AmpWavehhTocSuSu + AmpVertexhhTocSuSu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocSuSu = AmpTreehhTocSuSu
 AmpSum2hhTocSuSu = AmpTreehhTocSuSu 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSuOS(gt2)+MSuOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSu(gt2)+MSu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocSuSu = AmpTreehhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSu(gt2),MSu(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocSuSu(gt1, gt2, gt3) 
  AmpSum2hhTocSuSu = 2._dp*AmpWavehhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSu(gt2),MSu(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocSuSu(gt1, gt2, gt3) 
  AmpSum2hhTocSuSu = 2._dp*AmpVertexhhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSu(gt2),MSu(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocSuSu(gt1, gt2, gt3) 
  AmpSum2hhTocSuSu = AmpTreehhTocSuSu + 2._dp*AmpWavehhTocSuSu + 2._dp*AmpVertexhhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSu(gt2),MSu(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocSuSu(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocSuSu = AmpTreehhTocSuSu
  Call SquareAmp_StoSS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
  AmpSqTreehhTocSuSu(gt1, gt2, gt3) = (3)*AmpSqhhTocSuSu(gt1, gt2, gt3)  
  AmpSum2hhTocSuSu = + 2._dp*AmpWavehhTocSuSu + 2._dp*AmpVertexhhTocSuSu
  Call SquareAmp_StoSS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
  AmpSqhhTocSuSu(gt1, gt2, gt3) = AmpSqhhTocSuSu(gt1, gt2, gt3) + AmpSqTreehhTocSuSu(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocSuSu = AmpTreehhTocSuSu
  Call SquareAmp_StoSS(Mhh(gt1),MSu(gt2),MSu(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
  AmpSqTreehhTocSuSu(gt1, gt2, gt3) = (3)*AmpSqhhTocSuSu(gt1, gt2, gt3)  
  AmpSum2hhTocSuSu = + 2._dp*AmpWavehhTocSuSu + 2._dp*AmpVertexhhTocSuSu
  Call SquareAmp_StoSS(Mhh(gt1),MSu(gt2),MSu(gt3),AmpSumhhTocSuSu(gt1, gt2, gt3),AmpSum2hhTocSuSu(gt1, gt2, gt3),AmpSqhhTocSuSu(gt1, gt2, gt3)) 
  AmpSqhhTocSuSu(gt1, gt2, gt3) = AmpSqhhTocSuSu(gt1, gt2, gt3) + AmpSqTreehhTocSuSu(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocSuSu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTocSuSu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MSuOS(gt2),MSuOS(gt3),helfactor*AmpSqhhTocSuSu(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MSu(gt2),MSu(gt3),helfactor*AmpSqhhTocSuSu(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSuSu(gt1, gt2, gt3) + MRGhhTocSuSu(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSuSu(gt1, gt2, gt3) + MRGhhTocSuSu(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Conjg(Sv) Sv
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocSvSv(cplhhSvcSv,Mhh,MSv,Mhh2,MSv2,AmpTreehhTocSvSv)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocSvSv(ZcplhhSvcSv,Mhh,MSv,Mhh2,MSv2,               & 
& AmpTreehhTocSvSv)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSvSv(MLambda,em,gs,cplhhSvcSv,MhhOS,MSvOS,            & 
& MRPhhTocSvSv,MRGhhTocSvSv)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSvSv(MLambda,em,gs,ZcplhhSvcSv,MhhOS,MSvOS,           & 
& MRPhhTocSvSv,MRGhhTocSvSv)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocSvSv(MLambda,em,gs,cplhhSvcSv,Mhh,MSv,MRPhhTocSvSv,   & 
& MRGhhTocSvSv)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocSvSv(MLambda,em,gs,ZcplhhSvcSv,Mhh,MSv,               & 
& MRPhhTocSvSv,MRGhhTocSvSv)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocSvSv(cplhhSvcSv,ctcplhhSvcSv,Mhh,Mhh2,            & 
& MSv,MSv2,Zfhh,ZfSv,AmpWavehhTocSvSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocSvSv(MAh,MCha,MChi,MFd,MFe,Mhh,MHpm,            & 
& MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,              & 
& MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,               & 
& cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,             & 
& cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,            & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,      & 
& cplhhSdcSdcSvaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,         & 
& cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,        & 
& cplSvcSvVZVZ1,AmpVertexhhTocSvSv)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSvSv(MAh,MCha,MChi,MFd,MFe,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,              & 
& MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,          & 
& cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,             & 
& cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,            & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,      & 
& cplhhSdcSdcSvaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,         & 
& cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,        & 
& cplSvcSvVZVZ1,AmpVertexIRdrhhTocSvSv)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSvSv(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,        & 
& MFd2OS,MFe2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,MVZ2OS,               & 
& cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& ZcplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,    & 
& cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,               & 
& cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,cplhhSdcSdcSvaa,             & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,         & 
& cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,cplSvcSvVZVZ1,          & 
& AmpVertexIRoshhTocSvSv)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSvSv(MAh,MCha,MChi,MFd,MFe,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,              & 
& MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,          & 
& cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,             & 
& cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,            & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,ZcplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,      & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,      & 
& cplhhSdcSdcSvaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,         & 
& cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,        & 
& cplSvcSvVZVZ1,AmpVertexIRoshhTocSvSv)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSvSv(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,        & 
& MFd2OS,MFe2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,MVZ2OS,               & 
& cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,cplcFeChaSvR,cplChiChihhL,          & 
& cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,     & 
& cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,               & 
& cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,cplhhSdcSdcSvaa,             & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,         & 
& cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,cplSvcSvVZVZ1,          & 
& AmpVertexIRoshhTocSvSv)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocSvSv(MAh,MCha,MChi,MFd,MFe,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,              & 
& MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,          & 
& cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,             & 
& cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,            & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,      & 
& cplhhSdcSdcSvaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,         & 
& cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,        & 
& cplSvcSvVZVZ1,AmpVertexIRoshhTocSvSv)

 End if 
 End if 
AmpVertexhhTocSvSv = AmpVertexhhTocSvSv -  AmpVertexIRdrhhTocSvSv! +  AmpVertexIRoshhTocSvSv ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocSvSv=0._dp 
AmpVertexZhhTocSvSv=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocSvSv(gt2,:,:) = AmpWaveZhhTocSvSv(gt2,:,:)+ZRUZH(gt2,gt1)*AmpWavehhTocSvSv(gt1,:,:) 
AmpVertexZhhTocSvSv(gt2,:,:)= AmpVertexZhhTocSvSv(gt2,:,:) + ZRUZH(gt2,gt1)*AmpVertexhhTocSvSv(gt1,:,:) 
 End Do 
End Do 
AmpWavehhTocSvSv=AmpWaveZhhTocSvSv 
AmpVertexhhTocSvSv= AmpVertexZhhTocSvSv
! Final State 1 
AmpWaveZhhTocSvSv=0._dp 
AmpVertexZhhTocSvSv=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocSvSv(:,gt2,:) = AmpWaveZhhTocSvSv(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpWavehhTocSvSv(:,gt1,:) 
AmpVertexZhhTocSvSv(:,gt2,:)= AmpVertexZhhTocSvSv(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpVertexhhTocSvSv(:,gt1,:) 
 End Do 
End Do 
AmpWavehhTocSvSv=AmpWaveZhhTocSvSv 
AmpVertexhhTocSvSv= AmpVertexZhhTocSvSv
! Final State 2 
AmpWaveZhhTocSvSv=0._dp 
AmpVertexZhhTocSvSv=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZhhTocSvSv(:,:,gt2) = AmpWaveZhhTocSvSv(:,:,gt2)+ZRUZV(gt2,gt1)*AmpWavehhTocSvSv(:,:,gt1) 
AmpVertexZhhTocSvSv(:,:,gt2)= AmpVertexZhhTocSvSv(:,:,gt2)+ZRUZV(gt2,gt1)*AmpVertexhhTocSvSv(:,:,gt1) 
 End Do 
End Do 
AmpWavehhTocSvSv=AmpWaveZhhTocSvSv 
AmpVertexhhTocSvSv= AmpVertexZhhTocSvSv
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocSvSv = AmpVertexhhTocSvSv  +  AmpVertexIRoshhTocSvSv
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->conj[Sv] Sv -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocSvSv = AmpTreehhTocSvSv 
 AmpSum2hhTocSvSv = AmpTreehhTocSvSv + 2._dp*AmpWavehhTocSvSv + 2._dp*AmpVertexhhTocSvSv  
Else 
 AmpSumhhTocSvSv = AmpTreehhTocSvSv + AmpWavehhTocSvSv + AmpVertexhhTocSvSv
 AmpSum2hhTocSvSv = AmpTreehhTocSvSv + AmpWavehhTocSvSv + AmpVertexhhTocSvSv 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocSvSv = AmpTreehhTocSvSv
 AmpSum2hhTocSvSv = AmpTreehhTocSvSv 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSvOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSv(gt2)+MSv(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2hhTocSvSv = AmpTreehhTocSvSv
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocSvSv(gt1, gt2, gt3) 
  AmpSum2hhTocSvSv = 2._dp*AmpWavehhTocSvSv
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocSvSv(gt1, gt2, gt3) 
  AmpSum2hhTocSvSv = 2._dp*AmpVertexhhTocSvSv
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocSvSv(gt1, gt2, gt3) 
  AmpSum2hhTocSvSv = AmpTreehhTocSvSv + 2._dp*AmpWavehhTocSvSv + 2._dp*AmpVertexhhTocSvSv
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocSvSv(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocSvSv = AmpTreehhTocSvSv
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
  AmpSqTreehhTocSvSv(gt1, gt2, gt3) = (1)*AmpSqhhTocSvSv(gt1, gt2, gt3)  
  AmpSum2hhTocSvSv = + 2._dp*AmpWavehhTocSvSv + 2._dp*AmpVertexhhTocSvSv
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
  AmpSqhhTocSvSv(gt1, gt2, gt3) = AmpSqhhTocSvSv(gt1, gt2, gt3) + AmpSqTreehhTocSvSv(gt1, gt2, gt3)  
Else  
  AmpSum2hhTocSvSv = AmpTreehhTocSvSv
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
  AmpSqTreehhTocSvSv(gt1, gt2, gt3) = (1)*AmpSqhhTocSvSv(gt1, gt2, gt3)  
  AmpSum2hhTocSvSv = + 2._dp*AmpWavehhTocSvSv + 2._dp*AmpVertexhhTocSvSv
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhTocSvSv(gt1, gt2, gt3),AmpSum2hhTocSvSv(gt1, gt2, gt3),AmpSqhhTocSvSv(gt1, gt2, gt3)) 
  AmpSqhhTocSvSv(gt1, gt2, gt3) = AmpSqhhTocSvSv(gt1, gt2, gt3) + AmpSqTreehhTocSvSv(gt1, gt2, gt3)  
End if  
Else  
  AmpSqhhTocSvSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTocSvSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),helfactor*AmpSqhhTocSvSv(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MSv(gt2),MSv(gt3),helfactor*AmpSqhhTocSvSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTocSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTocSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSvSv(gt1, gt2, gt3) + MRGhhTocSvSv(gt1, gt2, gt3)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPhhTocSvSv(gt1, gt2, gt3) + MRGhhTocSvSv(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
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
! Conjg(VWm) VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhTocVWmVWm(cplhhcVWmVWm,Mhh,MVWm,Mhh2,MVWm2,          & 
& AmpTreehhTocVWmVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhTocVWmVWm(ZcplhhcVWmVWm,Mhh,MVWm,Mhh2,               & 
& MVWm2,AmpTreehhTocVWmVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocVWmVWm(MLambda,em,gs,cplhhcVWmVWm,MhhOS,              & 
& MVWmOS,MRPhhTocVWmVWm,MRGhhTocVWmVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocVWmVWm(MLambda,em,gs,ZcplhhcVWmVWm,MhhOS,             & 
& MVWmOS,MRPhhTocVWmVWm,MRGhhTocVWmVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhTocVWmVWm(MLambda,em,gs,cplhhcVWmVWm,Mhh,MVWm,           & 
& MRPhhTocVWmVWm,MRGhhTocVWmVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhTocVWmVWm(MLambda,em,gs,ZcplhhcVWmVWm,Mhh,               & 
& MVWm,MRPhhTocVWmVWm,MRGhhTocVWmVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTocVWmVWm(cplhhcVWmVWm,ctcplhhcVWmVWm,               & 
& Mhh,Mhh2,MVWm,MVWm2,Zfhh,ZfVWm,AmpWavehhTocVWmVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTocVWmVWm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcVWm,            & 
& cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,   & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhhhhh,          & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,            & 
& cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,           & 
& cplAhAhcVWmVWm1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,       & 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,& 
& cplSvcSvcVWmVWm1,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q,          & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexhhTocVWmVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocVWmVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcVWm,            & 
& cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,   & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhhhhh,          & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,            & 
& cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,           & 
& cplAhAhcVWmVWm1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,       & 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,& 
& cplSvcSvcVWmVWm1,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q,          & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRdrhhTocVWmVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocVWmVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcVWm,cplAhcHpmVWm,              & 
& cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,cplcgWmgAVWm,           & 
& cplcgWpCgAcVWm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgAgWpCVWm,  & 
& cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhhhhh,GosZcplhhHpmcHpm,       & 
& GosZcplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,GosZcplhhcHpmVWm,         & 
& ZcplhhcVWmVWm,cplhhVZVZ,GosZcplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,       & 
& cplSucSdVWm,cplSvcSeVWm,GosZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,       & 
& cplAhAhcVWmVWm1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,       & 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,& 
& cplSvcSvcVWmVWm1,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q,          & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhTocVWmVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocVWmVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcVWm,            & 
& cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,   & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhhhhh,          & 
& GZcplhhHpmcHpm,GZcplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,             & 
& GZcplhhcHpmVWm,ZcplhhcVWmVWm,cplhhVZVZ,GZcplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,       & 
& cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,GZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,         & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,          & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1, & 
& cplSucSucVWmVWmaa,cplSvcSvcVWmVWm1,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,            & 
& cplcVWmcVWmVWmVWm3Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhTocVWmVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocVWmVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplAhHpmcVWm,cplAhcHpmVWm,              & 
& cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,cplcgWmgAVWm,           & 
& cplcgWpCgAcVWm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,cplcgAgWpCVWm,  & 
& cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhhhhh,cplhhHpmcHpm,           & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,GcplhhcHpmVWm,cplhhcVWmVWm,   & 
& cplhhVZVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplSucSdVWm,             & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhcVWmVWm1,       & 
& cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,       & 
& cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,               & 
& cplSvcSvcVWmVWm1,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q,          & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhTocVWmVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhTocVWmVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcVWm,            & 
& cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgWmgWmhh,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgWpCgWpChh,   & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhhhhh,          & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,            & 
& cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,           & 
& cplAhAhcVWmVWm1,cplhhhhcVWmVWm1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,       & 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,& 
& cplSvcSvcVWmVWm1,cplcVWmcVWmVWmVWm1Q,cplcVWmcVWmVWmVWm2Q,cplcVWmcVWmVWmVWm3Q,          & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhTocVWmVWm)

 End if 
 End if 
AmpVertexhhTocVWmVWm = AmpVertexhhTocVWmVWm -  AmpVertexIRdrhhTocVWmVWm! +  AmpVertexIRoshhTocVWmVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhTocVWmVWm=0._dp 
AmpVertexZhhTocVWmVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhTocVWmVWm(:,gt2) = AmpWaveZhhTocVWmVWm(:,gt2)+ZRUZH(gt2,gt1)*AmpWavehhTocVWmVWm(:,gt1) 
AmpVertexZhhTocVWmVWm(:,gt2)= AmpVertexZhhTocVWmVWm(:,gt2) + ZRUZH(gt2,gt1)*AmpVertexhhTocVWmVWm(:,gt1) 
 End Do 
End Do 
AmpWavehhTocVWmVWm=AmpWaveZhhTocVWmVWm 
AmpVertexhhTocVWmVWm= AmpVertexZhhTocVWmVWm
End if
If (ShiftIRdiv) Then 
AmpVertexhhTocVWmVWm = AmpVertexhhTocVWmVWm  +  AmpVertexIRoshhTocVWmVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->conj[VWm] VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhTocVWmVWm = AmpTreehhTocVWmVWm 
 AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm + 2._dp*AmpWavehhTocVWmVWm + 2._dp*AmpVertexhhTocVWmVWm  
Else 
 AmpSumhhTocVWmVWm = AmpTreehhTocVWmVWm + AmpWavehhTocVWmVWm + AmpVertexhhTocVWmVWm
 AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm + AmpWavehhTocVWmVWm + AmpVertexhhTocVWmVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTocVWmVWm = AmpTreehhTocVWmVWm
 AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm 
End if 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MhhOS(gt1).gt.(MVWmOS+MVWmOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MVWm+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1 
  AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVWmOS,MVWmOS,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVWm,MVWm,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhTocVWmVWm(gt1) 
  AmpSum2hhTocVWmVWm = 2._dp*AmpWavehhTocVWmVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVWmOS,MVWmOS,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVWm,MVWm,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhTocVWmVWm(gt1) 
  AmpSum2hhTocVWmVWm = 2._dp*AmpVertexhhTocVWmVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVWmOS,MVWmOS,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVWm,MVWm,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhTocVWmVWm(gt1) 
  AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm + 2._dp*AmpWavehhTocVWmVWm + 2._dp*AmpVertexhhTocVWmVWm
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVWmOS,MVWmOS,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVWm,MVWm,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhTocVWmVWm(gt1) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm
  Call SquareAmp_StoVV(MhhOS(gt1),MVWmOS,MVWmOS,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
  AmpSqTreehhTocVWmVWm(gt1) = (1)*AmpSqhhTocVWmVWm(gt1)  
  AmpSum2hhTocVWmVWm = + 2._dp*AmpWavehhTocVWmVWm + 2._dp*AmpVertexhhTocVWmVWm
  Call SquareAmp_StoVV(MhhOS(gt1),MVWmOS,MVWmOS,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
  AmpSqhhTocVWmVWm(gt1) = AmpSqhhTocVWmVWm(gt1) + AmpSqTreehhTocVWmVWm(gt1)  
Else  
  AmpSum2hhTocVWmVWm = AmpTreehhTocVWmVWm
  Call SquareAmp_StoVV(Mhh(gt1),MVWm,MVWm,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
  AmpSqTreehhTocVWmVWm(gt1) = (1)*AmpSqhhTocVWmVWm(gt1)  
  AmpSum2hhTocVWmVWm = + 2._dp*AmpWavehhTocVWmVWm + 2._dp*AmpVertexhhTocVWmVWm
  Call SquareAmp_StoVV(Mhh(gt1),MVWm,MVWm,AmpSumhhTocVWmVWm(:,gt1),AmpSum2hhTocVWmVWm(:,gt1),AmpSqhhTocVWmVWm(gt1)) 
  AmpSqhhTocVWmVWm(gt1) = AmpSqhhTocVWmVWm(gt1) + AmpSqTreehhTocVWmVWm(gt1)  
End if  
Else  
  AmpSqhhTocVWmVWm(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTocVWmVWm(gt1).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MVWmOS,MVWmOS,helfactor*AmpSqhhTocVWmVWm(gt1))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MVWm,MVWm,helfactor*AmpSqhhTocVWmVWm(gt1))
End if 
If ((Abs(MRPhhTocVWmVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhTocVWmVWm(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhTocVWmVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhTocVWmVWm(gt1)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*2*helfactor*(MRPhhTocVWmVWm(gt1) + MRGhhTocVWmVWm(gt1)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*2*helfactor*(MRPhhTocVWmVWm(gt1) + MRGhhTocVWmVWm(gt1))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
End If 
If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! VZ VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_hhToVZVZ(cplhhVZVZ,Mhh,MVZ,Mhh2,MVZ2,AmpTreehhToVZVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_hhToVZVZ(ZcplhhVZVZ,Mhh,MVZ,Mhh2,MVZ2,AmpTreehhToVZVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToVZVZ(MLambda,em,gs,cplhhVZVZ,MhhOS,MVZOS,              & 
& MRPhhToVZVZ,MRGhhToVZVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToVZVZ(MLambda,em,gs,ZcplhhVZVZ,MhhOS,MVZOS,             & 
& MRPhhToVZVZ,MRGhhToVZVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_hhToVZVZ(MLambda,em,gs,cplhhVZVZ,Mhh,MVZ,MRPhhToVZVZ,      & 
& MRGhhToVZVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_hhToVZVZ(MLambda,em,gs,ZcplhhVZVZ,Mhh,MVZ,MRPhhToVZVZ,     & 
& MRGhhToVZVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToVZVZ(cplhhVZVZ,ctcplhhVZVZ,Mhh,Mhh2,               & 
& MVZ,MVZ2,Zfhh,ZfVZ,AmpWavehhToVZVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVZVZ(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,       & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhVZVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,   & 
& cplHpmcHpmVZVZ1,cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,cplSvcSvVZVZ1,             & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexhhToVZVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToVZVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,       & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhVZVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,   & 
& cplHpmcHpmVZVZ1,cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,cplSvcSvVZVZ1,             & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRdrhhToVZVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToVZVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,          & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,         & 
& cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,              & 
& cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,        & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,ZcplhhVZVZ,      & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,    & 
& cplcVWmVWmVZ,cplAhAhVZVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVZVZ1,& 
& cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,cplSvcSvVZVZ1,cplcVWmVWmVZVZ2Q,            & 
& cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhToVZVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToVZVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& ZcplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,      & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhVZVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,   & 
& cplHpmcHpmVZVZ1,cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,cplSvcSvVZVZ1,             & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhToVZVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToVZVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,          & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVWm2OS,MVZ2OS,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,          & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,         & 
& cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,              & 
& cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,        & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,    & 
& cplcVWmVWmVZ,cplAhAhVZVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVZVZ1,& 
& cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,cplSvcSvVZVZ1,cplcVWmVWmVZVZ2Q,            & 
& cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhToVZVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_hhToVZVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplcChaChahhL,cplcChaChahhR,        & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhhhhh,cplhhHpmcHpm,        & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,       & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhVZVZ1,cplhhhhVZVZ1,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,   & 
& cplHpmcHpmVZVZ1,cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,cplSvcSvVZVZ1,             & 
& cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,AmpVertexIRoshhToVZVZ)

 End if 
 End if 
AmpVertexhhToVZVZ = AmpVertexhhToVZVZ -  AmpVertexIRdrhhToVZVZ! +  AmpVertexIRoshhToVZVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZhhToVZVZ=0._dp 
AmpVertexZhhToVZVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZhhToVZVZ(:,gt2) = AmpWaveZhhToVZVZ(:,gt2)+ZRUZH(gt2,gt1)*AmpWavehhToVZVZ(:,gt1) 
AmpVertexZhhToVZVZ(:,gt2)= AmpVertexZhhToVZVZ(:,gt2) + ZRUZH(gt2,gt1)*AmpVertexhhToVZVZ(:,gt1) 
 End Do 
End Do 
AmpWavehhToVZVZ=AmpWaveZhhToVZVZ 
AmpVertexhhToVZVZ= AmpVertexZhhToVZVZ
End if
If (ShiftIRdiv) Then 
AmpVertexhhToVZVZ = AmpVertexhhToVZVZ  +  AmpVertexIRoshhToVZVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->VZ VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumhhToVZVZ = AmpTreehhToVZVZ 
 AmpSum2hhToVZVZ = AmpTreehhToVZVZ + 2._dp*AmpWavehhToVZVZ + 2._dp*AmpVertexhhToVZVZ  
Else 
 AmpSumhhToVZVZ = AmpTreehhToVZVZ + AmpWavehhToVZVZ + AmpVertexhhToVZVZ
 AmpSum2hhToVZVZ = AmpTreehhToVZVZ + AmpWavehhToVZVZ + AmpVertexhhToVZVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToVZVZ = AmpTreehhToVZVZ
 AmpSum2hhToVZVZ = AmpTreehhToVZVZ 
End if 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MhhOS(gt1).gt.(MVZOS+MVZOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MVZ+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1 
  AmpSum2hhToVZVZ = AmpTreehhToVZVZ
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVZOS,MVZOS,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVZ,MVZ,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqhhToVZVZ(gt1) 
  AmpSum2hhToVZVZ = 2._dp*AmpWavehhToVZVZ
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVZOS,MVZOS,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVZ,MVZ,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqhhToVZVZ(gt1) 
  AmpSum2hhToVZVZ = 2._dp*AmpVertexhhToVZVZ
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVZOS,MVZOS,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVZ,MVZ,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqhhToVZVZ(gt1) 
  AmpSum2hhToVZVZ = AmpTreehhToVZVZ + 2._dp*AmpWavehhToVZVZ + 2._dp*AmpVertexhhToVZVZ
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),MVZOS,MVZOS,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVZ,MVZ,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqhhToVZVZ(gt1) 
 End if 
If (OSkinematics) Then 
  AmpSum2hhToVZVZ = AmpTreehhToVZVZ
  Call SquareAmp_StoVV(MhhOS(gt1),MVZOS,MVZOS,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
  AmpSqTreehhToVZVZ(gt1) = (1)*AmpSqhhToVZVZ(gt1)  
  AmpSum2hhToVZVZ = + 2._dp*AmpWavehhToVZVZ + 2._dp*AmpVertexhhToVZVZ
  Call SquareAmp_StoVV(MhhOS(gt1),MVZOS,MVZOS,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
  AmpSqhhToVZVZ(gt1) = AmpSqhhToVZVZ(gt1) + AmpSqTreehhToVZVZ(gt1)  
Else  
  AmpSum2hhToVZVZ = AmpTreehhToVZVZ
  Call SquareAmp_StoVV(Mhh(gt1),MVZ,MVZ,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
  AmpSqTreehhToVZVZ(gt1) = (1)*AmpSqhhToVZVZ(gt1)  
  AmpSum2hhToVZVZ = + 2._dp*AmpWavehhToVZVZ + 2._dp*AmpVertexhhToVZVZ
  Call SquareAmp_StoVV(Mhh(gt1),MVZ,MVZ,AmpSumhhToVZVZ(:,gt1),AmpSum2hhToVZVZ(:,gt1),AmpSqhhToVZVZ(gt1)) 
  AmpSqhhToVZVZ(gt1) = AmpSqhhToVZVZ(gt1) + AmpSqTreehhToVZVZ(gt1)  
End if  
Else  
  AmpSqhhToVZVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToVZVZ(gt1).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MVZOS,MVZOS,helfactor*AmpSqhhToVZVZ(gt1))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MVZ,MVZ,helfactor*AmpSqhhToVZVZ(gt1))
End if 
If ((Abs(MRPhhToVZVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhToVZVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPhhToVZVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhToVZVZ(gt1)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPhhToVZVZ(gt1) + MRGhhToVZVZ(gt1)) 
  gP1Lhh(gt1,i4) = gP1Lhh(gt1,i4) + phasespacefactor*1*helfactor*(MRPhhToVZVZ(gt1) + MRGhhToVZVZ(gt1))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1Lhh(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
End If 
!---------------- 
! Ah hh
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhhh(MAhOS,MAh2OS,MhhOS,Mhh2OS,ZfAh,               & 
& Zfhh,AmpWavehhToAhhh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhhh(MAhOS,MAh2OS,MhhOS,Mhh2OS,ZfAh,               & 
& Zfhh,AmpWavehhToAhhh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhhh(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,           & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhHpmcHpm,          & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSucSuaa,           & 
& AmpVertexhhToAhhh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhhh(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,           & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhHpmcHpm,          & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSucSuaa,           & 
& AmpVertexhhToAhhh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhhh(MAh,MAh2,Mhh,Mhh2,ZfAh,Zfhh,AmpWavehhToAhhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhhh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,            & 
& MSu2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,          & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,        & 
& cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,              & 
& cplcgWpCgWpChh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,              & 
& cplhhhhSecSe1,cplhhhhSucSuaa,AmpVertexhhToAhhh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Ah hh -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToAhhh = 0._dp 
 AmpSum2hhToAhhh = 0._dp  
Else 
 AmpSumhhToAhhh = AmpVertexhhToAhhh + AmpWavehhToAhhh
 AmpSum2hhToAhhh = AmpVertexhhToAhhh + AmpWavehhToAhhh 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MAhOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MAh(gt2)+Mhh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MhhOS(gt3),AmpSumhhToAhhh(gt1, gt2, gt3),AmpSum2hhToAhhh(gt1, gt2, gt3),AmpSqhhToAhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),Mhh(gt3),AmpSumhhToAhhh(gt1, gt2, gt3),AmpSum2hhToAhhh(gt1, gt2, gt3),AmpSqhhToAhhh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToAhhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToAhhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MAhOS(gt2),MhhOS(gt3),helfactor*AmpSqhhToAhhh(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MAh(gt2),Mhh(gt3),helfactor*AmpSqhhToAhhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToAhhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Ah Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhSv(MAhOS,MAh2OS,MhhOS,Mhh2OS,MSvOS,              & 
& MSv2OS,ZfAh,Zfhh,ZfSv,AmpWavehhToAhSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhSv(MAhOS,MAh2OS,MhhOS,Mhh2OS,MSvOS,              & 
& MSv2OS,ZfAh,Zfhh,ZfSv,AmpWavehhToAhSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhSv(MAhOS,MFdOS,MFeOS,MhhOS,MSdOS,              & 
& MSeOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,              & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhToAhSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhSv(MAhOS,MFdOS,MFeOS,MhhOS,MSdOS,              & 
& MSeOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,              & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhToAhSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhSv(MAh,MAh2,Mhh,Mhh2,MSv,MSv2,ZfAh,              & 
& Zfhh,ZfSv,AmpWavehhToAhSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhSv(MAh,MFd,MFe,Mhh,MSd,MSe,MSv,MAh2,           & 
& MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,     & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,       & 
& cplAhSdSvcSdaa,cplAhSeSvcSe1,cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhToAhSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Ah Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToAhSv = 0._dp 
 AmpSum2hhToAhSv = 0._dp  
Else 
 AmpSumhhToAhSv = AmpVertexhhToAhSv + AmpWavehhToAhSv
 AmpSum2hhToAhSv = AmpVertexhhToAhSv + AmpWavehhToAhSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MAhOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MAh(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MAhOS(gt2),MSvOS(gt3),AmpSumhhToAhSv(gt1, gt2, gt3),AmpSum2hhToAhSv(gt1, gt2, gt3),AmpSqhhToAhSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MAh(gt2),MSv(gt3),AmpSumhhToAhSv(gt1, gt2, gt3),AmpSum2hhToAhSv(gt1, gt2, gt3),AmpSqhhToAhSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToAhSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToAhSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MAhOS(gt2),MSvOS(gt3),helfactor*AmpSqhhToAhSv(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MAh(gt2),MSv(gt3),helfactor*AmpSqhhToAhSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToAhSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Ah VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhVP(cplAhhhVZ,ctcplAhhhVZ,MAhOS,MAh2OS,           & 
& MhhOS,Mhh2OS,MVP,MVP2,MVZOS,MVZ2OS,ZfAh,Zfhh,ZfVP,ZfVZVP,AmpWavehhToAhVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhVP(cplAhhhVZ,ctcplAhhhVZ,MAhOS,MAh2OS,           & 
& MhhOS,Mhh2OS,MVP,MVP2,MVZOS,MVZ2OS,ZfAh,Zfhh,ZfVP,ZfVZVP,AmpWavehhToAhVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,         & 
& Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,          & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,               & 
& cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,               & 
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,AmpVertexhhToAhVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,         & 
& Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,          & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,               & 
& cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,               & 
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,AmpVertexhhToAhVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToAhVP(cplAhhhVZ,ctcplAhhhVZ,MAh,MAh2,               & 
& Mhh,Mhh2,MVP,MVP2,MVZ,MVZ2,ZfAh,Zfhh,ZfVP,ZfVZVP,AmpWavehhToAhVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToAhVP(MAh,MCha,MFd,MFe,MFu,Mhh,MHpm,              & 
& MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,              & 
& MVP2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,         & 
& cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,               & 
& cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,          & 
& cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,             & 
& cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,  & 
& cplhhcHpmVPVWm1,AmpVertexhhToAhVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Ah VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToAhVP = 0._dp 
 AmpSum2hhToAhVP = 0._dp  
Else 
 AmpSumhhToAhVP = AmpVertexhhToAhVP + AmpWavehhToAhVP
 AmpSum2hhToAhVP = AmpVertexhhToAhVP + AmpWavehhToAhVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MAhOS(gt2)+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MAh(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MAhOS(gt2),0._dp,AmpSumhhToAhVP(:,gt1, gt2),AmpSum2hhToAhVP(:,gt1, gt2),AmpSqhhToAhVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MAh(gt2),MVP,AmpSumhhToAhVP(:,gt1, gt2),AmpSum2hhToAhVP(:,gt1, gt2),AmpSqhhToAhVP(gt1, gt2)) 
End if  
Else  
  AmpSqhhToAhVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToAhVP(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MAhOS(gt2),0._dp,helfactor*AmpSqhhToAhVP(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MAh(gt2),MVP,helfactor*AmpSqhhToAhVP(gt1, gt2))
End if 
If ((Abs(MRPhhToAhVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToAhVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Cha bar(Fe)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToChacFe(MChaOS,MCha2OS,MFeOS,MFe2OS,MhhOS,          & 
& Mhh2OS,ZfFEL,ZfFER,Zfhh,ZfLm,ZfLp,AmpWavehhToChacFe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToChacFe(MChaOS,MCha2OS,MFeOS,MFe2OS,MhhOS,          & 
& Mhh2OS,ZfFEL,ZfFER,Zfhh,ZfLm,ZfLp,AmpWavehhToChacFe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChacFe(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,        & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFdcSuL,           & 
& cplcFeFdcSuR,cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexhhToChacFe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChacFe(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,        & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFdcSuL,           & 
& cplcFeFdcSuR,cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,            & 
& cplcFuFuhhR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexhhToChacFe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToChacFe(MCha,MCha2,MFe,MFe2,Mhh,Mhh2,               & 
& ZfFEL,ZfFER,Zfhh,ZfLm,ZfLp,AmpWavehhToChacFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChacFe(MCha,MFd,MFe,MFu,Mhh,MSd,MSe,             & 
& MSu,MSv,MCha2,MFd2,MFe2,MFu2,Mhh2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,       & 
& cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplcFecFuSdL,cplcFecFuSdR,AmpVertexhhToChacFe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Cha bar[Fe] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToChacFe = 0._dp 
 AmpSum2hhToChacFe = 0._dp  
Else 
 AmpSumhhToChacFe = AmpVertexhhToChacFe + AmpWavehhToChacFe
 AmpSum2hhToChacFe = AmpVertexhhToChacFe + AmpWavehhToChacFe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MChaOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MCha(gt2)+MFe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumhhToChacFe(:,gt1, gt2, gt3),AmpSum2hhToChacFe(:,gt1, gt2, gt3),AmpSqhhToChacFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MCha(gt2),MFe(gt3),AmpSumhhToChacFe(:,gt1, gt2, gt3),AmpSum2hhToChacFe(:,gt1, gt2, gt3),AmpSqhhToChacFe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToChacFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhToChacFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MChaOS(gt2),MFeOS(gt3),helfactor*AmpSqhhToChacFe(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MCha(gt2),MFe(gt3),helfactor*AmpSqhhToChacFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToChacFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToChacFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Chi Fv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToChiFv(MChiOS,MChi2OS,MhhOS,Mhh2OS,ZfFvL,           & 
& Zfhh,ZfL0,AmpWavehhToChiFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToChiFv(MChiOS,MChi2OS,MhhOS,Mhh2OS,ZfFvL,           & 
& Zfhh,ZfL0,AmpWavehhToChiFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChiFv(MChiOS,MFdOS,MFeOS,MhhOS,MSdOS,            & 
& MSeOS,MChi2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFvFecSeL,cplFvFecSeR,               & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplhhSdcSd,cplhhSecSe,AmpVertexhhToChiFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChiFv(MChiOS,MFdOS,MFeOS,MhhOS,MSdOS,            & 
& MSeOS,MChi2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFvFecSeL,cplFvFecSeR,               & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplhhSdcSd,cplhhSecSe,AmpVertexhhToChiFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToChiFv(MChi,MChi2,Mhh,Mhh2,ZfFvL,Zfhh,              & 
& ZfL0,AmpWavehhToChiFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToChiFv(MChi,MFd,MFe,Mhh,MSd,MSe,MChi2,            & 
& MFd2,MFe2,Mhh2,MSd2,MSe2,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,          & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,AmpVertexhhToChiFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Chi Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToChiFv = 0._dp 
 AmpSum2hhToChiFv = 0._dp  
Else 
 AmpSumhhToChiFv = AmpVertexhhToChiFv + AmpWavehhToChiFv
 AmpSum2hhToChiFv = AmpVertexhhToChiFv + AmpWavehhToChiFv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MChiOS(gt2)+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MChi(gt2)+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MChiOS(gt2),0._dp,AmpSumhhToChiFv(:,gt1, gt2, gt3),AmpSum2hhToChiFv(:,gt1, gt2, gt3),AmpSqhhToChiFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MChi(gt2),0._dp,AmpSumhhToChiFv(:,gt1, gt2, gt3),AmpSum2hhToChiFv(:,gt1, gt2, gt3),AmpSqhhToChiFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToChiFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhToChiFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MChiOS(gt2),0._dp,helfactor*AmpSqhhToChiFv(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MChi(gt2),0._dp,helfactor*AmpSqhhToChiFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToChiFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToChiFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fv Fv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToFvFv(MhhOS,Mhh2OS,ZfFvL,Zfhh,AmpWavehhToFvFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToFvFv(MhhOS,Mhh2OS,ZfFvL,Zfhh,AmpWavehhToFvFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToFvFv(MChaOS,MChiOS,MFdOS,MFeOS,MhhOS,            & 
& MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,Mhh2OS,            & 
& MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,MVZ2OS,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,   & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFvFecHpmL,             & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,               & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexhhToFvFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToFvFv(MChaOS,MChiOS,MFdOS,MFeOS,MhhOS,            & 
& MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,Mhh2OS,            & 
& MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,MVZ2OS,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,   & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplFvFecHpmL,             & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,               & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexhhToFvFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToFvFv(Mhh,Mhh2,ZfFvL,Zfhh,AmpWavehhToFvFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToFvFv(MCha,MChi,MFd,MFe,Mhh,MHpm,MSd,             & 
& MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,MVZ2,           & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,             & 
& cplcFdFdhhL,cplcFdFdhhR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,AmpVertexhhToFvFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Fv Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToFvFv = 0._dp 
 AmpSum2hhToFvFv = 0._dp  
Else 
 AmpSumhhToFvFv = AmpVertexhhToFvFv + AmpWavehhToFvFv
 AmpSum2hhToFvFv = AmpVertexhhToFvFv + AmpWavehhToFvFv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=gt2,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(0.+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),0._dp,0._dp,AmpSumhhToFvFv(:,gt1, gt2, gt3),AmpSum2hhToFvFv(:,gt1, gt2, gt3),AmpSqhhToFvFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),0._dp,0._dp,AmpSumhhToFvFv(:,gt1, gt2, gt3),AmpSum2hhToFvFv(:,gt1, gt2, gt3),AmpSqhhToFvFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToFvFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqhhToFvFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(MhhOS(gt1),0._dp,0._dp,helfactor*AmpSqhhToFvFv(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(Mhh(gt1),0._dp,0._dp,helfactor*AmpSqhhToFvFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToFvFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToFvFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Glu Glu
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToGluGlu(MGluOS,MGlu2OS,MhhOS,Mhh2OS,ZffG,           & 
& Zfhh,AmpWavehhToGluGlu)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToGluGlu(MGluOS,MGlu2OS,MhhOS,Mhh2OS,ZffG,           & 
& Zfhh,AmpWavehhToGluGlu)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToGluGlu(MFdOS,MFuOS,MGluOS,MhhOS,MSdOS,           & 
& MSuOS,MFd2OS,MFu2OS,MGlu2OS,Mhh2OS,MSd2OS,MSu2OS,cplGluFdcSdL,cplGluFdcSdR,            & 
& cplcFdFdhhL,cplcFdFdhhR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,             & 
& AmpVertexhhToGluGlu)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToGluGlu(MFdOS,MFuOS,MGluOS,MhhOS,MSdOS,           & 
& MSuOS,MFd2OS,MFu2OS,MGlu2OS,Mhh2OS,MSd2OS,MSu2OS,cplGluFdcSdL,cplGluFdcSdR,            & 
& cplcFdFdhhL,cplcFdFdhhR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,             & 
& AmpVertexhhToGluGlu)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToGluGlu(MGlu,MGlu2,Mhh,Mhh2,ZffG,Zfhh,              & 
& AmpWavehhToGluGlu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToGluGlu(MFd,MFu,MGlu,Mhh,MSd,MSu,MFd2,            & 
& MFu2,MGlu2,Mhh2,MSd2,MSu2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,AmpVertexhhToGluGlu)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Glu Glu -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToGluGlu = 0._dp 
 AmpSum2hhToGluGlu = 0._dp  
Else 
 AmpSumhhToGluGlu = AmpVertexhhToGluGlu + AmpWavehhToGluGlu
 AmpSum2hhToGluGlu = AmpVertexhhToGluGlu + AmpWavehhToGluGlu 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MhhOS(gt1).gt.(MGluOS+MGluOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MGlu+MGlu)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MhhOS(gt1),MGluOS,MGluOS,AmpSumhhToGluGlu(:,gt1),AmpSum2hhToGluGlu(:,gt1),AmpSqhhToGluGlu(gt1)) 
Else  
  Call SquareAmp_StoFF(Mhh(gt1),MGlu,MGlu,AmpSumhhToGluGlu(:,gt1),AmpSum2hhToGluGlu(:,gt1),AmpSqhhToGluGlu(gt1)) 
End if  
Else  
  AmpSqhhToGluGlu(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqhhToGluGlu(gt1).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(MhhOS(gt1),MGluOS,MGluOS,helfactor*AmpSqhhToGluGlu(gt1))
Else 
  gP1Lhh(gt1,i4) = 1._dp/2._dp*GammaTPS(Mhh(gt1),MGlu,MGlu,helfactor*AmpSqhhToGluGlu(gt1))
End if 
If ((Abs(MRPhhToGluGlu(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhToGluGlu(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! hh Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhSv(MhhOS,Mhh2OS,MSvOS,MSv2OS,Zfhh,               & 
& ZfSv,AmpWavehhTohhSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhSv(MhhOS,Mhh2OS,MSvOS,MSv2OS,Zfhh,               & 
& ZfSv,AmpWavehhTohhSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhSv(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,               & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,cplhhhhSdcSdaa,cplhhhhSecSe1,              & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhTohhSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhSv(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,               & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,cplhhhhSdcSdaa,cplhhhhSecSe1,              & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhTohhSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhSv(Mhh,Mhh2,MSv,MSv2,Zfhh,ZfSv,AmpWavehhTohhSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhSv(MFd,MFe,Mhh,MSd,MSe,MSv,MFd2,               & 
& MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,              & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,      & 
& cplSeSvcSe,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhTohhSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->hh Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTohhSv = 0._dp 
 AmpSum2hhTohhSv = 0._dp  
Else 
 AmpSumhhTohhSv = AmpVertexhhTohhSv + AmpWavehhTohhSv
 AmpSum2hhTohhSv = AmpVertexhhTohhSv + AmpWavehhTohhSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MhhOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(Mhh(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MhhOS(gt2),MSvOS(gt3),AmpSumhhTohhSv(gt1, gt2, gt3),AmpSum2hhTohhSv(gt1, gt2, gt3),AmpSqhhTohhSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),Mhh(gt2),MSv(gt3),AmpSumhhTohhSv(gt1, gt2, gt3),AmpSum2hhTohhSv(gt1, gt2, gt3),AmpSqhhTohhSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhTohhSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTohhSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MhhOS(gt2),MSvOS(gt3),helfactor*AmpSqhhTohhSv(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),Mhh(gt2),MSv(gt3),helfactor*AmpSqhhTohhSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhTohhSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhTohhSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! hh VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhVP(MhhOS,Mhh2OS,MVP,MVP2,Zfhh,ZfVP,              & 
& AmpWavehhTohhVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhVP(MhhOS,Mhh2OS,MVP,MVP2,Zfhh,ZfVP,              & 
& AmpWavehhTohhVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhVP(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,   & 
& cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,      & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,AmpVertexhhTohhVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhVP(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,   & 
& cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,      & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,AmpVertexhhTohhVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhVP(Mhh,Mhh2,MVP,MVP2,Zfhh,ZfVP,AmpWavehhTohhVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhVP(MCha,MFd,MFe,MFu,Mhh,MHpm,MSd,              & 
& MSe,MSu,MVP,MVWm,MCha2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVP2,MVWm2,            & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,             & 
& cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,         & 
& cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,             & 
& cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,       & 
& AmpVertexhhTohhVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->hh VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTohhVP = 0._dp 
 AmpSum2hhTohhVP = 0._dp  
Else 
 AmpSumhhTohhVP = AmpVertexhhTohhVP + AmpWavehhTohhVP
 AmpSum2hhTohhVP = AmpVertexhhTohhVP + AmpWavehhTohhVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MhhOS(gt2)+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(Mhh(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MhhOS(gt2),0._dp,AmpSumhhTohhVP(:,gt1, gt2),AmpSum2hhTohhVP(:,gt1, gt2),AmpSqhhTohhVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),Mhh(gt2),MVP,AmpSumhhTohhVP(:,gt1, gt2),AmpSum2hhTohhVP(:,gt1, gt2),AmpSqhhTohhVP(gt1, gt2)) 
End if  
Else  
  AmpSqhhTohhVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTohhVP(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MhhOS(gt2),0._dp,helfactor*AmpSqhhTohhVP(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),Mhh(gt2),MVP,helfactor*AmpSqhhTohhVP(gt1, gt2))
End if 
If ((Abs(MRPhhTohhVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhTohhVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! hh VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhVZ(MhhOS,Mhh2OS,MVZOS,MVZ2OS,Zfhh,               & 
& ZfVZ,AmpWavehhTohhVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhVZ(MhhOS,Mhh2OS,MVZOS,MVZ2OS,Zfhh,               & 
& ZfVZ,AmpWavehhTohhVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhVZ(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,            & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,              & 
& MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,MVZ2OS,               & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,       & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,               & 
& cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,AmpVertexhhTohhVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhVZ(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,            & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,              & 
& MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,MVZ2OS,               & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVZ,       & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,               & 
& cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplhhHpmcVWmVZ1,cplhhcHpmVWmVZ1,AmpVertexhhTohhVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhTohhVZ(Mhh,Mhh2,MVZ,MVZ2,Zfhh,ZfVZ,AmpWavehhTohhVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhTohhVZ(MCha,MChi,MFd,MFe,MFu,Mhh,MHpm,             & 
& MSd,MSe,MSu,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,              & 
& MSu2,MSv2,MVWm2,MVZ2,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,          & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVZ,             & 
& cplcgWpCgWpChh,cplcgWpCgWpCVZ,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,         & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVZ,cplHpmcVWmVZ,             & 
& cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplhhHpmcVWmVZ1, & 
& cplhhcHpmVWmVZ1,AmpVertexhhTohhVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->hh VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhTohhVZ = 0._dp 
 AmpSum2hhTohhVZ = 0._dp  
Else 
 AmpSumhhTohhVZ = AmpVertexhhTohhVZ + AmpWavehhTohhVZ
 AmpSum2hhTohhVZ = AmpVertexhhTohhVZ + AmpWavehhTohhVZ 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MhhOS(gt1).gt.(MhhOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(Mhh(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MhhOS(gt2),MVZOS,AmpSumhhTohhVZ(:,gt1, gt2),AmpSum2hhTohhVZ(:,gt1, gt2),AmpSqhhTohhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),Mhh(gt2),MVZ,AmpSumhhTohhVZ(:,gt1, gt2),AmpSum2hhTohhVZ(:,gt1, gt2),AmpSqhhTohhVZ(gt1, gt2)) 
End if  
Else  
  AmpSqhhTohhVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhTohhVZ(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),MhhOS(gt2),MVZOS,helfactor*AmpSqhhTohhVZ(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),Mhh(gt2),MVZ,helfactor*AmpSqhhTohhVZ(gt1, gt2))
End if 
If ((Abs(MRPhhTohhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhTohhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Hpm Conjg(Se)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToHpmcSe(MhhOS,Mhh2OS,MHpmOS,MHpm2OS,MSeOS,          & 
& MSe2OS,Zfhh,ZfHpm,ZfSe,AmpWavehhToHpmcSe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToHpmcSe(MhhOS,Mhh2OS,MHpmOS,MHpm2OS,MSeOS,          & 
& MSe2OS,Zfhh,ZfHpm,ZfSe,AmpWavehhToHpmcSe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToHpmcSe(MFdOS,MFeOS,MFuOS,MhhOS,MHpmOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,              & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,               & 
& cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplhhHpmSucSdaa,            & 
& cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,        & 
& cplHpmSucSecSuaa,cplHpmSvcSecSv1,AmpVertexhhToHpmcSe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToHpmcSe(MFdOS,MFeOS,MFuOS,MhhOS,MHpmOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,              & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,               & 
& cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplhhHpmSucSdaa,            & 
& cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,        & 
& cplHpmSucSecSuaa,cplHpmSvcSecSv1,AmpVertexhhToHpmcSe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToHpmcSe(Mhh,Mhh2,MHpm,MHpm2,MSe,MSe2,               & 
& Zfhh,ZfHpm,ZfSe,AmpWavehhToHpmcSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToHpmcSe(MFd,MFe,MFu,Mhh,MHpm,MSd,MSe,             & 
& MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,cplcFdFdhhR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,       & 
& cplSecSecSv,cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,             & 
& cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,cplHpmSvcSecSv1,AmpVertexhhToHpmcSe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Hpm conj[Se] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToHpmcSe = 0._dp 
 AmpSum2hhToHpmcSe = 0._dp  
Else 
 AmpSumhhToHpmcSe = AmpVertexhhToHpmcSe + AmpWavehhToHpmcSe
 AmpSum2hhToHpmcSe = AmpVertexhhToHpmcSe + AmpWavehhToHpmcSe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,6
If (((OSkinematics).and.(MhhOS(gt1).gt.(MHpmOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MHpm(gt2)+MSe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumhhToHpmcSe(gt1, gt2, gt3),AmpSum2hhToHpmcSe(gt1, gt2, gt3),AmpSqhhToHpmcSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MHpm(gt2),MSe(gt3),AmpSumhhToHpmcSe(gt1, gt2, gt3),AmpSum2hhToHpmcSe(gt1, gt2, gt3),AmpSqhhToHpmcSe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToHpmcSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToHpmcSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MHpmOS(gt2),MSeOS(gt3),helfactor*AmpSqhhToHpmcSe(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MHpm(gt2),MSe(gt3),helfactor*AmpSqhhToHpmcSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToHpmcSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToHpmcSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Se Conjg(VWm)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToSecVWm(MhhOS,Mhh2OS,MSeOS,MSe2OS,MVWmOS,           & 
& MVWm2OS,Zfhh,ZfSe,ZfVWm,AmpWavehhToSecVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToSecVWm(MhhOS,Mhh2OS,MSeOS,MSe2OS,MVWmOS,           & 
& MVWm2OS,Zfhh,ZfSe,ZfVWm,AmpWavehhToSecVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSecVWm(MFdOS,MFeOS,MFuOS,MhhOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,       & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,AmpVertexhhToSecVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSecVWm(MFdOS,MFeOS,MFuOS,MhhOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,       & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,       & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,AmpVertexhhToSecVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToSecVWm(Mhh,Mhh2,MSe,MSe2,MVWm,MVWm2,               & 
& Zfhh,ZfSe,ZfVWm,AmpWavehhToSecVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSecVWm(MFd,MFe,MFu,Mhh,MSd,MSe,MSu,              & 
& MSv,MVWm,MFd2,MFe2,MFu2,Mhh2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdhhL,cplcFdFdhhR,        & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,        & 
& cplSecSvcVWm,AmpVertexhhToSecVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Se conj[VWm] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToSecVWm = 0._dp 
 AmpSum2hhToSecVWm = 0._dp  
Else 
 AmpSumhhToSecVWm = AmpVertexhhToSecVWm + AmpWavehhToSecVWm
 AmpSum2hhToSecVWm = AmpVertexhhToSecVWm + AmpWavehhToSecVWm 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSeOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSe(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MSeOS(gt2),MVWmOS,AmpSumhhToSecVWm(:,gt1, gt2),AmpSum2hhToSecVWm(:,gt1, gt2),AmpSqhhToSecVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MSe(gt2),MVWm,AmpSumhhToSecVWm(:,gt1, gt2),AmpSum2hhToSecVWm(:,gt1, gt2),AmpSqhhToSecVWm(gt1, gt2)) 
End if  
Else  
  AmpSqhhToSecVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToSecVWm(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MSeOS(gt2),MVWmOS,helfactor*AmpSqhhToSecVWm(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MSe(gt2),MVWm,helfactor*AmpSqhhToSecVWm(gt1, gt2))
End if 
If ((Abs(MRPhhToSecVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToSecVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Sv Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvSv(MhhOS,Mhh2OS,MSvOS,MSv2OS,Zfhh,               & 
& ZfSv,AmpWavehhToSvSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvSv(MhhOS,Mhh2OS,MSvOS,MSv2OS,Zfhh,               & 
& ZfSv,AmpWavehhToSvSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvSv(MChiOS,MFdOS,MFeOS,MhhOS,MSdOS,             & 
& MSeOS,MSvOS,MChi2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplChiChihhL,            & 
& cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,              & 
& cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,     & 
& cplSdSvcSd,cplSeSvcSe,cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhToSvSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvSv(MChiOS,MFdOS,MFeOS,MhhOS,MSdOS,             & 
& MSeOS,MSvOS,MChi2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplChiChihhL,            & 
& cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,              & 
& cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,     & 
& cplSdSvcSd,cplSeSvcSe,cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhToSvSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvSv(Mhh,Mhh2,MSv,MSv2,Zfhh,ZfSv,AmpWavehhToSvSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvSv(MChi,MFd,MFe,Mhh,MSd,MSe,MSv,               & 
& MChi2,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplChiChihhL,cplChiChihhR,cplChiFvSvL,             & 
& cplChiFvSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,               & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,       & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexhhToSvSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Sv Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToSvSv = 0._dp 
 AmpSum2hhToSvSv = 0._dp  
Else 
 AmpSumhhToSvSv = AmpVertexhhToSvSv + AmpWavehhToSvSv
 AmpSum2hhToSvSv = AmpVertexhhToSvSv + AmpWavehhToSvSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=gt2,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSvOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSv(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumhhToSvSv(gt1, gt2, gt3),AmpSum2hhToSvSv(gt1, gt2, gt3),AmpSqhhToSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(Mhh(gt1),MSv(gt2),MSv(gt3),AmpSumhhToSvSv(gt1, gt2, gt3),AmpSum2hhToSvSv(gt1, gt2, gt3),AmpSqhhToSvSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqhhToSvSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqhhToSvSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MSvOS(gt2),MSvOS(gt3),helfactor*AmpSqhhToSvSv(gt1, gt2, gt3))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MSv(gt2),MSv(gt3),helfactor*AmpSqhhToSvSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPhhToSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGhhToSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Sv VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvVP(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& Zfhh,ZfSv,ZfVP,AmpWavehhToSvVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvVP(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& Zfhh,ZfSv,ZfVP,AmpWavehhToSvVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvVP(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdhhL,cplcFdFdhhR,      & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,      & 
& cplSdcSdVP,cplSeSvcSe,cplSecSeVP,AmpVertexhhToSvVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvVP(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdhhL,cplcFdFdhhR,      & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,      & 
& cplSdcSdVP,cplSeSvcSe,cplSecSeVP,AmpVertexhhToSvVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvVP(Mhh,Mhh2,MSv,MSv2,MVP,MVP2,Zfhh,              & 
& ZfSv,ZfVP,AmpWavehhToSvVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvVP(MFd,MFe,Mhh,MSd,MSe,MSv,MVP,MFd2,           & 
& MFe2,Mhh2,MSd2,MSe2,MSv2,MVP2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,         & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSdcSdVP,cplSeSvcSe,        & 
& cplSecSeVP,AmpVertexhhToSvVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Sv VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToSvVP = 0._dp 
 AmpSum2hhToSvVP = 0._dp  
Else 
 AmpSumhhToSvVP = AmpVertexhhToSvVP + AmpWavehhToSvVP
 AmpSum2hhToSvVP = AmpVertexhhToSvVP + AmpWavehhToSvVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSvOS(gt2)+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSv(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MSvOS(gt2),0._dp,AmpSumhhToSvVP(:,gt1, gt2),AmpSum2hhToSvVP(:,gt1, gt2),AmpSqhhToSvVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MSv(gt2),MVP,AmpSumhhToSvVP(:,gt1, gt2),AmpSum2hhToSvVP(:,gt1, gt2),AmpSqhhToSvVP(gt1, gt2)) 
End if  
Else  
  AmpSqhhToSvVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToSvVP(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MSvOS(gt2),0._dp,helfactor*AmpSqhhToSvVP(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MSv(gt2),MVP,helfactor*AmpSqhhToSvVP(gt1, gt2))
End if 
If ((Abs(MRPhhToSvVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToSvVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Sv VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvVZ(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,Zfhh,ZfSv,ZfVZ,AmpWavehhToSvVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvVZ(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,Zfhh,ZfSv,ZfVZ,AmpWavehhToSvVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvVZ(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdhhL,              & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,               & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplhhSdcSd,cplhhSecSe,     & 
& cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,cplSecSeVZ,AmpVertexhhToSvVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvVZ(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdhhL,              & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,               & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplhhSdcSd,cplhhSecSe,     & 
& cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,cplSecSeVZ,AmpVertexhhToSvVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToSvVZ(Mhh,Mhh2,MSv,MSv2,MVZ,MVZ2,Zfhh,              & 
& ZfSv,ZfVZ,AmpWavehhToSvVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToSvVZ(MFd,MFe,Mhh,MSd,MSe,MSv,MVZ,MFd2,           & 
& MFe2,Mhh2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,         & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,        & 
& cplSecSeVZ,AmpVertexhhToSvVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->Sv VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToSvVZ = 0._dp 
 AmpSum2hhToSvVZ = 0._dp  
Else 
 AmpSumhhToSvVZ = AmpVertexhhToSvVZ + AmpWavehhToSvVZ
 AmpSum2hhToSvVZ = AmpVertexhhToSvVZ + AmpWavehhToSvVZ 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MhhOS(gt1).gt.(MSvOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MSv(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MhhOS(gt1),MSvOS(gt2),MVZOS,AmpSumhhToSvVZ(:,gt1, gt2),AmpSum2hhToSvVZ(:,gt1, gt2),AmpSqhhToSvVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(Mhh(gt1),MSv(gt2),MVZ,AmpSumhhToSvVZ(:,gt1, gt2),AmpSum2hhToSvVZ(:,gt1, gt2),AmpSqhhToSvVZ(gt1, gt2)) 
End if  
Else  
  AmpSqhhToSvVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToSvVZ(gt1, gt2).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),MSvOS(gt2),MVZOS,helfactor*AmpSqhhToSvVZ(gt1, gt2))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MSv(gt2),MVZ,helfactor*AmpSqhhToSvVZ(gt1, gt2))
End if 
If ((Abs(MRPhhToSvVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGhhToSvVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VG VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToVGVG(MhhOS,Mhh2OS,MVG,MVG2,Zfhh,ZfVG,              & 
& AmpWavehhToVGVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToVGVG(MhhOS,Mhh2OS,MVG,MVG2,Zfhh,ZfVG,              & 
& AmpWavehhToVGVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVGVG(MFdOS,MFuOS,MhhOS,MSdOS,MSuOS,              & 
& MVG,MFd2OS,MFu2OS,Mhh2OS,MSd2OS,MSu2OS,MVG2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVGL,       & 
& cplcFdFdVGR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplhhSdcSd,cplhhSucSu,     & 
& cplSdcSdVG,cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexhhToVGVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVGVG(MFdOS,MFuOS,MhhOS,MSdOS,MSuOS,              & 
& MVG,MFd2OS,MFu2OS,Mhh2OS,MSd2OS,MSu2OS,MVG2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVGL,       & 
& cplcFdFdVGR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplhhSdcSd,cplhhSucSu,     & 
& cplSdcSdVG,cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexhhToVGVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToVGVG(Mhh,Mhh2,MVG,MVG2,Zfhh,ZfVG,AmpWavehhToVGVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVGVG(MFd,MFu,Mhh,MSd,MSu,MVG,MFd2,               & 
& MFu2,Mhh2,MSd2,MSu2,MVG2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVGL,cplcFdFdVGR,              & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplhhSdcSd,cplhhSucSu,cplSdcSdVG,      & 
& cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexhhToVGVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->VG VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToVGVG = 0._dp 
 AmpSum2hhToVGVG = 0._dp  
Else 
 AmpSumhhToVGVG = AmpVertexhhToVGVG + AmpWavehhToVGVG
 AmpSum2hhToVGVG = AmpVertexhhToVGVG + AmpWavehhToVGVG 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MhhOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MVG+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),0._dp,0._dp,AmpSumhhToVGVG(:,gt1),AmpSum2hhToVGVG(:,gt1),AmpSqhhToVGVG(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVG,MVG,AmpSumhhToVGVG(:,gt1),AmpSum2hhToVGVG(:,gt1),AmpSqhhToVGVG(gt1)) 
End if  
Else  
  AmpSqhhToVGVG(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToVGVG(gt1).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),0._dp,0._dp,helfactor*AmpSqhhToVGVG(gt1))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MVG,MVG,helfactor*AmpSqhhToVGVG(gt1))
End if 
If ((Abs(MRPhhToVGVG(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhToVGVG(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VP VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToVPVP(cplhhVZVZ,ctcplhhVZVZ,MhhOS,Mhh2OS,           & 
& MVP,MVP2,MVZOS,MVZ2OS,Zfhh,ZfVP,ZfVPVZ,ZfVZVP,AmpWavehhToVPVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToVPVP(cplhhVZVZ,ctcplhhVZVZ,MhhOS,Mhh2OS,           & 
& MVP,MVP2,MVZOS,MVZ2OS,Zfhh,ZfVP,ZfVPVZ,ZfVZVP,AmpWavehhToVPVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVPVP(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,   & 
& cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,      & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplSdcSdVPVPaa,           & 
& cplSecSeVPVP1,cplSucSuVPVPaa,cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,       & 
& AmpVertexhhToVPVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVPVP(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,   & 
& cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,      & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplSdcSdVPVPaa,           & 
& cplSecSeVPVP1,cplSucSuVPVPaa,cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,       & 
& AmpVertexhhToVPVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToVPVP(cplhhVZVZ,ctcplhhVZVZ,Mhh,Mhh2,               & 
& MVP,MVP2,MVZ,MVZ2,Zfhh,ZfVP,ZfVPVZ,ZfVZVP,AmpWavehhToVPVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVPVP(MCha,MFd,MFe,MFu,Mhh,MHpm,MSd,              & 
& MSe,MSu,MVP,MVWm,MCha2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVP2,MVWm2,            & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,             & 
& cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,         & 
& cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,             & 
& cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,       & 
& cplHpmcHpmVPVP1,cplSdcSdVPVPaa,cplSecSeVPVP1,cplSucSuVPVPaa,cplcVWmVPVPVWm3Q,          & 
& cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,AmpVertexhhToVPVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->VP VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToVPVP = 0._dp 
 AmpSum2hhToVPVP = 0._dp  
Else 
 AmpSumhhToVPVP = AmpVertexhhToVPVP + AmpWavehhToVPVP
 AmpSum2hhToVPVP = AmpVertexhhToVPVP + AmpWavehhToVPVP 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MhhOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MVP+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),0._dp,0._dp,AmpSumhhToVPVP(:,gt1),AmpSum2hhToVPVP(:,gt1),AmpSqhhToVPVP(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVP,MVP,AmpSumhhToVPVP(:,gt1),AmpSum2hhToVPVP(:,gt1),AmpSqhhToVPVP(gt1)) 
End if  
Else  
  AmpSqhhToVPVP(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToVPVP(gt1).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 1*GammaTPS(MhhOS(gt1),0._dp,0._dp,helfactor*AmpSqhhToVPVP(gt1))
Else 
  gP1Lhh(gt1,i4) = 1*GammaTPS(Mhh(gt1),MVP,MVP,helfactor*AmpSqhhToVPVP(gt1))
End if 
If ((Abs(MRPhhToVPVP(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhToVPVP(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VP VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_hhToVPVZ(cplhhVZVZ,ctcplhhVZVZ,MhhOS,Mhh2OS,           & 
& MVP,MVP2,MVZOS,MVZ2OS,Zfhh,ZfVP,ZfVZ,AmpWavehhToVPVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_hhToVPVZ(cplhhVZVZ,ctcplhhVZVZ,MhhOS,Mhh2OS,           & 
& MVP,MVP2,MVZOS,MVZ2OS,Zfhh,ZfVP,ZfVZ,AmpWavehhToVPVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVPVZ(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MVZOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,         & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVP,             & 
& cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplhhHpmcHpm,cplhhHpmcVWm,   & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,               & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,cplSdcSdVZ,cplSecSeVP,               & 
& cplSecSeVZ,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,cplSecSeVPVZ1,cplSucSuVPVZaa,cplcVWmVPVWmVZ3Q,          & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,AmpVertexhhToVPVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVPVZ(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MVZOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,         & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVP,             & 
& cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplhhHpmcHpm,cplhhHpmcVWm,   & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,               & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,cplSdcSdVZ,cplSecSeVP,               & 
& cplSecSeVZ,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,cplSecSeVPVZ1,cplSucSuVPVZaa,cplcVWmVPVWmVZ3Q,          & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,AmpVertexhhToVPVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_hhToVPVZ(cplhhVZVZ,ctcplhhVZVZ,Mhh,Mhh2,               & 
& MVP,MVP2,MVZ,MVZ2,Zfhh,ZfVP,ZfVZ,AmpWavehhToVPVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_hhToVPVZ(MCha,MFd,MFe,MFu,Mhh,MHpm,MSd,              & 
& MSe,MSu,MVP,MVWm,MVZ,MCha2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVP2,              & 
& MVWm2,MVZ2,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,             & 
& cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpChh,cplcgWpCgWpCVP,      & 
& cplcgWpCgWpCVZ,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,         & 
& cplSdcSdVP,cplSdcSdVZ,cplSecSeVP,cplSecSeVZ,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,        & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhcHpmVPVWm1,& 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,cplSecSeVPVZ1,cplSucSuVPVZaa,           & 
& cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,AmpVertexhhToVPVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ hh->VP VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumhhToVPVZ = 0._dp 
 AmpSum2hhToVPVZ = 0._dp  
Else 
 AmpSumhhToVPVZ = AmpVertexhhToVPVZ + AmpWavehhToVPVZ
 AmpSum2hhToVPVZ = AmpVertexhhToVPVZ + AmpWavehhToVPVZ 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MhhOS(gt1).gt.(0.+MVZOS))).or.((.not.OSkinematics).and.(Mhh(gt1).gt.(MVP+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MhhOS(gt1),0._dp,MVZOS,AmpSumhhToVPVZ(:,gt1),AmpSum2hhToVPVZ(:,gt1),AmpSqhhToVPVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(Mhh(gt1),MVP,MVZ,AmpSumhhToVPVZ(:,gt1),AmpSum2hhToVPVZ(:,gt1),AmpSqhhToVPVZ(gt1)) 
End if  
Else  
  AmpSqhhToVPVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqhhToVPVZ(gt1).eq.0._dp) Then 
  gP1Lhh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1Lhh(gt1,i4) = 2*GammaTPS(MhhOS(gt1),0._dp,MVZOS,helfactor*AmpSqhhToVPVZ(gt1))
Else 
  gP1Lhh(gt1,i4) = 2*GammaTPS(Mhh(gt1),MVP,MVZ,helfactor*AmpSqhhToVPVZ(gt1))
End if 
If ((Abs(MRPhhToVPVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGhhToVPVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1Lhh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
End Subroutine OneLoopDecay_hh

End Module Wrapper_OneLoopDecay_hh_MSSMTriLnV
