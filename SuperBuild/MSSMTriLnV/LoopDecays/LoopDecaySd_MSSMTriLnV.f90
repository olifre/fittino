! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:53 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Sd_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_SdToSdAh(cplAhSdcSd,MAh,MSd,MAh2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MSd(6),MAh2(2),MSd2(6)

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MAh(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhSdcSd(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSdAh


Subroutine Gamma_Real_MSSMTriLnV_SdToSdAh(MLambda,em,gs,cplAhSdcSd,MAh,               & 
& MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6)

Real(dp), Intent(in) :: MAh(2),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=2,2
Coup = cplAhSdcSd(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MSd(i2)
Mex3 = MAh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,1._dp/9._dp,0._dp,1._dp/9._dp,0._dp,0._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSdAh


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdAh(cplAhSdcSd,ctcplAhSdcSd,MAh,            & 
& MAh2,MSd,MSd2,ZfAh,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6)

Complex(dp), Intent(in) :: ctcplAhSdcSd(2,6,6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MAh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhSdcSd(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplAhSdcSd(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt2)*cplAhSdcSd(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt3)*cplAhSdcSd(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdAh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
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

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MAh(gt3) 


! {Ah, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
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


! {Cha, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChacFuSdL(i1,i3,gt2)
coup2R = cplcChacFuSdR(i1,i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
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


! {Chi, bar[Fd], bar[Fd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFdChiSdL(i3,i1,gt2)
coup2R = cplcFdChiSdR(i3,i1,gt2)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
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


! {Fd, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,i3,gt2)
coup2R = cplcFdChiSdR(i1,i3,gt2)
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


! {Fe, bar[Fu], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFecFuSdL(i1,i3,gt2)
coup2R = cplcFecFuSdR(i1,i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
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


! {Fu, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i3,i1,gt2)
coup2R = cplcChacFuSdR(i3,i1,gt2)
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


! {Fu, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i3,i1,gt2)
coup2R = cplcFecFuSdR(i3,i1,gt2)
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


! {Fv, bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplcFdFvSdL(i3,i1,gt2)
coup2R = cplcFdFvSdR(i3,i1,gt2)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
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


! {Glu, bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFdGluSdL(i3,gt2)
coup2R = cplcFdGluSdR(i3,gt2)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
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


! {Hpm, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
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


! {Sd, hh, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplAhSdcSd(i3,gt2,i1)
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


! {Sd, Ah, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, VZ, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, hh, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = -cplSdcSdVZ(gt2,i1)
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


! {Se, conj[Su], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
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


! {Su, conj[Hpm], conj[Hpm]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[VWm], conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[Se], conj[Se]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = cplSdcSecSu(gt2,i3,i1)
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


! {Su, conj[Hpm], conj[VWm]}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = -cplSdcSucVWm(gt2,i1)
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


! {Sv, conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(gt2,i3,i1)
coup3 = cplAhSdcSd(gt3,i3,i2)
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


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSdcSdVG(gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSdcSdVP(gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSdVWm(i2,gt1)
coup2 = -cplSdcSucVWm(gt2,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = -cplSdcSdVZ(gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplSdSvcSd(gt2,i1,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
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


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhAhSdcSdaa(gt3,i1,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplAhSdcHpmcSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplAhSdSvcSdaa(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplAhSdcSdcSvaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplAhSdcSecSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhAhSdcSdaa(gt3,i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplAhHpmSucSdaa(gt3,i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSdcSdcSvaa(gt3,i1,gt1,i2)
coup2 = cplSdSvcSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSdSvcSdaa(gt3,i1,i2,gt1)
coup2 = cplSdcSdcSv(gt2,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSeSucSdaa(gt3,i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i2)
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
coup1 = cplHpmSdcHpmcSdaa(i1,gt2,i2,gt1)
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
coup1 = cplSdSdcSdcSdabba(gt2,i1,gt1,i2)
coup2 = cplAhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSdcSdcSdabab(gt2,i1,gt1,i2)
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
coup1 = cplSdSecSdcSeaa(gt2,i1,gt1,i2)
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
coup1 = cplSdSucSdcSuabba(gt2,i1,gt1,i2)
coup2 = cplAhSucSu(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSucSdcSuabab(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh(MAh,MCha,MChi,MFd,MFe,             & 
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

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MAh(gt3) 


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSdcSdVG(gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSdcSdVP(gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdAh


Subroutine Amplitude_Tree_MSSMTriLnV_SdToFuCha(cplChaFucSdL,cplChaFucSdR,             & 
& MCha,MFu,MSd,MCha2,MFu2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFu(3),MSd(6),MCha2(2),MFu2(3),MSd2(6)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6)

Complex(dp) :: Amp(2,6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MCha(gt3) 
! Tree-Level Vertex 
coupT1L = cplChaFucSdL(gt3,gt2,gt1)
coupT1R = cplChaFucSdR(gt3,gt2,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToFuCha


Subroutine Gamma_Real_MSSMTriLnV_SdToFuCha(MLambda,em,gs,cplChaFucSdL,cplChaFucSdR,   & 
& MCha,MFu,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6)

Real(dp), Intent(in) :: MCha(2),MFu(3),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,2), GammarealGluon(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
CoupL = cplChaFucSdL(i3,i2,i1)
CoupR = cplChaFucSdR(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MFu(i2)
Mex3 = MCha(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,-2._dp/9._dp,1._dp/3._dp,4._dp/9._dp,-2._dp/3._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToFuCha


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFuCha(cplChaFucSdL,cplChaFucSdR,             & 
& ctcplChaFucSdL,ctcplChaFucSdR,MCha,MCha2,MFu,MFu2,MSd,MSd2,ZfFUL,ZfFUR,ZfLm,           & 
& ZfLp,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MFu(3),MFu2(3),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6)

Complex(dp), Intent(in) :: ctcplChaFucSdL(2,3,6),ctcplChaFucSdR(2,3,6)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfLm(2,2),ZfLp(2,2),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MCha(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChaFucSdL(gt3,gt2,gt1) 
ZcoupT1R = ctcplChaFucSdR(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplChaFucSdL(gt3,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplChaFucSdR(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplChaFucSdL(gt3,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplChaFucSdR(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLm(i1,gt3)*cplChaFucSdL(i1,gt2,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLp(i1,gt3))*cplChaFucSdR(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFuCha


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFuCha(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),      & 
& cplAhSdcSd(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),       & 
& cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcFdChaSuL(3,2,6),     & 
& cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcChaChaVPL(2,2),        & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiFdcSdL(4,3,6),          & 
& cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplFeFucSdL(3,3,6),             & 
& cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplhhSdcSd(2,6,6),& 
& cplHpmSucSd(2,6,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3), & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MCha(gt3) 


! {Ah, conj[Sd], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
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


! {Chi, bar[Fd], conj[Su]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3L = cplcFdChaSuL(i2,gt3,i3)
coup3R = cplcFdChaSuR(i2,gt3,i3)
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


! {Fd, Chi, Hpm}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MHpm(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
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


! {Fd, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
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


! {Fd, Chi, VWm}
Do i1=1,3
  Do i2=1,4
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MVWm 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
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


! {Fu, bar[Cha], Ah}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MAh(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
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


! {Fu, bar[Cha], hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = Mhh(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
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


! {Fu, bar[Cha], VP}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MVP 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = -cplcFuFuVPR(i1,gt2)
coup2R = -cplcFuFuVPL(i1,gt2)
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


! {Fu, bar[Cha], VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MVZ 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
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


! {Glu, bar[Fd], conj[Su]}
  Do i2=1,3
    Do i3=1,6
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3L = cplcFdChaSuL(i2,gt3,i3)
coup3R = cplcFdChaSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
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


! {Sd, Ah, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MCha(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, hh, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MCha(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, VP, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, VZ, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MCha(i3) 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Su, conj[Hpm], Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
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


! {Su, conj[VWm], Chi}
Do i1=1,6
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MChi(i3) 
coup1 = -cplSucSdVWm(i1,gt1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
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


! {VG, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVP(i2,gt1)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVZ(i2,gt1)
coup2L = -cplcFuFuVZR(i3,gt2)
coup2R = -cplcFuFuVZL(i3,gt2)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFuCha


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,        & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,     & 
& cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,       & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),      & 
& cplAhSdcSd(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),       & 
& cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcFdChaSuL(3,2,6),     & 
& cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcChaChaVPL(2,2),        & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiFdcSdL(4,3,6),          & 
& cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplFeFucSdL(3,3,6),             & 
& cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplhhSdcSd(2,6,6),& 
& cplHpmSucSd(2,6,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3), & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MCha(gt3) 


! {Fu, bar[Cha], VP}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MVP 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = -cplcFuFuVPR(i1,gt2)
coup2R = -cplcFuFuVPL(i1,gt2)
coup3L = cplcChaChaVPL(i2,gt3)
coup3R = cplcChaChaVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, VP, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = cplcChaChaVPL(i3,gt3)
coup3R = cplcChaChaVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VG, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVP(i2,gt1)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplChaFucSdL(gt3,i3,i2)
coup3R = cplChaFucSdR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuCha


Subroutine Amplitude_Tree_MSSMTriLnV_SdToFdChi(cplChiFdcSdL,cplChiFdcSdR,             & 
& MChi,MFd,MSd,MChi2,MFd2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MSd(6),MChi2(4),MFd2(3),MSd2(6)

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6)

Complex(dp) :: Amp(2,6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,4
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MChi(gt3) 
! Tree-Level Vertex 
coupT1L = cplChiFdcSdL(gt3,gt2,gt1)
coupT1R = cplChiFdcSdR(gt3,gt2,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToFdChi


Subroutine Gamma_Real_MSSMTriLnV_SdToFdChi(MLambda,em,gs,cplChiFdcSdL,cplChiFdcSdR,   & 
& MChi,MFd,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6)

Real(dp), Intent(in) :: MChi(4),MFd(3),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,4), GammarealGluon(6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
CoupL = cplChiFdcSdL(i3,i2,i1)
CoupR = cplChiFdcSdR(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MFd(i2)
Mex3 = MChi(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,1._dp/9._dp,0._dp,1._dp/9._dp,0._dp,0._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToFdChi


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFdChi(cplChiFdcSdL,cplChiFdcSdR,             & 
& ctcplChiFdcSdL,ctcplChiFdcSdR,MChi,MChi2,MFd,MFd2,MSd,MSd2,ZfFDL,ZfFDR,ZfL0,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MFd(3),MFd2(3),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6)

Complex(dp), Intent(in) :: ctcplChiFdcSdL(4,3,6),ctcplChiFdcSdR(4,3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfL0(4,4),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,4
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MChi(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChiFdcSdL(gt3,gt2,gt1) 
ZcoupT1R = ctcplChiFdcSdR(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplChiFdcSdL(gt3,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplChiFdcSdR(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt2)*cplChiFdcSdL(gt3,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt2))*cplChiFdcSdR(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt3)*cplChiFdcSdL(i1,gt2,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt3))*cplChiFdcSdR(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFdChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFdChi(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,      & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,       & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),        & 
& cplAhSdcSd(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),            & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),  & 
& cplSeSucSd(6,6,6),cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MChi(gt3) 


! {Ah, conj[Sd], bar[Fd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2L = cplcFdFdAhL(i3,gt2,i1)
coup2R = cplcFdFdAhR(i3,gt2,i1)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
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


! {Cha, bar[Fu], conj[Su]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChaFdcSuL(i1,gt2,i3)
coup2R = cplcChaFdcSuR(i1,gt2,i3)
coup3L = cplcFuChiSuL(i2,gt3,i3)
coup3R = cplcFuChiSuR(i2,gt3,i3)
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


! {Chi, bar[Fd], conj[Sd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFdcSdL(i1,gt2,i3)
coup2R = cplChiFdcSdR(i1,gt2,i3)
coup3L = cplcFdChiSdL(i2,gt3,i3)
coup3R = cplcFdChiSdR(i2,gt3,i3)
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


! {Fd, Chi, Ah}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MAh(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,gt2,i3)
coup2R = cplcFdFdAhR(i1,gt2,i3)
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


! {Fd, Chi, hh}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = Mhh(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
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


! {Fd, Fv, Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,gt2,i3)
coup2R = cplcFdFdSvR(i1,gt2,i3)
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


! {Fd, Chi, VZ}
Do i1=1,3
  Do i2=1,4
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MVZ 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = -cplcFdFdVZR(i1,gt2)
coup2R = -cplcFdFdVZL(i1,gt2)
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


! {Fd, Fv, conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdcSvL(i1,gt2,i3)
coup2R = cplcFdFdcSvR(i1,gt2,i3)
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


! {Fe, bar[Fu], conj[Su]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFeFdcSuL(i1,gt2,i3)
coup2R = cplcFeFdcSuR(i1,gt2,i3)
coup3L = cplcFuChiSuL(i2,gt3,i3)
coup3R = cplcFuChiSuR(i2,gt3,i3)
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


! {Fu, bar[Cha], conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MHpm(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
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


! {Fu, bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
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


! {Fu, bar[Cha], conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MVWm 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
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


! {Fv, bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplFvFdcSdL(i1,gt2,i3)
coup2R = cplFvFdcSdR(i1,gt2,i3)
coup3L = cplcFdChiSdL(i2,gt3,i3)
coup3R = cplcFdChiSdR(i2,gt3,i3)
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


! {Glu, bar[Fd], conj[Sd]}
  Do i2=1,3
    Do i3=1,6
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplGluFdcSdL(gt2,i3)
coup2R = cplGluFdcSdR(gt2,i3)
coup3L = cplcFdChiSdL(i2,gt3,i3)
coup3R = cplcFdChiSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], bar[Fd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2L = cplcFdFdhhL(i3,gt2,i1)
coup2R = cplcFdFdhhR(i3,gt2,i1)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
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


! {Hpm, conj[Su], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2L = cplcFuFdcHpmL(i3,gt2,i1)
coup2R = cplcFuFdcHpmR(i3,gt2,i1)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
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


! {Sd, Ah, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MChi(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
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


! {Sd, hh, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MChi(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
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


! {Sd, VZ, Chi}
Do i1=1,6
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MChi(i3) 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
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


! {Sd, Sv, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = cplChiFvSvL(gt3,i3,i2)
coup3R = cplChiFvSvR(gt3,i3,i2)
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


! {Sd, conj[Sv], Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = cplChiFvcSvL(gt3,i3,i2)
coup3R = cplChiFvcSvR(gt3,i3,i2)
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


! {Se, conj[Su], bar[Fu]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2L = cplcFuFdcSeL(i3,gt2,i1)
coup2R = cplcFuFdcSeR(i3,gt2,i1)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
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


! {Su, conj[Hpm], bar[Cha]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2L = cplcChaFdcSuL(i3,gt2,i1)
coup2R = cplcChaFdcSuR(i3,gt2,i1)
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


! {Su, conj[VWm], bar[Cha]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MCha(i3) 
coup1 = -cplSucSdVWm(i1,gt1)
coup2L = cplcChaFdcSuL(i3,gt2,i1)
coup2R = cplcChaFdcSuR(i3,gt2,i1)
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


! {Su, conj[Se], bar[Fe]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2L = cplcFeFdcSuL(i3,gt2,i1)
coup2R = cplcFeFdcSuR(i3,gt2,i1)
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


! {Sv, conj[Sd], bar[Fd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2L = cplcFdFdcSvL(i3,gt2,i1)
coup2R = cplcFdFdcSvR(i3,gt2,i1)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
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


! {VG, conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVP(i2,gt1)
coup2L = -cplcFdFdVPR(i3,gt2)
coup2R = -cplcFdFdVPL(i3,gt2)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, conj[Su], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = -cplSucSdVWm(i2,gt1)
coup2L = -cplcFuFdcVWmR(i3,gt2)
coup2R = -cplcFuFdcVWmL(i3,gt2)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVZ(i2,gt1)
coup2L = -cplcFdFdVZR(i3,gt2)
coup2R = -cplcFdFdVZL(i3,gt2)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], bar[Fd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2L = cplcFdFdSvL(i3,gt2,i1)
coup2R = cplcFdFdSvR(i3,gt2,i1)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFdChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,      & 
& cplChiChiAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChiChacHpmL,cplChiChacHpmR,         & 
& cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,     & 
& cplChiChiVZL,cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,     & 
& cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,       & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFeFucSdL,cplFeFucSdR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,       & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),        & 
& cplAhSdcSd(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),            & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),  & 
& cplSeSucSd(6,6,6),cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MChi(gt3) 


! {VG, conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVP(i2,gt1)
coup2L = -cplcFdFdVPR(i3,gt2)
coup2R = -cplcFdFdVPL(i3,gt2)
coup3L = cplChiFdcSdL(gt3,i3,i2)
coup3R = cplChiFdcSdR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFdChi


Subroutine Amplitude_Tree_MSSMTriLnV_SdToFvFd(cplFvFdcSdL,cplFvFdcSdR,MFd,            & 
& MSd,MFd2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MSd(6),MFd2(3),MSd2(6)

Complex(dp), Intent(in) :: cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6)

Complex(dp) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSd(gt1) 
Mex2 = 0. 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplFvFdcSdL(gt2,gt3,gt1)
coupT1R = cplFvFdcSdR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToFvFd


Subroutine Gamma_Real_MSSMTriLnV_SdToFvFd(MLambda,em,gs,cplFvFdcSdL,cplFvFdcSdR,      & 
& MFd,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6)

Real(dp), Intent(in) :: MFd(3),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,3), GammarealGluon(6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
CoupL = cplFvFdcSdL(i2,i3,i1)
CoupR = cplFvFdcSdR(i2,i3,i1)
Mex1 = MSd(i1)
Mex2 = 0.
Mex3 = MFd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,0._dp,1._dp/9._dp,0._dp,0._dp,1._dp/9._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToFvFd


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFvFd(cplFvFdcSdL,cplFvFdcSdR,ctcplFvFdcSdL,  & 
& ctcplFvFdcSdR,MFd,MFd2,MSd,MSd2,ZfFDL,ZfFDR,ZfFvL,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6)

Complex(dp), Intent(in) :: ctcplFvFdcSdL(3,3,6),ctcplFvFdcSdR(3,3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFvL(3,3),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSd(gt1) 
Mex2 = 0. 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplFvFdcSdL(gt2,gt3,gt1) 
ZcoupT1R = ctcplFvFdcSdR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplFvFdcSdL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplFvFdcSdR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFvL(i1,gt2)*cplFvFdcSdL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFvL(i1,gt2))*cplFvFdcSdR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplFvFdcSdL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplFvFdcSdR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFvFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFvFd(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,            & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,              & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),          & 
& cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFdcSdL(4,3,6),       & 
& cplChiFdcSdR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),            & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),           & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),& 
& cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),         & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),              & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = 0. 
Mex3 = MFd(gt3) 


! {Cha, bar[Fu], Se}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MSe(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChaFvSeL(i1,gt2,i3)
coup2R = cplcChaFvSeR(i1,gt2,i3)
coup3L = cplcFuFdcSeL(i2,gt3,i3)
coup3R = cplcFuFdcSeR(i2,gt3,i3)
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


! {Chi, bar[Fd], Sv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,gt2,i3)
coup2R = cplChiFvSvR(i1,gt2,i3)
coup3L = cplcFdFdcSvL(i2,gt3,i3)
coup3R = cplcFdFdcSvR(i2,gt3,i3)
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


! {Chi, bar[Fd], conj[Sv]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,gt2,i3)
coup2R = cplChiFvcSvR(i1,gt2,i3)
coup3L = cplcFdFdSvL(i2,gt3,i3)
coup3R = cplcFdFdSvR(i2,gt3,i3)
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


! {Fd, Chi, Sd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3L = cplChiFdcSdL(i2,gt3,i3)
coup3R = cplChiFdcSdR(i2,gt3,i3)
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


! {Fd, Fv, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MSd(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3L = cplFvFdcSdL(i2,gt3,i3)
coup3R = cplFvFdcSdR(i2,gt3,i3)
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


! {Fd, Glu, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MGlu 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,gt1)
coup1R = cplGluFdcSdR(i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3L = cplGluFdcSdL(gt3,i3)
coup3R = cplGluFdcSdR(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fe, bar[Fu], Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MHpm(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i1,gt2,i3)
coup2R = cplcFeFvHpmR(i1,gt2,i3)
coup3L = cplcFuFdcHpmL(i2,gt3,i3)
coup3R = cplcFuFdcHpmR(i2,gt3,i3)
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


! {Fe, bar[Fu], Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MSe(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
coup3L = cplcFuFdcSeL(i2,gt3,i3)
coup3R = cplcFuFdcSeR(i2,gt3,i3)
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


! {Fe, bar[Fu], VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MVWm 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = -cplcFeFvVWmR(i1,gt2)
coup2R = -cplcFeFvVWmL(i1,gt2)
coup3L = cplcFuFdcVWmL(i2,gt3)
coup3R = cplcFuFdcVWmR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fv, bar[Fd], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MVZ 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplFvFvVZL(gt2,i1)
coup2R = cplFvFvVZR(gt2,i1)
coup3L = cplcFdFdVZL(i2,gt3)
coup3R = cplcFdFdVZR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su], Fe}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
coup3L = cplcFeFdcSuL(i3,gt3,i2)
coup3R = cplcFeFdcSuR(i3,gt3,i2)
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


! {Sd, Ah, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdAhL(i3,gt3,i2)
coup3R = cplcFdFdAhR(i3,gt3,i2)
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


! {Sd, hh, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdhhL(i3,gt3,i2)
coup3R = cplcFdFdhhR(i3,gt3,i2)
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


! {Sd, Sv, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdSvL(i3,gt3,i2)
coup3R = cplcFdFdSvR(i3,gt3,i2)
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


! {Sd, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVG(i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdVGL(i3,gt3)
coup3R = cplcFdFdVGR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, VZ, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdVZL(i3,gt3)
coup3R = cplcFdFdVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, conj[Sv], Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdcSvL(i3,gt3,i2)
coup3R = cplcFdFdcSvR(i3,gt3,i2)
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


! {Se, conj[Su], Cha}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
coup3L = cplcChaFdcSuL(i3,gt3,i2)
coup3R = cplcChaFdcSuR(i3,gt3,i2)
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


! {Se, conj[Su], Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeFdcSuL(i3,gt3,i2)
coup3R = cplcFeFdcSuR(i3,gt3,i2)
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


! {Sv, conj[Sd], Chi}
Do i1=1,3
  Do i2=1,6
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2L = cplChiFvcSvL(i3,gt2,i1)
coup2R = cplChiFvcSvR(i3,gt2,i1)
coup3L = cplChiFdcSdL(i3,gt3,i2)
coup3R = cplChiFdcSdR(i3,gt3,i2)
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


! {VWm, conj[Su], Fe}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = -cplSucSdVWm(i2,gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
coup3L = cplcFeFdcSuL(i3,gt3,i2)
coup3R = cplcFeFdcSuR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], Fv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = 0. 
coup1 = -cplSdcSdVZ(i2,gt1)
coup2L = cplFvFvVZL(gt2,i3)
coup2R = cplFvFvVZR(gt2,i3)
coup3L = cplFvFdcSdL(i3,gt3,i2)
coup3R = cplFvFdcSdR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], Chi}
Do i1=1,3
  Do i2=1,6
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2L = cplChiFvSvL(i3,gt2,i1)
coup2R = cplChiFvSvR(i3,gt2,i1)
coup3L = cplChiFdcSdL(i3,gt3,i2)
coup3R = cplChiFdcSdR(i3,gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFvFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,            & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,           & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,         & 
& cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSdcSd,cplHpmSucSd,              & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),          & 
& cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFdcSdL(4,3,6),       & 
& cplChiFdcSdR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),            & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),           & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),& 
& cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),         & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),           & 
& cplcFeFvVWmR(3,3),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),              & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = 0. 
Mex3 = MFd(gt3) 


! {Sd, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVG(i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdVGL(i3,gt3)
coup3R = cplcFdFdVGR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFvFd


Subroutine Amplitude_Tree_MSSMTriLnV_SdToGluFd(cplGluFdcSdL,cplGluFdcSdR,             & 
& MFd,MGlu,MSd,MFd2,MGlu2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MFd2(3),MGlu2,MSd2(6)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6)

Complex(dp) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
    Do gt3=1,3
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MGlu 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplGluFdcSdL(gt3,gt1)
coupT1R = cplGluFdcSdR(gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt3) = AmpC 
    End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToGluFd


Subroutine Gamma_Real_MSSMTriLnV_SdToGluFd(MLambda,em,gs,cplGluFdcSdL,cplGluFdcSdR,   & 
& MFd,MGlu,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6)

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3), GammarealGluon(6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
    Do i3=1,3
CoupL = cplGluFdcSdL(i3,i1)
CoupR = cplGluFdcSdR(i3,i1)
Mex1 = MSd(i1)
Mex2 = MGlu
Mex3 = MFd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,4._dp/27._dp,0._dp,4._dp/27._dp,0._dp,0._dp,4._dp/27._dp,CoupL,CoupR,Gammarealphoton(i1,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,16._dp/9._dp,2._dp,-2._dp/9._dp,4._dp,-2._dp,16._dp/9._dp,CoupL,CoupR,Gammarealgluon(i1,i3),kont)
Else 
  GammarealGluon(i1,i3) = 0._dp 
  GammarealPhoton(i1,i3) = 0._dp 

End if 
    End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToGluFd


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToGluFd(cplGluFdcSdL,cplGluFdcSdR,             & 
& ctcplGluFdcSdL,ctcplGluFdcSdR,MFd,MFd2,MGlu,MGlu2,MSd,MSd2,ZfFDL,ZfFDR,ZffG,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MGlu,MGlu2,MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6)

Complex(dp), Intent(in) :: ctcplGluFdcSdL(3,6),ctcplGluFdcSdR(3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZffG,ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
    Do gt3=1,3
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MGlu 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplGluFdcSdL(gt3,gt1) 
ZcoupT1R = ctcplGluFdcSdR(gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplGluFdcSdL(gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplGluFdcSdR(gt3,i1)
End Do


! External Field 2 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZffG*cplGluFdcSdL(gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZffG)*cplGluFdcSdR(gt3,gt1)


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplGluFdcSdL(i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplGluFdcSdR(i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt3) = 4._dp/3._dp*AmpC 
    End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToGluFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToGluFd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,        & 
& cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),          & 
& cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),             & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),       & 
& cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),              & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
    Do gt3=1,3
Amp(:,gt1, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MGlu 
Mex3 = MFd(gt3) 


! {Fd, Chi, Sd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3L = cplChiFdcSdL(i2,gt3,i3)
coup3R = cplChiFdcSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Fv, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MSd(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3L = cplFvFdcSdL(i2,gt3,i3)
coup3R = cplFvFdcSdR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Glu, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MGlu 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,gt1)
coup1R = cplGluFdcSdR(i1,gt1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3L = cplGluFdcSdL(gt3,i3)
coup3R = cplGluFdcSdR(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Fu, bar[Cha], Su}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MSu(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3L = cplcChaFdcSuL(i2,gt3,i3)
coup3R = cplcChaFdcSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, bar[Fe], Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MSu(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3L = cplcFeFdcSuL(i2,gt3,i3)
coup3R = cplcFeFdcSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Glu, bar[Fd], VG}
  Do i2=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplcFdFdVGL(i2,gt3)
coup3R = cplcFdFdVGR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(2*(0.,1._dp))*AmpC 
  End Do


! {Sd, Ah, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdAhL(i3,gt3,i2)
coup3R = cplcFdFdAhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, hh, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdhhL(i3,gt3,i2)
coup3R = cplcFdFdhhR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Sv, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdSvL(i3,gt3,i2)
coup3R = cplcFdFdSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVG(i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdVGL(i3,gt3)
coup3R = cplcFdFdVGR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VZ, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdVZL(i3,gt3)
coup3R = cplcFdFdVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, conj[Sv], Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdcSvL(i3,gt3,i2)
coup3R = cplcFdFdcSvR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, conj[Hpm], Fu}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MFu(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFdcHpmL(i3,gt3,i2)
coup3R = cplcFuFdcHpmR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, conj[Se], Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFdcSeL(i3,gt3,i2)
coup3R = cplcFuFdcSeR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, conj[VWm], Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MFu(i3) 
coup1 = -cplSucSdVWm(i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFdcVWmL(i3,gt3)
coup3R = cplcFuFdcVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VG, conj[Sd], Glu}
  Do i2=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MGlu 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplGluFdcSdL(gt3,i2)
coup3R = cplGluFdcSdR(gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2*(0.,1._dp))*AmpC 
  End Do
    End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToGluFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,        & 
& cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),          & 
& cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),             & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),       & 
& cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),              & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
    Do gt3=1,3
Amp(:,gt1, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MGlu 
Mex3 = MFd(gt3) 


! {Glu, bar[Fd], VG}
  Do i2=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplcFdFdVGL(i2,gt3)
coup3R = cplcFdFdVGR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(2*(0.,1._dp))*AmpC 
  End Do


! {Sd, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVG(i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdVGL(i3,gt3)
coup3R = cplcFdFdVGR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VG, conj[Sd], Glu}
  Do i2=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MGlu 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplGluFdcSdL(gt3,i2)
coup3R = cplGluFdcSdR(gt3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2*(0.,1._dp))*AmpC 
  End Do
    End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToGluFd


Subroutine Amplitude_Tree_MSSMTriLnV_SdToFuFe(cplFeFucSdL,cplFeFucSdR,MFe,            & 
& MFu,MSd,MFe2,MFu2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFu(3),MSd(6),MFe2(3),MFu2(3),MSd2(6)

Complex(dp), Intent(in) :: cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6)

Complex(dp) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFe(gt3) 
! Tree-Level Vertex 
coupT1L = cplFeFucSdL(gt3,gt2,gt1)
coupT1R = cplFeFucSdR(gt3,gt2,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToFuFe


Subroutine Gamma_Real_MSSMTriLnV_SdToFuFe(MLambda,em,gs,cplFeFucSdL,cplFeFucSdR,      & 
& MFe,MFu,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6)

Real(dp), Intent(in) :: MFe(3),MFu(3),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,3), GammarealGluon(6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
CoupL = cplFeFucSdL(i3,i2,i1)
CoupR = cplFeFucSdR(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MFu(i2)
Mex3 = MFe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,-2._dp/9._dp,1._dp/3._dp,4._dp/9._dp,-2._dp/3._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToFuFe


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFuFe(cplFeFucSdL,cplFeFucSdR,ctcplFeFucSdL,  & 
& ctcplFeFucSdR,MFe,MFe2,MFu,MFu2,MSd,MSd2,ZfFEL,ZfFER,ZfFUL,ZfFUR,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFe2(3),MFu(3),MFu2(3),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6)

Complex(dp), Intent(in) :: ctcplFeFucSdL(3,3,6),ctcplFeFucSdR(3,3,6)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplFeFucSdL(gt3,gt2,gt1) 
ZcoupT1R = ctcplFeFucSdR(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplFeFucSdL(gt3,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplFeFucSdR(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplFeFucSdL(gt3,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplFeFucSdR(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt3)*cplFeFucSdL(i1,gt2,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt3))*cplFeFucSdR(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToFuFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFuFe(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,            & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,             & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,           & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvFecHpmL(3,3,2),           & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),            & 
& cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),             & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),               & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),        & 
& cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),           & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),            & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplhhSdcSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6), & 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFe(gt3) 


! {Ah, conj[Sd], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
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


! {Chi, bar[Fd], conj[Su]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3L = cplcFdFeSuL(i2,gt3,i3)
coup3R = cplcFdFeSuR(i2,gt3,i3)
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


! {Fd, Fv, Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MHpm(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
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


! {Fd, Chi, Se}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MSe(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
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


! {Fd, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
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


! {Fd, Fv, VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MVWm 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
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


! {Fu, bar[Fe], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MAh(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
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


! {Fu, bar[Fe], hh}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = Mhh(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
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


! {Fu, bar[Fe], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = -cplcFuFuVPR(i1,gt2)
coup2R = -cplcFuFuVPL(i1,gt2)
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


! {Fu, bar[Fe], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MVZ 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
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


! {Glu, bar[Fd], conj[Su]}
  Do i2=1,3
    Do i3=1,6
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3L = cplcFdFeSuL(i2,gt3,i3)
coup3R = cplcFdFeSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
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


! {Sd, conj[Sv], Cha}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MCha(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, Ah, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, hh, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, VP, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, VZ, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, conj[Sv], Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Su, conj[Se], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
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


! {VG, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVP(i2,gt1)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVZ(i2,gt1)
coup2L = -cplcFuFuVZR(i3,gt2)
coup2R = -cplcFuFuVZL(i3,gt2)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToFuFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,             & 
& cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,           & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,cplcChaFecSvR,           & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,           & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvFecHpmL(3,3,2),           & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),            & 
& cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),             & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),               & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),        & 
& cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),           & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),            & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplhhSdcSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6), & 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6)

Complex(dp), Intent(out) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFe(gt3) 


! {Fu, bar[Fe], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MVP 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = -cplcFuFuVPR(i1,gt2)
coup2R = -cplcFuFuVPL(i1,gt2)
coup3L = cplcFeFeVPL(i2,gt3)
coup3R = cplcFeFeVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, VP, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = -cplSdcSdVP(i1,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeFeVPL(i3,gt3)
coup3R = cplcFeFeVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VG, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVG(i2,gt1)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MFu(i3) 
coup1 = -cplSdcSdVP(i2,gt1)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToFuFe


Subroutine Amplitude_Tree_MSSMTriLnV_SdToSdhh(cplhhSdcSd,Mhh,MSd,Mhh2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),MSd(6),Mhh2(2),MSd2(6)

Complex(dp), Intent(in) :: cplhhSdcSd(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = Mhh(gt3) 
! Tree-Level Vertex 
coupT1 = cplhhSdcSd(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSdhh


Subroutine Gamma_Real_MSSMTriLnV_SdToSdhh(MLambda,em,gs,cplhhSdcSd,Mhh,               & 
& MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplhhSdcSd(2,6,6)

Real(dp), Intent(in) :: Mhh(2),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
Coup = cplhhSdcSd(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MSd(i2)
Mex3 = Mhh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,1._dp/9._dp,0._dp,1._dp/9._dp,0._dp,0._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSdhh


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdhh(cplhhSdcSd,ctcplhhSdcSd,Mhh,            & 
& Mhh2,MSd,MSd2,Zfhh,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplhhSdcSd(2,6,6)

Complex(dp), Intent(in) :: ctcplhhSdcSd(2,6,6)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = Mhh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplhhSdcSd(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplhhSdcSd(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt2)*cplhhSdcSd(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt3)*cplhhSdcSd(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdhh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,       & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,     & 
& cplhhSdSvcSdaa,cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,        & 
& cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,& 
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),& 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),     & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),     & 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSucSdVWm(6,6),               & 
& cplAhAhSdcSdaa(2,2,6,6),cplhhhhSdcSdaa(2,2,6,6),cplhhHpmSucSdaa(2,2,6,6),              & 
& cplhhSdSvcSdaa(2,6,3,6),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSdcSvaa(2,6,6,3),            & 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSeSucSdaa(2,6,6,6),cplHpmSdcHpmcSdaa(2,6,2,6),           & 
& cplSdSdcSdcSdabba(6,6,6,6),cplSdSdcSdcSdabab(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),        & 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),cplSdSvcSdcSvaa(6,3,6,3),        & 
& cplSdcSdcVWmVWmaa(6,6),cplSdcSdVZVZaa(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = Mhh(gt3) 


! {Ah, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
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


! {Cha, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChacFuSdL(i1,i3,gt2)
coup2R = cplcChacFuSdR(i1,i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
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


! {Chi, bar[Fd], bar[Fd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFdChiSdL(i3,i1,gt2)
coup2R = cplcFdChiSdR(i3,i1,gt2)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
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


! {Fd, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,i3,gt2)
coup2R = cplcFdChiSdR(i1,i3,gt2)
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


! {Fe, bar[Fu], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFecFuSdL(i1,i3,gt2)
coup2R = cplcFecFuSdR(i1,i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
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


! {Fu, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i3,i1,gt2)
coup2R = cplcChacFuSdR(i3,i1,gt2)
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


! {Fu, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i3,i1,gt2)
coup2R = cplcFecFuSdR(i3,i1,gt2)
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


! {Fv, bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplcFdFvSdL(i3,i1,gt2)
coup2R = cplcFdFvSdR(i3,i1,gt2)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
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


! {Glu, bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFdGluSdL(i3,gt2)
coup2R = cplcFdGluSdR(i3,gt2)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
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


! {Hpm, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
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


! {Sd, Ah, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplAhSdcSd(i3,gt2,i1)
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


! {Sd, VZ, Ah}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MAh(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplAhSdcSd(i3,gt2,i1)
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


! {Sd, hh, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSdSvcSd(gt2,i3,i1)
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


! {Sd, Ah, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MVZ 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = -cplSdcSdVZ(gt2,i1)
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


! {Sd, VZ, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = -cplSdcSdVZ(gt2,i1)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sd, conj[Sv], conj[Sv]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSdcSdcSv(gt2,i1,i3)
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


! {Se, conj[Su], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
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


! {Su, conj[Hpm], conj[Hpm]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[VWm], conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[Se], conj[Se]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = cplSdcSecSu(gt2,i3,i1)
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


! {Su, conj[Hpm], conj[VWm]}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = -cplSdcSucVWm(gt2,i1)
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


! {Su, conj[VWm], conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = -cplSdcSucVWm(gt2,i1)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(gt2,i3,i1)
coup3 = cplhhSdcSd(gt3,i3,i2)
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


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSdcSdVG(gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSdcSdVP(gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSdVWm(i2,gt1)
coup2 = -cplSdcSucVWm(gt2,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = -cplSdcSdVZ(gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplSdSvcSd(gt2,i1,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
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


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhhhSdcSdaa(gt3,i1,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplhhSdcHpmcSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplhhSdSvcSdaa(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplhhSdcSdcSvaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplhhSdcSecSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhhhSdcSdaa(gt3,i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplhhHpmSucSdaa(gt3,i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSdcSdcSvaa(gt3,i1,gt1,i2)
coup2 = cplSdSvcSd(gt2,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSdSvcSdaa(gt3,i1,i2,gt1)
coup2 = cplSdcSdcSv(gt2,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSeSucSdaa(gt3,i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i2)
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
coup1 = cplAhAhSdcSdaa(i1,i2,gt2,gt1)
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
coup1 = cplhhhhSdcSdaa(i1,i2,gt2,gt1)
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
coup1 = cplHpmSdcHpmcSdaa(i1,gt2,i2,gt1)
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
coup1 = cplSdSdcSdcSdabba(gt2,i1,gt1,i2)
coup2 = cplhhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSdcSdcSdabab(gt2,i1,gt1,i2)
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
coup1 = cplSdSecSdcSeaa(gt2,i1,gt1,i2)
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
coup1 = cplSdSucSdcSuabba(gt2,i1,gt1,i2)
coup2 = cplhhSucSu(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSucSdcSuabab(gt2,i1,gt1,i2)
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
coup1 = cplSdSvcSdcSvaa(gt2,i1,gt1,i2)
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
coup1 = cplSdcSdcVWmVWmaa(gt2,gt1)
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
coup1 = cplSdcSdVZVZaa(gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,         & 
& cplAhhhVZ,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,       & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSucSdVWm,cplAhAhSdcSdaa,cplhhhhSdcSdaa,cplhhHpmSucSdaa,     & 
& cplhhSdSvcSdaa,cplhhSdcHpmcSuaa,cplhhSdcSdcSvaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,        & 
& cplHpmSdcHpmcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecSdcSeaa,cplSdSucSdcSuabba,& 
& cplSdSucSdcSuabab,cplSdSvcSdcSvaa,cplSdcSdcVWmVWmaa,cplSdcSdVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),& 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),     & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),     & 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSucSdVWm(6,6),               & 
& cplAhAhSdcSdaa(2,2,6,6),cplhhhhSdcSdaa(2,2,6,6),cplhhHpmSucSdaa(2,2,6,6),              & 
& cplhhSdSvcSdaa(2,6,3,6),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSdcSvaa(2,6,6,3),            & 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSeSucSdaa(2,6,6,6),cplHpmSdcHpmcSdaa(2,6,2,6),           & 
& cplSdSdcSdcSdabba(6,6,6,6),cplSdSdcSdcSdabab(6,6,6,6),cplSdSecSdcSeaa(6,6,6,6),        & 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),cplSdSvcSdcSvaa(6,3,6,3),        & 
& cplSdcSdcVWmVWmaa(6,6),cplSdcSdVZVZaa(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = Mhh(gt3) 


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSdcSdVG(gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSdcSdVP(gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdhh


Subroutine Amplitude_Tree_MSSMTriLnV_SdToSuHpm(cplHpmSucSd,MHpm,MSd,MSu,              & 
& MHpm2,MSd2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MSd(6),MSu(6),MHpm2(2),MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplHpmSucSd(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MHpm(gt3) 
! Tree-Level Vertex 
coupT1 = cplHpmSucSd(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSuHpm


Subroutine Gamma_Real_MSSMTriLnV_SdToSuHpm(MLambda,em,gs,cplHpmSucSd,MHpm,            & 
& MSd,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplHpmSucSd(2,6,6)

Real(dp), Intent(in) :: MHpm(2),MSd(6),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=2,2
Coup = cplHpmSucSd(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MSu(i2)
Mex3 = MHpm(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,-2._dp/9._dp,1._dp/3._dp,4._dp/9._dp,-2._dp/3._dp,1._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSuHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSuHpm(cplHpmSucSd,ctcplHpmSucSd,             & 
& MHpm,MHpm2,MSd,MSd2,MSu,MSu2,ZfHpm,ZfSd,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSd(6),MSd2(6),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplHpmSucSd(2,6,6)

Complex(dp), Intent(in) :: ctcplHpmSucSd(2,6,6)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSd(6,6),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MHpm(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplHpmSucSd(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplHpmSucSd(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplHpmSucSd(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt3)*cplHpmSucSd(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSuHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSuHpm(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,      & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,             & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,     & 
& cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,              & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,            & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,         & 
& cplSucSdVWm,cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,              & 
& cplHpmSdcSdcSeaa,cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),            & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),             & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),             & 
& cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6), & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplAhHpmSucSdaa(2,2,6,6),& 
& cplhhHpmSucSdaa(2,2,6,6),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSdcSdcSeaa(2,6,6,6),         & 
& cplHpmSuSvcSdaa(2,6,3,6),cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSucSdcSvaa(2,6,6,3),         & 
& cplHpmSucSecSuaa(2,6,6,6),cplSdSucSdcSuabba(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),       & 
& cplSeSucSdcSvaa(6,6,6,3),cplSucSdVPVWmaa(6,6),cplSucSdVWmVZaa(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MHpm(gt3) 


! {Ah, conj[Sd], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
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


! {Chi, bar[Fd], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
coup3L = cplcFdFuHpmL(i2,i3,gt3)
coup3R = cplcFdFuHpmR(i2,i3,gt3)
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


! {Fd, Chi, Cha}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
coup3L = cplcFeFvHpmL(i3,i2,gt3)
coup3R = cplcFeFvHpmR(i3,i2,gt3)
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


! {Fu, bar[Cha], Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,i3,gt2)
coup2R = cplcFuChiSuR(i1,i3,gt2)
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


! {Glu, bar[Fd], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFdFuHpmL(i2,i3,gt3)
coup3R = cplcFdFuHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
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


! {Sd, Ah, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, hh, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
coup3 = cplHpmcHpmVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, VZ, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSeSucSd(i3,gt2,i1)
coup3 = cplHpmSvcSe(gt3,i2,i3)
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


! {Sd, Ah, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MVWm 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
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


! {Sd, hh, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
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


! {Sd, VP, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
coup3 = cplHpmcVWmVP(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VZ, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
coup3 = cplHpmcVWmVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[Hpm], Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, conj[VWm], Ah}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MAh(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, conj[Hpm], hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, conj[VWm], hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, conj[Hpm], VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = -cplSucSuVP(gt2,i1)
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


! {Su, conj[VWm], VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = -cplSucSuVP(gt2,i1)
coup3 = cplHpmcVWmVP(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[Hpm], VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = -cplSucSuVZ(gt2,i1)
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


! {Su, conj[VWm], VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = -cplSucSuVZ(gt2,i1)
coup3 = cplHpmcVWmVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = -cplSucSuVZ(gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhHpmSucSdaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhHpmSucSdaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplHpmSucHpmcSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplHpmSuSvcSdaa(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplHpmSucSdcSvaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplHpmSucSecSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhHpmSucSdaa(i1,gt3,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhHpmSucSdaa(i1,gt3,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
coup1 = cplHpmSdcHpmcSdaa(gt3,i1,i2,gt1)
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


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplHpmSdcSdcSeaa(gt3,i1,gt1,i2)
coup2 = cplSeSucSd(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhHpmSucSdaa(i1,i2,gt2,gt1)
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
coup1 = cplhhHpmSucSdaa(i1,i2,gt2,gt1)
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
coup1 = cplSdSucSdcSuabba(i1,gt2,gt1,i2)
coup2 = cplHpmSucSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

coup1 = cplSdSucSdcSuabab(i1,gt2,gt1,i2)
coup2 = cplHpmSucSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSucSdcSvaa(i1,gt2,gt1,i2)
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
coup1 = cplSucSdVPVWmaa(gt2,gt1)
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
coup1 = cplSucSdVWmVZaa(gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSuHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,      & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,             & 
& cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFuChiSuL,     & 
& cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSucSu,cplHpmSucSd,              & 
& cplHpmSvcSe,cplHpmcHpmVP,cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,            & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,         & 
& cplSucSdVWm,cplSucSuVZ,cplAhHpmSucSdaa,cplhhHpmSucSdaa,cplHpmSdcHpmcSdaa,              & 
& cplHpmSdcSdcSeaa,cplHpmSuSvcSdaa,cplHpmSucHpmcSuaa,cplHpmSucSdcSvaa,cplHpmSucSecSuaa,  & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucSdcSvaa,cplSucSdVPVWmaa,cplSucSdVWmVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),            & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),         & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),             & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),       & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),             & 
& cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6), & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplAhHpmSucSdaa(2,2,6,6),& 
& cplhhHpmSucSdaa(2,2,6,6),cplHpmSdcHpmcSdaa(2,6,2,6),cplHpmSdcSdcSeaa(2,6,6,6),         & 
& cplHpmSuSvcSdaa(2,6,3,6),cplHpmSucHpmcSuaa(2,6,2,6),cplHpmSucSdcSvaa(2,6,6,3),         & 
& cplHpmSucSecSuaa(2,6,6,6),cplSdSucSdcSuabba(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),       & 
& cplSeSucSdcSvaa(6,6,6,3),cplSucSdVPVWmaa(6,6),cplSucSdVWmVZaa(6,6)

Complex(dp), Intent(out) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MHpm(gt3) 


! {Sd, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
coup3 = cplHpmcHpmVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, VP, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
coup3 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[Hpm], VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = -cplSucSuVP(gt2,i1)
coup3 = cplHpmcHpmVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, conj[VWm], VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = -cplSucSuVP(gt2,i1)
coup3 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
coup3 = cplHpmSucSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplSucSdVPVWmaa(gt2,gt1)
coup2 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuHpm


Subroutine Amplitude_Tree_MSSMTriLnV_SdToSvSd(cplSdSvcSd,MSd,MSv,MSd2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSv(3),MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSdSvcSd(6,3,6)

Complex(dp) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdSvcSd(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSvSd


Subroutine Gamma_Real_MSSMTriLnV_SdToSvSd(MLambda,em,gs,cplSdSvcSd,MSd,               & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdSvcSd(6,3,6)

Real(dp), Intent(in) :: MSd(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,6), GammarealGluon(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
Coup = cplSdSvcSd(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MSv(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,0._dp,1._dp/9._dp,0._dp,0._dp,1._dp/9._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSvSd


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSvSd(cplSdSvcSd,ctcplSdSvcSd,MSd,            & 
& MSd2,MSv,MSv2,ZfSd,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSdSvcSd(6,3,6)

Complex(dp), Intent(in) :: ctcplSdSvcSd(6,3,6)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdSvcSd(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSdSvcSd(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSv(i1,gt2)*cplSdSvcSd(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdSvcSd(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSvSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSvSd(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,     & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,              & 
& cplhhSdSvcSdaa,cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,   & 
& cplSdSecSdcSeaa,cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFdcSdL(4,3,6),        & 
& cplChiFdcSdR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFdChiSdL(3,4,6),         & 
& cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplFeFucSdL(3,3,6),            & 
& cplFeFucSdR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFdFvSdL(3,3,6),           & 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),              & 
& cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),             & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),& 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),              & 
& cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhSdSvcSdaa(2,6,3,6),cplhhSdSvcSdaa(2,6,3,6),      & 
& cplHpmSuSvcSdaa(2,6,3,6),cplSdSdcSdcSdabba(6,6,6,6),cplSdSdcSdcSdabab(6,6,6,6),        & 
& cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),          & 
& cplSdSvcSdcSvaa(6,3,6,3),cplSdSvcSecSuaa(6,3,6,6)

Complex(dp), Intent(out) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 


! {Chi, bar[Fd], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
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


! {Fd, Chi, Fd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = cplcFdChiSdL(i3,i2,gt3)
coup3R = cplcFdChiSdR(i3,i2,gt3)
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


! {Fd, Fv, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = cplcFdFvSdL(i3,i2,gt3)
coup3R = cplcFdFvSdR(i3,i2,gt3)
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


! {Fd, Glu, Fd}
Do i1=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i1,gt1)
coup1R = cplGluFdcSdR(i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
coup3L = cplcFdGluSdL(i3,gt3)
coup3R = cplcFdGluSdR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fe, bar[Fu], Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
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


! {Fe, bar[Fu], Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
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


! {Fv, bar[Fd], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplChiFvSvL(i3,i1,gt2)
coup2R = cplChiFvSvR(i3,i1,gt2)
coup3L = cplcFdChiSdL(i2,i3,gt3)
coup3R = cplcFdChiSdR(i2,i3,gt3)
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


! {hh, conj[Sd], conj[Sv]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i3)
coup3 = cplSdSvcSd(gt3,i3,i2)
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


! {Sd, Ah, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplAhSdcSd(i2,gt3,i3)
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


! {Sd, hh, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplhhSdcSd(i2,gt3,i3)
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


! {Sd, Sv, Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdSvcSd(gt3,i2,i3)
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


! {Sd, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdVG(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, VZ, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, conj[Sv], Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdcSv(gt3,i3,i2)
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


! {Se, conj[Su], Hpm}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplSdcHpmcSu(gt3,i3,i2)
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


! {Se, conj[Su], Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplSdcSecSu(gt3,i3,i2)
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


! {Se, conj[Su], VWm}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = cplSdcSucVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sv, conj[Sd], hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
coup3 = cplhhSdcSd(i3,gt3,i2)
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


! {Sv, conj[Sd], VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = -cplSvcSvVZ(gt2,i1)
coup3 = cplSdcSdVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VZ, conj[Sd], conj[Sv]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = -cplSvcSvVZ(gt2,i3)
coup3 = cplSdSvcSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdSvcSdaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdSvcSdaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdSvcHpmcSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSdSvcSdcSvaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSdSvcSecSuaa(gt3,gt2,i1,i2)
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
coup1 = cplhhSdSvcSdaa(i1,gt3,i2,gt1)
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
coup1 = cplSdSdcSdcSdabba(gt3,i1,gt1,i2)
coup2 = cplSdSvcSd(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSdcSdcSdabab(gt3,i1,gt1,i2)
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
coup1 = cplSdSecHpmcSdaa(gt3,i1,i2,gt1)
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
coup1 = cplSdSecSdcSeaa(gt3,i1,gt1,i2)
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


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdSvcSdaa(i1,i2,gt2,gt1)
coup2 = cplAhSdcSd(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdSvcSdaa(i1,i2,gt2,gt1)
coup2 = cplhhSdcSd(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSuSvcSdaa(i1,i2,gt2,gt1)
coup2 = cplSdcHpmcSu(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSdcSvaa(i1,gt2,gt1,i2)
coup2 = cplSdSvcSd(gt3,i2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSvSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFvSvL,cplChiFvSvR,           & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplFeFucSdL,cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhSvcSv,               & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,     & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSvcSeVWm,cplSvcSvVZ,cplAhSdSvcSdaa,              & 
& cplhhSdSvcSdaa,cplHpmSuSvcSdaa,cplSdSdcSdcSdabba,cplSdSdcSdcSdabab,cplSdSecHpmcSdaa,   & 
& cplSdSecSdcSeaa,cplSdSvcHpmcSuaa,cplSdSvcSdcSvaa,cplSdSvcSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFdcSdL(4,3,6),        & 
& cplChiFdcSdR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFdChiSdL(3,4,6),         & 
& cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplFeFucSdL(3,3,6),            & 
& cplFeFucSdR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFdFvSdL(3,3,6),           & 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),              & 
& cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),             & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),& 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),              & 
& cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhSdSvcSdaa(2,6,3,6),cplhhSdSvcSdaa(2,6,3,6),      & 
& cplHpmSuSvcSdaa(2,6,3,6),cplSdSdcSdcSdabba(6,6,6,6),cplSdSdcSdcSdabab(6,6,6,6),        & 
& cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),          & 
& cplSdSvcSdcSvaa(6,3,6,3),cplSdSvcSecSuaa(6,3,6,6)

Complex(dp), Intent(out) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 


! {Sd, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdVG(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSdSvcSd(i3,gt2,i1)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSvSd


Subroutine Amplitude_Tree_MSSMTriLnV_SdToSdVZ(cplSdcSdVZ,MSd,MVZ,MSd2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MVZ,MSd2(6),MVZ2

Complex(dp), Intent(in) :: cplSdcSdVZ(6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1 = -cplSdcSdVZ(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSdVZ


Subroutine Gamma_Real_MSSMTriLnV_SdToSdVZ(MLambda,em,gs,cplSdcSdVZ,MSd,               & 
& MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcSdVZ(6,6)

Real(dp), Intent(in) :: MSd(6),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6), GammarealGluon(6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
Coup = cplSdcSdVZ(i2,i1)
Mex1 = MSd(i1)
Mex2 = MSd(i2)
Mex3 = MVZ
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,-1._dp/3._dp,-1._dp/3._dp,0._dp,Coup,Gammarealphoton(i1,i2),kont)
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,gs,1._dp,1._dp,0._dp,Coup,Gammarealgluon(i1,i2),kont)
 GammarealGluon(i1,i2) = GammarealGluon(i1,i2)*4._dp/3._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSdVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdVZ(cplSdcSdVP,cplSdcSdVZ,ctcplSdcSdVP,     & 
& ctcplSdcSdVZ,MSd,MSd2,MVP,MVP2,MVZ,MVZ2,ZfSd,ZfVPVZ,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplSdcSdVP(6,6),cplSdcSdVZ(6,6)

Complex(dp), Intent(in) :: ctcplSdcSdVP(6,6),ctcplSdcSdVZ(6,6)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfVPVZ,ZfVZ

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSdVZ(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSdcSdVZ(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt2)*cplSdcSdVZ(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVPVZ*cplSdcSdVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplSdcSdVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,              & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,         & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,     & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,    & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,  & 
& cplSucSdVWmVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),             & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),             & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplFvFvVZL(3,3),   & 
& cplFvFvVZR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),               & 
& cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplHpmcHpmVZ(2,2), & 
& cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),     & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),           & 
& cplSeSucSd(6,6,6),cplSecSeVZ(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplSvcSvVZ(3,3),    & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1(6,6),cplSdcSdVPVZaa(6,6),        & 
& cplSdcSdVZVZaa(6,6),cplSdcSucVWmVZaa(6,6),cplSucSdVWmVZaa(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVZ 


! {Ah, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
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


! {Cha, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChacFuSdL(i1,i3,gt2)
coup2R = cplcChacFuSdR(i1,i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
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


! {Chi, bar[Fd], bar[Fd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFdChiSdL(i3,i1,gt2)
coup2R = cplcFdChiSdR(i3,i1,gt2)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
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


! {Fd, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,i3,gt2)
coup2R = cplcFdChiSdR(i1,i3,gt2)
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


! {Fd, Fv, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,i3,gt2)
coup2R = cplcFdFvSdR(i1,i3,gt2)
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


! {Fe, bar[Fu], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFecFuSdL(i1,i3,gt2)
coup2R = cplcFecFuSdR(i1,i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
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


! {Fu, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i3,i1,gt2)
coup2R = cplcChacFuSdR(i3,i1,gt2)
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


! {Fu, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i3,i1,gt2)
coup2R = cplcFecFuSdR(i3,i1,gt2)
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


! {Fv, bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplcFdFvSdL(i3,i1,gt2)
coup2R = cplcFdFvSdR(i3,i1,gt2)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
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


! {Glu, bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFdGluSdL(i3,gt2)
coup2R = cplcFdGluSdR(i3,gt2)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
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


! {Hpm, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i3)
coup3 = cplSucSuVZ(i3,i2)
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


! {Sd, hh, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplAhSdcSd(i3,gt2,i1)
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


! {Sd, Ah, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, VZ, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSdSvcSd(gt2,i3,i1)
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


! {Sd, hh, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplSdcSdVZ(gt2,i1)
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


! {Sd, conj[Sv], conj[Sv]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSdcSdcSv(gt2,i1,i3)
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


! {Se, conj[Su], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i3)
coup3 = cplSucSuVZ(i3,i2)
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


! {Su, conj[Hpm], conj[Hpm]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[VWm], conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[Se], conj[Se]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = cplSdcSecSu(gt2,i3,i1)
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


! {Su, conj[Hpm], conj[VWm]}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
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


! {Su, conj[VWm], conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(gt2,i3,i1)
coup3 = cplSdcSdVZ(i3,i2)
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


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSdVWm(i2,gt1)
coup2 = cplSdcSucVWm(gt2,i3)
coup3 = cplSucSuVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = cplSdcSdVZ(gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplSdSvcSd(gt2,i1,i3)
coup3 = cplSdcSdVZ(i3,i2)
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


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVGVZLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdVPVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2 = cplSdcSdVZVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = -cplSucSdVWm(i1,gt1)
coup2 = cplSdcSucVWmVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSdVGVZLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSdVPVZaa(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = cplSdcSdVZVZaa(i1,gt1)
coup2 = cplSdcSdVZ(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = cplSucSdVWmVZaa(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,         & 
& cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,         & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,cplcFdFdVZR,cplFeFucSdL,             & 
& cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,     & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplhhVZVZ,cplHpmSucSd,    & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,   & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,          & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVZ,cplSucSdVWm,cplSucSuVZ,cplSvcSvVZ,cplcHpmVWmVZ,     & 
& cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1,cplSdcSdVPVZaa,cplSdcSdVZVZaa,cplSdcSucVWmVZaa,  & 
& cplSucSdVWmVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),             & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),             & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplFvFvVZL(3,3),   & 
& cplFvFvVZR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),               & 
& cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplHpmcHpmVZ(2,2), & 
& cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),     & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),           & 
& cplSeSucSd(6,6,6),cplSecSeVZ(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplSvcSvVZ(3,3),    & 
& cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplSdcSdVGVZLamct3ct2ct1(6,6),cplSdcSdVPVZaa(6,6),        & 
& cplSdcSdVZVZaa(6,6),cplSdcSucVWmVZaa(6,6),cplSucSdVWmVZaa(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVZ 


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVGVZLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdVPVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSdVGVZLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSdVPVZaa(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVZ


Subroutine Amplitude_Tree_MSSMTriLnV_SdTocSvSd(cplSdcSdcSv,MSd,MSv,MSd2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSv(3),MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSdcSdcSv(6,6,3)

Complex(dp) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdcSdcSv(gt3,gt1,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdTocSvSd


Subroutine Gamma_Real_MSSMTriLnV_SdTocSvSd(MLambda,em,gs,cplSdcSdcSv,MSd,             & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcSdcSv(6,6,3)

Real(dp), Intent(in) :: MSd(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,6), GammarealGluon(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
Coup = cplSdcSdcSv(i3,i1,i2)
Mex1 = MSd(i1)
Mex2 = MSv(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,0._dp,1._dp/9._dp,0._dp,0._dp,1._dp/9._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdTocSvSd


Subroutine Amplitude_WAVE_MSSMTriLnV_SdTocSvSd(cplSdcSdcSv,ctcplSdcSdcSv,             & 
& MSd,MSd2,MSv,MSv2,ZfSd,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSdcSdcSv(6,6,3)

Complex(dp), Intent(in) :: ctcplSdcSdcSv(6,6,3)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSdcSv(gt3,gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSdcSdcSv(gt3,i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt2))*cplSdcSdcSv(gt3,gt1,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdcSdcSv(i1,gt1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdTocSvSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdTocSvSd(MAh,MCha,MChi,MFd,MFe,               & 
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

Complex(dp), Intent(out) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 


! {Cha, bar[Fu], Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChaFecSvL(i1,i3,gt2)
coup2R = cplcChaFecSvR(i1,i3,gt2)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
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


! {Chi, bar[Fd], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,i3,gt2)
coup2R = cplChiFvcSvR(i1,i3,gt2)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
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


! {Fd, Chi, Fd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdcSvL(i1,i3,gt2)
coup2R = cplcFdFdcSvR(i1,i3,gt2)
coup3L = cplcFdChiSdL(i3,i2,gt3)
coup3R = cplcFdChiSdR(i3,i2,gt3)
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


! {Fd, Fv, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFdcSvL(i1,i3,gt2)
coup2R = cplcFdFdcSvR(i1,i3,gt2)
coup3L = cplcFdFvSdL(i3,i2,gt3)
coup3R = cplcFdFvSdR(i3,i2,gt3)
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


! {Fd, Glu, Fd}
Do i1=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i1,gt1)
coup1R = cplGluFdcSdR(i1,gt1)
coup2L = cplcFdFdcSvL(i1,i3,gt2)
coup2R = cplcFdFdcSvR(i1,i3,gt2)
coup3L = cplcFdGluSdL(i3,gt3)
coup3R = cplcFdGluSdR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fe, bar[Fu], Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFeFecSvL(i1,i3,gt2)
coup2R = cplcFeFecSvR(i1,i3,gt2)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
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


! {Fv, bar[Fd], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i3,i1,gt2)
coup2R = cplChiFvcSvR(i3,i1,gt2)
coup3L = cplcFdChiSdL(i2,i3,gt3)
coup3R = cplcFdChiSdR(i2,i3,gt3)
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


! {hh, conj[Sd], Sv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,i3,gt2)
coup3 = cplSdcSdcSv(gt3,i2,i3)
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


! {Hpm, conj[Su], Se}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
coup3 = cplSdcSecSu(gt3,i3,i2)
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


! {Sd, Ah, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplAhSdcSd(i2,gt3,i3)
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


! {Sd, hh, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplhhSdcSd(i2,gt3,i3)
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


! {Sd, Sv, Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdSvcSd(gt3,i2,i3)
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


! {Sd, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdcSdVG(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdcSdVP(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, VZ, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdcSdVZ(gt3,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, conj[Sv], Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdcSdcSv(gt3,i3,i2)
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


! {Se, conj[Su], Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
coup3 = cplSdcSecSu(gt3,i3,i2)
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


! {VWm, conj[Su], Se}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplSucSdVWm(i2,gt1)
coup2 = cplSecSvcVWm(i3,gt2)
coup3 = cplSdcSecSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], Sv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = cplSvcSvVZ(i3,gt2)
coup3 = cplSdcSdcSv(gt3,i2,i3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplhhSvcSv(i3,i1,gt2)
coup3 = cplhhSdcSd(i3,gt3,i2)
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


! {conj[Sv], conj[Sd], VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplSvcSvVZ(i1,gt2)
coup3 = cplSdcSdVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdcSdcSvaa(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdcSdcSvaa(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdcHpmcSucSvaa(gt3,i1,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSdSvcSdcSvaa(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, Sv}
Do i1=1,2
  Do i2=1,3
ML1 = Mhh(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSdcSdcSvaa(i1,gt3,gt1,i2)
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
coup1 = cplHpmSdcSdcSeaa(i1,gt3,gt1,i2)
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
coup1 = cplSdSdcSdcSdabba(gt3,i1,gt1,i2)
coup2 = cplSdcSdcSv(i2,i1,gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSdcSdcSdabab(gt3,i1,gt1,i2)
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
coup1 = cplSdSecSdcSeaa(gt3,i1,gt1,i2)
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


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSdcSvaa(i1,i2,gt1,gt2)
coup2 = cplAhSdcSd(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSdcSvaa(i1,i2,gt1,gt2)
coup2 = cplhhSdcSd(i1,gt3,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSdcSvaa(i1,i2,gt1,gt2)
coup2 = cplSdcHpmcSu(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSdcSvaa(i1,i2,gt1,gt2)
coup2 = cplSdcSdcSv(gt3,i1,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSdcSvaa(i1,i2,gt1,gt2)
coup2 = cplSdcSecSu(gt3,i1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdTocSvSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd(MAh,MCha,MChi,MFd,MFe,            & 
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

Complex(dp), Intent(out) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSd(gt3) 


! {Sd, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdcSdVG(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Sd, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdcSv(i3,i1,gt2)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdTocSvSd


Subroutine Amplitude_Tree_MSSMTriLnV_SdToSuSe(cplSeSucSd,MSd,MSe,MSu,MSd2,            & 
& MSe2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSe(6),MSu(6),MSd2(6),MSe2(6),MSu2(6)

Complex(dp), Intent(in) :: cplSeSucSd(6,6,6)

Complex(dp) :: Amp(6,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplSeSucSd(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSuSe


Subroutine Gamma_Real_MSSMTriLnV_SdToSuSe(MLambda,em,gs,cplSeSucSd,MSd,               & 
& MSe,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSeSucSd(6,6,6)

Real(dp), Intent(in) :: MSd(6),MSe(6),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,6), GammarealGluon(6,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
Coup = cplSeSucSd(i3,i2,i1)
Mex1 = MSd(i1)
Mex2 = MSu(i2)
Mex3 = MSe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,1._dp/9._dp,-2._dp/9._dp,1._dp/3._dp,4._dp/9._dp,-2._dp/3._dp,1._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSuSe


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSuSe(cplSeSucSd,ctcplSeSucSd,MSd,            & 
& MSd2,MSe,MSe2,MSu,MSu2,ZfSd,ZfSe,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplSeSucSd(6,6,6)

Complex(dp), Intent(in) :: ctcplSeSucSd(6,6,6)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfSe(6,6),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(6,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSeSucSd(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSeSucSd(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplSeSucSd(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplSeSucSd(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSuSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSuSe(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplAhSecSe,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,             & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,     & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,         & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhSeSucSdaa,cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,             & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,  & 
& cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),            & 
& cplcFdChaSuR(3,2,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplFeFucSdL(3,3,6),             & 
& cplFeFucSdR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuSeL(3,3,6),           & 
& cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),              & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),& 
& cplSecSvcVWm(6,3),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),    & 
& cplAhSeSucSdaa(2,6,6,6),cplhhSeSucSdaa(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),              & 
& cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSucSdcSvaa(6,6,6,3),         & 
& cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(6,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSe(gt3) 


! {Ah, conj[Sd], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
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


! {Chi, bar[Fd], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
coup3L = cplcFdFuSeL(i2,i3,gt3)
coup3R = cplcFdFuSeR(i2,i3,gt3)
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


! {Fd, Fv, Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MCha(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Chi, Fe}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fd, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fu, bar[Fe], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MChi(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,i3,gt2)
coup2R = cplcFuChiSuR(i1,i3,gt2)
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


! {Glu, bar[Fd], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFdFuSeL(i2,i3,gt3)
coup3R = cplcFdFuSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
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


! {Sd, conj[Sv], Hpm}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, Ah, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, hh, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, VP, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, VZ, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, conj[Sv], Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, conj[Sv], VWm}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MVWm 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
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


! {Su, conj[Se], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MAh(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, conj[Se], hh}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, conj[Se], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = -cplSucSuVP(gt2,i1)
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


! {Su, conj[Se], VZ}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = -cplSucSuVZ(gt2,i1)
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


! {VG, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = -cplSucSuVZ(gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSeSucSdaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSeSucSdaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSeSucHpmcSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcSd(i1,i2,gt1)
coup2 = cplSeSucSdcSvaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Su]}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSeSucSecSuaa(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSeSucSdaa(i1,gt3,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {hh, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSeSucSdaa(i1,gt3,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sd, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
coup1 = cplSdSecHpmcSdaa(i1,gt3,i2,gt1)
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


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplSdSecSdcSeaa(i1,gt3,gt1,i2)
coup2 = cplSeSucSd(i2,gt2,i1)
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
coup1 = cplAhSeSucSdaa(i1,i2,gt2,gt1)
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
coup1 = cplhhSeSucSdaa(i1,i2,gt2,gt1)
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
coup1 = cplHpmSuSvcSdaa(i1,gt2,i2,gt1)
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
coup1 = cplSdSucSdcSuabba(i1,gt2,gt1,i2)
coup2 = cplSeSucSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

coup1 = cplSdSucSdcSuabab(i1,gt2,gt1,i2)
coup2 = cplSeSucSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Se, Sv}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSucSdcSvaa(i1,gt2,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSuSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplAhSecSe,cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplChiFdcSdL,cplChiFdcSdR,             & 
& cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplFeFucSdL,cplFeFucSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplSdSvcSd,     & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSeSvcSe,cplSecSeVP,         & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplAhSeSucSdaa,cplhhSeSucSdaa,cplHpmSuSvcSdaa,cplSdSecHpmcSdaa,             & 
& cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSeSucHpmcSuaa,cplSeSucSdcSvaa,  & 
& cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),            & 
& cplcFdChaSuR(3,2,6),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplFeFucSdL(3,3,6),             & 
& cplFeFucSdR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuSeL(3,3,6),           & 
& cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplSdSvcSd(6,3,6),              & 
& cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),  & 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),& 
& cplSecSvcVWm(6,3),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),    & 
& cplAhSeSucSdaa(2,6,6,6),cplhhSeSucSdaa(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),              & 
& cplSdSecHpmcSdaa(6,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSucSdcSvaa(6,6,6,3),         & 
& cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(6,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSe(gt3) 


! {Sd, VP, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
coup3 = cplSecSeVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Su, conj[Se], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = -cplSucSuVP(gt2,i1)
coup3 = cplSecSeVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {VG, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
coup3 = cplSeSucSd(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuSe


Subroutine Amplitude_Tree_MSSMTriLnV_SdToSuVWm(cplSucSdVWm,MSd,MSu,MVWm,              & 
& MSd2,MSu2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSu(6),MVWm,MSd2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplSucSdVWm(6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = -cplSucSdVWm(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SdToSuVWm


Subroutine Gamma_Real_MSSMTriLnV_SdToSuVWm(MLambda,em,gs,cplSucSdVWm,MSd,             & 
& MSu,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSucSdVWm(6,6)

Real(dp), Intent(in) :: MSd(6),MSu(6),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6), GammarealGluon(6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
Coup = cplSucSdVWm(i2,i1)
Mex1 = MSd(i1)
Mex2 = MSu(i2)
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,-1._dp/3._dp,2._dp/3._dp,-1._dp,Coup,Gammarealphoton(i1,i2),kont)
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,gs,1._dp,1._dp,0._dp,Coup,Gammarealgluon(i1,i2),kont)
 GammarealGluon(i1,i2) = GammarealGluon(i1,i2)*4._dp/3._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SdToSuVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSuVWm(cplSucSdVWm,ctcplSucSdVWm,             & 
& MSd,MSd2,MSu,MSu2,MVWm,MVWm2,ZfSd,ZfSu,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSu(6),MSu2(6),MVWm,MVWm2

Complex(dp), Intent(in) :: cplSucSdVWm(6,6)

Complex(dp), Intent(in) :: ctcplSucSdVWm(6,6)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfSu(6,6),ZfVWm

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSucSdVWm(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSucSdVWm(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplSucSdVWm(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplSucSdVWm(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSuVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSuVWm(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,        & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,     & 
& cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChaFucSdL(2,3,6),            & 
& cplChaFucSdR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiFdcSdL(4,3,6),       & 
& cplChiFdcSdR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),       & 
& cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuVWmL(3,3),             & 
& cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcFuGluSuL(3,6),               & 
& cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplHpmSucSd(2,6,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),    & 
& cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6), & 
& cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),         & 
& cplcVWmVWmVZ,cplSdcSdcVWmVWmaa(6,6),cplSucSdVGVWmLamct3ct2ct1(6,6),cplSucSdVPVWmaa(6,6),& 
& cplSucSdVWmVZaa(6,6),cplSucSucVWmVWmaa(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVWm 


! {Ah, conj[Sd], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
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


! {Chi, bar[Fd], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
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


! {Fd, Chi, Cha}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFdcSdL(i2,i1,gt1)
coup1R = cplChiFdcSdR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFdcSdL(i2,i1,gt1)
coup1R = cplFvFdcSdR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fu, bar[Cha], Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,i3,gt2)
coup2R = cplcFuChiSuR(i1,i3,gt2)
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


! {Glu, bar[Fd], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
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


! {Sd, Ah, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSdcSd(i2,i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, hh, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, VZ, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSdcSv(i1,gt1,i2)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, hh, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhSdcSd(i2,i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
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


! {Sd, VP, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VZ, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplSdcSdVZ(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[Hpm], Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, conj[Hpm], hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, conj[VWm], hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, conj[Hpm], VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
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


! {Su, conj[VWm], VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[Hpm], VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSucSuVZ(gt2,i1)
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


! {Su, conj[VWm], VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSucSuVZ(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = cplSucSuVZ(gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSucSdVGVWmLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSucSdVPVWmaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2 = cplSucSdVWmVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = -cplSucSdVWm(i1,gt1)
coup2 = cplSucSucVWmVWmaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = cplSdcSdcVWmVWmaa(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = cplSucSdVGVWmLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = cplSucSdVPVWmaa(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Su, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
coup1 = cplSucSdVWmVZaa(i1,gt1)
coup2 = cplSucSuVZ(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSuVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplAhSucSu,cplAhcHpmVWm,cplChaFucSdL,cplChaFucSdR,cplcFdChaSuL,cplcFdChaSuR,           & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSdcSd,cplhhSucSu,cplhhcHpmVWm,cplhhcVWmVWm,cplHpmSucSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplSdcSdcSv,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,        & 
& cplSvcSeVWm,cplcHpmVPVWm,cplcVWmVPVWm,cplcHpmVWmVZ,cplcVWmVWmVZ,cplSdcSdcVWmVWmaa,     & 
& cplSucSdVGVWmLamct3ct2ct1,cplSucSdVPVWmaa,cplSucSdVWmVZaa,cplSucSucVWmVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplAhcHpmVWm(2,2),cplChaFucSdL(2,3,6),            & 
& cplChaFucSdR(2,3,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiFdcSdL(4,3,6),       & 
& cplChiFdcSdR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),       & 
& cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFdFuVWmL(3,3),             & 
& cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplcFuGluSuL(3,6),               & 
& cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplHpmSucSd(2,6,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),    & 
& cplSdcSdcSv(6,6,3),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6), & 
& cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplcHpmVWmVZ(2),         & 
& cplcVWmVWmVZ,cplSdcSdcVWmVWmaa(6,6),cplSucSdVGVWmLamct3ct2ct1(6,6),cplSucSdVPVWmaa(6,6),& 
& cplSucSdVWmVZaa(6,6),cplSucSucVWmVWmaa(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVWm 


! {Sd, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, VP, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSdcSdVP(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[Hpm], VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
coup3 = cplcHpmVPVWm(i2)
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Su, conj[VWm], VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
coup3 = cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
coup3 = cplSucSdVWm(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSucSdVGVWmLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSucSdVPVWmaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = cplSucSdVGVWmLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = cplSucSdVPVWmaa(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSuVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdVG(cplSdcSdVG,ctcplSdcSdVG,MSd,            & 
& MSd2,MVG,MVG2,ZfSd,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MVG,MVG2

Complex(dp), Intent(in) :: cplSdcSdVG(6,6)

Complex(dp), Intent(in) :: ctcplSdcSdVG(6,6)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfVG

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVG 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSdVG(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSdcSdVG(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt2)*cplSdcSdVG(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVG*cplSdcSdVG(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 4._dp/3._dp*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdVG(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFuFuVGL,cplcFuFuVGR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,            & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,               & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSucSuVG,cplSucSdVWm,cplVGVGVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1, & 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVGVZLamct3ct2ct1,& 
& cplSdcSucVWmVGLamct4ct2ct1,cplSucSdVGVWmLamct3ct2ct1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),        & 
& cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVGL(3,3),               & 
& cplcFdFdVGR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFuFuVGL(3,3),               & 
& cplcFuFuVGR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplGluGluVGL,cplGluGluVGR,      & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),      & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),             & 
& cplSucSuVG(6,6),cplSucSdVWm(6,6),cplVGVGVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSdcSdVGVPLamct3ct2ct1(6,6),          & 
& cplSdcSdVGVZLamct3ct2ct1(6,6),cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSucSdVGVWmLamct3ct2ct1(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVG 


! {Ah, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Cha, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChacFuSdL(i1,i3,gt2)
coup2R = cplcChacFuSdR(i1,i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Chi, bar[Fd], bar[Fd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFdChiSdL(i3,i1,gt2)
coup2R = cplcFdChiSdR(i3,i1,gt2)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Glu, Glu}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MGlu 
ML3 = MGlu 
coup1L = cplGluFdcSdL(i1,gt1)
coup1R = cplGluFdcSdR(i1,gt1)
coup2L = cplcFdGluSdL(i1,gt2)
coup2R = cplcFdGluSdR(i1,gt2)
coup3L = cplGluGluVGL
coup3R = cplGluGluVGR
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {Fe, bar[Fu], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFecFuSdL(i1,i3,gt2)
coup2R = cplcFecFuSdR(i1,i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fv, bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplcFdFvSdL(i3,i1,gt2)
coup2R = cplcFdFvSdR(i3,i1,gt2)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Glu, bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFdGluSdL(i3,gt2)
coup2R = cplcFdGluSdR(i3,gt2)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Hpm, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, VG, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MVG 
coup1 = cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
coup3 = cplVGVGVG
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {Se, conj[Su], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sv, conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(gt2,i3,i1)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VWm, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSdVWm(i2,gt1)
coup2 = cplSdcSucVWm(gt2,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = cplSdcSdVZ(gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplSdSvcSd(gt2,i1,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
coup2 = cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2 = cplSdcSdVGVZLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = -cplSucSdVWm(i1,gt1)
coup2 = cplSdcSucVWmVGLamct4ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 

coup1 = cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSdVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = cplSdcSdVGVZLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVZ(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = cplSucSdVGVWmLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVG(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,cplChiFdcSdR,cplcFdChiSdL,cplcFdChiSdR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,             & 
& cplFeFucSdL,cplFeFucSdR,cplcFuFuVGL,cplcFuFuVGR,cplcFdFvSdL,cplcFdFvSdR,               & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplhhSdcSd,cplHpmSucSd,            & 
& cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,               & 
& cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,           & 
& cplSeSucSd,cplSucSuVG,cplSucSdVWm,cplVGVGVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1, & 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVGVZLamct3ct2ct1,& 
& cplSdcSucVWmVGLamct4ct2ct1,cplSucSdVGVWmLamct3ct2ct1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiFdcSdL(4,3,6),        & 
& cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVGL(3,3),               & 
& cplcFdFdVGR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFuFuVGL(3,3),               & 
& cplcFuFuVGR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplGluGluVGL,cplGluGluVGR,      & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),      & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),             & 
& cplSucSuVG(6,6),cplSucSdVWm(6,6),cplVGVGVG,cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSdcSdVGVPLamct3ct2ct1(6,6),          & 
& cplSdcSdVGVZLamct3ct2ct1(6,6),cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSucSdVGVWmLamct3ct2ct1(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVG 


! {Sd, VG, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
ML3 = MVG 
coup1 = cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
coup3 = cplVGVGVG
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
coup2 = cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSdVGVGsumj113Lamct3ct2j1Lamct4j1ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 

coup1 = cplSdcSdVGVGsumj113Lamct3j1ct1Lamct4ct2j1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSdVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVG


Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdVP(cplSdcSdVP,cplSdcSdVZ,ctcplSdcSdVP,     & 
& ctcplSdcSdVZ,MSd,MSd2,MVP,MVP2,ZfSd,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MVP,MVP2

Complex(dp), Intent(in) :: cplSdcSdVP(6,6),cplSdcSdVZ(6,6)

Complex(dp), Intent(in) :: ctcplSdcSdVP(6,6),ctcplSdcSdVZ(6,6)

Complex(dp), Intent(in) :: ZfSd(6,6),ZfVP,ZfVZVP

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSd(i1,gt1))*cplSdcSdVP(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt2)*cplSdcSdVP(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVP*cplSdcSdVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZVP*cplSdcSdVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SdToSdVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdVP(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,             & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChaVPL,cplcChaChaVPR,cplChiFdcSdL,cplChiFdcSdR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdVPL,cplcFdFdVPR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,             & 
& cplhhSdcSd,cplHpmSucSd,cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVP,cplSucSdVWm,     & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVPVPaa,cplSdcSdVPVZaa,      & 
& cplSdcSucVWmVPaa,cplSucSdVPVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcChaChaVPL(2,2),         & 
& cplcChaChaVPR(2,2),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),        & 
& cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),& 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFvSdL(3,3,6),& 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),              & 
& cplHpmSucSd(2,6,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),& 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSecSeVP(6,6),cplSucSuVP(6,6),& 
& cplSucSdVWm(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplSdcSdVGVPLamct3ct2ct1(6,6),           & 
& cplSdcSdVPVPaa(6,6),cplSdcSdVPVZaa(6,6),cplSdcSucVWmVPaa(6,6),cplSucSdVPVWmaa(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVP 


! {Ah, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSdcSd(i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
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


! {Cha, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChaFucSdL(i1,i2,gt1)
coup1R = cplChaFucSdR(i1,i2,gt1)
coup2L = cplcChacFuSdL(i1,i3,gt2)
coup2R = cplcChacFuSdR(i1,i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
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


! {Chi, bar[Fd], bar[Fd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFdcSdL(i1,i2,gt1)
coup1R = cplChiFdcSdR(i1,i2,gt1)
coup2L = cplcFdChiSdL(i3,i1,gt2)
coup2R = cplcFdChiSdR(i3,i1,gt2)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
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


! {Fe, bar[Fu], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplFeFucSdL(i1,i2,gt1)
coup1R = cplFeFucSdR(i1,i2,gt1)
coup2L = cplcFecFuSdL(i1,i3,gt2)
coup2R = cplcFecFuSdR(i1,i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
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


! {Fu, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplChaFucSdL(i2,i1,gt1)
coup1R = cplChaFucSdR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i3,i1,gt2)
coup2R = cplcChacFuSdR(i3,i1,gt2)
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


! {Fu, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFeFucSdL(i2,i1,gt1)
coup1R = cplFeFucSdR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i3,i1,gt2)
coup2R = cplcFecFuSdR(i3,i1,gt2)
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


! {Fv, bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplFvFdcSdL(i1,i2,gt1)
coup1R = cplFvFdcSdR(i1,i2,gt1)
coup2L = cplcFdFvSdL(i3,i1,gt2)
coup2R = cplcFdFvSdR(i3,i1,gt2)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
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


! {Glu, bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,gt1)
coup1R = cplGluFdcSdR(i2,gt1)
coup2L = cplcFdGluSdL(i3,gt2)
coup2R = cplcFdGluSdR(i3,gt2)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSdcSd(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
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


! {Hpm, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplHpmSucSd(i1,i2,gt1)
coup2 = cplSdcHpmcSu(gt2,i1,i3)
coup3 = cplSucSuVP(i3,i2)
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


! {Se, conj[Su], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSeSucSd(i1,i2,gt1)
coup2 = cplSdcSecSu(gt2,i1,i3)
coup3 = cplSucSuVP(i3,i2)
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


! {Su, conj[Hpm], conj[Hpm]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[VWm], conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, conj[Se], conj[Se]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSucSd(i2,i1,gt1)
coup2 = cplSdcSecSu(gt2,i3,i1)
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


! {Su, conj[Hpm], conj[VWm]}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSucSd(i2,i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
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


! {Su, conj[VWm], conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSucSdVWm(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdSvcSd(i2,i1,gt1)
coup2 = cplSdcSdcSv(gt2,i3,i1)
coup3 = cplSdcSdVP(i3,i2)
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


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VWm, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSdVWm(i2,gt1)
coup2 = cplSdcSucVWm(gt2,i3)
coup3 = cplSucSuVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVZ(i2,gt1)
coup2 = cplSdcSdVZ(gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Sv], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdcSv(i2,gt1,i1)
coup2 = cplSdSvcSd(gt2,i1,i3)
coup3 = cplSdcSdVP(i3,i2)
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


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdVPVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = -cplSdcSdVZ(i1,gt1)
coup2 = cplSdcSdVPVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = -cplSucSdVWm(i1,gt1)
coup2 = cplSdcSucVWmVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSdVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSdVPVPaa(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Sd, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVZ 
coup1 = cplSdcSdVPVZaa(i1,gt1)
coup2 = cplSdcSdVZ(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do


! {Su, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVWm 
coup1 = cplSucSdVPVWmaa(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SdToSdVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVP(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChaVPL,cplcChaChaVPR,cplChiFdcSdL,cplChiFdcSdR,       & 
& cplcFdChiSdL,cplcFdChiSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdVPL,cplcFdFdVPR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVPL,cplcFeFeVPR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,             & 
& cplhhSdcSd,cplHpmSucSd,cplHpmcHpmVP,cplHpmcVWmVP,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,     & 
& cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,         & 
& cplSdcSdcSv,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVP,cplSucSdVWm,     & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSdcSdVGVPLamct3ct2ct1,cplSdcSdVPVPaa,cplSdcSdVPVZaa,      & 
& cplSdcSucVWmVPaa,cplSucSdVPVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcChaChaVPL(2,2),         & 
& cplcChaChaVPR(2,2),cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplcFdChiSdL(3,4,6),        & 
& cplcFdChiSdR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),& 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFvSdL(3,3,6),& 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),              & 
& cplHpmSucSd(2,6,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),& 
& cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSecSeVP(6,6),cplSucSuVP(6,6),& 
& cplSucSdVWm(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplSdcSdVGVPLamct3ct2ct1(6,6),           & 
& cplSdcSdVPVPaa(6,6),cplSdcSdVPVZaa(6,6),cplSdcSucVWmVPaa(6,6),cplSucSdVPVWmaa(6,6)

Complex(dp), Intent(out) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSd(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVP 


! {VG, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSdVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = -cplSdcSdVG(i1,gt1)
coup2 = cplSdcSdVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = -cplSdcSdVP(i1,gt1)
coup2 = cplSdcSdVPVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSdVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSdVPVPaa(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SdToSdVP



End Module OneLoopDecay_Sd_MSSMTriLnV
