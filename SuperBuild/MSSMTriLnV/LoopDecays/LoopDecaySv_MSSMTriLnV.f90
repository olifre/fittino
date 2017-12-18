! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:55 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Sv_MSSMTriLnV
Use Control 
Use Settings 
Use LoopFunctions 
Use AddLoopFunctions 
Use Model_Data_MSSMTriLnV 
Use DecayFFS 
Use DecayFFV 
Use DecaySSS 
Use DecaySFF 
Use DecaySSV 
Use DecaySVV 
Use Bremsstrahlung 

Contains 

Subroutine Amplitude_Tree_MSSMTriLnV_SvToFvChi(cplChiFvcSvL,cplChiFvcSvR,             & 
& MChi,MSv,MChi2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MSv(3),MChi2(4),MSv2(3)

Complex(dp), Intent(in) :: cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Complex(dp) :: Amp(2,3,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,4
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = MChi(gt3) 
! Tree-Level Vertex 
coupT1L = cplChiFvcSvL(gt3,gt2,gt1)
coupT1R = cplChiFvcSvR(gt3,gt2,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvToFvChi


Subroutine Gamma_Real_MSSMTriLnV_SvToFvChi(MLambda,em,gs,cplChiFvcSvL,cplChiFvcSvR,   & 
& MChi,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Real(dp), Intent(in) :: MChi(4),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,4), GammarealGluon(3,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
CoupL = cplChiFvcSvL(i3,i2,i1)
CoupR = cplChiFvcSvR(i3,i2,i1)
Mex1 = MSv(i1)
Mex2 = 0.
Mex3 = MChi(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Gammarealphoton(i1,i2,i3) = 0._dp 
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvToFvChi


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToFvChi(cplChiFvcSvL,cplChiFvcSvR,             & 
& ctcplChiFvcSvL,ctcplChiFvcSvR,MChi,MChi2,MSv,MSv2,ZfFvL,ZfL0,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3)

Complex(dp), Intent(in) :: ctcplChiFvcSvL(4,3,3),ctcplChiFvcSvR(4,3,3)

Complex(dp), Intent(in) :: ZfFvL(3,3),ZfL0(4,4),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,4
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = MChi(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChiFvcSvL(gt3,gt2,gt1) 
ZcoupT1R = ctcplChiFvcSvR(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplChiFvcSvL(gt3,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplChiFvcSvR(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFvL(i1,gt2)*cplChiFvcSvL(gt3,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFvL(i1,gt2))*cplChiFvcSvR(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt3)*cplChiFvcSvL(i1,gt2,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt3))*cplChiFvcSvR(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToFvChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToFvChi(MCha,MChi,MFd,MFe,Mhh,               & 
& MHpm,MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,             & 
& MVWm2,MVZ2,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,   & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,              & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,              & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,               & 
& MVZ,MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),        & 
& MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),  & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),       & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),           & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplhhSvcSv(2,3,3),cplSdcSdcSv(6,6,3),              & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = MChi(gt3) 


! {Chi, Fv, Sv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,gt2,i3)
coup2R = cplChiFvSvR(i1,gt2,i3)
coup3L = cplChiFvcSvL(gt3,i2,i3)
coup3R = cplChiFvcSvR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, Fv, conj[Sv]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,gt2,i3)
coup2R = cplChiFvcSvR(i1,gt2,i3)
coup3L = cplChiFvSvL(gt3,i2,i3)
coup3R = cplChiFvSvR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3L = cplChiFdcSdL(gt3,i2,i3)
coup3R = cplChiFdcSdR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Hpm}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MHpm(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,gt2,i3)
coup2R = cplcFeFvHpmR(i1,gt2,i3)
coup3L = cplChiChacHpmL(gt3,i2,i3)
coup3R = cplChiChacHpmR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
coup3L = cplChiFecSeL(gt3,i2,i3)
coup3R = cplChiFecSeR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, VWm}
Do i1=1,3
  Do i2=1,2
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MVWm 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = -cplcFeFvVWmR(i1,gt2)
coup2R = -cplcFeFvVWmL(i1,gt2)
coup3L = -cplChiChacVWmR(gt3,i2)
coup3R = -cplChiChacVWmL(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fv, Chi, VZ}
Do i1=1,3
  Do i2=1,4
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MVZ 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplFvFvVZL(gt2,i1)
coup2R = cplFvFvVZR(gt2,i1)
coup3L = -cplChiChiVZR(gt3,i2)
coup3R = -cplChiChiVZL(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdChiSdL(i3,gt3,i2)
coup3R = cplcFdChiSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
coup3L = cplcChaChiHpmL(i3,gt3,i2)
coup3R = cplcChaChiHpmR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MCha(i3) 
coup1 = -cplSecSvcVWm(i1,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
coup3L = cplcChaChiVWmL(i3,gt3)
coup3R = cplcChaChiVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeChiSeL(i3,gt3,i2)
coup3R = cplcFeChiSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, hh, Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MChi(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2L = cplChiFvcSvL(i3,gt2,i1)
coup2R = cplChiFvcSvR(i3,gt2,i1)
coup3L = cplChiChihhL(gt3,i3,i2)
coup3R = cplChiChihhR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Chi}
Do i1=1,3
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MChi(i3) 
coup1 = -cplSvcSvVZ(i1,gt1)
coup2L = cplChiFvcSvL(i3,gt2,i1)
coup2R = cplChiFvcSvR(i3,gt2,i1)
coup3L = -cplChiChiVZR(gt3,i3)
coup3R = -cplChiChiVZL(gt3,i3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Fv}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = -cplSvcSvVZ(i2,gt1)
coup2L = cplFvFvVZL(gt2,i3)
coup2R = cplFvFvVZR(gt2,i3)
coup3L = cplChiFvcSvL(gt3,i3,i2)
coup3R = cplChiFvcSvR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], conj[Se]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i1,i3)
coup2R = cplFvChacSeR(gt2,i1,i3)
coup3L = cplcFeChiSeL(i2,gt3,i3)
coup3R = cplcFeChiSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplFvFdcSdL(gt2,i1,i3)
coup2R = cplFvFdcSdR(gt2,i1,i3)
coup3L = cplcFdChiSdL(i2,gt3,i3)
coup3R = cplcFdChiSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i1,i3)
coup2R = cplFvFecSeR(gt2,i1,i3)
coup3L = cplcFeChiSeL(i2,gt3,i3)
coup3R = cplcFeChiSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], bar[Fe]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i3,gt2,i1)
coup2R = cplcFeFvHpmR(i3,gt2,i1)
coup3L = cplChiFecSeL(gt3,i3,i2)
coup3R = cplChiFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdFvSdL(i3,gt2,i1)
coup2R = cplcFdFvSdR(i3,gt2,i1)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], bar[Fe]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFeFvSeL(i3,gt2,i1)
coup2R = cplcFeFvSeR(i3,gt2,i1)
coup3L = cplChiFecSeL(gt3,i3,i2)
coup3R = cplChiFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], bar[Fe]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = -cplSecSvcVWm(i2,gt1)
coup2L = -cplcFeFvVWmR(i3,gt2)
coup2R = -cplcFeFvVWmL(i3,gt2)
coup3L = cplChiFecSeL(gt3,i3,i2)
coup3R = cplChiFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToFvChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi(MCha,MChi,MFd,MFe,Mhh,            & 
& MHpm,MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,             & 
& MVWm2,MVZ2,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplFvChacSeL,   & 
& cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,              & 
& cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,              & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,               & 
& MVZ,MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),        & 
& MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),  & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),       & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),           & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplhhSvcSv(2,3,3),cplSdcSdcSv(6,6,3),              & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = MChi(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvChi


Subroutine Amplitude_Tree_MSSMTriLnV_SvTocFdFd(cplcFdFdcSvL,cplcFdFdcSvR,             & 
& MFd,MSv,MFd2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MSv(3),MFd2(3),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3)

Complex(dp) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFdFdcSvL(gt2,gt3,gt1)
coupT1R = cplcFdFdcSvR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvTocFdFd


Subroutine Gamma_Real_MSSMTriLnV_SvTocFdFd(MLambda,em,gs,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& MFd,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3)

Real(dp), Intent(in) :: MFd(3),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,3), GammarealGluon(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFdFdcSvL(i2,i3,i1)
CoupR = cplcFdFdcSvR(i2,i3,i1)
Mex1 = MSv(i1)
Mex2 = MFd(i2)
Mex3 = MFd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp/3._dp,-1._dp/3._dp,1._dp/3._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,0._dp,0._dp,0._dp,4._dp,-4._dp,4._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvTocFdFd


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocFdFd(cplcFdFdcSvL,cplcFdFdcSvR,             & 
& ctcplcFdFdcSvL,ctcplcFdFdcSvR,MFd,MFd2,MSv,MSv2,ZfFDL,ZfFDR,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3)

Complex(dp), Intent(in) :: ctcplcFdFdcSvL(3,3,3),ctcplcFdFdcSvR(3,3,3)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFdFdcSvL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFdFdcSvR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplcFdFdcSvL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplcFdFdcSvR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDR(i1,gt2)*cplcFdFdcSvL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDL(i1,gt2))*cplcFdFdcSvR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplcFdFdcSvL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplcFdFdcSvR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocFdFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocFdFd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,              & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,             & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),        & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),       & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),             & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),               & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcChaFecSvL(2,3,3),        & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuHpmL(3,3,2),      & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),           & 
& cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6),cplhhSvcSv(2,3,3),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 


! {Chi, Fv, Sd}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MSd(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplcFdChiSdL(gt2,i1,i3)
coup2R = cplcFdChiSdR(gt2,i1,i3)
coup3L = cplFvFdcSdL(i2,gt3,i3)
coup3R = cplFvFdcSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Sd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplcFdFvSdL(gt2,i1,i3)
coup2R = cplcFdFvSdR(gt2,i1,i3)
coup3L = cplChiFdcSdL(i2,gt3,i3)
coup3R = cplChiFdcSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], Fd}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2L = cplcFdFdhhL(gt2,i3,i1)
coup2R = cplcFdFdhhR(gt2,i3,i1)
coup3L = cplcFdFdcSvL(i3,gt3,i2)
coup3R = cplcFdFdcSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Sv, hh, Fd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2L = cplcFdFdcSvL(gt2,i3,i1)
coup2R = cplcFdFdcSvR(gt2,i3,i1)
coup3L = cplcFdFdhhL(i3,gt3,i2)
coup3R = cplcFdFdhhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Fd}
Do i1=1,3
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplSvcSvVZ(i1,gt1)
coup2L = cplcFdFdcSvL(gt2,i3,i1)
coup2R = cplcFdFdcSvR(gt2,i3,i1)
coup3L = cplcFdFdVZL(i3,gt3)
coup3R = cplcFdFdVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Fd}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = -cplSvcSvVZ(i2,gt1)
coup2L = cplcFdFdVZL(gt2,i3)
coup2R = cplcFdFdVZR(gt2,i3)
coup3L = cplcFdFdcSvL(i3,gt3,i2)
coup3R = cplcFdFdcSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], Su}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MSu(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFdChaSuL(gt2,i1,i3)
coup2R = cplcFdChaSuR(gt2,i1,i3)
coup3L = cplcFeFdcSuL(i2,gt3,i3)
coup3R = cplcFeFdcSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MAh(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdAhL(gt2,i1,i3)
coup2R = cplcFdFdAhR(gt2,i1,i3)
coup3L = cplcFdFdAhL(i2,gt3,i3)
coup3R = cplcFdFdAhR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], hh}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdhhL(gt2,i1,i3)
coup2R = cplcFdFdhhR(gt2,i1,i3)
coup3L = cplcFdFdhhL(i2,gt3,i3)
coup3R = cplcFdFdhhR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdSvL(gt2,i1,i3)
coup2R = cplcFdFdSvR(gt2,i1,i3)
coup3L = cplcFdFdcSvL(i2,gt3,i3)
coup3R = cplcFdFdcSvR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdVGL(gt2,i1)
coup2R = cplcFdFdVGR(gt2,i1)
coup3L = cplcFdFdVGL(i2,gt3)
coup3R = cplcFdFdVGR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {bar[Fd], bar[Fd], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdVPL(gt2,i1)
coup2R = cplcFdFdVPR(gt2,i1)
coup3L = cplcFdFdVPL(i2,gt3)
coup3R = cplcFdFdVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {bar[Fd], bar[Fd], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVZ 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdVZL(gt2,i1)
coup2R = cplcFdFdVZR(gt2,i1)
coup3L = cplcFdFdVZL(i2,gt3)
coup3R = cplcFdFdVZR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdcSvL(gt2,i1,i3)
coup2R = cplcFdFdcSvR(gt2,i1,i3)
coup3L = cplcFdFdSvL(i2,gt3,i3)
coup3R = cplcFdFdSvR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSu(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFdFeSuL(gt2,i1,i3)
coup2R = cplcFdFeSuR(gt2,i1,i3)
coup3L = cplcFeFdcSuL(i2,gt3,i3)
coup3R = cplcFeFdcSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], Fu}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2L = cplcFdFuHpmL(gt2,i3,i1)
coup2R = cplcFdFuHpmR(gt2,i3,i1)
coup3L = cplcFuFdcSeL(i3,gt3,i2)
coup3R = cplcFuFdcSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdChiSdL(gt2,i3,i1)
coup2R = cplcFdChiSdR(gt2,i3,i1)
coup3L = cplChiFdcSdL(i3,gt3,i2)
coup3R = cplChiFdcSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], Fv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = 0. 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdFvSdL(gt2,i3,i1)
coup2R = cplcFdFvSdR(gt2,i3,i1)
coup3L = cplFvFdcSdL(i3,gt3,i2)
coup3R = cplFvFdcSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], Glu}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MGlu 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdGluSdL(gt2,i1)
coup2R = cplcFdGluSdR(gt2,i1)
coup3L = cplGluFdcSdL(gt3,i2)
coup3R = cplGluFdcSdR(gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Se], conj[Se], Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFdFuSeL(gt2,i3,i1)
coup2R = cplcFdFuSeR(gt2,i3,i1)
coup3L = cplcFuFdcSeL(i3,gt3,i2)
coup3R = cplcFuFdcSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], Fu}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = -cplSecSvcVWm(i2,gt1)
coup2L = cplcFdFuVWmL(gt2,i3)
coup2R = cplcFdFuVWmR(gt2,i3)
coup3L = cplcFuFdcSeL(i3,gt3,i2)
coup3R = cplcFuFdcSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocFdFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,          & 
& cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,              & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFdFeSuL,          & 
& cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,            & 
& cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSvcSv,cplSdcSdcSv,cplSecHpmcSv,             & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),        & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),       & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),             & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),               & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcChaFecSvL(2,3,3),        & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuHpmL(3,3,2),      & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),           & 
& cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6),cplhhSvcSv(2,3,3),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 


! {bar[Fd], bar[Fd], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdVGL(gt2,i1)
coup2R = cplcFdFdVGR(gt2,i1)
coup3L = cplcFdFdVGL(i2,gt3)
coup3R = cplcFdFdVGR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {bar[Fd], bar[Fd], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFdFdVPL(gt2,i1)
coup2R = cplcFdFdVPR(gt2,i1)
coup3L = cplcFdFdVPL(i2,gt3)
coup3R = cplcFdFdVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFdFd


Subroutine Amplitude_Tree_MSSMTriLnV_SvTocChaFe(cplcChaFecSvL,cplcChaFecSvR,          & 
& MCha,MFe,MSv,MCha2,MFe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFe(3),MSv(3),MCha2(2),MFe2(3),MSv2(3)

Complex(dp), Intent(in) :: cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3)

Complex(dp) :: Amp(2,3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 
! Tree-Level Vertex 
coupT1L = cplcChaFecSvL(gt2,gt3,gt1)
coupT1R = cplcChaFecSvR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvTocChaFe


Subroutine Gamma_Real_MSSMTriLnV_SvTocChaFe(MLambda,em,gs,cplcChaFecSvL,              & 
& cplcChaFecSvR,MCha,MFe,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3)

Real(dp), Intent(in) :: MCha(2),MFe(3),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,2,3), GammarealGluon(3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
CoupL = cplcChaFecSvL(i2,i3,i1)
CoupR = cplcChaFecSvR(i2,i3,i1)
Mex1 = MSv(i1)
Mex2 = MCha(i2)
Mex3 = MFe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp,-1._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvTocChaFe


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocChaFe(cplcChaFecSvL,cplcChaFecSvR,          & 
& ctcplcChaFecSvL,ctcplcChaFecSvR,MCha,MCha2,MFe,MFe2,MSv,MSv2,ZfFEL,ZfFER,              & 
& ZfLm,ZfLp,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MFe(3),MFe2(3),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3)

Complex(dp), Intent(in) :: ctcplcChaFecSvL(2,3,3),ctcplcChaFecSvR(2,3,3)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfLm(2,2),ZfLp(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcChaFecSvL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcChaFecSvR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplcChaFecSvL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplcChaFecSvR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLp(i1,gt2)*cplcChaFecSvL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLm(i1,gt2))*cplcChaFecSvR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt3)*cplcChaFecSvL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt3))*cplcChaFecSvR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocChaFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocChaFe(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,            & 
& cplcFeFeAhL,cplcFeFeAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,       & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,          & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,         & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),      & 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),       & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),     & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),             & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcChaFvSeL(2,3,6),      & 
& cplcChaFvSeR(2,3,6),cplhhSvcSv(2,3,3),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),       & 
& cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),           & 
& cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 


! {Chi, Fv, Hpm}
Do i1=1,4
  Do i2=1,3
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MHpm(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(gt2,i1,i3)
coup2R = cplcChaChiHpmR(gt2,i1,i3)
coup3L = cplFvFecHpmL(i2,gt3,i3)
coup3R = cplFvFecHpmR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, Fv, VWm}
Do i1=1,4
  Do i2=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MVWm 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplcChaChiVWmL(gt2,i1)
coup2R = cplcChaChiVWmR(gt2,i1)
coup3L = cplFvFecVWmL(i2,gt3)
coup3R = cplFvFecVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fv, Chi, Se}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MSe(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplcChaFvSeL(gt2,i1,i3)
coup2R = cplcChaFvSeR(gt2,i1,i3)
coup3L = cplChiFecSeL(i2,gt3,i3)
coup3R = cplChiFecSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], Cha}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MCha(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2L = cplcChaChahhL(gt2,i3,i1)
coup2R = cplcChaChahhR(gt2,i3,i1)
coup3L = cplcChaFecSvL(i3,gt3,i2)
coup3R = cplcChaFecSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, hh, Fe}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2L = cplcChaFecSvL(gt2,i3,i1)
coup2R = cplcChaFecSvR(gt2,i3,i1)
coup3L = cplcFeFehhL(i3,gt3,i2)
coup3R = cplcFeFehhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Fe}
Do i1=1,3
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = -cplSvcSvVZ(i1,gt1)
coup2L = cplcChaFecSvL(gt2,i3,i1)
coup2R = cplcChaFecSvR(gt2,i3,i1)
coup3L = cplcFeFeVZL(i3,gt3)
coup3R = cplcFeFeVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Cha}
  Do i2=1,3
    Do i3=1,2
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MCha(i3) 
coup1 = -cplSvcSvVZ(i2,gt1)
coup2L = cplcChaChaVZL(gt2,i3)
coup2R = cplcChaChaVZR(gt2,i3)
coup3L = cplcChaFecSvL(i3,gt3,i2)
coup3R = cplcChaFecSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], Ah}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MAh(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcChaChaAhL(gt2,i1,i3)
coup2R = cplcChaChaAhR(gt2,i1,i3)
coup3L = cplcFeFeAhL(i2,gt3,i3)
coup3R = cplcFeFeAhR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], bar[Fe], hh}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = Mhh(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcChaChahhL(gt2,i1,i3)
coup2R = cplcChaChahhR(gt2,i1,i3)
coup3L = cplcFeFehhL(i2,gt3,i3)
coup3R = cplcFeFehhR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], bar[Fe], VP}
Do i1=1,2
  Do i2=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3L = cplcFeFeVPL(i2,gt3)
coup3R = cplcFeFeVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Cha], bar[Fe], VZ}
Do i1=1,2
  Do i2=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MVZ 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcChaChaVZL(gt2,i1)
coup2R = cplcChaChaVZR(gt2,i1)
coup3L = cplcFeFeVZL(i2,gt3)
coup3R = cplcFeFeVZR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcChaFdcSuL(gt2,i1,i3)
coup2R = cplcChaFdcSuR(gt2,i1,i3)
coup3L = cplcFdFeSuL(i2,gt3,i3)
coup3R = cplcFdFeSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcChaFecSvL(gt2,i1,i3)
coup2R = cplcChaFecSvR(gt2,i1,i3)
coup3L = cplcFeFeSvL(i2,gt3,i3)
coup3R = cplcFeFeSvR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], Chi}
Do i1=1,2
  Do i2=1,6
    Do i3=1,4
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2L = cplcChaChiHpmL(gt2,i3,i1)
coup2R = cplcChaChiHpmR(gt2,i3,i1)
coup3L = cplChiFecSeL(i3,gt3,i2)
coup3R = cplChiFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcChacFuSdL(gt2,i3,i1)
coup2R = cplcChacFuSdR(gt2,i3,i1)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], Fv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcChaFvSeL(gt2,i3,i1)
coup2R = cplcChaFvSeR(gt2,i3,i1)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], Chi}
  Do i2=1,6
    Do i3=1,4
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = -cplSecSvcVWm(i2,gt1)
coup2L = cplcChaChiVWmL(gt2,i3)
coup2R = cplcChaChiVWmR(gt2,i3)
coup3L = cplChiFecSeL(i3,gt3,i2)
coup3R = cplChiFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocChaFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplcFeFeAhL,cplcFeFeAhR,cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,       & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,             & 
& cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,          & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,            & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplhhSvcSv,cplcChacFuSdL,cplcChacFuSdR,         & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),      & 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),       & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),     & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),             & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcChaFvSeL(2,3,6),      & 
& cplcChaFvSeR(2,3,6),cplhhSvcSv(2,3,3),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),       & 
& cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),           & 
& cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 


! {bar[Cha], bar[Fe], VP}
Do i1=1,2
  Do i2=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3L = cplcFeFeVPL(i2,gt3)
coup3R = cplcFeFeVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocChaFe


Subroutine Amplitude_Tree_MSSMTriLnV_SvTocFeFe(cplcFeFecSvL,cplcFeFecSvR,             & 
& MFe,MSv,MFe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MSv(3),MFe2(3),MSv2(3)

Complex(dp), Intent(in) :: cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Complex(dp) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFeFecSvL(gt2,gt3,gt1)
coupT1R = cplcFeFecSvR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvTocFeFe


Subroutine Gamma_Real_MSSMTriLnV_SvTocFeFe(MLambda,em,gs,cplcFeFecSvL,cplcFeFecSvR,   & 
& MFe,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Real(dp), Intent(in) :: MFe(3),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,3), GammarealGluon(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFeFecSvL(i2,i3,i1)
CoupR = cplcFeFecSvR(i2,i3,i1)
Mex1 = MSv(i1)
Mex2 = MFe(i2)
Mex3 = MFe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp,-1._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvTocFeFe


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocFeFe(cplcFeFecSvL,cplcFeFecSvR,             & 
& ctcplcFeFecSvL,ctcplcFeFecSvR,MFe,MFe2,MSv,MSv2,ZfFEL,ZfFER,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFe2(3),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3)

Complex(dp), Intent(in) :: ctcplcFeFecSvL(3,3,3),ctcplcFeFecSvR(3,3,3)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFeFecSvL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFeFecSvR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplcFeFecSvL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplcFeFecSvR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFER(i1,gt2)*cplcFeFecSvL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFEL(i1,gt2))*cplcFeFecSvR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt3)*cplcFeFecSvL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt3))*cplcFeFecSvR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocFeFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocFeFe(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,   & 
& cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,             & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),        & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),      & 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplhhSvcSv(2,3,3),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),           & 
& cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),           & 
& cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 


! {Chi, Fv, Se}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplcFeChiSeL(gt2,i1,i3)
coup2R = cplcFeChiSeR(gt2,i1,i3)
coup3L = cplFvFecSeL(i2,gt3,i3)
coup3R = cplFvFecSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Se}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MSe(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplcFeFvSeL(gt2,i1,i3)
coup2R = cplcFeFvSeR(gt2,i1,i3)
coup3L = cplChiFecSeL(i2,gt3,i3)
coup3R = cplChiFecSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2L = cplcFeFehhL(gt2,i3,i1)
coup2R = cplcFeFehhR(gt2,i3,i1)
coup3L = cplcFeFecSvL(i3,gt3,i2)
coup3R = cplcFeFecSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, hh, Fe}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2L = cplcFeFecSvL(gt2,i3,i1)
coup2R = cplcFeFecSvR(gt2,i3,i1)
coup3L = cplcFeFehhL(i3,gt3,i2)
coup3R = cplcFeFehhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Fe}
Do i1=1,3
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = -cplSvcSvVZ(i1,gt1)
coup2L = cplcFeFecSvL(gt2,i3,i1)
coup2R = cplcFeFecSvR(gt2,i3,i1)
coup3L = cplcFeFeVZL(i3,gt3)
coup3R = cplcFeFeVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Fe}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = -cplSvcSvVZ(i2,gt1)
coup2L = cplcFeFeVZL(gt2,i3)
coup2R = cplcFeFeVZR(gt2,i3)
coup3L = cplcFeFecSvL(i3,gt3,i2)
coup3R = cplcFeFecSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], Sv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFeChaSvL(gt2,i1,i3)
coup2R = cplcFeChaSvR(gt2,i1,i3)
coup3L = cplcFeFecSvL(i2,gt3,i3)
coup3R = cplcFeFecSvR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFeFdcSuL(gt2,i1,i3)
coup2R = cplcFeFdcSuR(gt2,i1,i3)
coup3L = cplcFdFeSuL(i2,gt3,i3)
coup3R = cplcFdFeSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MAh(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFeAhL(gt2,i1,i3)
coup2R = cplcFeFeAhR(gt2,i1,i3)
coup3L = cplcFeFeAhL(i2,gt3,i3)
coup3R = cplcFeFeAhR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], hh}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFehhL(gt2,i1,i3)
coup2R = cplcFeFehhR(gt2,i1,i3)
coup3L = cplcFeFehhL(i2,gt3,i3)
coup3R = cplcFeFehhR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFeSvL(gt2,i1,i3)
coup2R = cplcFeFeSvR(gt2,i1,i3)
coup3L = cplcFeFecSvL(i2,gt3,i3)
coup3R = cplcFeFecSvR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFeVPL(gt2,i1)
coup2R = cplcFeFeVPR(gt2,i1)
coup3L = cplcFeFeVPL(i2,gt3)
coup3R = cplcFeFeVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], bar[Fe], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MVZ 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFeVZL(gt2,i1)
coup2R = cplcFeFeVZR(gt2,i1)
coup3L = cplcFeFeVZL(i2,gt3)
coup3R = cplcFeFeVZR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFecSvL(gt2,i1,i3)
coup2R = cplcFeFecSvR(gt2,i1,i3)
coup3L = cplcFeFeSvL(i2,gt3,i3)
coup3R = cplcFeFeSvR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], Fv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2L = cplcFeFvHpmL(gt2,i3,i1)
coup2R = cplcFeFvHpmR(gt2,i3,i1)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFecFuSdL(gt2,i3,i1)
coup2R = cplcFecFuSdR(gt2,i3,i1)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFeChiSeL(gt2,i3,i1)
coup2R = cplcFeChiSeR(gt2,i3,i1)
coup3L = cplChiFecSeL(i3,gt3,i2)
coup3R = cplChiFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], Fv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFeFvSeL(gt2,i3,i1)
coup2R = cplcFeFvSeR(gt2,i3,i1)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], Fv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = -cplSecSvcVWm(i2,gt1)
coup2L = cplcFeFvVWmL(gt2,i3)
coup2R = cplcFeFvVWmR(gt2,i3)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocFeFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplcFeChaSvL,   & 
& cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,         & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,          & 
& cplFeFucSdR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,               & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSvcSv,             & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,           & 
& cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),        & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),      & 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplhhSvcSv(2,3,3),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),           & 
& cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),           & 
& cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 


! {bar[Fe], bar[Fe], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFeFeVPL(gt2,i1)
coup2R = cplcFeFeVPR(gt2,i1)
coup3L = cplcFeFeVPL(i2,gt3)
coup3R = cplcFeFeVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocFeFe


Subroutine Amplitude_Tree_MSSMTriLnV_SvToSvhh(cplhhSvcSv,Mhh,MSv,Mhh2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),MSv(3),Mhh2(2),MSv2(3)

Complex(dp), Intent(in) :: cplhhSvcSv(2,3,3)

Complex(dp) :: Amp(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = Mhh(gt3) 
! Tree-Level Vertex 
coupT1 = cplhhSvcSv(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvToSvhh


Subroutine Gamma_Real_MSSMTriLnV_SvToSvhh(MLambda,em,gs,cplhhSvcSv,Mhh,               & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplhhSvcSv(2,3,3)

Real(dp), Intent(in) :: Mhh(2),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,2), GammarealGluon(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
Coup = cplhhSvcSv(i3,i2,i1)
Mex1 = MSv(i1)
Mex2 = MSv(i2)
Mex3 = Mhh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Gammarealphoton(i1,i2,i3) = 0._dp 
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvToSvhh


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvhh(cplhhSvcSv,ctcplhhSvcSv,Mhh,            & 
& Mhh2,MSv,MSv2,Zfhh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplhhSvcSv(2,3,3)

Complex(dp), Intent(in) :: ctcplhhSvcSv(2,3,3)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = Mhh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplhhSvcSv(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplhhSvcSv(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSv(i1,gt2)*cplhhSvcSv(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt3)*cplhhSvcSv(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvhh(MAh,MCha,MChi,MFd,MFe,Mhh,            & 
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
& cplSvcSvVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MSv(3),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),            & 
& MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcFeChaSvL(3,2,3),       & 
& cplcFeChaSvR(3,2,3),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdFdhhL(3,3,2),         & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdcSvL(3,3,3),          & 
& cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),      & 
& cplcFeFecSvR(3,3,3),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),            & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),   & 
& cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),           & 
& cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhAhSvcSv1(2,2,3,3),             & 
& cplhhhhSvcSv1(2,2,3,3),cplhhHpmSvcSe1(2,2,3,6),cplhhSdSvcSdaa(2,6,3,6),cplhhSdcSdcSvaa(2,6,6,3),& 
& cplhhSeSvcSe1(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSecSv1(2,6,6,3),               & 
& cplHpmSvcHpmcSv1(2,3,2,3),cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcSecSv1(6,3,6,3),            & 
& cplSuSvcSucSvaa(6,3,6,3),cplSvSvcSvcSv1(3,3,3,3),cplSvcSvcVWmVWm1(3,3),cplSvcSvVZVZ1(3,3)

Complex(dp), Intent(out) :: Amp(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = Mhh(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = cplcFdFdhhL(i3,i2,gt3)
coup3R = cplcFdFdhhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
coup3L = cplcChaChahhL(i3,i2,gt3)
coup3R = cplcChaChahhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = cplcFeFehhL(i3,i2,gt3)
coup3R = cplcFeFehhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplChiFvSvL(i3,i1,gt2)
coup2R = cplChiFvSvR(i3,i1,gt2)
coup3L = cplChiChihhL(i3,i2,gt3)
coup3R = cplChiChihhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], conj[Sv]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i3)
coup3 = cplhhSvcSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplhhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplhhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplhhcHpmVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplhhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = cplhhHpmcVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, VWm, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sv, hh, hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
coup3 = cplhhhhhh(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, VZ}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = -cplSvcSvVZ(gt2,i1)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VZ, conj[Sv], conj[Sv]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = -cplSvcSvVZ(gt2,i3)
coup3 = cplhhSvcSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], bar[Fe]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i3,i1,gt2)
coup2R = cplcFeChaSvR(i3,i1,gt2)
coup3L = cplcFeFehhL(i2,i3,gt3)
coup3R = cplcFeFehhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = cplhhSecSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i3)
coup3 = cplhhSecSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {hh, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhhhSvcSv1(gt3,i1,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplhhSdSvcSdaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplhhHpmSvcSe1(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplhhSeSvcSe1(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhhhSvcSv1(gt3,i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplSdSvcSd(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhSecHpmcSv1(gt3,i1,i2,gt1)
coup2 = cplHpmSvcSe(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSecSv1(gt3,i1,i2,gt1)
coup2 = cplSeSvcSe(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Ah, Ah}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MAh(i2) 
coup1 = cplAhAhSvcSv1(i1,i2,gt2,gt1)
coup2 = cplAhAhhh(i1,i2,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 

  End Do
End Do


! {hh, hh}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = Mhh(i2) 
coup1 = cplhhhhSvcSv1(i1,i2,gt2,gt1)
coup2 = cplhhhhhh(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 

  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplHpmSvcHpmcSv1(i1,gt2,i2,gt1)
coup2 = cplhhHpmcHpm(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSvcSdcSvaa(i1,gt2,i2,gt1)
coup2 = cplhhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(i1,gt2,i2,gt1)
coup2 = cplhhSecSe(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplSuSvcSucSvaa(i1,gt2,i2,gt1)
coup2 = cplhhSucSu(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sv, Sv}
Do i1=1,3
  Do i2=1,3
ML1 = MSv(i1) 
ML2 = MSv(i2) 
coup1 = cplSvSvcSvcSv1(gt2,i1,gt1,i2)
coup2 = cplhhSvcSv(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {VWm, VWm}
ML1 = MVWm 
ML2 = MVWm 
coup1 = cplSvcSvcVWmVWm1(gt2,gt1)
coup2 = cplhhcVWmVWm(gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VZ, VZ}
ML1 = MVZ 
ML2 = MVZ 
coup1 = cplSvcSvVZVZ1(gt2,gt1)
coup2 = cplhhVZVZ(gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 

    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh(MAh,MCha,MChi,MFd,MFe,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,               & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChahhL,cplcChaChahhR,cplcFeChaSvL,     & 
& cplcFeChaSvR,cplChiChihhL,cplChiChihhR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,             & 
& cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,            & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,   & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhAhSvcSv1,cplhhhhSvcSv1,cplhhHpmSvcSe1,cplhhSdSvcSdaa,      & 
& cplhhSdcSdcSvaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSvcHpmcSv1,         & 
& cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,cplSvSvcSvcSv1,cplSvcSvcVWmVWm1,        & 
& cplSvcSvVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MSv(3),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),            & 
& MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcFeChaSvL(3,2,3),       & 
& cplcFeChaSvR(3,2,3),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdFdhhL(3,3,2),         & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdcSvL(3,3,3),          & 
& cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),      & 
& cplcFeFecSvR(3,3,3),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),            & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),   & 
& cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),           & 
& cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhAhSvcSv1(2,2,3,3),             & 
& cplhhhhSvcSv1(2,2,3,3),cplhhHpmSvcSe1(2,2,3,6),cplhhSdSvcSdaa(2,6,3,6),cplhhSdcSdcSvaa(2,6,6,3),& 
& cplhhSeSvcSe1(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSecSv1(2,6,6,3),               & 
& cplHpmSvcHpmcSv1(2,3,2,3),cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcSecSv1(6,3,6,3),            & 
& cplSuSvcSucSvaa(6,3,6,3),cplSvSvcSvcSv1(3,3,3,3),cplSvcSvcVWmVWm1(3,3),cplSvcSvVZVZ1(3,3)

Complex(dp), Intent(out) :: Amp(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = Mhh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvhh


Subroutine Amplitude_Tree_MSSMTriLnV_SvTocSdSd(cplSdcSdcSv,MSd,MSv,MSd2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSv(3),MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSdcSdcSv(6,6,3)

Complex(dp) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdcSdcSv(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvTocSdSd


Subroutine Gamma_Real_MSSMTriLnV_SvTocSdSd(MLambda,em,gs,cplSdcSdcSv,MSd,             & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcSdcSv(6,6,3)

Real(dp), Intent(in) :: MSd(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,6,6), GammarealGluon(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
Coup = cplSdcSdcSv(i3,i2,i1)
Mex1 = MSv(i1)
Mex2 = MSd(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp/3._dp,-1._dp/3._dp,1._dp/3._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,0._dp,0._dp,0._dp,4._dp,-4._dp,4._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvTocSdSd


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocSdSd(cplSdcSdcSv,ctcplSdcSdcSv,             & 
& MSd,MSd2,MSv,MSv2,ZfSd,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSdcSdcSv(6,6,3)

Complex(dp), Intent(in) :: ctcplSdcSdcSv(6,6,3)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSdcSv(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplSdcSdcSv(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt2))*cplSdcSdcSv(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdcSdcSv(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocSdSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocSdSd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,             & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,          & 
& cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab, & 
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),        & 
& cplChiFdcSdR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdChiSdL(3,4,6),       & 
& cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFeFucSdL(3,3,6),          & 
& cplFeFucSdR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),      & 
& cplcFeFecSvR(3,3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),           & 
& cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),              & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcFecFuSdL(3,3,6), & 
& cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),         & 
& cplSeSucSd(6,6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),            & 
& cplSucSdVWm(6,6),cplSvcSvVZ(3,3),cplAhSdcSdcSvaa(2,6,6,3),cplhhSdcSdcSvaa(2,6,6,3),    & 
& cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplSdSdcSdcSdabba(6,6,6,6),        & 
& cplSdSdcSdcSdabab(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSvcSdcSvaa(6,3,6,3),          & 
& cplSdcHpmcSucSvaa(6,2,6,3),cplSeSucSdcSvaa(6,6,6,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 


! {Chi, Fv, Fd}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MFd(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiFdcSdL(i1,i3,gt2)
coup2R = cplChiFdcSdR(i1,i3,gt2)
coup3L = cplcFdFvSdL(i3,i2,gt3)
coup3R = cplcFdFvSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Fd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplFvFdcSdL(i1,i3,gt2)
coup2R = cplFvFdcSdR(i1,i3,gt2)
coup3L = cplcFdChiSdL(i3,i2,gt3)
coup3R = cplcFdChiSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], Sd}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,i3,gt2)
coup3 = cplSdcSdcSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Sv, hh, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplSdcSdcSv(i3,gt2,i1)
coup3 = cplhhSdcSd(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = cplSdcSdcSv(i3,gt2,i1)
coup3 = cplSdcSdVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Sd}
  Do i2=1,3
    Do i3=1,6
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = cplSdcSdVZ(i3,gt2)
coup3 = cplSdcSdcSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], Fu}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFu(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplChaFucSdL(i1,i3,gt2)
coup2R = cplChaFucSdR(i1,i3,gt2)
coup3L = cplcFecFuSdL(i2,i3,gt3)
coup3R = cplcFecFuSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplChiFdcSdL(i3,i1,gt2)
coup2R = cplChiFdcSdR(i3,i1,gt2)
coup3L = cplcFdChiSdL(i2,i3,gt3)
coup3R = cplcFdChiSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplFvFdcSdL(i3,i1,gt2)
coup2R = cplFvFdcSdR(i3,i1,gt2)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], Glu}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MGlu 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplGluFdcSdL(i1,gt2)
coup2R = cplGluFdcSdR(i1,gt2)
coup3L = cplcFdGluSdL(i2,gt3)
coup3R = cplcFdGluSdR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {bar[Fe], bar[Fe], Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFu(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFeFucSdL(i1,i3,gt2)
coup2R = cplFeFucSdR(i1,i3,gt2)
coup3L = cplcFecFuSdL(i2,i3,gt3)
coup3R = cplcFecFuSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], Su}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,i3,gt2)
coup3 = cplSdcSecSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplAhSdcSd(i3,i1,gt2)
coup3 = cplAhSdcSd(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], hh}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplhhSdcSd(i3,i1,gt2)
coup3 = cplhhSdcSd(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdSvcSd(i1,i3,gt2)
coup3 = cplSdcSdcSv(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSdVG(i1,gt2)
coup3 = cplSdcSdVG(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSdVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], VZ}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSdVZ(i1,gt2)
coup3 = cplSdcSdVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], conj[Sv]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSdcSv(i1,gt2,i3)
coup3 = cplSdSvcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSeSucSd(i1,i3,gt2)
coup3 = cplSdcSecSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], Su}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplSucSdVWm(i3,gt2)
coup3 = cplSdcSecSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {hh, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSdcSdcSvaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSdcSdcSdabba(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
coup2 = cplSdSdcSdcSdabab(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(9)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSdcSdcSeaa(i2,gt3,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSdSecSdcSeaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Ah, Sd}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(i1,gt3,i2,gt1)
coup2 = cplAhSdcSd(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {hh, Sd}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(i1,gt3,i2,gt1)
coup2 = cplhhSdcSd(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sv, Sd}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSvcSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplSdcSdcSv(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {conj[Hpm], Su}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSucSvaa(gt3,i1,i2,gt1)
coup2 = cplHpmSucSd(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(i1,i2,gt2,gt1)
coup2 = cplAhSdcSd(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(i1,i2,gt2,gt1)
coup2 = cplhhSdcSd(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSdcSvaa(i1,i2,gt2,gt1)
coup2 = cplSdcHpmcSu(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSdcSvaa(i1,i2,gt2,gt1)
coup2 = cplSdcSdcSv(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSdcSvaa(i1,i2,gt2,gt1)
coup2 = cplSdcSecSu(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocSdSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSvcSv,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,         & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,             & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSvVZ,cplAhSdcSdcSvaa,          & 
& cplhhSdcSdcSvaa,cplHpmSdcSdcSeaa,cplHpmSucSdcSvaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab, & 
& cplSdSecSdcSeaa,cplSdSvcSdcSvaa,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),        & 
& cplChiFdcSdR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdChiSdL(3,4,6),       & 
& cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFeFucSdL(3,3,6),          & 
& cplFeFucSdR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),      & 
& cplcFeFecSvR(3,3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),           & 
& cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),              & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcFecFuSdL(3,3,6), & 
& cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),         & 
& cplSeSucSd(6,6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),            & 
& cplSucSdVWm(6,6),cplSvcSvVZ(3,3),cplAhSdcSdcSvaa(2,6,6,3),cplhhSdcSdcSvaa(2,6,6,3),    & 
& cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplSdSdcSdcSdabba(6,6,6,6),        & 
& cplSdSdcSdcSdabab(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSvcSdcSvaa(6,3,6,3),          & 
& cplSdcHpmcSucSvaa(6,2,6,3),cplSeSucSdcSvaa(6,6,6,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 


! {conj[Sd], conj[Sd], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSdVG(i1,gt2)
coup3 = cplSdcSdVG(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSdVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSdSd


Subroutine Amplitude_Tree_MSSMTriLnV_SvTocHpmSe(cplSecHpmcSv,MHpm,MSe,MSv,            & 
& MHpm2,MSe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MSe(6),MSv(3),MHpm2(2),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSecHpmcSv(6,2,3)

Complex(dp) :: Amp(3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplSecHpmcSv(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvTocHpmSe


Subroutine Gamma_Real_MSSMTriLnV_SvTocHpmSe(MLambda,em,gs,cplSecHpmcSv,               & 
& MHpm,MSe,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSecHpmcSv(6,2,3)

Real(dp), Intent(in) :: MHpm(2),MSe(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,2,6), GammarealGluon(3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,3
  Do i2=2,2
    Do i3=1,6
Coup = cplSecHpmcSv(i3,i2,i1)
Mex1 = MSv(i1)
Mex2 = MHpm(i2)
Mex3 = MSe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp,-1._dp,1._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvTocHpmSe


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocHpmSe(cplSecHpmcSv,ctcplSecHpmcSv,          & 
& MHpm,MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSecHpmcSv(6,2,3)

Complex(dp), Intent(in) :: ctcplSecHpmcSv(6,2,3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSecHpmcSv(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplSecHpmcSv(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt2))*cplSecHpmcSv(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplSecHpmcSv(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocHpmSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocHpmSe(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSecSe,cplAhcHpmVWm,   & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,cplhhSecSe,             & 
& cplhhSvcSv,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSdcSdcSv,            & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,cplHpmSecHpmcSe1, & 
& cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,cplSeSucSdcSvaa,   & 
& cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhSecSe(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),        & 
& cplChiChacHpmR(4,2,2),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFeChiSeL(3,4,6),     & 
& cplcFeChiSeR(3,4,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcChaFecSvL(2,3,3),     & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuSeL(3,3,6),       & 
& cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplhhHpmcHpm(2,2,2),cplhhSecSe(2,6,6),cplhhSvcSv(2,3,3),            & 
& cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplSdcHpmcSu(6,2,6),             & 
& cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSvVZ(3,3),              & 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplAhSecHpmcSv1(2,6,2,3),cplhhSecHpmcSv1(2,6,2,3),     & 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSvcHpmcSv1(2,3,2,3),cplSdSecHpmcSdaa(6,6,2,6),         & 
& cplSdcHpmcSucSvaa(6,2,6,3),cplSeSecHpmcSe1(6,6,2,6),cplSeSucSdcSvaa(6,6,6,3),          & 
& cplSeSvcHpmcSv1(6,3,2,3),cplSeSvcSecSv1(6,3,6,3),cplSecSvcVWmVP1(6,3),cplSecSvcVWmVZ1(6,3)

Complex(dp), Intent(out) :: Amp(3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 


! {Chi, Fv, Cha}
Do i1=1,4
  Do i2=1,3
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MCha(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiChacHpmL(i1,i3,gt2)
coup2R = cplChiChacHpmR(i1,i3,gt2)
coup3L = cplcChaFvSeL(i3,i2,gt3)
coup3R = cplcChaFvSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Fe}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplFvFecHpmL(i1,i3,gt2)
coup2R = cplFvFecHpmR(i1,i3,gt2)
coup3L = cplcFeChiSeL(i3,i2,gt3)
coup3R = cplcFeChiSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], Hpm}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,i3,gt2)
coup3 = cplSecHpmcSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], VWm}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MVWm 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhcHpmVWm(i1,gt2)
coup3 = cplSecSvcVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sv, hh, Se}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplSecHpmcSv(i3,gt2,i1)
coup3 = cplhhSecSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Se}
Do i1=1,3
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = cplSecHpmcSv(i3,gt2,i1)
coup3 = cplSecSeVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Hpm}
  Do i2=1,3
    Do i3=1,2
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MHpm(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = cplHpmcHpmVZ(i3,gt2)
coup3 = cplSecHpmcSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sv], VWm}
  Do i2=1,3
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MVWm 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = cplcHpmVWmVZ(gt2)
coup3 = cplSecSvcVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {bar[Cha], bar[Fe], Chi}
Do i1=1,2
  Do i2=1,3
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplChiChacHpmL(i3,i1,gt2)
coup2R = cplChiChacHpmR(i3,i1,gt2)
coup3L = cplcFeChiSeL(i2,i3,gt3)
coup3R = cplcFeChiSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFuFdcHpmL(i3,i1,gt2)
coup2R = cplcFuFdcHpmR(i3,i1,gt2)
coup3L = cplcFdFuSeL(i2,i3,gt3)
coup3R = cplcFdFuSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFvFecHpmL(i3,i1,gt2)
coup2R = cplFvFecHpmR(i3,i1,gt2)
coup3L = cplcFeFvSeL(i2,i3,gt3)
coup3R = cplcFeFvSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], Ah}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MAh(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplAhHpmcHpm(i3,i1,gt2)
coup3 = cplAhSecSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], hh}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplhhHpmcHpm(i3,i1,gt2)
coup3 = cplhhSecSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], VP}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplSecSeVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[Se], VZ}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmcHpmVZ(i1,gt2)
coup3 = cplSecSeVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcHpmcSu(i1,gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], conj[Sv]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSecHpmcSv(i1,gt2,i3)
coup3 = cplSeSvcSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], Ah}
  Do i2=1,6
    Do i3=1,2
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MAh(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplAhcHpmVWm(i3,gt2)
coup3 = cplAhSecSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Se], hh}
  Do i2=1,6
    Do i3=1,2
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplhhcHpmVWm(i3,gt2)
coup3 = cplhhSecSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Se], VP}
  Do i2=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplSecSeVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {conj[VWm], conj[Se], VZ}
  Do i2=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplcHpmVWmVZ(gt2)
coup3 = cplSecSeVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {hh, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSecHpmcSv1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSecHpmcSdaa(i2,gt3,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSecHpmcSe1(i2,gt3,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSecHpmcSe1(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhSecHpmcSv1(i1,gt3,i2,gt1)
coup2 = cplAhHpmcHpm(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhSecHpmcSv1(i1,gt3,i2,gt1)
coup2 = cplhhHpmcHpm(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Su, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
coup1 = cplSeSucSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplSdcHpmcSu(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sv, Se}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(gt3,i1,i2,gt1)
coup2 = cplSecHpmcSv(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {VP, VWm}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplSecSvcVWmVP1(gt3,gt1)
coup2 = cplcHpmVPVWm(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VZ, VWm}
ML1 = MVZ 
ML2 = MVWm 
coup1 = cplSecSvcVWmVZ1(gt3,gt1)
coup2 = cplcHpmVWmVZ(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecHpmcSv1(i1,i2,gt2,gt1)
coup2 = cplAhSecSe(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecHpmcSv1(i1,i2,gt2,gt1)
coup2 = cplhhSecSe(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcHpmcSv1(i1,i2,gt2,gt1)
coup2 = cplSecHpmcSv(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSucSvaa(i1,gt2,i2,gt1)
coup2 = cplSeSucSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSvcHpmcSv1(i1,i2,gt2,gt1)
coup2 = cplSecSecSv(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocHpmSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhSecSe,           & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,        & 
& cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcHpm,            & 
& cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,             & 
& cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,      & 
& cplSecSvcVWm,cplSvcSvVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSecHpmcSv1,cplhhSecHpmcSv1,     & 
& cplHpmSecHpmcSe1,cplHpmSvcHpmcSv1,cplSdSecHpmcSdaa,cplSdcHpmcSucSvaa,cplSeSecHpmcSe1,  & 
& cplSeSucSdcSvaa,cplSeSvcHpmcSv1,cplSeSvcSecSv1,cplSecSvcVWmVP1,cplSecSvcVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhSecSe(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),        & 
& cplChiChacHpmR(4,2,2),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFeChiSeL(3,4,6),     & 
& cplcFeChiSeR(3,4,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcChaFecSvL(2,3,3),     & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuSeL(3,3,6),       & 
& cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplhhHpmcHpm(2,2,2),cplhhSecSe(2,6,6),cplhhSvcSv(2,3,3),            & 
& cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplSdcHpmcSu(6,2,6),             & 
& cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSvVZ(3,3),              & 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplAhSecHpmcSv1(2,6,2,3),cplhhSecHpmcSv1(2,6,2,3),     & 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSvcHpmcSv1(2,3,2,3),cplSdSecHpmcSdaa(6,6,2,6),         & 
& cplSdcHpmcSucSvaa(6,2,6,3),cplSeSecHpmcSe1(6,6,2,6),cplSeSucSdcSvaa(6,6,6,3),          & 
& cplSeSvcHpmcSv1(6,3,2,3),cplSeSvcSecSv1(6,3,6,3),cplSecSvcVWmVP1(6,3),cplSecSvcVWmVZ1(6,3)

Complex(dp), Intent(out) :: Amp(3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 


! {conj[Hpm], conj[Se], VP}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplSecSeVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[VWm], conj[Se], VP}
  Do i2=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplSecSeVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VP, VWm}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplSecSvcVWmVP1(gt3,gt1)
coup2 = cplcHpmVPVWm(gt2)
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocHpmSe


Subroutine Amplitude_Tree_MSSMTriLnV_SvTocSeSe(cplSecSecSv,MSe,MSv,MSe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSv(3),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSecSecSv(6,6,3)

Complex(dp) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplSecSecSv(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvTocSeSe


Subroutine Gamma_Real_MSSMTriLnV_SvTocSeSe(MLambda,em,gs,cplSecSecSv,MSe,             & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSecSecSv(6,6,3)

Real(dp), Intent(in) :: MSe(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,6,6), GammarealGluon(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
Coup = cplSecSecSv(i3,i2,i1)
Mex1 = MSv(i1)
Mex2 = MSe(i2)
Mex3 = MSe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp,-1._dp,1._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvTocSeSe


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocSeSe(cplSecSecSv,ctcplSecSecSv,             & 
& MSe,MSe2,MSv,MSv2,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSecSecSv(6,6,3)

Complex(dp), Intent(in) :: ctcplSecSecSv(6,6,3)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSecSecSv(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplSecSecSv(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt2))*cplSecSecSv(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplSecSecSv(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTocSeSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocSeSe(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),        & 
& cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcChaFecSvL(2,3,3),        & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuSeL(3,3,6),       & 
& cplcFdFuSeR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),            & 
& cplhhSvcSv(2,3,3),cplHpmSvcSe(2,3,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),            & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),& 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhSecSecSv1(2,6,6,3),& 
& cplhhSecSecSv1(2,6,6,3),cplHpmSecSecSe1(2,6,6,6),cplHpmSvcSecSv1(2,3,6,3),             & 
& cplSdSecSdcSeaa(6,6,6,6),cplSeSecSecSe1(6,6,6,6),cplSeSucSdcSvaa(6,6,6,3),             & 
& cplSeSvcSecSv1(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 


! {Chi, Fv, Fe}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiFecSeL(i1,i3,gt2)
coup2R = cplChiFecSeR(i1,i3,gt2)
coup3L = cplcFeFvSeL(i3,i2,gt3)
coup3R = cplcFeFvSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Fe}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplFvFecSeL(i1,i3,gt2)
coup2R = cplFvFecSeR(i1,i3,gt2)
coup3L = cplcFeChiSeL(i3,i2,gt3)
coup3R = cplcFeChiSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], Se}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSecSe(i1,i3,gt2)
coup3 = cplSecSecSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, hh, Se}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplSecSecSv(i3,gt2,i1)
coup3 = cplhhSecSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, Se}
Do i1=1,3
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = cplSecSecSv(i3,gt2,i1)
coup3 = cplSecSeVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], Se}
  Do i2=1,3
    Do i3=1,6
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = cplSecSeVZ(i3,gt2)
coup3 = cplSecSecSv(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], Fv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplFvChacSeL(i3,i1,gt2)
coup2R = cplFvChacSeR(i3,i1,gt2)
coup3L = cplcFeFvSeL(i2,i3,gt3)
coup3R = cplcFeFvSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplcFuFdcSeL(i3,i1,gt2)
coup2R = cplcFuFdcSeR(i3,i1,gt2)
coup3L = cplcFdFuSeL(i2,i3,gt3)
coup3R = cplcFdFuSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MChi(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplChiFecSeL(i3,i1,gt2)
coup2R = cplChiFecSeR(i3,i1,gt2)
coup3L = cplcFeChiSeL(i2,i3,gt3)
coup3R = cplcFeChiSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFvFecSeL(i3,i1,gt2)
coup2R = cplFvFecSeR(i3,i1,gt2)
coup3L = cplcFeFvSeL(i2,i3,gt3)
coup3R = cplcFeFvSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], Sv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,i3,gt2)
coup3 = cplSecSecSv(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2 = cplSdcSecSu(i1,gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MAh(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplAhSecSe(i3,i1,gt2)
coup3 = cplAhSecSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], hh}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplhhSecSe(i3,i1,gt2)
coup3 = cplhhSecSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSeSvcSe(i1,i3,gt2)
coup3 = cplSecSecSv(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSecSeVP(i1,gt2)
coup3 = cplSecSeVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Se], conj[Se], VZ}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSecSeVZ(i1,gt2)
coup3 = cplSecSeVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Se], conj[Se], conj[Sv]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSecSecSv(i1,gt2,i3)
coup3 = cplSeSvcSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], Sv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplSvcSeVWm(i3,gt2)
coup3 = cplSecSecSv(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {hh, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSecSecSv1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSecSdcSeaa(i2,gt3,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSecSecSe1(i2,gt3,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSecSecSe1(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, Se}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSecSv1(i1,gt3,i2,gt1)
coup2 = cplAhSecSe(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, Se}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSecSv1(i1,gt3,i2,gt1)
coup2 = cplhhSecSe(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Su, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
coup1 = cplSeSucSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplSdcSecSu(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sv, Se}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(gt3,i1,i2,gt1)
coup2 = cplSecSecSv(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSecSv1(i1,i2,gt2,gt1)
coup2 = cplAhSecSe(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSecSv1(i1,i2,gt2,gt1)
coup2 = cplhhSecSe(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcSecSv1(i1,i2,gt2,gt1)
coup2 = cplSecHpmcSv(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSvcSecSv1(i1,i2,gt2,gt1)
coup2 = cplSecSecSv(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTocSeSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdcSdcSv,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSecSecSv1,cplhhSecSecSv1,cplHpmSecSecSe1,cplHpmSvcSecSv1,  & 
& cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSdcSvaa,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),        & 
& cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcChaFecSvL(2,3,3),        & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuSeL(3,3,6),       & 
& cplcFdFuSeR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),            & 
& cplhhSvcSv(2,3,3),cplHpmSvcSe(2,3,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),            & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),& 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhSecSecSv1(2,6,6,3),& 
& cplhhSecSecSv1(2,6,6,3),cplHpmSecSecSe1(2,6,6,6),cplHpmSvcSecSv1(2,3,6,3),             & 
& cplSdSecSdcSeaa(6,6,6,6),cplSeSecSecSe1(6,6,6,6),cplSeSucSdcSvaa(6,6,6,3),             & 
& cplSeSvcSecSv1(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 


! {conj[Se], conj[Se], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSecSeVP(i1,gt2)
coup3 = cplSecSeVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTocSeSe


Subroutine Amplitude_Tree_MSSMTriLnV_SvToSecVWm(cplSecSvcVWm,MSe,MSv,MVWm,            & 
& MSe2,MSv2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSv(3),MVWm,MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplSecSvcVWm(6,3)

Complex(dp) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = -cplSecSvcVWm(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvToSecVWm


Subroutine Gamma_Real_MSSMTriLnV_SvToSecVWm(MLambda,em,gs,cplSecSvcVWm,               & 
& MSe,MSv,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSecSvcVWm(6,3)

Real(dp), Intent(in) :: MSe(6),MSv(3),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,6), GammarealGluon(3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,3
  Do i2=1,6
Coup = cplSecSvcVWm(i2,i1)
Mex1 = MSv(i1)
Mex2 = MSe(i2)
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,0._dp,-1._dp,1._dp,Coup,Gammarealphoton(i1,i2),kont)
 GammarealGluon(i1,i2) = 0._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvToSecVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSecVWm(cplSecSvcVWm,ctcplSecSvcVWm,          & 
& MSe,MSe2,MSv,MSv2,MVWm,MVWm2,ZfSe,ZfSv,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: cplSecSvcVWm(6,3)

Complex(dp), Intent(in) :: ctcplSecSvcVWm(6,3)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfSv(3,3),ZfVWm

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSecSvcVWm(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplSecSvcVWm(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt2)*cplSecSvcVWm(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplSecSvcVWm(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSecVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSecVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSecSe,cplChiChacVWmL, & 
& cplChiChacVWmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,       & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,      & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,          & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,               & 
& cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,cplSeSucSd,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSvVZ,     & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1,            & 
& cplSvcSvcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2),cplAhSecSe(2,6,6),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),          & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),         & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplhhHpmcVWm(2,2),cplhhSecSe(2,6,6),cplhhSvcSv(2,3,3),cplhhcVWmVWm(2),cplHpmcVWmVP(2), & 
& cplHpmcVWmVZ(2),cplSdcSdcSv(6,6,3),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),& 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),& 
& cplSvcSvVZ(3,3),cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1(6,3),cplSecSecVWmVWm1(6,6),  & 
& cplSecSvcVWmVZ1(6,3),cplSvcSvcVWmVWm1(3,3)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVWm 


! {Chi, Fv, bar[Fe]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplcFeChiSeL(i3,i1,gt2)
coup2R = cplcFeChiSeR(i3,i1,gt2)
coup3L = cplFvFecVWmL(i2,i3)
coup3R = cplFvFecVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,i3,gt2)
coup2R = cplcFdFuSeR(i1,i3,gt2)
coup3L = -cplcFuFdcVWmR(i3,i2)
coup3R = -cplcFuFdcVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,i3,gt2)
coup2R = cplcFeChiSeR(i1,i3,gt2)
coup3L = -cplChiChacVWmR(i3,i2)
coup3R = -cplChiChacVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,i3,gt2)
coup2R = cplcFeFvSeR(i1,i3,gt2)
coup3L = -cplFvFecVWmR(i3,i2)
coup3R = -cplFvFecVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, bar[Cha]}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i3,i1,gt2)
coup2R = cplcChaFvSeR(i3,i1,gt2)
coup3L = cplChiChacVWmL(i2,i3)
coup3R = cplChiChacVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], conj[Se]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSecSe(i1,gt2,i3)
coup3 = cplSecSvcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSeSucSd(gt2,i3,i1)
coup3 = -cplSdcSucVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplAhSecSe(i3,gt2,i1)
coup3 = cplAhHpmcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
coup3 = cplhhHpmcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
coup3 = cplhhcVWmVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, Se, Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSe(gt2,i3,i1)
coup3 = -cplSecSvcVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplSecSeVP(gt2,i1)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, VWm, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplSecSeVP(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, Hpm, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplSecSeVZ(gt2,i1)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, VWm, VZ}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplSecSeVZ(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, hh, conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
coup3 = -cplhhHpmcVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sv, VZ, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sv, hh, conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sv, VZ, conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VZ, conj[Sv], conj[Se]}
  Do i2=1,3
    Do i3=1,6
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = cplSecSeVZ(gt2,i3)
coup3 = cplSecSvcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Se, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
coup1 = -cplSecSvcVWm(i1,gt1)
coup2 = cplSecSecVWmVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, VZ}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
coup1 = -cplSvcSvVZ(i1,gt1)
coup2 = cplSecSvcVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = cplSecSvcVWmVP1(i1,gt1)
coup2 = cplSecSeVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Se, VZ}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
coup1 = cplSecSvcVWmVZ1(i1,gt1)
coup2 = cplSecSeVZ(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Sv, conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
coup1 = cplSvcSvcVWmVWm1(i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSecVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,cplAhSecSe,           & 
& cplChiChacVWmL,cplChiChacVWmR,cplChiFvcSvL,cplChiFvcSvR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,       & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhHpmcVWm,cplhhSecSe,             & 
& cplhhSvcSv,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSdcSv,cplSdcSucVWm,            & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSvVZ,cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1,cplSecSecVWmVWm1,cplSecSvcVWmVZ1, & 
& cplSvcSvcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2),cplAhSecSe(2,6,6),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),          & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),         & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplhhHpmcVWm(2,2),cplhhSecSe(2,6,6),cplhhSvcSv(2,3,3),cplhhcVWmVWm(2),cplHpmcVWmVP(2), & 
& cplHpmcVWmVZ(2),cplSdcSdcSv(6,6,3),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),& 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),& 
& cplSvcSvVZ(3,3),cplcVWmVPVWm,cplcVWmVWmVZ,cplSecSvcVWmVP1(6,3),cplSecSecVWmVWm1(6,6),  & 
& cplSecSvcVWmVZ1(6,3),cplSvcSvcVWmVWm1(3,3)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVWm 


! {Se, Hpm, VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplSecSeVP(gt2,i1)
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, VWm, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplSecSeVP(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = cplSecSvcVWmVP1(i1,gt1)
coup2 = cplSecSeVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSecVWm


Subroutine Amplitude_Tree_MSSMTriLnV_SvToSvVZ(cplSvcSvVZ,MSv,MVZ,MSv2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MVZ,MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplSvcSvVZ(3,3)

Complex(dp) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1 = -cplSvcSvVZ(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SvToSvVZ


Subroutine Gamma_Real_MSSMTriLnV_SvToSvVZ(MLambda,em,gs,cplSvcSvVZ,MSv,               & 
& MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSvcSvVZ(3,3)

Real(dp), Intent(in) :: MSv(3),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3), GammarealGluon(3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,3
  Do i2=1,3
Coup = cplSvcSvVZ(i2,i1)
Mex1 = MSv(i1)
Mex2 = MSv(i2)
Mex3 = MVZ
If (Mex1.gt.(Mex2+Mex3)) Then 
 Gammarealphoton(i1,i2) = 0._dp 
 GammarealGluon(i1,i2) = 0._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SvToSvVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvVZ(cplSvcSvVZ,ctcplSvcSvVZ,MSv,            & 
& MSv2,MVZ,MVZ2,ZfSv,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVZ,MVZ2

Complex(dp), Intent(in) :: cplSvcSvVZ(3,3)

Complex(dp), Intent(in) :: ctcplSvcSvVZ(3,3)

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVZ

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSvcSvVZ(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt1))*cplSvcSvVZ(gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSv(i1,gt2)*cplSvcSvVZ(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplSvcSvVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvVZ(MCha,MChi,MFd,MFe,Mhh,MHpm,           & 
& MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,MVWm2,            & 
& MVZ2,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,               & 
& cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,      & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,             & 
& cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,cplSvcSvVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,               & 
& MVZ,MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),        & 
& MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),        & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),             & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),         & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),             & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplhhSvcSv(2,3,3),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),     & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),& 
& cplSeSvcSe(6,3,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),              & 
& cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplcHpmVWmVZ(2),cplcVWmVWmVZ,       & 
& cplSecSvcVWmVZ1(6,3),cplSvcSeVWmVZ1(3,6),cplSvcSvVZVZ1(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVZ 


! {Chi, Fv, Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
coup3L = -cplFvFvVZR(i3,i2)
coup3R = -cplFvFvVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = -cplcFdFdVZR(i3,i2)
coup3R = -cplcFdFdVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
coup3L = -cplcChaChaVZR(i3,i2)
coup3R = -cplcChaChaVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = -cplcFeFeVZR(i3,i2)
coup3R = -cplcFeFeVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fv, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = 0. 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFvcSvL(i2,i1,gt1)
coup1R = cplChiFvcSvR(i2,i1,gt1)
coup2L = cplChiFvSvL(i3,i1,gt2)
coup2R = cplChiFvSvR(i3,i1,gt2)
coup3L = -cplChiChiVZR(i3,i2)
coup3R = -cplChiChiVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], conj[Sv]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i3)
coup3 = cplSvcSvVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, VWm, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, VZ, hh}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSvcSvVZ(i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
coup3 = cplhhVZVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sv, hh, VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSvcSv(i2,i1,gt1)
coup2 = cplSvcSvVZ(gt2,i1)
coup3 = cplhhVZVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VZ, conj[Sv], conj[Sv]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = cplSvcSvVZ(gt2,i3)
coup3 = cplSvcSvVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], bar[Fe]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i3,i1,gt2)
coup2R = cplcFeChaSvR(i3,i1,gt2)
coup3L = cplcFeFeVZL(i2,i3)
coup3R = cplcFeFeVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = cplSecSeVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplSvcSeVWm(gt2,i3)
coup3 = cplSecSeVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Se, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
coup1 = -cplSecSvcVWm(i1,gt1)
coup2 = cplSvcSeVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, VZ}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
coup1 = -cplSvcSvVZ(i1,gt1)
coup2 = cplSvcSvVZVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
coup1 = cplSecSvcVWmVZ1(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Sv, VZ}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVZ 
coup1 = cplSvcSvVZVZ1(i1,gt1)
coup2 = cplSvcSvVZ(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ(MCha,MChi,MFd,MFe,Mhh,             & 
& MHpm,MSd,MSe,MSv,MVWm,MVZ,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,MSe2,MSv2,             & 
& MVWm2,MVZ2,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,         & 
& cplChiChiVZR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,          & 
& cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,cplhhSvcSv,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,      & 
& cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVZ,cplSdcSdcSv,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,             & 
& cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,cplSvcSvVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,               & 
& MVZ,MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),        & 
& MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),        & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),             & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),         & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),             & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplhhSvcSv(2,3,3),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),     & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),& 
& cplSeSvcSe(6,3,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),              & 
& cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplcHpmVWmVZ(2),cplcVWmVWmVZ,       & 
& cplSecSvcVWmVZ1(6,3),cplSvcSeVWmVZ1(3,6),cplSvcSvVZVZ1(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhAh(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MAh(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhAh(MAh,MFd,MFe,MSd,MSe,MSv,              & 
& MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplSdcSdcSv,cplSecSecSv,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdcSdcSvaa,cplAhSecSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),MSd2(6),            & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),           & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3),         & 
& cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),cplAhSdcSdcSvaa(2,6,6,3),               & 
& cplAhSecSecSv1(2,6,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MAh(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
coup3L = cplcFdFdAhL(i3,i2,gt3)
coup3R = cplcFdFdAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = cplcFeFeAhL(i3,i2,gt3)
coup3R = cplcFeFeAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = cplAhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplAhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhAhSdcSdaa(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhAhSecSe1(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSecSv1(gt3,i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(gt2,i1,i2,gt1)
coup2 = cplAhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSecSv1(gt2,i1,i2,gt1)
coup2 = cplAhSecSe(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhAh(MAh,MFd,MFe,MSd,MSe,               & 
& MSv,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,     & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplSdcSdcSv,cplSecSecSv,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdcSdcSvaa,cplAhSecSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),MSd2(6),            & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),           & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3),         & 
& cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),cplAhSdcSdcSvaa(2,6,6,3),               & 
& cplAhSecSecSv1(2,6,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MAh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhAh


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhhh(MAh,MAh2,Mhh,Mhh2,MSv,MSv2,             & 
& ZfAh,Zfhh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),Mhh(2),Mhh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),Zfhh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = Mhh(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhhh(MAh,MFd,MFe,Mhh,MSd,MSe,              & 
& MSv,MAh2,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdcSv,cplSecSecSv,cplAhSdcSdcSvaa,cplAhSecSecSv1,cplhhSdcSdcSvaa,cplhhSecSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),             & 
& Mhh2(2),MSd2(6),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),             & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),           & 
& cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3),cplAhSdcSdcSvaa(2,6,6,3),cplAhSecSecSv1(2,6,6,3),& 
& cplhhSdcSdcSvaa(2,6,6,3),cplhhSecSecSv1(2,6,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = Mhh(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
coup3L = cplcFdFdhhL(i3,i2,gt3)
coup3R = cplcFdFdhhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = cplcFeFehhL(i3,i2,gt3)
coup3R = cplcFeFehhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = cplhhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplhhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSecSv1(gt3,i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(gt2,i1,i2,gt1)
coup2 = cplhhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSecSv1(gt2,i1,i2,gt1)
coup2 = cplhhSecSe(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhhh(MAh,MFd,MFe,Mhh,MSd,               & 
& MSe,MSv,MAh2,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,        & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdcSv,cplSecSecSv,cplAhSdcSdcSvaa,cplAhSecSecSv1,cplhhSdcSdcSvaa,cplhhSecSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),             & 
& Mhh2(2),MSd2(6),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),             & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),           & 
& cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3),cplAhSdcSdcSvaa(2,6,6,3),cplAhSecSecSv1(2,6,6,3),& 
& cplhhSdcSdcSvaa(2,6,6,3),cplhhSecSecSv1(2,6,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = Mhh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhhh


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSv(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhSv(MAh,MCha,MChi,MFd,MFe,Mhh,            & 
& MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,MSd2,              & 
& MSe2,MSu2,MSv2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,       & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,               & 
& cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSdcSv,               & 
& cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplSvcSvVZ,               & 
& cplAhHpmSvcSe1,cplAhSdSvcSdaa,cplAhSdcSdcSvaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,           & 
& cplAhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MSv(3),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),            & 
& MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),& 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),           & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplhhSvcSv(2,3,3),cplHpmSvcSe(2,3,6),          & 
& cplSdSvcSd(6,3,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhHpmSvcSe1(2,2,3,6),& 
& cplAhSdSvcSdaa(2,6,3,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSeSvcSe1(2,6,3,6),               & 
& cplAhSecHpmcSv1(2,6,2,3),cplAhSecSecSv1(2,6,6,3),cplHpmSvcHpmcSv1(2,3,2,3),            & 
& cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcSecSv1(6,3,6,3),cplSuSvcSucSvaa(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSv(gt3) 


! {Chi, Fv, Chi}
Do i1=1,4
  Do i2=1,3
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = 0. 
ML3 = MChi(i3) 
coup1L = cplChiFvcSvL(i1,i2,gt1)
coup1R = cplChiFvcSvR(i1,i2,gt1)
coup2L = cplChiChiAhL(i1,i3,gt2)
coup2R = cplChiChiAhR(i1,i3,gt2)
coup3L = cplChiFvSvL(i3,i2,gt3)
coup3R = cplChiFvSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
coup3L = cplcFdFdSvL(i3,i2,gt3)
coup3R = cplcFdFdSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Fe}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = cplcFeChaSvL(i3,i2,gt3)
coup3R = cplcFeChaSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = cplcFeFeSvL(i3,i2,gt3)
coup3R = cplcFeFeSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {hh, conj[Sv], VZ}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
ML3 = MVZ 
coup1 = cplhhSvcSv(i1,i2,gt1)
coup2 = -cplAhhhVZ(gt2,i1)
coup3 = cplSvcSvVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = cplSdSvcSd(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplHpmSvcSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplSeSvcSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplSvcSeVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VZ, conj[Sv], hh}
  Do i2=1,3
    Do i3=1,2
ML1 = MVZ 
ML2 = MSv(i2) 
ML3 = Mhh(i3) 
coup1 = cplSvcSvVZ(i2,gt1)
coup2 = -cplAhhhVZ(gt2,i3)
coup3 = cplhhSvcSv(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fe], bar[Cha]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcChaChaAhL(i3,i1,gt2)
coup2R = cplcChaChaAhR(i3,i1,gt2)
coup3L = cplcFeChaSvL(i2,i3,gt3)
coup3R = cplcFeChaSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Hpm]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MHpm(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplAhHpmcHpm(gt2,i1,i3)
coup3 = cplHpmSvcSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[VWm]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MVWm 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = -cplAhHpmcVWm(gt2,i1)
coup3 = cplSvcSeVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[VWm], conj[Se], conj[Hpm]}
  Do i2=1,6
    Do i3=1,2
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MHpm(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = -cplAhcHpmVWm(gt2,i3)
coup3 = cplHpmSvcSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhSdSvcSdaa(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplAhHpmSvcSe1(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhSeSvcSe1(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplHpmSvcHpmcSv1(i1,gt3,i2,gt1)
coup2 = cplAhHpmcHpm(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSvcSdcSvaa(i1,gt3,i2,gt1)
coup2 = cplAhSdcSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(i1,gt3,i2,gt1)
coup2 = cplAhSecSe(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplSuSvcSucSvaa(i1,gt3,i2,gt1)
coup2 = cplAhSucSu(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(gt2,i1,i2,gt1)
coup2 = cplSdSvcSd(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhSecHpmcSv1(gt2,i1,i2,gt1)
coup2 = cplHpmSvcSe(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSecSv1(gt2,i1,i2,gt1)
coup2 = cplSeSvcSe(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhSv(MAh,MCha,MChi,MFd,MFe,             & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,Mhh2,MHpm2,               & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,               & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhhhVZ,cplAhHpmcHpm,   & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,               & 
& cplcFeChaSvR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdFdSvL,            & 
& cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,           & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,             & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplSvcSvVZ,cplAhHpmSvcSe1,cplAhSdSvcSdaa,cplAhSdcSdcSvaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,& 
& cplAhSecSecSv1,cplHpmSvcHpmcSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,cplSuSvcSucSvaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MSv(3),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),Mhh2(2),MHpm2(2),            & 
& MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),& 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),           & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplhhSvcSv(2,3,3),cplHpmSvcSe(2,3,6),          & 
& cplSdSvcSd(6,3,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhHpmSvcSe1(2,2,3,6),& 
& cplAhSdSvcSdaa(2,6,3,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSeSvcSe1(2,6,3,6),               & 
& cplAhSecHpmcSv1(2,6,2,3),cplAhSecSecSv1(2,6,6,3),cplHpmSvcHpmcSv1(2,3,2,3),            & 
& cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcSecSv1(6,3,6,3),cplSuSvcSucSvaa(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhSv


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhVP(MAh,MAh2,MSv,MSv2,MVP,MVP2,             & 
& ZfAh,ZfSv,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3),MVP,MVP2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3),ZfVP

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhVP(MAh,MFd,MFe,MSd,MSe,MSv,              & 
& MVP,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdcSv,              & 
& cplSecSeVP,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFecSvL(3,3,3),             & 
& cplcFeFecSvR(3,3,3),cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVP 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
coup3L = -cplcFdFdVPR(i3,i2)
coup3R = -cplcFdFdVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = -cplcFeFeVPR(i3,i2)
coup3R = -cplcFeFeVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhVP(MAh,MFd,MFe,MSd,MSe,               & 
& MSv,MVP,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,        & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdcSv,              & 
& cplSecSeVP,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFecSvL(3,3,3),             & 
& cplcFeFecSvR(3,3,3),cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhVZ(MAh,MAh2,MSv,MSv2,MVZ,MVZ2,             & 
& ZfAh,ZfSv,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3),ZfVZ

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVZ 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToAhVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhVZ(MAh,MFd,MFe,MSd,MSe,MSv,              & 
& MVZ,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVZ,cplSdcSdcSv,              & 
& cplSecSeVZ,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVZ,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),             & 
& cplcFeFecSvR(3,3,3),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSecSeVZ(6,6),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVZ 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
coup3L = -cplcFdFdVZR(i3,i2)
coup3R = -cplcFdFdVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = -cplcFeFeVZR(i3,i2)
coup3R = -cplcFeFeVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToAhVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhVZ(MAh,MFd,MFe,MSd,MSe,               & 
& MSv,MVZ,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,        & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVZ,cplSdcSdcSv,              & 
& cplSecSeVZ,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVZ,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),             & 
& cplcFeFecSvR(3,3,3),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSecSeVZ(6,6),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToAhVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToChacCha(MCha,MCha2,MSv,MSv2,ZfLm,            & 
& ZfLp,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfLm(2,2),ZfLp(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 
ZcoupT1L = 0._dp 
ZcoupT1R = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToChacCha


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToChacCha(MCha,MFd,MFe,MFu,MSd,              & 
& MSe,MSu,MSv,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,        & 
& cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcChaFecSvL,cplcChaFecSvR,     & 
& cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,       & 
& cplSdcSdcSv,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MCha2(2),MFd2(3),            & 
& MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),     & 
& cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 


! {Fd, Fd, Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,gt2,i3)
coup2R = cplcFdChaSuR(i1,gt2,i3)
coup3L = cplcChaFdcSuL(gt3,i2,i3)
coup3R = cplcChaFdcSuR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,gt2,i3)
coup2R = cplcFeChaSvR(i1,gt2,i3)
coup3L = cplcChaFecSvL(gt3,i2,i3)
coup3R = cplcChaFecSvR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplChaFucSdL(gt2,i3,i1)
coup2R = cplChaFucSdR(gt2,i3,i1)
coup3L = cplcChacFuSdL(gt3,i3,i2)
coup3R = cplcChacFuSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Fv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2L = cplFvChacSeL(i3,gt2,i1)
coup2R = cplFvChacSeR(i3,gt2,i1)
coup3L = cplcChaFvSeL(gt3,i3,i2)
coup3R = cplcChaFvSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToChacCha


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToChacCha(MCha,MFd,MFe,MFu,               & 
& MSd,MSe,MSu,MSv,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,cplChaFucSdR,    & 
& cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcChaFecSvL,cplcChaFecSvR,     & 
& cplcFeFecSvL,cplcFeFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,       & 
& cplSdcSdcSv,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MCha2(2),MFd2(3),            & 
& MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),     & 
& cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToChacCha


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToChiChi(MChi,MChi2,MSv,MSv2,ZfL0,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfL0(4,4),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,4
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 
ZcoupT1L = 0._dp 
ZcoupT1R = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToChiChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToChiChi(MChi,MFd,MFe,MSd,MSe,               & 
& MSv,MChi2,MFd2,MFe2,MSd2,MSe2,MSv2,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,             & 
& cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,         & 
& cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MChi2(4),MFd2(3),MFe2(3),MSd2(6),          & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
coup3L = cplChiFdcSdL(gt3,i2,i3)
coup3R = cplChiFdcSdR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,gt2,i3)
coup2R = cplcFeChiSeR(i1,gt2,i3)
coup3L = cplChiFecSeL(gt3,i2,i3)
coup3R = cplChiFecSeR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
coup3L = cplcFdChiSdL(i3,gt3,i2)
coup3R = cplcFdChiSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2L = cplChiFecSeL(gt2,i3,i1)
coup2R = cplChiFecSeR(gt2,i3,i1)
coup3L = cplcFeChiSeL(i3,gt3,i2)
coup3R = cplcFeChiSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplChiFdcSdL(gt2,i1,i3)
coup2R = cplChiFdcSdR(gt2,i1,i3)
coup3L = cplcFdChiSdL(i2,gt3,i3)
coup3R = cplcFdChiSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplChiFecSeL(gt2,i1,i3)
coup2R = cplChiFecSeR(gt2,i1,i3)
coup3L = cplcFeChiSeL(i2,gt3,i3)
coup3R = cplcFeChiSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdChiSdL(i3,gt2,i1)
coup2R = cplcFdChiSdR(i3,gt2,i1)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], bar[Fe]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFeChiSeL(i3,gt2,i1)
coup2R = cplcFeChiSeR(i3,gt2,i1)
coup3L = cplChiFecSeL(gt3,i3,i2)
coup3R = cplChiFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToChiChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToChiChi(MChi,MFd,MFe,MSd,MSe,            & 
& MSv,MChi2,MFd2,MFe2,MSd2,MSe2,MSv2,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,             & 
& cplChiFecSeR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdcSvL,         & 
& cplcFdFdcSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdcSv,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MChi2(4),MFd2(3),MFe2(3),MSd2(6),          & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToChiChi


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToFucFu(MFu,MFu2,MSv,MSv2,ZfFUL,               & 
& ZfFUR,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 
ZcoupT1L = 0._dp 
ZcoupT1R = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToFucFu


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToFucFu(MCha,MFd,MFe,MFu,MHpm,               & 
& MSd,MSe,MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,         & 
& cplChaFucSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,       & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,        & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,         & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,        & 
& cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),      & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),        & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 


! {Fd, Fd, Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3L = cplcFuFdcHpmL(gt3,i2,i3)
coup3R = cplcFuFdcHpmR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSe(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3L = cplcFuFdcSeL(gt3,i2,i3)
coup3R = cplcFuFdcSeR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVWm 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
coup3L = -cplcFuFdcVWmR(gt3,i2)
coup3R = -cplcFuFdcVWmL(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd, Cha}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MCha(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = cplcChacFuSdL(i3,gt3,i2)
coup3R = cplcChacFuSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFe(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFecFuSdL(i3,gt3,i2)
coup3R = cplcFecFuSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], bar[Fe], conj[Sd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MSd(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3L = cplcFecFuSdL(i2,gt3,i3)
coup3R = cplcFecFuSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSd(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3L = cplcFecFuSdL(i2,gt3,i3)
coup3R = cplcFecFuSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], bar[Fd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MFd(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFuFdcSeL(gt3,i3,i2)
coup3R = cplcFuFdcSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFd(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFuFdcSeL(gt3,i3,i2)
coup3R = cplcFuFdcSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MFd(i3) 
coup1 = -cplSecSvcVWm(i2,gt1)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
coup3L = cplcFuFdcSeL(gt3,i3,i2)
coup3R = cplcFuFdcSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToFucFu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToFucFu(MCha,MFd,MFe,MFu,MHpm,            & 
& MSd,MSe,MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,         & 
& cplChaFucSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,       & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcChaFecSvL,        & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,         & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,        & 
& cplcFecFuSdR,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),      & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),        & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToFucFu


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToFvFv(MSv,MSv2,ZfFvL,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfFvL(3,3),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = 0. 
ZcoupT1L = 0._dp 
ZcoupT1R = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToFvFv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToFvFv(MCha,MFd,MFe,MHpm,MSd,MSe,            & 
& MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplFvChacSeL,cplFvChacSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),MFd2(3),             & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),        & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),       & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = 0. 


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3L = cplFvFdcSdL(gt3,i2,i3)
coup3R = cplFvFdcSdR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,gt2,i3)
coup2R = cplcFeFvHpmR(i1,gt2,i3)
coup3L = cplFvFecHpmL(gt3,i2,i3)
coup3R = cplFvFecHpmR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Se}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MSe(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
coup3L = cplFvChacSeL(gt3,i2,i3)
coup3R = cplFvChacSeR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
coup3L = cplFvFecSeL(gt3,i2,i3)
coup3R = cplFvFecSeR(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MVWm 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = -cplcFeFvVWmR(i1,gt2)
coup2R = -cplcFeFvVWmL(i1,gt2)
coup3L = -cplFvFecVWmR(gt3,i2)
coup3R = -cplFvFecVWmL(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFvSdL(i3,gt3,i2)
coup3R = cplcFdFvSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Cha}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MCha(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
coup3L = cplcChaFvSeL(i3,gt3,i2)
coup3R = cplcChaFvSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeFvHpmL(i3,gt3,i2)
coup3R = cplcFeFvHpmR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeFvSeL(i3,gt3,i2)
coup3R = cplcFeFvSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MFe(i3) 
coup1 = -cplSecSvcVWm(i1,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeFvVWmL(i3,gt3)
coup3R = cplcFeFvVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {bar[Cha], bar[Fe], conj[Se]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i1,i3)
coup2R = cplFvChacSeR(gt2,i1,i3)
coup3L = cplcFeFvSeL(i2,gt3,i3)
coup3R = cplcFeFvSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplFvFdcSdL(gt2,i1,i3)
coup2R = cplFvFdcSdR(gt2,i1,i3)
coup3L = cplcFdFvSdL(i2,gt3,i3)
coup3R = cplcFdFvSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Hpm]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFvFecHpmL(gt2,i1,i3)
coup2R = cplFvFecHpmR(gt2,i1,i3)
coup3L = cplcFeFvHpmL(i2,gt3,i3)
coup3R = cplcFeFvHpmR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i1,i3)
coup2R = cplFvFecSeR(gt2,i1,i3)
coup3L = cplcFeFvSeL(i2,gt3,i3)
coup3R = cplcFeFvSeR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], conj[VWm]}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MVWm 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplFvFecVWmL(gt2,i1)
coup2R = cplFvFecVWmR(gt2,i1)
coup3L = cplcFeFvVWmL(i2,gt3)
coup3R = cplcFeFvVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[Se], bar[Fe]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i3,gt2,i1)
coup2R = cplcFeFvHpmR(i3,gt2,i1)
coup3L = cplFvFecSeL(gt3,i3,i2)
coup3R = cplFvFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdFvSdL(i3,gt2,i1)
coup2R = cplcFdFvSdR(i3,gt2,i1)
coup3L = cplFvFdcSdL(gt3,i3,i2)
coup3R = cplFvFdcSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], bar[Cha]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MCha(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcChaFvSeL(i3,gt2,i1)
coup2R = cplcChaFvSeR(i3,gt2,i1)
coup3L = cplFvChacSeL(gt3,i3,i2)
coup3R = cplFvChacSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], bar[Fe]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2L = cplcFeFvSeL(i3,gt2,i1)
coup2R = cplcFeFvSeR(i3,gt2,i1)
coup3L = cplFvFecSeL(gt3,i3,i2)
coup3R = cplFvFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], bar[Fe]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = -cplSecSvcVWm(i2,gt1)
coup2L = -cplcFeFvVWmR(i3,gt2)
coup2R = -cplcFeFvVWmL(i3,gt2)
coup3L = cplFvFecSeL(gt3,i3,i2)
coup3R = cplFvFecSeR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToFvFv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvFv(MCha,MFd,MFe,MHpm,MSd,             & 
& MSe,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplFvChacSeL,cplFvChacSeR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcChaFecSvL,cplcChaFecSvR,         & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),MFd2(3),             & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),        & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),       & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),             & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = 0. 
Mex3 = 0. 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToFvFv


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToGluGlu(MGlu,MGlu2,MSv,MSv2,ZffG,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MGlu,MGlu2,MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZffG,ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MGlu 
Mex3 = MGlu 
ZcoupT1L = 0._dp 
ZcoupT1R = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 0*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToGluGlu


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToGluGlu(MFd,MGlu,MSd,MSv,MFd2,              & 
& MGlu2,MSd2,MSv2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdGluSdL,      & 
& cplcFdGluSdR,cplSdcSdcSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MSv(3),MFd2(3),MGlu2,MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),          & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplSdcSdcSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MGlu 
Mex3 = MGlu 


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3L = cplGluFdcSdL(i2,i3)
coup3R = cplGluFdcSdR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdGluSdL(i3,i2)
coup3R = cplcFdGluSdR(i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdcSvL(i1,i2,gt1)
coup1R = cplcFdFdcSvR(i1,i2,gt1)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3L = cplcFdGluSdL(i2,i3)
coup3R = cplcFdGluSdR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i2,i1,gt1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplGluFdcSdL(i3,i2)
coup3R = cplGluFdcSdR(i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToGluGlu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToGluGlu(MFd,MGlu,MSd,MSv,MFd2,           & 
& MGlu2,MSd2,MSv2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFdGluSdL,      & 
& cplcFdGluSdR,cplSdcSdcSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MSv(3),MFd2(3),MGlu2,MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),          & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplSdcSdcSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MGlu 
Mex3 = MGlu 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToGluGlu


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTohhhh(Mhh,Mhh2,MSv,MSv2,Zfhh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = Mhh(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTohhhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTohhhh(MFd,MFe,Mhh,MSd,MSe,MSv,              & 
& MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdcSv,cplSecSecSv,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhSdcSdcSvaa,cplhhSecSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MFd2(3),MFe2(3),Mhh2(2),MSd2(6),            & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),        & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),         & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3),             & 
& cplhhhhSdcSdaa(2,2,6,6),cplhhhhSecSe1(2,2,6,6),cplhhSdcSdcSvaa(2,6,6,3),               & 
& cplhhSecSecSv1(2,6,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = Mhh(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
coup3L = cplcFdFdhhL(i3,i2,gt3)
coup3R = cplcFdFdhhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
coup3L = cplcFeFehhL(i3,i2,gt3)
coup3R = cplcFeFehhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = cplhhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = cplhhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplhhhhSdcSdaa(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplhhhhSecSe1(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(gt3,i1,i2,gt1)
coup2 = cplhhSdcSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSecSv1(gt3,i1,i2,gt1)
coup2 = cplhhSecSe(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(gt2,i1,i2,gt1)
coup2 = cplhhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSecSv1(gt2,i1,i2,gt1)
coup2 = cplhhSecSe(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTohhhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTohhhh(MFd,MFe,Mhh,MSd,MSe,               & 
& MSv,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,               & 
& cplSdcSdcSv,cplSecSecSv,cplhhhhSdcSdaa,cplhhhhSecSe1,cplhhSdcSdcSvaa,cplhhSecSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MFd2(3),MFe2(3),Mhh2(2),MSd2(6),            & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),        & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),         & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplSdcSdcSv(6,6,3),cplSecSecSv(6,6,3),             & 
& cplhhhhSdcSdaa(2,2,6,6),cplhhhhSecSe1(2,2,6,6),cplhhSdcSdcSvaa(2,6,6,3),               & 
& cplhhSecSecSv1(2,6,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = Mhh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTohhhh


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTohhVP(Mhh,Mhh2,MSv,MSv2,MVP,MVP2,             & 
& Zfhh,ZfSv,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSv(3),MSv2(3),MVP,MVP2

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSv(3,3),ZfVP

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTohhVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTohhVP(MFd,MFe,Mhh,MSd,MSe,MSv,              & 
& MVP,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,MVP2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,            & 
& cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,cplSdcSdVP,cplSdcSdcSv,    & 
& cplSecSeVP,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MVP,MFd2(3),MFe2(3),Mhh2(2),MSd2(6),        & 
& MSe2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),              & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),& 
& cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVP 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
coup3L = -cplcFdFdVPR(i3,i2)
coup3R = -cplcFdFdVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
coup3L = -cplcFeFeVPR(i3,i2)
coup3R = -cplcFeFeVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTohhVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTohhVP(MFd,MFe,Mhh,MSd,MSe,               & 
& MSv,MVP,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,MVP2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,        & 
& cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,cplSdcSdVP,cplSdcSdcSv,    & 
& cplSecSeVP,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MVP,MFd2(3),MFe2(3),Mhh2(2),MSd2(6),        & 
& MSe2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),              & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),& 
& cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTohhVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SvTohhVZ(Mhh,Mhh2,MSv,MSv2,MVZ,MVZ2,             & 
& Zfhh,ZfSv,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSv(3),MSv2(3),MVZ,MVZ2

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSv(3,3),ZfVZ

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvTohhVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTohhVZ(MFd,MFe,Mhh,MSd,MSe,MSv,              & 
& MVZ,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,            & 
& cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,             & 
& cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,cplSdcSdVZ,cplSdcSdcSv,    & 
& cplSecSeVZ,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MVZ,MFd2(3),MFe2(3),Mhh2(2),MSd2(6),        & 
& MSe2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),              & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSecSeVZ(6,6),& 
& cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
coup3L = -cplcFdFdVZR(i3,i2)
coup3R = -cplcFdFdVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
coup3L = -cplcFeFeVZR(i3,i2)
coup3R = -cplcFeFeVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvTohhVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTohhVZ(MFd,MFe,Mhh,MSd,MSe,               & 
& MSv,MVZ,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,        & 
& cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,             & 
& cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplhhSdcSd,cplhhSecSe,cplSdcSdVZ,cplSdcSdcSv,    & 
& cplSecSeVZ,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MVZ,MFd2(3),MFe2(3),Mhh2(2),MSd2(6),        & 
& MSe2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),              & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSecSeVZ(6,6),& 
& cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvTohhVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToHpmcHpm(MHpm,MHpm2,MSv,MSv2,ZfHpm,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToHpmcHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToHpmcHpm(MFd,MFe,MFu,MHpm,MSd,              & 
& MSe,MSu,MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdcSvL,cplcFdFdcSvR,        & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,  & 
& cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),MFe2(3),             & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),    & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),          & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSecHpmcSe1(2,6,2,6),& 
& cplHpmSucSdcSvaa(2,6,6,3),cplHpmSvcSecSv1(2,3,6,3),cplSdcHpmcSucSvaa(6,2,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = cplcFuFdcHpmL(i3,i2,gt3)
coup3R = cplcFuFdcHpmR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,i3,gt2)
coup2R = cplcFeFvHpmR(i1,i3,gt2)
coup3L = cplFvFecHpmL(i3,i2,gt3)
coup3R = cplFvFecHpmR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = cplSdcHpmcSu(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplHpmSvcSe(gt2,i3,i1)
coup3 = cplSecHpmcSv(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplHpmSdcHpmcSdaa(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplHpmSecHpmcSe1(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSucSvaa(i1,gt3,i2,gt1)
coup2 = cplHpmSucSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Su, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
coup1 = cplHpmSucSdcSvaa(gt2,i1,i2,gt1)
coup2 = cplSdcHpmcSu(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sv, Se}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
coup1 = cplHpmSvcSecSv1(gt2,i1,i2,gt1)
coup2 = cplSecHpmcSv(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToHpmcHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToHpmcHpm(MFd,MFe,MFu,MHpm,               & 
& MSd,MSe,MSu,MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdcSvL,cplcFdFdcSvR,    & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,  & 
& cplHpmSucSdcSvaa,cplHpmSvcSecSv1,cplSdcHpmcSucSvaa,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),MFe2(3),             & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),    & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),          & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSecHpmcSe1(2,6,2,6),& 
& cplHpmSucSdcSvaa(2,6,6,3),cplHpmSvcSecSv1(2,3,6,3),cplSdcHpmcSucSvaa(6,2,6,3)

Complex(dp), Intent(out) :: Amp(3,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToHpmcHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToHpmcVWm(MHpm,MHpm2,MSv,MSv2,MVWm,            & 
& MVWm2,ZfHpm,ZfSv,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSv(3,3),ZfVWm

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToHpmcVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToHpmcVWm(MFd,MFe,MFu,MHpm,MSd,              & 
& MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFecSvL,       & 
& cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,          & 
& cplHpmSvcSe,cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),        & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),        & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),           & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSdcSv(6,6,3),cplSdcSucVWm(6,6),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = -cplcFuFdcVWmR(i3,i2)
coup3R = -cplcFuFdcVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,i3,gt2)
coup2R = cplcFeFvHpmR(i1,i3,gt2)
coup3L = -cplFvFecVWmR(i3,i2)
coup3R = -cplFvFecVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = -cplSdcSucVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplHpmSvcSe(gt2,i3,i1)
coup3 = -cplSecSvcVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToHpmcVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToHpmcVWm(MFd,MFe,MFu,MHpm,               & 
& MSd,MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,      & 
& cplcFdFdcSvR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFecSvL,       & 
& cplcFeFecSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,          & 
& cplHpmSvcSe,cplSdcSdcSv,cplSdcSucVWm,cplSecSecSv,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),        & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),        & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),           & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSdcSv(6,6,3),cplSdcSucVWm(6,6),            & 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToHpmcVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSucSu(MSu,MSu2,MSv,MSv2,ZfSu,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MSu2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfSu(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSucSu


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSucSu(MCha,MFd,MFe,MHpm,MSd,               & 
& MSe,MSu,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,         & 
& cplcFdChaSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,            & 
& cplSeSucSd,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplHpmSucSdcSvaa,         & 
& cplHpmSucSecSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,& 
& cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),    & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplHpmSucSd(2,6,6),cplSdcHpmcSu(6,2,6),        & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),             & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSucSdVWm(6,6),             & 
& cplHpmSucSdcSvaa(2,6,6,3),cplHpmSucSecSuaa(2,6,6,6),cplSdSucSdcSuabba(6,6,6,6),        & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdcHpmcSucSvaa(6,2,6,3),cplSeSucSdcSvaa(6,6,6,3),        & 
& cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 


! {Fd, Fd, Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MCha(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
coup3L = cplcChaFdcSuL(i3,i2,gt3)
coup3R = cplcChaFdcSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fd, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
coup3L = cplcFeFdcSuL(i3,i2,gt3)
coup3R = cplcFeFdcSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Hpm}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
coup3 = cplSdcHpmcSu(i2,i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
coup3 = cplSdcSecSu(i2,i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, VWm}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVWm 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
coup3 = -cplSdcSucVWm(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Cha], bar[Fe], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
coup3L = cplcFeFdcSuL(i2,i3,gt3)
coup3R = cplcFeFdcSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], bar[Fe], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFecSvL(i1,i2,gt1)
coup1R = cplcFeFecSvR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
coup3L = cplcFeFdcSuL(i2,i3,gt3)
coup3R = cplcFeFdcSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
coup3 = cplSdcSecSu(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], conj[Se], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1 = cplSecSecSv(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
coup3 = cplSdcSecSu(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = -cplSucSdVWm(gt2,i3)
coup3 = cplSdcSecSu(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSucSdcSuabba(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
coup2 = cplSdSucSdcSuabab(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSucSecSuaa(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSucSecSuaa(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
coup1 = cplSdcHpmcSucSvaa(i1,i2,gt3,gt1)
coup2 = cplHpmSucSd(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, Sd}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
coup1 = cplHpmSucSdcSvaa(i1,gt2,i2,gt1)
coup2 = cplSdcHpmcSu(i2,i1,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
coup1 = cplSeSucSdcSvaa(i1,gt2,i2,gt1)
coup2 = cplSdcSecSu(i2,i1,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSucSu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSucSu(MCha,MFd,MFe,MHpm,MSd,            & 
& MSe,MSu,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,         & 
& cplcFdChaSuR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplHpmSucSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,            & 
& cplSeSucSd,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplHpmSucSdcSvaa,         & 
& cplHpmSucSecSuaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdcHpmcSucSvaa,cplSeSucSdcSvaa,& 
& cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),    & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplHpmSucSd(2,6,6),cplSdcHpmcSu(6,2,6),        & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),             & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSucSdVWm(6,6),             & 
& cplHpmSucSdcSvaa(2,6,6,3),cplHpmSucSecSuaa(2,6,6,6),cplSdSucSdcSuabba(6,6,6,6),        & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdcHpmcSucSvaa(6,2,6,3),cplSeSucSdcSvaa(6,6,6,3),        & 
& cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(3,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSucSu


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvSv(MSv,MSv2,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvSv(MCha,MFd,MFe,MHpm,MSd,MSe,            & 
& MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,         & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplSdSvcSdcSvaa,cplSeSvcHpmcSv1,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),MFd2(3),             & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),        & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),             & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),             & 
& cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcHpmcSv1(6,3,2,3),cplSeSvcSecSv1(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = cplcFdFdSvL(i3,i2,gt3)
coup3R = cplcFdFdSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Fe}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = cplcFeChaSvL(i3,i2,gt3)
coup3R = cplcFeChaSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = cplcFeFeSvL(i3,i2,gt3)
coup3R = cplcFeFeSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdSvcSd(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplHpmSvcSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplSeSvcSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplSvcSeVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {bar[Cha], bar[Fe], bar[Fe]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i3,i1,gt2)
coup2R = cplcFeChaSvR(i3,i1,gt2)
coup3L = cplcFeFeSvL(i2,i3,gt3)
coup3R = cplcFeFeSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = cplSeSvcSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i3)
coup3 = cplSeSvcSe(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSvcSdcSvaa(i1,gt3,i2,gt1)
coup2 = cplSdSvcSd(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSeSvcHpmcSv1(i1,gt3,i2,gt1)
coup2 = cplHpmSvcSe(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(i1,gt3,i2,gt1)
coup2 = cplSeSvcSe(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSvcSdcSvaa(i1,gt2,i2,gt1)
coup2 = cplSdSvcSd(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSeSvcHpmcSv1(i1,gt2,i2,gt1)
coup2 = cplHpmSvcSe(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(i1,gt2,i2,gt1)
coup2 = cplSeSvcSe(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvSv(MCha,MFd,MFe,MHpm,MSd,             & 
& MSe,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplSdSvcSdcSvaa,cplSeSvcHpmcSv1,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),MFd2(3),             & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),        & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),             & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),             & 
& cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcHpmcSv1(6,3,2,3),cplSeSvcSecSv1(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvSv


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvVP(cplSvcSvVZ,ctcplSvcSvVZ,MSv,            & 
& MSv2,MVP,MVP2,MVZ,MVZ2,ZfSv,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplSvcSvVZ(3,3)

Complex(dp), Intent(in) :: ctcplSvcSvVZ(3,3)

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVP,ZfVZVP

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZVP*cplSvcSvVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvVP(MCha,MFd,MFe,MHpm,MSd,MSe,            & 
& MSv,MVP,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVP2,MVWm2,cplcFeChaSvL,             & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,          & 
& cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,         & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVP,cplSdcSdcSv,cplSeSvcSe,cplSecSeVP,     & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,           & 
& cplSecSvcVWmVP1,cplSvcSeVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVP,MVWm,MCha2(2),MFd2(3),         & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVP2,MVWm2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),        & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),           & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),          & 
& cplHpmcVWmVP(2),cplSdSvcSd(6,3,6),cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),& 
& cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),              & 
& cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplSecSvcVWmVP1(6,3),cplSvcSeVPVWm1(3,6)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVP 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = -cplcFdFdVPR(i3,i2)
coup3R = -cplcFdFdVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFecSvL(i2,i1,gt1)
coup1R = cplcChaFecSvR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
coup3L = -cplcChaChaVPR(i3,i2)
coup3R = -cplcChaChaVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = -cplcFeFeVPR(i3,i2)
coup3R = -cplcFeFeVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, VWm, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSecSvcVWm(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {bar[Cha], bar[Fe], bar[Fe]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i3,i1,gt2)
coup2R = cplcFeChaSvR(i3,i1,gt2)
coup3L = cplcFeFeVPL(i2,i3)
coup3R = cplcFeFeVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = cplSecSeVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = cplSvcSeVWm(gt2,i3)
coup3 = cplSecSeVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Se, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
coup1 = -cplSecSvcVWm(i1,gt1)
coup2 = cplSvcSeVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
coup1 = cplSecSvcVWmVP1(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVP(MCha,MFd,MFe,MHpm,MSd,             & 
& MSe,MSv,MVP,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVP2,MVWm2,cplcFeChaSvL,         & 
& cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,          & 
& cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,         & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVP,cplSdcSdcSv,cplSeSvcSe,cplSecSeVP,     & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,           & 
& cplSecSvcVWmVP1,cplSvcSeVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVP,MVWm,MCha2(2),MFd2(3),         & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVP2,MVWm2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),        & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),           & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),          & 
& cplHpmcVWmVP(2),cplSdSvcSd(6,3,6),cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),& 
& cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),              & 
& cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplSecSvcVWmVP1(6,3),cplSvcSeVPVWm1(3,6)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvcSv(MSv,MSv2,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 
! Vanishing 


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToSvcSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvcSv(MCha,MFd,MFe,MHpm,MSd,               & 
& MSe,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplHpmSvcSecSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),MFd2(3),             & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),        & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),             & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),             & 
& cplHpmSvcSecSv1(2,3,6,3),cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcSecSv1(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = cplcFdFdcSvL(i3,i2,gt3)
coup3R = cplcFdFdcSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MCha(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
coup3L = cplcChaFecSvL(i3,i2,gt3)
coup3R = cplcChaFecSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = cplcFeFecSvL(i3,i2,gt3)
coup3R = cplcFeFecSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdcSv(i2,i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Hpm}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MHpm(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplSecHpmcSv(i2,i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplSecSecSv(i2,i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, VWm}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MVWm 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = -cplSecSvcVWm(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Cha], bar[Fe], bar[Fe]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFecSvL(i1,i2,gt1)
coup1R = cplcChaFecSvR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i3,i1,gt2)
coup2R = cplcFeChaSvR(i3,i1,gt2)
coup3L = cplcFeFecSvL(i2,i3,gt3)
coup3R = cplcFeFecSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = cplSecSecSv(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSvcVWm(i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i3)
coup3 = cplSecSecSv(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdSvcSdcSvaa(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MHpm(i2) 
coup1 = cplSecHpmcSv(i1,i2,gt1)
coup2 = cplHpmSvcSecSv1(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSeSvcSecSv1(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, Se}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
coup1 = cplHpmSvcSecSv1(i1,gt2,i2,gt1)
coup2 = cplSecHpmcSv(i2,i1,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSvcSdcSvaa(i1,gt2,i2,gt1)
coup2 = cplSdcSdcSv(i2,i1,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSeSvcSecSv1(i1,gt2,i2,gt1)
coup2 = cplSecSecSv(i2,i1,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToSvcSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvcSv(MCha,MFd,MFe,MHpm,MSd,            & 
& MSe,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcFeChaSvL,cplcFeChaSvR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeSvL,cplcFeFeSvR,             & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplHpmSvcSe,cplSdSvcSd,          & 
& cplSdcSdcSv,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,              & 
& cplHpmSvcSecSv1,cplSdSvcSdcSvaa,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),MFd2(3),             & 
& MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),        & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSdcSv(6,6,3),cplSeSvcSe(6,3,6),             & 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),             & 
& cplHpmSvcSecSv1(2,3,6,3),cplSdSvcSdcSvaa(6,3,6,3),cplSeSvcSecSv1(6,3,6,3)

Complex(dp), Intent(out) :: Amp(3,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToSvcSv


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVGVG(MSv,MSv2,MVG,MVG2,ZfSv,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVG,MVG2

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVG

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVG 
Mex3 = MVG 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 0*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVGVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVGVG(MFd,MSd,MSv,MVG,MFd2,MSd2,            & 
& MSv2,MVG2,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdcSvL,cplcFdFdcSvR,cplSdcSdVG,cplSdcSdcSv,    & 
& cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MSd(6),MSv(3),MVG,MFd2(3),MSd2(6),MSv2(3),MVG2

Complex(dp), Intent(in) :: cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplSdcSdVG(6,6),cplSdcSdcSv(6,6,3),cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),     & 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVG 
Mex3 = MVG 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = -cplcFdFdVGR(i1,i3)
coup2R = -cplcFdFdVGL(i1,i3)
coup3L = -cplcFdFdVGR(i3,i2)
coup3R = -cplcFdFdVGL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = -cplSdcSdVG(i3,i1)
coup3 = -cplSdcSdVG(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
coup2 = cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVGVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVGVG(MFd,MSd,MSv,MVG,MFd2,              & 
& MSd2,MSv2,MVG2,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdcSvL,cplcFdFdcSvR,cplSdcSdVG,           & 
& cplSdcSdcSv,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MSd(6),MSv(3),MVG,MFd2(3),MSd2(6),MSv2(3),MVG2

Complex(dp), Intent(in) :: cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplSdcSdVG(6,6),cplSdcSdcSv(6,6,3),cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),     & 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVG 
Mex3 = MVG 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVGVG


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVPVP(MSv,MSv2,MVP,MVP2,ZfSv,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVP,MVP2

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVP

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVP 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 1*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVPVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVPVP(MFd,MFe,MSd,MSe,MSv,MVP,              & 
& MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdcSv,              & 
& cplSecSeVP,cplSecSecSv,cplSdcSdVPVPaa,cplSecSeVPVP1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MFd2(3),MFe2(3),MSd2(6),MSe2(6),               & 
& MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),cplSecSecSv(6,6,3),cplSdcSdVPVPaa(6,6),& 
& cplSecSeVPVP1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVP 
Mex3 = MVP 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = -cplcFdFdVPR(i1,i3)
coup2R = -cplcFdFdVPL(i1,i3)
coup3L = -cplcFdFdVPR(i3,i2)
coup3R = -cplcFdFdVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = -cplcFeFeVPR(i1,i3)
coup2R = -cplcFeFeVPL(i1,i3)
coup3L = -cplcFeFeVPR(i3,i2)
coup3R = -cplcFeFeVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = -cplSdcSdVP(i3,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = -cplSecSeVP(i3,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdcSdVPVPaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSecSeVPVP1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVPVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVPVP(MFd,MFe,MSd,MSe,MSv,               & 
& MVP,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdcSv,              & 
& cplSecSeVP,cplSecSecSv,cplSdcSdVPVPaa,cplSecSeVPVP1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MFd2(3),MFe2(3),MSd2(6),MSe2(6),               & 
& MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplSdcSdVP(6,6),cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),cplSecSecSv(6,6,3),cplSdcSdVPVPaa(6,6),& 
& cplSecSeVPVP1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVP 
Mex3 = MVP 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVPVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVPVZ(MSv,MSv2,MVP,MVP2,MVZ,MVZ2,             & 
& ZfSv,ZfVP,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVP,ZfVZ

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVP 
Mex3 = MVZ 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 1*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVPVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVPVZ(MFd,MFe,MSd,MSe,MSv,MVP,              & 
& MVZ,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,MVZ2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,            & 
& cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,             & 
& cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,               & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSdcSdVPVZaa,cplSecSeVPVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MVZ,MFd2(3),MFe2(3),MSd2(6),MSe2(6),           & 
& MSv2(3),MVP2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),               & 
& cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSdcSdVPVZaa(6,6),& 
& cplSecSeVPVZ1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVP 
Mex3 = MVZ 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = -cplcFdFdVPR(i1,i3)
coup2R = -cplcFdFdVPL(i1,i3)
coup3L = -cplcFdFdVZR(i3,i2)
coup3R = -cplcFdFdVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = -cplcFeFeVPR(i1,i3)
coup2R = -cplcFeFeVPL(i1,i3)
coup3L = -cplcFeFeVZR(i3,i2)
coup3R = -cplcFeFeVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = -cplSdcSdVP(i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = -cplSecSeVP(i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdcSdVPVZaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSecSeVPVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVPVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVPVZ(MFd,MFe,MSd,MSe,MSv,               & 
& MVP,MVZ,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,MVZ2,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,        & 
& cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,             & 
& cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,               & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSdcSdVPVZaa,cplSecSeVPVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MVZ,MFd2(3),MFe2(3),MSd2(6),MSe2(6),           & 
& MSv2(3),MVP2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),& 
& cplcFdFdcSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),               & 
& cplSdcSdcSv(6,6,3),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSdcSdVPVZaa(6,6),& 
& cplSecSeVPVZ1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVP 
Mex3 = MVZ 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVPVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVWmcVWm(MSv,MSv2,MVWm,MVWm2,ZfSv,            & 
& ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVWm

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVWm 
Mex3 = MVWm 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 1*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVWmcVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVWmcVWm(MFd,MFe,MFu,MSd,MSe,               & 
& MSu,MSv,MVWm,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSdcSucVWm,          & 
& cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),MFu2(3),        & 
& MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),        & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),           & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplSdcSdcSv(6,6,3),cplSdcSucVWm(6,6),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),             & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplSdcSdcVWmVWmaa(6,6),cplSecSecVWmVWm1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVWm 
Mex3 = MVWm 


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,i3)
coup2R = -cplcFdFuVWmL(i1,i3)
coup3L = -cplcFuFdcVWmR(i3,i2)
coup3R = -cplcFuFdcVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = -cplcFeFvVWmR(i1,i3)
coup2R = -cplcFeFvVWmL(i1,i3)
coup3L = -cplFvFecVWmR(i3,i2)
coup3R = -cplFvFecVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = -cplSucSdVWm(i3,i1)
coup3 = -cplSdcSucVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = -cplSvcSeVWm(i3,i1)
coup3 = -cplSecSvcVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdcSdcVWmVWmaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSecSecVWmVWm1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVWmcVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVWmcVWm(MFd,MFe,MFu,MSd,MSe,            & 
& MSu,MSv,MVWm,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFecSvL,cplcFeFecSvR,       & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSdcSucVWm,          & 
& cplSecSecSv,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),MFu2(3),        & 
& MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),        & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),           & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplSdcSdcSv(6,6,3),cplSdcSucVWm(6,6),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),             & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplSdcSdcVWmVWmaa(6,6),cplSecSecVWmVWm1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVWm 
Mex3 = MVWm 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVWmcVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVZVZ(MSv,MSv2,MVZ,MVZ2,ZfSv,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSv(3),MSv2(3),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfSv(3,3),ZfVZ

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVZ 
Mex3 = MVZ 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
! Vanishing 


! External Field 2 
! Vanishing 


! External Field 3 


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 1*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SvToVZVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVZVZ(MFd,MFe,MSd,MSe,MSv,MVZ,              & 
& MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,       & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVZ,cplSdcSdcSv,              & 
& cplSecSeVZ,cplSecSecSv,cplSdcSdVZVZaa,cplSecSeVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVZ,MFd2(3),MFe2(3),MSd2(6),MSe2(6),               & 
& MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSdcSdVZVZaa(6,6),& 
& cplSecSeVZVZ1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVZ 
Mex3 = MVZ 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdcSvL(i2,i1,gt1)
coup1R = cplcFdFdcSvR(i2,i1,gt1)
coup2L = -cplcFdFdVZR(i1,i3)
coup2R = -cplcFdFdVZL(i1,i3)
coup3L = -cplcFdFdVZR(i3,i2)
coup3R = -cplcFdFdVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFecSvL(i2,i1,gt1)
coup1R = cplcFeFecSvR(i2,i1,gt1)
coup2L = -cplcFeFeVZR(i1,i3)
coup2R = -cplcFeFeVZL(i1,i3)
coup3L = -cplcFeFeVZR(i3,i2)
coup3R = -cplcFeFeVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = -cplSdcSdVZ(i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = -cplSecSeVZ(i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdcSdcSv(i1,i2,gt1)
coup2 = cplSdcSdVZVZaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplSecSecSv(i1,i2,gt1)
coup2 = cplSecSeVZVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SvToVZVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVZVZ(MFd,MFe,MSd,MSe,MSv,               & 
& MVZ,MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,   & 
& cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,cplSdcSdVZ,cplSdcSdcSv,              & 
& cplSecSeVZ,cplSecSecSv,cplSdcSdVZVZaa,cplSecSeVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVZ,MFd2(3),MFe2(3),MSd2(6),MSe2(6),               & 
& MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),            & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSdcSdVZVZaa(6,6),& 
& cplSecSeVZVZ1(6,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSv(gt1) 
Mex2 = MVZ 
Mex3 = MVZ 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SvToVZVZ



End Module OneLoopDecay_Sv_MSSMTriLnV
