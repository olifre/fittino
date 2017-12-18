! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:58 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Hpm_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_HpmToHpmAh(cplAhHpmcHpm,MAh,MHpm,MAh2,           & 
& MHpm2,Amp)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MAh(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhHpmcHpm(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToHpmAh


Subroutine Gamma_Real_MSSMTriLnV_HpmToHpmAh(MLambda,em,gs,cplAhHpmcHpm,               & 
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
Coup = cplAhHpmcHpm(i3,i2,i1)
Mex1 = MHpm(i1)
Mex2 = MHpm(i2)
Mex3 = MAh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp,1._dp,0._dp,1._dp,0._dp,0._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToHpmAh


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmAh(cplAhHpmcHpm,ctcplAhHpmcHpm,          & 
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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MAh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhHpmcHpm(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplAhHpmcHpm(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt2)*cplAhHpmcHpm(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt3)*cplAhHpmcHpm(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmAh(MAh,MCha,MChi,MFd,MFe,              & 
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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MAh(gt3) 


! {Ah, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i3,i2)
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


! {Ah, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
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


! {Ah, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhHpmcVWm(i1,gt2)
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


! {Cha, Chi, Chi}
Do i1=1,2
  Do i2=1,4
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,i3,gt2)
coup2R = cplcChaChiHpmR(i1,i3,gt2)
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


! {Chi, bar[Cha], bar[Cha]}
Do i1=1,4
  Do i2=1,2
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(i3,i1,gt2)
coup2R = cplcChaChiHpmR(i3,i1,gt2)
coup3L = cplcChaChaAhL(i2,i3,gt3)
coup3R = cplcChaChaAhR(i2,i3,gt3)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = cplcFuFuAhL(i3,i2,gt3)
coup3R = cplcFuFuAhR(i3,i2,gt3)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
coup3L = cplcFeFeAhL(i2,i3,gt3)
coup3R = cplcFeFeAhR(i2,i3,gt3)
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


! {gZ, gWmC, gWmC}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgWpCHpm(gt2)
coup3 = cplcgWpCgWpCAh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i3,i2)
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


! {hh, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
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


! {hh, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhHpmcVWm(i1,gt2)
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


! {Hpm, hh, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplAhHpmcHpm(i3,gt2,i1)
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


! {Hpm, Ah, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, VZ, hh}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, hh, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = -cplHpmcHpmVZ(gt2,i1)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = cplAhSucSu(gt3,i2,i3)
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


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
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


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
coup3 = cplAhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplAhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VWm, hh, Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplAhHpmcVWm(i3,gt2)
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


! {VWm, Ah, hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplhhHpmcVWm(i3,gt2)
coup3 = cplAhAhhh(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VZ, hh}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplhhHpmcVWm(i3,gt2)
coup3 = cplAhhhVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, hh, VZ}
  Do i2=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplAhhhVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = -cplHpmcHpmVZ(gt2,i3)
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


! {VZ, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVZ 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = -cplHpmcHpmVZ(gt2,i3)
coup3 = cplAhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplAhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
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


! {bar[gZ], bar[gWm], bar[gWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgZHpm(gt2)
coup3 = cplcgWmgWmAh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplHpmSvcSe(gt2,i1,i3)
coup3 = cplAhSecSe(gt3,i3,i2)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhAhHpmcHpm1(gt3,i1,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplAhhhHpmcHpm1(gt3,i1,gt2,i2)
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
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplAhHpmSucSdaa(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplAhHpmSvcSe1(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplAhHpmcVWmVP1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplAhHpmcVWmVZ1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhAhHpmcHpm1(gt3,i1,i2,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhhhHpmcHpm1(gt3,i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhSdcHpmcSuaa(gt3,i1,gt1,i2)
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
coup1 = cplAhSecHpmcSv1(gt3,i1,gt1,i2)
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


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplAhcHpmVPVWm1(gt3,gt1)
coup2 = cplHpmcVWmVP(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplAhcHpmVWmVZ1(gt3,gt1)
coup2 = cplHpmcVWmVZ(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {Ah, hh}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = Mhh(i2) 
coup1 = cplAhhhHpmcHpm1(i1,i2,gt2,gt1)
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
coup1 = cplHpmHpmcHpmcHpm1(gt2,i1,gt1,i2)
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
coup1 = cplHpmSdcHpmcSdaa(gt2,i1,gt1,i2)
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
coup1 = cplHpmSecHpmcSe1(gt2,i1,gt1,i2)
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
coup1 = cplHpmSucHpmcSuaa(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh(MAh,MCha,MChi,MFd,               & 
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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MAh(gt3) 


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
coup3 = cplAhHpmcVWm(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplAhcHpmVWm(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplAhHpmcVWmVP1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplAhcHpmVPVWm1(gt3,gt1)
coup2 = cplHpmcVWmVP(gt2)
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmAh


Subroutine Amplitude_Tree_MSSMTriLnV_HpmToAhVWm(cplAhcHpmVWm,MAh,MHpm,MVWm,           & 
& MAh2,MHpm2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MHpm(2),MVWm,MAh2(2),MHpm2(2),MVWm2

Complex(dp), Intent(in) :: cplAhcHpmVWm(2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = -cplAhcHpmVWm(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToAhVWm


Subroutine Gamma_Real_MSSMTriLnV_HpmToAhVWm(MLambda,em,gs,cplAhcHpmVWm,               & 
& MAh,MHpm,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhcHpmVWm(2,2)

Real(dp), Intent(in) :: MAh(2),MHpm(2),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2), GammarealGluon(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=2,2
Coup = cplAhcHpmVWm(i2,i1)
Mex1 = MHpm(i1)
Mex2 = MAh(i2)
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,-1._dp,0._dp,-1._dp,Coup,Gammarealphoton(i1,i2),kont)
 GammarealGluon(i1,i2) = 0._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToAhVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToAhVWm(cplAhcHpmVWm,ctcplAhcHpmVWm,          & 
& MAh,MAh2,MHpm,MHpm2,MVWm,MVWm2,ZfAh,ZfHpm,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MHpm(2),MHpm2(2),MVWm,MVWm2

Complex(dp), Intent(in) :: cplAhcHpmVWm(2,2)

Complex(dp), Intent(in) :: ctcplAhcHpmVWm(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhcHpmVWm(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplAhcHpmVWm(gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt2)*cplAhcHpmVWm(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplAhcHpmVWm(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToAhVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToAhVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,  & 
& cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,             & 
& cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,             & 
& cplChiChacHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,              & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,         & 
& cplcgWpCgAcHpm,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,  & 
& cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,           & 
& cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,          & 
& cplHpmcHpmcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcHpmL(3,3,2),    & 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFdFuVWmL(3,3),        & 
& cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcgWpCgAcHpm(2),               & 
& cplcgZgWmcHpm(2),cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm(2),           & 
& cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcHpmVP(2,2),               & 
& cplHpmcHpmVZ(2,2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplSucSdVWm(6,6),            & 
& cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,            & 
& cplAhAhcVWmVWm1(2,2),cplAhcHpmVPVWm1(2,2),cplAhcHpmVWmVZ1(2,2),cplhhcHpmVWmVZ1(2,2),   & 
& cplHpmcHpmcVWmVWm1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVWm 


! {Ah, conj[Hpm], hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhAhhh(gt2,i1,i3)
coup3 = cplhhcHpmVWm(i3,i2)
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


! {Ah, conj[VWm], hh}
Do i1=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhAhhh(gt2,i1,i3)
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


! {Cha, Chi, Cha}
Do i1=1,2
  Do i2=1,4
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaChaAhL(i1,i3,gt2)
coup2R = cplcChaChaAhR(i1,i3,gt2)
coup3L = -cplcChaChiVWmR(i3,i2)
coup3R = -cplcChaChiVWmL(i3,i2)
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


! {Chi, bar[Cha], Chi}
Do i1=1,4
  Do i2=1,2
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiChiAhL(i1,i3,gt2)
coup2R = cplChiChiAhR(i1,i3,gt2)
coup3L = cplcChaChiVWmL(i2,i3)
coup3R = cplcChaChiVWmR(i2,i3)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
coup3L = -cplcFdFuVWmR(i3,i2)
coup3R = -cplcFdFuVWmL(i3,i2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
coup3L = -cplcFeFvVWmR(i3,i2)
coup3R = -cplcFeFvVWmL(i3,i2)
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


! {gWm, gZ, gWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgWmAh(gt2)
coup3 = cplcgWmgZVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplAhAhhh(gt2,i3,i1)
coup3 = cplAhcHpmVWm(i3,i2)
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


! {hh, conj[Hpm], VZ}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplAhhhVZ(gt2,i1)
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


! {hh, conj[VWm], VZ}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplAhhhVZ(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Ah, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = -cplAhcHpmVWm(i2,i3)
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


! {Hpm, hh, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = -cplhhcHpmVWm(i2,i3)
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


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
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


! {Hpm, VZ, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
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


! {Hpm, hh, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplAhcHpmVWm(gt2,i1)
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


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplAhcHpmVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplAhcHpmVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplAhSdcSd(gt2,i3,i1)
coup3 = -cplSucSdVWm(i2,i3)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = -cplSvcSeVWm(i2,i3)
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


! {VWm, Ah, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = -cplAhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = -cplhhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplAhhhVZ(gt2,i3)
coup3 = cplhhcHpmVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[VWm], hh}
    Do i3=1,2
ML1 = MVZ 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplAhhhVZ(gt2,i3)
coup3 = cplhhcVWmVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuAhL(i3,i1,gt2)
coup2R = cplcFuFuAhR(i3,i1,gt2)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
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


! {bar[gWmC], bar[gP], bar[gWmC]}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcgWpCgAcHpm(gt1)
coup2 = cplcgWpCgWpCAh(gt2)
coup3 = cplcgAgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {bar[gWmC], bar[gZ], bar[gWmC]}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgWpCgWpCAh(gt2)
coup3 = cplcgZgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplAhSucSu(gt2,i1,i3)
coup3 = cplSucSdVWm(i3,i2)
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


! {Ah, conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
coup1 = -cplAhcHpmVWm(i1,gt1)
coup2 = cplAhAhcVWmVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplAhcHpmVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2 = cplAhcHpmVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {hh, VZ}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
coup1 = cplhhcHpmVWmVZ1(i1,gt1)
coup2 = cplAhhhVZ(gt2,i1)
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
coup1 = cplHpmcHpmcVWmVWm1(i1,gt1)
coup2 = cplAhcHpmVWm(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToAhVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,           & 
& cplcChaChaAhR,cplChiChiAhL,cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,           & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplcgWmgWmAh,cplcgWpCgWpCAh,cplAhhhVZ,             & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplAhcHpmVWm,               & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,             & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,        & 
& cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,    & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,       & 
& cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,           & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhAhcVWmVWm1,cplAhcHpmVPVWm1,cplAhcHpmVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),       & 
& cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),          & 
& cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplcgWmgWmAh(2),              & 
& cplcgWpCgWpCAh(2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),& 
& cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcHpmL(3,3,2),    & 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFdFuVWmL(3,3),        & 
& cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcgWpCgAcHpm(2),               & 
& cplcgZgWmcHpm(2),cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm(2),           & 
& cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcHpmVP(2,2),               & 
& cplHpmcHpmVZ(2,2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplSucSdVWm(6,6),            & 
& cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,            & 
& cplAhAhcVWmVWm1(2,2),cplAhcHpmVPVWm1(2,2),cplAhcHpmVWmVZ1(2,2),cplhhcHpmVWmVZ1(2,2),   & 
& cplHpmcHpmcVWmVWm1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVWm 


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplAhHpmcHpm(gt2,i3,i1)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplAhcHpmVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplAhHpmcVWm(gt2,i3)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplAhcHpmVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhVWm


Subroutine Amplitude_Tree_MSSMTriLnV_HpmToChiCha(cplChiChacHpmL,cplChiChacHpmR,       & 
& MCha,MChi,MHpm,MCha2,MChi2,MHpm2,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MHpm(2),MCha2(2),MChi2(4),MHpm2(2)

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2)

Complex(dp) :: Amp(2,2,4,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MCha(gt3) 
! Tree-Level Vertex 
coupT1L = cplChiChacHpmL(gt2,gt3,gt1)
coupT1R = cplChiChacHpmR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToChiCha


Subroutine Gamma_Real_MSSMTriLnV_HpmToChiCha(MLambda,em,gs,cplChiChacHpmL,            & 
& cplChiChacHpmR,MCha,MChi,MHpm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2)

Real(dp), Intent(in) :: MCha(2),MChi(4),MHpm(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,4,2), GammarealGluon(2,4,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,4
    Do i3=1,2
CoupL = cplChiChacHpmL(i2,i3,i1)
CoupR = cplChiChacHpmR(i2,i3,i1)
Mex1 = MHpm(i1)
Mex2 = MChi(i2)
Mex3 = MCha(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp,0._dp,1._dp,0._dp,0._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToChiCha


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToChiCha(cplChiChacHpmL,cplChiChacHpmR,       & 
& ctcplChiChacHpmL,ctcplChiChacHpmR,MCha,MCha2,MChi,MChi2,MHpm,MHpm2,ZfHpm,              & 
& ZfL0,ZfLm,ZfLp,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MChi(4),MChi2(4),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2)

Complex(dp), Intent(in) :: ctcplChiChacHpmL(4,2,2),ctcplChiChacHpmR(4,2,2)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfL0(4,4),ZfLm(2,2),ZfLp(2,2)

Complex(dp), Intent(out) :: Amp(2,2,4,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MCha(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChiChacHpmL(gt2,gt3,gt1) 
ZcoupT1R = ctcplChiChacHpmR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplChiChacHpmL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplChiChacHpmR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt2)*cplChiChacHpmL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt2))*cplChiChacHpmR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLm(i1,gt3)*cplChiChacHpmL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLp(i1,gt3))*cplChiChacHpmR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToChiCha


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToChiCha(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,            & 
& cplChiChiAhL,cplChiChiAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,     & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,   & 
& cplFvFecHpmL,cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,         & 
& cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),     & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),       & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),     & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),     & 
& cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),             & 
& cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2)

Complex(dp), Intent(out) :: Amp(2,2,4,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MCha(gt3) 


! {Ah, conj[Hpm], Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2L = cplChiChiAhL(gt2,i3,i1)
coup2R = cplChiChiAhR(gt2,i3,i1)
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


! {Ah, conj[VWm], Chi}
Do i1=1,2
    Do i3=1,4
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MChi(i3) 
coup1 = -cplAhcHpmVWm(i1,gt1)
coup2L = cplChiChiAhL(gt2,i3,i1)
coup2R = cplChiChiAhR(gt2,i3,i1)
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


! {Cha, Chi, Hpm}
Do i1=1,2
  Do i2=1,4
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MHpm(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,gt2,i3)
coup2R = cplcChaChiHpmR(i1,gt2,i3)
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


! {Cha, Chi, VWm}
Do i1=1,2
  Do i2=1,4
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MVWm 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = -cplcChaChiVWmR(i1,gt2)
coup2R = -cplcChaChiVWmL(i1,gt2)
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


! {Chi, bar[Cha], Ah}
Do i1=1,4
  Do i2=1,2
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MAh(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiChiAhL(gt2,i1,i3)
coup2R = cplChiChiAhR(gt2,i1,i3)
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


! {Chi, bar[Cha], hh}
Do i1=1,4
  Do i2=1,2
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = Mhh(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiChihhL(gt2,i1,i3)
coup2R = cplChiChihhR(gt2,i1,i3)
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


! {Chi, bar[Cha], VZ}
Do i1=1,4
  Do i2=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MVZ 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiChiVZL(gt2,i1)
coup2R = cplChiChiVZR(gt2,i1)
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


! {Fd, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
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


! {Fe, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,gt2,i3)
coup2R = cplcFeChiSeR(i1,gt2,i3)
coup3L = cplFvChacSeL(i2,gt3,i3)
coup3R = cplFvChacSeR(i2,gt3,i3)
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


! {Fv, bar[Fe], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplChiFvcSvL(gt2,i1,i3)
coup2R = cplChiFvcSvR(gt2,i1,i3)
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


! {hh, conj[Hpm], Chi}
Do i1=1,2
  Do i2=1,2
    Do i3=1,4
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2L = cplChiChihhL(gt2,i3,i1)
coup2R = cplChiChihhR(gt2,i3,i1)
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


! {hh, conj[VWm], Chi}
Do i1=1,2
    Do i3=1,4
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MChi(i3) 
coup1 = -cplhhcHpmVWm(i1,gt1)
coup2L = cplChiChihhL(gt2,i3,i1)
coup2R = cplChiChihhR(gt2,i3,i1)
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


! {Hpm, Ah, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MCha(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
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


! {Hpm, hh, Cha}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MCha(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
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


! {Hpm, VP, Cha}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
coup3L = cplcChaChaVPL(i3,gt3)
coup3R = cplcChaChaVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VZ, Cha}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MCha(i3) 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
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


! {Sd, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
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


! {Se, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2L = cplChiFecSeL(gt2,i3,i1)
coup2R = cplChiFecSeR(gt2,i3,i1)
coup3L = cplcFeChaSvL(i3,gt3,i2)
coup3R = cplcFeChaSvR(i3,gt3,i2)
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


! {VWm, Ah, Cha}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MCha(i3) 
coup1 = -cplAhcHpmVWm(i2,gt1)
coup2L = cplChiChacVWmL(gt2,i3)
coup2R = cplChiChacVWmR(gt2,i3)
coup3L = cplcChaChaAhL(i3,gt3,i2)
coup3R = cplcChaChaAhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Cha}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MCha(i3) 
coup1 = -cplhhcHpmVWm(i2,gt1)
coup2L = cplChiChacVWmL(gt2,i3)
coup2R = cplChiChacVWmR(gt2,i3)
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


! {VWm, VP, Cha}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplChiChacVWmL(gt2,i3)
coup2R = cplChiChacVWmR(gt2,i3)
coup3L = cplcChaChaVPL(i3,gt3)
coup3R = cplcChaChaVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Cha}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = MCha(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2L = cplChiChacVWmL(gt2,i3)
coup2R = cplChiChacVWmR(gt2,i3)
coup3L = cplcChaChaVZL(i3,gt3)
coup3R = cplcChaChaVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], Chi}
  Do i2=1,2
    Do i3=1,4
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = -cplHpmcHpmVZ(i2,gt1)
coup2L = cplChiChiVZL(gt2,i3)
coup2R = cplChiChiVZR(gt2,i3)
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


! {VZ, conj[VWm], Chi}
    Do i3=1,4
ML1 = MVZ 
ML2 = MVWm 
ML3 = MChi(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2L = cplChiChiVZL(gt2,i3)
coup2R = cplChiChiVZR(gt2,i3)
coup3L = cplChiChacVWmL(i3,gt3)
coup3R = cplChiChacVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {bar[Fu], bar[Fd], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplChiFucSuL(gt2,i1,i3)
coup2R = cplChiFucSuR(gt2,i1,i3)
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


! {conj[Su], conj[Sd], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2L = cplcFuChiSuL(i3,gt2,i1)
coup2R = cplcFuChiSuR(i3,gt2,i1)
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


! {conj[Sv], conj[Se], Fv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2L = cplChiFvSvL(gt2,i3,i1)
coup2R = cplChiFvSvR(gt2,i3,i1)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToChiCha


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha(MAh,MCha,MChi,MFd,              & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,       & 
& cplChiChiAhL,cplChiChiAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,     & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,cplcFuFdcHpmR,   & 
& cplFvFecHpmL,cplFvFecHpmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,         & 
& cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),    & 
& cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),     & 
& cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),       & 
& cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),     & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),           & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),           & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),     & 
& cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),             & 
& cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2)

Complex(dp), Intent(out) :: Amp(2,2,4,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,4
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MCha(gt3) 


! {Hpm, VP, Cha}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2L = cplChiChacHpmL(gt2,i3,i1)
coup2R = cplChiChacHpmR(gt2,i3,i1)
coup3L = cplcChaChaVPL(i3,gt3)
coup3R = cplcChaChaVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VWm, VP, Cha}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplChiChacVWmL(gt2,i3)
coup2R = cplChiChacVWmR(gt2,i3)
coup3L = cplcChaChaVPL(i3,gt3)
coup3R = cplcChaChaVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiCha


Subroutine Amplitude_Tree_MSSMTriLnV_HpmTocFuFd(cplcFuFdcHpmL,cplcFuFdcHpmR,          & 
& MFd,MFu,MHpm,MFd2,MFu2,MHpm2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MHpm(2),MFd2(3),MFu2(3),MHpm2(2)

Complex(dp), Intent(in) :: cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2)

Complex(dp) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFdcHpmL(gt2,gt3,gt1)
coupT1R = cplcFuFdcHpmR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmTocFuFd


Subroutine Gamma_Real_MSSMTriLnV_HpmTocFuFd(MLambda,em,gs,cplcFuFdcHpmL,              & 
& cplcFuFdcHpmR,MFd,MFu,MHpm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2)

Real(dp), Intent(in) :: MFd(3),MFu(3),MHpm(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,3,3), GammarealGluon(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFuFdcHpmL(i2,i3,i1)
CoupR = cplcFuFdcHpmR(i2,i3,i1)
Mex1 = MHpm(i1)
Mex2 = MFu(i2)
Mex3 = MFd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,3._dp,2._dp,1._dp,4._dp/3._dp,2._dp/3._dp,1._dp/3._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,0._dp,0._dp,0._dp,4._dp,-4._dp,4._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmTocFuFd


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocFuFd(cplcFuFdcHpmL,cplcFuFdcHpmR,          & 
& ctcplcFuFdcHpmL,ctcplcFuFdcHpmR,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,ZfFDL,ZfFDR,              & 
& ZfFUL,ZfFUR,ZfHpm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MFu(3),MFu2(3),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFuFdcHpmL(3,3,2),ctcplcFuFdcHpmR(3,3,2)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfHpm(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFdcHpmL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFuFdcHpmR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplcFuFdcHpmL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplcFuFdcHpmR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt2)*cplcFuFdcHpmL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt2))*cplcFuFdcHpmR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplcFuFdcHpmL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplcFuFdcHpmR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocFuFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocFuFd(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,          & 
& cplChiChacHpmR,cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,      & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,cplcFuFuhhL,        & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,          & 
& cplHpmcHpmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,       & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),     & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),  & 
& cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFuFdcHpmL(3,3,2),       & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFuFuhhL(3,3,2),         & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhHpmcHpm(2,2,2),& 
& cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplcChacFuSdL(2,3,6),            & 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),      & 
& cplSecHpmcSv(6,2,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2)

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
Mex1 = MHpm(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 


! {Ah, conj[Hpm], Fu}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2L = cplcFuFuAhL(gt2,i3,i1)
coup2R = cplcFuFuAhR(gt2,i3,i1)
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


! {Ah, conj[VWm], Fu}
Do i1=1,2
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = -cplAhcHpmVWm(i1,gt1)
coup2L = cplcFuFuAhL(gt2,i3,i1)
coup2R = cplcFuFuAhR(gt2,i3,i1)
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


! {Cha, Chi, Sd}
Do i1=1,2
  Do i2=1,4
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i1,gt2,i3)
coup2R = cplcChacFuSdR(i1,gt2,i3)
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


! {Chi, bar[Cha], Su}
Do i1=1,4
  Do i2=1,2
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MSu(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplcFuChiSuL(gt2,i1,i3)
coup2R = cplcFuChiSuR(gt2,i1,i3)
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


! {Fe, Fv, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSd(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i1,gt2,i3)
coup2R = cplcFecFuSdR(i1,gt2,i3)
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


! {hh, conj[Hpm], Fu}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2L = cplcFuFuhhL(gt2,i3,i1)
coup2R = cplcFuFuhhR(gt2,i3,i1)
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


! {hh, conj[VWm], Fu}
Do i1=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = -cplhhcHpmVWm(i1,gt1)
coup2L = cplcFuFuhhL(gt2,i3,i1)
coup2R = cplcFuFuhhR(gt2,i3,i1)
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


! {Hpm, Ah, Fd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
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


! {Hpm, hh, Fd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
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


! {Hpm, VP, Fd}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {Hpm, VZ, Fd}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
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


! {Se, Sv, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
coup3L = cplcFdFdSvL(i3,gt3,i2)
coup3R = cplcFdFdSvR(i3,gt3,i2)
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


! {VP, conj[Hpm], Fu}
  Do i2=1,2
    Do i3=1,3
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = -cplHpmcHpmVP(i2,gt1)
coup2L = cplcFuFuVPL(gt2,i3)
coup2R = cplcFuFuVPR(gt2,i3)
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


! {VP, conj[VWm], Fu}
    Do i3=1,3
ML1 = MVP 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplcFuFuVPL(gt2,i3)
coup2R = cplcFuFuVPR(gt2,i3)
coup3L = cplcFuFdcVWmL(i3,gt3)
coup3R = cplcFuFdcVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VWm, Ah, Fd}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = -cplAhcHpmVWm(i2,gt1)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
coup3L = cplcFdFdAhL(i3,gt3,i2)
coup3R = cplcFdFdAhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {VWm, hh, Fd}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = -cplhhcHpmVWm(i2,gt1)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
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


! {VWm, VP, Fd}
    Do i3=1,3
ML1 = MVWm 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VWm, VZ, Fd}
    Do i3=1,3
ML1 = MVWm 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
coup3L = cplcFdFdVZL(i3,gt3)
coup3R = cplcFdFdVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VZ, conj[Hpm], Fu}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = -cplHpmcHpmVZ(i2,gt1)
coup2L = cplcFuFuVZL(gt2,i3)
coup2R = cplcFuFuVZR(gt2,i3)
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


! {VZ, conj[VWm], Fu}
    Do i3=1,3
ML1 = MVZ 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2L = cplcFuFuVZL(gt2,i3)
coup2R = cplcFuFuVZR(gt2,i3)
coup3L = cplcFuFdcVWmL(i3,gt3)
coup3R = cplcFuFdcVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {bar[Fu], bar[Fd], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuAhL(gt2,i1,i3)
coup2R = cplcFuFuAhR(gt2,i1,i3)
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


! {bar[Fu], bar[Fd], hh}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuhhL(gt2,i1,i3)
coup2R = cplcFuFuhhR(gt2,i1,i3)
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


! {bar[Fu], bar[Fd], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVGL(gt2,i1)
coup2R = cplcFuFuVGR(gt2,i1)
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


! {bar[Fu], bar[Fd], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVPL(gt2,i1)
coup2R = cplcFuFuVPR(gt2,i1)
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


! {bar[Fu], bar[Fd], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MVZ 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVZL(gt2,i1)
coup2R = cplcFuFuVZR(gt2,i1)
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


! {conj[Su], conj[Sd], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2L = cplcFuChiSuL(gt2,i3,i1)
coup2R = cplcFuChiSuR(gt2,i3,i1)
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


! {conj[Su], conj[Sd], Glu}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MGlu 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2L = cplcFuGluSuL(gt2,i1)
coup2R = cplcFuGluSuR(gt2,i1)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocFuFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcHpm,cplAhcHpmVWm,             & 
& cplChiChacHpmL,cplChiChacHpmR,cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcHpm,cplhhcHpmVWm,           & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplSdcHpmcSu,cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),     & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),  & 
& cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFuFdcHpmL(3,3,2),       & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFuFuhhL(3,3,2),         & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhHpmcHpm(2,2,2),& 
& cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplcChacFuSdL(2,3,6),            & 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),      & 
& cplSecHpmcSv(6,2,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2)

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
Mex1 = MHpm(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 


! {Hpm, VP, Fd}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {VP, conj[Hpm], Fu}
  Do i2=1,2
    Do i3=1,3
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = -cplHpmcHpmVP(i2,gt1)
coup2L = cplcFuFuVPL(gt2,i3)
coup2R = cplcFuFuVPR(gt2,i3)
coup3L = cplcFuFdcHpmL(i3,gt3,i2)
coup3R = cplcFuFdcHpmR(i3,gt3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {VP, conj[VWm], Fu}
    Do i3=1,3
ML1 = MVP 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplcFuFuVPL(gt2,i3)
coup2R = cplcFuFuVPR(gt2,i3)
coup3L = cplcFuFdcVWmL(i3,gt3)
coup3R = cplcFuFdcVWmR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VWm, VP, Fd}
    Do i3=1,3
ML1 = MVWm 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {bar[Fu], bar[Fd], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVGL(gt2,i1)
coup2R = cplcFuFuVGR(gt2,i1)
coup3L = cplcFdFdVGL(i2,gt3)
coup3R = cplcFdFdVGR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {bar[Fu], bar[Fd], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVPL(gt2,i1)
coup2R = cplcFuFuVPR(gt2,i1)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocFuFd


Subroutine Amplitude_Tree_MSSMTriLnV_HpmToFvFe(cplFvFecHpmL,cplFvFecHpmR,             & 
& MFe,MHpm,MFe2,MHpm2,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MHpm(2),MFe2(3),MHpm2(2)

Complex(dp), Intent(in) :: cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2)

Complex(dp) :: Amp(2,2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 
! Tree-Level Vertex 
coupT1L = cplFvFecHpmL(gt2,gt3,gt1)
coupT1R = cplFvFecHpmR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToFvFe


Subroutine Gamma_Real_MSSMTriLnV_HpmToFvFe(MLambda,em,gs,cplFvFecHpmL,cplFvFecHpmR,   & 
& MFe,MHpm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2)

Real(dp), Intent(in) :: MFe(3),MHpm(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,3,3), GammarealGluon(2,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=2,2
  Do i2=1,3
    Do i3=1,3
CoupL = cplFvFecHpmL(i2,i3,i1)
CoupR = cplFvFecHpmR(i2,i3,i1)
Mex1 = MHpm(i1)
Mex2 = 0.
Mex3 = MFe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp,0._dp,1._dp,0._dp,0._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToFvFe


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToFvFe(cplFvFecHpmL,cplFvFecHpmR,             & 
& ctcplFvFecHpmL,ctcplFvFecHpmR,MFe,MFe2,MHpm,MHpm2,ZfFEL,ZfFER,ZfFvL,ZfHpm,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFe2(3),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2)

Complex(dp), Intent(in) :: ctcplFvFecHpmL(3,3,2),ctcplFvFecHpmR(3,3,2)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfFvL(3,3),ZfHpm(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplFvFecHpmL(gt2,gt3,gt1) 
ZcoupT1R = ctcplFvFecHpmR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplFvFecHpmL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplFvFecHpmR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFvL(i1,gt2)*cplFvFecHpmL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFvL(i1,gt2))*cplFvFecHpmR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt3)*cplFvFecHpmL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt3))*cplFvFecHpmR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToFvFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToFvFe(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,   & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,      & 
& cplChiFvSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,           & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,             & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),          & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),   & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),           & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),             & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),              & 
& cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),         & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),             & 
& cplHpmcHpmVZ(2,2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplcHpmVPVWm(2),             & 
& cplcHpmVWmVZ(2)

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
Mex1 = MHpm(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 


! {Cha, Chi, Se}
Do i1=1,2
  Do i2=1,4
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MSe(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i1,gt2,i3)
coup2R = cplcChaFvSeR(i1,gt2,i3)
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


! {Chi, bar[Cha], Sv}
Do i1=1,4
  Do i2=1,2
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MSv(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,gt2,i3)
coup2R = cplChiFvSvR(i1,gt2,i3)
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


! {Fd, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
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


! {Fe, Fv, Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MHpm(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,gt2,i3)
coup2R = cplcFeFvHpmR(i1,gt2,i3)
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


! {Fe, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
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


! {Fe, Fv, VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MVWm 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = -cplcFeFvVWmR(i1,gt2)
coup2R = -cplcFeFvVWmL(i1,gt2)
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


! {Fv, bar[Fe], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MVZ 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplFvFvVZL(gt2,i1)
coup2R = cplFvFvVZR(gt2,i1)
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


! {Hpm, Ah, Fe}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MFe(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
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


! {Hpm, hh, Fe}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
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


! {Hpm, VP, Fe}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
coup3L = cplcFeFeVPL(i3,gt3)
coup3R = cplcFeFeVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VZ, Fe}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
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


! {Sd, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
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


! {Se, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeFeSvL(i3,gt3,i2)
coup3R = cplcFeFeSvR(i3,gt3,i2)
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


! {VWm, Ah, Fe}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MFe(i3) 
coup1 = -cplAhcHpmVWm(i2,gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
coup3L = cplcFeFeAhL(i3,gt3,i2)
coup3R = cplcFeFeAhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Fe}
  Do i2=1,2
    Do i3=1,3
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = -cplhhcHpmVWm(i2,gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
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


! {VWm, VP, Fe}
    Do i3=1,3
ML1 = MVWm 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
coup3L = cplcFeFeVPL(i3,gt3)
coup3R = cplcFeFeVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Fe}
    Do i3=1,3
ML1 = MVWm 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
coup3L = cplcFeFeVZL(i3,gt3)
coup3R = cplcFeFeVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], Fv}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = 0. 
coup1 = -cplHpmcHpmVZ(i2,gt1)
coup2L = cplFvFvVZL(gt2,i3)
coup2R = cplFvFvVZR(gt2,i3)
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


! {VZ, conj[VWm], Fv}
    Do i3=1,3
ML1 = MVZ 
ML2 = MVWm 
ML3 = 0. 
coup1 = cplcHpmVWmVZ(gt1)
coup2L = cplFvFvVZL(gt2,i3)
coup2R = cplFvFvVZR(gt2,i3)
coup3L = cplFvFecVWmL(i3,gt3)
coup3R = cplFvFecVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {conj[Sv], conj[Se], Chi}
Do i1=1,3
  Do i2=1,6
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2L = cplChiFvSvL(i3,gt2,i1)
coup2R = cplChiFvSvR(i3,gt2,i1)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToFvFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhHpmcHpm,   & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,      & 
& cplChiFvSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,           & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,             & 
& cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhHpmcHpm,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,         & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),          & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),   & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),           & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),             & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),& 
& cplcChaFecSvR(2,3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),              & 
& cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),         & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplHpmcHpmVP(2,2),             & 
& cplHpmcHpmVZ(2,2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplcHpmVPVWm(2),             & 
& cplcHpmVWmVZ(2)

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
Mex1 = MHpm(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 


! {Hpm, VP, Fe}
Do i1=1,2
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
coup3L = cplcFeFeVPL(i3,gt3)
coup3R = cplcFeFeVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VWm, VP, Fe}
    Do i3=1,3
ML1 = MVWm 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
coup3L = cplcFeFeVPL(i3,gt3)
coup3R = cplcFeFeVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_VVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToFvFe


Subroutine Amplitude_Tree_MSSMTriLnV_HpmToHpmhh(cplhhHpmcHpm,Mhh,MHpm,Mhh2,           & 
& MHpm2,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),MHpm(2),Mhh2(2),MHpm2(2)

Complex(dp), Intent(in) :: cplhhHpmcHpm(2,2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = Mhh(gt3) 
! Tree-Level Vertex 
coupT1 = cplhhHpmcHpm(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToHpmhh


Subroutine Gamma_Real_MSSMTriLnV_HpmToHpmhh(MLambda,em,gs,cplhhHpmcHpm,               & 
& Mhh,MHpm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplhhHpmcHpm(2,2,2)

Real(dp), Intent(in) :: Mhh(2),MHpm(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2,2), GammarealGluon(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=2,2
    Do i3=1,2
Coup = cplhhHpmcHpm(i3,i2,i1)
Mex1 = MHpm(i1)
Mex2 = MHpm(i2)
Mex3 = Mhh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp,1._dp,0._dp,1._dp,0._dp,0._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToHpmhh


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmhh(cplhhHpmcHpm,ctcplhhHpmcHpm,          & 
& Mhh,Mhh2,MHpm,MHpm2,Zfhh,ZfHpm,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: cplhhHpmcHpm(2,2,2)

Complex(dp), Intent(in) :: ctcplhhHpmcHpm(2,2,2)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfHpm(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = Mhh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplhhHpmcHpm(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplhhHpmcHpm(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt2)*cplhhHpmcHpm(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt3)*cplhhHpmcHpm(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmhh(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,       & 
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
& cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhcHpmVWm(2,2),& 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2), & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgWmgWmhh(2),cplcgZgWmcHpm(2),              & 
& cplcgWpCgWpChh(2),cplcgZgWpCHpm(2),cplcgZgZhh(2),cplcgWmgZHpm(2),cplcgWpCgZcHpm(2),    & 
& cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),  & 
& cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),& 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplAhAhHpmcHpm1(2,2,2,2),cplAhhhHpmcHpm1(2,2,2,2),     & 
& cplhhhhHpmcHpm1(2,2,2,2),cplhhHpmSucSdaa(2,2,6,6),cplhhHpmSvcSe1(2,2,3,6),             & 
& cplhhHpmcVWmVP1(2,2),cplhhHpmcVWmVZ1(2,2),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSecHpmcSv1(2,6,2,3),& 
& cplhhcHpmVPVWm1(2,2),cplhhcHpmVWmVZ1(2,2),cplHpmHpmcHpmcHpm1(2,2,2,2),cplHpmSdcHpmcSdaa(2,6,2,6),& 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSvcHpmcSv1(2,3,2,3),        & 
& cplHpmcHpmcVWmVWm1(2,2),cplHpmcHpmVZVZ1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = Mhh(gt3) 


! {Ah, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
coup3 = cplhhHpmcHpm(gt3,i3,i2)
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


! {Ah, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
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


! {Ah, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhHpmcVWm(i1,gt2)
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


! {Ah, conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcVWm(i1,gt2)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Cha, Chi, Chi}
Do i1=1,2
  Do i2=1,4
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,i3,gt2)
coup2R = cplcChaChiHpmR(i1,i3,gt2)
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


! {Chi, bar[Cha], bar[Cha]}
Do i1=1,4
  Do i2=1,2
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(i3,i1,gt2)
coup2R = cplcChaChiHpmR(i3,i1,gt2)
coup3L = cplcChaChahhL(i2,i3,gt3)
coup3R = cplcChaChahhR(i2,i3,gt3)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = cplcFuFuhhL(i3,i2,gt3)
coup3R = cplcFuFuhhR(i3,i2,gt3)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
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


! {gWm, gZ, gZ}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgZHpm(gt2)
coup3 = cplcgZgZhh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {gZ, gWmC, gWmC}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgWpCHpm(gt2)
coup3 = cplcgWpCgWpChh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
coup3 = cplhhHpmcHpm(gt3,i3,i2)
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


! {hh, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
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


! {hh, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhHpmcVWm(i1,gt2)
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


! {hh, conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhHpmcVWm(i1,gt2)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Ah, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplAhHpmcHpm(i3,gt2,i1)
coup3 = cplAhAhhh(i3,i2,gt3)
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


! {Hpm, VZ, Ah}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MAh(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplAhHpmcHpm(i3,gt2,i1)
coup3 = -cplAhhhVZ(i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, hh, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, Ah, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MVZ 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = -cplHpmcHpmVZ(gt2,i1)
coup3 = -cplAhhhVZ(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VZ, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = -cplHpmcHpmVZ(gt2,i1)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = cplhhSucSu(gt3,i2,i3)
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


! {Se, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplHpmSvcSe(gt2,i3,i1)
coup3 = cplhhSvcSv(gt3,i2,i3)
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


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
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


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
coup3 = cplhhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplhhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm], conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VWm, Ah, Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplAhHpmcVWm(i3,gt2)
coup3 = cplAhAhhh(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VZ, Ah}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = MAh(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplAhHpmcVWm(i3,gt2)
coup3 = -cplAhhhVZ(i3,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, hh, hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplhhHpmcVWm(i3,gt2)
coup3 = cplhhhhhh(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, Ah, VZ}
  Do i2=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MVZ 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = -cplAhhhVZ(i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VWm, VZ, VZ}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VZ, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = -cplHpmcHpmVZ(gt2,i3)
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


! {VZ, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVZ 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = -cplHpmcHpmVZ(gt2,i3)
coup3 = cplhhHpmcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplhhcHpmVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[VWm], conj[VWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
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


! {bar[gWmC], bar[gZ], bar[gZ]}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgWpCHpm(gt2)
coup3 = cplcgZgZhh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {bar[gZ], bar[gWm], bar[gWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgZHpm(gt2)
coup3 = cplcgWmgWmhh(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplHpmSvcSe(gt2,i1,i3)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhhhHpmcHpm1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhhhHpmcHpm1(gt3,i1,gt2,i2)
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
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplhhHpmSucSdaa(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplhhHpmSvcSe1(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplhhHpmcVWmVP1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplhhHpmcVWmVZ1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhhhHpmcHpm1(i1,gt3,i2,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplhhhhHpmcHpm1(gt3,i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplhhSdcHpmcSuaa(gt3,i1,gt1,i2)
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
coup1 = cplhhSecHpmcSv1(gt3,i1,gt1,i2)
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


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplhhcHpmVPVWm1(gt3,gt1)
coup2 = cplHpmcVWmVP(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplhhcHpmVWmVZ1(gt3,gt1)
coup2 = cplHpmcVWmVZ(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {Ah, Ah}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MAh(i2) 
coup1 = cplAhAhHpmcHpm1(i1,i2,gt2,gt1)
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
coup1 = cplhhhhHpmcHpm1(i1,i2,gt2,gt1)
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
coup1 = cplHpmHpmcHpmcHpm1(gt2,i1,gt1,i2)
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
coup1 = cplHpmSdcHpmcSdaa(gt2,i1,gt1,i2)
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
coup1 = cplHpmSecHpmcSe1(gt2,i1,gt1,i2)
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
coup1 = cplHpmSucHpmcSuaa(gt2,i1,gt1,i2)
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
coup1 = cplHpmSvcHpmcSv1(gt2,i1,gt1,i2)
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
coup1 = cplHpmcHpmcVWmVWm1(gt2,gt1)
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
coup1 = cplHpmcHpmVZVZ1(gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,               & 
& cplAhHpmcHpm,cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,    & 
& cplcChaChahhR,cplChiChihhL,cplChiChihhR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdhhL,     & 
& cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,         & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgZgWpCHpm,cplcgZgZhh,       & 
& cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,            & 
& cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSucSd,      & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcHpmcSu,          & 
& cplSecHpmcSv,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhAhHpmcHpm1,cplAhhhHpmcHpm1,cplhhhhHpmcHpm1,& 
& cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhHpmcVWmVP1,cplhhHpmcVWmVZ1,cplhhSdcHpmcSuaa,       & 
& cplhhSecHpmcSv1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmHpmcHpmcHpm1,cplHpmSdcHpmcSdaa,  & 
& cplHpmSecHpmcSe1,cplHpmSucHpmcSuaa,cplHpmSvcHpmcSv1,cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhcHpmVWm(2,2),& 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2), & 
& cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgWmgWmhh(2),cplcgZgWmcHpm(2),              & 
& cplcgWpCgWpChh(2),cplcgZgWpCHpm(2),cplcgZgZhh(2),cplcgWmgZHpm(2),cplcgWpCgZcHpm(2),    & 
& cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),  & 
& cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),& 
& cplcHpmVPVWm(2),cplcHpmVWmVZ(2),cplAhAhHpmcHpm1(2,2,2,2),cplAhhhHpmcHpm1(2,2,2,2),     & 
& cplhhhhHpmcHpm1(2,2,2,2),cplhhHpmSucSdaa(2,2,6,6),cplhhHpmSvcSe1(2,2,3,6),             & 
& cplhhHpmcVWmVP1(2,2),cplhhHpmcVWmVZ1(2,2),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSecHpmcSv1(2,6,2,3),& 
& cplhhcHpmVPVWm1(2,2),cplhhcHpmVWmVZ1(2,2),cplHpmHpmcHpmcHpm1(2,2,2,2),cplHpmSdcHpmcSdaa(2,6,2,6),& 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSvcHpmcSv1(2,3,2,3),        & 
& cplHpmcHpmcVWmVWm1(2,2),cplHpmcHpmVZVZ1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = Mhh(gt3) 


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
coup3 = cplhhHpmcHpm(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = -cplHpmcHpmVP(gt2,i3)
coup3 = cplhhHpmcVWm(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplhhcHpmVWm(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm], conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplhhcVWmVWm(gt3)
Call Amp_VERTEX_StoSS_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplhhHpmcVWmVP1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplhhcHpmVPVWm1(gt3,gt1)
coup2 = cplHpmcVWmVP(gt2)
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmhh


Subroutine Amplitude_Tree_MSSMTriLnV_HpmTohhVWm(cplhhcHpmVWm,Mhh,MHpm,MVWm,           & 
& Mhh2,MHpm2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),MHpm(2),MVWm,Mhh2(2),MHpm2(2),MVWm2

Complex(dp), Intent(in) :: cplhhcHpmVWm(2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = -cplhhcHpmVWm(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmTohhVWm


Subroutine Gamma_Real_MSSMTriLnV_HpmTohhVWm(MLambda,em,gs,cplhhcHpmVWm,               & 
& Mhh,MHpm,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplhhcHpmVWm(2,2)

Real(dp), Intent(in) :: Mhh(2),MHpm(2),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2), GammarealGluon(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,2
Coup = cplhhcHpmVWm(i2,i1)
Mex1 = MHpm(i1)
Mex2 = Mhh(i2)
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,-1._dp,0._dp,-1._dp,Coup,Gammarealphoton(i1,i2),kont)
 GammarealGluon(i1,i2) = 0._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmTohhVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTohhVWm(cplhhcHpmVWm,ctcplhhcHpmVWm,          & 
& Mhh,Mhh2,MHpm,MHpm2,MVWm,MVWm2,Zfhh,ZfHpm,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MVWm,MVWm2

Complex(dp), Intent(in) :: cplhhcHpmVWm(2,2)

Complex(dp), Intent(in) :: ctcplhhcHpmVWm(2,2)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfHpm(2,2),ZfVWm

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
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplhhcHpmVWm(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplhhcHpmVWm(gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt2)*cplhhcHpmVWm(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplhhcHpmVWm(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTohhVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTohhVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhHpmcHpm,       & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,   & 
& cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgZgAhh,            & 
& cplcgWpCgAcHpm,cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,cplcgZgWpCVWm,  & 
& cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,            & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,       & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,           & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhhhcVWmVWm1,   & 
& cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),& 
& cplChiChacHpmR(4,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),   & 
& cplChiChihhR(4,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFdFdhhL(3,3,2),        & 
& cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),      & 
& cplFvFecHpmR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),          & 
& cplcFuFuhhR(3,3,2),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),              & 
& cplcFeFvVWmR(3,3),cplcgZgAhh(2),cplcgWpCgAcHpm(2),cplcgWmgWmhh(2),cplcgZgWmcHpm(2),    & 
& cplcgWpCgWpChh(2),cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh(2),cplcgWmgZVWm,              & 
& cplcgWpCgZcHpm(2),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),    & 
& cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),             & 
& cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhcHpmVWmVZ1(2,2),        & 
& cplhhhhcVWmVWm1(2,2),cplhhcHpmVPVWm1(2,2),cplhhcHpmVWmVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVWm 


! {Ah, conj[Hpm], Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhAhhh(i1,i3,gt2)
coup3 = cplAhcHpmVWm(i3,i2)
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


! {Ah, conj[Hpm], VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = -cplAhhhVZ(i1,gt2)
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


! {Ah, conj[VWm], VZ}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = -cplAhhhVZ(i1,gt2)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Cha, Chi, Cha}
Do i1=1,2
  Do i2=1,4
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaChahhL(i1,i3,gt2)
coup2R = cplcChaChahhR(i1,i3,gt2)
coup3L = -cplcChaChiVWmR(i3,i2)
coup3R = -cplcChaChiVWmL(i3,i2)
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


! {Chi, bar[Cha], Chi}
Do i1=1,4
  Do i2=1,2
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiChihhL(i1,i3,gt2)
coup2R = cplChiChihhR(i1,i3,gt2)
coup3L = cplcChaChiVWmL(i2,i3)
coup3R = cplcChaChiVWmR(i2,i3)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
coup3L = -cplcFdFuVWmR(i3,i2)
coup3R = -cplcFdFuVWmL(i3,i2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
coup3L = -cplcFeFvVWmR(i3,i2)
coup3R = -cplcFeFvVWmL(i3,i2)
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


! {gWm, gZ, gWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgWmhh(gt2)
coup3 = cplcgWmgZVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {gZ, gWmC, gP}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgAhh(gt2)
coup3 = cplcgAgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {gZ, gWmC, gZ}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgZhh(gt2)
coup3 = cplcgZgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhhhhh(gt2,i1,i3)
coup3 = cplhhcHpmVWm(i3,i2)
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


! {hh, conj[VWm], hh}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhhhhh(gt2,i1,i3)
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


! {Hpm, Ah, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = -cplAhcHpmVWm(i2,i3)
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


! {Hpm, hh, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = -cplhhcHpmVWm(i2,i3)
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


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
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


! {Hpm, VZ, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
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


! {Hpm, hh, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplhhcHpmVWm(gt2,i1)
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


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplhhcHpmVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplhhcHpmVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
coup3 = -cplSucSdVWm(i2,i3)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = -cplSvcSeVWm(i2,i3)
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


! {VWm, Ah, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = -cplAhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = -cplhhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, hh, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VWm, VP, VWm}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplhhcVWmVWm(gt2)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {VWm, VZ, VWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplhhcVWmVWm(gt2)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {VZ, conj[Hpm], Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = -cplAhhhVZ(i3,gt2)
coup3 = cplAhcHpmVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Hpm], VZ}
  Do i2=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplhhVZVZ(gt2)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[VWm], VZ}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplhhVZVZ(gt2)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuhhL(i3,i1,gt2)
coup2R = cplcFuFuhhR(i3,i1,gt2)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
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


! {bar[gWmC], bar[gP], bar[gWmC]}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcgWpCgAcHpm(gt1)
coup2 = cplcgWpCgWpChh(gt2)
coup3 = cplcgAgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {bar[gWmC], bar[gZ], bar[gWmC]}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgWpCgWpChh(gt2)
coup3 = cplcgZgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {bar[gZ], bar[gWm], bar[gZ]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgZgZhh(gt2)
coup3 = cplcgWmgZVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplhhSucSu(gt2,i1,i3)
coup3 = cplSucSdVWm(i3,i2)
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


! {conj[Sv], conj[Se], conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplhhSvcSv(gt2,i1,i3)
coup3 = cplSvcSeVWm(i3,i2)
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


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = -cplhhcHpmVWm(i1,gt1)
coup2 = cplhhhhcVWmVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplhhcHpmVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2 = cplhhcHpmVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Ah, VZ}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVZ 
coup1 = cplAhcHpmVWmVZ1(i1,gt1)
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
coup1 = cplHpmcHpmcVWmVWm1(i1,gt1)
coup2 = cplhhcHpmVWm(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTohhVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,               & 
& cplAhHpmcHpm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChahhL,cplcChaChahhR,   & 
& cplChiChihhL,cplChiChihhR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdhhL,cplcFdFdhhR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplcgZgAhh,cplcgWpCgAcHpm,cplcgWmgWmhh,cplcgZgWmcHpm,cplcgWpCgWpChh,cplcgAgWpCVWm,     & 
& cplcgZgWpCVWm,cplcgZgZhh,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhhhhh,cplhhHpmcHpm,           & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdcHpmcSu,cplSecHpmcSv,cplSucSdVWm,             & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,       & 
& cplhhhhcVWmVWm1,cplhhcHpmVPVWm1,cplhhcHpmVWmVZ1,cplHpmcHpmcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),& 
& cplChiChacHpmR(4,2,2),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),   & 
& cplChiChihhR(4,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFdFdhhL(3,3,2),        & 
& cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),      & 
& cplFvFecHpmR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),          & 
& cplcFuFuhhR(3,3,2),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),              & 
& cplcFeFvVWmR(3,3),cplcgZgAhh(2),cplcgWpCgAcHpm(2),cplcgWmgWmhh(2),cplcgZgWmcHpm(2),    & 
& cplcgWpCgWpChh(2),cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgZgZhh(2),cplcgWmgZVWm,              & 
& cplcgWpCgZcHpm(2),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),    & 
& cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),             & 
& cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhcHpmVWmVZ1(2,2),        & 
& cplhhhhcVWmVWm1(2,2),cplhhcHpmVPVWm1(2,2),cplhhcHpmVWmVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVWm 


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplhhHpmcHpm(gt2,i3,i1)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplhhcHpmVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplhhHpmcVWm(gt2,i3)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VP, VWm}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplhhcVWmVWm(gt2)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplhhcHpmVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhVWm


Subroutine Amplitude_Tree_MSSMTriLnV_HpmToHpmVZ(cplHpmcHpmVZ,MHpm,MVZ,MHpm2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MVZ,MHpm2(2),MVZ2

Complex(dp), Intent(in) :: cplHpmcHpmVZ(2,2)

Complex(dp) :: Amp(2,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1 = -cplHpmcHpmVZ(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToHpmVZ


Subroutine Gamma_Real_MSSMTriLnV_HpmToHpmVZ(MLambda,em,gs,cplHpmcHpmVZ,               & 
& MHpm,MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplHpmcHpmVZ(2,2)

Real(dp), Intent(in) :: MHpm(2),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,2), GammarealGluon(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=2,2
Coup = cplHpmcHpmVZ(i2,i1)
Mex1 = MHpm(i1)
Mex2 = MHpm(i2)
Mex3 = MVZ
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,-1._dp,-1._dp,0._dp,Coup,Gammarealphoton(i1,i2),kont)
 GammarealGluon(i1,i2) = 0._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToHpmVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmVZ(cplHpmcHpmVP,cplHpmcHpmVZ,            & 
& ctcplHpmcHpmVP,ctcplHpmcHpmVZ,MHpm,MHpm2,MVP,MVP2,MVZ,MVZ2,ZfHpm,ZfVPVZ,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2)

Complex(dp), Intent(in) :: ctcplHpmcHpmVP(2,2),ctcplHpmcHpmVZ(2,2)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfVPVZ,ZfVZ

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplHpmcHpmVZ(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplHpmcHpmVZ(gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt2)*cplHpmcHpmVZ(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVPVZ*cplHpmcHpmVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplHpmcHpmVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhHpmcVWm,    & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuHpmL,          & 
& cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvHpmL,               & 
& cplcFeFvHpmR,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,cplcgWmgZHpm,     & 
& cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,cplHpmSucSd,           & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,            & 
& cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhcHpmVWm(2,2),               & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),     & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),       & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),           & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),             & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplcgWmgWmVZ,cplcgZgWmcHpm(2),cplcgZgWpCHpm(2),cplcgWpCgWpCVZ,cplcgWmgZHpm(2),         & 
& cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhcHpmVWm(2,2),             & 
& cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),  & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcHpmcSu(6,2,6),cplSecSeVZ(6,6), & 
& cplSecHpmcSv(6,2,3),cplSucSuVZ(6,6),cplSvcSvVZ(3,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),   & 
& cplcVWmVWmVZ,cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2),cplhhHpmcVWmVZ1(2,2),           & 
& cplhhcHpmVWmVZ1(2,2),cplHpmcHpmVPVZ1(2,2),cplHpmcHpmVZVZ1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVZ 


! {Ah, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
coup3 = cplHpmcHpmVZ(i3,i2)
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


! {Ah, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
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


! {Ah, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = -cplAhHpmcVWm(i1,gt2)
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


! {Ah, conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = -cplAhHpmcVWm(i1,gt2)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Cha, Chi, Chi}
Do i1=1,2
  Do i2=1,4
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,i3,gt2)
coup2R = cplcChaChiHpmR(i1,i3,gt2)
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


! {Chi, bar[Cha], bar[Cha]}
Do i1=1,4
  Do i2=1,2
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(i3,i1,gt2)
coup2R = cplcChaChiHpmR(i3,i1,gt2)
coup3L = cplcChaChaVZL(i2,i3)
coup3R = cplcChaChaVZR(i2,i3)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
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


! {Fe, Fv, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,i3,gt2)
coup2R = cplcFeFvHpmR(i1,i3,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
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


! {gZ, gWmC, gWmC}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgWpCHpm(gt2)
coup3 = cplcgWpCgWpCVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
coup3 = cplHpmcHpmVZ(i3,i2)
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


! {hh, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
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


! {hh, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = -cplhhHpmcVWm(i1,gt2)
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


! {hh, conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = -cplhhHpmcVWm(i1,gt2)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, hh, Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplAhHpmcHpm(i3,gt2,i1)
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


! {Hpm, Ah, hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, VZ, hh}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplhhHpmcHpm(i3,gt2,i1)
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


! {Hpm, hh, VZ}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplHpmcHpmVZ(gt2,i1)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
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


! {Se, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplHpmSvcSe(gt2,i3,i1)
coup3 = -cplSvcSvVZ(i2,i3)
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


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
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


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm], conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {VWm, hh, Ah}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = -cplAhHpmcVWm(i3,gt2)
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


! {VWm, Ah, hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = -cplhhHpmcVWm(i3,gt2)
coup3 = -cplAhhhVZ(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VZ, hh}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = -cplhhHpmcVWm(i3,gt2)
coup3 = cplhhVZVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, hh, VZ}
  Do i2=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplhhVZVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplHpmcHpmVZ(gt2,i3)
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


! {VZ, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVZ 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcHpmVZ(gt2,i3)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplcHpmVWmVZ(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[VWm], conj[VWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
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


! {bar[gZ], bar[gWm], bar[gWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgZHpm(gt2)
coup3 = cplcgWmgWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplSdcSdVZ(i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplHpmSvcSe(gt2,i1,i3)
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


! {Ah, conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
coup1 = -cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcVWmVZ1(i1,gt2)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = -cplhhcHpmVWm(i1,gt1)
coup2 = cplhhHpmcVWmVZ1(i1,gt2)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplHpmcHpmVPVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2 = cplHpmcHpmVZVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Ah, conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
coup1 = cplAhcHpmVWmVZ1(i1,gt1)
coup2 = -cplAhHpmcVWm(i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = cplhhcHpmVWmVZ1(i1,gt1)
coup2 = -cplhhHpmcVWm(i1,gt2)
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
coup1 = cplHpmcHpmVPVZ1(i1,gt1)
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
coup1 = cplHpmcHpmVZVZ1(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhHpmcVWm,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,   & 
& cplChiChiVZL,cplChiChiVZR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdVZL,cplcFdFdVZR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgZgWpCHpm,cplcgWpCgWpCVZ,     & 
& cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,cplhhVZVZ,          & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,cplcHpmVPVWm,    & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhHpmcVWmVZ1,cplAhcHpmVWmVZ1,cplhhHpmcVWmVZ1,             & 
& cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,cplHpmcHpmVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhcHpmVWm(2,2),               & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),     & 
& cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),       & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),           & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),             & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplcgWmgWmVZ,cplcgZgWmcHpm(2),cplcgZgWpCHpm(2),cplcgWpCgWpCVZ,cplcgWmgZHpm(2),         & 
& cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhcHpmVWm(2,2),             & 
& cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),  & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcHpmcSu(6,2,6),cplSecSeVZ(6,6), & 
& cplSecHpmcSv(6,2,3),cplSucSuVZ(6,6),cplSvcSvVZ(3,3),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),   & 
& cplcVWmVWmVZ,cplAhHpmcVWmVZ1(2,2),cplAhcHpmVWmVZ1(2,2),cplhhHpmcVWmVZ1(2,2),           & 
& cplhhcHpmVWmVZ1(2,2),cplHpmcHpmVPVZ1(2,2),cplHpmcHpmVZVZ1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVZ 


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
coup3 = cplHpmcHpmVZ(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
coup3 = cplHpmcVWmVZ(i3)
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplcHpmVWmVZ(i2)
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm], conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplcVWmVWmVZ
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplHpmcHpmVPVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplHpmcHpmVPVZ1(i1,gt1)
coup2 = cplHpmcHpmVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVZ


Subroutine Amplitude_Tree_MSSMTriLnV_HpmTocSuSd(cplSdcHpmcSu,MHpm,MSd,MSu,            & 
& MHpm2,MSd2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MSd(6),MSu(6),MHpm2(2),MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplSdcHpmcSu(6,2,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdcHpmcSu(gt3,gt1,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmTocSuSd


Subroutine Gamma_Real_MSSMTriLnV_HpmTocSuSd(MLambda,em,gs,cplSdcHpmcSu,               & 
& MHpm,MSd,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcHpmcSu(6,2,6)

Real(dp), Intent(in) :: MHpm(2),MSd(6),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,6,6), GammarealGluon(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,6
    Do i3=1,6
Coup = cplSdcHpmcSu(i3,i1,i2)
Mex1 = MHpm(i1)
Mex2 = MSu(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,3._dp,2._dp,1._dp,4._dp/3._dp,2._dp/3._dp,1._dp/3._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,0._dp,0._dp,0._dp,4._dp,-4._dp,4._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmTocSuSd


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocSuSd(cplSdcHpmcSu,ctcplSdcHpmcSu,          & 
& MHpm,MHpm2,MSd,MSd2,MSu,MSu2,ZfHpm,ZfSd,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSd(6),MSd2(6),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplSdcHpmcSu(6,2,6)

Complex(dp), Intent(in) :: ctcplSdcHpmcSu(6,2,6)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSd(6,6),ZfSu(6,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcHpmcSu(gt3,gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplSdcHpmcSu(gt3,i1,gt2)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt2))*cplSdcHpmcSu(gt3,gt1,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdcHpmcSu(i1,gt1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocSuSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocSuSd(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,      & 
& cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplGluFucSuL,       & 
& cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcHpm,           & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,             & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,cplSucSuVP,               & 
& cplSucSuVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,cplHpmSdcHpmcSdaa,& 
& cplHpmSucHpmcSuaa,cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,& 
& cplSdSvcSecSuaa,cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,cplSeSucHpmcSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),            & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),   & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplhhHpmcHpm(2,2,2),cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),             & 
& cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6), & 
& cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplSdcHpmcSu(6,2,6),         & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSecHpmcSv(6,2,3),           & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),       & 
& cplAhSdcHpmcSuaa(2,6,2,6),cplhhSdcHpmcSuaa(2,6,2,6),cplHpmSdcHpmcSdaa(2,6,2,6),        & 
& cplHpmSucHpmcSuaa(2,6,2,6),cplSdSecHpmcSdaa(6,6,2,6),cplSdSucSdcSuabba(6,6,6,6),       & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),cplSdSvcSecSuaa(6,3,6,6),         & 
& cplSdcSucVWmVPaa(6,6),cplSdcSucVWmVZaa(6,6),cplSdcHpmcSucSvaa(6,2,6,3),cplSeSucHpmcSuaa(6,6,2,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 


! {Ah, conj[Hpm], Su}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhSucSu(i1,i3,gt2)
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


! {Ah, conj[VWm], Su}
Do i1=1,2
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MSu(i3) 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhSucSu(i1,i3,gt2)
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


! {Cha, Chi, Fd}
Do i1=1,2
  Do i2=1,4
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaFdcSuL(i1,i3,gt2)
coup2R = cplcChaFdcSuR(i1,i3,gt2)
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


! {Chi, bar[Cha], Fu}
Do i1=1,4
  Do i2=1,2
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MFu(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiFucSuL(i1,i3,gt2)
coup2R = cplChiFucSuR(i1,i3,gt2)
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


! {Fe, Fv, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFd(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFdcSuL(i1,i3,gt2)
coup2R = cplcFeFdcSuR(i1,i3,gt2)
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


! {hh, conj[Hpm], Su}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhSucSu(i1,i3,gt2)
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


! {hh, conj[VWm], Su}
Do i1=1,2
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MSu(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhSucSu(i1,i3,gt2)
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


! {Hpm, Ah, Sd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
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


! {Hpm, hh, Sd}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
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


! {Hpm, VP, Sd}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
coup3 = cplSdcSdVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {Hpm, VZ, Sd}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
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


! {Se, Sv, Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSdcSecSu(i3,i1,gt2)
coup3 = cplSdSvcSd(gt3,i2,i3)
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


! {VP, conj[Hpm], Su}
  Do i2=1,2
    Do i3=1,6
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplSucSuVP(i3,gt2)
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


! {VP, conj[VWm], Su}
    Do i3=1,6
ML1 = MVP 
ML2 = MVWm 
ML3 = MSu(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSucSuVP(i3,gt2)
coup3 = cplSdcSucVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VWm, Ah, Sd}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplSdcSucVWm(i3,gt2)
coup3 = cplAhSdcSd(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {VWm, hh, Sd}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplSdcSucVWm(i3,gt2)
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


! {VWm, VP, Sd}
    Do i3=1,6
ML1 = MVWm 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSdcSucVWm(i3,gt2)
coup3 = cplSdcSdVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VWm, VZ, Sd}
    Do i3=1,6
ML1 = MVWm 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplSdcSucVWm(i3,gt2)
coup3 = cplSdcSdVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VZ, conj[Hpm], Su}
  Do i2=1,2
    Do i3=1,6
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplSucSuVZ(i3,gt2)
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


! {VZ, conj[VWm], Su}
    Do i3=1,6
ML1 = MVZ 
ML2 = MVWm 
ML3 = MSu(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplSucSuVZ(i3,gt2)
coup3 = cplSdcSucVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {bar[Fu], bar[Fd], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplChiFucSuL(i3,i1,gt2)
coup2R = cplChiFucSuR(i3,i1,gt2)
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


! {bar[Fu], bar[Fd], Glu}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MGlu 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplGluFucSuL(i1,gt2)
coup2R = cplGluFucSuR(i1,gt2)
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


! {conj[Su], conj[Sd], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplAhSucSu(i3,i1,gt2)
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


! {conj[Su], conj[Sd], hh}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplhhSucSu(i3,i1,gt2)
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


! {conj[Su], conj[Sd], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVG(i1,gt2)
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


! {conj[Su], conj[Sd], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVP(i1,gt2)
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


! {conj[Su], conj[Sd], VZ}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVZ(i1,gt2)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhSdcHpmcSuaa(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhSdcHpmcSuaa(i1,gt3,i2,gt2)
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
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSdSucSdcSuabba(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(9)*AmpC 
coup2 = cplSdSucSdcSuabab(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSdSvcSecSuaa(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSdcSucVWmVPaa(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 


! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplSdcSucVWmVZaa(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 


! {Ah, Su}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSdcHpmcSuaa(i1,gt3,gt1,i2)
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


! {hh, Su}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSdcHpmcSuaa(i1,gt3,gt1,i2)
coup2 = cplhhSucSu(i1,i2,gt2)
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
coup1 = cplHpmSdcHpmcSdaa(i1,gt3,gt1,i2)
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
coup1 = cplSdSecHpmcSdaa(gt3,i1,gt1,i2)
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


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcHpmcSuaa(i1,i2,gt1,gt2)
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
coup1 = cplhhSdcHpmcSuaa(i1,i2,gt1,gt2)
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
coup1 = cplHpmSucHpmcSuaa(i1,i2,gt1,gt2)
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
coup1 = cplSdcHpmcSucSvaa(i1,gt1,gt2,i2)
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
coup1 = cplSdSvcHpmcSuaa(i1,i2,gt1,gt2)
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
coup1 = cplSeSucHpmcSuaa(i1,i2,gt1,gt2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocSuSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplAhHpmcHpm,cplAhSdcSd,cplAhSucSu,cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,       & 
& cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhHpmcHpm,cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplHpmcHpmVP,cplHpmcHpmVZ,             & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,               & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSecHpmcSv,cplSucSuVG,             & 
& cplSucSuVP,cplSucSuVZ,cplcHpmVPVWm,cplcHpmVWmVZ,cplAhSdcHpmcSuaa,cplhhSdcHpmcSuaa,     & 
& cplHpmSdcHpmcSdaa,cplHpmSucHpmcSuaa,cplSdSecHpmcSdaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,& 
& cplSdSvcHpmcSuaa,cplSdSvcSecSuaa,cplSdcSucVWmVPaa,cplSdcSucVWmVZaa,cplSdcHpmcSucSvaa,  & 
& cplSeSucHpmcSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),            & 
& cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),   & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplhhHpmcHpm(2,2,2),cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),             & 
& cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6), & 
& cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplSdcHpmcSu(6,2,6),         & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSecHpmcSv(6,2,3),           & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplcHpmVPVWm(2),cplcHpmVWmVZ(2),       & 
& cplAhSdcHpmcSuaa(2,6,2,6),cplhhSdcHpmcSuaa(2,6,2,6),cplHpmSdcHpmcSdaa(2,6,2,6),        & 
& cplHpmSucHpmcSuaa(2,6,2,6),cplSdSecHpmcSdaa(6,6,2,6),cplSdSucSdcSuabba(6,6,6,6),       & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),cplSdSvcSecSuaa(6,3,6,6),         & 
& cplSdcSucVWmVPaa(6,6),cplSdcSucVWmVZaa(6,6),cplSdcHpmcSucSvaa(6,2,6,3),cplSeSucHpmcSuaa(6,6,2,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 


! {Hpm, VP, Sd}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {VP, conj[Hpm], Su}
  Do i2=1,2
    Do i3=1,6
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplSucSuVP(i3,gt2)
coup3 = cplSdcHpmcSu(gt3,i2,i3)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {VP, conj[VWm], Su}
    Do i3=1,6
ML1 = MVP 
ML2 = MVWm 
ML3 = MSu(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSucSuVP(i3,gt2)
coup3 = cplSdcSucVWm(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {VWm, VP, Sd}
    Do i3=1,6
ML1 = MVWm 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSdcSucVWm(i3,gt2)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do


! {conj[Su], conj[Sd], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVG(i1,gt2)
coup3 = cplSdcSdVG(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4)*AmpC 
  End Do
End Do


! {conj[Su], conj[Sd], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSdcSucVWmVPaa(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSuSd


Subroutine Amplitude_Tree_MSSMTriLnV_HpmTocSvSe(cplSecHpmcSv,MHpm,MSe,MSv,            & 
& MHpm2,MSe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MSe(6),MSv(3),MHpm2(2),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSecHpmcSv(6,2,3)

Complex(dp) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplSecHpmcSv(gt3,gt1,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmTocSvSe


Subroutine Gamma_Real_MSSMTriLnV_HpmTocSvSe(MLambda,em,gs,cplSecHpmcSv,               & 
& MHpm,MSe,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSecHpmcSv(6,2,3)

Real(dp), Intent(in) :: MHpm(2),MSe(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2,3,6), GammarealGluon(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
  Do i2=1,3
    Do i3=1,6
Coup = cplSecHpmcSv(i3,i1,i2)
Mex1 = MHpm(i1)
Mex2 = MSv(i2)
Mex3 = MSe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp,0._dp,1._dp,0._dp,0._dp,1._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmTocSvSe


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocSvSe(cplSecHpmcSv,ctcplSecHpmcSv,          & 
& MHpm,MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSecHpmcSv(6,2,3)

Complex(dp), Intent(in) :: ctcplSecHpmcSv(6,2,3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSecHpmcSv(gt3,gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplSecHpmcSv(gt3,i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt2))*cplSecHpmcSv(gt3,gt1,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplSecHpmcSv(i1,gt1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocSvSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocSvSe(MAh,MCha,MChi,MFd,MFe,              & 
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

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 


! {Cha, Chi, Fe}
Do i1=1,2
  Do i2=1,4
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaFecSvL(i1,i3,gt2)
coup2R = cplcChaFecSvR(i1,i3,gt2)
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


! {Chi, bar[Cha], Fv}
Do i1=1,4
  Do i2=1,2
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = 0. 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,i3,gt2)
coup2R = cplChiFvcSvR(i1,i3,gt2)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdcSvL(i1,i3,gt2)
coup2R = cplcFdFdcSvR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFecSvL(i1,i3,gt2)
coup2R = cplcFeFecSvR(i1,i3,gt2)
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


! {Fv, bar[Fe], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MChi(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i3,i1,gt2)
coup2R = cplChiFvcSvR(i3,i1,gt2)
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


! {hh, conj[Hpm], Sv}
Do i1=1,2
  Do i2=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MSv(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,i3,gt2)
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


! {hh, conj[VWm], Sv}
Do i1=1,2
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MSv(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhSvcSv(i1,i3,gt2)
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


! {Hpm, Ah, Se}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
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


! {Hpm, hh, Se}
Do i1=1,2
  Do i2=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
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


! {Hpm, VP, Se}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
coup3 = cplSecSeVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VZ, Se}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplHpmcHpmVZ(i1,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSdcSdcSv(i3,i1,gt2)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSecSecSv(i3,i1,gt2)
coup3 = cplSeSvcSe(gt3,i2,i3)
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


! {VWm, Ah, Se}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhcHpmVWm(i2,gt1)
coup2 = cplSecSvcVWm(i3,gt2)
coup3 = cplAhSecSe(i2,gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Se}
  Do i2=1,2
    Do i3=1,6
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhcHpmVWm(i2,gt1)
coup2 = cplSecSvcVWm(i3,gt2)
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


! {VWm, VP, Se}
    Do i3=1,6
ML1 = MVWm 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSecSvcVWm(i3,gt2)
coup3 = cplSecSeVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Se}
    Do i3=1,6
ML1 = MVWm 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplSecSvcVWm(i3,gt2)
coup3 = cplSecSeVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], Sv}
  Do i2=1,2
    Do i3=1,3
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MSv(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplSvcSvVZ(i3,gt2)
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


! {VZ, conj[VWm], Sv}
    Do i3=1,3
ML1 = MVZ 
ML2 = MVWm 
ML3 = MSv(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplSvcSvVZ(i3,gt2)
coup3 = cplSecSvcVWm(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {conj[Sv], conj[Se], hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplhhSvcSv(i3,i1,gt2)
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


! {conj[Sv], conj[Se], VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplSvcSvVZ(i1,gt2)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhSecHpmcSv1(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhSecHpmcSv1(i1,gt3,i2,gt2)
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
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSeSucSdcSvaa(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSeSvcSecSv1(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSecSvcVWmVP1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplSecSvcVWmVZ1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 


! {hh, Sv}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSecHpmcSv1(i1,gt3,gt1,i2)
coup2 = cplhhSvcSv(i1,i2,gt2)
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
coup1 = cplHpmSecHpmcSe1(i1,gt3,gt1,i2)
coup2 = cplSecHpmcSv(i2,i1,gt2)
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
coup1 = cplSdSecHpmcSdaa(i1,gt3,gt1,i2)
coup2 = cplSdcSdcSv(i2,i1,gt2)
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
coup1 = cplSeSecHpmcSe1(gt3,i1,gt1,i2)
coup2 = cplSecSecSv(i2,i1,gt2)
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
coup1 = cplAhSecHpmcSv1(i1,i2,gt1,gt2)
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
coup1 = cplhhSecHpmcSv1(i1,i2,gt1,gt2)
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
coup1 = cplHpmSvcHpmcSv1(i1,i2,gt1,gt2)
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
coup1 = cplSdcHpmcSucSvaa(i1,gt1,i2,gt2)
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
coup1 = cplSeSvcHpmcSv1(i1,i2,gt1,gt2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocSvSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe(MAh,MCha,MChi,MFd,               & 
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

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,3
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 


! {Hpm, VP, Se}
Do i1=1,2
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplHpmcHpmVP(i1,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
coup3 = cplSecSeVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VWm, VP, Se}
    Do i3=1,6
ML1 = MVWm 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSecSvcVWm(i3,gt2)
coup3 = cplSecSeVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplSecSvcVWmVP1(gt3,gt2)
Call Amp_VERTEX_StoSS_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvSe


Subroutine Amplitude_Tree_MSSMTriLnV_HpmToVZVWm(cplcHpmVWmVZ,MHpm,MVWm,               & 
& MVZ,MHpm2,MVWm2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MVWm,MVZ,MHpm2(2),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcHpmVWmVZ(2)

Complex(dp) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MVZ 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = cplcHpmVWmVZ(gt1)
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = AmpC 
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_HpmToVZVWm


Subroutine Gamma_Real_MSSMTriLnV_HpmToVZVWm(MLambda,em,gs,cplcHpmVWmVZ,               & 
& MHpm,MVWm,MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcHpmVWmVZ(2)

Real(dp), Intent(in) :: MHpm(2),MVWm,MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(2), GammarealGluon(2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=2,2
Coup = cplcHpmVWmVZ(i1)
Mex1 = MHpm(i1)
Mex2 = MVZ
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
  GammarealGluon(i1) = 0._dp 
 Call hardphotonSVV(Mex1,Mex2,Mex3,MLambda,em,-1._dp,0._dp,-1._dp,Coup,Gammarealphoton(i1),kont)
Else 
  GammarealGluon(i1) = 0._dp 
  GammarealPhoton(i1) = 0._dp 

End if 
End Do
End Subroutine Gamma_Real_MSSMTriLnV_HpmToVZVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToVZVWm(cplcHpmVPVWm,cplcHpmVWmVZ,            & 
& ctcplcHpmVPVWm,ctcplcHpmVWmVZ,MHpm,MHpm2,MVP,MVP2,MVWm,MVWm2,MVZ,MVZ2,ZfHpm,           & 
& ZfVWm,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MVP,MVP2,MVWm,MVWm2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplcHpmVPVWm(2),cplcHpmVWmVZ(2)

Complex(dp), Intent(in) :: ctcplcHpmVPVWm(2),ctcplcHpmVWmVZ(2)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfVWm,ZfVZ

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MVZ 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplcHpmVWmVZ(gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplcHpmVWmVZ(i1)
End Do


! External Field 2 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplcHpmVWmVZ(gt1)


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplcHpmVWmVZ(gt1)


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 1*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToVZVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToVZVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,cplAhcHpmVWm,    & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,     & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,               & 
& cplcgWpCgAcHpm,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,  & 
& cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,          & 
& cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSecSeVZ,             & 
& cplSecHpmcSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,& 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),         & 
& cplChiChiVZR(4,4),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFdFdVZL(3,3),            & 
& cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),        & 
& cplFvFecHpmR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFdFuVWmL(3,3),               & 
& cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),   & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcgWpCgAcHpm(2),cplcgWmgWmVZ,cplcgZgWmcHpm(2),   & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,cplcgWmgZVWm,cplcgWpCgZcHpm(2),             & 
& cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmcHpmVP(2,2),  & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcHpmcSu(6,2,6),cplSecSeVZ(6,6), & 
& cplSecHpmcSv(6,2,3),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3), & 
& cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhcHpmVWmVZ1(2,2),        & 
& cplhhcHpmVWmVZ1(2,2),cplHpmcHpmVPVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2),cplHpmcHpmVZVZ1(2,2),& 
& cplSucSdVWmVZaa(6,6),cplSvcSeVWmVZ1(3,6),cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,            & 
& cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q

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
Mex1 = MHpm(gt1) 
Mex2 = MVZ 
Mex3 = MVWm 


! {Ah, conj[Hpm], hh}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhhhVZ(i1,i3)
coup3 = cplhhcHpmVWm(i3,i2)
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


! {Ah, conj[VWm], hh}
Do i1=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = -cplAhcHpmVWm(i1,gt1)
coup2 = cplAhhhVZ(i1,i3)
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


! {Cha, Chi, Cha}
Do i1=1,2
  Do i2=1,4
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = -cplcChaChaVZR(i1,i3)
coup2R = -cplcChaChaVZL(i1,i3)
coup3L = -cplcChaChiVWmR(i3,i2)
coup3R = -cplcChaChiVWmL(i3,i2)
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


! {Chi, bar[Cha], Chi}
Do i1=1,4
  Do i2=1,2
    Do i3=1,4
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = -cplChiChiVZR(i1,i3)
coup2R = -cplChiChiVZL(i1,i3)
coup3L = cplcChaChiVWmL(i2,i3)
coup3R = cplcChaChiVWmR(i2,i3)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = -cplcFdFdVZR(i1,i3)
coup2R = -cplcFdFdVZL(i1,i3)
coup3L = -cplcFdFuVWmR(i3,i2)
coup3R = -cplcFdFuVWmL(i3,i2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = -cplcFeFeVZR(i1,i3)
coup2R = -cplcFeFeVZL(i1,i3)
coup3L = -cplcFeFvVWmR(i3,i2)
coup3R = -cplcFeFvVWmL(i3,i2)
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


! {Fv, bar[Fe], Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = -cplFvFvVZR(i1,i3)
coup2R = -cplFvFvVZL(i1,i3)
coup3L = cplcFeFvVWmL(i2,i3)
coup3R = cplcFeFvVWmR(i2,i3)
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


! {gWm, gZ, gWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgWmVZ
coup3 = cplcgWmgZVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], Ah}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = -cplAhhhVZ(i3,i1)
coup3 = cplAhcHpmVWm(i3,i2)
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


! {hh, conj[Hpm], VZ}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhVZVZ(i1)
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


! {hh, conj[VWm], VZ}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = -cplhhcHpmVWm(i1,gt1)
coup2 = cplhhVZVZ(i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, Ah, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = -cplHpmcHpmVZ(i3,i1)
coup3 = -cplAhcHpmVWm(i2,i3)
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


! {Hpm, hh, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = -cplHpmcHpmVZ(i3,i1)
coup3 = -cplhhcHpmVWm(i2,i3)
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


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = -cplHpmcHpmVZ(i3,i1)
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


! {Hpm, VZ, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = -cplHpmcHpmVZ(i1,gt1)
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


! {Hpm, hh, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplcHpmVWmVZ(i1)
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplcHpmVWmVZ(i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = -cplHpmcHpmVZ(i1,gt1)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = -cplSdcSdVZ(i3,i1)
coup3 = -cplSucSdVWm(i2,i3)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = -cplSecSeVZ(i3,i1)
coup3 = -cplSvcSeVWm(i2,i3)
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


! {VWm, Ah, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVZ(i3)
coup3 = -cplAhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = -cplhhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVZ(i3)
coup3 = -cplhhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVZ(i3)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcVWmVZ(i3)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, hh, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = -cplhhcHpmVWm(i2,gt1)
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


! {VWm, VP, VWm}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = -cplcVWmVWmVZ
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VWm, VZ, VWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = -cplcVWmVWmVZ
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VZ, conj[Hpm], hh}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = -cplHpmcHpmVZ(i2,gt1)
coup2 = cplhhVZVZ(i3)
coup3 = cplhhcHpmVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[VWm], hh}
    Do i3=1,2
ML1 = MVZ 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplhhVZVZ(i3)
coup3 = cplhhcVWmVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVZL(i3,i1)
coup2R = cplcFuFuVZR(i3,i1)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
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


! {bar[gWmC], bar[gP], bar[gWmC]}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcgWpCgAcHpm(gt1)
coup2 = cplcgWpCgWpCVZ
coup3 = cplcgAgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {bar[gWmC], bar[gZ], bar[gWmC]}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgWpCgWpCVZ
coup3 = cplcgZgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVZ(i1,i3)
coup3 = cplSucSdVWm(i3,i2)
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


! {conj[Sv], conj[Se], conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplSvcSvVZ(i1,i3)
coup3 = cplSvcSeVWm(i3,i2)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhcHpmVWmVZ1(i1,i2)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhcHpmVWmVZ1(i1,i2)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSucSdVWmVZaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSvcSeVWmVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplcVWmVPVWmVZ1Q
coup2a = coup2 
coup2 = cplcVWmVPVWmVZ2Q
coup2b = coup2 
coup2 = cplcVWmVPVWmVZ3Q
coup2c = coup2 
If (Abs(coup1)*(Abs(coup2a)+Abs(coup2b)+Abs(coup2c)) .gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2a,coup2b,coup2c,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplcVWmVWmVZVZ1Q
coup2c = coup2 
coup2 = cplcVWmVWmVZVZ2Q
coup2b = coup2 
coup2 = cplcVWmVWmVZVZ3Q
coup2a = coup2 
If (Abs(coup1)*(Abs(coup2a)+Abs(coup2b)+Abs(coup2c)) .gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2a,coup2b,coup2c,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {hh, VZ}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVZ 
coup1 = cplhhcHpmVWmVZ1(i1,gt1)
coup2 = cplhhVZVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplHpmcHpmcVWmVWm1(i1,gt1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = cplhhcHpmVWmVZ1(i1,gt1)
coup2 = cplhhcVWmVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplHpmcHpmVPVZ1(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplHpmcHpmVZVZ1(i1,gt1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToVZVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhHpmcHpm,            & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,   & 
& cplChiChiVZR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcHpmL,      & 
& cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuVWmL,          & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvVWmL,               & 
& cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgWmgWmVZ,cplcgZgWmcHpm,cplcgAgWpCVWm,cplcgZgWpCVWm,    & 
& cplcgWpCgWpCVZ,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhcHpmVWm,cplhhcVWmVWm,     & 
& cplhhVZVZ,cplHpmcHpmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,              & 
& cplSecSeVZ,cplSecHpmcSv,cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,    & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVWmVZ1,cplhhcHpmVWmVZ1,cplHpmcHpmVPVZ1,& 
& cplHpmcHpmcVWmVWm1,cplHpmcHpmVZVZ1,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,cplcVWmVPVWmVZ3Q,    & 
& cplcVWmVPVWmVZ2Q,cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),           & 
& cplChiChacHpmR(4,2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),         & 
& cplChiChiVZR(4,4),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFdFdVZL(3,3),            & 
& cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),        & 
& cplFvFecHpmR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFdFuVWmL(3,3),               & 
& cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),   & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcgWpCgAcHpm(2),cplcgWmgWmVZ,cplcgZgWmcHpm(2),   & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWpCgWpCVZ,cplcgWmgZVWm,cplcgWpCgZcHpm(2),             & 
& cplhhHpmcHpm(2,2,2),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmcHpmVP(2,2),  & 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcHpmcSu(6,2,6),cplSecSeVZ(6,6), & 
& cplSecHpmcSv(6,2,3),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3), & 
& cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhcHpmVWmVZ1(2,2),        & 
& cplhhcHpmVWmVZ1(2,2),cplHpmcHpmVPVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2),cplHpmcHpmVZVZ1(2,2),& 
& cplSucSdVWmVZaa(6,6),cplSvcSeVWmVZ1(3,6),cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,            & 
& cplcVWmVPVWmVZ1Q,cplcVWmVWmVZVZ2Q,cplcVWmVWmVZVZ3Q,cplcVWmVWmVZVZ1Q

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
Mex1 = MHpm(gt1) 
Mex2 = MVZ 
Mex3 = MVWm 


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = -cplHpmcHpmVZ(i3,i1)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplcHpmVWmVZ(i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVZ(i3)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VP, VWm}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = -cplcVWmVWmVZ
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoVV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplcVWmVPVWmVZ1Q
coup2a = coup2 
coup2 = cplcVWmVPVWmVZ2Q
coup2b = coup2 
coup2 = cplcVWmVPVWmVZ3Q
coup2c = coup2 
Call Amp_VERTEX_StoVV_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2a,coup2b,coup2c,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplHpmcHpmVPVZ1(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVZVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToAhSe(MAh,MAh2,MHpm,MHpm2,MSe,               & 
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
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToAhSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToAhSe(MAh,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFdFuSeL,cplcFdFuSeR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,               & 
& cplAhSdcHpmcSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplSdSecHpmcSdaa,        & 
& cplSeSecHpmcSe1,cplSeSucHpmcSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MAh2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),       & 
& cplFvFecHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvSeL(3,3,6),          & 
& cplcFeFvSeR(3,3,6),cplSdcHpmcSu(6,2,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),            & 
& cplSecHpmcSv(6,2,3),cplAhSdcHpmcSuaa(2,6,2,6),cplAhSeSucSdaa(2,6,6,6),cplAhSeSvcSe1(2,6,3,6),& 
& cplAhSecHpmcSv1(2,6,2,3),cplSdSecHpmcSdaa(6,6,2,6),cplSeSecHpmcSe1(6,6,2,6),           & 
& cplSeSucHpmcSuaa(6,6,2,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSe(gt3) 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplAhSdcSd(gt2,i3,i1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplAhSecSe(gt2,i3,i1)
coup3 = cplSeSvcSe(gt3,i2,i3)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuAhL(i3,i1,gt2)
coup2R = cplcFuFuAhR(i3,i1,gt2)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplAhSucSu(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplAhSeSucSdaa(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplAhSeSvcSe1(gt2,gt3,i2,i1)
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
coup1 = cplSdSecHpmcSdaa(i1,gt3,gt1,i2)
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
coup1 = cplSeSecHpmcSe1(gt3,i1,gt1,i2)
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
coup1 = cplSeSucHpmcSuaa(gt3,i1,gt1,i2)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSdcHpmcSuaa(gt2,i1,gt1,i2)
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
coup1 = cplAhSecHpmcSv1(gt2,i1,gt1,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToAhSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhSe(MAh,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,             & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFdFuSeL,          & 
& cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,   & 
& cplAhSdcHpmcSuaa,cplAhSeSucSdaa,cplAhSeSvcSe1,cplAhSecHpmcSv1,cplSdSecHpmcSdaa,        & 
& cplSeSecHpmcSe1,cplSeSucHpmcSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MAh2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),       & 
& cplFvFecHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvSeL(3,3,6),          & 
& cplcFeFvSeR(3,3,6),cplSdcHpmcSu(6,2,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),            & 
& cplSecHpmcSv(6,2,3),cplAhSdcHpmcSuaa(2,6,2,6),cplAhSeSucSdaa(2,6,6,6),cplAhSeSvcSe1(2,6,3,6),& 
& cplAhSecHpmcSv1(2,6,2,3),cplSdSecHpmcSdaa(6,6,2,6),cplSeSecHpmcSe1(6,6,2,6),           & 
& cplSeSucHpmcSuaa(6,6,2,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MSe(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToAhSe


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToChaFv(MCha,MCha2,MHpm,MHpm2,ZfFvL,          & 
& ZfHpm,ZfLm,ZfLp,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: ZfFvL(3,3),ZfHpm(2,2),ZfLm(2,2),ZfLp(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MCha(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToChaFv


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToChaFv(MCha,MFd,MFe,MFu,MHpm,              & 
& MSd,MSe,MSu,MSv,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,           & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,         & 
& cplcFeChaSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,         & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,              & 
& cplcFeFvSeR,cplSdcHpmcSu,cplSecHpmcSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MCha2(2),            & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),           & 
& cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MCha(gt2) 
Mex3 = 0. 


! {Fv, bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplFvChacSeL(i1,gt2,i3)
coup2R = cplFvChacSeR(i1,gt2,i3)
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


! {bar[Fu], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplChaFucSdL(gt2,i1,i3)
coup2R = cplChaFucSdR(gt2,i1,i3)
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


! {conj[Su], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2L = cplcFdChaSuL(i3,gt2,i1)
coup2R = cplcFdChaSuR(i3,gt2,i1)
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


! {conj[Sv], conj[Se], bar[Fe]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2L = cplcFeChaSvL(i3,gt2,i1)
coup2R = cplcFeChaSvR(i3,gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToChaFv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChaFv(MCha,MFd,MFe,MFu,MHpm,           & 
& MSd,MSe,MSu,MSv,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,           & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,         & 
& cplcFeChaSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,         & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFvSdL,cplcFdFvSdR,cplcFeFvSeL,              & 
& cplcFeFvSeR,cplSdcHpmcSu,cplSecHpmcSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MCha2(2),            & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),           & 
& cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MCha(gt2) 
Mex3 = 0. 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChaFv


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToChiFe(MChi,MChi2,MFe,MFe2,MHpm,             & 
& MHpm2,ZfFEL,ZfFER,ZfHpm,ZfL0,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MFe(3),MFe2(3),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfHpm(2,2),ZfL0(4,4)

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
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToChiFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToChiFe(MChi,MFd,MFe,MFu,MHpm,              & 
& MSd,MSe,MSu,MSv,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChiFdcSdL,           & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,          & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,        & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFeSuL,             & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcHpmcSu,            & 
& cplSecHpmcSv,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MChi2(4),            & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MFe(gt3) 


! {Fd, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
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


! {Fe, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,gt2,i3)
coup2R = cplcFeChiSeR(i1,gt2,i3)
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


! {Fv, bar[Fe], Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplChiFvSvL(gt2,i1,i3)
coup2R = cplChiFvSvR(gt2,i1,i3)
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


! {Fv, bar[Fe], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplChiFvcSvL(gt2,i1,i3)
coup2R = cplChiFvcSvR(gt2,i1,i3)
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


! {Sd, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
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


! {Se, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2L = cplChiFecSeL(gt2,i3,i1)
coup2R = cplChiFecSeR(gt2,i3,i1)
coup3L = cplcFeFeSvL(i3,gt3,i2)
coup3R = cplcFeFeSvR(i3,gt3,i2)
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


! {bar[Fu], bar[Fd], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplChiFucSuL(gt2,i1,i3)
coup2R = cplChiFucSuR(gt2,i1,i3)
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


! {conj[Su], conj[Sd], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2L = cplcFuChiSuL(i3,gt2,i1)
coup2R = cplcFuChiSuR(i3,gt2,i1)
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


! {conj[Sv], conj[Se], Fv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2L = cplChiFvSvL(gt2,i3,i1)
coup2R = cplChiFvSvR(gt2,i3,i1)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToChiFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiFe(MChi,MFd,MFe,MFu,MHpm,           & 
& MSd,MSe,MSu,MSv,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplChiFdcSdL,           & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,          & 
& cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,          & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFucSdL,        & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFdFeSuL,             & 
& cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcFeFecSvL,cplcFeFecSvR,cplSdcHpmcSu,            & 
& cplSecHpmcSv,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MChi2(4),            & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplSdcHpmcSu(6,2,6),cplSecHpmcSv(6,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MFe(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToChiFe


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTohhSe(Mhh,Mhh2,MHpm,MHpm2,MSe,               & 
& MSe2,Zfhh,ZfHpm,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfHpm(2,2),ZfSe(6,6)

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
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTohhSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTohhSe(MFd,MFe,MFu,Mhh,MHpm,MSd,            & 
& MSe,MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,cplcFeFehhR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,        & 
& cplSecHpmcSv,cplhhSdcHpmcSuaa,cplhhSeSucSdaa,cplhhSeSvcSe1,cplhhSecHpmcSv1,            & 
& cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,cplSeSvcHpmcSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),              & 
& MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),      & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),           & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),             & 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplSdcHpmcSu(6,2,6),cplSeSucSd(6,6,6),             & 
& cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSeSucSdaa(2,6,6,6),& 
& cplhhSeSvcSe1(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplSdSecHpmcSdaa(6,6,2,6),             & 
& cplSeSecHpmcSe1(6,6,2,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSvcHpmcSv1(6,3,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MSe(gt3) 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
coup3 = cplSeSvcSe(gt3,i2,i3)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuhhL(i3,i1,gt2)
coup2R = cplcFuFuhhR(i3,i1,gt2)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplhhSucSu(gt2,i1,i3)
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


! {conj[Sv], conj[Se], conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplhhSvcSv(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplhhSeSucSdaa(gt2,gt3,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplhhSeSvcSe1(gt2,gt3,i2,i1)
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
coup1 = cplSdSecHpmcSdaa(i1,gt3,gt1,i2)
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
coup1 = cplSeSecHpmcSe1(gt3,i1,gt1,i2)
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
coup1 = cplSeSucHpmcSuaa(gt3,i1,gt1,i2)
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
coup1 = cplSeSvcHpmcSv1(gt3,i1,gt1,i2)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSdcHpmcSuaa(gt2,i1,gt1,i2)
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
coup1 = cplhhSecHpmcSv1(gt2,i1,gt1,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTohhSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhSe(MFd,MFe,MFu,Mhh,MHpm,             & 
& MSd,MSe,MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,             & 
& cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFehhL,         & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvSeL,               & 
& cplcFeFvSeR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcHpmcSu,cplSeSucSd,       & 
& cplSeSvcSe,cplSecHpmcSv,cplhhSdcHpmcSuaa,cplhhSeSucSdaa,cplhhSeSvcSe1,cplhhSecHpmcSv1, & 
& cplSdSecHpmcSdaa,cplSeSecHpmcSe1,cplSeSucHpmcSuaa,cplSeSvcHpmcSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),              & 
& MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),      & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),           & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),             & 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplSdcHpmcSu(6,2,6),cplSeSucSd(6,6,6),             & 
& cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSeSucSdaa(2,6,6,6),& 
& cplhhSeSvcSe1(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplSdSecHpmcSdaa(6,6,2,6),             & 
& cplSeSecHpmcSe1(6,6,2,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSvcHpmcSv1(6,3,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MSe(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTohhSe


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmSv(MHpm,MHpm2,MSv,MSv2,ZfHpm,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSv(3,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmSv(MFd,MFe,MFu,MHpm,MSd,               & 
& MSe,MSu,MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdSvL,cplcFdFdSvR,          & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdSvcSd,cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,    & 
& cplHpmSuSvcSdaa,cplSdSvcHpmcSuaa,cplSeSvcHpmcSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),MFe2(3),             & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),      & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),           & 
& cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSecHpmcSe1(2,6,2,6),& 
& cplHpmSuSvcSdaa(2,6,3,6),cplSdSvcHpmcSuaa(6,3,2,6),cplSeSvcHpmcSv1(6,3,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSv(gt3) 


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplHpmSvcSe(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplHpmSuSvcSdaa(gt2,i2,gt3,i1)
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
coup1 = cplSdSvcHpmcSuaa(i1,gt3,gt1,i2)
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
coup1 = cplSeSvcHpmcSv1(i1,gt3,gt1,i2)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplHpmSdcHpmcSdaa(gt2,i1,gt1,i2)
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
coup1 = cplHpmSecHpmcSe1(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmSv(MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MSv,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdSvL,cplcFdFdSvR,          & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdSvcSd,cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplHpmSdcHpmcSdaa,cplHpmSecHpmcSe1,    & 
& cplHpmSuSvcSdaa,cplSdSvcHpmcSuaa,cplSeSvcHpmcSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),MFe2(3),             & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),      & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),           & 
& cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSecHpmcSe1(2,6,2,6),& 
& cplHpmSuSvcSdaa(2,6,3,6),cplSdSvcHpmcSuaa(6,3,2,6),cplSeSvcHpmcSv1(6,3,2,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmSv


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmVP(cplHpmcHpmVP,cplHpmcHpmVZ,            & 
& ctcplHpmcHpmVP,ctcplHpmcHpmVZ,MHpm,MHpm2,MVP,MVP2,ZfHpm,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MVP,MVP2

Complex(dp), Intent(in) :: cplHpmcHpmVP(2,2),cplHpmcHpmVZ(2,2)

Complex(dp), Intent(in) :: ctcplHpmcHpmVP(2,2),ctcplHpmcHpmVZ(2,2)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfVP,ZfVZVP

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplHpmcHpmVP(gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt2)*cplHpmcHpmVP(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVP*cplHpmcHpmVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZVP*cplHpmcHpmVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVP(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiHpmL, & 
& cplcChaChiHpmR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,            & 
& cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgZgWpCHpm,        & 
& cplcgWpCgWpCVP,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,     & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSdVP,cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,             & 
& cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),        & 
& cplChiChacHpmR(4,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChiHpmL(2,4,2),     & 
& cplcChaChiHpmR(2,4,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcHpmL(3,3,2),          & 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVPL(3,3),         & 
& cplcFeFeVPR(3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVPL(3,3),             & 
& cplcFuFuVPR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgWmgWmVP,cplcgZgWmcHpm(2),& 
& cplcgZgWpCHpm(2),cplcgWpCgWpCVP,cplcgWmgZHpm(2),cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2), & 
& cplhhHpmcVWm(2,2),cplhhcHpmVWm(2,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVP(6,6),   & 
& cplSdcHpmcSu(6,2,6),cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),cplSucSuVP(6,6),               & 
& cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplAhHpmcVWmVP1(2,2),cplAhcHpmVPVWm1(2,2),& 
& cplhhHpmcVWmVP1(2,2),cplhhcHpmVPVWm1(2,2),cplHpmcHpmVPVP1(2,2),cplHpmcHpmVPVZ1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVP 


! {Ah, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
coup3 = cplHpmcHpmVP(i3,i2)
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


! {Ah, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcHpm(i1,gt2,i3)
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


! {Ah, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = -cplAhHpmcVWm(i1,gt2)
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


! {Ah, conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplAhcHpmVWm(i1,gt1)
coup2 = -cplAhHpmcVWm(i1,gt2)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Chi, bar[Cha], bar[Cha]}
Do i1=1,4
  Do i2=1,2
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i1,i2,gt1)
coup1R = cplChiChacHpmR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(i3,i1,gt2)
coup2R = cplcChaChiHpmR(i3,i1,gt2)
coup3L = cplcChaChaVPL(i2,i3)
coup3R = cplcChaChaVPR(i2,i3)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,i3,gt2)
coup2R = cplcFdFuHpmR(i1,i3,gt2)
coup3L = -cplcFuFuVPR(i3,i2)
coup3R = -cplcFuFuVPL(i3,i2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
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


! {gZ, gWmC, gWmC}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgZgWpCHpm(gt2)
coup3 = cplcgWpCgWpCVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {hh, conj[Hpm], conj[Hpm]}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
coup3 = cplHpmcHpmVP(i3,i2)
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


! {hh, conj[VWm], conj[Hpm]}
Do i1=1,2
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = cplhhHpmcHpm(i1,gt2,i3)
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


! {hh, conj[Hpm], conj[VWm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = -cplhhHpmcVWm(i1,gt2)
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


! {hh, conj[VWm], conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplhhcHpmVWm(i1,gt1)
coup2 = -cplhhHpmcVWm(i1,gt2)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplHpmSucSd(gt2,i3,i1)
coup3 = -cplSucSuVP(i2,i3)
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


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
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


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
coup3 = cplHpmcVWmVP(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm], conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {VZ, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplHpmcHpmVZ(gt2,i3)
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


! {VZ, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVZ 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcHpmVZ(gt2,i3)
coup3 = cplHpmcVWmVP(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VZ, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVZ 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVZ(i2,gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = cplcHpmVPVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[VWm], conj[VWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcVWmVZ(gt2)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
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


! {bar[gZ], bar[gWm], bar[gWm]}
ML1 = MVZ 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgZHpm(gt2)
coup3 = cplcgWmgWmVP
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplSdcSdVP(i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplHpmSvcSe(gt2,i1,i3)
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


! {Ah, conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
coup1 = -cplAhcHpmVWm(i1,gt1)
coup2 = cplAhHpmcVWmVP1(i1,gt2)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = -cplhhcHpmVWm(i1,gt1)
coup2 = cplhhHpmcVWmVP1(i1,gt2)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplHpmcHpmVPVP1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VZ}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2 = cplHpmcHpmVPVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Ah, conj[VWm]}
Do i1=1,2
ML1 = MAh(i1) 
ML2 = MVWm 
coup1 = cplAhcHpmVPVWm1(i1,gt1)
coup2 = -cplAhHpmcVWm(i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = cplhhcHpmVPVWm1(i1,gt1)
coup2 = -cplhhHpmcVWm(i1,gt2)
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
coup1 = cplHpmcHpmVPVP1(i1,gt1)
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
coup1 = cplHpmcHpmVPVZ1(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVP(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,         & 
& cplAhcHpmVWm,cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiHpmL, & 
& cplcChaChiHpmR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,            & 
& cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,cplcgWmgWmVP,cplcgZgWmcHpm,cplcgZgWpCHpm,        & 
& cplcgWpCgWpCVP,cplcgWmgZHpm,cplcgWpCgZcHpm,cplhhHpmcHpm,cplhhHpmcVWm,cplhhcHpmVWm,     & 
& cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,           & 
& cplSdcSdVP,cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplcHpmVPVWm,               & 
& cplcVWmVPVWm,cplcHpmVWmVZ,cplAhHpmcVWmVP1,cplAhcHpmVPVWm1,cplhhHpmcVWmVP1,             & 
& cplhhcHpmVPVWm1,cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),        & 
& cplChiChacHpmR(4,2,2),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChiHpmL(2,4,2),     & 
& cplcChaChiHpmR(2,4,2),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcHpmL(3,3,2),          & 
& cplcFuFdcHpmR(3,3,2),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVPL(3,3),         & 
& cplcFeFeVPR(3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVPL(3,3),             & 
& cplcFuFuVPR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcgWmgWmVP,cplcgZgWmcHpm(2),& 
& cplcgZgWpCHpm(2),cplcgWpCgWpCVP,cplcgWmgZHpm(2),cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2), & 
& cplhhHpmcVWm(2,2),cplhhcHpmVWm(2,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVP(6,6),   & 
& cplSdcHpmcSu(6,2,6),cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),cplSucSuVP(6,6),               & 
& cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),cplAhHpmcVWmVP1(2,2),cplAhcHpmVPVWm1(2,2),& 
& cplhhHpmcVWmVP1(2,2),cplhhcHpmVPVWm1(2,2),cplHpmcHpmVPVP1(2,2),cplHpmcHpmVPVZ1(2,2)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVP 


! {VP, conj[Hpm], conj[Hpm]}
  Do i2=1,2
    Do i3=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
coup3 = cplHpmcHpmVP(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[VWm], conj[Hpm]}
    Do i3=1,2
ML1 = MVP 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcHpmVP(gt2,i3)
coup3 = cplHpmcVWmVP(i3)
Call Amp_VERTEX_StoSV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do


! {VP, conj[Hpm], conj[VWm]}
  Do i2=1,2
ML1 = MVP 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmcHpmVP(i2,gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = cplcHpmVPVWm(i2)
Call Amp_VERTEX_StoSV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do


! {VP, conj[VWm], conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(gt2)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplHpmcHpmVPVP1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplHpmcHpmVPVP1(i1,gt1)
coup2 = cplHpmcHpmVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmVP


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmcSv(MHpm,MHpm2,MSv,MSv2,ZfHpm,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSv(3,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToHpmcSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmcSv(MFd,MFe,MFu,MHpm,MSd,              & 
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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSv(gt3) 


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuHpmL(i3,i1,gt2)
coup2R = cplcFdFuHpmR(i3,i1,gt2)
coup3L = cplcFdFdcSvL(i2,i3,gt3)
coup3R = cplcFdFdcSvR(i2,i3,gt3)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplHpmSucSd(gt2,i1,i3)
coup3 = cplSdcSdcSv(i3,i2,gt3)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplHpmSvcSe(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplHpmSucSdcSvaa(gt2,i2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplHpmSvcSecSv1(gt2,i2,i1,gt3)
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
coup1 = cplSdcHpmcSucSvaa(i1,gt1,i2,gt3)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplHpmSdcHpmcSdaa(gt2,i1,gt1,i2)
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
coup1 = cplHpmSecHpmcSe1(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToHpmcSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmcSv(MFd,MFe,MFu,MHpm,               & 
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
Mex1 = MHpm(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToHpmcSv


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSeSv(MHpm,MHpm2,MSe,MSe2,MSv,               & 
& MSv2,ZfHpm,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,3
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSeSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSeSv(MCha,MChi,MFd,MFe,MFu,               & 
& MHpm,MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,             & 
& cplChiChacHpmL,cplChiChacHpmR,cplcFeChaSvL,cplcFeChaSvR,cplChiFvSvL,cplChiFvSvR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,         & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplSdSvcSd,cplSdcHpmcSu,             & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSdSecHpmcSdaa,cplSdSvcHpmcSuaa,cplSeSecHpmcSe1,  & 
& cplSeSvcHpmcSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),             & 
& MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),  & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSdSecHpmcSdaa(6,6,2,6),     & 
& cplSdSvcHpmcSuaa(6,3,2,6),cplSeSecHpmcSe1(6,6,2,6),cplSeSvcHpmcSv1(6,3,2,3)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSv(gt3) 


! {Cha, Chi, Fv}
Do i1=1,2
  Do i2=1,4
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = 0. 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i1,i3,gt2)
coup2R = cplcChaFvSeR(i1,i3,gt2)
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


! {Fe, Fv, Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MChi(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,i3,gt2)
coup2R = cplcFeChiSeR(i1,i3,gt2)
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


! {Fv, bar[Fe], bar[Cha]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MCha(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcChaFvSeL(i3,i1,gt2)
coup2R = cplcChaFvSeR(i3,i1,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvSeL(i3,i1,gt2)
coup2R = cplcFeFvSeR(i3,i1,gt2)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuSeL(i3,i1,gt2)
coup2R = cplcFdFuSeR(i3,i1,gt2)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSeSucSd(gt2,i1,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplSeSvcSe(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdSvcHpmcSuaa(i1,gt3,gt1,i2)
coup2 = cplSeSucSd(gt2,i2,i1)
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
coup1 = cplSeSvcHpmcSv1(i1,gt3,gt1,i2)
coup2 = cplSeSvcSe(gt2,i2,i1)
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
coup1 = cplSdSecHpmcSdaa(i1,gt2,gt1,i2)
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
coup1 = cplSeSecHpmcSe1(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSeSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSeSv(MCha,MChi,MFd,MFe,MFu,            & 
& MHpm,MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,             & 
& cplChiChacHpmL,cplChiChacHpmR,cplcFeChaSvL,cplcFeChaSvR,cplChiFvSvL,cplChiFvSvR,       & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,         & 
& cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplSdSvcSd,cplSdcHpmcSu,             & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSdSecHpmcSdaa,cplSdSvcHpmcSuaa,cplSeSecHpmcSe1,  & 
& cplSeSvcHpmcSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),             & 
& MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),  & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSdSecHpmcSdaa(6,6,2,6),     & 
& cplSdSvcHpmcSuaa(6,3,2,6),cplSeSecHpmcSe1(6,6,2,6),cplSeSvcHpmcSv1(6,3,2,3)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,2
  Do gt2=1,6
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSeSv


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSeVP(MHpm,MHpm2,MSe,MSe2,MVP,               & 
& MVP2,ZfHpm,ZfSe,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MVP,MVP2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfVP

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
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSeVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSeVP(MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MVP,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,     & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,cplcFeFvSeL,cplcFeFvSeR,               & 
& cplSdcSdVP,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVP,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),          & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),             & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),               & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplSdcSdVP(6,6),cplSdcHpmcSu(6,2,6),             & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),               & 
& cplSucSuVP(6,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVP 


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,i3,gt2)
coup2R = cplcFdFuSeR(i1,i3,gt2)
coup3L = -cplcFuFuVPR(i3,i2)
coup3R = -cplcFuFuVPL(i3,i2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvSeL(i3,i1,gt2)
coup2R = cplcFeFvSeR(i3,i1,gt2)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSeSucSd(gt2,i3,i1)
coup3 = -cplSucSuVP(i2,i3)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuSeL(i3,i1,gt2)
coup2R = cplcFdFuSeR(i3,i1,gt2)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSeSucSd(gt2,i1,i3)
coup3 = cplSdcSdVP(i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplSeSvcSe(gt2,i1,i3)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSeVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSeVP(MFd,MFe,MFu,MHpm,MSd,             & 
& MSe,MSu,MSv,MVP,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,             & 
& cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVPL,         & 
& cplcFeFeVPR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,cplcFeFvSeL,               & 
& cplcFeFvSeR,cplSdcSdVP,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecHpmcSv,     & 
& cplSucSuVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVP,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),          & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),             & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),               & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplSdcSdVP(6,6),cplSdcHpmcSu(6,2,6),             & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),               & 
& cplSucSuVP(6,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSeVP


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSeVZ(MHpm,MHpm2,MSe,MSe2,MVZ,               & 
& MVZ2,ZfHpm,ZfSe,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfVZ

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
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSeVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSeVZ(MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MVZ,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,     & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,cplcFeFeVZR,         & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcFeFvSeL,     & 
& cplcFeFvSeR,cplSdcSdVZ,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecSeVZ,cplSecHpmcSv,     & 
& cplSucSuVZ,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVZ,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),          & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),             & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),               & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplSdcSdVZ(6,6), & 
& cplSdcHpmcSu(6,2,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVZ(6,6),               & 
& cplSecHpmcSv(6,2,3),cplSucSuVZ(6,6),cplSvcSvVZ(3,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVZ 


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,i3,gt2)
coup2R = cplcFdFuSeR(i1,i3,gt2)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
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


! {Fe, Fv, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,i3,gt2)
coup2R = cplcFeFvSeR(i1,i3,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i1,i2,gt1)
coup1R = cplFvFecHpmR(i1,i2,gt1)
coup2L = cplcFeFvSeL(i3,i1,gt2)
coup2R = cplcFeFvSeR(i3,i1,gt2)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSeSucSd(gt2,i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
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


! {Se, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSeSvcSe(gt2,i3,i1)
coup3 = -cplSvcSvVZ(i2,i3)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFdFuSeL(i3,i1,gt2)
coup2R = cplcFdFuSeR(i3,i1,gt2)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSeSucSd(gt2,i1,i3)
coup3 = cplSdcSdVZ(i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i2,gt1,i1)
coup2 = cplSeSvcSe(gt2,i1,i3)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSeVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSeVZ(MFd,MFe,MFu,MHpm,MSd,             & 
& MSe,MSu,MSv,MVZ,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,             & 
& cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeVZL,         & 
& cplcFeFeVZR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,     & 
& cplcFeFvSeL,cplcFeFvSeR,cplSdcSdVZ,cplSdcHpmcSu,cplSeSucSd,cplSeSvcSe,cplSecSeVZ,      & 
& cplSecHpmcSv,cplSucSuVZ,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVZ,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),          & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),             & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),               & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplSdcSdVZ(6,6), & 
& cplSdcHpmcSu(6,2,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVZ(6,6),               & 
& cplSecHpmcSv(6,2,3),cplSucSuVZ(6,6),cplSvcSvVZ(3,3)

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
Mex1 = MHpm(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSeVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSvVWm(MHpm,MHpm2,MSv,MSv2,MVWm,             & 
& MVWm2,ZfHpm,ZfSv,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSv(3,3),ZfVWm

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
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToSvVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSvVWm(MFd,MFe,MFu,MHpm,MSd,               & 
& MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdSvL,           & 
& cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,         & 
& cplcFeFeSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdSvcSd,            & 
& cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),        & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),      & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),           & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = -cplcFdFuVWmR(i3,i2)
coup3R = -cplcFdFuVWmL(i3,i2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = -cplcFeFvVWmR(i3,i2)
coup3R = -cplcFeFvVWmL(i3,i2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = -cplSucSdVWm(i2,i3)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = -cplSvcSeVWm(i2,i3)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToSvVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSvVWm(MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdSvL,           & 
& cplcFdFdSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFeSvL,         & 
& cplcFeFeSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdSvcSd,            & 
& cplSdcHpmcSu,cplSeSvcSe,cplSecHpmcSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),        & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),      & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),           & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToSvVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToVPVWm(cplcHpmVPVWm,cplcHpmVWmVZ,            & 
& ctcplcHpmVPVWm,ctcplcHpmVWmVZ,MHpm,MHpm2,MVP,MVP2,MVWm,MVWm2,ZfHpm,ZfVP,               & 
& ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MVP,MVP2,MVWm,MVWm2

Complex(dp), Intent(in) :: cplcHpmVPVWm(2),cplcHpmVWmVZ(2)

Complex(dp), Intent(in) :: ctcplcHpmVPVWm(2),ctcplcHpmVWmVZ(2)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfVP,ZfVWm

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,2
! External masses 
Mex1 = MHpm(gt1) 
Mex2 = MVP 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplcHpmVPVWm(gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt1))*cplcHpmVPVWm(i1)
End Do


! External Field 2 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVP*cplcHpmVPVWm(gt1)


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplcHpmVPVWm(gt1)


! Getting the amplitude 
Call TreeAmp_StoVV(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1) = 1*AmpC 
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmToVPVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToVPVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhcHpmVWm,              & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgWmgWmVP,cplcgZgWmcHpm,      & 
& cplcgWpCgWpCVP,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,   & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplSdcSdVP,           & 
& cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,               & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVPVWm1,cplhhcHpmVPVWm1,   & 
& cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,cplHpmcHpmcVWmVWm1,cplSucSdVPVWmaa,cplSvcSeVPVWm1,     & 
& cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,  & 
& cplcVWmVPVWmVZ1Q,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),    & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),         & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),           & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),             & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),& 
& cplcFeFvVWmR(3,3),cplcgWpCgAcHpm(2),cplcgWmgWmVP,cplcgZgWmcHpm(2),cplcgWpCgWpCVP,      & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2),        & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2), & 
& cplSdcSdVP(6,6),cplSdcHpmcSu(6,2,6),cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),               & 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,        & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhcHpmVPVWm1(2,2),cplhhcHpmVPVWm1(2,2),cplHpmcHpmVPVP1(2,2),& 
& cplHpmcHpmVPVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2),cplSucSdVPVWmaa(6,6),cplSvcSeVPVWm1(3,6), & 
& cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,  & 
& cplcVWmVPVWmVZ1Q

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
Mex1 = MHpm(gt1) 
Mex2 = MVP 
Mex3 = MVWm 


! {Cha, Chi, Cha}
Do i1=1,2
  Do i2=1,4
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiChacHpmL(i2,i1,gt1)
coup1R = cplChiChacHpmR(i2,i1,gt1)
coup2L = -cplcChaChaVPR(i1,i3)
coup2R = -cplcChaChaVPL(i1,i3)
coup3L = -cplcChaChiVWmR(i3,i2)
coup3R = -cplcChaChiVWmL(i3,i2)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = -cplcFdFdVPR(i1,i3)
coup2R = -cplcFdFdVPL(i1,i3)
coup3L = -cplcFdFuVWmR(i3,i2)
coup3R = -cplcFdFuVWmL(i3,i2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = -cplcFeFeVPR(i1,i3)
coup2R = -cplcFeFeVPL(i1,i3)
coup3L = -cplcFeFvVWmR(i3,i2)
coup3R = -cplcFeFvVWmL(i3,i2)
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


! {gWm, gZ, gWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgZgWmcHpm(gt1)
coup2 = cplcgWmgWmVP
coup3 = cplcgWmgZVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {Hpm, Ah, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhHpmcHpm(i2,i1,gt1)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = -cplAhcHpmVWm(i2,i3)
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


! {Hpm, hh, Hpm}
Do i1=1,2
  Do i2=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = -cplhhcHpmVWm(i2,i3)
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


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
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


! {Hpm, VZ, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = -cplHpmcHpmVZ(i1,gt1)
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


! {Hpm, hh, VWm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhHpmcHpm(i2,i1,gt1)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = -cplHpmcHpmVP(i1,gt1)
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


! {Hpm, VZ, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = -cplHpmcHpmVZ(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = -cplSdcSdVP(i3,i1)
coup3 = -cplSucSdVWm(i2,i3)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = -cplSecSeVP(i3,i1)
coup3 = -cplSvcSeVWm(i2,i3)
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


! {VWm, Ah, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = -cplAhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVP(i3)
coup3 = -cplAhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, hh, Hpm}
  Do i2=1,2
    Do i3=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = -cplhhcHpmVWm(i2,gt1)
coup2 = cplHpmcVWmVP(i3)
coup3 = -cplhhcHpmVWm(i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(i3)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VZ, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplHpmcVWmVP(i3)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, hh, VWm}
  Do i2=1,2
ML1 = MVWm 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = -cplhhcHpmVWm(i2,gt1)
coup2 = cplcVWmVPVWm
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do


! {VWm, VP, VWm}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplcVWmVPVWm
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VWm, VZ, VWm}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplcVWmVPVWm
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcHpmL(i1,i2,gt1)
coup1R = cplcFuFdcHpmR(i1,i2,gt1)
coup2L = cplcFuFuVPL(i3,i1)
coup2R = cplcFuFuVPR(i3,i1)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
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


! {bar[gWmC], bar[gP], bar[gWmC]}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcgWpCgAcHpm(gt1)
coup2 = cplcgWpCgWpCVP
coup3 = cplcgAgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {bar[gWmC], bar[gZ], bar[gWmC]}
ML1 = MVWm 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplcgWpCgZcHpm(gt1)
coup2 = cplcgWpCgWpCVP
coup3 = cplcgZgWpCVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology1_UUU(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcHpmcSu(i2,gt1,i1)
coup2 = cplSucSuVP(i1,i3)
coup3 = cplSucSdVWm(i3,i2)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmcHpm(i1,i2,gt1)
coup2 = cplAhcHpmVPVWm1(i1,i2)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = Mhh(i1) 
ML2 = MHpm(i2) 
coup1 = cplhhHpmcHpm(i1,i2,gt1)
coup2 = cplhhcHpmVPVWm1(i1,i2)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSucSdVPVWmaa(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSvcSeVPVWm1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplcVWmVPVPVWm1Q
coup2c = coup2 
coup2 = cplcVWmVPVPVWm2Q
coup2a = coup2 
coup2 = cplcVWmVPVPVWm3Q
coup2b = coup2 
If (Abs(coup1)*(Abs(coup2a)+Abs(coup2b)+Abs(coup2c)) .gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2a,coup2b,coup2c,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VWm, VZ}
ML1 = MVWm 
ML2 = MVZ 
coup1 = cplcHpmVWmVZ(gt1)
coup2 = cplcVWmVPVWmVZ1Q
coup2b = coup2 
coup2 = cplcVWmVPVWmVZ2Q
coup2c = coup2 
coup2 = cplcVWmVPVWmVZ3Q
coup2a = coup2 
If (Abs(coup1)*(Abs(coup2a)+Abs(coup2b)+Abs(coup2c)) .gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2a,coup2b,coup2c,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {Hpm, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVWm 
coup1 = cplHpmcHpmcVWmVWm1(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {hh, conj[VWm]}
Do i1=1,2
ML1 = Mhh(i1) 
ML2 = MVWm 
coup1 = cplhhcHpmVPVWm1(i1,gt1)
coup2 = cplhhcVWmVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplHpmcHpmVPVP1(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplHpmcHpmVPVZ1(i1,gt1)
coup2 = cplcHpmVWmVZ(i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmToVPVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVPVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,              & 
& MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhcHpmVWm,         & 
& cplChiChacHpmL,cplChiChacHpmR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChiVWmL,              & 
& cplcChaChiVWmR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,       & 
& cplFvFecHpmR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcgWpCgAcHpm,cplcgWmgWmVP,cplcgZgWmcHpm,      & 
& cplcgWpCgWpCVP,cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm,cplhhHpmcHpm,   & 
& cplhhcHpmVWm,cplhhcVWmVWm,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplSdcSdVP,           & 
& cplSdcHpmcSu,cplSecSeVP,cplSecHpmcSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,               & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplAhcHpmVPVWm1,cplhhcHpmVPVWm1,   & 
& cplHpmcHpmVPVP1,cplHpmcHpmVPVZ1,cplHpmcHpmcVWmVWm1,cplSucSdVPVWmaa,cplSvcSeVPVWm1,     & 
& cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,  & 
& cplcVWmVPVWmVZ1Q,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhcHpmVWm(2,2),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),    & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),         & 
& cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),           & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),             & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),& 
& cplcFeFvVWmR(3,3),cplcgWpCgAcHpm(2),cplcgWmgWmVP,cplcgZgWmcHpm(2),cplcgWpCgWpCVP,      & 
& cplcgAgWpCVWm,cplcgZgWpCVWm,cplcgWmgZVWm,cplcgWpCgZcHpm(2),cplhhHpmcHpm(2,2,2),        & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2), & 
& cplSdcSdVP(6,6),cplSdcHpmcSu(6,2,6),cplSecSeVP(6,6),cplSecHpmcSv(6,2,3),               & 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,        & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplAhcHpmVPVWm1(2,2),cplhhcHpmVPVWm1(2,2),cplHpmcHpmVPVP1(2,2),& 
& cplHpmcHpmVPVZ1(2,2),cplHpmcHpmcVWmVWm1(2,2),cplSucSdVPVWmaa(6,6),cplSvcSeVPVWm1(3,6), & 
& cplcVWmVPVPVWm3Q,cplcVWmVPVPVWm1Q,cplcVWmVPVPVWm2Q,cplcVWmVPVWmVZ3Q,cplcVWmVPVWmVZ2Q,  & 
& cplcVWmVPVWmVZ1Q

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
Mex1 = MHpm(gt1) 
Mex2 = MVP 
Mex3 = MVWm 


! {Hpm, VP, Hpm}
Do i1=1,2
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = -cplHpmcHpmVP(i3,i1)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoVV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Hpm, VP, VWm}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = -cplHpmcHpmVP(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoVV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
End Do


! {VWm, VP, Hpm}
    Do i3=1,2
ML1 = MVWm 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplHpmcVWmVP(i3)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoVV_Topology1_VVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
    End Do


! {VWm, VP, VWm}
ML1 = MVWm 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplcVWmVPVWm
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoVV_Topology1_VVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplcHpmVPVWm(gt1)
coup2 = cplcVWmVPVPVWm1Q
coup2c = coup2 
coup2 = cplcVWmVPVPVWm2Q
coup2a = coup2 
coup2 = cplcVWmVPVPVWm3Q
coup2b = coup2 
Call Amp_VERTEX_StoVV_Topology2_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2a,coup2b,coup2c,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 


! {Hpm, VP}
Do i1=1,2
ML1 = MHpm(i1) 
ML2 = MVP 
coup1 = cplHpmcHpmVPVP1(i1,gt1)
coup2 = cplcHpmVPVWm(i1)
Call Amp_VERTEX_StoVV_Topology4_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 

End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmToVPVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocSvVWm(MHpm,MHpm2,MSv,MSv2,MVWm,            & 
& MVWm2,ZfHpm,ZfSv,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSv(3,3),ZfVWm

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
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_HpmTocSvVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocSvVWm(MFd,MFe,MFu,MHpm,MSd,              & 
& MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,       & 
& cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),        & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),    & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),         & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(i2,i1,gt1)
coup1R = cplcFuFdcHpmR(i2,i1,gt1)
coup2L = cplcFdFdcSvL(i1,i3,gt2)
coup2R = cplcFdFdcSvR(i1,i3,gt2)
coup3L = -cplcFdFuVWmR(i3,i2)
coup3R = -cplcFdFuVWmL(i3,i2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecHpmL(i2,i1,gt1)
coup1R = cplFvFecHpmR(i2,i1,gt1)
coup2L = cplcFeFecSvL(i1,i3,gt2)
coup2R = cplcFeFecSvR(i1,i3,gt2)
coup3L = -cplcFeFvVWmR(i3,i2)
coup3R = -cplcFeFvVWmL(i3,i2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i1,gt1,i2)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = -cplSucSdVWm(i2,i3)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecHpmcSv(i1,gt1,i2)
coup2 = cplSecSecSv(i3,i1,gt2)
coup3 = -cplSvcSeVWm(i2,i3)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_HpmTocSvVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvVWm(MFd,MFe,MFu,MHpm,               & 
& MSd,MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdcSvL,      & 
& cplcFdFdcSvR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFvFecHpmL,cplFvFecHpmR,cplcFeFecSvL,       & 
& cplcFeFecSvR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSecHpmcSv,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),        & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),    & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),       & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),         & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

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
Mex1 = MHpm(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_HpmTocSvVWm



End Module OneLoopDecay_Hpm_MSSMTriLnV
