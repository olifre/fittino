! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:01 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Wrapper_OneLoopDecay_Cha_MSSMTriLnV
Use Model_Data_MSSMTriLnV 
Use Kinematics 
Use OneLoopDecay_Cha_MSSMTriLnV 
Use Control 
Use Settings 

 
Contains

 
Subroutine OneLoopDecay_Cha(MSdOS,MSd2OS,MSvOS,MSv2OS,MSuOS,MSu2OS,MSeOS,             & 
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
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvcSvL,         & 
& cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplcHpmVPVWm,cplcHpmVWmVZ,cplcVWmVPVWm,           & 
& cplcVWmVWmVZ,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,            & 
& cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,             & 
& cplGluFucSuR,cplhhcHpmVWm,cplhhcVWmVWm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhVZVZ,cplHpmcHpmVP,cplHpmcHpmVZ,       & 
& cplHpmcVWmVP,cplHpmcVWmVZ,cplHpmSucSd,cplHpmSvcSe,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSecSu,cplSdcSucVWm,cplSdSvcSd,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSeVP,cplSecSeVZ,cplSecSvcVWm,cplSeSucSd,cplSeSvcSe,cplSucSdVWm,      & 
& cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,ctcplcChacFuSdL,               & 
& ctcplcChacFuSdR,ctcplcChaChaAhL,ctcplcChaChaAhR,ctcplcChaChahhL,ctcplcChaChahhR,       & 
& ctcplcChaChaVPL,ctcplcChaChaVPR,ctcplcChaChaVZL,ctcplcChaChaVZR,ctcplcChaChiHpmL,      & 
& ctcplcChaChiHpmR,ctcplcChaChiVWmL,ctcplcChaChiVWmR,ctcplcChaFdcSuL,ctcplcChaFdcSuR,    & 
& ctcplcChaFecSvL,ctcplcChaFecSvR,ctcplcChaFvSeL,ctcplcChaFvSeR,GcplcChaChiHpmL,         & 
& GcplcChaChiHpmR,GcplcHpmVPVWm,GcplHpmcVWmVP,GosZcplcChaChiHpmL,GosZcplcChaChiHpmR,     & 
& GosZcplcHpmVPVWm,GosZcplHpmcVWmVP,GZcplcChaChiHpmL,GZcplcChaChiHpmR,GZcplcHpmVPVWm,    & 
& GZcplHpmcVWmVP,ZcplAhSdcSd,ZcplAhSecSe,ZcplAhSucSu,ZcplcChacFuSdL,ZcplcChacFuSdR,      & 
& ZcplcChaChaAhL,ZcplcChaChaAhR,ZcplcChaChahhL,ZcplcChaChahhR,ZcplcChaChaVPL,            & 
& ZcplcChaChaVPR,ZcplcChaChaVZL,ZcplcChaChaVZR,ZcplcChaChiHpmL,ZcplcChaChiHpmR,          & 
& ZcplcChaChiVWmL,ZcplcChaChiVWmR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplcChaFecSvL,          & 
& ZcplcChaFecSvR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplcFdChaSuL,ZcplcFdChaSuR,ZcplcFdChiSdL,  & 
& ZcplcFdChiSdR,ZcplcFdFdAhL,ZcplcFdFdAhR,ZcplcFdFdcSvL,ZcplcFdFdcSvR,ZcplcFdFdhhL,      & 
& ZcplcFdFdhhR,ZcplcFdFdSvL,ZcplcFdFdSvR,ZcplcFdFdVPL,ZcplcFdFdVPR,ZcplcFdFdVZL,         & 
& ZcplcFdFdVZR,ZcplcFdFeSuL,ZcplcFdFeSuR,ZcplcFdFuHpmL,ZcplcFdFuHpmR,ZcplcFdFuSeL,       & 
& ZcplcFdFuSeR,ZcplcFdFuVWmL,ZcplcFdFuVWmR,ZcplcFdFvSdL,ZcplcFdFvSdR,ZcplcFeChaSvL,      & 
& ZcplcFeChaSvR,ZcplcFeChiSeL,ZcplcFeChiSeR,ZcplcFeFeAhL,ZcplcFeFeAhR,ZcplcFeFecSvL,     & 
& ZcplcFeFecSvR,ZcplcFeFehhL,ZcplcFeFehhR,ZcplcFeFeSvL,ZcplcFeFeSvR,ZcplcFeFeVPL,        & 
& ZcplcFeFeVPR,ZcplcFeFeVZL,ZcplcFeFeVZR,ZcplcFeFvHpmL,ZcplcFeFvHpmR,ZcplcFeFvSeL,       & 
& ZcplcFeFvSeR,ZcplcFeFvVWmL,ZcplcFeFvVWmR,ZcplcFuChiSuL,ZcplcFuChiSuR,ZcplcFuFuAhL,     & 
& ZcplcFuFuAhR,ZcplcFuFuhhL,ZcplcFuFuhhR,ZcplcFuFuVPL,ZcplcFuFuVPR,ZcplcFuFuVZL,         & 
& ZcplcFuFuVZR,ZcplChaFucSdL,ZcplChaFucSdR,ZcplChiChacHpmL,ZcplChiChacHpmR,              & 
& ZcplChiChacVWmL,ZcplChiChacVWmR,ZcplChiFdcSdL,ZcplChiFdcSdR,ZcplChiFecSeL,             & 
& ZcplChiFecSeR,ZcplChiFucSuL,ZcplChiFucSuR,ZcplChiFvcSvL,ZcplChiFvcSvR,ZcplChiFvSvL,    & 
& ZcplChiFvSvR,ZcplcHpmVPVWm,ZcplcVWmVPVWm,ZcplFeFucSdL,ZcplFeFucSdR,ZcplFvChacSeL,      & 
& ZcplFvChacSeR,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplFvFecHpmL,ZcplFvFecHpmR,ZcplFvFecSeL,      & 
& ZcplFvFecSeR,ZcplFvFecVWmL,ZcplFvFecVWmR,ZcplFvFvVZL,ZcplFvFvVZR,ZcplhhSdcSd,          & 
& ZcplhhSecSe,ZcplhhSucSu,ZcplhhSvcSv,ZcplHpmcHpmVP,ZcplHpmcVWmVP,ZcplHpmSucSd,          & 
& ZcplHpmSvcSe,ZcplSdcSdcSv,ZcplSdcSdVP,ZcplSdcSdVZ,ZcplSdSvcSd,ZcplSecSecSv,            & 
& ZcplSecSeVP,ZcplSecSeVZ,ZcplSeSucSd,ZcplSeSvcSe,ZcplSucSdVWm,ZcplSucSuVP,              & 
& ZcplSucSuVZ,ZcplSvcSeVWm,ZcplSvcSvVZ,ZRUZD,ZRUZV,ZRUZU,ZRUZE,ZRUZH,ZRUZA,              & 
& ZRUZP,ZRUZN,ZRUUM,ZRUUP,ZRUZEL,ZRUZER,ZRUZDL,ZRUZDR,ZRUZUL,ZRUZUR,MLambda,             & 
& em,gs,deltaM,kont,gP1LCha)

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
& cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplcVWmVPVWm,cplcVWmVWmVZ,          & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplGluFucSuL(3,6), & 
& cplGluFucSuR(3,6),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),& 
& cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplhhVZVZ(2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplHpmcVWmVP(2),    & 
& cplHpmcVWmVZ(2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcHpmcSu(6,2,6),             & 
& cplSdcSdcSv(6,6,3),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6), & 
& cplSdcSucVWm(6,6),cplSdSvcSd(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSvcVWm(6,3),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6), & 
& cplSucSdVWm(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),     & 
& cplSvcSvVZ(3,3),ctcplcChacFuSdL(2,3,6),ctcplcChacFuSdR(2,3,6),ctcplcChaChaAhL(2,2,2),  & 
& ctcplcChaChaAhR(2,2,2),ctcplcChaChahhL(2,2,2),ctcplcChaChahhR(2,2,2),ctcplcChaChaVPL(2,2),& 
& ctcplcChaChaVPR(2,2),ctcplcChaChaVZL(2,2),ctcplcChaChaVZR(2,2),ctcplcChaChiHpmL(2,4,2),& 
& ctcplcChaChiHpmR(2,4,2),ctcplcChaChiVWmL(2,4),ctcplcChaChiVWmR(2,4),ctcplcChaFdcSuL(2,3,6),& 
& ctcplcChaFdcSuR(2,3,6),ctcplcChaFecSvL(2,3,3),ctcplcChaFecSvR(2,3,3),ctcplcChaFvSeL(2,3,6),& 
& ctcplcChaFvSeR(2,3,6),GcplcChaChiHpmL(2,4,2),GcplcChaChiHpmR(2,4,2),GcplcHpmVPVWm(2),  & 
& GcplHpmcVWmVP(2),GosZcplcChaChiHpmL(2,4,2),GosZcplcChaChiHpmR(2,4,2),GosZcplcHpmVPVWm(2),& 
& GosZcplHpmcVWmVP(2),GZcplcChaChiHpmL(2,4,2),GZcplcChaChiHpmR(2,4,2),GZcplcHpmVPVWm(2), & 
& GZcplHpmcVWmVP(2),ZcplAhSdcSd(2,6,6),ZcplAhSecSe(2,6,6),ZcplAhSucSu(2,6,6),            & 
& ZcplcChacFuSdL(2,3,6),ZcplcChacFuSdR(2,3,6),ZcplcChaChaAhL(2,2,2),ZcplcChaChaAhR(2,2,2),& 
& ZcplcChaChahhL(2,2,2),ZcplcChaChahhR(2,2,2),ZcplcChaChaVPL(2,2),ZcplcChaChaVPR(2,2),   & 
& ZcplcChaChaVZL(2,2),ZcplcChaChaVZR(2,2),ZcplcChaChiHpmL(2,4,2),ZcplcChaChiHpmR(2,4,2), & 
& ZcplcChaChiVWmL(2,4),ZcplcChaChiVWmR(2,4),ZcplcChaFdcSuL(2,3,6),ZcplcChaFdcSuR(2,3,6), & 
& ZcplcChaFecSvL(2,3,3),ZcplcChaFecSvR(2,3,3),ZcplcChaFvSeL(2,3,6),ZcplcChaFvSeR(2,3,6), & 
& ZcplcFdChaSuL(3,2,6),ZcplcFdChaSuR(3,2,6),ZcplcFdChiSdL(3,4,6),ZcplcFdChiSdR(3,4,6),   & 
& ZcplcFdFdAhL(3,3,2),ZcplcFdFdAhR(3,3,2),ZcplcFdFdcSvL(3,3,3),ZcplcFdFdcSvR(3,3,3),     & 
& ZcplcFdFdhhL(3,3,2),ZcplcFdFdhhR(3,3,2),ZcplcFdFdSvL(3,3,3),ZcplcFdFdSvR(3,3,3),       & 
& ZcplcFdFdVPL(3,3),ZcplcFdFdVPR(3,3),ZcplcFdFdVZL(3,3),ZcplcFdFdVZR(3,3),               & 
& ZcplcFdFeSuL(3,3,6),ZcplcFdFeSuR(3,3,6),ZcplcFdFuHpmL(3,3,2),ZcplcFdFuHpmR(3,3,2),     & 
& ZcplcFdFuSeL(3,3,6),ZcplcFdFuSeR(3,3,6),ZcplcFdFuVWmL(3,3),ZcplcFdFuVWmR(3,3),         & 
& ZcplcFdFvSdL(3,3,6),ZcplcFdFvSdR(3,3,6),ZcplcFeChaSvL(3,2,3),ZcplcFeChaSvR(3,2,3),     & 
& ZcplcFeChiSeL(3,4,6),ZcplcFeChiSeR(3,4,6),ZcplcFeFeAhL(3,3,2),ZcplcFeFeAhR(3,3,2),     & 
& ZcplcFeFecSvL(3,3,3),ZcplcFeFecSvR(3,3,3),ZcplcFeFehhL(3,3,2),ZcplcFeFehhR(3,3,2),     & 
& ZcplcFeFeSvL(3,3,3),ZcplcFeFeSvR(3,3,3),ZcplcFeFeVPL(3,3),ZcplcFeFeVPR(3,3),           & 
& ZcplcFeFeVZL(3,3),ZcplcFeFeVZR(3,3),ZcplcFeFvHpmL(3,3,2),ZcplcFeFvHpmR(3,3,2),         & 
& ZcplcFeFvSeL(3,3,6),ZcplcFeFvSeR(3,3,6),ZcplcFeFvVWmL(3,3),ZcplcFeFvVWmR(3,3),         & 
& ZcplcFuChiSuL(3,4,6),ZcplcFuChiSuR(3,4,6),ZcplcFuFuAhL(3,3,2),ZcplcFuFuAhR(3,3,2),     & 
& ZcplcFuFuhhL(3,3,2),ZcplcFuFuhhR(3,3,2),ZcplcFuFuVPL(3,3),ZcplcFuFuVPR(3,3),           & 
& ZcplcFuFuVZL(3,3),ZcplcFuFuVZR(3,3),ZcplChaFucSdL(2,3,6),ZcplChaFucSdR(2,3,6),         & 
& ZcplChiChacHpmL(4,2,2),ZcplChiChacHpmR(4,2,2),ZcplChiChacVWmL(4,2),ZcplChiChacVWmR(4,2),& 
& ZcplChiFdcSdL(4,3,6),ZcplChiFdcSdR(4,3,6),ZcplChiFecSeL(4,3,6),ZcplChiFecSeR(4,3,6)

Complex(dp),Intent(in) :: ZcplChiFucSuL(4,3,6),ZcplChiFucSuR(4,3,6),ZcplChiFvcSvL(4,3,3),ZcplChiFvcSvR(4,3,3),   & 
& ZcplChiFvSvL(4,3,3),ZcplChiFvSvR(4,3,3),ZcplcHpmVPVWm(2),ZcplcVWmVPVWm,ZcplFeFucSdL(3,3,6),& 
& ZcplFeFucSdR(3,3,6),ZcplFvChacSeL(3,2,6),ZcplFvChacSeR(3,2,6),ZcplFvFdcSdL(3,3,6),     & 
& ZcplFvFdcSdR(3,3,6),ZcplFvFecHpmL(3,3,2),ZcplFvFecHpmR(3,3,2),ZcplFvFecSeL(3,3,6),     & 
& ZcplFvFecSeR(3,3,6),ZcplFvFecVWmL(3,3),ZcplFvFecVWmR(3,3),ZcplFvFvVZL(3,3),            & 
& ZcplFvFvVZR(3,3),ZcplhhSdcSd(2,6,6),ZcplhhSecSe(2,6,6),ZcplhhSucSu(2,6,6),             & 
& ZcplhhSvcSv(2,3,3),ZcplHpmcHpmVP(2,2),ZcplHpmcVWmVP(2),ZcplHpmSucSd(2,6,6),            & 
& ZcplHpmSvcSe(2,3,6),ZcplSdcSdcSv(6,6,3),ZcplSdcSdVP(6,6),ZcplSdcSdVZ(6,6),             & 
& ZcplSdSvcSd(6,3,6),ZcplSecSecSv(6,6,3),ZcplSecSeVP(6,6),ZcplSecSeVZ(6,6),              & 
& ZcplSeSucSd(6,6,6),ZcplSeSvcSe(6,3,6),ZcplSucSdVWm(6,6),ZcplSucSuVP(6,6),              & 
& ZcplSucSuVZ(6,6),ZcplSvcSeVWm(3,6),ZcplSvcSvVZ(3,3)

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
Real(dp), Intent(out) :: gP1LCha(2,147) 
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
Real(dp) :: MRPChaToChaAh(2,2,2),MRGChaToChaAh(2,2,2), MRPZChaToChaAh(2,2,2),MRGZChaToChaAh(2,2,2) 
Real(dp) :: MVPChaToChaAh(2,2,2) 
Real(dp) :: RMsqTreeChaToChaAh(2,2,2),RMsqWaveChaToChaAh(2,2,2),RMsqVertexChaToChaAh(2,2,2) 
Complex(dp) :: AmpTreeChaToChaAh(2,2,2,2),AmpWaveChaToChaAh(2,2,2,2),AmpVertexChaToChaAh(2,2,2,2)& 
 & ,AmpVertexIRosChaToChaAh(2,2,2,2),AmpVertexIRdrChaToChaAh(2,2,2,2), AmpSumChaToChaAh(2,2,2,2), AmpSum2ChaToChaAh(2,2,2,2) 
Complex(dp) :: AmpTreeZChaToChaAh(2,2,2,2),AmpWaveZChaToChaAh(2,2,2,2),AmpVertexZChaToChaAh(2,2,2,2) 
Real(dp) :: AmpSqChaToChaAh(2,2,2),  AmpSqTreeChaToChaAh(2,2,2) 
Real(dp) :: MRPChaToChahh(2,2,2),MRGChaToChahh(2,2,2), MRPZChaToChahh(2,2,2),MRGZChaToChahh(2,2,2) 
Real(dp) :: MVPChaToChahh(2,2,2) 
Real(dp) :: RMsqTreeChaToChahh(2,2,2),RMsqWaveChaToChahh(2,2,2),RMsqVertexChaToChahh(2,2,2) 
Complex(dp) :: AmpTreeChaToChahh(2,2,2,2),AmpWaveChaToChahh(2,2,2,2),AmpVertexChaToChahh(2,2,2,2)& 
 & ,AmpVertexIRosChaToChahh(2,2,2,2),AmpVertexIRdrChaToChahh(2,2,2,2), AmpSumChaToChahh(2,2,2,2), AmpSum2ChaToChahh(2,2,2,2) 
Complex(dp) :: AmpTreeZChaToChahh(2,2,2,2),AmpWaveZChaToChahh(2,2,2,2),AmpVertexZChaToChahh(2,2,2,2) 
Real(dp) :: AmpSqChaToChahh(2,2,2),  AmpSqTreeChaToChahh(2,2,2) 
Real(dp) :: MRPChaToChaVZ(2,2),MRGChaToChaVZ(2,2), MRPZChaToChaVZ(2,2),MRGZChaToChaVZ(2,2) 
Real(dp) :: MVPChaToChaVZ(2,2) 
Real(dp) :: RMsqTreeChaToChaVZ(2,2),RMsqWaveChaToChaVZ(2,2),RMsqVertexChaToChaVZ(2,2) 
Complex(dp) :: AmpTreeChaToChaVZ(4,2,2),AmpWaveChaToChaVZ(4,2,2),AmpVertexChaToChaVZ(4,2,2)& 
 & ,AmpVertexIRosChaToChaVZ(4,2,2),AmpVertexIRdrChaToChaVZ(4,2,2), AmpSumChaToChaVZ(4,2,2), AmpSum2ChaToChaVZ(4,2,2) 
Complex(dp) :: AmpTreeZChaToChaVZ(4,2,2),AmpWaveZChaToChaVZ(4,2,2),AmpVertexZChaToChaVZ(4,2,2) 
Real(dp) :: AmpSqChaToChaVZ(2,2),  AmpSqTreeChaToChaVZ(2,2) 
Real(dp) :: MRPChaToChiHpm(2,4,2),MRGChaToChiHpm(2,4,2), MRPZChaToChiHpm(2,4,2),MRGZChaToChiHpm(2,4,2) 
Real(dp) :: MVPChaToChiHpm(2,4,2) 
Real(dp) :: RMsqTreeChaToChiHpm(2,4,2),RMsqWaveChaToChiHpm(2,4,2),RMsqVertexChaToChiHpm(2,4,2) 
Complex(dp) :: AmpTreeChaToChiHpm(2,2,4,2),AmpWaveChaToChiHpm(2,2,4,2),AmpVertexChaToChiHpm(2,2,4,2)& 
 & ,AmpVertexIRosChaToChiHpm(2,2,4,2),AmpVertexIRdrChaToChiHpm(2,2,4,2), AmpSumChaToChiHpm(2,2,4,2), AmpSum2ChaToChiHpm(2,2,4,2) 
Complex(dp) :: AmpTreeZChaToChiHpm(2,2,4,2),AmpWaveZChaToChiHpm(2,2,4,2),AmpVertexZChaToChiHpm(2,2,4,2) 
Real(dp) :: AmpSqChaToChiHpm(2,4,2),  AmpSqTreeChaToChiHpm(2,4,2) 
Real(dp) :: MRPChaToChiVWm(2,4),MRGChaToChiVWm(2,4), MRPZChaToChiVWm(2,4),MRGZChaToChiVWm(2,4) 
Real(dp) :: MVPChaToChiVWm(2,4) 
Real(dp) :: RMsqTreeChaToChiVWm(2,4),RMsqWaveChaToChiVWm(2,4),RMsqVertexChaToChiVWm(2,4) 
Complex(dp) :: AmpTreeChaToChiVWm(4,2,4),AmpWaveChaToChiVWm(4,2,4),AmpVertexChaToChiVWm(4,2,4)& 
 & ,AmpVertexIRosChaToChiVWm(4,2,4),AmpVertexIRdrChaToChiVWm(4,2,4), AmpSumChaToChiVWm(4,2,4), AmpSum2ChaToChiVWm(4,2,4) 
Complex(dp) :: AmpTreeZChaToChiVWm(4,2,4),AmpWaveZChaToChiVWm(4,2,4),AmpVertexZChaToChiVWm(4,2,4) 
Real(dp) :: AmpSqChaToChiVWm(2,4),  AmpSqTreeChaToChiVWm(2,4) 
Real(dp) :: MRPChaToFdcSu(2,3,6),MRGChaToFdcSu(2,3,6), MRPZChaToFdcSu(2,3,6),MRGZChaToFdcSu(2,3,6) 
Real(dp) :: MVPChaToFdcSu(2,3,6) 
Real(dp) :: RMsqTreeChaToFdcSu(2,3,6),RMsqWaveChaToFdcSu(2,3,6),RMsqVertexChaToFdcSu(2,3,6) 
Complex(dp) :: AmpTreeChaToFdcSu(2,2,3,6),AmpWaveChaToFdcSu(2,2,3,6),AmpVertexChaToFdcSu(2,2,3,6)& 
 & ,AmpVertexIRosChaToFdcSu(2,2,3,6),AmpVertexIRdrChaToFdcSu(2,2,3,6), AmpSumChaToFdcSu(2,2,3,6), AmpSum2ChaToFdcSu(2,2,3,6) 
Complex(dp) :: AmpTreeZChaToFdcSu(2,2,3,6),AmpWaveZChaToFdcSu(2,2,3,6),AmpVertexZChaToFdcSu(2,2,3,6) 
Real(dp) :: AmpSqChaToFdcSu(2,3,6),  AmpSqTreeChaToFdcSu(2,3,6) 
Real(dp) :: MRPChaToFecSv(2,3,3),MRGChaToFecSv(2,3,3), MRPZChaToFecSv(2,3,3),MRGZChaToFecSv(2,3,3) 
Real(dp) :: MVPChaToFecSv(2,3,3) 
Real(dp) :: RMsqTreeChaToFecSv(2,3,3),RMsqWaveChaToFecSv(2,3,3),RMsqVertexChaToFecSv(2,3,3) 
Complex(dp) :: AmpTreeChaToFecSv(2,2,3,3),AmpWaveChaToFecSv(2,2,3,3),AmpVertexChaToFecSv(2,2,3,3)& 
 & ,AmpVertexIRosChaToFecSv(2,2,3,3),AmpVertexIRdrChaToFecSv(2,2,3,3), AmpSumChaToFecSv(2,2,3,3), AmpSum2ChaToFecSv(2,2,3,3) 
Complex(dp) :: AmpTreeZChaToFecSv(2,2,3,3),AmpWaveZChaToFecSv(2,2,3,3),AmpVertexZChaToFecSv(2,2,3,3) 
Real(dp) :: AmpSqChaToFecSv(2,3,3),  AmpSqTreeChaToFecSv(2,3,3) 
Real(dp) :: MRPChaToFvSe(2,3,6),MRGChaToFvSe(2,3,6), MRPZChaToFvSe(2,3,6),MRGZChaToFvSe(2,3,6) 
Real(dp) :: MVPChaToFvSe(2,3,6) 
Real(dp) :: RMsqTreeChaToFvSe(2,3,6),RMsqWaveChaToFvSe(2,3,6),RMsqVertexChaToFvSe(2,3,6) 
Complex(dp) :: AmpTreeChaToFvSe(2,2,3,6),AmpWaveChaToFvSe(2,2,3,6),AmpVertexChaToFvSe(2,2,3,6)& 
 & ,AmpVertexIRosChaToFvSe(2,2,3,6),AmpVertexIRdrChaToFvSe(2,2,3,6), AmpSumChaToFvSe(2,2,3,6), AmpSum2ChaToFvSe(2,2,3,6) 
Complex(dp) :: AmpTreeZChaToFvSe(2,2,3,6),AmpWaveZChaToFvSe(2,2,3,6),AmpVertexZChaToFvSe(2,2,3,6) 
Real(dp) :: AmpSqChaToFvSe(2,3,6),  AmpSqTreeChaToFvSe(2,3,6) 
Real(dp) :: MRPChaTocFuSd(2,3,6),MRGChaTocFuSd(2,3,6), MRPZChaTocFuSd(2,3,6),MRGZChaTocFuSd(2,3,6) 
Real(dp) :: MVPChaTocFuSd(2,3,6) 
Real(dp) :: RMsqTreeChaTocFuSd(2,3,6),RMsqWaveChaTocFuSd(2,3,6),RMsqVertexChaTocFuSd(2,3,6) 
Complex(dp) :: AmpTreeChaTocFuSd(2,2,3,6),AmpWaveChaTocFuSd(2,2,3,6),AmpVertexChaTocFuSd(2,2,3,6)& 
 & ,AmpVertexIRosChaTocFuSd(2,2,3,6),AmpVertexIRdrChaTocFuSd(2,2,3,6), AmpSumChaTocFuSd(2,2,3,6), AmpSum2ChaTocFuSd(2,2,3,6) 
Complex(dp) :: AmpTreeZChaTocFuSd(2,2,3,6),AmpWaveZChaTocFuSd(2,2,3,6),AmpVertexZChaTocFuSd(2,2,3,6) 
Real(dp) :: AmpSqChaTocFuSd(2,3,6),  AmpSqTreeChaTocFuSd(2,3,6) 
Real(dp) :: MRPChaToChaSv(2,2,3),MRGChaToChaSv(2,2,3), MRPZChaToChaSv(2,2,3),MRGZChaToChaSv(2,2,3) 
Real(dp) :: MVPChaToChaSv(2,2,3) 
Real(dp) :: RMsqTreeChaToChaSv(2,2,3),RMsqWaveChaToChaSv(2,2,3),RMsqVertexChaToChaSv(2,2,3) 
Complex(dp) :: AmpTreeChaToChaSv(2,2,2,3),AmpWaveChaToChaSv(2,2,2,3),AmpVertexChaToChaSv(2,2,2,3)& 
 & ,AmpVertexIRosChaToChaSv(2,2,2,3),AmpVertexIRdrChaToChaSv(2,2,2,3), AmpSumChaToChaSv(2,2,2,3), AmpSum2ChaToChaSv(2,2,2,3) 
Complex(dp) :: AmpTreeZChaToChaSv(2,2,2,3),AmpWaveZChaToChaSv(2,2,2,3),AmpVertexZChaToChaSv(2,2,2,3) 
Real(dp) :: AmpSqChaToChaSv(2,2,3),  AmpSqTreeChaToChaSv(2,2,3) 
Real(dp) :: MRPChaToChaVP(2,2),MRGChaToChaVP(2,2), MRPZChaToChaVP(2,2),MRGZChaToChaVP(2,2) 
Real(dp) :: MVPChaToChaVP(2,2) 
Real(dp) :: RMsqTreeChaToChaVP(2,2),RMsqWaveChaToChaVP(2,2),RMsqVertexChaToChaVP(2,2) 
Complex(dp) :: AmpTreeChaToChaVP(4,2,2),AmpWaveChaToChaVP(4,2,2),AmpVertexChaToChaVP(4,2,2)& 
 & ,AmpVertexIRosChaToChaVP(4,2,2),AmpVertexIRdrChaToChaVP(4,2,2), AmpSumChaToChaVP(4,2,2), AmpSum2ChaToChaVP(4,2,2) 
Complex(dp) :: AmpTreeZChaToChaVP(4,2,2),AmpWaveZChaToChaVP(4,2,2),AmpVertexZChaToChaVP(4,2,2) 
Real(dp) :: AmpSqChaToChaVP(2,2),  AmpSqTreeChaToChaVP(2,2) 
Real(dp) :: MRPChaToChacSv(2,2,3),MRGChaToChacSv(2,2,3), MRPZChaToChacSv(2,2,3),MRGZChaToChacSv(2,2,3) 
Real(dp) :: MVPChaToChacSv(2,2,3) 
Real(dp) :: RMsqTreeChaToChacSv(2,2,3),RMsqWaveChaToChacSv(2,2,3),RMsqVertexChaToChacSv(2,2,3) 
Complex(dp) :: AmpTreeChaToChacSv(2,2,2,3),AmpWaveChaToChacSv(2,2,2,3),AmpVertexChaToChacSv(2,2,2,3)& 
 & ,AmpVertexIRosChaToChacSv(2,2,2,3),AmpVertexIRdrChaToChacSv(2,2,2,3), AmpSumChaToChacSv(2,2,2,3), AmpSum2ChaToChacSv(2,2,2,3) 
Complex(dp) :: AmpTreeZChaToChacSv(2,2,2,3),AmpWaveZChaToChacSv(2,2,2,3),AmpVertexZChaToChacSv(2,2,2,3) 
Real(dp) :: AmpSqChaToChacSv(2,2,3),  AmpSqTreeChaToChacSv(2,2,3) 
Real(dp) :: MRPChaToChiSe(2,4,6),MRGChaToChiSe(2,4,6), MRPZChaToChiSe(2,4,6),MRGZChaToChiSe(2,4,6) 
Real(dp) :: MVPChaToChiSe(2,4,6) 
Real(dp) :: RMsqTreeChaToChiSe(2,4,6),RMsqWaveChaToChiSe(2,4,6),RMsqVertexChaToChiSe(2,4,6) 
Complex(dp) :: AmpTreeChaToChiSe(2,2,4,6),AmpWaveChaToChiSe(2,2,4,6),AmpVertexChaToChiSe(2,2,4,6)& 
 & ,AmpVertexIRosChaToChiSe(2,2,4,6),AmpVertexIRdrChaToChiSe(2,2,4,6), AmpSumChaToChiSe(2,2,4,6), AmpSum2ChaToChiSe(2,2,4,6) 
Complex(dp) :: AmpTreeZChaToChiSe(2,2,4,6),AmpWaveZChaToChiSe(2,2,4,6),AmpVertexZChaToChiSe(2,2,4,6) 
Real(dp) :: AmpSqChaToChiSe(2,4,6),  AmpSqTreeChaToChiSe(2,4,6) 
Real(dp) :: MRPChaToFeAh(2,3,2),MRGChaToFeAh(2,3,2), MRPZChaToFeAh(2,3,2),MRGZChaToFeAh(2,3,2) 
Real(dp) :: MVPChaToFeAh(2,3,2) 
Real(dp) :: RMsqTreeChaToFeAh(2,3,2),RMsqWaveChaToFeAh(2,3,2),RMsqVertexChaToFeAh(2,3,2) 
Complex(dp) :: AmpTreeChaToFeAh(2,2,3,2),AmpWaveChaToFeAh(2,2,3,2),AmpVertexChaToFeAh(2,2,3,2)& 
 & ,AmpVertexIRosChaToFeAh(2,2,3,2),AmpVertexIRdrChaToFeAh(2,2,3,2), AmpSumChaToFeAh(2,2,3,2), AmpSum2ChaToFeAh(2,2,3,2) 
Complex(dp) :: AmpTreeZChaToFeAh(2,2,3,2),AmpWaveZChaToFeAh(2,2,3,2),AmpVertexZChaToFeAh(2,2,3,2) 
Real(dp) :: AmpSqChaToFeAh(2,3,2),  AmpSqTreeChaToFeAh(2,3,2) 
Real(dp) :: MRPChaToFehh(2,3,2),MRGChaToFehh(2,3,2), MRPZChaToFehh(2,3,2),MRGZChaToFehh(2,3,2) 
Real(dp) :: MVPChaToFehh(2,3,2) 
Real(dp) :: RMsqTreeChaToFehh(2,3,2),RMsqWaveChaToFehh(2,3,2),RMsqVertexChaToFehh(2,3,2) 
Complex(dp) :: AmpTreeChaToFehh(2,2,3,2),AmpWaveChaToFehh(2,2,3,2),AmpVertexChaToFehh(2,2,3,2)& 
 & ,AmpVertexIRosChaToFehh(2,2,3,2),AmpVertexIRdrChaToFehh(2,2,3,2), AmpSumChaToFehh(2,2,3,2), AmpSum2ChaToFehh(2,2,3,2) 
Complex(dp) :: AmpTreeZChaToFehh(2,2,3,2),AmpWaveZChaToFehh(2,2,3,2),AmpVertexZChaToFehh(2,2,3,2) 
Real(dp) :: AmpSqChaToFehh(2,3,2),  AmpSqTreeChaToFehh(2,3,2) 
Real(dp) :: MRPChaToFeSv(2,3,3),MRGChaToFeSv(2,3,3), MRPZChaToFeSv(2,3,3),MRGZChaToFeSv(2,3,3) 
Real(dp) :: MVPChaToFeSv(2,3,3) 
Real(dp) :: RMsqTreeChaToFeSv(2,3,3),RMsqWaveChaToFeSv(2,3,3),RMsqVertexChaToFeSv(2,3,3) 
Complex(dp) :: AmpTreeChaToFeSv(2,2,3,3),AmpWaveChaToFeSv(2,2,3,3),AmpVertexChaToFeSv(2,2,3,3)& 
 & ,AmpVertexIRosChaToFeSv(2,2,3,3),AmpVertexIRdrChaToFeSv(2,2,3,3), AmpSumChaToFeSv(2,2,3,3), AmpSum2ChaToFeSv(2,2,3,3) 
Complex(dp) :: AmpTreeZChaToFeSv(2,2,3,3),AmpWaveZChaToFeSv(2,2,3,3),AmpVertexZChaToFeSv(2,2,3,3) 
Real(dp) :: AmpSqChaToFeSv(2,3,3),  AmpSqTreeChaToFeSv(2,3,3) 
Real(dp) :: MRPChaToFeVP(2,3),MRGChaToFeVP(2,3), MRPZChaToFeVP(2,3),MRGZChaToFeVP(2,3) 
Real(dp) :: MVPChaToFeVP(2,3) 
Real(dp) :: RMsqTreeChaToFeVP(2,3),RMsqWaveChaToFeVP(2,3),RMsqVertexChaToFeVP(2,3) 
Complex(dp) :: AmpTreeChaToFeVP(4,2,3),AmpWaveChaToFeVP(4,2,3),AmpVertexChaToFeVP(4,2,3)& 
 & ,AmpVertexIRosChaToFeVP(4,2,3),AmpVertexIRdrChaToFeVP(4,2,3), AmpSumChaToFeVP(4,2,3), AmpSum2ChaToFeVP(4,2,3) 
Complex(dp) :: AmpTreeZChaToFeVP(4,2,3),AmpWaveZChaToFeVP(4,2,3),AmpVertexZChaToFeVP(4,2,3) 
Real(dp) :: AmpSqChaToFeVP(2,3),  AmpSqTreeChaToFeVP(2,3) 
Real(dp) :: MRPChaToFeVZ(2,3),MRGChaToFeVZ(2,3), MRPZChaToFeVZ(2,3),MRGZChaToFeVZ(2,3) 
Real(dp) :: MVPChaToFeVZ(2,3) 
Real(dp) :: RMsqTreeChaToFeVZ(2,3),RMsqWaveChaToFeVZ(2,3),RMsqVertexChaToFeVZ(2,3) 
Complex(dp) :: AmpTreeChaToFeVZ(4,2,3),AmpWaveChaToFeVZ(4,2,3),AmpVertexChaToFeVZ(4,2,3)& 
 & ,AmpVertexIRosChaToFeVZ(4,2,3),AmpVertexIRdrChaToFeVZ(4,2,3), AmpSumChaToFeVZ(4,2,3), AmpSum2ChaToFeVZ(4,2,3) 
Complex(dp) :: AmpTreeZChaToFeVZ(4,2,3),AmpWaveZChaToFeVZ(4,2,3),AmpVertexZChaToFeVZ(4,2,3) 
Real(dp) :: AmpSqChaToFeVZ(2,3),  AmpSqTreeChaToFeVZ(2,3) 
Real(dp) :: MRPChaToFvHpm(2,3,2),MRGChaToFvHpm(2,3,2), MRPZChaToFvHpm(2,3,2),MRGZChaToFvHpm(2,3,2) 
Real(dp) :: MVPChaToFvHpm(2,3,2) 
Real(dp) :: RMsqTreeChaToFvHpm(2,3,2),RMsqWaveChaToFvHpm(2,3,2),RMsqVertexChaToFvHpm(2,3,2) 
Complex(dp) :: AmpTreeChaToFvHpm(2,2,3,2),AmpWaveChaToFvHpm(2,2,3,2),AmpVertexChaToFvHpm(2,2,3,2)& 
 & ,AmpVertexIRosChaToFvHpm(2,2,3,2),AmpVertexIRdrChaToFvHpm(2,2,3,2), AmpSumChaToFvHpm(2,2,3,2), AmpSum2ChaToFvHpm(2,2,3,2) 
Complex(dp) :: AmpTreeZChaToFvHpm(2,2,3,2),AmpWaveZChaToFvHpm(2,2,3,2),AmpVertexZChaToFvHpm(2,2,3,2) 
Real(dp) :: AmpSqChaToFvHpm(2,3,2),  AmpSqTreeChaToFvHpm(2,3,2) 
Real(dp) :: MRPChaToFvVWm(2,3),MRGChaToFvVWm(2,3), MRPZChaToFvVWm(2,3),MRGZChaToFvVWm(2,3) 
Real(dp) :: MVPChaToFvVWm(2,3) 
Real(dp) :: RMsqTreeChaToFvVWm(2,3),RMsqWaveChaToFvVWm(2,3),RMsqVertexChaToFvVWm(2,3) 
Complex(dp) :: AmpTreeChaToFvVWm(4,2,3),AmpWaveChaToFvVWm(4,2,3),AmpVertexChaToFvVWm(4,2,3)& 
 & ,AmpVertexIRosChaToFvVWm(4,2,3),AmpVertexIRdrChaToFvVWm(4,2,3), AmpSumChaToFvVWm(4,2,3), AmpSum2ChaToFvVWm(4,2,3) 
Complex(dp) :: AmpTreeZChaToFvVWm(4,2,3),AmpWaveZChaToFvVWm(4,2,3),AmpVertexZChaToFvVWm(4,2,3) 
Real(dp) :: AmpSqChaToFvVWm(2,3),  AmpSqTreeChaToFvVWm(2,3) 
Write(*,*) "Calculating one-loop decays of Cha " 
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
! Cha Ah
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToChaAh(cplcChaChaAhL,cplcChaChaAhR,MAh,            & 
& MCha,MAh2,MCha2,AmpTreeChaToChaAh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToChaAh(ZcplcChaChaAhL,ZcplcChaChaAhR,              & 
& MAh,MCha,MAh2,MCha2,AmpTreeChaToChaAh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChaAh(MLambda,em,gs,cplcChaChaAhL,cplcChaChaAhR,      & 
& MAhOS,MChaOS,MRPChaToChaAh,MRGChaToChaAh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChaAh(MLambda,em,gs,ZcplcChaChaAhL,ZcplcChaChaAhR,    & 
& MAhOS,MChaOS,MRPChaToChaAh,MRGChaToChaAh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToChaAh(MLambda,em,gs,cplcChaChaAhL,cplcChaChaAhR,      & 
& MAh,MCha,MRPChaToChaAh,MRGChaToChaAh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChaAh(MLambda,em,gs,ZcplcChaChaAhL,ZcplcChaChaAhR,    & 
& MAh,MCha,MRPChaToChaAh,MRGChaToChaAh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaAh(cplcChaChaAhL,cplcChaChaAhR,ctcplcChaChaAhL,& 
& ctcplcChaChaAhR,MAh,MAh2,MCha,MCha2,ZfAh,ZfLm,ZfLp,AmpWaveChaToChaAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaAh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToChaAh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaAh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRdrChaToChaAh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaAh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChaAh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaAh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,ZcplcChaChaAhL,ZcplcChaChaAhR,     & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChaAh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaAh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChaAh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaAh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChaAh)

 End if 
 End if 
AmpVertexChaToChaAh = AmpVertexChaToChaAh -  AmpVertexIRdrChaToChaAh! +  AmpVertexIRosChaToChaAh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToChaAh=0._dp 
AmpVertexZChaToChaAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChaAh(1,gt2,:,:) = AmpWaveZChaToChaAh(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChaAh(1,gt1,:,:) 
AmpVertexZChaToChaAh(1,gt2,:,:)= AmpVertexZChaToChaAh(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChaAh(1,gt1,:,:) 
AmpWaveZChaToChaAh(2,gt2,:,:) = AmpWaveZChaToChaAh(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChaAh(2,gt1,:,:) 
AmpVertexZChaToChaAh(2,gt2,:,:)= AmpVertexZChaToChaAh(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChaAh(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaToChaAh=AmpWaveZChaToChaAh 
AmpVertexChaToChaAh= AmpVertexZChaToChaAh
! Final State 1 
AmpWaveZChaToChaAh=0._dp 
AmpVertexZChaToChaAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChaAh(1,:,gt2,:) = AmpWaveZChaToChaAh(1,:,gt2,:)+ZRUUM(gt2,gt1)*AmpWaveChaToChaAh(1,:,gt1,:) 
AmpVertexZChaToChaAh(1,:,gt2,:)= AmpVertexZChaToChaAh(1,:,gt2,:)+ZRUUM(gt2,gt1)*AmpVertexChaToChaAh(1,:,gt1,:) 
AmpWaveZChaToChaAh(2,:,gt2,:) = AmpWaveZChaToChaAh(2,:,gt2,:)+ZRUUPc(gt2,gt1)*AmpWaveChaToChaAh(2,:,gt1,:) 
AmpVertexZChaToChaAh(2,:,gt2,:)= AmpVertexZChaToChaAh(2,:,gt2,:)+ZRUUPc(gt2,gt1)*AmpVertexChaToChaAh(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaToChaAh=AmpWaveZChaToChaAh 
AmpVertexChaToChaAh= AmpVertexZChaToChaAh
! Final State 2 
AmpWaveZChaToChaAh=0._dp 
AmpVertexZChaToChaAh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChaAh(:,:,:,gt2) = AmpWaveZChaToChaAh(:,:,:,gt2)+ZRUZA(gt2,gt1)*AmpWaveChaToChaAh(:,:,:,gt1) 
AmpVertexZChaToChaAh(:,:,:,gt2)= AmpVertexZChaToChaAh(:,:,:,gt2)+ZRUZA(gt2,gt1)*AmpVertexChaToChaAh(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaToChaAh=AmpWaveZChaToChaAh 
AmpVertexChaToChaAh= AmpVertexZChaToChaAh
End if
If (ShiftIRdiv) Then 
AmpVertexChaToChaAh = AmpVertexChaToChaAh  +  AmpVertexIRosChaToChaAh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Cha Ah -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToChaAh = AmpTreeChaToChaAh 
 AmpSum2ChaToChaAh = AmpTreeChaToChaAh + 2._dp*AmpWaveChaToChaAh + 2._dp*AmpVertexChaToChaAh  
Else 
 AmpSumChaToChaAh = AmpTreeChaToChaAh + AmpWaveChaToChaAh + AmpVertexChaToChaAh
 AmpSum2ChaToChaAh = AmpTreeChaToChaAh + AmpWaveChaToChaAh + AmpVertexChaToChaAh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChaAh = AmpTreeChaToChaAh
 AmpSum2ChaToChaAh = AmpTreeChaToChaAh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=2,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChaOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MCha(gt2)+MAh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaToChaAh = AmpTreeChaToChaAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MAh(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToChaAh(gt1, gt2, gt3) 
  AmpSum2ChaToChaAh = 2._dp*AmpWaveChaToChaAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MAh(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToChaAh(gt1, gt2, gt3) 
  AmpSum2ChaToChaAh = 2._dp*AmpVertexChaToChaAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MAh(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToChaAh(gt1, gt2, gt3) 
  AmpSum2ChaToChaAh = AmpTreeChaToChaAh + 2._dp*AmpWaveChaToChaAh + 2._dp*AmpVertexChaToChaAh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MAh(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToChaAh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToChaAh = AmpTreeChaToChaAh
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
  AmpSqTreeChaToChaAh(gt1, gt2, gt3) = (1)*AmpSqChaToChaAh(gt1, gt2, gt3)  
  AmpSum2ChaToChaAh = + 2._dp*AmpWaveChaToChaAh + 2._dp*AmpVertexChaToChaAh
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
  AmpSqChaToChaAh(gt1, gt2, gt3) = AmpSqChaToChaAh(gt1, gt2, gt3) + AmpSqTreeChaToChaAh(gt1, gt2, gt3)  
Else  
  AmpSum2ChaToChaAh = AmpTreeChaToChaAh
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MAh(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
  AmpSqTreeChaToChaAh(gt1, gt2, gt3) = (1)*AmpSqChaToChaAh(gt1, gt2, gt3)  
  AmpSum2ChaToChaAh = + 2._dp*AmpWaveChaToChaAh + 2._dp*AmpVertexChaToChaAh
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MAh(gt3),AmpSumChaToChaAh(:,gt1, gt2, gt3),AmpSum2ChaToChaAh(:,gt1, gt2, gt3),AmpSqChaToChaAh(gt1, gt2, gt3)) 
  AmpSqChaToChaAh(gt1, gt2, gt3) = AmpSqChaToChaAh(gt1, gt2, gt3) + AmpSqTreeChaToChaAh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaToChaAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChaAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChaOS(gt2),MAhOS(gt3),helfactor*AmpSqChaToChaAh(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MCha(gt2),MAh(gt3),helfactor*AmpSqChaToChaAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToChaAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChaAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToChaAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChaAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChaAh(gt1, gt2, gt3) + MRGChaToChaAh(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChaAh(gt1, gt2, gt3) + MRGChaToChaAh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Cha hh
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToChahh(cplcChaChahhL,cplcChaChahhR,MCha,           & 
& Mhh,MCha2,Mhh2,AmpTreeChaToChahh)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToChahh(ZcplcChaChahhL,ZcplcChaChahhR,              & 
& MCha,Mhh,MCha2,Mhh2,AmpTreeChaToChahh)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChahh(MLambda,em,gs,cplcChaChahhL,cplcChaChahhR,      & 
& MChaOS,MhhOS,MRPChaToChahh,MRGChaToChahh)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChahh(MLambda,em,gs,ZcplcChaChahhL,ZcplcChaChahhR,    & 
& MChaOS,MhhOS,MRPChaToChahh,MRGChaToChahh)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToChahh(MLambda,em,gs,cplcChaChahhL,cplcChaChahhR,      & 
& MCha,Mhh,MRPChaToChahh,MRGChaToChahh)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChahh(MLambda,em,gs,ZcplcChaChahhL,ZcplcChaChahhR,    & 
& MCha,Mhh,MRPChaToChahh,MRGChaToChahh)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChahh(cplcChaChahhL,cplcChaChahhR,ctcplcChaChahhL,& 
& ctcplcChaChahhR,MCha,MCha2,Mhh,Mhh2,Zfhh,ZfLm,ZfLp,AmpWaveChaToChahh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChahh(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplAhhhVZ,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,    & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFehhL,        & 
& cplcFeFehhR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,            & 
& AmpVertexChaToChahh)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChahh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRdrChaToChahh)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChahh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& AmpVertexIRosChaToChahh)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChahh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRosChaToChahh)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChahh(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& AmpVertexIRosChaToChahh)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChahh(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRosChaToChahh)

 End if 
 End if 
AmpVertexChaToChahh = AmpVertexChaToChahh -  AmpVertexIRdrChaToChahh! +  AmpVertexIRosChaToChahh ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToChahh=0._dp 
AmpVertexZChaToChahh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChahh(1,gt2,:,:) = AmpWaveZChaToChahh(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChahh(1,gt1,:,:) 
AmpVertexZChaToChahh(1,gt2,:,:)= AmpVertexZChaToChahh(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChahh(1,gt1,:,:) 
AmpWaveZChaToChahh(2,gt2,:,:) = AmpWaveZChaToChahh(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChahh(2,gt1,:,:) 
AmpVertexZChaToChahh(2,gt2,:,:)= AmpVertexZChaToChahh(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChahh(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaToChahh=AmpWaveZChaToChahh 
AmpVertexChaToChahh= AmpVertexZChaToChahh
! Final State 1 
AmpWaveZChaToChahh=0._dp 
AmpVertexZChaToChahh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChahh(1,:,gt2,:) = AmpWaveZChaToChahh(1,:,gt2,:)+ZRUUM(gt2,gt1)*AmpWaveChaToChahh(1,:,gt1,:) 
AmpVertexZChaToChahh(1,:,gt2,:)= AmpVertexZChaToChahh(1,:,gt2,:)+ZRUUM(gt2,gt1)*AmpVertexChaToChahh(1,:,gt1,:) 
AmpWaveZChaToChahh(2,:,gt2,:) = AmpWaveZChaToChahh(2,:,gt2,:)+ZRUUPc(gt2,gt1)*AmpWaveChaToChahh(2,:,gt1,:) 
AmpVertexZChaToChahh(2,:,gt2,:)= AmpVertexZChaToChahh(2,:,gt2,:)+ZRUUPc(gt2,gt1)*AmpVertexChaToChahh(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaToChahh=AmpWaveZChaToChahh 
AmpVertexChaToChahh= AmpVertexZChaToChahh
! Final State 2 
AmpWaveZChaToChahh=0._dp 
AmpVertexZChaToChahh=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChahh(:,:,:,gt2) = AmpWaveZChaToChahh(:,:,:,gt2)+ZRUZH(gt2,gt1)*AmpWaveChaToChahh(:,:,:,gt1) 
AmpVertexZChaToChahh(:,:,:,gt2)= AmpVertexZChaToChahh(:,:,:,gt2)+ZRUZH(gt2,gt1)*AmpVertexChaToChahh(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaToChahh=AmpWaveZChaToChahh 
AmpVertexChaToChahh= AmpVertexZChaToChahh
End if
If (ShiftIRdiv) Then 
AmpVertexChaToChahh = AmpVertexChaToChahh  +  AmpVertexIRosChaToChahh
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Cha hh -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToChahh = AmpTreeChaToChahh 
 AmpSum2ChaToChahh = AmpTreeChaToChahh + 2._dp*AmpWaveChaToChahh + 2._dp*AmpVertexChaToChahh  
Else 
 AmpSumChaToChahh = AmpTreeChaToChahh + AmpWaveChaToChahh + AmpVertexChaToChahh
 AmpSum2ChaToChahh = AmpTreeChaToChahh + AmpWaveChaToChahh + AmpVertexChaToChahh 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChahh = AmpTreeChaToChahh
 AmpSum2ChaToChahh = AmpTreeChaToChahh 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChaOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MCha(gt2)+Mhh(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaToChahh = AmpTreeChaToChahh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),Mhh(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToChahh(gt1, gt2, gt3) 
  AmpSum2ChaToChahh = 2._dp*AmpWaveChaToChahh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),Mhh(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToChahh(gt1, gt2, gt3) 
  AmpSum2ChaToChahh = 2._dp*AmpVertexChaToChahh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),Mhh(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToChahh(gt1, gt2, gt3) 
  AmpSum2ChaToChahh = AmpTreeChaToChahh + 2._dp*AmpWaveChaToChahh + 2._dp*AmpVertexChaToChahh
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),Mhh(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToChahh(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToChahh = AmpTreeChaToChahh
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
  AmpSqTreeChaToChahh(gt1, gt2, gt3) = (1)*AmpSqChaToChahh(gt1, gt2, gt3)  
  AmpSum2ChaToChahh = + 2._dp*AmpWaveChaToChahh + 2._dp*AmpVertexChaToChahh
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
  AmpSqChaToChahh(gt1, gt2, gt3) = AmpSqChaToChahh(gt1, gt2, gt3) + AmpSqTreeChaToChahh(gt1, gt2, gt3)  
Else  
  AmpSum2ChaToChahh = AmpTreeChaToChahh
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),Mhh(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
  AmpSqTreeChaToChahh(gt1, gt2, gt3) = (1)*AmpSqChaToChahh(gt1, gt2, gt3)  
  AmpSum2ChaToChahh = + 2._dp*AmpWaveChaToChahh + 2._dp*AmpVertexChaToChahh
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),Mhh(gt3),AmpSumChaToChahh(:,gt1, gt2, gt3),AmpSum2ChaToChahh(:,gt1, gt2, gt3),AmpSqChaToChahh(gt1, gt2, gt3)) 
  AmpSqChaToChahh(gt1, gt2, gt3) = AmpSqChaToChahh(gt1, gt2, gt3) + AmpSqTreeChaToChahh(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaToChahh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChahh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChaOS(gt2),MhhOS(gt3),helfactor*AmpSqChaToChahh(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MCha(gt2),Mhh(gt3),helfactor*AmpSqChaToChahh(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToChahh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChahh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToChahh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChahh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChahh(gt1, gt2, gt3) + MRGChaToChahh(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChahh(gt1, gt2, gt3) + MRGChaToChahh(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Cha VZ
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToChaVZ(cplcChaChaVZL,cplcChaChaVZR,MCha,           & 
& MVZ,MCha2,MVZ2,AmpTreeChaToChaVZ)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToChaVZ(ZcplcChaChaVZL,ZcplcChaChaVZR,              & 
& MCha,MVZ,MCha2,MVZ2,AmpTreeChaToChaVZ)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChaVZ(MLambda,em,gs,cplcChaChaVZL,cplcChaChaVZR,      & 
& MChaOS,MVZOS,MRPChaToChaVZ,MRGChaToChaVZ)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChaVZ(MLambda,em,gs,ZcplcChaChaVZL,ZcplcChaChaVZR,    & 
& MChaOS,MVZOS,MRPChaToChaVZ,MRGChaToChaVZ)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToChaVZ(MLambda,em,gs,cplcChaChaVZL,cplcChaChaVZR,      & 
& MCha,MVZ,MRPChaToChaVZ,MRGChaToChaVZ)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChaVZ(MLambda,em,gs,ZcplcChaChaVZL,ZcplcChaChaVZR,    & 
& MCha,MVZ,MRPChaToChaVZ,MRGChaToChaVZ)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaVZ(cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,ctcplcChaChaVPL,ctcplcChaChaVPR,ctcplcChaChaVZL,ctcplcChaChaVZR,         & 
& MCha,MCha2,MVP,MVP2,MVZ,MVZ2,ZfLm,ZfLp,ZfVPVZ,ZfVZ,AmpWaveChaToChaVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaVZ(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,             & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeVZL,        & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,            & 
& cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,              & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexChaToChaVZ)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaVZ(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,       & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeVZL,        & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,            & 
& cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,              & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRdrChaToChaVZ)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaVZ(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,cplChiChacHpmL,       & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,       & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,ZcplcChaChaVZL,ZcplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,              & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeVZL,cplcFeFeVZR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,              & 
& cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,             & 
& cplcVWmVWmVZ,AmpVertexIRosChaToChaVZ)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaVZ(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,       & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,ZcplcChaChaVZL,     & 
& ZcplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL, & 
& cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeVZL,        & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,            & 
& cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,              & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosChaToChaVZ)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaVZ(MAhOS,MChaOS,MChiOS,MFdOS,             & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,cplChiChacHpmL,       & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,       & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,     & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,              & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeVZL,cplcFeFeVZR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,              & 
& cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,             & 
& cplcVWmVWmVZ,AmpVertexIRosChaToChaVZ)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChaVZ(MAh,MCha,MChi,MFd,MFe,MFu,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhhhVZ,       & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,              & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,  & 
& cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeVZL,        & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,            & 
& cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,cplhhVZVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,              & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosChaToChaVZ)

 End if 
 End if 
AmpVertexChaToChaVZ = AmpVertexChaToChaVZ -  AmpVertexIRdrChaToChaVZ! +  AmpVertexIRosChaToChaVZ ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToChaVZ=0._dp 
AmpVertexZChaToChaVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChaVZ(1,gt2,:) = AmpWaveZChaToChaVZ(1,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChaVZ(1,gt1,:) 
AmpVertexZChaToChaVZ(1,gt2,:)= AmpVertexZChaToChaVZ(1,gt2,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChaVZ(1,gt1,:) 
AmpWaveZChaToChaVZ(2,gt2,:) = AmpWaveZChaToChaVZ(2,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChaVZ(2,gt1,:) 
AmpVertexZChaToChaVZ(2,gt2,:)= AmpVertexZChaToChaVZ(2,gt2,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChaVZ(2,gt1,:) 
AmpWaveZChaToChaVZ(3,gt2,:) = AmpWaveZChaToChaVZ(3,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChaVZ(3,gt1,:) 
AmpVertexZChaToChaVZ(3,gt2,:)= AmpVertexZChaToChaVZ(3,gt2,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChaVZ(3,gt1,:) 
AmpWaveZChaToChaVZ(4,gt2,:) = AmpWaveZChaToChaVZ(4,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChaVZ(4,gt1,:) 
AmpVertexZChaToChaVZ(4,gt2,:)= AmpVertexZChaToChaVZ(4,gt2,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChaVZ(4,gt1,:) 
 End Do 
End Do 
AmpWaveChaToChaVZ=AmpWaveZChaToChaVZ 
AmpVertexChaToChaVZ= AmpVertexZChaToChaVZ
! Final State 1 
AmpWaveZChaToChaVZ=0._dp 
AmpVertexZChaToChaVZ=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChaVZ(1,:,gt2) = AmpWaveZChaToChaVZ(1,:,gt2)+ZRUUM(gt2,gt1)*AmpWaveChaToChaVZ(1,:,gt1) 
AmpVertexZChaToChaVZ(1,:,gt2)= AmpVertexZChaToChaVZ(1,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexChaToChaVZ(1,:,gt1) 
AmpWaveZChaToChaVZ(2,:,gt2) = AmpWaveZChaToChaVZ(2,:,gt2)+ZRUUPc(gt2,gt1)*AmpWaveChaToChaVZ(2,:,gt1) 
AmpVertexZChaToChaVZ(2,:,gt2)= AmpVertexZChaToChaVZ(2,:,gt2)+ZRUUPc(gt2,gt1)*AmpVertexChaToChaVZ(2,:,gt1) 
AmpWaveZChaToChaVZ(3,:,gt2) = AmpWaveZChaToChaVZ(3,:,gt2)+ZRUUM(gt2,gt1)*AmpWaveChaToChaVZ(3,:,gt1) 
AmpVertexZChaToChaVZ(3,:,gt2)= AmpVertexZChaToChaVZ(3,:,gt2)+ZRUUM(gt2,gt1)*AmpVertexChaToChaVZ(3,:,gt1) 
AmpWaveZChaToChaVZ(4,:,gt2) = AmpWaveZChaToChaVZ(4,:,gt2)+ZRUUPc(gt2,gt1)*AmpWaveChaToChaVZ(4,:,gt1) 
AmpVertexZChaToChaVZ(4,:,gt2)= AmpVertexZChaToChaVZ(4,:,gt2)+ZRUUPc(gt2,gt1)*AmpVertexChaToChaVZ(4,:,gt1) 
 End Do 
End Do 
AmpWaveChaToChaVZ=AmpWaveZChaToChaVZ 
AmpVertexChaToChaVZ= AmpVertexZChaToChaVZ
End if
If (ShiftIRdiv) Then 
AmpVertexChaToChaVZ = AmpVertexChaToChaVZ  +  AmpVertexIRosChaToChaVZ
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Cha VZ -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToChaVZ = AmpTreeChaToChaVZ 
 AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ + 2._dp*AmpWaveChaToChaVZ + 2._dp*AmpVertexChaToChaVZ  
Else 
 AmpSumChaToChaVZ = AmpTreeChaToChaVZ + AmpWaveChaToChaVZ + AmpVertexChaToChaVZ
 AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ + AmpWaveChaToChaVZ + AmpVertexChaToChaVZ 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChaVZ = AmpTreeChaToChaVZ
 AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChaOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MCha(gt2)+MVZ)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),MVZOS,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVZ,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToChaVZ(gt1, gt2) 
  AmpSum2ChaToChaVZ = 2._dp*AmpWaveChaToChaVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),MVZOS,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVZ,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToChaVZ(gt1, gt2) 
  AmpSum2ChaToChaVZ = 2._dp*AmpVertexChaToChaVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),MVZOS,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVZ,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToChaVZ(gt1, gt2) 
  AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ + 2._dp*AmpWaveChaToChaVZ + 2._dp*AmpVertexChaToChaVZ
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),MVZOS,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVZ,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToChaVZ(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),MVZOS,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
  AmpSqTreeChaToChaVZ(gt1, gt2) = (1)*AmpSqChaToChaVZ(gt1, gt2)  
  AmpSum2ChaToChaVZ = + 2._dp*AmpWaveChaToChaVZ + 2._dp*AmpVertexChaToChaVZ
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),MVZOS,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
  AmpSqChaToChaVZ(gt1, gt2) = AmpSqChaToChaVZ(gt1, gt2) + AmpSqTreeChaToChaVZ(gt1, gt2)  
Else  
  AmpSum2ChaToChaVZ = AmpTreeChaToChaVZ
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVZ,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
  AmpSqTreeChaToChaVZ(gt1, gt2) = (1)*AmpSqChaToChaVZ(gt1, gt2)  
  AmpSum2ChaToChaVZ = + 2._dp*AmpWaveChaToChaVZ + 2._dp*AmpVertexChaToChaVZ
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVZ,AmpSumChaToChaVZ(:,gt1, gt2),AmpSum2ChaToChaVZ(:,gt1, gt2),AmpSqChaToChaVZ(gt1, gt2)) 
  AmpSqChaToChaVZ(gt1, gt2) = AmpSqChaToChaVZ(gt1, gt2) + AmpSqTreeChaToChaVZ(gt1, gt2)  
End if  
Else  
  AmpSqChaToChaVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChaVZ(gt1, gt2).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChaOS(gt2),MVZOS,helfactor*AmpSqChaToChaVZ(gt1, gt2))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MCha(gt2),MVZ,helfactor*AmpSqChaToChaVZ(gt1, gt2))
End if 
If ((Abs(MRPChaToChaVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToChaVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToChaVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToChaVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChaVZ(gt1, gt2) + MRGChaToChaVZ(gt1, gt2)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChaVZ(gt1, gt2) + MRGChaToChaVZ(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Chi Hpm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToChiHpm(cplcChaChiHpmL,cplcChaChiHpmR,             & 
& MCha,MChi,MHpm,MCha2,MChi2,MHpm2,AmpTreeChaToChiHpm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToChiHpm(ZcplcChaChiHpmL,ZcplcChaChiHpmR,           & 
& MCha,MChi,MHpm,MCha2,MChi2,MHpm2,AmpTreeChaToChiHpm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChiHpm(MLambda,em,gs,cplcChaChiHpmL,cplcChaChiHpmR,   & 
& MChaOS,MChiOS,MHpmOS,MRPChaToChiHpm,MRGChaToChiHpm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChiHpm(MLambda,em,gs,ZcplcChaChiHpmL,ZcplcChaChiHpmR, & 
& MChaOS,MChiOS,MHpmOS,MRPChaToChiHpm,MRGChaToChiHpm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToChiHpm(MLambda,em,gs,cplcChaChiHpmL,cplcChaChiHpmR,   & 
& MCha,MChi,MHpm,MRPChaToChiHpm,MRGChaToChiHpm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChiHpm(MLambda,em,gs,ZcplcChaChiHpmL,ZcplcChaChiHpmR, & 
& MCha,MChi,MHpm,MRPChaToChiHpm,MRGChaToChiHpm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChiHpm(cplcChaChiHpmL,cplcChaChiHpmR,             & 
& ctcplcChaChiHpmL,ctcplcChaChiHpmR,MCha,MCha2,MChi,MChi2,MHpm,MHpm2,ZfHpm,              & 
& ZfL0,ZfLm,ZfLp,AmpWaveChaToChiHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChiHpm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,   & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcChaFvSeL,cplcChaFvSeR,cplhhHpmcHpm,         & 
& cplhhHpmcVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToChiHpm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,   & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcChaFvSeL,cplcChaFvSeR,cplhhHpmcHpm,         & 
& cplhhHpmcVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRdrChaToChiHpm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiHpm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,      & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,ZcplcChaChiHpmL,ZcplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,   & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,     & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcChaFvSeL,cplcChaFvSeR,cplhhHpmcHpm,cplhhHpmcVWm,         & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChiHpm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,ZcplcChaChiHpmL,ZcplcChaChiHpmR,cplcFdChiSdL,    & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,   & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcChaFvSeL,cplcChaFvSeR,cplhhHpmcHpm,         & 
& cplhhHpmcVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChiHpm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiHpm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,      & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,     & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcChaFvSeL,cplcChaFvSeR,cplhhHpmcHpm,cplhhHpmcVWm,         & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChiHpm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiHpm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,        & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,      & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,       & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,   & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcChaFvSeL,cplcChaFvSeR,cplhhHpmcHpm,         & 
& cplhhHpmcVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,           & 
& cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,AmpVertexIRosChaToChiHpm)

 End if 
 End if 
AmpVertexChaToChiHpm = AmpVertexChaToChiHpm -  AmpVertexIRdrChaToChiHpm! +  AmpVertexIRosChaToChiHpm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToChiHpm=0._dp 
AmpVertexZChaToChiHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChiHpm(1,gt2,:,:) = AmpWaveZChaToChiHpm(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChiHpm(1,gt1,:,:) 
AmpVertexZChaToChiHpm(1,gt2,:,:)= AmpVertexZChaToChiHpm(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChiHpm(1,gt1,:,:) 
AmpWaveZChaToChiHpm(2,gt2,:,:) = AmpWaveZChaToChiHpm(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChiHpm(2,gt1,:,:) 
AmpVertexZChaToChiHpm(2,gt2,:,:)= AmpVertexZChaToChiHpm(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChiHpm(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaToChiHpm=AmpWaveZChaToChiHpm 
AmpVertexChaToChiHpm= AmpVertexZChaToChiHpm
! Final State 1 
AmpWaveZChaToChiHpm=0._dp 
AmpVertexZChaToChiHpm=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZChaToChiHpm(1,:,gt2,:) = AmpWaveZChaToChiHpm(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpWaveChaToChiHpm(1,:,gt1,:) 
AmpVertexZChaToChiHpm(1,:,gt2,:)= AmpVertexZChaToChiHpm(1,:,gt2,:)+ZRUZN(gt2,gt1)*AmpVertexChaToChiHpm(1,:,gt1,:) 
AmpWaveZChaToChiHpm(2,:,gt2,:) = AmpWaveZChaToChiHpm(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpWaveChaToChiHpm(2,:,gt1,:) 
AmpVertexZChaToChiHpm(2,:,gt2,:)= AmpVertexZChaToChiHpm(2,:,gt2,:)+ZRUZNc(gt2,gt1)*AmpVertexChaToChiHpm(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaToChiHpm=AmpWaveZChaToChiHpm 
AmpVertexChaToChiHpm= AmpVertexZChaToChiHpm
! Final State 2 
AmpWaveZChaToChiHpm=0._dp 
AmpVertexZChaToChiHpm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChiHpm(:,:,:,gt2) = AmpWaveZChaToChiHpm(:,:,:,gt2)+ZRUZP(gt2,gt1)*AmpWaveChaToChiHpm(:,:,:,gt1) 
AmpVertexZChaToChiHpm(:,:,:,gt2)= AmpVertexZChaToChiHpm(:,:,:,gt2)+ZRUZP(gt2,gt1)*AmpVertexChaToChiHpm(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaToChiHpm=AmpWaveZChaToChiHpm 
AmpVertexChaToChiHpm= AmpVertexZChaToChiHpm
End if
If (ShiftIRdiv) Then 
AmpVertexChaToChiHpm = AmpVertexChaToChiHpm  +  AmpVertexIRosChaToChiHpm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Chi Hpm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToChiHpm = AmpTreeChaToChiHpm 
 AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm + 2._dp*AmpWaveChaToChiHpm + 2._dp*AmpVertexChaToChiHpm  
Else 
 AmpSumChaToChiHpm = AmpTreeChaToChiHpm + AmpWaveChaToChiHpm + AmpVertexChaToChiHpm
 AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm + AmpWaveChaToChiHpm + AmpVertexChaToChiHpm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChiHpm = AmpTreeChaToChiHpm
 AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=2,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChiOS(gt2)+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MChi(gt2)+MHpm(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MHpm(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToChiHpm(gt1, gt2, gt3) 
  AmpSum2ChaToChiHpm = 2._dp*AmpWaveChaToChiHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MHpm(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToChiHpm(gt1, gt2, gt3) 
  AmpSum2ChaToChiHpm = 2._dp*AmpVertexChaToChiHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MHpm(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToChiHpm(gt1, gt2, gt3) 
  AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm + 2._dp*AmpWaveChaToChiHpm + 2._dp*AmpVertexChaToChiHpm
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MHpm(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToChiHpm(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
  AmpSqTreeChaToChiHpm(gt1, gt2, gt3) = (1)*AmpSqChaToChiHpm(gt1, gt2, gt3)  
  AmpSum2ChaToChiHpm = + 2._dp*AmpWaveChaToChiHpm + 2._dp*AmpVertexChaToChiHpm
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
  AmpSqChaToChiHpm(gt1, gt2, gt3) = AmpSqChaToChiHpm(gt1, gt2, gt3) + AmpSqTreeChaToChiHpm(gt1, gt2, gt3)  
Else  
  AmpSum2ChaToChiHpm = AmpTreeChaToChiHpm
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MHpm(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
  AmpSqTreeChaToChiHpm(gt1, gt2, gt3) = (1)*AmpSqChaToChiHpm(gt1, gt2, gt3)  
  AmpSum2ChaToChiHpm = + 2._dp*AmpWaveChaToChiHpm + 2._dp*AmpVertexChaToChiHpm
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MHpm(gt3),AmpSumChaToChiHpm(:,gt1, gt2, gt3),AmpSum2ChaToChiHpm(:,gt1, gt2, gt3),AmpSqChaToChiHpm(gt1, gt2, gt3)) 
  AmpSqChaToChiHpm(gt1, gt2, gt3) = AmpSqChaToChiHpm(gt1, gt2, gt3) + AmpSqTreeChaToChiHpm(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaToChiHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChiHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChiOS(gt2),MHpmOS(gt3),helfactor*AmpSqChaToChiHpm(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MChi(gt2),MHpm(gt3),helfactor*AmpSqChaToChiHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToChiHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChiHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToChiHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChiHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChiHpm(gt1, gt2, gt3) + MRGChaToChiHpm(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChiHpm(gt1, gt2, gt3) + MRGChaToChiHpm(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Chi VWm
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToChiVWm(cplcChaChiVWmL,cplcChaChiVWmR,             & 
& MCha,MChi,MVWm,MCha2,MChi2,MVWm2,AmpTreeChaToChiVWm)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToChiVWm(ZcplcChaChiVWmL,ZcplcChaChiVWmR,           & 
& MCha,MChi,MVWm,MCha2,MChi2,MVWm2,AmpTreeChaToChiVWm)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChiVWm(MLambda,em,gs,cplcChaChiVWmL,cplcChaChiVWmR,   & 
& MChaOS,MChiOS,MVWmOS,MRPChaToChiVWm,MRGChaToChiVWm)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChiVWm(MLambda,em,gs,ZcplcChaChiVWmL,ZcplcChaChiVWmR, & 
& MChaOS,MChiOS,MVWmOS,MRPChaToChiVWm,MRGChaToChiVWm)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToChiVWm(MLambda,em,gs,cplcChaChiVWmL,cplcChaChiVWmR,   & 
& MCha,MChi,MVWm,MRPChaToChiVWm,MRGChaToChiVWm)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToChiVWm(MLambda,em,gs,ZcplcChaChiVWmL,ZcplcChaChiVWmR, & 
& MCha,MChi,MVWm,MRPChaToChiVWm,MRGChaToChiVWm)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChiVWm(cplcChaChiVWmL,cplcChaChiVWmR,             & 
& ctcplcChaChiVWmL,ctcplcChaChiVWmR,MCha,MCha2,MChi,MChi2,MVWm,MVWm2,ZfL0,               & 
& ZfLm,ZfLp,ZfVWm,AmpWaveChaToChiVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChiVWm(MAh,MCha,MChi,MFd,MFe,MFu,               & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,     & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhcHpmVWm,cplhhcVWmVWm,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,         & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexChaToChiVWm)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,     & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhcHpmVWm,cplhhcVWmVWm,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,         & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRdrChaToChiVWm)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,GosZcplcChaChiHpmL,GosZcplcChaChiHpmR,cplcFdChiSdL,          & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,ZcplcChaChiVWmL,      & 
& ZcplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,         & 
& GosZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosChaToChiVWm)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,GZcplcChaChiHpmL,GZcplcChaChiHpmR,cplcFdChiSdL,              & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,ZcplcChaChiVWmL,      & 
& ZcplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,         & 
& GZcplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosChaToChiVWm)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiVWm(MAhOS,MChaOS,MChiOS,MFdOS,            & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,GcplcChaChiHpmL,GcplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,   & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,     & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhcHpmVWm,cplhhcVWmVWm,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,GcplcHpmVPVWm,cplcVWmVPVWm,        & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosChaToChiVWm)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToChiVWm(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,     & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhcHpmVWm,cplhhcVWmVWm,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,         & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,AmpVertexIRosChaToChiVWm)

 End if 
 End if 
AmpVertexChaToChiVWm = AmpVertexChaToChiVWm -  AmpVertexIRdrChaToChiVWm! +  AmpVertexIRosChaToChiVWm ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToChiVWm=0._dp 
AmpVertexZChaToChiVWm=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToChiVWm(1,gt2,:) = AmpWaveZChaToChiVWm(1,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChiVWm(1,gt1,:) 
AmpVertexZChaToChiVWm(1,gt2,:)= AmpVertexZChaToChiVWm(1,gt2,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChiVWm(1,gt1,:) 
AmpWaveZChaToChiVWm(2,gt2,:) = AmpWaveZChaToChiVWm(2,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChiVWm(2,gt1,:) 
AmpVertexZChaToChiVWm(2,gt2,:)= AmpVertexZChaToChiVWm(2,gt2,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChiVWm(2,gt1,:) 
AmpWaveZChaToChiVWm(3,gt2,:) = AmpWaveZChaToChiVWm(3,gt2,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToChiVWm(3,gt1,:) 
AmpVertexZChaToChiVWm(3,gt2,:)= AmpVertexZChaToChiVWm(3,gt2,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToChiVWm(3,gt1,:) 
AmpWaveZChaToChiVWm(4,gt2,:) = AmpWaveZChaToChiVWm(4,gt2,:)+ZRUUP(gt2,gt1)*AmpWaveChaToChiVWm(4,gt1,:) 
AmpVertexZChaToChiVWm(4,gt2,:)= AmpVertexZChaToChiVWm(4,gt2,:) + ZRUUP(gt2,gt1)*AmpVertexChaToChiVWm(4,gt1,:) 
 End Do 
End Do 
AmpWaveChaToChiVWm=AmpWaveZChaToChiVWm 
AmpVertexChaToChiVWm= AmpVertexZChaToChiVWm
! Final State 1 
AmpWaveZChaToChiVWm=0._dp 
AmpVertexZChaToChiVWm=0._dp 
Do gt1=1,4
  Do gt2=1,4
AmpWaveZChaToChiVWm(1,:,gt2) = AmpWaveZChaToChiVWm(1,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveChaToChiVWm(1,:,gt1) 
AmpVertexZChaToChiVWm(1,:,gt2)= AmpVertexZChaToChiVWm(1,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexChaToChiVWm(1,:,gt1) 
AmpWaveZChaToChiVWm(2,:,gt2) = AmpWaveZChaToChiVWm(2,:,gt2)+ZRUZNc(gt2,gt1)*AmpWaveChaToChiVWm(2,:,gt1) 
AmpVertexZChaToChiVWm(2,:,gt2)= AmpVertexZChaToChiVWm(2,:,gt2)+ZRUZNc(gt2,gt1)*AmpVertexChaToChiVWm(2,:,gt1) 
AmpWaveZChaToChiVWm(3,:,gt2) = AmpWaveZChaToChiVWm(3,:,gt2)+ZRUZN(gt2,gt1)*AmpWaveChaToChiVWm(3,:,gt1) 
AmpVertexZChaToChiVWm(3,:,gt2)= AmpVertexZChaToChiVWm(3,:,gt2)+ZRUZN(gt2,gt1)*AmpVertexChaToChiVWm(3,:,gt1) 
AmpWaveZChaToChiVWm(4,:,gt2) = AmpWaveZChaToChiVWm(4,:,gt2)+ZRUZNc(gt2,gt1)*AmpWaveChaToChiVWm(4,:,gt1) 
AmpVertexZChaToChiVWm(4,:,gt2)= AmpVertexZChaToChiVWm(4,:,gt2)+ZRUZNc(gt2,gt1)*AmpVertexChaToChiVWm(4,:,gt1) 
 End Do 
End Do 
AmpWaveChaToChiVWm=AmpWaveZChaToChiVWm 
AmpVertexChaToChiVWm= AmpVertexZChaToChiVWm
End if
If (ShiftIRdiv) Then 
AmpVertexChaToChiVWm = AmpVertexChaToChiVWm  +  AmpVertexIRosChaToChiVWm
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Chi VWm -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToChiVWm = AmpTreeChaToChiVWm 
 AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm + 2._dp*AmpWaveChaToChiVWm + 2._dp*AmpVertexChaToChiVWm  
Else 
 AmpSumChaToChiVWm = AmpTreeChaToChiVWm + AmpWaveChaToChiVWm + AmpVertexChaToChiVWm
 AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm + AmpWaveChaToChiVWm + AmpVertexChaToChiVWm 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChiVWm = AmpTreeChaToChiVWm
 AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChiOS(gt2)+MVWmOS))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MChi(gt2)+MVWm)))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2 
  AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChiOS(gt2),MVWmOS,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MChi(gt2),MVWm,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToChiVWm(gt1, gt2) 
  AmpSum2ChaToChiVWm = 2._dp*AmpWaveChaToChiVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChiOS(gt2),MVWmOS,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MChi(gt2),MVWm,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToChiVWm(gt1, gt2) 
  AmpSum2ChaToChiVWm = 2._dp*AmpVertexChaToChiVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChiOS(gt2),MVWmOS,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MChi(gt2),MVWm,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToChiVWm(gt1, gt2) 
  AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm + 2._dp*AmpWaveChaToChiVWm + 2._dp*AmpVertexChaToChiVWm
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChiOS(gt2),MVWmOS,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MChi(gt2),MVWm,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToChiVWm(gt1, gt2) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm
  Call SquareAmp_FtoFV(MChaOS(gt1),MChiOS(gt2),MVWmOS,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
  AmpSqTreeChaToChiVWm(gt1, gt2) = (1)*AmpSqChaToChiVWm(gt1, gt2)  
  AmpSum2ChaToChiVWm = + 2._dp*AmpWaveChaToChiVWm + 2._dp*AmpVertexChaToChiVWm
  Call SquareAmp_FtoFV(MChaOS(gt1),MChiOS(gt2),MVWmOS,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
  AmpSqChaToChiVWm(gt1, gt2) = AmpSqChaToChiVWm(gt1, gt2) + AmpSqTreeChaToChiVWm(gt1, gt2)  
Else  
  AmpSum2ChaToChiVWm = AmpTreeChaToChiVWm
  Call SquareAmp_FtoFV(MCha(gt1),MChi(gt2),MVWm,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
  AmpSqTreeChaToChiVWm(gt1, gt2) = (1)*AmpSqChaToChiVWm(gt1, gt2)  
  AmpSum2ChaToChiVWm = + 2._dp*AmpWaveChaToChiVWm + 2._dp*AmpVertexChaToChiVWm
  Call SquareAmp_FtoFV(MCha(gt1),MChi(gt2),MVWm,AmpSumChaToChiVWm(:,gt1, gt2),AmpSum2ChaToChiVWm(:,gt1, gt2),AmpSqChaToChiVWm(gt1, gt2)) 
  AmpSqChaToChiVWm(gt1, gt2) = AmpSqChaToChiVWm(gt1, gt2) + AmpSqTreeChaToChiVWm(gt1, gt2)  
End if  
Else  
  AmpSqChaToChiVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChiVWm(gt1, gt2).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChiOS(gt2),MVWmOS,helfactor*AmpSqChaToChiVWm(gt1, gt2))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MChi(gt2),MVWm,helfactor*AmpSqChaToChiVWm(gt1, gt2))
End if 
If ((Abs(MRPChaToChiVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToChiVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToChiVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToChiVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChiVWm(gt1, gt2) + MRGChaToChiVWm(gt1, gt2)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToChiVWm(gt1, gt2) + MRGChaToChiVWm(gt1, gt2))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Fd Conjg(Su)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToFdcSu(cplcChaFdcSuL,cplcChaFdcSuR,MCha,           & 
& MFd,MSu,MCha2,MFd2,MSu2,AmpTreeChaToFdcSu)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToFdcSu(ZcplcChaFdcSuL,ZcplcChaFdcSuR,              & 
& MCha,MFd,MSu,MCha2,MFd2,MSu2,AmpTreeChaToFdcSu)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFdcSu(MLambda,em,gs,cplcChaFdcSuL,cplcChaFdcSuR,      & 
& MChaOS,MFdOS,MSuOS,MRPChaToFdcSu,MRGChaToFdcSu)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFdcSu(MLambda,em,gs,ZcplcChaFdcSuL,ZcplcChaFdcSuR,    & 
& MChaOS,MFdOS,MSuOS,MRPChaToFdcSu,MRGChaToFdcSu)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToFdcSu(MLambda,em,gs,cplcChaFdcSuL,cplcChaFdcSuR,      & 
& MCha,MFd,MSu,MRPChaToFdcSu,MRGChaToFdcSu)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFdcSu(MLambda,em,gs,ZcplcChaFdcSuL,ZcplcChaFdcSuR,    & 
& MCha,MFd,MSu,MRPChaToFdcSu,MRGChaToFdcSu)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFdcSu(cplcChaFdcSuL,cplcChaFdcSuR,ctcplcChaFdcSuL,& 
& ctcplcChaFdcSuR,MCha,MCha2,MFd,MFd2,MSu,MSu2,ZfFDL,ZfFDR,ZfLm,ZfLp,ZfSu,               & 
& AmpWaveChaToFdcSu)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFdcSu(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
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
& cplSucSuVZ,AmpVertexChaToFdcSu)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFdcSu(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSucSuVZ,AmpVertexIRdrChaToFdcSu)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFdcSu(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSucSuVZ,AmpVertexIRosChaToFdcSu)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFdcSu(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSucSuVZ,AmpVertexIRosChaToFdcSu)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFdcSu(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSucSuVZ,AmpVertexIRosChaToFdcSu)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFdcSu(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSucSuVZ,AmpVertexIRosChaToFdcSu)

 End if 
 End if 
AmpVertexChaToFdcSu = AmpVertexChaToFdcSu -  AmpVertexIRdrChaToFdcSu! +  AmpVertexIRosChaToFdcSu ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToFdcSu=0._dp 
AmpVertexZChaToFdcSu=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToFdcSu(1,gt2,:,:) = AmpWaveZChaToFdcSu(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaToFdcSu(1,gt1,:,:) 
AmpVertexZChaToFdcSu(1,gt2,:,:)= AmpVertexZChaToFdcSu(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaToFdcSu(1,gt1,:,:) 
AmpWaveZChaToFdcSu(2,gt2,:,:) = AmpWaveZChaToFdcSu(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToFdcSu(2,gt1,:,:) 
AmpVertexZChaToFdcSu(2,gt2,:,:)= AmpVertexZChaToFdcSu(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToFdcSu(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaToFdcSu=AmpWaveZChaToFdcSu 
AmpVertexChaToFdcSu= AmpVertexZChaToFdcSu
! Final State 1 
AmpWaveZChaToFdcSu=0._dp 
AmpVertexZChaToFdcSu=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZChaToFdcSu(1,:,gt2,:) = AmpWaveZChaToFdcSu(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpWaveChaToFdcSu(1,:,gt1,:) 
AmpVertexZChaToFdcSu(1,:,gt2,:)= AmpVertexZChaToFdcSu(1,:,gt2,:)+ZRUZDL(gt2,gt1)*AmpVertexChaToFdcSu(1,:,gt1,:) 
AmpWaveZChaToFdcSu(2,:,gt2,:) = AmpWaveZChaToFdcSu(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpWaveChaToFdcSu(2,:,gt1,:) 
AmpVertexZChaToFdcSu(2,:,gt2,:)= AmpVertexZChaToFdcSu(2,:,gt2,:)+ZRUZDRc(gt2,gt1)*AmpVertexChaToFdcSu(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaToFdcSu=AmpWaveZChaToFdcSu 
AmpVertexChaToFdcSu= AmpVertexZChaToFdcSu
! Final State 2 
AmpWaveZChaToFdcSu=0._dp 
AmpVertexZChaToFdcSu=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZChaToFdcSu(:,:,:,gt2) = AmpWaveZChaToFdcSu(:,:,:,gt2)+ZRUZUc(gt2,gt1)*AmpWaveChaToFdcSu(:,:,:,gt1) 
AmpVertexZChaToFdcSu(:,:,:,gt2)= AmpVertexZChaToFdcSu(:,:,:,gt2)+ZRUZUc(gt2,gt1)*AmpVertexChaToFdcSu(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaToFdcSu=AmpWaveZChaToFdcSu 
AmpVertexChaToFdcSu= AmpVertexZChaToFdcSu
End if
If (ShiftIRdiv) Then 
AmpVertexChaToFdcSu = AmpVertexChaToFdcSu  +  AmpVertexIRosChaToFdcSu
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fd conj[Su] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToFdcSu = AmpTreeChaToFdcSu 
 AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu + 2._dp*AmpWaveChaToFdcSu + 2._dp*AmpVertexChaToFdcSu  
Else 
 AmpSumChaToFdcSu = AmpTreeChaToFdcSu + AmpWaveChaToFdcSu + AmpVertexChaToFdcSu
 AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu + AmpWaveChaToFdcSu + AmpVertexChaToFdcSu 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFdcSu = AmpTreeChaToFdcSu
 AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFdOS(gt2)+MSuOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFd(gt2)+MSu(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFd(gt2),MSu(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToFdcSu(gt1, gt2, gt3) 
  AmpSum2ChaToFdcSu = 2._dp*AmpWaveChaToFdcSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFd(gt2),MSu(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToFdcSu(gt1, gt2, gt3) 
  AmpSum2ChaToFdcSu = 2._dp*AmpVertexChaToFdcSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFd(gt2),MSu(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToFdcSu(gt1, gt2, gt3) 
  AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu + 2._dp*AmpWaveChaToFdcSu + 2._dp*AmpVertexChaToFdcSu
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFd(gt2),MSu(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToFdcSu(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu
  Call SquareAmp_FtoFS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
  AmpSqTreeChaToFdcSu(gt1, gt2, gt3) = (3)*AmpSqChaToFdcSu(gt1, gt2, gt3)  
  AmpSum2ChaToFdcSu = + 2._dp*AmpWaveChaToFdcSu + 2._dp*AmpVertexChaToFdcSu
  Call SquareAmp_FtoFS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
  AmpSqChaToFdcSu(gt1, gt2, gt3) = AmpSqChaToFdcSu(gt1, gt2, gt3) + AmpSqTreeChaToFdcSu(gt1, gt2, gt3)  
Else  
  AmpSum2ChaToFdcSu = AmpTreeChaToFdcSu
  Call SquareAmp_FtoFS(MCha(gt1),MFd(gt2),MSu(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
  AmpSqTreeChaToFdcSu(gt1, gt2, gt3) = (3)*AmpSqChaToFdcSu(gt1, gt2, gt3)  
  AmpSum2ChaToFdcSu = + 2._dp*AmpWaveChaToFdcSu + 2._dp*AmpVertexChaToFdcSu
  Call SquareAmp_FtoFS(MCha(gt1),MFd(gt2),MSu(gt3),AmpSumChaToFdcSu(:,gt1, gt2, gt3),AmpSum2ChaToFdcSu(:,gt1, gt2, gt3),AmpSqChaToFdcSu(gt1, gt2, gt3)) 
  AmpSqChaToFdcSu(gt1, gt2, gt3) = AmpSqChaToFdcSu(gt1, gt2, gt3) + AmpSqTreeChaToFdcSu(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaToFdcSu(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFdcSu(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFdOS(gt2),MSuOS(gt3),helfactor*AmpSqChaToFdcSu(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFd(gt2),MSu(gt3),helfactor*AmpSqChaToFdcSu(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFdcSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFdcSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToFdcSu(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFdcSu(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToFdcSu(gt1, gt2, gt3) + MRGChaToFdcSu(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToFdcSu(gt1, gt2, gt3) + MRGChaToFdcSu(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Fe Conjg(Sv)
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToFecSv(cplcChaFecSvL,cplcChaFecSvR,MCha,           & 
& MFe,MSv,MCha2,MFe2,MSv2,AmpTreeChaToFecSv)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToFecSv(ZcplcChaFecSvL,ZcplcChaFecSvR,              & 
& MCha,MFe,MSv,MCha2,MFe2,MSv2,AmpTreeChaToFecSv)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFecSv(MLambda,em,gs,cplcChaFecSvL,cplcChaFecSvR,      & 
& MChaOS,MFeOS,MSvOS,MRPChaToFecSv,MRGChaToFecSv)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFecSv(MLambda,em,gs,ZcplcChaFecSvL,ZcplcChaFecSvR,    & 
& MChaOS,MFeOS,MSvOS,MRPChaToFecSv,MRGChaToFecSv)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToFecSv(MLambda,em,gs,cplcChaFecSvL,cplcChaFecSvR,      & 
& MCha,MFe,MSv,MRPChaToFecSv,MRGChaToFecSv)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFecSv(MLambda,em,gs,ZcplcChaFecSvL,ZcplcChaFecSvR,    & 
& MCha,MFe,MSv,MRPChaToFecSv,MRGChaToFecSv)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFecSv(cplcChaFecSvL,cplcChaFecSvR,ctcplcChaFecSvL,& 
& ctcplcChaFecSvR,MCha,MCha2,MFe,MFe2,MSv,MSv2,ZfFEL,ZfFER,ZfLm,ZfLp,ZfSv,               & 
& AmpWaveChaToFecSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFecSv(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
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
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexChaToFecSv)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFecSv(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRdrChaToFecSv)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFecSv(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosChaToFecSv)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFecSv(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosChaToFecSv)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFecSv(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosChaToFecSv)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFecSv(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,AmpVertexIRosChaToFecSv)

 End if 
 End if 
AmpVertexChaToFecSv = AmpVertexChaToFecSv -  AmpVertexIRdrChaToFecSv! +  AmpVertexIRosChaToFecSv ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToFecSv=0._dp 
AmpVertexZChaToFecSv=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToFecSv(1,gt2,:,:) = AmpWaveZChaToFecSv(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaToFecSv(1,gt1,:,:) 
AmpVertexZChaToFecSv(1,gt2,:,:)= AmpVertexZChaToFecSv(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaToFecSv(1,gt1,:,:) 
AmpWaveZChaToFecSv(2,gt2,:,:) = AmpWaveZChaToFecSv(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToFecSv(2,gt1,:,:) 
AmpVertexZChaToFecSv(2,gt2,:,:)= AmpVertexZChaToFecSv(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToFecSv(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaToFecSv=AmpWaveZChaToFecSv 
AmpVertexChaToFecSv= AmpVertexZChaToFecSv
! Final State 1 
AmpWaveZChaToFecSv=0._dp 
AmpVertexZChaToFecSv=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZChaToFecSv(1,:,gt2,:) = AmpWaveZChaToFecSv(1,:,gt2,:)+ZRUZEL(gt2,gt1)*AmpWaveChaToFecSv(1,:,gt1,:) 
AmpVertexZChaToFecSv(1,:,gt2,:)= AmpVertexZChaToFecSv(1,:,gt2,:)+ZRUZEL(gt2,gt1)*AmpVertexChaToFecSv(1,:,gt1,:) 
AmpWaveZChaToFecSv(2,:,gt2,:) = AmpWaveZChaToFecSv(2,:,gt2,:)+ZRUZERc(gt2,gt1)*AmpWaveChaToFecSv(2,:,gt1,:) 
AmpVertexZChaToFecSv(2,:,gt2,:)= AmpVertexZChaToFecSv(2,:,gt2,:)+ZRUZERc(gt2,gt1)*AmpVertexChaToFecSv(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaToFecSv=AmpWaveZChaToFecSv 
AmpVertexChaToFecSv= AmpVertexZChaToFecSv
! Final State 2 
AmpWaveZChaToFecSv=0._dp 
AmpVertexZChaToFecSv=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZChaToFecSv(:,:,:,gt2) = AmpWaveZChaToFecSv(:,:,:,gt2)+ZRUZVc(gt2,gt1)*AmpWaveChaToFecSv(:,:,:,gt1) 
AmpVertexZChaToFecSv(:,:,:,gt2)= AmpVertexZChaToFecSv(:,:,:,gt2)+ZRUZVc(gt2,gt1)*AmpVertexChaToFecSv(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaToFecSv=AmpWaveZChaToFecSv 
AmpVertexChaToFecSv= AmpVertexZChaToFecSv
End if
If (ShiftIRdiv) Then 
AmpVertexChaToFecSv = AmpVertexChaToFecSv  +  AmpVertexIRosChaToFecSv
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fe conj[Sv] -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToFecSv = AmpTreeChaToFecSv 
 AmpSum2ChaToFecSv = AmpTreeChaToFecSv + 2._dp*AmpWaveChaToFecSv + 2._dp*AmpVertexChaToFecSv  
Else 
 AmpSumChaToFecSv = AmpTreeChaToFecSv + AmpWaveChaToFecSv + AmpVertexChaToFecSv
 AmpSum2ChaToFecSv = AmpTreeChaToFecSv + AmpWaveChaToFecSv + AmpVertexChaToFecSv 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFecSv = AmpTreeChaToFecSv
 AmpSum2ChaToFecSv = AmpTreeChaToFecSv 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFeOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFe(gt2)+MSv(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaToFecSv = AmpTreeChaToFecSv
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToFecSv(gt1, gt2, gt3) 
  AmpSum2ChaToFecSv = 2._dp*AmpWaveChaToFecSv
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToFecSv(gt1, gt2, gt3) 
  AmpSum2ChaToFecSv = 2._dp*AmpVertexChaToFecSv
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToFecSv(gt1, gt2, gt3) 
  AmpSum2ChaToFecSv = AmpTreeChaToFecSv + 2._dp*AmpWaveChaToFecSv + 2._dp*AmpVertexChaToFecSv
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToFecSv(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToFecSv = AmpTreeChaToFecSv
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
  AmpSqTreeChaToFecSv(gt1, gt2, gt3) = (1)*AmpSqChaToFecSv(gt1, gt2, gt3)  
  AmpSum2ChaToFecSv = + 2._dp*AmpWaveChaToFecSv + 2._dp*AmpVertexChaToFecSv
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
  AmpSqChaToFecSv(gt1, gt2, gt3) = AmpSqChaToFecSv(gt1, gt2, gt3) + AmpSqTreeChaToFecSv(gt1, gt2, gt3)  
Else  
  AmpSum2ChaToFecSv = AmpTreeChaToFecSv
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
  AmpSqTreeChaToFecSv(gt1, gt2, gt3) = (1)*AmpSqChaToFecSv(gt1, gt2, gt3)  
  AmpSum2ChaToFecSv = + 2._dp*AmpWaveChaToFecSv + 2._dp*AmpVertexChaToFecSv
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFecSv(:,gt1, gt2, gt3),AmpSum2ChaToFecSv(:,gt1, gt2, gt3),AmpSqChaToFecSv(gt1, gt2, gt3)) 
  AmpSqChaToFecSv(gt1, gt2, gt3) = AmpSqChaToFecSv(gt1, gt2, gt3) + AmpSqTreeChaToFecSv(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaToFecSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFecSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),helfactor*AmpSqChaToFecSv(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFe(gt2),MSv(gt3),helfactor*AmpSqChaToFecSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFecSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFecSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToFecSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFecSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToFecSv(gt1, gt2, gt3) + MRGChaToFecSv(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToFecSv(gt1, gt2, gt3) + MRGChaToFecSv(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Fv Se
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaToFvSe(cplcChaFvSeL,cplcChaFvSeR,MCha,              & 
& MSe,MCha2,MSe2,AmpTreeChaToFvSe)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaToFvSe(ZcplcChaFvSeL,ZcplcChaFvSeR,MCha,            & 
& MSe,MCha2,MSe2,AmpTreeChaToFvSe)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFvSe(MLambda,em,gs,cplcChaFvSeL,cplcChaFvSeR,         & 
& MChaOS,MSeOS,MRPChaToFvSe,MRGChaToFvSe)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFvSe(MLambda,em,gs,ZcplcChaFvSeL,ZcplcChaFvSeR,       & 
& MChaOS,MSeOS,MRPChaToFvSe,MRGChaToFvSe)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaToFvSe(MLambda,em,gs,cplcChaFvSeL,cplcChaFvSeR,         & 
& MCha,MSe,MRPChaToFvSe,MRGChaToFvSe)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaToFvSe(MLambda,em,gs,ZcplcChaFvSeL,ZcplcChaFvSeR,       & 
& MCha,MSe,MRPChaToFvSe,MRGChaToFvSe)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvSe(cplcChaFvSeL,cplcChaFvSeR,ctcplcChaFvSeL,    & 
& ctcplcChaFvSeR,MCha,MCha2,MSe,MSe2,ZfFvL,ZfLm,ZfLp,ZfSe,AmpWaveChaToFvSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvSe(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,            & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,     & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,         & 
& cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,               & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,             & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSvcVWm,AmpVertexChaToFvSe)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFvSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,      & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,     & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,         & 
& cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,               & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,             & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSvcVWm,AmpVertexIRdrChaToFvSe)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFvSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,cplFvChacSeL,        & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,    & 
& cplcChaChaVZR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFeChiSeL,      & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,      & 
& cplcChaFdcSuR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,          & 
& cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplFvFvVZL,           & 
& cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,ZcplcChaFvSeL,ZcplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplhhSecSe,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,cplSeSvcSe,              & 
& cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSvcVWm,AmpVertexIRosChaToFvSe)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFvSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,      & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,     & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,         & 
& cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,ZcplcChaFvSeL,ZcplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,             & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSvcVWm,AmpVertexIRosChaToFvSe)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFvSe(MAhOS,MChaOS,MChiOS,MFdOS,              & 
& MFeOS,MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,              & 
& MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,              & 
& MSv2OS,MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,cplFvChacSeL,        & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,    & 
& cplcChaChaVZR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFeChiSeL,      & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,      & 
& cplcChaFdcSuR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,          & 
& cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplFvFvVZL,           & 
& cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,              & 
& cplcFeFvSeR,cplhhSecSe,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,cplSeSvcSe,              & 
& cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSvcVWm,AmpVertexIRosChaToFvSe)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaToFvSe(MAh,MCha,MChi,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplAhSecSe,      & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,     & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFeChiSeL,cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,         & 
& cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplFvFvVZL,cplFvFvVZR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,               & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,             & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSvcVWm,AmpVertexIRosChaToFvSe)

 End if 
 End if 
AmpVertexChaToFvSe = AmpVertexChaToFvSe -  AmpVertexIRdrChaToFvSe! +  AmpVertexIRosChaToFvSe ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaToFvSe=0._dp 
AmpVertexZChaToFvSe=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaToFvSe(1,gt2,:,:) = AmpWaveZChaToFvSe(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaToFvSe(1,gt1,:,:) 
AmpVertexZChaToFvSe(1,gt2,:,:)= AmpVertexZChaToFvSe(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaToFvSe(1,gt1,:,:) 
AmpWaveZChaToFvSe(2,gt2,:,:) = AmpWaveZChaToFvSe(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaToFvSe(2,gt1,:,:) 
AmpVertexZChaToFvSe(2,gt2,:,:)= AmpVertexZChaToFvSe(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaToFvSe(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaToFvSe=AmpWaveZChaToFvSe 
AmpVertexChaToFvSe= AmpVertexZChaToFvSe
! Final State 1 
AmpWaveZChaToFvSe=0._dp 
AmpVertexZChaToFvSe=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZChaToFvSe(1,:,gt2,:) = AmpWaveZChaToFvSe(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpWaveChaToFvSe(1,:,gt1,:) 
AmpVertexZChaToFvSe(1,:,gt2,:)= AmpVertexZChaToFvSe(1,:,gt2,:)+ZRUNoMatrix(gt2,gt1)*AmpVertexChaToFvSe(1,:,gt1,:) 
AmpWaveZChaToFvSe(2,:,gt2,:) = AmpWaveZChaToFvSe(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpWaveChaToFvSe(2,:,gt1,:) 
AmpVertexZChaToFvSe(2,:,gt2,:)= AmpVertexZChaToFvSe(2,:,gt2,:)+ZRUNoMatrixc(gt2,gt1)*AmpVertexChaToFvSe(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaToFvSe=AmpWaveZChaToFvSe 
AmpVertexChaToFvSe= AmpVertexZChaToFvSe
! Final State 2 
AmpWaveZChaToFvSe=0._dp 
AmpVertexZChaToFvSe=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZChaToFvSe(:,:,:,gt2) = AmpWaveZChaToFvSe(:,:,:,gt2)+ZRUZE(gt2,gt1)*AmpWaveChaToFvSe(:,:,:,gt1) 
AmpVertexZChaToFvSe(:,:,:,gt2)= AmpVertexZChaToFvSe(:,:,:,gt2)+ZRUZE(gt2,gt1)*AmpVertexChaToFvSe(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaToFvSe=AmpWaveZChaToFvSe 
AmpVertexChaToFvSe= AmpVertexZChaToFvSe
End if
If (ShiftIRdiv) Then 
AmpVertexChaToFvSe = AmpVertexChaToFvSe  +  AmpVertexIRosChaToFvSe
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fv Se -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaToFvSe = AmpTreeChaToFvSe 
 AmpSum2ChaToFvSe = AmpTreeChaToFvSe + 2._dp*AmpWaveChaToFvSe + 2._dp*AmpVertexChaToFvSe  
Else 
 AmpSumChaToFvSe = AmpTreeChaToFvSe + AmpWaveChaToFvSe + AmpVertexChaToFvSe
 AmpSum2ChaToFvSe = AmpTreeChaToFvSe + AmpWaveChaToFvSe + AmpVertexChaToFvSe 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFvSe = AmpTreeChaToFvSe
 AmpSum2ChaToFvSe = AmpTreeChaToFvSe 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MChaOS(gt1).gt.(0.+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(0.+MSe(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaToFvSe = AmpTreeChaToFvSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MSeOS(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MSe(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaToFvSe(gt1, gt2, gt3) 
  AmpSum2ChaToFvSe = 2._dp*AmpWaveChaToFvSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MSeOS(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MSe(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaToFvSe(gt1, gt2, gt3) 
  AmpSum2ChaToFvSe = 2._dp*AmpVertexChaToFvSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MSeOS(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MSe(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaToFvSe(gt1, gt2, gt3) 
  AmpSum2ChaToFvSe = AmpTreeChaToFvSe + 2._dp*AmpWaveChaToFvSe + 2._dp*AmpVertexChaToFvSe
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MSeOS(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MSe(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaToFvSe(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaToFvSe = AmpTreeChaToFvSe
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MSeOS(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
  AmpSqTreeChaToFvSe(gt1, gt2, gt3) = (1)*AmpSqChaToFvSe(gt1, gt2, gt3)  
  AmpSum2ChaToFvSe = + 2._dp*AmpWaveChaToFvSe + 2._dp*AmpVertexChaToFvSe
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MSeOS(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
  AmpSqChaToFvSe(gt1, gt2, gt3) = AmpSqChaToFvSe(gt1, gt2, gt3) + AmpSqTreeChaToFvSe(gt1, gt2, gt3)  
Else  
  AmpSum2ChaToFvSe = AmpTreeChaToFvSe
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MSe(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
  AmpSqTreeChaToFvSe(gt1, gt2, gt3) = (1)*AmpSqChaToFvSe(gt1, gt2, gt3)  
  AmpSum2ChaToFvSe = + 2._dp*AmpWaveChaToFvSe + 2._dp*AmpVertexChaToFvSe
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MSe(gt3),AmpSumChaToFvSe(:,gt1, gt2, gt3),AmpSum2ChaToFvSe(:,gt1, gt2, gt3),AmpSqChaToFvSe(gt1, gt2, gt3)) 
  AmpSqChaToFvSe(gt1, gt2, gt3) = AmpSqChaToFvSe(gt1, gt2, gt3) + AmpSqTreeChaToFvSe(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaToFvSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFvSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),0._dp,MSeOS(gt3),helfactor*AmpSqChaToFvSe(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),0._dp,MSe(gt3),helfactor*AmpSqChaToFvSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaToFvSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFvSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToFvSe(gt1, gt2, gt3) + MRGChaToFvSe(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaToFvSe(gt1, gt2, gt3) + MRGChaToFvSe(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! bar(Fu) Sd
!---------------- 

!Tree Level 
  If (.not.ExternalZfactors) Then 
Call Amplitude_Tree_MSSMTriLnV_ChaTocFuSd(cplcChacFuSdL,cplcChacFuSdR,MCha,           & 
& MFu,MSd,MCha2,MFu2,MSd2,AmpTreeChaTocFuSd)

  Else 
Call Amplitude_Tree_MSSMTriLnV_ChaTocFuSd(ZcplcChacFuSdL,ZcplcChacFuSdR,              & 
& MCha,MFu,MSd,MCha2,MFu2,MSd2,AmpTreeChaTocFuSd)

  End if 


!Real Corrections 
If (OSkinematics) Then 
  If (.not.ExternalZfactors) Then 
 ! OS and no Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaTocFuSd(MLambda,em,gs,cplcChacFuSdL,cplcChacFuSdR,      & 
& MChaOS,MFuOS,MSdOS,MRPChaTocFuSd,MRGChaTocFuSd)

  Else 
 ! OS and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaTocFuSd(MLambda,em,gs,ZcplcChacFuSdL,ZcplcChacFuSdR,    & 
& MChaOS,MFuOS,MSdOS,MRPChaTocFuSd,MRGChaTocFuSd)

  End if 
Else 
 ! DR and no Z-factors 
  If (.not.ExternalZfactors) Then 
Call Gamma_Real_MSSMTriLnV_ChaTocFuSd(MLambda,em,gs,cplcChacFuSdL,cplcChacFuSdR,      & 
& MCha,MFu,MSd,MRPChaTocFuSd,MRGChaTocFuSd)

  Else 
 ! DR and Z-factors 
Call Gamma_Real_MSSMTriLnV_ChaTocFuSd(MLambda,em,gs,ZcplcChacFuSdL,ZcplcChacFuSdR,    & 
& MCha,MFu,MSd,MRPChaTocFuSd,MRGChaTocFuSd)

  End if 
End if 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaTocFuSd(cplcChacFuSdL,cplcChacFuSdR,ctcplcChacFuSdL,& 
& ctcplcChacFuSdR,MCha,MCha2,MFu,MFu2,MSd,MSd2,ZfFUL,ZfFUR,ZfLm,ZfLp,ZfSd,               & 
& AmpWaveChaTocFuSd)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaTocFuSd(MAh,MCha,MChi,MFd,MFe,MFu,MGlu,           & 
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
& AmpVertexChaTocFuSd)

If (ShiftIRdiv) Then 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaTocFuSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRdrChaTocFuSd)

 If (ExternalZfactors) Then 
  If (OSkinematics) Then 
 ! OS and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaTocFuSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& AmpVertexIRosChaTocFuSd)

   Else 
 ! DR and Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaTocFuSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRosChaTocFuSd)

 End if 
 Else 
  If (OSkinematics) Then 
 ! OS and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaTocFuSd(MAhOS,MChaOS,MChiOS,MFdOS,             & 
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
& AmpVertexIRosChaTocFuSd)

   Else 
 ! DR and no Z-factors 
Call Amplitude_IR_VERTEX_MSSMTriLnV_ChaTocFuSd(MAh,MCha,MChi,MFd,MFe,MFu,             & 
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
& AmpVertexIRosChaTocFuSd)

 End if 
 End if 
AmpVertexChaTocFuSd = AmpVertexChaTocFuSd -  AmpVertexIRdrChaTocFuSd! +  AmpVertexIRosChaTocFuSd ! Shift added later
End if 


 ! Add Z-factors to have external fields on-shell 
 If (ExternalZfactors) Then 
! Decaying particle 
AmpWaveZChaTocFuSd=0._dp 
AmpVertexZChaTocFuSd=0._dp 
Do gt1=1,2
  Do gt2=1,2
AmpWaveZChaTocFuSd(1,gt2,:,:) = AmpWaveZChaTocFuSd(1,gt2,:,:)+ZRUUP(gt2,gt1)*AmpWaveChaTocFuSd(1,gt1,:,:) 
AmpVertexZChaTocFuSd(1,gt2,:,:)= AmpVertexZChaTocFuSd(1,gt2,:,:) + ZRUUP(gt2,gt1)*AmpVertexChaTocFuSd(1,gt1,:,:) 
AmpWaveZChaTocFuSd(2,gt2,:,:) = AmpWaveZChaTocFuSd(2,gt2,:,:)+ZRUUMc(gt2,gt1)*AmpWaveChaTocFuSd(2,gt1,:,:) 
AmpVertexZChaTocFuSd(2,gt2,:,:)= AmpVertexZChaTocFuSd(2,gt2,:,:) + ZRUUMc(gt2,gt1)*AmpVertexChaTocFuSd(2,gt1,:,:) 
 End Do 
End Do 
AmpWaveChaTocFuSd=AmpWaveZChaTocFuSd 
AmpVertexChaTocFuSd= AmpVertexZChaTocFuSd
! Final State 1 
AmpWaveZChaTocFuSd=0._dp 
AmpVertexZChaTocFuSd=0._dp 
Do gt1=1,3
  Do gt2=1,3
AmpWaveZChaTocFuSd(1,:,gt2,:) = AmpWaveZChaTocFuSd(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpWaveChaTocFuSd(1,:,gt1,:) 
AmpVertexZChaTocFuSd(1,:,gt2,:)= AmpVertexZChaTocFuSd(1,:,gt2,:)+ZRUZUR(gt2,gt1)*AmpVertexChaTocFuSd(1,:,gt1,:) 
AmpWaveZChaTocFuSd(2,:,gt2,:) = AmpWaveZChaTocFuSd(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpWaveChaTocFuSd(2,:,gt1,:) 
AmpVertexZChaTocFuSd(2,:,gt2,:)= AmpVertexZChaTocFuSd(2,:,gt2,:)+ZRUZULc(gt2,gt1)*AmpVertexChaTocFuSd(2,:,gt1,:) 
 End Do 
End Do 
AmpWaveChaTocFuSd=AmpWaveZChaTocFuSd 
AmpVertexChaTocFuSd= AmpVertexZChaTocFuSd
! Final State 2 
AmpWaveZChaTocFuSd=0._dp 
AmpVertexZChaTocFuSd=0._dp 
Do gt1=1,6
  Do gt2=1,6
AmpWaveZChaTocFuSd(:,:,:,gt2) = AmpWaveZChaTocFuSd(:,:,:,gt2)+ZRUZD(gt2,gt1)*AmpWaveChaTocFuSd(:,:,:,gt1) 
AmpVertexZChaTocFuSd(:,:,:,gt2)= AmpVertexZChaTocFuSd(:,:,:,gt2)+ZRUZD(gt2,gt1)*AmpVertexChaTocFuSd(:,:,:,gt1) 
 End Do 
End Do 
AmpWaveChaTocFuSd=AmpWaveZChaTocFuSd 
AmpVertexChaTocFuSd= AmpVertexZChaTocFuSd
End if
If (ShiftIRdiv) Then 
AmpVertexChaTocFuSd = AmpVertexChaTocFuSd  +  AmpVertexIRosChaTocFuSd
End if
 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->bar[Fu] Sd -----------------------" 
End if 
If (.not.SquareFullAmplitudeDecays) Then 
 AmpSumChaTocFuSd = AmpTreeChaTocFuSd 
 AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd + 2._dp*AmpWaveChaTocFuSd + 2._dp*AmpVertexChaTocFuSd  
Else 
 AmpSumChaTocFuSd = AmpTreeChaTocFuSd + AmpWaveChaTocFuSd + AmpVertexChaTocFuSd
 AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd + AmpWaveChaTocFuSd + AmpVertexChaTocFuSd 
End If 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaTocFuSd = AmpTreeChaTocFuSd
 AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd 
End if 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,6
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFuOS(gt2)+MSdOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFu(gt2)+MSd(gt3))))) Then 
 If (DebugLoopDecays) Then 
  Write(*,*) gt1, gt2, gt3 
  AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFu(gt2),MSd(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x TREE: ",AmpSqChaTocFuSd(gt1, gt2, gt3) 
  AmpSum2ChaTocFuSd = 2._dp*AmpWaveChaTocFuSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFu(gt2),MSd(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x WAVE: ",AmpSqChaTocFuSd(gt1, gt2, gt3) 
  AmpSum2ChaTocFuSd = 2._dp*AmpVertexChaTocFuSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFu(gt2),MSd(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x VERTEX: ",AmpSqChaTocFuSd(gt1, gt2, gt3) 
  AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd + 2._dp*AmpWaveChaTocFuSd + 2._dp*AmpVertexChaTocFuSd
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFu(gt2),MSd(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
End if  
  Write(*,*) "TREE x (TREE+WAVE+VERTEX): ",AmpSqChaTocFuSd(gt1, gt2, gt3) 
 End if 
If (OSkinematics) Then 
  AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd
  Call SquareAmp_FtoFS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
  AmpSqTreeChaTocFuSd(gt1, gt2, gt3) = (3)*AmpSqChaTocFuSd(gt1, gt2, gt3)  
  AmpSum2ChaTocFuSd = + 2._dp*AmpWaveChaTocFuSd + 2._dp*AmpVertexChaTocFuSd
  Call SquareAmp_FtoFS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
  AmpSqChaTocFuSd(gt1, gt2, gt3) = AmpSqChaTocFuSd(gt1, gt2, gt3) + AmpSqTreeChaTocFuSd(gt1, gt2, gt3)  
Else  
  AmpSum2ChaTocFuSd = AmpTreeChaTocFuSd
  Call SquareAmp_FtoFS(MCha(gt1),MFu(gt2),MSd(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
  AmpSqTreeChaTocFuSd(gt1, gt2, gt3) = (3)*AmpSqChaTocFuSd(gt1, gt2, gt3)  
  AmpSum2ChaTocFuSd = + 2._dp*AmpWaveChaTocFuSd + 2._dp*AmpVertexChaTocFuSd
  Call SquareAmp_FtoFS(MCha(gt1),MFu(gt2),MSd(gt3),AmpSumChaTocFuSd(:,gt1, gt2, gt3),AmpSum2ChaTocFuSd(:,gt1, gt2, gt3),AmpSqChaTocFuSd(gt1, gt2, gt3)) 
  AmpSqChaTocFuSd(gt1, gt2, gt3) = AmpSqChaTocFuSd(gt1, gt2, gt3) + AmpSqTreeChaTocFuSd(gt1, gt2, gt3)  
End if  
Else  
  AmpSqChaTocFuSd(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaTocFuSd(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFuOS(gt2),MSdOS(gt3),helfactor*AmpSqChaTocFuSd(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFu(gt2),MSd(gt3),helfactor*AmpSqChaTocFuSd(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaTocFuSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaTocFuSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
 ! Adding real corrections 
If ((Abs(MRPChaTocFuSd(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaTocFuSd(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
 If (.not.OnlyTreeLevelContributions) Then 
   If (DebugLoopDecays) Write(*,*) "real", phasespacefactor*1._dp/2._dp*helfactor*(MRPChaTocFuSd(gt1, gt2, gt3) + MRGChaTocFuSd(gt1, gt2, gt3)) 
  gP1LCha(gt1,i4) = gP1LCha(gt1,i4) + phasespacefactor*1._dp/2._dp*helfactor*(MRPChaTocFuSd(gt1, gt2, gt3) + MRGChaTocFuSd(gt1, gt2, gt3))
   If (DebugLoopDecays) Write(*,*) "sum",  gP1LCha(gt1,i4) 
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
! Cha Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaSv(MChaOS,MCha2OS,MSvOS,MSv2OS,ZfLm,           & 
& ZfLp,ZfSv,AmpWaveChaToChaSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaSv(MChaOS,MCha2OS,MSvOS,MSv2OS,ZfLm,           & 
& ZfLp,ZfSv,AmpWaveChaToChaSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaSv(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& ZcplChaFucSdL,ZcplChaFucSdR,ZcplFvChacSeL,ZcplFvChacSeR,ZcplcFdChaSuL,ZcplcFdChaSuR,   & 
& ZcplcFeChaSvL,ZcplcFeChaSvR,ZcplcFdFdSvL,ZcplcFdFdSvR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,   & 
& ZcplcFeFeSvL,ZcplcFeFeSvR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcChaFvSeL,ZcplcChaFvSeR,   & 
& ZcplSdSvcSd,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSeSvcSe,AmpVertexChaToChaSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaSv(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,         & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,         & 
& cplSdSvcSd,cplcChacFuSdL,cplcChacFuSdR,cplSeSvcSe,AmpVertexChaToChaSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaSv(MCha,MCha2,MSv,MSv2,ZfLm,ZfLp,              & 
& ZfSv,AmpWaveChaToChaSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaSv(MCha,MFd,MFe,MFu,MSd,MSe,MSu,             & 
& MSv,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,          & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,         & 
& cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplSdSvcSd,cplcChacFuSdL,cplcChacFuSdR,        & 
& cplSeSvcSe,AmpVertexChaToChaSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Cha Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChaSv = 0._dp 
 AmpSum2ChaToChaSv = 0._dp  
Else 
 AmpSumChaToChaSv = AmpVertexChaToChaSv + AmpWaveChaToChaSv
 AmpSum2ChaToChaSv = AmpVertexChaToChaSv + AmpWaveChaToChaSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChaOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MCha(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MSvOS(gt3),AmpSumChaToChaSv(:,gt1, gt2, gt3),AmpSum2ChaToChaSv(:,gt1, gt2, gt3),AmpSqChaToChaSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MSv(gt3),AmpSumChaToChaSv(:,gt1, gt2, gt3),AmpSum2ChaToChaSv(:,gt1, gt2, gt3),AmpSqChaToChaSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToChaSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChaSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChaOS(gt2),MSvOS(gt3),helfactor*AmpSqChaToChaSv(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MCha(gt2),MSv(gt3),helfactor*AmpSqChaToChaSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToChaSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChaSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Cha VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaVP(ZcplcChaChaVPL,ZcplcChaChaVPR,              & 
& ZcplcChaChaVZL,ZcplcChaChaVZR,ctcplcChaChaVPL,ctcplcChaChaVPR,ctcplcChaChaVZL,         & 
& ctcplcChaChaVZR,MChaOS,MCha2OS,MVP,MVP2,ZfLm,ZfLp,ZfVP,ZfVZVP,AmpWaveChaToChaVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaVP(cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,ctcplcChaChaVPL,ctcplcChaChaVPR,ctcplcChaChaVZL,ctcplcChaChaVZR,         & 
& MChaOS,MCha2OS,MVP,MVP2,ZfLm,ZfLp,ZfVP,ZfVZVP,AmpWaveChaToChaVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,          & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,ZcplcChaChaAhL,ZcplcChaChaAhR,ZcplChiChacHpmL,ZcplChiChacHpmR,     & 
& ZcplChiChacVWmL,ZcplChiChacVWmR,ZcplChaFucSdL,ZcplChaFucSdR,ZcplFvChacSeL,             & 
& ZcplFvChacSeR,ZcplcChaChahhL,ZcplcChaChahhR,ZcplcFdChaSuL,ZcplcFdChaSuR,               & 
& ZcplcFeChaSvL,ZcplcFeChaSvR,ZcplcChaChaVPL,ZcplcChaChaVPR,ZcplcChaChaVZL,              & 
& ZcplcChaChaVZR,ZcplcChaChiHpmL,ZcplcChaChiHpmR,ZcplcChaChiVWmL,ZcplcChaChiVWmR,        & 
& ZcplcFdFdVPL,ZcplcFdFdVPR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplcFeFeVPL,ZcplcFeFeVPR,     & 
& ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFuFuVPL,ZcplcFuFuVPR,ZcplcChaFvSeL,ZcplcChaFvSeR,   & 
& ZcplHpmcHpmVP,ZcplHpmcVWmVP,ZcplSdcSdVP,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSecSeVP,     & 
& ZcplSucSuVP,ZcplcHpmVPVWm,ZcplcVWmVPVWm,AmpVertexChaToChaVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaVP(MAhOS,MChaOS,MChiOS,MFdOS,MFeOS,          & 
& MFuOS,MhhOS,MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVP,MVWmOS,MVZOS,MAh2OS,MCha2OS,            & 
& MChi2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,               & 
& MVP2,MVWm2OS,MVZ2OS,cplcChaChaAhL,cplcChaChaAhR,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVPL,cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,     & 
& cplcFeFeVPL,cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVPL,cplcFuFuVPR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,AmpVertexChaToChaVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChaVP(cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,  & 
& cplcChaChaVZR,ctcplcChaChaVPL,ctcplcChaChaVPR,ctcplcChaChaVZL,ctcplcChaChaVZR,         & 
& MCha,MCha2,MVP,MVP2,ZfLm,ZfLp,ZfVP,ZfVZVP,AmpWaveChaToChaVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChaVP(MAh,MCha,MChi,MFd,MFe,MFu,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChacHpmL,        & 
& cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,       & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,   & 
& cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVPL,cplcFdFdVPR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFeVPL,cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVPL,         & 
& cplcFuFuVPR,cplcChaFvSeL,cplcChaFvSeR,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,            & 
& cplcChacFuSdL,cplcChacFuSdR,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,           & 
& AmpVertexChaToChaVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Cha VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChaVP = 0._dp 
 AmpSum2ChaToChaVP = 0._dp  
Else 
 AmpSumChaToChaVP = AmpVertexChaToChaVP + AmpWaveChaToChaVP
 AmpSum2ChaToChaVP = AmpVertexChaToChaVP + AmpWaveChaToChaVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChaOS(gt2)+0.))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MCha(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MChaOS(gt2),0._dp,AmpSumChaToChaVP(:,gt1, gt2),AmpSum2ChaToChaVP(:,gt1, gt2),AmpSqChaToChaVP(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MCha(gt2),MVP,AmpSumChaToChaVP(:,gt1, gt2),AmpSum2ChaToChaVP(:,gt1, gt2),AmpSqChaToChaVP(gt1, gt2)) 
End if  
Else  
  AmpSqChaToChaVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChaVP(gt1, gt2).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChaOS(gt2),0._dp,helfactor*AmpSqChaToChaVP(gt1, gt2))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MCha(gt2),MVP,helfactor*AmpSqChaToChaVP(gt1, gt2))
End if 
If ((Abs(MRPChaToChaVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToChaVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Cha Conjg(Sv)
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChacSv(MChaOS,MCha2OS,MSvOS,MSv2OS,               & 
& ZfLm,ZfLp,ZfSv,AmpWaveChaToChacSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChacSv(MChaOS,MCha2OS,MSvOS,MSv2OS,               & 
& ZfLm,ZfLp,ZfSv,AmpWaveChaToChacSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChacSv(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& ZcplChaFucSdL,ZcplChaFucSdR,ZcplFvChacSeL,ZcplFvChacSeR,ZcplcFdChaSuL,ZcplcFdChaSuR,   & 
& ZcplcFeChaSvL,ZcplcFeChaSvR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplcFdFdcSvL,               & 
& ZcplcFdFdcSvR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFeFecSvL,ZcplcFeFecSvR,               & 
& ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSdcSdcSv,ZcplSecSecSv,   & 
& AmpVertexChaToChacSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChacSv(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,          & 
& MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,            & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,       & 
& cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,cplSecSecSv,AmpVertexChaToChacSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChacSv(MCha,MCha2,MSv,MSv2,ZfLm,ZfLp,             & 
& ZfSv,AmpWaveChaToChacSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChacSv(MCha,MFd,MFe,MFu,MSd,MSe,MSu,            & 
& MSv,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,      & 
& cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,cplSdcSdcSv,        & 
& cplSecSecSv,AmpVertexChaToChacSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Cha conj[Sv] -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChacSv = 0._dp 
 AmpSum2ChaToChacSv = 0._dp  
Else 
 AmpSumChaToChacSv = AmpVertexChaToChacSv + AmpWaveChaToChacSv
 AmpSum2ChaToChacSv = AmpVertexChaToChacSv + AmpWaveChaToChacSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,2
    Do gt3=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChaOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MCha(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChaOS(gt2),MSvOS(gt3),AmpSumChaToChacSv(:,gt1, gt2, gt3),AmpSum2ChaToChacSv(:,gt1, gt2, gt3),AmpSqChaToChacSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MCha(gt2),MSv(gt3),AmpSumChaToChacSv(:,gt1, gt2, gt3),AmpSum2ChaToChacSv(:,gt1, gt2, gt3),AmpSqChaToChacSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToChacSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChacSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChaOS(gt2),MSvOS(gt3),helfactor*AmpSqChaToChacSv(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MCha(gt2),MSv(gt3),helfactor*AmpSqChaToChacSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToChacSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChacSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Chi Se
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChiSe(MChaOS,MCha2OS,MChiOS,MChi2OS,              & 
& MSeOS,MSe2OS,ZfL0,ZfLm,ZfLp,ZfSe,AmpWaveChaToChiSe)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChiSe(MChaOS,MCha2OS,MChiOS,MChi2OS,              & 
& MSeOS,MSe2OS,ZfL0,ZfLm,ZfLp,ZfSe,AmpWaveChaToChiSe)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChiSe(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,ZcplChiFdcSdL,ZcplChiFdcSdR,ZcplChiFecSeL,ZcplChiFecSeR,ZcplChiFucSuL,   & 
& ZcplChiFucSuR,ZcplChiFvSvL,ZcplChiFvSvR,ZcplChiFvcSvL,ZcplChiFvcSvR,ZcplcFdChiSdL,     & 
& ZcplcFdChiSdR,ZcplcFeChiSeL,ZcplcFeChiSeR,ZcplcFuChiSuL,ZcplcFuChiSuR,ZcplcChaFdcSuL,  & 
& ZcplcChaFdcSuR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFdFuSeL,ZcplcFdFuSeR,ZcplcChaFvSeL,  & 
& ZcplcChaFvSeR,ZcplcFeFvSeL,ZcplcFeFvSeR,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSeSucSd,     & 
& ZcplSeSvcSe,ZcplSecSecSv,AmpVertexChaToChiSe)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChiSe(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,        & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,           & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,        & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,           & 
& cplSeSvcSe,cplSecSecSv,AmpVertexChaToChiSe)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToChiSe(MCha,MCha2,MChi,MChi2,MSe,MSe2,             & 
& ZfL0,ZfLm,ZfLp,ZfSe,AmpWaveChaToChiSe)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToChiSe(MCha,MChi,MFd,MFe,MFu,MSd,MSe,            & 
& MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChiFdcSdL,cplChiFdcSdR,      & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,     & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcChacFuSdL,cplcChacFuSdR,cplSeSucSd,cplSeSvcSe,cplSecSecSv,AmpVertexChaToChiSe)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Chi Se -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToChiSe = 0._dp 
 AmpSum2ChaToChiSe = 0._dp  
Else 
 AmpSumChaToChiSe = AmpVertexChaToChiSe + AmpWaveChaToChiSe
 AmpSum2ChaToChiSe = AmpVertexChaToChiSe + AmpWaveChaToChiSe 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,4
    Do gt3=1,6
If (((OSkinematics).and.(MChaOS(gt1).gt.(MChiOS(gt2)+MSeOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MChi(gt2)+MSe(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MChiOS(gt2),MSeOS(gt3),AmpSumChaToChiSe(:,gt1, gt2, gt3),AmpSum2ChaToChiSe(:,gt1, gt2, gt3),AmpSqChaToChiSe(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MChi(gt2),MSe(gt3),AmpSumChaToChiSe(:,gt1, gt2, gt3),AmpSum2ChaToChiSe(:,gt1, gt2, gt3),AmpSqChaToChiSe(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToChiSe(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToChiSe(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MChiOS(gt2),MSeOS(gt3),helfactor*AmpSqChaToChiSe(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MChi(gt2),MSe(gt3),helfactor*AmpSqChaToChiSe(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToChiSe(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToChiSe(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fe Ah
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeAh(MAhOS,MAh2OS,MChaOS,MCha2OS,MFeOS,           & 
& MFe2OS,ZfAh,ZfFEL,ZfFER,ZfLm,ZfLp,AmpWaveChaToFeAh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeAh(MAhOS,MAh2OS,MChaOS,MCha2OS,MFeOS,           & 
& MFe2OS,ZfAh,ZfFEL,ZfFER,ZfLm,ZfLp,AmpWaveChaToFeAh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeAh(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,ZcplcFdFdAhL,ZcplcFdFdAhR,ZcplcFeFeAhL,ZcplcFeFeAhR,ZcplcFuFuAhL,        & 
& ZcplcFuFuAhR,ZcplAhSdcSd,ZcplAhSecSe,ZcplAhSucSu,ZcplcChaFdcSuL,ZcplcChaFdcSuR,        & 
& ZcplFeFucSdL,ZcplFeFucSdR,ZcplFvFecSeL,ZcplFvFecSeR,ZcplcFdFeSuL,ZcplcFdFeSuR,         & 
& ZcplcFeFeSvL,ZcplcFeFeSvR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcChaFvSeL,ZcplcChaFvSeR,   & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,AmpVertexChaToFeAh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeAh(MAhOS,MChaOS,MFdOS,MFeOS,MFuOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MAh2OS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,             & 
& cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplcChaFdcSuL,cplcChaFdcSuR,              & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,         & 
& cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToFeAh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeAh(MAh,MAh2,MCha,MCha2,MFe,MFe2,ZfAh,           & 
& ZfFEL,ZfFER,ZfLm,ZfLp,AmpWaveChaToFeAh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeAh(MAh,MCha,MFd,MFe,MFu,MSd,MSe,              & 
& MSu,MSv,MAh2,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToFeAh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fe Ah -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFeAh = 0._dp 
 AmpSum2ChaToFeAh = 0._dp  
Else 
 AmpSumChaToFeAh = AmpVertexChaToFeAh + AmpWaveChaToFeAh
 AmpSum2ChaToFeAh = AmpVertexChaToFeAh + AmpWaveChaToFeAh 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=2,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFeOS(gt2)+MAhOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFe(gt2)+MAh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MAhOS(gt3),AmpSumChaToFeAh(:,gt1, gt2, gt3),AmpSum2ChaToFeAh(:,gt1, gt2, gt3),AmpSqChaToFeAh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MAh(gt3),AmpSumChaToFeAh(:,gt1, gt2, gt3),AmpSum2ChaToFeAh(:,gt1, gt2, gt3),AmpSqChaToFeAh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToFeAh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFeAh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFeOS(gt2),MAhOS(gt3),helfactor*AmpSqChaToFeAh(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFe(gt2),MAh(gt3),helfactor*AmpSqChaToFeAh(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFeAh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFeAh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fe hh
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFehh(MChaOS,MCha2OS,MFeOS,MFe2OS,MhhOS,           & 
& Mhh2OS,ZfFEL,ZfFER,Zfhh,ZfLm,ZfLp,AmpWaveChaToFehh)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFehh(MChaOS,MCha2OS,MFeOS,MFe2OS,MhhOS,           & 
& Mhh2OS,ZfFEL,ZfFER,Zfhh,ZfLm,ZfLp,AmpWaveChaToFehh)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFehh(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,ZcplcFdFdhhL,ZcplcFdFdhhR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplFeFucSdL,    & 
& ZcplFeFucSdR,ZcplFvFecSeL,ZcplFvFecSeR,ZcplcFeFehhL,ZcplcFeFehhR,ZcplcFdFeSuL,         & 
& ZcplcFdFeSuR,ZcplcFeFeSvL,ZcplcFeFeSvR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFuFuhhL,     & 
& ZcplcFuFuhhR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplhhSdcSd,ZcplhhSecSe,ZcplhhSucSu,          & 
& ZcplhhSvcSv,ZcplcChacFuSdL,ZcplcChacFuSdR,AmpVertexChaToFehh)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFehh(MChaOS,MFdOS,MFeOS,MFuOS,MhhOS,            & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,Mhh2OS,MSd2OS,MSe2OS,             & 
& MSu2OS,MSv2OS,cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,         & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcChaFvSeL,cplcChaFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,     & 
& cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToFehh)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFehh(MCha,MCha2,MFe,MFe2,Mhh,Mhh2,ZfFEL,          & 
& ZfFER,Zfhh,ZfLm,ZfLp,AmpWaveChaToFehh)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFehh(MCha,MFd,MFe,MFu,Mhh,MSd,MSe,              & 
& MSu,MSv,MCha2,MFd2,MFe2,MFu2,Mhh2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,cplcFdFdhhR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,cplcChaFvSeL,cplcChaFvSeR,         & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,               & 
& AmpVertexChaToFehh)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fe hh -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFehh = 0._dp 
 AmpSum2ChaToFehh = 0._dp  
Else 
 AmpSumChaToFehh = AmpVertexChaToFehh + AmpWaveChaToFehh
 AmpSum2ChaToFehh = AmpVertexChaToFehh + AmpWaveChaToFehh 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFeOS(gt2)+MhhOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFe(gt2)+Mhh(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MhhOS(gt3),AmpSumChaToFehh(:,gt1, gt2, gt3),AmpSum2ChaToFehh(:,gt1, gt2, gt3),AmpSqChaToFehh(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),Mhh(gt3),AmpSumChaToFehh(:,gt1, gt2, gt3),AmpSum2ChaToFehh(:,gt1, gt2, gt3),AmpSqChaToFehh(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToFehh(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFehh(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFeOS(gt2),MhhOS(gt3),helfactor*AmpSqChaToFehh(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFe(gt2),Mhh(gt3),helfactor*AmpSqChaToFehh(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFehh(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFehh(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fe Sv
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeSv(MChaOS,MCha2OS,MFeOS,MFe2OS,MSvOS,           & 
& MSv2OS,ZfFEL,ZfFER,ZfLm,ZfLp,ZfSv,AmpWaveChaToFeSv)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeSv(MChaOS,MCha2OS,MFeOS,MFe2OS,MSvOS,           & 
& MSv2OS,ZfFEL,ZfFER,ZfLm,ZfLp,ZfSv,AmpWaveChaToFeSv)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeSv(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,           & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,            & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,ZcplChiFecSeL,ZcplChiFecSeR,               & 
& ZcplChiFvSvL,ZcplChiFvSvR,ZcplcChaChiHpmL,ZcplcChaChiHpmR,ZcplcChaChiVWmL,             & 
& ZcplcChaChiVWmR,ZcplcFdFdSvL,ZcplcFdFdSvR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,               & 
& ZcplFeFucSdL,ZcplFeFucSdR,ZcplFvFecHpmL,ZcplFvFecHpmR,ZcplFvFecSeL,ZcplFvFecSeR,       & 
& ZcplFvFecVWmL,ZcplFvFecVWmR,ZcplcFdFeSuL,ZcplcFdFeSuR,ZcplcFeFeSvL,ZcplcFeFeSvR,       & 
& ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplHpmSvcSe,ZcplSdSvcSd,    & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSeSvcSe,ZcplSvcSeVWm,AmpVertexChaToFeSv)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeSv(MChaOS,MChiOS,MFdOS,MFeOS,MFuOS,           & 
& MHpmOS,MSdOS,MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MChi2OS,MFd2OS,MFe2OS,MFu2OS,            & 
& MHpm2OS,MSd2OS,MSe2OS,MSu2OS,MSv2OS,MVWm2OS,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,     & 
& cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,               & 
& cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplHpmSvcSe,cplSdSvcSd,cplcChacFuSdL,cplcChacFuSdR,          & 
& cplSeSvcSe,cplSvcSeVWm,AmpVertexChaToFeSv)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeSv(MCha,MCha2,MFe,MFe2,MSv,MSv2,ZfFEL,          & 
& ZfFER,ZfLm,ZfLp,ZfSv,AmpWaveChaToFeSv)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeSv(MCha,MChi,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MSv,MVWm,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,           & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,       & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,     & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplcChacFuSdL,cplcChacFuSdR,cplSeSvcSe,cplSvcSeVWm,AmpVertexChaToFeSv)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fe Sv -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFeSv = 0._dp 
 AmpSum2ChaToFeSv = 0._dp  
Else 
 AmpSumChaToFeSv = AmpVertexChaToFeSv + AmpWaveChaToFeSv
 AmpSum2ChaToFeSv = AmpVertexChaToFeSv + AmpWaveChaToFeSv 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFeOS(gt2)+MSvOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFe(gt2)+MSv(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),AmpSumChaToFeSv(:,gt1, gt2, gt3),AmpSum2ChaToFeSv(:,gt1, gt2, gt3),AmpSqChaToFeSv(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),MFe(gt2),MSv(gt3),AmpSumChaToFeSv(:,gt1, gt2, gt3),AmpSum2ChaToFeSv(:,gt1, gt2, gt3),AmpSqChaToFeSv(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToFeSv(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFeSv(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFeOS(gt2),MSvOS(gt3),helfactor*AmpSqChaToFeSv(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFe(gt2),MSv(gt3),helfactor*AmpSqChaToFeSv(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFeSv(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFeSv(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fe VP
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeVP(MChaOS,MCha2OS,MFeOS,MFe2OS,MVP,             & 
& MVP2,ZfFEL,ZfFER,ZfLm,ZfLp,ZfVP,AmpWaveChaToFeVP)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeVP(MChaOS,MCha2OS,MFeOS,MFe2OS,MVP,             & 
& MVP2,ZfFEL,ZfFER,ZfLm,ZfLp,ZfVP,AmpWaveChaToFeVP)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeVP(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVP,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,               & 
& MSv2OS,MVP2,ZcplcFdFdVPL,ZcplcFdFdVPR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplFeFucSdL,      & 
& ZcplFeFucSdR,ZcplFvFecSeL,ZcplFvFecSeR,ZcplcFdFeSuL,ZcplcFdFeSuR,ZcplcFeFeSvL,         & 
& ZcplcFeFeSvR,ZcplcFeFeVPL,ZcplcFeFeVPR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFuFuVPL,     & 
& ZcplcFuFuVPR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplSdcSdVP,ZcplcChacFuSdL,ZcplcChacFuSdR,    & 
& ZcplSecSeVP,ZcplSucSuVP,AmpVertexChaToFeVP)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeVP(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVP,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,               & 
& MSv2OS,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,           & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,               & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVPL,           & 
& cplcFuFuVPR,cplcChaFvSeL,cplcChaFvSeR,cplSdcSdVP,cplcChacFuSdL,cplcChacFuSdR,          & 
& cplSecSeVP,cplSucSuVP,AmpVertexChaToFeVP)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeVP(MCha,MCha2,MFe,MFe2,MVP,MVP2,ZfFEL,          & 
& ZfFER,ZfLm,ZfLp,ZfVP,AmpWaveChaToFeVP)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeVP(MCha,MFd,MFe,MFu,MSd,MSe,MSu,              & 
& MSv,MVP,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVPL,cplcFuFuVPR,cplcChaFvSeL,cplcChaFvSeR,         & 
& cplSdcSdVP,cplcChacFuSdL,cplcChacFuSdR,cplSecSeVP,cplSucSuVP,AmpVertexChaToFeVP)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fe VP -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFeVP = 0._dp 
 AmpSum2ChaToFeVP = 0._dp  
Else 
 AmpSumChaToFeVP = AmpVertexChaToFeVP + AmpWaveChaToFeVP
 AmpSum2ChaToFeVP = AmpVertexChaToFeVP + AmpWaveChaToFeVP 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFeOS(gt2)+0.))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFe(gt2)+MVP)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MFeOS(gt2),0._dp,AmpSumChaToFeVP(:,gt1, gt2),AmpSum2ChaToFeVP(:,gt1, gt2),AmpSqChaToFeVP(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MFe(gt2),MVP,AmpSumChaToFeVP(:,gt1, gt2),AmpSum2ChaToFeVP(:,gt1, gt2),AmpSqChaToFeVP(gt1, gt2)) 
End if  
Else  
  AmpSqChaToFeVP(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFeVP(gt1, gt2).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFeOS(gt2),0._dp,helfactor*AmpSqChaToFeVP(gt1, gt2))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFe(gt2),MVP,helfactor*AmpSqChaToFeVP(gt1, gt2))
End if 
If ((Abs(MRPChaToFeVP(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToFeVP(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fe VZ
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeVZ(MChaOS,MCha2OS,MFeOS,MFe2OS,MVZOS,           & 
& MVZ2OS,ZfFEL,ZfFER,ZfLm,ZfLp,ZfVZ,AmpWaveChaToFeVZ)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeVZ(MChaOS,MCha2OS,MFeOS,MFe2OS,MVZOS,           & 
& MVZ2OS,ZfFEL,ZfFER,ZfLm,ZfLp,ZfVZ,AmpWaveChaToFeVZ)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeVZ(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVZOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVZ2OS,ZcplcFdFdVZL,ZcplcFdFdVZR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplFeFucSdL,    & 
& ZcplFeFucSdR,ZcplFvFecSeL,ZcplFvFecSeR,ZcplcFdFeSuL,ZcplcFdFeSuR,ZcplcFeFeSvL,         & 
& ZcplcFeFeSvR,ZcplcFeFeVZL,ZcplcFeFeVZR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFuFuVZL,     & 
& ZcplcFuFuVZR,ZcplFvFvVZL,ZcplFvFvVZR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplSdcSdVZ,          & 
& ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSecSeVZ,ZcplSucSuVZ,ZcplSvcSvVZ,AmpVertexChaToFeVZ)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeVZ(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,            & 
& MSeOS,MSuOS,MSvOS,MVZOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,             & 
& MSv2OS,MVZ2OS,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,         & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,               & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,           & 
& cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,cplSdcSdVZ,cplcChacFuSdL,  & 
& cplcChacFuSdR,cplSecSeVZ,cplSucSuVZ,cplSvcSvVZ,AmpVertexChaToFeVZ)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFeVZ(MCha,MCha2,MFe,MFe2,MVZ,MVZ2,ZfFEL,          & 
& ZfFER,ZfLm,ZfLp,ZfVZ,AmpWaveChaToFeVZ)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFeVZ(MCha,MFd,MFe,MFu,MSd,MSe,MSu,              & 
& MSv,MVZ,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSecSeVZ,           & 
& cplSucSuVZ,cplSvcSvVZ,AmpVertexChaToFeVZ)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fe VZ -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFeVZ = 0._dp 
 AmpSum2ChaToFeVZ = 0._dp  
Else 
 AmpSumChaToFeVZ = AmpVertexChaToFeVZ + AmpWaveChaToFeVZ
 AmpSum2ChaToFeVZ = AmpVertexChaToFeVZ + AmpWaveChaToFeVZ 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(MFeOS(gt2)+MVZOS))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(MFe(gt2)+MVZ)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),MFeOS(gt2),MVZOS,AmpSumChaToFeVZ(:,gt1, gt2),AmpSum2ChaToFeVZ(:,gt1, gt2),AmpSqChaToFeVZ(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),MFe(gt2),MVZ,AmpSumChaToFeVZ(:,gt1, gt2),AmpSum2ChaToFeVZ(:,gt1, gt2),AmpSqChaToFeVZ(gt1, gt2)) 
End if  
Else  
  AmpSqChaToFeVZ(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFeVZ(gt1, gt2).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),MFeOS(gt2),MVZOS,helfactor*AmpSqChaToFeVZ(gt1, gt2))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),MFe(gt2),MVZ,helfactor*AmpSqChaToFeVZ(gt1, gt2))
End if 
If ((Abs(MRPChaToFeVZ(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToFeVZ(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fv Hpm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvHpm(MChaOS,MCha2OS,MHpmOS,MHpm2OS,              & 
& ZfFvL,ZfHpm,ZfLm,ZfLp,AmpWaveChaToFvHpm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvHpm(MChaOS,MCha2OS,MHpmOS,MHpm2OS,              & 
& ZfFvL,ZfHpm,ZfLm,ZfLp,AmpWaveChaToFvHpm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvHpm(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplFvFecSeL,    & 
& ZcplFvFecSeR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFdFuHpmL,ZcplcFdFuHpmR,ZcplcFeFvHpmL,  & 
& ZcplcFeFvHpmR,ZcplcFdFvSdL,ZcplcFdFvSdR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplcFeFvSeL,      & 
& ZcplcFeFvSeR,ZcplHpmSucSd,ZcplHpmSvcSe,ZcplcChacFuSdL,ZcplcChacFuSdR,AmpVertexChaToFvHpm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvHpm(MChaOS,MFdOS,MFeOS,MFuOS,MHpmOS,          & 
& MSdOS,MSeOS,MSuOS,MSvOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MHpm2OS,MSd2OS,MSe2OS,            & 
& MSu2OS,MSv2OS,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecSeL,         & 
& cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplHpmSucSd,cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToFvHpm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvHpm(MCha,MCha2,MHpm,MHpm2,ZfFvL,ZfHpm,          & 
& ZfLm,ZfLp,AmpWaveChaToFvHpm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvHpm(MCha,MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplFvFdcSdL,cplFvFdcSdR,        & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,       & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplHpmSucSd,cplHpmSvcSe,             & 
& cplcChacFuSdL,cplcChacFuSdR,AmpVertexChaToFvHpm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fv Hpm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFvHpm = 0._dp 
 AmpSum2ChaToFvHpm = 0._dp  
Else 
 AmpSumChaToFvHpm = AmpVertexChaToFvHpm + AmpWaveChaToFvHpm
 AmpSum2ChaToFvHpm = AmpVertexChaToFvHpm + AmpWaveChaToFvHpm 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
    Do gt3=2,2
If (((OSkinematics).and.(MChaOS(gt1).gt.(0.+MHpmOS(gt3)))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(0.+MHpm(gt3))))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFS(MChaOS(gt1),0._dp,MHpmOS(gt3),AmpSumChaToFvHpm(:,gt1, gt2, gt3),AmpSum2ChaToFvHpm(:,gt1, gt2, gt3),AmpSqChaToFvHpm(gt1, gt2, gt3)) 
Else  
  Call SquareAmp_FtoFS(MCha(gt1),0._dp,MHpm(gt3),AmpSumChaToFvHpm(:,gt1, gt2, gt3),AmpSum2ChaToFvHpm(:,gt1, gt2, gt3),AmpSqChaToFvHpm(gt1, gt2, gt3)) 
End if  
Else  
  AmpSqChaToFvHpm(gt1, gt2, gt3) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFvHpm(gt1, gt2, gt3).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),0._dp,MHpmOS(gt3),helfactor*AmpSqChaToFvHpm(gt1, gt2, gt3))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),0._dp,MHpm(gt3),helfactor*AmpSqChaToFvHpm(gt1, gt2, gt3))
End if 
If ((Abs(MRPChaToFvHpm(gt1, gt2, gt3)).gt.1.0E-20_dp).or.(Abs(MRGChaToFvHpm(gt1, gt2, gt3)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

    End do
  End do
If (gt1.eq.2) isave = i4 
End do
!---------------- 
! Fv VWm
!---------------- 

If (LoopInducedDecaysOS) Then 


!Self-energy Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvVWm(MChaOS,MCha2OS,MVWmOS,MVWm2OS,              & 
& ZfFvL,ZfLm,ZfLp,ZfVWm,AmpWaveChaToFvVWm)

 Else 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvVWm(MChaOS,MCha2OS,MVWmOS,MVWm2OS,              & 
& ZfFvL,ZfLm,ZfLp,ZfVWm,AmpWaveChaToFvVWm)

 End if 


!Vertex Corrections 
 If (ExternalZfactors) Then 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvVWm(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,ZcplFvFdcSdL,ZcplFvFdcSdR,ZcplcChaFdcSuL,ZcplcChaFdcSuR,ZcplFvFecSeL,   & 
& ZcplFvFecSeR,ZcplcChaFecSvL,ZcplcChaFecSvR,ZcplcFdFuVWmL,ZcplcFdFuVWmR,ZcplcFdFvSdL,   & 
& ZcplcFdFvSdR,ZcplcChaFvSeL,ZcplcChaFvSeR,ZcplcFeFvSeL,ZcplcFeFvSeR,ZcplcFeFvVWmL,      & 
& ZcplcFeFvVWmR,ZcplcChacFuSdL,ZcplcChacFuSdR,ZcplSucSdVWm,ZcplSvcSeVWm,AmpVertexChaToFvVWm)

 Else 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvVWm(MChaOS,MFdOS,MFeOS,MFuOS,MSdOS,           & 
& MSeOS,MSuOS,MSvOS,MVWmOS,MCha2OS,MFd2OS,MFe2OS,MFu2OS,MSd2OS,MSe2OS,MSu2OS,            & 
& MSv2OS,MVWm2OS,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecSeL,        & 
& cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,         & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplcChacFuSdL,cplcChacFuSdR,cplSucSdVWm,cplSvcSeVWm,AmpVertexChaToFvVWm)

 End if 
Else 


!Self-energy Corrections 
Call Amplitude_WAVE_MSSMTriLnV_ChaToFvVWm(MCha,MCha2,MVWm,MVWm2,ZfFvL,ZfLm,           & 
& ZfLp,ZfVWm,AmpWaveChaToFvVWm)



!Vertex Corrections 
Call Amplitude_VERTEX_MSSMTriLnV_ChaToFvVWm(MCha,MFd,MFe,MFu,MSd,MSe,MSu,             & 
& MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,       & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcChacFuSdL,cplcChacFuSdR,         & 
& cplSucSdVWm,cplSvcSeVWm,AmpVertexChaToFvVWm)

End if 


 !Square the amplityde 
If (DebugLoopDecays) Then 
Write(*,*) "------------------ Cha->Fv VWm -----------------------" 
End if 
If (OnlyTreeLevelContributions) Then 
 AmpSumChaToFvVWm = 0._dp 
 AmpSum2ChaToFvVWm = 0._dp  
Else 
 AmpSumChaToFvVWm = AmpVertexChaToFvVWm + AmpWaveChaToFvVWm
 AmpSum2ChaToFvVWm = AmpVertexChaToFvVWm + AmpWaveChaToFvVWm 
End If 
Do gt1=1,2
i4 = isave 
  Do gt2=1,3
If (((OSkinematics).and.(MChaOS(gt1).gt.(0.+MVWmOS))).or.((.not.OSkinematics).and.(MCha(gt1).gt.(0.+MVWm)))) Then 
If (OSkinematics) Then 
  Call SquareAmp_FtoFV(MChaOS(gt1),0._dp,MVWmOS,AmpSumChaToFvVWm(:,gt1, gt2),AmpSum2ChaToFvVWm(:,gt1, gt2),AmpSqChaToFvVWm(gt1, gt2)) 
Else  
  Call SquareAmp_FtoFV(MCha(gt1),0._dp,MVWm,AmpSumChaToFvVWm(:,gt1, gt2),AmpSum2ChaToFvVWm(:,gt1, gt2),AmpSqChaToFvVWm(gt1, gt2)) 
End if  
Else  
  AmpSqChaToFvVWm(gt1, gt2) = 0._dp 
End if  

! Calculate Partial widths 
helfactor = 2._dp 
If (AmpSqChaToFvVWm(gt1, gt2).eq.0._dp) Then 
  gP1LCha(gt1,i4) = 0._dp 
Else 
If (OSkinematics) Then 
  gP1LCha(gt1,i4) = 1*GammaTPS(MChaOS(gt1),0._dp,MVWmOS,helfactor*AmpSqChaToFvVWm(gt1, gt2))
Else 
  gP1LCha(gt1,i4) = 1*GammaTPS(MCha(gt1),0._dp,MVWm,helfactor*AmpSqChaToFvVWm(gt1, gt2))
End if 
If ((Abs(MRPChaToFvVWm(gt1, gt2)).gt.1.0E-20_dp).or.(Abs(MRGChaToFvVWm(gt1, gt2)).gt.1.0E-20_dp)) Then 
  phasespacefactor = 1._dp 
End if 
 If (DebugLoopDecays) Write(*,*) "virtual", gP1LCha(gt1,i4) 
End if 
i4=i4+1

  End do
If (gt1.eq.2) isave = i4 
End do
End Subroutine OneLoopDecay_Cha

End Module Wrapper_OneLoopDecay_Cha_MSSMTriLnV
