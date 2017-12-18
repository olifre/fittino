! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:57 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Ah_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_AhTohhAh(cplAhAhhh,MAh,Mhh,MAh2,Mhh2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),Mhh(2),MAh2(2),Mhh2(2)

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MAh(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhAhhh(gt1,gt3,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTohhAh


Subroutine Gamma_Real_MSSMTriLnV_AhTohhAh(MLambda,em,gs,cplAhAhhh,MAh,Mhh,            & 
& GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2)

Real(dp), Intent(in) :: MAh(2),Mhh(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2,2), GammarealGluon(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,2
    Do i3=2,2
Coup = cplAhAhhh(i1,i3,i2)
Mex1 = MAh(i1)
Mex2 = Mhh(i2)
Mex3 = MAh(i3)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTohhAh


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhAh(cplAhAhhh,ctcplAhAhhh,MAh,              & 
& MAh2,Mhh,Mhh2,ZfAh,Zfhh,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),Mhh(2),Mhh2(2)

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2)

Complex(dp), Intent(in) :: ctcplAhAhhh(2,2,2)

Complex(dp), Intent(in) :: ZfAh(2,2),Zfhh(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MAh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhAhhh(gt1,gt3,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhAhhh(i1,gt3,gt2)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt2)*cplAhAhhh(gt1,gt3,i1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt3)*cplAhAhhh(gt1,i1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhAh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,     & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,           & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,             & 
& cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,cplhhHpmcHpm,            & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,      & 
& cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,cplAhhhHpmcHpm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),              & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChahhL(2,2,2),            & 
& cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplcFdFdhhL(3,3,2),       & 
& cplcFdFdhhR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),           & 
& cplcFuFuhhR(3,3,2),cplcgWmgWmhh(2),cplcgWpCgWpChh(2),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),& 
& cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),               & 
& cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplAhAhAhAh1(2,2,2,2),& 
& cplAhAhhhhh1(2,2,2,2),cplAhAhHpmcHpm1(2,2,2,2),cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),& 
& cplAhAhSucSuaa(2,2,6,6),cplAhAhSvcSv1(2,2,3,3),cplAhAhcVWmVWm1(2,2),cplAhAhVZVZ1(2,2), & 
& cplAhhhHpmcHpm1(2,2,2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MAh(gt3) 


! {Ah, hh, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhAhhh(i1,i3,gt2)
coup3 = cplAhAhhh(gt3,i3,i2)
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


! {Ah, hh, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhhhVZ(i1,gt2)
coup3 = cplAhhhVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChahhL(i1,i3,gt2)
coup2R = cplcChaChahhR(i1,i3,gt2)
coup3L = cplcChaChaAhL(i3,i2,gt3)
coup3R = cplcChaChaAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Chi, Chi, Chi}
Do i1=1,4
  Do i2=1,4
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChihhL(i1,i3,gt2)
coup2R = cplChiChihhR(i1,i3,gt2)
coup3L = cplChiChiAhL(i3,i2,gt3)
coup3R = cplChiChiAhR(i3,i2,gt3)
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
coup3L = cplcFdFdAhL(i3,i2,gt3)
coup3R = cplcFdFdAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
coup3L = cplcFeFeAhL(i3,i2,gt3)
coup3R = cplcFeFeAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,i3,gt2)
coup2R = cplcFuFuhhR(i1,i3,gt2)
coup3L = cplcFuFuAhL(i3,i2,gt3)
coup3R = cplcFuFuAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmhh(gt2)
coup3 = cplcgWmgWmAh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpChh(gt2)
coup3 = cplcgWpCgWpCAh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 


! {hh, Ah, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhhhhh(gt2,i1,i3)
coup3 = cplAhAhhh(gt3,i2,i3)
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


! {hh, VZ, hh}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhhhhh(gt2,i1,i3)
coup3 = cplAhhhVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = cplAhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = cplAhcHpmVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplhhcHpmVWm(gt2,i1)
coup3 = cplAhHpmcVWm(gt3,i2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = cplAhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = cplAhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplhhSucSu(gt2,i3,i1)
coup3 = cplAhSucSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = -cplhhHpmcVWm(gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplAhHpmcVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, hh, Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplAhhhVZ(i3,gt2)
coup3 = cplAhAhhh(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, hh, VZ}
  Do i2=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplhhVZVZ(gt2)
coup3 = cplAhhhVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i1,i3)
coup3 = cplAhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = -cplhhHpmcVWm(gt2,i1)
coup3 = cplAhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = -cplhhcHpmVWm(gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplAhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {Ah, hh}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhAhhhhh1(gt3,i1,gt2,i2)
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
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhhhHpmcHpm1(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, Ah}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MAh(i2) 
coup1 = cplAhAhAhAh1(gt1,gt3,i1,i2)
coup2 = cplAhAhhh(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhAhhhhh1(gt1,gt3,i1,i2)
coup2 = cplhhhhhh(gt2,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhAhHpmcHpm1(gt1,gt3,i1,i2)
coup2 = cplhhHpmcHpm(gt2,i2,i1)
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
coup1 = cplAhAhSdcSdaa(gt1,gt3,i1,i2)
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
coup1 = cplAhAhSecSe1(gt1,gt3,i1,i2)
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


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhAhSucSuaa(gt1,gt3,i1,i2)
coup2 = cplhhSucSu(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhAhSvcSv1(gt1,gt3,i1,i2)
coup2 = cplhhSvcSv(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhAhcVWmVWm1(gt1,gt3)
coup2 = cplhhcVWmVWm(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VZ, VZ}
ML1 = MVZ 
ML2 = MVZ 
coup1 = cplAhAhVZVZ1(gt1,gt3)
coup2 = cplhhVZVZ(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 



! {Ah, hh}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
coup1 = cplAhAhhhhh1(gt1,i1,gt2,i2)
coup2 = cplAhAhhh(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhhhHpmcHpm1(gt1,gt2,i1,i2)
coup2 = cplAhHpmcHpm(gt3,i2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,            & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,           & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,cplcgWpCgWpChh,cplhhhhhh,             & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,    & 
& cplhhcVWmVWm,cplhhVZVZ,cplAhAhAhAh1,cplAhAhhhhh1,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,       & 
& cplAhAhSecSe1,cplAhAhSucSuaa,cplAhAhSvcSv1,cplAhAhcVWmVWm1,cplAhAhVZVZ1,               & 
& cplAhhhHpmcHpm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),              & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChahhL(2,2,2),            & 
& cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplcFdFdhhL(3,3,2),       & 
& cplcFdFdhhR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),           & 
& cplcFuFuhhR(3,3,2),cplcgWmgWmhh(2),cplcgWpCgWpChh(2),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),& 
& cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),               & 
& cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplAhAhAhAh1(2,2,2,2),& 
& cplAhAhhhhh1(2,2,2,2),cplAhAhHpmcHpm1(2,2,2,2),cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),& 
& cplAhAhSucSuaa(2,2,6,6),cplAhAhSvcSv1(2,2,3,3),cplAhAhcVWmVWm1(2,2),cplAhAhVZVZ1(2,2), & 
& cplAhhhHpmcHpm1(2,2,2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MAh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhAh


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocChaCha(cplcChaChaAhL,cplcChaChaAhR,         & 
& MAh,MCha,MAh2,MCha2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MAh2(2),MCha2(2)

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2)

Complex(dp) :: Amp(2,2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 
! Tree-Level Vertex 
coupT1L = cplcChaChaAhL(gt2,gt3,gt1)
coupT1R = cplcChaChaAhR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocChaCha


Subroutine Gamma_Real_MSSMTriLnV_AhTocChaCha(MLambda,em,gs,cplcChaChaAhL,             & 
& cplcChaChaAhR,MAh,MCha,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2)

Real(dp), Intent(in) :: MAh(2),MCha(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2,2), GammarealGluon(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,2
    Do i3=1,2
CoupL = cplcChaChaAhL(i2,i3,i1)
CoupR = cplcChaChaAhR(i2,i3,i1)
Mex1 = MAh(i1)
Mex2 = MCha(i2)
Mex3 = MCha(i3)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTocChaCha


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocChaCha(cplcChaChaAhL,cplcChaChaAhR,         & 
& ctcplcChaChaAhL,ctcplcChaChaAhR,MAh,MAh2,MCha,MCha2,ZfAh,ZfLm,ZfLp,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MCha(2),MCha2(2)

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2)

Complex(dp), Intent(in) :: ctcplcChaChaAhL(2,2,2),ctcplcChaChaAhR(2,2,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfLm(2,2),ZfLp(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcChaChaAhL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcChaChaAhR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfAh(i1,gt1)*cplcChaChaAhL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfAh(i1,gt1)*cplcChaChaAhR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLp(i1,gt2)*cplcChaChaAhL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLm(i1,gt2))*cplcChaChaAhR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLm(i1,gt3)*cplcChaChaAhL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLp(i1,gt3))*cplcChaChaAhR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocChaCha


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocChaCha(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,   & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,       & 
& cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,       & 
& cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,cplcChaFecSvR,cplcChaFvSeL,   & 
& cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),       & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),       & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),     & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),   & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),   & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6)

Complex(dp), Intent(out) :: Amp(2,2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 


! {Ah, hh, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MCha(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2L = cplcChaChaAhL(gt2,i3,i1)
coup2R = cplcChaChaAhR(gt2,i3,i1)
coup3L = cplcChaChahhL(i3,gt3,i2)
coup3R = cplcChaChahhR(i3,gt3,i2)
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


! {Chi, Chi, Hpm}
Do i1=1,4
  Do i2=1,4
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MHpm(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(gt2,i1,i3)
coup2R = cplcChaChiHpmR(gt2,i1,i3)
coup3L = cplChiChacHpmL(i2,gt3,i3)
coup3R = cplChiChacHpmR(i2,gt3,i3)
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


! {Chi, Chi, VWm}
Do i1=1,4
  Do i2=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MVWm 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcChaChiVWmL(gt2,i1)
coup2R = cplcChaChiVWmR(gt2,i1)
coup3L = cplChiChacVWmL(i2,gt3)
coup3R = cplChiChacVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3L = cplChaFucSdL(gt3,i2,i3)
coup3R = cplChaFucSdR(gt3,i2,i3)
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


! {hh, Ah, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MCha(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2L = cplcChaChahhL(gt2,i3,i1)
coup2R = cplcChaChahhR(gt2,i3,i1)
coup3L = cplcChaChaAhL(i3,gt3,i2)
coup3R = cplcChaChaAhR(i3,gt3,i2)
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


! {hh, VZ, Cha}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MCha(i3) 
coup1 = cplAhhhVZ(gt1,i1)
coup2L = cplcChaChahhL(gt2,i3,i1)
coup2R = cplcChaChahhR(gt2,i3,i1)
coup3L = cplcChaChaVZL(i3,gt3)
coup3R = cplcChaChaVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Su, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
coup3L = cplcFdChaSuL(i3,gt3,i2)
coup3R = cplcFdChaSuR(i3,gt3,i2)
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


! {VZ, hh, Cha}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MCha(i3) 
coup1 = cplAhhhVZ(gt1,i2)
coup2L = cplcChaChaVZL(gt2,i3)
coup2R = cplcChaChaVZR(gt2,i3)
coup3L = cplcChaChahhL(i3,gt3,i2)
coup3R = cplcChaChahhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MAh(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcChaChaAhL(gt2,i1,i3)
coup2R = cplcChaChaAhR(gt2,i1,i3)
coup3L = cplcChaChaAhL(i2,gt3,i3)
coup3R = cplcChaChaAhR(i2,gt3,i3)
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


! {bar[Cha], bar[Cha], hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = Mhh(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcChaChahhL(gt2,i1,i3)
coup2R = cplcChaChahhR(gt2,i1,i3)
coup3L = cplcChaChahhL(i2,gt3,i3)
coup3R = cplcChaChahhR(i2,gt3,i3)
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


! {bar[Cha], bar[Cha], VP}
Do i1=1,2
  Do i2=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MVP 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3L = cplcChaChaVPL(i2,gt3)
coup3R = cplcChaChaVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Cha], bar[Cha], VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MVZ 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcChaChaVZL(gt2,i1)
coup2R = cplcChaChaVZR(gt2,i1)
coup3L = cplcChaChaVZL(i2,gt3)
coup3R = cplcChaChaVZR(i2,gt3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcChaFdcSuL(gt2,i1,i3)
coup2R = cplcChaFdcSuR(gt2,i1,i3)
coup3L = cplcFdChaSuL(i2,gt3,i3)
coup3R = cplcFdChaSuR(i2,gt3,i3)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
coup2L = cplcChaFecSvL(gt2,i1,i3)
coup2R = cplcChaFecSvR(gt2,i1,i3)
coup3L = cplcFeChaSvL(i2,gt3,i3)
coup3R = cplcFeChaSvR(i2,gt3,i3)
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


! {conj[Hpm], conj[Hpm], Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2L = cplcChaChiHpmL(gt2,i3,i1)
coup2R = cplcChaChiHpmR(gt2,i3,i1)
coup3L = cplChiChacHpmL(i3,gt3,i2)
coup3R = cplChiChacHpmR(i3,gt3,i2)
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


! {conj[Hpm], conj[VWm], Chi}
Do i1=1,2
    Do i3=1,4
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MChi(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2L = cplcChaChiHpmL(gt2,i3,i1)
coup2R = cplcChaChiHpmR(gt2,i3,i1)
coup3L = cplChiChacVWmL(i3,gt3)
coup3R = cplChiChacVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Sd], conj[Sd], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2L = cplcChacFuSdL(gt2,i3,i1)
coup2R = cplcChacFuSdR(gt2,i3,i1)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
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
coup1 = cplAhSecSe(gt1,i2,i1)
coup2L = cplcChaFvSeL(gt2,i3,i1)
coup2R = cplcChaFvSeR(gt2,i3,i1)
coup3L = cplFvChacSeL(i3,gt3,i2)
coup3R = cplFvChacSeR(i3,gt3,i2)
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


! {conj[VWm], conj[Hpm], Chi}
  Do i2=1,2
    Do i3=1,4
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2L = cplcChaChiVWmL(gt2,i3)
coup2R = cplcChaChiVWmR(gt2,i3)
coup3L = cplChiChacHpmL(i3,gt3,i2)
coup3R = cplChiChacHpmR(i3,gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocChaCha


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha(MAh,MCha,MChi,MFd,              & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,           & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,           & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcChaFecSvL,               & 
& cplcChaFecSvR,cplcChaFvSeL,cplcChaFvSeR,cplcChacFuSdL,cplcChacFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),       & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),       & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),     & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),   & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),   & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6)

Complex(dp), Intent(out) :: Amp(2,2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MCha(gt3) 


! {bar[Cha], bar[Cha], VP}
Do i1=1,2
  Do i2=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MVP 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3L = cplcChaChaVPL(i2,gt3)
coup3R = cplcChaChaVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocChaCha


Subroutine Amplitude_Tree_MSSMTriLnV_AhToChiChi(cplChiChiAhL,cplChiChiAhR,            & 
& MAh,MChi,MAh2,MChi2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MChi(4),MAh2(2),MChi2(4)

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2)

Complex(dp) :: Amp(2,2,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,4
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 
! Tree-Level Vertex 
coupT1L = cplChiChiAhL(gt2,gt3,gt1)
coupT1R = cplChiChiAhR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhToChiChi


Subroutine Gamma_Real_MSSMTriLnV_AhToChiChi(MLambda,em,gs,cplChiChiAhL,               & 
& cplChiChiAhR,MAh,MChi,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2)

Real(dp), Intent(in) :: MAh(2),MChi(4)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,4,4), GammarealGluon(2,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,4
    Do i3=1,4
CoupL = cplChiChiAhL(i2,i3,i1)
CoupR = cplChiChiAhR(i2,i3,i1)
Mex1 = MAh(i1)
Mex2 = MChi(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhToChiChi


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToChiChi(cplChiChiAhL,cplChiChiAhR,            & 
& ctcplChiChiAhL,ctcplChiChiAhR,MAh,MAh2,MChi,MChi2,ZfAh,ZfL0,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MChi(4),MChi2(4)

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2)

Complex(dp), Intent(in) :: ctcplChiChiAhL(4,4,2),ctcplChiChiAhR(4,4,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfL0(4,4)

Complex(dp), Intent(out) :: Amp(2,2,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,4
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChiChiAhL(gt2,gt3,gt1) 
ZcoupT1R = ctcplChiChiAhR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfAh(i1,gt1)*cplChiChiAhL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfAh(i1,gt1)*cplChiChiAhR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt2)*cplChiChiAhL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt2))*cplChiChiAhR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt3)*cplChiChiAhL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt3))*cplChiChiAhR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToChiChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToChiChi(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
& MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,          & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),             & 
& MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),       & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),       & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),       & 
& cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),   & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4)

Complex(dp), Intent(out) :: Amp(2,2,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 


! {Ah, hh, Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MChi(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2L = cplChiChiAhL(gt2,i3,i1)
coup2R = cplChiChiAhR(gt2,i3,i1)
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


! {Cha, Cha, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MHpm(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,gt2,i3)
coup2R = cplcChaChiHpmR(i1,gt2,i3)
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


! {Cha, Cha, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MVWm 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = -cplcChaChiVWmR(i1,gt2)
coup2R = -cplcChaChiVWmL(i1,gt2)
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


! {Chi, Chi, Ah}
Do i1=1,4
  Do i2=1,4
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MAh(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChiAhL(gt2,i1,i3)
coup2R = cplChiChiAhR(gt2,i1,i3)
coup3L = cplChiChiAhL(gt3,i2,i3)
coup3R = cplChiChiAhR(gt3,i2,i3)
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


! {Chi, Chi, hh}
Do i1=1,4
  Do i2=1,4
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = Mhh(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChihhL(gt2,i1,i3)
coup2R = cplChiChihhR(gt2,i1,i3)
coup3L = cplChiChihhL(gt3,i2,i3)
coup3R = cplChiChihhR(gt3,i2,i3)
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


! {Chi, Chi, VZ}
Do i1=1,4
  Do i2=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MVZ 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChiVZL(gt2,i1)
coup2R = cplChiChiVZR(gt2,i1)
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


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {Fu, Fu, Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3L = cplChiFucSuL(gt3,i2,i3)
coup3R = cplChiFucSuR(gt3,i2,i3)
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


! {hh, Ah, Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MChi(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2L = cplChiChihhL(gt2,i3,i1)
coup2R = cplChiChihhR(gt2,i3,i1)
coup3L = cplChiChiAhL(gt3,i3,i2)
coup3R = cplChiChiAhR(gt3,i3,i2)
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


! {hh, VZ, Chi}
Do i1=1,2
    Do i3=1,4
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MChi(i3) 
coup1 = cplAhhhVZ(gt1,i1)
coup2L = cplChiChihhL(gt2,i3,i1)
coup2R = cplChiChihhR(gt2,i3,i1)
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


! {Hpm, Hpm, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
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


! {Hpm, VWm, Cha}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MCha(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
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


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {Su, Su, Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2L = cplChiFucSuL(gt2,i3,i1)
coup2R = cplChiFucSuR(gt2,i3,i1)
coup3L = cplcFuChiSuL(i3,gt3,i2)
coup3R = cplcFuChiSuR(i3,gt3,i2)
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


! {VWm, Hpm, Cha}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2L = cplChiChacVWmL(gt2,i3)
coup2R = cplChiChacVWmR(gt2,i3)
coup3L = cplcChaChiHpmL(i3,gt3,i2)
coup3R = cplcChaChiHpmR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, hh, Chi}
  Do i2=1,2
    Do i3=1,4
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MChi(i3) 
coup1 = cplAhhhVZ(gt1,i2)
coup2L = cplChiChiVZL(gt2,i3)
coup2R = cplChiChiVZR(gt2,i3)
coup3L = cplChiChihhL(gt3,i3,i2)
coup3R = cplChiChihhR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MHpm(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplChiChacHpmL(gt2,i1,i3)
coup2R = cplChiChacHpmR(gt2,i1,i3)
coup3L = cplcChaChiHpmL(i2,gt3,i3)
coup3R = cplcChaChiHpmR(i2,gt3,i3)
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


! {bar[Cha], bar[Cha], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MVWm 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplChiChacVWmL(gt2,i1)
coup2R = cplChiChacVWmR(gt2,i1)
coup3L = cplcChaChiVWmL(i2,gt3)
coup3R = cplcChaChiVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fd], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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


! {bar[Fu], bar[Fu], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplChiFucSuL(gt2,i1,i3)
coup2R = cplChiFucSuR(gt2,i1,i3)
coup3L = cplcFuChiSuL(i2,gt3,i3)
coup3R = cplcFuChiSuR(i2,gt3,i3)
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


! {conj[Hpm], conj[Hpm], bar[Cha]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2L = cplcChaChiHpmL(i3,gt2,i1)
coup2R = cplcChaChiHpmR(i3,gt2,i1)
coup3L = cplChiChacHpmL(gt3,i3,i2)
coup3R = cplChiChacHpmR(gt3,i3,i2)
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


! {conj[Hpm], conj[VWm], bar[Cha]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MCha(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2L = cplcChaChiHpmL(i3,gt2,i1)
coup2R = cplcChaChiHpmR(i3,gt2,i1)
coup3L = -cplChiChacVWmR(gt3,i3)
coup3R = -cplChiChacVWmL(gt3,i3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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


! {conj[Su], conj[Su], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFuChiSuL(i3,gt2,i1)
coup2R = cplcFuChiSuR(i3,gt2,i1)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
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


! {conj[VWm], conj[Hpm], bar[Cha]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2L = -cplcChaChiVWmR(i3,gt2)
coup2R = -cplcChaChiVWmL(i3,gt2)
coup3L = cplChiChacHpmL(gt3,i3,i2)
coup3R = cplChiChacHpmR(gt3,i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToChiChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,    & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,              & 
& cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,              & 
& cplChiChihhL,cplChiChihhR,cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,         & 
& cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,     & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),             & 
& MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),       & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),       & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),       & 
& cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),   & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4)

Complex(dp), Intent(out) :: Amp(2,2,4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MChi(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiChi


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocFdFd(cplcFdFdAhL,cplcFdFdAhR,               & 
& MAh,MFd,MAh2,MFd2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MAh2(2),MFd2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2)

Complex(dp) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFdFdAhL(gt2,gt3,gt1)
coupT1R = cplcFdFdAhR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocFdFd


Subroutine Gamma_Real_MSSMTriLnV_AhTocFdFd(MLambda,em,gs,cplcFdFdAhL,cplcFdFdAhR,     & 
& MAh,MFd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2)

Real(dp), Intent(in) :: MAh(2),MFd(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,3,3), GammarealGluon(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFdFdAhL(i2,i3,i1)
CoupR = cplcFdFdAhR(i2,i3,i1)
Mex1 = MAh(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTocFdFd


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocFdFd(cplcFdFdAhL,cplcFdFdAhR,               & 
& ctcplcFdFdAhL,ctcplcFdFdAhR,MAh,MAh2,MFd,MFd2,ZfAh,ZfFDL,ZfFDR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MFd(3),MFd2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFdFdAhL(3,3,2),ctcplcFdFdAhR(3,3,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFDL(3,3),ZfFDR(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFdFdAhL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFdFdAhR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfAh(i1,gt1)*cplcFdFdAhL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfAh(i1,gt1)*cplcFdFdAhR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDR(i1,gt2)*cplcFdFdAhL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDL(i1,gt2))*cplcFdFdAhR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplcFdFdAhL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplcFdFdAhR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocFdFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocFdFd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,         & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),  & 
& cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),        & 
& cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),          & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),           & 
& cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 


! {Ah, hh, Fd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2L = cplcFdFdAhL(gt2,i3,i1)
coup2R = cplcFdFdAhR(gt2,i3,i1)
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


! {Chi, Chi, Sd}
Do i1=1,4
  Do i2=1,4
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcFdChiSdL(gt2,i1,i3)
coup2R = cplcFdChiSdR(gt2,i1,i3)
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


! {hh, Ah, Fd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2L = cplcFdFdhhL(gt2,i3,i1)
coup2R = cplcFdFdhhR(gt2,i3,i1)
coup3L = cplcFdFdAhL(i3,gt3,i2)
coup3R = cplcFdFdAhR(i3,gt3,i2)
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


! {hh, VZ, Fd}
Do i1=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = cplAhhhVZ(gt1,i1)
coup2L = cplcFdFdhhL(gt2,i3,i1)
coup2R = cplcFdFdhhR(gt2,i3,i1)
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


! {VZ, hh, Fd}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhhhVZ(gt1,i2)
coup2L = cplcFdFdVZL(gt2,i3)
coup2R = cplcFdFdVZR(gt2,i3)
coup3L = cplcFdFdhhL(i3,gt3,i2)
coup3R = cplcFdFdhhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], Su}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MSu(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcFdChaSuL(gt2,i1,i3)
coup2R = cplcFdChaSuR(gt2,i1,i3)
coup3L = cplcChaFdcSuL(i2,gt3,i3)
coup3R = cplcChaFdcSuR(i2,gt3,i3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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


! {bar[Fu], bar[Fu], Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(gt2,i1,i3)
coup2R = cplcFdFuHpmR(gt2,i1,i3)
coup3L = cplcFuFdcHpmL(i2,gt3,i3)
coup3R = cplcFuFdcHpmR(i2,gt3,i3)
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


! {bar[Fu], bar[Fu], Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuSeL(gt2,i1,i3)
coup2R = cplcFdFuSeR(gt2,i1,i3)
coup3L = cplcFuFdcSeL(i2,gt3,i3)
coup3R = cplcFuFdcSeR(i2,gt3,i3)
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


! {bar[Fu], bar[Fu], VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MVWm 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuVWmL(gt2,i1)
coup2R = cplcFdFuVWmR(gt2,i1)
coup3L = cplcFuFdcVWmL(i2,gt3)
coup3R = cplcFuFdcVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[Hpm], Fu}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2L = cplcFdFuHpmL(gt2,i3,i1)
coup2R = cplcFdFuHpmR(gt2,i3,i1)
coup3L = cplcFuFdcHpmL(i3,gt3,i2)
coup3R = cplcFuFdcHpmR(i3,gt3,i2)
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


! {conj[Hpm], conj[VWm], Fu}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2L = cplcFdFuHpmL(gt2,i3,i1)
coup2R = cplcFdFuHpmR(gt2,i3,i1)
coup3L = cplcFuFdcVWmL(i3,gt3)
coup3R = cplcFuFdcVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {conj[Sd], conj[Sd], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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


! {conj[Su], conj[Su], Cha}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFdChaSuL(gt2,i3,i1)
coup2R = cplcFdChaSuR(gt2,i3,i1)
coup3L = cplcChaFdcSuL(i3,gt3,i2)
coup3R = cplcChaFdcSuR(i3,gt3,i2)
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


! {conj[Su], conj[Su], Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFdFeSuL(gt2,i3,i1)
coup2R = cplcFdFeSuR(gt2,i3,i1)
coup3L = cplcFeFdcSuL(i3,gt3,i2)
coup3R = cplcFeFdcSuR(i3,gt3,i2)
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


! {conj[VWm], conj[Hpm], Fu}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2L = cplcFdFuVWmL(gt2,i3)
coup2R = cplcFdFuVWmR(gt2,i3)
coup3L = cplcFuFdcHpmL(i3,gt3,i2)
coup3R = cplcFuFdcHpmR(i3,gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocFdFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,         & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,   & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplcFdFeSuL,cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),  & 
& cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),        & 
& cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuHpmL(3,3,2),          & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),           & 
& cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MFd(gt3) 


! {bar[Fd], bar[Fd], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFdFd


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocFeFe(cplcFeFeAhL,cplcFeFeAhR,               & 
& MAh,MFe,MAh2,MFe2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFe(3),MAh2(2),MFe2(3)

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2)

Complex(dp) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFeFeAhL(gt2,gt3,gt1)
coupT1R = cplcFeFeAhR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocFeFe


Subroutine Gamma_Real_MSSMTriLnV_AhTocFeFe(MLambda,em,gs,cplcFeFeAhL,cplcFeFeAhR,     & 
& MAh,MFe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2)

Real(dp), Intent(in) :: MAh(2),MFe(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,3,3), GammarealGluon(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFeFeAhL(i2,i3,i1)
CoupR = cplcFeFeAhR(i2,i3,i1)
Mex1 = MAh(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTocFeFe


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocFeFe(cplcFeFeAhL,cplcFeFeAhR,               & 
& ctcplcFeFeAhL,ctcplcFeFeAhR,MAh,MAh2,MFe,MFe2,ZfAh,ZfFEL,ZfFER,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MFe(3),MFe2(3)

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFeFeAhL(3,3,2),ctcplcFeFeAhR(3,3,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFEL(3,3),ZfFER(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFeFeAhL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFeFeAhR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfAh(i1,gt1)*cplcFeFeAhL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfAh(i1,gt1)*cplcFeFeAhR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFER(i1,gt2)*cplcFeFeAhL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFEL(i1,gt2))*cplcFeFeAhR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt3)*cplcFeFeAhL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt3))*cplcFeFeAhR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocFeFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocFeFe(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),             & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),      & 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 


! {Ah, hh, Fe}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2L = cplcFeFeAhL(gt2,i3,i1)
coup2R = cplcFeFeAhR(gt2,i3,i1)
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


! {Chi, Chi, Se}
Do i1=1,4
  Do i2=1,4
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MSe(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcFeChiSeL(gt2,i1,i3)
coup2R = cplcFeChiSeR(gt2,i1,i3)
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


! {Fu, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3L = cplFeFucSdL(gt3,i2,i3)
coup3R = cplFeFucSdR(gt3,i2,i3)
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


! {hh, Ah, Fe}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MFe(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2L = cplcFeFehhL(gt2,i3,i1)
coup2R = cplcFeFehhR(gt2,i3,i1)
coup3L = cplcFeFeAhL(i3,gt3,i2)
coup3R = cplcFeFeAhR(i3,gt3,i2)
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


! {hh, VZ, Fe}
Do i1=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = cplAhhhVZ(gt1,i1)
coup2L = cplcFeFehhL(gt2,i3,i1)
coup2R = cplcFeFehhR(gt2,i3,i1)
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


! {Su, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
coup3L = cplcFdFeSuL(i3,gt3,i2)
coup3R = cplcFdFeSuR(i3,gt3,i2)
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


! {VZ, hh, Fe}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplAhhhVZ(gt1,i2)
coup2L = cplcFeFeVZL(gt2,i3)
coup2R = cplcFeFeVZR(gt2,i3)
coup3L = cplcFeFehhL(i3,gt3,i2)
coup3R = cplcFeFehhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], Sv}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MSv(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcFeChaSvL(gt2,i1,i3)
coup2R = cplcFeChaSvR(gt2,i1,i3)
coup3L = cplcChaFecSvL(i2,gt3,i3)
coup3R = cplcChaFecSvR(i2,gt3,i3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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


! {conj[Hpm], conj[Hpm], Fv}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = 0. 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2L = cplcFeFvHpmL(gt2,i3,i1)
coup2R = cplcFeFvHpmR(gt2,i3,i1)
coup3L = cplFvFecHpmL(i3,gt3,i2)
coup3R = cplFvFecHpmR(i3,gt3,i2)
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


! {conj[Hpm], conj[VWm], Fv}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = 0. 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2L = cplcFeFvHpmL(gt2,i3,i1)
coup2R = cplcFeFvHpmR(gt2,i3,i1)
coup3L = cplFvFecVWmL(i3,gt3)
coup3R = cplFvFecVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Sd], conj[Sd], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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


! {conj[VWm], conj[Hpm], Fv}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = 0. 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2L = cplcFeFvVWmL(gt2,i3)
coup2R = cplcFeFvVWmR(gt2,i3)
coup3L = cplFvFecHpmL(i3,gt3,i2)
coup3R = cplFvFecHpmR(i3,gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocFeFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,           & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFeFvSeL,cplcFeFvSeR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),             & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFeFvHpmL(3,3,2),      & 
& cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFe(gt3) 


! {bar[Fe], bar[Fe], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFeFe


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocFuFu(cplcFuFuAhL,cplcFuFuAhR,               & 
& MAh,MFu,MAh2,MFu2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFu(3),MAh2(2),MFu2(3)

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

Complex(dp) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFuAhL(gt2,gt3,gt1)
coupT1R = cplcFuFuAhR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocFuFu


Subroutine Gamma_Real_MSSMTriLnV_AhTocFuFu(MLambda,em,gs,cplcFuFuAhL,cplcFuFuAhR,     & 
& MAh,MFu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

Real(dp), Intent(in) :: MAh(2),MFu(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,3,3), GammarealGluon(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFuFuAhL(i2,i3,i1)
CoupR = cplcFuFuAhR(i2,i3,i1)
Mex1 = MAh(i1)
Mex2 = MFu(i2)
Mex3 = MFu(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,4._dp/3._dp,-4._dp/3._dp,4._dp/3._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,0._dp,0._dp,0._dp,4._dp,-4._dp,4._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_AhTocFuFu


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocFuFu(cplcFuFuAhL,cplcFuFuAhR,               & 
& ctcplcFuFuAhL,ctcplcFuFuAhR,MAh,MAh2,MFu,MFu2,ZfAh,ZfFUL,ZfFUR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MFu(3),MFu2(3)

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFuFuAhL(3,3,2),ctcplcFuFuAhR(3,3,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFUL(3,3),ZfFUR(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFuAhL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFuFuAhR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfAh(i1,gt1)*cplcFuFuAhL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfAh(i1,gt1)*cplcFuFuAhR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt2)*cplcFuFuAhL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt2))*cplcFuFuAhR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt3)*cplcFuFuAhL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt3))*cplcFuFuAhR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocFuFu


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocFuFu(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),           & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),             & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3), & 
& cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),& 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 


! {Ah, hh, Fu}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MFu(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2L = cplcFuFuAhL(gt2,i3,i1)
coup2R = cplcFuFuAhR(gt2,i3,i1)
coup3L = cplcFuFuhhL(i3,gt3,i2)
coup3R = cplcFuFuhhR(i3,gt3,i2)
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


! {Cha, Cha, Sd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MSd(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i1,gt2,i3)
coup2R = cplcChacFuSdR(i1,gt2,i3)
coup3L = cplChaFucSdL(i2,gt3,i3)
coup3R = cplChaFucSdR(i2,gt3,i3)
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


! {Chi, Chi, Su}
Do i1=1,4
  Do i2=1,4
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MSu(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcFuChiSuL(gt2,i1,i3)
coup2R = cplcFuChiSuR(gt2,i1,i3)
coup3L = cplChiFucSuL(i2,gt3,i3)
coup3R = cplChiFucSuR(i2,gt3,i3)
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


! {Fe, Fe, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSd(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i1,gt2,i3)
coup2R = cplcFecFuSdR(i1,gt2,i3)
coup3L = cplFeFucSdL(i2,gt3,i3)
coup3R = cplFeFucSdR(i2,gt3,i3)
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


! {hh, Ah, Fu}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MFu(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2L = cplcFuFuhhL(gt2,i3,i1)
coup2R = cplcFuFuhhR(gt2,i3,i1)
coup3L = cplcFuFuAhL(i3,gt3,i2)
coup3R = cplcFuFuAhR(i3,gt3,i2)
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


! {hh, VZ, Fu}
Do i1=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MFu(i3) 
coup1 = cplAhhhVZ(gt1,i1)
coup2L = cplcFuFuhhL(gt2,i3,i1)
coup2R = cplcFuFuhhR(gt2,i3,i1)
coup3L = cplcFuFuVZL(i3,gt3)
coup3R = cplcFuFuVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {Hpm, Hpm, Fd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MFd(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
coup3L = cplcFdFuHpmL(i3,gt3,i2)
coup3R = cplcFdFuHpmR(i3,gt3,i2)
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


! {Hpm, VWm, Fd}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MFd(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
coup3L = cplcFdFuVWmL(i3,gt3)
coup3R = cplcFdFuVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {Se, Se, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
coup3L = cplcFdFuSeL(i3,gt3,i2)
coup3R = cplcFdFuSeR(i3,gt3,i2)
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


! {VWm, Hpm, Fd}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MFd(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
coup3L = cplcFdFuHpmL(i3,gt3,i2)
coup3R = cplcFdFuHpmR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {VZ, hh, Fu}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MFu(i3) 
coup1 = cplAhhhVZ(gt1,i2)
coup2L = cplcFuFuVZL(gt2,i3)
coup2R = cplcFuFuVZR(gt2,i3)
coup3L = cplcFuFuhhL(i3,gt3,i2)
coup3R = cplcFuFuhhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Fd], bar[Fd], conj[Hpm]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcFuFdcHpmL(gt2,i1,i3)
coup2R = cplcFuFdcHpmR(gt2,i1,i3)
coup3L = cplcFdFuHpmL(i2,gt3,i3)
coup3R = cplcFdFuHpmR(i2,gt3,i3)
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


! {bar[Fd], bar[Fd], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSe(i3) 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcFuFdcSeL(gt2,i1,i3)
coup2R = cplcFuFdcSeR(gt2,i1,i3)
coup3L = cplcFdFuSeL(i2,gt3,i3)
coup3R = cplcFdFuSeR(i2,gt3,i3)
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


! {bar[Fd], bar[Fd], conj[VWm]}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MVWm 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcFuFdcVWmL(gt2,i1)
coup2R = cplcFuFdcVWmR(gt2,i1)
coup3L = cplcFdFuVWmL(i2,gt3)
coup3R = cplcFdFuVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {bar[Fu], bar[Fu], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuAhL(gt2,i1,i3)
coup2R = cplcFuFuAhR(gt2,i1,i3)
coup3L = cplcFuFuAhL(i2,gt3,i3)
coup3R = cplcFuFuAhR(i2,gt3,i3)
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


! {bar[Fu], bar[Fu], hh}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuhhL(gt2,i1,i3)
coup2R = cplcFuFuhhR(gt2,i1,i3)
coup3L = cplcFuFuhhL(i2,gt3,i3)
coup3R = cplcFuFuhhR(i2,gt3,i3)
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


! {bar[Fu], bar[Fu], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MVG 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuVGL(gt2,i1)
coup2R = cplcFuFuVGR(gt2,i1)
coup3L = cplcFuFuVGL(i2,gt3)
coup3R = cplcFuFuVGR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {bar[Fu], bar[Fu], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MVP 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuVPL(gt2,i1)
coup2R = cplcFuFuVPR(gt2,i1)
coup3L = cplcFuFuVPL(i2,gt3)
coup3R = cplcFuFuVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {bar[Fu], bar[Fu], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MVZ 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuVZL(gt2,i1)
coup2R = cplcFuFuVZR(gt2,i1)
coup3L = cplcFuFuVZL(i2,gt3)
coup3R = cplcFuFuVZR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], bar[Cha]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MCha(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2L = cplcChacFuSdL(i3,gt2,i1)
coup2R = cplcChacFuSdR(i3,gt2,i1)
coup3L = cplChaFucSdL(i3,gt3,i2)
coup3R = cplChaFucSdR(i3,gt3,i2)
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


! {conj[Sd], conj[Sd], bar[Fe]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2L = cplcFecFuSdL(i3,gt2,i1)
coup2R = cplcFecFuSdR(i3,gt2,i1)
coup3L = cplFeFucSdL(i3,gt3,i2)
coup3R = cplFeFucSdR(i3,gt3,i2)
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


! {conj[Su], conj[Su], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MChi(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFuChiSuL(gt2,i3,i1)
coup2R = cplcFuChiSuR(gt2,i3,i1)
coup3L = cplChiFucSuL(i3,gt3,i2)
coup3R = cplChiFucSuR(i3,gt3,i2)
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


! {conj[Su], conj[Su], Glu}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MGlu 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFuGluSuL(gt2,i1)
coup2R = cplcFuGluSuR(gt2,i1)
coup3L = cplGluFucSuL(gt3,i2)
coup3R = cplGluFucSuR(gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocFuFu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),           & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),             & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3), & 
& cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),& 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFu(gt3) 


! {bar[Fu], bar[Fu], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MVG 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuVGL(gt2,i1)
coup2R = cplcFuFuVGR(gt2,i1)
coup3L = cplcFuFuVGL(i2,gt3)
coup3R = cplcFuFuVGR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {bar[Fu], bar[Fu], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MVP 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFuFuVPL(gt2,i1)
coup2R = cplcFuFuVPR(gt2,i1)
coup3L = cplcFuFuVPL(i2,gt3)
coup3R = cplcFuFuVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocFuFu


Subroutine Amplitude_Tree_MSSMTriLnV_AhTohhVZ(cplAhhhVZ,MAh,Mhh,MVZ,MAh2,             & 
& Mhh2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),Mhh(2),MVZ,MAh2(2),Mhh2(2),MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1 = cplAhhhVZ(gt1,gt2)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTohhVZ


Subroutine Gamma_Real_MSSMTriLnV_AhTohhVZ(MLambda,em,gs,cplAhhhVZ,MAh,Mhh,            & 
& MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhhhVZ(2,2)

Real(dp), Intent(in) :: MAh(2),Mhh(2),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2), GammarealGluon(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,2
Coup = cplAhhhVZ(i1,i2)
Mex1 = MAh(i1)
Mex2 = Mhh(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTohhVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhVZ(cplAhhhVZ,ctcplAhhhVZ,MAh,              & 
& MAh2,Mhh,Mhh2,MVZ,MVZ2,ZfAh,Zfhh,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),Mhh(2),Mhh2(2),MVZ,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2)

Complex(dp), Intent(in) :: ctcplAhhhVZ(2,2)

Complex(dp), Intent(in) :: ZfAh(2,2),Zfhh(2,2),ZfVZ

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhhhVZ(gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhhhVZ(i1,gt2)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt2)*cplAhhhVZ(gt1,i1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplAhhhVZ(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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
& cplhhcHpmVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),             & 
& MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChahhL(2,2,2),            & 
& cplcChaChahhR(2,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChihhL(4,4,2),        & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcFdFdhhL(3,3,2),            & 
& cplcFdFdhhR(3,3,2),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFehhL(3,3,2),               & 
& cplcFeFehhR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuhhL(3,3,2),               & 
& cplcFuFuhhR(3,3,2),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmhh(2),cplcgWmgWmVZ,     & 
& cplcgWpCgWpChh(2),cplcgWpCgWpCVZ,cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),& 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),        & 
& cplSecSeVZ(6,6),cplSucSuVZ(6,6),cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhAhVZVZ1(2,2),        & 
& cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2),cplhhhhVZVZ1(2,2),cplhhHpmcVWmVZ1(2,2),      & 
& cplhhcHpmVWmVZ1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 


! {Ah, hh, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhAhhh(i1,i3,gt2)
coup3 = cplAhhhVZ(i3,i2)
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


! {Ah, hh, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = -cplAhhhVZ(i1,gt2)
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


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChahhL(i1,i3,gt2)
coup2R = cplcChaChahhR(i1,i3,gt2)
coup3L = -cplcChaChaVZR(i3,i2)
coup3R = -cplcChaChaVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Chi, Chi, Chi}
Do i1=1,4
  Do i2=1,4
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChihhL(i1,i3,gt2)
coup2R = cplChiChihhR(i1,i3,gt2)
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


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,i3,gt2)
coup2R = cplcFuFuhhR(i1,i3,gt2)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmhh(gt2)
coup3 = cplcgWmgWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpChh(gt2)
coup3 = cplcgWpCgWpCVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {hh, Ah, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhhhhh(gt2,i1,i3)
coup3 = -cplAhhhVZ(i2,i3)
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


! {hh, VZ, hh}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhhhhh(gt2,i1,i3)
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


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
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


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhcHpmVWm(gt2,i1)
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


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhcHpmVWm(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplhhSucSu(gt2,i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, hh, Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = -cplAhhhVZ(i3,gt2)
coup3 = cplAhhhVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, hh, VZ}
  Do i2=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplhhVZVZ(gt2)
coup3 = cplhhVZVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i1,i3)
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


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplhhHpmcVWm(gt2,i1)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcHpmVWm(gt2,i3)
coup3 = cplHpmcHpmVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {hh, VZ}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
coup1 = cplAhhhVZ(gt1,i1)
coup2 = cplhhhhVZVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplhhcHpmVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplhhHpmcVWmVZ1(gt2,i2)
Call Amp_VERTEX_StoSV_Topology2_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {Ah, VZ}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVZ 
coup1 = cplAhAhVZVZ1(gt1,i1)
coup2 = -cplAhhhVZ(i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplhhcHpmVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWmVZ1(gt1,i2)
coup2 = cplhhHpmcVWm(gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,          & 
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
& cplhhcHpmVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),             & 
& MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChahhL(2,2,2),            & 
& cplcChaChahhR(2,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChihhL(4,4,2),        & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcFdFdhhL(3,3,2),            & 
& cplcFdFdhhR(3,3,2),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFehhL(3,3,2),               & 
& cplcFeFehhR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuhhL(3,3,2),               & 
& cplcFuFuhhR(3,3,2),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmhh(2),cplcgWmgWmVZ,     & 
& cplcgWpCgWpChh(2),cplcgWpCgWpCVZ,cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),& 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),        & 
& cplSecSeVZ(6,6),cplSucSuVZ(6,6),cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhAhVZVZ1(2,2),        & 
& cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2),cplhhhhVZVZ1(2,2),cplhhHpmcVWmVZ1(2,2),      & 
& cplhhcHpmVWmVZ1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVZ


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocHpmHpm(cplAhHpmcHpm,MAh,MHpm,               & 
& MAh2,MHpm2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MHpm(2),MAh2(2),MHpm2(2)

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhHpmcHpm(gt1,gt3,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocHpmHpm


Subroutine Gamma_Real_MSSMTriLnV_AhTocHpmHpm(MLambda,em,gs,cplAhHpmcHpm,              & 
& MAh,MHpm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2)

Real(dp), Intent(in) :: MAh(2),MHpm(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2,2), GammarealGluon(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=2,2
    Do i3=2,2
Coup = cplAhHpmcHpm(i1,i3,i2)
Mex1 = MAh(i1)
Mex2 = MHpm(i2)
Mex3 = MHpm(i3)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTocHpmHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocHpmHpm(cplAhHpmcHpm,ctcplAhHpmcHpm,         & 
& MAh,MAh2,MHpm,MHpm2,ZfAh,ZfHpm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2)

Complex(dp), Intent(in) :: ctcplAhHpmcHpm(2,2,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfHpm(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhHpmcHpm(gt1,gt3,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhHpmcHpm(i1,gt3,gt2)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt2))*cplAhHpmcHpm(gt1,gt3,i1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt3)*cplAhHpmcHpm(gt1,i1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocHpmHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
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
& cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFuFdcHpmL(3,3,2),& 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFdFuHpmL(3,3,2),      & 
& cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgZgWmcHpm(2),          & 
& cplcgZgWpCHpm(2),cplcgWmgZHpm(2),cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),& 
& cplhhcHpmVWm(2,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),             & 
& cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),& 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplAhAhHpmcHpm1(2,2,2,2),cplAhhhHpmcHpm1(2,2,2,2),     & 
& cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),& 
& cplAhSdcHpmcSuaa(2,6,2,6),cplAhSecHpmcSv1(2,6,2,3),cplAhcHpmVPVWm1(2,2),               & 
& cplAhcHpmVWmVZ1(2,2),cplHpmHpmcHpmcHpm1(2,2,2,2),cplHpmSdcHpmcSdaa(2,6,2,6),           & 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSucHpmcSuaa(2,6,2,6)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 


! {Ah, hh, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhHpmcHpm(i1,i3,gt2)
coup3 = cplhhHpmcHpm(i2,gt3,i3)
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


! {Ah, hh, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhcHpmVWm(i1,gt2)
coup3 = -cplhhHpmcVWm(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Chi, Chi, Cha}
Do i1=1,4
  Do i2=1,4
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChacHpmL(i1,i3,gt2)
coup2R = cplChiChacHpmR(i1,i3,gt2)
coup3L = cplcChaChiHpmL(i3,i2,gt3)
coup3R = cplcChaChiHpmR(i3,i2,gt3)
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


! {Fu, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFdcHpmL(i1,i3,gt2)
coup2R = cplcFuFdcHpmR(i1,i3,gt2)
coup3L = cplcFdFuHpmL(i3,i2,gt3)
coup3R = cplcFdFuHpmR(i3,i2,gt3)
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


! {gWmC, gWmC, gZ}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgZcHpm(gt2)
coup3 = cplcgZgWpCHpm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {hh, Ah, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhHpmcHpm(i1,i3,gt2)
coup3 = cplAhHpmcHpm(i2,gt3,i3)
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


! {hh, VZ, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhHpmcHpm(i1,i3,gt2)
coup3 = cplHpmcHpmVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {hh, Ah, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MVWm 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhcHpmVWm(i1,gt2)
coup3 = -cplAhHpmcVWm(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, VZ, VWm}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhcHpmVWm(i1,gt2)
coup3 = cplHpmcVWmVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Su, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
coup3 = cplHpmSucSd(gt3,i2,i3)
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


! {VZ, hh, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplHpmcHpmVZ(i3,gt2)
coup3 = cplhhHpmcHpm(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, hh, VWm}
  Do i2=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplcHpmVWmVZ(gt2)
coup3 = -cplhhHpmcVWm(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {bar[Cha], bar[Cha], Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplChiChacHpmL(i3,i1,gt2)
coup2R = cplChiChacHpmR(i3,i1,gt2)
coup3L = cplcChaChiHpmL(i2,i3,gt3)
coup3R = cplcChaChiHpmR(i2,i3,gt3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcFuFdcHpmL(i3,i1,gt2)
coup2R = cplcFuFdcHpmR(i3,i1,gt2)
coup3L = cplcFdFuHpmL(i2,i3,gt3)
coup3R = cplcFdFuHpmR(i2,i3,gt3)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
coup2L = cplFvFecHpmL(i3,i1,gt2)
coup2R = cplFvFecHpmR(i3,i1,gt2)
coup3L = cplcFeFvHpmL(i2,i3,gt3)
coup3R = cplcFeFvHpmR(i2,i3,gt3)
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


! {bar[gWm], bar[gWm], bar[gZ]}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgZgWmcHpm(gt2)
coup3 = cplcgWmgZHpm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {conj[Hpm], conj[Hpm], Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplAhHpmcHpm(i3,i1,gt2)
coup3 = cplAhHpmcHpm(i3,gt3,i2)
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


! {conj[Hpm], conj[VWm], Ah}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MAh(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplAhHpmcHpm(i3,i1,gt2)
coup3 = -cplAhHpmcVWm(i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplhhHpmcHpm(i3,i1,gt2)
coup3 = cplhhHpmcHpm(i3,gt3,i2)
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


! {conj[Hpm], conj[VWm], hh}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcHpm(i3,i1,gt2)
coup3 = -cplhhHpmcVWm(i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], VP}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplHpmcHpmVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplHpmcVWmVP(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {conj[Hpm], conj[Hpm], VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmcHpmVZ(i1,gt2)
coup3 = cplHpmcHpmVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcHpmVZ(i1,gt2)
coup3 = cplHpmcVWmVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {conj[Sd], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2 = cplSdcHpmcSu(i1,gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
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
coup1 = cplAhSecSe(gt1,i2,i1)
coup2 = cplSecHpmcSv(i1,gt2,i3)
coup3 = cplHpmSvcSe(gt3,i3,i2)
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


! {conj[VWm], conj[Hpm], Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplAhcHpmVWm(i3,gt2)
coup3 = cplAhHpmcHpm(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcHpmVWm(i3,gt2)
coup3 = cplhhHpmcHpm(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], VP}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplHpmcHpmVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {conj[VWm], conj[Hpm], VZ}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplcHpmVWmVZ(gt2)
coup3 = cplHpmcHpmVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {Ah, hh}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhhhHpmcHpm1(i1,i2,gt3,gt2)
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
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmHpmcHpmcHpm1(gt3,i2,gt2,i1)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplHpmSdcHpmcSdaa(gt3,i2,gt2,i1)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplHpmSecHpmcSe1(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplHpmSucHpmcSuaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Ah, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhAhHpmcHpm1(gt1,i1,gt3,i2)
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
coup1 = cplAhhhHpmcHpm1(gt1,i1,gt3,i2)
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
coup1 = cplAhHpmSucSdaa(gt1,gt3,i1,i2)
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
coup1 = cplAhHpmSvcSe1(gt1,gt3,i1,i2)
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
coup1 = cplAhHpmcVWmVP1(gt1,gt3)
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
coup1 = cplAhHpmcVWmVZ1(gt1,gt3)
coup2 = cplcHpmVWmVZ(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhAhHpmcHpm1(gt1,i1,i2,gt2)
coup2 = cplAhHpmcHpm(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhhhHpmcHpm1(gt1,i1,i2,gt2)
coup2 = cplhhHpmcHpm(i1,gt3,i2)
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
coup1 = cplAhSdcHpmcSuaa(gt1,i1,gt2,i2)
coup2 = cplHpmSucSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSecHpmcSv1(gt1,i1,gt2,i2)
coup2 = cplHpmSvcSe(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplAhcHpmVPVWm1(gt1,gt2)
coup2 = cplHpmcVWmVP(gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplAhcHpmVWmVZ1(gt1,gt2)
coup2 = cplHpmcVWmVZ(gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocHpmHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm(MAh,MCha,MChi,MFd,              & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,           & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,             & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcHpmL,             & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,     & 
& cplhhHpmcVWm,cplhhcHpmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,           & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,         & 
& cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhHpmcVWmVP1,        & 
& cplAhHpmcVWmVZ1,cplAhSdcHpmcSuaa,cplAhSecHpmcSv1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,      & 
& cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFuFdcHpmL(3,3,2),& 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFdFuHpmL(3,3,2),      & 
& cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgZgWmcHpm(2),          & 
& cplcgZgWpCHpm(2),cplcgWmgZHpm(2),cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),& 
& cplhhcHpmVWm(2,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),             & 
& cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),& 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplAhAhHpmcHpm1(2,2,2,2),cplAhhhHpmcHpm1(2,2,2,2),     & 
& cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),& 
& cplAhSdcHpmcSuaa(2,6,2,6),cplAhSecHpmcSv1(2,6,2,3),cplAhcHpmVPVWm1(2,2),               & 
& cplAhcHpmVWmVZ1(2,2),cplHpmHpmcHpmcHpm1(2,2,2,2),cplHpmSdcHpmcSdaa(2,6,2,6),           & 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSucHpmcSuaa(2,6,2,6)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MHpm(gt3) 


! {conj[Hpm], conj[Hpm], VP}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplHpmcHpmVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], VP}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplHpmcHpmVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VP, VWm}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVP1(gt1,gt3)
coup2 = cplcHpmVPVWm(gt2)
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplAhcHpmVPVWm1(gt1,gt2)
coup2 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocHpmHpm


Subroutine Amplitude_Tree_MSSMTriLnV_AhToHpmcVWm(cplAhHpmcVWm,MAh,MHpm,               & 
& MVWm,MAh2,MHpm2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MHpm(2),MVWm,MAh2(2),MHpm2(2),MVWm2

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = cplAhHpmcVWm(gt1,gt2)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhToHpmcVWm


Subroutine Gamma_Real_MSSMTriLnV_AhToHpmcVWm(MLambda,em,gs,cplAhHpmcVWm,              & 
& MAh,MHpm,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2)

Real(dp), Intent(in) :: MAh(2),MHpm(2),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2), GammarealGluon(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=2,2
Coup = cplAhHpmcVWm(i1,i2)
Mex1 = MAh(i1)
Mex2 = MHpm(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhToHpmcVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToHpmcVWm(cplAhHpmcVWm,ctcplAhHpmcVWm,         & 
& MAh,MAh2,MHpm,MHpm2,MVWm,MVWm2,ZfAh,ZfHpm,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MHpm(2),MHpm2(2),MVWm,MVWm2

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2)

Complex(dp), Intent(in) :: ctcplAhHpmcVWm(2,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfHpm(2,2),ZfVWm

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhHpmcVWm(gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhHpmcVWm(i1,gt2)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt2)*cplAhHpmcVWm(gt1,i1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplAhHpmcVWm(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToHpmcVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,             & 
& cplChiChacVWmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcgWmgAHpm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,cplcgWpCgZcVWm,    & 
& cplhhHpmcHpm,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,           & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplcVWmVPVWm,         & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplhhHpmcVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacVWmL(4,2),             & 
& cplChiChacVWmR(4,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFuFdcVWmL(3,3),    & 
& cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFuHpmL(3,3,2),            & 
& cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgWmgAHpm(2),           & 
& cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm(2),cplcgWmgZHpm(2),cplcgWpCgZcVWm,           & 
& cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhcVWmVWm(2),cplHpmSucSd(2,6,6),              & 
& cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),& 
& cplSdcSucVWm(6,6),cplSecSvcVWm(6,3),cplcVWmVPVWm,cplcVWmVWmVZ,cplAhAhcVWmVWm1(2,2),    & 
& cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),cplhhHpmcVWmVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 


! {Ah, hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
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


! {Ah, hh, conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = -cplAhHpmcVWm(i1,gt2)
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


! {Cha, Cha, Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,i3,gt2)
coup2R = cplcChaChiHpmR(i1,i3,gt2)
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


! {Chi, Chi, bar[Cha]}
Do i1=1,4
  Do i2=1,4
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(i3,i1,gt2)
coup2R = cplcChaChiHpmR(i3,i1,gt2)
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


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {gWm, gWm, gP}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgAHpm(gt2)
coup3 = cplcgAgWmcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {gWm, gWm, gZ}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgZHpm(gt2)
coup3 = cplcgZgWmcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {hh, Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
coup3 = -cplAhHpmcVWm(i2,i3)
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


! {hh, VZ, conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
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


! {hh, VZ, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = -cplhhHpmcVWm(i1,gt2)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Hpm, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhHpmcHpm(i3,gt2,i1)
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


! {Hpm, Hpm, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, VWm, hh}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, Hpm, VP}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmVP(gt2,i1)
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


! {Hpm, VWm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplHpmcHpmVP(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Hpm, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmVZ(gt2,i1)
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


! {Hpm, VWm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplHpmcHpmVZ(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {VWm, Hpm, Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = -cplAhHpmcVWm(i3,gt2)
coup3 = cplAhHpmcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = -cplhhHpmcVWm(i3,gt2)
coup3 = cplhhHpmcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VP}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VWm, Hpm, VZ}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, hh, conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplHpmcHpmVZ(gt2,i3)
coup3 = -cplhhHpmcVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, hh, conj[VWm]}
  Do i2=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {bar[Fu], bar[Fu], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
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


! {bar[gWmC], bar[gWmC], bar[gZ]}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgZgWpCHpm(gt2)
coup3 = cplcgWpCgZcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Su], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplSdcSucVWm(i3,i2)
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


! {hh, VZ}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
coup1 = cplAhhhVZ(gt1,i1)
coup2 = cplhhHpmcVWmVZ1(i1,gt2)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplHpmcHpmcVWmVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Ah, conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
coup1 = cplAhAhcVWmVWm1(gt1,i1)
coup2 = -cplAhHpmcVWm(i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplHpmcHpmVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Hpm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplHpmcHpmVZ(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToHpmcVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm(MAh,MCha,MChi,MFd,              & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,           & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,             & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplChiChacVWmL,cplChiChacVWmR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuFdcVWmL,             & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,        & 
& cplcFeFvHpmR,cplcgWmgAHpm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm,cplcgWmgZHpm,      & 
& cplcgWpCgZcVWm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmSucSd,cplHpmSvcSe,         & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,         & 
& cplcVWmVPVWm,cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,             & 
& cplhhHpmcVWmVZ1,cplHpmcHpmcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacVWmL(4,2),             & 
& cplChiChacVWmR(4,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFuFdcVWmL(3,3),    & 
& cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFuHpmL(3,3,2),            & 
& cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgWmgAHpm(2),           & 
& cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgZgWpCHpm(2),cplcgWmgZHpm(2),cplcgWpCgZcVWm,           & 
& cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhcVWmVWm(2),cplHpmSucSd(2,6,6),              & 
& cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),& 
& cplSdcSucVWm(6,6),cplSecSvcVWm(6,3),cplcVWmVPVWm,cplcVWmVWmVZ,cplAhAhcVWmVWm1(2,2),    & 
& cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),cplhhHpmcVWmVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVWm 


! {Hpm, Hpm, VP}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmVP(gt2,i1)
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplHpmcHpmVP(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, Hpm, VP}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplHpmcHpmVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcVWm


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocSdSd(cplAhSdcSd,MAh,MSd,MAh2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MSd(6),MAh2(2),MSd2(6)

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhSdcSd(gt1,gt3,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocSdSd


Subroutine Gamma_Real_MSSMTriLnV_AhTocSdSd(MLambda,em,gs,cplAhSdcSd,MAh,              & 
& MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6)

Real(dp), Intent(in) :: MAh(2),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,6,6), GammarealGluon(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,6
    Do i3=1,6
Coup = cplAhSdcSd(i1,i3,i2)
Mex1 = MAh(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTocSdSd


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocSdSd(cplAhSdcSd,ctcplAhSdcSd,               & 
& MAh,MAh2,MSd,MSd2,ZfAh,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6)

Complex(dp), Intent(in) :: ctcplAhSdcSd(2,6,6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhSdcSd(gt1,gt3,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhSdcSd(i1,gt3,gt2)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt2))*cplAhSdcSd(gt1,gt3,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplAhSdcSd(gt1,i1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocSdSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocSdSd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,         & 
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
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),           & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),      & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),             & 
& cplSucSdVWm(6,6),cplAhAhSdcSdaa(2,2,6,6),cplAhHpmSucSdaa(2,2,6,6),cplAhSdSvcSdaa(2,6,3,6),& 
& cplAhSdcHpmcSuaa(2,6,2,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSdcSecSuaa(2,6,6,6),           & 
& cplAhSeSucSdaa(2,6,6,6),cplHpmSdcHpmcSdaa(2,6,2,6),cplSdSdcSdcSdabba(6,6,6,6),         & 
& cplSdSdcSdcSdabab(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),        & 
& cplSdSucSdcSuabab(6,6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 


! {Ah, hh, Sd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhSdcSd(i1,i3,gt2)
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


! {Chi, Chi, Fd}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFdcSdL(i1,i3,gt2)
coup2R = cplChiFdcSdR(i1,i3,gt2)
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


! {hh, Ah, Sd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhSdcSd(i1,i3,gt2)
coup3 = cplAhSdcSd(i2,gt3,i3)
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


! {hh, VZ, Sd}
Do i1=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhSdcSd(i1,i3,gt2)
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


! {VZ, hh, Sd}
  Do i2=1,2
    Do i3=1,6
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplSdcSdVZ(i3,gt2)
coup3 = cplhhSdcSd(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], Fu}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MFu(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplChaFucSdL(i1,i3,gt2)
coup2R = cplChaFucSdR(i1,i3,gt2)
coup3L = cplcChacFuSdL(i2,i3,gt3)
coup3R = cplcChacFuSdR(i2,i3,gt3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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


! {bar[Fu], bar[Fu], Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplChaFucSdL(i3,i1,gt2)
coup2R = cplChaFucSdR(i3,i1,gt2)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
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


! {bar[Fu], bar[Fu], Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplFeFucSdL(i3,i1,gt2)
coup2R = cplFeFucSdR(i3,i1,gt2)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
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


! {conj[Hpm], conj[Hpm], Su}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmSucSd(i1,i3,gt2)
coup3 = cplSdcHpmcSu(gt3,i2,i3)
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


! {conj[Hpm], conj[VWm], Su}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MSu(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmSucSd(i1,i3,gt2)
coup3 = cplSdcSucVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {conj[Sd], conj[Sd], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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


! {conj[Su], conj[Su], Hpm}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplHpmSucSd(i3,i1,gt2)
coup3 = cplSdcHpmcSu(gt3,i3,i2)
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


! {conj[Su], conj[Su], Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSeSucSd(i3,i1,gt2)
coup3 = cplSdcSecSu(gt3,i3,i2)
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


! {conj[Su], conj[Su], VWm}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSdVWm(i1,gt2)
coup3 = cplSdcSucVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[VWm], conj[Hpm], Su}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplSucSdVWm(i3,gt2)
coup3 = cplSdcHpmcSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmSdcHpmcSdaa(i2,gt3,i1,gt2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSdSecSdcSeaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSdSucSdcSuabba(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
coup2 = cplSdSucSdcSuabab(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(9)*AmpC 
  End Do
End Do


! {Ah, Sd}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhAhSdcSdaa(gt1,i1,gt3,i2)
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


! {Sv, Sd}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdSvcSdaa(gt1,gt3,i1,i2)
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
coup1 = cplAhSdcHpmcSuaa(gt1,gt3,i1,i2)
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


! {conj[Sd], Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSdcSdcSvaa(gt1,gt3,i1,i2)
coup2 = cplSdSvcSd(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {conj[Se], Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSdcSecSuaa(gt1,gt3,i1,i2)
coup2 = cplSeSucSd(i1,i2,gt2)
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
coup1 = cplAhAhSdcSdaa(gt1,i1,i2,gt2)
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


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplAhHpmSucSdaa(gt1,i1,i2,gt2)
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


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSdcSdcSvaa(gt1,i1,gt2,i2)
coup2 = cplSdSvcSd(gt3,i2,i1)
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
coup1 = cplAhSdSvcSdaa(gt1,i1,i2,gt2)
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
coup1 = cplAhSeSucSdaa(gt1,i1,i2,gt2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocSdSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,         & 
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
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),           & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),      & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),             & 
& cplSucSdVWm(6,6),cplAhAhSdcSdaa(2,2,6,6),cplAhHpmSucSdaa(2,2,6,6),cplAhSdSvcSdaa(2,6,3,6),& 
& cplAhSdcHpmcSuaa(2,6,2,6),cplAhSdcSdcSvaa(2,6,6,3),cplAhSdcSecSuaa(2,6,6,6),           & 
& cplAhSeSucSdaa(2,6,6,6),cplHpmSdcHpmcSdaa(2,6,2,6),cplSdSdcSdcSdabba(6,6,6,6),         & 
& cplSdSdcSdcSdabab(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),        & 
& cplSdSucSdcSuabab(6,6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MSd(gt3) 


! {conj[Sd], conj[Sd], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSdSd


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocSeSe(cplAhSecSe,MAh,MSe,MAh2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MSe(6),MAh2(2),MSe2(6)

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhSecSe(gt1,gt3,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocSeSe


Subroutine Gamma_Real_MSSMTriLnV_AhTocSeSe(MLambda,em,gs,cplAhSecSe,MAh,              & 
& MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6)

Real(dp), Intent(in) :: MAh(2),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,6,6), GammarealGluon(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,6
    Do i3=1,6
Coup = cplAhSecSe(i1,i3,i2)
Mex1 = MAh(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_AhTocSeSe


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocSeSe(cplAhSecSe,ctcplAhSecSe,               & 
& MAh,MAh2,MSe,MSe2,ZfAh,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6)

Complex(dp), Intent(in) :: ctcplAhSecSe(2,6,6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSe(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhSecSe(gt1,gt3,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhSecSe(i1,gt3,gt2)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt2))*cplAhSecSe(gt1,gt3,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplAhSecSe(gt1,i1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocSeSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocSeSe(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,        & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,        & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,           & 
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),            & 
& cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),             & 
& cplAhAhSecSe1(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhSdcSecSuaa(2,6,6,6),               & 
& cplAhSeSucSdaa(2,6,6,6),cplAhSeSvcSe1(2,6,3,6),cplAhSecHpmcSv1(2,6,2,3),               & 
& cplAhSecSecSv1(2,6,6,3),cplHpmSecHpmcSe1(2,6,2,6),cplSdSecSdcSeaa(6,6,6,6),            & 
& cplSeSecSecSe1(6,6,6,6),cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 


! {Ah, hh, Se}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhSecSe(i1,i3,gt2)
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


! {Chi, Chi, Fe}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFecSeL(i1,i3,gt2)
coup2R = cplChiFecSeR(i1,i3,gt2)
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


! {Fu, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFdcSeL(i1,i3,gt2)
coup2R = cplcFuFdcSeR(i1,i3,gt2)
coup3L = cplcFdFuSeL(i3,i2,gt3)
coup3R = cplcFdFuSeR(i3,i2,gt3)
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


! {hh, Ah, Se}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhSecSe(i1,i3,gt2)
coup3 = cplAhSecSe(i2,gt3,i3)
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


! {hh, VZ, Se}
Do i1=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhSecSe(i1,i3,gt2)
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


! {Su, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSdcSecSu(i3,gt2,i1)
coup3 = cplSeSucSd(gt3,i2,i3)
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


! {VZ, hh, Se}
  Do i2=1,2
    Do i3=1,6
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplSecSeVZ(i3,gt2)
coup3 = cplhhSecSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], Fv}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = 0. 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplFvChacSeL(i3,i1,gt2)
coup2R = cplFvChacSeR(i3,i1,gt2)
coup3L = cplcChaFvSeL(i2,i3,gt3)
coup3R = cplcChaFvSeR(i2,i3,gt3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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


! {conj[Hpm], conj[Hpm], Sv}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MSv(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmSvcSe(i1,i3,gt2)
coup3 = cplSecHpmcSv(gt3,i2,i3)
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


! {conj[Hpm], conj[VWm], Sv}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MSv(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmSvcSe(i1,i3,gt2)
coup3 = cplSecSvcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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


! {conj[VWm], conj[Hpm], Sv}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MSv(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplSvcSeVWm(i3,gt2)
coup3 = cplSecHpmcSv(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmSecHpmcSe1(i2,gt3,i1,gt2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplSdSecSdcSeaa(i2,gt3,i1,gt2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSeSecSecSe1(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSeSucSecSuaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Ah, Se}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhAhSecSe1(gt1,i1,gt3,i2)
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


! {Su, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSeSucSdaa(gt1,gt3,i1,i2)
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
coup1 = cplAhSeSvcSe1(gt1,gt3,i1,i2)
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


! {conj[Hpm], Sv}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSecHpmcSv1(gt1,gt3,i1,i2)
coup2 = cplHpmSvcSe(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {conj[Se], Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSecSecSv1(gt1,gt3,i1,i2)
coup2 = cplSeSvcSe(i1,i2,gt2)
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
coup1 = cplAhAhSecSe1(gt1,i1,i2,gt2)
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


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplAhHpmSvcSe1(gt1,i1,i2,gt2)
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
coup1 = cplAhSdcSecSuaa(gt1,i1,gt2,i2)
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


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSecSecSv1(gt1,i1,gt2,i2)
coup2 = cplSeSvcSe(gt3,i2,i1)
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
coup1 = cplAhSeSvcSe1(gt1,i1,i2,gt2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocSeSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,           & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,        & 
& cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSvcSeVWm,cplAhAhSecSe1,cplAhHpmSvcSe1,        & 
& cplAhSdcSecSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplAhSecSecSv1,           & 
& cplHpmSecHpmcSe1,cplSdSecSdcSeaa,cplSeSecSecSe1,cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),            & 
& cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),             & 
& cplAhAhSecSe1(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhSdcSecSuaa(2,6,6,6),               & 
& cplAhSeSucSdaa(2,6,6,6),cplAhSeSvcSe1(2,6,3,6),cplAhSecHpmcSv1(2,6,2,3),               & 
& cplAhSecSecSv1(2,6,6,3),cplHpmSecHpmcSe1(2,6,2,6),cplSdSecSdcSeaa(6,6,6,6),            & 
& cplSeSecSecSe1(6,6,6,6),cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSe(gt3) 


! {conj[Se], conj[Se], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplAhSecSe(gt1,i2,i1)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSeSe


Subroutine Amplitude_Tree_MSSMTriLnV_AhTocSuSu(cplAhSucSu,MAh,MSu,MAh2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MSu(6),MAh2(2),MSu2(6)

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhSucSu(gt1,gt3,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_AhTocSuSu


Subroutine Gamma_Real_MSSMTriLnV_AhTocSuSu(MLambda,em,gs,cplAhSucSu,MAh,              & 
& MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6)

Real(dp), Intent(in) :: MAh(2),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,6,6), GammarealGluon(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,6
    Do i3=1,6
Coup = cplAhSucSu(i1,i3,i2)
Mex1 = MAh(i1)
Mex2 = MSu(i2)
Mex3 = MSu(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,4._dp/3._dp,-4._dp/3._dp,4._dp/3._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,0._dp,0._dp,0._dp,4._dp,-4._dp,4._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_AhTocSuSu


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocSuSu(cplAhSucSu,ctcplAhSucSu,               & 
& MAh,MAh2,MSu,MSu2,ZfAh,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6)

Complex(dp), Intent(in) :: ctcplAhSucSu(2,6,6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhSucSu(gt1,gt3,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt1)*cplAhSucSu(i1,gt3,gt2)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt2))*cplAhSucSu(gt1,gt3,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt3)*cplAhSucSu(gt1,i1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTocSuSu


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocSuSu(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,   & 
& cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),           & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),     & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),            & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplAhAhSucSuaa(2,2,6,6),& 
& cplAhHpmSucSdaa(2,2,6,6),cplAhSdcHpmcSuaa(2,6,2,6),cplAhSdcSecSuaa(2,6,6,6),           & 
& cplAhSeSucSdaa(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSeSucSecSuaa(6,6,6,6),cplSuSucSucSuabba(6,6,6,6),        & 
& cplSuSucSucSuabab(6,6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 


! {Ah, hh, Su}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MSu(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhSucSu(i1,i3,gt2)
coup3 = cplhhSucSu(i2,gt3,i3)
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


! {Cha, Cha, Fd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaFdcSuL(i1,i3,gt2)
coup2R = cplcChaFdcSuR(i1,i3,gt2)
coup3L = cplcFdChaSuL(i3,i2,gt3)
coup3R = cplcFdChaSuR(i3,i2,gt3)
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


! {Chi, Chi, Fu}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MFu(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFucSuL(i1,i3,gt2)
coup2R = cplChiFucSuR(i1,i3,gt2)
coup3L = cplcFuChiSuL(i3,i2,gt3)
coup3R = cplcFuChiSuR(i3,i2,gt3)
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


! {Fe, Fe, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFeFdcSuL(i1,i3,gt2)
coup2R = cplcFeFdcSuR(i1,i3,gt2)
coup3L = cplcFdFeSuL(i3,i2,gt3)
coup3R = cplcFdFeSuR(i3,i2,gt3)
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


! {hh, Ah, Su}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MSu(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhSucSu(i1,i3,gt2)
coup3 = cplAhSucSu(i2,gt3,i3)
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


! {hh, VZ, Su}
Do i1=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MSu(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhSucSu(i1,i3,gt2)
coup3 = cplSucSuVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {Hpm, Hpm, Sd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MSd(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
coup3 = cplHpmSucSd(i2,gt3,i3)
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


! {Hpm, VWm, Sd}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MSd(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
coup3 = cplSucSdVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {Se, Se, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSdcSecSu(i3,i1,gt2)
coup3 = cplSeSucSd(i2,gt3,i3)
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


! {VWm, Hpm, Sd}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MSd(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplSdcSucVWm(i3,gt2)
coup3 = cplHpmSucSd(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {VZ, hh, Su}
  Do i2=1,2
    Do i3=1,6
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MSu(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = cplSucSuVZ(i3,gt2)
coup3 = cplhhSucSu(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Fd], bar[Fd], bar[Cha]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MCha(i3) 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcChaFdcSuL(i3,i1,gt2)
coup2R = cplcChaFdcSuR(i3,i1,gt2)
coup3L = cplcFdChaSuL(i2,i3,gt3)
coup3R = cplcFdChaSuR(i2,i3,gt3)
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


! {bar[Fd], bar[Fd], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplcFeFdcSuL(i3,i1,gt2)
coup2R = cplcFeFdcSuR(i3,i1,gt2)
coup3L = cplcFdFeSuL(i2,i3,gt3)
coup3R = cplcFdFeSuR(i2,i3,gt3)
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


! {bar[Fu], bar[Fu], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplChiFucSuL(i3,i1,gt2)
coup2R = cplChiFucSuR(i3,i1,gt2)
coup3L = cplcFuChiSuL(i2,i3,gt3)
coup3R = cplcFuChiSuR(i2,i3,gt3)
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


! {bar[Fu], bar[Fu], Glu}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MGlu 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplGluFucSuL(i1,gt2)
coup2R = cplGluFucSuR(i1,gt2)
coup3L = cplcFuGluSuL(i2,gt3)
coup3R = cplcFuGluSuR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Sd], conj[Sd], conj[Hpm]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2 = cplSdcHpmcSu(i1,i3,gt2)
coup3 = cplHpmSucSd(i3,gt3,i2)
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


! {conj[Sd], conj[Sd], conj[Se]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2 = cplSdcSecSu(i1,i3,gt2)
coup3 = cplSeSucSd(i3,gt3,i2)
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


! {conj[Sd], conj[Sd], conj[VWm]}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MVWm 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2 = cplSdcSucVWm(i1,gt2)
coup3 = cplSucSdVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[Su], conj[Su], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MAh(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplAhSucSu(i3,i1,gt2)
coup3 = cplAhSucSu(i3,gt3,i2)
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


! {conj[Su], conj[Su], hh}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplhhSucSu(i3,i1,gt2)
coup3 = cplhhSucSu(i3,gt3,i2)
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


! {conj[Su], conj[Su], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MVG 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSuVG(i1,gt2)
coup3 = cplSucSuVG(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Su], conj[Su], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MVP 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSuVP(i1,gt2)
coup3 = cplSucSuVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {conj[Su], conj[Su], VZ}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MVZ 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSuVZ(i1,gt2)
coup3 = cplSucSuVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmSucHpmcSuaa(i2,gt3,i1,gt2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplSdSucSdcSuabba(i2,gt3,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
coup2 = cplSdSucSdcSuabab(i2,gt3,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(9)*AmpC 
  End Do
End Do


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSeSucSecSuaa(i2,gt3,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSuSucSucSuabba(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
coup2 = cplSuSucSucSuabab(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(9)*AmpC 
  End Do
End Do


! {Ah, Su}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhAhSucSuaa(gt1,i1,gt3,i2)
coup2 = cplAhSucSu(i1,i2,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Hpm, Sd}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
coup1 = cplAhHpmSucSdaa(gt1,i1,gt3,i2)
coup2 = cplSdcHpmcSu(i2,i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Se, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSeSucSdaa(gt1,i1,gt3,i2)
coup2 = cplSdcSecSu(i2,i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Ah, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhAhSucSuaa(gt1,i1,i2,gt2)
coup2 = cplAhSucSu(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sd, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhSdcHpmcSuaa(gt1,i1,i2,gt2)
coup2 = cplHpmSucSd(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

  End Do
End Do


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSdcSecSuaa(gt1,i1,i2,gt2)
coup2 = cplSeSucSd(i2,gt3,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTocSuSu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,               & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcFdChaSuL,cplcFdChaSuR,               & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,   & 
& cplAhHpmSucSdaa,cplAhSdcHpmcSuaa,cplAhSdcSecSuaa,cplAhSeSucSdaa,cplHpmSucHpmcSuaa,     & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),           & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),     & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),            & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplAhAhSucSuaa(2,2,6,6),& 
& cplAhHpmSucSdaa(2,2,6,6),cplAhSdcHpmcSuaa(2,6,2,6),cplAhSdcSecSuaa(2,6,6,6),           & 
& cplAhSeSucSdaa(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSeSucSecSuaa(6,6,6,6),cplSuSucSucSuabba(6,6,6,6),        & 
& cplSuSucSucSuabab(6,6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSu(gt3) 


! {conj[Su], conj[Su], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MVG 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSuVG(i1,gt2)
coup3 = cplSucSuVG(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Su], conj[Su], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MVP 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSuVP(i1,gt2)
coup3 = cplSucSuVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTocSuSu


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhAh(MAh,MAh2,ZfAh,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2)

Complex(dp), Intent(in) :: ZfAh(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhAh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MHpm,MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,            & 
& MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,               & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSucSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MVWm,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),               & 
& MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplAhAhHpmcHpm1(2,2,2,2),cplAhAhSdcSdaa(2,2,6,6),  & 
& cplAhAhSecSe1(2,2,6,6),cplAhAhSucSuaa(2,2,6,6)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MAh(gt3) 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChaAhL(i1,i3,gt2)
coup2R = cplcChaChaAhR(i1,i3,gt2)
coup3L = cplcChaChaAhL(i3,i2,gt3)
coup3R = cplcChaChaAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Chi, Chi, Chi}
Do i1=1,4
  Do i2=1,4
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChiAhL(i1,i3,gt2)
coup2R = cplChiChiAhR(i1,i3,gt2)
coup3L = cplChiChiAhL(i3,i2,gt3)
coup3R = cplChiChiAhR(i3,i2,gt3)
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuAhL(i1,i3,gt2)
coup2R = cplcFuFuAhR(i1,i3,gt2)
coup3L = cplcFuFuAhL(i3,i2,gt3)
coup3R = cplcFuFuAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmAh(gt2)
coup3 = cplcgWmgWmAh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpCAh(gt2)
coup3 = cplcgWpCgWpCAh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = cplAhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = cplAhcHpmVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplAhcHpmVWm(gt2,i1)
coup3 = cplAhHpmcVWm(gt3,i2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = cplAhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplAhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplAhSucSu(gt2,i3,i1)
coup3 = cplAhSucSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = -cplAhHpmcVWm(gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplAhHpmcHpm(gt2,i1,i3)
coup3 = cplAhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = -cplAhHpmcVWm(gt2,i1)
coup3 = cplAhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = -cplAhcHpmVWm(gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhAhHpmcHpm1(gt2,gt3,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplAhAhSecSe1(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplAhAhSucSuaa(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhAhHpmcHpm1(gt1,gt3,i1,i2)
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
coup1 = cplAhAhSdcSdaa(gt1,gt3,i1,i2)
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
coup1 = cplAhAhSecSe1(gt1,gt3,i1,i2)
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
coup1 = cplAhAhSucSuaa(gt1,gt3,i1,i2)
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


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhAhHpmcHpm1(gt1,gt2,i1,i2)
coup2 = cplAhHpmcHpm(gt3,i2,i1)
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
coup1 = cplAhAhSdcSdaa(gt1,gt2,i1,i2)
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
coup1 = cplAhAhSecSe1(gt1,gt2,i1,i2)
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


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhAhSucSuaa(gt1,gt2,i1,i2)
coup2 = cplAhSucSu(gt3,i2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhAh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MHpm,MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,             & 
& MSu2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,          & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplAhAhHpmcHpm1,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhAhSucSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MVWm,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),               & 
& MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplAhAhHpmcHpm1(2,2,2,2),cplAhAhSdcSdaa(2,2,6,6),  & 
& cplAhAhSecSe1(2,2,6,6),cplAhAhSucSuaa(2,2,6,6)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MAh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhAh


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhSv(MAh,MFd,MFe,MSd,MSe,MSv,              & 
& MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,cplSdSvcSd,      & 
& cplSeSvcSe,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdSvcSdaa,cplAhSeSvcSe1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),MSd2(6),            & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),             & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplSdSvcSd(6,3,6),cplSeSvcSe(6,3,6),             & 
& cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),cplAhSdSvcSdaa(2,6,3,6),cplAhSeSvcSe1(2,6,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplAhSdSvcSdaa(gt2,i2,gt3,i1)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplAhSeSvcSe1(gt2,i2,gt3,i1)
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
coup1 = cplAhSdSvcSdaa(gt1,i1,gt3,i2)
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
coup1 = cplAhSeSvcSe1(gt1,i1,gt3,i2)
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
coup1 = cplAhAhSdcSdaa(gt1,gt2,i1,i2)
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


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhAhSecSe1(gt1,gt2,i1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhSv(MAh,MFd,MFe,MSd,MSe,               & 
& MSv,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,     & 
& cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,cplSdSvcSd,      & 
& cplSeSvcSe,cplAhAhSdcSdaa,cplAhAhSecSe1,cplAhSdSvcSdaa,cplAhSeSvcSe1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),MSd2(6),            & 
& MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),             & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplSdSvcSd(6,3,6),cplSeSvcSe(6,3,6),             & 
& cplAhAhSdcSdaa(2,2,6,6),cplAhAhSecSe1(2,2,6,6),cplAhSdSvcSdaa(2,6,3,6),cplAhSeSvcSe1(2,6,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhSv


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhVP(MAh,MAh2,MVP,MVP2,ZfAh,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVP,MVP2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVP

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhVP(MAh,MCha,MFd,MFe,MFu,MHpm,            & 
& MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVP2,              & 
& MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,             & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,           & 
& cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVP,MVWm,            & 
& MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),             & 
& MVP2,MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcgWmgWmVP,      & 
& cplcgWpCgWpCVP,cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSecSeVP(6,6),      & 
& cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplAhHpmcVWmVP1(2,2),cplAhcHpmVPVWm1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVP 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChaAhL(i1,i3,gt2)
coup2R = cplcChaChaAhR(i1,i3,gt2)
coup3L = -cplcChaChaVPR(i3,i2)
coup3R = -cplcChaChaVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuAhL(i1,i3,gt2)
coup2R = cplcFuFuAhR(i1,i3,gt2)
coup3L = -cplcFuFuVPR(i3,i2)
coup3R = -cplcFuFuVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmAh(gt2)
coup3 = cplcgWmgWmVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpCAh(gt2)
coup3 = cplcgWpCgWpCVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
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


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhcHpmVWm(gt2,i1)
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


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplAhcHpmVWm(gt2,i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplAhSucSu(gt2,i3,i1)
coup3 = -cplSucSuVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplAhHpmcHpm(gt2,i1,i3)
coup3 = cplHpmcVWmVP(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplAhHpmcVWm(gt2,i1)
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplAhHpmcVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplAhcHpmVWm(gt2,i3)
coup3 = cplHpmcHpmVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplAhcHpmVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplAhHpmcVWmVP1(gt2,i2)
Call Amp_VERTEX_StoSV_Topology2_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplAhcHpmVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplAhHpmcVWm(gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhVP(MAh,MCha,MFd,MFe,MFu,              & 
& MHpm,MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,              & 
& MVP2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,              & 
& cplcChaChaVPR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,             & 
& cplcFuFuVPR,cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,          & 
& cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVP,MVWm,            & 
& MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),             & 
& MVP2,MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcgWmgWmVP,      & 
& cplcgWpCgWpCVP,cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSecSeVP(6,6),      & 
& cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplAhHpmcVWmVP1(2,2),cplAhcHpmVPVWm1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhVP


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhVZ(MAh,MAh2,MVZ,MVZ2,ZfAh,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVZ

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToAhVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,             & 
& MSu2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,        & 
& cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,              & 
& cplcgWpCgWpCVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,             & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),           & 
& MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),             & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeVZL(3,3),& 
& cplcFeFeVZR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmVZ,cplcgWpCgWpCVZ,        & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSecSeVZ(6,6),cplSucSuVZ(6,6),     & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVZ 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChaAhL(i1,i3,gt2)
coup2R = cplcChaChaAhR(i1,i3,gt2)
coup3L = -cplcChaChaVZR(i3,i2)
coup3R = -cplcChaChaVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Chi, Chi, Chi}
Do i1=1,4
  Do i2=1,4
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChiAhL(i1,i3,gt2)
coup2R = cplChiChiAhR(i1,i3,gt2)
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


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuAhL(i1,i3,gt2)
coup2R = cplcFuFuAhR(i1,i3,gt2)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmAh(gt2)
coup3 = cplcgWmgWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpCAh(gt2)
coup3 = cplcgWpCgWpCVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
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


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplAhcHpmVWm(gt2,i1)
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


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplAhcHpmVWm(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplAhSucSu(gt2,i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplAhHpmcHpm(gt2,i1,i3)
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


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplAhHpmcVWm(gt2,i1)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplAhHpmcVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplAhcHpmVWm(gt2,i3)
coup3 = cplHpmcHpmVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplAhcHpmVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplAhHpmcVWmVZ1(gt2,i2)
Call Amp_VERTEX_StoSV_Topology2_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplAhcHpmVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWmVZ1(gt1,i2)
coup2 = cplAhHpmcVWm(gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToAhVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,              & 
& MSe2,MSu2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,            & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,         & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmVZ,cplcgWpCgWpCVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,           & 
& cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),           & 
& MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),             & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeVZL(3,3),& 
& cplcFeFeVZR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmVZ,cplcgWpCgWpCVZ,        & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSecSeVZ(6,6),cplSucSuVZ(6,6),     & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToAhVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToChacFe(MAh,MAh2,MCha,MCha2,MFe,              & 
& MFe2,ZfAh,ZfFEL,ZfFER,ZfLm,ZfLp,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MFe(3),MFe2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFEL(3,3),ZfFER(3,3),ZfLm(2,2),ZfLp(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToChacFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToChacFe(MAh,MCha,MFd,MFe,MFu,               & 
& MSd,MSe,MSu,MSv,MAh2,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,             & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,           & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplcFeFvSeL,cplcFeFvSeR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MAh2(2),              & 
& MCha2(2),MFd2(3),MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),         & 
& cplFvChacSeR(3,2,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),       & 
& cplcFeChaSvR(3,2,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFeFecSvL(3,3,3),       & 
& cplcFeFecSvR(3,3,3),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFecFuSdL(3,3,6),         & 
& cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 


! {Fd, Fd, Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,gt2,i3)
coup2R = cplcFdChaSuR(i1,gt2,i3)
coup3L = cplcFeFdcSuL(gt3,i2,i3)
coup3R = cplcFeFdcSuR(gt3,i2,i3)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,gt2,i3)
coup2R = cplcFeChaSvR(i1,gt2,i3)
coup3L = cplcFeFecSvL(gt3,i2,i3)
coup3R = cplcFeFecSvR(gt3,i2,i3)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2L = cplChaFucSdL(gt2,i3,i1)
coup2R = cplChaFucSdR(gt2,i3,i1)
coup3L = cplcFecFuSdL(gt3,i3,i2)
coup3R = cplcFecFuSdR(gt3,i3,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2L = cplFvChacSeL(i3,gt2,i1)
coup2R = cplFvChacSeR(i3,gt2,i1)
coup3L = cplcFeFvSeL(gt3,i3,i2)
coup3R = cplcFeFvSeR(gt3,i3,i2)
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


! {bar[Fu], bar[Fu], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplChaFucSdL(gt2,i1,i3)
coup2R = cplChaFucSdR(gt2,i1,i3)
coup3L = cplcFecFuSdL(gt3,i2,i3)
coup3R = cplcFecFuSdR(gt3,i2,i3)
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


! {conj[Su], conj[Su], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFdChaSuL(i3,gt2,i1)
coup2R = cplcFdChaSuR(i3,gt2,i1)
coup3L = cplcFeFdcSuL(gt3,i3,i2)
coup3R = cplcFeFdcSuR(gt3,i3,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToChacFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToChacFe(MAh,MCha,MFd,MFe,MFu,            & 
& MSd,MSe,MSu,MSv,MAh2,MCha2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,             & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,           & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFeFecSvL,         & 
& cplcFeFecSvR,cplcFeFvSeL,cplcFeFvSeR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MAh2(2),              & 
& MCha2(2),MFd2(3),MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),         & 
& cplFvChacSeR(3,2,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),       & 
& cplcFeChaSvR(3,2,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFeFecSvL(3,3,3),       & 
& cplcFeFecSvR(3,3,3),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFecFuSdL(3,3,6),         & 
& cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFe(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToChacFe


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToChiFv(MAh,MAh2,MChi,MChi2,ZfAh,              & 
& ZfFvL,ZfL0,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MChi(4),MChi2(4)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFvL(3,3),ZfL0(4,4)

Complex(dp), Intent(out) :: Amp(2,2,4,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToChiFv


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToChiFv(MAh,MChi,MFd,MFe,MSd,MSe,            & 
& MAh2,MChi2,MFd2,MFe2,MSd2,MSe2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,        & 
& cplAhSdcSd,cplAhSecSe,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,             & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MChi(4),MFd(3),MFe(3),MSd(6),MSe(6),MAh2(2),MChi2(4),MFd2(3),MFe2(3),          & 
& MSd2(6),MSe2(6)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),           & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,4,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
Mex3 = 0. 


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
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


! {Fe, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,gt2,i3)
coup2R = cplcFeChiSeR(i1,gt2,i3)
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


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
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


! {Se, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
coup2L = cplChiFecSeL(gt2,i3,i1)
coup2R = cplChiFecSeR(gt2,i3,i1)
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


! {bar[Fd], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
coup2L = cplChiFdcSdL(gt2,i1,i3)
coup2R = cplChiFdcSdR(gt2,i1,i3)
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


! {bar[Fe], bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
coup2L = cplChiFecSeL(gt2,i1,i3)
coup2R = cplChiFecSeR(gt2,i1,i3)
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


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
coup2L = cplcFdChiSdL(i3,gt2,i1)
coup2R = cplcFdChiSdR(i3,gt2,i1)
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


! {conj[Se], conj[Se], bar[Fe]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSecSe(gt1,i2,i1)
coup2L = cplcFeChiSeL(i3,gt2,i1)
coup2R = cplcFeChiSeR(i3,gt2,i1)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToChiFv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiFv(MAh,MChi,MFd,MFe,MSd,             & 
& MSe,MAh2,MChi2,MFd2,MFe2,MSd2,MSe2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,    & 
& cplAhSdcSd,cplAhSecSe,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,             & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,cplcFeFvSeR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MChi(4),MFd(3),MFe(3),MSd(6),MSe(6),MAh2(2),MChi2(4),MFd2(3),MFe2(3),          & 
& MSd2(6),MSe2(6)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),           & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),           & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,2,4,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MChi(gt2) 
Mex3 = 0. 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToChiFv


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToFvFv(MAh,MAh2,ZfAh,ZfFvL,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFvL(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToFvFv


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToFvFv(MAh,MCha,MChi,MFd,MFe,MHpm,           & 
& MSd,MSe,MSv,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplcChaChaAhL,  & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhcHpmVWm,              & 
& cplFvChacSeL,cplFvChacSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,           & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,               & 
& MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhcHpmVWm(2,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFvSvL(4,3,3),          & 
& cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),         & 
& cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFvHpmL(3,3,2),            & 
& cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),         & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = 0. 
Mex3 = 0. 


! {Cha, Cha, Se}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MSe(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i1,gt2,i3)
coup2R = cplcChaFvSeR(i1,gt2,i3)
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


! {Chi, Chi, Sv}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MSv(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,gt2,i3)
coup2R = cplChiFvSvR(i1,gt2,i3)
coup3L = cplChiFvcSvL(i2,gt3,i3)
coup3R = cplChiFvcSvR(i2,gt3,i3)
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


! {Chi, Chi, conj[Sv]}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MSv(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,gt2,i3)
coup2R = cplChiFvcSvR(i1,gt2,i3)
coup3L = cplChiFvSvL(i2,gt3,i3)
coup3R = cplChiFvSvR(i2,gt3,i3)
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {Fe, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {Hpm, Hpm, Fe}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MFe(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
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


! {Hpm, VWm, Fe}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MFe(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
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


! {Sd, Sd, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {Se, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {VWm, Hpm, Fe}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MFe(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
coup3L = cplcFeFvHpmL(i3,gt3,i2)
coup3R = cplcFeFvHpmR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], conj[Se]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MSe(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i1,i3)
coup2R = cplFvChacSeR(gt2,i1,i3)
coup3L = cplcChaFvSeL(i2,gt3,i3)
coup3R = cplcChaFvSeR(i2,gt3,i3)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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
coup1L = cplcFeFeAhL(i1,i2,gt1)
coup1R = cplcFeFeAhR(i1,i2,gt1)
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


! {conj[Hpm], conj[Hpm], bar[Fe]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MFe(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2L = cplcFeFvHpmL(i3,gt2,i1)
coup2R = cplcFeFvHpmR(i3,gt2,i1)
coup3L = cplFvFecHpmL(gt3,i3,i2)
coup3R = cplFvFecHpmR(gt3,i3,i2)
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


! {conj[Hpm], conj[VWm], bar[Fe]}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MFe(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2L = cplcFeFvHpmL(i3,gt2,i1)
coup2R = cplcFeFvHpmR(i3,gt2,i1)
coup3L = -cplFvFecVWmR(gt3,i3)
coup3R = -cplFvFecVWmL(gt3,i3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Sd], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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
coup1 = cplAhSecSe(gt1,i2,i1)
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


! {conj[VWm], conj[Hpm], bar[Fe]}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MFe(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2L = -cplcFeFvVWmR(i3,gt2)
coup2R = -cplcFeFvVWmL(i3,gt2)
coup3L = cplFvFecHpmL(gt3,i3,i2)
coup3R = cplFvFecHpmR(gt3,i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToFvFv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToFvFv(MAh,MCha,MChi,MFd,MFe,             & 
& MHpm,MSd,MSe,MSv,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSv2,MVWm2,           & 
& cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,               & 
& cplAhcHpmVWm,cplFvChacSeL,cplFvChacSeR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,           & 
& cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,            & 
& cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,           & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,               & 
& MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhcHpmVWm(2,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFvSvL(4,3,3),          & 
& cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),         & 
& cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFvHpmL(3,3,2),            & 
& cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),         & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = 0. 
Mex3 = 0. 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToFvFv


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToGluGlu(MAh,MAh2,MGlu,MGlu2,ZfAh,ZffG,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MGlu,MGlu2

Complex(dp), Intent(in) :: ZfAh(2,2),ZffG

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToGluGlu


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToGluGlu(MAh,MFd,MFu,MGlu,MSd,               & 
& MSu,MAh2,MFd2,MFu2,MGlu2,MSd2,MSu2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,    & 
& cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MAh2(2),MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),               & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),               & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MGlu 
Mex3 = MGlu 


! {Fd, Fd, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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


! {Fu, Fu, Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3L = cplGluFucSuL(i2,i3)
coup3R = cplGluFucSuR(i2,i3)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Su, Su, Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuGluSuL(i3,i2)
coup3R = cplcFuGluSuR(i3,i2)
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
coup1L = cplcFdFdAhL(i1,i2,gt1)
coup1R = cplcFdFdAhR(i1,i2,gt1)
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


! {bar[Fu], bar[Fu], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplGluFucSuL(i1,i3)
coup2R = cplGluFucSuR(i1,i3)
coup3L = cplcFuGluSuL(i2,i3)
coup3R = cplcFuGluSuR(i2,i3)
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
coup1 = cplAhSdcSd(gt1,i2,i1)
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


! {conj[Su], conj[Su], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2L = cplcFuGluSuL(i3,i1)
coup2R = cplcFuGluSuR(i3,i1)
coup3L = cplGluFucSuL(i3,i2)
coup3R = cplGluFucSuR(i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToGluGlu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToGluGlu(MAh,MFd,MFu,MGlu,MSd,            & 
& MSu,MAh2,MFd2,MFu2,MGlu2,MSd2,MSu2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,    & 
& cplAhSdcSd,cplAhSucSu,cplGluFdcSdL,cplGluFdcSdR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MAh2(2),MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),               & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),               & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MGlu 
Mex3 = MGlu 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToGluGlu


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhhh(MAh,MAh2,Mhh,Mhh2,ZfAh,Zfhh,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),Mhh(2),Mhh2(2)

Complex(dp), Intent(in) :: ZfAh(2,2),Zfhh(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhhh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,             & 
& MSe2,MSu2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcFdFdhhL,        & 
& cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcgWmgWmhh,              & 
& cplcgWpCgWpChh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,              & 
& cplhhhhSecSe1,cplhhhhSucSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MVWm,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),        & 
& MSd2(6),MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),         & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcgWmgWmhh(2),cplcgWpCgWpChh(2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),               & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplAhhhHpmcHpm1(2,2,2,2),cplhhhhHpmcHpm1(2,2,2,2),cplhhhhSdcSdaa(2,2,6,6),& 
& cplhhhhSecSe1(2,2,6,6),cplhhhhSucSuaa(2,2,6,6)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = Mhh(gt3) 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChahhL(i1,i3,gt2)
coup2R = cplcChaChahhR(i1,i3,gt2)
coup3L = cplcChaChahhL(i3,i2,gt3)
coup3R = cplcChaChahhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Chi, Chi, Chi}
Do i1=1,4
  Do i2=1,4
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiChihhL(i1,i3,gt2)
coup2R = cplChiChihhR(i1,i3,gt2)
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


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,i3,gt2)
coup2R = cplcFuFuhhR(i1,i3,gt2)
coup3L = cplcFuFuhhL(i3,i2,gt3)
coup3R = cplcFuFuhhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmhh(gt2)
coup3 = cplcgWmgWmhh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpChh(gt2)
coup3 = cplcgWpCgWpChh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = cplhhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
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


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplhhcHpmVWm(gt2,i1)
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


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = -cplhhcHpmVWm(gt2,i1)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = cplhhSdcSd(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = cplhhSecSe(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplhhSucSu(gt2,i3,i1)
coup3 = cplhhSucSu(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = -cplhhHpmcVWm(gt2,i3)
coup3 = cplhhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplhhHpmcVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i1,i3)
coup3 = cplhhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = -cplhhHpmcVWm(gt2,i1)
coup3 = cplhhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = -cplhhHpmcVWm(gt2,i1)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = -cplhhcHpmVWm(gt2,i3)
coup3 = cplhhHpmcHpm(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplhhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhhhHpmcHpm1(gt2,gt3,i2,i1)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhhhSecSe1(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplhhhhSucSuaa(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhhhHpmcHpm1(gt1,gt3,i1,i2)
coup2 = cplhhHpmcHpm(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhhhHpmcHpm1(gt1,gt2,i1,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhhh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MVWm,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,MHpm2,              & 
& MSd2,MSe2,MSu2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,            & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcgWmgWmhh,cplcgWpCgWpChh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,           & 
& cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,cplhhhhSdcSdaa,   & 
& cplhhhhSecSe1,cplhhhhSucSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MVWm,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),        & 
& MSd2(6),MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),         & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcgWmgWmhh(2),cplcgWpCgWpChh(2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),               & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplAhhhHpmcHpm1(2,2,2,2),cplhhhhHpmcHpm1(2,2,2,2),cplhhhhSdcSdaa(2,2,6,6),& 
& cplhhhhSecSe1(2,2,6,6),cplhhhhSucSuaa(2,2,6,6)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = Mhh(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhhh


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhSv(MAh,MAh2,Mhh,Mhh2,MSv,MSv2,             & 
& ZfAh,Zfhh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),Mhh(2),Mhh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),Zfhh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhSv(MAh,MFd,MFe,Mhh,MSd,MSe,              & 
& MSv,MAh2,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,     & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,      & 
& cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,cplhhSdSvcSdaa,cplhhSeSvcSe1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),             & 
& Mhh2(2),MSd2(6),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),             & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),             & 
& cplSdSvcSd(6,3,6),cplSeSvcSe(6,3,6),cplAhSdSvcSdaa(2,6,3,6),cplAhSeSvcSe1(2,6,3,6),    & 
& cplhhSdSvcSdaa(2,6,3,6),cplhhSeSvcSe1(2,6,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
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


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
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


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplhhSdSvcSdaa(gt2,i2,gt3,i1)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhSeSvcSe1(gt2,i2,gt3,i1)
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
coup1 = cplAhSdSvcSdaa(gt1,i1,gt3,i2)
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
coup1 = cplAhSeSvcSe1(gt1,i1,gt3,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhSv(MAh,MFd,MFe,Mhh,MSd,               & 
& MSe,MSv,MAh2,MFd2,MFe2,Mhh2,MSd2,MSe2,MSv2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,        & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,     & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,cplhhSdcSd,cplhhSecSe,cplSdSvcSd,      & 
& cplSeSvcSe,cplAhSdSvcSdaa,cplAhSeSvcSe1,cplhhSdSvcSdaa,cplhhSeSvcSe1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),Mhh(2),MSd(6),MSe(6),MSv(3),MAh2(2),MFd2(3),MFe2(3),             & 
& Mhh2(2),MSd2(6),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),             & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),             & 
& cplSdSvcSd(6,3,6),cplSeSvcSe(6,3,6),cplAhSdSvcSdaa(2,6,3,6),cplAhSeSvcSe1(2,6,3,6),    & 
& cplhhSdSvcSdaa(2,6,3,6),cplhhSeSvcSe1(2,6,3,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhSv


Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhVP(cplAhhhVZ,ctcplAhhhVZ,MAh,              & 
& MAh2,Mhh,Mhh2,MVP,MVP2,MVZ,MVZ2,ZfAh,Zfhh,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),Mhh(2),Mhh2(2),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2)

Complex(dp), Intent(in) :: ctcplAhhhVZ(2,2)

Complex(dp), Intent(in) :: ZfAh(2,2),Zfhh(2,2),ZfVP,ZfVZVP

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MAh(gt1) 
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
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZVP*cplAhhhVZ(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhTohhVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhVP(MAh,MCha,MFd,MFe,MFu,Mhh,             & 
& MHpm,MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,              & 
& MSu2,MVP2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChahhL,              & 
& cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVPL,         & 
& cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuhhL,               & 
& cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,cplcgWpCgWpChh,          & 
& cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,             & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,             & 
& cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,  & 
& cplhhcHpmVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),              & 
& MVP,MVWm,MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),            & 
& MSe2(6),MSu2(6),MVP2,MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),       & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),               & 
& cplcgWmgWmhh(2),cplcgWmgWmVP,cplcgWpCgWpChh(2),cplcgWpCgWpCVP,cplhhHpmcHpm(2,2,2),     & 
& cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),   & 
& cplSecSeVP(6,6),cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplAhHpmcVWmVP1(2,2),     & 
& cplAhcHpmVPVWm1(2,2),cplhhHpmcVWmVP1(2,2),cplhhcHpmVPVWm1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVP 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = cplcChaChahhL(i1,i3,gt2)
coup2R = cplcChaChahhR(i1,i3,gt2)
coup3L = -cplcChaChaVPR(i3,i2)
coup3R = -cplcChaChaVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,i3,gt2)
coup2R = cplcFuFuhhR(i1,i3,gt2)
coup3L = -cplcFuFuVPR(i3,i2)
coup3R = -cplcFuFuVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmhh(gt2)
coup3 = cplcgWmgWmVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpChh(gt2)
coup3 = cplcgWpCgWpCVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
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


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplhhcHpmVWm(gt2,i1)
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


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i1)
coup2 = cplhhcHpmVWm(gt2,i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplhhSucSu(gt2,i3,i1)
coup3 = -cplSucSuVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcHpm(gt2,i1,i3)
coup3 = cplHpmcVWmVP(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplhhHpmcVWm(gt2,i1)
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplhhHpmcVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcHpmVWm(gt2,i3)
coup3 = cplHpmcHpmVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplhhcHpmVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplhhHpmcVWmVP1(gt2,i2)
Call Amp_VERTEX_StoSV_Topology2_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplhhcHpmVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplhhHpmcVWm(gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhTohhVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVP(MAh,MCha,MFd,MFe,MFu,              & 
& Mhh,MHpm,MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,               & 
& MSe2,MSu2,MVP2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,           & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplcChaChahhL,cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVPL,cplcFuFuVPR,cplcgWmgWmhh,cplcgWmgWmVP,             & 
& cplcgWpCgWpChh,cplcgWpCgWpCVP,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,         & 
& cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,             & 
& cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,       & 
& cplhhHpmcVWmVP1,cplhhcHpmVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),              & 
& MVP,MVWm,MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),            & 
& MSe2(6),MSu2(6),MVP2,MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),       & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),               & 
& cplcgWmgWmhh(2),cplcgWmgWmVP,cplcgWpCgWpChh(2),cplcgWpCgWpCVP,cplhhHpmcHpm(2,2,2),     & 
& cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),   & 
& cplSecSeVP(6,6),cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplAhHpmcVWmVP1(2,2),     & 
& cplAhcHpmVPVWm1(2,2),cplhhHpmcVWmVP1(2,2),cplhhcHpmVPVWm1(2,2)

Complex(dp), Intent(out) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhTohhVP


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToHpmcSe(MAh,MAh2,MHpm,MHpm2,MSe,              & 
& MSe2,ZfAh,ZfHpm,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MHpm(2),MHpm2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfHpm(2,2),ZfSe(6,6)

Complex(dp), Intent(out) :: Amp(2,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToHpmcSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToHpmcSe(MAh,MFd,MFe,MFu,MHpm,               & 
& MSd,MSe,MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,             & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuHpmL,             & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,            & 
& cplSecSecSv,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,cplAhSecSecSv1,             & 
& cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MAh2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),          & 
& cplFvFecSeR(3,3,6),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),        & 
& cplcFeFvHpmR(3,3,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),          & 
& cplSecSecSv(6,6,3),cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhSdcSecSuaa(2,6,6,6),& 
& cplAhSecSecSv1(2,6,6,3),cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSecSecSe1(2,6,6,6),            & 
& cplHpmSucSecSuaa(2,6,6,6)

Complex(dp), Intent(out) :: Amp(2,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = cplcFuFdcSeL(i3,i2,gt3)
coup3R = cplcFuFdcSeR(i3,i2,gt3)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,i3,gt2)
coup2R = cplcFeFvHpmR(i1,i3,gt2)
coup3L = cplFvFecSeL(i3,i2,gt3)
coup3R = cplFvFecSeR(i3,i2,gt3)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = cplSdcSecSu(i2,gt3,i3)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplHpmSvcSe(gt2,i3,i1)
coup3 = cplSecSecSv(i2,gt3,i3)
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


! {bar[Fu], bar[Fu], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
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


! {conj[Su], conj[Su], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplSdcSecSu(i3,gt3,i2)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplHpmSdcSdcSeaa(gt2,i2,i1,gt3)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplHpmSecSecSe1(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplHpmSucSecSuaa(gt2,i2,gt3,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSdcSecSuaa(gt1,i1,gt3,i2)
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


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSecSecSv1(gt1,i1,gt3,i2)
coup2 = cplHpmSvcSe(gt2,i2,i1)
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
coup1 = cplAhHpmSucSdaa(gt1,gt2,i1,i2)
coup2 = cplSdcSecSu(i2,gt3,i1)
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
coup1 = cplAhHpmSvcSe1(gt1,gt2,i1,i2)
coup2 = cplSecSecSv(i2,gt3,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToHpmcSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcSe(MAh,MFd,MFe,MFu,MHpm,            & 
& MSd,MSe,MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,             & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuHpmL,             & 
& cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,            & 
& cplSecSecSv,cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,cplAhSecSecSv1,             & 
& cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MAh2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),          & 
& cplFvFecSeR(3,3,6),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),        & 
& cplcFeFvHpmR(3,3,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),          & 
& cplSecSecSv(6,6,3),cplAhHpmSucSdaa(2,2,6,6),cplAhHpmSvcSe1(2,2,3,6),cplAhSdcSecSuaa(2,6,6,6),& 
& cplAhSecSecSv1(2,6,6,3),cplHpmSdcSdcSeaa(2,6,6,6),cplHpmSecSecSe1(2,6,6,6),            & 
& cplHpmSucSecSuaa(2,6,6,6)

Complex(dp), Intent(out) :: Amp(2,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSe(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToHpmcSe


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSecVWm(MAh,MAh2,MSe,MSe2,MVWm,               & 
& MVWm2,ZfAh,ZfSe,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSe(6),MSe2(6),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSe(6,6),ZfVWm

Complex(dp), Intent(out) :: Amp(2,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,6
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSecVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSecVWm(MAh,MFd,MFe,MFu,MSd,MSe,            & 
& MSu,MSv,MVWm,MAh2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdAhL,cplcFdFdAhR,    & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MAh2(2),MFd2(3),         & 
& MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),             & 
& cplFvFecVWmR(3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvSeL(3,3,6),            & 
& cplcFeFvSeR(3,3,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),              & 
& cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVWm 


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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


! {Fe, Fe, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Se, Se, Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {bar[Fu], bar[Fu], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuSeL(i3,i1,gt2)
coup2R = cplcFdFuSeR(i3,i1,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
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


! {conj[Su], conj[Su], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSeSucSd(gt2,i1,i3)
coup3 = cplSdcSucVWm(i3,i2)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSecVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSecVWm(MAh,MFd,MFe,MFu,MSd,             & 
& MSe,MSu,MSv,MVWm,MAh2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuSeL,          & 
& cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSecSvcVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MAh2(2),MFd2(3),         & 
& MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),             & 
& cplFvFecVWmR(3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvSeL(3,3,6),            & 
& cplcFeFvSeR(3,3,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),              & 
& cplSecSvcVWm(6,3)

Complex(dp), Intent(out) :: Amp(2,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSecVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvSv(MAh,MChi,MFd,MFe,MSd,MSe,             & 
& MSv,MAh2,MChi2,MFd2,MFe2,MSd2,MSe2,MSv2,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,         & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplChiFvSvL,cplChiFvSvR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,  & 
& cplAhSeSvcSe1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MChi(4),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MAh2(2),MChi2(4),MFd2(3),           & 
& MFe2(3),MSd2(6),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),        & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplSdSvcSd(6,3,6),cplSeSvcSe(6,3,6),             & 
& cplAhSdSvcSdaa(2,6,3,6),cplAhSeSvcSe1(2,6,3,6)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 


! {Chi, Chi, Fv}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = 0. 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
coup3L = cplChiFvSvL(i2,i3,gt3)
coup3R = cplChiFvSvR(i2,i3,gt3)
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdSvcSdaa(gt1,i1,gt3,i2)
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


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSeSvcSe1(gt1,i1,gt3,i2)
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
coup1 = cplAhSdSvcSdaa(gt1,i1,gt2,i2)
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


! {Se, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSeSvcSe1(gt1,i1,gt2,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvSv(MAh,MChi,MFd,MFe,MSd,              & 
& MSe,MSv,MAh2,MChi2,MFd2,MFe2,MSd2,MSe2,MSv2,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplChiFvSvL,cplChiFvSvR,     & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFeFeSvL,cplcFeFeSvR,cplSdSvcSd,cplSeSvcSe,cplAhSdSvcSdaa,  & 
& cplAhSeSvcSe1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MChi(4),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MAh2(2),MChi2(4),MFd2(3),           & 
& MFe2(3),MSd2(6),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),        & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplSdSvcSd(6,3,6),cplSeSvcSe(6,3,6),             & 
& cplAhSdSvcSdaa(2,6,3,6),cplAhSeSvcSe1(2,6,3,6)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvSv


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvVP(MAh,MAh2,MSv,MSv2,MVP,MVP2,             & 
& ZfAh,ZfSv,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3),MVP,MVP2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3),ZfVP

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
! External masses 
Mex1 = MAh(gt1) 
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


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvVP(MAh,MFd,MFe,MSd,MSe,MSv,              & 
& MVP,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,     & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplSdSvcSd,cplSdcSdVP,cplSeSvcSe,      & 
& cplSecSeVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),             & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),               & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplSdSvcSd(6,3,6),cplSdcSdVP(6,6),cplSeSvcSe(6,3,6), & 
& cplSecSeVP(6,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVP 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvVP(MAh,MFd,MFe,MSd,MSe,               & 
& MSv,MVP,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVP2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,        & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVPL,cplcFdFdVPR,     & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplSdSvcSd,cplSdcSdVP,cplSeSvcSe,      & 
& cplSecSeVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVP,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),             & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),               & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplSdSvcSd(6,3,6),cplSdcSdVP(6,6),cplSeSvcSe(6,3,6), & 
& cplSecSeVP(6,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvVP


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvVZ(MAh,MAh2,MSv,MSv2,MVZ,MVZ2,             & 
& ZfAh,ZfSv,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3),ZfVZ

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvVZ(MAh,MFd,MFe,MSd,MSe,MSv,              & 
& MVZ,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,     & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,      & 
& cplSecSeVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVZ,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),             & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplSdSvcSd(6,3,6),cplSdcSdVZ(6,6),cplSeSvcSe(6,3,6), & 
& cplSecSeVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVZ 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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


! {Fe, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Se, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(gt1,i1,i2)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvVZ(MAh,MFd,MFe,MSd,MSe,               & 
& MSv,MVZ,MAh2,MFd2,MFe2,MSd2,MSe2,MSv2,MVZ2,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,        & 
& cplcFeFeAhR,cplAhSdcSd,cplAhSecSe,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVZL,cplcFdFdVZR,     & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVZL,cplcFeFeVZR,cplSdSvcSd,cplSdcSdVZ,cplSeSvcSe,      & 
& cplSecSeVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MSd(6),MSe(6),MSv(3),MVZ,MAh2(2),MFd2(3),MFe2(3),MSd2(6),        & 
& MSe2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),             & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplSdSvcSd(6,3,6),cplSdcSdVZ(6,6),cplSeSvcSe(6,3,6), & 
& cplSecSeVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvcSv(MAh,MAh2,MSv,MSv2,ZfAh,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToSvcSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvcSv(MAh,MCha,MChi,MFd,MFe,               & 
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

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 


! {Chi, Chi, Fv}
Do i1=1,4
  Do i2=1,4
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = 0. 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
coup3L = cplChiFvcSvL(i2,i3,gt3)
coup3R = cplChiFvcSvR(i2,i3,gt3)
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {hh, VZ, conj[Sv]}
Do i1=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MSv(i3) 
coup1 = -cplAhhhVZ(gt1,i1)
coup2 = cplhhSvcSv(i1,gt2,i3)
coup3 = -cplSvcSvVZ(i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {VZ, hh, conj[Sv]}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MSv(i3) 
coup1 = -cplAhhhVZ(gt1,i2)
coup2 = -cplSvcSvVZ(gt2,i3)
coup3 = cplhhSvcSv(i2,i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Cha], bar[Fe]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaChaAhL(i1,i2,gt1)
coup1R = cplcChaChaAhR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i3,i1,gt2)
coup2R = cplcFeChaSvR(i3,i1,gt2)
coup3L = cplcChaFecSvL(i2,i3,gt3)
coup3R = cplcChaFecSvR(i2,i3,gt3)
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


! {conj[Hpm], conj[Hpm], conj[Se]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MSe(i3) 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = cplSecHpmcSv(i3,i2,gt3)
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


! {conj[Hpm], conj[VWm], conj[Se]}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MSe(i3) 
coup1 = -cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmSvcSe(i1,gt2,i3)
coup3 = -cplSecSvcVWm(i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[VWm], conj[Hpm], conj[Se]}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MSe(i3) 
coup1 = -cplAhHpmcVWm(gt1,i2)
coup2 = -cplSvcSeVWm(gt2,i3)
coup3 = cplSecHpmcSv(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmSvcHpmcSv1(i2,gt2,i1,gt3)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = cplSdSvcSdcSvaa(i2,gt2,i1,gt3)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSeSvcSecSv1(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSuSvcSucSvaa(i2,gt2,i1,gt3)
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
coup1 = cplAhSdcSdcSvaa(gt1,i1,i2,gt3)
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
coup1 = cplAhSecHpmcSv1(gt1,i1,i2,gt3)
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
coup1 = cplAhSecSecSv1(gt1,i1,i2,gt3)
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


! {Hpm, Se}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
coup1 = cplAhHpmSvcSe1(gt1,i1,gt2,i2)
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
coup1 = cplAhSdSvcSdaa(gt1,i1,gt2,i2)
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
coup1 = cplAhSeSvcSe1(gt1,i1,gt2,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToSvcSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvcSv(MAh,MCha,MChi,MFd,MFe,            & 
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

Complex(dp), Intent(out) :: Amp(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToSvcSv


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVGVG(MAh,MAh2,MVG,MVG2,ZfAh,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVG,MVG2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVG

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVGVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVGVG(MAh,MFd,MFu,MSd,MSu,MVG,              & 
& MAh2,MFd2,MFu2,MSd2,MSu2,MVG2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,         & 
& cplAhSdcSd,cplAhSucSu,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplSdcSdVG,      & 
& cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFu(3),MSd(6),MSu(6),MVG,MAh2(2),MFd2(3),MFu2(3),MSd2(6),               & 
& MSu2(6),MVG2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFuFuVGL(3,3),& 
& cplcFuFuVGR(3,3),cplSdcSdVG(6,6),cplSucSuVG(6,6),cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVG 
Mex3 = MVG 


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = -cplcFuFuVGR(i1,i3)
coup2R = -cplcFuFuVGL(i1,i3)
coup3L = -cplcFuFuVGR(i3,i2)
coup3R = -cplcFuFuVGL(i3,i2)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = -cplSdcSdVG(i3,i1)
coup3 = -cplSdcSdVG(i2,i3)
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


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = -cplSucSuVG(i3,i1)
coup3 = -cplSucSuVG(i2,i3)
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
coup1 = cplAhSdcSd(gt1,i1,i2)
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


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
coup2 = cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVGVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVGVG(MAh,MFd,MFu,MSd,MSu,               & 
& MVG,MAh2,MFd2,MFu2,MSd2,MSu2,MVG2,cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSdcSd,cplAhSucSu,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplSdcSdVG,      & 
& cplSucSuVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,& 
& cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFu(3),MSd(6),MSu(6),MVG,MAh2(2),MFd2(3),MFu2(3),MSd2(6),               & 
& MSu2(6),MVG2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFuFuVGL(3,3),& 
& cplcFuFuVGR(3,3),cplSdcSdVG(6,6),cplSucSuVG(6,6),cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVG 
Mex3 = MVG 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVGVG


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVPVP(MAh,MAh2,MVP,MVP2,ZfAh,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVP,MVP2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVP

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVPVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVPVP(MAh,MCha,MFd,MFe,MFu,MHpm,            & 
& MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVP2,              & 
& MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,     & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,cplcChaChaVPR,             & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSecSeVP,           & 
& cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplHpmcHpmVPVP1,  & 
& cplSdcSdVPVPaa,cplSecSeVPVP1,cplSucSuVPVPaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVP,MVWm,            & 
& MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),             & 
& MVP2,MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcgWmgWmVP,      & 
& cplcgWpCgWpCVP,cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSecSeVP(6,6),      & 
& cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplAhHpmcVWmVP1(2,2),cplAhcHpmVPVWm1(2,2),& 
& cplHpmcHpmVPVP1(2,2),cplSdcSdVPVPaa(6,6),cplSecSeVPVP1(6,6),cplSucSuVPVPaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVP 
Mex3 = MVP 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = -cplcChaChaVPR(i1,i3)
coup2R = -cplcChaChaVPL(i1,i3)
coup3L = -cplcChaChaVPR(i3,i2)
coup3R = -cplcChaChaVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = -cplcFuFuVPR(i1,i3)
coup2R = -cplcFuFuVPL(i1,i3)
coup3L = -cplcFuFuVPR(i3,i2)
coup3R = -cplcFuFuVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmVP
coup3 = cplcgWmgWmVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpCVP
coup3 = cplcgWpCgWpCVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = -cplSdcSdVP(i3,i1)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = -cplSecSeVP(i3,i1)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = -cplSucSuVP(i3,i1)
coup3 = -cplSucSuVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplHpmcVWmVP(i3)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplcVWmVPVWm
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcHpmVP(i1,i3)
coup3 = cplHpmcVWmVP(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmcVWmVP(i1)
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcVWmVP(i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2 = cplcHpmVPVWm(i3)
coup3 = cplHpmcHpmVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2 = -cplcVWmVPVWm
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmVPVP1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSecSeVPVP1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSucSuVPVPaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplHpmcVWmVP(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplHpmcVWmVP(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVPVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVPVP(MAh,MCha,MFd,MFe,MFu,              & 
& MHpm,MSd,MSe,MSu,MVP,MVWm,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,              & 
& MVP2,MVWm2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,              & 
& cplcChaChaVPR,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,             & 
& cplcFuFuVPR,cplcgWmgWmVP,cplcgWpCgWpCVP,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,          & 
& cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,cplcVWmVPVWm,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,       & 
& cplHpmcHpmVPVP1,cplSdcSdVPVPaa,cplSecSeVPVP1,cplSucSuVPVPaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVP,MVWm,            & 
& MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),             & 
& MVP2,MVWm2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),               & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcgWmgWmVP,      & 
& cplcgWpCgWpCVP,cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSecSeVP(6,6),      & 
& cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplAhHpmcVWmVP1(2,2),cplAhcHpmVPVWm1(2,2),& 
& cplHpmcHpmVPVP1(2,2),cplSdcSdVPVPaa(6,6),cplSecSeVPVP1(6,6),cplSucSuVPVPaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVP 
Mex3 = MVP 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVPVP


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVPVZ(MAh,MAh2,MVP,MVP2,MVZ,MVZ2,             & 
& ZfAh,ZfVP,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVP,ZfVZ

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVPVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVPVZ(MAh,MCha,MFd,MFe,MFu,MHpm,            & 
& MSd,MSe,MSu,MVP,MVWm,MVZ,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,               & 
& MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,          & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplcChaChaVPL,              & 
& cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,         & 
& cplcFdFdVZR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpCVP,          & 
& cplcgWpCgWpCVZ,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVP,         & 
& cplSdcSdVZ,cplSecSeVP,cplSecSeVZ,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,cplcVWmVPVWm,      & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,             & 
& cplAhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,cplSecSeVPVZ1,cplSucSuVPVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVP,MVWm,            & 
& MVZ,MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),         & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeVPL(3,3),  & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),  & 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpCVP,            & 
& cplcgWpCgWpCVZ,cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),    & 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSucSuVP(6,6),       & 
& cplSucSuVZ(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,             & 
& cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),cplAhcHpmVPVWm1(2,2),cplAhcHpmVWmVZ1(2,2),   & 
& cplHpmcHpmVPVZ1(2,2),cplSdcSdVPVZaa(6,6),cplSecSeVPVZ1(6,6),cplSucSuVPVZaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVP 
Mex3 = MVZ 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = -cplcChaChaVPR(i1,i3)
coup2R = -cplcChaChaVPL(i1,i3)
coup3L = -cplcChaChaVZR(i3,i2)
coup3R = -cplcChaChaVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
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
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = -cplcFuFuVPR(i1,i3)
coup2R = -cplcFuFuVPL(i1,i3)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmVP
coup3 = cplcgWmgWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpCVP
coup3 = cplcgWpCgWpCVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = -cplSdcSdVP(i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = -cplSecSeVP(i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = -cplSucSuVP(i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplHpmcVWmVP(i3)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplcVWmVPVWm
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcHpmVP(i1,i3)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmcVWmVP(i1)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcVWmVP(i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2 = cplcHpmVPVWm(i3)
coup3 = cplHpmcHpmVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2 = -cplcVWmVPVWm
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmVPVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSecSeVPVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSucSuVPVZaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWmVZ1(gt1,i2)
coup2 = cplHpmcVWmVP(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplHpmcVWmVZ(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVPVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVPVZ(MAh,MCha,MFd,MFe,MFu,              & 
& MHpm,MSd,MSe,MSu,MVP,MVWm,MVZ,MAh2,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,               & 
& MSu2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,              & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,           & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcFdFdVPL,cplcFdFdVPR,       & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVP,cplcgWmgWmVZ,             & 
& cplcgWpCgWpCVP,cplcgWpCgWpCVZ,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,     & 
& cplSdcSdVP,cplSdcSdVZ,cplSecSeVP,cplSecSeVZ,cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,        & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,& 
& cplAhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplSdcSdVPVZaa,cplSecSeVPVZ1,cplSucSuVPVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVP,MVWm,            & 
& MVZ,MAh2(2),MCha2(2),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),         & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),               & 
& cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),               & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeVPL(3,3),  & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),  & 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmVP,cplcgWmgWmVZ,cplcgWpCgWpCVP,            & 
& cplcgWpCgWpCVZ,cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),    & 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSucSuVP(6,6),       & 
& cplSucSuVZ(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,             & 
& cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),cplAhcHpmVPVWm1(2,2),cplAhcHpmVWmVZ1(2,2),   & 
& cplHpmcHpmVPVZ1(2,2),cplSdcSdVPVZaa(6,6),cplSecSeVPVZ1(6,6),cplSucSuVPVZaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVP 
Mex3 = MVZ 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVPVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVWmcVWm(MAh,MAh2,MVWm,MVWm2,ZfAh,            & 
& ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVWm

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVWmcVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVWmcVWm(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacVWmL,             & 
& cplChiChacVWmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcVWmL,cplcFuFdcVWmR,              & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,cplcgZgWpCVWm,   & 
& cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcVWmVP,       & 
& cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,           & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,cplAhcHpmVPVWm1,& 
& cplAhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1,cplSucSucVWmVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacVWmL(4,2),             & 
& cplChiChacVWmR(4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcVWmL(3,3),        & 
& cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFuVWmL(3,3),              & 
& cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcgWmgAVWm,cplcgWpCgAcVWm,     & 
& cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcVWm,   & 
& cplhhHpmcVWm(2,2),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),   & 
& cplSdcSucVWm(6,6),cplSecSvcVWm(6,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2), & 
& cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),   & 
& cplAhcHpmVPVWm1(2,2),cplAhcHpmVWmVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2),cplSdcSdcVWmVWmaa(6,6),& 
& cplSecSecVWmVWm1(6,6),cplSucSucVWmVWmaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVWm 
Mex3 = MVWm 


! {Ah, hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhAhhh(gt1,i1,i2)
coup2 = cplAhcHpmVWm(i1,i3)
coup3 = -cplhhHpmcVWm(i2,i3)
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


! {Cha, Cha, Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = -cplcChaChiVWmR(i1,i3)
coup2R = -cplcChaChiVWmL(i1,i3)
coup3L = -cplChiChacVWmR(i3,i2)
coup3R = -cplChiChacVWmL(i3,i2)
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


! {Chi, Chi, bar[Cha]}
Do i1=1,4
  Do i2=1,4
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = cplcChaChiVWmL(i3,i1)
coup2R = cplcChaChiVWmR(i3,i1)
coup3L = cplChiChacVWmL(i2,i3)
coup3R = cplChiChacVWmR(i2,i3)
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


! {Fd, Fd, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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


! {gWm, gWm, gP}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgAVWm
coup3 = cplcgAgWmcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {gWm, gWm, gZ}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgZVWm
coup3 = cplcgZgWmcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {hh, Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhAhhh(gt1,i2,i1)
coup2 = cplhhcHpmVWm(i1,i3)
coup3 = -cplAhHpmcVWm(i2,i3)
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


! {hh, VZ, conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplAhhhVZ(gt1,i1)
coup2 = cplhhcHpmVWm(i1,i3)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {hh, VZ, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplAhhhVZ(gt1,i1)
coup2 = cplhhcVWmVWm(i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Hpm, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplAhcHpmVWm(i3,i1)
coup3 = cplAhHpmcVWm(i3,i2)
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


! {Hpm, Hpm, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplhhcHpmVWm(i3,i1)
coup3 = cplhhHpmcVWm(i3,i2)
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


! {Hpm, VWm, hh}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = -cplhhcHpmVWm(i3,i1)
coup3 = cplhhcVWmVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, VP}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Hpm, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplcHpmVWmVZ(i1)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplcHpmVWmVZ(i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
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


! {VWm, Hpm, hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplhhcVWmVWm(i3)
coup3 = cplhhHpmcVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VP}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = -cplcVWmVPVWm
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {VWm, Hpm, VZ}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplcVWmVWmVZ
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, hh, conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhhhVZ(gt1,i2)
coup2 = cplcHpmVWmVZ(i3)
coup3 = -cplhhHpmcVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, hh, conj[VWm]}
  Do i2=1,2
ML1 = MVZ 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplAhhhVZ(gt1,i2)
coup2 = -cplcVWmVWmVZ
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {bar[Fu], bar[Fu], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(i1,i2,gt1)
coup1R = cplcFuFuAhR(i1,i2,gt1)
coup2L = cplcFdFuVWmL(i3,i1)
coup2R = cplcFdFuVWmR(i3,i1)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
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


! {bar[gWmC], bar[gWmC], bar[gP]}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgAgWpCVWm
coup3 = cplcgWpCgAcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {bar[gWmC], bar[gWmC], bar[gZ]}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgZgWpCVWm
coup3 = cplcgWpCgZcVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Su], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(gt1,i2,i1)
coup2 = cplSucSdVWm(i1,i3)
coup3 = cplSdcSucVWm(i3,i2)
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


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmcVWmVWm1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSecSecVWmVWm1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSucSucVWmVWmaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {Hpm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VP, Hpm}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplHpmcVWmVP(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do


! {VZ, Hpm}
  Do i2=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWmVZ1(gt1,i2)
coup2 = cplHpmcVWmVZ(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVWmcVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVWmcVWm(MAh,MCha,MChi,MFd,              & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,           & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,             & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplChiChacVWmL,cplChiChacVWmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcVWmL,             & 
& cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,        & 
& cplcFeFvVWmR,cplcgWmgAVWm,cplcgWpCgAcVWm,cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,    & 
& cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcVWm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhcVWmVWm,      & 
& cplHpmcVWmVP,cplHpmcVWmVZ,cplSdcSucVWm,cplSecSvcVWm,cplSucSdVWm,cplSvcSeVWm,           & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVP1,cplAhHpmcVWmVZ1,   & 
& cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,cplSdcSdcVWmVWmaa,cplSecSecVWmVWm1, & 
& cplSucSucVWmVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacVWmL(4,2),             & 
& cplChiChacVWmR(4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcVWmL(3,3),        & 
& cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFuVWmL(3,3),              & 
& cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcgWmgAVWm,cplcgWpCgAcVWm,     & 
& cplcgAgWmcVWm,cplcgZgWmcVWm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcVWm,   & 
& cplhhHpmcVWm(2,2),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),   & 
& cplSdcSucVWm(6,6),cplSecSvcVWm(6,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2), & 
& cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhHpmcVWmVP1(2,2),cplAhHpmcVWmVZ1(2,2),   & 
& cplAhcHpmVPVWm1(2,2),cplAhcHpmVWmVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2),cplSdcSdcVWmVWmaa(6,6),& 
& cplSecSecVWmVWm1(6,6),cplSucSucVWmVWmaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVWm 
Mex3 = MVWm 


! {Hpm, Hpm, VP}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {VWm, Hpm, VP}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = -cplcVWmVPVWm
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplAhHpmcVWmVP1(gt1,i1)
coup2 = cplcHpmVPVWm(i1)
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VP, Hpm}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVPVWm1(gt1,i2)
coup2 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoVV_Topology4_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVWmcVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVZVZ(MAh,MAh2,MVZ,MVZ2,ZfAh,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfVZ

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MAh(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_AhToVZVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVZVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,             & 
& MSu2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,     & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,              & 
& cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,             & 
& cplAhcHpmVWm,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplcFdFdVZL,        & 
& cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcgWmgWmVZ,              & 
& cplcgWpCgWpCVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,cplSucSuVZ,             & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplHpmcHpmVZVZ1,             & 
& cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),           & 
& MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),             & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeVZL(3,3),& 
& cplcFeFeVZR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmVZ,cplcgWpCgWpCVZ,        & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSecSeVZ(6,6),cplSucSuVZ(6,6),     & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2),cplHpmcHpmVZVZ1(2,2),& 
& cplSdcSdVZVZaa(6,6),cplSecSeVZVZ1(6,6),cplSucSuVZVZaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVZ 
Mex3 = MVZ 


! {Cha, Cha, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaChaAhL(i2,i1,gt1)
coup1R = cplcChaChaAhR(i2,i1,gt1)
coup2L = -cplcChaChaVZR(i1,i3)
coup2R = -cplcChaChaVZL(i1,i3)
coup3L = -cplcChaChaVZR(i3,i2)
coup3R = -cplcChaChaVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Chi, Chi, Chi}
Do i1=1,4
  Do i2=1,4
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChiAhL(i1,i2,gt1)
coup1R = cplChiChiAhR(i1,i2,gt1)
coup2L = -cplChiChiVZR(i1,i3)
coup2R = -cplChiChiVZL(i1,i3)
coup3L = -cplChiChiVZR(i3,i2)
coup3R = -cplChiChiVZL(i3,i2)
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


! {Fd, Fd, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdFdAhL(i2,i1,gt1)
coup1R = cplcFdFdAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
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
coup1L = cplcFeFeAhL(i2,i1,gt1)
coup1R = cplcFeFeAhR(i2,i1,gt1)
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
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Fu, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(i2,i1,gt1)
coup1R = cplcFuFuAhR(i2,i1,gt1)
coup2L = -cplcFuFuVZR(i1,i3)
coup2R = -cplcFuFuVZL(i1,i3)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {gWm, gWm, gWm}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWmgWmAh(gt1)
coup2 = cplcgWmgWmVZ
coup3 = cplcgWmgWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 


! {gWmC, gWmC, gWmC}
ML1 = MVWm 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgWpCAh(gt1)
coup2 = cplcgWpCgWpCVZ
coup3 = cplcgWpCgWpCVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 


! {Hpm, Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = -cplHpmcHpmVZ(i3,i1)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Hpm, VWm, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = -cplHpmcHpmVZ(i3,i1)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, Hpm, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplcHpmVWmVZ(i1)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VWm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i1)
coup2 = cplcHpmVWmVZ(i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Sd, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(gt1,i1,i2)
coup2 = -cplSdcSdVZ(i3,i1)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = -cplSecSeVZ(i3,i1)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(2)*AmpC 
    End Do
  End Do
End Do


! {Su, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = -cplSucSuVZ(i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(6)*AmpC 
    End Do
  End Do
End Do


! {VWm, Hpm, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = cplHpmcVWmVZ(i3)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Hpm, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(gt1,i2)
coup2 = -cplcVWmVWmVZ
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcHpmVZ(i1,i3)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {conj[Hpm], conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(gt1,i2,i1)
coup2 = cplHpmcVWmVZ(i1)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(gt1,i1)
coup2 = cplHpmcVWmVZ(i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {conj[VWm], conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2 = cplcHpmVWmVZ(i3)
coup3 = cplHpmcHpmVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcVWm(gt1,i2)
coup2 = cplcVWmVWmVZ
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(gt1,i1,i2)
coup2 = cplHpmcHpmVZVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(gt1,i1,i2)
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
coup1 = cplAhSecSe(gt1,i1,i2)
coup2 = cplSecSeVZVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(gt1,i1,i2)
coup2 = cplSucSuVZVZaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWmVZ1(gt1,i2)
coup2 = cplHpmcVWmVZ(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplAhHpmcVWmVZ1(gt1,i1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {VWm, Hpm}
  Do i2=1,2
ML1 = MVWm 
ML2 = MHpm(i2) 
coup1 = cplAhcHpmVWmVZ1(gt1,i2)
coup2 = cplHpmcVWmVZ(i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_VS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_AhToVZVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVZVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MHpm,MSd,MSe,MSu,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,              & 
& MSe2,MSu2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,            & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,           & 
& cplAhSucSu,cplAhcHpmVWm,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,         & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcgWmgWmVZ,cplcgWpCgWpCVZ,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSecSeVZ,           & 
& cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplHpmcHpmVZVZ1,  & 
& cplSdcSdVZVZaa,cplSecSeVZVZ1,cplSucSuVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),             & 
& MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),           & 
& MSe2(6),MSu2(6),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),           & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),cplcgWpCgWpCAh(2),               & 
& cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),             & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFeFeVZL(3,3),& 
& cplcFeFeVZR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcgWmgWmVZ,cplcgWpCgWpCVZ,        & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSecSeVZ(6,6),cplSucSuVZ(6,6),     & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2),cplHpmcHpmVZVZ1(2,2),& 
& cplSdcSdVZVZaa(6,6),cplSecSeVZVZ1(6,6),cplSucSuVZVZaa(6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MAh(gt1) 
Mex2 = MVZ 
Mex3 = MVZ 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_AhToVZVZ



End Module OneLoopDecay_Ah_MSSMTriLnV
