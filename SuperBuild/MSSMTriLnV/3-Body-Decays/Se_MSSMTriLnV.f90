! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 10:36 on 25.4.2017   
! ----------------------------------------------------------------------  
 
 
Module Se3Decays_MSSMTriLnV 
 
Use Control 
Use Settings 
Use CouplingsForDecays_MSSMTriLnV 
Use ThreeBodyPhaseSpaceS 
 
Contains 
 
Subroutine SeThreeBodyDecay(n_in,MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,             & 
& MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,           & 
& MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,             & 
& ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,               & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,gSeAhChaFv,gSeAhChiFe,          & 
& gSeAhFdcFu,gSeAhFeFv,gSeChaChacSe,gSeSvChaChi,gSeChaChicSv,gSeFdChacSd,gSeChaFecHpm,   & 
& gSeChaFecSe,gSeChaHpmcFe,gSeSdChacFd,gSeSeChacCha,gSeSeChacFe,gSeSeChiChi,             & 
& gSecSuChiFd,gSehhChiFe,gSeSvChiFe,gSecSvChiFe,gSeHpmChiFv,gSeSeChiFv,gSeSdChicFu,      & 
& gSeFdFecSd,gSecSuFdGlu,gSehhFdcFu,gSeHpmFdcFd,gSeSeFdcFd,gSeFeFecSe,gSecSuFeFu,        & 
& gSeSvFeFv,gSecSvFeFv,gSeHpmFecCha,gSeSdFecFd,gSeSeFecFe,gSecFuFeSu,gSeFeFecHpm,        & 
& gSeHpmFecFe,gSeSeFecCha,gSehhChaFv,gSecSuFdFv,gSeSeFvFv,gSeFvSdcFu,gSeSvChaFv,         & 
& gSehhFeFv,gSeFvFvHpm,gSeSdGlucFu,gSeSeFucFu,gSeSvFdcFu,gSecFuChaSu,gSecSvFdcFu,        & 
& gSecFuFuHpm,gSecSuChaFu,gSecSvChaFv,epsI,deltaM,CheckRealStates,gT,gPartial,BR)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp),Intent(in) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

Complex(dp) :: cplAhSecSe(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcChaChaAhL(2,2,2),     & 
& cplcChaChaAhR(2,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVZL(2,2),     & 
& cplcChaChaVZR(2,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaFdcSuL(2,3,6),   & 
& cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),    & 
& cplcChaFvSeR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFdChiSdL(3,4,6),       & 
& cplcFdChiSdR(3,4,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdFdcSvL(3,3,3),         & 
& cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),          & 
& cplcFdFdSvR(3,3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFeSuL(3,3,6),               & 
& cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),            & 
& cplcFdGluSdR(3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFeChaSvL(3,2,3),         & 
& cplcFeChaSvR(3,2,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFdcSuL(3,3,6),       & 
& cplcFeFdcSuR(3,3,6),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),         & 
& cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFvHpmL(3,3,2),              & 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFuChiSuL(3,4,6),         & 
& cplcFuChiSuR(3,4,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),     & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcFuFuAhL(3,3,2),          & 
& cplcFuFuAhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVZL(3,3),             & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplChaFucSdL(2,3,6),              & 
& cplChaFucSdR(2,3,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),   & 
& cplChiChacVWmR(4,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),          & 
& cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),         & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6), & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),              & 
& cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplSecSeVZ(6,6),cplSeSvcSe(6,3,6),               & 
& cplSvcSeVWm(3,6)

Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2,vd,vu

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(inout) :: gSeAhChaFv(6,2,2,3),gSeAhChiFe(6,2,4,3),gSeAhFdcFu(6,2,3,3),gSeAhFeFv(6,2,3,3),       & 
& gSeChaChacSe(6,2,2,6),gSeSvChaChi(6,3,2,4),gSeChaChicSv(6,2,4,3),gSeFdChacSd(6,3,2,6), & 
& gSeChaFecHpm(6,2,3,2),gSeChaFecSe(6,2,3,6),gSeChaHpmcFe(6,2,2,3),gSeSdChacFd(6,6,2,3), & 
& gSeSeChacCha(6,6,2,2),gSeSeChacFe(6,6,2,3),gSeSeChiChi(6,6,4,4),gSecSuChiFd(6,6,4,3),  & 
& gSehhChiFe(6,2,4,3),gSeSvChiFe(6,3,4,3),gSecSvChiFe(6,3,4,3),gSeHpmChiFv(6,2,4,3),     & 
& gSeSeChiFv(6,6,4,3),gSeSdChicFu(6,6,4,3),gSeFdFecSd(6,3,3,6),gSecSuFdGlu(6,6,3,1),     & 
& gSehhFdcFu(6,2,3,3),gSeHpmFdcFd(6,2,3,3),gSeSeFdcFd(6,6,3,3),gSeFeFecSe(6,3,3,6),      & 
& gSecSuFeFu(6,6,3,3),gSeSvFeFv(6,3,3,3),gSecSvFeFv(6,3,3,3),gSeHpmFecCha(6,2,3,2),      & 
& gSeSdFecFd(6,6,3,3),gSeSeFecFe(6,6,3,3),gSecFuFeSu(6,3,3,6),gSeFeFecHpm(6,3,3,2),      & 
& gSeHpmFecFe(6,2,3,3),gSeSeFecCha(6,6,3,2),gSehhChaFv(6,2,2,3),gSecSuFdFv(6,6,3,3),     & 
& gSeSeFvFv(6,6,3,3),gSeFvSdcFu(6,3,6,3),gSeSvChaFv(6,3,2,3),gSehhFeFv(6,2,3,3),         & 
& gSeFvFvHpm(6,3,3,2),gSeSdGlucFu(6,6,1,3),gSeSeFucFu(6,6,3,3),gSeSvFdcFu(6,3,3,3),      & 
& gSecFuChaSu(6,3,2,6),gSecSvFdcFu(6,3,3,3),gSecFuFuHpm(6,3,3,2),gSecSuChaFu(6,6,2,3),   & 
& gSecSvChaFv(6,3,2,3)

Real(dp) :: gSeAhChaFvi(2,2,3),gSeAhChiFei(2,4,3),gSeAhFdcFui(2,3,3),gSeAhFeFvi(2,3,3),           & 
& gSeChaChacSei(2,2,6),gSeSvChaChii(3,2,4),gSeChaChicSvi(2,4,3),gSeFdChacSdi(3,2,6),     & 
& gSeChaFecHpmi(2,3,2),gSeChaFecSei(2,3,6),gSeChaHpmcFei(2,2,3),gSeSdChacFdi(6,2,3),     & 
& gSeSeChacChai(6,2,2),gSeSeChacFei(6,2,3),gSeSeChiChii(6,4,4),gSecSuChiFdi(6,4,3),      & 
& gSehhChiFei(2,4,3),gSeSvChiFei(3,4,3),gSecSvChiFei(3,4,3),gSeHpmChiFvi(2,4,3),         & 
& gSeSeChiFvi(6,4,3),gSeSdChicFui(6,4,3),gSeFdFecSdi(3,3,6),gSecSuFdGlui(6,3,1),         & 
& gSehhFdcFui(2,3,3),gSeHpmFdcFdi(2,3,3),gSeSeFdcFdi(6,3,3),gSeFeFecSei(3,3,6),          & 
& gSecSuFeFui(6,3,3),gSeSvFeFvi(3,3,3),gSecSvFeFvi(3,3,3),gSeHpmFecChai(2,3,2),          & 
& gSeSdFecFdi(6,3,3),gSeSeFecFei(6,3,3),gSecFuFeSui(3,3,6),gSeFeFecHpmi(3,3,2),          & 
& gSeHpmFecFei(2,3,3),gSeSeFecChai(6,3,2),gSehhChaFvi(2,2,3),gSecSuFdFvi(6,3,3),         & 
& gSeSeFvFvi(6,3,3),gSeFvSdcFui(3,6,3),gSeSvChaFvi(3,2,3),gSehhFeFvi(2,3,3),             & 
& gSeFvFvHpmi(3,3,2),gSeSdGlucFui(6,1,3),gSeSeFucFui(6,3,3),gSeSvFdcFui(3,3,3),          & 
& gSecFuChaSui(3,2,6),gSecSvFdcFui(3,3,3),gSecFuFuHpmi(3,3,2),gSecSuChaFui(6,2,3),       & 
& gSecSvChaFvi(3,2,3)

Real(dp), Intent(inout), Optional :: BR(:,:), gPartial(:,:) 
Real(dp), Intent(inout) :: gT(:) 
Integer, Intent(in) :: n_in 
Real(dp), Intent(in) :: epsI, deltaM 
Logical, Intent(in) ::  CheckRealStates 
Integer :: i_start, i_end, i_run, n_out, n_length, gt1, gt2, gt3, i1 
Logical :: check 
Iname = Iname +1 
NameOfUnit(Iname) = 'SeThreeBodyDecay' 
 

 
If (CheckRealStates) Then 
Else 
End If 
 
check=CheckRealStates 

 
If (n_in.Lt.0) Then 
 i_start = 1 
 i_end = 6 
 Else If ( (n_in.Ge.1).And.(n_in.Le. 6) ) Then 
 i_start = n_in 
 i_end = n_in 
Else 
 If (ErrorLevel.Ge.-1) Then 
   Write (ErrCan, *) 'Problem in subroutine'//NameOfUnit(Iname) 
   Write (ErrCan, *) 'Value of n_in out of range, (n_in,6) = ',n_in,6 
 End If 
 
 If (ErrorLevel.Gt.0) Call TerminateProgram 
 
 If (Present(BR)) BR = 0._dp 
 Iname = Iname - 1 
 Return 
End If 
 
Do i_run = i_start, i_end 
 
Call CouplingsFor_Se_decays_3B(MSe(i_run),i_run,MAh,MAh2,MCha,MCha2,MChi,             & 
& MChi2,MFd,MFd2,MFe,MFe2,MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,              & 
& MSe,MSe2,MSu,MSu2,MSv,MSv2,MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,            & 
& ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,ZUR,ZV,ZW,ZZ,alphaH,betaH,g1,g2,g3,Yd,Ye,L1,L2,             & 
& Yu,Mu,Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,cplAhSecSe,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,   & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaFdcSuL,               & 
& cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcFdChaSuL,      & 
& cplcFdChaSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,           & 
& cplcFdFdcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,              & 
& cplcFdFdVZR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplcFecFuSdL,            & 
& cplcFecFuSdR,cplcFeChaSvL,cplcFeChaSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,         & 
& cplcFeFdcSuR,cplcFeFeAhL,cplcFeFeAhR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFvHpmL,              & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFuFuAhL,       & 
& cplcFuFuAhR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,              & 
& cplcFuGluSuR,cplChaFucSdL,cplChaFucSdR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,   & 
& cplChiChacVWmR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvcSvL,cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplFeFucSdL,            & 
& cplFeFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,            & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,             & 
& cplFvFvVZR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,cplSecSeVZ,cplSeSvcSe,cplSvcSeVWm,deltaM)


 
gSeAhChaFvi = 0._dp 
Call SeToAhChaFv(i_run,MAh,MCha,MSe,cplAhSecSe,cplcChaChaAhL,cplcChaChaAhR,           & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,gSeAhChaFvi)

gSeAhChaFv(i_run,:,:,:) = gSeAhChaFvi 
gT(i_run) = gT(i_run) + Sum(gSeAhChaFvi) 
 
gSeAhChiFei = 0._dp 
Call SeToAhChiFe(i_run,MAh,MChi,MFe,MSe,cplAhSecSe,cplcFeFeAhL,cplcFeFeAhR,           & 
& cplChiChiAhL,cplChiChiAhR,cplChiFecSeL,cplChiFecSeR,deltaM,epsI,check,gSeAhChiFei)

gSeAhChiFe(i_run,:,:,:) = gSeAhChiFei 
gT(i_run) = gT(i_run) + Sum(gSeAhChiFei) 
 
gSeAhFdcFui = 0._dp 
Call SeToAhFdcFu(i_run,MAh,MFd,MFu,MSe,cplAhSecSe,cplcFdFdAhL,cplcFdFdAhR,            & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuAhL,cplcFuFuAhR,deltaM,epsI,check,gSeAhFdcFui)

gSeAhFdcFu(i_run,:,:,:) = gSeAhFdcFui 
gT(i_run) = gT(i_run) + Sum(gSeAhFdcFui) 
 
gSeAhFeFvi = 0._dp 
Call SeToAhFeFv(i_run,MAh,MFe,MSe,cplAhSecSe,cplcFeFeAhL,cplcFeFeAhR,cplFvFecSeL,     & 
& cplFvFecSeR,deltaM,epsI,check,gSeAhFeFvi)

gSeAhFeFv(i_run,:,:,:) = gSeAhFeFvi 
gT(i_run) = gT(i_run) + Sum(gSeAhFeFvi) 
 
gSeChaChacSei = 0._dp 
Call SeToChaChacSe(i_run,MCha,MSe,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,              & 
& check,gSeChaChacSei)

gSeChaChacSe(i_run,:,:,:) = gSeChaChacSei 
gT(i_run) = gT(i_run) + Sum(gSeChaChacSei) 
 
gSeSvChaChii = 0._dp 
Call SeToSvChaChi(i_run,MSv,MCha,MChi,MVWm,MHpm,MFe,MSe,cplHpmSvcSe,cplSvcSeVWm,      & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR, & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplFvChacSeL,cplFvChacSeR,           & 
& deltaM,epsI,check,gSeSvChaChii)

gSeSvChaChi(i_run,:,:,:) = gSeSvChaChii 
gT(i_run) = gT(i_run) + Sum(gSeSvChaChii) 
 
gSeChaChicSvi = 0._dp 
Call SeToChaChicSv(i_run,MCha,MChi,MSv,MSe,cplChiFvcSvL,cplChiFvcSvR,cplFvChacSeL,    & 
& cplFvChacSeR,deltaM,epsI,check,gSeChaChicSvi)

gSeChaChicSv(i_run,:,:,:) = gSeChaChicSvi 
gT(i_run) = gT(i_run) + Sum(gSeChaChicSvi) 
 
gSeFdChacSdi = 0._dp 
Call SeToFdChacSd(i_run,MFd,MCha,MSd,MFu,MSe,cplcFuFdcSeL,cplcFuFdcSeR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& deltaM,epsI,check,gSeFdChacSdi)

gSeFdChacSd(i_run,:,:,:) = gSeFdChacSdi 
gT(i_run) = gT(i_run) + Sum(gSeFdChacSdi) 
 
gSeChaFecHpmi = 0._dp 
Call SeToChaFecHpm(i_run,MCha,MFe,MHpm,MChi,MSe,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiFecSeL,cplChiFecSeR,cplFvChacSeL,cplFvChacSeR,cplFvFecHpmL,cplFvFecHpmR,         & 
& deltaM,epsI,check,gSeChaFecHpmi)

gSeChaFecHpm(i_run,:,:,:) = gSeChaFecHpmi 
gT(i_run) = gT(i_run) + Sum(gSeChaFecHpmi) 
 
gSeChaFecSei = 0._dp 
Call SeToChaFecSe(i_run,MCha,MFe,MSe,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,           & 
& cplFvFecSeR,deltaM,epsI,check,gSeChaFecSei)

gSeChaFecSe(i_run,:,:,:) = gSeChaFecSei 
gT(i_run) = gT(i_run) + Sum(gSeChaFecSei) 
 
gSeChaHpmcFei = 0._dp 
Call SeToChaHpmcFe(i_run,MCha,MHpm,MFe,MSe,cplcFeFvHpmL,cplcFeFvHpmR,cplFvChacSeL,    & 
& cplFvChacSeR,deltaM,epsI,check,gSeChaHpmcFei)

gSeChaHpmcFe(i_run,:,:,:) = gSeChaHpmcFei 
gT(i_run) = gT(i_run) + Sum(gSeChaHpmcFei) 
 
gSeSdChacFdi = 0._dp 
Call SeToSdChacFd(i_run,MSd,MCha,MFd,MSu,MSe,cplSdcSecSu,cplcFdChaSuL,cplcFdChaSuR,   & 
& cplcFdFvSdL,cplcFdFvSdR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,gSeSdChacFdi)

gSeSdChacFd(i_run,:,:,:) = gSeSdChacFdi 
gT(i_run) = gT(i_run) + Sum(gSeSdChacFdi) 
 
gSeSeChacChai = 0._dp 
Call SeToSeChacCha(i_run,MSe,MCha,MVZ,MAh,Mhh,cplAhSecSe,cplhhSecSe,cplSecSeVZ,       & 
& cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplcChaFvSeL,cplcChaFvSeR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,gSeSeChacChai)

gSeSeChacCha(i_run,:,:,:) = gSeSeChacChai 
gT(i_run) = gT(i_run) + Sum(gSeSeChacChai) 
 
gSeSeChacFei = 0._dp 
Call SeToSeChacFe(i_run,MSe,MCha,MFe,MSv,cplSecSecSv,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcFeFvSeL,cplcFeFvSeR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,gSeSeChacFei)

gSeSeChacFe(i_run,:,:,:) = gSeSeChacFei 
gT(i_run) = gT(i_run) + Sum(gSeSeChacFei) 
 
gSeSeChiChii = 0._dp 
Call SeToSeChiChi(i_run,MSe,MChi,MVZ,MAh,Mhh,MFe,cplAhSecSe,cplhhSecSe,               & 
& cplSecSeVZ,cplcFeChiSeL,cplcFeChiSeR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,           & 
& cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,cplChiFecSeR,deltaM,               & 
& epsI,check,gSeSeChiChii)

gSeSeChiChi(i_run,:,:,:) = gSeSeChiChii 
gT(i_run) = gT(i_run) + Sum(gSeSeChiChii) 
 
gSecSuChiFdi = 0._dp 
Call SeTocSuChiFd(i_run,MSu,MChi,MFd,MSd,MFe,MFu,MSe,cplSdcSecSu,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,         & 
& cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,deltaM,epsI,check,gSecSuChiFdi)

gSecSuChiFd(i_run,:,:,:) = gSecSuChiFdi 
gT(i_run) = gT(i_run) + Sum(gSecSuChiFdi) 
 
gSehhChiFei = 0._dp 
Call SeTohhChiFe(i_run,Mhh,MChi,MFe,MSe,cplhhSecSe,cplcFeFehhL,cplcFeFehhR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFecSeL,cplChiFecSeR,deltaM,epsI,check,gSehhChiFei)

gSehhChiFe(i_run,:,:,:) = gSehhChiFei 
gT(i_run) = gT(i_run) + Sum(gSehhChiFei) 
 
gSeSvChiFei = 0._dp 
Call SeToSvChiFe(i_run,MSv,MChi,MFe,MSe,cplSeSvcSe,cplcFeFeSvL,cplcFeFeSvR,           & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplFvFecSeL,cplFvFecSeR,             & 
& deltaM,epsI,check,gSeSvChiFei)

gSeSvChiFe(i_run,:,:,:) = gSeSvChiFei 
gT(i_run) = gT(i_run) + Sum(gSeSvChiFei) 
 
gSecSvChiFei = 0._dp 
Call SeTocSvChiFe(i_run,MSv,MChi,MFe,MSe,cplSecSecSv,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFecSeL,cplFvFecSeR,           & 
& deltaM,epsI,check,gSecSvChiFei)

gSecSvChiFe(i_run,:,:,:) = gSecSvChiFei 
gT(i_run) = gT(i_run) + Sum(gSecSvChiFei) 
 
gSeHpmChiFvi = 0._dp 
Call SeToHpmChiFv(i_run,MHpm,MChi,MSv,MFe,MCha,MSe,cplHpmSvcSe,cplcChaChiHpmL,        & 
& cplcChaChiHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,       & 
& cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,gSeHpmChiFvi)

gSeHpmChiFv(i_run,:,:,:) = gSeHpmChiFvi 
gT(i_run) = gT(i_run) + Sum(gSeHpmChiFvi) 
 
gSeSeChiFvi = 0._dp 
Call SeToSeChiFv(i_run,MSe,MChi,MSv,MFe,cplSecSecSv,cplSeSvcSe,cplcFeChiSeL,          & 
& cplcFeChiSeR,cplcFeFvSeL,cplcFeFvSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,              & 
& check,gSeSeChiFvi)

gSeSeChiFv(i_run,:,:,:) = gSeSeChiFvi 
gT(i_run) = gT(i_run) + Sum(gSeSeChiFvi) 
 
gSeSdChicFui = 0._dp 
Call SeToSdChicFu(i_run,MSd,MChi,MFu,MSu,MFe,MFd,MSe,cplSdcSecSu,cplcFdChiSdL,        & 
& cplcFdChiSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,         & 
& cplcFuFdcSeR,cplChiFecSeL,cplChiFecSeR,deltaM,epsI,check,gSeSdChicFui)

gSeSdChicFu(i_run,:,:,:) = gSeSdChicFui 
gT(i_run) = gT(i_run) + Sum(gSeSdChicFui) 
 
gSeFdFecSdi = 0._dp 
Call SeToFdFecSd(i_run,MFd,MFe,MSd,MFu,MChi,MSe,cplcFuFdcSeL,cplcFuFdcSeR,            & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeFdFecSdi)

gSeFdFecSd(i_run,:,:,:) = gSeFdFecSdi 
gT(i_run) = gT(i_run) + Sum(gSeFdFecSdi) 
 
gSecSuFdGlui = 0._dp 
Call SeTocSuFdGlu(i_run,MSu,MFd,MGlu,MSd,MFu,MSe,cplSdcSecSu,cplcFuFdcSeL,            & 
& cplcFuFdcSeR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,deltaM,               & 
& epsI,check,gSecSuFdGlui)

gSecSuFdGlu(i_run,:,:,:) = gSecSuFdGlui 
gT(i_run) = gT(i_run) + Sum(gSecSuFdGlui) 
 
gSehhFdcFui = 0._dp 
Call SeTohhFdcFu(i_run,Mhh,MFd,MFu,MSe,cplhhSecSe,cplcFdFdhhL,cplcFdFdhhR,            & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuhhL,cplcFuFuhhR,deltaM,epsI,check,gSehhFdcFui)

gSehhFdcFu(i_run,:,:,:) = gSehhFdcFui 
gT(i_run) = gT(i_run) + Sum(gSehhFdcFui) 
 
gSeHpmFdcFdi = 0._dp 
Call SeToHpmFdcFd(i_run,MHpm,MFd,MSv,MFu,MSe,cplHpmSvcSe,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,gSeHpmFdcFdi)

gSeHpmFdcFd(i_run,:,:,:) = gSeHpmFdcFdi 
gT(i_run) = gT(i_run) + Sum(gSeHpmFdcFdi) 
 
gSeSeFdcFdi = 0._dp 
Call SeToSeFdcFd(i_run,MSe,MFd,MVZ,MSv,MAh,Mhh,MFu,cplAhSecSe,cplhhSecSe,             & 
& cplSecSecSv,cplSecSeVZ,cplSeSvcSe,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,gSeSeFdcFdi)

gSeSeFdcFd(i_run,:,:,:) = gSeSeFdcFdi 
gT(i_run) = gT(i_run) + Sum(gSeSeFdcFdi) 
 
gSeFeFecSei = 0._dp 
Call SeToFeFecSe(i_run,MFe,MSe,MChi,cplChiFecSeL,cplChiFecSeR,cplFvFecSeL,            & 
& cplFvFecSeR,deltaM,epsI,check,gSeFeFecSei)

gSeFeFecSe(i_run,:,:,:) = gSeFeFecSei 
gT(i_run) = gT(i_run) + Sum(gSeFeFecSei) 
 
gSecSuFeFui = 0._dp 
Call SeTocSuFeFu(i_run,MSu,MFe,MFu,MSd,MChi,MSe,cplSdcSecSu,cplChiFecSeL,             & 
& cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplFeFucSdL,cplFeFucSdR,deltaM,epsI,            & 
& check,gSecSuFeFui)

gSecSuFeFu(i_run,:,:,:) = gSecSuFeFui 
gT(i_run) = gT(i_run) + Sum(gSecSuFeFui) 
 
gSeSvFeFvi = 0._dp 
Call SeToSvFeFv(i_run,MSv,MFe,MVWm,MHpm,MSe,MChi,cplHpmSvcSe,cplSeSvcSe,              & 
& cplSvcSeVWm,cplcFeFeSvL,cplcFeFeSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,             & 
& cplChiFvSvR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,deltaM,epsI,check,gSeSvFeFvi)

gSeSvFeFv(i_run,:,:,:) = gSeSvFeFvi 
gT(i_run) = gT(i_run) + Sum(gSeSvFeFvi) 
 
gSecSvFeFvi = 0._dp 
Call SeTocSvFeFv(i_run,MSv,MFe,MSe,MCha,MChi,cplSecSecSv,cplcChaFecSvL,               & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,        & 
& cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,            & 
& check,gSecSvFeFvi)

gSecSvFeFv(i_run,:,:,:) = gSecSvFeFvi 
gT(i_run) = gT(i_run) + Sum(gSecSvFeFvi) 
 
gSeHpmFecChai = 0._dp 
Call SeToHpmFecCha(i_run,MHpm,MFe,MCha,MSv,MChi,MSe,cplHpmSvcSe,cplcChaChiHpmL,       & 
& cplcChaChiHpmR,cplcChaFecSvL,cplcChaFecSvR,cplChiFecSeL,cplChiFecSeR,deltaM,           & 
& epsI,check,gSeHpmFecChai)

gSeHpmFecCha(i_run,:,:,:) = gSeHpmFecChai 
gT(i_run) = gT(i_run) + Sum(gSeHpmFecChai) 
 
gSeSdFecFdi = 0._dp 
Call SeToSdFecFd(i_run,MSd,MFe,MFd,MSu,MChi,MSe,cplSdcSecSu,cplcFdChiSdL,             & 
& cplcFdChiSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFvSdL,cplcFdFvSdR,cplChiFecSeL,             & 
& cplChiFecSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeSdFecFdi)

gSeSdFecFd(i_run,:,:,:) = gSeSdFecFdi 
gT(i_run) = gT(i_run) + Sum(gSeSdFecFdi) 
 
gSeSeFecFei = 0._dp 
Call SeToSeFecFe(i_run,MSe,MFe,MVZ,MSv,MAh,Mhh,MChi,cplAhSecSe,cplhhSecSe,            & 
& cplSecSecSv,cplSecSeVZ,cplSeSvcSe,cplcFeChiSeL,cplcFeChiSeR,cplcFeFeAhL,               & 
& cplcFeFeAhR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFvSeL,cplcFeFvSeR,cplChiFecSeL,              & 
& cplChiFecSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeSeFecFei)

gSeSeFecFe(i_run,:,:,:) = gSeSeFecFei 
gT(i_run) = gT(i_run) + Sum(gSeSeFecFei) 
 
gSecFuFeSui = 0._dp 
Call SeTocFuFeSu(i_run,MFu,MFe,MSu,MFd,MChi,MSe,cplcFdFeSuL,cplcFdFeSuR,              & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplChiFecSeL,cplChiFecSeR,         & 
& deltaM,epsI,check,gSecFuFeSui)

gSecFuFeSu(i_run,:,:,:) = gSecFuFeSui 
gT(i_run) = gT(i_run) + Sum(gSecFuFeSui) 
 
gSeFeFecHpmi = 0._dp 
Call SeToFeFecHpm(i_run,MFe,MHpm,MSe,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,           & 
& cplFvFecSeR,deltaM,epsI,check,gSeFeFecHpmi)

gSeFeFecHpm(i_run,:,:,:) = gSeFeFecHpmi 
gT(i_run) = gT(i_run) + Sum(gSeFeFecHpmi) 
 
gSeHpmFecFei = 0._dp 
Call SeToHpmFecFe(i_run,MHpm,MFe,MSv,MSe,cplHpmSvcSe,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeHpmFecFei)

gSeHpmFecFe(i_run,:,:,:) = gSeHpmFecFei 
gT(i_run) = gT(i_run) + Sum(gSeHpmFecFei) 
 
gSeSeFecChai = 0._dp 
Call SeToSeFecCha(i_run,MSe,MFe,MCha,MSv,cplSeSvcSe,cplcChaFecSvL,cplcChaFecSvR,      & 
& cplcChaFvSeL,cplcChaFvSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeSeFecChai)

gSeSeFecCha(i_run,:,:,:) = gSeSeFecChai 
gT(i_run) = gT(i_run) + Sum(gSeSeFecChai) 
 
gSehhChaFvi = 0._dp 
Call SeTohhChaFv(i_run,Mhh,MCha,MSe,cplhhSecSe,cplcChaChahhL,cplcChaChahhR,           & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,gSehhChaFvi)

gSehhChaFv(i_run,:,:,:) = gSehhChaFvi 
gT(i_run) = gT(i_run) + Sum(gSehhChaFvi) 
 
gSecSuFdFvi = 0._dp 
Call SeTocSuFdFv(i_run,MSu,MFd,MSd,MCha,MFe,MSe,cplSdcSecSu,cplcChaFdcSuL,            & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSecSuFdFvi)

gSecSuFdFv(i_run,:,:,:) = gSecSuFdFvi 
gT(i_run) = gT(i_run) + Sum(gSecSuFdFvi) 
 
gSeSeFvFvi = 0._dp 
Call SeToSeFvFv(i_run,MSe,MVZ,MCha,MFe,cplSecSeVZ,cplcChaFvSeL,cplcChaFvSeR,          & 
& cplcFeFvSeL,cplcFeFvSeR,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFvVZL,cplFvFvVZR,deltaM,epsI,check,gSeSeFvFvi)

gSeSeFvFv(i_run,:,:,:) = gSeSeFvFvi 
gT(i_run) = gT(i_run) + Sum(gSeSeFvFvi) 
 
gSeFvSdcFui = 0._dp 
Call SeToFvSdcFu(i_run,MSd,MFu,MCha,MFe,MFd,MSe,cplcChacFuSdL,cplcChacFuSdR,          & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeFvSdcFui)

gSeFvSdcFu(i_run,:,:,:) = gSeFvSdcFui 
gT(i_run) = gT(i_run) + Sum(gSeFvSdcFui) 
 
gSeSvChaFvi = 0._dp 
Call SeToSvChaFv(i_run,MSv,MCha,MSe,MFe,cplSeSvcSe,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,gSeSvChaFvi)

gSeSvChaFv(i_run,:,:,:) = gSeSvChaFvi 
gT(i_run) = gT(i_run) + Sum(gSeSvChaFvi) 
 
gSehhFeFvi = 0._dp 
Call SeTohhFeFv(i_run,Mhh,MFe,MSe,cplhhSecSe,cplcFeFehhL,cplcFeFehhR,cplFvFecSeL,     & 
& cplFvFecSeR,deltaM,epsI,check,gSehhFeFvi)

gSehhFeFv(i_run,:,:,:) = gSehhFeFvi 
gT(i_run) = gT(i_run) + Sum(gSehhFeFvi) 
 
gSeFvFvHpmi = 0._dp 
Call SeToFvFvHpm(i_run,MHpm,MFe,MSe,cplcFeFvHpmL,cplcFeFvHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,deltaM,epsI,check,gSeFvFvHpmi)

gSeFvFvHpm(i_run,:,:,:) = gSeFvFvHpmi 
gT(i_run) = gT(i_run) + Sum(gSeFvFvHpmi) 
 
gSeSdGlucFui = 0._dp 
Call SeToSdGlucFu(i_run,MSd,MGlu,MFu,MSu,MFd,MSe,cplSdcSecSu,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuGluSuL,cplcFuGluSuR,deltaM,               & 
& epsI,check,gSeSdGlucFui)

gSeSdGlucFu(i_run,:,:,:) = gSeSdGlucFui 
gT(i_run) = gT(i_run) + Sum(gSeSdGlucFui) 
 
gSeSeFucFui = 0._dp 
Call SeToSeFucFu(i_run,MSe,MFu,MVZ,MAh,Mhh,MFd,cplAhSecSe,cplhhSecSe,cplSecSeVZ,      & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuAhL,cplcFuFuAhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,deltaM,epsI,check,gSeSeFucFui)

gSeSeFucFu(i_run,:,:,:) = gSeSeFucFui 
gT(i_run) = gT(i_run) + Sum(gSeSeFucFui) 
 
gSeSvFdcFui = 0._dp 
Call SeToSvFdcFu(i_run,MSv,MFd,MFu,MVWm,MHpm,MSe,cplHpmSvcSe,cplSeSvcSe,              & 
& cplSvcSeVWm,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,          & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,deltaM,epsI,check,gSeSvFdcFui)

gSeSvFdcFu(i_run,:,:,:) = gSeSvFdcFui 
gT(i_run) = gT(i_run) + Sum(gSeSvFdcFui) 
 
gSecFuChaSui = 0._dp 
Call SeTocFuChaSu(i_run,MFu,MCha,MSu,MFd,MSe,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,gSecFuChaSui)

gSecFuChaSu(i_run,:,:,:) = gSecFuChaSui 
gT(i_run) = gT(i_run) + Sum(gSecFuChaSui) 
 
gSecSvFdcFui = 0._dp 
Call SeTocSvFdcFu(i_run,MSv,MFd,MFu,MSe,cplSecSecSv,cplcFdFdcSvL,cplcFdFdcSvR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,gSecSvFdcFui)

gSecSvFdcFu(i_run,:,:,:) = gSecSvFdcFui 
gT(i_run) = gT(i_run) + Sum(gSecSvFdcFui) 
 
gSecFuFuHpmi = 0._dp 
Call SeTocFuFuHpm(i_run,MFu,MHpm,MFd,MSe,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFdcSeL,      & 
& cplcFuFdcSeR,deltaM,epsI,check,gSecFuFuHpmi)

gSecFuFuHpm(i_run,:,:,:) = gSecFuFuHpmi 
gT(i_run) = gT(i_run) + Sum(gSecFuFuHpmi) 
 
gSecSuChaFui = 0._dp 
Call SeTocSuChaFu(i_run,MSu,MCha,MFu,MSd,MSe,cplSdcSecSu,cplChaFucSdL,cplChaFucSdR,   & 
& deltaM,epsI,check,gSecSuChaFui)

gSecSuChaFu(i_run,:,:,:) = gSecSuChaFui 
gT(i_run) = gT(i_run) + Sum(gSecSuChaFui) 
 
gSecSvChaFvi = 0._dp 
Call SeTocSvChaFv(i_run,MSv,MCha,MSe,cplSecSecSv,cplFvChacSeL,cplFvChacSeR,           & 
& deltaM,epsI,check,gSecSvChaFvi)

gSecSvChaFv(i_run,:,:,:) = gSecSvChaFvi 
gT(i_run) = gT(i_run) + Sum(gSecSvChaFvi) 
 
End Do 
 

If (Present(gPartial)) Then
Do i1 = i_start, i_end 
 
n_length=1
Do gt1=2,2
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSeAhChaFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSeAhChiFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeAhFdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeAhFeFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=gt1,2
    Do gt3=1,6
gPartial(i1,n_length)= gSeChaChacSe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,4
gPartial(i1,n_length)= gSeSvChaChi(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSeChaChicSv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
gPartial(i1,n_length)= gSeFdChacSd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSeChaFecHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,6
gPartial(i1,n_length)= gSeChaFecSe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=2,2
    Do gt3=1,3
gPartial(i1,n_length)= gSeChaHpmcFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSeSdChacFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
gPartial(i1,n_length)= gSeSeChacCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSeSeChacFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=gt2,4
gPartial(i1,n_length)= gSeSeChiChi(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSecSuChiFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSehhChiFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSeSvChiFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSecSvChiFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSeHpmChiFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSeSeChiFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,4
    Do gt3=1,3
gPartial(i1,n_length)= gSeSdChicFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
gPartial(i1,n_length)= gSeFdFecSd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,1
gPartial(i1,n_length)= gSecSuFdGlu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSehhFdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeHpmFdcFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeSeFdcFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=gt1,3
    Do gt3=1,6
gPartial(i1,n_length)= gSeFeFecSe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSecSuFeFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeSvFeFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSecSvFeFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,2
gPartial(i1,n_length)= gSeHpmFecCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeSdFecFd(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeSeFecFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
gPartial(i1,n_length)= gSecFuFeSu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=gt1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSeFeFecHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=2,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeHpmFecFe(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
gPartial(i1,n_length)= gSeSeFecCha(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSehhChaFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSecSuFdFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=gt2,3
gPartial(i1,n_length)= gSeSeFvFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,3
gPartial(i1,n_length)= gSeFvSdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSeSvChaFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSehhFeFv(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=gt1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSeFvFvHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,1
    Do gt3=1,3
gPartial(i1,n_length)= gSeSdGlucFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeSeFucFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSeSvFdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
gPartial(i1,n_length)= gSecFuChaSu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
gPartial(i1,n_length)= gSecSvFdcFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=2,2
gPartial(i1,n_length)= gSecFuFuHpm(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSecSuChaFu(i1,gt1,gt2,gt3)
n_length=n_length+1
     End Do 
  End Do 
End Do 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
gPartial(i1,n_length)= gSecSvChaFv(i1,gt1,gt2,gt3)
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
 
End Subroutine SeThreeBodyDecay
 
 
Subroutine SeToAhChaFv(iIN,MAh,MCha,MSe,cplAhSecSe,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MCha(2),MSe(6)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplFvChacSeL(3,2,6),      & 
& cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 64 
Allocate( gSum(2,2,3, Isum) ) 
Allocate( Contribution(2,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MAh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MCha(gt2))+Abs(MAh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Ah Cha Fv Propagator: Se" 
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
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcChaChaAhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcChaChaAhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Cha Fv Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
coup(1) = cplAhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplFvChacSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvChacSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Cha Fv Propagator: Se,Se" 
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
!  Se, Cha 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i2,iIN) 
coup(2) = cplFvChacSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcChaChaAhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcChaChaAhR(i2,gt2,gt1))  
coup(5) = cplAhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Cha Fv Propagator: Se,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaChaAhL(i1,gt2,gt1) 
coup(4) = cplcChaChaAhR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaChaAhL(i2,gt2,gt1) 
coup(8) = cplcChaChaAhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Cha Fv Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToAhChaFv 
 
 
Subroutine SeToAhChiFe(iIN,MAh,MChi,MFe,MSe,cplAhSecSe,cplcFeFeAhL,cplcFeFeAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplChiFecSeL,cplChiFecSeR,deltaM,epsI,check,g,               & 
& WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MChi(4),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplChiChiAhL(4,4,2),          & 
& cplChiChiAhR(4,4,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 169 
Allocate( gSum(2,4,3, Isum) ) 
Allocate( Contribution(2,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MAh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(MAh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Ah Chi Fe Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFeAhL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFeAhR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiChiAhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplChiChiAhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Chi" 
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
coup(1) = cplAhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
coup(4) = cplAhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplChiFecSeL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFecSeR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFeAhL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFeAhR(i2,gt3,gt1))  
coup(5) = cplAhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplChiFecSeL(i2,gt3,iIN) 
coup(2) = cplChiFecSeR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiChiAhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiChiAhR(i2,gt2,gt1))  
coup(5) = cplAhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Se,Chi" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFeAhL(i1,gt3,gt1) 
coup(4) = cplcFeFeAhR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFeAhL(i2,gt3,gt1) 
coup(8) = cplcFeFeAhR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Fe,Fe" 
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFeAhL(i1,gt3,gt1) 
coup(4) = cplcFeFeAhR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(i2,gt3,iIN) 
coup(6) = cplChiFecSeR(i2,gt3,iIN)  
coup(7) = cplChiChiAhL(i2,gt2,gt1) 
coup(8) = cplChiChiAhR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Fe,Chi" 
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
coup(1) = cplChiFecSeL(i1,gt3,iIN) 
coup(2) = cplChiFecSeR(i1,gt3,iIN) 
coup(3) = cplChiChiAhL(i1,gt2,gt1) 
coup(4) = cplChiChiAhR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(i2,gt3,iIN) 
coup(6) = cplChiFecSeR(i2,gt3,iIN)  
coup(7) = cplChiChiAhL(i2,gt2,gt1) 
coup(8) = cplChiChiAhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Chi Fe Propagator: Chi,Chi" 
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
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:169))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToAhChiFe 
 
 
Subroutine SeToAhFdcFu(iIN,MAh,MFd,MFu,MSe,cplAhSecSe,cplcFdFdAhL,cplcFdFdAhR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuAhL,cplcFuFuAhR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MFd(3),MFu(3),MSe(6)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFdcSeL(3,3,6),          & 
& cplcFuFdcSeR(3,3,6),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

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
mass(1) = MSe(iIN) 
 
Isum = 144 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MAh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MFd(gt2))+Abs(MAh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Ah Fd cFu Propagator: Se" 
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
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFuFuAhL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFuFuAhR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFdAhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdAhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: Fd" 
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
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplAhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: Se,Se" 
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
!  Se, bar[Fu] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFuFuAhL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFuFuAhR(gt3,i2,gt1))  
coup(5) = cplAhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: Se,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  Se, Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFdAhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdAhR(i2,gt2,gt1))  
coup(5) = cplAhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: Se,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fd'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplcFuFuAhL(gt3,i1,gt1) 
coup(4) = cplcFuFuAhR(gt3,i1,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt2,iIN)  
coup(7) = cplcFuFuAhL(gt3,i2,gt1) 
coup(8) = cplcFuFuAhR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], Fd 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplcFuFuAhL(gt3,i1,gt1) 
coup(4) = cplcFuFuAhR(gt3,i1,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFdAhL(i2,gt2,gt1) 
coup(8) = cplcFdFdAhR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: bar[Fu],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdFdAhL(i1,gt2,gt1) 
coup(4) = cplcFdFdAhR(i1,gt2,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFdAhL(i2,gt2,gt1) 
coup(8) = cplcFdFdAhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fd cFu Propagator: Fd,Fd" 
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
    Do gt1=2,2
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
End Subroutine SeToAhFdcFu 
 
 
Subroutine SeToAhFeFv(iIN,MAh,MFe,MSe,cplAhSecSe,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MAh(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplFvFecSeL(3,3,6),           & 
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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MAh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MFe(gt2))+Abs(MAh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Ah Fe Fv Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFeAhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFeAhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fe Fv Propagator: Fe" 
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
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplAhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fe Fv Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFeAhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFeAhR(i2,gt2,gt1))  
coup(5) = cplAhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fe Fv Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFeAhL(i1,gt2,gt1) 
coup(4) = cplcFeFeAhR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFeAhL(i2,gt2,gt1) 
coup(8) = cplcFeFeAhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Ah Fe Fv Propagator: Fe,Fe" 
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
End Subroutine SeToAhFeFv 
 
 
Subroutine SeToChaChacSe(iIN,MCha,MSe,cplFvChacSeL,cplFvChacSeR,deltaM,               & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MSe(6)

Complex(dp),Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 9 
Allocate( gSum(2,2,6, Isum) ) 
Allocate( Contribution(2,2,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=gt1,2
        Do gt3=1,6
Isum = 0 
 
rk2 = (MCha(gt1)/MSe(iIN))**2 
rm2 = (MCha(gt2)/MSe(iIN))**2 
rj2 = (MSe(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSe(gt3))+Abs(MCha(gt2))+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplFvChacSeL(i1,gt2,gt3)) 
coup(3) = Conjg(cplFvChacSeR(i1,gt2,gt3))
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvChacSeL(i1,gt1,gt3)) 
coup(3) = Conjg(cplFvChacSeR(i1,gt1,gt3))
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(i1,gt1,gt3) 
coup(4) = cplFvChacSeR(i1,gt1,gt3) 
coup(5) = cplFvChacSeL(i1,gt1,iIN) 
coup(6) = cplFvChacSeR(i1,gt1,iIN)  
coup(7) = cplFvChacSeL(i1,gt2,gt3) 
coup(8) = cplFvChacSeR(i1,gt2,gt3) 
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
Write(*,*) "Se->Cha Cha cSe Propagator: Fv" 
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
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplFvChacSeL(i1,gt2,gt3) 
coup(4) = cplFvChacSeR(i1,gt2,gt3) 
coup(5) = cplFvChacSeL(i2,gt1,iIN) 
coup(6) = cplFvChacSeR(i2,gt1,iIN)  
coup(7) = cplFvChacSeL(i2,gt2,gt3) 
coup(8) = cplFvChacSeR(i2,gt2,gt3) 
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(i1,gt1,gt3) 
coup(4) = cplFvChacSeR(i1,gt1,gt3) 
coup(5) = cplFvChacSeL(i2,gt1,iIN) 
coup(6) = cplFvChacSeR(i2,gt1,iIN)  
coup(7) = cplFvChacSeL(i2,gt2,gt3) 
coup(8) = cplFvChacSeR(i2,gt2,gt3) 
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(i1,gt1,gt3) 
coup(4) = cplFvChacSeR(i1,gt1,gt3) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplFvChacSeL(i2,gt1,gt3) 
coup(8) = cplFvChacSeR(i2,gt1,gt3) 
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
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplFvChacSeL(i1,gt2,gt3) 
coup(4) = cplFvChacSeR(i1,gt2,gt3) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplFvChacSeL(i2,gt1,gt3) 
coup(8) = cplFvChacSeR(i2,gt1,gt3) 
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
Write(*,*) "Se->Cha Cha cSe Propagator: Fv,Fv" 
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
    Do gt1=1,2
      Do gt2=gt1,2
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToChaChacSe 
 
 
Subroutine SeToSvChaChi(iIN,MSv,MCha,MChi,MVWm,MHpm,MFe,MSe,cplHpmSvcSe,              & 
& cplSvcSeVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,    & 
& cplChiChacVWmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplFvChacSeL,         & 
& cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MCha(2),MChi(4),MVWm,MHpm(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplSvcSeVWm(3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),          & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),   & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 81 
Allocate( gSum(3,2,4, Isum) ) 
Allocate( Contribution(3,2,4, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,4
Isum = 0 
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (MChi(gt3)/MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MChi(gt3))+Abs(MCha(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VWm 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVWm 
mass(2) = MVWm 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSvcSeVWm(gt1,iIN)) 
coup(3) = Conjg(cplChiChacVWmL(gt3,gt2)) 
coup(2) = Conjg(cplChiChacVWmR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: VWm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm'



!-------------- 
!  Hpm 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MHpm(i1) 
mass(2) = MHpm(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiChacHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChacHpmR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->Sv Cha Chi Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFvSvL(gt3,i1,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Fv" 
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
!  VWm, Hpm 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MHpm(i2)  
coup(1) = cplSvcSeVWm(gt1,iIN) 
coup(2) = Conjg(cplChiChacVWmL(gt3,gt2)) 
coup(3) = Conjg(cplChiChacVWmR(gt3,gt2))  
coup(4) = cplHpmSvcSe(i2,gt1,iIN) 
coup(5) = Conjg(cplChiChacHpmL(gt3,gt2,i2)) 
coup(6) = Conjg(cplChiChacHpmR(gt3,gt2,i2))  
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
Write(*,*) "Se->Sv Cha Chi Propagator: VWm,Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Hpm'
      End Do 



!-------------- 
!  VWm, Fe 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MFe2(i2)  
coup(1) = cplChiFecSeL(gt3,i2,iIN) 
coup(2) = cplChiFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(i2,gt2,gt1))  
coup(5) = cplSvcSeVWm(gt1,iIN) 
coup(7) = Conjg(cplChiChacVWmL(gt3,gt2)) 
coup(6) = Conjg(cplChiChacVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: VWm,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Fe'
      End Do 



!-------------- 
!  VWm, Fv 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = 0._dp  
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt3,i2,gt1))  
coup(5) = cplSvcSeVWm(gt1,iIN) 
coup(7) = Conjg(cplChiChacVWmL(gt3,gt2)) 
coup(6) = Conjg(cplChiChacVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: VWm,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Fv'
      End Do 



!-------------- 
!  Hpm, Hpm 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MHpm(i2)  
coup(1) = cplHpmSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChacHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChacHpmR(gt3,gt2,i1))  
coup(4) = cplHpmSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplChiChacHpmL(gt3,gt2,i2)) 
coup(5) = Conjg(cplChiChacHpmR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Hpm,Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Hpm'
        End Do 
      End Do 



!-------------- 
!  Hpm, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt3,i2,iIN) 
coup(2) = cplChiFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(i2,gt2,gt1))  
coup(5) = cplHpmSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplChiChacHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplChiChacHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Hpm,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Fe'
        End Do 
      End Do 



!-------------- 
!  Hpm, Fv 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = 0.  
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt3,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt3,i2,gt1))  
coup(5) = cplHpmSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplChiChacHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplChiChacHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Hpm,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Fv'
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
coup(1) = cplChiFecSeL(gt3,i1,iIN) 
coup(2) = cplChiFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChaSvL(i1,gt2,gt1) 
coup(4) = cplcFeChaSvR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(gt3,i2,iIN) 
coup(6) = cplChiFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeChaSvL(i2,gt2,gt1) 
coup(8) = cplcFeChaSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Fe,Fe" 
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
coup(1) = cplChiFecSeL(gt3,i1,iIN) 
coup(2) = cplChiFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChaSvL(i1,gt2,gt1) 
coup(4) = cplcFeChaSvR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplChiFvSvL(gt3,i2,gt1) 
coup(8) = cplChiFvSvR(gt3,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Fe,Fv" 
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplChiFvSvL(gt3,i1,gt1) 
coup(4) = cplChiFvSvR(gt3,i1,gt1) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplChiFvSvL(gt3,i2,gt1) 
coup(8) = cplChiFvSvR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Chi Propagator: Fv,Fv" 
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
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,4
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSvChaChi 
 
 
Subroutine SeToChaChicSv(iIN,MCha,MChi,MSv,MSe,cplChiFvcSvL,cplChiFvcSvR,             & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MChi(4),MSv(3),MSe(6)

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
mass(1) = MSe(iIN) 
 
Isum = 9 
Allocate( gSum(2,4,3, Isum) ) 
Allocate( Contribution(2,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt1)/MSe(iIN))**2 
rm2 = (MChi(gt2)/MSe(iIN))**2 
rj2 = (MSv(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSv(gt3))+Abs(MChi(gt2))+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(gt2,i1,gt3)) 
coup(3) = Conjg(cplChiFvcSvR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Chi cSv Propagator: Fv" 
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
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplChiFvcSvL(gt2,i1,gt3) 
coup(4) = cplChiFvcSvR(gt2,i1,gt3) 
coup(5) = cplFvChacSeL(i2,gt1,iIN) 
coup(6) = cplFvChacSeR(i2,gt1,iIN)  
coup(7) = cplChiFvcSvL(gt2,i2,gt3) 
coup(8) = cplChiFvcSvR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Chi cSv Propagator: Fv,Fv" 
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
    Do gt1=1,2
      Do gt2=1,4
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToChaChicSv 
 
 
Subroutine SeToFdChacSd(iIN,MFd,MCha,MSd,MFu,MSe,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MCha(2),MSd(6),MFu(3),MSe(6)

Complex(dp),Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),      & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MFd(gt1)/MSe(iIN))**2 
rm2 = (MCha(gt2)/MSe(iIN))**2 
rj2 = (MSd(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSd(gt3))+Abs(MCha(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplChaFucSdL(gt2,i1,gt3)) 
coup(3) = Conjg(cplChaFucSdR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Cha cSd Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFdcSdL(i1,gt1,gt3)) 
coup(3) = Conjg(cplFvFdcSdR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Cha cSd Propagator: Fv" 
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
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt1,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt1,iIN) 
coup(3) = cplChaFucSdL(gt2,i1,gt3) 
coup(4) = cplChaFucSdR(gt2,i1,gt3) 
coup(5) = cplcFuFdcSeL(i2,gt1,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt1,iIN)  
coup(7) = cplChaFucSdL(gt2,i2,gt3) 
coup(8) = cplChaFucSdR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Cha cSd Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = 0.  
coup(1) = cplcFuFdcSeL(i1,gt1,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt1,iIN) 
coup(3) = cplChaFucSdL(gt2,i1,gt3) 
coup(4) = cplChaFucSdR(gt2,i1,gt3) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt1,gt3) 
coup(8) = cplFvFdcSdR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Cha cSd Propagator: bar[Fu],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],Fv'
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplFvFdcSdL(i1,gt1,gt3) 
coup(4) = cplFvFdcSdR(i1,gt1,gt3) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt1,gt3) 
coup(8) = cplFvFdcSdR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Cha cSd Propagator: Fv,Fv" 
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
End Subroutine SeToFdChacSd 
 
 
Subroutine SeToChaFecHpm(iIN,MCha,MFe,MHpm,MChi,MSe,cplChiChacHpmL,cplChiChacHpmR,    & 
& cplChiFecSeL,cplChiFecSeR,cplFvChacSeL,cplFvChacSeR,cplFvFecHpmL,cplFvFecHpmR,         & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MFe(3),MHpm(2),MChi(4),MSe(6)

Complex(dp),Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),  & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MCha(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt2)/MSe(iIN))**2 
rj2 = (MHpm(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MHpm(gt3))+Abs(MFe(gt2))+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplFvFecHpmL(i1,gt2,gt3)) 
coup(3) = Conjg(cplFvFecHpmR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cHpm Propagator: Fv" 
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
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiChacHpmL(i1,gt1,gt3)) 
coup(3) = Conjg(cplChiChacHpmR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cHpm Propagator: Chi" 
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
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplFvFecHpmL(i1,gt2,gt3) 
coup(4) = cplFvFecHpmR(i1,gt2,gt3) 
coup(5) = cplFvChacSeL(i2,gt1,iIN) 
coup(6) = cplFvChacSeR(i2,gt1,iIN)  
coup(7) = cplFvFecHpmL(i2,gt2,gt3) 
coup(8) = cplFvFecHpmR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cHpm Propagator: Fv,Fv" 
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



!-------------- 
!  Fv, Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = MChi(i2)  
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplFvFecHpmL(i1,gt2,gt3) 
coup(4) = cplFvFecHpmR(i1,gt2,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiChacHpmL(i2,gt1,gt3) 
coup(8) = cplChiChacHpmR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cHpm Propagator: Fv,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fv,Chi'
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiChacHpmL(i1,gt1,gt3) 
coup(4) = cplChiChacHpmR(i1,gt1,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiChacHpmL(i2,gt1,gt3) 
coup(8) = cplChiChacHpmR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cHpm Propagator: Chi,Chi" 
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
End Subroutine SeToChaFecHpm 
 
 
Subroutine SeToChaFecSe(iIN,MCha,MFe,MSe,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,       & 
& cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 36 
Allocate( gSum(2,3,6, Isum) ) 
Allocate( Contribution(2,3,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,6
Isum = 0 
 
rk2 = (MCha(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt2)/MSe(iIN))**2 
rj2 = (MSe(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSe(gt3))+Abs(MFe(gt2))+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplFvFecSeL(i1,gt2,gt3)) 
coup(3) = Conjg(cplFvFecSeR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cSe Propagator: Fv" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvChacSeL(i1,gt1,gt3)) 
coup(3) = Conjg(cplFvChacSeR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cSe Propagator: Fv" 
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
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplFvFecSeL(i1,gt2,gt3) 
coup(4) = cplFvFecSeR(i1,gt2,gt3) 
coup(5) = cplFvChacSeL(i2,gt1,iIN) 
coup(6) = cplFvChacSeR(i2,gt1,iIN)  
coup(7) = cplFvFecSeL(i2,gt2,gt3) 
coup(8) = cplFvFecSeR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cSe Propagator: Fv,Fv" 
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



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplFvFecSeL(i1,gt2,gt3) 
coup(4) = cplFvFecSeR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvChacSeL(i2,gt1,gt3) 
coup(8) = cplFvChacSeR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cSe Propagator: Fv,Fv" 
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



!-------------- 
!  Fv, Fv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = 0.  
mass(2) = 0.  
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvChacSeL(i1,gt1,gt3) 
coup(4) = cplFvChacSeR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvChacSeL(i2,gt1,gt3) 
coup(8) = cplFvChacSeR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Fe cSe Propagator: Fv,Fv" 
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
    Do gt1=1,2
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
End Subroutine SeToChaFecSe 
 
 
Subroutine SeToChaHpmcFe(iIN,MCha,MHpm,MFe,MSe,cplcFeFvHpmL,cplcFeFvHpmR,             & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MCha(2),MHpm(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 9 
Allocate( gSum(2,2,3, Isum) ) 
Allocate( Contribution(2,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=2,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MHpm(gt2)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MHpm(gt2))+Abs(MCha(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt1,iIN)) 
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
Write(*,*) "Se->Cha Hpm cFe Propagator: Fv" 
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
coup(1) = cplFvChacSeL(i1,gt1,iIN) 
coup(2) = cplFvChacSeR(i1,gt1,iIN) 
coup(3) = cplcFeFvHpmL(gt3,i1,gt2) 
coup(4) = cplcFeFvHpmR(gt3,i1,gt2) 
coup(5) = cplFvChacSeL(i2,gt1,iIN) 
coup(6) = cplFvChacSeR(i2,gt1,iIN)  
coup(7) = cplcFeFvHpmL(gt3,i2,gt2) 
coup(8) = cplcFeFvHpmR(gt3,i2,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Cha Hpm cFe Propagator: Fv,Fv" 
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
    Do gt1=1,2
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
End Subroutine SeToChaHpmcFe 
 
 
Subroutine SeToSdChacFd(iIN,MSd,MCha,MFd,MSu,MSe,cplSdcSecSu,cplcFdChaSuL,            & 
& cplcFdChaSuR,cplcFdFvSdL,cplcFdFvSdR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MCha(2),MFd(3),MSu(6),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFdFvSdL(3,3,6),        & 
& cplcFdFvSdR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (MFd(gt3)/MSe(iIN))**2 
rj2 = (MSd(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFd(gt3))+Abs(MCha(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Su] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSu(i1) 
mass(2) = MSu(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFdChaSuL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdChaSuR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Cha cFd Propagator: conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Sd Cha cFd Propagator: Fv" 
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
!  conj[Su], conj[Su] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSu(i1)  
mass(2) = MSu(i2)  
coup(1) = cplSdcSecSu(gt1,iIN,i1) 
coup(3) = Conjg(cplcFdChaSuL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdChaSuR(gt3,gt2,i1))  
coup(4) = cplSdcSecSu(gt1,iIN,i2) 
coup(6) = Conjg(cplcFdChaSuL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdChaSuR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Cha cFd Propagator: conj[Su],conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],conj[Su]'
        End Do 
      End Do 



!-------------- 
!  conj[Su], Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSu(i1)  
mass(1) = 0.  
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFvSdL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFvSdR(gt3,i2,gt1))  
coup(5) = cplSdcSecSu(gt1,iIN,i1) 
coup(7) = Conjg(cplcFdChaSuL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdChaSuR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Cha cFd Propagator: conj[Su],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],Fv'
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplcFdFvSdL(gt3,i1,gt1) 
coup(4) = cplcFdFvSdR(gt3,i1,gt1) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplcFdFvSdL(gt3,i2,gt1) 
coup(8) = cplcFdFvSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Cha cFd Propagator: Fv,Fv" 
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
End Subroutine SeToSdChacFd 
 
 
Subroutine SeToSeChacCha(iIN,MSe,MCha,MVZ,MAh,Mhh,cplAhSecSe,cplhhSecSe,              & 
& cplSecSeVZ,cplcChaChaAhL,cplcChaChaAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplcChaFvSeL,cplcChaFvSeR,cplFvChacSeL,cplFvChacSeR,deltaM,              & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MCha(2),MVZ,MAh(2),Mhh(2)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplhhSecSe(2,6,6),cplSecSeVZ(6,6),cplcChaChaAhL(2,2,2),             & 
& cplcChaChaAhR(2,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVZL(2,2),     & 
& cplcChaChaVZR(2,2),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplFvChacSeL(3,2,6),        & 
& cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 64 
Allocate( gSum(6,2,2, Isum) ) 
Allocate( Contribution(6,2,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,2
        Do gt3=1,2
Isum = 0 
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (MCha(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MCha(gt3))+Abs(MCha(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
Write(*,*) "Se->Se Cha cCha Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Ah 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MAh(i1) 
mass(2) = MAh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplcChaChaAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChaAhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah'
      End Do 



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Se Cha cCha Propagator: hh" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Se Cha cCha Propagator: Fv" 
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
!  VZ, Ah 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MAh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcChaChaVZL(gt3,gt2)) 
coup(3) = Conjg(cplcChaChaVZR(gt3,gt2))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(5) = Conjg(cplcChaChaAhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcChaChaAhR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Cha cCha Propagator: VZ,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Ah'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcChaChaVZL(gt3,gt2)) 
coup(3) = Conjg(cplcChaChaVZR(gt3,gt2))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Cha cCha Propagator: VZ,hh" 
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
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
coup(7) = Conjg(cplcChaChaVZL(gt3,gt2)) 
coup(6) = Conjg(cplcChaChaVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: VZ,Fv" 
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
!  Ah, Ah 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = MAh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcChaChaAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChaAhR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcChaChaAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaChaAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: Ah,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Ah'
        End Do 
      End Do 



!-------------- 
!  Ah, hh 
!-------------- 
Do i1=1,2
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcChaChaAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChaAhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcChaChahhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaChahhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: Ah,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,hh'
        End Do 
      End Do 



!-------------- 
!  Ah, Fv 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MAh(i1)  
mass(1) = 0.  
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i2,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcChaChaAhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaChaAhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: Ah,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Fv'
        End Do 
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
coup(1) = cplhhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcChaChahhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaChahhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcChaChahhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaChahhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: hh,hh" 
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
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i2,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcChaChahhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaChahhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: hh,Fv" 
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplcChaFvSeL(gt3,i1,gt1) 
coup(4) = cplcChaFvSeR(gt3,i1,gt1) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplcChaFvSeL(gt3,i2,gt1) 
coup(8) = cplcChaFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cCha Propagator: Fv,Fv" 
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
      Do gt2=1,2
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSeChacCha 
 
 
Subroutine SeToSeChacFe(iIN,MSe,MCha,MFe,MSv,cplSecSecSv,cplcFeChaSvL,cplcFeChaSvR,   & 
& cplcFeFvSeL,cplcFeFvSeR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MCha(2),MFe(3),MSv(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFeFvSeL(3,3,6),        & 
& cplcFeFvSeR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 36 
Allocate( gSum(6,2,3, Isum) ) 
Allocate( Contribution(6,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MCha(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  conj[Sv] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFeChaSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeChaSvR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cFe Propagator: conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvChacSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Se Cha cFe Propagator: Fv" 
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
!  conj[Sv], conj[Sv] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFeChaSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeChaSvR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplcFeChaSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeChaSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cFe Propagator: conj[Sv],conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],conj[Sv]'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = 0.  
coup(1) = cplFvChacSeL(i2,gt2,iIN) 
coup(2) = cplFvChacSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(gt1,iIN,i1) 
coup(7) = Conjg(cplcFeChaSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeChaSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cFe Propagator: conj[Sv],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Fv'
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
coup(1) = cplFvChacSeL(i1,gt2,iIN) 
coup(2) = cplFvChacSeR(i1,gt2,iIN) 
coup(3) = cplcFeFvSeL(gt3,i1,gt1) 
coup(4) = cplcFeFvSeR(gt3,i1,gt1) 
coup(5) = cplFvChacSeL(i2,gt2,iIN) 
coup(6) = cplFvChacSeR(i2,gt2,iIN)  
coup(7) = cplcFeFvSeL(gt3,i2,gt1) 
coup(8) = cplcFeFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Cha cFe Propagator: Fv,Fv" 
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
End Subroutine SeToSeChacFe 
 
 
Subroutine SeToSeChiChi(iIN,MSe,MChi,MVZ,MAh,Mhh,MFe,cplAhSecSe,cplhhSecSe,           & 
& cplSecSeVZ,cplcFeChiSeL,cplcFeChiSeR,cplChiChiAhL,cplChiChiAhR,cplChiChihhL,           & 
& cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,cplChiFecSeR,deltaM,               & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MChi(4),MVZ,MAh(2),Mhh(2),MFe(3)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplhhSecSe(2,6,6),cplSecSeVZ(6,6),cplcFeChiSeL(3,4,6),              & 
& cplcFeChiSeR(3,4,6),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFecSeL(4,3,6),           & 
& cplChiFecSeR(4,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 64 
Allocate( gSum(6,4,4, Isum) ) 
Allocate( Contribution(6,4,4, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,4
        Do gt3=gt2,4
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MChi(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MChi(gt3))+Abs(MChi(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
Write(*,*) "Se->Se Chi Chi Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Ah 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MAh(i1) 
mass(2) = MAh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiChiAhL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiChiAhR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MAh(i1) 
mass(2) = MAh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplChiChiAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChiAhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MAh(i1)  
mass(2) = MAh(i1)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChiAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChiAhR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i1,gt1,iIN) 
coup(6) = Conjg(cplChiChiAhL(gt2,gt3,i1)) 
coup(5) = Conjg(cplChiChiAhR(gt2,gt3,i1))  
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
Write(*,*) "Se->Se Chi Chi Propagator: Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah'
      End Do 



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(i1,gt1,iIN)) 
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
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(i1,gt1,iIN)) 
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
coup(1) = cplhhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChihhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplChiChihhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i1,gt1,iIN) 
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
Write(*,*) "Se->Se Chi Chi Propagator: hh" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeChiSeL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeChiSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MFe(i1)  
mass(2) = MFe(i1)  
coup(1) = cplChiFecSeL(gt3,i1,iIN) 
coup(2) = cplChiFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(gt2,i1,iIN) 
coup(6) = cplChiFecSeR(gt2,i1,iIN)  
coup(7) = cplcFeChiSeL(i1,gt3,gt1) 
coup(8) = cplcFeChiSeR(i1,gt3,gt1) 
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
Write(*,*) "Se->Se Chi Chi Propagator: Fe" 
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
!  VZ, Ah 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MAh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplChiChiVZL(gt2,gt3)) 
coup(3) = Conjg(cplChiChiVZR(gt2,gt3))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(5) = Conjg(cplChiChiAhL(gt2,gt3,i2)) 
coup(6) = Conjg(cplChiChiAhR(gt2,gt3,i2))  
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
Write(*,*) "Se->Se Chi Chi Propagator: VZ,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Ah'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplChiChiVZL(gt2,gt3)) 
coup(3) = Conjg(cplChiChiVZR(gt2,gt3))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Chi Chi Propagator: VZ,hh" 
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
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt3,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
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
mass(1) = MFe2(i2)  
coup(1) = cplChiFecSeL(gt3,i2,iIN) 
coup(2) = cplChiFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
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
Write(*,*) "Se->Se Chi Chi Propagator: VZ,Fe" 
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
!  Ah, Ah 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = MAh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChiAhL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiChiAhR(gt2,gt3,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplChiChiAhL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiChiAhR(gt2,gt3,i2))  
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
Write(*,*) "Se->Se Chi Chi Propagator: Ah,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Ah'
        End Do 
      End Do 



!-------------- 
!  Ah, hh 
!-------------- 
Do i1=1,2
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChiAhL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiChiAhR(gt2,gt3,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Chi Chi Propagator: Ah,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,hh'
        End Do 
      End Do 



!-------------- 
!  Ah, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MAh(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt3,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplChiChiAhL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiChiAhR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(2) = MAh(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt3,i2,iIN) 
coup(2) = cplChiFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplChiChiAhL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiChiAhR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Chi Propagator: Ah,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Fe'
        End Do 
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
coup(1) = cplhhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiChihhL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiChihhR(gt2,gt3,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Chi Chi Propagator: hh,hh" 
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
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt3,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
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
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt3,i2,iIN) 
coup(2) = cplChiFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
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
Write(*,*) "Se->Se Chi Chi Propagator: hh,Fe" 
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt3,gt1) 
coup(4) = cplcFeChiSeR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt3,gt1) 
coup(8) = cplcFeChiSeR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt3,i1,iIN) 
coup(2) = cplChiFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt3,gt1) 
coup(8) = cplcFeChiSeR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt3,i1,iIN) 
coup(2) = cplChiFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(gt3,i2,iIN) 
coup(6) = cplChiFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt2,gt1) 
coup(8) = cplcFeChiSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt3,gt1) 
coup(4) = cplcFeChiSeR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt3,i2,iIN) 
coup(6) = cplChiFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt2,gt1) 
coup(8) = cplcFeChiSeR(i2,gt2,gt1) 
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
Write(*,*) "Se->Se Chi Chi Propagator: Fe,Fe" 
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
      Do gt2=1,4
        Do gt3=gt2,4
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSeChiChi 
 
 
Subroutine SeTocSuChiFd(iIN,MSu,MChi,MFd,MSd,MFe,MFu,MSe,cplSdcSecSu,cplcFeFdcSuL,    & 
& cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,         & 
& cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSu(6),MChi(4),MFd(3),MSd(6),MFe(3),MFu(3),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),       & 
& cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MFd(gt3)/MSe(iIN))**2 
rj2 = (MSu(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFd(gt3))+Abs(MChi(gt2))+Abs(MSu(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSu Chi Fd Propagator: Sd" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFdcSuL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFdcSuR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: Fe" 
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
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt3,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFucSuL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiFucSuR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
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
coup(1) = cplSdcSecSu(i1,iIN,gt1) 
coup(3) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFdcSdR(gt2,gt3,i1))  
coup(4) = cplSdcSecSu(i2,iIN,gt1) 
coup(6) = Conjg(cplChiFdcSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFdcSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: Sd,Sd" 
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
!  Sd, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFdcSuL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFdcSuR(i2,gt3,gt1))  
coup(5) = cplSdcSecSu(i1,iIN,gt1) 
coup(7) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFdcSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: Sd,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Fe'
        End Do 
      End Do 



!-------------- 
!  Sd, bar[Fu] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt3,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFucSuL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFucSuR(gt2,i2,gt1))  
coup(5) = cplSdcSecSu(i1,iIN,gt1) 
coup(7) = Conjg(cplChiFdcSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFdcSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: Sd,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,bar[Fu]'
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFdcSuL(i1,gt3,gt1) 
coup(4) = cplcFeFdcSuR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt3,gt1) 
coup(8) = cplcFeFdcSuR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: Fe,Fe" 
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
!  Fe, bar[Fu] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFu(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFdcSuL(i1,gt3,gt1) 
coup(4) = cplcFeFdcSuR(i1,gt3,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt3,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt3,iIN)  
coup(7) = cplChiFucSuL(gt2,i2,gt1) 
coup(8) = cplChiFucSuR(gt2,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: Fe,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt3,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt3,iIN) 
coup(3) = cplChiFucSuL(gt2,i1,gt1) 
coup(4) = cplChiFucSuR(gt2,i1,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt3,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt3,iIN)  
coup(7) = cplChiFucSuL(gt2,i2,gt1) 
coup(8) = cplChiFucSuR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Chi Fd Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
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
End Subroutine SeTocSuChiFd 
 
 
Subroutine SeTohhChiFe(iIN,Mhh,MChi,MFe,MSe,cplhhSecSe,cplcFeFehhL,cplcFeFehhR,       & 
& cplChiChihhL,cplChiChihhR,cplChiFecSeL,cplChiFecSeR,deltaM,epsI,check,g,               & 
& WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MChi(4),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplhhSecSe(2,6,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplChiChihhL(4,4,2),          & 
& cplChiChihhR(4,4,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 169 
Allocate( gSum(2,4,3, Isum) ) 
Allocate( Contribution(2,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (Mhh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->hh Chi Fe Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFehhL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFehhR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt3,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt3,iIN)) 
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
Write(*,*) "Se->hh Chi Fe Propagator: Chi" 
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
coup(1) = cplhhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
coup(4) = cplhhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplChiFecSeL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFecSeR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFehhL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFehhR(i2,gt3,gt1))  
coup(5) = cplhhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplChiFecSeL(i2,gt3,iIN) 
coup(2) = cplChiFecSeR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiChihhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplChiChihhR(i2,gt2,gt1))  
coup(5) = cplhhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Se,Chi" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFehhL(i1,gt3,gt1) 
coup(4) = cplcFeFehhR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFehhL(i2,gt3,gt1) 
coup(8) = cplcFeFehhR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Fe,Fe" 
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFehhL(i1,gt3,gt1) 
coup(4) = cplcFeFehhR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(i2,gt3,iIN) 
coup(6) = cplChiFecSeR(i2,gt3,iIN)  
coup(7) = cplChiChihhL(i2,gt2,gt1) 
coup(8) = cplChiChihhR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Fe,Chi" 
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
coup(1) = cplChiFecSeL(i1,gt3,iIN) 
coup(2) = cplChiFecSeR(i1,gt3,iIN) 
coup(3) = cplChiChihhL(i1,gt2,gt1) 
coup(4) = cplChiChihhR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(i2,gt3,iIN) 
coup(6) = cplChiFecSeR(i2,gt3,iIN)  
coup(7) = cplChiChihhL(i2,gt2,gt1) 
coup(8) = cplChiChihhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Chi Fe Propagator: Chi,Chi" 
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:169))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTohhChiFe 
 
 
Subroutine SeToSvChiFe(iIN,MSv,MChi,MFe,MSe,cplSeSvcSe,cplcFeFeSvL,cplcFeFeSvR,       & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplFvFecSeL,cplFvFecSeR,             & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MChi(4),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplSeSvcSe(6,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplChiFecSeL(4,3,6),          & 
& cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplFvFecSeL(3,3,6),          & 
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
mass(1) = MSe(iIN) 
 
Isum = 144 
Allocate( gSum(3,4,3, Isum) ) 
Allocate( Contribution(3,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Sv Chi Fe Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFeSvL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt3,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFvSvL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Fv" 
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
coup(1) = cplSeSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplChiFecSeL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFecSeR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFeSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(i2,gt3,gt1))  
coup(5) = cplSeSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplFvFecSeL(i2,gt3,iIN) 
coup(2) = cplFvFecSeR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFvSvL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFvSvR(gt2,i2,gt1))  
coup(5) = cplSeSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Se,Fv" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFeSvL(i1,gt3,gt1) 
coup(4) = cplcFeFeSvR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFeSvL(i2,gt3,gt1) 
coup(8) = cplcFeFeSvR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Fe,Fe" 
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFeSvL(i1,gt3,gt1) 
coup(4) = cplcFeFeSvR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(i2,gt3,iIN) 
coup(6) = cplFvFecSeR(i2,gt3,iIN)  
coup(7) = cplChiFvSvL(gt2,i2,gt1) 
coup(8) = cplChiFvSvR(gt2,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Fe,Fv" 
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
coup(1) = cplFvFecSeL(i1,gt3,iIN) 
coup(2) = cplFvFecSeR(i1,gt3,iIN) 
coup(3) = cplChiFvSvL(gt2,i1,gt1) 
coup(4) = cplChiFvSvR(gt2,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt3,iIN) 
coup(6) = cplFvFecSeR(i2,gt3,iIN)  
coup(7) = cplChiFvSvL(gt2,i2,gt1) 
coup(8) = cplChiFvSvR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Chi Fe Propagator: Fv,Fv" 
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
    Do gt1=1,3
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
End Subroutine SeToSvChiFe 
 
 
Subroutine SeTocSvChiFe(iIN,MSv,MChi,MFe,MSe,cplSecSecSv,cplcFeFecSvL,cplcFeFecSvR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFecSeL,cplFvFecSeR,           & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MChi(4),MFe(3),MSe(6)

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
mass(1) = MSe(iIN) 
 
Isum = 144 
Allocate( gSum(3,4,3, Isum) ) 
Allocate( Contribution(3,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MChi(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSv Chi Fe Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFecSvL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFecSvR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt3,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt3,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(gt2,i1,gt1)) 
coup(3) = Conjg(cplChiFvcSvR(gt2,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Fv" 
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
coup(1) = cplSecSecSv(i1,iIN,gt1) 
coup(3) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
coup(4) = cplSecSecSv(i2,iIN,gt1) 
coup(6) = Conjg(cplChiFecSeL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFecSeR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFecSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFecSvR(i2,gt3,gt1))  
coup(5) = cplSecSecSv(i1,iIN,gt1) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplFvFecSeL(i2,gt3,iIN) 
coup(2) = cplFvFecSeR(i2,gt3,iIN) 
coup(4) = Conjg(cplChiFvcSvL(gt2,i2,gt1)) 
coup(3) = Conjg(cplChiFvcSvR(gt2,i2,gt1))  
coup(5) = cplSecSecSv(i1,iIN,gt1) 
coup(7) = Conjg(cplChiFecSeL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFecSeR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Se,Fv" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFecSvL(i1,gt3,gt1) 
coup(4) = cplcFeFecSvR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFecSvL(i2,gt3,gt1) 
coup(8) = cplcFeFecSvR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Fe,Fe" 
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFecSvL(i1,gt3,gt1) 
coup(4) = cplcFeFecSvR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(i2,gt3,iIN) 
coup(6) = cplFvFecSeR(i2,gt3,iIN)  
coup(7) = cplChiFvcSvL(gt2,i2,gt1) 
coup(8) = cplChiFvcSvR(gt2,i2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Fe,Fv" 
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
coup(1) = cplFvFecSeL(i1,gt3,iIN) 
coup(2) = cplFvFecSeR(i1,gt3,iIN) 
coup(3) = cplChiFvcSvL(gt2,i1,gt1) 
coup(4) = cplChiFvcSvR(gt2,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt3,iIN) 
coup(6) = cplFvFecSeR(i2,gt3,iIN)  
coup(7) = cplChiFvcSvL(gt2,i2,gt1) 
coup(8) = cplChiFvcSvR(gt2,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Chi Fe Propagator: Fv,Fv" 
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
    Do gt1=1,3
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
End Subroutine SeTocSvChiFe 
 
 
Subroutine SeToHpmChiFv(iIN,MHpm,MChi,MSv,MFe,MCha,MSe,cplHpmSvcSe,cplcChaChiHpmL,    & 
& cplcChaChiHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,       & 
& cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MChi(4),MSv(3),MFe(3),MCha(2),MSe(6)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFeFvHpmL(3,3,2),   & 
& cplcFeFvHpmR(3,3,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),       & 
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
mass(1) = MSe(iIN) 
 
Isum = 64 
Allocate( gSum(2,4,3, Isum) ) 
Allocate( Contribution(2,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MHpm(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MChi(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Hpm Chi Fv Propagator: Sv" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvHpmR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Fe" 
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
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcChaChiHpmL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcChaChiHpmR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
coup(1) = cplHpmSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
coup(4) = cplHpmSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplChiFvcSvL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFvcSvR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Sv,Sv" 
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
!  Sv, Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFvHpmL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvHpmR(i2,gt3,gt1))  
coup(5) = cplHpmSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Sv,Fe" 
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
!  Sv, Cha 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i2,iIN) 
coup(2) = cplFvChacSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcChaChiHpmL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcChaChiHpmR(i2,gt2,gt1))  
coup(5) = cplHpmSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Sv,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Cha'
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt3,gt1) 
coup(4) = cplcFeFvHpmR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt3,gt1) 
coup(8) = cplcFeFvHpmR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Fe,Fe" 
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
!  Fe, Cha 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MCha(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt3,gt1) 
coup(4) = cplcFeFvHpmR(i1,gt3,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaChiHpmL(i2,gt2,gt1) 
coup(8) = cplcChaChiHpmR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Fe,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaChiHpmL(i1,gt2,gt1) 
coup(4) = cplcChaChiHpmR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaChiHpmL(i2,gt2,gt1) 
coup(8) = cplcChaChiHpmR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Chi Fv Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToHpmChiFv 
 
 
Subroutine SeToSeChiFv(iIN,MSe,MChi,MSv,MFe,cplSecSecSv,cplSeSvcSe,cplcFeChiSeL,      & 
& cplcFeChiSeR,cplcFeFvSeL,cplcFeFvSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplChiFvSvL,cplChiFvSvR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,              & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MChi(4),MSv(3),MFe(3)

Complex(dp),Intent(in) :: cplSecSecSv(6,6,3),cplSeSvcSe(6,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 144 
Allocate( gSum(6,4,3, Isum) ) 
Allocate( Contribution(6,4,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,4
        Do gt3=1,3
Isum = 0 
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MChi(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Se Chi Fv Propagator: Sv" 
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
!  conj[Sv] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,iIN,i1)) 
coup(3) = Conjg(cplChiFvSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvSvR(gt2,gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFvSeL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Fe" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->Se Chi Fv Propagator: Fe" 
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
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
coup(4) = cplSeSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplChiFvcSvL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFvcSvR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Sv,Sv" 
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
!  Sv, conj[Sv] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplChiFvSvL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFvSvR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Sv,conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,conj[Sv]'
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
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt3,gt1))  
coup(5) = cplSeSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Sv,Fe" 
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
!  Sv, Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplSeSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplChiFvcSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvcSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Sv,Fe" 
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
!  conj[Sv], conj[Sv] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplChiFvSvL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChiFvSvR(gt2,gt3,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplChiFvSvL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChiFvSvR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: conj[Sv],conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],conj[Sv]'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt3,gt1))  
coup(5) = cplSecSecSv(gt1,iIN,i1) 
coup(7) = Conjg(cplChiFvSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: conj[Sv],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Fe'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(gt1,iIN,i1) 
coup(7) = Conjg(cplChiFvSvL(gt2,gt3,i1)) 
coup(6) = Conjg(cplChiFvSvR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: conj[Sv],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Fe'
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt3,gt1) 
coup(4) = cplcFeFvSeR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt3,gt1) 
coup(8) = cplcFeFvSeR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Fe,Fe" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt3,gt1) 
coup(4) = cplcFeFvSeR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt2,gt1) 
coup(8) = cplcFeChiSeR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Fe,Fe" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChiSeL(i1,gt2,gt1) 
coup(4) = cplcFeChiSeR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeChiSeL(i2,gt2,gt1) 
coup(8) = cplcFeChiSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Chi Fv Propagator: Fe,Fe" 
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
End Subroutine SeToSeChiFv 
 
 
Subroutine SeToSdChicFu(iIN,MSd,MChi,MFu,MSu,MFe,MFd,MSe,cplSdcSecSu,cplcFdChiSdL,    & 
& cplcFdChiSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,         & 
& cplcFuFdcSeR,cplChiFecSeL,cplChiFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MChi(4),MFu(3),MSu(6),MFe(3),MFd(3),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFecFuSdL(3,3,6),       & 
& cplcFecFuSdR(3,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MChi(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSd(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MChi(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Su] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSu(i1) 
mass(2) = MSu(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFuChiSuL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuChiSuR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(gt2,i1,iIN)) 
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
Write(*,*) "Se->Sd Chi cFu Propagator: Fe" 
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
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->Sd Chi cFu Propagator: Fd" 
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
!  conj[Su], conj[Su] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSu(i1)  
mass(2) = MSu(i2)  
coup(1) = cplSdcSecSu(gt1,iIN,i1) 
coup(3) = Conjg(cplcFuChiSuL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuChiSuR(gt3,gt2,i1))  
coup(4) = cplSdcSecSu(gt1,iIN,i2) 
coup(6) = Conjg(cplcFuChiSuL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuChiSuR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: conj[Su],conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],conj[Su]'
        End Do 
      End Do 



!-------------- 
!  conj[Su], Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSu(i1)  
mass(1) = MFe(i2)  
coup(1) = cplChiFecSeL(gt2,i2,iIN) 
coup(2) = cplChiFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFecFuSdL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFecFuSdR(i2,gt3,gt1))  
coup(5) = cplSdcSecSu(gt1,iIN,i1) 
coup(7) = Conjg(cplcFuChiSuL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuChiSuR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: conj[Su],Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],Fe'
        End Do 
      End Do 



!-------------- 
!  conj[Su], Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSu(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdChiSdL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdChiSdR(i2,gt2,gt1))  
coup(5) = cplSdcSecSu(gt1,iIN,i1) 
coup(7) = Conjg(cplcFuChiSuL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuChiSuR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: conj[Su],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],Fd'
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
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFecFuSdL(i1,gt3,gt1) 
coup(4) = cplcFecFuSdR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(gt2,i2,iIN) 
coup(6) = cplChiFecSeR(gt2,i2,iIN)  
coup(7) = cplcFecFuSdL(i2,gt3,gt1) 
coup(8) = cplcFecFuSdR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: Fe,Fe" 
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
!  Fe, Fd 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFd(i2)  
coup(1) = cplChiFecSeL(gt2,i1,iIN) 
coup(2) = cplChiFecSeR(gt2,i1,iIN) 
coup(3) = cplcFecFuSdL(i1,gt3,gt1) 
coup(4) = cplcFecFuSdR(i1,gt3,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdChiSdL(i2,gt2,gt1) 
coup(8) = cplcFdChiSdR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: Fe,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdChiSdL(i1,gt2,gt1) 
coup(4) = cplcFdChiSdR(i1,gt2,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdChiSdL(i2,gt2,gt1) 
coup(8) = cplcFdChiSdR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Chi cFu Propagator: Fd,Fd" 
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
End Subroutine SeToSdChicFu 
 
 
Subroutine SeToFdFecSd(iIN,MFd,MFe,MSd,MFu,MChi,MSe,cplcFuFdcSeL,cplcFuFdcSeR,        & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFd(3),MFe(3),MSd(6),MFu(3),MChi(4),MSe(6)

Complex(dp),Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),      & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 100 
Allocate( gSum(3,3,6, Isum) ) 
Allocate( Contribution(3,3,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
Isum = 0 
 
rk2 = (MFd(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt2)/MSe(iIN))**2 
rj2 = (MSd(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSd(gt3))+Abs(MFe(gt2))+Abs(MFd(gt1)))) Then 
!-------------- 
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplFeFucSdL(gt2,i1,gt3)) 
coup(3) = Conjg(cplFeFucSdR(gt2,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFdcSdL(i1,gt1,gt3)) 
coup(3) = Conjg(cplChiFdcSdR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: Chi" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFdcSdL(i1,gt1,gt3)) 
coup(3) = Conjg(cplFvFdcSdR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: Fv" 
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
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt1,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt1,iIN) 
coup(3) = cplFeFucSdL(gt2,i1,gt3) 
coup(4) = cplFeFucSdR(gt2,i1,gt3) 
coup(5) = cplcFuFdcSeL(i2,gt1,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt1,iIN)  
coup(7) = cplFeFucSdL(gt2,i2,gt3) 
coup(8) = cplFeFucSdR(gt2,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MChi(i2)  
coup(1) = cplcFuFdcSeL(i1,gt1,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt1,iIN) 
coup(3) = cplFeFucSdL(gt2,i1,gt3) 
coup(4) = cplFeFucSdR(gt2,i1,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFdcSdL(i2,gt1,gt3) 
coup(8) = cplChiFdcSdR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: bar[Fu],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],Chi'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = 0.  
coup(1) = cplcFuFdcSeL(i1,gt1,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt1,iIN) 
coup(3) = cplFeFucSdL(gt2,i1,gt3) 
coup(4) = cplFeFucSdR(gt2,i1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt1,gt3) 
coup(8) = cplFvFdcSdR(i2,gt1,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: bar[Fu],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],Fv'
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFdcSdL(i1,gt1,gt3) 
coup(4) = cplChiFdcSdR(i1,gt1,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFdcSdL(i2,gt1,gt3) 
coup(8) = cplChiFdcSdR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: Chi,Chi" 
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



!-------------- 
!  Chi, Fv 
!-------------- 
Do i1=1,4
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFdcSdL(i1,gt1,gt3) 
coup(4) = cplChiFdcSdR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt1,gt3) 
coup(8) = cplFvFdcSdR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: Chi,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Fv'
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFdcSdL(i1,gt1,gt3) 
coup(4) = cplFvFdcSdR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFdcSdL(i2,gt1,gt3) 
coup(8) = cplFvFdcSdR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fd Fe cSd Propagator: Fv,Fv" 
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
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:100))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToFdFecSd 
 
 
Subroutine SeTocSuFdGlu(iIN,MSu,MFd,MGlu,MSd,MFu,MSe,cplSdcSecSu,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,deltaM,               & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSu(6),MFd(3),MGlu,MSd(6),MFu(3),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplGluFdcSdL(3,6),         & 
& cplGluFdcSdR(3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 81 
Allocate( gSum(6,3,1, Isum) ) 
Allocate( Contribution(6,3,1, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MGlu/MSe(iIN))**2 
rj2 = (MSu(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MGlu)+Abs(MFd(gt2))+Abs(MSu(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSu Fd Glu Propagator: Sd" 
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
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplGluFucSuL(i1,gt1)) 
coup(3) = Conjg(cplGluFucSuR(i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Glu Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp
Else 
gSum(gt1,gt2,1,Isum)=resD
End If 
Contribution(gt1,gt2,1,Isum)='bar[Fu]'
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
coup(1) = cplSdcSecSu(i1,iIN,gt1) 
coup(3) = Conjg(cplGluFdcSdL(gt2,i1)) 
coup(2) = Conjg(cplGluFdcSdR(gt2,i1))  
coup(4) = cplSdcSecSu(i2,iIN,gt1) 
coup(6) = Conjg(cplGluFdcSdL(gt2,i2)) 
coup(5) = Conjg(cplGluFdcSdR(gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Glu Propagator: Sd,Sd" 
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
!  Sd, bar[Fu] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplGluFucSuL(i2,gt1)) 
coup(3) = Conjg(cplGluFucSuR(i2,gt1))  
coup(5) = cplSdcSecSu(i1,iIN,gt1) 
coup(7) = Conjg(cplGluFdcSdL(gt2,i1)) 
coup(6) = Conjg(cplGluFdcSdR(gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Glu Propagator: Sd,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp  
Else 
gSum(gt1,gt2,1,Isum)= resS  
End If 
Contribution(gt1,gt2,1,Isum)='Sd,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplGluFucSuL(i1,gt1) 
coup(4) = cplGluFucSuR(i1,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt2,iIN)  
coup(7) = cplGluFucSuL(i2,gt1) 
coup(8) = cplGluFucSuR(i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Glu Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,1,Isum)= 0._dp  
Else 
gSum(gt1,gt2,1,Isum)= resS  
End If 
Contribution(gt1,gt2,1,Isum)='bar[Fu],bar[Fu]'
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
End Subroutine SeTocSuFdGlu 
 
 
Subroutine SeTohhFdcFu(iIN,Mhh,MFd,MFu,MSe,cplhhSecSe,cplcFdFdhhL,cplcFdFdhhR,        & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuhhL,cplcFuFuhhR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MFd(3),MFu(3),MSe(6)

Complex(dp),Intent(in) :: cplhhSecSe(2,6,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),          & 
& cplcFuFdcSeR(3,3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2)

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
mass(1) = MSe(iIN) 
 
Isum = 144 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (Mhh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MFd(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->hh Fd cFu Propagator: Se" 
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
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFuFuhhL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFuFuhhR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFdhhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdhhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: Fd" 
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
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplhhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: Se,Se" 
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
!  Se, bar[Fu] 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFuFuhhL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFuFuhhR(gt3,i2,gt1))  
coup(5) = cplhhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: Se,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  Se, Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFdhhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdhhR(i2,gt2,gt1))  
coup(5) = cplhhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: Se,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fd'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplcFuFuhhL(gt3,i1,gt1) 
coup(4) = cplcFuFuhhR(gt3,i1,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt2,iIN)  
coup(7) = cplcFuFuhhL(gt3,i2,gt1) 
coup(8) = cplcFuFuhhR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], Fd 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplcFuFuhhL(gt3,i1,gt1) 
coup(4) = cplcFuFuhhR(gt3,i1,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFdhhL(i2,gt2,gt1) 
coup(8) = cplcFdFdhhR(i2,gt2,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: bar[Fu],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdFdhhL(i1,gt2,gt1) 
coup(4) = cplcFdFdhhR(i1,gt2,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFdhhL(i2,gt2,gt1) 
coup(8) = cplcFdFdhhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fd cFu Propagator: Fd,Fd" 
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
    Do gt1=1,2
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
End Subroutine SeTohhFdcFu 
 
 
Subroutine SeToHpmFdcFd(iIN,MHpm,MFd,MSv,MFu,MSe,cplHpmSvcSe,cplcFdFdcSvL,            & 
& cplcFdFdcSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFdcSeL,cplcFuFdcSeR,deltaM,               & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MFd(3),MSv(3),MFu(3),MSe(6)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFdFuHpmL(3,3,2),       & 
& cplcFdFuHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 36 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MFd(gt3)/MSe(iIN))**2 
rj2 = (MHpm(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFd(gt3))+Abs(MFd(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Hpm Fd cFd Propagator: Sv" 
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
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFdFuHpmL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFdFuHpmR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fd cFd Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
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
coup(1) = cplHpmSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
coup(4) = cplHpmSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFdcSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdcSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fd cFd Propagator: Sv,Sv" 
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
!  Sv, bar[Fu] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFuHpmL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFuHpmR(gt3,i2,gt1))  
coup(5) = cplHpmSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fd cFd Propagator: Sv,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplcFdFuHpmL(gt3,i1,gt1) 
coup(4) = cplcFdFuHpmR(gt3,i1,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt2,iIN)  
coup(7) = cplcFdFuHpmL(gt3,i2,gt1) 
coup(8) = cplcFdFuHpmR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fd cFd Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToHpmFdcFd 
 
 
Subroutine SeToSeFdcFd(iIN,MSe,MFd,MVZ,MSv,MAh,Mhh,MFu,cplAhSecSe,cplhhSecSe,         & 
& cplSecSecSv,cplSecSeVZ,cplSeSvcSe,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFd(3),MVZ,MSv(3),MAh(2),Mhh(2),MFu(3)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplhhSecSe(2,6,6),cplSecSecSv(6,6,3),cplSecSeVZ(6,6),               & 
& cplSeSvcSe(6,3,6),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdFdcSvL(3,3,3),           & 
& cplcFdFdcSvR(3,3,3),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),          & 
& cplcFdFdSvR(3,3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFuSeL(3,3,6),               & 
& cplcFdFuSeR(3,3,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 196 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MFd(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFd(gt3))+Abs(MFd(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
Write(*,*) "Se->Se Fd cFd Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Se Fd cFd Propagator: Sv" 
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
!  conj[Sv] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFdFdSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdSvR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv]'
      End Do 



!-------------- 
!  Ah 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MAh(i1) 
mass(2) = MAh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFdFdAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdAhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah'
      End Do 



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Se Fd cFd Propagator: hh" 
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
!  bar[Fu] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFu(i1) 
mass(2) = MFu(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFdFuSeL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu]'
      End Do 



!-------------- 
!  VZ, Sv 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MSv(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFdVZR(gt3,gt2))  
coup(4) = cplSeSvcSe(gt1,i2,iIN) 
coup(5) = Conjg(cplcFdFdcSvL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFdFdcSvR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fd cFd Propagator: VZ,Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Sv'
      End Do 



!-------------- 
!  VZ, conj[Sv] 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MSv(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFdVZR(gt3,gt2))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(5) = Conjg(cplcFdFdSvL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFdFdSvR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fd cFd Propagator: VZ,conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,conj[Sv]'
      End Do 



!-------------- 
!  VZ, Ah 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MAh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFdVZR(gt3,gt2))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(5) = Conjg(cplcFdFdAhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFdFdAhR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fd cFd Propagator: VZ,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Ah'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFdFdVZR(gt3,gt2))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Fd cFd Propagator: VZ,hh" 
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
!  VZ, bar[Fu] 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MFu2(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(gt3,i2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
coup(7) = Conjg(cplcFdFdVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFdFdVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 3*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: VZ,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,bar[Fu]'
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
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcFdFdcSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdcSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Sv,Sv" 
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
!  Sv, conj[Sv] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplcFdFdSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Sv,conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,conj[Sv]'
        End Do 
      End Do 



!-------------- 
!  Sv, Ah 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MAh(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Sv,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Ah'
        End Do 
      End Do 



!-------------- 
!  Sv, hh 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Sv,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,hh'
        End Do 
      End Do 



!-------------- 
!  Sv, bar[Fu] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(gt3,i2,gt1))  
coup(5) = cplSeSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFdFdcSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdcSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Sv,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], conj[Sv] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFdFdSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdSvR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplcFdFdSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: conj[Sv],conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],conj[Sv]'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Ah 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MAh(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFdFdSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdSvR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: conj[Sv],Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Ah'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], hh 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFdFdSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdSvR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: conj[Sv],hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],hh'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], bar[Fu] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(gt1,iIN,i1) 
coup(7) = Conjg(cplcFdFdSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: conj[Sv],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  Ah, Ah 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = MAh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFdFdAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdAhR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Ah,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Ah'
        End Do 
      End Do 



!-------------- 
!  Ah, hh 
!-------------- 
Do i1=1,2
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFdFdAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdAhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Ah,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,hh'
        End Do 
      End Do 



!-------------- 
!  Ah, bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MAh(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(gt3,i2,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFdFdAhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdAhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: Ah,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,bar[Fu]'
        End Do 
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
coup(1) = cplhhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFdFdhhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFdhhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFdFdhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFdhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: hh,hh" 
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
!  hh, bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(gt3,i2,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFdFdhhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFdhhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: hh,bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,bar[Fu]'
        End Do 
      End Do 



!-------------- 
!  bar[Fu], bar[Fu] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFu(i1)  
mass(2) = MFu(i2)  
coup(1) = cplcFuFdcSeL(i1,gt2,iIN) 
coup(2) = cplcFuFdcSeR(i1,gt2,iIN) 
coup(3) = cplcFdFuSeL(gt3,i1,gt1) 
coup(4) = cplcFdFuSeR(gt3,i1,gt1) 
coup(5) = cplcFuFdcSeL(i2,gt2,iIN) 
coup(6) = cplcFuFdcSeR(i2,gt2,iIN)  
coup(7) = cplcFdFuSeL(gt3,i2,gt1) 
coup(8) = cplcFdFuSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fd cFd Propagator: bar[Fu],bar[Fu]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='bar[Fu],bar[Fu]'
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:196))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSeFdcFd 
 
 
Subroutine SeToFeFecSe(iIN,MFe,MSe,MChi,cplChiFecSeL,cplChiFecSeR,cplFvFecSeL,        & 
& cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MSe(6),MChi(4)

Complex(dp),Intent(in) :: cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 49 
Allocate( gSum(3,3,6, Isum) ) 
Allocate( Contribution(3,3,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=1,6
Isum = 0 
 
rk2 = (MFe(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt2)/MSe(iIN))**2 
rj2 = (MSe(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSe(gt3))+Abs(MFe(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplChiFecSeL(i1,gt2,gt3)) 
coup(3) = Conjg(cplChiFecSeR(i1,gt2,gt3))
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFecSeL(i1,gt1,gt3)) 
coup(3) = Conjg(cplChiFecSeR(i1,gt1,gt3))
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFecSeL(i1,gt1,gt3) 
coup(4) = cplChiFecSeR(i1,gt1,gt3) 
coup(5) = cplChiFecSeL(i1,gt1,iIN) 
coup(6) = cplChiFecSeR(i1,gt1,iIN)  
coup(7) = cplChiFecSeL(i1,gt2,gt3) 
coup(8) = cplChiFecSeR(i1,gt2,gt3) 
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
Write(*,*) "Se->Fe Fe cSe Propagator: Chi" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplFvFecSeL(i1,gt2,gt3)) 
coup(3) = Conjg(cplFvFecSeR(i1,gt2,gt3))
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFecSeL(i1,gt1,gt3)) 
coup(3) = Conjg(cplFvFecSeR(i1,gt1,gt3))
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFecSeL(i1,gt1,gt3) 
coup(4) = cplFvFecSeR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i1,gt1,iIN) 
coup(6) = cplFvFecSeR(i1,gt1,iIN)  
coup(7) = cplFvFecSeL(i1,gt2,gt3) 
coup(8) = cplFvFecSeR(i1,gt2,gt3) 
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
Write(*,*) "Se->Fe Fe cSe Propagator: Fv" 
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
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFecSeL(i1,gt1,iIN) 
coup(2) = cplChiFecSeR(i1,gt1,iIN) 
coup(3) = cplChiFecSeL(i1,gt2,gt3) 
coup(4) = cplChiFecSeR(i1,gt2,gt3) 
coup(5) = cplChiFecSeL(i2,gt1,iIN) 
coup(6) = cplChiFecSeR(i2,gt1,iIN)  
coup(7) = cplChiFecSeL(i2,gt2,gt3) 
coup(8) = cplChiFecSeR(i2,gt2,gt3) 
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFecSeL(i1,gt1,gt3) 
coup(4) = cplChiFecSeR(i1,gt1,gt3) 
coup(5) = cplChiFecSeL(i2,gt1,iIN) 
coup(6) = cplChiFecSeR(i2,gt1,iIN)  
coup(7) = cplChiFecSeL(i2,gt2,gt3) 
coup(8) = cplChiFecSeR(i2,gt2,gt3) 
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFecSeL(i1,gt1,gt3) 
coup(4) = cplChiFecSeR(i1,gt1,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFecSeL(i2,gt1,gt3) 
coup(8) = cplChiFecSeR(i2,gt1,gt3) 
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
coup(1) = cplChiFecSeL(i1,gt1,iIN) 
coup(2) = cplChiFecSeR(i1,gt1,iIN) 
coup(3) = cplChiFecSeL(i1,gt2,gt3) 
coup(4) = cplChiFecSeR(i1,gt2,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFecSeL(i2,gt1,gt3) 
coup(8) = cplChiFecSeR(i2,gt1,gt3) 
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
Write(*,*) "Se->Fe Fe cSe Propagator: Chi,Chi" 
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



!-------------- 
!  Chi, Fv 
!-------------- 
Do i1=1,4
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt1,iIN) 
coup(2) = cplChiFecSeR(i1,gt1,iIN) 
coup(3) = cplChiFecSeL(i1,gt2,gt3) 
coup(4) = cplChiFecSeR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt1,iIN) 
coup(6) = cplFvFecSeR(i2,gt1,iIN)  
coup(7) = cplFvFecSeL(i2,gt2,gt3) 
coup(8) = cplFvFecSeR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFecSeL(i1,gt1,gt3) 
coup(4) = cplChiFecSeR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt1,iIN) 
coup(6) = cplFvFecSeR(i2,gt1,iIN)  
coup(7) = cplFvFecSeL(i2,gt2,gt3) 
coup(8) = cplFvFecSeR(i2,gt2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFecSeL(i1,gt1,gt3) 
coup(4) = cplChiFecSeR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFecSeL(i2,gt1,gt3) 
coup(8) = cplFvFecSeR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt1,iIN) 
coup(2) = cplChiFecSeR(i1,gt1,iIN) 
coup(3) = cplChiFecSeL(i1,gt2,gt3) 
coup(4) = cplChiFecSeR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFecSeL(i2,gt1,gt3) 
coup(8) = cplFvFecSeR(i2,gt1,gt3) 
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
Write(*,*) "Se->Fe Fe cSe Propagator: Chi,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Fv'
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
coup(1) = cplFvFecSeL(i1,gt1,iIN) 
coup(2) = cplFvFecSeR(i1,gt1,iIN) 
coup(3) = cplFvFecSeL(i1,gt2,gt3) 
coup(4) = cplFvFecSeR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt1,iIN) 
coup(6) = cplFvFecSeR(i2,gt1,iIN)  
coup(7) = cplFvFecSeL(i2,gt2,gt3) 
coup(8) = cplFvFecSeR(i2,gt2,gt3) 
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFecSeL(i1,gt1,gt3) 
coup(4) = cplFvFecSeR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt1,iIN) 
coup(6) = cplFvFecSeR(i2,gt1,iIN)  
coup(7) = cplFvFecSeL(i2,gt2,gt3) 
coup(8) = cplFvFecSeR(i2,gt2,gt3) 
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFecSeL(i1,gt1,gt3) 
coup(4) = cplFvFecSeR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFecSeL(i2,gt1,gt3) 
coup(8) = cplFvFecSeR(i2,gt1,gt3) 
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
coup(1) = cplFvFecSeL(i1,gt1,iIN) 
coup(2) = cplFvFecSeR(i1,gt1,iIN) 
coup(3) = cplFvFecSeL(i1,gt2,gt3) 
coup(4) = cplFvFecSeR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFecSeL(i2,gt1,gt3) 
coup(8) = cplFvFecSeR(i2,gt1,gt3) 
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
Write(*,*) "Se->Fe Fe cSe Propagator: Fv,Fv" 
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
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=1,6
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:49))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToFeFecSe 
 
 
Subroutine SeTocSuFeFu(iIN,MSu,MFe,MFu,MSd,MChi,MSe,cplSdcSecSu,cplChiFecSeL,         & 
& cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplFeFucSdL,cplFeFucSdR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSu(6),MFe(3),MFu(3),MSd(6),MChi(4),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 100 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSu(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MFe(gt2))+Abs(MSu(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSu Fe Fu Propagator: Sd" 
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
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFucSuL(i1,gt3,gt1)) 
coup(3) = Conjg(cplChiFucSuR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fe Fu Propagator: Chi" 
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
coup(1) = cplSdcSecSu(i1,iIN,gt1) 
coup(3) = Conjg(cplFeFucSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplFeFucSdR(gt2,gt3,i1))  
coup(4) = cplSdcSecSu(i2,iIN,gt1) 
coup(6) = Conjg(cplFeFucSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplFeFucSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fe Fu Propagator: Sd,Sd" 
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
!  Sd, Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFucSuL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChiFucSuR(i2,gt3,gt1))  
coup(5) = cplSdcSecSu(i1,iIN,gt1) 
coup(7) = Conjg(cplFeFucSdL(gt2,gt3,i1)) 
coup(6) = Conjg(cplFeFucSdR(gt2,gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fe Fu Propagator: Sd,Chi" 
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
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFucSuL(i1,gt3,gt1) 
coup(4) = cplChiFucSuR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFucSuL(i2,gt3,gt1) 
coup(8) = cplChiFucSuR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fe Fu Propagator: Chi,Chi" 
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:100))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTocSuFeFu 
 
 
Subroutine SeToSvFeFv(iIN,MSv,MFe,MVWm,MHpm,MSe,MChi,cplHpmSvcSe,cplSeSvcSe,          & 
& cplSvcSeVWm,cplcFeFeSvL,cplcFeFeSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,             & 
& cplChiFvSvR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFe(3),MVWm,MHpm(2),MSe(6),MChi(4)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplSeSvcSe(6,3,6),cplSvcSeVWm(3,6),cplcFeFeSvL(3,3,3),             & 
& cplcFeFeSvR(3,3,3),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),         & 
& cplChiFvSvR(4,3,3),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3)

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
mass(1) = MSe(iIN) 
 
Isum = 256 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MFe(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VWm 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVWm 
mass(2) = MVWm 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSvcSeVWm(gt1,iIN)) 
coup(3) = Conjg(cplFvFecVWmL(gt3,gt2)) 
coup(2) = Conjg(cplFvFecVWmR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: VWm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm'



!-------------- 
!  Hpm 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MHpm(i1) 
mass(2) = MHpm(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplFvFecHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecHpmR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm'
      End Do 



!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Sv Fe Fv Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFeSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFvSvL(i1,gt3,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Chi" 
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
!  VWm, Hpm 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MHpm(i2)  
coup(1) = cplSvcSeVWm(gt1,iIN) 
coup(2) = Conjg(cplFvFecVWmL(gt3,gt2)) 
coup(3) = Conjg(cplFvFecVWmR(gt3,gt2))  
coup(4) = cplHpmSvcSe(i2,gt1,iIN) 
coup(5) = Conjg(cplFvFecHpmL(gt3,gt2,i2)) 
coup(6) = Conjg(cplFvFecHpmR(gt3,gt2,i2))  
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
Write(*,*) "Se->Sv Fe Fv Propagator: VWm,Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Hpm'
      End Do 



!-------------- 
!  VWm, Se 
!-------------- 
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MSe(i2)  
coup(1) = cplSvcSeVWm(gt1,iIN) 
coup(2) = Conjg(cplFvFecVWmL(gt3,gt2)) 
coup(3) = Conjg(cplFvFecVWmR(gt3,gt2))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(5) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
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
Write(*,*) "Se->Sv Fe Fv Propagator: VWm,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Se'
      End Do 



!-------------- 
!  VWm, Fe 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MFe2(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFeSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(i2,gt2,gt1))  
coup(5) = cplSvcSeVWm(gt1,iIN) 
coup(7) = Conjg(cplFvFecVWmL(gt3,gt2)) 
coup(6) = Conjg(cplFvFecVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: VWm,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Fe'
      End Do 



!-------------- 
!  VWm, Chi 
!-------------- 
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MChi2(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i2,gt3,gt1))  
coup(5) = cplSvcSeVWm(gt1,iIN) 
coup(7) = Conjg(cplFvFecVWmL(gt3,gt2)) 
coup(6) = Conjg(cplFvFecVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: VWm,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Chi'
      End Do 



!-------------- 
!  Hpm, Hpm 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MHpm(i2)  
coup(1) = cplHpmSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplFvFecHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecHpmR(gt3,gt2,i1))  
coup(4) = cplHpmSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplFvFecHpmL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecHpmR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Hpm,Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Hpm'
        End Do 
      End Do 



!-------------- 
!  Hpm, Se 
!-------------- 
Do i1=1,2
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MSe(i2)  
coup(1) = cplHpmSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplFvFecHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecHpmR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Hpm,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Se'
        End Do 
      End Do 



!-------------- 
!  Hpm, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFeSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(i2,gt2,gt1))  
coup(5) = cplHpmSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Hpm,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Fe'
        End Do 
      End Do 



!-------------- 
!  Hpm, Chi 
!-------------- 
Do i1=1,2
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i2,gt3,gt1))  
coup(5) = cplHpmSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Hpm,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Chi'
        End Do 
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
coup(1) = cplSeSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFeSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFeSvR(i2,gt2,gt1))  
coup(5) = cplSeSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChiFvSvR(i2,gt3,gt1))  
coup(5) = cplSeSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Se,Chi" 
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
!  Fe, Fe 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFeSvL(i1,gt2,gt1) 
coup(4) = cplcFeFeSvR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFeSvL(i2,gt2,gt1) 
coup(8) = cplcFeFeSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Fe,Fe" 
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFeSvL(i1,gt2,gt1) 
coup(4) = cplcFeFeSvR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFvSvL(i2,gt3,gt1) 
coup(8) = cplChiFvSvR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Fe,Chi" 
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFvSvL(i1,gt3,gt1) 
coup(4) = cplChiFvSvR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFvSvL(i2,gt3,gt1) 
coup(8) = cplChiFvSvR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fe Fv Propagator: Chi,Chi" 
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
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:256))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSvFeFv 
 
 
Subroutine SeTocSvFeFv(iIN,MSv,MFe,MSe,MCha,MChi,cplSecSecSv,cplcChaFecSvL,           & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,        & 
& cplChiFvcSvR,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,            & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFe(3),MSe(6),MCha(2),MChi(4)

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
mass(1) = MSe(iIN) 
 
Isum = 225 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MFe(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSv Fe Fv Propagator: Se" 
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
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcChaFecSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcChaFecSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFecSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFecSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Fe" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplChiFvcSvL(i1,gt3,gt1)) 
coup(3) = Conjg(cplChiFvcSvR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Chi" 
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
coup(1) = cplSecSecSv(i1,iIN,gt1) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(i2,iIN,gt1) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Se,Se" 
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
!  Se, Cha 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i2,iIN) 
coup(2) = cplFvChacSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcChaFecSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcChaFecSvR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(i1,iIN,gt1) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Se,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Cha'
        End Do 
      End Do 



!-------------- 
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFecSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFecSvR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(i1,iIN,gt1) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplChiFvcSvL(i2,gt3,gt1)) 
coup(3) = Conjg(cplChiFvcSvR(i2,gt3,gt1))  
coup(5) = cplSecSecSv(i1,iIN,gt1) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Se,Chi" 
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
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFecSvL(i1,gt2,gt1) 
coup(4) = cplcChaFecSvR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaFecSvL(i2,gt2,gt1) 
coup(8) = cplcChaFecSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFecSvL(i1,gt2,gt1) 
coup(4) = cplcChaFecSvR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFecSvL(i2,gt2,gt1) 
coup(8) = cplcFeFecSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Cha,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Fe'
        End Do 
      End Do 



!-------------- 
!  Cha, Chi 
!-------------- 
Do i1=1,2
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MChi(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFecSvL(i1,gt2,gt1) 
coup(4) = cplcChaFecSvR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFvcSvL(i2,gt3,gt1) 
coup(8) = cplChiFvcSvR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Cha,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Chi'
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFecSvL(i1,gt2,gt1) 
coup(4) = cplcFeFecSvR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFecSvL(i2,gt2,gt1) 
coup(8) = cplcFeFecSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Fe,Fe" 
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFecSvL(i1,gt2,gt1) 
coup(4) = cplcFeFecSvR(i1,gt2,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFvcSvL(i2,gt3,gt1) 
coup(8) = cplChiFvcSvR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Fe,Chi" 
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplChiFvcSvL(i1,gt3,gt1) 
coup(4) = cplChiFvcSvR(i1,gt3,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplChiFvcSvL(i2,gt3,gt1) 
coup(8) = cplChiFvcSvR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fe Fv Propagator: Chi,Chi" 
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
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:225))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTocSvFeFv 
 
 
Subroutine SeToHpmFecCha(iIN,MHpm,MFe,MCha,MSv,MChi,MSe,cplHpmSvcSe,cplcChaChiHpmL,   & 
& cplcChaChiHpmR,cplcChaFecSvL,cplcChaFecSvR,cplChiFecSeL,cplChiFecSeR,deltaM,           & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MFe(3),MCha(2),MSv(3),MChi(4),MSe(6)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaFecSvL(2,3,3),  & 
& cplcChaFecSvR(2,3,3),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 49 
Allocate( gSum(2,3,2, Isum) ) 
Allocate( Contribution(2,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,2
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (MCha(gt3)/MSe(iIN))**2 
rj2 = (MHpm(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MCha(gt3))+Abs(MFe(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Hpm Fe cCha Propagator: Sv" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcChaChiHpmL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcChaChiHpmR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cCha Propagator: Chi" 
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
coup(1) = cplHpmSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
coup(4) = cplHpmSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcChaFecSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaFecSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cCha Propagator: Sv,Sv" 
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
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcChaChiHpmL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaChiHpmR(gt3,i2,gt1))  
coup(5) = cplHpmSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cCha Propagator: Sv,Chi" 
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplcChaChiHpmL(gt3,i1,gt1) 
coup(4) = cplcChaChiHpmR(gt3,i1,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplcChaChiHpmL(gt3,i2,gt1) 
coup(8) = cplcChaChiHpmR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cCha Propagator: Chi,Chi" 
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
      Do gt2=1,3
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:49))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToHpmFecCha 
 
 
Subroutine SeToSdFecFd(iIN,MSd,MFe,MFd,MSu,MChi,MSe,cplSdcSecSu,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplcFdFeSuL,cplcFdFeSuR,cplcFdFvSdL,cplcFdFvSdR,cplChiFecSeL,             & 
& cplChiFecSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFe(3),MFd(3),MSu(6),MChi(4),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFdFeSuL(3,3,6),        & 
& cplcFdFeSuR(3,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplChiFecSeL(4,3,6),          & 
& cplChiFecSeR(4,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (MFd(gt3)/MSe(iIN))**2 
rj2 = (MSd(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFd(gt3))+Abs(MFe(gt2))+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Su] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSu(i1) 
mass(2) = MSu(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFdFeSuL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFeSuR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Sd Fe cFd Propagator: Chi" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Sd Fe cFd Propagator: Fv" 
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
!  conj[Su], conj[Su] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSu(i1)  
mass(2) = MSu(i2)  
coup(1) = cplSdcSecSu(gt1,iIN,i1) 
coup(3) = Conjg(cplcFdFeSuL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFdFeSuR(gt3,gt2,i1))  
coup(4) = cplSdcSecSu(gt1,iIN,i2) 
coup(6) = Conjg(cplcFdFeSuL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFdFeSuR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: conj[Su],conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],conj[Su]'
        End Do 
      End Do 



!-------------- 
!  conj[Su], Chi 
!-------------- 
Do i1=1,6
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSu(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdChiSdL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdChiSdR(gt3,i2,gt1))  
coup(5) = cplSdcSecSu(gt1,iIN,i1) 
coup(7) = Conjg(cplcFdFeSuL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFeSuR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: conj[Su],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],Chi'
        End Do 
      End Do 



!-------------- 
!  conj[Su], Fv 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSu(i1)  
mass(1) = 0.  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFdFvSdL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFdFvSdR(gt3,i2,gt1))  
coup(5) = cplSdcSecSu(gt1,iIN,i1) 
coup(7) = Conjg(cplcFdFeSuL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFdFeSuR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: conj[Su],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Su],Fv'
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplcFdChiSdL(gt3,i1,gt1) 
coup(4) = cplcFdChiSdR(gt3,i1,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplcFdChiSdL(gt3,i2,gt1) 
coup(8) = cplcFdChiSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: Chi,Chi" 
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



!-------------- 
!  Chi, Fv 
!-------------- 
Do i1=1,4
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplcFdChiSdL(gt3,i1,gt1) 
coup(4) = cplcFdChiSdR(gt3,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplcFdFvSdL(gt3,i2,gt1) 
coup(8) = cplcFdFvSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: Chi,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Fv'
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplcFdFvSdL(gt3,i1,gt1) 
coup(4) = cplcFdFvSdR(gt3,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplcFdFvSdL(gt3,i2,gt1) 
coup(8) = cplcFdFvSdR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Fe cFd Propagator: Fv,Fv" 
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
End Subroutine SeToSdFecFd 
 
 
Subroutine SeToSeFecFe(iIN,MSe,MFe,MVZ,MSv,MAh,Mhh,MChi,cplAhSecSe,cplhhSecSe,        & 
& cplSecSecSv,cplSecSeVZ,cplSeSvcSe,cplcFeChiSeL,cplcFeChiSeR,cplcFeFeAhL,               & 
& cplcFeFeAhR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFvSeL,cplcFeFvSeR,cplChiFecSeL,              & 
& cplChiFecSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFe(3),MVZ,MSv(3),MAh(2),Mhh(2),MChi(4)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplhhSecSe(2,6,6),cplSecSecSv(6,6,3),cplSecSeVZ(6,6),               & 
& cplSeSvcSe(6,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),         & 
& cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVZL(3,3),             & 
& cplcFeFeVZR(3,3),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplChiFecSeL(4,3,6),            & 
& cplChiFecSeR(4,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 324 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MFe(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
Write(*,*) "Se->Se Fe cFe Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Se Fe cFe Propagator: Sv" 
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
!  conj[Sv] 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFeFeSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeSvR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv]'
      End Do 



!-------------- 
!  Ah 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MAh(i1) 
mass(2) = MAh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFeFeAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeAhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah'
      End Do 



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Se Fe cFe Propagator: hh" 
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
!  Chi 
!-------------- 
Do i1=1,4
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MChi(i1) 
mass(2) = MChi(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Se Fe cFe Propagator: Chi" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Se Fe cFe Propagator: Fv" 
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
!  VZ, Sv 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MSv(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFeVZR(gt3,gt2))  
coup(4) = cplSeSvcSe(gt1,i2,iIN) 
coup(5) = Conjg(cplcFeFecSvL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFeFecSvR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fe cFe Propagator: VZ,Sv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Sv'
      End Do 



!-------------- 
!  VZ, conj[Sv] 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MSv(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFeVZR(gt3,gt2))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(5) = Conjg(cplcFeFeSvL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFeFeSvR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fe cFe Propagator: VZ,conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,conj[Sv]'
      End Do 



!-------------- 
!  VZ, Ah 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MAh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFeVZR(gt3,gt2))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(5) = Conjg(cplcFeFeAhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFeFeAhR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fe cFe Propagator: VZ,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Ah'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFeFeVZR(gt3,gt2))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Fe cFe Propagator: VZ,hh" 
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
!  VZ, Chi 
!-------------- 
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MChi2(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
coup(7) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFeFeVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: VZ,Chi" 
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
!  VZ, Fv 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = 0._dp  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
coup(7) = Conjg(cplcFeFeVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFeFeVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 1*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: VZ,Fv" 
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
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeFecSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFecSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Sv,Sv" 
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
!  Sv, conj[Sv] 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplcFeFeSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFeSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Sv,conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,conj[Sv]'
        End Do 
      End Do 



!-------------- 
!  Sv, Ah 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MAh(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFeAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFeAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Sv,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Ah'
        End Do 
      End Do 



!-------------- 
!  Sv, hh 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFehhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFehhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Sv,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,hh'
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
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplSeSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Sv,Chi" 
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
!  Sv, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = 0.  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplSeSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Sv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Fv'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], conj[Sv] 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFeFeSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeSvR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(gt1,iIN,i2) 
coup(6) = Conjg(cplcFeFeSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFeSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: conj[Sv],conj[Sv]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],conj[Sv]'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Ah 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MAh(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFeFeSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeSvR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFeAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFeAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: conj[Sv],Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Ah'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], hh 
!-------------- 
Do i1=1,3
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplSecSecSv(gt1,iIN,i1) 
coup(3) = Conjg(cplcFeFeSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeSvR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFehhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFehhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: conj[Sv],hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],hh'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Chi 
!-------------- 
Do i1=1,3
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(gt1,iIN,i1) 
coup(7) = Conjg(cplcFeFeSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFeSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: conj[Sv],Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Chi'
        End Do 
      End Do 



!-------------- 
!  conj[Sv], Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = 0.  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplSecSecSv(gt1,iIN,i1) 
coup(7) = Conjg(cplcFeFeSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFeSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: conj[Sv],Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='conj[Sv],Fv'
        End Do 
      End Do 



!-------------- 
!  Ah, Ah 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = MAh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFeFeAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeAhR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFeAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFeAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Ah,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Ah'
        End Do 
      End Do 



!-------------- 
!  Ah, hh 
!-------------- 
Do i1=1,2
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFeFeAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFeAhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFehhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFehhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Ah,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,hh'
        End Do 
      End Do 



!-------------- 
!  Ah, Chi 
!-------------- 
Do i1=1,2
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MAh(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFeFeAhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFeAhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Ah,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Chi'
        End Do 
      End Do 



!-------------- 
!  Ah, Fv 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MAh(i1)  
mass(1) = 0.  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFeFeAhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFeAhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Ah,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Fv'
        End Do 
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
coup(1) = cplhhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFehhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFeFehhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFehhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: hh,hh" 
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
!  hh, Chi 
!-------------- 
Do i1=1,2
  Do i2=1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MChi(i2)  
coup(1) = cplChiFecSeL(i2,gt2,iIN) 
coup(2) = cplChiFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeChiSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeChiSeR(gt3,i2,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFehhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: hh,Chi" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,Chi'
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
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(gt3,i2,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFeFehhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFehhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: hh,Fv" 
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
!  Chi, Chi 
!-------------- 
Do i1=1,3
  Do i2=i1+1,4
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = MChi(i2)  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplcFeChiSeL(gt3,i1,gt1) 
coup(4) = cplcFeChiSeR(gt3,i1,gt1) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplcFeChiSeL(gt3,i2,gt1) 
coup(8) = cplcFeChiSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Chi,Chi" 
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



!-------------- 
!  Chi, Fv 
!-------------- 
Do i1=1,4
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MChi(i1)  
mass(2) = 0.  
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplcFeChiSeL(gt3,i1,gt1) 
coup(4) = cplcFeChiSeR(gt3,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplcFeFvSeL(gt3,i2,gt1) 
coup(8) = cplcFeFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Chi,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Chi,Fv'
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplcFeFvSeL(gt3,i1,gt1) 
coup(4) = cplcFeFvSeR(gt3,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplcFeFvSeL(gt3,i2,gt1) 
coup(8) = cplcFeFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cFe Propagator: Fv,Fv" 
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
      Do gt2=1,3
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:324))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSeFecFe 
 
 
Subroutine SeTocFuFeSu(iIN,MFu,MFe,MSu,MFd,MChi,MSe,cplcFdFeSuL,cplcFdFeSuR,          & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplChiFecSeL,cplChiFecSeR,         & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFu(3),MFe(3),MSu(6),MFd(3),MChi(4),MSe(6)

Complex(dp),Intent(in) :: cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),        & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 49 
Allocate( gSum(3,3,6, Isum) ) 
Allocate( Contribution(3,3,6, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,6
Isum = 0 
 
rk2 = (MFu(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt2)/MSe(iIN))**2 
rj2 = (MSu(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSu(gt3))+Abs(MFe(gt2))+Abs(MFu(gt1)))) Then 
!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFdFeSuL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFdFeSuR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Fe Su Propagator: Fd" 
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplChiFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplChiFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFuChiSuL(gt1,i1,gt3)) 
coup(3) = Conjg(cplcFuChiSuR(gt1,i1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Fe Su Propagator: Chi" 
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
!  Fd, Fd 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFd(i1)  
mass(2) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt1,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt1,i1,iIN) 
coup(3) = cplcFdFeSuL(i1,gt2,gt3) 
coup(4) = cplcFdFeSuR(i1,gt2,gt3) 
coup(5) = cplcFuFdcSeL(gt1,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt1,i2,iIN)  
coup(7) = cplcFdFeSuL(i2,gt2,gt3) 
coup(8) = cplcFdFeSuR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Fe Su Propagator: Fd,Fd" 
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
coup(1) = cplcFuFdcSeL(gt1,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt1,i1,iIN) 
coup(3) = cplcFdFeSuL(i1,gt2,gt3) 
coup(4) = cplcFdFeSuR(i1,gt2,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplcFuChiSuL(gt1,i2,gt3) 
coup(8) = cplcFuChiSuR(gt1,i2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Fe Su Propagator: Fd,Chi" 
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
coup(1) = cplChiFecSeL(i1,gt2,iIN) 
coup(2) = cplChiFecSeR(i1,gt2,iIN) 
coup(3) = cplcFuChiSuL(gt1,i1,gt3) 
coup(4) = cplcFuChiSuR(gt1,i1,gt3) 
coup(5) = cplChiFecSeL(i2,gt2,iIN) 
coup(6) = cplChiFecSeR(i2,gt2,iIN)  
coup(7) = cplcFuChiSuL(gt1,i2,gt3) 
coup(8) = cplcFuChiSuR(gt1,i2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Fe Su Propagator: Chi,Chi" 
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:49))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTocFuFeSu 
 
 
Subroutine SeToFeFecHpm(iIN,MFe,MHpm,MSe,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,       & 
& cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFe(3),MHpm(2),MSe(6)

Complex(dp),Intent(in) :: cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,2, Isum) ) 
Allocate( Contribution(3,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=2,2
Isum = 0 
 
rk2 = (MFe(gt1)/MSe(iIN))**2 
rm2 = (MFe(gt2)/MSe(iIN))**2 
rj2 = (MHpm(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MHpm(gt3))+Abs(MFe(gt2))+Abs(MFe(gt1)))) Then 
!-------------- 
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt1,iIN)) 
coup(4) = Conjg(cplFvFecHpmL(i1,gt2,gt3)) 
coup(3) = Conjg(cplFvFecHpmR(i1,gt2,gt3))
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplFvFecHpmL(i1,gt1,gt3)) 
coup(3) = Conjg(cplFvFecHpmR(i1,gt1,gt3))
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFecHpmL(i1,gt1,gt3) 
coup(4) = cplFvFecHpmR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i1,gt1,iIN) 
coup(6) = cplFvFecSeR(i1,gt1,iIN)  
coup(7) = cplFvFecHpmL(i1,gt2,gt3) 
coup(8) = cplFvFecHpmR(i1,gt2,gt3) 
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
Write(*,*) "Se->Fe Fe cHpm Propagator: Fv" 
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
coup(1) = cplFvFecSeL(i1,gt1,iIN) 
coup(2) = cplFvFecSeR(i1,gt1,iIN) 
coup(3) = cplFvFecHpmL(i1,gt2,gt3) 
coup(4) = cplFvFecHpmR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt1,iIN) 
coup(6) = cplFvFecSeR(i2,gt1,iIN)  
coup(7) = cplFvFecHpmL(i2,gt2,gt3) 
coup(8) = cplFvFecHpmR(i2,gt2,gt3) 
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFecHpmL(i1,gt1,gt3) 
coup(4) = cplFvFecHpmR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt1,iIN) 
coup(6) = cplFvFecSeR(i2,gt1,iIN)  
coup(7) = cplFvFecHpmL(i2,gt2,gt3) 
coup(8) = cplFvFecHpmR(i2,gt2,gt3) 
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplFvFecHpmL(i1,gt1,gt3) 
coup(4) = cplFvFecHpmR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFecHpmL(i2,gt1,gt3) 
coup(8) = cplFvFecHpmR(i2,gt1,gt3) 
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
coup(1) = cplFvFecSeL(i1,gt1,iIN) 
coup(2) = cplFvFecSeR(i1,gt1,iIN) 
coup(3) = cplFvFecHpmL(i1,gt2,gt3) 
coup(4) = cplFvFecHpmR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplFvFecHpmL(i2,gt1,gt3) 
coup(8) = cplFvFecHpmR(i2,gt1,gt3) 
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
Write(*,*) "Se->Fe Fe cHpm Propagator: Fv,Fv" 
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
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=2,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToFeFecHpm 
 
 
Subroutine SeToHpmFecFe(iIN,MHpm,MFe,MSv,MSe,cplHpmSvcSe,cplcFeFecSvL,cplcFeFecSvR,   & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MFe(3),MSv(3),MSe(6)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),       & 
& cplcFeFvHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 36 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=2,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (MFe(gt3)/MSe(iIN))**2 
rj2 = (MHpm(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFe(gt3))+Abs(MFe(gt2))+Abs(MHpm(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Hpm Fe cFe Propagator: Sv" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(gt3,i1,gt1)) 
coup(3) = Conjg(cplcFeFvHpmR(gt3,i1,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cFe Propagator: Fv" 
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
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplHpmSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
coup(4) = cplHpmSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcFeFecSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFeFecSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cFe Propagator: Sv,Sv" 
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
!  Sv, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = 0.  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcFeFvHpmL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcFeFvHpmR(gt3,i2,gt1))  
coup(5) = cplHpmSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcFeFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFeFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cFe Propagator: Sv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Fv'
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplcFeFvHpmL(gt3,i1,gt1) 
coup(4) = cplcFeFvHpmR(gt3,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplcFeFvHpmL(gt3,i2,gt1) 
coup(8) = cplcFeFvHpmR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Hpm Fe cFe Propagator: Fv,Fv" 
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
End Subroutine SeToHpmFecFe 
 
 
Subroutine SeToSeFecCha(iIN,MSe,MFe,MCha,MSv,cplSeSvcSe,cplcChaFecSvL,cplcChaFecSvR,  & 
& cplcChaFvSeL,cplcChaFvSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFe(3),MCha(2),MSv(3)

Complex(dp),Intent(in) :: cplSeSvcSe(6,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),      & 
& cplcChaFvSeR(2,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 36 
Allocate( gSum(6,3,2, Isum) ) 
Allocate( Contribution(6,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,2
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (MCha(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MCha(gt3))+Abs(MFe(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  Sv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSv(i1) 
mass(2) = MSv(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->Se Fe cCha Propagator: Sv" 
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
!  Fv 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = 0. 
mass(2) = 0. 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(i1,gt2,iIN)) 
coup(1) = Conjg(cplFvFecSeR(i1,gt2,iIN)) 
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
Write(*,*) "Se->Se Fe cCha Propagator: Fv" 
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
!  Sv, Sv 
!-------------- 
Do i1=1,2
  Do i2=i1+1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSv(i1)  
mass(2) = MSv(i2)  
coup(1) = cplSeSvcSe(gt1,i1,iIN) 
coup(3) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(gt1,i2,iIN) 
coup(6) = Conjg(cplcChaFecSvL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcChaFecSvR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cCha Propagator: Sv,Sv" 
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
!  Sv, Fv 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSv(i1)  
mass(1) = 0.  
coup(1) = cplFvFecSeL(i2,gt2,iIN) 
coup(2) = cplFvFecSeR(i2,gt2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(gt3,i2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(gt3,i2,gt1))  
coup(5) = cplSeSvcSe(gt1,i1,iIN) 
coup(7) = Conjg(cplcChaFecSvL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcChaFecSvR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cCha Propagator: Sv,Fv" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sv,Fv'
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
coup(1) = cplFvFecSeL(i1,gt2,iIN) 
coup(2) = cplFvFecSeR(i1,gt2,iIN) 
coup(3) = cplcChaFvSeL(gt3,i1,gt1) 
coup(4) = cplcChaFvSeR(gt3,i1,gt1) 
coup(5) = cplFvFecSeL(i2,gt2,iIN) 
coup(6) = cplFvFecSeR(i2,gt2,iIN)  
coup(7) = cplcChaFvSeL(gt3,i2,gt1) 
coup(8) = cplcChaFvSeR(gt3,i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fe cCha Propagator: Fv,Fv" 
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
      Do gt2=1,3
        Do gt3=1,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSeFecCha 
 
 
Subroutine SeTohhChaFv(iIN,Mhh,MCha,MSe,cplhhSecSe,cplcChaChahhL,cplcChaChahhR,       & 
& cplFvChacSeL,cplFvChacSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MCha(2),MSe(6)

Complex(dp),Intent(in) :: cplhhSecSe(2,6,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplFvChacSeL(3,2,6),      & 
& cplFvChacSeR(3,2,6)

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
mass(1) = MSe(iIN) 
 
Isum = 64 
Allocate( gSum(2,2,3, Isum) ) 
Allocate( Contribution(2,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (Mhh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MCha(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->hh Cha Fv Propagator: Se" 
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
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcChaChahhL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcChaChahhR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Cha Fv Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
coup(1) = cplhhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplFvChacSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvChacSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Cha Fv Propagator: Se,Se" 
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
!  Se, Cha 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i2,iIN) 
coup(2) = cplFvChacSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcChaChahhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcChaChahhR(i2,gt2,gt1))  
coup(5) = cplhhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Cha Fv Propagator: Se,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaChahhL(i1,gt2,gt1) 
coup(4) = cplcChaChahhR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaChahhL(i2,gt2,gt1) 
coup(8) = cplcChaChahhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Cha Fv Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
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
      Do gt2=1,2
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:64))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTohhChaFv 
 
 
Subroutine SeTocSuFdFv(iIN,MSu,MFd,MSd,MCha,MFe,MSe,cplSdcSecSu,cplcChaFdcSuL,        & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSu(6),MFd(3),MSd(6),MCha(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),     & 
& cplcFeFdcSuR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSu(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MFd(gt2))+Abs(MSu(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSu Fd Fv Propagator: Sd" 
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
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcChaFdcSuL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcChaFdcSuR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFdcSuL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFdcSuR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Fe" 
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
!  Sd, Sd 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSd(i1)  
mass(2) = MSd(i2)  
coup(1) = cplSdcSecSu(i1,iIN,gt1) 
coup(3) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFdcSdR(gt3,gt2,i1))  
coup(4) = cplSdcSecSu(i2,iIN,gt1) 
coup(6) = Conjg(cplFvFdcSdL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFdcSdR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Sd,Sd" 
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
!  Sd, Cha 
!-------------- 
Do i1=1,6
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i2,iIN) 
coup(2) = cplFvChacSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcChaFdcSuL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcChaFdcSuR(i2,gt2,gt1))  
coup(5) = cplSdcSecSu(i1,iIN,gt1) 
coup(7) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFdcSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Sd,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Cha'
        End Do 
      End Do 



!-------------- 
!  Sd, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSd(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFdcSuL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFdcSuR(i2,gt2,gt1))  
coup(5) = cplSdcSecSu(i1,iIN,gt1) 
coup(7) = Conjg(cplFvFdcSdL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFdcSdR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Sd,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Sd,Fe'
        End Do 
      End Do 



!-------------- 
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFdcSuL(i1,gt2,gt1) 
coup(4) = cplcChaFdcSuR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaFdcSuL(i2,gt2,gt1) 
coup(8) = cplcChaFdcSuR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFdcSuL(i1,gt2,gt1) 
coup(4) = cplcChaFdcSuR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt2,gt1) 
coup(8) = cplcFeFdcSuR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Cha,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Fe'
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFdcSuL(i1,gt2,gt1) 
coup(4) = cplcFeFdcSuR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFdcSuL(i2,gt2,gt1) 
coup(8) = cplcFeFdcSuR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Fd Fv Propagator: Fe,Fe" 
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:121))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTocSuFdFv 
 
 
Subroutine SeToSeFvFv(iIN,MSe,MVZ,MCha,MFe,cplSecSeVZ,cplcChaFvSeL,cplcChaFvSeR,      & 
& cplcFeFvSeL,cplcFeFvSeR,cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFvVZL,cplFvFvVZR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MVZ,MCha(2),MFe(3)

Complex(dp),Intent(in) :: cplSecSeVZ(6,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),           & 
& cplcFeFvSeR(3,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFvVZL(3,3),cplFvFvVZR(3,3)

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
mass(1) = MSe(iIN) 
 
Isum = 36 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=gt2,3
Isum = 0 
 
rk2 = (0./MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(0.)+Abs(MSe(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
Write(*,*) "Se->Se Fv Fv Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcChaFvSeL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcChaFvSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MCha(i1)  
mass(2) = MCha(i1)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt2,gt1) 
coup(4) = cplcChaFvSeR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt2,i1,iIN) 
coup(6) = cplFvChacSeR(gt2,i1,iIN)  
coup(7) = cplcChaFvSeL(i1,gt3,gt1) 
coup(8) = cplcChaFvSeR(i1,gt3,gt1) 
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
Write(*,*) "Se->Se Fv Fv Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFvSeL(i1,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i1,gt3,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFeFvSeL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MFe(i1)  
mass(2) = MFe(i1)  
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt2,gt1) 
coup(4) = cplcFeFvSeR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt2,i1,iIN) 
coup(6) = cplFvFecSeR(gt2,i1,iIN)  
coup(7) = cplcFeFvSeL(i1,gt3,gt1) 
coup(8) = cplcFeFvSeR(i1,gt3,gt1) 
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
Write(*,*) "Se->Se Fv Fv Propagator: Fe" 
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
!  VZ, Cha 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MCha2(i2)  
coup(1) = cplFvChacSeL(gt2,i2,iIN) 
coup(2) = cplFvChacSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(i2,gt3,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
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
mass(1) = MCha2(i2)  
coup(1) = cplFvChacSeL(gt3,i2,iIN) 
coup(2) = cplFvChacSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcChaFvSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcChaFvSeR(i2,gt2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
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
Write(*,*) "Se->Se Fv Fv Propagator: VZ,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Cha'
      End Do 



!-------------- 
!  VZ, Fe 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MFe2(i2)  
coup(1) = cplFvFecSeL(gt2,i2,iIN) 
coup(2) = cplFvFecSeR(gt2,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt3,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt3,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
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
mass(1) = MFe2(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFvSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFvSeR(i2,gt2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
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
Write(*,*) "Se->Se Fv Fv Propagator: VZ,Fe" 
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
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt2,i1,iIN) 
coup(2) = cplFvChacSeR(gt2,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt3,gt1) 
coup(4) = cplcChaFvSeR(i1,gt3,gt1) 
coup(5) = cplFvChacSeL(gt2,i2,iIN) 
coup(6) = cplFvChacSeR(gt2,i2,iIN)  
coup(7) = cplcChaFvSeL(i2,gt3,gt1) 
coup(8) = cplcChaFvSeR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt2,gt1) 
coup(4) = cplcChaFvSeR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt2,i2,iIN) 
coup(6) = cplFvChacSeR(gt2,i2,iIN)  
coup(7) = cplcChaFvSeL(i2,gt3,gt1) 
coup(8) = cplcChaFvSeR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt2,gt1) 
coup(4) = cplcChaFvSeR(i1,gt2,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaFvSeL(i2,gt2,gt1) 
coup(8) = cplcChaFvSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt2,i1,iIN) 
coup(2) = cplFvChacSeR(gt2,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt3,gt1) 
coup(4) = cplcChaFvSeR(i1,gt3,gt1) 
coup(5) = cplFvChacSeL(gt3,i2,iIN) 
coup(6) = cplFvChacSeR(gt3,i2,iIN)  
coup(7) = cplcChaFvSeL(i2,gt2,gt1) 
coup(8) = cplcChaFvSeR(i2,gt2,gt1) 
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
Write(*,*) "Se->Se Fv Fv Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt2,i1,iIN) 
coup(2) = cplFvChacSeR(gt2,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt3,gt1) 
coup(4) = cplcChaFvSeR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(gt2,i2,iIN) 
coup(6) = cplFvFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt3,gt1) 
coup(8) = cplcFeFvSeR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt2,gt1) 
coup(4) = cplcChaFvSeR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt2,i2,iIN) 
coup(6) = cplFvFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt3,gt1) 
coup(8) = cplcFeFvSeR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt3,i1,iIN) 
coup(2) = cplFvChacSeR(gt3,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt2,gt1) 
coup(4) = cplcChaFvSeR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt2,gt1) 
coup(8) = cplcFeFvSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt2,i1,iIN) 
coup(2) = cplFvChacSeR(gt2,i1,iIN) 
coup(3) = cplcChaFvSeL(i1,gt3,gt1) 
coup(4) = cplcChaFvSeR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt2,gt1) 
coup(8) = cplcFeFvSeR(i2,gt2,gt1) 
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
Write(*,*) "Se->Se Fv Fv Propagator: Cha,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Fe'
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
coup(1) = cplFvFecSeL(gt2,i1,iIN) 
coup(2) = cplFvFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt3,gt1) 
coup(4) = cplcFeFvSeR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(gt2,i2,iIN) 
coup(6) = cplFvFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt3,gt1) 
coup(8) = cplcFeFvSeR(i2,gt3,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt2,gt1) 
coup(4) = cplcFeFvSeR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt2,i2,iIN) 
coup(6) = cplFvFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt3,gt1) 
coup(8) = cplcFeFvSeR(i2,gt3,gt1) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt2,gt1) 
coup(4) = cplcFeFvSeR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt2,gt1) 
coup(8) = cplcFeFvSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt3.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt2,i1,iIN) 
coup(2) = cplFvFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvSeL(i1,gt3,gt1) 
coup(4) = cplcFeFvSeR(i1,gt3,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFvSeL(i2,gt2,gt1) 
coup(8) = cplcFeFvSeR(i2,gt2,gt1) 
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
Write(*,*) "Se->Se Fv Fv Propagator: Fe,Fe" 
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
      Do gt2=1,3
        Do gt3=gt2,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:36))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSeFvFv 
 
 
Subroutine SeToFvSdcFu(iIN,MSd,MFu,MCha,MFe,MFd,MSe,cplcChacFuSdL,cplcChacFuSdR,      & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MFu(3),MCha(2),MFe(3),MFd(3),MSe(6)

Complex(dp),Intent(in) :: cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),      & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),       & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (0./MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSd(gt2)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MSd(gt2))+Abs(0.))) Then 
!-------------- 
!  Cha 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MCha(i1) 
mass(2) = MCha(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvChacSeL(gt1,i1,iIN)) 
coup(1) = Conjg(cplFvChacSeR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcChacFuSdL(i1,gt3,gt2)) 
coup(3) = Conjg(cplcChacFuSdR(i1,gt3,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt1,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFecFuSdL(i1,gt3,gt2)) 
coup(3) = Conjg(cplcFecFuSdR(i1,gt3,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Fe" 
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
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFvSdL(i1,gt1,gt2)) 
coup(3) = Conjg(cplcFdFvSdR(i1,gt1,gt2))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Fd" 
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
!  Cha, Cha 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MCha(i2)  
coup(1) = cplFvChacSeL(gt1,i1,iIN) 
coup(2) = cplFvChacSeR(gt1,i1,iIN) 
coup(3) = cplcChacFuSdL(i1,gt3,gt2) 
coup(4) = cplcChacFuSdR(i1,gt3,gt2) 
coup(5) = cplFvChacSeL(gt1,i2,iIN) 
coup(6) = cplFvChacSeR(gt1,i2,iIN)  
coup(7) = cplcChacFuSdL(i2,gt3,gt2) 
coup(8) = cplcChacFuSdR(i2,gt3,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Cha,Cha" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Cha'
        End Do 
      End Do 



!-------------- 
!  Cha, Fe 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvChacSeL(gt1,i1,iIN) 
coup(2) = cplFvChacSeR(gt1,i1,iIN) 
coup(3) = cplcChacFuSdL(i1,gt3,gt2) 
coup(4) = cplcChacFuSdR(i1,gt3,gt2) 
coup(5) = cplFvFecSeL(gt1,i2,iIN) 
coup(6) = cplFvFecSeR(gt1,i2,iIN)  
coup(7) = cplcFecFuSdL(i2,gt3,gt2) 
coup(8) = cplcFecFuSdR(i2,gt3,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Cha,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Fe'
        End Do 
      End Do 



!-------------- 
!  Cha, Fd 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MCha(i1)  
mass(2) = MFd(i2)  
coup(1) = cplFvChacSeL(gt1,i1,iIN) 
coup(2) = cplFvChacSeR(gt1,i1,iIN) 
coup(3) = cplcChacFuSdL(i1,gt3,gt2) 
coup(4) = cplcChacFuSdR(i1,gt3,gt2) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFvSdL(i2,gt1,gt2) 
coup(8) = cplcFdFvSdR(i2,gt1,gt2) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Cha,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Cha,Fd'
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
coup(1) = cplFvFecSeL(gt1,i1,iIN) 
coup(2) = cplFvFecSeR(gt1,i1,iIN) 
coup(3) = cplcFecFuSdL(i1,gt3,gt2) 
coup(4) = cplcFecFuSdR(i1,gt3,gt2) 
coup(5) = cplFvFecSeL(gt1,i2,iIN) 
coup(6) = cplFvFecSeR(gt1,i2,iIN)  
coup(7) = cplcFecFuSdL(i2,gt3,gt2) 
coup(8) = cplcFecFuSdR(i2,gt3,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Fe,Fe" 
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
!  Fe, Fd 
!-------------- 
Do i1=1,3
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MFe(i1)  
mass(2) = MFd(i2)  
coup(1) = cplFvFecSeL(gt1,i1,iIN) 
coup(2) = cplFvFecSeR(gt1,i1,iIN) 
coup(3) = cplcFecFuSdL(i1,gt3,gt2) 
coup(4) = cplcFecFuSdR(i1,gt3,gt2) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFvSdL(i2,gt1,gt2) 
coup(8) = cplcFdFvSdR(i2,gt1,gt2) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Fe,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Fe,Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdFvSdL(i1,gt1,gt2) 
coup(4) = cplcFdFvSdR(i1,gt1,gt2) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFvSdL(i2,gt1,gt2) 
coup(8) = cplcFdFvSdR(i2,gt1,gt2) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Fv Sd cFu Propagator: Fd,Fd" 
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
End Subroutine SeToFvSdcFu 
 
 
Subroutine SeToSvChaFv(iIN,MSv,MCha,MSe,MFe,cplSeSvcSe,cplcFeChaSvL,cplcFeChaSvR,     & 
& cplFvChacSeL,cplFvChacSeR,cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MCha(2),MSe(6),MFe(3)

Complex(dp),Intent(in) :: cplSeSvcSe(6,3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplFvChacSeL(3,2,6),        & 
& cplFvChacSeR(3,2,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 81 
Allocate( gSum(3,2,3, Isum) ) 
Allocate( Contribution(3,2,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,2
        Do gt3=1,3
Isum = 0 
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MCha(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Sv Cha Fv Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->Sv Cha Fv Propagator: Fe" 
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
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSeSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplFvChacSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvChacSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Fv Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeChaSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeChaSvR(i2,gt2,gt1))  
coup(5) = cplSeSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Fv Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeChaSvL(i1,gt2,gt1) 
coup(4) = cplcFeChaSvR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeChaSvL(i2,gt2,gt1) 
coup(8) = cplcFeChaSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Cha Fv Propagator: Fe,Fe" 
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
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSvChaFv 
 
 
Subroutine SeTohhFeFv(iIN,Mhh,MFe,MSe,cplhhSecSe,cplcFeFehhL,cplcFeFehhR,             & 
& cplFvFecSeL,cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: Mhh(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplhhSecSe(2,6,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplFvFecSeL(3,3,6),           & 
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
mass(1) = MSe(iIN) 
 
Isum = 81 
Allocate( gSum(2,3,3, Isum) ) 
Allocate( Contribution(2,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,2
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFe(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (Mhh(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MFe(gt2))+Abs(Mhh(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(gt1,i1,iIN)) 
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
Write(*,*) "Se->hh Fe Fv Propagator: Se" 
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
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->hh Fe Fv Propagator: Fe" 
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
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplhhSecSe(gt1,i1,iIN) 
coup(3) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(gt1,i2,iIN) 
coup(6) = Conjg(cplFvFecSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvFecSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fe Fv Propagator: Se,Se" 
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
!  Se, Fe 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFe(i2)  
coup(1) = cplFvFecSeL(gt3,i2,iIN) 
coup(2) = cplFvFecSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFeFehhL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFeFehhR(i2,gt2,gt1))  
coup(5) = cplhhSecSe(gt1,i1,iIN) 
coup(7) = Conjg(cplFvFecSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplFvFecSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fe Fv Propagator: Se,Fe" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fe'
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
coup(1) = cplFvFecSeL(gt3,i1,iIN) 
coup(2) = cplFvFecSeR(gt3,i1,iIN) 
coup(3) = cplcFeFehhL(i1,gt2,gt1) 
coup(4) = cplcFeFehhR(i1,gt2,gt1) 
coup(5) = cplFvFecSeL(gt3,i2,iIN) 
coup(6) = cplFvFecSeR(gt3,i2,iIN)  
coup(7) = cplcFeFehhL(i2,gt2,gt1) 
coup(8) = cplcFeFehhR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->hh Fe Fv Propagator: Fe,Fe" 
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
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTohhFeFv 
 
 
Subroutine SeToFvFvHpm(iIN,MHpm,MFe,MSe,cplcFeFvHpmL,cplcFeFvHpmR,cplFvFecSeL,        & 
& cplFvFecSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MHpm(2),MFe(3),MSe(6)

Complex(dp),Intent(in) :: cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 9 
Allocate( gSum(3,3,2, Isum) ) 
Allocate( Contribution(3,3,2, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=gt1,3
        Do gt3=2,2
Isum = 0 
 
rk2 = (0./MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MHpm(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MHpm(gt3))+Abs(0.)+Abs(0.))) Then 
!-------------- 
!  Fe 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt1,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt1,i1,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(i1,gt2,gt3)) 
coup(3) = Conjg(cplcFeFvHpmR(i1,gt2,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MFe(i1) 
mass(2) = MFe(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplFvFecSeL(gt2,i1,iIN)) 
coup(1) = Conjg(cplFvFecSeR(gt2,i1,iIN)) 
coup(4) = Conjg(cplcFeFvHpmL(i1,gt1,gt3)) 
coup(3) = Conjg(cplcFeFvHpmR(i1,gt1,gt3))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
 
 mass(1) = MFe(i1)  
mass(2) = MFe(i1)  
coup(1) = cplFvFecSeL(gt2,i1,iIN) 
coup(2) = cplFvFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt1,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(gt1,i1,iIN) 
coup(6) = cplFvFecSeR(gt1,i1,iIN)  
coup(7) = cplcFeFvHpmL(i1,gt2,gt3) 
coup(8) = cplcFeFvHpmR(i1,gt2,gt3) 
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
Write(*,*) "Se->Fv Fv Hpm Propagator: Fe" 
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
coup(1) = cplFvFecSeL(gt1,i1,iIN) 
coup(2) = cplFvFecSeR(gt1,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt2,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(gt1,i2,iIN) 
coup(6) = cplFvFecSeR(gt1,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt2,gt3) 
coup(8) = cplcFeFvHpmR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt2,i1,iIN) 
coup(2) = cplFvFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt1,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(gt1,i2,iIN) 
coup(6) = cplFvFecSeR(gt1,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt2,gt3) 
coup(8) = cplcFeFvHpmR(i2,gt2,gt3) 
Call IntegrateChiChiInterference(mass,m_in,r_outcrossed,coup,smin2,smax2,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt2,i1,iIN) 
coup(2) = cplFvFecSeR(gt2,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt1,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt1,gt3) 
coup(5) = cplFvFecSeL(gt2,i2,iIN) 
coup(6) = cplFvFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt1,gt3) 
coup(8) = cplcFeFvHpmR(i2,gt1,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
If (gt1.Eq.gt2) Then 
resC=resC/2._dp 
End If
resS = resS + resC 
mass(1) = MFe(i1)  
mass(2) = MFe(i2)  
coup(1) = cplFvFecSeL(gt1,i1,iIN) 
coup(2) = cplFvFecSeR(gt1,i1,iIN) 
coup(3) = cplcFeFvHpmL(i1,gt2,gt3) 
coup(4) = cplcFeFvHpmR(i1,gt2,gt3) 
coup(5) = cplFvFecSeL(gt2,i2,iIN) 
coup(6) = cplFvFecSeR(gt2,i2,iIN)  
coup(7) = cplcFeFvHpmL(i2,gt1,gt3) 
coup(8) = cplcFeFvHpmR(i2,gt1,gt3) 
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
Write(*,*) "Se->Fv Fv Hpm Propagator: Fe,Fe" 
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
      Do gt2=gt1,3
        Do gt3=2,2
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:9))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToFvFvHpm 
 
 
Subroutine SeToSdGlucFu(iIN,MSd,MGlu,MFu,MSu,MFd,MSe,cplSdcSecSu,cplcFdGluSdL,        & 
& cplcFdGluSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuGluSuL,cplcFuGluSuR,deltaM,               & 
& epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSd(6),MGlu,MFu(3),MSu(6),MFd(3),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuFdcSeL(3,3,6),           & 
& cplcFuFdcSeR(3,3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6)

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
mass(1) = MSe(iIN) 
 
Isum = 81 
Allocate( gSum(6,1,3, Isum) ) 
Allocate( Contribution(6,1,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,6
        Do gt3=1,3
Isum = 0 
 
rk2 = (MGlu/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSd(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MGlu)+Abs(MSd(gt1)))) Then 
!-------------- 
!  conj[Su] 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSu(i1) 
mass(2) = MSu(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(gt1,iIN,i1)) 
coup(3) = Conjg(cplcFuGluSuL(gt3,i1)) 
coup(2) = Conjg(cplcFuGluSuR(gt3,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Glu cFu Propagator: conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp
Else 
gSum(gt1,1,gt3,Isum)=resD
End If 
Contribution(gt1,1,gt3,Isum)='conj[Su]'
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
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->Sd Glu cFu Propagator: Fd" 
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
!  conj[Su], conj[Su] 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSu(i1)  
mass(2) = MSu(i2)  
coup(1) = cplSdcSecSu(gt1,iIN,i1) 
coup(3) = Conjg(cplcFuGluSuL(gt3,i1)) 
coup(2) = Conjg(cplcFuGluSuR(gt3,i1))  
coup(4) = cplSdcSecSu(gt1,iIN,i2) 
coup(6) = Conjg(cplcFuGluSuL(gt3,i2)) 
coup(5) = Conjg(cplcFuGluSuR(gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Glu cFu Propagator: conj[Su],conj[Su]" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp  
Else 
gSum(gt1,1,gt3,Isum)= resS  
End If 
Contribution(gt1,1,gt3,Isum)='conj[Su],conj[Su]'
        End Do 
      End Do 



!-------------- 
!  conj[Su], Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSu(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdGluSdL(i2,gt1)) 
coup(3) = Conjg(cplcFdGluSdR(i2,gt1))  
coup(5) = cplSdcSecSu(gt1,iIN,i1) 
coup(7) = Conjg(cplcFuGluSuL(gt3,i1)) 
coup(6) = Conjg(cplcFuGluSuR(gt3,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Glu cFu Propagator: conj[Su],Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,1,gt3,Isum)= 0._dp  
Else 
gSum(gt1,1,gt3,Isum)= resS  
End If 
Contribution(gt1,1,gt3,Isum)='conj[Su],Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdGluSdL(i1,gt1) 
coup(4) = cplcFdGluSdR(i1,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdGluSdL(i2,gt1) 
coup(8) = cplcFdGluSdR(i2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 4*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sd Glu cFu Propagator: Fd,Fd" 
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
End Subroutine SeToSdGlucFu 
 
 
Subroutine SeToSeFucFu(iIN,MSe,MFu,MVZ,MAh,Mhh,MFd,cplAhSecSe,cplhhSecSe,             & 
& cplSecSeVZ,cplcFdFuSeL,cplcFdFuSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,deltaM,epsI,               & 
& check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSe(6),MFu(3),MVZ,MAh(2),Mhh(2),MFd(3)

Complex(dp),Intent(in) :: cplAhSecSe(2,6,6),cplhhSecSe(2,6,6),cplSecSeVZ(6,6),cplcFdFuSeL(3,3,6),               & 
& cplcFdFuSeR(3,3,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFuAhL(3,3,2),         & 
& cplcFuFuAhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVZL(3,3),             & 
& cplcFuFuVZR(3,3)

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
mass(1) = MSe(iIN) 
 
Isum = 64 
Allocate( gSum(6,3,3, Isum) ) 
Allocate( Contribution(6,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1, iIN-1
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFu(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSe(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MFu(gt2))+Abs(MSe(gt1)))) Then 
!-------------- 
!  VZ 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVZ 
mass(2) = MVZ 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSeVZ(gt1,iIN)) 
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
Write(*,*) "Se->Se Fu cFu Propagator: VZ" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ'



!-------------- 
!  Ah 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MAh(i1) 
mass(2) = MAh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplAhSecSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFuFuAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFuAhR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah'
      End Do 



!-------------- 
!  hh 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = Mhh(i1) 
mass(2) = Mhh(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplhhSecSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Se Fu cFu Propagator: hh" 
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
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
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
Write(*,*) "Se->Se Fu cFu Propagator: Fd" 
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
!  VZ, Ah 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = MAh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFuFuVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFuFuVZR(gt3,gt2))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(5) = Conjg(cplcFuFuAhL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFuFuAhR(gt3,gt2,i2))  
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
Write(*,*) "Se->Se Fu cFu Propagator: VZ,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Ah'
      End Do 



!-------------- 
!  VZ, hh 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ  
mass(1) = Mhh(i2)  
coup(1) = cplSecSeVZ(gt1,iIN) 
coup(2) = Conjg(cplcFuFuVZL(gt3,gt2)) 
coup(3) = Conjg(cplcFuFuVZR(gt3,gt2))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
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
Write(*,*) "Se->Se Fu cFu Propagator: VZ,hh" 
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
!  VZ, Fd 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVZ2  
mass(1) = MFd2(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i2,gt2,gt1))  
coup(5) = cplSecSeVZ(gt1,iIN) 
coup(7) = Conjg(cplcFuFuVZL(gt3,gt2)) 
coup(6) = Conjg(cplcFuFuVZR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 3*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: VZ,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VZ,Fd'
      End Do 



!-------------- 
!  Ah, Ah 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = MAh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFuAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFuAhR(gt3,gt2,i1))  
coup(4) = cplAhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFuAhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFuAhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: Ah,Ah" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Ah'
        End Do 
      End Do 



!-------------- 
!  Ah, hh 
!-------------- 
Do i1=1,2
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MAh(i1)  
mass(2) = Mhh(i2)  
coup(1) = cplAhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFuAhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFuAhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFuhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFuhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: Ah,hh" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,hh'
        End Do 
      End Do 



!-------------- 
!  Ah, Fd 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MAh(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i2,gt2,gt1))  
coup(5) = cplAhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFuFuAhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFuAhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: Ah,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Ah,Fd'
        End Do 
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
coup(1) = cplhhSecSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFuhhL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFuhhR(gt3,gt2,i1))  
coup(4) = cplhhSecSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFuhhL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFuhhR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: hh,hh" 
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
!  hh, Fd 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = Mhh(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFuSeL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFuSeR(i2,gt2,gt1))  
coup(5) = cplhhSecSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFuFuhhL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFuhhR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: hh,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='hh,Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdFuSeL(i1,gt2,gt1) 
coup(4) = cplcFdFuSeR(i1,gt2,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFuSeL(i2,gt2,gt1) 
coup(8) = cplcFdFuSeR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Se Fu cFu Propagator: Fd,Fd" 
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
End Subroutine SeToSeFucFu 
 
 
Subroutine SeToSvFdcFu(iIN,MSv,MFd,MFu,MVWm,MHpm,MSe,cplHpmSvcSe,cplSeSvcSe,          & 
& cplSvcSeVWm,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,          & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFd(3),MFu(3),MVWm,MHpm(2),MSe(6)

Complex(dp),Intent(in) :: cplHpmSvcSe(2,3,6),cplSeSvcSe(6,3,6),cplSvcSeVWm(3,6),cplcFdFdSvL(3,3,3),             & 
& cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),      & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3)

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
mass(1) = MSe(iIN) 
 
Isum = 144 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MFd(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  VWm 
!-------------- 
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MVWm 
mass(2) = MVWm 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSvcSeVWm(gt1,iIN)) 
coup(3) = Conjg(cplcFuFdcVWmL(gt3,gt2)) 
coup(2) = Conjg(cplcFuFdcVWmR(gt3,gt2))
coup(4:6) = coup(1:3) 
Call IntegrateVV(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: VWm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm'



!-------------- 
!  Hpm 
!-------------- 
Do i1=1,2
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MHpm(i1) 
mass(2) = MHpm(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplHpmSvcSe(i1,gt1,iIN)) 
coup(3) = Conjg(cplcFuFdcHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcHpmR(gt3,gt2,i1))
coup(4:6) = coup(1:3) 
Call IntegrateSaSa(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp
Else 
gSum(gt1,gt2,gt3,Isum)=resD
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm'
      End Do 



!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSeSvcSe(i1,gt1,iIN)) 
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
Write(*,*) "Se->Sv Fd cFu Propagator: Se" 
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
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFdSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Fd" 
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
!  VWm, Hpm 
!-------------- 
  Do i2=1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MHpm(i2)  
coup(1) = cplSvcSeVWm(gt1,iIN) 
coup(2) = Conjg(cplcFuFdcVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcFuFdcVWmR(gt3,gt2))  
coup(4) = cplHpmSvcSe(i2,gt1,iIN) 
coup(5) = Conjg(cplcFuFdcHpmL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFuFdcHpmR(gt3,gt2,i2))  
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
Write(*,*) "Se->Sv Fd cFu Propagator: VWm,Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Hpm'
      End Do 



!-------------- 
!  VWm, Se 
!-------------- 
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm  
mass(1) = MSe(i2)  
coup(1) = cplSvcSeVWm(gt1,iIN) 
coup(2) = Conjg(cplcFuFdcVWmL(gt3,gt2)) 
coup(3) = Conjg(cplcFuFdcVWmR(gt3,gt2))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(5) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
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
Write(*,*) "Se->Sv Fd cFu Propagator: VWm,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Se'
      End Do 



!-------------- 
!  VWm, Fd 
!-------------- 
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MVWm2  
mass(1) = MFd2(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFdSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(i2,gt2,gt1))  
coup(5) = cplSvcSeVWm(gt1,iIN) 
coup(7) = Conjg(cplcFuFdcVWmL(gt3,gt2)) 
coup(6) = Conjg(cplcFuFdcVWmR(gt3,gt2))  
Call IntegrateVF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
resC = 3*resC  ! Color factor 
If (resC.ne.resC) resC = 0._dp
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: VWm,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='VWm,Fd'
      End Do 



!-------------- 
!  Hpm, Hpm 
!-------------- 
Do i1=1,1
  Do i2=i1+1,2
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MHpm(i2)  
coup(1) = cplHpmSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFdcHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcHpmR(gt3,gt2,i1))  
coup(4) = cplHpmSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFdcHpmL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcHpmR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Hpm,Hpm" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Hpm'
        End Do 
      End Do 



!-------------- 
!  Hpm, Se 
!-------------- 
Do i1=1,2
  Do i2=1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MHpm(i1)  
mass(2) = MSe(i2)  
coup(1) = cplHpmSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFdcHpmL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcHpmR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Hpm,Se" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Se'
        End Do 
      End Do 



!-------------- 
!  Hpm, Fd 
!-------------- 
Do i1=1,2
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MHpm(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFdSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(i2,gt2,gt1))  
coup(5) = cplHpmSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFuFdcHpmL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcHpmR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Hpm,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Hpm,Fd'
        End Do 
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
coup(1) = cplSeSvcSe(i1,gt1,iIN) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
coup(4) = cplSeSvcSe(i2,gt1,iIN) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Se,Se" 
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
!  Se, Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFdSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdSvR(i2,gt2,gt1))  
coup(5) = cplSeSvcSe(i1,gt1,iIN) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Se,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdFdSvL(i1,gt2,gt1) 
coup(4) = cplcFdFdSvR(i1,gt2,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFdSvL(i2,gt2,gt1) 
coup(8) = cplcFdFdSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->Sv Fd cFu Propagator: Fd,Fd" 
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
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:144))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeToSvFdcFu 
 
 
Subroutine SeTocFuChaSu(iIN,MFu,MCha,MSu,MFd,MSe,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFu(3),MCha(2),MSu(6),MFd(3),MSe(6)

Complex(dp),Intent(in) :: cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MFu(gt1)/MSe(iIN))**2 
rm2 = (MCha(gt2)/MSe(iIN))**2 
rj2 = (MSu(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MSu(gt3))+Abs(MCha(gt2))+Abs(MFu(gt1)))) Then 
!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt1,i1,iIN)) 
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
Write(*,*) "Se->cFu Cha Su Propagator: Fd" 
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
coup(1) = cplcFuFdcSeL(gt1,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt1,i1,iIN) 
coup(3) = cplcFdChaSuL(i1,gt2,gt3) 
coup(4) = cplcFdChaSuR(i1,gt2,gt3) 
coup(5) = cplcFuFdcSeL(gt1,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt1,i2,iIN)  
coup(7) = cplcFdChaSuL(i2,gt2,gt3) 
coup(8) = cplcFdChaSuR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Cha Su Propagator: Fd,Fd" 
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
End Subroutine SeTocFuChaSu 
 
 
Subroutine SeTocSvFdcFu(iIN,MSv,MFd,MFu,MSe,cplSecSecSv,cplcFdFdcSvL,cplcFdFdcSvR,    & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MFd(3),MFu(3),MSe(6)

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
mass(1) = MSe(iIN) 
 
Isum = 81 
Allocate( gSum(3,3,3, Isum) ) 
Allocate( Contribution(3,3,3, Isum) ) 
gSum = 0._dp  
Contribution = ' ' 
 
Isum = 0 
 
    Do gt1=1,3
      Do gt2=1,3
        Do gt3=1,3
Isum = 0 
 
rk2 = (MFd(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MFd(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSv Fd cFu Propagator: Se" 
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
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt3,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt3,i1,iIN)) 
coup(4) = Conjg(cplcFdFdcSvL(i1,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdcSvR(i1,gt2,gt1))
coup(5:8) = coup(1:4) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
 
 resD = resD + resS 
If (resD.ne.resD) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fd cFu Propagator: Fd" 
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
!  Se, Se 
!-------------- 
Do i1=1,5
  Do i2=i1+1,6
Isum = Isum + 1 
 
resS = 0._dp 
mass(1) = MSe(i1)  
mass(2) = MSe(i2)  
coup(1) = cplSecSecSv(i1,iIN,gt1) 
coup(3) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(i2,iIN,gt1) 
coup(6) = Conjg(cplcFuFdcSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplcFuFdcSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fd cFu Propagator: Se,Se" 
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
!  Se, Fd 
!-------------- 
Do i1=1,6
  Do i2=1,3
Isum = Isum + 1 
 
resS = 0._dp 
mass(2) = MSe(i1)  
mass(1) = MFd(i2)  
coup(1) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i2,iIN) 
coup(4) = Conjg(cplcFdFdcSvL(i2,gt2,gt1)) 
coup(3) = Conjg(cplcFdFdcSvR(i2,gt2,gt1))  
coup(5) = cplSecSecSv(i1,iIN,gt1) 
coup(7) = Conjg(cplcFuFdcSeL(gt3,gt2,i1)) 
coup(6) = Conjg(cplcFuFdcSeR(gt3,gt2,i1))  
Call IntegrateSF(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fd cFu Propagator: Se,Fd" 
Write(*,*)  "M_in: ",m_in 
Write(*,*)  "mass: ",mass 
Write(*,*)  "coup: ",coup 
gSum(gt1,gt2,gt3,Isum)= 0._dp  
Else 
gSum(gt1,gt2,gt3,Isum)= resS  
End If 
Contribution(gt1,gt2,gt3,Isum)='Se,Fd'
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
coup(1) = cplcFuFdcSeL(gt3,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt3,i1,iIN) 
coup(3) = cplcFdFdcSvL(i1,gt2,gt1) 
coup(4) = cplcFdFdcSvR(i1,gt2,gt1) 
coup(5) = cplcFuFdcSeL(gt3,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt3,i2,iIN)  
coup(7) = cplcFdFdcSvL(i2,gt2,gt1) 
coup(8) = cplcFdFdcSvR(i2,gt2,gt1) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Fd cFu Propagator: Fd,Fd" 
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
        Do gt3=1,3
g(gt1,gt2,gt3)=Sum(gSum(gt1,gt2,gt3,1:81))
If (g(gt1,gt2,gt3).Lt.0._dp) Then
  Write (ErrCan,*)'Error in Subroutine'//NameOfUnit(Iname)
  g(gt1,gt2,gt3)=0._dp
End If
       End Do 
     End Do 
   End Do 
End Subroutine SeTocSvFdcFu 
 
 
Subroutine SeTocFuFuHpm(iIN,MFu,MHpm,MFd,MSe,cplcFdFuHpmL,cplcFdFuHpmR,               & 
& cplcFuFdcSeL,cplcFuFdcSeR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MFu(3),MHpm(2),MFd(3),MSe(6)

Complex(dp),Intent(in) :: cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MFu(gt1)/MSe(iIN))**2 
rm2 = (MFu(gt2)/MSe(iIN))**2 
rj2 = (MHpm(gt3)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MHpm(gt3))+Abs(MFu(gt2))+Abs(MFu(gt1)))) Then 
!-------------- 
!  Fd 
!-------------- 
Do i1=1,3
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MFd(i1) 
mass(2) = MFd(i1) 
m_in = MSe(iIN) 
coup(2) = Conjg(cplcFuFdcSeL(gt1,i1,iIN)) 
coup(1) = Conjg(cplcFuFdcSeR(gt1,i1,iIN)) 
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
Write(*,*) "Se->cFu Fu Hpm Propagator: Fd" 
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
coup(1) = cplcFuFdcSeL(gt1,i1,iIN) 
coup(2) = cplcFuFdcSeR(gt1,i1,iIN) 
coup(3) = cplcFdFuHpmL(i1,gt2,gt3) 
coup(4) = cplcFdFuHpmR(i1,gt2,gt3) 
coup(5) = cplcFuFdcSeL(gt1,i2,iIN) 
coup(6) = cplcFuFdcSeR(gt1,i2,iIN)  
coup(7) = cplcFdFuHpmL(i2,gt2,gt3) 
coup(8) = cplcFdFuHpmR(i2,gt2,gt3) 
Call IntegrateFFLM(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cFu Fu Hpm Propagator: Fd,Fd" 
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
End Subroutine SeTocFuFuHpm 
 
 
Subroutine SeTocSuChaFu(iIN,MSu,MCha,MFu,MSd,MSe,cplSdcSecSu,cplChaFucSdL,            & 
& cplChaFucSdR,deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSu(6),MCha(2),MFu(3),MSd(6),MSe(6)

Complex(dp),Intent(in) :: cplSdcSecSu(6,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (MFu(gt3)/MSe(iIN))**2 
rj2 = (MSu(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(MFu(gt3))+Abs(MCha(gt2))+Abs(MSu(gt1)))) Then 
!-------------- 
!  Sd 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSd(i1) 
mass(2) = MSd(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSdcSecSu(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSu Cha Fu Propagator: Sd" 
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
coup(1) = cplSdcSecSu(i1,iIN,gt1) 
coup(3) = Conjg(cplChaFucSdL(gt2,gt3,i1)) 
coup(2) = Conjg(cplChaFucSdR(gt2,gt3,i1))  
coup(4) = cplSdcSecSu(i2,iIN,gt1) 
coup(6) = Conjg(cplChaFucSdL(gt2,gt3,i2)) 
coup(5) = Conjg(cplChaFucSdR(gt2,gt3,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 3*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSu Cha Fu Propagator: Sd,Sd" 
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
End Subroutine SeTocSuChaFu 
 
 
Subroutine SeTocSvChaFv(iIN,MSv,MCha,MSe,cplSecSecSv,cplFvChacSeL,cplFvChacSeR,       & 
& deltaM,epsI,check,g,WriteContributions)

Implicit None 
 
Real(dp),Intent(in) :: MSv(3),MCha(2),MSe(6)

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
mass(1) = MSe(iIN) 
 
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
 
rk2 = (MCha(gt2)/MSe(iIN))**2 
rm2 = (0./MSe(iIN))**2 
rj2 = (MSv(gt1)/MSe(iIN))**2 
smin=2._dp*Sqrt(rk2) 
smax=1._dp+rk2-rj2-rm2-2._dp*Sqrt(rj2*rm2) 
smin2=2._dp*Sqrt(rm2) 
smax2=1._dp+rm2-rj2-rk2-2._dp*Sqrt(rj2*rk2) 
m_in=MSe(iIN) 
r_out(1)=rj2 
r_out(2)=rk2 
r_out(3)=rm2 
r_outcrossed(1)=rj2 
r_outcrossed(2)=rm2 
r_outcrossed(3)=rk2 
If(Abs(MSe(iIN)).gt.(Abs(0.)+Abs(MCha(gt2))+Abs(MSv(gt1)))) Then 
!-------------- 
!  Se 
!-------------- 
Do i1=1,6
Isum = Isum + 1 
resS=0._dp 
resD=0._dp 
 
mass(1) = MSe(i1) 
mass(2) = MSe(i1) 
m_in = MSe(iIN) 
coup(1) = Conjg(cplSecSecSv(i1,iIN,gt1)) 
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
Write(*,*) "Se->cSv Cha Fv Propagator: Se" 
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
coup(1) = cplSecSecSv(i1,iIN,gt1) 
coup(3) = Conjg(cplFvChacSeL(gt3,gt2,i1)) 
coup(2) = Conjg(cplFvChacSeR(gt3,gt2,i1))  
coup(4) = cplSecSecSv(i2,iIN,gt1) 
coup(6) = Conjg(cplFvChacSeL(gt3,gt2,i2)) 
coup(5) = Conjg(cplFvChacSeR(gt3,gt2,i2))  
Call IntegrateSaSb(mass,m_in,r_out,coup,smin,smax,epsI,resC) 
If (resC.ne.resC) resC = 0._dp
resC = 2._dp*resC 
resC = 1*resC  ! Color factor 
resS = resS + resC 
If (resS.ne.resS) Then 
Write(*,*) "NaN appearing in the following diagrams: " 
Write(*,*) "Se->cSv Cha Fv Propagator: Se,Se" 
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
End Subroutine SeTocSvChaFv 
 
 
End Module Se3Decays_MSSMTriLnV 
 
