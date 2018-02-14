! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.12.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 13:05 on 7.2.2018   
! ----------------------------------------------------------------------  
 
 
Module Sv3Decays_MSSMTriLnV 
 
Use Control 
Use Settings 
Use CouplingsForDecays_MSSMTriLnV 
Use ThreeBodyPhaseSpaceS 
 
Contains 
 
Subroutine SvThreeBodyDecay(n_in,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,             & 
& MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,           & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSvChiChacSe,gSvSvChiChi,       & 
& gSvChiChicSv,gSvcSdChiFd,gSvcHpmChiFe,gSvcSeChiFe,gSvChiHpmcFe,gSvSdChicFd,            & 
& gSvSeChicCha,gSvSeChicFe,gSvFdAhcFd,gSvcSdFdFv,gSvcSdFdGlu,gSvhhFdcFd,gSvSvFdcFd,      & 
& gSvFdcChacSu,gSvFdcFdcSv,gSvFdcFecSu,gSvcHpmFdcFu,gSvcSeFdcFu,gSvFeAhcCha,             & 
& gSvcSdFeFu,gSvcSeFeFv,gSvhhFecCha,gSvFeSucFd,gSvSvFecFe,gSvFeAhcFe,gSvcHpmFeFv,        & 
& gSvhhFecFe,gSvFecChacSv,gSvFecFecSv,gSvFvAhChi,gSvcHpmChaFv,gSvhhChiFv,gSvFvFucSu,     & 
& gSvSvFvFv,gSvFvFvcSv,gSvcChaFvHpm,gSvSdFvcFd,gSvSeFvcFe,gSvFvSucFu,gSvSdGlucFd,        & 
& gSvSdcChacFu,gSvSdcFecFu,gSvSeFucFd,gSvSeFvcCha,gSvSvChacCha,gSvSvFucFu,               & 
& gSvcChaFeSv,gSvcFdChaSu,gSvcFdFuHpm,gSvcFeChaSv,gSvcFeFvHpm,gSvcSdChaFu,               & 
& gSvcSeChaFv,epsI,deltaM,CheckRealStates,gT,gPartial,BR)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp),Intent(in) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

Complex(dp) :: cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),  & 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),       & 
& cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),   & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),   & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),       & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),         & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),               & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),             & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),             & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),         & 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),             & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),   & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),       & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplhhSvcSv(2,3,3), & 
& cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),           & 
& cplSvcSvVZ(3,3)

Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2,vd,vu

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(inout) :: gSvChiChacSe(3,4,2,6),gSvSvChiChi(3,3,4,4),gSvChiChicSv(3,4,4,3),gSvcSdChiFd(3,6,4,3),& 
& gSvcHpmChiFe(3,2,4,3),gSvcSeChiFe(3,6,4,3),gSvChiHpmcFe(3,4,2,3),gSvSdChicFd(3,6,4,3), & 
& gSvSeChicCha(3,6,4,2),gSvSeChicFe(3,6,4,3),gSvFdAhcFd(3,3,2,3),gSvcSdFdFv(3,6,3,3),    & 
& gSvcSdFdGlu(3,6,3,1),gSvhhFdcFd(3,2,3,3),gSvSvFdcFd(3,3,3,3),gSvFdcChacSu(3,3,2,6),    & 
& gSvFdcFdcSv(3,3,3,3),gSvFdcFecSu(3,3,3,6),gSvcHpmFdcFu(3,2,3,3),gSvcSeFdcFu(3,6,3,3),  & 
& gSvFeAhcCha(3,3,2,2),gSvcSdFeFu(3,6,3,3),gSvcSeFeFv(3,6,3,3),gSvhhFecCha(3,2,3,2),     & 
& gSvFeSucFd(3,3,6,3),gSvSvFecFe(3,3,3,3),gSvFeAhcFe(3,3,2,3),gSvcHpmFeFv(3,2,3,3),      & 
& gSvhhFecFe(3,2,3,3),gSvFecChacSv(3,3,2,3),gSvFecFecSv(3,3,3,3),gSvFvAhChi(3,3,2,4),    & 
& gSvcHpmChaFv(3,2,2,3),gSvhhChiFv(3,2,4,3),gSvFvFucSu(3,3,3,6),gSvSvFvFv(3,3,3,3),      & 
& gSvFvFvcSv(3,3,3,3),gSvcChaFvHpm(3,2,3,2),gSvSdFvcFd(3,6,3,3),gSvSeFvcFe(3,6,3,3),     & 
& gSvFvSucFu(3,3,6,3),gSvSdGlucFd(3,6,1,3),gSvSdcChacFu(3,6,2,3),gSvSdcFecFu(3,6,3,3),   & 
& gSvSeFucFd(3,6,3,3),gSvSeFvcCha(3,6,3,2),gSvSvChacCha(3,3,2,2),gSvSvFucFu(3,3,3,3),    & 
& gSvcChaFeSv(3,2,3,3),gSvcFdChaSu(3,3,2,6),gSvcFdFuHpm(3,3,3,2),gSvcFeChaSv(3,3,2,3),   & 
& gSvcFeFvHpm(3,3,3,2),gSvcSdChaFu(3,6,2,3),gSvcSeChaFv(3,6,2,3)

Real(dp) :: gSvChiChacSei(4,2,6),gSvSvChiChii(3,4,4),gSvChiChicSvi(4,4,3),gSvcSdChiFdi(6,4,3),    & 
& gSvcHpmChiFei(2,4,3),gSvcSeChiFei(6,4,3),gSvChiHpmcFei(4,2,3),gSvSdChicFdi(6,4,3),     & 
& gSvSeChicChai(6,4,2),gSvSeChicFei(6,4,3),gSvFdAhcFdi(3,2,3),gSvcSdFdFvi(6,3,3),        & 
& gSvcSdFdGlui(6,3,1),gSvhhFdcFdi(2,3,3),gSvSvFdcFdi(3,3,3),gSvFdcChacSui(3,2,6),        & 
& gSvFdcFdcSvi(3,3,3),gSvFdcFecSui(3,3,6),gSvcHpmFdcFui(2,3,3),gSvcSeFdcFui(6,3,3),      & 
& gSvFeAhcChai(3,2,2),gSvcSdFeFui(6,3,3),gSvcSeFeFvi(6,3,3),gSvhhFecChai(2,3,2),         & 
& gSvFeSucFdi(3,6,3),gSvSvFecFei(3,3,3),gSvFeAhcFei(3,2,3),gSvcHpmFeFvi(2,3,3),          & 
& gSvhhFecFei(2,3,3),gSvFecChacSvi(3,2,3),gSvFecFecSvi(3,3,3),gSvFvAhChii(3,2,4),        & 
& gSvcHpmChaFvi(2,2,3),gSvhhChiFvi(2,4,3),gSvFvFucSui(3,3,6),gSvSvFvFvi(3,3,3),          & 
& gSvFvFvcSvi(3,3,3),gSvcChaFvHpmi(2,3,2),gSvSdFvcFdi(6,3,3),gSvSeFvcFei(6,3,3),         & 
& gSvFvSucFui(3,6,3),gSvSdGlucFdi(6,1,3),gSvSdcChacFui(6,2,3),gSvSdcFecFui(6,3,3),       & 
& gSvSeFucFdi(6,3,3),gSvSeFvcChai(6,3,2),gSvSvChacChai(3,2,2),gSvSvFucFui(3,3,3),        & 
& gSvcChaFeSvi(2,3,3),gSvcFdChaSui(3,2,6),gSvcFdFuHpmi(3,3,2),gSvcFeChaSvi(3,2,3),       & 
& gSvcFeFvHpmi(3,3,2),gSvcSdChaFui(6,2,3),gSvcSeChaFvi(6,2,3)

Real(dp), Intent(inout), Optional :: BR(:,:), gPartial(:,:) 
Real(dp), Intent(inout) :: gT(:) 
Integer, Intent(in) :: n_in 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Intent(in) ::  CheckRealStates 
Integer :: i_start, i_end, i_run, n_out, n_length, gt1, gt2, gt3, i1 
Logical :: check 
Iname = Iname +1 
NameOfUnit(Iname) = 'SvThreeBodyDecay' 
 

 
If (CheckRealStates) Then 
Else 
End If 
 
check=CheckRealStates 

 
If (n_in.Lt.0) Then 
 i_start = 1 
 i_end = 3 
 Else If ( (n_in.Ge.1).And.(n_in.Le. 3) ) Then 
 i_start = n_in 
 i_end = n_in 
Else 
 If (ErrorLevel.Ge.-1) Then 
   Write (ErrCan, *) 'Problem in subroutine'//NameOfUnit(Iname) 
   Write (ErrCan, *) 'Value of n_in out of range, (n_in,3) = ',n_in,3 
 End If 
 
 If (ErrorLevel.Gt.0) Call TerminateProgram 
 
 If (Present(BR)) BR = 0._dp 
 Iname = Iname - 1 
 Return 
End If 
 
Do i_run = i_start, i_end 
 
Call CouplingsFor_Sv_decays_3B(MSv(i_run),i_run,MAh,MAh2,MCha,MCha2,MChi,             & 
& MChi2,MFd,MFd2,MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,              & 
& MSe,MSe2,MSu,MSu2,MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,            & 
& ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,             & 
& Yu,Mu,Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,   & 
& cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,             & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,     & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFdFdAhL,cplcFdFdAhR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplChaFucSdL,cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChiAhL,cplChiChiAhR,     & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplChiFvSvL,cplChiFvSvR,cplFeFucSdL,cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,             & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFvVZL,cplFvFvVZR,cplGluFdcSdL,cplGluFdcSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,   & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,deltaM)


 
gSvChiChacSei = 0._dp 
Call SvToChiChacSe(i_run,MChi,MCha,MSe,MSv,cplChiFvcSvL,cplChiFvcSvR,cplFvChacSeL,    & 
& cplFvChacSeR,deltaM,epsI,check,gSvChiChacSei)

gSvChiChacSe(i_run,:,:,:) = gSvChiChacSei 
gT(i_run) = gT(i_run) + Sum(gSvChiChacSei) 
 
gSvSvChiChii = 0._dp 
Call SvToSvChiChi(i_run,MSv,MChi,MVZ,Mhh,cplhhSvcSv,cplSvcSvVZ,cplChiChihhL,          & 
& cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,          & 
& cplChiFvSvR,deltaM,epsI,check,gSvSvChiChii)

gSvSvChiChi(i_run,:,:,:) = gSvSvChiChii 
gT(i_run) = gT(i_run) + Sum(gSvSvChiChii) 
 
gSvChiChicSvi = 0._dp 
Call SvToChiChicSv(i_run,MChi,MSv,cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,              & 
& check,gSvChiChicSvi)

gSvChiChicSv(i_run,:,:,:) = gSvChiChicSvi 
gT(i_run) = gT(i_run) + Sum(gSvChiChicSvi) 
 
gSvcSdChiFdi = 0._dp 
Call SvTocSdChiFd(i_run,MSd,MChi,MFd,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,           & 
& deltaM,epsI,check,gSvcSdChiFdi)

gSvcSdChiFd(i_run,:,:,:) = gSvcSdChiFdi 
gT(i_run) = gT(i_run) + Sum(gSvcSdChiFdi) 
 
gSvcHpmChiFei = 0._dp 
Call SvTocHpmChiFe(i_run,MHpm,MChi,MFe,MSe,MCha,MSv,cplSecHpmcSv,cplcChaFecSvL,       & 
& cplcChaFecSvR,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,    & 
& cplChiFvcSvR,cplFvFecHpmL,cplFvFecHpmR,deltaM,epsI,check,gSvcHpmChiFei)

gSvcHpmChiFe(i_run,:,:,:) = gSvcHpmChiFei 
gT(i_run) = gT(i_run) + Sum(gSvcHpmChiFei) 
 
gSvcSeChiFei = 0._dp 
Call SvTocSeChiFe(i_run,MSe,MChi,MFe,MSv,cplSecSecSv,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFecSeL,cplFvFecSeR,           & 
& deltaM,epsI,check,gSvcSeChiFei)

gSvcSeChiFe(i_run,:,:,:) = gSvcSeChiFei 
gT(i_run) = gT(i_run) + Sum(gSvcSeChiFei) 
 
gSvChiHpmcFei = 0._dp 
Call SvToChiHpmcFe(i_run,MChi,MHpm,MFe,MSv,cplcFeFvHpmL,cplcFeFvHpmR,cplChiFvcSvL,    & 
& cplChiFvcSvR,deltaM,epsI,check,gSvChiHpmcFei)

gSvChiHpmcFe(i_run,:,:,:) = gSvChiHpmcFei 
gT(i_run) = gT(i_run) + Sum(gSvChiHpmcFei) 
 
gSvSdChicFdi = 0._dp 
Call SvToSdChicFd(i_run,MSd,MChi,MFd,MSv,cplSdcSdcSv,cplcFdChiSdL,cplcFdChiSdR,       & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFvSdL,cplcFdFvSdR,cplChiFvcSvL,cplChiFvcSvR,           & 
& deltaM,epsI,check,gSvSdChicFdi)

gSvSdChicFd(i_run,:,:,:) = gSvSdChicFdi 
gT(i_run) = gT(i_run) + Sum(gSvSdChicFdi) 
 
gSvSeChicChai = 0._dp 
Call SvToSeChicCha(i_run,MSe,MChi,MCha,MVWm,MHpm,MFe,MSv,cplSecHpmcSv,cplSecSvcVWm,   & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcFeChiSeL,cplcFeChiSeR,cplChiFvcSvL,        & 
& cplChiFvcSvR,deltaM,epsI,check,gSvSeChicChai)

gSvSeChicCha(i_run,:,:,:) = gSvSeChicChai 
gT(i_run) = gT(i_run) + Sum(gSvSeChicChai) 
 
gSvSeChicFei = 0._dp 
Call SvToSeChicFe(i_run,MSe,MChi,MFe,MSv,cplSecSecSv,cplcFeChiSeL,cplcFeChiSeR,       & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvSeL,cplcFeFvSeR,cplChiFvcSvL,cplChiFvcSvR,           & 
& deltaM,epsI,check,gSvSeChicFei)

gSvSeChicFe(i_run,:,:,:) = gSvSeChicFei 
gT(i_run) = gT(i_run) + Sum(gSvSeChicFei) 
 
gSvFdAhcFdi = 0._dp 
Call SvToFdAhcFd(i_run,MFd,MAh,MSv,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,              & 
& cplcFdFdcSvR,deltaM,epsI,check,gSvFdAhcFdi)

gSvFdAhcFd(i_run,:,:,:) = gSvFdAhcFdi 
gT(i_run) = gT(i_run) + Sum(gSvFdAhcFdi) 
 
gSvcSdFdFvi = 0._dp 
Call SvTocSdFdFv(i_run,MSd,MFd,MChi,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,        & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,           & 
& deltaM,epsI,check,gSvcSdFdFvi)

gSvcSdFdFv(i_run,:,:,:) = gSvcSdFdFvi 
gT(i_run) = gT(i_run) + Sum(gSvcSdFdFvi) 
 
gSvcSdFdGlui = 0._dp 
Call SvTocSdFdGlu(i_run,MSd,MFd,MGlu,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplGluFdcSdL,cplGluFdcSdR,deltaM,epsI,check,gSvcSdFdGlui)

gSvcSdFdGlu(i_run,:,:,:) = gSvcSdFdGlui 
gT(i_run) = gT(i_run) + Sum(gSvcSdFdGlui) 
 
gSvhhFdcFdi = 0._dp 
Call SvTohhFdcFd(i_run,Mhh,MFd,MSv,cplhhSvcSv,cplcFdFdcSvL,cplcFdFdcSvR,              & 
& cplcFdFdhhL,cplcFdFdhhR,deltaM,epsI,check,gSvhhFdcFdi)

gSvhhFdcFd(i_run,:,:,:) = gSvhhFdcFdi 
gT(i_run) = gT(i_run) + Sum(gSvhhFdcFdi) 
 
gSvSvFdcFdi = 0._dp 
Call SvToSvFdcFd(i_run,MSv,MFd,MVZ,Mhh,cplhhSvcSv,cplSvcSvVZ,cplcFdFdcSvL,            & 
& cplcFdFdcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,              & 
& cplcFdFdVZR,deltaM,epsI,check,gSvSvFdcFdi)

gSvSvFdcFd(i_run,:,:,:) = gSvSvFdcFdi 
gT(i_run) = gT(i_run) + Sum(gSvSvFdcFdi) 
 
gSvFdcChacSui = 0._dp 
Call SvToFdcChacSu(i_run,MFd,MCha,MSu,MFe,MSv,cplcChaFdcSuL,cplcChaFdcSuR,            & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& deltaM,epsI,check,gSvFdcChacSui)

gSvFdcChacSu(i_run,:,:,:) = gSvFdcChacSui 
gT(i_run) = gT(i_run) + Sum(gSvFdcChacSui) 
 
gSvFdcFdcSvi = 0._dp 
Call SvToFdcFdcSv(i_run,MFd,MSv,cplcFdFdcSvL,cplcFdFdcSvR,deltaM,epsI,check,          & 
& gSvFdcFdcSvi)

gSvFdcFdcSv(i_run,:,:,:) = gSvFdcFdcSvi 
gT(i_run) = gT(i_run) + Sum(gSvFdcFdcSvi) 
 
gSvFdcFecSui = 0._dp 
Call SvToFdcFecSu(i_run,MFd,MFe,MSu,MSv,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,gSvFdcFecSui)

gSvFdcFecSu(i_run,:,:,:) = gSvFdcFecSui 
gT(i_run) = gT(i_run) + Sum(gSvFdcFecSui) 
 
gSvcHpmFdcFui = 0._dp 
Call SvTocHpmFdcFu(i_run,MHpm,MFd,MFu,MSe,MSv,cplSecHpmcSv,cplcFdFdcSvL,              & 
& cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,deltaM,             & 
& epsI,check,gSvcHpmFdcFui)

gSvcHpmFdcFu(i_run,:,:,:) = gSvcHpmFdcFui 
gT(i_run) = gT(i_run) + Sum(gSvcHpmFdcFui) 
 
gSvcSeFdcFui = 0._dp 
Call SvTocSeFdcFu(i_run,MSe,MFd,MFu,MSv,cplSecSecSv,cplcFdFdcSvL,cplcFdFdcSvR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,gSvcSeFdcFui)

gSvcSeFdcFu(i_run,:,:,:) = gSvcSeFdcFui 
gT(i_run) = gT(i_run) + Sum(gSvcSeFdcFui) 
 
gSvFeAhcChai = 0._dp 
Call SvToFeAhcCha(i_run,MFe,MAh,MCha,MSv,cplcChaChaAhL,cplcChaChaAhR,cplcChaFecSvL,   & 
& cplcChaFecSvR,cplcFeFeAhL,cplcFeFeAhR,deltaM,epsI,check,gSvFeAhcChai)

gSvFeAhcCha(i_run,:,:,:) = gSvFeAhcChai 
gT(i_run) = gT(i_run) + Sum(gSvFeAhcChai) 
 
gSvcSdFeFui = 0._dp 
Call SvTocSdFeFu(i_run,MSd,MFe,MFu,MCha,MSv,cplSdcSdcSv,cplcChaFecSvL,cplcChaFecSvR,  & 
& cplcFeFecSvL,cplcFeFecSvR,cplChaFucSdL,cplChaFucSdR,cplFeFucSdL,cplFeFucSdR,           & 
& deltaM,epsI,check,gSvcSdFeFui)

gSvcSdFeFu(i_run,:,:,:) = gSvcSdFeFui 
gT(i_run) = gT(i_run) + Sum(gSvcSdFeFui) 
 
gSvcSeFeFvi = 0._dp 
Call SvTocSeFeFv(i_run,MSe,MFe,MCha,MChi,MSv,cplSecSecSv,cplcChaFecSvL,               & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,        & 
& cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,            & 
& check,gSvcSeFeFvi)

gSvcSeFeFv(i_run,:,:,:) = gSvcSeFeFvi 
gT(i_run) = gT(i_run) + Sum(gSvcSeFeFvi) 
 
gSvhhFecChai = 0._dp 
Call SvTohhFecCha(i_run,Mhh,MFe,MCha,MSv,cplhhSvcSv,cplcChaChahhL,cplcChaChahhR,      & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFehhL,cplcFeFehhR,deltaM,epsI,check,gSvhhFecChai)

gSvhhFecCha(i_run,:,:,:) = gSvhhFecChai 
gT(i_run) = gT(i_run) + Sum(gSvhhFecChai) 
 
gSvFeSucFdi = 0._dp 
Call SvToFeSucFd(i_run,MFe,MSu,MFd,MCha,MSv,cplcChaFecSvL,cplcChaFecSvR,              & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFeSuL,cplcFdFeSuR,           & 
& cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,gSvFeSucFdi)

gSvFeSucFd(i_run,:,:,:) = gSvFeSucFdi 
gT(i_run) = gT(i_run) + Sum(gSvFeSucFdi) 
 
gSvSvFecFei = 0._dp 
Call SvToSvFecFe(i_run,MSv,MFe,MVZ,Mhh,MCha,cplhhSvcSv,cplSvcSvVZ,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeChaSvL,cplcFeChaSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,         & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,deltaM,epsI,               & 
& check,gSvSvFecFei)

gSvSvFecFe(i_run,:,:,:) = gSvSvFecFei 
gT(i_run) = gT(i_run) + Sum(gSvSvFecFei) 
 
gSvFeAhcFei = 0._dp 
Call SvToFeAhcFe(i_run,MFe,MAh,MSv,cplcFeFeAhL,cplcFeFeAhR,cplcFeFecSvL,              & 
& cplcFeFecSvR,deltaM,epsI,check,gSvFeAhcFei)

gSvFeAhcFe(i_run,:,:,:) = gSvFeAhcFei 
gT(i_run) = gT(i_run) + Sum(gSvFeAhcFei) 
 
gSvcHpmFeFvi = 0._dp 
Call SvTocHpmFeFv(i_run,MHpm,MFe,MSe,MSv,cplSecHpmcSv,cplcFeFecSvL,cplcFeFecSvR,      & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSvcHpmFeFvi)

gSvcHpmFeFv(i_run,:,:,:) = gSvcHpmFeFvi 
gT(i_run) = gT(i_run) + Sum(gSvcHpmFeFvi) 
 
gSvhhFecFei = 0._dp 
Call SvTohhFecFe(i_run,Mhh,MFe,MSv,cplhhSvcSv,cplcFeFecSvL,cplcFeFecSvR,              & 
& cplcFeFehhL,cplcFeFehhR,deltaM,epsI,check,gSvhhFecFei)

gSvhhFecFe(i_run,:,:,:) = gSvhhFecFei 
gT(i_run) = gT(i_run) + Sum(gSvhhFecFei) 
 
gSvFecChacSvi = 0._dp 
Call SvToFecChacSv(i_run,MFe,MCha,MSv,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,       & 
& cplcFeFecSvR,deltaM,epsI,check,gSvFecChacSvi)

gSvFecChacSv(i_run,:,:,:) = gSvFecChacSvi 
gT(i_run) = gT(i_run) + Sum(gSvFecChacSvi) 
 
gSvFecFecSvi = 0._dp 
Call SvToFecFecSv(i_run,MFe,MSv,cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,          & 
& gSvFecFecSvi)

gSvFecFecSv(i_run,:,:,:) = gSvFecFecSvi 
gT(i_run) = gT(i_run) + Sum(gSvFecFecSvi) 
 
gSvFvAhChii = 0._dp 
Call SvToFvAhChi(i_run,MAh,MChi,MSv,cplChiChiAhL,cplChiChiAhR,cplChiFvcSvL,           & 
& cplChiFvcSvR,deltaM,epsI,check,gSvFvAhChii)

gSvFvAhChi(i_run,:,:,:) = gSvFvAhChii 
gT(i_run) = gT(i_run) + Sum(gSvFvAhChii) 
 
gSvcHpmChaFvi = 0._dp 
Call SvTocHpmChaFv(i_run,MHpm,MCha,MSe,MChi,MSv,cplSecHpmcSv,cplChiChacHpmL,          & 
& cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,deltaM,             & 
& epsI,check,gSvcHpmChaFvi)

gSvcHpmChaFv(i_run,:,:,:) = gSvcHpmChaFvi 
gT(i_run) = gT(i_run) + Sum(gSvcHpmChaFvi) 
 
gSvhhChiFvi = 0._dp 
Call SvTohhChiFv(i_run,Mhh,MChi,MSv,cplhhSvcSv,cplChiChihhL,cplChiChihhR,             & 
& cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,check,gSvhhChiFvi)

gSvhhChiFv(i_run,:,:,:) = gSvhhChiFvi 
gT(i_run) = gT(i_run) + Sum(gSvhhChiFvi) 
 
gSvFvFucSui = 0._dp 
Call SvToFvFucSu(i_run,MFu,MSu,MChi,MSv,cplChiFucSuL,cplChiFucSuR,cplChiFvcSvL,       & 
& cplChiFvcSvR,deltaM,epsI,check,gSvFvFucSui)

gSvFvFucSu(i_run,:,:,:) = gSvFvFucSui 
gT(i_run) = gT(i_run) + Sum(gSvFvFucSui) 
 
gSvSvFvFvi = 0._dp 
Call SvToSvFvFv(i_run,MSv,MVZ,MChi,cplSvcSvVZ,cplChiFvcSvL,cplChiFvcSvR,              & 
& cplChiFvSvL,cplChiFvSvR,cplFvFvVZL,cplFvFvVZR,deltaM,epsI,check,gSvSvFvFvi)

gSvSvFvFv(i_run,:,:,:) = gSvSvFvFvi 
gT(i_run) = gT(i_run) + Sum(gSvSvFvFvi) 
 
gSvFvFvcSvi = 0._dp 
Call SvToFvFvcSv(i_run,MSv,MChi,cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,check,          & 
& gSvFvFvcSvi)

gSvFvFvcSv(i_run,:,:,:) = gSvFvFvcSvi 
gT(i_run) = gT(i_run) + Sum(gSvFvFvcSvi) 
 
gSvcChaFvHpmi = 0._dp 
Call SvTocChaFvHpm(i_run,MCha,MHpm,MFe,MChi,MSv,cplcChaChiHpmL,cplcChaChiHpmR,        & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplChiFvcSvL,cplChiFvcSvR,       & 
& deltaM,epsI,check,gSvcChaFvHpmi)

gSvcChaFvHpm(i_run,:,:,:) = gSvcChaFvHpmi 
gT(i_run) = gT(i_run) + Sum(gSvcChaFvHpmi) 
 
gSvSdFvcFdi = 0._dp 
Call SvToSdFvcFd(i_run,MSd,MFd,MChi,MSv,cplSdcSdcSv,cplcFdChiSdL,cplcFdChiSdR,        & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFvSdL,cplcFdFvSdR,cplChiFvcSvL,cplChiFvcSvR,           & 
& deltaM,epsI,check,gSvSdFvcFdi)

gSvSdFvcFd(i_run,:,:,:) = gSvSdFvcFdi 
gT(i_run) = gT(i_run) + Sum(gSvSdFvcFdi) 
 
gSvSeFvcFei = 0._dp 
Call SvToSeFvcFe(i_run,MSe,MFe,MVWm,MHpm,MChi,MSv,cplSecHpmcSv,cplSecSecSv,           & 
& cplSecSvcVWm,cplcFeChiSeL,cplcFeChiSeR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,         & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplChiFvcSvL,           & 
& cplChiFvcSvR,deltaM,epsI,check,gSvSeFvcFei)

gSvSeFvcFe(i_run,:,:,:) = gSvSeFvcFei 
gT(i_run) = gT(i_run) + Sum(gSvSeFvcFei) 
 
gSvFvSucFui = 0._dp 
Call SvToFvSucFu(i_run,MSu,MFu,MChi,MSv,cplcFuChiSuL,cplcFuChiSuR,cplChiFvcSvL,       & 
& cplChiFvcSvR,deltaM,epsI,check,gSvFvSucFui)

gSvFvSucFu(i_run,:,:,:) = gSvFvSucFui 
gT(i_run) = gT(i_run) + Sum(gSvFvSucFui) 
 
gSvSdGlucFdi = 0._dp 
Call SvToSdGlucFd(i_run,MSd,MGlu,MFd,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcFdGluSdL,cplcFdGluSdR,deltaM,epsI,check,gSvSdGlucFdi)

gSvSdGlucFd(i_run,:,:,:) = gSvSdGlucFdi 
gT(i_run) = gT(i_run) + Sum(gSvSdGlucFdi) 
 
gSvSdcChacFui = 0._dp 
Call SvToSdcChacFu(i_run,MSd,MCha,MFu,MFe,MSv,cplSdcSdcSv,cplcChacFuSdL,              & 
& cplcChacFuSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFecFuSdL,cplcFecFuSdR,deltaM,            & 
& epsI,check,gSvSdcChacFui)

gSvSdcChacFu(i_run,:,:,:) = gSvSdcChacFui 
gT(i_run) = gT(i_run) + Sum(gSvSdcChacFui) 
 
gSvSdcFecFui = 0._dp 
Call SvToSdcFecFu(i_run,MSd,MFe,MFu,MSv,cplSdcSdcSv,cplcFecFuSdL,cplcFecFuSdR,        & 
& cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,gSvSdcFecFui)

gSvSdcFecFu(i_run,:,:,:) = gSvSdcFecFui 
gT(i_run) = gT(i_run) + Sum(gSvSdcFecFui) 
 
gSvSeFucFdi = 0._dp 
Call SvToSeFucFd(i_run,MSe,MFu,MFd,MVWm,MHpm,MSv,cplSecHpmcSv,cplSecSecSv,            & 
& cplSecSvcVWm,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,          & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,deltaM,epsI,check,gSvSeFucFdi)

gSvSeFucFd(i_run,:,:,:) = gSvSeFucFdi 
gT(i_run) = gT(i_run) + Sum(gSvSeFucFdi) 
 
gSvSeFvcChai = 0._dp 
Call SvToSeFvcCha(i_run,MSe,MCha,MFe,MSv,cplSecSecSv,cplcChaFecSvL,cplcChaFecSvR,     & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,deltaM,epsI,check,gSvSeFvcChai)

gSvSeFvcCha(i_run,:,:,:) = gSvSeFvcChai 
gT(i_run) = gT(i_run) + Sum(gSvSeFvcChai) 
 
gSvSvChacChai = 0._dp 
Call SvToSvChacCha(i_run,MSv,MCha,MVZ,Mhh,MFe,cplhhSvcSv,cplSvcSvVZ,cplcChaChahhL,    & 
& cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeChaSvL,    & 
& cplcFeChaSvR,deltaM,epsI,check,gSvSvChacChai)

gSvSvChacCha(i_run,:,:,:) = gSvSvChacChai 
gT(i_run) = gT(i_run) + Sum(gSvSvChacChai) 
 
gSvSvFucFui = 0._dp 
Call SvToSvFucFu(i_run,MSv,MFu,MVZ,Mhh,cplhhSvcSv,cplSvcSvVZ,cplcFuFuhhL,             & 
& cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,deltaM,epsI,check,gSvSvFucFui)

gSvSvFucFu(i_run,:,:,:) = gSvSvFucFui 
gT(i_run) = gT(i_run) + Sum(gSvSvFucFui) 
 
gSvcChaFeSvi = 0._dp 
Call SvTocChaFeSv(i_run,MCha,MFe,MSv,cplcChaFecSvL,cplcChaFecSvR,cplcFeFeSvL,         & 
& cplcFeFeSvR,deltaM,epsI,check,gSvcChaFeSvi)

gSvcChaFeSv(i_run,:,:,:) = gSvcChaFeSvi 
gT(i_run) = gT(i_run) + Sum(gSvcChaFeSvi) 
 
gSvcFdChaSui = 0._dp 
Call SvTocFdChaSu(i_run,MFd,MCha,MSu,MSv,cplcFdChaSuL,cplcFdChaSuR,cplcFdFdcSvL,      & 
& cplcFdFdcSvR,deltaM,epsI,check,gSvcFdChaSui)

gSvcFdChaSu(i_run,:,:,:) = gSvcFdChaSui 
gT(i_run) = gT(i_run) + Sum(gSvcFdChaSui) 
 
gSvcFdFuHpmi = 0._dp 
Call SvTocFdFuHpm(i_run,MFd,MFu,MHpm,MSv,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFuHpmL,      & 
& cplcFdFuHpmR,deltaM,epsI,check,gSvcFdFuHpmi)

gSvcFdFuHpm(i_run,:,:,:) = gSvcFdFuHpmi 
gT(i_run) = gT(i_run) + Sum(gSvcFdFuHpmi) 
 
gSvcFeChaSvi = 0._dp 
Call SvTocFeChaSv(i_run,MFe,MCha,MSv,cplcFeChaSvL,cplcFeChaSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,deltaM,epsI,check,gSvcFeChaSvi)

gSvcFeChaSv(i_run,:,:,:) = gSvcFeChaSvi 
gT(i_run) = gT(i_run) + Sum(gSvcFeChaSvi) 
 
gSvcFeFvHpmi = 0._dp 
Call SvTocFeFvHpm(i_run,MFe,MHpm,MSv,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,          & 
& cplcFeFvHpmR,deltaM,epsI,check,gSvcFeFvHpmi)

gSvcFeFvHpm(i_run,:,:,:) = gSvcFeFvHpmi 
gT(i_run) = gT(i_run) + Sum(gSvcFeFvHpmi) 
 
gSvcSdChaFui = 0._dp 
Call SvTocSdChaFu(i_run,MSd,MCha,MFu,MSv,cplSdcSdcSv,cplChaFucSdL,cplChaFucSdR,       & 
& deltaM,epsI,check,gSvcSdChaFui)

gSvcSdChaFu(i_run,:,:,:) = gSvcSdChaFui 
gT(i_run) = gT(i_run) + Sum(gSvcSdChaFui) 
 
gSvcSeChaFvi = 0._dp 
Call SvTocSeChaFv(i_run,MSe,MCha,MSv,cplSecSecSv,cplFvChacSeL,cplFvChacSeR,           & 
& deltaM,epsI,check,gSvcSeChaFvi)

gSvcSeChaFv(i_run,:,:,:) = gSvcSeChaFvi 
gT(i_run) = gT(i_run) + Sum(gSvcSeChaFvi) 
 
End Do 
 

If (Present(gPartial)) Then
Do i1 = i_start, i_end 
 
n_length=1
Do gt1=1,4
  Do gt2=1,2
    Do gt3=1,6
gPartial(i1,n_length)= gSvChiChacSe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=gt2,4
gPartial(i1,n_length)= gSvSvChiChi(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,4
  Do gt2=gt1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvChiChicSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSdChiFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvcHpmChiFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSeChiFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,4
  Do gt2=2,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvChiHpmcFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvSdChicFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,2
gPartial(i1,n_length)= gSvSeChicCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvSeChicFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=2,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvFdAhcFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSdFdFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,1
gPartial(i1,n_length)= gSvcSdFdGlu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvhhFdcFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSvFdcFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
gPartial(i1,n_length)= gSvFdcChacSu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvFdcFdcSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
gPartial(i1,n_length)= gSvFdcFecSu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcHpmFdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSeFdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=2,2
    Do gt3=1,2
gPartial(i1,n_length)= gSvFeAhcCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSdFeFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSeFeFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,2
gPartial(i1,n_length)= gSvhhFecCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,3
gPartial(i1,n_length)= gSvFeSucFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSvFecFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=2,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvFeAhcFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcHpmFeFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvhhFecFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvFecChacSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvFecFecSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=2,2
    Do gt3=1,4
gPartial(i1,n_length)= gSvFvAhChi(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvcHpmChaFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSvhhChiFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
gPartial(i1,n_length)= gSvFvFucSu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=gt2,3
gPartial(i1,n_length)= gSvSvFvFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=gt1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvFvFvcSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSvcChaFvHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSdFvcFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSeFvcFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,3
gPartial(i1,n_length)= gSvFvSucFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,1
    Do gt3=1,3
gPartial(i1,n_length)= gSvSdGlucFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvSdcChacFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSdcFecFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSeFucFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
gPartial(i1,n_length)= gSvSeFvcCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
gPartial(i1,n_length)= gSvSvChacCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvSvFucFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSvcChaFeSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
gPartial(i1,n_length)= gSvcFdChaSu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSvcFdFuHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvcFeChaSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSvcFeFvHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSdChaFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSvcSeChaFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
If (Present(BR).And.(gT(i1).Gt.0._dp)) Then 
BR(i1,:)=gPartial(i1,:)/gT(i1)
Else If (Present(BR)) Then
BR(i1,:)=0._dp
End If
 
End Do 
End if 
Iname = Iname - 1 
 
End Subroutine SvThreeBodyDecay
 
 
Subroutine SvToChiChacSe(iIN,MChi,MCha,MSe,MSv,cplChiFvcSvL,cplChiFvcSvR,             & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MChi(4),MCha(2),MSe(6),MSv(3)

Complex(dp),Intent(in) :: cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(4,2,6, Isum) ) 
Allocate( Contribution(4,2,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,4
      Do gt2=1,2
        Do gt3=1,6
Isum = 0 
 
rk2 = (MChi(gt1)/MSv(iIN))**2 
rm2 = (MCha(gt2)/MSv(iIN))**2 
rj2 = (MSe(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSe(gt3))+Abs(MCha(gt2))+Abs(MChi(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplFvChacSeL(i1,gt2,gt3)) 
coup(3) = Conjg(cplFvChacSeR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Chi Cha cSe Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt1,i1,iIN) 
coup(2) = cplChiFvcSvR(gt1,i1,iIN) 
coup(3) = cplFvChacSeL(i1,gt2,gt3) 
coup(4) = cplFvChacSeR(i1,gt2,gt3) 
coup(5) = cplChiFvcSvL(gt1,i2,iIN) 
coup(6) = cplChiFvcSvR(gt1,i2,iIN)  
coup(7) = cplFvChacSeL(i2,gt2,gt3) 
coup(8) = cplFvChacSeR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Chi Cha cSe Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,4
      Do gt2=1,2
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToChiChacSe 
 
 
Subroutine SvToSvChiChi(iIN,MSv,MChi,MVZ,Mhh,cplhhSvcSv,cplSvcSvVZ,cplChiChihhL,      & 
& cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,          & 
& cplChiFvSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MChi(4),MVZ,Mhh(2)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplSvcSvVZ(3,3),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),            & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),           & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(3,4,4, Isum) ) 
Allocate( Contribution(3,4,4, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,4
        Do gt3=gt2,4
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MChi(gt3)/MSv(iIN))**2 
rj2 = (MSv(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MChi(gt3))+Abs(MChi(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplChiChiVZL(gt2,gt3)) 
coup(2) = Conjg(cplChiChiVZR(gt2,gt3))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplChiChiVZL(gt3,gt2)) 
coup(2) = Conjg(cplChiChiVZR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiChihhL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiChihhR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiChihhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChihhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = Mhh(i1)  
mass(2) = Mhh(i1)  
coup(1) = cplhhSvcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChihhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChihhR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(i1,gt1,iIN) 
coup(6) = Conjg(cplChiChihhL(gt2,gt3,i1)) 
coup(5) = Conjg(cplChiChihhR(gt2,gt3,i1))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='hh'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplChiFvSvL(gt3,i1,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplChiFvSvL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt3,i1,iIN) 
coup(2) = cplChiFvcSvR(gt3,i1,iIN) 
coup(3) = cplChiFvSvL(gt2,i1,gt1) 
coup(4) = cplChiFvSvR(gt2,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i1,iIN) 
coup(6) = cplChiFvcSvR(gt2,i1,iIN)  
coup(7) = cplChiFvSvL(gt3,i1,gt1) 
coup(8) = cplChiFvSvR(gt3,i1,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSvcSvVZ(gt1,iIN) 
coup(2) = Conjg(cplChiChiVZL(gt2,gt3)) 
coup(3) = Conjg(cplChiChiVZR(gt2,gt3))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(5) = Conjg(cplChiChihhL(gt2,gt3,i2)) 
coup(6) = Conjg(cplChiChihhR(gt2,gt3,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: VZ,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,hh'
      End Do 



!-------------- 
!  VZ, Fv 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = 0._dp  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt3,i2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplChiChiVZL(gt2,gt3)) 
coup(6) = Conjg(cplChiChiVZR(gt2,gt3))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(2) = MVZ2  
mass(1) = 0._dp  
coup(1) = cplChiFvcSvL(gt3,i2,iIN) 
coup(2) = cplChiFvcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt2,i2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplChiChiVZL(gt2,gt3)) 
coup(6) = Conjg(cplChiChiVZR(gt2,gt3))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: VZ,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Fv'
      End Do 



!-------------- 
!  hh, hh 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = Mhh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplhhSvcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChihhL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiChihhR(gt2,gt3,i1))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplChiChihhL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiChihhR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: hh,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,hh'
        End Do 
      End Do 



!-------------- 
!  hh, Fv 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiChihhL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiChihhR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(2) = Mhh(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt3,i2,iIN) 
coup(2) = cplChiFvcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt2,i2,gt1))  
coup(5) = cplhhSvcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiChihhL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiChihhR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: hh,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplChiFvSvL(gt3,i1,gt1) 
coup(4) = cplChiFvSvR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplChiFvSvL(gt3,i2,gt1) 
coup(8) = cplChiFvSvR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt3,i1,iIN) 
coup(2) = cplChiFvcSvR(gt3,i1,iIN) 
coup(3) = cplChiFvSvL(gt2,i1,gt1) 
coup(4) = cplChiFvSvR(gt2,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplChiFvSvL(gt3,i2,gt1) 
coup(8) = cplChiFvSvR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt3,i1,iIN) 
coup(2) = cplChiFvcSvR(gt3,i1,iIN) 
coup(3) = cplChiFvSvL(gt2,i1,gt1) 
coup(4) = cplChiFvSvR(gt2,i1,gt1) 
coup(5) = cplChiFvcSvL(gt3,i2,iIN) 
coup(6) = cplChiFvcSvR(gt3,i2,iIN)  
coup(7) = cplChiFvSvL(gt2,i2,gt1) 
coup(8) = cplChiFvSvR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplChiFvSvL(gt3,i1,gt1) 
coup(4) = cplChiFvSvR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(gt3,i2,iIN) 
coup(6) = cplChiFvcSvR(gt3,i2,iIN)  
coup(7) = cplChiFvSvL(gt2,i2,gt1) 
coup(8) = cplChiFvSvR(gt2,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Chi Chi Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1, iIN-1
      Do gt2=1,4
        Do gt3=gt2,4
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSvChiChi 
 
 
Subroutine SvToChiChicSv(iIN,MChi,MSv,cplChiFvcSvL,cplChiFvcSvR,deltaM,               & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(4,4,3, Isum) ) 
Allocate( Contribution(4,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,4
      Do gt2=gt1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt1)/MSv(iIN))**2 
rm2 = (MChi(gt2)/MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(MChi(gt2))+Abs(MChi(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(gt2,i1,gt3)) 
coup(3) = Conjg(cplChiFvcSvR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(gt1,i1,gt3)) 
coup(3) = Conjg(cplChiFvcSvR(gt1,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplChiFvcSvL(gt1,i1,gt3) 
coup(4) = cplChiFvcSvR(gt1,i1,gt3) 
coup(5) = cplChiFvcSvL(gt1,i1,iIN) 
coup(6) = cplChiFvcSvR(gt1,i1,iIN)  
coup(7) = cplChiFvcSvL(gt2,i1,gt3) 
coup(8) = cplChiFvcSvR(gt2,i1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Chi Chi cSv Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt1,i1,iIN) 
coup(2) = cplChiFvcSvR(gt1,i1,iIN) 
coup(3) = cplChiFvcSvL(gt2,i1,gt3) 
coup(4) = cplChiFvcSvR(gt2,i1,gt3) 
coup(5) = cplChiFvcSvL(gt1,i2,iIN) 
coup(6) = cplChiFvcSvR(gt1,i2,iIN)  
coup(7) = cplChiFvcSvL(gt2,i2,gt3) 
coup(8) = cplChiFvcSvR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplChiFvcSvL(gt1,i1,gt3) 
coup(4) = cplChiFvcSvR(gt1,i1,gt3) 
coup(5) = cplChiFvcSvL(gt1,i2,iIN) 
coup(6) = cplChiFvcSvR(gt1,i2,iIN)  
coup(7) = cplChiFvcSvL(gt2,i2,gt3) 
coup(8) = cplChiFvcSvR(gt2,i2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplChiFvcSvL(gt1,i1,gt3) 
coup(4) = cplChiFvcSvR(gt1,i1,gt3) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplChiFvcSvL(gt1,i2,gt3) 
coup(8) = cplChiFvcSvR(gt1,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt1,i1,iIN) 
coup(2) = cplChiFvcSvR(gt1,i1,iIN) 
coup(3) = cplChiFvcSvL(gt2,i1,gt3) 
coup(4) = cplChiFvcSvR(gt2,i1,gt3) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplChiFvcSvL(gt1,i2,gt3) 
coup(8) = cplChiFvcSvR(gt1,i2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Chi Chi cSv Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,4
      Do gt2=gt1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToChiChicSv 
 
 
Subroutine SvTocSdChiFd(iIN,MSd,MChi,MFd,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MChi(4),MFd(3),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplChiFdcSdL(4,3,6),       & 
& cplChiFdcSdR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 144 
Allocate( gSum(6,4,3, Isum) ) 
Allocate( Contribution(6,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MChi(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFdcSdR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFdcSdL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiFdcSdR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplFvFdcSdL(i1,gt3,gt1)) 
coup(3) = Conjg(cplFvFdcSdR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  Sd, Sd 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFdcSdR(gt2,gt3,i1))  
coup(4) = cplSdcSdcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplChiFdcSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFdcSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: Sd,Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Sd'
        End Do 
      End Do 



!-------------- 
!  Sd, bar[Fd] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt3,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFdcSdL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFdcSdR(gt2,i2,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFdcSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: Sd,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  Sd, Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplFvFdcSdL(i2,gt3,gt1)) 
coup(3) = Conjg(cplFvFdcSdR(i2,gt3,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFdcSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: Sd,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Fv'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt3,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt3,iIN) 
coup(3) = cplChiFdcSdL(gt2,i1,gt1) 
coup(4) = cplChiFdcSdR(gt2,i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt3,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt3,iIN)  
coup(7) = cplChiFdcSdL(gt2,i2,gt1) 
coup(8) = cplChiFdcSdR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = 0.  
coup(1) = cplcFdFdcSvL(i1,gt3,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt3,iIN) 
coup(3) = cplChiFdcSdL(gt2,i1,gt1) 
coup(4) = cplChiFdcSdR(gt2,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt3,gt1) 
coup(8) = cplFvFdcSdR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: bar[Fd],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplFvFdcSdL(i1,gt3,gt1) 
coup(4) = cplFvFdcSdR(i1,gt3,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt3,gt1) 
coup(8) = cplFvFdcSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Chi Fd Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:144))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSdChiFd 
 
 
Subroutine SvTocHpmChiFe(iIN,MHpm,MChi,MFe,MSe,MCha,MSv,cplSecHpmcSv,cplcChaFecSvL,   & 
& cplcChaFecSvR,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,    & 
& cplChiFvcSvR,cplFvFecHpmL,cplFvFecHpmR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MChi(4),MFe(3),MSe(6),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplChiChacHpmL(4,2,2),  & 
& cplChiChacHpmR(4,2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),     & 
& cplChiFvcSvR(4,3,3),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 121 
Allocate( gSum(2,4,3, Isum) ) 
Allocate( Contribution(2,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MHpm(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiChacHpmL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiChacHpmR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplFvFecHpmL(i1,gt3,gt1)) 
coup(3) = Conjg(cplFvFecHpmR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecHpmcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
coup(4) = cplSecHpmcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplChiFecSeL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFecSeR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Cha] 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MCha(i2)  
coup(1) = cplcChaFecSvL(i2,gt3,iIN) 
coup(2) = cplcChaFecSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiChacHpmL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiChacHpmR(gt2,i2,gt1))  
coup(5) = cplSecHpmcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: Se,bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  Se, Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplFvFecHpmL(i2,gt3,gt1)) 
coup(3) = Conjg(cplFvFecHpmR(i2,gt3,gt1))  
coup(5) = cplSecHpmcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: Se,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fv'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt3,iIN) 
coup(2) = cplcChaFecSvR(i1,gt3,iIN) 
coup(3) = cplChiChacHpmL(gt2,i1,gt1) 
coup(4) = cplChiChacHpmR(gt2,i1,gt1) 
coup(5) = cplcChaFecSvL(i2,gt3,iIN) 
coup(6) = cplcChaFecSvR(i2,gt3,iIN)  
coup(7) = cplChiChacHpmL(gt2,i2,gt1) 
coup(8) = cplChiChacHpmR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], Fv 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = 0.  
coup(1) = cplcChaFecSvL(i1,gt3,iIN) 
coup(2) = cplcChaFecSvR(i1,gt3,iIN) 
coup(3) = cplChiChacHpmL(gt2,i1,gt1) 
coup(4) = cplChiChacHpmR(gt2,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplFvFecHpmL(i2,gt3,gt1) 
coup(8) = cplFvFecHpmR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: bar[Cha],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplFvFecHpmL(i1,gt3,gt1) 
coup(4) = cplFvFecHpmR(i1,gt3,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplFvFecHpmL(i2,gt3,gt1) 
coup(8) = cplFvFecHpmR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Chi Fe Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=2,2
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:121))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocHpmChiFe 
 
 
Subroutine SvTocSeChiFe(iIN,MSe,MChi,MFe,MSv,cplSecSecSv,cplcFeFecSvL,cplcFeFecSvR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFecSeL,cplFvFecSeR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MChi(4),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplChiFecSeL(4,3,6),       & 
& cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFecSeL(3,3,6),        & 
& cplFvFecSeR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 144 
Allocate( gSum(6,4,3, Isum) ) 
Allocate( Contribution(6,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFecSeL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiFecSeR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplFvFecSeL(i1,gt3,gt1)) 
coup(3) = Conjg(cplFvFecSeR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(i1,gt1,iIN) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
coup(4) = cplSecSecSv(i2,gt1,iIN) 
coup(6) = Conjg(cplChiFecSeL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFecSeR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Fe] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(i2,gt3,iIN) 
coup(2) = cplcFeFecSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFecSeL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFecSeR(gt2,i2,gt1))  
coup(5) = cplSecSecSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: Se,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  Se, Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplFvFecSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplFvFecSeR(i2,gt3,gt1))  
coup(5) = cplSecSecSv(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: Se,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fv'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt3,iIN) 
coup(2) = cplcFeFecSvR(i1,gt3,iIN) 
coup(3) = cplChiFecSeL(gt2,i1,gt1) 
coup(4) = cplChiFecSeR(gt2,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt3,iIN) 
coup(6) = cplcFeFecSvR(i2,gt3,iIN)  
coup(7) = cplChiFecSeL(gt2,i2,gt1) 
coup(8) = cplChiFecSeR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = 0.  
coup(1) = cplcFeFecSvL(i1,gt3,iIN) 
coup(2) = cplcFeFecSvR(i1,gt3,iIN) 
coup(3) = cplChiFecSeL(gt2,i1,gt1) 
coup(4) = cplChiFecSeR(gt2,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplFvFecSeL(i2,gt3,gt1) 
coup(8) = cplFvFecSeR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: bar[Fe],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplFvFecSeL(i1,gt3,gt1) 
coup(4) = cplFvFecSeR(i1,gt3,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplFvFecSeL(i2,gt3,gt1) 
coup(8) = cplFvFecSeR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Chi Fe Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:144))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSeChiFe 
 
 
Subroutine SvToChiHpmcFe(iIN,MChi,MHpm,MFe,MSv,cplcFeFvHpmL,cplcFeFvHpmR,             & 
& cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MChi(4),MHpm(2),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(4,2,3, Isum) ) 
Allocate( Contribution(4,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,4
      Do gt2=2,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt1)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MHpm(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MHpm(gt2))+Abs(MChi(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcFeFvHpmR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Chi Hpm cFe Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt1,i1,iIN) 
coup(2) = cplChiFvcSvR(gt1,i1,iIN) 
coup(3) = cplcFeFvHpmL(gt3,i1,gt2) 
coup(4) = cplcFeFvHpmR(gt3,i1,gt2) 
coup(5) = cplChiFvcSvL(gt1,i2,iIN) 
coup(6) = cplChiFvcSvR(gt1,i2,iIN)  
coup(7) = cplcFeFvHpmL(gt3,i2,gt2) 
coup(8) = cplcFeFvHpmR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Chi Hpm cFe Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,4
      Do gt2=2,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToChiHpmcFe 
 
 
Subroutine SvToSdChicFd(iIN,MSd,MChi,MFd,MSv,cplSdcSdcSv,cplcFdChiSdL,cplcFdChiSdR,   & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFvSdL,cplcFdFvSdR,cplChiFvcSvL,cplChiFvcSvR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MChi(4),MFd(3),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFdcSvL(3,3,3),       & 
& cplcFdFdcSvR(3,3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 144 
Allocate( gSum(6,4,3, Isum) ) 
Allocate( Contribution(6,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MChi(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Sd] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFdChiSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdChiSdR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd]'
      End Do 



!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdChiSdL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdChiSdR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFdFvSdL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFdFvSdR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  conj[Sd], conj[Sd] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdChiSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdChiSdR(gt3,gt2,i1))  
coup(4) = cplSdcSdcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdChiSdL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdChiSdR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: conj[Sd],conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],conj[Sd]'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdChiSdL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdChiSdR(i2,gt2,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdChiSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdChiSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: conj[Sd],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],Fd'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFdFvSdL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFvSdR(gt3,i2,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdChiSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdChiSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: conj[Sd],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],Fv'
        End Do 
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdChiSdL(i1,gt2,gt1) 
coup(4) = cplcFdChiSdR(i1,gt2,gt1) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdChiSdL(i2,gt2,gt1) 
coup(8) = cplcFdChiSdR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



!-------------- 
!  Fd, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = 0.  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdChiSdL(i1,gt2,gt1) 
coup(4) = cplcFdChiSdR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplcFdFvSdL(gt3,i2,gt1) 
coup(8) = cplcFdFvSdR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: Fd,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplcFdFvSdL(gt3,i1,gt1) 
coup(4) = cplcFdFvSdR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplcFdFvSdL(gt3,i2,gt1) 
coup(8) = cplcFdFvSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Chi cFd Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:144))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSdChicFd 
 
 
Subroutine SvToSeChicCha(iIN,MSe,MChi,MCha,MVWm,MHpm,MFe,MSv,cplSecHpmcSv,            & 
& cplSecSvcVWm,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,              & 
& cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcFeChiSeL,cplcFeChiSeR,       & 
& cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MChi(4),MCha(2),MVWm,MHpm(2),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplSecSvcVWm(6,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),    & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),     & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,4,2, Isum) ) 
Allocate( Contribution(6,4,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,2
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MCha(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MCha(gt3))+Abs(MChi(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  conj[VWm] 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVWm 
mass(2) = MVWm 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSvcVWm(gt1,iIN)) 
coup(3) = Conjg(cplcChaChiVWmL(gt3,gt2)) 
coup(2) = Conjg(cplcChaChiVWmR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[VWm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm]'



!-------------- 
!  conj[Hpm] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MHpm(i1) 
mass(2) = MHpm(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcChaChiHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChiHpmR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeChiSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  conj[VWm], conj[Hpm] 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MHpm(i2)  
coup(1) = cplSecSvcVWm(gt1,iIN) 
coup(2) = Conjg(cplcChaChiVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcChaChiVWmR(gt3,gt2))  
coup(4) = cplSecHpmcSv(gt1,i2,iIN) 
coup(5) = Conjg(cplcChaChiHpmL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcChaChiHpmR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[VWm],conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],conj[Hpm]'
      End Do 



!-------------- 
!  conj[VWm], Fe 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MFe2(i2)  
coup(1) = cplcChaFecSvL(gt3,i2,iIN) 
coup(2) = cplcChaFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplSecSvcVWm(gt1,iIN) 
coup(7) = Conjg(cplcChaChiVWmL(gt3,gt2)) 
coup(6) = Conjg(cplcChaChiVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[VWm],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],Fe'
      End Do 



!-------------- 
!  conj[VWm], Fv 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = 0._dp  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i2,gt1))  
coup(5) = cplSecSvcVWm(gt1,iIN) 
coup(7) = Conjg(cplcChaChiVWmL(gt3,gt2)) 
coup(6) = Conjg(cplcChaChiVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[VWm],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],Fv'
      End Do 



!-------------- 
!  conj[Hpm], conj[Hpm] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MHpm(i2)  
coup(1) = cplSecHpmcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcChaChiHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChiHpmR(gt3,gt2,i1))  
coup(4) = cplSecHpmcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcChaChiHpmL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaChiHpmR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[Hpm],conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],conj[Hpm]'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i2,iIN) 
coup(2) = cplcChaFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplSecHpmcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaChiHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaChiHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[Hpm],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],Fe'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], Fv 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i2,gt1))  
coup(5) = cplSecHpmcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaChiHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaChiHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: conj[Hpm],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],Fv'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i1,iIN) 
coup(2) = cplcChaFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt2,gt1) 
coup(8) = cplcFeChiSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = 0.  
coup(1) = cplcChaFecSvL(gt3,i1,iIN) 
coup(2) = cplcChaFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplcChaFvSeL(gt3,i2,gt1) 
coup(8) = cplcChaFvSeR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: Fe,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplcChaFvSeL(gt3,i1,gt1) 
coup(4) = cplcChaFvSeR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplcChaFvSeL(gt3,i2,gt1) 
coup(8) = cplcChaFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cCha Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSeChicCha 
 
 
Subroutine SvToSeChicFe(iIN,MSe,MChi,MFe,MSv,cplSecSecSv,cplcFeChiSeL,cplcFeChiSeR,   & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvSeL,cplcFeFvSeR,cplChiFvcSvL,cplChiFvcSvR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MChi(4),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFecSvL(3,3,3),       & 
& cplcFeFecSvR(3,3,3),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 144 
Allocate( gSum(6,4,3, Isum) ) 
Allocate( Contribution(6,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  conj[Se] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFeChiSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeChiSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeChiSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv'
      End Do 



!-------------- 
!  conj[Se], conj[Se] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeChiSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeChiSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeChiSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeChiSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: conj[Se],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],conj[Se]'
        End Do 
      End Do 



!-------------- 
!  conj[Se], Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt3,i2,iIN) 
coup(2) = cplcFeFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeChiSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeChiSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: conj[Se],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],Fe'
        End Do 
      End Do 



!-------------- 
!  conj[Se], Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = 0.  
coup(1) = cplChiFvcSvL(gt2,i2,iIN) 
coup(2) = cplChiFvcSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeChiSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeChiSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: conj[Se],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],Fv'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt3,i1,iIN) 
coup(2) = cplcFeFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplcFeFecSvL(gt3,i2,iIN) 
coup(6) = cplcFeFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt2,gt1) 
coup(8) = cplcFeChiSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = 0.  
coup(1) = cplcFeFecSvL(gt3,i1,iIN) 
coup(2) = cplcFeFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(gt3,i2,gt1) 
coup(8) = cplcFeFvSeR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: Fe,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fv'
        End Do 
      End Do 



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplChiFvcSvL(gt2,i1,iIN) 
coup(2) = cplChiFvcSvR(gt2,i1,iIN) 
coup(3) = cplcFeFvSeL(gt3,i1,gt1) 
coup(4) = cplcFeFvSeR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(gt2,i2,iIN) 
coup(6) = cplChiFvcSvR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(gt3,i2,gt1) 
coup(8) = cplcFeFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Chi cFe Propagator: Fv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Fv'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:144))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSeChicFe 
 
 
Subroutine SvToFdAhcFd(iIN,MFd,MAh,MSv,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MAh(2),MSv(3)

Complex(dp),Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,2,3, Isum) ) 
Allocate( Contribution(3,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt1)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MAh(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MAh(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFdFdAhL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcFdFdAhR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd Ah cFd Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt1,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt1,iIN) 
coup(3) = cplcFdFdAhL(gt3,i1,gt2) 
coup(4) = cplcFdFdAhR(gt3,i1,gt2) 
coup(5) = cplcFdFdcSvL(i2,gt1,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt1,iIN)  
coup(7) = cplcFdFdAhL(gt3,i2,gt2) 
coup(8) = cplcFdFdAhR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd Ah cFd Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFdAhcFd 
 
 
Subroutine SvTocSdFdFv(iIN,MSd,MFd,MChi,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,    & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFd(3),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplChiFdcSdL(4,3,6),       & 
& cplChiFdcSdR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 169 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(MFd(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFdcSdR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFdcSdL(gt3,i1,gt1)) 
coup(3) = Conjg(cplFvFdcSdR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFdcSdL(i1,gt2,gt1)) 
coup(3) = Conjg(cplChiFdcSdR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Sd, Sd 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFdcSdR(gt3,gt2,i1))  
coup(4) = cplSdcSdcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplFvFdcSdL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFdcSdR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: Sd,Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Sd'
        End Do 
      End Do 



!-------------- 
!  Sd, bar[Fd] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplFvFdcSdL(gt3,i2,gt1)) 
coup(3) = Conjg(cplFvFdcSdR(gt3,i2,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFdcSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: Sd,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  Sd, Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt3,iIN) 
coup(2) = cplChiFvcSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFdcSdL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiFdcSdR(i2,gt2,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFdcSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: Sd,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Chi'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplFvFdcSdL(gt3,i1,gt1) 
coup(4) = cplFvFdcSdR(gt3,i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt2,iIN)  
coup(7) = cplFvFdcSdL(gt3,i2,gt1) 
coup(8) = cplFvFdcSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplFvFdcSdL(gt3,i1,gt1) 
coup(4) = cplFvFdcSdR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFdcSdL(i2,gt2,gt1) 
coup(8) = cplChiFdcSdR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: bar[Fd],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiFdcSdL(i1,gt2,gt1) 
coup(4) = cplChiFdcSdR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFdcSdL(i2,gt2,gt1) 
coup(8) = cplChiFdcSdR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Fv Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:169))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSdFdFv 
 
 
Subroutine SvTocSdFdGlu(iIN,MSd,MFd,MGlu,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplGluFdcSdL,cplGluFdcSdR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFd(3),MGlu,MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplGluFdcSdL(3,6),         & 
& cplGluFdcSdR(3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,3,1, Isum) ) 
Allocate( Contribution(6,3,1, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSv(iIN))**2 
rm2 = (MGlu/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MGlu)+Abs(MFd(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplGluFdcSdL(gt2,i1)) 
coup(2) = Conjg(cplGluFdcSdR(gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Glu Propagator: Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp
Else 
gSum(gt1,gt2,1,Isum)=resD
End If 
Contribution(gt1,gt2,1,Isum)='Sd'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplGluFdcSdL(i1,gt1)) 
coup(3) = Conjg(cplGluFdcSdR(i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Glu Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp
Else 
gSum(gt1,gt2,1,Isum)=resD
End If 
Contribution(gt1,gt2,1,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Sd, Sd 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplGluFdcSdL(gt2,i1)) 
coup(2) = Conjg(cplGluFdcSdR(gt2,i1))  
coup(4) = cplSdcSdcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplGluFdcSdL(gt2,i2)) 
coup(5) = Conjg(cplGluFdcSdR(gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Glu Propagator: Sd,Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp  
Else 
gSum(gt1,gt2,1,Isum)= resS  
End If 
Contribution(gt1,gt2,1,Isum)='Sd,Sd'
        End Do 
      End Do 



!-------------- 
!  Sd, bar[Fd] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplGluFdcSdL(i2,gt1)) 
coup(3) = Conjg(cplGluFdcSdR(i2,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplGluFdcSdL(gt2,i1)) 
coup(6) = Conjg(cplGluFdcSdR(gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Glu Propagator: Sd,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp  
Else 
gSum(gt1,gt2,1,Isum)= resS  
End If 
Contribution(gt1,gt2,1,Isum)='Sd,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplGluFdcSdL(i1,gt1) 
coup(4) = cplGluFdcSdR(i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt2,iIN)  
coup(7) = cplGluFdcSdL(i2,gt1) 
coup(8) = cplGluFdcSdR(i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fd Glu Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp  
Else 
gSum(gt1,gt2,1,Isum)= resS  
End If 
Contribution(gt1,gt2,1,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,1,:)= 0._dp  
End If 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
g(gt1,gt2,1)=Sum(gSum(gt1,gt2,1,1:81))
If (g(gt1,gt2,1).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,1)=0._dp
End If
     End Do 
   End Do 
End Subroutine SvTocSdFdGlu 
 
 
Subroutine SvTohhFdcFd(iIN,Mhh,MFd,MSv,cplhhSvcSv,cplcFdFdcSvL,cplcFdFdcSvR,          & 
& cplcFdFdhhL,cplcFdFdhhR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MFd(3),MSv(3)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),         & 
& cplcFdFdhhR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (Mhh(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MFd(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fd cFd Propagator: Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFdFdhhL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFdFdhhR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fd cFd Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplhhSvcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFdcSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdcSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fd cFd Propagator: Sv,Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Sv'
        End Do 
      End Do 



!-------------- 
!  Sv, bar[Fd] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFdhhL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFdhhR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fd cFd Propagator: Sv,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplcFdFdhhL(gt3,i1,gt1) 
coup(4) = cplcFdFdhhR(gt3,i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt2,iIN)  
coup(7) = cplcFdFdhhL(gt3,i2,gt1) 
coup(8) = cplcFdFdhhR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fd cFd Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTohhFdcFd 
 
 
Subroutine SvToSvFdcFd(iIN,MSv,MFd,MVZ,Mhh,cplhhSvcSv,cplSvcSvVZ,cplcFdFdcSvL,        & 
& cplcFdFdcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,              & 
& cplcFdFdVZR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFd(3),MVZ,Mhh(2)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplSvcSvVZ(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSv(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MFd(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(2) = Conjg(cplcFdFdVZR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFdFdhhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdhhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='hh'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFdFdSvL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSvcSvVZ(gt1,iIN) 
coup(2) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFdVZR(gt3,gt2))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(5) = Conjg(cplcFdFdhhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFdFdhhR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: VZ,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,hh'
      End Do 



!-------------- 
!  VZ, bar[Fd] 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MFd2(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFdSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(gt3,i2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFdFdVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 3*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: VZ,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,bar[Fd]'
      End Do 



!-------------- 
!  hh, hh 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = Mhh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplhhSvcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplcFdFdhhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdhhR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: hh,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,hh'
        End Do 
      End Do 



!-------------- 
!  hh, bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFdSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplcFdFdhhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdhhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: hh,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplcFdFdSvL(gt3,i1,gt1) 
coup(4) = cplcFdFdSvR(gt3,i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt2,iIN)  
coup(7) = cplcFdFdSvL(gt3,i2,gt1) 
coup(8) = cplcFdFdSvR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fd cFd Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSvFdcFd 
 
 
Subroutine SvToFdcChacSu(iIN,MFd,MCha,MSu,MFe,MSv,cplcChaFdcSuL,cplcChaFdcSuR,        & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MCha(2),MSu(6),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),  & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(3,2,6, Isum) ) 
Allocate( Contribution(3,2,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,6
Isum = 0 
 
rk2 = (MFd(gt1)/MSv(iIN))**2 
rm2 = (MCha(gt2)/MSv(iIN))**2 
rj2 = (MSu(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSu(gt3))+Abs(MCha(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcChaFdcSuL(gt2,i1,gt3)) 
coup(3) = Conjg(cplcChaFdcSuR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cCha cSu Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFdcSuL(i1,gt1,gt3)) 
coup(3) = Conjg(cplcFeFdcSuR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cCha cSu Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt1,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt1,iIN) 
coup(3) = cplcChaFdcSuL(gt2,i1,gt3) 
coup(4) = cplcChaFdcSuR(gt2,i1,gt3) 
coup(5) = cplcFdFdcSvL(i2,gt1,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt1,iIN)  
coup(7) = cplcChaFdcSuL(gt2,i2,gt3) 
coup(8) = cplcChaFdcSuR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cCha cSu Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFdFdcSvL(i1,gt1,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt1,iIN) 
coup(3) = cplcChaFdcSuL(gt2,i1,gt3) 
coup(4) = cplcChaFdcSuR(gt2,i1,gt3) 
coup(5) = cplcChaFecSvL(gt2,i2,iIN) 
coup(6) = cplcChaFecSvR(gt2,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt1,gt3) 
coup(8) = cplcFeFdcSuR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cCha cSu Propagator: bar[Fd],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt2,i1,iIN) 
coup(2) = cplcChaFecSvR(gt2,i1,iIN) 
coup(3) = cplcFeFdcSuL(i1,gt1,gt3) 
coup(4) = cplcFeFdcSuR(i1,gt1,gt3) 
coup(5) = cplcChaFecSvL(gt2,i2,iIN) 
coup(6) = cplcChaFecSvR(gt2,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt1,gt3) 
coup(8) = cplcFeFdcSuR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cCha cSu Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFdcChacSu 
 
 
Subroutine SvToFdcFdcSv(iIN,MFd,MSv,cplcFdFdcSvL,cplcFdFdcSvR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MSv(3)

Complex(dp),Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt1)/MSv(iIN))**2 
rm2 = (MFd(gt2)/MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(MFd(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFdFdcSvL(gt2,i1,gt3)) 
coup(3) = Conjg(cplcFdFdcSvR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFd cSv Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt1,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt1,iIN) 
coup(3) = cplcFdFdcSvL(gt2,i1,gt3) 
coup(4) = cplcFdFdcSvR(gt2,i1,gt3) 
coup(5) = cplcFdFdcSvL(i2,gt1,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt1,iIN)  
coup(7) = cplcFdFdcSvL(gt2,i2,gt3) 
coup(8) = cplcFdFdcSvR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFd cSv Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFdcFdcSv 
 
 
Subroutine SvToFdcFecSu(iIN,MFd,MFe,MSu,MSv,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,   & 
& cplcFeFdcSuR,cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MFe(3),MSu(6),MSv(3)

Complex(dp),Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),      & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(3,3,6, Isum) ) 
Allocate( Contribution(3,3,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
Isum = 0 
 
rk2 = (MFd(gt1)/MSv(iIN))**2 
rm2 = (MFe(gt2)/MSv(iIN))**2 
rj2 = (MSu(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSu(gt3))+Abs(MFe(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFeFdcSuL(gt2,i1,gt3)) 
coup(3) = Conjg(cplcFeFdcSuR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFe cSu Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFdcSuL(i1,gt1,gt3)) 
coup(3) = Conjg(cplcFeFdcSuR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFe cSu Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt1,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt1,iIN) 
coup(3) = cplcFeFdcSuL(gt2,i1,gt3) 
coup(4) = cplcFeFdcSuR(gt2,i1,gt3) 
coup(5) = cplcFdFdcSvL(i2,gt1,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt1,iIN)  
coup(7) = cplcFeFdcSuL(gt2,i2,gt3) 
coup(8) = cplcFeFdcSuR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFe cSu Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFdFdcSvL(i1,gt1,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt1,iIN) 
coup(3) = cplcFeFdcSuL(gt2,i1,gt3) 
coup(4) = cplcFeFdcSuR(gt2,i1,gt3) 
coup(5) = cplcFeFecSvL(gt2,i2,iIN) 
coup(6) = cplcFeFecSvR(gt2,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt1,gt3) 
coup(8) = cplcFeFdcSuR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFe cSu Propagator: bar[Fd],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt2,i1,iIN) 
coup(2) = cplcFeFecSvR(gt2,i1,iIN) 
coup(3) = cplcFeFdcSuL(i1,gt1,gt3) 
coup(4) = cplcFeFdcSuR(i1,gt1,gt3) 
coup(5) = cplcFeFecSvL(gt2,i2,iIN) 
coup(6) = cplcFeFecSvR(gt2,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt1,gt3) 
coup(8) = cplcFeFdcSuR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fd cFe cSu Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFdcFecSu 
 
 
Subroutine SvTocHpmFdcFu(iIN,MHpm,MFd,MFu,MSe,MSv,cplSecHpmcSv,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,deltaM,             & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MFd(3),MFu(3),MSe(6),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),     & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MHpm(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MFd(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fd cFu Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFuFdcHpmL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFuFdcHpmR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fd cFu Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecHpmcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
coup(4) = cplSecHpmcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fd cFu Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Fd] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFuFdcHpmL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFuFdcHpmR(gt3,i2,gt1))  
coup(5) = cplSecHpmcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fd cFu Propagator: Se,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplcFuFdcHpmL(gt3,i1,gt1) 
coup(4) = cplcFuFdcHpmR(gt3,i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt2,iIN)  
coup(7) = cplcFuFdcHpmL(gt3,i2,gt1) 
coup(8) = cplcFuFdcHpmR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fd cFu Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocHpmFdcFu 
 
 
Subroutine SvTocSeFdcFu(iIN,MSe,MFd,MFu,MSv,cplSecSecSv,cplcFdFdcSvL,cplcFdFdcSvR,    & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFd(3),MFu(3),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MFd(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fd cFu Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  bar[Fd] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFuFdcSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFuFdcSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fd cFu Propagator: bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd]'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fd cFu Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Fd] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFuFdcSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFuFdcSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(i1,gt1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fd cFu Propagator: Se,bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fd]'
        End Do 
      End Do 



!-------------- 
!  bar[Fd], bar[Fd] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(i1,gt2,iIN) 
coup(2) = cplcFdFdcSvR(i1,gt2,iIN) 
coup(3) = cplcFuFdcSeL(gt3,i1,gt1) 
coup(4) = cplcFuFdcSeR(gt3,i1,gt1) 
coup(5) = cplcFdFdcSvL(i2,gt2,iIN) 
coup(6) = cplcFdFdcSvR(i2,gt2,iIN)  
coup(7) = cplcFuFdcSeL(gt3,i2,gt1) 
coup(8) = cplcFuFdcSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fd cFu Propagator: bar[Fd],bar[Fd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fd],bar[Fd]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSeFdcFu 
 
 
Subroutine SvToFeAhcCha(iIN,MFe,MAh,MCha,MSv,cplcChaChaAhL,cplcChaChaAhR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFeAhL,cplcFeFeAhR,deltaM,epsI,check,g,               & 
& WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MAh(2),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),  & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 25 
Allocate( gSum(3,2,2, Isum) ) 
Allocate( Contribution(3,2,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,2
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (MCha(gt3)/MSv(iIN))**2 
rj2 = (MAh(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MCha(gt3))+Abs(MAh(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcChaChaAhL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcChaChaAhR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cCha Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFeAhL(i1,gt1,gt2)) 
coup(3) = Conjg(cplcFeFeAhR(i1,gt1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cCha Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt1,iIN) 
coup(2) = cplcChaFecSvR(i1,gt1,iIN) 
coup(3) = cplcChaChaAhL(gt3,i1,gt2) 
coup(4) = cplcChaChaAhR(gt3,i1,gt2) 
coup(5) = cplcChaFecSvL(i2,gt1,iIN) 
coup(6) = cplcChaFecSvR(i2,gt1,iIN)  
coup(7) = cplcChaChaAhL(gt3,i2,gt2) 
coup(8) = cplcChaChaAhR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cCha Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(i1,gt1,iIN) 
coup(2) = cplcChaFecSvR(i1,gt1,iIN) 
coup(3) = cplcChaChaAhL(gt3,i1,gt2) 
coup(4) = cplcChaChaAhR(gt3,i1,gt2) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeFeAhL(i2,gt1,gt2) 
coup(8) = cplcFeFeAhR(i2,gt1,gt2) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cCha Propagator: bar[Cha],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i1,iIN) 
coup(2) = cplcChaFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeFeAhL(i1,gt1,gt2) 
coup(4) = cplcFeFeAhR(i1,gt1,gt2) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeFeAhL(i2,gt1,gt2) 
coup(8) = cplcFeFeAhR(i2,gt1,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cCha Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:25))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFeAhcCha 
 
 
Subroutine SvTocSdFeFu(iIN,MSd,MFe,MFu,MCha,MSv,cplSdcSdcSv,cplcChaFecSvL,            & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplChaFucSdL,cplChaFucSdR,cplFeFucSdL,         & 
& cplFeFucSdR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFe(3),MFu(3),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),     & 
& cplcFeFecSvR(3,3,3),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFeFucSdL(3,3,6),        & 
& cplFeFucSdR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 121 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MFe(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplFeFucSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplFeFucSdR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd'
      End Do 



!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChaFucSdL(i1,gt3,gt1)) 
coup(3) = Conjg(cplChaFucSdR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFeFucSdL(i1,gt3,gt1)) 
coup(3) = Conjg(cplFeFucSdR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Sd, Sd 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplFeFucSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplFeFucSdR(gt2,gt3,i1))  
coup(4) = cplSdcSdcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplFeFucSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplFeFucSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: Sd,Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Sd'
        End Do 
      End Do 



!-------------- 
!  Sd, bar[Cha] 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MCha(i2)  
coup(1) = cplcChaFecSvL(i2,gt2,iIN) 
coup(2) = cplcChaFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplChaFucSdL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChaFucSdR(i2,gt3,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFeFucSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplFeFucSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: Sd,bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  Sd, bar[Fe] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(i2,gt2,iIN) 
coup(2) = cplcFeFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplFeFucSdL(i2,gt3,gt1)) 
coup(3) = Conjg(cplFeFucSdR(i2,gt3,gt1))  
coup(5) = cplSdcSdcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFeFucSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplFeFucSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: Sd,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplChaFucSdL(i1,gt3,gt1) 
coup(4) = cplChaFucSdR(i1,gt3,gt1) 
coup(5) = cplcChaFecSvL(i2,gt2,iIN) 
coup(6) = cplcChaFecSvR(i2,gt2,iIN)  
coup(7) = cplChaFucSdL(i2,gt3,gt1) 
coup(8) = cplChaFucSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplChaFucSdL(i1,gt3,gt1) 
coup(4) = cplChaFucSdR(i1,gt3,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplFeFucSdL(i2,gt3,gt1) 
coup(8) = cplFeFucSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: bar[Cha],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt2,iIN) 
coup(2) = cplcFeFecSvR(i1,gt2,iIN) 
coup(3) = cplFeFucSdL(i1,gt3,gt1) 
coup(4) = cplFeFucSdR(i1,gt3,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplFeFucSdL(i2,gt3,gt1) 
coup(8) = cplFeFucSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Fe Fu Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:121))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSdFeFu 
 
 
Subroutine SvTocSeFeFv(iIN,MSe,MFe,MCha,MChi,MSv,cplSecSecSv,cplcChaFecSvL,           & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,        & 
& cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFe(3),MCha(2),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),     & 
& cplcFeFecSvR(3,3,3),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),       & 
& cplChiFvcSvR(4,3,3),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFecSeL(3,3,6),        & 
& cplFvFecSeR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 225 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(MFe(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvChacSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplFvChacSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFecSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplFvFecSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFecSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplChiFecSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(i1,gt1,iIN) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(i2,gt1,iIN) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Cha] 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MCha(i2)  
coup(1) = cplcChaFecSvL(i2,gt2,iIN) 
coup(2) = cplcChaFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplFvChacSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplFvChacSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Se,bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Fe] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(i2,gt2,iIN) 
coup(2) = cplcFeFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplFvFecSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplFvFecSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Se,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  Se, Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt3,iIN) 
coup(2) = cplChiFvcSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFecSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiFecSeR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Se,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Chi'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(gt3,i1,gt1) 
coup(4) = cplFvChacSeR(gt3,i1,gt1) 
coup(5) = cplcChaFecSvL(i2,gt2,iIN) 
coup(6) = cplcChaFecSvR(i2,gt2,iIN)  
coup(7) = cplFvChacSeL(gt3,i2,gt1) 
coup(8) = cplFvChacSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(gt3,i1,gt1) 
coup(4) = cplFvChacSeR(gt3,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplFvFecSeL(gt3,i2,gt1) 
coup(8) = cplFvFecSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Cha],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], Chi 
!-------------- 
Do i1=1,2
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(gt3,i1,gt1) 
coup(4) = cplFvChacSeR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFecSeL(i2,gt2,gt1) 
coup(8) = cplChiFecSeR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Cha],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],Chi'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt2,iIN) 
coup(2) = cplcFeFecSvR(i1,gt2,iIN) 
coup(3) = cplFvFecSeL(gt3,i1,gt1) 
coup(4) = cplFvFecSeR(gt3,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplFvFecSeL(gt3,i2,gt1) 
coup(8) = cplFvFecSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcFeFecSvL(i1,gt2,iIN) 
coup(2) = cplcFeFecSvR(i1,gt2,iIN) 
coup(3) = cplFvFecSeL(gt3,i1,gt1) 
coup(4) = cplFvFecSeR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFecSeL(i2,gt2,gt1) 
coup(8) = cplChiFecSeR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: bar[Fe],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiFecSeL(i1,gt2,gt1) 
coup(4) = cplChiFecSeR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFecSeL(i2,gt2,gt1) 
coup(8) = cplChiFecSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Fe Fv Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:225))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSeFeFv 
 
 
Subroutine SvTohhFecCha(iIN,Mhh,MFe,MCha,MSv,cplhhSvcSv,cplcChaChahhL,cplcChaChahhR,  & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFehhL,cplcFeFehhR,deltaM,epsI,check,g,               & 
& WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MFe(3),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaFecSvL(2,3,3),     & 
& cplcChaFecSvR(2,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 64 
Allocate( gSum(2,3,2, Isum) ) 
Allocate( Contribution(2,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,2
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (MCha(gt3)/MSv(iIN))**2 
rj2 = (Mhh(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MCha(gt3))+Abs(MFe(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaFecSvR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv'
      End Do 



!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcChaChahhL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcChaChahhR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFehhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFehhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplhhSvcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcChaFecSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaFecSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: Sv,Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Sv'
        End Do 
      End Do 



!-------------- 
!  Sv, bar[Cha] 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MCha(i2)  
coup(1) = cplcChaFecSvL(i2,gt2,iIN) 
coup(2) = cplcChaFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcChaChahhL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaChahhR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: Sv,bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  Sv, Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i2,iIN) 
coup(2) = cplcChaFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFehhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFehhR(i2,gt2,gt1))  
coup(5) = cplhhSvcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: Sv,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Fe'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplcChaChahhL(gt3,i1,gt1) 
coup(4) = cplcChaChahhR(gt3,i1,gt1) 
coup(5) = cplcChaFecSvL(i2,gt2,iIN) 
coup(6) = cplcChaFecSvR(i2,gt2,iIN)  
coup(7) = cplcChaChahhL(gt3,i2,gt1) 
coup(8) = cplcChaChahhR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplcChaChahhL(gt3,i1,gt1) 
coup(4) = cplcChaChahhR(gt3,i1,gt1) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeFehhL(i2,gt2,gt1) 
coup(8) = cplcFeFehhR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: bar[Cha],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i1,iIN) 
coup(2) = cplcChaFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeFehhL(i1,gt2,gt1) 
coup(4) = cplcFeFehhR(i1,gt2,gt1) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeFehhL(i2,gt2,gt1) 
coup(8) = cplcFeFehhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cCha Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTohhFecCha 
 
 
Subroutine SvToFeSucFd(iIN,MFe,MSu,MFd,MCha,MSv,cplcChaFecSvL,cplcChaFecSvR,          & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFeSuL,cplcFdFeSuR,           & 
& cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MSu(6),MFd(3),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),    & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),         & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 64 
Allocate( gSum(3,6,3, Isum) ) 
Allocate( Contribution(3,6,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,6
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSu(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MSu(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFdChaSuL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcFdChaSuR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFdFeSuL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcFdFeSuR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFeSuL(i1,gt1,gt2)) 
coup(3) = Conjg(cplcFdFeSuR(i1,gt1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt1,iIN) 
coup(2) = cplcChaFecSvR(i1,gt1,iIN) 
coup(3) = cplcFdChaSuL(gt3,i1,gt2) 
coup(4) = cplcFdChaSuR(gt3,i1,gt2) 
coup(5) = cplcChaFecSvL(i2,gt1,iIN) 
coup(6) = cplcChaFecSvR(i2,gt1,iIN)  
coup(7) = cplcFdChaSuL(gt3,i2,gt2) 
coup(8) = cplcFdChaSuR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(i1,gt1,iIN) 
coup(2) = cplcChaFecSvR(i1,gt1,iIN) 
coup(3) = cplcFdChaSuL(gt3,i1,gt2) 
coup(4) = cplcFdChaSuR(gt3,i1,gt2) 
coup(5) = cplcFeFecSvL(i2,gt1,iIN) 
coup(6) = cplcFeFecSvR(i2,gt1,iIN)  
coup(7) = cplcFdFeSuL(gt3,i2,gt2) 
coup(8) = cplcFdFeSuR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Cha],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], Fd 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcChaFecSvL(i1,gt1,iIN) 
coup(2) = cplcChaFecSvR(i1,gt1,iIN) 
coup(3) = cplcFdChaSuL(gt3,i1,gt2) 
coup(4) = cplcFdChaSuR(gt3,i1,gt2) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdFeSuL(i2,gt1,gt2) 
coup(8) = cplcFdFeSuR(i2,gt1,gt2) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Cha],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],Fd'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt1,iIN) 
coup(2) = cplcFeFecSvR(i1,gt1,iIN) 
coup(3) = cplcFdFeSuL(gt3,i1,gt2) 
coup(4) = cplcFdFeSuR(gt3,i1,gt2) 
coup(5) = cplcFeFecSvL(i2,gt1,iIN) 
coup(6) = cplcFeFecSvR(i2,gt1,iIN)  
coup(7) = cplcFdFeSuL(gt3,i2,gt2) 
coup(8) = cplcFdFeSuR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], Fd 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFeFecSvL(i1,gt1,iIN) 
coup(2) = cplcFeFecSvR(i1,gt1,iIN) 
coup(3) = cplcFdFeSuL(gt3,i1,gt2) 
coup(4) = cplcFdFeSuR(gt3,i1,gt2) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdFeSuL(i2,gt1,gt2) 
coup(8) = cplcFdFeSuR(i2,gt1,gt2) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: bar[Fe],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],Fd'
        End Do 
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdFeSuL(i1,gt1,gt2) 
coup(4) = cplcFdFeSuR(i1,gt1,gt2) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdFeSuL(i2,gt1,gt2) 
coup(8) = cplcFdFeSuR(i2,gt1,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Su cFd Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,6
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFeSucFd 
 
 
Subroutine SvToSvFecFe(iIN,MSv,MFe,MVZ,Mhh,MCha,cplhhSvcSv,cplSvcSvVZ,cplcChaFecSvL,  & 
& cplcChaFecSvR,cplcFeChaSvL,cplcFeChaSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,         & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,deltaM,epsI,               & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFe(3),MVZ,Mhh(2),MCha(2)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplSvcSvVZ(3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),          & 
& cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 64 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MSv(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MFe(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(2) = Conjg(cplcFeFeVZR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFehhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='hh'
      End Do 



!-------------- 
!  bar[Cha] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFeChaSvL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha]'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFeFeSvL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSvcSvVZ(gt1,iIN) 
coup(2) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFeVZR(gt3,gt2))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(5) = Conjg(cplcFeFehhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFeFehhR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: VZ,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,hh'
      End Do 



!-------------- 
!  VZ, bar[Cha] 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MCha2(i2)  
coup(1) = cplcChaFecSvL(i2,gt2,iIN) 
coup(2) = cplcChaFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(gt3,i2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFeFeVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: VZ,bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,bar[Cha]'
      End Do 



!-------------- 
!  VZ, bar[Fe] 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MFe2(i2)  
coup(1) = cplcFeFecSvL(i2,gt2,iIN) 
coup(2) = cplcFeFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFeSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(gt3,i2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFeFeVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: VZ,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,bar[Fe]'
      End Do 



!-------------- 
!  hh, hh 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = Mhh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplhhSvcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFehhR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFehhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFehhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: hh,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,hh'
        End Do 
      End Do 



!-------------- 
!  hh, bar[Cha] 
!-------------- 
Do i1=1,2
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MCha(i2)  
coup(1) = cplcChaFecSvL(i2,gt2,iIN) 
coup(2) = cplcChaFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFehhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: hh,bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  hh, bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(i2,gt2,iIN) 
coup(2) = cplcFeFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFeSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFehhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: hh,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Cha] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplcFeChaSvL(gt3,i1,gt1) 
coup(4) = cplcFeChaSvR(gt3,i1,gt1) 
coup(5) = cplcChaFecSvL(i2,gt2,iIN) 
coup(6) = cplcChaFecSvR(i2,gt2,iIN)  
coup(7) = cplcFeChaSvL(gt3,i2,gt1) 
coup(8) = cplcFeChaSvR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: bar[Cha],bar[Cha]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Cha]'
        End Do 
      End Do 



!-------------- 
!  bar[Cha], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(i1,gt2,iIN) 
coup(2) = cplcChaFecSvR(i1,gt2,iIN) 
coup(3) = cplcFeChaSvL(gt3,i1,gt1) 
coup(4) = cplcFeChaSvR(gt3,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplcFeFeSvL(gt3,i2,gt1) 
coup(8) = cplcFeFeSvR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: bar[Cha],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Cha],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt2,iIN) 
coup(2) = cplcFeFecSvR(i1,gt2,iIN) 
coup(3) = cplcFeFeSvL(gt3,i1,gt1) 
coup(4) = cplcFeFeSvR(gt3,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplcFeFeSvL(gt3,i2,gt1) 
coup(8) = cplcFeFeSvR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fe cFe Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSvFecFe 
 
 
Subroutine SvToFeAhcFe(iIN,MFe,MAh,MSv,cplcFeFeAhL,cplcFeFeAhR,cplcFeFecSvL,          & 
& cplcFeFecSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MAh(2),MSv(3)

Complex(dp),Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,2,3, Isum) ) 
Allocate( Contribution(3,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MAh(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MAh(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFeFeAhL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcFeFeAhR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cFe Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt1,iIN) 
coup(2) = cplcFeFecSvR(i1,gt1,iIN) 
coup(3) = cplcFeFeAhL(gt3,i1,gt2) 
coup(4) = cplcFeFeAhR(gt3,i1,gt2) 
coup(5) = cplcFeFecSvL(i2,gt1,iIN) 
coup(6) = cplcFeFecSvR(i2,gt1,iIN)  
coup(7) = cplcFeFeAhL(gt3,i2,gt2) 
coup(8) = cplcFeFeAhR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe Ah cFe Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFeAhcFe 
 
 
Subroutine SvTocHpmFeFv(iIN,MHpm,MFe,MSe,MSv,cplSecHpmcSv,cplcFeFecSvL,               & 
& cplcFeFecSvR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MFe(3),MSe(6),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplFvFecHpmL(3,3,2),      & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MHpm(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(MFe(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fe Fv Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFecHpmL(gt3,i1,gt1)) 
coup(3) = Conjg(cplFvFecHpmR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fe Fv Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecHpmcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
coup(4) = cplSecHpmcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fe Fv Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, bar[Fe] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(i2,gt2,iIN) 
coup(2) = cplcFeFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplFvFecHpmL(gt3,i2,gt1)) 
coup(3) = Conjg(cplFvFecHpmR(gt3,i2,gt1))  
coup(5) = cplSecHpmcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fe Fv Propagator: Se,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt2,iIN) 
coup(2) = cplcFeFecSvR(i1,gt2,iIN) 
coup(3) = cplFvFecHpmL(gt3,i1,gt1) 
coup(4) = cplFvFecHpmR(gt3,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplFvFecHpmL(gt3,i2,gt1) 
coup(8) = cplFvFecHpmR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Fe Fv Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocHpmFeFv 
 
 
Subroutine SvTohhFecFe(iIN,Mhh,MFe,MSv,cplhhSvcSv,cplcFeFecSvL,cplcFeFecSvR,          & 
& cplcFeFehhL,cplcFeFehhR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),         & 
& cplcFeFehhR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (Mhh(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(MFe(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cFe Propagator: Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv'
      End Do 



!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFeFehhL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFeFehhR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cFe Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplhhSvcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeFecSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFecSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cFe Propagator: Sv,Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Sv'
        End Do 
      End Do 



!-------------- 
!  Sv, bar[Fe] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(i2,gt2,iIN) 
coup(2) = cplcFeFecSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFehhL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFehhR(gt3,i2,gt1))  
coup(5) = cplhhSvcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cFe Propagator: Sv,bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt2,iIN) 
coup(2) = cplcFeFecSvR(i1,gt2,iIN) 
coup(3) = cplcFeFehhL(gt3,i1,gt1) 
coup(4) = cplcFeFehhR(gt3,i1,gt1) 
coup(5) = cplcFeFecSvL(i2,gt2,iIN) 
coup(6) = cplcFeFecSvR(i2,gt2,iIN)  
coup(7) = cplcFeFehhL(gt3,i2,gt1) 
coup(8) = cplcFeFehhR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Fe cFe Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTohhFecFe 
 
 
Subroutine SvToFecChacSv(iIN,MFe,MCha,MSv,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,   & 
& cplcFeFecSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(3,2,3, Isum) ) 
Allocate( Contribution(3,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (MCha(gt2)/MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(MCha(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcChaFecSvL(gt2,i1,gt3)) 
coup(3) = Conjg(cplcChaFecSvR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cCha cSv Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFecSvL(i1,gt1,gt3)) 
coup(3) = Conjg(cplcFeFecSvR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cCha cSv Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt1,iIN) 
coup(2) = cplcFeFecSvR(i1,gt1,iIN) 
coup(3) = cplcChaFecSvL(gt2,i1,gt3) 
coup(4) = cplcChaFecSvR(gt2,i1,gt3) 
coup(5) = cplcFeFecSvL(i2,gt1,iIN) 
coup(6) = cplcFeFecSvR(i2,gt1,iIN)  
coup(7) = cplcChaFecSvL(gt2,i2,gt3) 
coup(8) = cplcChaFecSvR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cCha cSv Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



!-------------- 
!  bar[Fe], Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt1,iIN) 
coup(2) = cplcFeFecSvR(i1,gt1,iIN) 
coup(3) = cplcChaFecSvL(gt2,i1,gt3) 
coup(4) = cplcChaFecSvR(gt2,i1,gt3) 
coup(5) = cplcChaFecSvL(gt2,i2,iIN) 
coup(6) = cplcChaFecSvR(gt2,i2,iIN)  
coup(7) = cplcFeFecSvL(i2,gt1,gt3) 
coup(8) = cplcFeFecSvR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cCha cSv Propagator: bar[Fe],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt2,i1,iIN) 
coup(2) = cplcChaFecSvR(gt2,i1,iIN) 
coup(3) = cplcFeFecSvL(i1,gt1,gt3) 
coup(4) = cplcFeFecSvR(i1,gt1,gt3) 
coup(5) = cplcChaFecSvL(gt2,i2,iIN) 
coup(6) = cplcChaFecSvR(gt2,i2,iIN)  
coup(7) = cplcFeFecSvL(i2,gt1,gt3) 
coup(8) = cplcFeFecSvR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cCha cSv Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFecChacSv 
 
 
Subroutine SvToFecFecSv(iIN,MFe,MSv,cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (MFe(gt2)/MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(MFe(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  bar[Fe] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFeFecSvL(gt2,i1,gt3)) 
coup(3) = Conjg(cplcFeFecSvR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cFe cSv Propagator: bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe]'
      End Do 



!-------------- 
!  bar[Fe], bar[Fe] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(i1,gt1,iIN) 
coup(2) = cplcFeFecSvR(i1,gt1,iIN) 
coup(3) = cplcFeFecSvL(gt2,i1,gt3) 
coup(4) = cplcFeFecSvR(gt2,i1,gt3) 
coup(5) = cplcFeFecSvL(i2,gt1,iIN) 
coup(6) = cplcFeFecSvR(i2,gt1,iIN)  
coup(7) = cplcFeFecSvL(gt2,i2,gt3) 
coup(8) = cplcFeFecSvR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fe cFe cSv Propagator: bar[Fe],bar[Fe]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fe],bar[Fe]'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFecFecSv 
 
 
Subroutine SvToFvAhChi(iIN,MAh,MChi,MSv,cplChiChiAhL,cplChiChiAhR,cplChiFvcSvL,       & 
& cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 16 
Allocate( gSum(3,2,4, Isum) ) 
Allocate( Contribution(3,2,4, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,4
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (MChi(gt3)/MSv(iIN))**2 
rj2 = (MAh(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MChi(gt3))+Abs(MAh(gt2))+Abs(0.))) Then 
!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplChiChiAhL(i1,gt3,gt2)) 
coup(3) = Conjg(cplChiChiAhR(i1,gt3,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Ah Chi Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt1,iIN) 
coup(2) = cplChiFvcSvR(i1,gt1,iIN) 
coup(3) = cplChiChiAhL(i1,gt3,gt2) 
coup(4) = cplChiChiAhR(i1,gt3,gt2) 
coup(5) = cplChiFvcSvL(i2,gt1,iIN) 
coup(6) = cplChiFvcSvR(i2,gt1,iIN)  
coup(7) = cplChiChiAhL(i2,gt3,gt2) 
coup(8) = cplChiChiAhR(i2,gt3,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Ah Chi Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=2,2
        Do gt3=1,4
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:16))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFvAhChi 
 
 
Subroutine SvTocHpmChaFv(iIN,MHpm,MCha,MSe,MChi,MSv,cplSecHpmcSv,cplChiChacHpmL,      & 
& cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,deltaM,             & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MCha(2),MSe(6),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiFvcSvL(4,3,3),  & 
& cplChiFvcSvR(4,3,3),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 100 
Allocate( gSum(2,2,3, Isum) ) 
Allocate( Contribution(2,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MHpm(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(MCha(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Cha Fv Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiChacHpmL(i1,gt2,gt1)) 
coup(3) = Conjg(cplChiChacHpmR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Cha Fv Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecHpmcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
coup(4) = cplSecHpmcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplFvChacSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvChacSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Cha Fv Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



!-------------- 
!  Se, Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt3,iIN) 
coup(2) = cplChiFvcSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiChacHpmL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiChacHpmR(i2,gt2,gt1))  
coup(5) = cplSecHpmcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Cha Fv Propagator: Se,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiChacHpmL(i1,gt2,gt1) 
coup(4) = cplChiChacHpmR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiChacHpmL(i2,gt2,gt1) 
coup(8) = cplChiChacHpmR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cHpm Cha Fv Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=2,2
      Do gt2=1,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:100))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocHpmChaFv 
 
 
Subroutine SvTohhChiFv(iIN,Mhh,MChi,MSv,cplhhSvcSv,cplChiChihhL,cplChiChihhR,         & 
& cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiFvcSvL(4,3,3),        & 
& cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 49 
Allocate( gSum(2,4,3, Isum) ) 
Allocate( Contribution(2,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (Mhh(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(MChi(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvcSvR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Chi Fv Propagator: Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiChihhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplChiChihhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Chi Fv Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplhhSvcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
coup(4) = cplhhSvcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplChiFvcSvL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFvcSvR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Chi Fv Propagator: Sv,Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Sv'
        End Do 
      End Do 



!-------------- 
!  Sv, Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt3,iIN) 
coup(2) = cplChiFvcSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiChihhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiChihhR(i2,gt2,gt1))  
coup(5) = cplhhSvcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Chi Fv Propagator: Sv,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiChihhL(i1,gt2,gt1) 
coup(4) = cplChiChihhR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiChihhL(i2,gt2,gt1) 
coup(8) = cplChiChihhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->hh Chi Fv Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,2
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:49))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTohhChiFv 
 
 
Subroutine SvToFvFucSu(iIN,MFu,MSu,MChi,MSv,cplChiFucSuL,cplChiFucSuR,cplChiFvcSvL,   & 
& cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFu(3),MSu(6),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 16 
Allocate( gSum(3,3,6, Isum) ) 
Allocate( Contribution(3,3,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (MFu(gt2)/MSv(iIN))**2 
rj2 = (MSu(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSu(gt3))+Abs(MFu(gt2))+Abs(0.))) Then 
!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplChiFucSuL(i1,gt2,gt3)) 
coup(3) = Conjg(cplChiFucSuR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Fu cSu Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt1,iIN) 
coup(2) = cplChiFvcSvR(i1,gt1,iIN) 
coup(3) = cplChiFucSuL(i1,gt2,gt3) 
coup(4) = cplChiFucSuR(i1,gt2,gt3) 
coup(5) = cplChiFvcSvL(i2,gt1,iIN) 
coup(6) = cplChiFvcSvR(i2,gt1,iIN)  
coup(7) = cplChiFucSuL(i2,gt2,gt3) 
coup(8) = cplChiFucSuR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Fu cSu Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:16))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFvFucSu 
 
 
Subroutine SvToSvFvFv(iIN,MSv,MVZ,MChi,cplSvcSvVZ,cplChiFvcSvL,cplChiFvcSvR,          & 
& cplChiFvSvL,cplChiFvSvR,cplFvFvVZL,cplFvFvVZR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MVZ,MChi(4)

Complex(dp),Intent(in) :: cplSvcSvVZ(3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),           & 
& cplChiFvSvR(4,3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 25 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=gt2,3
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MSv(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(0.)+Abs(MSv(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplFvFvVZL(gt2,gt3)) 
coup(2) = Conjg(cplFvFvVZR(gt2,gt3))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplFvFvVZL(gt3,gt2)) 
coup(2) = Conjg(cplFvFvVZR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fv Fv Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFvSvL(i1,gt3,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFvSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MChi(i1)  
mass(2) = MChi(i1)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiFvSvL(i1,gt2,gt1) 
coup(4) = cplChiFvSvR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i1,gt2,iIN) 
coup(6) = cplChiFvcSvR(i1,gt2,iIN)  
coup(7) = cplChiFvSvL(i1,gt3,gt1) 
coup(8) = cplChiFvSvR(i1,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fv Fv Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  VZ, Chi 
!-------------- 
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MChi2(i2)  
coup(1) = cplChiFvcSvL(i2,gt2,iIN) 
coup(2) = cplChiFvcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i2,gt3,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplFvFvVZL(gt2,gt3)) 
coup(6) = Conjg(cplFvFvVZR(gt2,gt3))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(2) = MVZ2  
mass(1) = MChi2(i2)  
coup(1) = cplChiFvcSvL(i2,gt3,iIN) 
coup(2) = cplChiFvcSvR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFvSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i2,gt2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplFvFvVZL(gt2,gt3)) 
coup(6) = Conjg(cplFvFvVZR(gt2,gt3))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fv Fv Propagator: VZ,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Chi'
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplChiFvSvL(i1,gt3,gt1) 
coup(4) = cplChiFvSvR(i1,gt3,gt1) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplChiFvSvL(i2,gt3,gt1) 
coup(8) = cplChiFvSvR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiFvSvL(i1,gt2,gt1) 
coup(4) = cplChiFvSvR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplChiFvSvL(i2,gt3,gt1) 
coup(8) = cplChiFvSvR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt3,iIN) 
coup(2) = cplChiFvcSvR(i1,gt3,iIN) 
coup(3) = cplChiFvSvL(i1,gt2,gt1) 
coup(4) = cplChiFvSvR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFvSvL(i2,gt2,gt1) 
coup(8) = cplChiFvSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplChiFvSvL(i1,gt3,gt1) 
coup(4) = cplChiFvSvR(i1,gt3,gt1) 
coup(5) = cplChiFvcSvL(i2,gt3,iIN) 
coup(6) = cplChiFvcSvR(i2,gt3,iIN)  
coup(7) = cplChiFvSvL(i2,gt2,gt1) 
coup(8) = cplChiFvSvR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fv Fv Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=gt2,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:25))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSvFvFv 
 
 
Subroutine SvToFvFvcSv(iIN,MSv,MChi,cplChiFvcSvL,cplChiFvcSvR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MChi(4)

Complex(dp),Intent(in) :: cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 16 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(0.)+Abs(0.))) Then 
!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(i1,gt2,gt3)) 
coup(3) = Conjg(cplChiFvcSvR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(i1,gt1,gt3)) 
coup(3) = Conjg(cplChiFvcSvR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MChi(i1)  
mass(2) = MChi(i1)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplChiFvcSvL(i1,gt1,gt3) 
coup(4) = cplChiFvcSvR(i1,gt1,gt3) 
coup(5) = cplChiFvcSvL(i1,gt1,iIN) 
coup(6) = cplChiFvcSvR(i1,gt1,iIN)  
coup(7) = cplChiFvcSvL(i1,gt2,gt3) 
coup(8) = cplChiFvcSvR(i1,gt2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Fv cSv Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt1,iIN) 
coup(2) = cplChiFvcSvR(i1,gt1,iIN) 
coup(3) = cplChiFvcSvL(i1,gt2,gt3) 
coup(4) = cplChiFvcSvR(i1,gt2,gt3) 
coup(5) = cplChiFvcSvL(i2,gt1,iIN) 
coup(6) = cplChiFvcSvR(i2,gt1,iIN)  
coup(7) = cplChiFvcSvL(i2,gt2,gt3) 
coup(8) = cplChiFvcSvR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplChiFvcSvL(i1,gt1,gt3) 
coup(4) = cplChiFvcSvR(i1,gt1,gt3) 
coup(5) = cplChiFvcSvL(i2,gt1,iIN) 
coup(6) = cplChiFvcSvR(i2,gt1,iIN)  
coup(7) = cplChiFvcSvL(i2,gt2,gt3) 
coup(8) = cplChiFvcSvR(i2,gt2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplChiFvcSvL(i1,gt1,gt3) 
coup(4) = cplChiFvcSvR(i1,gt1,gt3) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplChiFvcSvL(i2,gt1,gt3) 
coup(8) = cplChiFvcSvR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt1,iIN) 
coup(2) = cplChiFvcSvR(i1,gt1,iIN) 
coup(3) = cplChiFvcSvL(i1,gt2,gt3) 
coup(4) = cplChiFvcSvR(i1,gt2,gt3) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplChiFvcSvL(i2,gt1,gt3) 
coup(8) = cplChiFvcSvR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Fv cSv Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:16))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFvFvcSv 
 
 
Subroutine SvTocChaFvHpm(iIN,MCha,MHpm,MFe,MChi,MSv,cplcChaChiHpmL,cplcChaChiHpmR,    & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplChiFvcSvL,cplChiFvcSvR,       & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MHpm(2),MFe(3),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),& 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 49 
Allocate( gSum(2,3,2, Isum) ) 
Allocate( Contribution(2,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=2,2
Isum = 0 
 
rk2 = (MCha(gt1)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MHpm(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MHpm(gt3))+Abs(0.)+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFeFvHpmR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fv Hpm Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcChaChiHpmL(gt1,i1,gt3)) 
coup(3) = Conjg(cplcChaChiHpmR(gt1,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fv Hpm Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt1,i1,iIN) 
coup(2) = cplcChaFecSvR(gt1,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt2,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt2,gt3) 
coup(5) = cplcChaFecSvL(gt1,i2,iIN) 
coup(6) = cplcChaFecSvR(gt1,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt2,gt3) 
coup(8) = cplcFeFvHpmR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fv Hpm Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcChaFecSvL(gt1,i1,iIN) 
coup(2) = cplcChaFecSvR(gt1,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt2,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt2,gt3) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplcChaChiHpmL(gt1,i2,gt3) 
coup(8) = cplcChaChiHpmR(gt1,i2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fv Hpm Propagator: Fe,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplcChaChiHpmL(gt1,i1,gt3) 
coup(4) = cplcChaChiHpmR(gt1,i1,gt3) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplcChaChiHpmL(gt1,i2,gt3) 
coup(8) = cplcChaChiHpmR(gt1,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fv Hpm Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=2,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:49))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocChaFvHpm 
 
 
Subroutine SvToSdFvcFd(iIN,MSd,MFd,MChi,MSv,cplSdcSdcSv,cplcFdChiSdL,cplcFdChiSdR,    & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFvSdL,cplcFdFvSdR,cplChiFvcSvL,cplChiFvcSvR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFd(3),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFdcSvL(3,3,3),       & 
& cplcFdFdcSvR(3,3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 169 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(0.)+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Sd] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFdFvSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFvSdR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd]'
      End Do 



!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFvSdL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdFvSdR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFdChiSdL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFdChiSdR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  conj[Sd], conj[Sd] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFvSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFvSdR(gt3,gt2,i1))  
coup(4) = cplSdcSdcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFvSdL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFvSdR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: conj[Sd],conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],conj[Sd]'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFvSdL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFvSdR(i2,gt2,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFvSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFvSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: conj[Sd],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],Fd'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt2,iIN) 
coup(2) = cplChiFvcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdChiSdL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdChiSdR(gt3,i2,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFvSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFvSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: conj[Sd],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],Chi'
        End Do 
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdFvSdL(i1,gt2,gt1) 
coup(4) = cplcFdFvSdR(i1,gt2,gt1) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdFvSdL(i2,gt2,gt1) 
coup(8) = cplcFdFvSdR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



!-------------- 
!  Fd, Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdFvSdL(i1,gt2,gt1) 
coup(4) = cplcFdFvSdR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplcFdChiSdL(gt3,i2,gt1) 
coup(8) = cplcFdChiSdR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: Fd,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplcFdChiSdL(gt3,i1,gt1) 
coup(4) = cplcFdChiSdR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplcFdChiSdL(gt3,i2,gt1) 
coup(8) = cplcFdChiSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Fv cFd Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:169))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSdFvcFd 
 
 
Subroutine SvToSeFvcFe(iIN,MSe,MFe,MVWm,MHpm,MChi,MSv,cplSecHpmcSv,cplSecSecSv,       & 
& cplSecSvcVWm,cplcFeChiSeL,cplcFeChiSeR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,         & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplChiFvcSvL,           & 
& cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFe(3),MVWm,MHpm(2),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplcFeChiSeL(3,4,6),         & 
& cplcFeChiSeR(3,4,6),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),       & 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 256 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (MFe(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFe(gt3))+Abs(0.)+Abs(MSe(gt1)))) Then 
!-------------- 
!  conj[VWm] 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVWm 
mass(2) = MVWm 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSvcVWm(gt1,iIN)) 
coup(3) = Conjg(cplcFeFvVWmL(gt3,gt2)) 
coup(2) = Conjg(cplcFeFvVWmR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[VWm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm]'



!-------------- 
!  conj[Hpm] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MHpm(i1) 
mass(2) = MHpm(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFeFvHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFvHpmR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm]'
      End Do 



!-------------- 
!  conj[Se] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFeFvSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFvSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFvSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  conj[VWm], conj[Hpm] 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MHpm(i2)  
coup(1) = cplSecSvcVWm(gt1,iIN) 
coup(2) = Conjg(cplcFeFvVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFvVWmR(gt3,gt2))  
coup(4) = cplSecHpmcSv(gt1,i2,iIN) 
coup(5) = Conjg(cplcFeFvHpmL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFeFvHpmR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[VWm],conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],conj[Hpm]'
      End Do 



!-------------- 
!  conj[VWm], conj[Se] 
!-------------- 
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MSe(i2)  
coup(1) = cplSecSvcVWm(gt1,iIN) 
coup(2) = Conjg(cplcFeFvVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFvVWmR(gt3,gt2))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(5) = Conjg(cplcFeFvSeL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFeFvSeR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[VWm],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],conj[Se]'
      End Do 



!-------------- 
!  conj[VWm], Fe 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MFe2(i2)  
coup(1) = cplcFeFecSvL(gt3,i2,iIN) 
coup(2) = cplcFeFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt2,gt1))  
coup(5) = cplSecSvcVWm(gt1,iIN) 
coup(7) = Conjg(cplcFeFvVWmL(gt3,gt2)) 
coup(6) = Conjg(cplcFeFvVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[VWm],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],Fe'
      End Do 



!-------------- 
!  conj[VWm], Chi 
!-------------- 
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MChi2(i2)  
coup(1) = cplChiFvcSvL(i2,gt2,iIN) 
coup(2) = cplChiFvcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplSecSvcVWm(gt1,iIN) 
coup(7) = Conjg(cplcFeFvVWmL(gt3,gt2)) 
coup(6) = Conjg(cplcFeFvVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[VWm],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],Chi'
      End Do 



!-------------- 
!  conj[Hpm], conj[Hpm] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MHpm(i2)  
coup(1) = cplSecHpmcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFvHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFvHpmR(gt3,gt2,i1))  
coup(4) = cplSecHpmcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeFvHpmL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFvHpmR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Hpm],conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],conj[Hpm]'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], conj[Se] 
!-------------- 
Do i1=1,2
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecHpmcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFvHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFvHpmR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeFvSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFvSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Hpm],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],conj[Se]'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt3,i2,iIN) 
coup(2) = cplcFeFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt2,gt1))  
coup(5) = cplSecHpmcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFvHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFvHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Hpm],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],Fe'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], Chi 
!-------------- 
Do i1=1,2
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt2,iIN) 
coup(2) = cplChiFvcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplSecHpmcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFvHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFvHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Hpm],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],Chi'
        End Do 
      End Do 



!-------------- 
!  conj[Se], conj[Se] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFvSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFvSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeFvSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFvSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Se],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],conj[Se]'
        End Do 
      End Do 



!-------------- 
!  conj[Se], Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt3,i2,iIN) 
coup(2) = cplcFeFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFvSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFvSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Se],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],Fe'
        End Do 
      End Do 



!-------------- 
!  conj[Se], Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFvcSvL(i2,gt2,iIN) 
coup(2) = cplChiFvcSvR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFvSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFvSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: conj[Se],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],Chi'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt3,i1,iIN) 
coup(2) = cplcFeFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt2,gt1) 
coup(4) = cplcFeFvSeR(i1,gt2,gt1) 
coup(5) = cplcFeFecSvL(gt3,i2,iIN) 
coup(6) = cplcFeFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt2,gt1) 
coup(8) = cplcFeFvSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcFeFecSvL(gt3,i1,iIN) 
coup(2) = cplcFeFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt2,gt1) 
coup(4) = cplcFeFvSeR(i1,gt2,gt1) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplcFeChiSeL(gt3,i2,gt1) 
coup(8) = cplcFeChiSeR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: Fe,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Chi'
        End Do 
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt2,iIN) 
coup(2) = cplChiFvcSvR(i1,gt2,iIN) 
coup(3) = cplcFeChiSeL(gt3,i1,gt1) 
coup(4) = cplcFeChiSeR(gt3,i1,gt1) 
coup(5) = cplChiFvcSvL(i2,gt2,iIN) 
coup(6) = cplChiFvcSvR(i2,gt2,iIN)  
coup(7) = cplcFeChiSeL(gt3,i2,gt1) 
coup(8) = cplcFeChiSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cFe Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:256))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSeFvcFe 
 
 
Subroutine SvToFvSucFu(iIN,MSu,MFu,MChi,MSv,cplcFuChiSuL,cplcFuChiSuR,cplChiFvcSvL,   & 
& cplChiFvcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSu(6),MFu(3),MChi(4),MSv(3)

Complex(dp),Intent(in) :: cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 16 
Allocate( gSum(3,6,3, Isum) ) 
Allocate( Contribution(3,6,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,6
        Do gt3=1,3
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSu(gt2)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MSu(gt2))+Abs(0.))) Then 
!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplChiFvcSvL(i1,gt1,iIN)) 
coup(1) = Conjg(cplChiFvcSvR(i1,gt1,iIN)) 
coup(4) = Conjg(cplcFuChiSuL(gt3,i1,gt2)) 
coup(3) = Conjg(cplcFuChiSuR(gt3,i1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Su cFu Propagator: Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi'
      End Do 



!-------------- 
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFvcSvL(i1,gt1,iIN) 
coup(2) = cplChiFvcSvR(i1,gt1,iIN) 
coup(3) = cplcFuChiSuL(gt3,i1,gt2) 
coup(4) = cplcFuChiSuR(gt3,i1,gt2) 
coup(5) = cplChiFvcSvL(i2,gt1,iIN) 
coup(6) = cplChiFvcSvR(i2,gt1,iIN)  
coup(7) = cplcFuChiSuL(gt3,i2,gt2) 
coup(8) = cplcFuChiSuR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Fv Su cFu Propagator: Chi,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Chi'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,6
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:16))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToFvSucFu 
 
 
Subroutine SvToSdGlucFd(iIN,MSd,MGlu,MFd,MSv,cplSdcSdcSv,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFdGluSdL,cplcFdGluSdR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MGlu,MFd(3),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdGluSdL(3,6),         & 
& cplcFdGluSdR(3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,1,3, Isum) ) 
Allocate( Contribution(6,1,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
        Do gt3=1,3
Isum = 0 
 
rk2 = (MGlu/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MGlu)+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Sd] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFdGluSdL(gt3,i1)) 
coup(2) = Conjg(cplcFdGluSdR(gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Glu cFd Propagator: conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp
Else 
gSum(gt1,1,gt3,Isum)=resD
End If 
Contribution(gt1,1,gt3,Isum)='conj[Sd]'
      End Do 



!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdGluSdL(i1,gt1)) 
coup(3) = Conjg(cplcFdGluSdR(i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Glu cFd Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp
Else 
gSum(gt1,1,gt3,Isum)=resD
End If 
Contribution(gt1,1,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  conj[Sd], conj[Sd] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdGluSdL(gt3,i1)) 
coup(2) = Conjg(cplcFdGluSdR(gt3,i1))  
coup(4) = cplSdcSdcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdGluSdL(gt3,i2)) 
coup(5) = Conjg(cplcFdGluSdR(gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Glu cFd Propagator: conj[Sd],conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp  
Else 
gSum(gt1,1,gt3,Isum)= resS  
End If 
Contribution(gt1,1,gt3,Isum)='conj[Sd],conj[Sd]'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdGluSdL(i2,gt1)) 
coup(3) = Conjg(cplcFdGluSdR(i2,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdGluSdL(gt3,i1)) 
coup(6) = Conjg(cplcFdGluSdR(gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Glu cFd Propagator: conj[Sd],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp  
Else 
gSum(gt1,1,gt3,Isum)= resS  
End If 
Contribution(gt1,1,gt3,Isum)='conj[Sd],Fd'
        End Do 
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdGluSdL(i1,gt1) 
coup(4) = cplcFdGluSdR(i1,gt1) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdGluSdL(i2,gt1) 
coup(8) = cplcFdGluSdR(i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd Glu cFd Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp  
Else 
gSum(gt1,1,gt3,Isum)= resS  
End If 
Contribution(gt1,1,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



Else 
gSum(gt1,1,gt3,:)= 0._dp  
End If 
       End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
        Do gt3=1,3
g(gt1,1,gt3)=Sum(gSum(gt1,1,gt3,1:81))
If (g(gt1,1,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,1,gt3)=0._dp
End If
       End Do 
   End Do 
End Subroutine SvToSdGlucFd 
 
 
Subroutine SvToSdcChacFu(iIN,MSd,MCha,MFu,MFe,MSv,cplSdcSdcSv,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcChaFecSvL,cplcChaFecSvR,cplcFecFuSdL,cplcFecFuSdR,deltaM,            & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MCha(2),MFu(3),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcChaFecSvL(2,3,3),    & 
& cplcChaFecSvR(2,3,3),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,2,3, Isum) ) 
Allocate( Contribution(6,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MCha(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Sd] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcChacFuSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplcChacFuSdR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cCha cFu Propagator: conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFecFuSdL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFecFuSdR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cCha cFu Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  conj[Sd], conj[Sd] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcChacFuSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplcChacFuSdR(gt2,gt3,i1))  
coup(4) = cplSdcSdcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcChacFuSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplcChacFuSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cCha cFu Propagator: conj[Sd],conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],conj[Sd]'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt2,i2,iIN) 
coup(2) = cplcChaFecSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFecFuSdL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFecFuSdR(i2,gt3,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcChacFuSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplcChacFuSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cCha cFu Propagator: conj[Sd],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt2,i1,iIN) 
coup(2) = cplcChaFecSvR(gt2,i1,iIN) 
coup(3) = cplcFecFuSdL(i1,gt3,gt1) 
coup(4) = cplcFecFuSdR(i1,gt3,gt1) 
coup(5) = cplcChaFecSvL(gt2,i2,iIN) 
coup(6) = cplcChaFecSvR(gt2,i2,iIN)  
coup(7) = cplcFecFuSdL(i2,gt3,gt1) 
coup(8) = cplcFecFuSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cCha cFu Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSdcChacFu 
 
 
Subroutine SvToSdcFecFu(iIN,MSd,MFe,MFu,MSv,cplSdcSdcSv,cplcFecFuSdL,cplcFecFuSdR,    & 
& cplcFeFecSvL,cplcFeFecSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFe(3),MFu(3),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFeFecSvL(3,3,3),       & 
& cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MFe(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Sd] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFecFuSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplcFecFuSdR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cFe cFu Propagator: conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(gt2,i1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFecFuSdL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFecFuSdR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cFe cFu Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  conj[Sd], conj[Sd] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFecFuSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplcFecFuSdR(gt2,gt3,i1))  
coup(4) = cplSdcSdcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFecFuSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplcFecFuSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cFe cFu Propagator: conj[Sd],conj[Sd]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],conj[Sd]'
        End Do 
      End Do 



!-------------- 
!  conj[Sd], Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt2,i2,iIN) 
coup(2) = cplcFeFecSvR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFecFuSdL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFecFuSdR(i2,gt3,gt1))  
coup(5) = cplSdcSdcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFecFuSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplcFecFuSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cFe cFu Propagator: conj[Sd],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sd],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt2,i1,iIN) 
coup(2) = cplcFeFecSvR(gt2,i1,iIN) 
coup(3) = cplcFecFuSdL(i1,gt3,gt1) 
coup(4) = cplcFecFuSdR(i1,gt3,gt1) 
coup(5) = cplcFeFecSvL(gt2,i2,iIN) 
coup(6) = cplcFeFecSvR(gt2,i2,iIN)  
coup(7) = cplcFecFuSdL(i2,gt3,gt1) 
coup(8) = cplcFecFuSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sd cFe cFu Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSdcFecFu 
 
 
Subroutine SvToSeFucFd(iIN,MSe,MFu,MFd,MVWm,MHpm,MSv,cplSecHpmcSv,cplSecSecSv,        & 
& cplSecSvcVWm,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,          & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFu(3),MFd(3),MVWm,MHpm(2),MSv(3)

Complex(dp),Intent(in) :: cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplcFdFdcSvL(3,3,3),         & 
& cplcFdFdcSvR(3,3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),        & 
& cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 144 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFu(gt2)/MSv(iIN))**2 
rm2 = (MFd(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFd(gt3))+Abs(MFu(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  conj[VWm] 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVWm 
mass(2) = MVWm 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSvcVWm(gt1,iIN)) 
coup(3) = Conjg(cplcFdFuVWmL(gt3,gt2)) 
coup(2) = Conjg(cplcFdFuVWmR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[VWm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm]'



!-------------- 
!  conj[Hpm] 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MHpm(i1) 
mass(2) = MHpm(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecHpmcSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFdFuHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFuHpmR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm]'
      End Do 



!-------------- 
!  conj[Se] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcFdFuSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFuSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se]'
      End Do 



!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFuSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  conj[VWm], conj[Hpm] 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MHpm(i2)  
coup(1) = cplSecSvcVWm(gt1,iIN) 
coup(2) = Conjg(cplcFdFuVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFuVWmR(gt3,gt2))  
coup(4) = cplSecHpmcSv(gt1,i2,iIN) 
coup(5) = Conjg(cplcFdFuHpmL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFdFuHpmR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[VWm],conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],conj[Hpm]'
      End Do 



!-------------- 
!  conj[VWm], conj[Se] 
!-------------- 
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MSe(i2)  
coup(1) = cplSecSvcVWm(gt1,iIN) 
coup(2) = Conjg(cplcFdFuVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFuVWmR(gt3,gt2))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(5) = Conjg(cplcFdFuSeL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFdFuSeR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[VWm],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],conj[Se]'
      End Do 



!-------------- 
!  conj[VWm], Fd 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MFd2(i2)  
coup(1) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i2,gt2,gt1))  
coup(5) = cplSecSvcVWm(gt1,iIN) 
coup(7) = Conjg(cplcFdFuVWmL(gt3,gt2)) 
coup(6) = Conjg(cplcFdFuVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 3*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[VWm],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[VWm],Fd'
      End Do 



!-------------- 
!  conj[Hpm], conj[Hpm] 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MHpm(i2)  
coup(1) = cplSecHpmcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFuHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFuHpmR(gt3,gt2,i1))  
coup(4) = cplSecHpmcSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFuHpmL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFuHpmR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Hpm],conj[Hpm]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],conj[Hpm]'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], conj[Se] 
!-------------- 
Do i1=1,2
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecHpmcSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFuHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFuHpmR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFuSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFuSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Hpm],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],conj[Se]'
        End Do 
      End Do 



!-------------- 
!  conj[Hpm], Fd 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i2,gt2,gt1))  
coup(5) = cplSecHpmcSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFuHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFuHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Hpm],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Hpm],Fd'
        End Do 
      End Do 



!-------------- 
!  conj[Se], conj[Se] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFuSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFuSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFuSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFuSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Se],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],conj[Se]'
        End Do 
      End Do 



!-------------- 
!  conj[Se], Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFuSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFuSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: conj[Se],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],Fd'
        End Do 
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt3,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt3,i1,iIN) 
coup(3) = cplcFdFuSeL(i1,gt2,gt1) 
coup(4) = cplcFdFuSeR(i1,gt2,gt1) 
coup(5) = cplcFdFdcSvL(gt3,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt3,i2,iIN)  
coup(7) = cplcFdFuSeL(i2,gt2,gt1) 
coup(8) = cplcFdFuSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fu cFd Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:144))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSeFucFd 
 
 
Subroutine SvToSeFvcCha(iIN,MSe,MCha,MFe,MSv,cplSecSecSv,cplcChaFecSvL,               & 
& cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,deltaM,epsI,           & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MCha(2),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),     & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 81 
Allocate( gSum(6,3,2, Isum) ) 
Allocate( Contribution(6,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,2
Isum = 0 
 
rk2 = (0./MSv(iIN))**2 
rm2 = (MCha(gt3)/MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MCha(gt3))+Abs(0.)+Abs(MSe(gt1)))) Then 
!-------------- 
!  conj[Se] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,i1,iIN)) 
coup(3) = Conjg(cplcChaFvSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaFvSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cCha Propagator: conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se]'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFvSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cCha Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  conj[Se], conj[Se] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(gt1,i1,iIN) 
coup(3) = Conjg(cplcChaFvSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaFvSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,i2,iIN) 
coup(6) = Conjg(cplcChaFvSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaFvSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cCha Propagator: conj[Se],conj[Se]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],conj[Se]'
        End Do 
      End Do 



!-------------- 
!  conj[Se], Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i2,iIN) 
coup(2) = cplcChaFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaFvSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaFvSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cCha Propagator: conj[Se],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Se],Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i1,iIN) 
coup(2) = cplcChaFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt2,gt1) 
coup(4) = cplcFeFvSeR(i1,gt2,gt1) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt2,gt1) 
coup(8) = cplcFeFvSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Se Fv cCha Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSeFvcCha 
 
 
Subroutine SvToSvChacCha(iIN,MSv,MCha,MVZ,Mhh,MFe,cplhhSvcSv,cplSvcSvVZ,              & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplcFeChaSvL,cplcFeChaSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MCha(2),MVZ,Mhh(2),MFe(3)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplSvcSvVZ(3,3),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),          & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(3,2,2, Isum) ) 
Allocate( Contribution(3,2,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,2
        Do gt3=1,2
Isum = 0 
 
rk2 = (MCha(gt2)/MSv(iIN))**2 
rm2 = (MCha(gt3)/MSv(iIN))**2 
rj2 = (MSv(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MCha(gt3))+Abs(MCha(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplcChaChaVZL(gt3,gt2)) 
coup(2) = Conjg(cplcChaChaVZR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplcChaChahhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChahhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='hh'
      End Do 



!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeChaSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSvcSvVZ(gt1,iIN) 
coup(2) = Conjg(cplcChaChaVZL(gt3,gt2)) 
coup(3) = Conjg(cplcChaChaVZR(gt3,gt2))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(5) = Conjg(cplcChaChahhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcChaChahhR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: VZ,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,hh'
      End Do 



!-------------- 
!  VZ, Fe 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MFe2(i2)  
coup(1) = cplcChaFecSvL(gt3,i2,iIN) 
coup(2) = cplcChaFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(i2,gt2,gt1))  
coup(5) = cplSvcSvVZ(gt1,iIN) 
coup(7) = Conjg(cplcChaChaVZL(gt3,gt2)) 
coup(6) = Conjg(cplcChaChaVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: VZ,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Fe'
      End Do 



!-------------- 
!  hh, hh 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = Mhh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplhhSvcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplcChaChahhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChahhR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplcChaChahhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaChahhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: hh,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,hh'
        End Do 
      End Do 



!-------------- 
!  hh, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i2,iIN) 
coup(2) = cplcChaFecSvR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(i2,gt2,gt1))  
coup(5) = cplhhSvcSv(i1,gt1,iIN) 
coup(7) = Conjg(cplcChaChahhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaChahhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: hh,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,Fe'
        End Do 
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt3,i1,iIN) 
coup(2) = cplcChaFecSvR(gt3,i1,iIN) 
coup(3) = cplcFeChaSvL(i1,gt2,gt1) 
coup(4) = cplcFeChaSvR(i1,gt2,gt1) 
coup(5) = cplcChaFecSvL(gt3,i2,iIN) 
coup(6) = cplcChaFecSvR(gt3,i2,iIN)  
coup(7) = cplcFeChaSvL(i2,gt2,gt1) 
coup(8) = cplcFeChaSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Cha cCha Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1, iIN-1
      Do gt2=1,2
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSvChacCha 
 
 
Subroutine SvToSvFucFu(iIN,MSv,MFu,MVZ,Mhh,cplhhSvcSv,cplSvcSvVZ,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFu(3),MVZ,Mhh(2)

Complex(dp),Intent(in) :: cplhhSvcSv(2,3,3),cplSvcSvVZ(3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),              & 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFu(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSv(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MFu(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSvcSvVZ(gt1,iIN)) 
coup(3) = Conjg(cplcFuFuVZL(gt3,gt2)) 
coup(2) = Conjg(cplcFuFuVZR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fu cFu Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplhhSvcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFuFuhhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFuhhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fu cFu Propagator: hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='hh'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSvcSvVZ(gt1,iIN) 
coup(2) = Conjg(cplcFuFuVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFuFuVZR(gt3,gt2))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(5) = Conjg(cplcFuFuhhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFuFuhhR(gt3,gt2,i2))  
If(Abs(mass(1)-mass(2)).lt.0.1) Then 
Call IntegrateVSGoldstone(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
Else 
Call IntegrateVS(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
End If 
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fu cFu Propagator: VZ,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,hh'
      End Do 



!-------------- 
!  hh, hh 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = Mhh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplhhSvcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFuhhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFuhhR(gt3,gt2,i1))  
coup(4) = cplhhSvcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFuhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFuhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->Sv Fu cFu Propagator: hh,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,hh'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvToSvFucFu 
 
 
Subroutine SvTocChaFeSv(iIN,MCha,MFe,MSv,cplcChaFecSvL,cplcChaFecSvR,cplcFeFeSvL,     & 
& cplcFeFeSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1, iIN-1
Isum = 0 
 
rk2 = (MCha(gt1)/MSv(iIN))**2 
rm2 = (MFe(gt2)/MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(MFe(gt2))+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcChaFecSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcChaFecSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFeFeSvL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFeFeSvR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fe Sv Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcChaFecSvL(gt1,i1,iIN) 
coup(2) = cplcChaFecSvR(gt1,i1,iIN) 
coup(3) = cplcFeFeSvL(i1,gt2,gt3) 
coup(4) = cplcFeFeSvR(i1,gt2,gt3) 
coup(5) = cplcChaFecSvL(gt1,i2,iIN) 
coup(6) = cplcChaFecSvR(gt1,i2,iIN)  
coup(7) = cplcFeFeSvL(i2,gt2,gt3) 
coup(8) = cplcFeFeSvR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cCha Fe Sv Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1, iIN-1
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocChaFeSv 
 
 
Subroutine SvTocFdChaSu(iIN,MFd,MCha,MSu,MSv,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplcFdFdcSvL,cplcFdFdcSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MCha(2),MSu(6),MSv(3)

Complex(dp),Intent(in) :: cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,2,6, Isum) ) 
Allocate( Contribution(3,2,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,6
Isum = 0 
 
rk2 = (MFd(gt1)/MSv(iIN))**2 
rm2 = (MCha(gt2)/MSv(iIN))**2 
rj2 = (MSu(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSu(gt3))+Abs(MCha(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFdChaSuL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFdChaSuR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFd Cha Su Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt1,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt1,i1,iIN) 
coup(3) = cplcFdChaSuL(i1,gt2,gt3) 
coup(4) = cplcFdChaSuR(i1,gt2,gt3) 
coup(5) = cplcFdFdcSvL(gt1,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt1,i2,iIN)  
coup(7) = cplcFdChaSuL(i2,gt2,gt3) 
coup(8) = cplcFdChaSuR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFd Cha Su Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocFdChaSu 
 
 
Subroutine SvTocFdFuHpm(iIN,MFd,MFu,MHpm,MSv,cplcFdFdcSvL,cplcFdFdcSvR,               & 
& cplcFdFuHpmL,cplcFdFuHpmR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MFu(3),MHpm(2),MSv(3)

Complex(dp),Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,2, Isum) ) 
Allocate( Contribution(3,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=2,2
Isum = 0 
 
rk2 = (MFd(gt1)/MSv(iIN))**2 
rm2 = (MFu(gt2)/MSv(iIN))**2 
rj2 = (MHpm(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MHpm(gt3))+Abs(MFu(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFdFdcSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFdFdcSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFdFuHpmL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFdFuHpmR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFd Fu Hpm Propagator: Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd'
      End Do 



!-------------- 
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFdFdcSvL(gt1,i1,iIN) 
coup(2) = cplcFdFdcSvR(gt1,i1,iIN) 
coup(3) = cplcFdFuHpmL(i1,gt2,gt3) 
coup(4) = cplcFdFuHpmR(i1,gt2,gt3) 
coup(5) = cplcFdFdcSvL(gt1,i2,iIN) 
coup(6) = cplcFdFdcSvR(gt1,i2,iIN)  
coup(7) = cplcFdFuHpmL(i2,gt2,gt3) 
coup(8) = cplcFdFuHpmR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFd Fu Hpm Propagator: Fd,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fd,Fd'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=2,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocFdFuHpm 
 
 
Subroutine SvTocFeChaSv(iIN,MFe,MCha,MSv,cplcFeChaSvL,cplcFeChaSvR,cplcFeFecSvL,      & 
& cplcFeFecSvR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,2,3, Isum) ) 
Allocate( Contribution(3,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1, iIN-1
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (MCha(gt2)/MSv(iIN))**2 
rj2 = (MSv(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MSv(gt3))+Abs(MCha(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFeChaSvL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFeChaSvR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFe Cha Sv Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt1,i1,iIN) 
coup(2) = cplcFeFecSvR(gt1,i1,iIN) 
coup(3) = cplcFeChaSvL(i1,gt2,gt3) 
coup(4) = cplcFeChaSvR(i1,gt2,gt3) 
coup(5) = cplcFeFecSvL(gt1,i2,iIN) 
coup(6) = cplcFeFecSvR(gt1,i2,iIN)  
coup(7) = cplcFeChaSvL(i2,gt2,gt3) 
coup(8) = cplcFeChaSvR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFe Cha Sv Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1, iIN-1
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocFeChaSv 
 
 
Subroutine SvTocFeFvHpm(iIN,MFe,MHpm,MSv,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,      & 
& cplcFeFvHpmR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MHpm(2),MSv(3)

Complex(dp),Intent(in) :: cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,2, Isum) ) 
Allocate( Contribution(3,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=2,2
Isum = 0 
 
rk2 = (MFe(gt1)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MHpm(gt3)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MHpm(gt3))+Abs(0.)+Abs(MFe(gt1)))) Then 
!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSv(iIN) 
coup(2) = Conjg(cplcFeFecSvL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFeFecSvR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFeFvHpmR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFe Fv Hpm Propagator: Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe'
      End Do 



!-------------- 
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplcFeFecSvL(gt1,i1,iIN) 
coup(2) = cplcFeFecSvR(gt1,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt2,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt2,gt3) 
coup(5) = cplcFeFecSvL(gt1,i2,iIN) 
coup(6) = cplcFeFecSvR(gt1,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt2,gt3) 
coup(8) = cplcFeFvHpmR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cFe Fv Hpm Propagator: Fe,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fe'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=2,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocFeFvHpm 
 
 
Subroutine SvTocSdChaFu(iIN,MSd,MCha,MFu,MSv,cplSdcSdcSv,cplChaFucSdL,cplChaFucSdR,   & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MCha(2),MFu(3),MSv(3)

Complex(dp),Intent(in) :: cplSdcSdcSv(6,6,3),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(6,2,3, Isum) ) 
Allocate( Contribution(6,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSv(iIN))**2 
rm2 = (MFu(gt3)/MSv(iIN))**2 
rj2 = (MSd(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(MFu(gt3))+Abs(MCha(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSdcSdcSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplChaFucSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChaFucSdR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Cha Fu Propagator: Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd'
      End Do 



!-------------- 
!  Sd, Sd 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSdcSv(i1,gt1,iIN) 
coup(3) = Conjg(cplChaFucSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChaFucSdR(gt2,gt3,i1))  
coup(4) = cplSdcSdcSv(i2,gt1,iIN) 
coup(6) = Conjg(cplChaFucSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChaFucSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSd Cha Fu Propagator: Sd,Sd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Sd'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSdChaFu 
 
 
Subroutine SvTocSeChaFv(iIN,MSe,MCha,MSv,cplSecSecSv,cplFvChacSeL,cplFvChacSeR,       & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

Real(dp),Intent(inout)::g(:,:,:) 
Logical, Intent(in) :: check 
Integer, Intent(in) :: iIN 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Optional :: WriteContributions 
Integer :: i1,i2,gt1,gt2,gt3, Isum 
Real(dp) :: resR,  res1, res2, resD, m_in 
Complex(dp) :: resC, resS 
Real(dp), Allocatable :: gSum(:,:,:,:) 
Character(len=20), Allocatable :: Contribution(:,:,:,:) 
Real(dp)::smin,smax,smin2,smax2,rj2,rk2,rm2 
Real(dp)::r_out(3),r_outcrossed(3) 
Real(dp)::mass(3) 
Complex(dp)::coup(10) 
mass(1) = MSv(iIN) 
 
Isum = 36 
Allocate( gSum(6,2,3, Isum) ) 
Allocate( Contribution(6,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSv(iIN))**2 
rm2 = (0./MSv(iIN))**2 
rj2 = (MSe(gt1)/MSv(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSv(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSv(iIN)).gt.(Abs(0.)+Abs(MCha(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSv(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,gt1,iIN)) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Cha Fv Propagator: Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Se'
      End Do 



!-------------- 
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(i1,gt1,iIN) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(i2,gt1,iIN) 
coup(6) = Conjg(cplFvChacSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvChacSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Sv->cSe Cha Fv Propagator: Se,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Se'
        End Do 
      End Do 



Else 
gSum(gt1,gt2,gt3,:)= 0._dp  
End If 
       End Do 
     End Do 
   End Do 
!---------- 
!Summing 
!---------- 
g=0._dp 
    Do gt1=1,6
      Do gt2=1,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SvTocSeChaFv 
 
 
End Module Sv3Decays_MSSMTriLnV 
 
