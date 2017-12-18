! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Ah_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Ah_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Ah(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcHpmcSuaa,       & 
& cplAhSdcSd,cplAhSdcSdcSvaa,cplAhSdcSecSuaa,cplAhSdSvcSdaa,cplAhSecHpmcSv1,             & 
& cplAhSecSe,cplAhSecSecSv1,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSucSu,cplcChacFuSdL,       & 
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
& cplcFuGluSuR,cplcgAgWmcVWm,cplcgAgWpCVWm,cplcgWmgAHpm,cplcgWmgAVWm,cplcgWmgWmAh,       & 
& cplcgWmgWmhh,cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWmgZHpm,cplcgWmgZVWm,cplcgWpCgAcVWm,       & 
& cplcgWpCgWpCAh,cplcgWpCgWpChh,cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplcgWpCgZcHpm,            & 
& cplcgWpCgZcVWm,cplcgZgWmcHpm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgZgWpCVWm,cplChaFucSdL,   & 
& cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,         & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplcHpmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplhhcHpmVPVWm1,cplhhcHpmVWm,cplhhcHpmVWmVZ1,cplhhcVWmVWm,cplhhhhhh,cplhhhhHpmcHpm1,   & 
& cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSucSuaa,cplhhhhVZVZ1,cplhhHpmcHpm,cplhhHpmcVWm,    & 
& cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcSd,cplhhSdSvcSdaa,cplhhSecSe,cplhhSeSvcSe1,    & 
& cplhhSucSu,cplhhSvcSv,cplhhVZVZ,cplHpmcHpmcVWmVWm1,cplHpmcHpmVP,cplHpmcHpmVPVP1,       & 
& cplHpmcHpmVPVZ1,cplHpmcHpmVZ,cplHpmcHpmVZVZ1,cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmHpmcHpmcHpm1,& 
& cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSucHpmcSuaa, & 
& cplHpmSucSd,cplHpmSucSecSuaa,cplHpmSvcHpmcSv1,cplHpmSvcSe,cplSdcHpmcSu,cplSdcSdcSv,    & 
& cplSdcSdcVWmVWmaa,cplSdcSdVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSdcSdVP,cplSdcSdVPVPaa,cplSdcSdVPVZaa,cplSdcSdVZ,cplSdcSdVZVZaa,cplSdcSecSu,        & 
& cplSdcSucVWm,cplSdSdcSdcSdabab,cplSdSdcSdcSdabba,cplSdSecSdcSeaa,cplSdSucSdcSuabab,    & 
& cplSdSucSdcSuabba,cplSdSvcSd,cplSdSvcSdcSvaa,cplSecHpmcSv,cplSecSecSv,cplSecSecVWmVWm1,& 
& cplSecSeVP,cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSeVZ,cplSecSeVZVZ1,cplSecSvcVWm,          & 
& cplSeSecSecSe1,cplSeSucSd,cplSeSucSecSuaa,cplSeSvcSe,cplSeSvcSecSv1,cplSucSdVWm,       & 
& cplSucSucVWmVWmaa,cplSucSuVG,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVP,cplSucSuVPVPaa,cplSucSuVPVZaa,cplSucSuVZ,cplSucSuVZVZaa,cplSuSucSucSuabab,  & 
& cplSuSucSucSuabba,cplSuSvcSucSvaa,cplSvcSeVWm,cplSvcSvVZ,ctcplAhAhhh,ctcplAhhhVZ,      & 
& ctcplAhHpmcHpm,ctcplAhHpmcVWm,ctcplAhSdcSd,ctcplAhSecSe,ctcplAhSucSu,ctcplcChaChaAhL,  & 
& ctcplcChaChaAhR,ctcplcFdFdAhL,ctcplcFdFdAhR,ctcplcFeFeAhL,ctcplcFeFeAhR,               & 
& ctcplcFuFuAhL,ctcplcFuFuAhR,ctcplChiChiAhL,ctcplChiChiAhR,GcplAhHpmcHpm,               & 
& GcplcHpmVPVWm,GcplHpmcVWmVP,GosZcplAhHpmcHpm,GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,        & 
& GZcplAhHpmcHpm,GZcplcHpmVPVWm,GZcplHpmcVWmVP,ZcplAhAhhh,ZcplAhhhVZ,ZcplAhHpmcHpm,      & 
& ZcplAhHpmcVWm,ZcplAhSdcSd,ZcplAhSecSe,ZcplAhSucSu,ZcplcChaChaAhL,ZcplcChaChaAhR,       & 
& ZcplcFdFdAhL,ZcplcFdFdAhR,ZcplcFeFeAhL,ZcplcFeFeAhR,ZcplcFuFuAhL,ZcplcFuFuAhR,         & 
& ZcplChiChiAhL,ZcplChiChiAhR,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,           & 
& ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,em,gs,deltaM,            & 
& kont,gP1LAh)

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
& cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhSdcHpmcSuaa(2,6,2,6),            & 
& cplAhSdcSd(2,6,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSdcSecSuaa(2,6,6,6),cplAhSdSvcSdaa(2,6,3,6),& 
& cplAhSecHpmcSv1(2,6,2,3),cplAhSecSe(2,6,6),cplAhSecSecSv1(2,6,6,3),cplAhSeSucSdaa(2,6,6,6),& 
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
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcgAgWmcVWm,cplcgAgWpCVWm,      & 
& cplcgWmgAHpm(2),cplcgWmgAVWm,cplcgWmgWmAh(2),cplcgWmgWmhh(2),cplcgWmgWmVP,             & 
& cplcgWmgWmVZ,cplcgWmgZHpm(2),cplcgWmgZVWm,cplcgWpCgAcVWm,cplcgWpCgWpCAh(2),            & 
& cplcgWpCgWpChh(2),cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplcgWpCgZcHpm(2),cplcgWpCgZcVWm,      & 
& cplcgZgWmcHpm(2),cplcgZgWmcVWm,cplcgZgWpCHpm(2),cplcgZgWpCVWm,cplChaFucSdL(2,3,6),     & 
& cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2)

Complex(dp),Intent(in) :: cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,          & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),               & 
& cplhhcHpmVPVWm1(2,2),cplhhcHpmVWm(2,2),cplhhcHpmVWmVZ1(2,2),cplhhcVWmVWm(2),           & 
& cplhhhhhh(2,2,2),cplhhhhHpmcHpm1(2,2,2,2),cplhhhhSdcSdaa(2,2,6,6),cplhhhhSecSe1(2,2,6,6),& 
& cplhhhhSucSuaa(2,2,6,6),cplhhhhVZVZ1(2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),       & 
& cplhhHpmcVWmVP1(2,2),cplhhHpmcVWmVZ1(2,2),cplhhSdcSd(2,6,6),cplhhSdSvcSdaa(2,6,3,6),   & 
& cplhhSecSe(2,6,6),cplhhSeSvcSe1(2,6,3,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),          & 
& cplhhVZVZ(2),cplHpmcHpmcVWmVWm1(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVPVP1(2,2),           & 
& cplHpmcHpmVPVZ1(2,2),cplHpmcHpmVZ(2,2),cplHpmcHpmVZVZ1(2,2),cplHpmcVWmVP(2),           & 
& cplHpmcVWmVZ(2),cplHpmHpmcHpmcHpm1(2,2,2,2),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSdcSdcSeaa(2,6,6,6),& 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSecSecSe1(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),         & 
& cplHpmSucSd(2,6,6),cplHpmSucSecSuaa(2,6,6,6),cplHpmSvcHpmcSv1(2,3,2,3),cplHpmSvcSe(2,3,6),& 
& cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSdcVWmVWmaa(6,6),cplSdcSdVG(6,6),         & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),& 
& cplSdcSdVP(6,6),cplSdcSdVPVPaa(6,6),cplSdcSdVPVZaa(6,6),cplSdcSdVZ(6,6),               & 
& cplSdcSdVZVZaa(6,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSdSdcSdcSdabab(6,6,6,6),   & 
& cplSdSdcSdcSdabba(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),        & 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSvcSd(6,3,6),cplSdSvcSdcSvaa(6,3,6,3),cplSecHpmcSv(6,2,3),& 
& cplSecSecSv(6,6,3),cplSecSecVWmVWm1(6,6),cplSecSeVP(6,6),cplSecSeVPVP1(6,6),           & 
& cplSecSeVPVZ1(6,6),cplSecSeVZ(6,6),cplSecSeVZVZ1(6,6),cplSecSvcVWm(6,3),               & 
& cplSeSecSecSe1(6,6,6,6),cplSeSucSd(6,6,6),cplSeSucSecSuaa(6,6,6,6),cplSeSvcSe(6,3,6),  & 
& cplSeSvcSecSv1(6,3,6,3),cplSucSdVWm(6,6),cplSucSucVWmVWmaa(6,6),cplSucSuVG(6,6),       & 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),& 
& cplSucSuVP(6,6),cplSucSuVPVPaa(6,6),cplSucSuVPVZaa(6,6),cplSucSuVZ(6,6),               & 
& cplSucSuVZVZaa(6,6),cplSuSucSucSuabab(6,6,6,6),cplSuSucSucSuabba(6,6,6,6),             & 
& cplSuSvcSucSvaa(6,3,6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),ctcplAhAhhh(2,2,2),          & 
& ctcplAhhhVZ(2,2),ctcplAhHpmcHpm(2,2,2),ctcplAhHpmcVWm(2,2),ctcplAhSdcSd(2,6,6),        & 
& ctcplAhSecSe(2,6,6),ctcplAhSucSu(2,6,6),ctcplcChaChaAhL(2,2,2),ctcplcChaChaAhR(2,2,2), & 
& ctcplcFdFdAhL(3,3,2),ctcplcFdFdAhR(3,3,2),ctcplcFeFeAhL(3,3,2),ctcplcFeFeAhR(3,3,2),   & 
& ctcplcFuFuAhL(3,3,2),ctcplcFuFuAhR(3,3,2),ctcplChiChiAhL(4,4,2),ctcplChiChiAhR(4,4,2)

Complex(dp),Intent(in) :: GcplAhHpmcHpm(2,2,2),GcplcHpmVPVWm(2),GcplHpmcVWmVP(2),GosZcplAhHpmcHpm(2,2,2),        & 
& GosZcplcHpmVPVWm(2),GosZcplHpmcVWmVP(2),GZcplAhHpmcHpm(2,2,2),GZcplcHpmVPVWm(2),       & 
& GZcplHpmcVWmVP(2),ZcplAhAhhh(2,2,2),ZcplAhhhVZ(2,2),ZcplAhHpmcHpm(2,2,2),              & 
& ZcplAhHpmcVWm(2,2),ZcplAhSdcSd(2,6,6),ZcplAhSecSe(2,6,6),ZcplAhSucSu(2,6,6),           & 
& ZcplcChaChaAhL(2,2,2),ZcplcChaChaAhR(2,2,2),ZcplcFdFdAhL(3,3,2),ZcplcFdFdAhR(3,3,2),   & 
& ZcplcFeFeAhL(3,3,2),ZcplcFeFeAhR(3,3,2),ZcplcFuFuAhL(3,3,2),ZcplcFuFuAhR(3,3,2),       & 
& ZcplChiChiAhL(4,4,2),ZcplChiChiAhR(4,4,2)

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
Real(dp), Intent(out) :: gP1LAh(2,237) 
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
Real(dp) :: MRPAhTohhAh(2,2,2),MRGAhTohhAh(2,2,2), MRPZAhTohhAh(2,2,2),MRGZAhTohhAh(2,2,2) 
Real(dp) :: MVPAhTohhAh(2,2,2) 
Real(dp) :: RMsqTreeAhTohhAh(2,2,2),RMsqWaveAhTohhAh(2,2,2),RMsqVertexAhTohhAh(2,2,2) 
Complex(dp) :: AmpTreeAhTohhAh(2,2,2),AmpWaveAhTohhAh(2,2,2),AmpVertexAhTohhAh(2,2,2)& 
 & ,AmpVertexIRosAhTohhAh(2,2,2),AmpVertexIRdrAhTohhAh(2,2,2), AmpSumAhTohhAh(2,2,2), AmpSum2AhTohhAh(2,2,2) 
Complex(dp) :: AmpTreeZAhTohhAh(2,2,2),AmpWaveZAhTohhAh(2,2,2),AmpVertexZAhTohhAh(2,2,2) 
Real(dp) :: AmpSqAhTohhAh(2,2,2),  AmpSqTreeAhTohhAh(2,2,2) 
Real(dp) :: MRPAhTocChaCha(2,2,2),MRGAhTocChaCha(2,2,2), MRPZAhTocChaCha(2,2,2),MRGZAhTocChaCha(2,2,2) 
Real(dp) :: MVPAhTocChaCha(2,2,2) 
Real(dp) :: RMsqTreeAhTocChaCha(2,2,2),RMsqWaveAhTocChaCha(2,2,2),RMsqVertexAhTocChaCha(2,2,2) 
Complex(dp) :: AmpTreeAhTocChaCha(2,2,2,2),AmpWaveAhTocChaCha(2,2,2,2),AmpVertexAhTocChaCha(2,2,2,2)& 
 & ,AmpVertexIRosAhTocChaCha(2,2,2,2),AmpVertexIRdrAhTocChaCha(2,2,2,2), AmpSumAhTocChaCha(2,2,2,2), AmpSum2AhTocChaCha(2,2,2,2) 
Complex(dp) :: AmpTreeZAhTocChaCha(2,2,2,2),AmpWaveZAhTocChaCha(2,2,2,2),AmpVertexZAhTocChaCha(2,2,2,2) 
Real(dp) :: AmpSqAhTocChaCha(2,2,2),  AmpSqTreeAhTocChaCha(2,2,2) 
Real(dp) :: MRPAhToChiChi(2,4,4),MRGAhToChiChi(2,4,4), MRPZAhToChiChi(2,4,4),MRGZAhToChiChi(2,4,4) 
Real(dp) :: MVPAhToChiChi(2,4,4) 
Real(dp) :: RMsqTreeAhToChiChi(2,4,4),RMsqWaveAhToChiChi(2,4,4),RMsqVertexAhToChiChi(2,4,4) 
Complex(dp) :: AmpTreeAhToChiChi(2,2,4,4),AmpWaveAhToChiChi(2,2,4,4),AmpVertexAhToChiChi(2,2,4,4)& 
 & ,AmpVertexIRosAhToChiChi(2,2,4,4),AmpVertexIRdrAhToChiChi(2,2,4,4), AmpSumAhToChiChi(2,2,4,4), AmpSum2AhToChiChi(2,2,4,4) 
Complex(dp) :: AmpTreeZAhToChiChi(2,2,4,4),AmpWaveZAhToChiChi(2,2,4,4),AmpVertexZAhToChiChi(2,2,4,4) 
Real(dp) :: AmpSqAhToChiChi(2,4,4),  AmpSqTreeAhToChiChi(2,4,4) 
Real(dp) :: MRPAhTocFdFd(2,3,3),MRGAhTocFdFd(2,3,3), MRPZAhTocFdFd(2,3,3),MRGZAhTocFdFd(2,3,3) 
Real(dp) :: MVPAhTocFdFd(2,3,3) 
Real(dp) :: RMsqTreeAhTocFdFd(2,3,3),RMsqWaveAhTocFdFd(2,3,3),RMsqVertexAhTocFdFd(2,3,3) 
Complex(dp) :: AmpTreeAhTocFdFd(2,2,3,3),AmpWaveAhTocFdFd(2,2,3,3),AmpVertexAhTocFdFd(2,2,3,3)& 
 & ,AmpVertexIRosAhTocFdFd(2,2,3,3),AmpVertexIRdrAhTocFdFd(2,2,3,3), AmpSumAhTocFdFd(2,2,3,3), AmpSum2AhTocFdFd(2,2,3,3) 
Complex(dp) :: AmpTreeZAhTocFdFd(2,2,3,3),AmpWaveZAhTocFdFd(2,2,3,3),AmpVertexZAhTocFdFd(2,2,3,3) 
Real(dp) :: AmpSqAhTocFdFd(2,3,3),  AmpSqTreeAhTocFdFd(2,3,3) 
Real(dp) :: MRPAhTocFeFe(2,3,3),MRGAhTocFeFe(2,3,3), MRPZAhTocFeFe(2,3,3),MRGZAhTocFeFe(2,3,3) 
Real(dp) :: MVPAhTocFeFe(2,3,3) 
Real(dp) :: RMsqTreeAhTocFeFe(2,3,3),RMsqWaveAhTocFeFe(2,3,3),RMsqVertexAhTocFeFe(2,3,3) 
Complex(dp) :: AmpTreeAhTocFeFe(2,2,3,3),AmpWaveAhTocFeFe(2,2,3,3),AmpVertexAhTocFeFe(2,2,3,3)& 
 & ,AmpVertexIRosAhTocFeFe(2,2,3,3),AmpVertexIRdrAhTocFeFe(2,2,3,3), AmpSumAhTocFeFe(2,2,3,3), AmpSum2AhTocFeFe(2,2,3,3) 
Complex(dp) :: AmpTreeZAhTocFeFe(2,2,3,3),AmpWaveZAhTocFeFe(2,2,3,3),AmpVertexZAhTocFeFe(2,2,3,3) 
Real(dp) :: AmpSqAhTocFeFe(2,3,3),  AmpSqTreeAhTocFeFe(2,3,3) 
Real(dp) :: MRPAhTocFuFu(2,3,3),MRGAhTocFuFu(2,3,3), MRPZAhTocFuFu(2,3,3),MRGZAhTocFuFu(2,3,3) 
Real(dp) :: MVPAhTocFuFu(2,3,3) 
Real(dp) :: RMsqTreeAhTocFuFu(2,3,3),RMsqWaveAhTocFuFu(2,3,3),RMsqVertexAhTocFuFu(2,3,3) 
Complex(dp) :: AmpTreeAhTocFuFu(2,2,3,3),AmpWaveAhTocFuFu(2,2,3,3),AmpVertexAhTocFuFu(2,2,3,3)& 
 & ,AmpVertexIRosAhTocFuFu(2,2,3,3),AmpVertexIRdrAhTocFuFu(2,2,3,3), AmpSumAhTocFuFu(2,2,3,3), AmpSum2AhTocFuFu(2,2,3,3) 
Complex(dp) :: AmpTreeZAhTocFuFu(2,2,3,3),AmpWaveZAhTocFuFu(2,2,3,3),AmpVertexZAhTocFuFu(2,2,3,3) 
Real(dp) :: AmpSqAhTocFuFu(2,3,3),  AmpSqTreeAhTocFuFu(2,3,3) 
Real(dp) :: MRPAhTohhVZ(2,2),MRGAhTohhVZ(2,2), MRPZAhTohhVZ(2,2),MRGZAhTohhVZ(2,2) 
Real(dp) :: MVPAhTohhVZ(2,2) 
Real(dp) :: RMsqTreeAhTohhVZ(2,2),RMsqWaveAhTohhVZ(2,2),RMsqVertexAhTohhVZ(2,2) 
Complex(dp) :: AmpTreeAhTohhVZ(2,2,2),AmpWaveAhTohhVZ(2,2,2),AmpVertexAhTohhVZ(2,2,2)& 
 & ,AmpVertexIRosAhTohhVZ(2,2,2),AmpVertexIRdrAhTohhVZ(2,2,2), AmpSumAhTohhVZ(2,2,2), AmpSum2AhTohhVZ(2,2,2) 
Complex(dp) :: AmpTreeZAhTohhVZ(2,2,2),AmpWaveZAhTohhVZ(2,2,2),AmpVertexZAhTohhVZ(2,2,2) 
Real(dp) :: AmpSqAhTohhVZ(2,2),  AmpSqTreeAhTohhVZ(2,2) 
Real(dp) :: MRPAhTocHpmHpm(2,2,2),MRGAhTocHpmHpm(2,2,2), MRPZAhTocHpmHpm(2,2,2),MRGZAhTocHpmHpm(2,2,2) 
Real(dp) :: MVPAhTocHpmHpm(2,2,2) 
Real(dp) :: RMsqTreeAhTocHpmHpm(2,2,2),RMsqWaveAhTocHpmHpm(2,2,2),RMsqVertexAhTocHpmHpm(2,2,2) 
Complex(dp) :: AmpTreeAhTocHpmHpm(2,2,2),AmpWaveAhTocHpmHpm(2,2,2),AmpVertexAhTocHpmHpm(2,2,2)& 
 & ,AmpVertexIRosAhTocHpmHpm(2,2,2),AmpVertexIRdrAhTocHpmHpm(2,2,2), AmpSumAhTocHpmHpm(2,2,2), AmpSum2AhTocHpmHpm(2,2,2) 
Complex(dp) :: AmpTreeZAhTocHpmHpm(2,2,2),AmpWaveZAhTocHpmHpm(2,2,2),AmpVertexZAhTocHpmHpm(2,2,2) 
Real(dp) :: AmpSqAhTocHpmHpm(2,2,2),  AmpSqTreeAhTocHpmHpm(2,2,2) 
Real(dp) :: MRPAhToHpmcVWm(2,2),MRGAhToHpmcVWm(2,2), MRPZAhToHpmcVWm(2,2),MRGZAhToHpmcVWm(2,2) 
Real(dp) :: MVPAhToHpmcVWm(2,2) 
Real(dp) :: RMsqTreeAhToHpmcVWm(2,2),RMsqWaveAhToHpmcVWm(2,2),RMsqVertexAhToHpmcVWm(2,2) 
Complex(dp) :: AmpTreeAhToHpmcVWm(2,2,2),AmpWaveAhToHpmcVWm(2,2,2),AmpVertexAhToHpmcVWm(2,2,2)& 
 & ,AmpVertexIRosAhToHpmcVWm(2,2,2),AmpVertexIRdrAhToHpmcVWm(2,2,2), AmpSumAhToHpmcVWm(2,2,2), AmpSum2AhToHpmcVWm(2,2,2) 
Complex(dp) :: AmpTreeZAhToHpmcVWm(2,2,2),AmpWaveZAhToHpmcVWm(2,2,2),AmpVertexZAhToHpmcVWm(2,2,2) 
Real(dp) :: AmpSqAhToHpmcVWm(2,2),  AmpSqTreeAhToHpmcVWm(2,2) 
Real(dp) :: MRPAhTocSdSd(2,6,6),MRGAhTocSdSd(2,6,6), MRPZAhTocSdSd(2,6,6),MRGZAhTocSdSd(2,6,6) 
Real(dp) :: MVPAhTocSdSd(2,6,6) 
Real(dp) :: RMsqTreeAhTocSdSd(2,6,6),RMsqWaveAhTocSdSd(2,6,6),RMsqVertexAhTocSdSd(2,6,6) 
Complex(dp) :: AmpTreeAhTocSdSd(2,6,6),AmpWaveAhTocSdSd(2,6,6),AmpVertexAhTocSdSd(2,6,6)& 
 & ,AmpVertexIRosAhTocSdSd(2,6,6),AmpVertexIRdrAhTocSdSd(2,6,6), AmpSumAhTocSdSd(2,6,6), AmpSum2AhTocSdSd(2,6,6) 
Complex(dp) :: AmpTreeZAhTocSdSd(2,6,6),AmpWaveZAhTocSdSd(2,6,6),AmpVertexZAhTocSdSd(2,6,6) 
Real(dp) :: AmpSqAhTocSdSd(2,6,6),  AmpSqTreeAhTocSdSd(2,6,6) 
Real(dp) :: MRPAhTocSeSe(2,6,6),MRGAhTocSeSe(2,6,6), MRPZAhTocSeSe(2,6,6),MRGZAhTocSeSe(2,6,6) 
Real(dp) :: MVPAhTocSeSe(2,6,6) 
Real(dp) :: RMsqTreeAhTocSeSe(2,6,6),RMsqWaveAhTocSeSe(2,6,6),RMsqVertexAhTocSeSe(2,6,6) 
Complex(dp) :: AmpTreeAhTocSeSe(2,6,6),AmpWaveAhTocSeSe(2,6,6),AmpVertexAhTocSeSe(2,6,6)& 
 & ,AmpVertexIRosAhTocSeSe(2,6,6),AmpVertexIRdrAhTocSeSe(2,6,6), AmpSumAhTocSeSe(2,6,6), AmpSum2AhTocSeSe(2,6,6) 
Complex(dp) :: AmpTreeZAhTocSeSe(2,6,6),AmpWaveZAhTocSeSe(2,6,6),AmpVertexZAhTocSeSe(2,6,6) 
Real(dp) :: AmpSqAhTocSeSe(2,6,6),  AmpSqTreeAhTocSeSe(2,6,6) 
Real(dp) :: MRPAhTocSuSu(2,6,6),MRGAhTocSuSu(2,6,6), MRPZAhTocSuSu(2,6,6),MRGZAhTocSuSu(2,6,6) 
Real(dp) :: MVPAhTocSuSu(2,6,6) 
Real(dp) :: RMsqTreeAhTocSuSu(2,6,6),RMsqWaveAhTocSuSu(2,6,6),RMsqVertexAhTocSuSu(2,6,6) 
Complex(dp) :: AmpTreeAhTocSuSu(2,6,6),AmpWaveAhTocSuSu(2,6,6),AmpVertexAhTocSuSu(2,6,6)& 
 & ,AmpVertexIRosAhTocSuSu(2,6,6),AmpVertexIRdrAhTocSuSu(2,6,6), AmpSumAhTocSuSu(2,6,6), AmpSum2AhTocSuSu(2,6,6) 
Complex(dp) :: AmpTreeZAhTocSuSu(2,6,6),AmpWaveZAhTocSuSu(2,6,6),AmpVertexZAhTocSuSu(2,6,6) 
Real(dp) :: AmpSqAhTocSuSu(2,6,6),  AmpSqTreeAhTocSuSu(2,6,6) 
Real(dp) :: MRPAhToAhAh(2,2,2),MRGAhToAhAh(2,2,2), MRPZAhToAhAh(2,2,2),MRGZAhToAhAh(2,2,2) 
Real(dp) :: MVPAhToAhAh(2,2,2) 
Real(dp) :: RMsqTreeAhToAhAh(2,2,2),RMsqWaveAhToAhAh(2,2,2),RMsqVertexAhToAhAh(2,2,2) 
Complex(dp) :: AmpTreeAhToAhAh(2,2,2),AmpWaveAhToAhAh(2,2,2),AmpVertexAhToAhAh(2,2,2)& 
 & ,AmpVertexIRosAhToAhAh(2,2,2),AmpVertexIRdrAhToAhAh(2,2,2), AmpSumAhToAhAh(2,2,2), AmpSum2AhToAhAh(2,2,2) 
Complex(dp) :: AmpTreeZAhToAhAh(2,2,2),AmpWaveZAhToAhAh(2,2,2),AmpVertexZAhToAhAh(2,2,2) 
Real(dp) :: AmpSqAhToAhAh(2,2,2),  AmpSqTreeAhToAhAh(2,2,2) 
Real(dp) :: MRPAhToAhSv(2,2,3),MRGAhToAhSv(2,2,3), MRPZAhToAhSv(2,2,3),MRGZAhToAhSv(2,2,3) 
Real(dp) :: MVPAhToAhSv(2,2,3) 
Real(dp) :: RMsqTreeAhToAhSv(2,2,3),RMsqWaveAhToAhSv(2,2,3),RMsqVertexAhToAhSv(2,2,3) 
Complex(dp) :: AmpTreeAhToAhSv(2,2,3),AmpWaveAhToAhSv(2,2,3),AmpVertexAhToAhSv(2,2,3)& 
 & ,AmpVertexIRosAhToAhSv(2,2,3),AmpVertexIRdrAhToAhSv(2,2,3), AmpSumAhToAhSv(2,2,3), AmpSum2AhToAhSv(2,2,3) 
Complex(dp) :: AmpTreeZAhToAhSv(2,2,3),AmpWaveZAhToAhSv(2,2,3),AmpVertexZAhToAhSv(2,2,3) 
Real(dp) :: AmpSqAhToAhSv(2,2,3),  AmpSqTreeAhToAhSv(2,2,3) 
Real(dp) :: MRPAhToAhVP(2,2),MRGAhToAhVP(2,2), MRPZAhToAhVP(2,2),MRGZAhToAhVP(2,2) 
Real(dp) :: MVPAhToAhVP(2,2) 
Real(dp) :: RMsqTreeAhToAhVP(2,2),RMsqWaveAhToAhVP(2,2),RMsqVertexAhToAhVP(2,2) 
Complex(dp) :: AmpTreeAhToAhVP(2,2,2),AmpWaveAhToAhVP(2,2,2),AmpVertexAhToAhVP(2,2,2)& 
 & ,AmpVertexIRosAhToAhVP(2,2,2),AmpVertexIRdrAhToAhVP(2,2,2), AmpSumAhToAhVP(2,2,2), AmpSum2AhToAhVP(2,2,2) 
Complex(dp) :: AmpTreeZAhToAhVP(2,2,2),AmpWaveZAhToAhVP(2,2,2),AmpVertexZAhToAhVP(2,2,2) 
Real(dp) :: AmpSqAhToAhVP(2,2),  AmpSqTreeAhToAhVP(2,2) 
Real(dp) :: MRPAhToAhVZ(2,2),MRGAhToAhVZ(2,2), MRPZAhToAhVZ(2,2),MRGZAhToAhVZ(2,2) 
Real(dp) :: MVPAhToAhVZ(2,2) 
Real(dp) :: RMsqTreeAhToAhVZ(2,2),RMsqWaveAhToAhVZ(2,2),RMsqVertexAhToAhVZ(2,2) 
Complex(dp) :: AmpTreeAhToAhVZ(2,2,2),AmpWaveAhToAhVZ(2,2,2),AmpVertexAhToAhVZ(2,2,2)& 
 & ,AmpVertexIRosAhToAhVZ(2,2,2),AmpVertexIRdrAhToAhVZ(2,2,2), AmpSumAhToAhVZ(2,2,2), AmpSum2AhToAhVZ(2,2,2) 
Complex(dp) :: AmpTreeZAhToAhVZ(2,2,2),AmpWaveZAhToAhVZ(2,2,2),AmpVertexZAhToAhVZ(2,2,2) 
Real(dp) :: AmpSqAhToAhVZ(2,2),  AmpSqTreeAhToAhVZ(2,2) 
Real(dp) :: MRPAhToChacFe(2,2,3),MRGAhToChacFe(2,2,3), MRPZAhToChacFe(2,2,3),MRGZAhToChacFe(2,2,3) 
Real(dp) :: MVPAhToChacFe(2,2,3) 
Real(dp) :: RMsqTreeAhToChacFe(2,2,3),RMsqWaveAhToChacFe(2,2,3),RMsqVertexAhToChacFe(2,2,3) 
Complex(dp) :: AmpTreeAhToChacFe(2,2,2,3),AmpWaveAhToChacFe(2,2,2,3),AmpVertexAhToChacFe(2,2,2,3)& 
 & ,AmpVertexIRosAhToChacFe(2,2,2,3),AmpVertexIRdrAhToChacFe(2,2,2,3), AmpSumAhToChacFe(2,2,2,3), AmpSum2AhToChacFe(2,2,2,3) 
Complex(dp) :: AmpTreeZAhToChacFe(2,2,2,3),AmpWaveZAhToChacFe(2,2,2,3),AmpVertexZAhToChacFe(2,2,2,3) 
Real(dp) :: AmpSqAhToChacFe(2,2,3),  AmpSqTreeAhToChacFe(2,2,3) 
Real(dp) :: MRPAhToChiFv(2,4,3),MRGAhToChiFv(2,4,3), MRPZAhToChiFv(2,4,3),MRGZAhToChiFv(2,4,3) 
Real(dp) :: MVPAhToChiFv(2,4,3) 
Real(dp) :: RMsqTreeAhToChiFv(2,4,3),RMsqWaveAhToChiFv(2,4,3),RMsqVertexAhToChiFv(2,4,3) 
Complex(dp) :: AmpTreeAhToChiFv(2,2,4,3),AmpWaveAhToChiFv(2,2,4,3),AmpVertexAhToChiFv(2,2,4,3)& 
 & ,AmpVertexIRosAhToChiFv(2,2,4,3),AmpVertexIRdrAhToChiFv(2,2,4,3), AmpSumAhToChiFv(2,2,4,3), AmpSum2AhToChiFv(2,2,4,3) 
Complex(dp) :: AmpTreeZAhToChiFv(2,2,4,3),AmpWaveZAhToChiFv(2,2,4,3),AmpVertexZAhToChiFv(2,2,4,3) 
Real(dp) :: AmpSqAhToChiFv(2,4,3),  AmpSqTreeAhToChiFv(2,4,3) 
Real(dp) :: MRPAhToFvFv(2,3,3),MRGAhToFvFv(2,3,3), MRPZAhToFvFv(2,3,3),MRGZAhToFvFv(2,3,3) 
Real(dp) :: MVPAhToFvFv(2,3,3) 
Real(dp) :: RMsqTreeAhToFvFv(2,3,3),RMsqWaveAhToFvFv(2,3,3),RMsqVertexAhToFvFv(2,3,3) 
Complex(dp) :: AmpTreeAhToFvFv(2,2,3,3),AmpWaveAhToFvFv(2,2,3,3),AmpVertexAhToFvFv(2,2,3,3)& 
 & ,AmpVertexIRosAhToFvFv(2,2,3,3),AmpVertexIRdrAhToFvFv(2,2,3,3), AmpSumAhToFvFv(2,2,3,3), AmpSum2AhToFvFv(2,2,3,3) 
Complex(dp) :: AmpTreeZAhToFvFv(2,2,3,3),AmpWaveZAhToFvFv(2,2,3,3),AmpVertexZAhToFvFv(2,2,3,3) 
Real(dp) :: AmpSqAhToFvFv(2,3,3),  AmpSqTreeAhToFvFv(2,3,3) 
Real(dp) :: MRPAhToGluGlu(2),MRGAhToGluGlu(2), MRPZAhToGluGlu(2),MRGZAhToGluGlu(2) 
Real(dp) :: MVPAhToGluGlu(2) 
Real(dp) :: RMsqTreeAhToGluGlu(2),RMsqWaveAhToGluGlu(2),RMsqVertexAhToGluGlu(2) 
Complex(dp) :: AmpTreeAhToGluGlu(2,2),AmpWaveAhToGluGlu(2,2),AmpVertexAhToGluGlu(2,2)& 
 & ,AmpVertexIRosAhToGluGlu(2,2),AmpVertexIRdrAhToGluGlu(2,2), AmpSumAhToGluGlu(2,2), AmpSum2AhToGluGlu(2,2) 
Complex(dp) :: AmpTreeZAhToGluGlu(2,2),AmpWaveZAhToGluGlu(2,2),AmpVertexZAhToGluGlu(2,2) 
Real(dp) :: AmpSqAhToGluGlu(2),  AmpSqTreeAhToGluGlu(2) 
Real(dp) :: MRPAhTohhhh(2,2,2),MRGAhTohhhh(2,2,2), MRPZAhTohhhh(2,2,2),MRGZAhTohhhh(2,2,2) 
Real(dp) :: MVPAhTohhhh(2,2,2) 
Real(dp) :: RMsqTreeAhTohhhh(2,2,2),RMsqWaveAhTohhhh(2,2,2),RMsqVertexAhTohhhh(2,2,2) 
Complex(dp) :: AmpTreeAhTohhhh(2,2,2),AmpWaveAhTohhhh(2,2,2),AmpVertexAhTohhhh(2,2,2)& 
 & ,AmpVertexIRosAhTohhhh(2,2,2),AmpVertexIRdrAhTohhhh(2,2,2), AmpSumAhTohhhh(2,2,2), AmpSum2AhTohhhh(2,2,2) 
Complex(dp) :: AmpTreeZAhTohhhh(2,2,2),AmpWaveZAhTohhhh(2,2,2),AmpVertexZAhTohhhh(2,2,2) 
Real(dp) :: AmpSqAhTohhhh(2,2,2),  AmpSqTreeAhTohhhh(2,2,2) 
Real(dp) :: MRPAhTohhSv(2,2,3),MRGAhTohhSv(2,2,3), MRPZAhTohhSv(2,2,3),MRGZAhTohhSv(2,2,3) 
Real(dp) :: MVPAhTohhSv(2,2,3) 
Real(dp) :: RMsqTreeAhTohhSv(2,2,3),RMsqWaveAhTohhSv(2,2,3),RMsqVertexAhTohhSv(2,2,3) 
Complex(dp) :: AmpTreeAhTohhSv(2,2,3),AmpWaveAhTohhSv(2,2,3),AmpVertexAhTohhSv(2,2,3)& 
 & ,AmpVertexIRosAhTohhSv(2,2,3),AmpVertexIRdrAhTohhSv(2,2,3), AmpSumAhTohhSv(2,2,3), AmpSum2AhTohhSv(2,2,3) 
Complex(dp) :: AmpTreeZAhTohhSv(2,2,3),AmpWaveZAhTohhSv(2,2,3),AmpVertexZAhTohhSv(2,2,3) 
Real(dp) :: AmpSqAhTohhSv(2,2,3),  AmpSqTreeAhTohhSv(2,2,3) 
Real(dp) :: MRPAhTohhVP(2,2),MRGAhTohhVP(2,2), MRPZAhTohhVP(2,2),MRGZAhTohhVP(2,2) 
Real(dp) :: MVPAhTohhVP(2,2) 
Real(dp) :: RMsqTreeAhTohhVP(2,2),RMsqWaveAhTohhVP(2,2),RMsqVertexAhTohhVP(2,2) 
Complex(dp) :: AmpTreeAhTohhVP(2,2,2),AmpWaveAhTohhVP(2,2,2),AmpVertexAhTohhVP(2,2,2)& 
 & ,AmpVertexIRosAhTohhVP(2,2,2),AmpVertexIRdrAhTohhVP(2,2,2), AmpSumAhTohhVP(2,2,2), AmpSum2AhTohhVP(2,2,2) 
Complex(dp) :: AmpTreeZAhTohhVP(2,2,2),AmpWaveZAhTohhVP(2,2,2),AmpVertexZAhTohhVP(2,2,2) 
Real(dp) :: AmpSqAhTohhVP(2,2),  AmpSqTreeAhTohhVP(2,2) 
Real(dp) :: MRPAhToHpmcSe(2,2,6),MRGAhToHpmcSe(2,2,6), MRPZAhToHpmcSe(2,2,6),MRGZAhToHpmcSe(2,2,6) 
Real(dp) :: MVPAhToHpmcSe(2,2,6) 
Real(dp) :: RMsqTreeAhToHpmcSe(2,2,6),RMsqWaveAhToHpmcSe(2,2,6),RMsqVertexAhToHpmcSe(2,2,6) 
Complex(dp) :: AmpTreeAhToHpmcSe(2,2,6),AmpWaveAhToHpmcSe(2,2,6),AmpVertexAhToHpmcSe(2,2,6)& 
 & ,AmpVertexIRosAhToHpmcSe(2,2,6),AmpVertexIRdrAhToHpmcSe(2,2,6), AmpSumAhToHpmcSe(2,2,6), AmpSum2AhToHpmcSe(2,2,6) 
Complex(dp) :: AmpTreeZAhToHpmcSe(2,2,6),AmpWaveZAhToHpmcSe(2,2,6),AmpVertexZAhToHpmcSe(2,2,6) 
Real(dp) :: AmpSqAhToHpmcSe(2,2,6),  AmpSqTreeAhToHpmcSe(2,2,6) 
Real(dp) :: MRPAhToSecVWm(2,6),MRGAhToSecVWm(2,6), MRPZAhToSecVWm(2,6),MRGZAhToSecVWm(2,6) 
Real(dp) :: MVPAhToSecVWm(2,6) 
Real(dp) :: RMsqTreeAhToSecVWm(2,6),RMsqWaveAhToSecVWm(2,6),RMsqVertexAhToSecVWm(2,6) 
Complex(dp) :: AmpTreeAhToSecVWm(2,2,6),AmpWaveAhToSecVWm(2,2,6),AmpVertexAhToSecVWm(2,2,6)& 
 & ,AmpVertexIRosAhToSecVWm(2,2,6),AmpVertexIRdrAhToSecVWm(2,2,6), AmpSumAhToSecVWm(2,2,6), AmpSum2AhToSecVWm(2,2,6) 
Complex(dp) :: AmpTreeZAhToSecVWm(2,2,6),AmpWaveZAhToSecVWm(2,2,6),AmpVertexZAhToSecVWm(2,2,6) 
Real(dp) :: AmpSqAhToSecVWm(2,6),  AmpSqTreeAhToSecVWm(2,6) 
Real(dp) :: MRPAhToSvSv(2,3,3),MRGAhToSvSv(2,3,3), MRPZAhToSvSv(2,3,3),MRGZAhToSvSv(2,3,3) 
Real(dp) :: MVPAhToSvSv(2,3,3) 
Real(dp) :: RMsqTreeAhToSvSv(2,3,3),RMsqWaveAhToSvSv(2,3,3),RMsqVertexAhToSvSv(2,3,3) 
Complex(dp) :: AmpTreeAhToSvSv(2,3,3),AmpWaveAhToSvSv(2,3,3),AmpVertexAhToSvSv(2,3,3)& 
 & ,AmpVertexIRosAhToSvSv(2,3,3),AmpVertexIRdrAhToSvSv(2,3,3), AmpSumAhToSvSv(2,3,3), AmpSum2AhToSvSv(2,3,3) 
Complex(dp) :: AmpTreeZAhToSvSv(2,3,3),AmpWaveZAhToSvSv(2,3,3),AmpVertexZAhToSvSv(2,3,3) 
Real(dp) :: AmpSqAhToSvSv(2,3,3),  AmpSqTreeAhToSvSv(2,3,3) 
Real(dp) :: MRPAhToSvVP(2,3),MRGAhToSvVP(2,3), MRPZAhToSvVP(2,3),MRGZAhToSvVP(2,3) 
Real(dp) :: MVPAhToSvVP(2,3) 
Real(dp) :: RMsqTreeAhToSvVP(2,3),RMsqWaveAhToSvVP(2,3),RMsqVertexAhToSvVP(2,3) 
Complex(dp) :: AmpTreeAhToSvVP(2,2,3),AmpWaveAhToSvVP(2,2,3),AmpVertexAhToSvVP(2,2,3)& 
 & ,AmpVertexIRosAhToSvVP(2,2,3),AmpVertexIRdrAhToSvVP(2,2,3), AmpSumAhToSvVP(2,2,3), AmpSum2AhToSvVP(2,2,3) 
Complex(dp) :: AmpTreeZAhToSvVP(2,2,3),AmpWaveZAhToSvVP(2,2,3),AmpVertexZAhToSvVP(2,2,3) 
Real(dp) :: AmpSqAhToSvVP(2,3),  AmpSqTreeAhToSvVP(2,3) 
Real(dp) :: MRPAhToSvVZ(2,3),MRGAhToSvVZ(2,3), MRPZAhToSvVZ(2,3),MRGZAhToSvVZ(2,3) 
Real(dp) :: MVPAhToSvVZ(2,3) 
Real(dp) :: RMsqTreeAhToSvVZ(2,3),RMsqWaveAhToSvVZ(2,3),RMsqVertexAhToSvVZ(2,3) 
Complex(dp) :: AmpTreeAhToSvVZ(2,2,3),AmpWaveAhToSvVZ(2,2,3),AmpVertexAhToSvVZ(2,2,3)& 
 & ,AmpVertexIRosAhToSvVZ(2,2,3),AmpVertexIRdrAhToSvVZ(2,2,3), AmpSumAhToSvVZ(2,2,3), AmpSum2AhToSvVZ(2,2,3) 
Complex(dp) :: AmpTreeZAhToSvVZ(2,2,3),AmpWaveZAhToSvVZ(2,2,3),AmpVertexZAhToSvVZ(2,2,3) 
Real(dp) :: AmpSqAhToSvVZ(2,3),  AmpSqTreeAhToSvVZ(2,3) 
Real(dp) :: MRPAhToSvcSv(2,3,3),MRGAhToSvcSv(2,3,3), MRPZAhToSvcSv(2,3,3),MRGZAhToSvcSv(2,3,3) 
Real(dp) :: MVPAhToSvcSv(2,3,3) 
Real(dp) :: RMsqTreeAhToSvcSv(2,3,3),RMsqWaveAhToSvcSv(2,3,3),RMsqVertexAhToSvcSv(2,3,3) 
Complex(dp) :: AmpTreeAhToSvcSv(2,3,3),AmpWaveAhToSvcSv(2,3,3),AmpVertexAhToSvcSv(2,3,3)& 
 & ,AmpVertexIRosAhToSvcSv(2,3,3),AmpVertexIRdrAhToSvcSv(2,3,3), AmpSumAhToSvcSv(2,3,3), AmpSum2AhToSvcSv(2,3,3) 
Complex(dp) :: AmpTreeZAhToSvcSv(2,3,3),AmpWaveZAhToSvcSv(2,3,3),AmpVertexZAhToSvcSv(2,3,3) 
Real(dp) :: AmpSqAhToSvcSv(2,3,3),  AmpSqTreeAhToSvcSv(2,3,3) 
Real(dp) :: MRPAhToVGVG(2),MRGAhToVGVG(2), MRPZAhToVGVG(2),MRGZAhToVGVG(2) 
Real(dp) :: MVPAhToVGVG(2) 
Real(dp) :: RMsqTreeAhToVGVG(2),RMsqWaveAhToVGVG(2),RMsqVertexAhToVGVG(2) 
Complex(dp) :: AmpTreeAhToVGVG(2,2),AmpWaveAhToVGVG(2,2),AmpVertexAhToVGVG(2,2)& 
 & ,AmpVertexIRosAhToVGVG(2,2),AmpVertexIRdrAhToVGVG(2,2), AmpSumAhToVGVG(2,2), AmpSum2AhToVGVG(2,2) 
Complex(dp) :: AmpTreeZAhToVGVG(2,2),AmpWaveZAhToVGVG(2,2),AmpVertexZAhToVGVG(2,2) 
Real(dp) :: AmpSqAhToVGVG(2),  AmpSqTreeAhToVGVG(2) 
Real(dp) :: MRPAhToVPVP(2),MRGAhToVPVP(2), MRPZAhToVPVP(2),MRGZAhToVPVP(2) 
Real(dp) :: MVPAhToVPVP(2) 
Real(dp) :: RMsqTreeAhToVPVP(2),RMsqWaveAhToVPVP(2),RMsqVertexAhToVPVP(2) 
Complex(dp) :: AmpTreeAhToVPVP(2,2),AmpWaveAhToVPVP(2,2),AmpVertexAhToVPVP(2,2)& 
 & ,AmpVertexIRosAhToVPVP(2,2),AmpVertexIRdrAhToVPVP(2,2), AmpSumAhToVPVP(2,2), AmpSum2AhToVPVP(2,2) 
Complex(dp) :: AmpTreeZAhToVPVP(2,2),AmpWaveZAhToVPVP(2,2),AmpVertexZAhToVPVP(2,2) 
Real(dp) :: AmpSqAhToVPVP(2),  AmpSqTreeAhToVPVP(2) 
Real(dp) :: MRPAhToVPVZ(2),MRGAhToVPVZ(2), MRPZAhToVPVZ(2),MRGZAhToVPVZ(2) 
Real(dp) :: MVPAhToVPVZ(2) 
Real(dp) :: RMsqTreeAhToVPVZ(2),RMsqWaveAhToVPVZ(2),RMsqVertexAhToVPVZ(2) 
Complex(dp) :: AmpTreeAhToVPVZ(2,2),AmpWaveAhToVPVZ(2,2),AmpVertexAhToVPVZ(2,2)& 
 & ,AmpVertexIRosAhToVPVZ(2,2),AmpVertexIRdrAhToVPVZ(2,2), AmpSumAhToVPVZ(2,2), AmpSum2AhToVPVZ(2,2) 
Complex(dp) :: AmpTreeZAhToVPVZ(2,2),AmpWaveZAhToVPVZ(2,2),AmpVertexZAhToVPVZ(2,2) 
Real(dp) :: AmpSqAhToVPVZ(2),  AmpSqTreeAhToVPVZ(2) 
Real(dp) :: MRPAhToVWmcVWm(2),MRGAhToVWmcVWm(2), MRPZAhToVWmcVWm(2),MRGZAhToVWmcVWm(2) 
Real(dp) :: MVPAhToVWmcVWm(2) 
Real(dp) :: RMsqTreeAhToVWmcVWm(2),RMsqWaveAhToVWmcVWm(2),RMsqVertexAhToVWmcVWm(2) 
Complex(dp) :: AmpTreeAhToVWmcVWm(2,2),AmpWaveAhToVWmcVWm(2,2),AmpVertexAhToVWmcVWm(2,2)& 
 & ,AmpVertexIRosAhToVWmcVWm(2,2),AmpVertexIRdrAhToVWmcVWm(2,2), AmpSumAhToVWmcVWm(2,2), AmpSum2AhToVWmcVWm(2,2) 
Complex(dp) :: AmpTreeZAhToVWmcVWm(2,2),AmpWaveZAhToVWmcVWm(2,2),AmpVertexZAhToVWmcVWm(2,2) 
Real(dp) :: AmpSqAhToVWmcVWm(2),  AmpSqTreeAhToVWmcVWm(2) 
Real(dp) :: MRPAhToVZVZ(2),MRGAhToVZVZ(2), MRPZAhToVZVZ(2),MRGZAhToVZVZ(2) 
Real(dp) :: MVPAhToVZVZ(2) 
Real(dp) :: RMsqTreeAhToVZVZ(2),RMsqWaveAhToVZVZ(2),RMsqVertexAhToVZVZ(2) 
Complex(dp) :: AmpTreeAhToVZVZ(2,2),AmpWaveAhToVZVZ(2,2),AmpVertexAhToVZVZ(2,2)& 
 & ,AmpVertexIRosAhToVZVZ(2,2),AmpVertexIRdrAhToVZVZ(2,2), AmpSumAhToVZVZ(2,2), AmpSum2AhToVZVZ(2,2) 
Complex(dp) :: AmpTreeZAhToVZVZ(2,2),AmpWaveZAhToVZVZ(2,2),AmpVertexZAhToVZVZ(2,2) 
Real(dp) :: AmpSqAhToVZVZ(2),  AmpSqTreeAhToVZVZ(2) 
Write(*,*) "Calculating one-loop decays of Ah " 
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
isave = 3

If (.not.CalcLoopDecay_LoopInducedOnly) Then 
!---------------- 
! hh Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_AhTohhAh(cplAhAhhh,MAh,Mhh,MAh2,Mhh2,AmpTreeAhTohhAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTohhAh(ZcplAhAhhh,MAh,Mhh,MAh2,Mhh2,AmpTreeAhTohhAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTohhAh(MLambda,em,gs,cplAhAhhh,MAhOS,MhhOS,              & 
& MRPAhTohhAh,MRGAhTohhAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTohhAh(MLambda,em,gs,ZcplAhAhhh,MAhOS,MhhOS,             & 
& MRPAhTohhAh,MRGAhTohhAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTohhAh(MLambda,em,gs,cplAhAhhh,MAh,Mhh,MRPAhTohhAh,      & 
& MRGAhTohhAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTohhAh(MLambda,em,gs,ZcplAhAhhh,MAh,Mhh,MRPAhTohhAh,     & 
& MRGAhTohhAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhAh(cplAhAhhh,ctcplAhAhhh,MAh,MAh2,               & 
& Mhh,Mhh2,ZfAh,Zfhh,AmpWaveAhTohhAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhAh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
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
& AmpVertexAhTohhAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexIRdrAhTohhAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,AmpVertexIRosAhTohhAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexIRosAhTohhAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,AmpVertexIRosAhTohhAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexIRosAhTohhAh)

 End if 
 End if 
AmpVertexAhTohhAh = AmpVertexAhTohhAh -  AmpVertexIRdrAhTohhAh! +  AmpVertexIRosAhTohhAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTohhAh=0._dp 
AmpVertexZAhTohhAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTohhAh(gt2,:,:) = AmpWaveZAhTohhAh(gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTohhAh(gt1,:,:) 
AmpVertexZAhTohhAh(gt2,:,:)= AmpVertexZAhTohhAh(gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTohhAh(gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTohhAh=AmpWaveZAhTohhAh 
AmpVertexAhTohhAh= AmpVertexZAhTohhAh
! Final State 1 
AmpWaveZAhTohhAh=0._dp 
AmpVertexZAhTohhAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTohhAh(:,gt2,:) = AmpWaveZAhTohhAh(:,gt2,:)+ZRUZH(gt2,gt1)*AmpWaveAhTohhAh(:,gt1,:) 
AmpVertexZAhTohhAh(:,gt2,:)= AmpVertexZAhTohhAh(:,gt2,:)+ZRUZH(gt2,gt1)*AmpVertexAhTohhAh(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTohhAh=AmpWaveZAhTohhAh 
AmpVertexAhTohhAh= AmpVertexZAhTohhAh
! Final State 2 
AmpWaveZAhTohhAh=0._dp 
AmpVertexZAhTohhAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTohhAh(:,:,gt2) = AmpWaveZAhTohhAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveAhTohhAh(:,:,gt1) 
AmpVertexZAhTohhAh(:,:,gt2)= AmpVertexZAhTohhAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexAhTohhAh(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTohhAh=AmpWaveZAhTohhAh 
AmpVertexAhTohhAh= AmpVertexZAhTohhAh
End if
If (ShiftIRdiv) Then 
AmpVertexAhTohhAh = AmpVertexAhTohhAh  +  AmpVertexIRosAhTohhAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->hh Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTohhAh = AmpTreeAhTohhAh 
 AmpSum2AhTohhAh = AmpTreeAhTohhAh + 2._dp*AmpWaveAhTohhAh + 2._dp*AmpVertexAhTohhAh  
Else 
 AmpSumAhTohhAh = AmpTreeAhTohhAh + AmpWaveAhTohhAh + AmpVertexAhTohhAh
 AmpSum2AhTohhAh = AmpTreeAhTohhAh + AmpWaveAhTohhAh + AmpVertexAhTohhAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTohhAh = AmpTreeAhTohhAh
 AmpSum2AhTohhAh = AmpTreeAhTohhAh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MhhOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(Mhh(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTohhAh = AmpTreeAhTohhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MAh(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTohhAh(gt1, gt2, gt3) 
  AmpSum2AhTohhAh = 2._dp*AmpWaveAhTohhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MAh(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTohhAh(gt1, gt2, gt3) 
  AmpSum2AhTohhAh = 2._dp*AmpVertexAhTohhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MAh(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTohhAh(gt1, gt2, gt3) 
  AmpSum2AhTohhAh = AmpTreeAhTohhAh + 2._dp*AmpWaveAhTohhAh + 2._dp*AmpVertexAhTohhAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MAh(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTohhAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTohhAh = AmpTreeAhTohhAh
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
  AmpSqTreeAhTohhAh(gt1, gt2, gt3) = (1)*AmpSqAhTohhAh(gt1, gt2, gt3)  
  AmpSum2AhTohhAh = + 2._dp*AmpWaveAhTohhAh + 2._dp*AmpVertexAhTohhAh
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
  AmpSqAhTohhAh(gt1, gt2, gt3) = AmpSqAhTohhAh(gt1, gt2, gt3) + AmpSqTreeAhTohhAh(gt1, gt2, gt3)  
Else  
  AmpSum2AhTohhAh = AmpTreeAhTohhAh
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MAh(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
  AmpSqTreeAhTohhAh(gt1, gt2, gt3) = (1)*AmpSqAhTohhAh(gt1, gt2, gt3)  
  AmpSum2AhTohhAh = + 2._dp*AmpWaveAhTohhAh + 2._dp*AmpVertexAhTohhAh
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MAh(gt3),AmpSumAhTohhAh(gt1, gt2, gt3),AmpSum2AhTohhAh(gt1, gt2, gt3),AmpSqAhTohhAh(gt1, gt2, gt3)) 
  AmpSqAhTohhAh(gt1, gt2, gt3) = AmpSqAhTohhAh(gt1, gt2, gt3) + AmpSqTreeAhTohhAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTohhAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTohhAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MhhOS(gt2),MAhOS(gt3),helfactor*AmpSqAhTohhAh(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),Mhh(gt2),MAh(gt3),helfactor*AmpSqAhTohhAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTohhAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTohhAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTohhAh(gt1, gt2, gt3) + MRGAhTohhAh(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTohhAh(gt1, gt2, gt3) + MRGAhTohhAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
! bar(Cha) Cha
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_AhTocChaCha(cplcChaChaAhL,cplcChaChaAhR,               & 
& MAh,MCha,MAh2,MCha2,AmpTreeAhTocChaCha)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocChaCha(ZcplcChaChaAhL,ZcplcChaChaAhR,             & 
& MAh,MCha,MAh2,MCha2,AmpTreeAhTocChaCha)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocChaCha(MLambda,em,gs,cplcChaChaAhL,cplcChaChaAhR,     & 
& MAhOS,MChaOS,MRPAhTocChaCha,MRGAhTocChaCha)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocChaCha(MLambda,em,gs,ZcplcChaChaAhL,ZcplcChaChaAhR,   & 
& MAhOS,MChaOS,MRPAhTocChaCha,MRGAhTocChaCha)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocChaCha(MLambda,em,gs,cplcChaChaAhL,cplcChaChaAhR,     & 
& MAh,MCha,MRPAhTocChaCha,MRGAhTocChaCha)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocChaCha(MLambda,em,gs,ZcplcChaChaAhL,ZcplcChaChaAhR,   & 
& MAh,MCha,MRPAhTocChaCha,MRGAhTocChaCha)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocChaCha(cplcChaChaAhL,cplcChaChaAhR,               & 
& ctcplcChaChaAhL,ctcplcChaChaAhR,MAh,MAh2,MCha,MCha2,ZfAh,ZfLm,ZfLp,AmpWaveAhTocChaCha)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexAhTocChaCha)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRdrAhTocChaCha)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,ZcplcChaChaAhL,ZcplcChaChaAhR,cplChiChiAhL,       & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosAhTocChaCha)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,ZcplcChaChaAhL,ZcplcChaChaAhR,     & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosAhTocChaCha)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosAhTocChaCha)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosAhTocChaCha)

 End if 
 End if 
AmpVertexAhTocChaCha = AmpVertexAhTocChaCha -  AmpVertexIRdrAhTocChaCha! +  AmpVertexIRosAhTocChaCha ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocChaCha=0._dp 
AmpVertexZAhTocChaCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocChaCha(:,gt2,:,:) = AmpWaveZAhTocChaCha(:,gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocChaCha(:,gt1,:,:) 
AmpVertexZAhTocChaCha(:,gt2,:,:)= AmpVertexZAhTocChaCha(:,gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocChaCha(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocChaCha=AmpWaveZAhTocChaCha 
AmpVertexAhTocChaCha= AmpVertexZAhTocChaCha
! Final State 1 
AmpWaveZAhTocChaCha=0._dp 
AmpVertexZAhTocChaCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocChaCha(1,:,gt2,:) = AmpWaveZAhTocChaCha(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveAhTocChaCha(1,:,gt1,:) 
AmpVertexZAhTocChaCha(1,:,gt2,:)= AmpVertexZAhTocChaCha(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpVertexAhTocChaCha(1,:,gt1,:) 
AmpWaveZAhTocChaCha(2,:,gt2,:) = AmpWaveZAhTocChaCha(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveAhTocChaCha(2,:,gt1,:) 
AmpVertexZAhTocChaCha(2,:,gt2,:)= AmpVertexZAhTocChaCha(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpVertexAhTocChaCha(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocChaCha=AmpWaveZAhTocChaCha 
AmpVertexAhTocChaCha= AmpVertexZAhTocChaCha
! Final State 2 
AmpWaveZAhTocChaCha=0._dp 
AmpVertexZAhTocChaCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocChaCha(1,:,:,gt2) = AmpWaveZAhTocChaCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpWaveAhTocChaCha(1,:,:,gt1) 
AmpVertexZAhTocChaCha(1,:,:,gt2)= AmpVertexZAhTocChaCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexAhTocChaCha(1,:,:,gt1) 
AmpWaveZAhTocChaCha(2,:,:,gt2) = AmpWaveZAhTocChaCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpWaveAhTocChaCha(2,:,:,gt1) 
AmpVertexZAhTocChaCha(2,:,:,gt2)= AmpVertexZAhTocChaCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpVertexAhTocChaCha(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocChaCha=AmpWaveZAhTocChaCha 
AmpVertexAhTocChaCha= AmpVertexZAhTocChaCha
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocChaCha = AmpVertexAhTocChaCha  +  AmpVertexIRosAhTocChaCha
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->bar[Cha] Cha -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocChaCha = AmpTreeAhTocChaCha 
 AmpSum2AhTocChaCha = AmpTreeAhTocChaCha + 2._dp*AmpWaveAhTocChaCha + 2._dp*AmpVertexAhTocChaCha  
Else 
 AmpSumAhTocChaCha = AmpTreeAhTocChaCha + AmpWaveAhTocChaCha + AmpVertexAhTocChaCha
 AmpSum2AhTocChaCha = AmpTreeAhTocChaCha + AmpWaveAhTocChaCha + AmpVertexAhTocChaCha 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocChaCha = AmpTreeAhTocChaCha
 AmpSum2AhTocChaCha = AmpTreeAhTocChaCha 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MChaOS(gt2)+MChaOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MCha(gt2)+MCha(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocChaCha = AmpTreeAhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MCha(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocChaCha(gt1, gt2, gt3) 
  AmpSum2AhTocChaCha = 2._dp*AmpWaveAhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MCha(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocChaCha(gt1, gt2, gt3) 
  AmpSum2AhTocChaCha = 2._dp*AmpVertexAhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MCha(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocChaCha(gt1, gt2, gt3) 
  AmpSum2AhTocChaCha = AmpTreeAhTocChaCha + 2._dp*AmpWaveAhTocChaCha + 2._dp*AmpVertexAhTocChaCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MCha(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocChaCha(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocChaCha = AmpTreeAhTocChaCha
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
  AmpSqTreeAhTocChaCha(gt1, gt2, gt3) = (1)*AmpSqAhTocChaCha(gt1, gt2, gt3)  
  AmpSum2AhTocChaCha = + 2._dp*AmpWaveAhTocChaCha + 2._dp*AmpVertexAhTocChaCha
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
  AmpSqAhTocChaCha(gt1, gt2, gt3) = AmpSqAhTocChaCha(gt1, gt2, gt3) + AmpSqTreeAhTocChaCha(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocChaCha = AmpTreeAhTocChaCha
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MCha(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
  AmpSqTreeAhTocChaCha(gt1, gt2, gt3) = (1)*AmpSqAhTocChaCha(gt1, gt2, gt3)  
  AmpSum2AhTocChaCha = + 2._dp*AmpWaveAhTocChaCha + 2._dp*AmpVertexAhTocChaCha
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MCha(gt3),AmpSumAhTocChaCha(:,gt1, gt2, gt3),AmpSum2AhTocChaCha(:,gt1, gt2, gt3),AmpSqAhTocChaCha(gt1, gt2, gt3)) 
  AmpSqAhTocChaCha(gt1, gt2, gt3) = AmpSqAhTocChaCha(gt1, gt2, gt3) + AmpSqTreeAhTocChaCha(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocChaCha(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhTocChaCha(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MChaOS(gt2),MChaOS(gt3),helfactor*AmpSqAhTocChaCha(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MCha(gt2),MCha(gt3),helfactor*AmpSqAhTocChaCha(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocChaCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocChaCha(gt1, gt2, gt3) + MRGAhTocChaCha(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocChaCha(gt1, gt2, gt3) + MRGAhTocChaCha(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhToChiChi(cplChiChiAhL,cplChiChiAhR,MAh,              & 
& MChi,MAh2,MChi2,AmpTreeAhToChiChi)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhToChiChi(ZcplChiChiAhL,ZcplChiChiAhR,MAh,            & 
& MChi,MAh2,MChi2,AmpTreeAhToChiChi)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhToChiChi(MLambda,em,gs,cplChiChiAhL,cplChiChiAhR,        & 
& MAhOS,MChiOS,MRPAhToChiChi,MRGAhToChiChi)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhToChiChi(MLambda,em,gs,ZcplChiChiAhL,ZcplChiChiAhR,      & 
& MAhOS,MChiOS,MRPAhToChiChi,MRGAhToChiChi)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhToChiChi(MLambda,em,gs,cplChiChiAhL,cplChiChiAhR,        & 
& MAh,MChi,MRPAhToChiChi,MRGAhToChiChi)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhToChiChi(MLambda,em,gs,ZcplChiChiAhL,ZcplChiChiAhR,      & 
& MAh,MChi,MRPAhToChiChi,MRGAhToChiChi)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToChiChi(cplChiChiAhL,cplChiChiAhR,ctcplChiChiAhL,   & 
& ctcplChiChiAhR,MAh,MAh2,MChi,MChi2,ZfAh,ZfL0,AmpWaveAhToChiChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,             & 
& MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,               & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,AmpVertexAhToChiChi)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,          & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,AmpVertexIRdrAhToChiChi)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,        & 
& MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,               & 
& cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,ZcplChiChiAhL,ZcplChiChiAhR,cplcFdFdAhL,         & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,    & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,   & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,AmpVertexIRosAhToChiChi)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,ZcplChiChiAhL,         & 
& ZcplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,AmpVertexIRosAhToChiChi)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,        & 
& MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,               & 
& cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,           & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,    & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,   & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,AmpVertexIRosAhToChiChi)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,          & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,AmpVertexIRosAhToChiChi)

 End if 
 End if 
AmpVertexAhToChiChi = AmpVertexAhToChiChi -  AmpVertexIRdrAhToChiChi! +  AmpVertexIRosAhToChiChi ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhToChiChi=0._dp 
AmpVertexZAhToChiChi=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhToChiChi(:,gt2,:,:) = AmpWaveZAhToChiChi(:,gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhToChiChi(:,gt1,:,:) 
AmpVertexZAhToChiChi(:,gt2,:,:)= AmpVertexZAhToChiChi(:,gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhToChiChi(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveAhToChiChi=AmpWaveZAhToChiChi 
AmpVertexAhToChiChi= AmpVertexZAhToChiChi
! Final State 1 
AmpWaveZAhToChiChi=0._dp 
AmpVertexZAhToChiChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZAhToChiChi(1,:,gt2,:) = AmpWaveZAhToChiChi(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpWaveAhToChiChi(1,:,gt1,:) 
AmpVertexZAhToChiChi(1,:,gt2,:)= AmpVertexZAhToChiChi(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpVertexAhToChiChi(1,:,gt1,:) 
AmpWaveZAhToChiChi(2,:,gt2,:) = AmpWaveZAhToChiChi(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpWaveAhToChiChi(2,:,gt1,:) 
AmpVertexZAhToChiChi(2,:,gt2,:)= AmpVertexZAhToChiChi(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpVertexAhToChiChi(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveAhToChiChi=AmpWaveZAhToChiChi 
AmpVertexAhToChiChi= AmpVertexZAhToChiChi
! Final State 2 
AmpWaveZAhToChiChi=0._dp 
AmpVertexZAhToChiChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZAhToChiChi(1,:,:,gt2) = AmpWaveZAhToChiChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveAhToChiChi(1,:,:,gt1) 
AmpVertexZAhToChiChi(1,:,:,gt2)= AmpVertexZAhToChiChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexAhToChiChi(1,:,:,gt1) 
AmpWaveZAhToChiChi(2,:,:,gt2) = AmpWaveZAhToChiChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveAhToChiChi(2,:,:,gt1) 
AmpVertexZAhToChiChi(2,:,:,gt2)= AmpVertexZAhToChiChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexAhToChiChi(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveAhToChiChi=AmpWaveZAhToChiChi 
AmpVertexAhToChiChi= AmpVertexZAhToChiChi
End if
If (ShiftIRdiv) Then 
AmpVertexAhToChiChi = AmpVertexAhToChiChi  +  AmpVertexIRosAhToChiChi
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Chi Chi -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhToChiChi = AmpTreeAhToChiChi 
 AmpSum2AhToChiChi = AmpTreeAhToChiChi + 2._dp*AmpWaveAhToChiChi + 2._dp*AmpVertexAhToChiChi  
Else 
 AmpSumAhToChiChi = AmpTreeAhToChiChi + AmpWaveAhToChiChi + AmpVertexAhToChiChi
 AmpSum2AhToChiChi = AmpTreeAhToChiChi + AmpWaveAhToChiChi + AmpVertexAhToChiChi 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToChiChi = AmpTreeAhToChiChi
 AmpSum2AhToChiChi = AmpTreeAhToChiChi 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=gt2,4
If (((OSkinematics).and.(MAhOS(gt1).gt.(MChiOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MChi(gt2)+MChi(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhToChiChi = AmpTreeAhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),MChi(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhToChiChi(gt1, gt2, gt3) 
  AmpSum2AhToChiChi = 2._dp*AmpWaveAhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),MChi(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhToChiChi(gt1, gt2, gt3) 
  AmpSum2AhToChiChi = 2._dp*AmpVertexAhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),MChi(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhToChiChi(gt1, gt2, gt3) 
  AmpSum2AhToChiChi = AmpTreeAhToChiChi + 2._dp*AmpWaveAhToChiChi + 2._dp*AmpVertexAhToChiChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),MChi(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhToChiChi(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhToChiChi = AmpTreeAhToChiChi
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
  AmpSqTreeAhToChiChi(gt1, gt2, gt3) = (1)*AmpSqAhToChiChi(gt1, gt2, gt3)  
  AmpSum2AhToChiChi = + 2._dp*AmpWaveAhToChiChi + 2._dp*AmpVertexAhToChiChi
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
  AmpSqAhToChiChi(gt1, gt2, gt3) = AmpSqAhToChiChi(gt1, gt2, gt3) + AmpSqTreeAhToChiChi(gt1, gt2, gt3)  
Else  
  AmpSum2AhToChiChi = AmpTreeAhToChiChi
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),MChi(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
  AmpSqTreeAhToChiChi(gt1, gt2, gt3) = (1)*AmpSqAhToChiChi(gt1, gt2, gt3)  
  AmpSum2AhToChiChi = + 2._dp*AmpWaveAhToChiChi + 2._dp*AmpVertexAhToChiChi
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),MChi(gt3),AmpSumAhToChiChi(:,gt1, gt2, gt3),AmpSum2AhToChiChi(:,gt1, gt2, gt3),AmpSqAhToChiChi(gt1, gt2, gt3)) 
  AmpSqAhToChiChi(gt1, gt2, gt3) = AmpSqAhToChiChi(gt1, gt2, gt3) + AmpSqTreeAhToChiChi(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhToChiChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqAhToChiChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAhOS(gt1),MChiOS(gt2),MChiOS(gt3),helfactor*AmpSqAhToChiChi(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAh(gt1),MChi(gt2),MChi(gt3),helfactor*AmpSqAhToChiChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/4._dp*helfactor*(MRPAhToChiChi(gt1, gt2, gt3) + MRGAhToChiChi(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/4._dp*helfactor*(MRPAhToChiChi(gt1, gt2, gt3) + MRGAhToChiChi(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhTocFdFd(cplcFdFdAhL,cplcFdFdAhR,MAh,MFd,             & 
& MAh2,MFd2,AmpTreeAhTocFdFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocFdFd(ZcplcFdFdAhL,ZcplcFdFdAhR,MAh,               & 
& MFd,MAh2,MFd2,AmpTreeAhTocFdFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFdFd(MLambda,em,gs,cplcFdFdAhL,cplcFdFdAhR,           & 
& MAhOS,MFdOS,MRPAhTocFdFd,MRGAhTocFdFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFdFd(MLambda,em,gs,ZcplcFdFdAhL,ZcplcFdFdAhR,         & 
& MAhOS,MFdOS,MRPAhTocFdFd,MRGAhTocFdFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocFdFd(MLambda,em,gs,cplcFdFdAhL,cplcFdFdAhR,           & 
& MAh,MFd,MRPAhTocFdFd,MRGAhTocFdFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFdFd(MLambda,em,gs,ZcplcFdFdAhL,ZcplcFdFdAhR,         & 
& MAh,MFd,MRPAhTocFdFd,MRGAhTocFdFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocFdFd(cplcFdFdAhL,cplcFdFdAhR,ctcplcFdFdAhL,       & 
& ctcplcFdFdAhR,MAh,MAh2,MFd,MFd2,ZfAh,ZfFDL,ZfFDR,AmpWaveAhTocFdFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& AmpVertexAhTocFdFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& AmpVertexIRdrAhTocFdFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,   & 
& cplChiChiAhL,cplChiChiAhR,ZcplcFdFdAhL,ZcplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,               & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,AmpVertexIRosAhTocFdFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,ZcplcFdFdAhL,ZcplcFdFdAhR,       & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& AmpVertexIRosAhTocFdFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,   & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,               & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,AmpVertexIRosAhTocFdFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& AmpVertexIRosAhTocFdFd)

 End if 
 End if 
AmpVertexAhTocFdFd = AmpVertexAhTocFdFd -  AmpVertexIRdrAhTocFdFd! +  AmpVertexIRosAhTocFdFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocFdFd=0._dp 
AmpVertexZAhTocFdFd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocFdFd(:,gt2,:,:) = AmpWaveZAhTocFdFd(:,gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocFdFd(:,gt1,:,:) 
AmpVertexZAhTocFdFd(:,gt2,:,:)= AmpVertexZAhTocFdFd(:,gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocFdFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocFdFd=AmpWaveZAhTocFdFd 
AmpVertexAhTocFdFd= AmpVertexZAhTocFdFd
! Final State 1 
AmpWaveZAhTocFdFd=0._dp 
AmpVertexZAhTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZAhTocFdFd(1,:,gt2,:) = AmpWaveZAhTocFdFd(1,:,gt2,:)+ZRUZDR(gt2,gt1)*AmpWaveAhTocFdFd(1,:,gt1,:) 
AmpVertexZAhTocFdFd(1,:,gt2,:)= AmpVertexZAhTocFdFd(1,:,gt2,:)+ZRUZDR(gt2,gt1)*AmpVertexAhTocFdFd(1,:,gt1,:) 
AmpWaveZAhTocFdFd(2,:,gt2,:) = AmpWaveZAhTocFdFd(2,:,gt2,:)+ZRUZDLc(gt2,gt1)*AmpWaveAhTocFdFd(2,:,gt1,:) 
AmpVertexZAhTocFdFd(2,:,gt2,:)= AmpVertexZAhTocFdFd(2,:,gt2,:)+ZRUZDLc(gt2,gt1)*AmpVertexAhTocFdFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocFdFd=AmpWaveZAhTocFdFd 
AmpVertexAhTocFdFd= AmpVertexZAhTocFdFd
! Final State 2 
AmpWaveZAhTocFdFd=0._dp 
AmpVertexZAhTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZAhTocFdFd(1,:,:,gt2) = AmpWaveZAhTocFdFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveAhTocFdFd(1,:,:,gt1) 
AmpVertexZAhTocFdFd(1,:,:,gt2)= AmpVertexZAhTocFdFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexAhTocFdFd(1,:,:,gt1) 
AmpWaveZAhTocFdFd(2,:,:,gt2) = AmpWaveZAhTocFdFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveAhTocFdFd(2,:,:,gt1) 
AmpVertexZAhTocFdFd(2,:,:,gt2)= AmpVertexZAhTocFdFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexAhTocFdFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocFdFd=AmpWaveZAhTocFdFd 
AmpVertexAhTocFdFd= AmpVertexZAhTocFdFd
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocFdFd = AmpVertexAhTocFdFd  +  AmpVertexIRosAhTocFdFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->bar[Fd] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocFdFd = AmpTreeAhTocFdFd 
 AmpSum2AhTocFdFd = AmpTreeAhTocFdFd + 2._dp*AmpWaveAhTocFdFd + 2._dp*AmpVertexAhTocFdFd  
Else 
 AmpSumAhTocFdFd = AmpTreeAhTocFdFd + AmpWaveAhTocFdFd + AmpVertexAhTocFdFd
 AmpSum2AhTocFdFd = AmpTreeAhTocFdFd + AmpWaveAhTocFdFd + AmpVertexAhTocFdFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocFdFd = AmpTreeAhTocFdFd
 AmpSum2AhTocFdFd = AmpTreeAhTocFdFd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MFdOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MFd(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocFdFd = AmpTreeAhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFd(gt2),MFd(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocFdFd(gt1, gt2, gt3) 
  AmpSum2AhTocFdFd = 2._dp*AmpWaveAhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFd(gt2),MFd(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocFdFd(gt1, gt2, gt3) 
  AmpSum2AhTocFdFd = 2._dp*AmpVertexAhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFd(gt2),MFd(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocFdFd(gt1, gt2, gt3) 
  AmpSum2AhTocFdFd = AmpTreeAhTocFdFd + 2._dp*AmpWaveAhTocFdFd + 2._dp*AmpVertexAhTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFd(gt2),MFd(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocFdFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocFdFd = AmpTreeAhTocFdFd
  Call SquareAmp_StoFF(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
  AmpSqTreeAhTocFdFd(gt1, gt2, gt3) = (3)*AmpSqAhTocFdFd(gt1, gt2, gt3)  
  AmpSum2AhTocFdFd = + 2._dp*AmpWaveAhTocFdFd + 2._dp*AmpVertexAhTocFdFd
  Call SquareAmp_StoFF(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
  AmpSqAhTocFdFd(gt1, gt2, gt3) = AmpSqAhTocFdFd(gt1, gt2, gt3) + AmpSqTreeAhTocFdFd(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocFdFd = AmpTreeAhTocFdFd
  Call SquareAmp_StoFF(MAh(gt1),MFd(gt2),MFd(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
  AmpSqTreeAhTocFdFd(gt1, gt2, gt3) = (3)*AmpSqAhTocFdFd(gt1, gt2, gt3)  
  AmpSum2AhTocFdFd = + 2._dp*AmpWaveAhTocFdFd + 2._dp*AmpVertexAhTocFdFd
  Call SquareAmp_StoFF(MAh(gt1),MFd(gt2),MFd(gt3),AmpSumAhTocFdFd(:,gt1, gt2, gt3),AmpSum2AhTocFdFd(:,gt1, gt2, gt3),AmpSqAhTocFdFd(gt1, gt2, gt3)) 
  AmpSqAhTocFdFd(gt1, gt2, gt3) = AmpSqAhTocFdFd(gt1, gt2, gt3) + AmpSqTreeAhTocFdFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocFdFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhTocFdFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MFdOS(gt2),MFdOS(gt3),helfactor*AmpSqAhTocFdFd(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MFd(gt2),MFd(gt3),helfactor*AmpSqAhTocFdFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocFdFd(gt1, gt2, gt3) + MRGAhTocFdFd(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocFdFd(gt1, gt2, gt3) + MRGAhTocFdFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhTocFeFe(cplcFeFeAhL,cplcFeFeAhR,MAh,MFe,             & 
& MAh2,MFe2,AmpTreeAhTocFeFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocFeFe(ZcplcFeFeAhL,ZcplcFeFeAhR,MAh,               & 
& MFe,MAh2,MFe2,AmpTreeAhTocFeFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFeFe(MLambda,em,gs,cplcFeFeAhL,cplcFeFeAhR,           & 
& MAhOS,MFeOS,MRPAhTocFeFe,MRGAhTocFeFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFeFe(MLambda,em,gs,ZcplcFeFeAhL,ZcplcFeFeAhR,         & 
& MAhOS,MFeOS,MRPAhTocFeFe,MRGAhTocFeFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocFeFe(MLambda,em,gs,cplcFeFeAhL,cplcFeFeAhR,           & 
& MAh,MFe,MRPAhTocFeFe,MRGAhTocFeFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFeFe(MLambda,em,gs,ZcplcFeFeAhL,ZcplcFeFeAhR,         & 
& MAh,MFe,MRPAhTocFeFe,MRGAhTocFeFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocFeFe(cplcFeFeAhL,cplcFeFeAhR,ctcplcFeFeAhL,       & 
& ctcplcFeFeAhR,MAh,MAh2,MFe,MFe2,ZfAh,ZfFEL,ZfFER,AmpWaveAhTocFeFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexAhTocFeFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRdrAhTocFeFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,ZcplcFeFeAhL,ZcplcFeFeAhR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,           & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,           & 
& cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosAhTocFeFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,ZcplcFeFeAhL,ZcplcFeFeAhR,           & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosAhTocFeFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,           & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,           & 
& cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosAhTocFeFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosAhTocFeFe)

 End if 
 End if 
AmpVertexAhTocFeFe = AmpVertexAhTocFeFe -  AmpVertexIRdrAhTocFeFe! +  AmpVertexIRosAhTocFeFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocFeFe=0._dp 
AmpVertexZAhTocFeFe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocFeFe(:,gt2,:,:) = AmpWaveZAhTocFeFe(:,gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocFeFe(:,gt1,:,:) 
AmpVertexZAhTocFeFe(:,gt2,:,:)= AmpVertexZAhTocFeFe(:,gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocFeFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocFeFe=AmpWaveZAhTocFeFe 
AmpVertexAhTocFeFe= AmpVertexZAhTocFeFe
! Final State 1 
AmpWaveZAhTocFeFe=0._dp 
AmpVertexZAhTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZAhTocFeFe(1,:,gt2,:) = AmpWaveZAhTocFeFe(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpWaveAhTocFeFe(1,:,gt1,:) 
AmpVertexZAhTocFeFe(1,:,gt2,:)= AmpVertexZAhTocFeFe(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpVertexAhTocFeFe(1,:,gt1,:) 
AmpWaveZAhTocFeFe(2,:,gt2,:) = AmpWaveZAhTocFeFe(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpWaveAhTocFeFe(2,:,gt1,:) 
AmpVertexZAhTocFeFe(2,:,gt2,:)= AmpVertexZAhTocFeFe(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpVertexAhTocFeFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocFeFe=AmpWaveZAhTocFeFe 
AmpVertexAhTocFeFe= AmpVertexZAhTocFeFe
! Final State 2 
AmpWaveZAhTocFeFe=0._dp 
AmpVertexZAhTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZAhTocFeFe(1,:,:,gt2) = AmpWaveZAhTocFeFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWaveAhTocFeFe(1,:,:,gt1) 
AmpVertexZAhTocFeFe(1,:,:,gt2)= AmpVertexZAhTocFeFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexAhTocFeFe(1,:,:,gt1) 
AmpWaveZAhTocFeFe(2,:,:,gt2) = AmpWaveZAhTocFeFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWaveAhTocFeFe(2,:,:,gt1) 
AmpVertexZAhTocFeFe(2,:,:,gt2)= AmpVertexZAhTocFeFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexAhTocFeFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocFeFe=AmpWaveZAhTocFeFe 
AmpVertexAhTocFeFe= AmpVertexZAhTocFeFe
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocFeFe = AmpVertexAhTocFeFe  +  AmpVertexIRosAhTocFeFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->bar[Fe] Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocFeFe = AmpTreeAhTocFeFe 
 AmpSum2AhTocFeFe = AmpTreeAhTocFeFe + 2._dp*AmpWaveAhTocFeFe + 2._dp*AmpVertexAhTocFeFe  
Else 
 AmpSumAhTocFeFe = AmpTreeAhTocFeFe + AmpWaveAhTocFeFe + AmpVertexAhTocFeFe
 AmpSum2AhTocFeFe = AmpTreeAhTocFeFe + AmpWaveAhTocFeFe + AmpVertexAhTocFeFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocFeFe = AmpTreeAhTocFeFe
 AmpSum2AhTocFeFe = AmpTreeAhTocFeFe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MFeOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MFe(gt2)+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocFeFe = AmpTreeAhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFe(gt2),MFe(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocFeFe(gt1, gt2, gt3) 
  AmpSum2AhTocFeFe = 2._dp*AmpWaveAhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFe(gt2),MFe(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocFeFe(gt1, gt2, gt3) 
  AmpSum2AhTocFeFe = 2._dp*AmpVertexAhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFe(gt2),MFe(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocFeFe(gt1, gt2, gt3) 
  AmpSum2AhTocFeFe = AmpTreeAhTocFeFe + 2._dp*AmpWaveAhTocFeFe + 2._dp*AmpVertexAhTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFe(gt2),MFe(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocFeFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocFeFe = AmpTreeAhTocFeFe
  Call SquareAmp_StoFF(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
  AmpSqTreeAhTocFeFe(gt1, gt2, gt3) = (1)*AmpSqAhTocFeFe(gt1, gt2, gt3)  
  AmpSum2AhTocFeFe = + 2._dp*AmpWaveAhTocFeFe + 2._dp*AmpVertexAhTocFeFe
  Call SquareAmp_StoFF(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
  AmpSqAhTocFeFe(gt1, gt2, gt3) = AmpSqAhTocFeFe(gt1, gt2, gt3) + AmpSqTreeAhTocFeFe(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocFeFe = AmpTreeAhTocFeFe
  Call SquareAmp_StoFF(MAh(gt1),MFe(gt2),MFe(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
  AmpSqTreeAhTocFeFe(gt1, gt2, gt3) = (1)*AmpSqAhTocFeFe(gt1, gt2, gt3)  
  AmpSum2AhTocFeFe = + 2._dp*AmpWaveAhTocFeFe + 2._dp*AmpVertexAhTocFeFe
  Call SquareAmp_StoFF(MAh(gt1),MFe(gt2),MFe(gt3),AmpSumAhTocFeFe(:,gt1, gt2, gt3),AmpSum2AhTocFeFe(:,gt1, gt2, gt3),AmpSqAhTocFeFe(gt1, gt2, gt3)) 
  AmpSqAhTocFeFe(gt1, gt2, gt3) = AmpSqAhTocFeFe(gt1, gt2, gt3) + AmpSqTreeAhTocFeFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocFeFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhTocFeFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MFeOS(gt2),MFeOS(gt3),helfactor*AmpSqAhTocFeFe(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MFe(gt2),MFe(gt3),helfactor*AmpSqAhTocFeFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocFeFe(gt1, gt2, gt3) + MRGAhTocFeFe(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocFeFe(gt1, gt2, gt3) + MRGAhTocFeFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhTocFuFu(cplcFuFuAhL,cplcFuFuAhR,MAh,MFu,             & 
& MAh2,MFu2,AmpTreeAhTocFuFu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocFuFu(ZcplcFuFuAhL,ZcplcFuFuAhR,MAh,               & 
& MFu,MAh2,MFu2,AmpTreeAhTocFuFu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFuFu(MLambda,em,gs,cplcFuFuAhL,cplcFuFuAhR,           & 
& MAhOS,MFuOS,MRPAhTocFuFu,MRGAhTocFuFu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFuFu(MLambda,em,gs,ZcplcFuFuAhL,ZcplcFuFuAhR,         & 
& MAhOS,MFuOS,MRPAhTocFuFu,MRGAhTocFuFu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocFuFu(MLambda,em,gs,cplcFuFuAhL,cplcFuFuAhR,           & 
& MAh,MFu,MRPAhTocFuFu,MRGAhTocFuFu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocFuFu(MLambda,em,gs,ZcplcFuFuAhL,ZcplcFuFuAhR,         & 
& MAh,MFu,MRPAhTocFuFu,MRGAhTocFuFu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocFuFu(cplcFuFuAhL,cplcFuFuAhR,ctcplcFuFuAhL,       & 
& ctcplcFuFuAhR,MAh,MAh2,MFu,MFu2,ZfAh,ZfFUL,ZfFUR,AmpWaveAhTocFuFu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplcFecFuSdL,cplcFecFuSdR,AmpVertexAhTocFuFu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRdrAhTocFuFu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplcFecFuSdR,AmpVertexIRosAhTocFuFu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosAhTocFuFu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplcFecFuSdR,AmpVertexIRosAhTocFuFu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexIRosAhTocFuFu)

 End if 
 End if 
AmpVertexAhTocFuFu = AmpVertexAhTocFuFu -  AmpVertexIRdrAhTocFuFu! +  AmpVertexIRosAhTocFuFu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocFuFu=0._dp 
AmpVertexZAhTocFuFu=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocFuFu(:,gt2,:,:) = AmpWaveZAhTocFuFu(:,gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocFuFu(:,gt1,:,:) 
AmpVertexZAhTocFuFu(:,gt2,:,:)= AmpVertexZAhTocFuFu(:,gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocFuFu(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocFuFu=AmpWaveZAhTocFuFu 
AmpVertexAhTocFuFu= AmpVertexZAhTocFuFu
! Final State 1 
AmpWaveZAhTocFuFu=0._dp 
AmpVertexZAhTocFuFu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZAhTocFuFu(1,:,gt2,:) = AmpWaveZAhTocFuFu(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveAhTocFuFu(1,:,gt1,:) 
AmpVertexZAhTocFuFu(1,:,gt2,:)= AmpVertexZAhTocFuFu(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpVertexAhTocFuFu(1,:,gt1,:) 
AmpWaveZAhTocFuFu(2,:,gt2,:) = AmpWaveZAhTocFuFu(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveAhTocFuFu(2,:,gt1,:) 
AmpVertexZAhTocFuFu(2,:,gt2,:)= AmpVertexZAhTocFuFu(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpVertexAhTocFuFu(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocFuFu=AmpWaveZAhTocFuFu 
AmpVertexAhTocFuFu= AmpVertexZAhTocFuFu
! Final State 2 
AmpWaveZAhTocFuFu=0._dp 
AmpVertexZAhTocFuFu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZAhTocFuFu(1,:,:,gt2) = AmpWaveZAhTocFuFu(1,:,:,gt2)+ZRUZUL(gt2,gt1)*AmpWaveAhTocFuFu(1,:,:,gt1) 
AmpVertexZAhTocFuFu(1,:,:,gt2)= AmpVertexZAhTocFuFu(1,:,:,gt2)+ZRUZUL(gt2,gt1)*AmpVertexAhTocFuFu(1,:,:,gt1) 
AmpWaveZAhTocFuFu(2,:,:,gt2) = AmpWaveZAhTocFuFu(2,:,:,gt2)+ZRUZUR(gt2,gt1)*AmpWaveAhTocFuFu(2,:,:,gt1) 
AmpVertexZAhTocFuFu(2,:,:,gt2)= AmpVertexZAhTocFuFu(2,:,:,gt2)+ZRUZUR(gt2,gt1)*AmpVertexAhTocFuFu(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocFuFu=AmpWaveZAhTocFuFu 
AmpVertexAhTocFuFu= AmpVertexZAhTocFuFu
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocFuFu = AmpVertexAhTocFuFu  +  AmpVertexIRosAhTocFuFu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->bar[Fu] Fu -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocFuFu = AmpTreeAhTocFuFu 
 AmpSum2AhTocFuFu = AmpTreeAhTocFuFu + 2._dp*AmpWaveAhTocFuFu + 2._dp*AmpVertexAhTocFuFu  
Else 
 AmpSumAhTocFuFu = AmpTreeAhTocFuFu + AmpWaveAhTocFuFu + AmpVertexAhTocFuFu
 AmpSum2AhTocFuFu = AmpTreeAhTocFuFu + AmpWaveAhTocFuFu + AmpVertexAhTocFuFu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocFuFu = AmpTreeAhTocFuFu
 AmpSum2AhTocFuFu = AmpTreeAhTocFuFu 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MFuOS(gt2)+MFuOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MFu(gt2)+MFu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocFuFu = AmpTreeAhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFu(gt2),MFu(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocFuFu(gt1, gt2, gt3) 
  AmpSum2AhTocFuFu = 2._dp*AmpWaveAhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFu(gt2),MFu(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocFuFu(gt1, gt2, gt3) 
  AmpSum2AhTocFuFu = 2._dp*AmpVertexAhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFu(gt2),MFu(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocFuFu(gt1, gt2, gt3) 
  AmpSum2AhTocFuFu = AmpTreeAhTocFuFu + 2._dp*AmpWaveAhTocFuFu + 2._dp*AmpVertexAhTocFuFu
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MFu(gt2),MFu(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocFuFu(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocFuFu = AmpTreeAhTocFuFu
  Call SquareAmp_StoFF(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
  AmpSqTreeAhTocFuFu(gt1, gt2, gt3) = (3)*AmpSqAhTocFuFu(gt1, gt2, gt3)  
  AmpSum2AhTocFuFu = + 2._dp*AmpWaveAhTocFuFu + 2._dp*AmpVertexAhTocFuFu
  Call SquareAmp_StoFF(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
  AmpSqAhTocFuFu(gt1, gt2, gt3) = AmpSqAhTocFuFu(gt1, gt2, gt3) + AmpSqTreeAhTocFuFu(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocFuFu = AmpTreeAhTocFuFu
  Call SquareAmp_StoFF(MAh(gt1),MFu(gt2),MFu(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
  AmpSqTreeAhTocFuFu(gt1, gt2, gt3) = (3)*AmpSqAhTocFuFu(gt1, gt2, gt3)  
  AmpSum2AhTocFuFu = + 2._dp*AmpWaveAhTocFuFu + 2._dp*AmpVertexAhTocFuFu
  Call SquareAmp_StoFF(MAh(gt1),MFu(gt2),MFu(gt3),AmpSumAhTocFuFu(:,gt1, gt2, gt3),AmpSum2AhTocFuFu(:,gt1, gt2, gt3),AmpSqAhTocFuFu(gt1, gt2, gt3)) 
  AmpSqAhTocFuFu(gt1, gt2, gt3) = AmpSqAhTocFuFu(gt1, gt2, gt3) + AmpSqTreeAhTocFuFu(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocFuFu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhTocFuFu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MFuOS(gt2),MFuOS(gt3),helfactor*AmpSqAhTocFuFu(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MFu(gt2),MFu(gt3),helfactor*AmpSqAhTocFuFu(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocFuFu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocFuFu(gt1, gt2, gt3) + MRGAhTocFuFu(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocFuFu(gt1, gt2, gt3) + MRGAhTocFuFu(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
! hh VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_AhTohhVZ(cplAhhhVZ,MAh,Mhh,MVZ,MAh2,Mhh2,              & 
& MVZ2,AmpTreeAhTohhVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTohhVZ(ZcplAhhhVZ,MAh,Mhh,MVZ,MAh2,Mhh2,             & 
& MVZ2,AmpTreeAhTohhVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTohhVZ(MLambda,em,gs,cplAhhhVZ,MAhOS,MhhOS,              & 
& MVZOS,MRPAhTohhVZ,MRGAhTohhVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTohhVZ(MLambda,em,gs,ZcplAhhhVZ,MAhOS,MhhOS,             & 
& MVZOS,MRPAhTohhVZ,MRGAhTohhVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTohhVZ(MLambda,em,gs,cplAhhhVZ,MAh,Mhh,MVZ,              & 
& MRPAhTohhVZ,MRGAhTohhVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTohhVZ(MLambda,em,gs,ZcplAhhhVZ,MAh,Mhh,MVZ,             & 
& MRPAhTohhVZ,MRGAhTohhVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhVZ(cplAhhhVZ,ctcplAhhhVZ,MAh,MAh2,               & 
& Mhh,Mhh2,MVZ,MVZ2,ZfAh,Zfhh,ZfVZ,AmpWaveAhTohhVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhVZ(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
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
& cplhhcHpmVWmVZ1,AmpVertexAhTohhVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplhhcHpmVWmVZ1,AmpVertexIRdrAhTohhVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& AmpVertexIRosAhTohhVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplhhcHpmVWmVZ1,AmpVertexIRosAhTohhVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& AmpVertexIRosAhTohhVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplhhcHpmVWmVZ1,AmpVertexIRosAhTohhVZ)

 End if 
 End if 
AmpVertexAhTohhVZ = AmpVertexAhTohhVZ -  AmpVertexIRdrAhTohhVZ! +  AmpVertexIRosAhTohhVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTohhVZ=0._dp 
AmpVertexZAhTohhVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTohhVZ(:,gt2,:) = AmpWaveZAhTohhVZ(:,gt2,:)+ZRUZA(gt2,gt1)*AmpWaveAhTohhVZ(:,gt1,:) 
AmpVertexZAhTohhVZ(:,gt2,:)= AmpVertexZAhTohhVZ(:,gt2,:) + ZRUZA(gt2,gt1)*AmpVertexAhTohhVZ(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTohhVZ=AmpWaveZAhTohhVZ 
AmpVertexAhTohhVZ= AmpVertexZAhTohhVZ
! Final State 1 
AmpWaveZAhTohhVZ=0._dp 
AmpVertexZAhTohhVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTohhVZ(:,:,gt2) = AmpWaveZAhTohhVZ(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveAhTohhVZ(:,:,gt1) 
AmpVertexZAhTohhVZ(:,:,gt2)= AmpVertexZAhTohhVZ(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexAhTohhVZ(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTohhVZ=AmpWaveZAhTohhVZ 
AmpVertexAhTohhVZ= AmpVertexZAhTohhVZ
End if
If (ShiftIRdiv) Then 
AmpVertexAhTohhVZ = AmpVertexAhTohhVZ  +  AmpVertexIRosAhTohhVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->hh VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTohhVZ = AmpTreeAhTohhVZ 
 AmpSum2AhTohhVZ = AmpTreeAhTohhVZ + 2._dp*AmpWaveAhTohhVZ + 2._dp*AmpVertexAhTohhVZ  
Else 
 AmpSumAhTohhVZ = AmpTreeAhTohhVZ + AmpWaveAhTohhVZ + AmpVertexAhTohhVZ
 AmpSum2AhTohhVZ = AmpTreeAhTohhVZ + AmpWaveAhTohhVZ + AmpVertexAhTohhVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTohhVZ = AmpTreeAhTohhVZ
 AmpSum2AhTohhVZ = AmpTreeAhTohhVZ 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MhhOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(Mhh(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2AhTohhVZ = AmpTreeAhTohhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),MVZOS,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVZ,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTohhVZ(gt1, gt2) 
  AmpSum2AhTohhVZ = 2._dp*AmpWaveAhTohhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),MVZOS,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVZ,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTohhVZ(gt1, gt2) 
  AmpSum2AhTohhVZ = 2._dp*AmpVertexAhTohhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),MVZOS,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVZ,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTohhVZ(gt1, gt2) 
  AmpSum2AhTohhVZ = AmpTreeAhTohhVZ + 2._dp*AmpWaveAhTohhVZ + 2._dp*AmpVertexAhTohhVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),MVZOS,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVZ,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTohhVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTohhVZ = AmpTreeAhTohhVZ
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),MVZOS,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
  AmpSqTreeAhTohhVZ(gt1, gt2) = (1)*AmpSqAhTohhVZ(gt1, gt2)  
  AmpSum2AhTohhVZ = + 2._dp*AmpWaveAhTohhVZ + 2._dp*AmpVertexAhTohhVZ
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),MVZOS,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
  AmpSqAhTohhVZ(gt1, gt2) = AmpSqAhTohhVZ(gt1, gt2) + AmpSqTreeAhTohhVZ(gt1, gt2)  
Else  
  AmpSum2AhTohhVZ = AmpTreeAhTohhVZ
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVZ,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
  AmpSqTreeAhTohhVZ(gt1, gt2) = (1)*AmpSqAhTohhVZ(gt1, gt2)  
  AmpSum2AhTohhVZ = + 2._dp*AmpWaveAhTohhVZ + 2._dp*AmpVertexAhTohhVZ
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVZ,AmpSumAhTohhVZ(:,gt1, gt2),AmpSum2AhTohhVZ(:,gt1, gt2),AmpSqAhTohhVZ(gt1, gt2)) 
  AmpSqAhTohhVZ(gt1, gt2) = AmpSqAhTohhVZ(gt1, gt2) + AmpSqTreeAhTohhVZ(gt1, gt2)  
End if  
Else  
  AmpSqAhTohhVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTohhVZ(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MhhOS(gt2),MVZOS,helfactor*AmpSqAhTohhVZ(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),Mhh(gt2),MVZ,helfactor*AmpSqAhTohhVZ(gt1, gt2))
End if 
If ((Abs(MRPAhTohhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTohhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPAhTohhVZ(gt1, gt2) + MRGAhTohhVZ(gt1, gt2)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1*helfactor*(MRPAhTohhVZ(gt1, gt2) + MRGAhTohhVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
! Conjg(Hpm) Hpm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_AhTocHpmHpm(cplAhHpmcHpm,MAh,MHpm,MAh2,MHpm2,          & 
& AmpTreeAhTocHpmHpm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocHpmHpm(ZcplAhHpmcHpm,MAh,MHpm,MAh2,               & 
& MHpm2,AmpTreeAhTocHpmHpm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocHpmHpm(MLambda,em,gs,cplAhHpmcHpm,MAhOS,              & 
& MHpmOS,MRPAhTocHpmHpm,MRGAhTocHpmHpm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocHpmHpm(MLambda,em,gs,ZcplAhHpmcHpm,MAhOS,             & 
& MHpmOS,MRPAhTocHpmHpm,MRGAhTocHpmHpm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocHpmHpm(MLambda,em,gs,cplAhHpmcHpm,MAh,MHpm,           & 
& MRPAhTocHpmHpm,MRGAhTocHpmHpm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocHpmHpm(MLambda,em,gs,ZcplAhHpmcHpm,MAh,               & 
& MHpm,MRPAhTocHpmHpm,MRGAhTocHpmHpm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocHpmHpm(cplAhHpmcHpm,ctcplAhHpmcHpm,               & 
& MAh,MAh2,MHpm,MHpm2,ZfAh,ZfHpm,AmpWaveAhTocHpmHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexAhTocHpmHpm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexIRdrAhTocHpmHpm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
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
& cplHpmSucHpmcSuaa,AmpVertexIRosAhTocHpmHpm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexIRosAhTocHpmHpm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
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
& cplHpmSucHpmcSuaa,AmpVertexIRosAhTocHpmHpm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,AmpVertexIRosAhTocHpmHpm)

 End if 
 End if 
AmpVertexAhTocHpmHpm = AmpVertexAhTocHpmHpm -  AmpVertexIRdrAhTocHpmHpm! +  AmpVertexIRosAhTocHpmHpm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocHpmHpm=0._dp 
AmpVertexZAhTocHpmHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocHpmHpm(gt2,:,:) = AmpWaveZAhTocHpmHpm(gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocHpmHpm(gt1,:,:) 
AmpVertexZAhTocHpmHpm(gt2,:,:)= AmpVertexZAhTocHpmHpm(gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocHpmHpm(gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocHpmHpm=AmpWaveZAhTocHpmHpm 
AmpVertexAhTocHpmHpm= AmpVertexZAhTocHpmHpm
! Final State 1 
AmpWaveZAhTocHpmHpm=0._dp 
AmpVertexZAhTocHpmHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocHpmHpm(:,gt2,:) = AmpWaveZAhTocHpmHpm(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveAhTocHpmHpm(:,gt1,:) 
AmpVertexZAhTocHpmHpm(:,gt2,:)= AmpVertexZAhTocHpmHpm(:,gt2,:)+ZRUZP(gt2,gt1)*AmpVertexAhTocHpmHpm(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocHpmHpm=AmpWaveZAhTocHpmHpm 
AmpVertexAhTocHpmHpm= AmpVertexZAhTocHpmHpm
! Final State 2 
AmpWaveZAhTocHpmHpm=0._dp 
AmpVertexZAhTocHpmHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocHpmHpm(:,:,gt2) = AmpWaveZAhTocHpmHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveAhTocHpmHpm(:,:,gt1) 
AmpVertexZAhTocHpmHpm(:,:,gt2)= AmpVertexZAhTocHpmHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexAhTocHpmHpm(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocHpmHpm=AmpWaveZAhTocHpmHpm 
AmpVertexAhTocHpmHpm= AmpVertexZAhTocHpmHpm
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocHpmHpm = AmpVertexAhTocHpmHpm  +  AmpVertexIRosAhTocHpmHpm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->conj[Hpm] Hpm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocHpmHpm = AmpTreeAhTocHpmHpm 
 AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm + 2._dp*AmpWaveAhTocHpmHpm + 2._dp*AmpVertexAhTocHpmHpm  
Else 
 AmpSumAhTocHpmHpm = AmpTreeAhTocHpmHpm + AmpWaveAhTocHpmHpm + AmpVertexAhTocHpmHpm
 AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm + AmpWaveAhTocHpmHpm + AmpVertexAhTocHpmHpm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocHpmHpm = AmpTreeAhTocHpmHpm
 AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MHpmOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MHpm(gt2)+MHpm(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MHpm(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocHpmHpm(gt1, gt2, gt3) 
  AmpSum2AhTocHpmHpm = 2._dp*AmpWaveAhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MHpm(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocHpmHpm(gt1, gt2, gt3) 
  AmpSum2AhTocHpmHpm = 2._dp*AmpVertexAhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MHpm(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocHpmHpm(gt1, gt2, gt3) 
  AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm + 2._dp*AmpWaveAhTocHpmHpm + 2._dp*AmpVertexAhTocHpmHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MHpm(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocHpmHpm(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqTreeAhTocHpmHpm(gt1, gt2, gt3) = (1)*AmpSqAhTocHpmHpm(gt1, gt2, gt3)  
  AmpSum2AhTocHpmHpm = + 2._dp*AmpWaveAhTocHpmHpm + 2._dp*AmpVertexAhTocHpmHpm
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqAhTocHpmHpm(gt1, gt2, gt3) = AmpSqAhTocHpmHpm(gt1, gt2, gt3) + AmpSqTreeAhTocHpmHpm(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocHpmHpm = AmpTreeAhTocHpmHpm
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MHpm(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqTreeAhTocHpmHpm(gt1, gt2, gt3) = (1)*AmpSqAhTocHpmHpm(gt1, gt2, gt3)  
  AmpSum2AhTocHpmHpm = + 2._dp*AmpWaveAhTocHpmHpm + 2._dp*AmpVertexAhTocHpmHpm
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MHpm(gt3),AmpSumAhTocHpmHpm(gt1, gt2, gt3),AmpSum2AhTocHpmHpm(gt1, gt2, gt3),AmpSqAhTocHpmHpm(gt1, gt2, gt3)) 
  AmpSqAhTocHpmHpm(gt1, gt2, gt3) = AmpSqAhTocHpmHpm(gt1, gt2, gt3) + AmpSqTreeAhTocHpmHpm(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocHpmHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTocHpmHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MHpmOS(gt2),MHpmOS(gt3),helfactor*AmpSqAhTocHpmHpm(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MHpm(gt2),MHpm(gt3),helfactor*AmpSqAhTocHpmHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocHpmHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocHpmHpm(gt1, gt2, gt3) + MRGAhTocHpmHpm(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocHpmHpm(gt1, gt2, gt3) + MRGAhTocHpmHpm(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhToHpmcVWm(cplAhHpmcVWm,MAh,MHpm,MVWm,MAh2,           & 
& MHpm2,MVWm2,AmpTreeAhToHpmcVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhToHpmcVWm(ZcplAhHpmcVWm,MAh,MHpm,MVWm,               & 
& MAh2,MHpm2,MVWm2,AmpTreeAhToHpmcVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhToHpmcVWm(MLambda,em,gs,cplAhHpmcVWm,MAhOS,              & 
& MHpmOS,MVWmOS,MRPAhToHpmcVWm,MRGAhToHpmcVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhToHpmcVWm(MLambda,em,gs,ZcplAhHpmcVWm,MAhOS,             & 
& MHpmOS,MVWmOS,MRPAhToHpmcVWm,MRGAhToHpmcVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhToHpmcVWm(MLambda,em,gs,cplAhHpmcVWm,MAh,MHpm,           & 
& MVWm,MRPAhToHpmcVWm,MRGAhToHpmcVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhToHpmcVWm(MLambda,em,gs,ZcplAhHpmcVWm,MAh,               & 
& MHpm,MVWm,MRPAhToHpmcVWm,MRGAhToHpmcVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToHpmcVWm(cplAhHpmcVWm,ctcplAhHpmcVWm,               & 
& MAh,MAh2,MHpm,MHpm2,MVWm,MVWm2,ZfAh,ZfHpm,ZfVWm,AmpWaveAhToHpmcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,             & 
& cplChiChacVWmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgWmgAHpm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,    & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,           & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,         & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexAhToHpmcVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,             & 
& cplChiChacVWmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgWmgAHpm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,    & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,           & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,         & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexIRdrAhToHpmcVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,GosZcplAhHpmcHpm,ZcplAhHpmcVWm,      & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,   & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgAHpm,cplcgAgWmcVWm,        & 
& cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,GosZcplHpmcVWmVP,cplHpmcHpmVZ,       & 
& cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhAhcVWmVWm1,      & 
& cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosAhToHpmcVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,GZcplAhHpmcHpm,          & 
& ZcplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,            & 
& cplChiChacVWmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgWmgAHpm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,    & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,           & 
& GZcplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,       & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexIRosAhToHpmcVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,GcplAhHpmcHpm,cplAhHpmcVWm,          & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,   & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgAHpm,cplcgAgWmcVWm,        & 
& cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,cplhhHpmcHpm,cplhhHpmcVWm,     & 
& cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,GcplHpmcVWmVP,cplHpmcHpmVZ,          & 
& cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,cplAhAhcVWmVWm1,      & 
& cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,AmpVertexIRosAhToHpmcVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,             & 
& cplChiChacVWmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgWmgAHpm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,    & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,           & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,         & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,AmpVertexIRosAhToHpmcVWm)

 End if 
 End if 
AmpVertexAhToHpmcVWm = AmpVertexAhToHpmcVWm -  AmpVertexIRdrAhToHpmcVWm! +  AmpVertexIRosAhToHpmcVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhToHpmcVWm=0._dp 
AmpVertexZAhToHpmcVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhToHpmcVWm(:,gt2,:) = AmpWaveZAhToHpmcVWm(:,gt2,:)+ZRUZA(gt2,gt1)*AmpWaveAhToHpmcVWm(:,gt1,:) 
AmpVertexZAhToHpmcVWm(:,gt2,:)= AmpVertexZAhToHpmcVWm(:,gt2,:) + ZRUZA(gt2,gt1)*AmpVertexAhToHpmcVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhToHpmcVWm=AmpWaveZAhToHpmcVWm 
AmpVertexAhToHpmcVWm= AmpVertexZAhToHpmcVWm
! Final State 1 
AmpWaveZAhToHpmcVWm=0._dp 
AmpVertexZAhToHpmcVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhToHpmcVWm(:,:,gt2) = AmpWaveZAhToHpmcVWm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveAhToHpmcVWm(:,:,gt1) 
AmpVertexZAhToHpmcVWm(:,:,gt2)= AmpVertexZAhToHpmcVWm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexAhToHpmcVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhToHpmcVWm=AmpWaveZAhToHpmcVWm 
AmpVertexAhToHpmcVWm= AmpVertexZAhToHpmcVWm
End if
If (ShiftIRdiv) Then 
AmpVertexAhToHpmcVWm = AmpVertexAhToHpmcVWm  +  AmpVertexIRosAhToHpmcVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Hpm conj[VWm] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhToHpmcVWm = AmpTreeAhToHpmcVWm 
 AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm + 2._dp*AmpWaveAhToHpmcVWm + 2._dp*AmpVertexAhToHpmcVWm  
Else 
 AmpSumAhToHpmcVWm = AmpTreeAhToHpmcVWm + AmpWaveAhToHpmcVWm + AmpVertexAhToHpmcVWm
 AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm + AmpWaveAhToHpmcVWm + AmpVertexAhToHpmcVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToHpmcVWm = AmpTreeAhToHpmcVWm
 AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MHpmOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MHpm(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MHpm(gt2),MVWm,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhToHpmcVWm(gt1, gt2) 
  AmpSum2AhToHpmcVWm = 2._dp*AmpWaveAhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MHpm(gt2),MVWm,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhToHpmcVWm(gt1, gt2) 
  AmpSum2AhToHpmcVWm = 2._dp*AmpVertexAhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MHpm(gt2),MVWm,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhToHpmcVWm(gt1, gt2) 
  AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm + 2._dp*AmpWaveAhToHpmcVWm + 2._dp*AmpVertexAhToHpmcVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MHpm(gt2),MVWm,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhToHpmcVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm
  Call SquareAmp_StoSV(MAhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
  AmpSqTreeAhToHpmcVWm(gt1, gt2) = (1)*AmpSqAhToHpmcVWm(gt1, gt2)  
  AmpSum2AhToHpmcVWm = + 2._dp*AmpWaveAhToHpmcVWm + 2._dp*AmpVertexAhToHpmcVWm
  Call SquareAmp_StoSV(MAhOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
  AmpSqAhToHpmcVWm(gt1, gt2) = AmpSqAhToHpmcVWm(gt1, gt2) + AmpSqTreeAhToHpmcVWm(gt1, gt2)  
Else  
  AmpSum2AhToHpmcVWm = AmpTreeAhToHpmcVWm
  Call SquareAmp_StoSV(MAh(gt1),MHpm(gt2),MVWm,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
  AmpSqTreeAhToHpmcVWm(gt1, gt2) = (1)*AmpSqAhToHpmcVWm(gt1, gt2)  
  AmpSum2AhToHpmcVWm = + 2._dp*AmpWaveAhToHpmcVWm + 2._dp*AmpVertexAhToHpmcVWm
  Call SquareAmp_StoSV(MAh(gt1),MHpm(gt2),MVWm,AmpSumAhToHpmcVWm(:,gt1, gt2),AmpSum2AhToHpmcVWm(:,gt1, gt2),AmpSqAhToHpmcVWm(gt1, gt2)) 
  AmpSqAhToHpmcVWm(gt1, gt2) = AmpSqAhToHpmcVWm(gt1, gt2) + AmpSqTreeAhToHpmcVWm(gt1, gt2)  
End if  
Else  
  AmpSqAhToHpmcVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToHpmcVWm(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MHpmOS(gt2),MVWmOS,helfactor*AmpSqAhToHpmcVWm(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MHpm(gt2),MVWm,helfactor*AmpSqAhToHpmcVWm(gt1, gt2))
End if 
If ((Abs(MRPAhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*2*helfactor*(MRPAhToHpmcVWm(gt1, gt2) + MRGAhToHpmcVWm(gt1, gt2)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*2*helfactor*(MRPAhToHpmcVWm(gt1, gt2) + MRGAhToHpmcVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhTocSdSd(cplAhSdcSd,MAh,MSd,MAh2,MSd2,AmpTreeAhTocSdSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocSdSd(ZcplAhSdcSd,MAh,MSd,MAh2,MSd2,               & 
& AmpTreeAhTocSdSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSdSd(MLambda,em,gs,cplAhSdcSd,MAhOS,MSdOS,            & 
& MRPAhTocSdSd,MRGAhTocSdSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSdSd(MLambda,em,gs,ZcplAhSdcSd,MAhOS,MSdOS,           & 
& MRPAhTocSdSd,MRGAhTocSdSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocSdSd(MLambda,em,gs,cplAhSdcSd,MAh,MSd,MRPAhTocSdSd,   & 
& MRGAhTocSdSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSdSd(MLambda,em,gs,ZcplAhSdcSd,MAh,MSd,               & 
& MRPAhTocSdSd,MRGAhTocSdSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocSdSd(cplAhSdcSd,ctcplAhSdcSd,MAh,MAh2,            & 
& MSd,MSd2,ZfAh,ZfSd,AmpWaveAhTocSdSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexAhTocSdSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexIRdrAhTocSdSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSdSucSdcSuabab,AmpVertexIRosAhTocSdSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexIRosAhTocSdSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& AmpVertexIRosAhTocSdSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,AmpVertexIRosAhTocSdSd)

 End if 
 End if 
AmpVertexAhTocSdSd = AmpVertexAhTocSdSd -  AmpVertexIRdrAhTocSdSd! +  AmpVertexIRosAhTocSdSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocSdSd=0._dp 
AmpVertexZAhTocSdSd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocSdSd(gt2,:,:) = AmpWaveZAhTocSdSd(gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocSdSd(gt1,:,:) 
AmpVertexZAhTocSdSd(gt2,:,:)= AmpVertexZAhTocSdSd(gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocSdSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocSdSd=AmpWaveZAhTocSdSd 
AmpVertexAhTocSdSd= AmpVertexZAhTocSdSd
! Final State 1 
AmpWaveZAhTocSdSd=0._dp 
AmpVertexZAhTocSdSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZAhTocSdSd(:,gt2,:) = AmpWaveZAhTocSdSd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpWaveAhTocSdSd(:,gt1,:) 
AmpVertexZAhTocSdSd(:,gt2,:)= AmpVertexZAhTocSdSd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpVertexAhTocSdSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocSdSd=AmpWaveZAhTocSdSd 
AmpVertexAhTocSdSd= AmpVertexZAhTocSdSd
! Final State 2 
AmpWaveZAhTocSdSd=0._dp 
AmpVertexZAhTocSdSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZAhTocSdSd(:,:,gt2) = AmpWaveZAhTocSdSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveAhTocSdSd(:,:,gt1) 
AmpVertexZAhTocSdSd(:,:,gt2)= AmpVertexZAhTocSdSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexAhTocSdSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocSdSd=AmpWaveZAhTocSdSd 
AmpVertexAhTocSdSd= AmpVertexZAhTocSdSd
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocSdSd = AmpVertexAhTocSdSd  +  AmpVertexIRosAhTocSdSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->conj[Sd] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocSdSd = AmpTreeAhTocSdSd 
 AmpSum2AhTocSdSd = AmpTreeAhTocSdSd + 2._dp*AmpWaveAhTocSdSd + 2._dp*AmpVertexAhTocSdSd  
Else 
 AmpSumAhTocSdSd = AmpTreeAhTocSdSd + AmpWaveAhTocSdSd + AmpVertexAhTocSdSd
 AmpSum2AhTocSdSd = AmpTreeAhTocSdSd + AmpWaveAhTocSdSd + AmpVertexAhTocSdSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocSdSd = AmpTreeAhTocSdSd
 AmpSum2AhTocSdSd = AmpTreeAhTocSdSd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSdOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSd(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocSdSd = AmpTreeAhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSd(gt2),MSd(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocSdSd(gt1, gt2, gt3) 
  AmpSum2AhTocSdSd = 2._dp*AmpWaveAhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSd(gt2),MSd(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocSdSd(gt1, gt2, gt3) 
  AmpSum2AhTocSdSd = 2._dp*AmpVertexAhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSd(gt2),MSd(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocSdSd(gt1, gt2, gt3) 
  AmpSum2AhTocSdSd = AmpTreeAhTocSdSd + 2._dp*AmpWaveAhTocSdSd + 2._dp*AmpVertexAhTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSd(gt2),MSd(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocSdSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocSdSd = AmpTreeAhTocSdSd
  Call SquareAmp_StoSS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
  AmpSqTreeAhTocSdSd(gt1, gt2, gt3) = (3)*AmpSqAhTocSdSd(gt1, gt2, gt3)  
  AmpSum2AhTocSdSd = + 2._dp*AmpWaveAhTocSdSd + 2._dp*AmpVertexAhTocSdSd
  Call SquareAmp_StoSS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
  AmpSqAhTocSdSd(gt1, gt2, gt3) = AmpSqAhTocSdSd(gt1, gt2, gt3) + AmpSqTreeAhTocSdSd(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocSdSd = AmpTreeAhTocSdSd
  Call SquareAmp_StoSS(MAh(gt1),MSd(gt2),MSd(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
  AmpSqTreeAhTocSdSd(gt1, gt2, gt3) = (3)*AmpSqAhTocSdSd(gt1, gt2, gt3)  
  AmpSum2AhTocSdSd = + 2._dp*AmpWaveAhTocSdSd + 2._dp*AmpVertexAhTocSdSd
  Call SquareAmp_StoSS(MAh(gt1),MSd(gt2),MSd(gt3),AmpSumAhTocSdSd(gt1, gt2, gt3),AmpSum2AhTocSdSd(gt1, gt2, gt3),AmpSqAhTocSdSd(gt1, gt2, gt3)) 
  AmpSqAhTocSdSd(gt1, gt2, gt3) = AmpSqAhTocSdSd(gt1, gt2, gt3) + AmpSqTreeAhTocSdSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocSdSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTocSdSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MSdOS(gt2),MSdOS(gt3),helfactor*AmpSqAhTocSdSd(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MSd(gt2),MSd(gt3),helfactor*AmpSqAhTocSdSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocSdSd(gt1, gt2, gt3) + MRGAhTocSdSd(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocSdSd(gt1, gt2, gt3) + MRGAhTocSdSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhTocSeSe(cplAhSecSe,MAh,MSe,MAh2,MSe2,AmpTreeAhTocSeSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocSeSe(ZcplAhSecSe,MAh,MSe,MAh2,MSe2,               & 
& AmpTreeAhTocSeSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSeSe(MLambda,em,gs,cplAhSecSe,MAhOS,MSeOS,            & 
& MRPAhTocSeSe,MRGAhTocSeSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSeSe(MLambda,em,gs,ZcplAhSecSe,MAhOS,MSeOS,           & 
& MRPAhTocSeSe,MRGAhTocSeSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocSeSe(MLambda,em,gs,cplAhSecSe,MAh,MSe,MRPAhTocSeSe,   & 
& MRGAhTocSeSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSeSe(MLambda,em,gs,ZcplAhSecSe,MAh,MSe,               & 
& MRPAhTocSeSe,MRGAhTocSeSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocSeSe(cplAhSecSe,ctcplAhSecSe,MAh,MAh2,            & 
& MSe,MSe2,ZfAh,ZfSe,AmpWaveAhTocSeSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,        & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,        & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,           & 
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexAhTocSeSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,        & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,        & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,           & 
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRdrAhTocSeSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,ZcplAhSecSe,cplAhSucSu,     & 
& cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,              & 
& cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,      & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,cplAhSdcSecSuaa,     & 
& cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,cplHpmSecHpmcSe1,          & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosAhTocSeSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,ZcplAhSecSe,    & 
& cplAhSucSu,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,        & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,        & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,           & 
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosAhTocSeSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,              & 
& cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,      & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,cplAhSdcSecSuaa,     & 
& cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,cplHpmSecHpmcSe1,          & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosAhTocSeSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,        & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,        & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,           & 
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosAhTocSeSe)

 End if 
 End if 
AmpVertexAhTocSeSe = AmpVertexAhTocSeSe -  AmpVertexIRdrAhTocSeSe! +  AmpVertexIRosAhTocSeSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocSeSe=0._dp 
AmpVertexZAhTocSeSe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocSeSe(gt2,:,:) = AmpWaveZAhTocSeSe(gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocSeSe(gt1,:,:) 
AmpVertexZAhTocSeSe(gt2,:,:)= AmpVertexZAhTocSeSe(gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocSeSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocSeSe=AmpWaveZAhTocSeSe 
AmpVertexAhTocSeSe= AmpVertexZAhTocSeSe
! Final State 1 
AmpWaveZAhTocSeSe=0._dp 
AmpVertexZAhTocSeSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZAhTocSeSe(:,gt2,:) = AmpWaveZAhTocSeSe(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpWaveAhTocSeSe(:,gt1,:) 
AmpVertexZAhTocSeSe(:,gt2,:)= AmpVertexZAhTocSeSe(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpVertexAhTocSeSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocSeSe=AmpWaveZAhTocSeSe 
AmpVertexAhTocSeSe= AmpVertexZAhTocSeSe
! Final State 2 
AmpWaveZAhTocSeSe=0._dp 
AmpVertexZAhTocSeSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZAhTocSeSe(:,:,gt2) = AmpWaveZAhTocSeSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveAhTocSeSe(:,:,gt1) 
AmpVertexZAhTocSeSe(:,:,gt2)= AmpVertexZAhTocSeSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexAhTocSeSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocSeSe=AmpWaveZAhTocSeSe 
AmpVertexAhTocSeSe= AmpVertexZAhTocSeSe
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocSeSe = AmpVertexAhTocSeSe  +  AmpVertexIRosAhTocSeSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->conj[Se] Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocSeSe = AmpTreeAhTocSeSe 
 AmpSum2AhTocSeSe = AmpTreeAhTocSeSe + 2._dp*AmpWaveAhTocSeSe + 2._dp*AmpVertexAhTocSeSe  
Else 
 AmpSumAhTocSeSe = AmpTreeAhTocSeSe + AmpWaveAhTocSeSe + AmpVertexAhTocSeSe
 AmpSum2AhTocSeSe = AmpTreeAhTocSeSe + AmpWaveAhTocSeSe + AmpVertexAhTocSeSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocSeSe = AmpTreeAhTocSeSe
 AmpSum2AhTocSeSe = AmpTreeAhTocSeSe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSeOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSe(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocSeSe = AmpTreeAhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSe(gt2),MSe(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocSeSe(gt1, gt2, gt3) 
  AmpSum2AhTocSeSe = 2._dp*AmpWaveAhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSe(gt2),MSe(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocSeSe(gt1, gt2, gt3) 
  AmpSum2AhTocSeSe = 2._dp*AmpVertexAhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSe(gt2),MSe(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocSeSe(gt1, gt2, gt3) 
  AmpSum2AhTocSeSe = AmpTreeAhTocSeSe + 2._dp*AmpWaveAhTocSeSe + 2._dp*AmpVertexAhTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSe(gt2),MSe(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocSeSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocSeSe = AmpTreeAhTocSeSe
  Call SquareAmp_StoSS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
  AmpSqTreeAhTocSeSe(gt1, gt2, gt3) = (1)*AmpSqAhTocSeSe(gt1, gt2, gt3)  
  AmpSum2AhTocSeSe = + 2._dp*AmpWaveAhTocSeSe + 2._dp*AmpVertexAhTocSeSe
  Call SquareAmp_StoSS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
  AmpSqAhTocSeSe(gt1, gt2, gt3) = AmpSqAhTocSeSe(gt1, gt2, gt3) + AmpSqTreeAhTocSeSe(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocSeSe = AmpTreeAhTocSeSe
  Call SquareAmp_StoSS(MAh(gt1),MSe(gt2),MSe(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
  AmpSqTreeAhTocSeSe(gt1, gt2, gt3) = (1)*AmpSqAhTocSeSe(gt1, gt2, gt3)  
  AmpSum2AhTocSeSe = + 2._dp*AmpWaveAhTocSeSe + 2._dp*AmpVertexAhTocSeSe
  Call SquareAmp_StoSS(MAh(gt1),MSe(gt2),MSe(gt3),AmpSumAhTocSeSe(gt1, gt2, gt3),AmpSum2AhTocSeSe(gt1, gt2, gt3),AmpSqAhTocSeSe(gt1, gt2, gt3)) 
  AmpSqAhTocSeSe(gt1, gt2, gt3) = AmpSqAhTocSeSe(gt1, gt2, gt3) + AmpSqTreeAhTocSeSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocSeSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTocSeSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MSeOS(gt2),MSeOS(gt3),helfactor*AmpSqAhTocSeSe(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MSe(gt2),MSe(gt3),helfactor*AmpSqAhTocSeSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocSeSe(gt1, gt2, gt3) + MRGAhTocSeSe(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocSeSe(gt1, gt2, gt3) + MRGAhTocSeSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
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
Call Amplitude_Tree_MSSMTriLnV_AhTocSuSu(cplAhSucSu,MAh,MSu,MAh2,MSu2,AmpTreeAhTocSuSu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_AhTocSuSu(ZcplAhSucSu,MAh,MSu,MAh2,MSu2,               & 
& AmpTreeAhTocSuSu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSuSu(MLambda,em,gs,cplAhSucSu,MAhOS,MSuOS,            & 
& MRPAhTocSuSu,MRGAhTocSuSu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSuSu(MLambda,em,gs,ZcplAhSucSu,MAhOS,MSuOS,           & 
& MRPAhTocSuSu,MRGAhTocSuSu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_AhTocSuSu(MLambda,em,gs,cplAhSucSu,MAh,MSu,MRPAhTocSuSu,   & 
& MRGAhTocSuSu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_AhTocSuSu(MLambda,em,gs,ZcplAhSucSu,MAh,MSu,               & 
& MRPAhTocSuSu,MRGAhTocSuSu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTocSuSu(cplAhSucSu,ctcplAhSucSu,MAh,MAh2,            & 
& MSu,MSu2,ZfAh,ZfSu,AmpWaveAhTocSuSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,AmpVertexAhTocSuSu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& AmpVertexIRdrAhTocSuSu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,AmpVertexIRosAhTocSuSu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& AmpVertexIRosAhTocSuSu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,AmpVertexIRosAhTocSuSu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& AmpVertexIRosAhTocSuSu)

 End if 
 End if 
AmpVertexAhTocSuSu = AmpVertexAhTocSuSu -  AmpVertexIRdrAhTocSuSu! +  AmpVertexIRosAhTocSuSu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZAhTocSuSu=0._dp 
AmpVertexZAhTocSuSu=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZAhTocSuSu(gt2,:,:) = AmpWaveZAhTocSuSu(gt2,:,:)+ZRUZA(gt2,gt1)*AmpWaveAhTocSuSu(gt1,:,:) 
AmpVertexZAhTocSuSu(gt2,:,:)= AmpVertexZAhTocSuSu(gt2,:,:) + ZRUZA(gt2,gt1)*AmpVertexAhTocSuSu(gt1,:,:) 
 End Do 
End Do 
AmpWaveAhTocSuSu=AmpWaveZAhTocSuSu 
AmpVertexAhTocSuSu= AmpVertexZAhTocSuSu
! Final State 1 
AmpWaveZAhTocSuSu=0._dp 
AmpVertexZAhTocSuSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZAhTocSuSu(:,gt2,:) = AmpWaveZAhTocSuSu(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWaveAhTocSuSu(:,gt1,:) 
AmpVertexZAhTocSuSu(:,gt2,:)= AmpVertexZAhTocSuSu(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpVertexAhTocSuSu(:,gt1,:) 
 End Do 
End Do 
AmpWaveAhTocSuSu=AmpWaveZAhTocSuSu 
AmpVertexAhTocSuSu= AmpVertexZAhTocSuSu
! Final State 2 
AmpWaveZAhTocSuSu=0._dp 
AmpVertexZAhTocSuSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZAhTocSuSu(:,:,gt2) = AmpWaveZAhTocSuSu(:,:,gt2)+ZRUZU(gt2,gt1)*AmpWaveAhTocSuSu(:,:,gt1) 
AmpVertexZAhTocSuSu(:,:,gt2)= AmpVertexZAhTocSuSu(:,:,gt2)+ZRUZU(gt2,gt1)*AmpVertexAhTocSuSu(:,:,gt1) 
 End Do 
End Do 
AmpWaveAhTocSuSu=AmpWaveZAhTocSuSu 
AmpVertexAhTocSuSu= AmpVertexZAhTocSuSu
End if
If (ShiftIRdiv) Then 
AmpVertexAhTocSuSu = AmpVertexAhTocSuSu  +  AmpVertexIRosAhTocSuSu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->conj[Su] Su -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumAhTocSuSu = AmpTreeAhTocSuSu 
 AmpSum2AhTocSuSu = AmpTreeAhTocSuSu + 2._dp*AmpWaveAhTocSuSu + 2._dp*AmpVertexAhTocSuSu  
Else 
 AmpSumAhTocSuSu = AmpTreeAhTocSuSu + AmpWaveAhTocSuSu + AmpVertexAhTocSuSu
 AmpSum2AhTocSuSu = AmpTreeAhTocSuSu + AmpWaveAhTocSuSu + AmpVertexAhTocSuSu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTocSuSu = AmpTreeAhTocSuSu
 AmpSum2AhTocSuSu = AmpTreeAhTocSuSu 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSuOS(gt2)+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSu(gt2)+MSu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2AhTocSuSu = AmpTreeAhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSu(gt2),MSu(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqAhTocSuSu(gt1, gt2, gt3) 
  AmpSum2AhTocSuSu = 2._dp*AmpWaveAhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSu(gt2),MSu(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqAhTocSuSu(gt1, gt2, gt3) 
  AmpSum2AhTocSuSu = 2._dp*AmpVertexAhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSu(gt2),MSu(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqAhTocSuSu(gt1, gt2, gt3) 
  AmpSum2AhTocSuSu = AmpTreeAhTocSuSu + 2._dp*AmpWaveAhTocSuSu + 2._dp*AmpVertexAhTocSuSu
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSu(gt2),MSu(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqAhTocSuSu(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2AhTocSuSu = AmpTreeAhTocSuSu
  Call SquareAmp_StoSS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
  AmpSqTreeAhTocSuSu(gt1, gt2, gt3) = (3)*AmpSqAhTocSuSu(gt1, gt2, gt3)  
  AmpSum2AhTocSuSu = + 2._dp*AmpWaveAhTocSuSu + 2._dp*AmpVertexAhTocSuSu
  Call SquareAmp_StoSS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
  AmpSqAhTocSuSu(gt1, gt2, gt3) = AmpSqAhTocSuSu(gt1, gt2, gt3) + AmpSqTreeAhTocSuSu(gt1, gt2, gt3)  
Else  
  AmpSum2AhTocSuSu = AmpTreeAhTocSuSu
  Call SquareAmp_StoSS(MAh(gt1),MSu(gt2),MSu(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
  AmpSqTreeAhTocSuSu(gt1, gt2, gt3) = (3)*AmpSqAhTocSuSu(gt1, gt2, gt3)  
  AmpSum2AhTocSuSu = + 2._dp*AmpWaveAhTocSuSu + 2._dp*AmpVertexAhTocSuSu
  Call SquareAmp_StoSS(MAh(gt1),MSu(gt2),MSu(gt3),AmpSumAhTocSuSu(gt1, gt2, gt3),AmpSum2AhTocSuSu(gt1, gt2, gt3),AmpSqAhTocSuSu(gt1, gt2, gt3)) 
  AmpSqAhTocSuSu(gt1, gt2, gt3) = AmpSqAhTocSuSu(gt1, gt2, gt3) + AmpSqTreeAhTocSuSu(gt1, gt2, gt3)  
End if  
Else  
  AmpSqAhTocSuSu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTocSuSu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MSuOS(gt2),MSuOS(gt3),helfactor*AmpSqAhTocSuSu(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MSu(gt2),MSu(gt3),helfactor*AmpSqAhTocSuSu(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPAhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTocSuSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocSuSu(gt1, gt2, gt3) + MRGAhTocSuSu(gt1, gt2, gt3)) 
  gP1LAh(gt1,i4) = gP1LAh(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPAhTocSuSu(gt1, gt2, gt3) + MRGAhTocSuSu(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LAh(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
End If 
!---------------- 
! Ah Ah
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhAh(MAhOS,MAh2OS,ZfAh,AmpWaveAhToAhAh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhAh(MAhOS,MAh2OS,ZfAh,AmpWaveAhToAhAh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhAh(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,            & 
& MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,               & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,          & 
& cplAhAhSecSe1,cplAhAhSucSuaa,AmpVertexAhToAhAh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhAh(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,            & 
& MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,               & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,          & 
& cplAhAhSecSe1,cplAhAhSucSuaa,AmpVertexAhToAhAh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhAh(MAh,MAh2,ZfAh,AmpWaveAhToAhAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhAh(MAh,MCha,MChi,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,           & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,           & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSucSuaa,AmpVertexAhToAhAh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Ah Ah -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToAhAh = 0._dp 
 AmpSum2AhToAhAh = 0._dp  
Else 
 AmpSumAhToAhAh = AmpVertexAhToAhAh + AmpWaveAhToAhAh
 AmpSum2AhToAhAh = AmpVertexAhToAhAh + AmpWaveAhToAhAh 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=gt2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MAhOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MAh(gt2)+MAh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumAhToAhAh(gt1, gt2, gt3),AmpSum2AhToAhAh(gt1, gt2, gt3),AmpSqAhToAhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MAh(gt2),MAh(gt3),AmpSumAhToAhAh(gt1, gt2, gt3),AmpSum2AhToAhAh(gt1, gt2, gt3),AmpSqAhToAhAh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToAhAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqAhToAhAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAhOS(gt1),MAhOS(gt2),MAhOS(gt3),helfactor*AmpSqAhToAhAh(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAh(gt1),MAh(gt2),MAh(gt3),helfactor*AmpSqAhToAhAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToAhSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveAhToAhSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveAhToAhSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhSv(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,               & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,     & 
& cplcFeFeSvR,cplSdSvcSd,cplSeSvcSe,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdSvcSdaa,         & 
& cplAhSeSvcSe1,AmpVertexAhToAhSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhSv(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,               & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,     & 
& cplcFeFeSvR,cplSdSvcSd,cplSeSvcSe,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdSvcSdaa,         & 
& cplAhSeSvcSe1,AmpVertexAhToAhSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,AmpWaveAhToAhSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhSv(MAh,MFd,MFe,MSd,MSe,MSv,MAh2,               & 
& MFd2,MFe2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,              & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,cplSdSvcSd,      & 
& cplSeSvcSe,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdSvcSdaa,cplAhSeSvcSe1,AmpVertexAhToAhSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Ah Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToAhSv = 0._dp 
 AmpSum2AhToAhSv = 0._dp  
Else 
 AmpSumAhToAhSv = AmpVertexAhToAhSv + AmpWaveAhToAhSv
 AmpSum2AhToAhSv = AmpVertexAhToAhSv + AmpWaveAhToAhSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MAhOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MAh(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MAhOS(gt2),MSvOS(gt3),AmpSumAhToAhSv(gt1, gt2, gt3),AmpSum2AhToAhSv(gt1, gt2, gt3),AmpSqAhToAhSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MAh(gt2),MSv(gt3),AmpSumAhToAhSv(gt1, gt2, gt3),AmpSum2AhToAhSv(gt1, gt2, gt3),AmpSqAhToAhSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToAhSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToAhSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MAhOS(gt2),MSvOS(gt3),helfactor*AmpSqAhToAhSv(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MAh(gt2),MSv(gt3),helfactor*AmpSqAhToAhSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToAhSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToAhSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToAhVP(MAhOS,MAh2OS,MVP,MVP2,ZfAh,ZfVP,              & 
& AmpWaveAhToAhVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhVP(MAhOS,MAh2OS,MVP,MVP2,ZfAh,ZfVP,              & 
& AmpWaveAhToAhVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,          & 
& cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,          & 
& cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,               & 
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,AmpVertexAhToAhVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,          & 
& cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,          & 
& cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,               & 
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,AmpVertexAhToAhVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhVP(MAh,MAh2,MVP,MVP2,ZfAh,ZfVP,AmpWaveAhToAhVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhVP(MAh,MCha,MFd,MFe,MFu,MHpm,MSd,              & 
& MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVP2,MVWm2,            & 
& cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,             & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,           & 
& cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,AmpVertexAhToAhVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Ah VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToAhVP = 0._dp 
 AmpSum2AhToAhVP = 0._dp  
Else 
 AmpSumAhToAhVP = AmpVertexAhToAhVP + AmpWaveAhToAhVP
 AmpSum2AhToAhVP = AmpVertexAhToAhVP + AmpWaveAhToAhVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MAhOS(gt2)+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MAh(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MAhOS(gt2),0._dp,AmpSumAhToAhVP(:,gt1, gt2),AmpSum2AhToAhVP(:,gt1, gt2),AmpSqAhToAhVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MAh(gt2),MVP,AmpSumAhToAhVP(:,gt1, gt2),AmpSum2AhToAhVP(:,gt1, gt2),AmpSqAhToAhVP(gt1, gt2)) 
End if  
Else  
  AmpSqAhToAhVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToAhVP(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MAhOS(gt2),0._dp,helfactor*AmpSqAhToAhVP(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MAh(gt2),MVP,helfactor*AmpSqAhToAhVP(gt1, gt2))
End if 
If ((Abs(MRPAhToAhVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToAhVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Ah VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhVZ(MAhOS,MAh2OS,MVZOS,MVZ2OS,ZfAh,               & 
& ZfVZ,AmpWaveAhToAhVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhVZ(MAhOS,MAh2OS,MVZOS,MVZ2OS,ZfAh,               & 
& ZfVZ,AmpWaveAhToAhVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhVZ(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVZL,              & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,           & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,cplcgWpCgWpCVZ,cplHpmcHpmVZ,          & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,               & 
& cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,AmpVertexAhToAhVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhVZ(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVZL,              & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,           & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,cplcgWpCgWpCVZ,cplHpmcHpmVZ,          & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,               & 
& cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,AmpVertexAhToAhVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToAhVZ(MAh,MAh2,MVZ,MVZ2,ZfAh,ZfVZ,AmpWaveAhToAhVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToAhVZ(MAh,MCha,MChi,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,             & 
& MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,          & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,        & 
& cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,              & 
& cplcgWpCgWpCVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,             & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,AmpVertexAhToAhVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Ah VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToAhVZ = 0._dp 
 AmpSum2AhToAhVZ = 0._dp  
Else 
 AmpSumAhToAhVZ = AmpVertexAhToAhVZ + AmpWaveAhToAhVZ
 AmpSum2AhToAhVZ = AmpVertexAhToAhVZ + AmpWaveAhToAhVZ 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MAhOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MAh(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MAhOS(gt2),MVZOS,AmpSumAhToAhVZ(:,gt1, gt2),AmpSum2AhToAhVZ(:,gt1, gt2),AmpSqAhToAhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MAh(gt2),MVZ,AmpSumAhToAhVZ(:,gt1, gt2),AmpSum2AhToAhVZ(:,gt1, gt2),AmpSqAhToAhVZ(gt1, gt2)) 
End if  
Else  
  AmpSqAhToAhVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToAhVZ(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MAhOS(gt2),MVZOS,helfactor*AmpSqAhToAhVZ(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MAh(gt2),MVZ,helfactor*AmpSqAhToAhVZ(gt1, gt2))
End if 
If ((Abs(MRPAhToAhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToAhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToChacFe(MAhOS,MAh2OS,MChaOS,MCha2OS,MFeOS,          & 
& MFe2OS,ZfAh,ZfFEL,ZfFER,ZfLm,ZfLp,AmpWaveAhToChacFe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToChacFe(MAhOS,MAh2OS,MChaOS,MCha2OS,MFeOS,          & 
& MFe2OS,ZfAh,ZfFEL,ZfFER,ZfLm,ZfLp,AmpWaveAhToChacFe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChacFe(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFeFdcSuL,         & 
& cplcFeFdcSuR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvSeL,cplcFeFvSeR,cplcFecFuSdL,           & 
& cplcFecFuSdR,AmpVertexAhToChacFe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChacFe(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFeFdcSuL,         & 
& cplcFeFdcSuR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvSeL,cplcFeFvSeR,cplcFecFuSdL,           & 
& cplcFecFuSdR,AmpVertexAhToChacFe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToChacFe(MAh,MAh2,MCha,MCha2,MFe,MFe2,               & 
& ZfAh,ZfFEL,ZfFER,ZfLm,ZfLp,AmpWaveAhToChacFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChacFe(MAh,MCha,MFd,MFe,MFu,MSd,MSe,             & 
& MSu,MSv,MAh2,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFecFuSdL,cplcFecFuSdR,AmpVertexAhToChacFe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Cha bar[Fe] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToChacFe = 0._dp 
 AmpSum2AhToChacFe = 0._dp  
Else 
 AmpSumAhToChacFe = AmpVertexAhToChacFe + AmpWaveAhToChacFe
 AmpSum2AhToChacFe = AmpVertexAhToChacFe + AmpWaveAhToChacFe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MChaOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MCha(gt2)+MFe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumAhToChacFe(:,gt1, gt2, gt3),AmpSum2AhToChacFe(:,gt1, gt2, gt3),AmpSqAhToChacFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MCha(gt2),MFe(gt3),AmpSumAhToChacFe(:,gt1, gt2, gt3),AmpSum2AhToChacFe(:,gt1, gt2, gt3),AmpSqAhToChacFe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToChacFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhToChacFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MChaOS(gt2),MFeOS(gt3),helfactor*AmpSqAhToChacFe(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MCha(gt2),MFe(gt3),helfactor*AmpSqAhToChacFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToChacFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToChacFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToChiFv(MAhOS,MAh2OS,MChiOS,MChi2OS,ZfAh,            & 
& ZfFvL,ZfL0,AmpWaveAhToChiFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToChiFv(MAhOS,MAh2OS,MChiOS,MChi2OS,ZfAh,            & 
& ZfFvL,ZfL0,AmpWaveAhToChiFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChiFv(MAhOS,MChiOS,MFdOS,MFeOS,MSdOS,            & 
& MSeOS,MAh2OS,MChi2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplChiFdcSdL,cplChiFdcSdR,               & 
& cplChiFecSeL,cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcFeFvSeL,cplcFeFvSeR,AmpVertexAhToChiFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChiFv(MAhOS,MChiOS,MFdOS,MFeOS,MSdOS,            & 
& MSeOS,MAh2OS,MChi2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplChiFdcSdL,cplChiFdcSdR,               & 
& cplChiFecSeL,cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplcFeFvSeL,cplcFeFvSeR,AmpVertexAhToChiFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToChiFv(MAh,MAh2,MChi,MChi2,ZfAh,ZfFvL,              & 
& ZfL0,AmpWaveAhToChiFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToChiFv(MAh,MChi,MFd,MFe,MSd,MSe,MAh2,             & 
& MChi2,MFd2,MFe2,MSd2,MSe2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplAhSdcSd,cplAhSecSe,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,             & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,               & 
& AmpVertexAhToChiFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Chi Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToChiFv = 0._dp 
 AmpSum2AhToChiFv = 0._dp  
Else 
 AmpSumAhToChiFv = AmpVertexAhToChiFv + AmpWaveAhToChiFv
 AmpSum2AhToChiFv = AmpVertexAhToChiFv + AmpWaveAhToChiFv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MChiOS(gt2)+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MChi(gt2)+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MChiOS(gt2),0._dp,AmpSumAhToChiFv(:,gt1, gt2, gt3),AmpSum2AhToChiFv(:,gt1, gt2, gt3),AmpSqAhToChiFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MChi(gt2),0._dp,AmpSumAhToChiFv(:,gt1, gt2, gt3),AmpSum2AhToChiFv(:,gt1, gt2, gt3),AmpSqAhToChiFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToChiFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhToChiFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MChiOS(gt2),0._dp,helfactor*AmpSqAhToChiFv(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MChi(gt2),0._dp,helfactor*AmpSqAhToChiFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToChiFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToChiFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToFvFv(MAhOS,MAh2OS,ZfAh,ZfFvL,AmpWaveAhToFvFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToFvFv(MAhOS,MAh2OS,ZfAh,ZfFvL,AmpWaveAhToFvFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToFvFv(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MHpm2OS,          & 
& MSd2OS,MSe2OS,MSv2OS,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,    & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,cplAhHpmcVWm,             & 
& cplAhSdcSd,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFvSvL,              & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFvHpmL,           & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,AmpVertexAhToFvFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToFvFv(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MHpm2OS,          & 
& MSd2OS,MSe2OS,MSv2OS,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,    & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,cplAhHpmcVWm,             & 
& cplAhSdcSd,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFvSvL,              & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFvHpmL,           & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,AmpVertexAhToFvFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToFvFv(MAh,MAh2,ZfAh,ZfFvL,AmpWaveAhToFvFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToFvFv(MAh,MCha,MChi,MFd,MFe,MHpm,MSd,             & 
& MSe,MSv,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcChaChaAhL,      & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhcHpmVWm,              & 
& cplFvChacSeL,cplFvChacSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& AmpVertexAhToFvFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Fv Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToFvFv = 0._dp 
 AmpSum2AhToFvFv = 0._dp  
Else 
 AmpSumAhToFvFv = AmpVertexAhToFvFv + AmpWaveAhToFvFv
 AmpSum2AhToFvFv = AmpVertexAhToFvFv + AmpWaveAhToFvFv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=gt2,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(0.+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),0._dp,0._dp,AmpSumAhToFvFv(:,gt1, gt2, gt3),AmpSum2AhToFvFv(:,gt1, gt2, gt3),AmpSqAhToFvFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),0._dp,0._dp,AmpSumAhToFvFv(:,gt1, gt2, gt3),AmpSum2AhToFvFv(:,gt1, gt2, gt3),AmpSqAhToFvFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToFvFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqAhToFvFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAhOS(gt1),0._dp,0._dp,helfactor*AmpSqAhToFvFv(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAh(gt1),0._dp,0._dp,helfactor*AmpSqAhToFvFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToFvFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToFvFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToGluGlu(MAhOS,MAh2OS,MGluOS,MGlu2OS,ZfAh,           & 
& ZffG,AmpWaveAhToGluGlu)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToGluGlu(MAhOS,MAh2OS,MGluOS,MGlu2OS,ZfAh,           & 
& ZffG,AmpWaveAhToGluGlu)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToGluGlu(MAhOS,MFdOS,MFuOS,MGluOS,MSdOS,           & 
& MSuOS,MAh2OS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,               & 
& cplGluFucSuL,cplGluFucSuR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& AmpVertexAhToGluGlu)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToGluGlu(MAhOS,MFdOS,MFuOS,MGluOS,MSdOS,           & 
& MSuOS,MAh2OS,MFd2OS,MFu2OS,MGlu2OS,MSd2OS,MSu2OS,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,               & 
& cplGluFucSuL,cplGluFucSuR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& AmpVertexAhToGluGlu)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToGluGlu(MAh,MAh2,MGlu,MGlu2,ZfAh,ZffG,              & 
& AmpWaveAhToGluGlu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToGluGlu(MAh,MFd,MFu,MGlu,MSd,MSu,MAh2,            & 
& MFd2,MFu2,MGlu2,MSd2,MSu2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,             & 
& cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,AmpVertexAhToGluGlu)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Glu Glu -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToGluGlu = 0._dp 
 AmpSum2AhToGluGlu = 0._dp  
Else 
 AmpSumAhToGluGlu = AmpVertexAhToGluGlu + AmpWaveAhToGluGlu
 AmpSum2AhToGluGlu = AmpVertexAhToGluGlu + AmpWaveAhToGluGlu 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MAhOS(gt1).gt.(MGluOS+MGluOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MGlu+MGlu)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MAhOS(gt1),MGluOS,MGluOS,AmpSumAhToGluGlu(:,gt1),AmpSum2AhToGluGlu(:,gt1),AmpSqAhToGluGlu(gt1)) 
Else  
  Call SquareAmp_StoFF(MAh(gt1),MGlu,MGlu,AmpSumAhToGluGlu(:,gt1),AmpSum2AhToGluGlu(:,gt1),AmpSqAhToGluGlu(gt1)) 
End if  
Else  
  AmpSqAhToGluGlu(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqAhToGluGlu(gt1).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAhOS(gt1),MGluOS,MGluOS,helfactor*AmpSqAhToGluGlu(gt1))
Else 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAh(gt1),MGlu,MGlu,helfactor*AmpSqAhToGluGlu(gt1))
End if 
If ((Abs(MRPAhToGluGlu(gt1)).gt.1.0E-20_dp).or.(Abs(MRGAhToGluGlu(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! hh hh
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhhh(MAhOS,MAh2OS,MhhOS,Mhh2OS,ZfAh,               & 
& Zfhh,AmpWaveAhTohhhh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhhh(MAhOS,MAh2OS,MhhOS,Mhh2OS,ZfAh,               & 
& Zfhh,AmpWaveAhTohhhh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhhh(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,           & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhHpmcHpm,          & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSucSuaa,           & 
& AmpVertexAhTohhhh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhhh(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,           & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhHpmcHpm,          & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,               & 
& cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSucSuaa,           & 
& AmpVertexAhTohhhh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhhh(MAh,MAh2,Mhh,Mhh2,ZfAh,Zfhh,AmpWaveAhTohhhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhhh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,            & 
& MSu2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,          & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,        & 
& cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,              & 
& cplcgWpCgWpChh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,              & 
& cplhhhhSecSe1,cplhhhhSucSuaa,AmpVertexAhTohhhh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->hh hh -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTohhhh = 0._dp 
 AmpSum2AhTohhhh = 0._dp  
Else 
 AmpSumAhTohhhh = AmpVertexAhTohhhh + AmpWaveAhTohhhh
 AmpSum2AhTohhhh = AmpVertexAhTohhhh + AmpWaveAhTohhhh 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=gt2,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MhhOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(Mhh(gt2)+Mhh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumAhTohhhh(gt1, gt2, gt3),AmpSum2AhTohhhh(gt1, gt2, gt3),AmpSqAhTohhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),Mhh(gt3),AmpSumAhTohhhh(gt1, gt2, gt3),AmpSum2AhTohhhh(gt1, gt2, gt3),AmpSqAhTohhhh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhTohhhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqAhTohhhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAhOS(gt1),MhhOS(gt2),MhhOS(gt3),helfactor*AmpSqAhTohhhh(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1._dp/2._dp*GammaTPS(MAh(gt1),Mhh(gt2),Mhh(gt3),helfactor*AmpSqAhTohhhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! hh Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhSv(MAhOS,MAh2OS,MhhOS,Mhh2OS,MSvOS,              & 
& MSv2OS,ZfAh,Zfhh,ZfSv,AmpWaveAhTohhSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhSv(MAhOS,MAh2OS,MhhOS,Mhh2OS,MSvOS,              & 
& MSv2OS,ZfAh,Zfhh,ZfSv,AmpWaveAhTohhSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhSv(MAhOS,MFdOS,MFeOS,MhhOS,MSdOS,              & 
& MSeOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,              & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexAhTohhSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhSv(MAhOS,MFdOS,MFeOS,MhhOS,MSdOS,              & 
& MSeOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,              & 
& cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexAhTohhSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhSv(MAh,MAh2,Mhh,Mhh2,MSv,MSv2,ZfAh,              & 
& Zfhh,ZfSv,AmpWaveAhTohhSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhSv(MAh,MFd,MFe,Mhh,MSd,MSe,MSv,MAh2,           & 
& MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFeFehhL,     & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,cplSeSvcSe,       & 
& cplAhSdSvcSdaa,cplAhSeSvcSe1,cplhhSdSvcSdaa,cplhhSeSvcSe1,AmpVertexAhTohhSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->hh Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTohhSv = 0._dp 
 AmpSum2AhTohhSv = 0._dp  
Else 
 AmpSumAhTohhSv = AmpVertexAhTohhSv + AmpWaveAhTohhSv
 AmpSum2AhTohhSv = AmpVertexAhTohhSv + AmpWaveAhTohhSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MhhOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(Mhh(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MhhOS(gt2),MSvOS(gt3),AmpSumAhTohhSv(gt1, gt2, gt3),AmpSum2AhTohhSv(gt1, gt2, gt3),AmpSqAhTohhSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),Mhh(gt2),MSv(gt3),AmpSumAhTohhSv(gt1, gt2, gt3),AmpSum2AhTohhSv(gt1, gt2, gt3),AmpSqAhTohhSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhTohhSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTohhSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MhhOS(gt2),MSvOS(gt3),helfactor*AmpSqAhTohhSv(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),Mhh(gt2),MSv(gt3),helfactor*AmpSqAhTohhSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhTohhSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhTohhVP(cplAhhhVZ,ctcplAhhhVZ,MAhOS,MAh2OS,           & 
& MhhOS,Mhh2OS,MVP,MVP2,MVZOS,MVZ2OS,ZfAh,Zfhh,ZfVP,ZfVZVP,AmpWaveAhTohhVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhVP(cplAhhhVZ,ctcplAhhhVZ,MAhOS,MAh2OS,           & 
& MhhOS,Mhh2OS,MVP,MVP2,MVZOS,MVZ2OS,ZfAh,Zfhh,ZfVP,ZfVZVP,AmpWaveAhTohhVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
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
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,AmpVertexAhTohhVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
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
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,AmpVertexAhTohhVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhTohhVP(cplAhhhVZ,ctcplAhhhVZ,MAh,MAh2,               & 
& Mhh,Mhh2,MVP,MVP2,MVZ,MVZ2,ZfAh,Zfhh,ZfVP,ZfVZVP,AmpWaveAhTohhVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhTohhVP(MAh,MCha,MFd,MFe,MFu,Mhh,MHpm,              & 
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
& cplhhcHpmVPVWm1,AmpVertexAhTohhVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->hh VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhTohhVP = 0._dp 
 AmpSum2AhTohhVP = 0._dp  
Else 
 AmpSumAhTohhVP = AmpVertexAhTohhVP + AmpWaveAhTohhVP
 AmpSum2AhTohhVP = AmpVertexAhTohhVP + AmpWaveAhTohhVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MAhOS(gt1).gt.(MhhOS(gt2)+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(Mhh(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MhhOS(gt2),0._dp,AmpSumAhTohhVP(:,gt1, gt2),AmpSum2AhTohhVP(:,gt1, gt2),AmpSqAhTohhVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),Mhh(gt2),MVP,AmpSumAhTohhVP(:,gt1, gt2),AmpSum2AhTohhVP(:,gt1, gt2),AmpSqAhTohhVP(gt1, gt2)) 
End if  
Else  
  AmpSqAhTohhVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhTohhVP(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MhhOS(gt2),0._dp,helfactor*AmpSqAhTohhVP(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),Mhh(gt2),MVP,helfactor*AmpSqAhTohhVP(gt1, gt2))
End if 
If ((Abs(MRPAhTohhVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhTohhVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToHpmcSe(MAhOS,MAh2OS,MHpmOS,MHpm2OS,MSeOS,          & 
& MSe2OS,ZfAh,ZfHpm,ZfSe,AmpWaveAhToHpmcSe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToHpmcSe(MAhOS,MAh2OS,MHpmOS,MHpm2OS,MSeOS,          & 
& MSe2OS,ZfAh,ZfHpm,ZfSe,AmpWaveAhToHpmcSe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToHpmcSe(MAhOS,MFdOS,MFeOS,MFuOS,MHpmOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,    & 
& cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,           & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,    & 
& cplAhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,AmpVertexAhToHpmcSe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToHpmcSe(MAhOS,MFdOS,MFeOS,MFuOS,MHpmOS,           & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,    & 
& cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,           & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,    & 
& cplAhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,AmpVertexAhToHpmcSe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToHpmcSe(MAh,MAh2,MHpm,MHpm2,MSe,MSe2,               & 
& ZfAh,ZfHpm,ZfSe,AmpWaveAhToHpmcSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToHpmcSe(MAh,MFd,MFe,MFu,MHpm,MSd,MSe,             & 
& MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,             & 
& cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,cplAhSecSecSv1,cplHpmSdcSdcSeaa,        & 
& cplHpmSecSecSe1,cplHpmSucSecSuaa,AmpVertexAhToHpmcSe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Hpm conj[Se] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToHpmcSe = 0._dp 
 AmpSum2AhToHpmcSe = 0._dp  
Else 
 AmpSumAhToHpmcSe = AmpVertexAhToHpmcSe + AmpWaveAhToHpmcSe
 AmpSum2AhToHpmcSe = AmpVertexAhToHpmcSe + AmpWaveAhToHpmcSe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=2,2
    Do gt3=1,6
If (((OSkinematics).and.(MAhOS(gt1).gt.(MHpmOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MHpm(gt2)+MSe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumAhToHpmcSe(gt1, gt2, gt3),AmpSum2AhToHpmcSe(gt1, gt2, gt3),AmpSqAhToHpmcSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MHpm(gt2),MSe(gt3),AmpSumAhToHpmcSe(gt1, gt2, gt3),AmpSum2AhToHpmcSe(gt1, gt2, gt3),AmpSqAhToHpmcSe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToHpmcSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToHpmcSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MHpmOS(gt2),MSeOS(gt3),helfactor*AmpSqAhToHpmcSe(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MHpm(gt2),MSe(gt3),helfactor*AmpSqAhToHpmcSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToHpmcSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToHpmcSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToSecVWm(MAhOS,MAh2OS,MSeOS,MSe2OS,MVWmOS,           & 
& MVWm2OS,ZfAh,ZfSe,ZfVWm,AmpWaveAhToSecVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToSecVWm(MAhOS,MAh2OS,MSeOS,MSe2OS,MVWmOS,           & 
& MVWm2OS,ZfAh,ZfSe,ZfVWm,AmpWaveAhToSecVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSecVWm(MAhOS,MFdOS,MFeOS,MFuOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,AmpVertexAhToSecVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSecVWm(MAhOS,MFdOS,MFeOS,MFuOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,AmpVertexAhToSecVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToSecVWm(MAh,MAh2,MSe,MSe2,MVWm,MVWm2,               & 
& ZfAh,ZfSe,ZfVWm,AmpWaveAhToSecVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSecVWm(MAh,MFd,MFe,MFu,MSd,MSe,MSu,              & 
& MSv,MVWm,MAh2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdAhL,cplcFdFdAhR,        & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,               & 
& AmpVertexAhToSecVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Se conj[VWm] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToSecVWm = 0._dp 
 AmpSum2AhToSecVWm = 0._dp  
Else 
 AmpSumAhToSecVWm = AmpVertexAhToSecVWm + AmpWaveAhToSecVWm
 AmpSum2AhToSecVWm = AmpVertexAhToSecVWm + AmpWaveAhToSecVWm 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSeOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSe(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MSeOS(gt2),MVWmOS,AmpSumAhToSecVWm(:,gt1, gt2),AmpSum2AhToSecVWm(:,gt1, gt2),AmpSqAhToSecVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MSe(gt2),MVWm,AmpSumAhToSecVWm(:,gt1, gt2),AmpSum2AhToSecVWm(:,gt1, gt2),AmpSqAhToSecVWm(gt1, gt2)) 
End if  
Else  
  AmpSqAhToSecVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToSecVWm(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MSeOS(gt2),MVWmOS,helfactor*AmpSqAhToSecVWm(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MSe(gt2),MVWm,helfactor*AmpSqAhToSecVWm(gt1, gt2))
End if 
If ((Abs(MRPAhToSecVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToSecVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToSvSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveAhToSvSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveAhToSvSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvSv(MAhOS,MChiOS,MFdOS,MFeOS,MSdOS,             & 
& MSeOS,MSvOS,MAh2OS,MChi2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplChiChiAhL,            & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,               & 
& cplAhSecSe,cplChiFvSvL,cplChiFvSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,    & 
& cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,AmpVertexAhToSvSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvSv(MAhOS,MChiOS,MFdOS,MFeOS,MSdOS,             & 
& MSeOS,MSvOS,MAh2OS,MChi2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplChiChiAhL,            & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,               & 
& cplAhSecSe,cplChiFvSvL,cplChiFvSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,    & 
& cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,AmpVertexAhToSvSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,AmpWaveAhToSvSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvSv(MAh,MChi,MFd,MFe,MSd,MSe,MSv,               & 
& MAh2,MChi2,MFd2,MFe2,MSd2,MSe2,MSv2,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,             & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplChiFvSvL,cplChiFvSvR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,  & 
& cplAhSeSvcSe1,AmpVertexAhToSvSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Sv Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToSvSv = 0._dp 
 AmpSum2AhToSvSv = 0._dp  
Else 
 AmpSumAhToSvSv = AmpVertexAhToSvSv + AmpWaveAhToSvSv
 AmpSum2AhToSvSv = AmpVertexAhToSvSv + AmpWaveAhToSvSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=gt2,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSvOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSv(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumAhToSvSv(gt1, gt2, gt3),AmpSum2AhToSvSv(gt1, gt2, gt3),AmpSqAhToSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSv(gt2),MSv(gt3),AmpSumAhToSvSv(gt1, gt2, gt3),AmpSum2AhToSvSv(gt1, gt2, gt3),AmpSqAhToSvSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToSvSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqAhToSvSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MSvOS(gt2),MSvOS(gt3),helfactor*AmpSqAhToSvSv(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MSv(gt2),MSv(gt3),helfactor*AmpSqAhToSvSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToSvVP(MAhOS,MAh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& ZfAh,ZfSv,ZfVP,AmpWaveAhToSvVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvVP(MAhOS,MAh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& ZfAh,ZfSv,ZfVP,AmpWaveAhToSvVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvVP(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdAhL,cplcFdFdAhR,      & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,     & 
& cplcFdFdVPR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplSdSvcSd,cplSdcSdVP,     & 
& cplSeSvcSe,cplSecSeVP,AmpVertexAhToSvVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvVP(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdAhL,cplcFdFdAhR,      & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,     & 
& cplcFdFdVPR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplSdSvcSd,cplSdcSdVP,     & 
& cplSeSvcSe,cplSecSeVP,AmpVertexAhToSvVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvVP(MAh,MAh2,MSv,MSv2,MVP,MVP2,ZfAh,              & 
& ZfSv,ZfVP,AmpWaveAhToSvVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvVP(MAh,MFd,MFe,MSd,MSe,MSv,MVP,MAh2,           & 
& MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeSvL,     & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplSdSvcSd,cplSdcSdVP,cplSeSvcSe,cplSecSeVP,       & 
& AmpVertexAhToSvVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Sv VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToSvVP = 0._dp 
 AmpSum2AhToSvVP = 0._dp  
Else 
 AmpSumAhToSvVP = AmpVertexAhToSvVP + AmpWaveAhToSvVP
 AmpSum2AhToSvVP = AmpVertexAhToSvVP + AmpWaveAhToSvVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSvOS(gt2)+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSv(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MSvOS(gt2),0._dp,AmpSumAhToSvVP(:,gt1, gt2),AmpSum2AhToSvVP(:,gt1, gt2),AmpSqAhToSvVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MSv(gt2),MVP,AmpSumAhToSvVP(:,gt1, gt2),AmpSum2AhToSvVP(:,gt1, gt2),AmpSqAhToSvVP(gt1, gt2)) 
End if  
Else  
  AmpSqAhToSvVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToSvVP(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MSvOS(gt2),0._dp,helfactor*AmpSqAhToSvVP(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MSv(gt2),MVP,helfactor*AmpSqAhToSvVP(gt1, gt2))
End if 
If ((Abs(MRPAhToSvVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToSvVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToSvVZ(MAhOS,MAh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,ZfAh,ZfSv,ZfVZ,AmpWaveAhToSvVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvVZ(MAhOS,MAh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,ZfAh,ZfSv,ZfVZ,AmpWaveAhToSvVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvVZ(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,     & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,cplSecSeVZ,AmpVertexAhToSvVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvVZ(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,     & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,cplSecSeVZ,AmpVertexAhToSvVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvVZ(MAh,MAh2,MSv,MSv2,MVZ,MVZ2,ZfAh,              & 
& ZfSv,ZfVZ,AmpWaveAhToSvVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvVZ(MAh,MFd,MFe,MSd,MSe,MSv,MVZ,MAh2,           & 
& MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeSvL,     & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,cplSecSeVZ,       & 
& AmpVertexAhToSvVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Sv VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToSvVZ = 0._dp 
 AmpSum2AhToSvVZ = 0._dp  
Else 
 AmpSumAhToSvVZ = AmpVertexAhToSvVZ + AmpWaveAhToSvVZ
 AmpSum2AhToSvVZ = AmpVertexAhToSvVZ + AmpWaveAhToSvVZ 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSvOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSv(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MAhOS(gt1),MSvOS(gt2),MVZOS,AmpSumAhToSvVZ(:,gt1, gt2),AmpSum2AhToSvVZ(:,gt1, gt2),AmpSqAhToSvVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MAh(gt1),MSv(gt2),MVZ,AmpSumAhToSvVZ(:,gt1, gt2),AmpSum2AhToSvVZ(:,gt1, gt2),AmpSqAhToSvVZ(gt1, gt2)) 
End if  
Else  
  AmpSqAhToSvVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToSvVZ(gt1, gt2).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MSvOS(gt2),MVZOS,helfactor*AmpSqAhToSvVZ(gt1, gt2))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MSv(gt2),MVZ,helfactor*AmpSqAhToSvVZ(gt1, gt2))
End if 
If ((Abs(MRPAhToSvVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGAhToSvVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Sv Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvcSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,              & 
& ZfSv,AmpWaveAhToSvcSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvcSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,              & 
& ZfSv,AmpWaveAhToSvcSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvcSv(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,           & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,              & 
& MFd2OS,MFe2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,MVZ2OS,               & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFvSvL,cplChiFvSvR,             & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,     & 
& cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplAhSdSvcSdaa,cplAhSdcSdcSvaa,     & 
& cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,         & 
& cplSeSvcSecSv1,cplSuSvcSucSvaa,AmpVertexAhToSvcSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvcSv(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,           & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,              & 
& MFd2OS,MFe2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,MVZ2OS,               & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFvSvL,cplChiFvSvR,             & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,     & 
& cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplAhSdSvcSdaa,cplAhSdcSdcSvaa,     & 
& cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,         & 
& cplSeSvcSecSv1,cplSuSvcSucSvaa,AmpVertexAhToSvcSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToSvcSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,AmpWaveAhToSvcSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToSvcSv(MAh,MCha,MChi,MFd,MFe,Mhh,MHpm,            & 
& MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,              & 
& MSu2,MSv2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,            & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,               & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,               & 
& cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,               & 
& cplAhHpmSvcSe1,cplAhSdSvcSdaa,cplAhSdcSdcSvaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,           & 
& cplAhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,        & 
& AmpVertexAhToSvcSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->Sv conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToSvcSv = 0._dp 
 AmpSum2AhToSvcSv = 0._dp  
Else 
 AmpSumAhToSvcSv = AmpVertexAhToSvcSv + AmpWaveAhToSvcSv
 AmpSum2AhToSvcSv = AmpVertexAhToSvcSv + AmpWaveAhToSvcSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MAhOS(gt1).gt.(MSvOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MSv(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MAhOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumAhToSvcSv(gt1, gt2, gt3),AmpSum2AhToSvcSv(gt1, gt2, gt3),AmpSqAhToSvcSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MAh(gt1),MSv(gt2),MSv(gt3),AmpSumAhToSvcSv(gt1, gt2, gt3),AmpSum2AhToSvcSv(gt1, gt2, gt3),AmpSqAhToSvcSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqAhToSvcSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToSvcSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MSvOS(gt2),MSvOS(gt3),helfactor*AmpSqAhToSvcSv(gt1, gt2, gt3))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MSv(gt2),MSv(gt3),helfactor*AmpSqAhToSvcSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPAhToSvcSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGAhToSvcSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VG VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhToVGVG(MAhOS,MAh2OS,MVG,MVG2,ZfAh,ZfVG,              & 
& AmpWaveAhToVGVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToVGVG(MAhOS,MAh2OS,MVG,MVG2,ZfAh,ZfVG,              & 
& AmpWaveAhToVGVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVGVG(MAhOS,MFdOS,MFuOS,MSdOS,MSuOS,              & 
& MVG,MAh2OS,MFd2OS,MFu2OS,MSd2OS,MSu2OS,MVG2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,       & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSucSu,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,     & 
& cplSdcSdVG,cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexAhToVGVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVGVG(MAhOS,MFdOS,MFuOS,MSdOS,MSuOS,              & 
& MVG,MAh2OS,MFd2OS,MFu2OS,MSd2OS,MSu2OS,MVG2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,       & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSucSu,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,     & 
& cplSdcSdVG,cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexAhToVGVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToVGVG(MAh,MAh2,MVG,MVG2,ZfAh,ZfVG,AmpWaveAhToVGVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVGVG(MAh,MFd,MFu,MSd,MSu,MVG,MAh2,               & 
& MFd2,MFu2,MSd2,MSu2,MVG2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,              & 
& cplAhSdcSd,cplAhSucSu,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplSdcSdVG,      & 
& cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexAhToVGVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->VG VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToVGVG = 0._dp 
 AmpSum2AhToVGVG = 0._dp  
Else 
 AmpSumAhToVGVG = AmpVertexAhToVGVG + AmpWaveAhToVGVG
 AmpSum2AhToVGVG = AmpVertexAhToVGVG + AmpWaveAhToVGVG 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MAhOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MVG+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MAhOS(gt1),0._dp,0._dp,AmpSumAhToVGVG(:,gt1),AmpSum2AhToVGVG(:,gt1),AmpSqAhToVGVG(gt1)) 
Else  
  Call SquareAmp_StoVV(MAh(gt1),MVG,MVG,AmpSumAhToVGVG(:,gt1),AmpSum2AhToVGVG(:,gt1),AmpSqAhToVGVG(gt1)) 
End if  
Else  
  AmpSqAhToVGVG(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToVGVG(gt1).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),0._dp,0._dp,helfactor*AmpSqAhToVGVG(gt1))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MVG,MVG,helfactor*AmpSqAhToVGVG(gt1))
End if 
If ((Abs(MRPAhToVGVG(gt1)).gt.1.0E-20_dp).or.(Abs(MRGAhToVGVG(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToVPVP(MAhOS,MAh2OS,MVP,MVP2,ZfAh,ZfVP,              & 
& AmpWaveAhToVPVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToVPVP(MAhOS,MAh2OS,MVP,MVP2,ZfAh,ZfVP,              & 
& AmpWaveAhToVPVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVPVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,          & 
& cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,          & 
& cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,               & 
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplHpmcHpmVPVP1,cplSdcSdVPVPaa,cplSecSeVPVP1,          & 
& cplSucSuVPVPaa,AmpVertexAhToVPVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVPVP(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,               & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,          & 
& cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,          & 
& cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,               & 
& cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplHpmcHpmVPVP1,cplSdcSdVPVPaa,cplSecSeVPVP1,          & 
& cplSucSuVPVPaa,AmpVertexAhToVPVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToVPVP(MAh,MAh2,MVP,MVP2,ZfAh,ZfVP,AmpWaveAhToVPVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVPVP(MAh,MCha,MFd,MFe,MFu,MHpm,MSd,              & 
& MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVP2,MVWm2,            & 
& cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,             & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,           & 
& cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplHpmcHpmVPVP1,  & 
& cplSdcSdVPVPaa,cplSecSeVPVP1,cplSucSuVPVPaa,AmpVertexAhToVPVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->VP VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToVPVP = 0._dp 
 AmpSum2AhToVPVP = 0._dp  
Else 
 AmpSumAhToVPVP = AmpVertexAhToVPVP + AmpWaveAhToVPVP
 AmpSum2AhToVPVP = AmpVertexAhToVPVP + AmpWaveAhToVPVP 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MAhOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MVP+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MAhOS(gt1),0._dp,0._dp,AmpSumAhToVPVP(:,gt1),AmpSum2AhToVPVP(:,gt1),AmpSqAhToVPVP(gt1)) 
Else  
  Call SquareAmp_StoVV(MAh(gt1),MVP,MVP,AmpSumAhToVPVP(:,gt1),AmpSum2AhToVPVP(:,gt1),AmpSqAhToVPVP(gt1)) 
End if  
Else  
  AmpSqAhToVPVP(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToVPVP(gt1).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),0._dp,0._dp,helfactor*AmpSqAhToVPVP(gt1))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MVP,MVP,helfactor*AmpSqAhToVPVP(gt1))
End if 
If ((Abs(MRPAhToVPVP(gt1)).gt.1.0E-20_dp).or.(Abs(MRGAhToVPVP(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
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
Call Amplitude_WAVE_MSSMTriLnV_AhToVPVZ(MAhOS,MAh2OS,MVP,MVP2,MVZOS,MVZ2OS,           & 
& ZfAh,ZfVP,ZfVZ,AmpWaveAhToVPVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToVPVZ(MAhOS,MAh2OS,MVP,MVP2,MVZOS,MVZ2OS,           & 
& ZfAh,ZfVP,ZfVZ,AmpWaveAhToVPVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVPVZ(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,         & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,          & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplHpmcHpmVP,cplHpmcVWmVP,     & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,cplSdcSdVZ,cplSecSeVP,cplSecSeVZ,cplSucSuVP,      & 
& cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,        & 
& cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,        & 
& cplSecSeVPVZ1,cplSucSuVPVZaa,AmpVertexAhToVPVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVPVZ(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,             & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,         & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,          & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplHpmcHpmVP,cplHpmcVWmVP,     & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,cplSdcSdVZ,cplSecSeVP,cplSecSeVZ,cplSucSuVP,      & 
& cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,        & 
& cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,        & 
& cplSecSeVPVZ1,cplSucSuVPVZaa,AmpVertexAhToVPVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToVPVZ(MAh,MAh2,MVP,MVP2,MVZ,MVZ2,ZfAh,              & 
& ZfVP,ZfVZ,AmpWaveAhToVPVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVPVZ(MAh,MCha,MFd,MFe,MFu,MHpm,MSd,              & 
& MSe,MSu,MVP,MVWm,MVZ,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVP2,              & 
& MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,              & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,         & 
& cplcFdFdVZR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpCVP,          & 
& cplcgWpCgWpCVZ,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,         & 
& cplSdcSdVZ,cplSecSeVP,cplSecSeVZ,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,      & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,             & 
& cplAhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,cplSecSeVPVZ1,cplSucSuVPVZaa,           & 
& AmpVertexAhToVPVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->VP VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToVPVZ = 0._dp 
 AmpSum2AhToVPVZ = 0._dp  
Else 
 AmpSumAhToVPVZ = AmpVertexAhToVPVZ + AmpWaveAhToVPVZ
 AmpSum2AhToVPVZ = AmpVertexAhToVPVZ + AmpWaveAhToVPVZ 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MAhOS(gt1).gt.(0.+MVZOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MVP+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MAhOS(gt1),0._dp,MVZOS,AmpSumAhToVPVZ(:,gt1),AmpSum2AhToVPVZ(:,gt1),AmpSqAhToVPVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(MAh(gt1),MVP,MVZ,AmpSumAhToVPVZ(:,gt1),AmpSum2AhToVPVZ(:,gt1),AmpSqAhToVPVZ(gt1)) 
End if  
Else  
  AmpSqAhToVPVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToVPVZ(gt1).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),0._dp,MVZOS,helfactor*AmpSqAhToVPVZ(gt1))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MVP,MVZ,helfactor*AmpSqAhToVPVZ(gt1))
End if 
If ((Abs(MRPAhToVPVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGAhToVPVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VWm Conjg(VWm)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhToVWmcVWm(MAhOS,MAh2OS,MVWmOS,MVWm2OS,               & 
& ZfAh,ZfVWm,AmpWaveAhToVWmcVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToVWmcVWm(MAhOS,MAh2OS,MVWmOS,MVWm2OS,               & 
& ZfAh,ZfVWm,AmpWaveAhToVWmcVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVWmcVWm(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,           & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,   & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWmgAVWm,cplcgWpCgAcVWm,       & 
& cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcVWm,   & 
& cplhhHpmcVWm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,         & 
& cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,               & 
& AmpVertexAhToVWmcVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVWmcVWm(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,         & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,cplChiChacVWmR,           & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,   & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWmgAVWm,cplcgWpCgAcVWm,       & 
& cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcVWm,   & 
& cplhhHpmcVWm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,         & 
& cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,               & 
& AmpVertexAhToVWmcVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToVWmcVWm(MAh,MAh2,MVWm,MVWm2,ZfAh,ZfVWm,            & 
& AmpWaveAhToVWmcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVWmcVWm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,             & 
& cplChiChacVWmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,cplcgZgWpCVWm,   & 
& cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcVWmVP,       & 
& cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,           & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,& 
& cplAhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,& 
& AmpVertexAhToVWmcVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->VWm conj[VWm] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToVWmcVWm = 0._dp 
 AmpSum2AhToVWmcVWm = 0._dp  
Else 
 AmpSumAhToVWmcVWm = AmpVertexAhToVWmcVWm + AmpWaveAhToVWmcVWm
 AmpSum2AhToVWmcVWm = AmpVertexAhToVWmcVWm + AmpWaveAhToVWmcVWm 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MAhOS(gt1).gt.(MVWmOS+MVWmOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MVWm+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MAhOS(gt1),MVWmOS,MVWmOS,AmpSumAhToVWmcVWm(:,gt1),AmpSum2AhToVWmcVWm(:,gt1),AmpSqAhToVWmcVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MAh(gt1),MVWm,MVWm,AmpSumAhToVWmcVWm(:,gt1),AmpSum2AhToVWmcVWm(:,gt1),AmpSqAhToVWmcVWm(gt1)) 
End if  
Else  
  AmpSqAhToVWmcVWm(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToVWmcVWm(gt1).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAhOS(gt1),MVWmOS,MVWmOS,helfactor*AmpSqAhToVWmcVWm(gt1))
Else 
  gP1LAh(gt1,i4) = 2*GammaTPS(MAh(gt1),MVWm,MVWm,helfactor*AmpSqAhToVWmcVWm(gt1))
End if 
If ((Abs(MRPAhToVWmcVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGAhToVWmcVWm(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
!---------------- 
! VZ VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_AhToVZVZ(MAhOS,MAh2OS,MVZOS,MVZ2OS,ZfAh,               & 
& ZfVZ,AmpWaveAhToVZVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_AhToVZVZ(MAhOS,MAh2OS,MVZOS,MVZ2OS,ZfAh,               & 
& ZfVZ,AmpWaveAhToVZVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVZVZ(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVZL,              & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,           & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,cplcgWpCgWpCVZ,cplHpmcHpmVZ,          & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,               & 
& cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplHpmcHpmVZVZ1,cplSdcSdVZVZaa,cplSecSeVZVZ1,          & 
& cplSucSuVZVZaa,AmpVertexAhToVZVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVZVZ(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MHpmOS,MSdOS,MSeOS,MSuOS,MVWmOS,MVZOS,MAh2OS,MCha2OS,MChi2OS,MFd2OS,             & 
& MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MVWm2OS,MVZ2OS,cplcChaChaAhL,               & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVZL,              & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,           & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,cplcgWpCgWpCVZ,cplHpmcHpmVZ,          & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,               & 
& cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplHpmcHpmVZVZ1,cplSdcSdVZVZaa,cplSecSeVZVZ1,          & 
& cplSucSuVZVZaa,AmpVertexAhToVZVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_AhToVZVZ(MAh,MAh2,MVZ,MVZ2,ZfAh,ZfVZ,AmpWaveAhToVZVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_AhToVZVZ(MAh,MCha,MChi,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,             & 
& MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,          & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,        & 
& cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,              & 
& cplcgWpCgWpCVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,             & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplHpmcHpmVZVZ1,             & 
& cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,AmpVertexAhToVZVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Ah->VZ VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumAhToVZVZ = 0._dp 
 AmpSum2AhToVZVZ = 0._dp  
Else 
 AmpSumAhToVZVZ = AmpVertexAhToVZVZ + AmpWaveAhToVZVZ
 AmpSum2AhToVZVZ = AmpVertexAhToVZVZ + AmpWaveAhToVZVZ 
End If 
Do gt1=1,2
i4 = isave 
If (((OSkinematics).and.(MAhOS(gt1).gt.(MVZOS+MVZOS))).or.((.not.OSkinematics).and.(MAh(gt1).gt.(MVZ+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MAhOS(gt1),MVZOS,MVZOS,AmpSumAhToVZVZ(:,gt1),AmpSum2AhToVZVZ(:,gt1),AmpSqAhToVZVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(MAh(gt1),MVZ,MVZ,AmpSumAhToVZVZ(:,gt1),AmpSum2AhToVZVZ(:,gt1),AmpSqAhToVZVZ(gt1)) 
End if  
Else  
  AmpSqAhToVZVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqAhToVZVZ(gt1).eq.0._dp) Then 
  gP1LAh(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAhOS(gt1),MVZOS,MVZOS,helfactor*AmpSqAhToVZVZ(gt1))
Else 
  gP1LAh(gt1,i4) = 1*GammaTPS(MAh(gt1),MVZ,MVZ,helfactor*AmpSqAhToVZVZ(gt1))
End if 
If ((Abs(MRPAhToVZVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGAhToVZVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LAh(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.2) isave = i4 
End do
End Subroutine OneLoopDecay_Ah

End Module Wrapper_OneLoopDecay_Ah_MSSMTriLnV
