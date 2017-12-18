! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:00 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Se_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Se_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Se(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,              & 
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
& ZfVPVZ,ZfVZVP,cplAhAhhh,cplAhAhSecSe1,cplAhcHpmVWm,cplAhhhVZ,cplAhHpmcHpm,             & 
& cplAhHpmcVWm,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSd,cplAhSdcSecSuaa,cplAhSecHpmcSv1,& 
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
& cplcFuGluSuR,cplChaFucSdL,cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplcHpmVPVWm,           & 
& cplcHpmVWmVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,           & 
& cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,              & 
& cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,cplhhcHpmVWm,cplhhcVWmVWm,cplhhhhhh,            & 
& cplhhhhSecSe1,cplhhHpmcHpm,cplhhHpmcVWm,cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcSd,     & 
& cplhhSdcSecSuaa,cplhhSecHpmcSv1,cplhhSecSe,cplhhSecSecSv1,cplhhSeSucSdaa,              & 
& cplhhSeSvcSe1,cplhhSucSu,cplhhSvcSv,cplhhVZVZ,cplHpmcHpmVP,cplHpmcHpmVZ,               & 
& cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmSdcSdcSeaa,cplHpmSecHpmcSe1,cplHpmSecSecSe1,           & 
& cplHpmSucSd,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,        & 
& cplHpmSvcSe,cplHpmSvcSecSv1,cplSdcHpmcSu,cplSdcHpmcSucSvaa,cplSdcSdcSv,cplSdcSdVG,     & 
& cplSdcSdVP,cplSdcSdVZ,cplSdcSecSu,cplSdcSucVWm,cplSdSecSdcSeaa,cplSdSucSdcSuabab,      & 
& cplSdSucSdcSuabba,cplSdSvcSd,cplSdSvcSecSuaa,cplSecHpmcSv,cplSecSecSv,cplSecSecVWmVWm1,& 
& cplSecSeVP,cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSeVZ,cplSecSeVZVZ1,cplSecSvcVWm,          & 
& cplSecSvcVWmVP1,cplSecSvcVWmVZ1,cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSucSd,             & 
& cplSeSucSdcSvaa,cplSeSucSecSuaa,cplSeSvcHpmcSv1,cplSeSvcSe,cplSeSvcSecSv1,             & 
& cplSucSdVPVWmaa,cplSucSdVWm,cplSucSdVWmVZaa,cplSucSuVG,cplSucSuVP,cplSucSuVZ,          & 
& cplSvcSeVPVWm1,cplSvcSeVWm,cplSvcSeVWmVZ1,cplSvcSvcVWmVWm1,cplSvcSvVZ,ctcplAhSecSe,    & 
& ctcplcFuFdcSeL,ctcplcFuFdcSeR,ctcplChiFecSeL,ctcplChiFecSeR,ctcplFvChacSeL,            & 
& ctcplFvChacSeR,ctcplFvFecSeL,ctcplFvFecSeR,ctcplhhSecSe,ctcplHpmSvcSe,ctcplSdcSecSu,   & 
& ctcplSecSecSv,ctcplSecSeVP,ctcplSecSeVZ,ctcplSeSvcSe,ctcplSvcSeVWm,GcplcHpmVPVWm,      & 
& GcplHpmcVWmVP,GcplHpmSvcSe,GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,GosZcplHpmSvcSe,          & 
& GZcplcHpmVPVWm,GZcplHpmcVWmVP,GZcplHpmSvcSe,ZcplAhSecSe,ZcplcFuFdcSeL,ZcplcFuFdcSeR,   & 
& ZcplChiFecSeL,ZcplChiFecSeR,ZcplFvChacSeL,ZcplFvChacSeR,ZcplFvFecSeL,ZcplFvFecSeR,     & 
& ZcplhhSecSe,ZcplHpmSvcSe,ZcplSdcSecSu,ZcplSecSecSv,ZcplSecSeVZ,ZcplSeSvcSe,            & 
& ZcplSvcSeVWm,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,ZRUZP,ZRUZN,ZRUUM,ZRUUP,              & 
& ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,em,gs,deltaM,kont,gP1LSe)

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

Complex(dp),Intent(in) :: cplAhAhhh(2,2,2),cplAhAhSecSe1(2,2,6,6),cplAhcHpmVWm(2,2),cplAhhhVZ(2,2),             & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),& 
& cplAhSdcSd(2,6,6),cplAhSdcSecSuaa(2,6,6,6),cplAhSecHpmcSv1(2,6,2,3),cplAhSecSe(2,6,6), & 
& cplAhSecSecSv1(2,6,6,3),cplAhSeSucSdaa(2,6,6,6),cplAhSeSvcSe1(2,6,3,6),cplAhSucSu(2,6,6),& 
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
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),           & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),               & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6), & 
& cplcFuGluSuR(3,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),       & 
& cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),     & 
& cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4),         & 
& cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),         & 
& cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),       & 
& cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcHpmVPVWm(2),             & 
& cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),       & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6)

Complex(dp),Intent(in) :: cplGluFdcSdR(3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhhhhh(2,2,2),cplhhhhSecSe1(2,2,6,6),cplhhHpmcHpm(2,2,2),           & 
& cplhhHpmcVWm(2,2),cplhhHpmSucSdaa(2,2,6,6),cplhhHpmSvcSe1(2,2,3,6),cplhhSdcSd(2,6,6),  & 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSe(2,6,6),cplhhSecSecSv1(2,6,6,3),& 
& cplhhSeSucSdaa(2,6,6,6),cplhhSeSvcSe1(2,6,3,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),    & 
& cplhhVZVZ(2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),      & 
& cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSecHpmcSe1(2,6,2,6),cplHpmSecSecSe1(2,6,6,6),          & 
& cplHpmSucSd(2,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplHpmSucSecSuaa(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),& 
& cplHpmSvcHpmcSv1(2,3,2,3),cplHpmSvcSe(2,3,6),cplHpmSvcSecSv1(2,3,6,3),cplSdcHpmcSu(6,2,6),& 
& cplSdcHpmcSucSvaa(6,2,6,3),cplSdcSdcSv(6,6,3),cplSdcSdVG(6,6),cplSdcSdVP(6,6),         & 
& cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSdSecSdcSeaa(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),cplSdSvcSd(6,3,6),               & 
& cplSdSvcSecSuaa(6,3,6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSecVWmVWm1(6,6), & 
& cplSecSeVP(6,6),cplSecSeVPVP1(6,6),cplSecSeVPVZ1(6,6),cplSecSeVZ(6,6),cplSecSeVZVZ1(6,6),& 
& cplSecSvcVWm(6,3),cplSecSvcVWmVP1(6,3),cplSecSvcVWmVZ1(6,3),cplSeSecHpmcSe1(6,6,2,6),  & 
& cplSeSecSecSe1(6,6,6,6),cplSeSucSd(6,6,6),cplSeSucSdcSvaa(6,6,6,3),cplSeSucSecSuaa(6,6,6,6),& 
& cplSeSvcHpmcSv1(6,3,2,3),cplSeSvcSe(6,3,6),cplSeSvcSecSv1(6,3,6,3),cplSucSdVPVWmaa(6,6),& 
& cplSucSdVWm(6,6),cplSucSdVWmVZaa(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6), & 
& cplSvcSeVPVWm1(3,6),cplSvcSeVWm(3,6),cplSvcSeVWmVZ1(3,6),cplSvcSvcVWmVWm1(3,3),        & 
& cplSvcSvVZ(3,3),ctcplAhSecSe(2,6,6),ctcplcFuFdcSeL(3,3,6),ctcplcFuFdcSeR(3,3,6),       & 
& ctcplChiFecSeL(4,3,6),ctcplChiFecSeR(4,3,6),ctcplFvChacSeL(3,2,6),ctcplFvChacSeR(3,2,6),& 
& ctcplFvFecSeL(3,3,6),ctcplFvFecSeR(3,3,6),ctcplhhSecSe(2,6,6),ctcplHpmSvcSe(2,3,6),    & 
& ctcplSdcSecSu(6,6,6),ctcplSecSecSv(6,6,3),ctcplSecSeVP(6,6),ctcplSecSeVZ(6,6),         & 
& ctcplSeSvcSe(6,3,6),ctcplSvcSeVWm(3,6),GcplcHpmVPVWm(2),GcplHpmcVWmVP(2),              & 
& GcplHpmSvcSe(2,3,6),GosZcplcHpmVPVWm(2),GosZcplHpmcVWmVP(2),GosZcplHpmSvcSe(2,3,6),    & 
& GZcplcHpmVPVWm(2),GZcplHpmcVWmVP(2),GZcplHpmSvcSe(2,3,6),ZcplAhSecSe(2,6,6),           & 
& ZcplcFuFdcSeL(3,3,6),ZcplcFuFdcSeR(3,3,6),ZcplChiFecSeL(4,3,6),ZcplChiFecSeR(4,3,6),   & 
& ZcplFvChacSeL(3,2,6),ZcplFvChacSeR(3,2,6),ZcplFvFecSeL(3,3,6),ZcplFvFecSeR(3,3,6),     & 
& ZcplhhSecSe(2,6,6),ZcplHpmSvcSe(2,3,6),ZcplSdcSecSu(6,6,6),ZcplSecSecSv(6,6,3),        & 
& ZcplSecSeVZ(6,6),ZcplSeSvcSe(6,3,6),ZcplSvcSeVWm(3,6)

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
Real(dp), Intent(out) :: gP1LSe(6,168) 
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
Real(dp) :: MRPSeToSeAh(6,6,2),MRGSeToSeAh(6,6,2), MRPZSeToSeAh(6,6,2),MRGZSeToSeAh(6,6,2) 
Real(dp) :: MVPSeToSeAh(6,6,2) 
Real(dp) :: RMsqTreeSeToSeAh(6,6,2),RMsqWaveSeToSeAh(6,6,2),RMsqVertexSeToSeAh(6,6,2) 
Complex(dp) :: AmpTreeSeToSeAh(6,6,2),AmpWaveSeToSeAh(6,6,2),AmpVertexSeToSeAh(6,6,2)& 
 & ,AmpVertexIRosSeToSeAh(6,6,2),AmpVertexIRdrSeToSeAh(6,6,2), AmpSumSeToSeAh(6,6,2), AmpSum2SeToSeAh(6,6,2) 
Complex(dp) :: AmpTreeZSeToSeAh(6,6,2),AmpWaveZSeToSeAh(6,6,2),AmpVertexZSeToSeAh(6,6,2) 
Real(dp) :: AmpSqSeToSeAh(6,6,2),  AmpSqTreeSeToSeAh(6,6,2) 
Real(dp) :: MRPSeToFvCha(6,3,2),MRGSeToFvCha(6,3,2), MRPZSeToFvCha(6,3,2),MRGZSeToFvCha(6,3,2) 
Real(dp) :: MVPSeToFvCha(6,3,2) 
Real(dp) :: RMsqTreeSeToFvCha(6,3,2),RMsqWaveSeToFvCha(6,3,2),RMsqVertexSeToFvCha(6,3,2) 
Complex(dp) :: AmpTreeSeToFvCha(2,6,3,2),AmpWaveSeToFvCha(2,6,3,2),AmpVertexSeToFvCha(2,6,3,2)& 
 & ,AmpVertexIRosSeToFvCha(2,6,3,2),AmpVertexIRdrSeToFvCha(2,6,3,2), AmpSumSeToFvCha(2,6,3,2), AmpSum2SeToFvCha(2,6,3,2) 
Complex(dp) :: AmpTreeZSeToFvCha(2,6,3,2),AmpWaveZSeToFvCha(2,6,3,2),AmpVertexZSeToFvCha(2,6,3,2) 
Real(dp) :: AmpSqSeToFvCha(6,3,2),  AmpSqTreeSeToFvCha(6,3,2) 
Real(dp) :: MRPSeToFeChi(6,3,4),MRGSeToFeChi(6,3,4), MRPZSeToFeChi(6,3,4),MRGZSeToFeChi(6,3,4) 
Real(dp) :: MVPSeToFeChi(6,3,4) 
Real(dp) :: RMsqTreeSeToFeChi(6,3,4),RMsqWaveSeToFeChi(6,3,4),RMsqVertexSeToFeChi(6,3,4) 
Complex(dp) :: AmpTreeSeToFeChi(2,6,3,4),AmpWaveSeToFeChi(2,6,3,4),AmpVertexSeToFeChi(2,6,3,4)& 
 & ,AmpVertexIRosSeToFeChi(2,6,3,4),AmpVertexIRdrSeToFeChi(2,6,3,4), AmpSumSeToFeChi(2,6,3,4), AmpSum2SeToFeChi(2,6,3,4) 
Complex(dp) :: AmpTreeZSeToFeChi(2,6,3,4),AmpWaveZSeToFeChi(2,6,3,4),AmpVertexZSeToFeChi(2,6,3,4) 
Real(dp) :: AmpSqSeToFeChi(6,3,4),  AmpSqTreeSeToFeChi(6,3,4) 
Real(dp) :: MRPSeTocFuFd(6,3,3),MRGSeTocFuFd(6,3,3), MRPZSeTocFuFd(6,3,3),MRGZSeTocFuFd(6,3,3) 
Real(dp) :: MVPSeTocFuFd(6,3,3) 
Real(dp) :: RMsqTreeSeTocFuFd(6,3,3),RMsqWaveSeTocFuFd(6,3,3),RMsqVertexSeTocFuFd(6,3,3) 
Complex(dp) :: AmpTreeSeTocFuFd(2,6,3,3),AmpWaveSeTocFuFd(2,6,3,3),AmpVertexSeTocFuFd(2,6,3,3)& 
 & ,AmpVertexIRosSeTocFuFd(2,6,3,3),AmpVertexIRdrSeTocFuFd(2,6,3,3), AmpSumSeTocFuFd(2,6,3,3), AmpSum2SeTocFuFd(2,6,3,3) 
Complex(dp) :: AmpTreeZSeTocFuFd(2,6,3,3),AmpWaveZSeTocFuFd(2,6,3,3),AmpVertexZSeTocFuFd(2,6,3,3) 
Real(dp) :: AmpSqSeTocFuFd(6,3,3),  AmpSqTreeSeTocFuFd(6,3,3) 
Real(dp) :: MRPSeToFvFe(6,3,3),MRGSeToFvFe(6,3,3), MRPZSeToFvFe(6,3,3),MRGZSeToFvFe(6,3,3) 
Real(dp) :: MVPSeToFvFe(6,3,3) 
Real(dp) :: RMsqTreeSeToFvFe(6,3,3),RMsqWaveSeToFvFe(6,3,3),RMsqVertexSeToFvFe(6,3,3) 
Complex(dp) :: AmpTreeSeToFvFe(2,6,3,3),AmpWaveSeToFvFe(2,6,3,3),AmpVertexSeToFvFe(2,6,3,3)& 
 & ,AmpVertexIRosSeToFvFe(2,6,3,3),AmpVertexIRdrSeToFvFe(2,6,3,3), AmpSumSeToFvFe(2,6,3,3), AmpSum2SeToFvFe(2,6,3,3) 
Complex(dp) :: AmpTreeZSeToFvFe(2,6,3,3),AmpWaveZSeToFvFe(2,6,3,3),AmpVertexZSeToFvFe(2,6,3,3) 
Real(dp) :: AmpSqSeToFvFe(6,3,3),  AmpSqTreeSeToFvFe(6,3,3) 
Real(dp) :: MRPSeToSehh(6,6,2),MRGSeToSehh(6,6,2), MRPZSeToSehh(6,6,2),MRGZSeToSehh(6,6,2) 
Real(dp) :: MVPSeToSehh(6,6,2) 
Real(dp) :: RMsqTreeSeToSehh(6,6,2),RMsqWaveSeToSehh(6,6,2),RMsqVertexSeToSehh(6,6,2) 
Complex(dp) :: AmpTreeSeToSehh(6,6,2),AmpWaveSeToSehh(6,6,2),AmpVertexSeToSehh(6,6,2)& 
 & ,AmpVertexIRosSeToSehh(6,6,2),AmpVertexIRdrSeToSehh(6,6,2), AmpSumSeToSehh(6,6,2), AmpSum2SeToSehh(6,6,2) 
Complex(dp) :: AmpTreeZSeToSehh(6,6,2),AmpWaveZSeToSehh(6,6,2),AmpVertexZSeToSehh(6,6,2) 
Real(dp) :: AmpSqSeToSehh(6,6,2),  AmpSqTreeSeToSehh(6,6,2) 
Real(dp) :: MRPSeToSvHpm(6,3,2),MRGSeToSvHpm(6,3,2), MRPZSeToSvHpm(6,3,2),MRGZSeToSvHpm(6,3,2) 
Real(dp) :: MVPSeToSvHpm(6,3,2) 
Real(dp) :: RMsqTreeSeToSvHpm(6,3,2),RMsqWaveSeToSvHpm(6,3,2),RMsqVertexSeToSvHpm(6,3,2) 
Complex(dp) :: AmpTreeSeToSvHpm(6,3,2),AmpWaveSeToSvHpm(6,3,2),AmpVertexSeToSvHpm(6,3,2)& 
 & ,AmpVertexIRosSeToSvHpm(6,3,2),AmpVertexIRdrSeToSvHpm(6,3,2), AmpSumSeToSvHpm(6,3,2), AmpSum2SeToSvHpm(6,3,2) 
Complex(dp) :: AmpTreeZSeToSvHpm(6,3,2),AmpWaveZSeToSvHpm(6,3,2),AmpVertexZSeToSvHpm(6,3,2) 
Real(dp) :: AmpSqSeToSvHpm(6,3,2),  AmpSqTreeSeToSvHpm(6,3,2) 
Real(dp) :: MRPSeTocSuSd(6,6,6),MRGSeTocSuSd(6,6,6), MRPZSeTocSuSd(6,6,6),MRGZSeTocSuSd(6,6,6) 
Real(dp) :: MVPSeTocSuSd(6,6,6) 
Real(dp) :: RMsqTreeSeTocSuSd(6,6,6),RMsqWaveSeTocSuSd(6,6,6),RMsqVertexSeTocSuSd(6,6,6) 
Complex(dp) :: AmpTreeSeTocSuSd(6,6,6),AmpWaveSeTocSuSd(6,6,6),AmpVertexSeTocSuSd(6,6,6)& 
 & ,AmpVertexIRosSeTocSuSd(6,6,6),AmpVertexIRdrSeTocSuSd(6,6,6), AmpSumSeTocSuSd(6,6,6), AmpSum2SeTocSuSd(6,6,6) 
Complex(dp) :: AmpTreeZSeTocSuSd(6,6,6),AmpWaveZSeTocSuSd(6,6,6),AmpVertexZSeTocSuSd(6,6,6) 
Real(dp) :: AmpSqSeTocSuSd(6,6,6),  AmpSqTreeSeTocSuSd(6,6,6) 
Real(dp) :: MRPSeToSvSe(6,3,6),MRGSeToSvSe(6,3,6), MRPZSeToSvSe(6,3,6),MRGZSeToSvSe(6,3,6) 
Real(dp) :: MVPSeToSvSe(6,3,6) 
Real(dp) :: RMsqTreeSeToSvSe(6,3,6),RMsqWaveSeToSvSe(6,3,6),RMsqVertexSeToSvSe(6,3,6) 
Complex(dp) :: AmpTreeSeToSvSe(6,3,6),AmpWaveSeToSvSe(6,3,6),AmpVertexSeToSvSe(6,3,6)& 
 & ,AmpVertexIRosSeToSvSe(6,3,6),AmpVertexIRdrSeToSvSe(6,3,6), AmpSumSeToSvSe(6,3,6), AmpSum2SeToSvSe(6,3,6) 
Complex(dp) :: AmpTreeZSeToSvSe(6,3,6),AmpWaveZSeToSvSe(6,3,6),AmpVertexZSeToSvSe(6,3,6) 
Real(dp) :: AmpSqSeToSvSe(6,3,6),  AmpSqTreeSeToSvSe(6,3,6) 
Real(dp) :: MRPSeToSeVZ(6,6),MRGSeToSeVZ(6,6), MRPZSeToSeVZ(6,6),MRGZSeToSeVZ(6,6) 
Real(dp) :: MVPSeToSeVZ(6,6) 
Real(dp) :: RMsqTreeSeToSeVZ(6,6),RMsqWaveSeToSeVZ(6,6),RMsqVertexSeToSeVZ(6,6) 
Complex(dp) :: AmpTreeSeToSeVZ(2,6,6),AmpWaveSeToSeVZ(2,6,6),AmpVertexSeToSeVZ(2,6,6)& 
 & ,AmpVertexIRosSeToSeVZ(2,6,6),AmpVertexIRdrSeToSeVZ(2,6,6), AmpSumSeToSeVZ(2,6,6), AmpSum2SeToSeVZ(2,6,6) 
Complex(dp) :: AmpTreeZSeToSeVZ(2,6,6),AmpWaveZSeToSeVZ(2,6,6),AmpVertexZSeToSeVZ(2,6,6) 
Real(dp) :: AmpSqSeToSeVZ(6,6),  AmpSqTreeSeToSeVZ(6,6) 
Real(dp) :: MRPSeTocSvSe(6,3,6),MRGSeTocSvSe(6,3,6), MRPZSeTocSvSe(6,3,6),MRGZSeTocSvSe(6,3,6) 
Real(dp) :: MVPSeTocSvSe(6,3,6) 
Real(dp) :: RMsqTreeSeTocSvSe(6,3,6),RMsqWaveSeTocSvSe(6,3,6),RMsqVertexSeTocSvSe(6,3,6) 
Complex(dp) :: AmpTreeSeTocSvSe(6,3,6),AmpWaveSeTocSvSe(6,3,6),AmpVertexSeTocSvSe(6,3,6)& 
 & ,AmpVertexIRosSeTocSvSe(6,3,6),AmpVertexIRdrSeTocSvSe(6,3,6), AmpSumSeTocSvSe(6,3,6), AmpSum2SeTocSvSe(6,3,6) 
Complex(dp) :: AmpTreeZSeTocSvSe(6,3,6),AmpWaveZSeTocSvSe(6,3,6),AmpVertexZSeTocSvSe(6,3,6) 
Real(dp) :: AmpSqSeTocSvSe(6,3,6),  AmpSqTreeSeTocSvSe(6,3,6) 
Real(dp) :: MRPSeToSvVWm(6,3),MRGSeToSvVWm(6,3), MRPZSeToSvVWm(6,3),MRGZSeToSvVWm(6,3) 
Real(dp) :: MVPSeToSvVWm(6,3) 
Real(dp) :: RMsqTreeSeToSvVWm(6,3),RMsqWaveSeToSvVWm(6,3),RMsqVertexSeToSvVWm(6,3) 
Complex(dp) :: AmpTreeSeToSvVWm(2,6,3),AmpWaveSeToSvVWm(2,6,3),AmpVertexSeToSvVWm(2,6,3)& 
 & ,AmpVertexIRosSeToSvVWm(2,6,3),AmpVertexIRdrSeToSvVWm(2,6,3), AmpSumSeToSvVWm(2,6,3), AmpSum2SeToSvVWm(2,6,3) 
Complex(dp) :: AmpTreeZSeToSvVWm(2,6,3),AmpWaveZSeToSvVWm(2,6,3),AmpVertexZSeToSvVWm(2,6,3) 
Real(dp) :: AmpSqSeToSvVWm(6,3),  AmpSqTreeSeToSvVWm(6,3) 
Real(dp) :: MRPSeToAhHpm(6,2,2),MRGSeToAhHpm(6,2,2), MRPZSeToAhHpm(6,2,2),MRGZSeToAhHpm(6,2,2) 
Real(dp) :: MVPSeToAhHpm(6,2,2) 
Real(dp) :: RMsqTreeSeToAhHpm(6,2,2),RMsqWaveSeToAhHpm(6,2,2),RMsqVertexSeToAhHpm(6,2,2) 
Complex(dp) :: AmpTreeSeToAhHpm(6,2,2),AmpWaveSeToAhHpm(6,2,2),AmpVertexSeToAhHpm(6,2,2)& 
 & ,AmpVertexIRosSeToAhHpm(6,2,2),AmpVertexIRdrSeToAhHpm(6,2,2), AmpSumSeToAhHpm(6,2,2), AmpSum2SeToAhHpm(6,2,2) 
Complex(dp) :: AmpTreeZSeToAhHpm(6,2,2),AmpWaveZSeToAhHpm(6,2,2),AmpVertexZSeToAhHpm(6,2,2) 
Real(dp) :: AmpSqSeToAhHpm(6,2,2),  AmpSqTreeSeToAhHpm(6,2,2) 
Real(dp) :: MRPSeToAhVWm(6,2),MRGSeToAhVWm(6,2), MRPZSeToAhVWm(6,2),MRGZSeToAhVWm(6,2) 
Real(dp) :: MVPSeToAhVWm(6,2) 
Real(dp) :: RMsqTreeSeToAhVWm(6,2),RMsqWaveSeToAhVWm(6,2),RMsqVertexSeToAhVWm(6,2) 
Complex(dp) :: AmpTreeSeToAhVWm(2,6,2),AmpWaveSeToAhVWm(2,6,2),AmpVertexSeToAhVWm(2,6,2)& 
 & ,AmpVertexIRosSeToAhVWm(2,6,2),AmpVertexIRdrSeToAhVWm(2,6,2), AmpSumSeToAhVWm(2,6,2), AmpSum2SeToAhVWm(2,6,2) 
Complex(dp) :: AmpTreeZSeToAhVWm(2,6,2),AmpWaveZSeToAhVWm(2,6,2),AmpVertexZSeToAhVWm(2,6,2) 
Real(dp) :: AmpSqSeToAhVWm(6,2),  AmpSqTreeSeToAhVWm(6,2) 
Real(dp) :: MRPSeToChaChi(6,2,4),MRGSeToChaChi(6,2,4), MRPZSeToChaChi(6,2,4),MRGZSeToChaChi(6,2,4) 
Real(dp) :: MVPSeToChaChi(6,2,4) 
Real(dp) :: RMsqTreeSeToChaChi(6,2,4),RMsqWaveSeToChaChi(6,2,4),RMsqVertexSeToChaChi(6,2,4) 
Complex(dp) :: AmpTreeSeToChaChi(2,6,2,4),AmpWaveSeToChaChi(2,6,2,4),AmpVertexSeToChaChi(2,6,2,4)& 
 & ,AmpVertexIRosSeToChaChi(2,6,2,4),AmpVertexIRdrSeToChaChi(2,6,2,4), AmpSumSeToChaChi(2,6,2,4), AmpSum2SeToChaChi(2,6,2,4) 
Complex(dp) :: AmpTreeZSeToChaChi(2,6,2,4),AmpWaveZSeToChaChi(2,6,2,4),AmpVertexZSeToChaChi(2,6,2,4) 
Real(dp) :: AmpSqSeToChaChi(6,2,4),  AmpSqTreeSeToChaChi(6,2,4) 
Real(dp) :: MRPSeTohhHpm(6,2,2),MRGSeTohhHpm(6,2,2), MRPZSeTohhHpm(6,2,2),MRGZSeTohhHpm(6,2,2) 
Real(dp) :: MVPSeTohhHpm(6,2,2) 
Real(dp) :: RMsqTreeSeTohhHpm(6,2,2),RMsqWaveSeTohhHpm(6,2,2),RMsqVertexSeTohhHpm(6,2,2) 
Complex(dp) :: AmpTreeSeTohhHpm(6,2,2),AmpWaveSeTohhHpm(6,2,2),AmpVertexSeTohhHpm(6,2,2)& 
 & ,AmpVertexIRosSeTohhHpm(6,2,2),AmpVertexIRdrSeTohhHpm(6,2,2), AmpSumSeTohhHpm(6,2,2), AmpSum2SeTohhHpm(6,2,2) 
Complex(dp) :: AmpTreeZSeTohhHpm(6,2,2),AmpWaveZSeTohhHpm(6,2,2),AmpVertexZSeTohhHpm(6,2,2) 
Real(dp) :: AmpSqSeTohhHpm(6,2,2),  AmpSqTreeSeTohhHpm(6,2,2) 
Real(dp) :: MRPSeTohhVWm(6,2),MRGSeTohhVWm(6,2), MRPZSeTohhVWm(6,2),MRGZSeTohhVWm(6,2) 
Real(dp) :: MVPSeTohhVWm(6,2) 
Real(dp) :: RMsqTreeSeTohhVWm(6,2),RMsqWaveSeTohhVWm(6,2),RMsqVertexSeTohhVWm(6,2) 
Complex(dp) :: AmpTreeSeTohhVWm(2,6,2),AmpWaveSeTohhVWm(2,6,2),AmpVertexSeTohhVWm(2,6,2)& 
 & ,AmpVertexIRosSeTohhVWm(2,6,2),AmpVertexIRdrSeTohhVWm(2,6,2), AmpSumSeTohhVWm(2,6,2), AmpSum2SeTohhVWm(2,6,2) 
Complex(dp) :: AmpTreeZSeTohhVWm(2,6,2),AmpWaveZSeTohhVWm(2,6,2),AmpVertexZSeTohhVWm(2,6,2) 
Real(dp) :: AmpSqSeTohhVWm(6,2),  AmpSqTreeSeTohhVWm(6,2) 
Real(dp) :: MRPSeToHpmVP(6,2),MRGSeToHpmVP(6,2), MRPZSeToHpmVP(6,2),MRGZSeToHpmVP(6,2) 
Real(dp) :: MVPSeToHpmVP(6,2) 
Real(dp) :: RMsqTreeSeToHpmVP(6,2),RMsqWaveSeToHpmVP(6,2),RMsqVertexSeToHpmVP(6,2) 
Complex(dp) :: AmpTreeSeToHpmVP(2,6,2),AmpWaveSeToHpmVP(2,6,2),AmpVertexSeToHpmVP(2,6,2)& 
 & ,AmpVertexIRosSeToHpmVP(2,6,2),AmpVertexIRdrSeToHpmVP(2,6,2), AmpSumSeToHpmVP(2,6,2), AmpSum2SeToHpmVP(2,6,2) 
Complex(dp) :: AmpTreeZSeToHpmVP(2,6,2),AmpWaveZSeToHpmVP(2,6,2),AmpVertexZSeToHpmVP(2,6,2) 
Real(dp) :: AmpSqSeToHpmVP(6,2),  AmpSqTreeSeToHpmVP(6,2) 
Real(dp) :: MRPSeToHpmVZ(6,2),MRGSeToHpmVZ(6,2), MRPZSeToHpmVZ(6,2),MRGZSeToHpmVZ(6,2) 
Real(dp) :: MVPSeToHpmVZ(6,2) 
Real(dp) :: RMsqTreeSeToHpmVZ(6,2),RMsqWaveSeToHpmVZ(6,2),RMsqVertexSeToHpmVZ(6,2) 
Complex(dp) :: AmpTreeSeToHpmVZ(2,6,2),AmpWaveSeToHpmVZ(2,6,2),AmpVertexSeToHpmVZ(2,6,2)& 
 & ,AmpVertexIRosSeToHpmVZ(2,6,2),AmpVertexIRdrSeToHpmVZ(2,6,2), AmpSumSeToHpmVZ(2,6,2), AmpSum2SeToHpmVZ(2,6,2) 
Complex(dp) :: AmpTreeZSeToHpmVZ(2,6,2),AmpWaveZSeToHpmVZ(2,6,2),AmpVertexZSeToHpmVZ(2,6,2) 
Real(dp) :: AmpSqSeToHpmVZ(6,2),  AmpSqTreeSeToHpmVZ(6,2) 
Real(dp) :: MRPSeToHpmcSv(6,2,3),MRGSeToHpmcSv(6,2,3), MRPZSeToHpmcSv(6,2,3),MRGZSeToHpmcSv(6,2,3) 
Real(dp) :: MVPSeToHpmcSv(6,2,3) 
Real(dp) :: RMsqTreeSeToHpmcSv(6,2,3),RMsqWaveSeToHpmcSv(6,2,3),RMsqVertexSeToHpmcSv(6,2,3) 
Complex(dp) :: AmpTreeSeToHpmcSv(6,2,3),AmpWaveSeToHpmcSv(6,2,3),AmpVertexSeToHpmcSv(6,2,3)& 
 & ,AmpVertexIRosSeToHpmcSv(6,2,3),AmpVertexIRdrSeToHpmcSv(6,2,3), AmpSumSeToHpmcSv(6,2,3), AmpSum2SeToHpmcSv(6,2,3) 
Complex(dp) :: AmpTreeZSeToHpmcSv(6,2,3),AmpWaveZSeToHpmcSv(6,2,3),AmpVertexZSeToHpmcSv(6,2,3) 
Real(dp) :: AmpSqSeToHpmcSv(6,2,3),  AmpSqTreeSeToHpmcSv(6,2,3) 
Real(dp) :: MRPSeToSeVP(6,6),MRGSeToSeVP(6,6), MRPZSeToSeVP(6,6),MRGZSeToSeVP(6,6) 
Real(dp) :: MVPSeToSeVP(6,6) 
Real(dp) :: RMsqTreeSeToSeVP(6,6),RMsqWaveSeToSeVP(6,6),RMsqVertexSeToSeVP(6,6) 
Complex(dp) :: AmpTreeSeToSeVP(2,6,6),AmpWaveSeToSeVP(2,6,6),AmpVertexSeToSeVP(2,6,6)& 
 & ,AmpVertexIRosSeToSeVP(2,6,6),AmpVertexIRdrSeToSeVP(2,6,6), AmpSumSeToSeVP(2,6,6), AmpSum2SeToSeVP(2,6,6) 
Complex(dp) :: AmpTreeZSeToSeVP(2,6,6),AmpWaveZSeToSeVP(2,6,6),AmpVertexZSeToSeVP(2,6,6) 
Real(dp) :: AmpSqSeToSeVP(6,6),  AmpSqTreeSeToSeVP(6,6) 
Real(dp) :: MRPSeToVPVWm(6),MRGSeToVPVWm(6), MRPZSeToVPVWm(6),MRGZSeToVPVWm(6) 
Real(dp) :: MVPSeToVPVWm(6) 
Real(dp) :: RMsqTreeSeToVPVWm(6),RMsqWaveSeToVPVWm(6),RMsqVertexSeToVPVWm(6) 
Complex(dp) :: AmpTreeSeToVPVWm(2,6),AmpWaveSeToVPVWm(2,6),AmpVertexSeToVPVWm(2,6)& 
 & ,AmpVertexIRosSeToVPVWm(2,6),AmpVertexIRdrSeToVPVWm(2,6), AmpSumSeToVPVWm(2,6), AmpSum2SeToVPVWm(2,6) 
Complex(dp) :: AmpTreeZSeToVPVWm(2,6),AmpWaveZSeToVPVWm(2,6),AmpVertexZSeToVPVWm(2,6) 
Real(dp) :: AmpSqSeToVPVWm(6),  AmpSqTreeSeToVPVWm(6) 
Real(dp) :: MRPSeToVWmVZ(6),MRGSeToVWmVZ(6), MRPZSeToVWmVZ(6),MRGZSeToVWmVZ(6) 
Real(dp) :: MVPSeToVWmVZ(6) 
Real(dp) :: RMsqTreeSeToVWmVZ(6),RMsqWaveSeToVWmVZ(6),RMsqVertexSeToVWmVZ(6) 
Complex(dp) :: AmpTreeSeToVWmVZ(2,6),AmpWaveSeToVWmVZ(2,6),AmpVertexSeToVWmVZ(2,6)& 
 & ,AmpVertexIRosSeToVWmVZ(2,6),AmpVertexIRdrSeToVWmVZ(2,6), AmpSumSeToVWmVZ(2,6), AmpSum2SeToVWmVZ(2,6) 
Complex(dp) :: AmpTreeZSeToVWmVZ(2,6),AmpWaveZSeToVWmVZ(2,6),AmpVertexZSeToVWmVZ(2,6) 
Real(dp) :: AmpSqSeToVWmVZ(6),  AmpSqTreeSeToVWmVZ(6) 
Real(dp) :: MRPSeTocSvVWm(6,3),MRGSeTocSvVWm(6,3), MRPZSeTocSvVWm(6,3),MRGZSeTocSvVWm(6,3) 
Real(dp) :: MVPSeTocSvVWm(6,3) 
Real(dp) :: RMsqTreeSeTocSvVWm(6,3),RMsqWaveSeTocSvVWm(6,3),RMsqVertexSeTocSvVWm(6,3) 
Complex(dp) :: AmpTreeSeTocSvVWm(2,6,3),AmpWaveSeTocSvVWm(2,6,3),AmpVertexSeTocSvVWm(2,6,3)& 
 & ,AmpVertexIRosSeTocSvVWm(2,6,3),AmpVertexIRdrSeTocSvVWm(2,6,3), AmpSumSeTocSvVWm(2,6,3), AmpSum2SeTocSvVWm(2,6,3) 
Complex(dp) :: AmpTreeZSeTocSvVWm(2,6,3),AmpWaveZSeTocSvVWm(2,6,3),AmpVertexZSeTocSvVWm(2,6,3) 
Real(dp) :: AmpSqSeTocSvVWm(6,3),  AmpSqTreeSeTocSvVWm(6,3) 
Write(*,*) "Calculating one-loop decays of Se " 
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
! Se Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToSeAh(cplAhSecSe,MAh,MSe,MAh2,MSe2,AmpTreeSeToSeAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToSeAh(ZcplAhSecSe,MAh,MSe,MAh2,MSe2,AmpTreeSeToSeAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSeAh(MLambda,em,gs,cplAhSecSe,MAhOS,MSeOS,             & 
& MRPSeToSeAh,MRGSeToSeAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSeAh(MLambda,em,gs,ZcplAhSecSe,MAhOS,MSeOS,            & 
& MRPSeToSeAh,MRGSeToSeAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToSeAh(MLambda,em,gs,cplAhSecSe,MAh,MSe,MRPSeToSeAh,     & 
& MRGSeToSeAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSeAh(MLambda,em,gs,ZcplAhSecSe,MAh,MSe,MRPSeToSeAh,    & 
& MRGSeToSeAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSeAh(cplAhSecSe,ctcplAhSecSe,MAh,MAh2,             & 
& MSe,MSe2,ZfAh,ZfSe,AmpWaveSeToSeAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSeAh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
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
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexSeToSeAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRdrSeToSeAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosSeToSeAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosSeToSeAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosSeToSeAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,AmpVertexIRosSeToSeAh)

 End if 
 End if 
AmpVertexSeToSeAh = AmpVertexSeToSeAh -  AmpVertexIRdrSeToSeAh! +  AmpVertexIRosSeToSeAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToSeAh=0._dp 
AmpVertexZSeToSeAh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSeAh(gt2,:,:) = AmpWaveZSeToSeAh(gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToSeAh(gt1,:,:) 
AmpVertexZSeToSeAh(gt2,:,:)= AmpVertexZSeToSeAh(gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToSeAh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToSeAh=AmpWaveZSeToSeAh 
AmpVertexSeToSeAh= AmpVertexZSeToSeAh
! Final State 1 
AmpWaveZSeToSeAh=0._dp 
AmpVertexZSeToSeAh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSeAh(:,gt2,:) = AmpWaveZSeToSeAh(:,gt2,:)+ZRUZE(gt2,gt1)*AmpWaveSeToSeAh(:,gt1,:) 
AmpVertexZSeToSeAh(:,gt2,:)= AmpVertexZSeToSeAh(:,gt2,:)+ZRUZE(gt2,gt1)*AmpVertexSeToSeAh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToSeAh=AmpWaveZSeToSeAh 
AmpVertexSeToSeAh= AmpVertexZSeToSeAh
! Final State 2 
AmpWaveZSeToSeAh=0._dp 
AmpVertexZSeToSeAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSeToSeAh(:,:,gt2) = AmpWaveZSeToSeAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveSeToSeAh(:,:,gt1) 
AmpVertexZSeToSeAh(:,:,gt2)= AmpVertexZSeToSeAh(:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexSeToSeAh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToSeAh=AmpWaveZSeToSeAh 
AmpVertexSeToSeAh= AmpVertexZSeToSeAh
End if
If (ShiftIRdiv) Then 
AmpVertexSeToSeAh = AmpVertexSeToSeAh  +  AmpVertexIRosSeToSeAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Se Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToSeAh = AmpTreeSeToSeAh 
 AmpSum2SeToSeAh = AmpTreeSeToSeAh + 2._dp*AmpWaveSeToSeAh + 2._dp*AmpVertexSeToSeAh  
Else 
 AmpSumSeToSeAh = AmpTreeSeToSeAh + AmpWaveSeToSeAh + AmpVertexSeToSeAh
 AmpSum2SeToSeAh = AmpTreeSeToSeAh + AmpWaveSeToSeAh + AmpVertexSeToSeAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSeAh = AmpTreeSeToSeAh
 AmpSum2SeToSeAh = AmpTreeSeToSeAh 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSeOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSe(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToSeAh = AmpTreeSeToSeAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),MAh(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToSeAh(gt1, gt2, gt3) 
  AmpSum2SeToSeAh = 2._dp*AmpWaveSeToSeAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),MAh(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToSeAh(gt1, gt2, gt3) 
  AmpSum2SeToSeAh = 2._dp*AmpVertexSeToSeAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),MAh(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToSeAh(gt1, gt2, gt3) 
  AmpSum2SeToSeAh = AmpTreeSeToSeAh + 2._dp*AmpWaveSeToSeAh + 2._dp*AmpVertexSeToSeAh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),MAh(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToSeAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToSeAh = AmpTreeSeToSeAh
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
  AmpSqTreeSeToSeAh(gt1, gt2, gt3) = (1)*AmpSqSeToSeAh(gt1, gt2, gt3)  
  AmpSum2SeToSeAh = + 2._dp*AmpWaveSeToSeAh + 2._dp*AmpVertexSeToSeAh
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
  AmpSqSeToSeAh(gt1, gt2, gt3) = AmpSqSeToSeAh(gt1, gt2, gt3) + AmpSqTreeSeToSeAh(gt1, gt2, gt3)  
Else  
  AmpSum2SeToSeAh = AmpTreeSeToSeAh
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),MAh(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
  AmpSqTreeSeToSeAh(gt1, gt2, gt3) = (1)*AmpSqSeToSeAh(gt1, gt2, gt3)  
  AmpSum2SeToSeAh = + 2._dp*AmpWaveSeToSeAh + 2._dp*AmpVertexSeToSeAh
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),MAh(gt3),AmpSumSeToSeAh(gt1, gt2, gt3),AmpSum2SeToSeAh(gt1, gt2, gt3),AmpSqSeToSeAh(gt1, gt2, gt3)) 
  AmpSqSeToSeAh(gt1, gt2, gt3) = AmpSqSeToSeAh(gt1, gt2, gt3) + AmpSqTreeSeToSeAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToSeAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSeAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSeOS(gt2),MAhOS(gt3),helfactor*AmpSqSeToSeAh(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSe(gt2),MAh(gt3),helfactor*AmpSqSeToSeAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToSeAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSeAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToSeAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSeAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSeAh(gt1, gt2, gt3) + MRGSeToSeAh(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSeAh(gt1, gt2, gt3) + MRGSeToSeAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Fv Cha
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToFvCha(cplFvChacSeL,cplFvChacSeR,MCha,              & 
& MSe,MCha2,MSe2,AmpTreeSeToFvCha)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToFvCha(ZcplFvChacSeL,ZcplFvChacSeR,MCha,            & 
& MSe,MCha2,MSe2,AmpTreeSeToFvCha)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFvCha(MLambda,em,gs,cplFvChacSeL,cplFvChacSeR,         & 
& MChaOS,MSeOS,MRPSeToFvCha,MRGSeToFvCha)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFvCha(MLambda,em,gs,ZcplFvChacSeL,ZcplFvChacSeR,       & 
& MChaOS,MSeOS,MRPSeToFvCha,MRGSeToFvCha)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToFvCha(MLambda,em,gs,cplFvChacSeL,cplFvChacSeR,         & 
& MCha,MSe,MRPSeToFvCha,MRGSeToFvCha)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFvCha(MLambda,em,gs,ZcplFvChacSeL,ZcplFvChacSeR,       & 
& MCha,MSe,MRPSeToFvCha,MRGSeToFvCha)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToFvCha(cplFvChacSeL,cplFvChacSeR,ctcplFvChacSeL,    & 
& ctcplFvChacSeR,MCha,MCha2,MSe,MSe2,ZfFvL,ZfLm,ZfLp,ZfSe,AmpWaveSeToFvCha)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToFvCha(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,            & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexSeToFvCha)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,      & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRdrSeToFvCha)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,cplChiChacHpmL,      & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,ZcplFvChacSeL,  & 
& ZcplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,      & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFecSeL,     & 
& cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,              & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvCha)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,      & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,ZcplFvChacSeL,ZcplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,     & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvCha)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,cplChiChacHpmL,      & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,       & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFecSeL,     & 
& cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,              & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvCha)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,      & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvCha)

 End if 
 End if 
AmpVertexSeToFvCha = AmpVertexSeToFvCha -  AmpVertexIRdrSeToFvCha! +  AmpVertexIRosSeToFvCha ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToFvCha=0._dp 
AmpVertexZSeToFvCha=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToFvCha(:,gt2,:,:) = AmpWaveZSeToFvCha(:,gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToFvCha(:,gt1,:,:) 
AmpVertexZSeToFvCha(:,gt2,:,:)= AmpVertexZSeToFvCha(:,gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToFvCha(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToFvCha=AmpWaveZSeToFvCha 
AmpVertexSeToFvCha= AmpVertexZSeToFvCha
! Final State 1 
AmpWaveZSeToFvCha=0._dp 
AmpVertexZSeToFvCha=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToFvCha(1,:,gt2,:) = AmpWaveZSeToFvCha(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpWaveSeToFvCha(1,:,gt1,:) 
AmpVertexZSeToFvCha(1,:,gt2,:)= AmpVertexZSeToFvCha(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpVertexSeToFvCha(1,:,gt1,:) 
AmpWaveZSeToFvCha(2,:,gt2,:) = AmpWaveZSeToFvCha(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpWaveSeToFvCha(2,:,gt1,:) 
AmpVertexZSeToFvCha(2,:,gt2,:)= AmpVertexZSeToFvCha(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpVertexSeToFvCha(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToFvCha=AmpWaveZSeToFvCha 
AmpVertexSeToFvCha= AmpVertexZSeToFvCha
! Final State 2 
AmpWaveZSeToFvCha=0._dp 
AmpVertexZSeToFvCha=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSeToFvCha(1,:,:,gt2) = AmpWaveZSeToFvCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpWaveSeToFvCha(1,:,:,gt1) 
AmpVertexZSeToFvCha(1,:,:,gt2)= AmpVertexZSeToFvCha(1,:,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexSeToFvCha(1,:,:,gt1) 
AmpWaveZSeToFvCha(2,:,:,gt2) = AmpWaveZSeToFvCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpWaveSeToFvCha(2,:,:,gt1) 
AmpVertexZSeToFvCha(2,:,:,gt2)= AmpVertexZSeToFvCha(2,:,:,gt2)+ZRUUP(gt2,gt1)*AmpVertexSeToFvCha(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToFvCha=AmpWaveZSeToFvCha 
AmpVertexSeToFvCha= AmpVertexZSeToFvCha
End if
If (ShiftIRdiv) Then 
AmpVertexSeToFvCha = AmpVertexSeToFvCha  +  AmpVertexIRosSeToFvCha
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Fv Cha -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToFvCha = AmpTreeSeToFvCha 
 AmpSum2SeToFvCha = AmpTreeSeToFvCha + 2._dp*AmpWaveSeToFvCha + 2._dp*AmpVertexSeToFvCha  
Else 
 AmpSumSeToFvCha = AmpTreeSeToFvCha + AmpWaveSeToFvCha + AmpVertexSeToFvCha
 AmpSum2SeToFvCha = AmpTreeSeToFvCha + AmpWaveSeToFvCha + AmpVertexSeToFvCha 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToFvCha = AmpTreeSeToFvCha
 AmpSum2SeToFvCha = AmpTreeSeToFvCha 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(0.+MChaOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(0.+MCha(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToFvCha = AmpTreeSeToFvCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MChaOS(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MCha(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToFvCha(gt1, gt2, gt3) 
  AmpSum2SeToFvCha = 2._dp*AmpWaveSeToFvCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MChaOS(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MCha(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToFvCha(gt1, gt2, gt3) 
  AmpSum2SeToFvCha = 2._dp*AmpVertexSeToFvCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MChaOS(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MCha(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToFvCha(gt1, gt2, gt3) 
  AmpSum2SeToFvCha = AmpTreeSeToFvCha + 2._dp*AmpWaveSeToFvCha + 2._dp*AmpVertexSeToFvCha
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MChaOS(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MCha(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToFvCha(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToFvCha = AmpTreeSeToFvCha
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MChaOS(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
  AmpSqTreeSeToFvCha(gt1, gt2, gt3) = (1)*AmpSqSeToFvCha(gt1, gt2, gt3)  
  AmpSum2SeToFvCha = + 2._dp*AmpWaveSeToFvCha + 2._dp*AmpVertexSeToFvCha
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MChaOS(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
  AmpSqSeToFvCha(gt1, gt2, gt3) = AmpSqSeToFvCha(gt1, gt2, gt3) + AmpSqTreeSeToFvCha(gt1, gt2, gt3)  
Else  
  AmpSum2SeToFvCha = AmpTreeSeToFvCha
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MCha(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
  AmpSqTreeSeToFvCha(gt1, gt2, gt3) = (1)*AmpSqSeToFvCha(gt1, gt2, gt3)  
  AmpSum2SeToFvCha = + 2._dp*AmpWaveSeToFvCha + 2._dp*AmpVertexSeToFvCha
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MCha(gt3),AmpSumSeToFvCha(:,gt1, gt2, gt3),AmpSum2SeToFvCha(:,gt1, gt2, gt3),AmpSqSeToFvCha(gt1, gt2, gt3)) 
  AmpSqSeToFvCha(gt1, gt2, gt3) = AmpSqSeToFvCha(gt1, gt2, gt3) + AmpSqTreeSeToFvCha(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToFvCha(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSeToFvCha(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),0._dp,MChaOS(gt3),helfactor*AmpSqSeToFvCha(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),0._dp,MCha(gt3),helfactor*AmpSqSeToFvCha(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToFvCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToFvCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToFvCha(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToFvCha(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToFvCha(gt1, gt2, gt3) + MRGSeToFvCha(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToFvCha(gt1, gt2, gt3) + MRGSeToFvCha(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Fe Chi
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToFeChi(cplChiFecSeL,cplChiFecSeR,MChi,              & 
& MFe,MSe,MChi2,MFe2,MSe2,AmpTreeSeToFeChi)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToFeChi(ZcplChiFecSeL,ZcplChiFecSeR,MChi,            & 
& MFe,MSe,MChi2,MFe2,MSe2,AmpTreeSeToFeChi)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFeChi(MLambda,em,gs,cplChiFecSeL,cplChiFecSeR,         & 
& MChiOS,MFeOS,MSeOS,MRPSeToFeChi,MRGSeToFeChi)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFeChi(MLambda,em,gs,ZcplChiFecSeL,ZcplChiFecSeR,       & 
& MChiOS,MFeOS,MSeOS,MRPSeToFeChi,MRGSeToFeChi)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToFeChi(MLambda,em,gs,cplChiFecSeL,cplChiFecSeR,         & 
& MChi,MFe,MSe,MRPSeToFeChi,MRGSeToFeChi)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFeChi(MLambda,em,gs,ZcplChiFecSeL,ZcplChiFecSeR,       & 
& MChi,MFe,MSe,MRPSeToFeChi,MRGSeToFeChi)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToFeChi(cplChiFecSeL,cplChiFecSeR,ctcplChiFecSeL,    & 
& ctcplChiFecSeR,MChi,MChi2,MFe,MFe2,MSe,MSe2,ZfFEL,ZfFER,ZfL0,ZfSe,AmpWaveSeToFeChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToFeChi(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,cplcFeFeAhL,             & 
& cplcFeFeAhR,cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,    & 
& cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,         & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,       & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSvcSe,               & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexSeToFeChi)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,    & 
& cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,         & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,       & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSvcSe,               & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRdrSeToFeChi)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,cplcFeFeAhL,cplcFeFeAhR,          & 
& cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,   & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,ZcplChiFecSeL,ZcplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,        & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,         & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFeChi)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,    & 
& cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,         & 
& cplChiFdcSdL,cplChiFdcSdR,ZcplChiFecSeL,ZcplChiFecSeR,cplChiFucSuL,cplChiFucSuR,       & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,       & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSvcSe,               & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFeChi)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplChiChiAhL,cplChiChiAhR,cplcFeFeAhL,cplcFeFeAhR,          & 
& cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,   & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,         & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFeChi)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,    & 
& cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,         & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,       & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSvcSe,               & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFeChi)

 End if 
 End if 
AmpVertexSeToFeChi = AmpVertexSeToFeChi -  AmpVertexIRdrSeToFeChi! +  AmpVertexIRosSeToFeChi ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToFeChi=0._dp 
AmpVertexZSeToFeChi=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToFeChi(:,gt2,:,:) = AmpWaveZSeToFeChi(:,gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToFeChi(:,gt1,:,:) 
AmpVertexZSeToFeChi(:,gt2,:,:)= AmpVertexZSeToFeChi(:,gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToFeChi(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToFeChi=AmpWaveZSeToFeChi 
AmpVertexSeToFeChi= AmpVertexZSeToFeChi
! Final State 1 
AmpWaveZSeToFeChi=0._dp 
AmpVertexZSeToFeChi=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToFeChi(1,:,gt2,:) = AmpWaveZSeToFeChi(1,:,gt2,:)+ZRUZEL(gt2,gt1)*AmpWaveSeToFeChi(1,:,gt1,:) 
AmpVertexZSeToFeChi(1,:,gt2,:)= AmpVertexZSeToFeChi(1,:,gt2,:)+ZRUZEL(gt2,gt1)*AmpVertexSeToFeChi(1,:,gt1,:) 
AmpWaveZSeToFeChi(2,:,gt2,:) = AmpWaveZSeToFeChi(2,:,gt2,:)+ZRUZERc(gt2,gt1)*AmpWaveSeToFeChi(2,:,gt1,:) 
AmpVertexZSeToFeChi(2,:,gt2,:)= AmpVertexZSeToFeChi(2,:,gt2,:)+ZRUZERc(gt2,gt1)*AmpVertexSeToFeChi(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToFeChi=AmpWaveZSeToFeChi 
AmpVertexSeToFeChi= AmpVertexZSeToFeChi
! Final State 2 
AmpWaveZSeToFeChi=0._dp 
AmpVertexZSeToFeChi=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZSeToFeChi(1,:,:,gt2) = AmpWaveZSeToFeChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSeToFeChi(1,:,:,gt1) 
AmpVertexZSeToFeChi(1,:,:,gt2)= AmpVertexZSeToFeChi(1,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSeToFeChi(1,:,:,gt1) 
AmpWaveZSeToFeChi(2,:,:,gt2) = AmpWaveZSeToFeChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveSeToFeChi(2,:,:,gt1) 
AmpVertexZSeToFeChi(2,:,:,gt2)= AmpVertexZSeToFeChi(2,:,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexSeToFeChi(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToFeChi=AmpWaveZSeToFeChi 
AmpVertexSeToFeChi= AmpVertexZSeToFeChi
End if
If (ShiftIRdiv) Then 
AmpVertexSeToFeChi = AmpVertexSeToFeChi  +  AmpVertexIRosSeToFeChi
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Fe Chi -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToFeChi = AmpTreeSeToFeChi 
 AmpSum2SeToFeChi = AmpTreeSeToFeChi + 2._dp*AmpWaveSeToFeChi + 2._dp*AmpVertexSeToFeChi  
Else 
 AmpSumSeToFeChi = AmpTreeSeToFeChi + AmpWaveSeToFeChi + AmpVertexSeToFeChi
 AmpSum2SeToFeChi = AmpTreeSeToFeChi + AmpWaveSeToFeChi + AmpVertexSeToFeChi 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToFeChi = AmpTreeSeToFeChi
 AmpSum2SeToFeChi = AmpTreeSeToFeChi 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,4
If (((OSkinematics).and.(MSeOS(gt1).gt.(MFeOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MFe(gt2)+MChi(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToFeChi = AmpTreeSeToFeChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFe(gt2),MChi(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToFeChi(gt1, gt2, gt3) 
  AmpSum2SeToFeChi = 2._dp*AmpWaveSeToFeChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFe(gt2),MChi(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToFeChi(gt1, gt2, gt3) 
  AmpSum2SeToFeChi = 2._dp*AmpVertexSeToFeChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFe(gt2),MChi(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToFeChi(gt1, gt2, gt3) 
  AmpSum2SeToFeChi = AmpTreeSeToFeChi + 2._dp*AmpWaveSeToFeChi + 2._dp*AmpVertexSeToFeChi
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFe(gt2),MChi(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToFeChi(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToFeChi = AmpTreeSeToFeChi
  Call SquareAmp_StoFF(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
  AmpSqTreeSeToFeChi(gt1, gt2, gt3) = (1)*AmpSqSeToFeChi(gt1, gt2, gt3)  
  AmpSum2SeToFeChi = + 2._dp*AmpWaveSeToFeChi + 2._dp*AmpVertexSeToFeChi
  Call SquareAmp_StoFF(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
  AmpSqSeToFeChi(gt1, gt2, gt3) = AmpSqSeToFeChi(gt1, gt2, gt3) + AmpSqTreeSeToFeChi(gt1, gt2, gt3)  
Else  
  AmpSum2SeToFeChi = AmpTreeSeToFeChi
  Call SquareAmp_StoFF(MSe(gt1),MFe(gt2),MChi(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
  AmpSqTreeSeToFeChi(gt1, gt2, gt3) = (1)*AmpSqSeToFeChi(gt1, gt2, gt3)  
  AmpSum2SeToFeChi = + 2._dp*AmpWaveSeToFeChi + 2._dp*AmpVertexSeToFeChi
  Call SquareAmp_StoFF(MSe(gt1),MFe(gt2),MChi(gt3),AmpSumSeToFeChi(:,gt1, gt2, gt3),AmpSum2SeToFeChi(:,gt1, gt2, gt3),AmpSqSeToFeChi(gt1, gt2, gt3)) 
  AmpSqSeToFeChi(gt1, gt2, gt3) = AmpSqSeToFeChi(gt1, gt2, gt3) + AmpSqTreeSeToFeChi(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToFeChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSeToFeChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MFeOS(gt2),MChiOS(gt3),helfactor*AmpSqSeToFeChi(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MFe(gt2),MChi(gt3),helfactor*AmpSqSeToFeChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToFeChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToFeChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToFeChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToFeChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToFeChi(gt1, gt2, gt3) + MRGSeToFeChi(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToFeChi(gt1, gt2, gt3) + MRGSeToFeChi(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! bar(Fu) Fd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeTocFuFd(cplcFuFdcSeL,cplcFuFdcSeR,MFd,               & 
& MFu,MSe,MFd2,MFu2,MSe2,AmpTreeSeTocFuFd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeTocFuFd(ZcplcFuFdcSeL,ZcplcFuFdcSeR,MFd,             & 
& MFu,MSe,MFd2,MFu2,MSe2,AmpTreeSeTocFuFd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocFuFd(MLambda,em,gs,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& MFdOS,MFuOS,MSeOS,MRPSeTocFuFd,MRGSeTocFuFd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocFuFd(MLambda,em,gs,ZcplcFuFdcSeL,ZcplcFuFdcSeR,       & 
& MFdOS,MFuOS,MSeOS,MRPSeTocFuFd,MRGSeTocFuFd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeTocFuFd(MLambda,em,gs,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& MFd,MFu,MSe,MRPSeTocFuFd,MRGSeTocFuFd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocFuFd(MLambda,em,gs,ZcplcFuFdcSeL,ZcplcFuFdcSeR,       & 
& MFd,MFu,MSe,MRPSeTocFuFd,MRGSeTocFuFd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeTocFuFd(cplcFuFdcSeL,cplcFuFdcSeR,ctcplcFuFdcSeL,    & 
& ctcplcFuFdcSeR,MFd,MFd2,MFu,MFu2,MSe,MSe2,ZfFDL,ZfFDR,ZfFUL,ZfFUR,ZfSe,AmpWaveSeTocFuFd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexSeTocFuFd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRdrSeTocFuFd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeTocFuFd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeTocFuFd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeTocFuFd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeTocFuFd)

 End if 
 End if 
AmpVertexSeTocFuFd = AmpVertexSeTocFuFd -  AmpVertexIRdrSeTocFuFd! +  AmpVertexIRosSeTocFuFd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeTocFuFd=0._dp 
AmpVertexZSeTocFuFd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeTocFuFd(:,gt2,:,:) = AmpWaveZSeTocFuFd(:,gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeTocFuFd(:,gt1,:,:) 
AmpVertexZSeTocFuFd(:,gt2,:,:)= AmpVertexZSeTocFuFd(:,gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeTocFuFd(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSeTocFuFd=AmpWaveZSeTocFuFd 
AmpVertexSeTocFuFd= AmpVertexZSeTocFuFd
! Final State 1 
AmpWaveZSeTocFuFd=0._dp 
AmpVertexZSeTocFuFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeTocFuFd(1,:,gt2,:) = AmpWaveZSeTocFuFd(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveSeTocFuFd(1,:,gt1,:) 
AmpVertexZSeTocFuFd(1,:,gt2,:)= AmpVertexZSeTocFuFd(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpVertexSeTocFuFd(1,:,gt1,:) 
AmpWaveZSeTocFuFd(2,:,gt2,:) = AmpWaveZSeTocFuFd(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveSeTocFuFd(2,:,gt1,:) 
AmpVertexZSeTocFuFd(2,:,gt2,:)= AmpVertexZSeTocFuFd(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpVertexSeTocFuFd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSeTocFuFd=AmpWaveZSeTocFuFd 
AmpVertexSeTocFuFd= AmpVertexZSeTocFuFd
! Final State 2 
AmpWaveZSeTocFuFd=0._dp 
AmpVertexZSeTocFuFd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeTocFuFd(1,:,:,gt2) = AmpWaveZSeTocFuFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpWaveSeTocFuFd(1,:,:,gt1) 
AmpVertexZSeTocFuFd(1,:,:,gt2)= AmpVertexZSeTocFuFd(1,:,:,gt2)+ZRUZDL(gt2,gt1)*AmpVertexSeTocFuFd(1,:,:,gt1) 
AmpWaveZSeTocFuFd(2,:,:,gt2) = AmpWaveZSeTocFuFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpWaveSeTocFuFd(2,:,:,gt1) 
AmpVertexZSeTocFuFd(2,:,:,gt2)= AmpVertexZSeTocFuFd(2,:,:,gt2)+ZRUZDR(gt2,gt1)*AmpVertexSeTocFuFd(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSeTocFuFd=AmpWaveZSeTocFuFd 
AmpVertexSeTocFuFd= AmpVertexZSeTocFuFd
End if
If (ShiftIRdiv) Then 
AmpVertexSeTocFuFd = AmpVertexSeTocFuFd  +  AmpVertexIRosSeTocFuFd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->bar[Fu] Fd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeTocFuFd = AmpTreeSeTocFuFd 
 AmpSum2SeTocFuFd = AmpTreeSeTocFuFd + 2._dp*AmpWaveSeTocFuFd + 2._dp*AmpVertexSeTocFuFd  
Else 
 AmpSumSeTocFuFd = AmpTreeSeTocFuFd + AmpWaveSeTocFuFd + AmpVertexSeTocFuFd
 AmpSum2SeTocFuFd = AmpTreeSeTocFuFd + AmpWaveSeTocFuFd + AmpVertexSeTocFuFd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeTocFuFd = AmpTreeSeTocFuFd
 AmpSum2SeTocFuFd = AmpTreeSeTocFuFd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSeOS(gt1).gt.(MFuOS(gt2)+MFdOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MFu(gt2)+MFd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeTocFuFd = AmpTreeSeTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFu(gt2),MFd(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeTocFuFd(gt1, gt2, gt3) 
  AmpSum2SeTocFuFd = 2._dp*AmpWaveSeTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFu(gt2),MFd(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeTocFuFd(gt1, gt2, gt3) 
  AmpSum2SeTocFuFd = 2._dp*AmpVertexSeTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFu(gt2),MFd(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeTocFuFd(gt1, gt2, gt3) 
  AmpSum2SeTocFuFd = AmpTreeSeTocFuFd + 2._dp*AmpWaveSeTocFuFd + 2._dp*AmpVertexSeTocFuFd
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MFu(gt2),MFd(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeTocFuFd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeTocFuFd = AmpTreeSeTocFuFd
  Call SquareAmp_StoFF(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
  AmpSqTreeSeTocFuFd(gt1, gt2, gt3) = (3)*AmpSqSeTocFuFd(gt1, gt2, gt3)  
  AmpSum2SeTocFuFd = + 2._dp*AmpWaveSeTocFuFd + 2._dp*AmpVertexSeTocFuFd
  Call SquareAmp_StoFF(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
  AmpSqSeTocFuFd(gt1, gt2, gt3) = AmpSqSeTocFuFd(gt1, gt2, gt3) + AmpSqTreeSeTocFuFd(gt1, gt2, gt3)  
Else  
  AmpSum2SeTocFuFd = AmpTreeSeTocFuFd
  Call SquareAmp_StoFF(MSe(gt1),MFu(gt2),MFd(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
  AmpSqTreeSeTocFuFd(gt1, gt2, gt3) = (3)*AmpSqSeTocFuFd(gt1, gt2, gt3)  
  AmpSum2SeTocFuFd = + 2._dp*AmpWaveSeTocFuFd + 2._dp*AmpVertexSeTocFuFd
  Call SquareAmp_StoFF(MSe(gt1),MFu(gt2),MFd(gt3),AmpSumSeTocFuFd(:,gt1, gt2, gt3),AmpSum2SeTocFuFd(:,gt1, gt2, gt3),AmpSqSeTocFuFd(gt1, gt2, gt3)) 
  AmpSqSeTocFuFd(gt1, gt2, gt3) = AmpSqSeTocFuFd(gt1, gt2, gt3) + AmpSqTreeSeTocFuFd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeTocFuFd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSeTocFuFd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MFuOS(gt2),MFdOS(gt3),helfactor*AmpSqSeTocFuFd(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MFu(gt2),MFd(gt3),helfactor*AmpSqSeTocFuFd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTocFuFd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeTocFuFd(gt1, gt2, gt3) + MRGSeTocFuFd(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeTocFuFd(gt1, gt2, gt3) + MRGSeTocFuFd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Fv Fe
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToFvFe(cplFvFecSeL,cplFvFecSeR,MFe,MSe,              & 
& MFe2,MSe2,AmpTreeSeToFvFe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToFvFe(ZcplFvFecSeL,ZcplFvFecSeR,MFe,MSe,            & 
& MFe2,MSe2,AmpTreeSeToFvFe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFvFe(MLambda,em,gs,cplFvFecSeL,cplFvFecSeR,            & 
& MFeOS,MSeOS,MRPSeToFvFe,MRGSeToFvFe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFvFe(MLambda,em,gs,ZcplFvFecSeL,ZcplFvFecSeR,          & 
& MFeOS,MSeOS,MRPSeToFvFe,MRGSeToFvFe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToFvFe(MLambda,em,gs,cplFvFecSeL,cplFvFecSeR,            & 
& MFe,MSe,MRPSeToFvFe,MRGSeToFvFe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToFvFe(MLambda,em,gs,ZcplFvFecSeL,ZcplFvFecSeR,          & 
& MFe,MSe,MRPSeToFvFe,MRGSeToFvFe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToFvFe(cplFvFecSeL,cplFvFecSeR,ctcplFvFecSeL,        & 
& ctcplFvFecSeR,MFe,MFe2,MSe,MSe2,ZfFEL,ZfFER,ZfFvL,ZfSe,AmpWaveSeToFvFe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,cplFvChacSeL,   & 
& cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,            & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,              & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexSeToFvFe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,          & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,              & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRdrSeToFvFe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,cplFvChacSeL,            & 
& cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,            & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,ZcplFvFecSeL,ZcplFvFecSeR,cplFvFecVWmL,          & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,              & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvFe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,          & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,ZcplFvFecSeL,ZcplFvFecSeR,           & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,              & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvFe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,cplFvChacSeL,            & 
& cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,            & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,              & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvFe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,          & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,              & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,AmpVertexIRosSeToFvFe)

 End if 
 End if 
AmpVertexSeToFvFe = AmpVertexSeToFvFe -  AmpVertexIRdrSeToFvFe! +  AmpVertexIRosSeToFvFe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToFvFe=0._dp 
AmpVertexZSeToFvFe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToFvFe(:,gt2,:,:) = AmpWaveZSeToFvFe(:,gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToFvFe(:,gt1,:,:) 
AmpVertexZSeToFvFe(:,gt2,:,:)= AmpVertexZSeToFvFe(:,gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToFvFe(:,gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToFvFe=AmpWaveZSeToFvFe 
AmpVertexSeToFvFe= AmpVertexZSeToFvFe
! Final State 1 
AmpWaveZSeToFvFe=0._dp 
AmpVertexZSeToFvFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToFvFe(1,:,gt2,:) = AmpWaveZSeToFvFe(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpWaveSeToFvFe(1,:,gt1,:) 
AmpVertexZSeToFvFe(1,:,gt2,:)= AmpVertexZSeToFvFe(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpVertexSeToFvFe(1,:,gt1,:) 
AmpWaveZSeToFvFe(2,:,gt2,:) = AmpWaveZSeToFvFe(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpWaveSeToFvFe(2,:,gt1,:) 
AmpVertexZSeToFvFe(2,:,gt2,:)= AmpVertexZSeToFvFe(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpVertexSeToFvFe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToFvFe=AmpWaveZSeToFvFe 
AmpVertexSeToFvFe= AmpVertexZSeToFvFe
! Final State 2 
AmpWaveZSeToFvFe=0._dp 
AmpVertexZSeToFvFe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToFvFe(1,:,:,gt2) = AmpWaveZSeToFvFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpWaveSeToFvFe(1,:,:,gt1) 
AmpVertexZSeToFvFe(1,:,:,gt2)= AmpVertexZSeToFvFe(1,:,:,gt2)+ZRUZEL(gt2,gt1)*AmpVertexSeToFvFe(1,:,:,gt1) 
AmpWaveZSeToFvFe(2,:,:,gt2) = AmpWaveZSeToFvFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpWaveSeToFvFe(2,:,:,gt1) 
AmpVertexZSeToFvFe(2,:,:,gt2)= AmpVertexZSeToFvFe(2,:,:,gt2)+ZRUZER(gt2,gt1)*AmpVertexSeToFvFe(2,:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToFvFe=AmpWaveZSeToFvFe 
AmpVertexSeToFvFe= AmpVertexZSeToFvFe
End if
If (ShiftIRdiv) Then 
AmpVertexSeToFvFe = AmpVertexSeToFvFe  +  AmpVertexIRosSeToFvFe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Fv Fe -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToFvFe = AmpTreeSeToFvFe 
 AmpSum2SeToFvFe = AmpTreeSeToFvFe + 2._dp*AmpWaveSeToFvFe + 2._dp*AmpVertexSeToFvFe  
Else 
 AmpSumSeToFvFe = AmpTreeSeToFvFe + AmpWaveSeToFvFe + AmpVertexSeToFvFe
 AmpSum2SeToFvFe = AmpTreeSeToFvFe + AmpWaveSeToFvFe + AmpVertexSeToFvFe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToFvFe = AmpTreeSeToFvFe
 AmpSum2SeToFvFe = AmpTreeSeToFvFe 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MSeOS(gt1).gt.(0.+MFeOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(0.+MFe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToFvFe = AmpTreeSeToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MFeOS(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MFe(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToFvFe(gt1, gt2, gt3) 
  AmpSum2SeToFvFe = 2._dp*AmpWaveSeToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MFeOS(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MFe(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToFvFe(gt1, gt2, gt3) 
  AmpSum2SeToFvFe = 2._dp*AmpVertexSeToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MFeOS(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MFe(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToFvFe(gt1, gt2, gt3) 
  AmpSum2SeToFvFe = AmpTreeSeToFvFe + 2._dp*AmpWaveSeToFvFe + 2._dp*AmpVertexSeToFvFe
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MFeOS(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MFe(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToFvFe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToFvFe = AmpTreeSeToFvFe
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MFeOS(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
  AmpSqTreeSeToFvFe(gt1, gt2, gt3) = (1)*AmpSqSeToFvFe(gt1, gt2, gt3)  
  AmpSum2SeToFvFe = + 2._dp*AmpWaveSeToFvFe + 2._dp*AmpVertexSeToFvFe
  Call SquareAmp_StoFF(MSeOS(gt1),0._dp,MFeOS(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
  AmpSqSeToFvFe(gt1, gt2, gt3) = AmpSqSeToFvFe(gt1, gt2, gt3) + AmpSqTreeSeToFvFe(gt1, gt2, gt3)  
Else  
  AmpSum2SeToFvFe = AmpTreeSeToFvFe
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MFe(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
  AmpSqTreeSeToFvFe(gt1, gt2, gt3) = (1)*AmpSqSeToFvFe(gt1, gt2, gt3)  
  AmpSum2SeToFvFe = + 2._dp*AmpWaveSeToFvFe + 2._dp*AmpVertexSeToFvFe
  Call SquareAmp_StoFF(MSe(gt1),0._dp,MFe(gt3),AmpSumSeToFvFe(:,gt1, gt2, gt3),AmpSum2SeToFvFe(:,gt1, gt2, gt3),AmpSqSeToFvFe(gt1, gt2, gt3)) 
  AmpSqSeToFvFe(gt1, gt2, gt3) = AmpSqSeToFvFe(gt1, gt2, gt3) + AmpSqTreeSeToFvFe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToFvFe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSeToFvFe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),0._dp,MFeOS(gt3),helfactor*AmpSqSeToFvFe(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),0._dp,MFe(gt3),helfactor*AmpSqSeToFvFe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToFvFe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToFvFe(gt1, gt2, gt3) + MRGSeToFvFe(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToFvFe(gt1, gt2, gt3) + MRGSeToFvFe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Se hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToSehh(cplhhSecSe,Mhh,MSe,Mhh2,MSe2,AmpTreeSeToSehh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToSehh(ZcplhhSecSe,Mhh,MSe,Mhh2,MSe2,AmpTreeSeToSehh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSehh(MLambda,em,gs,cplhhSecSe,MhhOS,MSeOS,             & 
& MRPSeToSehh,MRGSeToSehh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSehh(MLambda,em,gs,ZcplhhSecSe,MhhOS,MSeOS,            & 
& MRPSeToSehh,MRGSeToSehh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToSehh(MLambda,em,gs,cplhhSecSe,Mhh,MSe,MRPSeToSehh,     & 
& MRGSeToSehh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSehh(MLambda,em,gs,ZcplhhSecSe,Mhh,MSe,MRPSeToSehh,    & 
& MRGSeToSehh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSehh(cplhhSecSe,ctcplhhSecSe,Mhh,Mhh2,             & 
& MSe,MSe2,Zfhh,ZfSe,AmpWaveSeToSehh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSehh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
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
& AmpVertexSeToSehh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexIRdrSeToSehh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& AmpVertexIRosSeToSehh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexIRosSeToSehh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh(MAhOS,MChaOS,MChiOS,MFdOS,               & 
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
& AmpVertexIRosSeToSehh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh(MAh,MCha,MChi,MFd,MFe,MFu,               & 
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
& AmpVertexIRosSeToSehh)

 End if 
 End if 
AmpVertexSeToSehh = AmpVertexSeToSehh -  AmpVertexIRdrSeToSehh! +  AmpVertexIRosSeToSehh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToSehh=0._dp 
AmpVertexZSeToSehh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSehh(gt2,:,:) = AmpWaveZSeToSehh(gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToSehh(gt1,:,:) 
AmpVertexZSeToSehh(gt2,:,:)= AmpVertexZSeToSehh(gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToSehh(gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToSehh=AmpWaveZSeToSehh 
AmpVertexSeToSehh= AmpVertexZSeToSehh
! Final State 1 
AmpWaveZSeToSehh=0._dp 
AmpVertexZSeToSehh=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSehh(:,gt2,:) = AmpWaveZSeToSehh(:,gt2,:)+ZRUZE(gt2,gt1)*AmpWaveSeToSehh(:,gt1,:) 
AmpVertexZSeToSehh(:,gt2,:)= AmpVertexZSeToSehh(:,gt2,:)+ZRUZE(gt2,gt1)*AmpVertexSeToSehh(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToSehh=AmpWaveZSeToSehh 
AmpVertexSeToSehh= AmpVertexZSeToSehh
! Final State 2 
AmpWaveZSeToSehh=0._dp 
AmpVertexZSeToSehh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSeToSehh(:,:,gt2) = AmpWaveZSeToSehh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveSeToSehh(:,:,gt1) 
AmpVertexZSeToSehh(:,:,gt2)= AmpVertexZSeToSehh(:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexSeToSehh(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToSehh=AmpWaveZSeToSehh 
AmpVertexSeToSehh= AmpVertexZSeToSehh
End if
If (ShiftIRdiv) Then 
AmpVertexSeToSehh = AmpVertexSeToSehh  +  AmpVertexIRosSeToSehh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Se hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToSehh = AmpTreeSeToSehh 
 AmpSum2SeToSehh = AmpTreeSeToSehh + 2._dp*AmpWaveSeToSehh + 2._dp*AmpVertexSeToSehh  
Else 
 AmpSumSeToSehh = AmpTreeSeToSehh + AmpWaveSeToSehh + AmpVertexSeToSehh
 AmpSum2SeToSehh = AmpTreeSeToSehh + AmpWaveSeToSehh + AmpVertexSeToSehh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSehh = AmpTreeSeToSehh
 AmpSum2SeToSehh = AmpTreeSeToSehh 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSeOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSe(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToSehh = AmpTreeSeToSehh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),Mhh(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToSehh(gt1, gt2, gt3) 
  AmpSum2SeToSehh = 2._dp*AmpWaveSeToSehh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),Mhh(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToSehh(gt1, gt2, gt3) 
  AmpSum2SeToSehh = 2._dp*AmpVertexSeToSehh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),Mhh(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToSehh(gt1, gt2, gt3) 
  AmpSum2SeToSehh = AmpTreeSeToSehh + 2._dp*AmpWaveSeToSehh + 2._dp*AmpVertexSeToSehh
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),Mhh(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToSehh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToSehh = AmpTreeSeToSehh
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
  AmpSqTreeSeToSehh(gt1, gt2, gt3) = (1)*AmpSqSeToSehh(gt1, gt2, gt3)  
  AmpSum2SeToSehh = + 2._dp*AmpWaveSeToSehh + 2._dp*AmpVertexSeToSehh
  Call SquareAmp_StoSS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
  AmpSqSeToSehh(gt1, gt2, gt3) = AmpSqSeToSehh(gt1, gt2, gt3) + AmpSqTreeSeToSehh(gt1, gt2, gt3)  
Else  
  AmpSum2SeToSehh = AmpTreeSeToSehh
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),Mhh(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
  AmpSqTreeSeToSehh(gt1, gt2, gt3) = (1)*AmpSqSeToSehh(gt1, gt2, gt3)  
  AmpSum2SeToSehh = + 2._dp*AmpWaveSeToSehh + 2._dp*AmpVertexSeToSehh
  Call SquareAmp_StoSS(MSe(gt1),MSe(gt2),Mhh(gt3),AmpSumSeToSehh(gt1, gt2, gt3),AmpSum2SeToSehh(gt1, gt2, gt3),AmpSqSeToSehh(gt1, gt2, gt3)) 
  AmpSqSeToSehh(gt1, gt2, gt3) = AmpSqSeToSehh(gt1, gt2, gt3) + AmpSqTreeSeToSehh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToSehh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSehh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSeOS(gt2),MhhOS(gt3),helfactor*AmpSqSeToSehh(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSe(gt2),Mhh(gt3),helfactor*AmpSqSeToSehh(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToSehh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSehh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToSehh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSehh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSehh(gt1, gt2, gt3) + MRGSeToSehh(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSehh(gt1, gt2, gt3) + MRGSeToSehh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Sv Hpm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToSvHpm(cplHpmSvcSe,MHpm,MSe,MSv,MHpm2,              & 
& MSe2,MSv2,AmpTreeSeToSvHpm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToSvHpm(ZcplHpmSvcSe,MHpm,MSe,MSv,MHpm2,             & 
& MSe2,MSv2,AmpTreeSeToSvHpm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvHpm(MLambda,em,gs,cplHpmSvcSe,MHpmOS,MSeOS,          & 
& MSvOS,MRPSeToSvHpm,MRGSeToSvHpm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvHpm(MLambda,em,gs,ZcplHpmSvcSe,MHpmOS,               & 
& MSeOS,MSvOS,MRPSeToSvHpm,MRGSeToSvHpm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToSvHpm(MLambda,em,gs,cplHpmSvcSe,MHpm,MSe,              & 
& MSv,MRPSeToSvHpm,MRGSeToSvHpm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvHpm(MLambda,em,gs,ZcplHpmSvcSe,MHpm,MSe,             & 
& MSv,MRPSeToSvHpm,MRGSeToSvHpm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSvHpm(cplHpmSvcSe,ctcplHpmSvcSe,MHpm,              & 
& MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,ZfSe,ZfSv,AmpWaveSeToSvHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSvHpm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSecSe,              & 
& cplFvChacSeL,cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,cplcFdFdSvR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,cplhhHpmcVWm,         & 
& cplhhSecSe,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,               & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,     & 
& cplSecSecSv,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,     & 
& cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,     & 
& cplSdSvcSecSuaa,cplSeSvcSecSv1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,AmpVertexSeToSvHpm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSecSe,        & 
& cplFvChacSeL,cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,cplcFdFdSvR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,cplhhHpmcVWm,         & 
& cplhhSecSe,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,               & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,     & 
& cplSecSecSv,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,     & 
& cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,     & 
& cplSdSvcSecSuaa,cplSeSvcSecSv1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,AmpVertexIRdrSeToSvHpm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSecSe,cplFvChacSeL,          & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,             & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSecSe,           & 
& cplhhSvcSv,cplHpmSucSd,ZcplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,            & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,      & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,cplHpmSecHpmcSe1,& 
& cplHpmSecSecSe1,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,cplSdSvcSecSuaa,      & 
& cplSeSvcSecSv1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,AmpVertexIRosSeToSvHpm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSecSe,        & 
& cplFvChacSeL,cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,cplcFdFdSvR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,cplhhHpmcVWm,         & 
& cplhhSecSe,cplhhSvcSv,cplHpmSucSd,ZcplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,              & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,     & 
& cplSecSecSv,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,     & 
& cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,     & 
& cplSdSvcSecSuaa,cplSeSvcSecSv1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,AmpVertexIRosSeToSvHpm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSecSe,cplFvChacSeL,          & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,             & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSecSe,           & 
& cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,             & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,      & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,cplHpmSecHpmcSe1,& 
& cplHpmSecSecSe1,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,cplSdSvcSecSuaa,      & 
& cplSeSvcSecSv1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,AmpVertexIRosSeToSvHpm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSecSe,        & 
& cplFvChacSeL,cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,cplcFdFdSvR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,cplhhHpmcVWm,         & 
& cplhhSecSe,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,               & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,     & 
& cplSecSecSv,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,     & 
& cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSuSvcSdaa,cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,     & 
& cplSdSvcSecSuaa,cplSeSvcSecSv1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,AmpVertexIRosSeToSvHpm)

 End if 
 End if 
AmpVertexSeToSvHpm = AmpVertexSeToSvHpm -  AmpVertexIRdrSeToSvHpm! +  AmpVertexIRosSeToSvHpm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToSvHpm=0._dp 
AmpVertexZSeToSvHpm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSvHpm(gt2,:,:) = AmpWaveZSeToSvHpm(gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToSvHpm(gt1,:,:) 
AmpVertexZSeToSvHpm(gt2,:,:)= AmpVertexZSeToSvHpm(gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToSvHpm(gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToSvHpm=AmpWaveZSeToSvHpm 
AmpVertexSeToSvHpm= AmpVertexZSeToSvHpm
! Final State 1 
AmpWaveZSeToSvHpm=0._dp 
AmpVertexZSeToSvHpm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToSvHpm(:,gt2,:) = AmpWaveZSeToSvHpm(:,gt2,:)+ZRUZV(gt2,gt1)*AmpWaveSeToSvHpm(:,gt1,:) 
AmpVertexZSeToSvHpm(:,gt2,:)= AmpVertexZSeToSvHpm(:,gt2,:)+ZRUZV(gt2,gt1)*AmpVertexSeToSvHpm(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToSvHpm=AmpWaveZSeToSvHpm 
AmpVertexSeToSvHpm= AmpVertexZSeToSvHpm
! Final State 2 
AmpWaveZSeToSvHpm=0._dp 
AmpVertexZSeToSvHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZSeToSvHpm(:,:,gt2) = AmpWaveZSeToSvHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveSeToSvHpm(:,:,gt1) 
AmpVertexZSeToSvHpm(:,:,gt2)= AmpVertexZSeToSvHpm(:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexSeToSvHpm(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToSvHpm=AmpWaveZSeToSvHpm 
AmpVertexSeToSvHpm= AmpVertexZSeToSvHpm
End if
If (ShiftIRdiv) Then 
AmpVertexSeToSvHpm = AmpVertexSeToSvHpm  +  AmpVertexIRosSeToSvHpm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Sv Hpm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToSvHpm = AmpTreeSeToSvHpm 
 AmpSum2SeToSvHpm = AmpTreeSeToSvHpm + 2._dp*AmpWaveSeToSvHpm + 2._dp*AmpVertexSeToSvHpm  
Else 
 AmpSumSeToSvHpm = AmpTreeSeToSvHpm + AmpWaveSeToSvHpm + AmpVertexSeToSvHpm
 AmpSum2SeToSvHpm = AmpTreeSeToSvHpm + AmpWaveSeToSvHpm + AmpVertexSeToSvHpm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSvHpm = AmpTreeSeToSvHpm
 AmpSum2SeToSvHpm = AmpTreeSeToSvHpm 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSvOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSv(gt2)+MHpm(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToSvHpm = AmpTreeSeToSvHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MHpm(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToSvHpm(gt1, gt2, gt3) 
  AmpSum2SeToSvHpm = 2._dp*AmpWaveSeToSvHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MHpm(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToSvHpm(gt1, gt2, gt3) 
  AmpSum2SeToSvHpm = 2._dp*AmpVertexSeToSvHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MHpm(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToSvHpm(gt1, gt2, gt3) 
  AmpSum2SeToSvHpm = AmpTreeSeToSvHpm + 2._dp*AmpWaveSeToSvHpm + 2._dp*AmpVertexSeToSvHpm
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MHpm(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToSvHpm(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToSvHpm = AmpTreeSeToSvHpm
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
  AmpSqTreeSeToSvHpm(gt1, gt2, gt3) = (1)*AmpSqSeToSvHpm(gt1, gt2, gt3)  
  AmpSum2SeToSvHpm = + 2._dp*AmpWaveSeToSvHpm + 2._dp*AmpVertexSeToSvHpm
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
  AmpSqSeToSvHpm(gt1, gt2, gt3) = AmpSqSeToSvHpm(gt1, gt2, gt3) + AmpSqTreeSeToSvHpm(gt1, gt2, gt3)  
Else  
  AmpSum2SeToSvHpm = AmpTreeSeToSvHpm
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MHpm(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
  AmpSqTreeSeToSvHpm(gt1, gt2, gt3) = (1)*AmpSqSeToSvHpm(gt1, gt2, gt3)  
  AmpSum2SeToSvHpm = + 2._dp*AmpWaveSeToSvHpm + 2._dp*AmpVertexSeToSvHpm
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MHpm(gt3),AmpSumSeToSvHpm(gt1, gt2, gt3),AmpSum2SeToSvHpm(gt1, gt2, gt3),AmpSqSeToSvHpm(gt1, gt2, gt3)) 
  AmpSqSeToSvHpm(gt1, gt2, gt3) = AmpSqSeToSvHpm(gt1, gt2, gt3) + AmpSqTreeSeToSvHpm(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToSvHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSvHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSvOS(gt2),MHpmOS(gt3),helfactor*AmpSqSeToSvHpm(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSv(gt2),MHpm(gt3),helfactor*AmpSqSeToSvHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToSvHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSvHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToSvHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSvHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSvHpm(gt1, gt2, gt3) + MRGSeToSvHpm(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSvHpm(gt1, gt2, gt3) + MRGSeToSvHpm(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Conjg(Su) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeTocSuSd(cplSdcSecSu,MSd,MSe,MSu,MSd2,MSe2,           & 
& MSu2,AmpTreeSeTocSuSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeTocSuSd(ZcplSdcSecSu,MSd,MSe,MSu,MSd2,               & 
& MSe2,MSu2,AmpTreeSeTocSuSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocSuSd(MLambda,em,gs,cplSdcSecSu,MSdOS,MSeOS,           & 
& MSuOS,MRPSeTocSuSd,MRGSeTocSuSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocSuSd(MLambda,em,gs,ZcplSdcSecSu,MSdOS,MSeOS,          & 
& MSuOS,MRPSeTocSuSd,MRGSeTocSuSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeTocSuSd(MLambda,em,gs,cplSdcSecSu,MSd,MSe,               & 
& MSu,MRPSeTocSuSd,MRGSeTocSuSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocSuSd(MLambda,em,gs,ZcplSdcSecSu,MSd,MSe,              & 
& MSu,MRPSeTocSuSd,MRGSeTocSuSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeTocSuSd(cplSdcSecSu,ctcplSdcSecSu,MSd,               & 
& MSd2,MSe,MSe2,MSu,MSu2,ZfSd,ZfSe,ZfSu,AmpWaveSeTocSuSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,            & 
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
& cplSeSucSecSuaa,AmpVertexSeTocSuSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,AmpVertexIRdrSeTocSuSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& AmpVertexIRosSeTocSuSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,AmpVertexIRosSeTocSuSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd(MAhOS,MChaOS,MChiOS,MFdOS,              & 
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
& AmpVertexIRosSeTocSuSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd(MAh,MCha,MChi,MFd,MFe,MFu,              & 
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
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,AmpVertexIRosSeTocSuSd)

 End if 
 End if 
AmpVertexSeTocSuSd = AmpVertexSeTocSuSd -  AmpVertexIRdrSeTocSuSd! +  AmpVertexIRosSeTocSuSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeTocSuSd=0._dp 
AmpVertexZSeTocSuSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeTocSuSd(gt2,:,:) = AmpWaveZSeTocSuSd(gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeTocSuSd(gt1,:,:) 
AmpVertexZSeTocSuSd(gt2,:,:)= AmpVertexZSeTocSuSd(gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeTocSuSd(gt1,:,:) 
 End Do 
End Do 
AmpWaveSeTocSuSd=AmpWaveZSeTocSuSd 
AmpVertexSeTocSuSd= AmpVertexZSeTocSuSd
! Final State 1 
AmpWaveZSeTocSuSd=0._dp 
AmpVertexZSeTocSuSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeTocSuSd(:,gt2,:) = AmpWaveZSeTocSuSd(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpWaveSeTocSuSd(:,gt1,:) 
AmpVertexZSeTocSuSd(:,gt2,:)= AmpVertexZSeTocSuSd(:,gt2,:)+ZRUZUc(gt2,gt1)*AmpVertexSeTocSuSd(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeTocSuSd=AmpWaveZSeTocSuSd 
AmpVertexSeTocSuSd= AmpVertexZSeTocSuSd
! Final State 2 
AmpWaveZSeTocSuSd=0._dp 
AmpVertexZSeTocSuSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeTocSuSd(:,:,gt2) = AmpWaveZSeTocSuSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveSeTocSuSd(:,:,gt1) 
AmpVertexZSeTocSuSd(:,:,gt2)= AmpVertexZSeTocSuSd(:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexSeTocSuSd(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeTocSuSd=AmpWaveZSeTocSuSd 
AmpVertexSeTocSuSd= AmpVertexZSeTocSuSd
End if
If (ShiftIRdiv) Then 
AmpVertexSeTocSuSd = AmpVertexSeTocSuSd  +  AmpVertexIRosSeTocSuSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->conj[Su] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeTocSuSd = AmpTreeSeTocSuSd 
 AmpSum2SeTocSuSd = AmpTreeSeTocSuSd + 2._dp*AmpWaveSeTocSuSd + 2._dp*AmpVertexSeTocSuSd  
Else 
 AmpSumSeTocSuSd = AmpTreeSeTocSuSd + AmpWaveSeTocSuSd + AmpVertexSeTocSuSd
 AmpSum2SeTocSuSd = AmpTreeSeTocSuSd + AmpWaveSeTocSuSd + AmpVertexSeTocSuSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeTocSuSd = AmpTreeSeTocSuSd
 AmpSum2SeTocSuSd = AmpTreeSeTocSuSd 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
    Do gt3=1,6
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSuOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSu(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeTocSuSd = AmpTreeSeTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSu(gt2),MSd(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeTocSuSd(gt1, gt2, gt3) 
  AmpSum2SeTocSuSd = 2._dp*AmpWaveSeTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSu(gt2),MSd(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeTocSuSd(gt1, gt2, gt3) 
  AmpSum2SeTocSuSd = 2._dp*AmpVertexSeTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSu(gt2),MSd(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeTocSuSd(gt1, gt2, gt3) 
  AmpSum2SeTocSuSd = AmpTreeSeTocSuSd + 2._dp*AmpWaveSeTocSuSd + 2._dp*AmpVertexSeTocSuSd
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSu(gt2),MSd(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeTocSuSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeTocSuSd = AmpTreeSeTocSuSd
  Call SquareAmp_StoSS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
  AmpSqTreeSeTocSuSd(gt1, gt2, gt3) = (3)*AmpSqSeTocSuSd(gt1, gt2, gt3)  
  AmpSum2SeTocSuSd = + 2._dp*AmpWaveSeTocSuSd + 2._dp*AmpVertexSeTocSuSd
  Call SquareAmp_StoSS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
  AmpSqSeTocSuSd(gt1, gt2, gt3) = AmpSqSeTocSuSd(gt1, gt2, gt3) + AmpSqTreeSeTocSuSd(gt1, gt2, gt3)  
Else  
  AmpSum2SeTocSuSd = AmpTreeSeTocSuSd
  Call SquareAmp_StoSS(MSe(gt1),MSu(gt2),MSd(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
  AmpSqTreeSeTocSuSd(gt1, gt2, gt3) = (3)*AmpSqSeTocSuSd(gt1, gt2, gt3)  
  AmpSum2SeTocSuSd = + 2._dp*AmpWaveSeTocSuSd + 2._dp*AmpVertexSeTocSuSd
  Call SquareAmp_StoSS(MSe(gt1),MSu(gt2),MSd(gt3),AmpSumSeTocSuSd(gt1, gt2, gt3),AmpSum2SeTocSuSd(gt1, gt2, gt3),AmpSqSeTocSuSd(gt1, gt2, gt3)) 
  AmpSqSeTocSuSd(gt1, gt2, gt3) = AmpSqSeTocSuSd(gt1, gt2, gt3) + AmpSqTreeSeTocSuSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeTocSuSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeTocSuSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSuOS(gt2),MSdOS(gt3),helfactor*AmpSqSeTocSuSd(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSu(gt2),MSd(gt3),helfactor*AmpSqSeTocSuSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTocSuSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeTocSuSd(gt1, gt2, gt3) + MRGSeTocSuSd(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeTocSuSd(gt1, gt2, gt3) + MRGSeTocSuSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Sv Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToSvSe(cplSeSvcSe,MSe,MSv,MSe2,MSv2,AmpTreeSeToSvSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToSvSe(ZcplSeSvcSe,MSe,MSv,MSe2,MSv2,AmpTreeSeToSvSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvSe(MLambda,em,gs,cplSeSvcSe,MSeOS,MSvOS,             & 
& MRPSeToSvSe,MRGSeToSvSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvSe(MLambda,em,gs,ZcplSeSvcSe,MSeOS,MSvOS,            & 
& MRPSeToSvSe,MRGSeToSvSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToSvSe(MLambda,em,gs,cplSeSvcSe,MSe,MSv,MRPSeToSvSe,     & 
& MRGSeToSvSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvSe(MLambda,em,gs,ZcplSeSvcSe,MSe,MSv,MRPSeToSvSe,    & 
& MRGSeToSvSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSvSe(cplSeSvcSe,ctcplSeSvcSe,MSe,MSe2,             & 
& MSv,MSv2,ZfSe,ZfSv,AmpWaveSeToSvSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSvSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,      & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexSeToSvSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,      & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexIRdrSeToSvSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,          & 
& cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,             & 
& cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSucSd,       & 
& ZcplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexIRosSeToSvSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,      & 
& cplSeSucSd,ZcplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,    & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexIRosSeToSvSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,          & 
& cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,             & 
& cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSucSd,       & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,    & 
& cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,cplSeSecHpmcSe1,& 
& cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexIRosSeToSvSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,      & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,AmpVertexIRosSeToSvSe)

 End if 
 End if 
AmpVertexSeToSvSe = AmpVertexSeToSvSe -  AmpVertexIRdrSeToSvSe! +  AmpVertexIRosSeToSvSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToSvSe=0._dp 
AmpVertexZSeToSvSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSvSe(gt2,:,:) = AmpWaveZSeToSvSe(gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToSvSe(gt1,:,:) 
AmpVertexZSeToSvSe(gt2,:,:)= AmpVertexZSeToSvSe(gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToSvSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveSeToSvSe=AmpWaveZSeToSvSe 
AmpVertexSeToSvSe= AmpVertexZSeToSvSe
! Final State 1 
AmpWaveZSeToSvSe=0._dp 
AmpVertexZSeToSvSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToSvSe(:,gt2,:) = AmpWaveZSeToSvSe(:,gt2,:)+ZRUZV(gt2,gt1)*AmpWaveSeToSvSe(:,gt1,:) 
AmpVertexZSeToSvSe(:,gt2,:)= AmpVertexZSeToSvSe(:,gt2,:)+ZRUZV(gt2,gt1)*AmpVertexSeToSvSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToSvSe=AmpWaveZSeToSvSe 
AmpVertexSeToSvSe= AmpVertexZSeToSvSe
! Final State 2 
AmpWaveZSeToSvSe=0._dp 
AmpVertexZSeToSvSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSvSe(:,:,gt2) = AmpWaveZSeToSvSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSeToSvSe(:,:,gt1) 
AmpVertexZSeToSvSe(:,:,gt2)= AmpVertexZSeToSvSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSeToSvSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToSvSe=AmpWaveZSeToSvSe 
AmpVertexSeToSvSe= AmpVertexZSeToSvSe
End if
If (ShiftIRdiv) Then 
AmpVertexSeToSvSe = AmpVertexSeToSvSe  +  AmpVertexIRosSeToSvSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Sv Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToSvSe = AmpTreeSeToSvSe 
 AmpSum2SeToSvSe = AmpTreeSeToSvSe + 2._dp*AmpWaveSeToSvSe + 2._dp*AmpVertexSeToSvSe  
Else 
 AmpSumSeToSvSe = AmpTreeSeToSvSe + AmpWaveSeToSvSe + AmpVertexSeToSvSe
 AmpSum2SeToSvSe = AmpTreeSeToSvSe + AmpWaveSeToSvSe + AmpVertexSeToSvSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSvSe = AmpTreeSeToSvSe
 AmpSum2SeToSvSe = AmpTreeSeToSvSe 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSvOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSv(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeToSvSe = AmpTreeSeToSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToSvSe(gt1, gt2, gt3) 
  AmpSum2SeToSvSe = 2._dp*AmpWaveSeToSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToSvSe(gt1, gt2, gt3) 
  AmpSum2SeToSvSe = 2._dp*AmpVertexSeToSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToSvSe(gt1, gt2, gt3) 
  AmpSum2SeToSvSe = AmpTreeSeToSvSe + 2._dp*AmpWaveSeToSvSe + 2._dp*AmpVertexSeToSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToSvSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToSvSe = AmpTreeSeToSvSe
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
  AmpSqTreeSeToSvSe(gt1, gt2, gt3) = (1)*AmpSqSeToSvSe(gt1, gt2, gt3)  
  AmpSum2SeToSvSe = + 2._dp*AmpWaveSeToSvSe + 2._dp*AmpVertexSeToSvSe
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
  AmpSqSeToSvSe(gt1, gt2, gt3) = AmpSqSeToSvSe(gt1, gt2, gt3) + AmpSqTreeSeToSvSe(gt1, gt2, gt3)  
Else  
  AmpSum2SeToSvSe = AmpTreeSeToSvSe
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
  AmpSqTreeSeToSvSe(gt1, gt2, gt3) = (1)*AmpSqSeToSvSe(gt1, gt2, gt3)  
  AmpSum2SeToSvSe = + 2._dp*AmpWaveSeToSvSe + 2._dp*AmpVertexSeToSvSe
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeToSvSe(gt1, gt2, gt3),AmpSum2SeToSvSe(gt1, gt2, gt3),AmpSqSeToSvSe(gt1, gt2, gt3)) 
  AmpSqSeToSvSe(gt1, gt2, gt3) = AmpSqSeToSvSe(gt1, gt2, gt3) + AmpSqTreeSeToSvSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeToSvSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSvSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),helfactor*AmpSqSeToSvSe(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSv(gt2),MSe(gt3),helfactor*AmpSqSeToSvSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSvSe(gt1, gt2, gt3) + MRGSeToSvSe(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeToSvSe(gt1, gt2, gt3) + MRGSeToSvSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Se VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToSeVZ(cplSecSeVZ,MSe,MVZ,MSe2,MVZ2,AmpTreeSeToSeVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToSeVZ(ZcplSecSeVZ,MSe,MVZ,MSe2,MVZ2,AmpTreeSeToSeVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSeVZ(MLambda,em,gs,cplSecSeVZ,MSeOS,MVZOS,             & 
& MRPSeToSeVZ,MRGSeToSeVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSeVZ(MLambda,em,gs,ZcplSecSeVZ,MSeOS,MVZOS,            & 
& MRPSeToSeVZ,MRGSeToSeVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToSeVZ(MLambda,em,gs,cplSecSeVZ,MSe,MVZ,MRPSeToSeVZ,     & 
& MRGSeToSeVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSeVZ(MLambda,em,gs,ZcplSecSeVZ,MSe,MVZ,MRPSeToSeVZ,    & 
& MRGSeToSeVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSeVZ(cplSecSeVP,cplSecSeVZ,ctcplSecSeVP,           & 
& ctcplSecSeVZ,MSe,MSe2,MVP,MVP2,MVZ,MVZ2,ZfSe,ZfVPVZ,ZfVZ,AmpWaveSeToSeVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSeVZ(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,    & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,cplChiFecSeR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,cplcFdFuSeR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,               & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,               & 
& AmpVertexSeToSeVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,           & 
& cplFvChacSeR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,       & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,   & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,               & 
& AmpVertexIRdrSeToSeVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,             & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,cplChiFecSeR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,cplcFdFuSeR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,               & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,ZcplSecSeVZ,cplSecHpmcSv,      & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,               & 
& AmpVertexIRosSeToSeVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,           & 
& cplFvChacSeR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,       & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,   & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,ZcplSecSeVZ,cplSecHpmcSv,      & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,               & 
& AmpVertexIRosSeToSeVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ(MAhOS,MChaOS,MChiOS,MFdOS,               & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,             & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,cplChiFecSeR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,cplcFdFuSeR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,               & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,               & 
& AmpVertexIRosSeToSeVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,           & 
& cplFvChacSeR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,       & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,   & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,               & 
& AmpVertexIRosSeToSeVZ)

 End if 
 End if 
AmpVertexSeToSeVZ = AmpVertexSeToSeVZ -  AmpVertexIRdrSeToSeVZ! +  AmpVertexIRosSeToSeVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToSeVZ=0._dp 
AmpVertexZSeToSeVZ=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSeVZ(:,gt2,:) = AmpWaveZSeToSeVZ(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToSeVZ(:,gt1,:) 
AmpVertexZSeToSeVZ(:,gt2,:)= AmpVertexZSeToSeVZ(:,gt2,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToSeVZ(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToSeVZ=AmpWaveZSeToSeVZ 
AmpVertexSeToSeVZ= AmpVertexZSeToSeVZ
! Final State 1 
AmpWaveZSeToSeVZ=0._dp 
AmpVertexZSeToSeVZ=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSeVZ(:,:,gt2) = AmpWaveZSeToSeVZ(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSeToSeVZ(:,:,gt1) 
AmpVertexZSeToSeVZ(:,:,gt2)= AmpVertexZSeToSeVZ(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSeToSeVZ(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToSeVZ=AmpWaveZSeToSeVZ 
AmpVertexSeToSeVZ= AmpVertexZSeToSeVZ
End if
If (ShiftIRdiv) Then 
AmpVertexSeToSeVZ = AmpVertexSeToSeVZ  +  AmpVertexIRosSeToSeVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Se VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToSeVZ = AmpTreeSeToSeVZ 
 AmpSum2SeToSeVZ = AmpTreeSeToSeVZ + 2._dp*AmpWaveSeToSeVZ + 2._dp*AmpVertexSeToSeVZ  
Else 
 AmpSumSeToSeVZ = AmpTreeSeToSeVZ + AmpWaveSeToSeVZ + AmpVertexSeToSeVZ
 AmpSum2SeToSeVZ = AmpTreeSeToSeVZ + AmpWaveSeToSeVZ + AmpVertexSeToSeVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSeVZ = AmpTreeSeToSeVZ
 AmpSum2SeToSeVZ = AmpTreeSeToSeVZ 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSeOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSe(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SeToSeVZ = AmpTreeSeToSeVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),MVZOS,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVZ,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToSeVZ(gt1, gt2) 
  AmpSum2SeToSeVZ = 2._dp*AmpWaveSeToSeVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),MVZOS,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVZ,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToSeVZ(gt1, gt2) 
  AmpSum2SeToSeVZ = 2._dp*AmpVertexSeToSeVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),MVZOS,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVZ,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToSeVZ(gt1, gt2) 
  AmpSum2SeToSeVZ = AmpTreeSeToSeVZ + 2._dp*AmpWaveSeToSeVZ + 2._dp*AmpVertexSeToSeVZ
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),MVZOS,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVZ,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToSeVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToSeVZ = AmpTreeSeToSeVZ
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),MVZOS,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
  AmpSqTreeSeToSeVZ(gt1, gt2) = (1)*AmpSqSeToSeVZ(gt1, gt2)  
  AmpSum2SeToSeVZ = + 2._dp*AmpWaveSeToSeVZ + 2._dp*AmpVertexSeToSeVZ
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),MVZOS,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
  AmpSqSeToSeVZ(gt1, gt2) = AmpSqSeToSeVZ(gt1, gt2) + AmpSqTreeSeToSeVZ(gt1, gt2)  
Else  
  AmpSum2SeToSeVZ = AmpTreeSeToSeVZ
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVZ,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
  AmpSqTreeSeToSeVZ(gt1, gt2) = (1)*AmpSqSeToSeVZ(gt1, gt2)  
  AmpSum2SeToSeVZ = + 2._dp*AmpWaveSeToSeVZ + 2._dp*AmpVertexSeToSeVZ
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVZ,AmpSumSeToSeVZ(:,gt1, gt2),AmpSum2SeToSeVZ(:,gt1, gt2),AmpSqSeToSeVZ(gt1, gt2)) 
  AmpSqSeToSeVZ(gt1, gt2) = AmpSqSeToSeVZ(gt1, gt2) + AmpSqTreeSeToSeVZ(gt1, gt2)  
End if  
Else  
  AmpSqSeToSeVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSeVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSeOS(gt2),MVZOS,helfactor*AmpSqSeToSeVZ(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSe(gt2),MVZ,helfactor*AmpSqSeToSeVZ(gt1, gt2))
End if 
If ((Abs(MRPSeToSeVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToSeVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToSeVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToSeVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSeToSeVZ(gt1, gt2) + MRGSeToSeVZ(gt1, gt2)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1*helfactor*(MRPSeToSeVZ(gt1, gt2) + MRGSeToSeVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Conjg(Sv) Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeTocSvSe(cplSecSecSv,MSe,MSv,MSe2,MSv2,               & 
& AmpTreeSeTocSvSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeTocSvSe(ZcplSecSecSv,MSe,MSv,MSe2,MSv2,              & 
& AmpTreeSeTocSvSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocSvSe(MLambda,em,gs,cplSecSecSv,MSeOS,MSvOS,           & 
& MRPSeTocSvSe,MRGSeTocSvSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocSvSe(MLambda,em,gs,ZcplSecSecSv,MSeOS,MSvOS,          & 
& MRPSeTocSvSe,MRGSeTocSvSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeTocSvSe(MLambda,em,gs,cplSecSecSv,MSe,MSv,               & 
& MRPSeTocSvSe,MRGSeTocSvSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeTocSvSe(MLambda,em,gs,ZcplSecSecSv,MSe,MSv,              & 
& MRPSeTocSvSe,MRGSeTocSvSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeTocSvSe(cplSecSecSv,ctcplSecSecSv,MSe,               & 
& MSe2,MSv,MSv2,ZfSe,ZfSv,AmpWaveSeTocSvSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexSeTocSvSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRdrSeTocSvSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,          & 
& cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,         & 
& cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,           & 
& cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,      & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,ZcplSecSecSv,cplSecSvcVWm,               & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSeTocSvSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,ZcplSecSecSv,cplSecSvcVWm,    & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSeTocSvSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,          & 
& cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,         & 
& cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,          & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,           & 
& cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,      & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,    & 
& cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,              & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSeTocSvSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,AmpVertexIRosSeTocSvSe)

 End if 
 End if 
AmpVertexSeTocSvSe = AmpVertexSeTocSvSe -  AmpVertexIRdrSeTocSvSe! +  AmpVertexIRosSeTocSvSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeTocSvSe=0._dp 
AmpVertexZSeTocSvSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeTocSvSe(gt2,:,:) = AmpWaveZSeTocSvSe(gt2,:,:)+ZRUZEc(gt2,gt1)*AmpWaveSeTocSvSe(gt1,:,:) 
AmpVertexZSeTocSvSe(gt2,:,:)= AmpVertexZSeTocSvSe(gt2,:,:) + ZRUZEc(gt2,gt1)*AmpVertexSeTocSvSe(gt1,:,:) 
 End Do 
End Do 
AmpWaveSeTocSvSe=AmpWaveZSeTocSvSe 
AmpVertexSeTocSvSe= AmpVertexZSeTocSvSe
! Final State 1 
AmpWaveZSeTocSvSe=0._dp 
AmpVertexZSeTocSvSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeTocSvSe(:,gt2,:) = AmpWaveZSeTocSvSe(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpWaveSeTocSvSe(:,gt1,:) 
AmpVertexZSeTocSvSe(:,gt2,:)= AmpVertexZSeTocSvSe(:,gt2,:)+ZRUZVc(gt2,gt1)*AmpVertexSeTocSvSe(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeTocSvSe=AmpWaveZSeTocSvSe 
AmpVertexSeTocSvSe= AmpVertexZSeTocSvSe
! Final State 2 
AmpWaveZSeTocSvSe=0._dp 
AmpVertexZSeTocSvSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeTocSvSe(:,:,gt2) = AmpWaveZSeTocSvSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveSeTocSvSe(:,:,gt1) 
AmpVertexZSeTocSvSe(:,:,gt2)= AmpVertexZSeTocSvSe(:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexSeTocSvSe(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeTocSvSe=AmpWaveZSeTocSvSe 
AmpVertexSeTocSvSe= AmpVertexZSeTocSvSe
End if
If (ShiftIRdiv) Then 
AmpVertexSeTocSvSe = AmpVertexSeTocSvSe  +  AmpVertexIRosSeTocSvSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->conj[Sv] Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeTocSvSe = AmpTreeSeTocSvSe 
 AmpSum2SeTocSvSe = AmpTreeSeTocSvSe + 2._dp*AmpWaveSeTocSvSe + 2._dp*AmpVertexSeTocSvSe  
Else 
 AmpSumSeTocSvSe = AmpTreeSeTocSvSe + AmpWaveSeTocSvSe + AmpVertexSeTocSvSe
 AmpSum2SeTocSvSe = AmpTreeSeTocSvSe + AmpWaveSeTocSvSe + AmpVertexSeTocSvSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeTocSvSe = AmpTreeSeTocSvSe
 AmpSum2SeTocSvSe = AmpTreeSeTocSvSe 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSvOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSv(gt2)+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2SeTocSvSe = AmpTreeSeTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeTocSvSe(gt1, gt2, gt3) 
  AmpSum2SeTocSvSe = 2._dp*AmpWaveSeTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeTocSvSe(gt1, gt2, gt3) 
  AmpSum2SeTocSvSe = 2._dp*AmpVertexSeTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeTocSvSe(gt1, gt2, gt3) 
  AmpSum2SeTocSvSe = AmpTreeSeTocSvSe + 2._dp*AmpWaveSeTocSvSe + 2._dp*AmpVertexSeTocSvSe
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeTocSvSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeTocSvSe = AmpTreeSeTocSvSe
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
  AmpSqTreeSeTocSvSe(gt1, gt2, gt3) = (1)*AmpSqSeTocSvSe(gt1, gt2, gt3)  
  AmpSum2SeTocSvSe = + 2._dp*AmpWaveSeTocSvSe + 2._dp*AmpVertexSeTocSvSe
  Call SquareAmp_StoSS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
  AmpSqSeTocSvSe(gt1, gt2, gt3) = AmpSqSeTocSvSe(gt1, gt2, gt3) + AmpSqTreeSeTocSvSe(gt1, gt2, gt3)  
Else  
  AmpSum2SeTocSvSe = AmpTreeSeTocSvSe
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
  AmpSqTreeSeTocSvSe(gt1, gt2, gt3) = (1)*AmpSqSeTocSvSe(gt1, gt2, gt3)  
  AmpSum2SeTocSvSe = + 2._dp*AmpWaveSeTocSvSe + 2._dp*AmpVertexSeTocSvSe
  Call SquareAmp_StoSS(MSe(gt1),MSv(gt2),MSe(gt3),AmpSumSeTocSvSe(gt1, gt2, gt3),AmpSum2SeTocSvSe(gt1, gt2, gt3),AmpSqSeTocSvSe(gt1, gt2, gt3)) 
  AmpSqSeTocSvSe(gt1, gt2, gt3) = AmpSqSeTocSvSe(gt1, gt2, gt3) + AmpSqTreeSeTocSvSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqSeTocSvSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeTocSvSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSvOS(gt2),MSeOS(gt3),helfactor*AmpSqSeTocSvSe(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSv(gt2),MSe(gt3),helfactor*AmpSqSeTocSvSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTocSvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPSeTocSvSe(gt1, gt2, gt3) + MRGSeTocSvSe(gt1, gt2, gt3)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPSeTocSvSe(gt1, gt2, gt3) + MRGSeTocSvSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
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
! Sv VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_SeToSvVWm(cplSvcSeVWm,MSe,MSv,MVWm,MSe2,               & 
& MSv2,MVWm2,AmpTreeSeToSvVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_SeToSvVWm(ZcplSvcSeVWm,MSe,MSv,MVWm,MSe2,              & 
& MSv2,MVWm2,AmpTreeSeToSvVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvVWm(MLambda,em,gs,cplSvcSeVWm,MSeOS,MSvOS,           & 
& MVWmOS,MRPSeToSvVWm,MRGSeToSvVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvVWm(MLambda,em,gs,ZcplSvcSeVWm,MSeOS,MSvOS,          & 
& MVWmOS,MRPSeToSvVWm,MRGSeToSvVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_SeToSvVWm(MLambda,em,gs,cplSvcSeVWm,MSe,MSv,               & 
& MVWm,MRPSeToSvVWm,MRGSeToSvVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_SeToSvVWm(MLambda,em,gs,ZcplSvcSeVWm,MSe,MSv,              & 
& MVWm,MRPSeToSvVWm,MRGSeToSvVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSvVWm(cplSvcSeVWm,ctcplSvcSeVWm,MSe,               & 
& MSe2,MSv,MSv2,MVWm,MVWm2,ZfSe,ZfSv,ZfVWm,AmpWaveSeToSvVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSvVWm(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,              & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,             & 
& cplhhcVWmVWm,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,cplcVWmVPVWm,              & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,              & 
& cplSvcSvcVWmVWm1,AmpVertexSeToSvVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,        & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,             & 
& cplhhcVWmVWm,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,cplcVWmVPVWm,              & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,              & 
& cplSvcSvcVWmVWm1,AmpVertexIRdrSeToSvVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,          & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,             & 
& GosZcplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,               & 
& cplSecSecSv,cplSucSdVWm,ZcplSvcSeVWm,cplSvcSvVZ,GosZcplcHpmVPVWm,cplcVWmVPVWm,         & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,              & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSeToSvVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,        & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,             & 
& cplhhcVWmVWm,GZcplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,               & 
& cplSecSeVZ,cplSecSecSv,cplSucSdVWm,ZcplSvcSeVWm,cplSvcSvVZ,GZcplcHpmVPVWm,             & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1, & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSeToSvVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,          & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,             & 
& GcplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,      & 
& cplSucSdVWm,cplSvcSeVWm,cplSvcSvVZ,GcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,            & 
& cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,cplSvcSvcVWmVWm1,          & 
& AmpVertexIRosSeToSvVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,        & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,             & 
& cplhhcVWmVWm,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,cplcVWmVPVWm,              & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,              & 
& cplSvcSvcVWmVWm1,AmpVertexIRosSeToSvVWm)

 End if 
 End if 
AmpVertexSeToSvVWm = AmpVertexSeToSvVWm -  AmpVertexIRdrSeToSvVWm! +  AmpVertexIRosSeToSvVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZSeToSvVWm=0._dp 
AmpVertexZSeToSvVWm=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZSeToSvVWm(:,gt2,:) = AmpWaveZSeToSvVWm(:,gt2,:)+ZRUZEc(gt2,gt1)*AmpWaveSeToSvVWm(:,gt1,:) 
AmpVertexZSeToSvVWm(:,gt2,:)= AmpVertexZSeToSvVWm(:,gt2,:) + ZRUZEc(gt2,gt1)*AmpVertexSeToSvVWm(:,gt1,:) 
 End Do 
End Do 
AmpWaveSeToSvVWm=AmpWaveZSeToSvVWm 
AmpVertexSeToSvVWm= AmpVertexZSeToSvVWm
! Final State 1 
AmpWaveZSeToSvVWm=0._dp 
AmpVertexZSeToSvVWm=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZSeToSvVWm(:,:,gt2) = AmpWaveZSeToSvVWm(:,:,gt2)+ZRUZV(gt2,gt1)*AmpWaveSeToSvVWm(:,:,gt1) 
AmpVertexZSeToSvVWm(:,:,gt2)= AmpVertexZSeToSvVWm(:,:,gt2)+ZRUZV(gt2,gt1)*AmpVertexSeToSvVWm(:,:,gt1) 
 End Do 
End Do 
AmpWaveSeToSvVWm=AmpWaveZSeToSvVWm 
AmpVertexSeToSvVWm= AmpVertexZSeToSvVWm
End if
If (ShiftIRdiv) Then 
AmpVertexSeToSvVWm = AmpVertexSeToSvVWm  +  AmpVertexIRosSeToSvVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Sv VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumSeToSvVWm = AmpTreeSeToSvVWm 
 AmpSum2SeToSvVWm = AmpTreeSeToSvVWm + 2._dp*AmpWaveSeToSvVWm + 2._dp*AmpVertexSeToSvVWm  
Else 
 AmpSumSeToSvVWm = AmpTreeSeToSvVWm + AmpWaveSeToSvVWm + AmpVertexSeToSvVWm
 AmpSum2SeToSvVWm = AmpTreeSeToSvVWm + AmpWaveSeToSvVWm + AmpVertexSeToSvVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSvVWm = AmpTreeSeToSvVWm
 AmpSum2SeToSvVWm = AmpTreeSeToSvVWm 
End if 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSvOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSv(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2SeToSvVWm = AmpTreeSeToSvVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqSeToSvVWm(gt1, gt2) 
  AmpSum2SeToSvVWm = 2._dp*AmpWaveSeToSvVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqSeToSvVWm(gt1, gt2) 
  AmpSum2SeToSvVWm = 2._dp*AmpVertexSeToSvVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqSeToSvVWm(gt1, gt2) 
  AmpSum2SeToSvVWm = AmpTreeSeToSvVWm + 2._dp*AmpWaveSeToSvVWm + 2._dp*AmpVertexSeToSvVWm
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqSeToSvVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2SeToSvVWm = AmpTreeSeToSvVWm
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
  AmpSqTreeSeToSvVWm(gt1, gt2) = (1)*AmpSqSeToSvVWm(gt1, gt2)  
  AmpSum2SeToSvVWm = + 2._dp*AmpWaveSeToSvVWm + 2._dp*AmpVertexSeToSvVWm
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
  AmpSqSeToSvVWm(gt1, gt2) = AmpSqSeToSvVWm(gt1, gt2) + AmpSqTreeSeToSvVWm(gt1, gt2)  
Else  
  AmpSum2SeToSvVWm = AmpTreeSeToSvVWm
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
  AmpSqTreeSeToSvVWm(gt1, gt2) = (1)*AmpSqSeToSvVWm(gt1, gt2)  
  AmpSum2SeToSvVWm = + 2._dp*AmpWaveSeToSvVWm + 2._dp*AmpVertexSeToSvVWm
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeToSvVWm(:,gt1, gt2),AmpSum2SeToSvVWm(:,gt1, gt2),AmpSqSeToSvVWm(gt1, gt2)) 
  AmpSqSeToSvVWm(gt1, gt2) = AmpSqSeToSvVWm(gt1, gt2) + AmpSqTreeSeToSvVWm(gt1, gt2)  
End if  
Else  
  AmpSqSeToSvVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSvVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSvOS(gt2),MVWmOS,helfactor*AmpSqSeToSvVWm(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSv(gt2),MVWm,helfactor*AmpSqSeToSvVWm(gt1, gt2))
End if 
If ((Abs(MRPSeToSvVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToSvVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPSeToSvVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToSvVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1*helfactor*(MRPSeToSvVWm(gt1, gt2) + MRGSeToSvVWm(gt1, gt2)) 
  gP1LSe(gt1,i4) = gP1LSe(gt1,i4) + phasespacefactor*1*helfactor*(MRPSeToSvVWm(gt1, gt2) + MRGSeToSvVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LSe(gt1,i4) 
  End if 
End if 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
End If 
!---------------- 
! Ah Hpm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToAhHpm(MAhOS,MAh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,ZfAh,ZfHpm,ZfSe,AmpWaveSeToAhHpm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToAhHpm(MAhOS,MAh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,ZfAh,ZfHpm,ZfSe,AmpWaveSeToAhHpm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToAhHpm(MAhOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,    & 
& cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,           & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,    & 
& cplAhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,AmpVertexSeToAhHpm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToAhHpm(MAhOS,MFdOS,MFeOS,MFuOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,    & 
& cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,           & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,    & 
& cplAhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,AmpVertexSeToAhHpm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToAhHpm(MAh,MAh2,MHpm,MHpm2,MSe,MSe2,ZfAh,           & 
& ZfHpm,ZfSe,AmpWaveSeToAhHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToAhHpm(MAh,MFd,MFe,MFu,MHpm,MSd,MSe,              & 
& MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,             & 
& cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,cplAhSecSecSv1,cplHpmSdcSdcSeaa,        & 
& cplHpmSecSecSe1,cplHpmSucSecSuaa,AmpVertexSeToAhHpm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Ah Hpm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToAhHpm = 0._dp 
 AmpSum2SeToAhHpm = 0._dp  
Else 
 AmpSumSeToAhHpm = AmpVertexSeToAhHpm + AmpWaveSeToAhHpm
 AmpSum2SeToAhHpm = AmpVertexSeToAhHpm + AmpWaveSeToAhHpm 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=2,2
    Do gt3=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MAhOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MAh(gt2)+MHpm(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MAhOS(gt2),MHpmOS(gt3),AmpSumSeToAhHpm(gt1, gt2, gt3),AmpSum2SeToAhHpm(gt1, gt2, gt3),AmpSqSeToAhHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MAh(gt2),MHpm(gt3),AmpSumSeToAhHpm(gt1, gt2, gt3),AmpSum2SeToAhHpm(gt1, gt2, gt3),AmpSqSeToAhHpm(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSeToAhHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToAhHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MAhOS(gt2),MHpmOS(gt3),helfactor*AmpSqSeToAhHpm(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MAh(gt2),MHpm(gt3),helfactor*AmpSqSeToAhHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToAhHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToAhHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Ah VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToAhVWm(MAhOS,MAh2OS,MSeOS,MSe2OS,MVWmOS,            & 
& MVWm2OS,ZfAh,ZfSe,ZfVWm,AmpWaveSeToAhVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToAhVWm(MAhOS,MAh2OS,MSeOS,MSe2OS,MVWmOS,            & 
& MVWm2OS,ZfAh,ZfSe,ZfVWm,AmpWaveSeToAhVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToAhVWm(MAhOS,MFdOS,MFeOS,MFuOS,MSdOS,             & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,    & 
& cplFvFecSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSecSu,           & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexSeToAhVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToAhVWm(MAhOS,MFdOS,MFeOS,MFuOS,MSdOS,             & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MAh2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,    & 
& cplFvFecSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSecSu,           & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexSeToAhVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToAhVWm(MAh,MAh2,MSe,MSe2,MVWm,MVWm2,ZfAh,           & 
& ZfSe,ZfVWm,AmpWaveSeToAhVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToAhVWm(MAh,MFd,MFe,MFu,MSd,MSe,MSu,               & 
& MSv,MVWm,MAh2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdAhL,cplcFdFdAhR,        & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,             & 
& AmpVertexSeToAhVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Ah VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToAhVWm = 0._dp 
 AmpSum2SeToAhVWm = 0._dp  
Else 
 AmpSumSeToAhVWm = AmpVertexSeToAhVWm + AmpWaveSeToAhVWm
 AmpSum2SeToAhVWm = AmpVertexSeToAhVWm + AmpWaveSeToAhVWm 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MAhOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MAh(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MAhOS(gt2),MVWmOS,AmpSumSeToAhVWm(:,gt1, gt2),AmpSum2SeToAhVWm(:,gt1, gt2),AmpSqSeToAhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MAh(gt2),MVWm,AmpSumSeToAhVWm(:,gt1, gt2),AmpSum2SeToAhVWm(:,gt1, gt2),AmpSqSeToAhVWm(gt1, gt2)) 
End if  
Else  
  AmpSqSeToAhVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToAhVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MAhOS(gt2),MVWmOS,helfactor*AmpSqSeToAhVWm(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MAh(gt2),MVWm,helfactor*AmpSqSeToAhVWm(gt1, gt2))
End if 
If ((Abs(MRPSeToAhVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToAhVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Cha Chi
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToChaChi(MChaOS,MCha2OS,MChiOS,MChi2OS,              & 
& MSeOS,MSe2OS,ZfL0,ZfLm,ZfLp,ZfSe,AmpWaveSeToChaChi)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToChaChi(MChaOS,MCha2OS,MChiOS,MChi2OS,              & 
& MSeOS,MSe2OS,ZfL0,ZfLm,ZfLp,ZfSe,AmpWaveSeToChaChi)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToChaChi(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,        & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,         & 
& cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplSdcSecSu,            & 
& cplSeSvcSe,cplSecSecSv,AmpVertexSeToChaChi)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToChaChi(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,        & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,         & 
& cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,         & 
& cplcFuChiSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplSdcSecSu,            & 
& cplSeSvcSe,cplSecSecSv,AmpVertexSeToChaChi)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToChaChi(MCha,MCha2,MChi,MChi2,MSe,MSe2,             & 
& ZfL0,ZfLm,ZfLp,ZfSe,AmpWaveSeToChaChi)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToChaChi(MCha,MChi,MFd,MFe,MFu,MSd,MSe,            & 
& MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,      & 
& cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplFvFecSeL,cplFvFecSeR,cplSdcSecSu,cplSeSvcSe,cplSecSecSv,AmpVertexSeToChaChi)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Cha Chi -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToChaChi = 0._dp 
 AmpSum2SeToChaChi = 0._dp  
Else 
 AmpSumSeToChaChi = AmpVertexSeToChaChi + AmpWaveSeToChaChi
 AmpSum2SeToChaChi = AmpVertexSeToChaChi + AmpWaveSeToChaChi 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,2
    Do gt3=1,4
If (((OSkinematics).and.(MSeOS(gt1).gt.(MChaOS(gt2)+MChiOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MCha(gt2)+MChi(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoFF(MSeOS(gt1),MChaOS(gt2),MChiOS(gt3),AmpSumSeToChaChi(:,gt1, gt2, gt3),AmpSum2SeToChaChi(:,gt1, gt2, gt3),AmpSqSeToChaChi(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoFF(MSe(gt1),MCha(gt2),MChi(gt3),AmpSumSeToChaChi(:,gt1, gt2, gt3),AmpSum2SeToChaChi(:,gt1, gt2, gt3),AmpSqSeToChaChi(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSeToChaChi(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 4._dp 
If (AmpSqSeToChaChi(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MChaOS(gt2),MChiOS(gt3),helfactor*AmpSqSeToChaChi(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MCha(gt2),MChi(gt3),helfactor*AmpSqSeToChaChi(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToChaChi(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToChaChi(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! hh Hpm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeTohhHpm(MhhOS,Mhh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,Zfhh,ZfHpm,ZfSe,AmpWaveSeTohhHpm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeTohhHpm(MhhOS,Mhh2OS,MHpmOS,MHpm2OS,MSeOS,           & 
& MSe2OS,Zfhh,ZfHpm,ZfSe,AmpWaveSeTohhHpm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeTohhHpm(MFdOS,MFeOS,MFuOS,MhhOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,              & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,               & 
& cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplhhHpmSucSdaa,            & 
& cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,        & 
& cplHpmSucSecSuaa,cplHpmSvcSecSv1,AmpVertexSeTohhHpm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeTohhHpm(MFdOS,MFeOS,MFuOS,MhhOS,MHpmOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,              & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,               & 
& cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplhhHpmSucSdaa,            & 
& cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,        & 
& cplHpmSucSecSuaa,cplHpmSvcSecSv1,AmpVertexSeTohhHpm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeTohhHpm(Mhh,Mhh2,MHpm,MHpm2,MSe,MSe2,Zfhh,           & 
& ZfHpm,ZfSe,AmpWaveSeTohhHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeTohhHpm(MFd,MFe,MFu,Mhh,MHpm,MSd,MSe,              & 
& MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,cplcFdFdhhR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,       & 
& cplSecSecSv,cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,             & 
& cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,cplHpmSvcSecSv1,AmpVertexSeTohhHpm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->hh Hpm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeTohhHpm = 0._dp 
 AmpSum2SeTohhHpm = 0._dp  
Else 
 AmpSumSeTohhHpm = AmpVertexSeTohhHpm + AmpWaveSeTohhHpm
 AmpSum2SeTohhHpm = AmpVertexSeTohhHpm + AmpWaveSeTohhHpm 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,2
    Do gt3=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MhhOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(Mhh(gt2)+MHpm(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MhhOS(gt2),MHpmOS(gt3),AmpSumSeTohhHpm(gt1, gt2, gt3),AmpSum2SeTohhHpm(gt1, gt2, gt3),AmpSqSeTohhHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),Mhh(gt2),MHpm(gt3),AmpSumSeTohhHpm(gt1, gt2, gt3),AmpSum2SeTohhHpm(gt1, gt2, gt3),AmpSqSeTohhHpm(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSeTohhHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeTohhHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MhhOS(gt2),MHpmOS(gt3),helfactor*AmpSqSeTohhHpm(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),Mhh(gt2),MHpm(gt3),helfactor*AmpSqSeTohhHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeTohhHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeTohhHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! hh VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeTohhVWm(MhhOS,Mhh2OS,MSeOS,MSe2OS,MVWmOS,            & 
& MVWm2OS,Zfhh,ZfSe,ZfVWm,AmpWaveSeTohhVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeTohhVWm(MhhOS,Mhh2OS,MSeOS,MSe2OS,MVWmOS,            & 
& MVWm2OS,Zfhh,ZfSe,ZfVWm,AmpWaveSeTohhVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeTohhVWm(MFdOS,MFeOS,MFuOS,MhhOS,MSdOS,             & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,          & 
& cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,               & 
& cplhhSvcSv,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexSeTohhVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeTohhVWm(MFdOS,MFeOS,MFuOS,MhhOS,MSdOS,             & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVWm2OS,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,          & 
& cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,               & 
& cplhhSvcSv,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexSeTohhVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeTohhVWm(Mhh,Mhh2,MSe,MSe2,MVWm,MVWm2,Zfhh,           & 
& ZfSe,ZfVWm,AmpWaveSeTohhVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeTohhVWm(MFd,MFe,MFu,Mhh,MSd,MSe,MSu,               & 
& MSv,MVWm,MFd2,MFe2,MFu2,Mhh2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdhhL,cplcFdFdhhR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,       & 
& cplSvcSeVWm,AmpVertexSeTohhVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->hh VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeTohhVWm = 0._dp 
 AmpSum2SeTohhVWm = 0._dp  
Else 
 AmpSumSeTohhVWm = AmpVertexSeTohhVWm + AmpWaveSeTohhVWm
 AmpSum2SeTohhVWm = AmpVertexSeTohhVWm + AmpWaveSeTohhVWm 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MhhOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(Mhh(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MhhOS(gt2),MVWmOS,AmpSumSeTohhVWm(:,gt1, gt2),AmpSum2SeTohhVWm(:,gt1, gt2),AmpSqSeTohhVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),Mhh(gt2),MVWm,AmpSumSeTohhVWm(:,gt1, gt2),AmpSum2SeTohhVWm(:,gt1, gt2),AmpSqSeTohhVWm(gt1, gt2)) 
End if  
Else  
  AmpSqSeTohhVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeTohhVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MhhOS(gt2),MVWmOS,helfactor*AmpSqSeTohhVWm(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),Mhh(gt2),MVWm,helfactor*AmpSqSeTohhVWm(gt1, gt2))
End if 
If ((Abs(MRPSeTohhVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeTohhVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Hpm VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmVP(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVP,             & 
& MVP2,ZfHpm,ZfSe,ZfVP,AmpWaveSeToHpmVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmVP(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVP,             & 
& MVP2,ZfHpm,ZfSe,ZfVP,AmpWaveSeToHpmVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmVP(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVP,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,               & 
& MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,             & 
& cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,             & 
& cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdVP,              & 
& cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,AmpVertexSeToHpmVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmVP(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVP,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,               & 
& MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,             & 
& cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,             & 
& cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdVP,              & 
& cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,AmpVertexSeToHpmVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmVP(MHpm,MHpm2,MSe,MSe2,MVP,MVP2,ZfHpm,          & 
& ZfSe,ZfVP,AmpWaveSeToHpmVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmVP(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,              & 
& MSv,MVP,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcSdVP,cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,      & 
& AmpVertexSeToHpmVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Hpm VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToHpmVP = 0._dp 
 AmpSum2SeToHpmVP = 0._dp  
Else 
 AmpSumSeToHpmVP = AmpVertexSeToHpmVP + AmpWaveSeToHpmVP
 AmpSum2SeToHpmVP = AmpVertexSeToHpmVP + AmpWaveSeToHpmVP 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MHpmOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MHpm(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MHpmOS(gt2),0._dp,AmpSumSeToHpmVP(:,gt1, gt2),AmpSum2SeToHpmVP(:,gt1, gt2),AmpSqSeToHpmVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MHpm(gt2),MVP,AmpSumSeToHpmVP(:,gt1, gt2),AmpSum2SeToHpmVP(:,gt1, gt2),AmpSqSeToHpmVP(gt1, gt2)) 
End if  
Else  
  AmpSqSeToHpmVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToHpmVP(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MHpmOS(gt2),0._dp,helfactor*AmpSqSeToHpmVP(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MHpm(gt2),MVP,helfactor*AmpSqSeToHpmVP(gt1, gt2))
End if 
If ((Abs(MRPSeToHpmVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToHpmVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Hpm VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmVZ(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVZOS,           & 
& MVZ2OS,ZfHpm,ZfSe,ZfVZ,AmpWaveSeToHpmVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmVZ(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MVZOS,           & 
& MVZ2OS,ZfHpm,ZfSe,ZfVZ,AmpWaveSeToHpmVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmVZ(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVZOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,               & 
& cplHpmSvcSe,cplSdcSdVZ,cplSdcSecSu,cplSecSeVZ,cplSecSecSv,cplSucSuVZ,cplSvcSvVZ,       & 
& AmpVertexSeToHpmVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmVZ(MFdOS,MFeOS,MFuOS,MHpmOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVZOS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,           & 
& cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,               & 
& cplHpmSvcSe,cplSdcSdVZ,cplSdcSecSu,cplSecSeVZ,cplSecSecSv,cplSucSuVZ,cplSvcSvVZ,       & 
& AmpVertexSeToHpmVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmVZ(MHpm,MHpm2,MSe,MSe2,MVZ,MVZ2,ZfHpm,          & 
& ZfSe,ZfVZ,AmpWaveSeToHpmVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmVZ(MFd,MFe,MFu,MHpm,MSd,MSe,MSu,              & 
& MSv,MVZ,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdVZ,cplSdcSecSu,              & 
& cplSecSeVZ,cplSecSecSv,cplSucSuVZ,cplSvcSvVZ,AmpVertexSeToHpmVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Hpm VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToHpmVZ = 0._dp 
 AmpSum2SeToHpmVZ = 0._dp  
Else 
 AmpSumSeToHpmVZ = AmpVertexSeToHpmVZ + AmpWaveSeToHpmVZ
 AmpSum2SeToHpmVZ = AmpVertexSeToHpmVZ + AmpWaveSeToHpmVZ 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=2,2
If (((OSkinematics).and.(MSeOS(gt1).gt.(MHpmOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MHpm(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MHpmOS(gt2),MVZOS,AmpSumSeToHpmVZ(:,gt1, gt2),AmpSum2SeToHpmVZ(:,gt1, gt2),AmpSqSeToHpmVZ(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MHpm(gt2),MVZ,AmpSumSeToHpmVZ(:,gt1, gt2),AmpSum2SeToHpmVZ(:,gt1, gt2),AmpSqSeToHpmVZ(gt1, gt2)) 
End if  
Else  
  AmpSqSeToHpmVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToHpmVZ(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MHpmOS(gt2),MVZOS,helfactor*AmpSqSeToHpmVZ(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MHpm(gt2),MVZ,helfactor*AmpSqSeToHpmVZ(gt1, gt2))
End if 
If ((Abs(MRPSeToHpmVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToHpmVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Hpm Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmcSv(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MSvOS,          & 
& MSv2OS,ZfHpm,ZfSe,ZfSv,AmpWaveSeToHpmcSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmcSv(MHpmOS,MHpm2OS,MSeOS,MSe2OS,MSvOS,          & 
& MSv2OS,ZfHpm,ZfSe,ZfSv,AmpWaveSeToHpmcSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmcSv(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,           & 
& MSd2OS,MSe2OS,MSu2OS,MSv2OS,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,       & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdcSvL,cplcFdFdcSvR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,cplHpmSdcSdcSeaa,          & 
& cplHpmSecSecSe1,cplHpmSucSdcSvaa,cplHpmSvcSecSv1,AmpVertexSeToHpmcSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmcSv(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,           & 
& MSd2OS,MSe2OS,MSu2OS,MSv2OS,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,       & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdcSvL,cplcFdFdcSvR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,cplHpmSdcSdcSeaa,          & 
& cplHpmSecSecSe1,cplHpmSucSdcSvaa,cplHpmSvcSecSv1,AmpVertexSeToHpmcSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToHpmcSv(MHpm,MHpm2,MSe,MSe2,MSv,MSv2,               & 
& ZfHpm,ZfSe,ZfSv,AmpWaveSeToHpmcSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToHpmcSv(MCha,MChi,MFd,MFe,MFu,MHpm,               & 
& MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplFvChacSeL,     & 
& cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,       & 
& cplcChaChiHpmR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,        & 
& cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdcSv,            & 
& cplSdcSecSu,cplSecSecSv,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSdcSvaa,             & 
& cplHpmSvcSecSv1,AmpVertexSeToHpmcSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Hpm conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToHpmcSv = 0._dp 
 AmpSum2SeToHpmcSv = 0._dp  
Else 
 AmpSumSeToHpmcSv = AmpVertexSeToHpmcSv + AmpWaveSeToHpmcSv
 AmpSum2SeToHpmcSv = AmpVertexSeToHpmcSv + AmpWaveSeToHpmcSv 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=2,2
    Do gt3=1,3
If (((OSkinematics).and.(MSeOS(gt1).gt.(MHpmOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MHpm(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSS(MSeOS(gt1),MHpmOS(gt2),MSvOS(gt3),AmpSumSeToHpmcSv(gt1, gt2, gt3),AmpSum2SeToHpmcSv(gt1, gt2, gt3),AmpSqSeToHpmcSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_StoSS(MSe(gt1),MHpm(gt2),MSv(gt3),AmpSumSeToHpmcSv(gt1, gt2, gt3),AmpSum2SeToHpmcSv(gt1, gt2, gt3),AmpSqSeToHpmcSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqSeToHpmcSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToHpmcSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MHpmOS(gt2),MSvOS(gt3),helfactor*AmpSqSeToHpmcSv(gt1, gt2, gt3))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MHpm(gt2),MSv(gt3),helfactor*AmpSqSeToHpmcSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPSeToHpmcSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGSeToHpmcSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Se VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToSeVP(cplSecSeVP,cplSecSeVZ,ctcplSecSeVP,           & 
& ctcplSecSeVZ,MSeOS,MSe2OS,MVP,MVP2,ZfSe,ZfVP,ZfVZVP,AmpWaveSeToSeVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToSeVP(cplSecSeVP,cplSecSeVZ,ctcplSecSeVP,           & 
& ctcplSecSeVZ,MSeOS,MSe2OS,MVP,MVP2,ZfSe,ZfVP,ZfVZVP,AmpWaveSeToSeVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSeVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplcChaChaVPL,cplcChaChaVPR,  & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVPL,cplcFdFdVPR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,              & 
& cplSdcSdVP,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVP,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,             & 
& cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSvcVWmVP1,cplSvcSeVPVWm1,AmpVertexSeToSeVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSeVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,            & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplcChaChaVPL,cplcChaChaVPR,  & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVPL,cplcFdFdVPR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,              & 
& cplSdcSdVP,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVP,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,             & 
& cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSvcVWmVP1,cplSvcSeVPVWm1,AmpVertexSeToSeVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToSeVP(cplSecSeVP,cplSecSeVZ,ctcplSecSeVP,           & 
& ctcplSecSeVZ,MSe,MSe2,MVP,MVP2,ZfSe,ZfVP,ZfVZVP,AmpWaveSeToSeVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToSeVP(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,              & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplHpmSvcSe,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,     & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVP,cplSvcSeVWm,               & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSvcVWmVP1,cplSvcSeVPVWm1,  & 
& AmpVertexSeToSeVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->Se VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToSeVP = 0._dp 
 AmpSum2SeToSeVP = 0._dp  
Else 
 AmpSumSeToSeVP = AmpVertexSeToSeVP + AmpWaveSeToSeVP
 AmpSum2SeToSeVP = AmpVertexSeToSeVP + AmpWaveSeToSeVP 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,6
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSeOS(gt2)+0.))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSe(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSeOS(gt2),0._dp,AmpSumSeToSeVP(:,gt1, gt2),AmpSum2SeToSeVP(:,gt1, gt2),AmpSqSeToSeVP(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSe(gt2),MVP,AmpSumSeToSeVP(:,gt1, gt2),AmpSum2SeToSeVP(:,gt1, gt2),AmpSqSeToSeVP(gt1, gt2)) 
End if  
Else  
  AmpSqSeToSeVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToSeVP(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSeOS(gt2),0._dp,helfactor*AmpSqSeToSeVP(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSe(gt2),MVP,helfactor*AmpSqSeToSeVP(gt1, gt2))
End if 
If ((Abs(MRPSeToSeVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeToSeVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
!---------------- 
! VP VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToVPVWm(MSeOS,MSe2OS,MVP,MVP2,MVWmOS,MVWm2OS,        & 
& ZfSe,ZfVP,ZfVWm,AmpWaveSeToVPVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToVPVWm(MSeOS,MSe2OS,MVP,MVP2,MVWmOS,MVWm2OS,        & 
& ZfSe,ZfVP,ZfVWm,AmpWaveSeToVPVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToVPVWm(MFdOS,MFeOS,MFuOS,MSdOS,MSeOS,             & 
& MSuOS,MSvOS,MVP,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,            & 
& cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVP,cplSdcSecSu,cplSecSeVP,              & 
& cplSecSecSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,cplSucSdVPVWmaa,cplSvcSeVPVWm1,         & 
& AmpVertexSeToVPVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToVPVWm(MFdOS,MFeOS,MFuOS,MSdOS,MSeOS,             & 
& MSuOS,MSvOS,MVP,MVWmOS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,            & 
& cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVP,cplSdcSecSu,cplSecSeVP,              & 
& cplSecSecSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,cplSucSdVPVWmaa,cplSvcSeVPVWm1,         & 
& AmpVertexSeToVPVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToVPVWm(MSe,MSe2,MVP,MVP2,MVWm,MVWm2,ZfSe,           & 
& ZfVP,ZfVWm,AmpWaveSeToVPVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToVPVWm(MFd,MFe,MFu,MSd,MSe,MSu,MSv,               & 
& MVP,MVWm,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,cplcFdFdVPL,cplcFdFdVPR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplSdcSdVP,cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,      & 
& cplSucSdVPVWmaa,cplSvcSeVPVWm1,AmpVertexSeToVPVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->VP VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToVPVWm = 0._dp 
 AmpSum2SeToVPVWm = 0._dp  
Else 
 AmpSumSeToVPVWm = AmpVertexSeToVPVWm + AmpWaveSeToVPVWm
 AmpSum2SeToVPVWm = AmpVertexSeToVPVWm + AmpWaveSeToVPVWm 
End If 
Do gt1=1,6
i4 = isave 
If (((OSkinematics).and.(MSeOS(gt1).gt.(0.+MVWmOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MVP+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSeOS(gt1),0._dp,MVWmOS,AmpSumSeToVPVWm(:,gt1),AmpSum2SeToVPVWm(:,gt1),AmpSqSeToVPVWm(gt1)) 
Else  
  Call SquareAmp_StoVV(MSe(gt1),MVP,MVWm,AmpSumSeToVPVWm(:,gt1),AmpSum2SeToVPVWm(:,gt1),AmpSqSeToVPVWm(gt1)) 
End if  
Else  
  AmpSqSeToVPVWm(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToVPVWm(gt1).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 2*GammaTPS(MSeOS(gt1),0._dp,MVWmOS,helfactor*AmpSqSeToVPVWm(gt1))
Else 
  gP1LSe(gt1,i4) = 2*GammaTPS(MSe(gt1),MVP,MVWm,helfactor*AmpSqSeToVPVWm(gt1))
End if 
If ((Abs(MRPSeToVPVWm(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSeToVPVWm(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.6) isave = i4 
End do
!---------------- 
! VWm VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeToVWmVZ(MSeOS,MSe2OS,MVWmOS,MVWm2OS,MVZOS,           & 
& MVZ2OS,ZfSe,ZfVWm,ZfVZ,AmpWaveSeToVWmVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeToVWmVZ(MSeOS,MSe2OS,MVWmOS,MVWm2OS,MVZOS,           & 
& MVZ2OS,ZfSe,ZfVWm,ZfVZ,AmpWaveSeToVWmVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeToVWmVZ(MFdOS,MFeOS,MFuOS,MSdOS,MSeOS,             & 
& MSuOS,MSvOS,MVWmOS,MVZOS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,             & 
& MVWm2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,          & 
& cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVZ,cplSdcSecSu,    & 
& cplSecSeVZ,cplSecSecSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplSucSdVWmVZaa,  & 
& cplSvcSeVWmVZ1,AmpVertexSeToVWmVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeToVWmVZ(MFdOS,MFeOS,MFuOS,MSdOS,MSeOS,             & 
& MSuOS,MSvOS,MVWmOS,MVZOS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,             & 
& MVWm2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,          & 
& cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,             & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVZ,cplSdcSecSu,    & 
& cplSecSeVZ,cplSecSecSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplSucSdVWmVZaa,  & 
& cplSvcSeVWmVZ1,AmpVertexSeToVWmVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeToVWmVZ(MSe,MSe2,MVWm,MVWm2,MVZ,MVZ2,ZfSe,           & 
& ZfVWm,ZfVZ,AmpWaveSeToVWmVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeToVWmVZ(MFd,MFe,MFu,MSd,MSe,MSu,MSv,               & 
& MVWm,MVZ,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVZ,cplSdcSecSu,cplSecSeVZ,cplSecSecSv,               & 
& cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,          & 
& AmpVertexSeToVWmVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->VWm VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeToVWmVZ = 0._dp 
 AmpSum2SeToVWmVZ = 0._dp  
Else 
 AmpSumSeToVWmVZ = AmpVertexSeToVWmVZ + AmpWaveSeToVWmVZ
 AmpSum2SeToVWmVZ = AmpVertexSeToVWmVZ + AmpWaveSeToVWmVZ 
End If 
Do gt1=1,6
i4 = isave 
If (((OSkinematics).and.(MSeOS(gt1).gt.(MVWmOS+MVZOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MVWm+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoVV(MSeOS(gt1),MVWmOS,MVZOS,AmpSumSeToVWmVZ(:,gt1),AmpSum2SeToVWmVZ(:,gt1),AmpSqSeToVWmVZ(gt1)) 
Else  
  Call SquareAmp_StoVV(MSe(gt1),MVWm,MVZ,AmpSumSeToVWmVZ(:,gt1),AmpSum2SeToVWmVZ(:,gt1),AmpSqSeToVWmVZ(gt1)) 
End if  
Else  
  AmpSqSeToVWmVZ(gt1) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeToVWmVZ(gt1).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 2*GammaTPS(MSeOS(gt1),MVWmOS,MVZOS,helfactor*AmpSqSeToVWmVZ(gt1))
Else 
  gP1LSe(gt1,i4) = 2*GammaTPS(MSe(gt1),MVWm,MVZ,helfactor*AmpSqSeToVWmVZ(gt1))
End if 
If ((Abs(MRPSeToVWmVZ(gt1)).gt.1.0E-20_dp).or.(Abs(MRGSeToVWmVZ(gt1)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

If (gt1.eq.6) isave = i4 
End do
!---------------- 
! Conjg(Sv) VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_SeTocSvVWm(MSeOS,MSe2OS,MSvOS,MSv2OS,MVWmOS,           & 
& MVWm2OS,ZfSe,ZfSv,ZfVWm,AmpWaveSeTocSvVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_SeTocSvVWm(MSeOS,MSe2OS,MSvOS,MSv2OS,MVWmOS,           & 
& MVWm2OS,ZfSe,ZfSv,ZfVWm,AmpWaveSeTocSvVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_SeTocSvVWm(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,            & 
& MSe2OS,MSu2OS,MSv2OS,MVWm2OS,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,      & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdcSvL,cplcFdFdcSvR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexSeTocSvVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_SeTocSvVWm(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,            & 
& MSe2OS,MSu2OS,MSv2OS,MVWm2OS,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,      & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdcSvL,cplcFdFdcSvR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,AmpVertexSeTocSvVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_SeTocSvVWm(MSe,MSe2,MSv,MSv2,MVWm,MVWm2,               & 
& ZfSe,ZfSv,ZfVWm,AmpWaveSeTocSvVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_SeTocSvVWm(MCha,MChi,MFd,MFe,MFu,MSd,MSe,            & 
& MSu,MSv,MVWm,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplFvChacSeL,        & 
& cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,        & 
& cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuVWmL,        & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,            & 
& cplSucSdVWm,cplSvcSeVWm,AmpVertexSeTocSvVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Se->conj[Sv] VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumSeTocSvVWm = 0._dp 
 AmpSum2SeTocSvVWm = 0._dp  
Else 
 AmpSumSeTocSvVWm = AmpVertexSeTocSvVWm + AmpWaveSeTocSvVWm
 AmpSum2SeTocSvVWm = AmpVertexSeTocSvVWm + AmpWaveSeTocSvVWm 
End If 
Do gt1=1,6
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MSeOS(gt1).gt.(MSvOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MSe(gt1).gt.(MSv(gt2)+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_StoSV(MSeOS(gt1),MSvOS(gt2),MVWmOS,AmpSumSeTocSvVWm(:,gt1, gt2),AmpSum2SeTocSvVWm(:,gt1, gt2),AmpSqSeTocSvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_StoSV(MSe(gt1),MSv(gt2),MVWm,AmpSumSeTocSvVWm(:,gt1, gt2),AmpSum2SeTocSvVWm(:,gt1, gt2),AmpSqSeTocSvVWm(gt1, gt2)) 
End if  
Else  
  AmpSqSeTocSvVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 1._dp 
If (AmpSqSeTocSvVWm(gt1, gt2).eq.0._dp) Then 
  gP1LSe(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSeOS(gt1),MSvOS(gt2),MVWmOS,helfactor*AmpSqSeTocSvVWm(gt1, gt2))
Else 
  gP1LSe(gt1,i4) = 1*GammaTPS(MSe(gt1),MSv(gt2),MVWm,helfactor*AmpSqSeTocSvVWm(gt1, gt2))
End if 
If ((Abs(MRPSeTocSvVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGSeTocSvVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LSe(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.6) isave = i4 
End do
End Subroutine OneLoopDecay_Se

End Module Wrapper_OneLoopDecay_Se_MSSMTriLnV
