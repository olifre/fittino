! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Sv_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Sv_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Sv(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& ZfVPVZ,ZfVZVP,cplAhAhhh,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSvcSv1,cplAhcHpmVWm,       & 
& cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhHpmSvcSe1,cplAhSdcSd,cplAhSdcSdcSvaa,         & 
& cplAhSdSvcSdaa,cplAhSecHpmcSv1,cplAhSecSe,cplAhSecSecSv1,cplAhSeSvcSe1,cplAhSucSu,     & 
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
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplChaFucSdL,      & 
& cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,         & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplChiFvSvL,cplChiFvSvR,cplcHpmVPVWm,cplcHpmVWmVZ,cplcVWmVPVWm,cplcVWmVWmVZ,           & 
& cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,             & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,cplGluFdcSdR,cplhhcHpmVWm,cplhhcVWmVWm,             & 
& cplhhhhhh,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhhhSvcSv1,cplhhHpmcHpm,cplhhHpmcVWm,        & 
& cplhhHpmSvcSe1,cplhhSdcSd,cplhhSdcSdcSvaa,cplhhSdSvcSdaa,cplhhSecHpmcSv1,              & 
& cplhhSecSe,cplhhSecSecSv1,cplhhSeSvcSe1,cplhhSucSu,cplhhSvcSv,cplhhVZVZ,               & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmSdcHpmcSdaa,cplHpmSdcSdcSeaa,& 
& cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSucSd,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,        & 
& cplHpmSvcHpmcSv1,cplHpmSvcSe,cplHpmSvcSecSv1,cplSdcHpmcSu,cplSdcHpmcSucSvaa,           & 
& cplSdcSdcSv,cplSdcSdcVWmVWmaa,cplSdcSdVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,    & 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSdcSdVP,cplSdcSdVPVPaa,cplSdcSdVPVZaa,    & 
& cplSdcSdVZ,cplSdcSdVZVZaa,cplSdcSecSu,cplSdcSucVWm,cplSdSdcSdcSdabab,cplSdSdcSdcSdabba,& 
& cplSdSecHpmcSdaa,cplSdSecSdcSeaa,cplSdSucSdcSuabab,cplSdSucSdcSuabba,cplSdSvcSd,       & 
& cplSdSvcSdcSvaa,cplSecHpmcSv,cplSecSecSv,cplSecSecVWmVWm1,cplSecSeVP,cplSecSeVPVP1,    & 
& cplSecSeVPVZ1,cplSecSeVZ,cplSecSeVZVZ1,cplSecSvcVWm,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,   & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSucSd,cplSeSucSdcSvaa,cplSeSucSecSuaa,             & 
& cplSeSvcHpmcSv1,cplSeSvcSe,cplSeSvcSecSv1,cplSucSdVWm,cplSuSvcSucSvaa,cplSvcSeVPVWm1,  & 
& cplSvcSeVWm,cplSvcSeVWmVZ1,cplSvcSvcVWmVWm1,cplSvcSvVZ,cplSvcSvVZVZ1,cplSvSvcSvcSv1,   & 
& ctcplcChaFecSvL,ctcplcChaFecSvR,ctcplcFdFdcSvL,ctcplcFdFdcSvR,ctcplcFeFecSvL,          & 
& ctcplcFeFecSvR,ctcplChiFvcSvL,ctcplChiFvcSvR,ctcplhhSvcSv,ctcplSdcSdcSv,               & 
& ctcplSecHpmcSv,ctcplSecSecSv,ctcplSecSvcVWm,ctcplSvcSvVZ,GcplcHpmVPVWm,GcplHpmcVWmVP,  & 
& GcplSecHpmcSv,GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,GosZcplSecHpmcSv,GZcplcHpmVPVWm,       & 
& GZcplHpmcVWmVP,GZcplSecHpmcSv,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFdFdcSvL,             & 
& ZcplcFdFdcSvR,ZcplcFeFecSvL,ZcplcFeFecSvR,ZcplChiFvcSvL,ZcplChiFvcSvR,ZcplhhSvcSv,     & 
& ZcplSdcSdcSv,ZcplSecHpmcSv,ZcplSecSecSv,ZcplSecSvcVWm,ZcplSvcSvVZ,ZRUZD,               & 
& ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,            & 
& ZRUZDR,ZRUZUL,ZRUZUR,MLambda,em,gs,deltaM,kont,gP1LSv)

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

Complex(dp),Intent(in) :: cplAhAhhh(2,2,2),cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),cplAhAhSvcSv1(2,2,3,3),& 
& cplAhcHpmVWm(2,2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhHpmSvcSe1(2,2,3,6),& 
& cplAhSdcSd(2,6,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSdSvcSdaa(2,6,3,6),cplAhSecHpmcSv1(2,6,2,3),& 
& cplAhSecSe(2,6,6),cplAhSecSecSv1(2,6,6,3),cplAhSeSvcSe1(2,6,3,6),cplAhSucSu(2,6,6),    & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),   & 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),       & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),     & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),     & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),     & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),         & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),  & 
& cplcFdFdVZR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),            & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),           & 
& cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFeChaSvL(3,2,3),         & 
& cplcFeChaSvR(3,2,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFdcSuL(3,3,6),       & 
& cplcFeFdcSuR(3,3,6),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),         & 
& cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),         & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),   & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),       & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,cplFeFucSdL(3,3,6),          & 
& cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),         & 
& cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),& 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhhhhh(2,2,2),& 
& cplhhhhSdcSdaa(2,2,6,6),cplhhhhSecSe1(2,2,6,6),cplhhhhSvcSv1(2,2,3,3),cplhhHpmcHpm(2,2,2),& 
& cplhhHpmcVWm(2,2),cplhhHpmSvcSe1(2,2,3,6),cplhhSdcSd(2,6,6),cplhhSdcSdcSvaa(2,6,6,3),  & 
& cplhhSdSvcSdaa(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSe(2,6,6),cplhhSecSecSv1(2,6,6,3)

Complex(dp),Intent(in) :: cplhhSeSvcSe1(2,6,3,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhVZVZ(2),               & 
& cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplHpmSdcHpmcSdaa(2,6,2,6),& 
& cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSecHpmcSe1(2,6,2,6),cplHpmSecSecSe1(2,6,6,6),          & 
& cplHpmSucSd(2,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplHpmSucSecSuaa(2,6,6,6),cplHpmSvcHpmcSv1(2,3,2,3),& 
& cplHpmSvcSe(2,3,6),cplHpmSvcSecSv1(2,3,6,3),cplSdcHpmcSu(6,2,6),cplSdcHpmcSucSvaa(6,2,6,3),& 
& cplSdcSdcSv(6,6,3),cplSdcSdcVWmVWmaa(6,6),cplSdcSdVG(6,6),cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSdcSdVP(6,6),cplSdcSdVPVPaa(6,6),    & 
& cplSdcSdVPVZaa(6,6),cplSdcSdVZ(6,6),cplSdcSdVZVZaa(6,6),cplSdcSecSu(6,6,6),            & 
& cplSdcSucVWm(6,6),cplSdSdcSdcSdabab(6,6,6,6),cplSdSdcSdcSdabba(6,6,6,6),               & 
& cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),         & 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSvcSd(6,3,6),cplSdSvcSdcSvaa(6,3,6,3),cplSecHpmcSv(6,2,3),& 
& cplSecSecSv(6,6,3),cplSecSecVWmVWm1(6,6),cplSecSeVP(6,6),cplSecSeVPVP1(6,6),           & 
& cplSecSeVPVZ1(6,6),cplSecSeVZ(6,6),cplSecSeVZVZ1(6,6),cplSecSvcVWm(6,3),               & 
& cplSecSvcVWmVP1(6,3),cplSecSvcVWmVZ1(6,3),cplSeSecHpmcSe1(6,6,2,6),cplSeSecSecSe1(6,6,6,6),& 
& cplSeSucSd(6,6,6),cplSeSucSdcSvaa(6,6,6,3),cplSeSucSecSuaa(6,6,6,6),cplSeSvcHpmcSv1(6,3,2,3),& 
& cplSeSvcSe(6,3,6),cplSeSvcSecSv1(6,3,6,3),cplSucSdVWm(6,6),cplSuSvcSucSvaa(6,3,6,3),   & 
& cplSvcSeVPVWm1(3,6),cplSvcSeVWm(3,6),cplSvcSeVWmVZ1(3,6),cplSvcSvcVWmVWm1(3,3),        & 
& cplSvcSvVZ(3,3),cplSvcSvVZVZ1(3,3),cplSvSvcSvcSv1(3,3,3,3),ctcplcChaFecSvL(2,3,3),     & 
& ctcplcChaFecSvR(2,3,3),ctcplcFdFdcSvL(3,3,3),ctcplcFdFdcSvR(3,3,3),ctcplcFeFecSvL(3,3,3),& 
& ctcplcFeFecSvR(3,3,3),ctcplChiFvcSvL(4,3,3),ctcplChiFvcSvR(4,3,3),ctcplhhSvcSv(2,3,3), & 
& ctcplSdcSdcSv(6,6,3),ctcplSecHpmcSv(6,2,3),ctcplSecSecSv(6,6,3),ctcplSecSvcVWm(6,3),   & 
& ctcplSvcSvVZ(3,3),GcplcHpmVPVWm(2),GcplHpmcVWmVP(2),GcplSecHpmcSv(6,2,3),              & 
& GosZcplcHpmVPVWm(2),GosZcplHpmcVWmVP(2),GosZcplSecHpmcSv(6,2,3),GZcplcHpmVPVWm(2),     & 
& GZcplHpmcVWmVP(2),GZcplSecHpmcSv(6,2,3),ZcplcChaFecSvL(2,3,3),ZcplcChaFecSvR(2,3,3),   & 
& ZcplcFdFdcSvL(3,3,3),ZcplcFdFdcSvR(3,3,3),ZcplcFeFecSvL(3,3,3),ZcplcFeFecSvR(3,3,3),   & 
& ZcplChiFvcSvL(4,3,3),ZcplChiFvcSvR(4,3,3),ZcplhhSvcSv(2,3,3),ZcplSdcSdcSv(6,6,3),      & 
& ZcplSecHpmcSv(6,2,3),ZcplSecSecSv(6,6,3),ZcplSecSvcVWm(6,3),ZcplSvcSvVZ(3,3)

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
Real(dp), Intent(out) :: gP1LSv(3,235) 
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
Real(dp) :: MRPSvToFvChi(3,3,4),MRGSvToFvChi(3,3,4), MRPZSvToFvChi(3,3,4),MRGZSvToFvChi(3,3,4) 
Real(dp) :: MVPSvToFvChi(3,3,4) 
Real(dp) :: RMsqTreeSvToFvChi(3,3,4),RMsqWaveSvToFvChi(3,3,4),RMsqVertexSvToFvChi(3,3,4) 
Complex(dp) :: AmpTreeSvToFvChi(2,3,3,4),AmpWaveSvToFvChi(2,3,3,4),AmpVertexSvToFvChi(2,3,3,4)& 
 & ,AmpVertexIRosSvToFvChi(2,3,3,4),AmpVertexIRdrSvToFvChi(2,3,3,4), AmpSumSvToFvChi(2,3,3,4), AmpSum2SvToFvChi(2,3,3,4) 
Complex(dp) :: AmpTreeZSvToFvChi(2,3,3,4),AmpWaveZSvToFvChi(2,3,3,4),AmpVertexZSvToFvChi(2,3,3,4) 
Real(dp) :: AmpSqSvToFvChi(3,3,4),  AmpSqTreeSvToFvChi(3,3,4) 
Real(dp) :: MRPSvTocFdFd(3,3,3),MRGSvTocFdFd(3,3,3), MRPZSvTocFdFd(3,3,3),MRGZSvTocFdFd(3,3,3) 
Real(dp) :: MVPSvTocFdFd(3,3,3) 
Real(dp) :: RMsqTreeSvTocFdFd(3,3,3),RMsqWaveSvTocFdFd(3,3,3),RMsqVertexSvTocFdFd(3,3,3) 
Complex(dp) :: AmpTreeSvTocFdFd(2,3,3,3),AmpWaveSvTocFdFd(2,3,3,3),AmpVertexSvTocFdFd(2,3,3,3)& 
 & ,AmpVertexIRosSvTocFdFd(2,3,3,3),AmpVertexIRdrSvTocFdFd(2,3,3,3), AmpSumSvTocFdFd(2,3,3,3), AmpSum2SvTocFdFd(2,3,3,3) 
Complex(dp) :: AmpTreeZSvTocFdFd(2,3,3,3),AmpWaveZSvTocFdFd(2,3,3,3),AmpVertexZSvTocFdFd(2,3,3,3) 
Real(dp) :: AmpSqSvTocFdFd(3,3,3),  AmpSqTreeSvTocFdFd(3,3,3) 
Real(dp) :: MRPSvTocChaFe(3,2,3),MRGSvTocChaFe(3,2,3), MRPZSvTocChaFe(3,2,3),MRGZSvTocChaFe(3,2,3) 
Real(dp) :: MVPSvTocChaFe(3,2,3) 
Real(dp) :: RMsqTreeSvTocChaFe(3,2,3),RMsqWaveSvTocChaFe(3,2,3),RMsqVertexSvTocChaFe(3,2,3) 
Complex(dp) :: AmpTreeSvTocChaFe(2,3,2,3),AmpWaveSvTocChaFe(2,3,2,3),AmpVertexSvTocChaFe(2,3,2,3)& 
 & ,AmpVertexIRosSvTocChaFe(2,3,2,3),AmpVertexIRdrSvTocChaFe(2,3,2,3), AmpSumSvTocChaFe(2,3,2,3), AmpSum2SvTocChaFe(2,3,2,3) 
Complex(dp) :: AmpTreeZSvTocChaFe(2,3,2,3),AmpWaveZSvTocChaFe(2,3,2,3),AmpVertexZSvTocChaFe(2,3,2,3) 
Real(dp) :: AmpSqSvTocChaFe(3,2,3),  AmpSqTreeSvTocChaFe(3,2,3) 
Real(dp) :: MRPSvTocFeFe(3,3,3),MRGSvTocFeFe(3,3,3), MRPZSvTocFeFe(3,3,3),MRGZSvTocFeFe(3,3,3) 
Real(dp) :: MVPSvTocFeFe(3,3,3) 
Real(dp) :: RMsqTreeSvTocFeFe(3,3,3),RMsqWaveSvTocFeFe(3,3,3),RMsqVertexSvTocFeFe(3,3,3) 
Complex(dp) :: AmpTreeSvTocFeFe(2,3,3,3),AmpWaveSvTocFeFe(2,3,3,3),AmpVertexSvTocFeFe(2,3,3,3)& 
 & ,AmpVertexIRosSvTocFeFe(2,3,3,3),AmpVertexIRdrSvTocFeFe(2,3,3,3), AmpSumSvTocFeFe(2,3,3,3), AmpSum2SvTocFeFe(2,3,3,3) 
Complex(dp) :: AmpTreeZSvTocFeFe(2,3,3,3),AmpWaveZSvTocFeFe(2,3,3,3),AmpVertexZSvTocFeFe(2,3,3,3) 
Real(dp) :: AmpSqSvTocFeFe(3,3,3),  AmpSqTreeSvTocFeFe(3,3,3) 
Real(dp) :: MRPSvToSvhh(3,3,2),MRGSvToSvhh(3,3,2), MRPZSvToSvhh(3,3,2),MRGZSvToSvhh(3,3,2) 
Real(dp) :: MVPSvToSvhh(3,3,2) 
Real(dp) :: RMsqTreeSvToSvhh(3,3,2),RMsqWaveSvToSvhh(3,3,2),RMsqVertexSvToSvhh(3,3,2) 
Complex(dp) :: AmpTreeSvToSvhh(3,3,2),AmpWaveSvToSvhh(3,3,2),AmpVertexSvToSvhh(3,3,2)& 
 & ,AmpVertexIRosSvToSvhh(3,3,2),AmpVertexIRdrSvToSvhh(3,3,2), AmpSumSvToSvhh(3,3,2), AmpSum2SvToSvhh(3,3,2) 
Complex(dp) :: AmpTreeZSvToSvhh(3,3,2),AmpWaveZSvToSvhh(3,3,2),AmpVertexZSvToSvhh(3,3,2) 
Real(dp) :: AmpSqSvToSvhh(3,3,2),  AmpSqTreeSvToSvhh(3,3,2) 
Real(dp) :: MRPSvTocSdSd(3,6,6),MRGSvTocSdSd(3,6,6), MRPZSvTocSdSd(3,6,6),MRGZSvTocSdSd(3,6,6) 
Real(dp) :: MVPSvTocSdSd(3,6,6) 
Real(dp) :: RMsqTreeSvTocSdSd(3,6,6),RMsqWaveSvTocSdSd(3,6,6),RMsqVertexSvTocSdSd(3,6,6) 
Complex(dp) :: AmpTreeSvTocSdSd(3,6,6),AmpWaveSvTocSdSd(3,6,6),AmpVertexSvTocSdSd(3,6,6)& 
 & ,AmpVertexIRosSvTocSdSd(3,6,6),AmpVertexIRdrSvTocSdSd(3,6,6), AmpSumSvTocSdSd(3,6,6), AmpSum2SvTocSdSd(3,6,6) 
Complex(dp) :: AmpTreeZSvTocSdSd(3,6,6),AmpWaveZSvTocSdSd(3,6,6),AmpVertexZSvTocSdSd(3,6,6) 
Real(dp) :: AmpSqSvTocSdSd(3,6,6),  AmpSqTreeSvTocSdSd(3,6,6) 
Real(dp) :: MRPSvTocHpmSe(3,2,6),MRGSvTocHpmSe(3,2,6), MRPZSvTocHpmSe(3,2,6),MRGZSvTocHpmSe(3,2,6) 
Real(dp) :: MVPSvTocHpmSe(3,2,6) 
Real(dp) :: RMsqTreeSvTocHpmSe(3,2,6),RMsqWaveSvTocHpmSe(3,2,6),RMsqVertexSvTocHpmSe(3,2,6) 
Complex(dp) :: AmpTreeSvTocHpmSe(3,2,6),AmpWaveSvTocHpmSe(3,2,6),AmpVertexSvTocHpmSe(3,2,6)& 
 & ,AmpVertexIRosSvTocHpmSe(3,2,6),AmpVertexIRdrSvTocHpmSe(3,2,6), AmpSumSvTocHpmSe(3,2,6), AmpSum2SvTocHpmSe(3,2,6) 
Complex(dp) :: AmpTreeZSvTocHpmSe(3,2,6),AmpWaveZSvTocHpmSe(3,2,6),AmpVertexZSvTocHpmSe(3,2,6) 
Real(dp) :: AmpSqSvTocHpmSe(3,2,6),  AmpSqTreeSvTocHpmSe(3,2,6) 
Real(dp) :: MRPSvTocSeSe(3,6,6),MRGSvTocSeSe(3,6,6), MRPZSvTocSeSe(3,6,6),MRGZSvTocSeSe(3,6,6) 
Real(dp) :: MVPSvTocSeSe(3,6,6) 
Real(dp) :: RMsqTreeSvTocSeSe(3,6,6),RMsqWaveSvTocSeSe(3,6,6),RMsqVertexSvTocSeSe(3,6,6) 
Complex(dp) :: AmpTreeSvTocSeSe(3,6,6),AmpWaveSvTocSeSe(3,6,6),AmpVertexSvTocSeSe(3,6,6)& 
 & ,AmpVertexIRosSvTocSeSe(3,6,6),AmpVertexIRdrSvTocSeSe(3,6,6), AmpSumSvTocSeSe(3,6,6), AmpSum2SvTocSeSe(3,6,6) 
Complex(dp) :: AmpTreeZSvTocSeSe(3,6,6),AmpWaveZSvTocSeSe(3,6,6),AmpVertexZSvTocSeSe(3,6,6) 
Real(dp) :: AmpSqSvTocSeSe(3,6,6),  AmpSqTreeSvTocSeSe(3,6,6) 
Real(dp) :: MRPSvToSecVWm(3,6),MRGSvToSecVWm(3,6), MRPZSvToSecVWm(3,6),MRGZSvToSecVWm(3,6) 
Real(dp) :: MVPSvToSecVWm(3,6) 
Real(dp) :: RMsqTreeSvToSecVWm(3,6),RMsqWaveSvToSecVWm(3,6),RMsqVertexSvToSecVWm(3,6) 
Complex(dp) :: AmpTreeSvToSecVWm(2,3,6),AmpWaveSvToSecVWm(2,3,6),AmpVertexSvToSecVWm(2,3,6)& 
 & ,AmpVertexIRosSvToSecVWm(2,3,6),AmpVertexIRdrSvToSecVWm(2,3,6), AmpSumSvToSecVWm(2,3,6), AmpSum2SvToSecVWm(2,3,6) 
Complex(dp) :: AmpTreeZSvToSecVWm(2,3,6),AmpWaveZSvToSecVWm(2,3,6),AmpVertexZSvToSecVWm(2,3,6) 
Real(dp) :: AmpSqSvToSecVWm(3,6),  AmpSqTreeSvToSecVWm(3,6) 
Real(dp) :: MRPSvToSvVZ(3,3),MRGSvToSvVZ(3,3), MRPZSvToSvVZ(3,3),MRGZSvToSvVZ(3,3) 
Real(dp) :: MVPSvToSvVZ(3,3) 
Real(dp) :: RMsqTreeSvToSvVZ(3,3),RMsqWaveSvToSvVZ(3,3),RMsqVertexSvToSvVZ(3,3) 
Complex(dp) :: AmpTreeSvToSvVZ(2,3,3),AmpWaveSvToSvVZ(2,3,3),AmpVertexSvToSvVZ(2,3,3)& 
 & ,AmpVertexIRosSvToSvVZ(2,3,3),AmpVertexIRdrSvToSvVZ(2,3,3), AmpSumSvToSvVZ(2,3,3), AmpSum2SvToSvVZ(2,3,3) 
Complex(dp) :: AmpTreeZSvToSvVZ(2,3,3),AmpWaveZSvToSvVZ(2,3,3),AmpVertexZSvToSvVZ(2,3,3) 
Real(dp) :: AmpSqSvToSvVZ(3,3),  AmpSqTreeSvToSvVZ(3,3) 
Real(dp) :: MRPSvToAhAh(3,2,2),MRGSvToAhAh(3,2,2), MRPZSvToAhAh(3,2,2),MRGZSvToAhAh(3,2,2) 
Real(dp) :: MVPSvToAhAh(3,2,2) 
Real(dp) :: RMsqTreeSvToAhAh(3,2,2),RMsqWaveSvToAhAh(3,2,2),RMsqVertexSvToAhAh(3,2,2) 
Complex(dp) :: AmpTreeSvToAhAh(3,2,2),AmpWaveSvToAhAh(3,2,2),AmpVertexSvToAhAh(3,2,2)& 
 & ,AmpVertexIRosSvToAhAh(3,2,2),AmpVertexIRdrSvToAhAh(3,2,2), AmpSumSvToAhAh(3,2,2), AmpSum2SvToAhAh(3,2,2) 
Complex(dp) :: AmpTreeZSvToAhAh(3,2,2),AmpWaveZSvToAhAh(3,2,2),AmpVertexZSvToAhAh(3,2,2) 
Real(dp) :: AmpSqSvToAhAh(3,2,2),  AmpSqTreeSvToAhAh(3,2,2) 
Real(dp) :: MRPSvToAhhh(3,2,2),MRGSvToAhhh(3,2,2), MRPZSvToAhhh(3,2,2),MRGZSvToAhhh(3,2,2) 
Real(dp) :: MVPSvToAhhh(3,2,2) 
Real(dp) :: RMsqTreeSvToAhhh(3,2,2),RMsqWaveSvToAhhh(3,2,2),RMsqVertexSvToAhhh(3,2,2) 
Complex(dp) :: AmpTreeSvToAhhh(3,2,2),AmpWaveSvToAhhh(3,2,2),AmpVertexSvToAhhh(3,2,2)& 
 & ,AmpVertexIRosSvToAhhh(3,2,2),AmpVertexIRdrSvToAhhh(3,2,2), AmpSumSvToAhhh(3,2,2), AmpSum2SvToAhhh(3,2,2) 
Complex(dp) :: AmpTreeZSvToAhhh(3,2,2),AmpWaveZSvToAhhh(3,2,2),AmpVertexZSvToAhhh(3,2,2) 
Real(dp) :: AmpSqSvToAhhh(3,2,2),  AmpSqTreeSvToAhhh(3,2,2) 
Real(dp) :: MRPSvToAhSv(3,2,3),MRGSvToAhSv(3,2,3), MRPZSvToAhSv(3,2,3),MRGZSvToAhSv(3,2,3) 
Real(dp) :: MVPSvToAhSv(3,2,3) 
Real(dp) :: RMsqTreeSvToAhSv(3,2,3),RMsqWaveSvToAhSv(3,2,3),RMsqVertexSvToAhSv(3,2,3) 
Complex(dp) :: AmpTreeSvToAhSv(3,2,3),AmpWaveSvToAhSv(3,2,3),AmpVertexSvToAhSv(3,2,3)& 
 & ,AmpVertexIRosSvToAhSv(3,2,3),AmpVertexIRdrSvToAhSv(3,2,3), AmpSumSvToAhSv(3,2,3), AmpSum2SvToAhSv(3,2,3) 
Complex(dp) :: AmpTreeZSvToAhSv(3,2,3),AmpWaveZSvToAhSv(3,2,3),AmpVertexZSvToAhSv(3,2,3) 
Real(dp) :: AmpSqSvToAhSv(3,2,3),  AmpSqTreeSvToAhSv(3,2,3) 
Real(dp) :: MRPSvToAhVP(3,2),MRGSvToAhVP(3,2), MRPZSvToAhVP(3,2),MRGZSvToAhVP(3,2) 
Real(dp) :: MVPSvToAhVP(3,2) 
Real(dp) :: RMsqTreeSvToAhVP(3,2),RMsqWaveSvToAhVP(3,2),RMsqVertexSvToAhVP(3,2) 
Complex(dp) :: AmpTreeSvToAhVP(2,3,2),AmpWaveSvToAhVP(2,3,2),AmpVertexSvToAhVP(2,3,2)& 
 & ,AmpVertexIRosSvToAhVP(2,3,2),AmpVertexIRdrSvToAhVP(2,3,2), AmpSumSvToAhVP(2,3,2), AmpSum2SvToAhVP(2,3,2) 
Complex(dp) :: AmpTreeZSvToAhVP(2,3,2),AmpWaveZSvToAhVP(2,3,2),AmpVertexZSvToAhVP(2,3,2) 
Real(dp) :: AmpSqSvToAhVP(3,2),  AmpSqTreeSvToAhVP(3,2) 
Real(dp) :: MRPSvToAhVZ(3,2),MRGSvToAhVZ(3,2), MRPZSvToAhVZ(3,2),MRGZSvToAhVZ(3,2) 
Real(dp) :: MVPSvToAhVZ(3,2) 
Real(dp) :: RMsqTreeSvToAhVZ(3,2),RMsqWaveSvToAhVZ(3,2),RMsqVertexSvToAhVZ(3,2) 
Complex(dp) :: AmpTreeSvToAhVZ(2,3,2),AmpWaveSvToAhVZ(2,3,2),AmpVertexSvToAhVZ(2,3,2)& 
 & ,AmpVertexIRosSvToAhVZ(2,3,2),AmpVertexIRdrSvToAhVZ(2,3,2), AmpSumSvToAhVZ(2,3,2), AmpSum2SvToAhVZ(2,3,2) 
Complex(dp) :: AmpTreeZSvToAhVZ(2,3,2),AmpWaveZSvToAhVZ(2,3,2),AmpVertexZSvToAhVZ(2,3,2) 
Real(dp) :: AmpSqSvToAhVZ(3,2),  AmpSqTreeSvToAhVZ(3,2) 
Real(dp) :: MRPSvToChacCha(3,2,2),MRGSvToChacCha(3,2,2), MRPZSvToChacCha(3,2,2),MRGZSvToChacCha(3,2,2) 
Real(dp) :: MVPSvToChacCha(3,2,2) 
Real(dp) :: RMsqTreeSvToChacCha(3,2,2),RMsqWaveSvToChacCha(3,2,2),RMsqVertexSvToChacCha(3,2,2) 
Complex(dp) :: AmpTreeSvToChacCha(2,3,2,2),AmpWaveSvToChacCha(2,3,2,2),AmpVertexSvToChacCha(2,3,2,2)& 
 & ,AmpVertexIRosSvToChacCha(2,3,2,2),AmpVertexIRdrSvToChacCha(2,3,2,2), AmpSumSvToChacCha(2,3,2,2), AmpSum2SvToChacCha(2,3,2,2) 
Complex(dp) :: AmpTreeZSvToChacCha(2,3,2,2),AmpWaveZSvToChacCha(2,3,2,2),AmpVertexZSvToChacCha(2,3,2,2) 
Real(dp) :: AmpSqSvToChacCha(3,2,2),  AmpSqTreeSvToChacCha(3,2,2) 
Real(dp) :: MRPSvToChiChi(3,4,4),MRGSvToChiChi(3,4,4), MRPZSvToChiChi(3,4,4),MRGZSvToChiChi(3,4,4) 
Real(dp) :: MVPSvToChiChi(3,4,4) 
Real(dp) :: RMsqTreeSvToChiChi(3,4,4),RMsqWaveSvToChiChi(3,4,4),RMsqVertexSvToChiChi(3,4,4) 
Complex(dp) :: AmpTreeSvToChiChi(2,3,4,4),AmpWaveSvToChiChi(2,3,4,4),AmpVertexSvToChiChi(2,3,4,4)& 
 & ,AmpVertexIRosSvToChiChi(2,3,4,4),AmpVertexIRdrSvToChiChi(2,3,4,4), AmpSumSvToChiChi(2,3,4,4), AmpSum2SvToChiChi(2,3,4,4) 
Complex(dp) :: AmpTreeZSvToChiChi(2,3,4,4),AmpWaveZSvToChiChi(2,3,4,4),AmpVertexZSvToChiChi(2,3,4,4) 
Real(dp) :: AmpSqSvToChiChi(3,4,4),  AmpSqTreeSvToChiChi(3,4,4) 
Real(dp) :: MRPSvToFucFu(3,3,3),MRGSvToFucFu(3,3,3), MRPZSvToFucFu(3,3,3),MRGZSvToFucFu(3,3,3) 
Real(dp) :: MVPSvToFucFu(3,3,3) 
Real(dp) :: RMsqTreeSvToFucFu(3,3,3),RMsqWaveSvToFucFu(3,3,3),RMsqVertexSvToFucFu(3,3,3) 
Complex(dp) :: AmpTreeSvToFucFu(2,3,3,3),AmpWaveSvToFucFu(2,3,3,3),AmpVertexSvToFucFu(2,3,3,3)& 
 & ,AmpVertexIRosSvToFucFu(2,3,3,3),AmpVertexIRdrSvToFucFu(2,3,3,3), AmpSumSvToFucFu(2,3,3,3), AmpSum2SvToFucFu(2,3,3,3) 
Complex(dp) :: AmpTreeZSvToFucFu(2,3,3,3),AmpWaveZSvToFucFu(2,3,3,3),AmpVertexZSvToFucFu(2,3,3,3) 
Real(dp) :: AmpSqSvToFucFu(3,3,3),  AmpSqTreeSvToFucFu(3,3,3) 
Real(dp) :: MRPSvToFvFv(3,3,3),MRGSvToFvFv(3,3,3), MRPZSvToFvFv(3,3,3),MRGZSvToFvFv(3,3,3) 
Real(dp) :: MVPSvToFvFv(3,3,3) 
Real(dp) :: RMsqTreeSvToFvFv(3,3,3),RMsqWaveSvToFvFv(3,3,3),RMsqVertexSvToFvFv(3,3,3) 
Complex(dp) :: AmpTreeSvToFvFv(2,3,3,3),AmpWaveSvToFvFv(2,3,3,3),AmpVertexSvToFvFv(2,3,3,3)& 
 & ,AmpVertexIRosSvToFvFv(2,3,3,3),AmpVertexIRdrSvToFvFv(2,3,3,3), AmpSumSvToFvFv(2,3,3,3), AmpSum2SvToFvFv(2,3,3,3) 
Complex(dp) :: AmpTreeZSvToFvFv(2,3,3,3),AmpWaveZSvToFvFv(2,3,3,3),AmpVertexZSvToFvFv(2,3,3,3) 
Real(dp) :: AmpSqSvToFvFv(3,3,3),  AmpSqTreeSvToFvFv(3,3,3) 
Real(dp) :: MRPSvToGluGlu(3),MRGSvToGluGlu(3), MRPZSvToGluGlu(3),MRGZSvToGluGlu(3) 
Real(dp) :: MVPSvToGluGlu(3) 
Real(dp) :: RMsqTreeSvToGluGlu(3),RMsqWaveSvToGluGlu(3),RMsqVertexSvToGluGlu(3) 
Complex(dp) :: AmpTreeSvToGluGlu(2,3),AmpWaveSvToGluGlu(2,3),AmpVertexSvToGluGlu(2,3)& 
 & ,AmpVertexIRosSvToGluGlu(2,3),AmpVertexIRdrSvToGluGlu(2,3), AmpSumSvToGluGlu(2,3), AmpSum2SvToGluGlu(2,3) 
Complex(dp) :: AmpTreeZSvToGluGlu(2,3),AmpWaveZSvToGluGlu(2,3),AmpVertexZSvToGluGlu(2,3) 
Real(dp) :: AmpSqSvToGluGlu(3),  AmpSqTreeSvToGluGlu(3) 
Real(dp) :: MRPSvTohhhh(3,2,2),MRGSvTohhhh(3,2,2), MRPZSvTohhhh(3,2,2),MRGZSvTohhhh(3,2,2) 
Real(dp) :: MVPSvTohhhh(3,2,2) 
Real(dp) :: RMsqTreeSvTohhhh(3,2,2),RMsqWaveSvTohhhh(3,2,2),RMsqVertexSvTohhhh(3,2,2) 
Complex(dp) :: AmpTreeSvTohhhh(3,2,2),AmpWaveSvTohhhh(3,2,2),AmpVertexSvTohhhh(3,2,2)& 
 & ,AmpVertexIRosSvTohhhh(3,2,2),AmpVertexIRdrSvTohhhh(3,2,2), AmpSumSvTohhhh(3,2,2), AmpSum2SvTohhhh(3,2,2) 
Complex(dp) :: AmpTreeZSvTohhhh(3,2,2),AmpWaveZSvTohhhh(3,2,2),AmpVertexZSvTohhhh(3,2,2) 
Real(dp) :: AmpSqSvTohhhh(3,2,2),  AmpSqTreeSvTohhhh(3,2,2) 
Real(dp) :: MRPSvTohhVP(3,2),MRGSvTohhVP(3,2), MRPZSvTohhVP(3,2),MRGZSvTohhVP(3,2) 
Real(dp) :: MVPSvTohhVP(3,2) 
Real(dp) :: RMsqTreeSvTohhVP(3,2),RMsqWaveSvTohhVP(3,2),RMsqVertexSvTohhVP(3,2) 
Complex(dp) :: AmpTreeSvTohhVP(2,3,2),AmpWaveSvTohhVP(2,3,2),AmpVertexSvTohhVP(2,3,2)& 
 & ,AmpVertexIRosSvTohhVP(2,3,2),AmpVertexIRdrSvTohhVP(2,3,2), AmpSumSvTohhVP(2,3,2), AmpSum2SvTohhVP(2,3,2) 
Complex(dp) :: AmpTreeZSvTohhVP(2,3,2),AmpWaveZSvTohhVP(2,3,2),AmpVertexZSvTohhVP(2,3,2) 
Real(dp) :: AmpSqSvTohhVP(3,2),  AmpSqTreeSvTohhVP(3,2) 
Real(dp) :: MRPSvTohhVZ(3,2),MRGSvTohhVZ(3,2), MRPZSvTohhVZ(3,2),MRGZSvTohhVZ(3,2) 
Real(dp) :: MVPSvTohhVZ(3,2) 
Real(dp) :: RMsqTreeSvTohhVZ(3,2),RMsqWaveSvTohhVZ(3,2),RMsqVertexSvTohhVZ(3,2) 
Complex(dp) :: AmpTreeSvTohhVZ(2,3,2),AmpWaveSvTohhVZ(2,3,2),AmpVertexSvTohhVZ(2,3,2)& 
 & ,AmpVertexIRosSvTohhVZ(2,3,2),AmpVertexIRdrSvTohhVZ(2,3,2), AmpSumSvTohhVZ(2,3,2), AmpSum2SvTohhVZ(2,3,2) 
Complex(dp) :: AmpTreeZSvTohhVZ(2,3,2),AmpWaveZSvTohhVZ(2,3,2),AmpVertexZSvTohhVZ(2,3,2) 
Real(dp) :: AmpSqSvTohhVZ(3,2),  AmpSqTreeSvTohhVZ(3,2) 
Real(dp) :: MRPSvToHpmcHpm(3,2,2),MRGSvToHpmcHpm(3,2,2), MRPZSvToHpmcHpm(3,2,2),MRGZSvToHpmcHpm(3,2,2) 
Real(dp) :: MVPSvToHpmcHpm(3,2,2) 
Real(dp) :: RMsqTreeSvToHpmcHpm(3,2,2),RMsqWaveSvToHpmcHpm(3,2,2),RMsqVertexSvToHpmcHpm(3,2,2) 
Complex(dp) :: AmpTreeSvToHpmcHpm(3,2,2),AmpWaveSvToHpmcHpm(3,2,2),AmpVertexSvToHpmcHpm(3,2,2)& 
 & ,AmpVertexIRosSvToHpmcHpm(3,2,2),AmpVertexIRdrSvToHpmcHpm(3,2,2), AmpSumSvToHpmcHpm(3,2,2), AmpSum2SvToHpmcHpm(3,2,2) 
Complex(dp) :: AmpTreeZSvToHpmcHpm(3,2,2),AmpWaveZSvToHpmcHpm(3,2,2),AmpVertexZSvToHpmcHpm(3,2,2) 
Real(dp) :: AmpSqSvToHpmcHpm(3,2,2),  AmpSqTreeSvToHpmcHpm(3,2,2) 
Real(dp) :: MRPSvToHpmcVWm(3,2),MRGSvToHpmcVWm(3,2), MRPZSvToHpmcVWm(3,2),MRGZSvToHpmcVWm(3,2) 
Real(dp) :: MVPSvToHpmcVWm(3,2) 
Real(dp) :: RMsqTreeSvToHpmcVWm(3,2),RMsqWaveSvToHpmcVWm(3,2),RMsqVertexSvToHpmcVWm(3,2) 
Complex(dp) :: AmpTreeSvToHpmcVWm(2,3,2),AmpWaveSvToHpmcVWm(2,3,2),AmpVertexSvToHpmcVWm(2,3,2)& 
 & ,AmpVertexIRosSvToHpmcVWm(2,3,2),AmpVertexIRdrSvToHpmcVWm(2,3,2), AmpSumSvToHpmcVWm(2,3,2), AmpSum2SvToHpmcVWm(2,3,2) 
Complex(dp) :: AmpTreeZSvToHpmcVWm(2,3,2),AmpWaveZSvToHpmcVWm(2,3,2),AmpVertexZSvToHpmcVWm(2,3,2) 
Real(dp) :: AmpSqSvToHpmcVWm(3,2),  AmpSqTreeSvToHpmcVWm(3,2) 
Real(dp) :: MRPSvToSucSu(3,6,6),MRGSvToSucSu(3,6,6), MRPZSvToSucSu(3,6,6),MRGZSvToSucSu(3,6,6) 
Real(dp) :: MVPSvToSucSu(3,6,6) 
Real(dp) :: RMsqTreeSvToSucSu(3,6,6),RMsqWaveSvToSucSu(3,6,6),RMsqVertexSvToSucSu(3,6,6) 
Complex(dp) :: AmpTreeSvToSucSu(3,6,6),AmpWaveSvToSucSu(3,6,6),AmpVertexSvToSucSu(3,6,6)& 
 & ,AmpVertexIRosSvToSucSu(3,6,6),AmpVertexIRdrSvToSucSu(3,6,6), AmpSumSvToSucSu(3,6,6), AmpSum2SvToSucSu(3,6,6) 
Complex(dp) :: AmpTreeZSvToSucSu(3,6,6),AmpWaveZSvToSucSu(3,6,6),AmpVertexZSvToSucSu(3,6,6) 
Real(dp) :: AmpSqSvToSucSu(3,6,6),  AmpSqTreeSvToSucSu(3,6,6) 
Real(dp) :: MRPSvToSvSv(3,3,3),MRGSvToSvSv(3,3,3), MRPZSvToSvSv(3,3,3),MRGZSvToSvSv(3,3,3) 
Real(dp) :: MVPSvToSvSv(3,3,3) 
Real(dp) :: RMsqTreeSvToSvSv(3,3,3),RMsqWaveSvToSvSv(3,3,3),RMsqVertexSvToSvSv(3,3,3) 
Complex(dp) :: AmpTreeSvToSvSv(3,3,3),AmpWaveSvToSvSv(3,3,3),AmpVertexSvToSvSv(3,3,3)& 
 & ,AmpVertexIRosSvToSvSv(3,3,3),AmpVertexIRdrSvToSvSv(3,3,3), AmpSumSvToSvSv(3,3,3), AmpSum2SvToSvSv(3,3,3) 
Complex(dp) :: AmpTreeZSvToSvSv(3,3,3),AmpWaveZSvToSvSv(3,3,3),AmpVertexZSvToSvSv(3,3,3) 
Real(dp) :: AmpSqSvToSvSv(3,3,3),  AmpSqTreeSvToSvSv(3,3,3) 
Real(dp) :: MRPSvToSvVP(3,3),MRGSvToSvVP(3,3), MRPZSvToSvVP(3,3),MRGZSvToSvVP(3,3) 
Real(dp) :: MVPSvToSvVP(3,3) 
Real(dp) :: RMsqTreeSvToSvVP(3,3),RMsqWaveSvToSvVP(3,3),RMsqVertexSvToSvVP(3,3) 
Complex(dp) :: AmpTreeSvToSvVP(2,3,3),AmpWaveSvToSvVP(2,3,3),AmpVertexSvToSvVP(2,3,3)& 
 & ,AmpVertexIRosSvToSvVP(2,3,3),AmpVertexIRdrSvToSvVP(2,3,3), AmpSumSvToSvVP(2,3,3), AmpSum2SvToSvVP(2,3,3) 
Complex(dp) :: AmpTreeZSvToSvVP(2,3,3),AmpWaveZSvToSvVP(2,3,3),AmpVertexZSvToSvVP(2,3,3) 
Real(dp) :: AmpSqSvToSvVP(3,3),  AmpSqTreeSvToSvVP(3,3) 
Real(dp) :: MRPSvToSvcSv(3,3,3),MRGSvToSvcSv(3,3,3), MRPZSvToSvcSv(3,3,3),MRGZSvToSvcSv(3,3,3) 
Real(dp) :: MVPSvToSvcSv(3,3,3) 
Real(dp) :: RMsqTreeSvToSvcSv(3,3,3),RMsqWaveSvToSvcSv(3,3,3),RMsqVertexSvToSvcSv(3,3,3) 
Complex(dp) :: AmpTreeSvToSvcSv(3,3,3),AmpWaveSvToSvcSv(3,3,3),AmpVertexSvToSvcSv(3,3,3)& 
 & ,AmpVertexIRosSvToSvcSv(3,3,3),AmpVertexIRdrSvToSvcSv(3,3,3), AmpSumSvToSvcSv(3,3,3), AmpSum2SvToSvcSv(3,3,3) 
Complex(dp) :: AmpTreeZSvToSvcSv(3,3,3),AmpWaveZSvToSvcSv(3,3,3),AmpVertexZSvToSvcSv(3,3,3) 
Real(dp) :: AmpSqSvToSvcSv(3,3,3),  AmpSqTreeSvToSvcSv(3,3,3) 
Real(dp) :: MRPSvToVGVG(3),MRGSvToVGVG(3), MRPZSvToVGVG(3),MRGZSvToVGVG(3) 
Real(dp) :: MVPSvToVGVG(3) 
Real(dp) :: RMsqTreeSvToVGVG(3),RMsqWaveSvToVGVG(3),RMsqVertexSvToVGVG(3) 
Complex(dp) :: AmpTreeSvToVGVG(2,3),AmpWaveSvToVGVG(2,3),AmpVertexSvToVGVG(2,3)& 
 & ,AmpVertexIRosSvToVGVG(2,3),AmpVertexIRdrSvToVGVG(2,3), AmpSumSvToVGVG(2,3), AmpSum2SvToVGVG(2,3) 
Complex(dp) :: AmpTreeZSvToVGVG(2,3),AmpWaveZSvToVGVG(2,3),AmpVertexZSvToVGVG(2,3) 
Real(dp) :: AmpSqSvToVGVG(3),  AmpSqTreeSvToVGVG(3) 
Real(dp) :: MRPSvToVPVP(3),MRGSvToVPVP(3), MRPZSvToVPVP(3),MRGZSvToVPVP(3) 
Real(dp) :: MVPSvToVPVP(3) 
Real(dp) :: RMsqTreeSvToVPVP(3),RMsqWaveSvToVPVP(3),RMsqVertexSvToVPVP(3) 
Complex(dp) :: AmpTreeSvToVPVP(2,3),AmpWaveSvToVPVP(2,3),AmpVertexSvToVPVP(2,3)& 
 & ,AmpVertexIRosSvToVPVP(2,3),AmpVertexIRdrSvToVPVP(2,3), AmpSumSvToVPVP(2,3), AmpSum2SvToVPVP(2,3) 
Complex(dp) :: AmpTreeZSvToVPVP(2,3),AmpWaveZSvToVPVP(2,3),AmpVertexZSvToVPVP(2,3) 
Real(dp) :: AmpSqSvToVPVP(3),  AmpSqTreeSvToVPVP(3) 
Real(dp) :: MRPSvToVPVZ(3),MRGSvToVPVZ(3), MRPZSvToVPVZ(3),MRGZSvToVPVZ(3) 
Real(dp) :: MVPSvToVPVZ(3) 
Real(dp) :: RMsqTreeSvToVPVZ(3),RMsqWaveSvToVPVZ(3),RMsqVertexSvToVPVZ(3) 
Complex(dp) :: AmpTreeSvToVPVZ(2,3),AmpWaveSvToVPVZ(2,3),AmpVertexSvToVPVZ(2,3)& 
 & ,AmpVertexIRosSvToVPVZ(2,3),AmpVertexIRdrSvToVPVZ(2,3), AmpSumSvToVPVZ(2,3), AmpSum2SvToVPVZ(2,3) 
Complex(dp) :: AmpTreeZSvToVPVZ(2,3),AmpWaveZSvToVPVZ(2,3),AmpVertexZSvToVPVZ(2,3) 
Real(dp) :: AmpSqSvToVPVZ(3),  AmpSqTreeSvToVPVZ(3) 
Real(dp) :: MRPSvToVWmcVWm(3),MRGSvToVWmcVWm(3), MRPZSvToVWmcVWm(3),MRGZSvToVWmcVWm(3) 
Real(dp) :: MVPSvToVWmcVWm(3) 
Real(dp) :: RMsqTreeSvToVWmcVWm(3),RMsqWaveSvToVWmcVWm(3),RMsqVertexSvToVWmcVWm(3) 
Complex(dp) :: AmpTreeSvToVWmcVWm(2,3),AmpWaveSvToVWmcVWm(2,3),AmpVertexSvToVWmcVWm(2,3)& 
 & ,AmpVertexIRosSvToVWmcVWm(2,3),AmpVertexIRdrSvToVWmcVWm(2,3), AmpSumSvToVWmcVWm(2,3), AmpSum2SvToVWmcVWm(2,3) 
Complex(dp) :: AmpTreeZSvToVWmcVWm(2,3),AmpWaveZSvToVWmcVWm(2,3),AmpVertexZSvToVWmcVWm(2,3) 
Real(dp) :: AmpSqSvToVWmcVWm(3),  AmpSqTreeSvToVWmcVWm(3) 
Real(dp) :: MRPSvToVZVZ(3),MRGSvToVZVZ(3), MRPZSvToVZVZ(3),MRGZSvToVZVZ(3) 
Real(dp) :: MVPSvToVZVZ(3) 
Real(dp) :: RMsqTreeSvToVZVZ(3),RMsqWaveSvToVZVZ(3),RMsqVertexSvToVZVZ(3) 
Complex(dp) :: AmpTreeSvToVZVZ(2,3),AmpWaveSvToVZVZ(2,3),AmpVertexSvToVZVZ(2,3)& 
 & ,AmpVertexIRosSvToVZVZ(2,3),AmpVertexIRdrSvToVZVZ(2,3), AmpSumSvToVZVZ(2,3), AmpSum2SvToVZVZ(2,3) 
Complex(dp) :: AmpTreeZSvToVZVZ(2,3),AmpWaveZSvToVZVZ(2,3),AmpVertexZSvToVZVZ(2,3) 
Real(dp) :: AmpSqSvToVZVZ(3),  AmpSqTreeSvToVZVZ(3) 
Write(*,*) "Calculating one-loop decays of Sv " 
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
! Fv Chi
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvToFvChi(cplChiFvcSvL,cplChiFvcSvR,MChi,              & 
& MSv,MChi2,MSv2,AmpTreeSvToFvChi)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvToFvChi(ZcplChiFvcSvL,ZcplChiFvcSvR,MChi,            & 
& MSv,MChi2,MSv2,AmpTreeSvToFvChi)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToFvChi(MLambda,em,gs,cplChiFvcSvL,cplChiFvcSvR,         & 
& MChiOS,MSvOS,MRPSvToFvChi,MRGSvToFvChi)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToFvChi(MLambda,em,gs,ZcplChiFvcSvL,ZcplChiFvcSvR,       & 
& MChiOS,MSvOS,MRPSvToFvChi,MRGSvToFvChi)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvToFvChi(MLambda,em,gs,cplChiFvcSvL,cplChiFvcSvR,         & 
& MChi,MSv,MRPSvToFvChi,MRGSvToFvChi)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToFvChi(MLambda,em,gs,ZcplChiFvcSvL,ZcplChiFvcSvR,       & 
& MChi,MSv,MRPSvToFvChi,MRGSvToFvChi)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToFvChi(cplChiFvcSvL,cplChiFvcSvR,ctcplChiFvcSvL,    & 
& ctcplChiFvcSvR,MChi,MChi2,MSv,MSv2,ZfFvL,ZfL0,ZfSv,AmpWaveSvToFvChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFvChi(MCha,MChi,MFd,MFe,Mhh,MHpm,MSd,            & 
& MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,MVZ2,           & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,              & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,              & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,              & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexSvToFvChi)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi(MCha,MChi,MFd,MFe,Mhh,MHpm,             & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,         & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,              & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,              & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRdrSvToFvChi)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi(MChaOS,MChiOS,MFdOS,MFeOS,              & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,             & 
& Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,MVZ2OS,cplChiChacHpmL,cplChiChacHpmR,      & 
& cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFvSvL,cplChiFvSvR,ZcplChiFvcSvL,ZcplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvToFvChi)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi(MCha,MChi,MFd,MFe,Mhh,MHpm,             & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,         & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,ZcplChiFvcSvL,          & 
& ZcplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,    & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,              & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,              & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvToFvChi)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi(MChaOS,MChiOS,MFdOS,MFeOS,              & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,             & 
& Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,MVZ2OS,cplChiChacHpmL,cplChiChacHpmR,      & 
& cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvToFvChi)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi(MCha,MChi,MFd,MFe,Mhh,MHpm,             & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,         & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,              & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,              & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvToFvChi)

 End if 
 End if 
AmpVertexSvToFvChi = AmpVertexSvToFvChi -  AmpVertexIRdrSvToFvChi! +  AmpVertexIRosSvToFvChi ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvToFvChi=0._dp 
AmpVertexZSvToFvChi=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToFvChi(:,gt2,:,:) = AmpWaveZSvToFvChi(:,gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvToFvChi(:,gt1,:,:) 
AmpVertexZSvToFvChi(:,gt2,:,:)= AmpVertexZSvToFvChi(:,gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvToFvChi(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSvToFvChi=AmpWaveZSvToFvChi 
AmpVertexSvToFvChi= AmpVertexZSvToFvChi
! Final State 1 
AmpWaveZSvToFvChi=0._dp 
AmpVertexZSvToFvChi=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToFvChi(1,:,gt2,:) = AmpWaveZSvToFvChi(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpWaveSvToFvChi(1,:,gt1,:) 
AmpVertexZSvToFvChi(1,:,gt2,:)= AmpVertexZSvToFvChi(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpVertexSvToFvChi(1,:,gt1,:) 
AmpWaveZSvToFvChi(2,:,gt2,:) = AmpWaveZSvToFvChi(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpWaveSvToFvChi(2,:,gt1,:) 
AmpVertexZSvToFvChi(2,:,gt2,:)= AmpVertexZSvToFvChi(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpVertexSvToFvChi(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSvToFvChi=AmpWaveZSvToFvChi 
AmpVertexSvToFvChi= AmpVertexZSvToFvChi
! Final State 2 
AmpWaveZSvToFvChi=0._dp 
AmpVertexZSvToFvChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZSvToFvChi(1,:,:,gt2) = AmpWaveZSvToFvChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSvToFvChi(1,:,:,gt1) 
AmpVertexZSvToFvChi(1,:,:,gt2)= AmpVertexZSvToFvChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSvToFvChi(1,:,:,gt1) 
AmpWaveZSvToFvChi(2,:,:,gt2) = AmpWaveZSvToFvChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSvToFvChi(2,:,:,gt1) 
AmpVertexZSvToFvChi(2,:,:,gt2)= AmpVertexZSvToFvChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSvToFvChi(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSvToFvChi=AmpWaveZSvToFvChi 
AmpVertexSvToFvChi= AmpVertexZSvToFvChi
End if
If (ShiftIRdiv) Then 
AmpVertexSvToFvChi = AmpVertexSvToFvChi  +  AmpVertexIRosSvToFvChi
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Fv Chi -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvToFvChi = AmpTreeSvToFvChi 
 AmpSum2SvToFvChi = AmpTreeSvToFvChi + 2._dp*AmpWaveSvToFvChi + 2._dp*AmpVertexSvToFvChi  
Else 
 AmpSumSvToFvChi = AmpTreeSvToFvChi + AmpWaveSvToFvChi + AmpVertexSvToFvChi
 AmpSum2SvToFvChi = AmpTreeSvToFvChi + AmpWaveSvToFvChi + AmpVertexSvToFvChi 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToFvChi = AmpTreeSvToFvChi
 AmpSum2SvToFvChi = AmpTreeSvToFvChi 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,4
If (((OSkinematics).and.(MSvOS(gt1).gt.(0.+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(0.+MChi(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvToFvChi = AmpTreeSvToFvChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,MChiOS(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),0._dp,MChi(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvToFvChi(gt1, gt2, gt3) 
  AmpSum2SvToFvChi = 2._dp*AmpWaveSvToFvChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,MChiOS(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),0._dp,MChi(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvToFvChi(gt1, gt2, gt3) 
  AmpSum2SvToFvChi = 2._dp*AmpVertexSvToFvChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,MChiOS(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),0._dp,MChi(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvToFvChi(gt1, gt2, gt3) 
  AmpSum2SvToFvChi = AmpTreeSvToFvChi + 2._dp*AmpWaveSvToFvChi + 2._dp*AmpVertexSvToFvChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,MChiOS(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),0._dp,MChi(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvToFvChi(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvToFvChi = AmpTreeSvToFvChi
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,MChiOS(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
  AmpSqTreeSvToFvChi(gt1, gt2, gt3) = (1)*AmpSqSvToFvChi(gt1, gt2, gt3)  
  AmpSum2SvToFvChi = + 2._dp*AmpWaveSvToFvChi + 2._dp*AmpVertexSvToFvChi
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,MChiOS(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
  AmpSqSvToFvChi(gt1, gt2, gt3) = AmpSqSvToFvChi(gt1, gt2, gt3) + AmpSqTreeSvToFvChi(gt1, gt2, gt3)  
Else  
  AmpSum2SvToFvChi = AmpTreeSvToFvChi
  Call SquareAmp_StoFF(MSv(gt1),0._dp,MChi(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
  AmpSqTreeSvToFvChi(gt1, gt2, gt3) = (1)*AmpSqSvToFvChi(gt1, gt2, gt3)  
  AmpSum2SvToFvChi = + 2._dp*AmpWaveSvToFvChi + 2._dp*AmpVertexSvToFvChi
  Call SquareAmp_StoFF(MSv(gt1),0._dp,MChi(gt3),AmpSumSvToFvChi(:,gt1, gt2, gt3),AmpSum2SvToFvChi(:,gt1, gt2, gt3),AmpSqSvToFvChi(gt1, gt2, gt3)) 
  AmpSqSvToFvChi(gt1, gt2, gt3) = AmpSqSvToFvChi(gt1, gt2, gt3) + AmpSqTreeSvToFvChi(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvToFvChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvToFvChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),0._dp,MChiOS(gt3),helfactor*AmpSqSvToFvChi(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),0._dp,MChi(gt3),helfactor*AmpSqSvToFvChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToFvChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToFvChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvToFvChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToFvChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvToFvChi(gt1, gt2, gt3) + MRGSvToFvChi(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvToFvChi(gt1, gt2, gt3) + MRGSvToFvChi(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! bar(Fd) Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvTocFdFd(cplcFdFdcSvL,cplcFdFdcSvR,MFd,               & 
& MSv,MFd2,MSv2,AmpTreeSvTocFdFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvTocFdFd(ZcplcFdFdcSvL,ZcplcFdFdcSvR,MFd,             & 
& MSv,MFd2,MSv2,AmpTreeSvTocFdFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocFdFd(MLambda,em,gs,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& MFdOS,MSvOS,MRPSvTocFdFd,MRGSvTocFdFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocFdFd(MLambda,em,gs,ZcplcFdFdcSvL,ZcplcFdFdcSvR,       & 
& MFdOS,MSvOS,MRPSvTocFdFd,MRGSvTocFdFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvTocFdFd(MLambda,em,gs,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& MFd,MSv,MRPSvTocFdFd,MRGSvTocFdFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocFdFd(MLambda,em,gs,ZcplcFdFdcSvL,ZcplcFdFdcSvR,       & 
& MFd,MSv,MRPSvTocFdFd,MRGSvTocFdFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTocFdFd(cplcFdFdcSvL,cplcFdFdcSvR,ctcplcFdFdcSvL,    & 
& ctcplcFdFdcSvR,MFd,MFd2,MSv,MSv2,ZfFDL,ZfFDR,ZfSv,AmpWaveSvTocFdFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,               & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,             & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,cplcFdFeSuR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,       & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexSvTocFdFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,              & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,             & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRdrSvTocFdFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFdChaSuL,    & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,ZcplcFdFdcSvL,ZcplcFdFdcSvR,cplcFeFdcSuL,          & 
& cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,         & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,             & 
& cplSvcSvVZ,AmpVertexIRosSvTocFdFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,ZcplcFdFdcSvL,             & 
& ZcplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,             & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvTocFdFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MGluOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVG,MVP,MVWmOS,MVZOS,          & 
& MAh2OS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MGlu2OS,Mhh2OS,MHpm2OS,MSd2OS,             & 
& MSe2OS,MSu2OS,MSv2OS,MVG2,MVP2,MVWm2OS,MVZ2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFdChaSuL,    & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,            & 
& cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,         & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,             & 
& cplSvcSvVZ,AmpVertexIRosSvTocFdFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,              & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,             & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvTocFdFd)

 End if 
 End if 
AmpVertexSvTocFdFd = AmpVertexSvTocFdFd -  AmpVertexIRdrSvTocFdFd! +  AmpVertexIRosSvTocFdFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvTocFdFd=0._dp 
AmpVertexZSvTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocFdFd(:,gt2,:,:) = AmpWaveZSvTocFdFd(:,gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvTocFdFd(:,gt1,:,:) 
AmpVertexZSvTocFdFd(:,gt2,:,:)= AmpVertexZSvTocFdFd(:,gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvTocFdFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSvTocFdFd=AmpWaveZSvTocFdFd 
AmpVertexSvTocFdFd= AmpVertexZSvTocFdFd
! Final State 1 
AmpWaveZSvTocFdFd=0._dp 
AmpVertexZSvTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocFdFd(1,:,gt2,:) = AmpWaveZSvTocFdFd(1,:,gt2,:)+ZRUZDR(gt2,gt1)*AmpWaveSvTocFdFd(1,:,gt1,:) 
AmpVertexZSvTocFdFd(1,:,gt2,:)= AmpVertexZSvTocFdFd(1,:,gt2,:)+ZRUZDR(gt2,gt1)*AmpVertexSvTocFdFd(1,:,gt1,:) 
AmpWaveZSvTocFdFd(2,:,gt2,:) = AmpWaveZSvTocFdFd(2,:,gt2,:)+ZRUZDLc(gt2,gt1)*AmpWaveSvTocFdFd(2,:,gt1,:) 
AmpVertexZSvTocFdFd(2,:,gt2,:)= AmpVertexZSvTocFdFd(2,:,gt2,:)+ZRUZDLc(gt2,gt1)*AmpVertexSvTocFdFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSvTocFdFd=AmpWaveZSvTocFdFd 
AmpVertexSvTocFdFd= AmpVertexZSvTocFdFd
! Final State 2 
AmpWaveZSvTocFdFd=0._dp 
AmpVertexZSvTocFdFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocFdFd(1,:,:,gt2) = AmpWaveZSvTocFdFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveSvTocFdFd(1,:,:,gt1) 
AmpVertexZSvTocFdFd(1,:,:,gt2)= AmpVertexZSvTocFdFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexSvTocFdFd(1,:,:,gt1) 
AmpWaveZSvTocFdFd(2,:,:,gt2) = AmpWaveZSvTocFdFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveSvTocFdFd(2,:,:,gt1) 
AmpVertexZSvTocFdFd(2,:,:,gt2)= AmpVertexZSvTocFdFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexSvTocFdFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSvTocFdFd=AmpWaveZSvTocFdFd 
AmpVertexSvTocFdFd= AmpVertexZSvTocFdFd
End if
If (ShiftIRdiv) Then 
AmpVertexSvTocFdFd = AmpVertexSvTocFdFd  +  AmpVertexIRosSvTocFdFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->bar[Fd] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvTocFdFd = AmpTreeSvTocFdFd 
 AmpSum2SvTocFdFd = AmpTreeSvTocFdFd + 2._dp*AmpWaveSvTocFdFd + 2._dp*AmpVertexSvTocFdFd  
Else 
 AmpSumSvTocFdFd = AmpTreeSvTocFdFd + AmpWaveSvTocFdFd + AmpVertexSvTocFdFd
 AmpSum2SvTocFdFd = AmpTreeSvTocFdFd + AmpWaveSvTocFdFd + AmpVertexSvTocFdFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTocFdFd = AmpTreeSvTocFdFd
 AmpSum2SvTocFdFd = AmpTreeSvTocFdFd 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MFdOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MFd(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvTocFdFd = AmpTreeSvTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFd(gt2),MFd(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvTocFdFd(gt1, gt2, gt3) 
  AmpSum2SvTocFdFd = 2._dp*AmpWaveSvTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFd(gt2),MFd(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvTocFdFd(gt1, gt2, gt3) 
  AmpSum2SvTocFdFd = 2._dp*AmpVertexSvTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFd(gt2),MFd(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvTocFdFd(gt1, gt2, gt3) 
  AmpSum2SvTocFdFd = AmpTreeSvTocFdFd + 2._dp*AmpWaveSvTocFdFd + 2._dp*AmpVertexSvTocFdFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFd(gt2),MFd(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvTocFdFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvTocFdFd = AmpTreeSvTocFdFd
  Call SquareAmp_StoFF(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
  AmpSqTreeSvTocFdFd(gt1, gt2, gt3) = (3)*AmpSqSvTocFdFd(gt1, gt2, gt3)  
  AmpSum2SvTocFdFd = + 2._dp*AmpWaveSvTocFdFd + 2._dp*AmpVertexSvTocFdFd
  Call SquareAmp_StoFF(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
  AmpSqSvTocFdFd(gt1, gt2, gt3) = AmpSqSvTocFdFd(gt1, gt2, gt3) + AmpSqTreeSvTocFdFd(gt1, gt2, gt3)  
Else  
  AmpSum2SvTocFdFd = AmpTreeSvTocFdFd
  Call SquareAmp_StoFF(MSv(gt1),MFd(gt2),MFd(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
  AmpSqTreeSvTocFdFd(gt1, gt2, gt3) = (3)*AmpSqSvTocFdFd(gt1, gt2, gt3)  
  AmpSum2SvTocFdFd = + 2._dp*AmpWaveSvTocFdFd + 2._dp*AmpVertexSvTocFdFd
  Call SquareAmp_StoFF(MSv(gt1),MFd(gt2),MFd(gt3),AmpSumSvTocFdFd(:,gt1, gt2, gt3),AmpSum2SvTocFdFd(:,gt1, gt2, gt3),AmpSqSvTocFdFd(gt1, gt2, gt3)) 
  AmpSqSvTocFdFd(gt1, gt2, gt3) = AmpSqSvTocFdFd(gt1, gt2, gt3) + AmpSqTreeSvTocFdFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvTocFdFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvTocFdFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MFdOS(gt2),MFdOS(gt3),helfactor*AmpSqSvTocFdFd(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MFd(gt2),MFd(gt3),helfactor*AmpSqSvTocFdFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocFdFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocFdFd(gt1, gt2, gt3) + MRGSvTocFdFd(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocFdFd(gt1, gt2, gt3) + MRGSvTocFdFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! bar(Cha) Fe
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvTocChaFe(cplcChaFecSvL,cplcChaFecSvR,MCha,           & 
& MFe,MSv,MCha2,MFe2,MSv2,AmpTreeSvTocChaFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvTocChaFe(ZcplcChaFecSvL,ZcplcChaFecSvR,              & 
& MCha,MFe,MSv,MCha2,MFe2,MSv2,AmpTreeSvTocChaFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocChaFe(MLambda,em,gs,cplcChaFecSvL,cplcChaFecSvR,      & 
& MChaOS,MFeOS,MSvOS,MRPSvTocChaFe,MRGSvTocChaFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocChaFe(MLambda,em,gs,ZcplcChaFecSvL,ZcplcChaFecSvR,    & 
& MChaOS,MFeOS,MSvOS,MRPSvTocChaFe,MRGSvTocChaFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvTocChaFe(MLambda,em,gs,cplcChaFecSvL,cplcChaFecSvR,      & 
& MCha,MFe,MSv,MRPSvTocChaFe,MRGSvTocChaFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocChaFe(MLambda,em,gs,ZcplcChaFecSvL,ZcplcChaFecSvR,    & 
& MCha,MFe,MSv,MRPSvTocChaFe,MRGSvTocChaFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTocChaFe(cplcChaFecSvL,cplcChaFecSvR,ctcplcChaFecSvL,& 
& ctcplcChaFecSvR,MCha,MCha2,MFe,MFe2,MSv,MSv2,ZfFEL,ZfFER,ZfLm,ZfLp,ZfSv,               & 
& AmpWaveSvTocChaFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTocChaFe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,     & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,      & 
& cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,              & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,          & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexSvTocChaFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFeFeAhL,     & 
& cplcFeFeAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,     & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,      & 
& cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,              & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,          & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRdrSvTocChaFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplcFeFeAhL,cplcFeFeAhR,        & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& ZcplcChaFecSvL,ZcplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,     & 
& cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,           & 
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvTocChaFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFeFeAhL,     & 
& cplcFeFeAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,     & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,      & 
& cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,              & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,ZcplcChaFecSvL,ZcplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcChaFvSeL,cplcChaFvSeR,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,          & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvTocChaFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplcFeFeAhL,cplcFeFeAhR,        & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,       & 
& cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,           & 
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvTocChaFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFeFeAhL,     & 
& cplcFeFeAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,     & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,      & 
& cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,              & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,          & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosSvTocChaFe)

 End if 
 End if 
AmpVertexSvTocChaFe = AmpVertexSvTocChaFe -  AmpVertexIRdrSvTocChaFe! +  AmpVertexIRosSvTocChaFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvTocChaFe=0._dp 
AmpVertexZSvTocChaFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocChaFe(:,gt2,:,:) = AmpWaveZSvTocChaFe(:,gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvTocChaFe(:,gt1,:,:) 
AmpVertexZSvTocChaFe(:,gt2,:,:)= AmpVertexZSvTocChaFe(:,gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvTocChaFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSvTocChaFe=AmpWaveZSvTocChaFe 
AmpVertexSvTocChaFe= AmpVertexZSvTocChaFe
! Final State 1 
AmpWaveZSvTocChaFe=0._dp 
AmpVertexZSvTocChaFe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSvTocChaFe(1,:,gt2,:) = AmpWaveZSvTocChaFe(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveSvTocChaFe(1,:,gt1,:) 
AmpVertexZSvTocChaFe(1,:,gt2,:)= AmpVertexZSvTocChaFe(1,:,gt2,:)+ZRUUP(gt2,gt1)*AmpVertexSvTocChaFe(1,:,gt1,:) 
AmpWaveZSvTocChaFe(2,:,gt2,:) = AmpWaveZSvTocChaFe(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveSvTocChaFe(2,:,gt1,:) 
AmpVertexZSvTocChaFe(2,:,gt2,:)= AmpVertexZSvTocChaFe(2,:,gt2,:)+ZRUUMc(gt2,gt1)*AmpVertexSvTocChaFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSvTocChaFe=AmpWaveZSvTocChaFe 
AmpVertexSvTocChaFe= AmpVertexZSvTocChaFe
! Final State 2 
AmpWaveZSvTocChaFe=0._dp 
AmpVertexZSvTocChaFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocChaFe(1,:,:,gt2) = AmpWaveZSvTocChaFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWaveSvTocChaFe(1,:,:,gt1) 
AmpVertexZSvTocChaFe(1,:,:,gt2)= AmpVertexZSvTocChaFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexSvTocChaFe(1,:,:,gt1) 
AmpWaveZSvTocChaFe(2,:,:,gt2) = AmpWaveZSvTocChaFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWaveSvTocChaFe(2,:,:,gt1) 
AmpVertexZSvTocChaFe(2,:,:,gt2)= AmpVertexZSvTocChaFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexSvTocChaFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSvTocChaFe=AmpWaveZSvTocChaFe 
AmpVertexSvTocChaFe= AmpVertexZSvTocChaFe
End if
If (ShiftIRdiv) Then 
AmpVertexSvTocChaFe = AmpVertexSvTocChaFe  +  AmpVertexIRosSvTocChaFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->bar[Cha] Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvTocChaFe = AmpTreeSvTocChaFe 
 AmpSum2SvTocChaFe = AmpTreeSvTocChaFe + 2._dp*AmpWaveSvTocChaFe + 2._dp*AmpVertexSvTocChaFe  
Else 
 AmpSumSvTocChaFe = AmpTreeSvTocChaFe + AmpWaveSvTocChaFe + AmpVertexSvTocChaFe
 AmpSum2SvTocChaFe = AmpTreeSvTocChaFe + AmpWaveSvTocChaFe + AmpVertexSvTocChaFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTocChaFe = AmpTreeSvTocChaFe
 AmpSum2SvTocChaFe = AmpTreeSvTocChaFe 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MChaOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MCha(gt2)+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvTocChaFe = AmpTreeSvTocChaFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MFe(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvTocChaFe(gt1, gt2, gt3) 
  AmpSum2SvTocChaFe = 2._dp*AmpWaveSvTocChaFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MFe(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvTocChaFe(gt1, gt2, gt3) 
  AmpSum2SvTocChaFe = 2._dp*AmpVertexSvTocChaFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MFe(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvTocChaFe(gt1, gt2, gt3) 
  AmpSum2SvTocChaFe = AmpTreeSvTocChaFe + 2._dp*AmpWaveSvTocChaFe + 2._dp*AmpVertexSvTocChaFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MFe(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvTocChaFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvTocChaFe = AmpTreeSvTocChaFe
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocChaFe(gt1, gt2, gt3) = (1)*AmpSqSvTocChaFe(gt1, gt2, gt3)  
  AmpSum2SvTocChaFe = + 2._dp*AmpWaveSvTocChaFe + 2._dp*AmpVertexSvTocChaFe
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
  AmpSqSvTocChaFe(gt1, gt2, gt3) = AmpSqSvTocChaFe(gt1, gt2, gt3) + AmpSqTreeSvTocChaFe(gt1, gt2, gt3)  
Else  
  AmpSum2SvTocChaFe = AmpTreeSvTocChaFe
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MFe(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocChaFe(gt1, gt2, gt3) = (1)*AmpSqSvTocChaFe(gt1, gt2, gt3)  
  AmpSum2SvTocChaFe = + 2._dp*AmpWaveSvTocChaFe + 2._dp*AmpVertexSvTocChaFe
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MFe(gt3),AmpSumSvTocChaFe(:,gt1, gt2, gt3),AmpSum2SvTocChaFe(:,gt1, gt2, gt3),AmpSqSvTocChaFe(gt1, gt2, gt3)) 
  AmpSqSvTocChaFe(gt1, gt2, gt3) = AmpSqSvTocChaFe(gt1, gt2, gt3) + AmpSqTreeSvTocChaFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvTocChaFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvTocChaFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MChaOS(gt2),MFeOS(gt3),helfactor*AmpSqSvTocChaFe(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MCha(gt2),MFe(gt3),helfactor*AmpSqSvTocChaFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTocChaFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocChaFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvTocChaFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocChaFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocChaFe(gt1, gt2, gt3) + MRGSvTocChaFe(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocChaFe(gt1, gt2, gt3) + MRGSvTocChaFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! bar(Fe) Fe
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvTocFeFe(cplcFeFecSvL,cplcFeFecSvR,MFe,               & 
& MSv,MFe2,MSv2,AmpTreeSvTocFeFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvTocFeFe(ZcplcFeFecSvL,ZcplcFeFecSvR,MFe,             & 
& MSv,MFe2,MSv2,AmpTreeSvTocFeFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocFeFe(MLambda,em,gs,cplcFeFecSvL,cplcFeFecSvR,         & 
& MFeOS,MSvOS,MRPSvTocFeFe,MRGSvTocFeFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocFeFe(MLambda,em,gs,ZcplcFeFecSvL,ZcplcFeFecSvR,       & 
& MFeOS,MSvOS,MRPSvTocFeFe,MRGSvTocFeFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvTocFeFe(MLambda,em,gs,cplcFeFecSvL,cplcFeFecSvR,         & 
& MFe,MSv,MRPSvTocFeFe,MRGSvTocFeFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocFeFe(MLambda,em,gs,ZcplcFeFecSvL,ZcplcFeFecSvR,       & 
& MFe,MSv,MRPSvTocFeFe,MRGSvTocFeFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTocFeFe(cplcFeFecSvL,cplcFeFecSvR,ctcplcFeFecSvL,    & 
& ctcplcFeFecSvR,MFe,MFe2,MSv,MSv2,ZfFEL,ZfFER,ZfSv,AmpWaveSvTocFeFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,              & 
& cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,             & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& cplSvcSvVZ,AmpVertexSvTocFeFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,        & 
& cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,             & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& cplSvcSvVZ,AmpVertexIRdrSvTocFeFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,cplcFeChaSvR,          & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,ZcplcFeFecSvL,ZcplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,     & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,             & 
& AmpVertexIRosSvTocFeFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,        & 
& cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,ZcplcFeFecSvL,ZcplcFeFecSvR,cplcFeFvHpmL,      & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,             & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& cplSvcSvVZ,AmpVertexIRosSvTocFeFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,cplcFeChaSvR,          & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,       & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,             & 
& AmpVertexIRosSvTocFeFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,        & 
& cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,             & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& cplSvcSvVZ,AmpVertexIRosSvTocFeFe)

 End if 
 End if 
AmpVertexSvTocFeFe = AmpVertexSvTocFeFe -  AmpVertexIRdrSvTocFeFe! +  AmpVertexIRosSvTocFeFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvTocFeFe=0._dp 
AmpVertexZSvTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocFeFe(:,gt2,:,:) = AmpWaveZSvTocFeFe(:,gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvTocFeFe(:,gt1,:,:) 
AmpVertexZSvTocFeFe(:,gt2,:,:)= AmpVertexZSvTocFeFe(:,gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvTocFeFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSvTocFeFe=AmpWaveZSvTocFeFe 
AmpVertexSvTocFeFe= AmpVertexZSvTocFeFe
! Final State 1 
AmpWaveZSvTocFeFe=0._dp 
AmpVertexZSvTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocFeFe(1,:,gt2,:) = AmpWaveZSvTocFeFe(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpWaveSvTocFeFe(1,:,gt1,:) 
AmpVertexZSvTocFeFe(1,:,gt2,:)= AmpVertexZSvTocFeFe(1,:,gt2,:)+ZRUZER(gt2,gt1)*AmpVertexSvTocFeFe(1,:,gt1,:) 
AmpWaveZSvTocFeFe(2,:,gt2,:) = AmpWaveZSvTocFeFe(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpWaveSvTocFeFe(2,:,gt1,:) 
AmpVertexZSvTocFeFe(2,:,gt2,:)= AmpVertexZSvTocFeFe(2,:,gt2,:)+ZRUZELc(gt2,gt1)*AmpVertexSvTocFeFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSvTocFeFe=AmpWaveZSvTocFeFe 
AmpVertexSvTocFeFe= AmpVertexZSvTocFeFe
! Final State 2 
AmpWaveZSvTocFeFe=0._dp 
AmpVertexZSvTocFeFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocFeFe(1,:,:,gt2) = AmpWaveZSvTocFeFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWaveSvTocFeFe(1,:,:,gt1) 
AmpVertexZSvTocFeFe(1,:,:,gt2)= AmpVertexZSvTocFeFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexSvTocFeFe(1,:,:,gt1) 
AmpWaveZSvTocFeFe(2,:,:,gt2) = AmpWaveZSvTocFeFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWaveSvTocFeFe(2,:,:,gt1) 
AmpVertexZSvTocFeFe(2,:,:,gt2)= AmpVertexZSvTocFeFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexSvTocFeFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSvTocFeFe=AmpWaveZSvTocFeFe 
AmpVertexSvTocFeFe= AmpVertexZSvTocFeFe
End if
If (ShiftIRdiv) Then 
AmpVertexSvTocFeFe = AmpVertexSvTocFeFe  +  AmpVertexIRosSvTocFeFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->bar[Fe] Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvTocFeFe = AmpTreeSvTocFeFe 
 AmpSum2SvTocFeFe = AmpTreeSvTocFeFe + 2._dp*AmpWaveSvTocFeFe + 2._dp*AmpVertexSvTocFeFe  
Else 
 AmpSumSvTocFeFe = AmpTreeSvTocFeFe + AmpWaveSvTocFeFe + AmpVertexSvTocFeFe
 AmpSum2SvTocFeFe = AmpTreeSvTocFeFe + AmpWaveSvTocFeFe + AmpVertexSvTocFeFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTocFeFe = AmpTreeSvTocFeFe
 AmpSum2SvTocFeFe = AmpTreeSvTocFeFe 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MFeOS(gt2)+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MFe(gt2)+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvTocFeFe = AmpTreeSvTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFe(gt2),MFe(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvTocFeFe(gt1, gt2, gt3) 
  AmpSum2SvTocFeFe = 2._dp*AmpWaveSvTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFe(gt2),MFe(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvTocFeFe(gt1, gt2, gt3) 
  AmpSum2SvTocFeFe = 2._dp*AmpVertexSvTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFe(gt2),MFe(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvTocFeFe(gt1, gt2, gt3) 
  AmpSum2SvTocFeFe = AmpTreeSvTocFeFe + 2._dp*AmpWaveSvTocFeFe + 2._dp*AmpVertexSvTocFeFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFe(gt2),MFe(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvTocFeFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvTocFeFe = AmpTreeSvTocFeFe
  Call SquareAmp_StoFF(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocFeFe(gt1, gt2, gt3) = (1)*AmpSqSvTocFeFe(gt1, gt2, gt3)  
  AmpSum2SvTocFeFe = + 2._dp*AmpWaveSvTocFeFe + 2._dp*AmpVertexSvTocFeFe
  Call SquareAmp_StoFF(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
  AmpSqSvTocFeFe(gt1, gt2, gt3) = AmpSqSvTocFeFe(gt1, gt2, gt3) + AmpSqTreeSvTocFeFe(gt1, gt2, gt3)  
Else  
  AmpSum2SvTocFeFe = AmpTreeSvTocFeFe
  Call SquareAmp_StoFF(MSv(gt1),MFe(gt2),MFe(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocFeFe(gt1, gt2, gt3) = (1)*AmpSqSvTocFeFe(gt1, gt2, gt3)  
  AmpSum2SvTocFeFe = + 2._dp*AmpWaveSvTocFeFe + 2._dp*AmpVertexSvTocFeFe
  Call SquareAmp_StoFF(MSv(gt1),MFe(gt2),MFe(gt3),AmpSumSvTocFeFe(:,gt1, gt2, gt3),AmpSum2SvTocFeFe(:,gt1, gt2, gt3),AmpSqSvTocFeFe(gt1, gt2, gt3)) 
  AmpSqSvTocFeFe(gt1, gt2, gt3) = AmpSqSvTocFeFe(gt1, gt2, gt3) + AmpSqTreeSvTocFeFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvTocFeFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvTocFeFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MFeOS(gt2),MFeOS(gt3),helfactor*AmpSqSvTocFeFe(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MFe(gt2),MFe(gt3),helfactor*AmpSqSvTocFeFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocFeFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocFeFe(gt1, gt2, gt3) + MRGSvTocFeFe(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocFeFe(gt1, gt2, gt3) + MRGSvTocFeFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! Sv hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvToSvhh(cplhhSvcSv,Mhh,MSv,Mhh2,MSv2,AmpTreeSvToSvhh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvToSvhh(ZcplhhSvcSv,Mhh,MSv,Mhh2,MSv2,AmpTreeSvToSvhh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSvhh(MLambda,em,gs,cplhhSvcSv,MhhOS,MSvOS,             & 
& MRPSvToSvhh,MRGSvToSvhh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSvhh(MLambda,em,gs,ZcplhhSvcSv,MhhOS,MSvOS,            & 
& MRPSvToSvhh,MRGSvToSvhh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvToSvhh(MLambda,em,gs,cplhhSvcSv,Mhh,MSv,MRPSvToSvhh,     & 
& MRGSvToSvhh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSvhh(MLambda,em,gs,ZcplhhSvcSv,Mhh,MSv,MRPSvToSvhh,    & 
& MRGSvToSvhh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvhh(cplhhSvcSv,ctcplhhSvcSv,Mhh,Mhh2,             & 
& MSv,MSv2,Zfhh,ZfSv,AmpWaveSvToSvhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvhh(MAh,MCha,MChi,MFd,MFe,Mhh,MHpm,             & 
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
& cplSvcSvVZVZ1,AmpVertexSvToSvhh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh(MAh,MCha,MChi,MFd,MFe,Mhh,               & 
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
& cplSvcSvVZVZ1,AmpVertexIRdrSvToSvhh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& AmpVertexIRosSvToSvhh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh(MAh,MCha,MChi,MFd,MFe,Mhh,               & 
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
& cplSvcSvVZVZ1,AmpVertexIRosSvToSvhh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& AmpVertexIRosSvToSvhh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh(MAh,MCha,MChi,MFd,MFe,Mhh,               & 
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
& cplSvcSvVZVZ1,AmpVertexIRosSvToSvhh)

 End if 
 End if 
AmpVertexSvToSvhh = AmpVertexSvToSvhh -  AmpVertexIRdrSvToSvhh! +  AmpVertexIRosSvToSvhh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvToSvhh=0._dp 
AmpVertexZSvToSvhh=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToSvhh(gt2,:,:) = AmpWaveZSvToSvhh(gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvToSvhh(gt1,:,:) 
AmpVertexZSvToSvhh(gt2,:,:)= AmpVertexZSvToSvhh(gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvToSvhh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSvToSvhh=AmpWaveZSvToSvhh 
AmpVertexSvToSvhh= AmpVertexZSvToSvhh
! Final State 1 
AmpWaveZSvToSvhh=0._dp 
AmpVertexZSvToSvhh=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToSvhh(:,gt2,:) = AmpWaveZSvToSvhh(:,gt2,:)+ZRUZV(gt2,gt1)*AmpWaveSvToSvhh(:,gt1,:) 
AmpVertexZSvToSvhh(:,gt2,:)= AmpVertexZSvToSvhh(:,gt2,:)+ZRUZV(gt2,gt1)*AmpVertexSvToSvhh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSvToSvhh=AmpWaveZSvToSvhh 
AmpVertexSvToSvhh= AmpVertexZSvToSvhh
! Final State 2 
AmpWaveZSvToSvhh=0._dp 
AmpVertexZSvToSvhh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSvToSvhh(:,:,gt2) = AmpWaveZSvToSvhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveSvToSvhh(:,:,gt1) 
AmpVertexZSvToSvhh(:,:,gt2)= AmpVertexZSvToSvhh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexSvToSvhh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSvToSvhh=AmpWaveZSvToSvhh 
AmpVertexSvToSvhh= AmpVertexZSvToSvhh
End if
If (ShiftIRdiv) Then 
AmpVertexSvToSvhh = AmpVertexSvToSvhh  +  AmpVertexIRosSvToSvhh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Sv hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvToSvhh = AmpTreeSvToSvhh 
 AmpSum2SvToSvhh = AmpTreeSvToSvhh + 2._dp*AmpWaveSvToSvhh + 2._dp*AmpVertexSvToSvhh  
Else 
 AmpSumSvToSvhh = AmpTreeSvToSvhh + AmpWaveSvToSvhh + AmpVertexSvToSvhh
 AmpSum2SvToSvhh = AmpTreeSvToSvhh + AmpWaveSvToSvhh + AmpVertexSvToSvhh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSvhh = AmpTreeSvToSvhh
 AmpSum2SvToSvhh = AmpTreeSvToSvhh 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSvOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSv(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvToSvhh = AmpTreeSvToSvhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),Mhh(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvToSvhh(gt1, gt2, gt3) 
  AmpSum2SvToSvhh = 2._dp*AmpWaveSvToSvhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),Mhh(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvToSvhh(gt1, gt2, gt3) 
  AmpSum2SvToSvhh = 2._dp*AmpVertexSvToSvhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),Mhh(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvToSvhh(gt1, gt2, gt3) 
  AmpSum2SvToSvhh = AmpTreeSvToSvhh + 2._dp*AmpWaveSvToSvhh + 2._dp*AmpVertexSvToSvhh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),Mhh(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvToSvhh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvToSvhh = AmpTreeSvToSvhh
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
  AmpSqTreeSvToSvhh(gt1, gt2, gt3) = (1)*AmpSqSvToSvhh(gt1, gt2, gt3)  
  AmpSum2SvToSvhh = + 2._dp*AmpWaveSvToSvhh + 2._dp*AmpVertexSvToSvhh
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
  AmpSqSvToSvhh(gt1, gt2, gt3) = AmpSqSvToSvhh(gt1, gt2, gt3) + AmpSqTreeSvToSvhh(gt1, gt2, gt3)  
Else  
  AmpSum2SvToSvhh = AmpTreeSvToSvhh
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),Mhh(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
  AmpSqTreeSvToSvhh(gt1, gt2, gt3) = (1)*AmpSqSvToSvhh(gt1, gt2, gt3)  
  AmpSum2SvToSvhh = + 2._dp*AmpWaveSvToSvhh + 2._dp*AmpVertexSvToSvhh
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),Mhh(gt3),AmpSumSvToSvhh(gt1, gt2, gt3),AmpSum2SvToSvhh(gt1, gt2, gt3),AmpSqSvToSvhh(gt1, gt2, gt3)) 
  AmpSqSvToSvhh(gt1, gt2, gt3) = AmpSqSvToSvhh(gt1, gt2, gt3) + AmpSqTreeSvToSvhh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvToSvhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToSvhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSvOS(gt2),MhhOS(gt3),helfactor*AmpSqSvToSvhh(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSv(gt2),Mhh(gt3),helfactor*AmpSqSvToSvhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToSvhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvToSvhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvToSvhh(gt1, gt2, gt3) + MRGSvToSvhh(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvToSvhh(gt1, gt2, gt3) + MRGSvToSvhh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! Conjg(Sd) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvTocSdSd(cplSdcSdcSv,MSd,MSv,MSd2,MSv2,               & 
& AmpTreeSvTocSdSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvTocSdSd(ZcplSdcSdcSv,MSd,MSv,MSd2,MSv2,              & 
& AmpTreeSvTocSdSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocSdSd(MLambda,em,gs,cplSdcSdcSv,MSdOS,MSvOS,           & 
& MRPSvTocSdSd,MRGSvTocSdSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocSdSd(MLambda,em,gs,ZcplSdcSdcSv,MSdOS,MSvOS,          & 
& MRPSvTocSdSd,MRGSvTocSdSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvTocSdSd(MLambda,em,gs,cplSdcSdcSv,MSd,MSv,               & 
& MRPSvTocSdSd,MRGSvTocSdSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocSdSd(MLambda,em,gs,ZcplSdcSdcSv,MSd,MSv,              & 
& MRPSvTocSdSd,MRGSvTocSdSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTocSdSd(cplSdcSdcSv,ctcplSdcSdcSv,MSd,               & 
& MSd2,MSv,MSv2,ZfSd,ZfSv,AmpWaveSvTocSdSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexSvTocSdSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRdrSvTocSdSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSvTocSdSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSvTocSdSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSvTocSdSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,AmpVertexIRosSvTocSdSd)

 End if 
 End if 
AmpVertexSvTocSdSd = AmpVertexSvTocSdSd -  AmpVertexIRdrSvTocSdSd! +  AmpVertexIRosSvTocSdSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvTocSdSd=0._dp 
AmpVertexZSvTocSdSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocSdSd(gt2,:,:) = AmpWaveZSvTocSdSd(gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvTocSdSd(gt1,:,:) 
AmpVertexZSvTocSdSd(gt2,:,:)= AmpVertexZSvTocSdSd(gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvTocSdSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveSvTocSdSd=AmpWaveZSvTocSdSd 
AmpVertexSvTocSdSd= AmpVertexZSvTocSdSd
! Final State 1 
AmpWaveZSvTocSdSd=0._dp 
AmpVertexZSvTocSdSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSvTocSdSd(:,gt2,:) = AmpWaveZSvTocSdSd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpWaveSvTocSdSd(:,gt1,:) 
AmpVertexZSvTocSdSd(:,gt2,:)= AmpVertexZSvTocSdSd(:,gt2,:)+ZRUZDc(gt2,gt1)*AmpVertexSvTocSdSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSvTocSdSd=AmpWaveZSvTocSdSd 
AmpVertexSvTocSdSd= AmpVertexZSvTocSdSd
! Final State 2 
AmpWaveZSvTocSdSd=0._dp 
AmpVertexZSvTocSdSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSvTocSdSd(:,:,gt2) = AmpWaveZSvTocSdSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSvTocSdSd(:,:,gt1) 
AmpVertexZSvTocSdSd(:,:,gt2)= AmpVertexZSvTocSdSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSvTocSdSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveSvTocSdSd=AmpWaveZSvTocSdSd 
AmpVertexSvTocSdSd= AmpVertexZSvTocSdSd
End if
If (ShiftIRdiv) Then 
AmpVertexSvTocSdSd = AmpVertexSvTocSdSd  +  AmpVertexIRosSvTocSdSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->conj[Sd] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvTocSdSd = AmpTreeSvTocSdSd 
 AmpSum2SvTocSdSd = AmpTreeSvTocSdSd + 2._dp*AmpWaveSvTocSdSd + 2._dp*AmpVertexSvTocSdSd  
Else 
 AmpSumSvTocSdSd = AmpTreeSvTocSdSd + AmpWaveSvTocSdSd + AmpVertexSvTocSdSd
 AmpSum2SvTocSdSd = AmpTreeSvTocSdSd + AmpWaveSvTocSdSd + AmpVertexSvTocSdSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTocSdSd = AmpTreeSvTocSdSd
 AmpSum2SvTocSdSd = AmpTreeSvTocSdSd 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSdOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSd(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvTocSdSd = AmpTreeSvTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSd(gt2),MSd(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvTocSdSd(gt1, gt2, gt3) 
  AmpSum2SvTocSdSd = 2._dp*AmpWaveSvTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSd(gt2),MSd(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvTocSdSd(gt1, gt2, gt3) 
  AmpSum2SvTocSdSd = 2._dp*AmpVertexSvTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSd(gt2),MSd(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvTocSdSd(gt1, gt2, gt3) 
  AmpSum2SvTocSdSd = AmpTreeSvTocSdSd + 2._dp*AmpWaveSvTocSdSd + 2._dp*AmpVertexSvTocSdSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSd(gt2),MSd(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvTocSdSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvTocSdSd = AmpTreeSvTocSdSd
  Call SquareAmp_StoSS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
  AmpSqTreeSvTocSdSd(gt1, gt2, gt3) = (3)*AmpSqSvTocSdSd(gt1, gt2, gt3)  
  AmpSum2SvTocSdSd = + 2._dp*AmpWaveSvTocSdSd + 2._dp*AmpVertexSvTocSdSd
  Call SquareAmp_StoSS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
  AmpSqSvTocSdSd(gt1, gt2, gt3) = AmpSqSvTocSdSd(gt1, gt2, gt3) + AmpSqTreeSvTocSdSd(gt1, gt2, gt3)  
Else  
  AmpSum2SvTocSdSd = AmpTreeSvTocSdSd
  Call SquareAmp_StoSS(MSv(gt1),MSd(gt2),MSd(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
  AmpSqTreeSvTocSdSd(gt1, gt2, gt3) = (3)*AmpSqSvTocSdSd(gt1, gt2, gt3)  
  AmpSum2SvTocSdSd = + 2._dp*AmpWaveSvTocSdSd + 2._dp*AmpVertexSvTocSdSd
  Call SquareAmp_StoSS(MSv(gt1),MSd(gt2),MSd(gt3),AmpSumSvTocSdSd(gt1, gt2, gt3),AmpSum2SvTocSdSd(gt1, gt2, gt3),AmpSqSvTocSdSd(gt1, gt2, gt3)) 
  AmpSqSvTocSdSd(gt1, gt2, gt3) = AmpSqSvTocSdSd(gt1, gt2, gt3) + AmpSqTreeSvTocSdSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvTocSdSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvTocSdSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSdOS(gt2),MSdOS(gt3),helfactor*AmpSqSvTocSdSd(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSd(gt2),MSd(gt3),helfactor*AmpSqSvTocSdSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocSdSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocSdSd(gt1, gt2, gt3) + MRGSvTocSdSd(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocSdSd(gt1, gt2, gt3) + MRGSvTocSdSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! Conjg(Hpm) Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvTocHpmSe(cplSecHpmcSv,MHpm,MSe,MSv,MHpm2,            & 
& MSe2,MSv2,AmpTreeSvTocHpmSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvTocHpmSe(ZcplSecHpmcSv,MHpm,MSe,MSv,MHpm2,           & 
& MSe2,MSv2,AmpTreeSvTocHpmSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocHpmSe(MLambda,em,gs,cplSecHpmcSv,MHpmOS,              & 
& MSeOS,MSvOS,MRPSvTocHpmSe,MRGSvTocHpmSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocHpmSe(MLambda,em,gs,ZcplSecHpmcSv,MHpmOS,             & 
& MSeOS,MSvOS,MRPSvTocHpmSe,MRGSvTocHpmSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvTocHpmSe(MLambda,em,gs,cplSecHpmcSv,MHpm,MSe,            & 
& MSv,MRPSvTocHpmSe,MRGSvTocHpmSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocHpmSe(MLambda,em,gs,ZcplSecHpmcSv,MHpm,               & 
& MSe,MSv,MRPSvTocHpmSe,MRGSvTocHpmSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTocHpmSe(cplSecHpmcSv,ctcplSecHpmcSv,MHpm,           & 
& MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,ZfSe,ZfSv,AmpWaveSvTocHpmSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTocHpmSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
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
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexSvTocHpmSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRdrSvTocHpmSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosSvTocHpmSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosSvTocHpmSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosSvTocHpmSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,AmpVertexIRosSvTocHpmSe)

 End if 
 End if 
AmpVertexSvTocHpmSe = AmpVertexSvTocHpmSe -  AmpVertexIRdrSvTocHpmSe! +  AmpVertexIRosSvTocHpmSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvTocHpmSe=0._dp 
AmpVertexZSvTocHpmSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocHpmSe(gt2,:,:) = AmpWaveZSvTocHpmSe(gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvTocHpmSe(gt1,:,:) 
AmpVertexZSvTocHpmSe(gt2,:,:)= AmpVertexZSvTocHpmSe(gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvTocHpmSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveSvTocHpmSe=AmpWaveZSvTocHpmSe 
AmpVertexSvTocHpmSe= AmpVertexZSvTocHpmSe
! Final State 1 
AmpWaveZSvTocHpmSe=0._dp 
AmpVertexZSvTocHpmSe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSvTocHpmSe(:,gt2,:) = AmpWaveZSvTocHpmSe(:,gt2,:)+ZRUZP(gt2,gt1)*AmpWaveSvTocHpmSe(:,gt1,:) 
AmpVertexZSvTocHpmSe(:,gt2,:)= AmpVertexZSvTocHpmSe(:,gt2,:)+ZRUZP(gt2,gt1)*AmpVertexSvTocHpmSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveSvTocHpmSe=AmpWaveZSvTocHpmSe 
AmpVertexSvTocHpmSe= AmpVertexZSvTocHpmSe
! Final State 2 
AmpWaveZSvTocHpmSe=0._dp 
AmpVertexZSvTocHpmSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSvTocHpmSe(:,:,gt2) = AmpWaveZSvTocHpmSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSvTocHpmSe(:,:,gt1) 
AmpVertexZSvTocHpmSe(:,:,gt2)= AmpVertexZSvTocHpmSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSvTocHpmSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveSvTocHpmSe=AmpWaveZSvTocHpmSe 
AmpVertexSvTocHpmSe= AmpVertexZSvTocHpmSe
End if
If (ShiftIRdiv) Then 
AmpVertexSvTocHpmSe = AmpVertexSvTocHpmSe  +  AmpVertexIRosSvTocHpmSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->conj[Hpm] Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvTocHpmSe = AmpTreeSvTocHpmSe 
 AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe + 2._dp*AmpWaveSvTocHpmSe + 2._dp*AmpVertexSvTocHpmSe  
Else 
 AmpSumSvTocHpmSe = AmpTreeSvTocHpmSe + AmpWaveSvTocHpmSe + AmpVertexSvTocHpmSe
 AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe + AmpWaveSvTocHpmSe + AmpVertexSvTocHpmSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTocHpmSe = AmpTreeSvTocHpmSe
 AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
    Do gt3=1,6
If (((OSkinematics).and.(MSvOS(gt1).gt.(MHpmOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MHpm(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MSe(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvTocHpmSe(gt1, gt2, gt3) 
  AmpSum2SvTocHpmSe = 2._dp*AmpWaveSvTocHpmSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MSe(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvTocHpmSe(gt1, gt2, gt3) 
  AmpSum2SvTocHpmSe = 2._dp*AmpVertexSvTocHpmSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MSe(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvTocHpmSe(gt1, gt2, gt3) 
  AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe + 2._dp*AmpWaveSvTocHpmSe + 2._dp*AmpVertexSvTocHpmSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MSe(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvTocHpmSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocHpmSe(gt1, gt2, gt3) = (1)*AmpSqSvTocHpmSe(gt1, gt2, gt3)  
  AmpSum2SvTocHpmSe = + 2._dp*AmpWaveSvTocHpmSe + 2._dp*AmpVertexSvTocHpmSe
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
  AmpSqSvTocHpmSe(gt1, gt2, gt3) = AmpSqSvTocHpmSe(gt1, gt2, gt3) + AmpSqTreeSvTocHpmSe(gt1, gt2, gt3)  
Else  
  AmpSum2SvTocHpmSe = AmpTreeSvTocHpmSe
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MSe(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocHpmSe(gt1, gt2, gt3) = (1)*AmpSqSvTocHpmSe(gt1, gt2, gt3)  
  AmpSum2SvTocHpmSe = + 2._dp*AmpWaveSvTocHpmSe + 2._dp*AmpVertexSvTocHpmSe
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MSe(gt3),AmpSumSvTocHpmSe(gt1, gt2, gt3),AmpSum2SvTocHpmSe(gt1, gt2, gt3),AmpSqSvTocHpmSe(gt1, gt2, gt3)) 
  AmpSqSvTocHpmSe(gt1, gt2, gt3) = AmpSqSvTocHpmSe(gt1, gt2, gt3) + AmpSqTreeSvTocHpmSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvTocHpmSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvTocHpmSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MHpmOS(gt2),MSeOS(gt3),helfactor*AmpSqSvTocHpmSe(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MHpm(gt2),MSe(gt3),helfactor*AmpSqSvTocHpmSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTocHpmSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocHpmSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvTocHpmSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocHpmSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocHpmSe(gt1, gt2, gt3) + MRGSvTocHpmSe(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocHpmSe(gt1, gt2, gt3) + MRGSvTocHpmSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! Conjg(Se) Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvTocSeSe(cplSecSecSv,MSe,MSv,MSe2,MSv2,               & 
& AmpTreeSvTocSeSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvTocSeSe(ZcplSecSecSv,MSe,MSv,MSe2,MSv2,              & 
& AmpTreeSvTocSeSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocSeSe(MLambda,em,gs,cplSecSecSv,MSeOS,MSvOS,           & 
& MRPSvTocSeSe,MRGSvTocSeSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocSeSe(MLambda,em,gs,ZcplSecSecSv,MSeOS,MSvOS,          & 
& MRPSvTocSeSe,MRGSvTocSeSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvTocSeSe(MLambda,em,gs,cplSecSecSv,MSe,MSv,               & 
& MRPSvTocSeSe,MRGSvTocSeSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvTocSeSe(MLambda,em,gs,ZcplSecSecSv,MSe,MSv,              & 
& MRPSvTocSeSe,MRGSvTocSeSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTocSeSe(cplSecSecSv,ctcplSecSecSv,MSe,               & 
& MSe2,MSv,MSv2,ZfSe,ZfSv,AmpWaveSvTocSeSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexSvTocSeSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRdrSvTocSeSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,          & 
& cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,         & 
& cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,           & 
& cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,      & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,ZcplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSvTocSeSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,ZcplSecSecSv,cplSecSvcVWm,    & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSvTocSeSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,          & 
& cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,         & 
& cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,           & 
& cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,      & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,    & 
& cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,              & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSvTocSeSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSvTocSeSe)

 End if 
 End if 
AmpVertexSvTocSeSe = AmpVertexSvTocSeSe -  AmpVertexIRdrSvTocSeSe! +  AmpVertexIRosSvTocSeSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvTocSeSe=0._dp 
AmpVertexZSvTocSeSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvTocSeSe(gt2,:,:) = AmpWaveZSvTocSeSe(gt2,:,:)+ZRUZVc(gt2,gt1)*AmpWaveSvTocSeSe(gt1,:,:) 
AmpVertexZSvTocSeSe(gt2,:,:)= AmpVertexZSvTocSeSe(gt2,:,:) + ZRUZVc(gt2,gt1)*AmpVertexSvTocSeSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveSvTocSeSe=AmpWaveZSvTocSeSe 
AmpVertexSvTocSeSe= AmpVertexZSvTocSeSe
! Final State 1 
AmpWaveZSvTocSeSe=0._dp 
AmpVertexZSvTocSeSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSvTocSeSe(:,gt2,:) = AmpWaveZSvTocSeSe(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpWaveSvTocSeSe(:,gt1,:) 
AmpVertexZSvTocSeSe(:,gt2,:)= AmpVertexZSvTocSeSe(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpVertexSvTocSeSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveSvTocSeSe=AmpWaveZSvTocSeSe 
AmpVertexSvTocSeSe= AmpVertexZSvTocSeSe
! Final State 2 
AmpWaveZSvTocSeSe=0._dp 
AmpVertexZSvTocSeSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSvTocSeSe(:,:,gt2) = AmpWaveZSvTocSeSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSvTocSeSe(:,:,gt1) 
AmpVertexZSvTocSeSe(:,:,gt2)= AmpVertexZSvTocSeSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSvTocSeSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveSvTocSeSe=AmpWaveZSvTocSeSe 
AmpVertexSvTocSeSe= AmpVertexZSvTocSeSe
End if
If (ShiftIRdiv) Then 
AmpVertexSvTocSeSe = AmpVertexSvTocSeSe  +  AmpVertexIRosSvTocSeSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->conj[Se] Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvTocSeSe = AmpTreeSvTocSeSe 
 AmpSum2SvTocSeSe = AmpTreeSvTocSeSe + 2._dp*AmpWaveSvTocSeSe + 2._dp*AmpVertexSvTocSeSe  
Else 
 AmpSumSvTocSeSe = AmpTreeSvTocSeSe + AmpWaveSvTocSeSe + AmpVertexSvTocSeSe
 AmpSum2SvTocSeSe = AmpTreeSvTocSeSe + AmpWaveSvTocSeSe + AmpVertexSvTocSeSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTocSeSe = AmpTreeSvTocSeSe
 AmpSum2SvTocSeSe = AmpTreeSvTocSeSe 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSeOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSe(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SvTocSeSe = AmpTreeSvTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSe(gt2),MSe(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvTocSeSe(gt1, gt2, gt3) 
  AmpSum2SvTocSeSe = 2._dp*AmpWaveSvTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSe(gt2),MSe(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvTocSeSe(gt1, gt2, gt3) 
  AmpSum2SvTocSeSe = 2._dp*AmpVertexSvTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSe(gt2),MSe(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvTocSeSe(gt1, gt2, gt3) 
  AmpSum2SvTocSeSe = AmpTreeSvTocSeSe + 2._dp*AmpWaveSvTocSeSe + 2._dp*AmpVertexSvTocSeSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSe(gt2),MSe(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvTocSeSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvTocSeSe = AmpTreeSvTocSeSe
  Call SquareAmp_StoSS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocSeSe(gt1, gt2, gt3) = (1)*AmpSqSvTocSeSe(gt1, gt2, gt3)  
  AmpSum2SvTocSeSe = + 2._dp*AmpWaveSvTocSeSe + 2._dp*AmpVertexSvTocSeSe
  Call SquareAmp_StoSS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
  AmpSqSvTocSeSe(gt1, gt2, gt3) = AmpSqSvTocSeSe(gt1, gt2, gt3) + AmpSqTreeSvTocSeSe(gt1, gt2, gt3)  
Else  
  AmpSum2SvTocSeSe = AmpTreeSvTocSeSe
  Call SquareAmp_StoSS(MSv(gt1),MSe(gt2),MSe(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
  AmpSqTreeSvTocSeSe(gt1, gt2, gt3) = (1)*AmpSqSvTocSeSe(gt1, gt2, gt3)  
  AmpSum2SvTocSeSe = + 2._dp*AmpWaveSvTocSeSe + 2._dp*AmpVertexSvTocSeSe
  Call SquareAmp_StoSS(MSv(gt1),MSe(gt2),MSe(gt3),AmpSumSvTocSeSe(gt1, gt2, gt3),AmpSum2SvTocSeSe(gt1, gt2, gt3),AmpSqSvTocSeSe(gt1, gt2, gt3)) 
  AmpSqSvTocSeSe(gt1, gt2, gt3) = AmpSqSvTocSeSe(gt1, gt2, gt3) + AmpSqTreeSvTocSeSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSvTocSeSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvTocSeSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSeOS(gt2),MSeOS(gt3),helfactor*AmpSqSvTocSeSe(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSe(gt2),MSe(gt3),helfactor*AmpSqSvTocSeSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTocSeSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocSeSe(gt1, gt2, gt3) + MRGSvTocSeSe(gt1, gt2, gt3)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSvTocSeSe(gt1, gt2, gt3) + MRGSvTocSeSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! Se Conjg(VWm)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvToSecVWm(cplSecSvcVWm,MSe,MSv,MVWm,MSe2,             & 
& MSv2,MVWm2,AmpTreeSvToSecVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvToSecVWm(ZcplSecSvcVWm,MSe,MSv,MVWm,MSe2,            & 
& MSv2,MVWm2,AmpTreeSvToSecVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSecVWm(MLambda,em,gs,cplSecSvcVWm,MSeOS,               & 
& MSvOS,MVWmOS,MRPSvToSecVWm,MRGSvToSecVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSecVWm(MLambda,em,gs,ZcplSecSvcVWm,MSeOS,              & 
& MSvOS,MVWmOS,MRPSvToSecVWm,MRGSvToSecVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvToSecVWm(MLambda,em,gs,cplSecSvcVWm,MSe,MSv,             & 
& MVWm,MRPSvToSecVWm,MRGSvToSecVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSecVWm(MLambda,em,gs,ZcplSecSvcVWm,MSe,MSv,            & 
& MVWm,MRPSvToSecVWm,MRGSvToSecVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSecVWm(cplSecSvcVWm,ctcplSecSvcVWm,MSe,            & 
& MSe2,MSv,MSv2,MVWm,MVWm2,ZfSe,ZfSv,ZfVWm,AmpWaveSvToSecVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSecVWm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL,            & 
& cplChiChacVWmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,     & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1,            & 
& cplSvcSvcVWmVWm1,AmpVertexSvToSecVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL,      & 
& cplChiChacVWmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,     & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1,            & 
& cplSvcSvcVWmVWm1,AmpVertexIRdrSvToSecVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL,cplChiChacVWmR,      & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,     & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,cplhhcVWmVWm,               & 
& GosZcplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,          & 
& cplSecSeVP,cplSecSeVZ,GosZcplSecHpmcSv,cplSecSecSv,ZcplSecSvcVWm,cplSvcSvVZ,           & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1,            & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSvToSecVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL,      & 
& cplChiChacVWmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcVWmVWm,GZcplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,          & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,GZcplSecHpmcSv,cplSecSecSv,ZcplSecSvcVWm,             & 
& cplSvcSvVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1, & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSvToSecVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL,cplChiChacVWmR,      & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,     & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,cplhhcVWmVWm,               & 
& GcplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,             & 
& cplSecSeVP,cplSecSeVZ,GcplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,               & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1,            & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSvToSecVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL,      & 
& cplChiChacVWmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,     & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1,            & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSvToSecVWm)

 End if 
 End if 
AmpVertexSvToSecVWm = AmpVertexSvToSecVWm -  AmpVertexIRdrSvToSecVWm! +  AmpVertexIRosSvToSecVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvToSecVWm=0._dp 
AmpVertexZSvToSecVWm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToSecVWm(:,gt2,:) = AmpWaveZSvToSecVWm(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpWaveSvToSecVWm(:,gt1,:) 
AmpVertexZSvToSecVWm(:,gt2,:)= AmpVertexZSvToSecVWm(:,gt2,:) + ZRUZVc(gt2,gt1)*AmpVertexSvToSecVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveSvToSecVWm=AmpWaveZSvToSecVWm 
AmpVertexSvToSecVWm= AmpVertexZSvToSecVWm
! Final State 1 
AmpWaveZSvToSecVWm=0._dp 
AmpVertexZSvToSecVWm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSvToSecVWm(:,:,gt2) = AmpWaveZSvToSecVWm(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSvToSecVWm(:,:,gt1) 
AmpVertexZSvToSecVWm(:,:,gt2)= AmpVertexZSvToSecVWm(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSvToSecVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveSvToSecVWm=AmpWaveZSvToSecVWm 
AmpVertexSvToSecVWm= AmpVertexZSvToSecVWm
End if
If (ShiftIRdiv) Then 
AmpVertexSvToSecVWm = AmpVertexSvToSecVWm  +  AmpVertexIRosSvToSecVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Se conj[VWm] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvToSecVWm = AmpTreeSvToSecVWm 
 AmpSum2SvToSecVWm = AmpTreeSvToSecVWm + 2._dp*AmpWaveSvToSecVWm + 2._dp*AmpVertexSvToSecVWm  
Else 
 AmpSumSvToSecVWm = AmpTreeSvToSecVWm + AmpWaveSvToSecVWm + AmpVertexSvToSecVWm
 AmpSum2SvToSecVWm = AmpTreeSvToSecVWm + AmpWaveSvToSecVWm + AmpVertexSvToSecVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSecVWm = AmpTreeSvToSecVWm
 AmpSum2SvToSecVWm = AmpTreeSvToSecVWm 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSeOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSe(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SvToSecVWm = AmpTreeSvToSecVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSeOS(gt2),MVWmOS,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSe(gt2),MVWm,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvToSecVWm(gt1, gt2) 
  AmpSum2SvToSecVWm = 2._dp*AmpWaveSvToSecVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSeOS(gt2),MVWmOS,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSe(gt2),MVWm,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvToSecVWm(gt1, gt2) 
  AmpSum2SvToSecVWm = 2._dp*AmpVertexSvToSecVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSeOS(gt2),MVWmOS,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSe(gt2),MVWm,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvToSecVWm(gt1, gt2) 
  AmpSum2SvToSecVWm = AmpTreeSvToSecVWm + 2._dp*AmpWaveSvToSecVWm + 2._dp*AmpVertexSvToSecVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSeOS(gt2),MVWmOS,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSe(gt2),MVWm,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvToSecVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvToSecVWm = AmpTreeSvToSecVWm
  Call SquareAmp_StoSV(MSvOS(gt1),MSeOS(gt2),MVWmOS,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
  AmpSqTreeSvToSecVWm(gt1, gt2) = (1)*AmpSqSvToSecVWm(gt1, gt2)  
  AmpSum2SvToSecVWm = + 2._dp*AmpWaveSvToSecVWm + 2._dp*AmpVertexSvToSecVWm
  Call SquareAmp_StoSV(MSvOS(gt1),MSeOS(gt2),MVWmOS,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
  AmpSqSvToSecVWm(gt1, gt2) = AmpSqSvToSecVWm(gt1, gt2) + AmpSqTreeSvToSecVWm(gt1, gt2)  
Else  
  AmpSum2SvToSecVWm = AmpTreeSvToSecVWm
  Call SquareAmp_StoSV(MSv(gt1),MSe(gt2),MVWm,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
  AmpSqTreeSvToSecVWm(gt1, gt2) = (1)*AmpSqSvToSecVWm(gt1, gt2)  
  AmpSum2SvToSecVWm = + 2._dp*AmpWaveSvToSecVWm + 2._dp*AmpVertexSvToSecVWm
  Call SquareAmp_StoSV(MSv(gt1),MSe(gt2),MVWm,AmpSumSvToSecVWm(:,gt1, gt2),AmpSum2SvToSecVWm(:,gt1, gt2),AmpSqSvToSecVWm(gt1, gt2)) 
  AmpSqSvToSecVWm(gt1, gt2) = AmpSqSvToSecVWm(gt1, gt2) + AmpSqTreeSvToSecVWm(gt1, gt2)  
End if  
Else  
  AmpSqSvToSecVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToSecVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSeOS(gt2),MVWmOS,helfactor*AmpSqSvToSecVWm(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSe(gt2),MVWm,helfactor*AmpSqSvToSecVWm(gt1, gt2))
End if 
If ((Abs(MRPSvToSecVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToSecVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvToSecVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToSecVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSvToSecVWm(gt1, gt2) + MRGSvToSecVWm(gt1, gt2)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1*helfactor*(MRPSvToSecVWm(gt1, gt2) + MRGSvToSecVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
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
! Sv VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SvToSvVZ(cplSvcSvVZ,MSv,MVZ,MSv2,MVZ2,AmpTreeSvToSvVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SvToSvVZ(ZcplSvcSvVZ,MSv,MVZ,MSv2,MVZ2,AmpTreeSvToSvVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSvVZ(MLambda,em,gs,cplSvcSvVZ,MSvOS,MVZOS,             & 
& MRPSvToSvVZ,MRGSvToSvVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSvVZ(MLambda,em,gs,ZcplSvcSvVZ,MSvOS,MVZOS,            & 
& MRPSvToSvVZ,MRGSvToSvVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SvToSvVZ(MLambda,em,gs,cplSvcSvVZ,MSv,MVZ,MRPSvToSvVZ,     & 
& MRGSvToSvVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SvToSvVZ(MLambda,em,gs,ZcplSvcSvVZ,MSv,MVZ,MRPSvToSvVZ,    & 
& MRGSvToSvVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvVZ(cplSvcSvVZ,ctcplSvcSvVZ,MSv,MSv2,             & 
& MVZ,MVZ2,ZfSv,ZfVZ,AmpWaveSvToSvVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvVZ(MCha,MChi,MFd,MFe,Mhh,MHpm,MSd,             & 
& MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,MVZ2,           & 
& cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplFvFvVZL,cplFvFvVZR,cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,      & 
& cplSdSvcSd,cplSdcSdVZ,cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,      & 
& cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSvcVWmVZ1,         & 
& cplSvcSeVWmVZ1,cplSvcSvVZVZ1,AmpVertexSvToSvVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ(MCha,MChi,MFd,MFe,Mhh,MHpm,              & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,               & 
& cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,      & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,             & 
& cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,cplSvcSvVZVZ1,AmpVertexIRdrSvToSvVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ(MChaOS,MChiOS,MFdOS,MFeOS,               & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,             & 
& Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,MVZ2OS,cplcFeChaSvL,cplcFeChaSvR,          & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,         & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,      & 
& cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,ZcplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,      & 
& cplSvcSvVZVZ1,AmpVertexIRosSvToSvVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ(MCha,MChi,MFd,MFe,Mhh,MHpm,              & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,               & 
& cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,      & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,ZcplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,            & 
& cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,cplSvcSvVZVZ1,AmpVertexIRosSvToSvVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ(MChaOS,MChiOS,MFdOS,MFeOS,               & 
& MhhOS,MHpmOS,MSdOS,MSeOS,MSvOS,MVWmOS,MVZOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,             & 
& Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,MVZ2OS,cplcFeChaSvL,cplcFeChaSvR,          & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,         & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,      & 
& cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,       & 
& cplSvcSvVZVZ1,AmpVertexIRosSvToSvVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ(MCha,MChi,MFd,MFe,Mhh,MHpm,              & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,               & 
& cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,      & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,             & 
& cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,cplSvcSvVZVZ1,AmpVertexIRosSvToSvVZ)

 End if 
 End if 
AmpVertexSvToSvVZ = AmpVertexSvToSvVZ -  AmpVertexIRdrSvToSvVZ! +  AmpVertexIRosSvToSvVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSvToSvVZ=0._dp 
AmpVertexZSvToSvVZ=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToSvVZ(:,gt2,:) = AmpWaveZSvToSvVZ(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpWaveSvToSvVZ(:,gt1,:) 
AmpVertexZSvToSvVZ(:,gt2,:)= AmpVertexZSvToSvVZ(:,gt2,:) + ZRUZVc(gt2,gt1)*AmpVertexSvToSvVZ(:,gt1,:) 
 End Do 
End Do 
AmpWaveSvToSvVZ=AmpWaveZSvToSvVZ 
AmpVertexSvToSvVZ= AmpVertexZSvToSvVZ
! Final State 1 
AmpWaveZSvToSvVZ=0._dp 
AmpVertexZSvToSvVZ=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSvToSvVZ(:,:,gt2) = AmpWaveZSvToSvVZ(:,:,gt2)+ZRUZV(gt2,gt1)*AmpWaveSvToSvVZ(:,:,gt1) 
AmpVertexZSvToSvVZ(:,:,gt2)= AmpVertexZSvToSvVZ(:,:,gt2)+ZRUZV(gt2,gt1)*AmpVertexSvToSvVZ(:,:,gt1) 
 End Do 
End Do 
AmpWaveSvToSvVZ=AmpWaveZSvToSvVZ 
AmpVertexSvToSvVZ= AmpVertexZSvToSvVZ
End if
If (ShiftIRdiv) Then 
AmpVertexSvToSvVZ = AmpVertexSvToSvVZ  +  AmpVertexIRosSvToSvVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Sv VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSvToSvVZ = AmpTreeSvToSvVZ 
 AmpSum2SvToSvVZ = AmpTreeSvToSvVZ + 2._dp*AmpWaveSvToSvVZ + 2._dp*AmpVertexSvToSvVZ  
Else 
 AmpSumSvToSvVZ = AmpTreeSvToSvVZ + AmpWaveSvToSvVZ + AmpVertexSvToSvVZ
 AmpSum2SvToSvVZ = AmpTreeSvToSvVZ + AmpWaveSvToSvVZ + AmpVertexSvToSvVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSvVZ = AmpTreeSvToSvVZ
 AmpSum2SvToSvVZ = AmpTreeSvToSvVZ 
End if 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSvOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSv(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SvToSvVZ = AmpTreeSvToSvVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),MVZOS,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVZ,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSvToSvVZ(gt1, gt2) 
  AmpSum2SvToSvVZ = 2._dp*AmpWaveSvToSvVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),MVZOS,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVZ,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSvToSvVZ(gt1, gt2) 
  AmpSum2SvToSvVZ = 2._dp*AmpVertexSvToSvVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),MVZOS,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVZ,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSvToSvVZ(gt1, gt2) 
  AmpSum2SvToSvVZ = AmpTreeSvToSvVZ + 2._dp*AmpWaveSvToSvVZ + 2._dp*AmpVertexSvToSvVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),MVZOS,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVZ,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSvToSvVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SvToSvVZ = AmpTreeSvToSvVZ
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),MVZOS,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
  AmpSqTreeSvToSvVZ(gt1, gt2) = (1)*AmpSqSvToSvVZ(gt1, gt2)  
  AmpSum2SvToSvVZ = + 2._dp*AmpWaveSvToSvVZ + 2._dp*AmpVertexSvToSvVZ
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),MVZOS,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
  AmpSqSvToSvVZ(gt1, gt2) = AmpSqSvToSvVZ(gt1, gt2) + AmpSqTreeSvToSvVZ(gt1, gt2)  
Else  
  AmpSum2SvToSvVZ = AmpTreeSvToSvVZ
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVZ,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
  AmpSqTreeSvToSvVZ(gt1, gt2) = (1)*AmpSqSvToSvVZ(gt1, gt2)  
  AmpSum2SvToSvVZ = + 2._dp*AmpWaveSvToSvVZ + 2._dp*AmpVertexSvToSvVZ
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVZ,AmpSumSvToSvVZ(:,gt1, gt2),AmpSum2SvToSvVZ(:,gt1, gt2),AmpSqSvToSvVZ(gt1, gt2)) 
  AmpSqSvToSvVZ(gt1, gt2) = AmpSqSvToSvVZ(gt1, gt2) + AmpSqTreeSvToSvVZ(gt1, gt2)  
End if  
Else  
  AmpSqSvToSvVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToSvVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSvOS(gt2),MVZOS,helfactor*AmpSqSvToSvVZ(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSv(gt2),MVZ,helfactor*AmpSqSvToSvVZ(gt1, gt2))
End if 
If ((Abs(MRPSvToSvVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSvToSvVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSvToSvVZ(gt1, gt2) + MRGSvToSvVZ(gt1, gt2)) 
  gP1LSv(gt1,i4) = gP1LSv(gt1,i4) + phasespacefactor*1*helfactor*(MRPSvToSvVZ(gt1, gt2) + MRGSvToSvVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSv(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
End If 
!---------------- 
! Ah Ah
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhAh(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveSvToAhAh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhAh(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveSvToAhAh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhAh(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,               & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,cplAhAhSdcSdaa,cplAhAhSecSe1,        & 
& cplAhSdcSdcSvaa,cplAhSecSecSv1,AmpVertexSvToAhAh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhAh(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,               & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,cplAhAhSdcSdaa,cplAhAhSecSe1,        & 
& cplAhSdcSdcSvaa,cplAhSecSecSv1,AmpVertexSvToAhAh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhAh(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,AmpWaveSvToAhAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhAh(MAh,MFd,MFe,MSd,MSe,MSv,MAh2,               & 
& MFd2,MFe2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,              & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplSdcSdcSv,cplSecSecSv,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdcSdcSvaa,cplAhSecSecSv1,   & 
& AmpVertexSvToAhAh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Ah Ah -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToAhAh = 0._dp 
 AmpSum2SvToAhAh = 0._dp  
Else 
 AmpSumSvToAhAh = AmpVertexSvToAhAh + AmpWaveSvToAhAh
 AmpSum2SvToAhAh = AmpVertexSvToAhAh + AmpWaveSvToAhAh 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
    Do gt3=gt2,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MAhOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MAh(gt2)+MAh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MAhOS(gt2),MAhOS(gt3),AmpSumSvToAhAh(gt1, gt2, gt3),AmpSum2SvToAhAh(gt1, gt2, gt3),AmpSqSvToAhAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MAh(gt2),MAh(gt3),AmpSumSvToAhAh(gt1, gt2, gt3),AmpSum2SvToAhAh(gt1, gt2, gt3),AmpSqSvToAhAh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToAhAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqSvToAhAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSvOS(gt1),MAhOS(gt2),MAhOS(gt3),helfactor*AmpSqSvToAhAh(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSv(gt1),MAh(gt2),MAh(gt3),helfactor*AmpSqSvToAhAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToAhAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Ah hh
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhhh(MAhOS,MAh2OS,MhhOS,Mhh2OS,MSvOS,              & 
& MSv2OS,ZfAh,Zfhh,ZfSv,AmpWaveSvToAhhh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhhh(MAhOS,MAh2OS,MhhOS,Mhh2OS,MSvOS,              & 
& MSv2OS,ZfAh,Zfhh,ZfSv,AmpWaveSvToAhhh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhhh(MAhOS,MFdOS,MFeOS,MhhOS,MSdOS,              & 
& MSeOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplhhSdcSd,cplhhSecSe,cplSdcSdcSv,cplSecSecSv,cplAhSdcSdcSvaa,cplAhSecSecSv1,          & 
& cplhhSdcSdcSvaa,cplhhSecSecSv1,AmpVertexSvToAhhh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhhh(MAhOS,MFdOS,MFeOS,MhhOS,MSdOS,              & 
& MSeOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplhhSdcSd,cplhhSecSe,cplSdcSdcSv,cplSecSecSv,cplAhSdcSdcSvaa,cplAhSecSecSv1,          & 
& cplhhSdcSdcSvaa,cplhhSecSecSv1,AmpVertexSvToAhhh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhhh(MAh,MAh2,Mhh,Mhh2,MSv,MSv2,ZfAh,              & 
& Zfhh,ZfSv,AmpWaveSvToAhhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhhh(MAh,MFd,MFe,Mhh,MSd,MSe,MSv,MAh2,           & 
& MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdcSv,cplSecSecSv,cplAhSdcSdcSvaa,cplAhSecSecSv1,cplhhSdcSdcSvaa,cplhhSecSecSv1, & 
& AmpVertexSvToAhhh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Ah hh -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToAhhh = 0._dp 
 AmpSum2SvToAhhh = 0._dp  
Else 
 AmpSumSvToAhhh = AmpVertexSvToAhhh + AmpWaveSvToAhhh
 AmpSum2SvToAhhh = AmpVertexSvToAhhh + AmpWaveSvToAhhh 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
    Do gt3=1,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MAhOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MAh(gt2)+Mhh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MAhOS(gt2),MhhOS(gt3),AmpSumSvToAhhh(gt1, gt2, gt3),AmpSum2SvToAhhh(gt1, gt2, gt3),AmpSqSvToAhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MAh(gt2),Mhh(gt3),AmpSumSvToAhhh(gt1, gt2, gt3),AmpSum2SvToAhhh(gt1, gt2, gt3),AmpSqSvToAhhh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToAhhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToAhhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MAhOS(gt2),MhhOS(gt3),helfactor*AmpSqSvToAhhh(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MAh(gt2),Mhh(gt3),helfactor*AmpSqSvToAhhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToAhhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToAhhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Ah Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveSvToAhSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhSv(MAhOS,MAh2OS,MSvOS,MSv2OS,ZfAh,               & 
& ZfSv,AmpWaveSvToAhSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhSv(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
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
& cplSeSvcSecSv1,cplSuSvcSucSvaa,AmpVertexSvToAhSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhSv(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
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
& cplSeSvcSecSv1,cplSuSvcSucSvaa,AmpVertexSvToAhSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,AmpWaveSvToAhSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhSv(MAh,MCha,MChi,MFd,MFe,Mhh,MHpm,             & 
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
& AmpVertexSvToAhSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Ah Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToAhSv = 0._dp 
 AmpSum2SvToAhSv = 0._dp  
Else 
 AmpSumSvToAhSv = AmpVertexSvToAhSv + AmpWaveSvToAhSv
 AmpSum2SvToAhSv = AmpVertexSvToAhSv + AmpWaveSvToAhSv 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
    Do gt3=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MAhOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MAh(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MAhOS(gt2),MSvOS(gt3),AmpSumSvToAhSv(gt1, gt2, gt3),AmpSum2SvToAhSv(gt1, gt2, gt3),AmpSqSvToAhSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MAh(gt2),MSv(gt3),AmpSumSvToAhSv(gt1, gt2, gt3),AmpSum2SvToAhSv(gt1, gt2, gt3),AmpSqSvToAhSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToAhSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToAhSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MAhOS(gt2),MSvOS(gt3),helfactor*AmpSqSvToAhSv(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MAh(gt2),MSv(gt3),helfactor*AmpSqSvToAhSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToAhSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToAhSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Ah VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhVP(MAhOS,MAh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& ZfAh,ZfSv,ZfVP,AmpWaveSvToAhVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhVP(MAhOS,MAh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& ZfAh,ZfSv,ZfVP,AmpWaveSvToAhVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhVP(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdAhL,cplcFdFdAhR,      & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,    & 
& cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,             & 
& cplSdcSdcSv,cplSecSeVP,cplSecSecSv,AmpVertexSvToAhVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhVP(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdAhL,cplcFdFdAhR,      & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,    & 
& cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,             & 
& cplSdcSdcSv,cplSecSeVP,cplSecSecSv,AmpVertexSvToAhVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhVP(MAh,MAh2,MSv,MSv2,MVP,MVP2,ZfAh,              & 
& ZfSv,ZfVP,AmpWaveSvToAhVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhVP(MAh,MFd,MFe,MSd,MSe,MSv,MVP,MAh2,           & 
& MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdcSv,              & 
& cplSecSeVP,cplSecSecSv,AmpVertexSvToAhVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Ah VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToAhVP = 0._dp 
 AmpSum2SvToAhVP = 0._dp  
Else 
 AmpSumSvToAhVP = AmpVertexSvToAhVP + AmpWaveSvToAhVP
 AmpSum2SvToAhVP = AmpVertexSvToAhVP + AmpWaveSvToAhVP 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MAhOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MAh(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MAhOS(gt2),0._dp,AmpSumSvToAhVP(:,gt1, gt2),AmpSum2SvToAhVP(:,gt1, gt2),AmpSqSvToAhVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MAh(gt2),MVP,AmpSumSvToAhVP(:,gt1, gt2),AmpSum2SvToAhVP(:,gt1, gt2),AmpSqSvToAhVP(gt1, gt2)) 
End if  
Else  
  AmpSqSvToAhVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToAhVP(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MAhOS(gt2),0._dp,helfactor*AmpSqSvToAhVP(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MAh(gt2),MVP,helfactor*AmpSqSvToAhVP(gt1, gt2))
End if 
If ((Abs(MRPSvToAhVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToAhVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Ah VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhVZ(MAhOS,MAh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,ZfAh,ZfSv,ZfVZ,AmpWaveSvToAhVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhVZ(MAhOS,MAh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,ZfAh,ZfSv,ZfVZ,AmpWaveSvToAhVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhVZ(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVZL,cplcFdFdVZR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,cplSecSecSv,AmpVertexSvToAhVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhVZ(MAhOS,MFdOS,MFeOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MAh2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdAhL,              & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVZL,cplcFdFdVZR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,cplSecSecSv,AmpVertexSvToAhVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToAhVZ(MAh,MAh2,MSv,MSv2,MVZ,MVZ2,ZfAh,              & 
& ZfSv,ZfVZ,AmpWaveSvToAhVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToAhVZ(MAh,MFd,MFe,MSd,MSe,MSv,MVZ,MAh2,           & 
& MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVZ,cplSdcSdcSv,              & 
& cplSecSeVZ,cplSecSecSv,AmpVertexSvToAhVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Ah VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToAhVZ = 0._dp 
 AmpSum2SvToAhVZ = 0._dp  
Else 
 AmpSumSvToAhVZ = AmpVertexSvToAhVZ + AmpWaveSvToAhVZ
 AmpSum2SvToAhVZ = AmpVertexSvToAhVZ + AmpWaveSvToAhVZ 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MAhOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MAh(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MAhOS(gt2),MVZOS,AmpSumSvToAhVZ(:,gt1, gt2),AmpSum2SvToAhVZ(:,gt1, gt2),AmpSqSvToAhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MAh(gt2),MVZ,AmpSumSvToAhVZ(:,gt1, gt2),AmpSum2SvToAhVZ(:,gt1, gt2),AmpSqSvToAhVZ(gt1, gt2)) 
End if  
Else  
  AmpSqSvToAhVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToAhVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MAhOS(gt2),MVZOS,helfactor*AmpSqSvToAhVZ(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MAh(gt2),MVZ,helfactor*AmpSqSvToAhVZ(gt1, gt2))
End if 
If ((Abs(MRPSvToAhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToAhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Cha bar(Cha)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToChacCha(MChaOS,MCha2OS,MSvOS,MSv2OS,               & 
& ZfLm,ZfLp,ZfSv,AmpWaveSvToChacCha)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToChacCha(MChaOS,MCha2OS,MSvOS,MSv2OS,               & 
& ZfLm,ZfLp,ZfSv,AmpWaveSvToChacCha)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToChacCha(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,       & 
& cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,cplSecSecSv,AmpVertexSvToChacCha)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToChacCha(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,       & 
& cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,cplSecSecSv,AmpVertexSvToChacCha)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToChacCha(MCha,MCha2,MSv,MSv2,ZfLm,ZfLp,             & 
& ZfSv,AmpWaveSvToChacCha)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToChacCha(MCha,MFd,MFe,MFu,MSd,MSe,MSu,            & 
& MSv,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,      & 
& cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,        & 
& cplSecSecSv,AmpVertexSvToChacCha)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Cha bar[Cha] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToChacCha = 0._dp 
 AmpSum2SvToChacCha = 0._dp  
Else 
 AmpSumSvToChacCha = AmpVertexSvToChacCha + AmpWaveSvToChacCha
 AmpSum2SvToChacCha = AmpVertexSvToChacCha + AmpWaveSvToChacCha 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,2
    Do gt3=1,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MChaOS(gt2)+MChaOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MCha(gt2)+MCha(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MChaOS(gt2),MChaOS(gt3),AmpSumSvToChacCha(:,gt1, gt2, gt3),AmpSum2SvToChacCha(:,gt1, gt2, gt3),AmpSqSvToChacCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MCha(gt2),MCha(gt3),AmpSumSvToChacCha(:,gt1, gt2, gt3),AmpSum2SvToChacCha(:,gt1, gt2, gt3),AmpSqSvToChacCha(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToChacCha(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvToChacCha(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MChaOS(gt2),MChaOS(gt3),helfactor*AmpSqSvToChacCha(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MCha(gt2),MCha(gt3),helfactor*AmpSqSvToChacCha(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToChacCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToChacCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Chi Chi
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToChiChi(MChiOS,MChi2OS,MSvOS,MSv2OS,ZfL0,           & 
& ZfSv,AmpWaveSvToChiChi)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToChiChi(MChiOS,MChi2OS,MSvOS,MSv2OS,ZfL0,           & 
& ZfSv,AmpWaveSvToChiChi)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToChiChi(MChiOS,MFdOS,MFeOS,MSdOS,MSeOS,           & 
& MSvOS,MChi2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,           & 
& AmpVertexSvToChiChi)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToChiChi(MChiOS,MFdOS,MFeOS,MSdOS,MSeOS,           & 
& MSvOS,MChi2OS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFecSeL,cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,           & 
& AmpVertexSvToChiChi)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToChiChi(MChi,MChi2,MSv,MSv2,ZfL0,ZfSv,              & 
& AmpWaveSvToChiChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToChiChi(MChi,MFd,MFe,MSd,MSe,MSv,MChi2,           & 
& MFd2,MFe2,MSd2,MSe2,MSv2,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,          & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,AmpVertexSvToChiChi)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Chi Chi -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToChiChi = 0._dp 
 AmpSum2SvToChiChi = 0._dp  
Else 
 AmpSumSvToChiChi = AmpVertexSvToChiChi + AmpWaveSvToChiChi
 AmpSum2SvToChiChi = AmpVertexSvToChiChi + AmpWaveSvToChiChi 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,4
    Do gt3=gt2,4
If (((OSkinematics).and.(MSvOS(gt1).gt.(MChiOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MChi(gt2)+MChi(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MChiOS(gt2),MChiOS(gt3),AmpSumSvToChiChi(:,gt1, gt2, gt3),AmpSum2SvToChiChi(:,gt1, gt2, gt3),AmpSqSvToChiChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MChi(gt2),MChi(gt3),AmpSumSvToChiChi(:,gt1, gt2, gt3),AmpSum2SvToChiChi(:,gt1, gt2, gt3),AmpSqSvToChiChi(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToChiChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqSvToChiChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSvOS(gt1),MChiOS(gt2),MChiOS(gt3),helfactor*AmpSqSvToChiChi(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSv(gt1),MChi(gt2),MChi(gt3),helfactor*AmpSqSvToChiChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToChiChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Fu bar(Fu)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToFucFu(MFuOS,MFu2OS,MSvOS,MSv2OS,ZfFUL,             & 
& ZfFUR,ZfSv,AmpWaveSvToFucFu)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToFucFu(MFuOS,MFu2OS,MSvOS,MSv2OS,ZfFUL,             & 
& ZfFUR,ZfSv,AmpWaveSvToFucFu)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFucFu(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,           & 
& MSdOS,MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSv2OS,MVWm2OS,cplChaFucSdL,cplChaFucSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,          & 
& cplSecSvcVWm,AmpVertexSvToFucFu)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFucFu(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,           & 
& MSdOS,MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,           & 
& MSv2OS,MVWm2OS,cplChaFucSdL,cplChaFucSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,          & 
& cplSecSvcVWm,AmpVertexSvToFucFu)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToFucFu(MFu,MFu2,MSv,MSv2,ZfFUL,ZfFUR,               & 
& ZfSv,AmpWaveSvToFucFu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFucFu(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,             & 
& MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,cplChaFucSdR,    & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,           & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,AmpVertexSvToFucFu)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Fu bar[Fu] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToFucFu = 0._dp 
 AmpSum2SvToFucFu = 0._dp  
Else 
 AmpSumSvToFucFu = AmpVertexSvToFucFu + AmpWaveSvToFucFu
 AmpSum2SvToFucFu = AmpVertexSvToFucFu + AmpWaveSvToFucFu 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MFuOS(gt2)+MFuOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MFu(gt2)+MFu(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MFuOS(gt2),MFuOS(gt3),AmpSumSvToFucFu(:,gt1, gt2, gt3),AmpSum2SvToFucFu(:,gt1, gt2, gt3),AmpSqSvToFucFu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MFu(gt2),MFu(gt3),AmpSumSvToFucFu(:,gt1, gt2, gt3),AmpSum2SvToFucFu(:,gt1, gt2, gt3),AmpSqSvToFucFu(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToFucFu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvToFucFu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MFuOS(gt2),MFuOS(gt3),helfactor*AmpSqSvToFucFu(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MFu(gt2),MFu(gt3),helfactor*AmpSqSvToFucFu(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToFucFu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToFucFu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Fv Fv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToFvFv(MSvOS,MSv2OS,ZfFvL,ZfSv,AmpWaveSvToFvFv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToFvFv(MSvOS,MSv2OS,ZfFvL,ZfSv,AmpWaveSvToFvFv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFvFv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,         & 
& cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& AmpVertexSvToFvFv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFvFv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,         & 
& cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& AmpVertexSvToFvFv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToFvFv(MSv,MSv2,ZfFvL,ZfSv,AmpWaveSvToFvFv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToFvFv(MCha,MFd,MFe,MHpm,MSd,MSe,MSv,              & 
& MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplFvChacSeL,cplFvChacSeR,             & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,AmpVertexSvToFvFv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Fv Fv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToFvFv = 0._dp 
 AmpSum2SvToFvFv = 0._dp  
Else 
 AmpSumSvToFvFv = AmpVertexSvToFvFv + AmpWaveSvToFvFv
 AmpSum2SvToFvFv = AmpVertexSvToFvFv + AmpWaveSvToFvFv 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=gt2,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(0.+0.)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),0._dp,0._dp,AmpSumSvToFvFv(:,gt1, gt2, gt3),AmpSum2SvToFvFv(:,gt1, gt2, gt3),AmpSqSvToFvFv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),0._dp,0._dp,AmpSumSvToFvFv(:,gt1, gt2, gt3),AmpSum2SvToFvFv(:,gt1, gt2, gt3),AmpSqSvToFvFv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToFvFv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqSvToFvFv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSvOS(gt1),0._dp,0._dp,helfactor*AmpSqSvToFvFv(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSv(gt1),0._dp,0._dp,helfactor*AmpSqSvToFvFv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToFvFv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToFvFv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Glu Glu
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToGluGlu(MGluOS,MGlu2OS,MSvOS,MSv2OS,ZffG,           & 
& ZfSv,AmpWaveSvToGluGlu)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToGluGlu(MGluOS,MGlu2OS,MSvOS,MSv2OS,ZffG,           & 
& ZfSv,AmpWaveSvToGluGlu)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToGluGlu(MFdOS,MGluOS,MSdOS,MSvOS,MFd2OS,          & 
& MGlu2OS,MSd2OS,MSv2OS,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplSdcSdcSv,AmpVertexSvToGluGlu)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToGluGlu(MFdOS,MGluOS,MSdOS,MSvOS,MFd2OS,          & 
& MGlu2OS,MSd2OS,MSv2OS,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplSdcSdcSv,AmpVertexSvToGluGlu)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToGluGlu(MGlu,MGlu2,MSv,MSv2,ZffG,ZfSv,              & 
& AmpWaveSvToGluGlu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToGluGlu(MFd,MGlu,MSd,MSv,MFd2,MGlu2,              & 
& MSd2,MSv2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplSdcSdcSv,AmpVertexSvToGluGlu)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Glu Glu -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToGluGlu = 0._dp 
 AmpSum2SvToGluGlu = 0._dp  
Else 
 AmpSumSvToGluGlu = AmpVertexSvToGluGlu + AmpWaveSvToGluGlu
 AmpSum2SvToGluGlu = AmpVertexSvToGluGlu + AmpWaveSvToGluGlu 
End If 
Do gt1=1,3
i4 = isave 
If (((OSkinematics).and.(MSvOS(gt1).gt.(MGluOS+MGluOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MGlu+MGlu)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSvOS(gt1),MGluOS,MGluOS,AmpSumSvToGluGlu(:,gt1),AmpSum2SvToGluGlu(:,gt1),AmpSqSvToGluGlu(gt1)) 
Else  
  Call SquareAmp_StoFF(MSv(gt1),MGlu,MGlu,AmpSumSvToGluGlu(:,gt1),AmpSum2SvToGluGlu(:,gt1),AmpSqSvToGluGlu(gt1)) 
End if  
Else  
  AmpSqSvToGluGlu(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSvToGluGlu(gt1).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSvOS(gt1),MGluOS,MGluOS,helfactor*AmpSqSvToGluGlu(gt1))
Else 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSv(gt1),MGlu,MGlu,helfactor*AmpSqSvToGluGlu(gt1))
End if 
If ((Abs(MRPSvToGluGlu(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSvToGluGlu(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.3) isave = i4 
End do
!---------------- 
! hh hh
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhhh(MhhOS,Mhh2OS,MSvOS,MSv2OS,Zfhh,               & 
& ZfSv,AmpWaveSvTohhhh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhhh(MhhOS,Mhh2OS,MSvOS,MSv2OS,Zfhh,               & 
& ZfSv,AmpWaveSvTohhhh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhhh(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplhhSdcSd,cplhhSecSe,cplSdcSdcSv,cplSecSecSv,cplhhhhSdcSdaa,cplhhhhSecSe1,            & 
& cplhhSdcSdcSvaa,cplhhSecSecSv1,AmpVertexSvTohhhh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhhh(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplhhSdcSd,cplhhSecSe,cplSdcSdcSv,cplSecSecSv,cplhhhhSdcSdaa,cplhhhhSecSe1,            & 
& cplhhSdcSdcSvaa,cplhhSecSecSv1,AmpVertexSvTohhhh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhhh(Mhh,Mhh2,MSv,MSv2,Zfhh,ZfSv,AmpWaveSvTohhhh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhhh(MFd,MFe,Mhh,MSd,MSe,MSv,MFd2,               & 
& MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdcSvL,cplcFdFdcSvR,            & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdcSv,cplSecSecSv,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhSdcSdcSvaa,cplhhSecSecSv1,   & 
& AmpVertexSvTohhhh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->hh hh -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTohhhh = 0._dp 
 AmpSum2SvTohhhh = 0._dp  
Else 
 AmpSumSvTohhhh = AmpVertexSvTohhhh + AmpWaveSvTohhhh
 AmpSum2SvTohhhh = AmpVertexSvTohhhh + AmpWaveSvTohhhh 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,2
    Do gt3=gt2,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MhhOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(Mhh(gt2)+Mhh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MhhOS(gt2),MhhOS(gt3),AmpSumSvTohhhh(gt1, gt2, gt3),AmpSum2SvTohhhh(gt1, gt2, gt3),AmpSqSvTohhhh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),Mhh(gt2),Mhh(gt3),AmpSumSvTohhhh(gt1, gt2, gt3),AmpSum2SvTohhhh(gt1, gt2, gt3),AmpSqSvTohhhh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvTohhhh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqSvTohhhh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSvOS(gt1),MhhOS(gt2),MhhOS(gt3),helfactor*AmpSqSvTohhhh(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1._dp/2._dp*GammaTPS(MSv(gt1),Mhh(gt2),Mhh(gt3),helfactor*AmpSqSvTohhhh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvTohhhh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! hh VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhVP(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& Zfhh,ZfSv,ZfVP,AmpWaveSvTohhVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhVP(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVP,MVP2,           & 
& Zfhh,ZfSv,ZfVP,AmpWaveSvTohhVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhVP(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdhhL,cplcFdFdhhR,      & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdVP,cplSdcSdcSv,cplSecSeVP,cplSecSecSv,AmpVertexSvTohhVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhVP(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVP,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdhhL,cplcFdFdhhR,      & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdVP,cplSdcSdcSv,cplSecSeVP,cplSecSecSv,AmpVertexSvTohhVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhVP(Mhh,Mhh2,MSv,MSv2,MVP,MVP2,Zfhh,              & 
& ZfSv,ZfVP,AmpWaveSvTohhVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhVP(MFd,MFe,Mhh,MSd,MSe,MSv,MVP,MFd2,           & 
& MFe2,Mhh2,MSd2,MSe2,MSv2,MVP2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,cplcFdFdVPR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,cplSdcSdVP,cplSdcSdcSv,cplSecSeVP,     & 
& cplSecSecSv,AmpVertexSvTohhVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->hh VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTohhVP = 0._dp 
 AmpSum2SvTohhVP = 0._dp  
Else 
 AmpSumSvTohhVP = AmpVertexSvTohhVP + AmpWaveSvTohhVP
 AmpSum2SvTohhVP = AmpVertexSvTohhVP + AmpWaveSvTohhVP 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MhhOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(Mhh(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MhhOS(gt2),0._dp,AmpSumSvTohhVP(:,gt1, gt2),AmpSum2SvTohhVP(:,gt1, gt2),AmpSqSvTohhVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),Mhh(gt2),MVP,AmpSumSvTohhVP(:,gt1, gt2),AmpSum2SvTohhVP(:,gt1, gt2),AmpSqSvTohhVP(gt1, gt2)) 
End if  
Else  
  AmpSqSvTohhVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvTohhVP(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MhhOS(gt2),0._dp,helfactor*AmpSqSvTohhVP(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),Mhh(gt2),MVP,helfactor*AmpSqSvTohhVP(gt1, gt2))
End if 
If ((Abs(MRPSvTohhVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvTohhVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! hh VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhVZ(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,Zfhh,ZfSv,ZfVZ,AmpWaveSvTohhVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhVZ(MhhOS,Mhh2OS,MSvOS,MSv2OS,MVZOS,              & 
& MVZ2OS,Zfhh,ZfSv,ZfVZ,AmpWaveSvTohhVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhVZ(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdhhL,              & 
& cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,              & 
& cplhhSecSe,cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,cplSecSecSv,AmpVertexSvTohhVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhVZ(MFdOS,MFeOS,MhhOS,MSdOS,MSeOS,              & 
& MSvOS,MVZOS,MFd2OS,MFe2OS,Mhh2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdhhL,              & 
& cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,              & 
& cplhhSecSe,cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,cplSecSecSv,AmpVertexSvTohhVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvTohhVZ(Mhh,Mhh2,MSv,MSv2,MVZ,MVZ2,Zfhh,              & 
& ZfSv,ZfVZ,AmpWaveSvTohhVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvTohhVZ(MFd,MFe,Mhh,MSd,MSe,MSv,MVZ,MFd2,           & 
& MFe2,Mhh2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,     & 
& cplSecSecSv,AmpVertexSvTohhVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->hh VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvTohhVZ = 0._dp 
 AmpSum2SvTohhVZ = 0._dp  
Else 
 AmpSumSvTohhVZ = AmpVertexSvTohhVZ + AmpWaveSvTohhVZ
 AmpSum2SvTohhVZ = AmpVertexSvTohhVZ + AmpWaveSvTohhVZ 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MhhOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(Mhh(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MhhOS(gt2),MVZOS,AmpSumSvTohhVZ(:,gt1, gt2),AmpSum2SvTohhVZ(:,gt1, gt2),AmpSqSvTohhVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),Mhh(gt2),MVZ,AmpSumSvTohhVZ(:,gt1, gt2),AmpSum2SvTohhVZ(:,gt1, gt2),AmpSqSvTohhVZ(gt1, gt2)) 
End if  
Else  
  AmpSqSvTohhVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvTohhVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MhhOS(gt2),MVZOS,helfactor*AmpSqSvTohhVZ(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),Mhh(gt2),MVZ,helfactor*AmpSqSvTohhVZ(gt1, gt2))
End if 
If ((Abs(MRPSvTohhVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvTohhVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Hpm Conjg(Hpm)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToHpmcHpm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& ZfHpm,ZfSv,AmpWaveSvToHpmcHpm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToHpmcHpm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& ZfHpm,ZfSv,AmpWaveSvToHpmcHpm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToHpmcHpm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa, & 
& AmpVertexSvToHpmcHpm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToHpmcHpm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,             & 
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa, & 
& AmpVertexSvToHpmcHpm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToHpmcHpm(MHpm,MHpm2,MSv,MSv2,ZfHpm,ZfSv,            & 
& AmpWaveSvToHpmcHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToHpmcHpm(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,            & 
& MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,  & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,           & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,               & 
& cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa,AmpVertexSvToHpmcHpm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Hpm conj[Hpm] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToHpmcHpm = 0._dp 
 AmpSum2SvToHpmcHpm = 0._dp  
Else 
 AmpSumSvToHpmcHpm = AmpVertexSvToHpmcHpm + AmpWaveSvToHpmcHpm
 AmpSum2SvToHpmcHpm = AmpVertexSvToHpmcHpm + AmpWaveSvToHpmcHpm 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
    Do gt3=2,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MHpmOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MHpm(gt2)+MHpm(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MHpmOS(gt2),MHpmOS(gt3),AmpSumSvToHpmcHpm(gt1, gt2, gt3),AmpSum2SvToHpmcHpm(gt1, gt2, gt3),AmpSqSvToHpmcHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MHpm(gt2),MHpm(gt3),AmpSumSvToHpmcHpm(gt1, gt2, gt3),AmpSum2SvToHpmcHpm(gt1, gt2, gt3),AmpSqSvToHpmcHpm(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToHpmcHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToHpmcHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MHpmOS(gt2),MHpmOS(gt3),helfactor*AmpSqSvToHpmcHpm(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MHpm(gt2),MHpm(gt3),helfactor*AmpSqSvToHpmcHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToHpmcHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToHpmcHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Hpm Conjg(VWm)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToHpmcVWm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& MVWmOS,MVWm2OS,ZfHpm,ZfSv,ZfVWm,AmpWaveSvToHpmcVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToHpmcVWm(MHpmOS,MHpm2OS,MSvOS,MSv2OS,               & 
& MVWmOS,MVWm2OS,ZfHpm,ZfSv,ZfVWm,AmpWaveSvToHpmcVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToHpmcVWm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,     & 
& cplFvFecVWmR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,         & 
& cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,             & 
& cplSecSvcVWm,AmpVertexSvToHpmcVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToHpmcVWm(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,     & 
& cplFvFecVWmR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,         & 
& cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,             & 
& cplSecSvcVWm,AmpVertexSvToHpmcVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToHpmcVWm(MHpm,MHpm2,MSv,MSv2,MVWm,MVWm2,            & 
& ZfHpm,ZfSv,ZfVWm,AmpWaveSvToHpmcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToHpmcVWm(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,            & 
& MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,cplcFdFdcSvR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,cplSecSvcVWm,AmpVertexSvToHpmcVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Hpm conj[VWm] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToHpmcVWm = 0._dp 
 AmpSum2SvToHpmcVWm = 0._dp  
Else 
 AmpSumSvToHpmcVWm = AmpVertexSvToHpmcVWm + AmpWaveSvToHpmcVWm
 AmpSum2SvToHpmcVWm = AmpVertexSvToHpmcVWm + AmpWaveSvToHpmcVWm 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MSvOS(gt1).gt.(MHpmOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MHpm(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MHpmOS(gt2),MVWmOS,AmpSumSvToHpmcVWm(:,gt1, gt2),AmpSum2SvToHpmcVWm(:,gt1, gt2),AmpSqSvToHpmcVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MHpm(gt2),MVWm,AmpSumSvToHpmcVWm(:,gt1, gt2),AmpSum2SvToHpmcVWm(:,gt1, gt2),AmpSqSvToHpmcVWm(gt1, gt2)) 
End if  
Else  
  AmpSqSvToHpmcVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToHpmcVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MHpmOS(gt2),MVWmOS,helfactor*AmpSqSvToHpmcVWm(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MHpm(gt2),MVWm,helfactor*AmpSqSvToHpmcVWm(gt1, gt2))
End if 
If ((Abs(MRPSvToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToHpmcVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Su Conjg(Su)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToSucSu(MSuOS,MSu2OS,MSvOS,MSv2OS,ZfSu,              & 
& ZfSv,AmpWaveSvToSucSu)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToSucSu(MSuOS,MSu2OS,MSvOS,MSv2OS,ZfSu,              & 
& ZfSv,AmpWaveSvToSucSu)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSucSu(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,           & 
& MSv2OS,MVWm2OS,cplcFdChaSuL,cplcFdChaSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,     & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,          & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,             & 
& cplSucSdVWm,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,     & 
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,cplSeSucSecSuaa,AmpVertexSvToSucSu)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSucSu(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,           & 
& MSv2OS,MVWm2OS,cplcFdChaSuL,cplcFdChaSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,     & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,          & 
& cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,             & 
& cplSucSdVWm,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,     & 
& cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,cplSeSucSecSuaa,AmpVertexSvToSucSu)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSucSu(MSu,MSu2,MSv,MSv2,ZfSu,ZfSv,AmpWaveSvToSucSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSucSu(MCha,MFd,MFe,MHpm,MSd,MSe,MSu,             & 
& MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,cplcFdChaSuR,    & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,   & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,cplSeSucSecSuaa, & 
& AmpVertexSvToSucSu)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Su conj[Su] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSucSu = 0._dp 
 AmpSum2SvToSucSu = 0._dp  
Else 
 AmpSumSvToSucSu = AmpVertexSvToSucSu + AmpWaveSvToSucSu
 AmpSum2SvToSucSu = AmpVertexSvToSucSu + AmpWaveSvToSucSu 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSuOS(gt2)+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSu(gt2)+MSu(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSuOS(gt2),MSuOS(gt3),AmpSumSvToSucSu(gt1, gt2, gt3),AmpSum2SvToSucSu(gt1, gt2, gt3),AmpSqSvToSucSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSu(gt2),MSu(gt3),AmpSumSvToSucSu(gt1, gt2, gt3),AmpSum2SvToSucSu(gt1, gt2, gt3),AmpSqSvToSucSu(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToSucSu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToSucSu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSuOS(gt2),MSuOS(gt3),helfactor*AmpSqSvToSucSu(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSu(gt2),MSu(gt3),helfactor*AmpSqSvToSucSu(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToSucSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToSucSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Sv Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvSv(MSvOS,MSv2OS,ZfSv,AmpWaveSvToSvSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvSv(MSvOS,MSv2OS,ZfSv,AmpWaveSvToSvSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSdSvcSdcSvaa,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexSvToSvSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSdSvcSdcSvaa,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexSvToSvSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvSv(MSv,MSv2,ZfSv,AmpWaveSvToSvSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvSv(MCha,MFd,MFe,MHpm,MSd,MSe,MSv,              & 
& MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplSdSvcSdcSvaa,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexSvToSvSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Sv Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSvSv = 0._dp 
 AmpSum2SvToSvSv = 0._dp  
Else 
 AmpSumSvToSvSv = AmpVertexSvToSvSv + AmpWaveSvToSvSv
 AmpSum2SvToSvSv = AmpVertexSvToSvSv + AmpWaveSvToSvSv 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=gt2,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSvOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSv(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumSvToSvSv(gt1, gt2, gt3),AmpSum2SvToSvSv(gt1, gt2, gt3),AmpSqSvToSvSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),MSv(gt3),AmpSumSvToSvSv(gt1, gt2, gt3),AmpSum2SvToSvSv(gt1, gt2, gt3),AmpSqSvToSvSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToSvSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (gt2.ne.gt3) helfactor = 2._dp*helfactor 
If (AmpSqSvToSvSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSvOS(gt2),MSvOS(gt3),helfactor*AmpSqSvToSvSv(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSv(gt2),MSv(gt3),helfactor*AmpSqSvToSvSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Sv VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvVP(cplSvcSvVZ,ctcplSvcSvVZ,MSvOS,MSv2OS,         & 
& MVP,MVP2,MVZOS,MVZ2OS,ZfSv,ZfVP,ZfVZVP,AmpWaveSvToSvVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvVP(cplSvcSvVZ,ctcplSvcSvVZ,MSvOS,MSv2OS,         & 
& MVP,MVP2,MVZOS,MVZ2OS,ZfSv,ZfVP,ZfVZVP,AmpWaveSvToSvVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvVP(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSvOS,MVP,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,             & 
& MVP2,MVWm2OS,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVP,              & 
& cplSdcSdcSv,cplSeSvcSe,cplSecSeVP,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplSecSvcVWmVP1,cplSvcSeVPVWm1,AmpVertexSvToSvVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvVP(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,            & 
& MSeOS,MSvOS,MVP,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,             & 
& MVP2,MVWm2OS,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVP,              & 
& cplSdcSdcSv,cplSeSvcSe,cplSecSeVP,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplSecSvcVWmVP1,cplSvcSeVPVWm1,AmpVertexSvToSvVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvVP(cplSvcSvVZ,ctcplSvcSvVZ,MSv,MSv2,             & 
& MVP,MVP2,MVZ,MVZ2,ZfSv,ZfVP,ZfVZVP,AmpWaveSvToSvVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvVP(MCha,MFd,MFe,MHpm,MSd,MSe,MSv,              & 
& MVP,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVP2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,    & 
& cplcChaChaVPL,cplcChaChaVPR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplHpmcHpmVP,        & 
& cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVP,cplSdcSdcSv,cplSeSvcSe,cplSecSeVP,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplSecSvcVWmVP1,        & 
& cplSvcSeVPVWm1,AmpVertexSvToSvVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Sv VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSvVP = 0._dp 
 AmpSum2SvToSvVP = 0._dp  
Else 
 AmpSumSvToSvVP = AmpVertexSvToSvVP + AmpWaveSvToSvVP
 AmpSum2SvToSvVP = AmpVertexSvToSvVP + AmpWaveSvToSvVP 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSvOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSv(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSvOS(gt1),MSvOS(gt2),0._dp,AmpSumSvToSvVP(:,gt1, gt2),AmpSum2SvToSvVP(:,gt1, gt2),AmpSqSvToSvVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSv(gt1),MSv(gt2),MVP,AmpSumSvToSvVP(:,gt1, gt2),AmpSum2SvToSvVP(:,gt1, gt2),AmpSqSvToSvVP(gt1, gt2)) 
End if  
Else  
  AmpSqSvToSvVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToSvVP(gt1, gt2).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSvOS(gt2),0._dp,helfactor*AmpSqSvToSvVP(gt1, gt2))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSv(gt2),MVP,helfactor*AmpSqSvToSvVP(gt1, gt2))
End if 
If ((Abs(MRPSvToSvVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! Sv Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvcSv(MSvOS,MSv2OS,ZfSv,AmpWaveSvToSvcSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvcSv(MSvOS,MSv2OS,ZfSv,AmpWaveSvToSvcSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvcSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,           & 
& MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplHpmSvcSecSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,AmpVertexSvToSvcSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvcSv(MChaOS,MFdOS,MFeOS,MHpmOS,MSdOS,           & 
& MSeOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MHpm2OS,MSd2OS,MSe2OS,MSv2OS,MVWm2OS,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplHpmSvcSecSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,AmpVertexSvToSvcSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToSvcSv(MSv,MSv2,ZfSv,AmpWaveSvToSvcSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToSvcSv(MCha,MFd,MFe,MHpm,MSd,MSe,MSv,             & 
& MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplHpmSvcSecSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,AmpVertexSvToSvcSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->Sv conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToSvcSv = 0._dp 
 AmpSum2SvToSvcSv = 0._dp  
Else 
 AmpSumSvToSvcSv = AmpVertexSvToSvcSv + AmpWaveSvToSvcSv
 AmpSum2SvToSvcSv = AmpVertexSvToSvcSv + AmpWaveSvToSvcSv 
End If 
Do gt1=1,3
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSvOS(gt1).gt.(MSvOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MSv(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSvOS(gt1),MSvOS(gt2),MSvOS(gt3),AmpSumSvToSvcSv(gt1, gt2, gt3),AmpSum2SvToSvcSv(gt1, gt2, gt3),AmpSqSvToSvcSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSv(gt1),MSv(gt2),MSv(gt3),AmpSumSvToSvcSv(gt1, gt2, gt3),AmpSum2SvToSvcSv(gt1, gt2, gt3),AmpSqSvToSvcSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSvToSvcSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToSvcSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MSvOS(gt2),MSvOS(gt3),helfactor*AmpSqSvToSvcSv(gt1, gt2, gt3))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MSv(gt2),MSv(gt3),helfactor*AmpSqSvToSvcSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSvToSvcSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSvToSvcSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.3) isave = i4 
End do
!---------------- 
! VG VG
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToVGVG(MSvOS,MSv2OS,MVG,MVG2,ZfSv,ZfVG,              & 
& AmpWaveSvToVGVG)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToVGVG(MSvOS,MSv2OS,MVG,MVG2,ZfSv,ZfVG,              & 
& AmpWaveSvToVGVG)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVGVG(MFdOS,MSdOS,MSvOS,MVG,MFd2OS,               & 
& MSd2OS,MSv2OS,MVG2,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdcSvL,cplcFdFdcSvR,cplSdcSdVG,       & 
& cplSdcSdcSv,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& AmpVertexSvToVGVG)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVGVG(MFdOS,MSdOS,MSvOS,MVG,MFd2OS,               & 
& MSd2OS,MSv2OS,MVG2,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdcSvL,cplcFdFdcSvR,cplSdcSdVG,       & 
& cplSdcSdcSv,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& AmpVertexSvToVGVG)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToVGVG(MSv,MSv2,MVG,MVG2,ZfSv,ZfVG,AmpWaveSvToVGVG)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVGVG(MFd,MSd,MSv,MVG,MFd2,MSd2,MSv2,             & 
& MVG2,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdcSvL,cplcFdFdcSvR,cplSdcSdVG,cplSdcSdcSv,         & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,   & 
& AmpVertexSvToVGVG)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->VG VG -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToVGVG = 0._dp 
 AmpSum2SvToVGVG = 0._dp  
Else 
 AmpSumSvToVGVG = AmpVertexSvToVGVG + AmpWaveSvToVGVG
 AmpSum2SvToVGVG = AmpVertexSvToVGVG + AmpWaveSvToVGVG 
End If 
Do gt1=1,3
i4 = isave 
If (((OSkinematics).and.(MSvOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MVG+MVG)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSvOS(gt1),0._dp,0._dp,AmpSumSvToVGVG(:,gt1),AmpSum2SvToVGVG(:,gt1),AmpSqSvToVGVG(gt1)) 
Else  
  Call SquareAmp_StoVV(MSv(gt1),MVG,MVG,AmpSumSvToVGVG(:,gt1),AmpSum2SvToVGVG(:,gt1),AmpSqSvToVGVG(gt1)) 
End if  
Else  
  AmpSqSvToVGVG(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToVGVG(gt1).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),0._dp,0._dp,helfactor*AmpSqSvToVGVG(gt1))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MVG,MVG,helfactor*AmpSqSvToVGVG(gt1))
End if 
If ((Abs(MRPSvToVGVG(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSvToVGVG(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.3) isave = i4 
End do
!---------------- 
! VP VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToVPVP(MSvOS,MSv2OS,MVP,MVP2,ZfSv,ZfVP,              & 
& AmpWaveSvToVPVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToVPVP(MSvOS,MSv2OS,MVP,MVP2,ZfSv,ZfVP,              & 
& AmpWaveSvToVPVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVPVP(MFdOS,MFeOS,MSdOS,MSeOS,MSvOS,              & 
& MVP,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,      & 
& cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,             & 
& cplSdcSdcSv,cplSecSeVP,cplSecSecSv,cplSdcSdVPVPaa,cplSecSeVPVP1,AmpVertexSvToVPVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVPVP(MFdOS,MFeOS,MSdOS,MSeOS,MSvOS,              & 
& MVP,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,      & 
& cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,             & 
& cplSdcSdcSv,cplSecSeVP,cplSecSecSv,cplSdcSdVPVPaa,cplSecSeVPVP1,AmpVertexSvToVPVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToVPVP(MSv,MSv2,MVP,MVP2,ZfSv,ZfVP,AmpWaveSvToVPVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVPVP(MFd,MFe,MSd,MSe,MSv,MVP,MFd2,               & 
& MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,            & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdcSv,              & 
& cplSecSeVP,cplSecSecSv,cplSdcSdVPVPaa,cplSecSeVPVP1,AmpVertexSvToVPVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->VP VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToVPVP = 0._dp 
 AmpSum2SvToVPVP = 0._dp  
Else 
 AmpSumSvToVPVP = AmpVertexSvToVPVP + AmpWaveSvToVPVP
 AmpSum2SvToVPVP = AmpVertexSvToVPVP + AmpWaveSvToVPVP 
End If 
Do gt1=1,3
i4 = isave 
If (((OSkinematics).and.(MSvOS(gt1).gt.(0.+0.))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MVP+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSvOS(gt1),0._dp,0._dp,AmpSumSvToVPVP(:,gt1),AmpSum2SvToVPVP(:,gt1),AmpSqSvToVPVP(gt1)) 
Else  
  Call SquareAmp_StoVV(MSv(gt1),MVP,MVP,AmpSumSvToVPVP(:,gt1),AmpSum2SvToVPVP(:,gt1),AmpSqSvToVPVP(gt1)) 
End if  
Else  
  AmpSqSvToVPVP(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToVPVP(gt1).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),0._dp,0._dp,helfactor*AmpSqSvToVPVP(gt1))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MVP,MVP,helfactor*AmpSqSvToVPVP(gt1))
End if 
If ((Abs(MRPSvToVPVP(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSvToVPVP(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.3) isave = i4 
End do
!---------------- 
! VP VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToVPVZ(MSvOS,MSv2OS,MVP,MVP2,MVZOS,MVZ2OS,           & 
& ZfSv,ZfVP,ZfVZ,AmpWaveSvToVPVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToVPVZ(MSvOS,MSv2OS,MVP,MVP2,MVZOS,MVZ2OS,           & 
& ZfSv,ZfVP,ZfVZ,AmpWaveSvToVPVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVPVZ(MFdOS,MFeOS,MSdOS,MSeOS,MSvOS,              & 
& MVP,MVZOS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,MVZ2OS,cplcFdFdVPL,cplcFdFdVPR,      & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdVZ,               & 
& cplSdcSdcSv,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSdcSdVPVZaa,cplSecSeVPVZ1,            & 
& AmpVertexSvToVPVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVPVZ(MFdOS,MFeOS,MSdOS,MSeOS,MSvOS,              & 
& MVP,MVZOS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVP2,MVZ2OS,cplcFdFdVPL,cplcFdFdVPR,      & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdVZ,               & 
& cplSdcSdcSv,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSdcSdVPVZaa,cplSecSeVPVZ1,            & 
& AmpVertexSvToVPVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToVPVZ(MSv,MSv2,MVP,MVP2,MVZ,MVZ2,ZfSv,              & 
& ZfVP,ZfVZ,AmpWaveSvToVPVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVPVZ(MFd,MFe,MSd,MSe,MSv,MVP,MVZ,MFd2,           & 
& MFe2,MSd2,MSe2,MSv2,MVP2,MVZ2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSecSeVP,cplSecSeVZ,     & 
& cplSecSecSv,cplSdcSdVPVZaa,cplSecSeVPVZ1,AmpVertexSvToVPVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->VP VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToVPVZ = 0._dp 
 AmpSum2SvToVPVZ = 0._dp  
Else 
 AmpSumSvToVPVZ = AmpVertexSvToVPVZ + AmpWaveSvToVPVZ
 AmpSum2SvToVPVZ = AmpVertexSvToVPVZ + AmpWaveSvToVPVZ 
End If 
Do gt1=1,3
i4 = isave 
If (((OSkinematics).and.(MSvOS(gt1).gt.(0.+MVZOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MVP+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSvOS(gt1),0._dp,MVZOS,AmpSumSvToVPVZ(:,gt1),AmpSum2SvToVPVZ(:,gt1),AmpSqSvToVPVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(MSv(gt1),MVP,MVZ,AmpSumSvToVPVZ(:,gt1),AmpSum2SvToVPVZ(:,gt1),AmpSqSvToVPVZ(gt1)) 
End if  
Else  
  AmpSqSvToVPVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToVPVZ(gt1).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 2*GammaTPS(MSvOS(gt1),0._dp,MVZOS,helfactor*AmpSqSvToVPVZ(gt1))
Else 
  gP1LSv(gt1,i4) = 2*GammaTPS(MSv(gt1),MVP,MVZ,helfactor*AmpSqSvToVPVZ(gt1))
End if 
If ((Abs(MRPSvToVPVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSvToVPVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.3) isave = i4 
End do
!---------------- 
! VWm Conjg(VWm)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToVWmcVWm(MSvOS,MSv2OS,MVWmOS,MVWm2OS,               & 
& ZfSv,ZfVWm,AmpWaveSvToVWmcVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToVWmcVWm(MSvOS,MSv2OS,MVWmOS,MVWm2OS,               & 
& ZfSv,ZfVWm,AmpWaveSvToVWmcVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVWmcVWm(MFdOS,MFeOS,MFuOS,MSdOS,MSeOS,           & 
& MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,             & 
& cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,AmpVertexSvToVWmcVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVWmcVWm(MFdOS,MFeOS,MFuOS,MSdOS,MSeOS,           & 
& MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,             & 
& cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,AmpVertexSvToVWmcVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToVWmcVWm(MSv,MSv2,MVWm,MVWm2,ZfSv,ZfVWm,            & 
& AmpWaveSvToVWmcVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVWmcVWm(MFd,MFe,MFu,MSd,MSe,MSu,MSv,             & 
& MVWm,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSdcSucVWm,          & 
& cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,   & 
& AmpVertexSvToVWmcVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->VWm conj[VWm] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToVWmcVWm = 0._dp 
 AmpSum2SvToVWmcVWm = 0._dp  
Else 
 AmpSumSvToVWmcVWm = AmpVertexSvToVWmcVWm + AmpWaveSvToVWmcVWm
 AmpSum2SvToVWmcVWm = AmpVertexSvToVWmcVWm + AmpWaveSvToVWmcVWm 
End If 
Do gt1=1,3
i4 = isave 
If (((OSkinematics).and.(MSvOS(gt1).gt.(MVWmOS+MVWmOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MVWm+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSvOS(gt1),MVWmOS,MVWmOS,AmpSumSvToVWmcVWm(:,gt1),AmpSum2SvToVWmcVWm(:,gt1),AmpSqSvToVWmcVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MSv(gt1),MVWm,MVWm,AmpSumSvToVWmcVWm(:,gt1),AmpSum2SvToVWmcVWm(:,gt1),AmpSqSvToVWmcVWm(gt1)) 
End if  
Else  
  AmpSqSvToVWmcVWm(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToVWmcVWm(gt1).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 2*GammaTPS(MSvOS(gt1),MVWmOS,MVWmOS,helfactor*AmpSqSvToVWmcVWm(gt1))
Else 
  gP1LSv(gt1,i4) = 2*GammaTPS(MSv(gt1),MVWm,MVWm,helfactor*AmpSqSvToVWmcVWm(gt1))
End if 
If ((Abs(MRPSvToVWmcVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSvToVWmcVWm(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.3) isave = i4 
End do
!---------------- 
! VZ VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SvToVZVZ(MSvOS,MSv2OS,MVZOS,MVZ2OS,ZfSv,               & 
& ZfVZ,AmpWaveSvToVZVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SvToVZVZ(MSvOS,MSv2OS,MVZOS,MVZ2OS,ZfSv,               & 
& ZfVZ,AmpWaveSvToVZVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVZVZ(MFdOS,MFeOS,MSdOS,MSeOS,MSvOS,              & 
& MVZOS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,cplSecSecSv,cplSdcSdVZVZaa,cplSecSeVZVZ1,            & 
& AmpVertexSvToVZVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVZVZ(MFdOS,MFeOS,MSdOS,MSeOS,MSvOS,              & 
& MVZOS,MFd2OS,MFe2OS,MSd2OS,MSe2OS,MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,           & 
& cplSdcSdVZ,cplSdcSdcSv,cplSecSeVZ,cplSecSecSv,cplSdcSdVZVZaa,cplSecSeVZVZ1,            & 
& AmpVertexSvToVZVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SvToVZVZ(MSv,MSv2,MVZ,MVZ2,ZfSv,ZfVZ,AmpWaveSvToVZVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SvToVZVZ(MFd,MFe,MSd,MSe,MSv,MVZ,MFd2,               & 
& MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,            & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVZ,cplSdcSdcSv,              & 
& cplSecSeVZ,cplSecSecSv,cplSdcSdVZVZaa,cplSecSeVZVZ1,AmpVertexSvToVZVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Sv->VZ VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSvToVZVZ = 0._dp 
 AmpSum2SvToVZVZ = 0._dp  
Else 
 AmpSumSvToVZVZ = AmpVertexSvToVZVZ + AmpWaveSvToVZVZ
 AmpSum2SvToVZVZ = AmpVertexSvToVZVZ + AmpWaveSvToVZVZ 
End If 
Do gt1=1,3
i4 = isave 
If (((OSkinematics).and.(MSvOS(gt1).gt.(MVZOS+MVZOS))).or.((.not.OSkinematics).and.(MSv(gt1).gt.(MVZ+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSvOS(gt1),MVZOS,MVZOS,AmpSumSvToVZVZ(:,gt1),AmpSum2SvToVZVZ(:,gt1),AmpSqSvToVZVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(MSv(gt1),MVZ,MVZ,AmpSumSvToVZVZ(:,gt1),AmpSum2SvToVZVZ(:,gt1),AmpSqSvToVZVZ(gt1)) 
End if  
Else  
  AmpSqSvToVZVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSvToVZVZ(gt1).eq.0._dp) Then 
  gP1LSv(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSvOS(gt1),MVZOS,MVZOS,helfactor*AmpSqSvToVZVZ(gt1))
Else 
  gP1LSv(gt1,i4) = 1*GammaTPS(MSv(gt1),MVZ,MVZ,helfactor*AmpSqSvToVZVZ(gt1))
End if 
If ((Abs(MRPSvToVZVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSvToVZVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSv(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.3) isave = i4 
End do
End Subroutine OneLoopDecay_Sv

End Module Wrapper_OneLoopDecay_Sv_MSSMTriLnV
