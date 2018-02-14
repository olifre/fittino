! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.12.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 13:05 on 7.2.2018   
! ----------------------------------------------------------------------  
 
 
Module BranchingRatios_MSSMTriLnV 
 
Use Control 
Use Settings 
Use Couplings_MSSMTriLnV 
Use Model_Data_MSSMTriLnV 
Use LoopCouplings_MSSMTriLnV 
Use Glu3Decays_MSSMTriLnV 
Use Chi3Decays_MSSMTriLnV 
Use Cha3Decays_MSSMTriLnV 
Use Sd3Decays_MSSMTriLnV 
Use Su3Decays_MSSMTriLnV 
Use Se3Decays_MSSMTriLnV 
Use Sv3Decays_MSSMTriLnV 
Use TreeLevelDecays_MSSMTriLnV 


 Contains 
 
Subroutine CalculateBR(CTBD,fac3,epsI,deltaM,kont,MAh,MAh2,MCha,MCha2,MChi,           & 
& MChi2,MFd,MFd2,MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,              & 
& MSe,MSe2,MSu,MSu2,MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,            & 
& ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,vd,vu,g1,g2,g3,Yd,Ye,             & 
& L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gPSd,            & 
& gTSd,BRSd,gPSu,gTSu,BRSu,gPSe,gTSe,BRSe,gPSv,gTSv,BRSv,gPhh,gThh,BRhh,gPAh,            & 
& gTAh,BRAh,gPHpm,gTHpm,BRHpm,gPGlu,gTGlu,BRGlu,gPChi,gTChi,BRChi,gPCha,gTCha,           & 
& BRCha,gPFu,gTFu,BRFu)

Real(dp), Intent(in) :: epsI, deltaM, fac3 
Integer, Intent(inout) :: kont 
Logical, Intent(in) :: CTBD 
Real(dp),Intent(inout) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(inout) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp),Intent(in) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

Real(dp),Intent(inout) :: vd,vu

Real(dp),Intent(inout) :: gPSd(6,1899),gTSd(6),BRSd(6,1899),gPSu(6,1638),gTSu(6),BRSu(6,1638),gPSe(6,1938),     & 
& gTSe(6),BRSe(6,1938),gPSv(3,2052),gTSv(3),BRSv(3,2052),gPhh(2,171),gThh(2),            & 
& BRhh(2,171),gPAh(2,157),gTAh(2),BRAh(2,157),gPHpm(2,88),gTHpm(2),BRHpm(2,88),          & 
& gPGlu(1,180),gTGlu,BRGlu(1,180),gPChi(4,442),gTChi(4),BRChi(4,442),gPCha(2,407),       & 
& gTCha(2),BRCha(2,407),gPFu(3,96),gTFu(3),BRFu(3,96)

Complex(dp) :: cplHiggsPP(2),cplHiggsGG(2),cplPseudoHiggsPP(2),cplPseudoHiggsGG(2),cplHiggsZZvirt(2),& 
& cplHiggsWWvirt(2)

Real(dp) :: gGluFdcFdChi(1,3,3,4),gGluFdcFdFv(1,3,3,3),gGluFdcFucCha(1,3,3,2),gGluFdcFucFe(1,3,3,3),& 
& gGluFucFuChi(1,3,3,4),gChiChicChaCha(4,4,2,2),gChiChiChiChi(4,4,4,4),gChiChicFdFd(4,4,3,3),& 
& gChiChicFeFe(4,4,3,3),gChiChicFuFu(4,4,3,3),gChiChacFdFu(4,2,3,3),gChiChacFeFv(4,2,3,3),& 
& gChiChiFvFv(4,4,3,3),gChiFdcFdFv(4,3,3,3),gChiFdcFdGlu(4,3,3,1),gChiFdcFucFe(4,3,3,3), & 
& gChiFecFeFv(4,3,3,3),gChiFucFuGlu(4,3,3,1),gChaChacChaCha(2,2,2,2),gChaChaChiChi(2,2,4,4),& 
& gChaChacFdFd(2,2,3,3),gChaChacFeFe(2,2,3,3),gChaChacFuFu(2,2,3,3),gChaChaFvFv(2,2,3,3),& 
& gChaChicFuFd(2,4,3,3),gChaChiFvFe(2,4,3,3),gChaFdcFdFe(2,3,3,3),gChaFdcFuGlu(2,3,3,1), & 
& gChaFecFeFe(2,3,3,3),gChaFvcFuFd(2,3,3,3),gChaFvFvFe(2,3,3,3),gChacFuFuFe(2,3,3,3),    & 
& gSdAhChaFu(6,2,2,3),gSdAhChiFd(6,2,4,3),gSdAhFdFv(6,2,3,3),gSdAhFdGlu(6,2,3,1),        & 
& gSdAhFeFu(6,2,3,3),gSdSuChaChi(6,6,2,4),gSdChaFdcHpm(6,2,3,2),gSdChaFdcSe(6,2,3,6),    & 
& gSdhhChaFu(6,2,2,3),gSdChaGluSu(6,2,1,6),gSdSdChacCha(6,6,2,2),gSdSdChacFe(6,6,2,3),   & 
& gSdSdChiChi(6,6,4,4),gSdhhChiFd(6,2,4,3),gSdSvChiFd(6,3,4,3),gSdcSvChiFd(6,3,4,3),     & 
& gSdSuChiFe(6,6,4,3),gSdHpmChiFu(6,2,4,3),gSdSeChiFu(6,6,4,3),gSdSdChiFv(6,6,4,3),      & 
& gSdChiGluSd(6,4,1,6),gSdFdFdcSd(6,3,3,6),gSdFeFdcSe(6,3,3,6),gSdFuFdcSu(6,3,3,6),      & 
& gSdSvFdFv(6,3,3,3),gSdcSvFdFv(6,3,3,3),gSdHpmFdcCha(6,2,3,2),gSdSdFdcFd(6,6,3,3),      & 
& gSdSeFdcFe(6,6,3,3),gSdSuFdcFu(6,6,3,3),gSdFeFdcHpm(6,3,3,2),gSdHpmFdcFe(6,2,3,3),     & 
& gSdSeFdcCha(6,6,3,2),gSdhhFeFu(6,2,3,3),gSdFeGluSu(6,3,1,6),gSdSdFecCha(6,6,3,2),      & 
& gSdSdFecFe(6,6,3,3),gSdcSvFeFu(6,3,3,3),gSdFuFvSe(6,3,3,6),gSdSdFucFu(6,6,3,3),        & 
& gSdSvChaFu(6,3,2,3),gSdSvFeFu(6,3,3,3),gSdFuFvHpm(6,3,3,2),gSdSuChaFv(6,6,2,3),        & 
& gSdhhFdFv(6,2,3,3),gSdSuFeFv(6,6,3,3),gSdSdFvFv(6,6,3,3),gSdFvGluSd(6,3,1,6),          & 
& gSdhhFdGlu(6,2,3,1),gSdSvFdGlu(6,3,3,1),gSdcSvFdGlu(6,3,3,1),gSdHpmFuGlu(6,2,3,1),     & 
& gSdSeFuGlu(6,6,3,1),gSdGluGluSd(6,1,1,6),gSdcSvChaFu(6,3,2,3),gSuAhChiFu(6,2,4,3),     & 
& gSuAhFdcCha(6,2,3,2),gSuAhFdcFe(6,2,3,3),gSuAhFuGlu(6,2,3,1),gSuSuChiChi(6,6,4,4),     & 
& gSucHpmChiFd(6,2,4,3),gSucSeChiFd(6,6,4,3),gSuhhChiFu(6,2,4,3),gSuChiGluSu(6,4,1,6),   & 
& gSuSdChicCha(6,6,4,2),gSuSdChicFe(6,6,4,3),gSuFdFucSd(6,3,3,6),gSucSeFdFv(6,6,3,3),    & 
& gSuhhFdcCha(6,2,3,2),gSuSuFdcFd(6,6,3,3),gSuFdSvcFe(6,3,3,3),gSucHpmFdFv(6,2,3,3),     & 
& gSuhhFdcFe(6,2,3,3),gSuFdcChacSv(6,3,2,3),gSuFdcFecSv(6,3,3,3),gSucHpmChaFu(6,2,2,3),  & 
& gSucSeFeFu(6,6,3,3),gSuFuFucSu(6,3,3,6),gSuFuFvSv(6,3,3,3),gSuFuFvcSv(6,3,3,3),        & 
& gSucChaFuHpm(6,2,3,2),gSuSdFucFd(6,6,3,3),gSucFeFuSe(6,3,3,6),gSuSuFucFu(6,6,3,3),     & 
& gSucHpmFdGlu(6,2,3,1),gSucSeFdGlu(6,6,3,1),gSuhhFuGlu(6,2,3,1),gSuGluGluSu(6,1,1,6),   & 
& gSuGluSdcCha(6,1,6,2),gSuGluSdcFe(6,1,6,3),gSuSdFvcFe(6,6,3,3),gSuSdFvcCha(6,6,3,2),   & 
& gSuSuChacCha(6,6,2,2),gSuSuFecFe(6,6,3,3),gSuSuFvFv(6,6,3,3),gSucChaFdSv(6,2,3,3),     & 
& gSucChaFeSu(6,2,3,6),gSucChaFuSe(6,2,3,6),gSucFeChaSu(6,3,2,6),gSucFeFuHpm(6,3,3,2),   & 
& gSucHpmFeFu(6,2,3,3),gSucSeChaFu(6,6,2,3),gSeAhChaFv(6,2,2,3),gSeAhChiFe(6,2,4,3),     & 
& gSeAhFdcFu(6,2,3,3),gSeAhFeFv(6,2,3,3),gSeChaChacSe(6,2,2,6),gSeSvChaChi(6,3,2,4),     & 
& gSeChaChicSv(6,2,4,3),gSeFdChacSd(6,3,2,6),gSeChaFecHpm(6,2,3,2),gSeChaFecSe(6,2,3,6), & 
& gSeChaHpmcFe(6,2,2,3),gSeSdChacFd(6,6,2,3),gSeSeChacCha(6,6,2,2),gSeSeChacFe(6,6,2,3)

Real(dp) :: gSeSeChiChi(6,6,4,4),gSecSuChiFd(6,6,4,3),gSehhChiFe(6,2,4,3),gSeSvChiFe(6,3,4,3),     & 
& gSecSvChiFe(6,3,4,3),gSeHpmChiFv(6,2,4,3),gSeSeChiFv(6,6,4,3),gSeSdChicFu(6,6,4,3),    & 
& gSeFdFecSd(6,3,3,6),gSecSuFdGlu(6,6,3,1),gSehhFdcFu(6,2,3,3),gSeHpmFdcFd(6,2,3,3),     & 
& gSeSeFdcFd(6,6,3,3),gSeFeFecSe(6,3,3,6),gSecSuFeFu(6,6,3,3),gSeSvFeFv(6,3,3,3),        & 
& gSecSvFeFv(6,3,3,3),gSeHpmFecCha(6,2,3,2),gSeSdFecFd(6,6,3,3),gSeSeFecFe(6,6,3,3),     & 
& gSecFuFeSu(6,3,3,6),gSeFeFecHpm(6,3,3,2),gSeHpmFecFe(6,2,3,3),gSeSeFecCha(6,6,3,2),    & 
& gSehhChaFv(6,2,2,3),gSecSuFdFv(6,6,3,3),gSeSeFvFv(6,6,3,3),gSeFvSdcFu(6,3,6,3),        & 
& gSeSvChaFv(6,3,2,3),gSehhFeFv(6,2,3,3),gSeFvFvHpm(6,3,3,2),gSeSdGlucFu(6,6,1,3),       & 
& gSeSeFucFu(6,6,3,3),gSeSvFdcFu(6,3,3,3),gSecFuChaSu(6,3,2,6),gSecSvFdcFu(6,3,3,3),     & 
& gSecFuFuHpm(6,3,3,2),gSecSuChaFu(6,6,2,3),gSecSvChaFv(6,3,2,3),gSvChiChacSe(3,4,2,6),  & 
& gSvSvChiChi(3,3,4,4),gSvChiChicSv(3,4,4,3),gSvcSdChiFd(3,6,4,3),gSvcHpmChiFe(3,2,4,3), & 
& gSvcSeChiFe(3,6,4,3),gSvChiHpmcFe(3,4,2,3),gSvSdChicFd(3,6,4,3),gSvSeChicCha(3,6,4,2), & 
& gSvSeChicFe(3,6,4,3),gSvFdAhcFd(3,3,2,3),gSvcSdFdFv(3,6,3,3),gSvcSdFdGlu(3,6,3,1),     & 
& gSvhhFdcFd(3,2,3,3),gSvSvFdcFd(3,3,3,3),gSvFdcChacSu(3,3,2,6),gSvFdcFdcSv(3,3,3,3),    & 
& gSvFdcFecSu(3,3,3,6),gSvcHpmFdcFu(3,2,3,3),gSvcSeFdcFu(3,6,3,3),gSvFeAhcCha(3,3,2,2),  & 
& gSvcSdFeFu(3,6,3,3),gSvcSeFeFv(3,6,3,3),gSvhhFecCha(3,2,3,2),gSvFeSucFd(3,3,6,3),      & 
& gSvSvFecFe(3,3,3,3),gSvFeAhcFe(3,3,2,3),gSvcHpmFeFv(3,2,3,3),gSvhhFecFe(3,2,3,3),      & 
& gSvFecChacSv(3,3,2,3),gSvFecFecSv(3,3,3,3),gSvFvAhChi(3,3,2,4),gSvcHpmChaFv(3,2,2,3),  & 
& gSvhhChiFv(3,2,4,3),gSvFvFucSu(3,3,3,6),gSvSvFvFv(3,3,3,3),gSvFvFvcSv(3,3,3,3),        & 
& gSvcChaFvHpm(3,2,3,2),gSvSdFvcFd(3,6,3,3),gSvSeFvcFe(3,6,3,3),gSvFvSucFu(3,3,6,3),     & 
& gSvSdGlucFd(3,6,1,3),gSvSdcChacFu(3,6,2,3),gSvSdcFecFu(3,6,3,3),gSvSeFucFd(3,6,3,3),   & 
& gSvSeFvcCha(3,6,3,2),gSvSvChacCha(3,3,2,2),gSvSvFucFu(3,3,3,3),gSvcChaFeSv(3,2,3,3),   & 
& gSvcFdChaSu(3,3,2,6),gSvcFdFuHpm(3,3,3,2),gSvcFeChaSv(3,3,2,3),gSvcFeFvHpm(3,3,3,2),   & 
& gSvcSdChaFu(3,6,2,3),gSvcSeChaFv(3,6,2,3)

Complex(dp) :: coup 
Real(dp) :: vev 
Real(dp) :: gTVZ,gTVWm

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateBR'
 
Write(*,*) "Calculating branching ratios and decay widths" 
gTVWm = gamW 
gTVZ = gamZ 
gPSd = 0._dp 
gTSd = 0._dp 
BRSd = 0._dp 
Call SdTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPSd(:,1:147),gTSd,             & 
& BRSd(:,1:147))

Do i1=1,6
gTSd(i1) =Sum(gPSd(i1,:)) 
If (gTSd(i1).Gt.0._dp) BRSd(i1,: ) =gPSd(i1,:)/gTSd(i1) 
End Do 
 

gPSu = 0._dp 
gTSu = 0._dp 
BRSu = 0._dp 
Call SuTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPSu(:,1:102),gTSu,             & 
& BRSu(:,1:102))

Do i1=1,6
gTSu(i1) =Sum(gPSu(i1,:)) 
If (gTSu(i1).Gt.0._dp) BRSu(i1,: ) =gPSu(i1,:)/gTSu(i1) 
End Do 
 

gPSe = 0._dp 
gTSe = 0._dp 
BRSe = 0._dp 
Call SeTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPSe(:,1:138),gTSe,             & 
& BRSe(:,1:138))

Do i1=1,6
gTSe(i1) =Sum(gPSe(i1,:)) 
If (gTSe(i1).Gt.0._dp) BRSe(i1,: ) =gPSe(i1,:)/gTSe(i1) 
End Do 
 

gPSv = 0._dp 
gTSv = 0._dp 
BRSv = 0._dp 
Call SvTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPSv(:,1:129),gTSv,             & 
& BRSv(:,1:129))

Do i1=1,3
gTSv(i1) =Sum(gPSv(i1,:)) 
If (gTSv(i1).Gt.0._dp) BRSv(i1,: ) =gPSv(i1,:)/gTSv(i1) 
End Do 
 

gPhh = 0._dp 
gThh = 0._dp 
BRhh = 0._dp 
Call hhTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPhh,gThh,BRhh)

Do i1=1,2
gThh(i1) =Sum(gPhh(i1,:)) 
If (gThh(i1).Gt.0._dp) BRhh(i1,: ) =gPhh(i1,:)/gThh(i1) 
End Do 
 

gPAh = 0._dp 
gTAh = 0._dp 
BRAh = 0._dp 
Call AhTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPAh,gTAh,BRAh)

Do i1=1,2
gTAh(i1) =Sum(gPAh(i1,:)) 
If (gTAh(i1).Gt.0._dp) BRAh(i1,: ) =gPAh(i1,:)/gTAh(i1) 
End Do 
 

! Set Goldstone Widhts 
gTAh(1)=gTVZ


gPHpm = 0._dp 
gTHpm = 0._dp 
BRHpm = 0._dp 
Call HpmTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,               & 
& MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,           & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPHpm,gTHpm,BRHpm)

Do i1=1,2
gTHpm(i1) =Sum(gPHpm(i1,:)) 
If (gTHpm(i1).Gt.0._dp) BRHpm(i1,: ) =gPHpm(i1,:)/gTHpm(i1) 
End Do 
 

! Set Goldstone Widhts 
gTHpm(1)=gTVWm


gPGlu = 0._dp 
gTGlu = 0._dp 
BRGlu = 0._dp 
Call GluTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,               & 
& MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,           & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPGlu(:,1:36),gTGlu,            & 
& BRGlu(:,1:36))

Do i1=1,1
gTGlu =Sum(gPGlu(i1,:)) 
If (gTGlu.Gt.0._dp) BRGlu(i1,: ) =gPGlu(i1,:)/gTGlu 
End Do 
 

gPChi = 0._dp 
gTChi = 0._dp 
BRChi = 0._dp 
Call ChiTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,               & 
& MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,           & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPChi(:,1:83),gTChi,            & 
& BRChi(:,1:83))

Do i1=1,4
gTChi(i1) =Sum(gPChi(i1,:)) 
If (gTChi(i1).Gt.0._dp) BRChi(i1,: ) =gPChi(i1,:)/gTChi(i1) 
End Do 
 

gPCha = 0._dp 
gTCha = 0._dp 
BRCha = 0._dp 
Call ChaTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,               & 
& MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,           & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPCha(:,1:79),gTCha,            & 
& BRCha(:,1:79))

Do i1=1,2
gTCha(i1) =Sum(gPCha(i1,:)) 
If (gTCha(i1).Gt.0._dp) BRCha(i1,: ) =gPCha(i1,:)/gTCha(i1) 
End Do 
 

gPFu = 0._dp 
gTFu = 0._dp 
BRFu = 0._dp 
Call FuTwoBodyDecay(-1,DeltaM,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,            & 
& MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,               & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gPFu,gTFu,BRFu)

Do i1=1,3
gTFu(i1) =Sum(gPFu(i1,:)) 
If (gTFu(i1).Gt.0._dp) BRFu(i1,: ) =gPFu(i1,:)/gTFu(i1) 
End Do 
 

If (.Not.CTBD) Then 
If ((Enable3BDecaysS).and.(Calc3BodyDecay_Sd)) Then 
If (MaxVal(gTSd).Lt.MaxVal(fac3*Abs(MSd))) Then 
Call SdThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSdAhChaFu,gSdAhChiFd,gSdAhFdFv,          & 
& gSdAhFdGlu,gSdAhFeFu,gSdSuChaChi,gSdChaFdcHpm,gSdChaFdcSe,gSdhhChaFu,gSdChaGluSu,      & 
& gSdSdChacCha,gSdSdChacFe,gSdSdChiChi,gSdhhChiFd,gSdSvChiFd,gSdcSvChiFd,gSdSuChiFe,     & 
& gSdHpmChiFu,gSdSeChiFu,gSdSdChiFv,gSdChiGluSd,gSdFdFdcSd,gSdFeFdcSe,gSdFuFdcSu,        & 
& gSdSvFdFv,gSdcSvFdFv,gSdHpmFdcCha,gSdSdFdcFd,gSdSeFdcFe,gSdSuFdcFu,gSdFeFdcHpm,        & 
& gSdHpmFdcFe,gSdSeFdcCha,gSdhhFeFu,gSdFeGluSu,gSdSdFecCha,gSdSdFecFe,gSdcSvFeFu,        & 
& gSdFuFvSe,gSdSdFucFu,gSdSvChaFu,gSdSvFeFu,gSdFuFvHpm,gSdSuChaFv,gSdhhFdFv,             & 
& gSdSuFeFv,gSdSdFvFv,gSdFvGluSd,gSdhhFdGlu,gSdSvFdGlu,gSdcSvFdGlu,gSdHpmFuGlu,          & 
& gSdSeFuGlu,gSdGluGluSd,gSdcSvChaFu,epsI,deltaM,.False.,gTSd,gPSd(:,148:1899)           & 
& ,BRSd(:,148:1899))

Else 
Call SdThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSdAhChaFu,gSdAhChiFd,gSdAhFdFv,          & 
& gSdAhFdGlu,gSdAhFeFu,gSdSuChaChi,gSdChaFdcHpm,gSdChaFdcSe,gSdhhChaFu,gSdChaGluSu,      & 
& gSdSdChacCha,gSdSdChacFe,gSdSdChiChi,gSdhhChiFd,gSdSvChiFd,gSdcSvChiFd,gSdSuChiFe,     & 
& gSdHpmChiFu,gSdSeChiFu,gSdSdChiFv,gSdChiGluSd,gSdFdFdcSd,gSdFeFdcSe,gSdFuFdcSu,        & 
& gSdSvFdFv,gSdcSvFdFv,gSdHpmFdcCha,gSdSdFdcFd,gSdSeFdcFe,gSdSuFdcFu,gSdFeFdcHpm,        & 
& gSdHpmFdcFe,gSdSeFdcCha,gSdhhFeFu,gSdFeGluSu,gSdSdFecCha,gSdSdFecFe,gSdcSvFeFu,        & 
& gSdFuFvSe,gSdSdFucFu,gSdSvChaFu,gSdSvFeFu,gSdFuFvHpm,gSdSuChaFv,gSdhhFdFv,             & 
& gSdSuFeFv,gSdSdFvFv,gSdFvGluSd,gSdhhFdGlu,gSdSvFdGlu,gSdcSvFdGlu,gSdHpmFuGlu,          & 
& gSdSeFuGlu,gSdGluGluSd,gSdcSvChaFu,epsI,deltaM,.True.,gTSd,gPSd(:,148:1899)            & 
& ,BRSd(:,148:1899))

End If 
 
End If 
Else 
Call SdThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSdAhChaFu,gSdAhChiFd,gSdAhFdFv,          & 
& gSdAhFdGlu,gSdAhFeFu,gSdSuChaChi,gSdChaFdcHpm,gSdChaFdcSe,gSdhhChaFu,gSdChaGluSu,      & 
& gSdSdChacCha,gSdSdChacFe,gSdSdChiChi,gSdhhChiFd,gSdSvChiFd,gSdcSvChiFd,gSdSuChiFe,     & 
& gSdHpmChiFu,gSdSeChiFu,gSdSdChiFv,gSdChiGluSd,gSdFdFdcSd,gSdFeFdcSe,gSdFuFdcSu,        & 
& gSdSvFdFv,gSdcSvFdFv,gSdHpmFdcCha,gSdSdFdcFd,gSdSeFdcFe,gSdSuFdcFu,gSdFeFdcHpm,        & 
& gSdHpmFdcFe,gSdSeFdcCha,gSdhhFeFu,gSdFeGluSu,gSdSdFecCha,gSdSdFecFe,gSdcSvFeFu,        & 
& gSdFuFvSe,gSdSdFucFu,gSdSvChaFu,gSdSvFeFu,gSdFuFvHpm,gSdSuChaFv,gSdhhFdFv,             & 
& gSdSuFeFv,gSdSdFvFv,gSdFvGluSd,gSdhhFdGlu,gSdSvFdGlu,gSdcSvFdGlu,gSdHpmFuGlu,          & 
& gSdSeFuGlu,gSdGluGluSd,gSdcSvChaFu,epsI,deltaM,.False.,gTSd,gPSd(:,148:1899)           & 
& ,BRSd(:,148:1899))

End If 
Do i1=1,6
gTSd(i1) =Sum(gPSd(i1,:)) 
If (gTSd(i1).Gt.0._dp) BRSd(i1,: ) =gPSd(i1,:)/gTSd(i1) 
End Do 
 

If (.Not.CTBD) Then 
If ((Enable3BDecaysS).and.(Calc3BodyDecay_Su)) Then 
If (MaxVal(gTSu).Lt.MaxVal(fac3*Abs(MSu))) Then 
Call SuThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSuAhChiFu,gSuAhFdcCha,gSuAhFdcFe,        & 
& gSuAhFuGlu,gSuSuChiChi,gSucHpmChiFd,gSucSeChiFd,gSuhhChiFu,gSuChiGluSu,gSuSdChicCha,   & 
& gSuSdChicFe,gSuFdFucSd,gSucSeFdFv,gSuhhFdcCha,gSuSuFdcFd,gSuFdSvcFe,gSucHpmFdFv,       & 
& gSuhhFdcFe,gSuFdcChacSv,gSuFdcFecSv,gSucHpmChaFu,gSucSeFeFu,gSuFuFucSu,gSuFuFvSv,      & 
& gSuFuFvcSv,gSucChaFuHpm,gSuSdFucFd,gSucFeFuSe,gSuSuFucFu,gSucHpmFdGlu,gSucSeFdGlu,     & 
& gSuhhFuGlu,gSuGluGluSu,gSuGluSdcCha,gSuGluSdcFe,gSuSdFvcFe,gSuSdFvcCha,gSuSuChacCha,   & 
& gSuSuFecFe,gSuSuFvFv,gSucChaFdSv,gSucChaFeSu,gSucChaFuSe,gSucFeChaSu,gSucFeFuHpm,      & 
& gSucHpmFeFu,gSucSeChaFu,epsI,deltaM,.False.,gTSu,gPSu(:,103:1638),BRSu(:,103:1638))

Else 
Call SuThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSuAhChiFu,gSuAhFdcCha,gSuAhFdcFe,        & 
& gSuAhFuGlu,gSuSuChiChi,gSucHpmChiFd,gSucSeChiFd,gSuhhChiFu,gSuChiGluSu,gSuSdChicCha,   & 
& gSuSdChicFe,gSuFdFucSd,gSucSeFdFv,gSuhhFdcCha,gSuSuFdcFd,gSuFdSvcFe,gSucHpmFdFv,       & 
& gSuhhFdcFe,gSuFdcChacSv,gSuFdcFecSv,gSucHpmChaFu,gSucSeFeFu,gSuFuFucSu,gSuFuFvSv,      & 
& gSuFuFvcSv,gSucChaFuHpm,gSuSdFucFd,gSucFeFuSe,gSuSuFucFu,gSucHpmFdGlu,gSucSeFdGlu,     & 
& gSuhhFuGlu,gSuGluGluSu,gSuGluSdcCha,gSuGluSdcFe,gSuSdFvcFe,gSuSdFvcCha,gSuSuChacCha,   & 
& gSuSuFecFe,gSuSuFvFv,gSucChaFdSv,gSucChaFeSu,gSucChaFuSe,gSucFeChaSu,gSucFeFuHpm,      & 
& gSucHpmFeFu,gSucSeChaFu,epsI,deltaM,.True.,gTSu,gPSu(:,103:1638),BRSu(:,103:1638))

End If 
 
End If 
Else 
Call SuThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSuAhChiFu,gSuAhFdcCha,gSuAhFdcFe,        & 
& gSuAhFuGlu,gSuSuChiChi,gSucHpmChiFd,gSucSeChiFd,gSuhhChiFu,gSuChiGluSu,gSuSdChicCha,   & 
& gSuSdChicFe,gSuFdFucSd,gSucSeFdFv,gSuhhFdcCha,gSuSuFdcFd,gSuFdSvcFe,gSucHpmFdFv,       & 
& gSuhhFdcFe,gSuFdcChacSv,gSuFdcFecSv,gSucHpmChaFu,gSucSeFeFu,gSuFuFucSu,gSuFuFvSv,      & 
& gSuFuFvcSv,gSucChaFuHpm,gSuSdFucFd,gSucFeFuSe,gSuSuFucFu,gSucHpmFdGlu,gSucSeFdGlu,     & 
& gSuhhFuGlu,gSuGluGluSu,gSuGluSdcCha,gSuGluSdcFe,gSuSdFvcFe,gSuSdFvcCha,gSuSuChacCha,   & 
& gSuSuFecFe,gSuSuFvFv,gSucChaFdSv,gSucChaFeSu,gSucChaFuSe,gSucFeChaSu,gSucFeFuHpm,      & 
& gSucHpmFeFu,gSucSeChaFu,epsI,deltaM,.False.,gTSu,gPSu(:,103:1638),BRSu(:,103:1638))

End If 
Do i1=1,6
gTSu(i1) =Sum(gPSu(i1,:)) 
If (gTSu(i1).Gt.0._dp) BRSu(i1,: ) =gPSu(i1,:)/gTSu(i1) 
End Do 
 

If (.Not.CTBD) Then 
If ((Enable3BDecaysS).and.(Calc3BodyDecay_Se)) Then 
If (MaxVal(gTSe).Lt.MaxVal(fac3*Abs(MSe))) Then 
Call SeThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSeAhChaFv,gSeAhChiFe,gSeAhFdcFu,         & 
& gSeAhFeFv,gSeChaChacSe,gSeSvChaChi,gSeChaChicSv,gSeFdChacSd,gSeChaFecHpm,              & 
& gSeChaFecSe,gSeChaHpmcFe,gSeSdChacFd,gSeSeChacCha,gSeSeChacFe,gSeSeChiChi,             & 
& gSecSuChiFd,gSehhChiFe,gSeSvChiFe,gSecSvChiFe,gSeHpmChiFv,gSeSeChiFv,gSeSdChicFu,      & 
& gSeFdFecSd,gSecSuFdGlu,gSehhFdcFu,gSeHpmFdcFd,gSeSeFdcFd,gSeFeFecSe,gSecSuFeFu,        & 
& gSeSvFeFv,gSecSvFeFv,gSeHpmFecCha,gSeSdFecFd,gSeSeFecFe,gSecFuFeSu,gSeFeFecHpm,        & 
& gSeHpmFecFe,gSeSeFecCha,gSehhChaFv,gSecSuFdFv,gSeSeFvFv,gSeFvSdcFu,gSeSvChaFv,         & 
& gSehhFeFv,gSeFvFvHpm,gSeSdGlucFu,gSeSeFucFu,gSeSvFdcFu,gSecFuChaSu,gSecSvFdcFu,        & 
& gSecFuFuHpm,gSecSuChaFu,gSecSvChaFv,epsI,deltaM,.False.,gTSe,gPSe(:,139:1938)          & 
& ,BRSe(:,139:1938))

Else 
Call SeThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSeAhChaFv,gSeAhChiFe,gSeAhFdcFu,         & 
& gSeAhFeFv,gSeChaChacSe,gSeSvChaChi,gSeChaChicSv,gSeFdChacSd,gSeChaFecHpm,              & 
& gSeChaFecSe,gSeChaHpmcFe,gSeSdChacFd,gSeSeChacCha,gSeSeChacFe,gSeSeChiChi,             & 
& gSecSuChiFd,gSehhChiFe,gSeSvChiFe,gSecSvChiFe,gSeHpmChiFv,gSeSeChiFv,gSeSdChicFu,      & 
& gSeFdFecSd,gSecSuFdGlu,gSehhFdcFu,gSeHpmFdcFd,gSeSeFdcFd,gSeFeFecSe,gSecSuFeFu,        & 
& gSeSvFeFv,gSecSvFeFv,gSeHpmFecCha,gSeSdFecFd,gSeSeFecFe,gSecFuFeSu,gSeFeFecHpm,        & 
& gSeHpmFecFe,gSeSeFecCha,gSehhChaFv,gSecSuFdFv,gSeSeFvFv,gSeFvSdcFu,gSeSvChaFv,         & 
& gSehhFeFv,gSeFvFvHpm,gSeSdGlucFu,gSeSeFucFu,gSeSvFdcFu,gSecFuChaSu,gSecSvFdcFu,        & 
& gSecFuFuHpm,gSecSuChaFu,gSecSvChaFv,epsI,deltaM,.True.,gTSe,gPSe(:,139:1938)           & 
& ,BRSe(:,139:1938))

End If 
 
End If 
Else 
Call SeThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSeAhChaFv,gSeAhChiFe,gSeAhFdcFu,         & 
& gSeAhFeFv,gSeChaChacSe,gSeSvChaChi,gSeChaChicSv,gSeFdChacSd,gSeChaFecHpm,              & 
& gSeChaFecSe,gSeChaHpmcFe,gSeSdChacFd,gSeSeChacCha,gSeSeChacFe,gSeSeChiChi,             & 
& gSecSuChiFd,gSehhChiFe,gSeSvChiFe,gSecSvChiFe,gSeHpmChiFv,gSeSeChiFv,gSeSdChicFu,      & 
& gSeFdFecSd,gSecSuFdGlu,gSehhFdcFu,gSeHpmFdcFd,gSeSeFdcFd,gSeFeFecSe,gSecSuFeFu,        & 
& gSeSvFeFv,gSecSvFeFv,gSeHpmFecCha,gSeSdFecFd,gSeSeFecFe,gSecFuFeSu,gSeFeFecHpm,        & 
& gSeHpmFecFe,gSeSeFecCha,gSehhChaFv,gSecSuFdFv,gSeSeFvFv,gSeFvSdcFu,gSeSvChaFv,         & 
& gSehhFeFv,gSeFvFvHpm,gSeSdGlucFu,gSeSeFucFu,gSeSvFdcFu,gSecFuChaSu,gSecSvFdcFu,        & 
& gSecFuFuHpm,gSecSuChaFu,gSecSvChaFv,epsI,deltaM,.False.,gTSe,gPSe(:,139:1938)          & 
& ,BRSe(:,139:1938))

End If 
Do i1=1,6
gTSe(i1) =Sum(gPSe(i1,:)) 
If (gTSe(i1).Gt.0._dp) BRSe(i1,: ) =gPSe(i1,:)/gTSe(i1) 
End Do 
 

If (.Not.CTBD) Then 
If ((Enable3BDecaysS).and.(Calc3BodyDecay_Sv)) Then 
If (MaxVal(gTSv).Lt.MaxVal(fac3*Abs(MSv))) Then 
Call SvThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSvChiChacSe,gSvSvChiChi,gSvChiChicSv,    & 
& gSvcSdChiFd,gSvcHpmChiFe,gSvcSeChiFe,gSvChiHpmcFe,gSvSdChicFd,gSvSeChicCha,            & 
& gSvSeChicFe,gSvFdAhcFd,gSvcSdFdFv,gSvcSdFdGlu,gSvhhFdcFd,gSvSvFdcFd,gSvFdcChacSu,      & 
& gSvFdcFdcSv,gSvFdcFecSu,gSvcHpmFdcFu,gSvcSeFdcFu,gSvFeAhcCha,gSvcSdFeFu,               & 
& gSvcSeFeFv,gSvhhFecCha,gSvFeSucFd,gSvSvFecFe,gSvFeAhcFe,gSvcHpmFeFv,gSvhhFecFe,        & 
& gSvFecChacSv,gSvFecFecSv,gSvFvAhChi,gSvcHpmChaFv,gSvhhChiFv,gSvFvFucSu,gSvSvFvFv,      & 
& gSvFvFvcSv,gSvcChaFvHpm,gSvSdFvcFd,gSvSeFvcFe,gSvFvSucFu,gSvSdGlucFd,gSvSdcChacFu,     & 
& gSvSdcFecFu,gSvSeFucFd,gSvSeFvcCha,gSvSvChacCha,gSvSvFucFu,gSvcChaFeSv,gSvcFdChaSu,    & 
& gSvcFdFuHpm,gSvcFeChaSv,gSvcFeFvHpm,gSvcSdChaFu,gSvcSeChaFv,epsI,deltaM,               & 
& .False.,gTSv,gPSv(:,130:2052),BRSv(:,130:2052))

Else 
Call SvThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSvChiChacSe,gSvSvChiChi,gSvChiChicSv,    & 
& gSvcSdChiFd,gSvcHpmChiFe,gSvcSeChiFe,gSvChiHpmcFe,gSvSdChicFd,gSvSeChicCha,            & 
& gSvSeChicFe,gSvFdAhcFd,gSvcSdFdFv,gSvcSdFdGlu,gSvhhFdcFd,gSvSvFdcFd,gSvFdcChacSu,      & 
& gSvFdcFdcSv,gSvFdcFecSu,gSvcHpmFdcFu,gSvcSeFdcFu,gSvFeAhcCha,gSvcSdFeFu,               & 
& gSvcSeFeFv,gSvhhFecCha,gSvFeSucFd,gSvSvFecFe,gSvFeAhcFe,gSvcHpmFeFv,gSvhhFecFe,        & 
& gSvFecChacSv,gSvFecFecSv,gSvFvAhChi,gSvcHpmChaFv,gSvhhChiFv,gSvFvFucSu,gSvSvFvFv,      & 
& gSvFvFvcSv,gSvcChaFvHpm,gSvSdFvcFd,gSvSeFvcFe,gSvFvSucFu,gSvSdGlucFd,gSvSdcChacFu,     & 
& gSvSdcFecFu,gSvSeFucFd,gSvSeFvcCha,gSvSvChacCha,gSvSvFucFu,gSvcChaFeSv,gSvcFdChaSu,    & 
& gSvcFdFuHpm,gSvcFeChaSv,gSvcFeFvHpm,gSvcSdChaFu,gSvcSeChaFv,epsI,deltaM,               & 
& .True.,gTSv,gPSv(:,130:2052),BRSv(:,130:2052))

End If 
 
End If 
Else 
Call SvThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSvChiChacSe,gSvSvChiChi,gSvChiChicSv,    & 
& gSvcSdChiFd,gSvcHpmChiFe,gSvcSeChiFe,gSvChiHpmcFe,gSvSdChicFd,gSvSeChicCha,            & 
& gSvSeChicFe,gSvFdAhcFd,gSvcSdFdFv,gSvcSdFdGlu,gSvhhFdcFd,gSvSvFdcFd,gSvFdcChacSu,      & 
& gSvFdcFdcSv,gSvFdcFecSu,gSvcHpmFdcFu,gSvcSeFdcFu,gSvFeAhcCha,gSvcSdFeFu,               & 
& gSvcSeFeFv,gSvhhFecCha,gSvFeSucFd,gSvSvFecFe,gSvFeAhcFe,gSvcHpmFeFv,gSvhhFecFe,        & 
& gSvFecChacSv,gSvFecFecSv,gSvFvAhChi,gSvcHpmChaFv,gSvhhChiFv,gSvFvFucSu,gSvSvFvFv,      & 
& gSvFvFvcSv,gSvcChaFvHpm,gSvSdFvcFd,gSvSeFvcFe,gSvFvSucFu,gSvSdGlucFd,gSvSdcChacFu,     & 
& gSvSdcFecFu,gSvSeFucFd,gSvSeFvcCha,gSvSvChacCha,gSvSvFucFu,gSvcChaFeSv,gSvcFdChaSu,    & 
& gSvcFdFuHpm,gSvcFeChaSv,gSvcFeFvHpm,gSvcSdChaFu,gSvcSeChaFv,epsI,deltaM,               & 
& .False.,gTSv,gPSv(:,130:2052),BRSv(:,130:2052))

End If 
Do i1=1,3
gTSv(i1) =Sum(gPSv(i1,:)) 
If (gTSv(i1).Gt.0._dp) BRSv(i1,: ) =gPSv(i1,:)/gTSv(i1) 
End Do 
 

! No 3-body decays for hh  
! No 3-body decays for Ah  
! No 3-body decays for Hpm  
If (.Not.CTBD) Then 
If ((Enable3BDecaysF).and.(Calc3BodyDecay_Glu)) Then 
If (gTGlu.Lt.fac3*Abs(MGlu)) Then 
Call GluThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTSd,gTSu,gGluFdcFdChi,gGluFdcFdFv,       & 
& gGluFdcFucCha,gGluFdcFucFe,gGluFucFuChi,epsI,deltaM,.False.,gTGlu,gPGlu(:,37:180)      & 
& ,BRGlu(:,37:180))

Else 
Call GluThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTSd,gTSu,gGluFdcFdChi,gGluFdcFdFv,       & 
& gGluFdcFucCha,gGluFdcFucFe,gGluFucFuChi,epsI,deltaM,.True.,gTGlu,gPGlu(:,37:180)       & 
& ,BRGlu(:,37:180))

End If 
 
End If 
Else 
Call GluThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTSd,gTSu,gGluFdcFdChi,gGluFdcFdFv,       & 
& gGluFdcFucCha,gGluFdcFucFe,gGluFucFuChi,epsI,deltaM,.False.,gTGlu,gPGlu(:,37:180)      & 
& ,BRGlu(:,37:180))

End If 
Do i1=1,1
gTGlu =Sum(gPGlu(i1,:)) 
If (gTGlu.Gt.0._dp) BRGlu(i1,: ) =gPGlu(i1,:)/gTGlu 
End Do 
 

If (.Not.CTBD) Then 
If ((Enable3BDecaysF).and.(Calc3BodyDecay_Chi)) Then 
If (MaxVal(gTChi).Lt.MaxVal(fac3*Abs(MChi))) Then 
Call ChiThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTAh,gThh,gTHpm,gTSd,gTSe,gTSu,           & 
& gTSv,gTVWm,gTVZ,gChiChicChaCha,gChiChiChiChi,gChiChicFdFd,gChiChicFeFe,gChiChicFuFu,   & 
& gChiChacFdFu,gChiChacFeFv,gChiChiFvFv,gChiFdcFdFv,gChiFdcFdGlu,gChiFdcFucFe,           & 
& gChiFecFeFv,gChiFucFuGlu,epsI,deltaM,.False.,gTChi,gPChi(:,84:442),BRChi(:,84:442))

Else 
Call ChiThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTAh,gThh,gTHpm,gTSd,gTSe,gTSu,           & 
& gTSv,gTVWm,gTVZ,gChiChicChaCha,gChiChiChiChi,gChiChicFdFd,gChiChicFeFe,gChiChicFuFu,   & 
& gChiChacFdFu,gChiChacFeFv,gChiChiFvFv,gChiFdcFdFv,gChiFdcFdGlu,gChiFdcFucFe,           & 
& gChiFecFeFv,gChiFucFuGlu,epsI,deltaM,.True.,gTChi,gPChi(:,84:442),BRChi(:,84:442))

End If 
 
End If 
Else 
Call ChiThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTAh,gThh,gTHpm,gTSd,gTSe,gTSu,           & 
& gTSv,gTVWm,gTVZ,gChiChicChaCha,gChiChiChiChi,gChiChicFdFd,gChiChicFeFe,gChiChicFuFu,   & 
& gChiChacFdFu,gChiChacFeFv,gChiChiFvFv,gChiFdcFdFv,gChiFdcFdGlu,gChiFdcFucFe,           & 
& gChiFecFeFv,gChiFucFuGlu,epsI,deltaM,.False.,gTChi,gPChi(:,84:442),BRChi(:,84:442))

End If 
Do i1=1,4
gTChi(i1) =Sum(gPChi(i1,:)) 
If (gTChi(i1).Gt.0._dp) BRChi(i1,: ) =gPChi(i1,:)/gTChi(i1) 
End Do 
 

If (.Not.CTBD) Then 
If ((Enable3BDecaysF).and.(Calc3BodyDecay_Cha)) Then 
If (MaxVal(gTCha).Lt.MaxVal(fac3*Abs(MCha))) Then 
Call ChaThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTAh,gThh,gTHpm,gTSd,gTSe,gTSu,           & 
& gTSv,gTVWm,gTVZ,gChaChacChaCha,gChaChaChiChi,gChaChacFdFd,gChaChacFeFe,gChaChacFuFu,   & 
& gChaChaFvFv,gChaChicFuFd,gChaChiFvFe,gChaFdcFdFe,gChaFdcFuGlu,gChaFecFeFe,             & 
& gChaFvcFuFd,gChaFvFvFe,gChacFuFuFe,epsI,deltaM,.False.,gTCha,gPCha(:,80:407)           & 
& ,BRCha(:,80:407))

Else 
Call ChaThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTAh,gThh,gTHpm,gTSd,gTSe,gTSu,           & 
& gTSv,gTVWm,gTVZ,gChaChacChaCha,gChaChaChiChi,gChaChacFdFd,gChaChacFeFe,gChaChacFuFu,   & 
& gChaChaFvFv,gChaChicFuFd,gChaChiFvFe,gChaFdcFdFe,gChaFdcFuGlu,gChaFecFeFe,             & 
& gChaFvcFuFd,gChaFvFvFe,gChacFuFuFe,epsI,deltaM,.True.,gTCha,gPCha(:,80:407)            & 
& ,BRCha(:,80:407))

End If 
 
End If 
Else 
Call ChaThreeBodyDecay(-1,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gTAh,gThh,gTHpm,gTSd,gTSe,gTSu,           & 
& gTSv,gTVWm,gTVZ,gChaChacChaCha,gChaChaChiChi,gChaChacFdFd,gChaChacFeFe,gChaChacFuFu,   & 
& gChaChaFvFv,gChaChicFuFd,gChaChiFvFe,gChaFdcFdFe,gChaFdcFuGlu,gChaFecFeFe,             & 
& gChaFvcFuFd,gChaFvFvFe,gChacFuFuFe,epsI,deltaM,.False.,gTCha,gPCha(:,80:407)           & 
& ,BRCha(:,80:407))

End If 
Do i1=1,2
gTCha(i1) =Sum(gPCha(i1,:)) 
If (gTCha(i1).Gt.0._dp) BRCha(i1,: ) =gPCha(i1,:)/gTCha(i1) 
End Do 
 

! No 3-body decays for Fu  
Iname = Iname - 1 
 
End Subroutine CalculateBR 
End Module BranchingRatios_MSSMTriLnV 
 