! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:54 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Su_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_SuToSuAh(cplAhSucSu,MAh,MSu,MAh2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MSu(6),MAh2(2),MSu2(6)

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MAh(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhSucSu(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuToSuAh


Subroutine Gamma_Real_MSSMTriLnV_SuToSuAh(MLambda,em,gs,cplAhSucSu,MAh,               & 
& MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6)

Real(dp), Intent(in) :: MAh(2),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=2,2
Coup = cplAhSucSu(i3,i2,i1)
Mex1 = MSu(i1)
Mex2 = MSu(i2)
Mex3 = MAh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,4._dp/9._dp,0._dp,4._dp/9._dp,0._dp,0._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuToSuAh


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuAh(cplAhSucSu,ctcplAhSucSu,MAh,            & 
& MAh2,MSu,MSu2,ZfAh,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6)

Complex(dp), Intent(in) :: ctcplAhSucSu(2,6,6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSu(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MAh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhSucSu(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplAhSucSu(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplAhSucSu(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt3)*cplAhSucSu(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuAh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MAh(gt3) 


! {Ah, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
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


! {Chi, bar[Fu], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
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


! {Fd, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
coup3L = cplcChaChaAhL(i3,i2,gt3)
coup3R = cplcChaChaAhR(i3,i2,gt3)
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


! {Fd, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fu, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,i3,gt2)
coup2R = cplcFuChiSuR(i1,i3,gt2)
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


! {Glu, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
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


! {Sd, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
coup3 = cplAhHpmcHpm(gt3,i2,i3)
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


! {Sd, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
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


! {Su, hh, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, Ah, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, VZ, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, hh, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = -cplSucSuVZ(gt2,i1)
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


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
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


! {VZ, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = -cplSucSuVZ(gt2,i3)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = -cplSucSdVWm(gt2,i3)
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


! {Ah, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhAhSucSuaa(gt3,i1,gt2,i2)
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
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplAhHpmSucSdaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplAhSeSucSdaa(gt3,i2,gt2,i1)
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
coup1 = cplAhAhSucSuaa(gt3,i1,i2,gt1)
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


! {Sd, Hpm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhSdcHpmcSuaa(gt3,i1,i2,gt1)
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
coup1 = cplAhSdcSecSuaa(gt3,i1,i2,gt1)
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


! {Hpm, Hpm}
Do i1=1,2
  Do i2=1,2
ML1 = MHpm(i1) 
ML2 = MHpm(i2) 
coup1 = cplHpmSucHpmcSuaa(i1,gt2,i2,gt1)
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
coup1 = cplSdSucSdcSuabba(i1,gt2,i2,gt1)
coup2 = cplAhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSucSdcSuabab(i1,gt2,i2,gt1)
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
coup1 = cplSeSucSecSuaa(i1,gt2,i2,gt1)
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
coup1 = cplSuSucSucSuabba(gt2,i1,gt1,i2)
coup2 = cplAhSucSu(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSuSucSucSuabab(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh(MAh,MCha,MChi,MFd,MFe,             & 
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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MAh(gt3) 


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuAh


Subroutine Amplitude_Tree_MSSMTriLnV_SuToFuChi(cplChiFucSuL,cplChiFucSuR,             & 
& MChi,MFu,MSu,MChi2,MFu2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFu(3),MSu(6),MChi2(4),MFu2(3),MSu2(6)

Complex(dp), Intent(in) :: cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6)

Complex(dp) :: Amp(2,6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,4
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MChi(gt3) 
! Tree-Level Vertex 
coupT1L = cplChiFucSuL(gt3,gt2,gt1)
coupT1R = cplChiFucSuR(gt3,gt2,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuToFuChi


Subroutine Gamma_Real_MSSMTriLnV_SuToFuChi(MLambda,em,gs,cplChiFucSuL,cplChiFucSuR,   & 
& MChi,MFu,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6)

Real(dp), Intent(in) :: MChi(4),MFu(3),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,4), GammarealGluon(6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
CoupL = cplChiFucSuL(i3,i2,i1)
CoupR = cplChiFucSuR(i3,i2,i1)
Mex1 = MSu(i1)
Mex2 = MFu(i2)
Mex3 = MChi(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,4._dp/9._dp,0._dp,4._dp/9._dp,0._dp,0._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuToFuChi


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToFuChi(cplChiFucSuL,cplChiFucSuR,             & 
& ctcplChiFucSuL,ctcplChiFucSuR,MChi,MChi2,MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,ZfL0,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MFu(3),MFu2(3),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6)

Complex(dp), Intent(in) :: ctcplChiFucSuL(4,3,6),ctcplChiFucSuR(4,3,6)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfL0(4,4),ZfSu(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MChi(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChiFucSuL(gt3,gt2,gt1) 
ZcoupT1R = ctcplChiFucSuR(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplChiFucSuL(gt3,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplChiFucSuR(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplChiFucSuL(gt3,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplChiFucSuR(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt3)*cplChiFucSuL(i1,gt2,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt3))*cplChiFucSuR(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToFuChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToFuChi(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,   & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,              & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),        & 
& cplAhSucSu(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),      & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),       & 
& cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplhhSucSu(2,6,6),& 
& cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSucSuVG(6,6),              & 
& cplSucSuVP(6,6),cplSucSuVZ(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MChi(gt3) 


! {Ah, conj[Su], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
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


! {Chi, bar[Fu], conj[Su]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
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


! {Fd, Cha, Hpm}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MHpm(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
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


! {Fd, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
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


! {Fd, Cha, VWm}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MVWm 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
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


! {Fu, Chi, Ah}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MAh(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
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


! {Fu, Chi, hh}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = Mhh(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
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


! {Fu, Chi, VZ}
Do i1=1,3
  Do i2=1,4
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MVZ 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
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


! {Glu, bar[Fu], conj[Su]}
  Do i2=1,3
    Do i3=1,6
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3L = cplcFuChiSuL(i2,gt3,i3)
coup3R = cplcFuChiSuR(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], bar[Fu]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
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


! {Sd, Hpm, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, VWm, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MCha(i3) 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Su, Ah, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MChi(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
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


! {Su, hh, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MChi(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
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


! {Su, VZ, Chi}
Do i1=1,6
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MChi(i3) 
coup1 = -cplSucSuVZ(i1,gt1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
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


! {VG, conj[Su], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = -cplSucSuVG(i2,gt1)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = -cplSucSuVP(i2,gt1)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
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


! {VZ, conj[Su], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = -cplSucSuVZ(i2,gt1)
coup2L = -cplcFuFuVZR(i3,gt2)
coup2R = -cplcFuFuVZL(i3,gt2)
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


! {bar[Cha], bar[Fd], conj[Sd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
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


! {bar[Fe], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
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


! {conj[Hpm], conj[Sd], bar[Fd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
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


! {conj[Se], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
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


! {conj[VWm], conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSucVWm(i2,gt1)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToFuChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,   & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplChaFucSdL,cplChaFucSdR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcChaFdcSuL,    & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,          & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,              & 
& cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),        & 
& cplAhSucSu(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),      & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),       & 
& cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplhhSucSu(2,6,6),& 
& cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSucSuVG(6,6),              & 
& cplSucSuVP(6,6),cplSucSuVZ(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MChi(gt3) 


! {VG, conj[Su], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = -cplSucSuVG(i2,gt1)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], bar[Fu]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = -cplSucSuVP(i2,gt1)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplChiFucSuL(gt3,i3,i2)
coup3R = cplChiFucSuR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuChi


Subroutine Amplitude_Tree_MSSMTriLnV_SuTocChaFd(cplcChaFdcSuL,cplcChaFdcSuR,          & 
& MCha,MFd,MSu,MCha2,MFd2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MSu(6),MCha2(2),MFd2(3),MSu2(6)

Complex(dp), Intent(in) :: cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6)

Complex(dp) :: Amp(2,6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcChaFdcSuL(gt2,gt3,gt1)
coupT1R = cplcChaFdcSuR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuTocChaFd


Subroutine Gamma_Real_MSSMTriLnV_SuTocChaFd(MLambda,em,gs,cplcChaFdcSuL,              & 
& cplcChaFdcSuR,MCha,MFd,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6)

Real(dp), Intent(in) :: MCha(2),MFd(3),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,2,3), GammarealGluon(6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
CoupL = cplcChaFdcSuL(i2,i3,i1)
CoupR = cplcChaFdcSuR(i2,i3,i1)
Mex1 = MSu(i1)
Mex2 = MCha(i2)
Mex3 = MFd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,2._dp/3._dp,-2._dp/9._dp,1._dp,-1._dp/3._dp,1._dp/9._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuTocChaFd


Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocChaFd(cplcChaFdcSuL,cplcChaFdcSuR,          & 
& ctcplcChaFdcSuL,ctcplcChaFdcSuR,MCha,MCha2,MFd,MFd2,MSu,MSu2,ZfFDL,ZfFDR,              & 
& ZfLm,ZfLp,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MFd(3),MFd2(3),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6)

Complex(dp), Intent(in) :: ctcplcChaFdcSuL(2,3,6),ctcplcChaFdcSuR(2,3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfLm(2,2),ZfLp(2,2),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(2,6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcChaFdcSuL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcChaFdcSuR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplcChaFdcSuL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplcChaFdcSuR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLp(i1,gt2)*cplcChaFdcSuL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLm(i1,gt2))*cplcChaFdcSuR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplcChaFdcSuL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplcChaFdcSuR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocChaFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocChaFd(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,cplChiFdcSdR,     & 
& cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,cplcChaChiVWmR, & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,   & 
& cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,             & 
& cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplAhSucSu(2,6,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),        & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiFdcSdL(4,3,6),          & 
& cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcChaChiHpmL(2,4,2),     & 
& cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),      & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),     & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),       & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplhhSucSu(2,6,6),cplcChacFuSdL(2,3,6),        & 
& cplcChacFuSdR(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),         & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFd(gt3) 


! {Ah, conj[Su], Cha}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2L = cplcChaChaAhL(gt2,i3,i1)
coup2R = cplcChaChaAhR(gt2,i3,i1)
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


! {Chi, bar[Fu], Hpm}
Do i1=1,4
  Do i2=1,3
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MHpm(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcChaChiHpmL(gt2,i1,i3)
coup2R = cplcChaChiHpmR(gt2,i1,i3)
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


! {Chi, bar[Fu], VWm}
Do i1=1,4
  Do i2=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MVWm 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcChaChiVWmL(gt2,i1)
coup2R = cplcChaChiVWmR(gt2,i1)
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


! {Fu, Chi, Sd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
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


! {Fu, Glu, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MGlu 
ML3 = MSd(i3) 
coup1L = cplGluFucSuL(i1,gt1)
coup1R = cplGluFucSuR(i1,gt1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
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


! {hh, conj[Su], Cha}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2L = cplcChaChahhL(gt2,i3,i1)
coup2R = cplcChaChahhR(gt2,i3,i1)
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


! {Su, Ah, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
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


! {Su, hh, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
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


! {Su, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSucSuVG(i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
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


! {Su, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSucSuVP(i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
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


! {Su, VZ, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplSucSuVZ(i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
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


! {VP, conj[Su], Cha}
  Do i2=1,6
    Do i3=1,2
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = -cplSucSuVP(i2,gt1)
coup2L = cplcChaChaVPL(gt2,i3)
coup2R = cplcChaChaVPR(gt2,i3)
coup3L = cplcChaFdcSuL(i3,gt3,i2)
coup3R = cplcChaFdcSuR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Su], Cha}
  Do i2=1,6
    Do i3=1,2
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = -cplSucSuVZ(i2,gt1)
coup2L = cplcChaChaVZL(gt2,i3)
coup2R = cplcChaChaVZR(gt2,i3)
coup3L = cplcChaFdcSuL(i3,gt3,i2)
coup3R = cplcChaFdcSuR(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fd], Ah}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MAh(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcChaChaAhL(gt2,i1,i3)
coup2R = cplcChaChaAhR(gt2,i1,i3)
coup3L = cplcFdFdAhL(i2,gt3,i3)
coup3R = cplcFdFdAhR(i2,gt3,i3)
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


! {bar[Cha], bar[Fd], hh}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = Mhh(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcChaChahhL(gt2,i1,i3)
coup2R = cplcChaChahhR(gt2,i1,i3)
coup3L = cplcFdFdhhL(i2,gt3,i3)
coup3R = cplcFdFdhhR(i2,gt3,i3)
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


! {bar[Cha], bar[Fd], VP}
Do i1=1,2
  Do i2=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3L = cplcFdFdVPL(i2,gt3)
coup3R = cplcFdFdVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Cha], bar[Fd], VZ}
Do i1=1,2
  Do i2=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MVZ 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcChaChaVZL(gt2,i1)
coup2R = cplcChaChaVZR(gt2,i1)
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


! {bar[Fe], bar[Fd], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcChaFecSvL(gt2,i1,i3)
coup2R = cplcChaFecSvR(gt2,i1,i3)
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


! {conj[Hpm], conj[Sd], Chi}
Do i1=1,2
  Do i2=1,6
    Do i3=1,4
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2L = cplcChaChiHpmL(gt2,i3,i1)
coup2R = cplcChaChiHpmR(gt2,i3,i1)
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


! {conj[Se], conj[Sd], Fv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = 0. 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2L = cplcChaFvSeL(gt2,i3,i1)
coup2R = cplcChaFvSeR(gt2,i3,i1)
coup3L = cplFvFdcSdL(i3,gt3,i2)
coup3R = cplFvFdcSdR(i3,gt3,i2)
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


! {conj[VWm], conj[Sd], Chi}
  Do i2=1,6
    Do i3=1,4
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = -cplSdcSucVWm(i2,gt1)
coup2L = cplcChaChiVWmL(gt2,i3)
coup2R = cplcChaChiVWmR(gt2,i3)
coup3L = cplChiFdcSdL(i3,gt3,i2)
coup3R = cplChiFdcSdR(i3,gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocChaFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplcFdFdAhL,cplcFdFdAhR,cplAhSucSu,cplcChaChahhL,          & 
& cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplChiFdcSdL,    & 
& cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcChaChiVWmL,   & 
& cplcChaChiVWmR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,          & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,          & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,    & 
& cplcChaFecSvR,cplGluFucSuL,cplGluFucSuR,cplcChaFvSeL,cplcChaFvSeR,cplhhSucSu,          & 
& cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,          & 
& cplSucSuVP,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),      & 
& cplAhSucSu(2,6,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),        & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiFdcSdL(4,3,6),          & 
& cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcChaChiHpmL(2,4,2),     & 
& cplcChaChiHpmR(2,4,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplFvFdcSdL(3,3,6),      & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),     & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),       & 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplhhSucSu(2,6,6),cplcChacFuSdL(2,3,6),        & 
& cplcChacFuSdR(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),         & 
& cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MFd(gt3) 


! {Su, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSucSuVG(i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
coup3L = cplcFdFdVGL(i3,gt3)
coup3R = cplcFdFdVGR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Su, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSucSuVP(i1,gt1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VP, conj[Su], Cha}
  Do i2=1,6
    Do i3=1,2
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MCha(i3) 
coup1 = -cplSucSuVP(i2,gt1)
coup2L = cplcChaChaVPL(gt2,i3)
coup2R = cplcChaChaVPR(gt2,i3)
coup3L = cplcChaFdcSuL(i3,gt3,i2)
coup3R = cplcChaFdcSuR(i3,gt3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], bar[Fd], VP}
Do i1=1,2
  Do i2=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3L = cplcFdFdVPL(i2,gt3)
coup3R = cplcFdFdVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocChaFd


Subroutine Amplitude_Tree_MSSMTriLnV_SuTocFeFd(cplcFeFdcSuL,cplcFeFdcSuR,             & 
& MFd,MFe,MSu,MFd2,MFe2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MSu(6),MFd2(3),MFe2(3),MSu2(6)

Complex(dp), Intent(in) :: cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6)

Complex(dp) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFeFdcSuL(gt2,gt3,gt1)
coupT1R = cplcFeFdcSuR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuTocFeFd


Subroutine Gamma_Real_MSSMTriLnV_SuTocFeFd(MLambda,em,gs,cplcFeFdcSuL,cplcFeFdcSuR,   & 
& MFd,MFe,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6)

Real(dp), Intent(in) :: MFd(3),MFe(3),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,3), GammarealGluon(6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFeFdcSuL(i2,i3,i1)
CoupR = cplcFeFdcSuR(i2,i3,i1)
Mex1 = MSu(i1)
Mex2 = MFe(i2)
Mex3 = MFd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,2._dp/3._dp,-2._dp/9._dp,1._dp,-1._dp/3._dp,1._dp/9._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuTocFeFd


Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocFeFd(cplcFeFdcSuL,cplcFeFdcSuR,             & 
& ctcplcFeFdcSuL,ctcplcFeFdcSuR,MFd,MFd2,MFe,MFe2,MSu,MSu2,ZfFDL,ZfFDR,ZfFEL,            & 
& ZfFER,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MFe(3),MFe2(3),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6)

Complex(dp), Intent(in) :: ctcplcFeFdcSuL(3,3,6),ctcplcFeFdcSuR(3,3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFEL(3,3),ZfFER(3,3),ZfSu(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFeFdcSuL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFeFdcSuR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplcFeFdcSuL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplcFeFdcSuR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFER(i1,gt2)*cplcFeFdcSuL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFEL(i1,gt2))*cplcFeFdcSuR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplcFeFdcSuL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplcFeFdcSuR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocFeFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocFeFd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,              & 
& cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSucSu(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),            & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),           & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),           & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplhhSucSu(2,6,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),         & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFd(gt3) 


! {Ah, conj[Su], Fe}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2L = cplcFeFeAhL(gt2,i3,i1)
coup2R = cplcFeFeAhR(gt2,i3,i1)
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


! {Chi, bar[Fu], Se}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MSe(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFeChiSeL(gt2,i1,i3)
coup2R = cplcFeChiSeR(gt2,i1,i3)
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


! {Fu, Chi, Sd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
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


! {Fu, Glu, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MGlu 
ML3 = MSd(i3) 
coup1L = cplGluFucSuL(i1,gt1)
coup1R = cplGluFucSuR(i1,gt1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
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


! {hh, conj[Su], Fe}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2L = cplcFeFehhL(gt2,i3,i1)
coup2R = cplcFeFehhR(gt2,i3,i1)
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


! {Su, Ah, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
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


! {Su, hh, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
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


! {Su, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSucSuVG(i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
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


! {Su, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSucSuVP(i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
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


! {Su, VZ, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplSucSuVZ(i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
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


! {VP, conj[Su], Fe}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = -cplSucSuVP(i2,gt1)
coup2L = cplcFeFeVPL(gt2,i3)
coup2R = cplcFeFeVPR(gt2,i3)
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


! {VZ, conj[Su], Fe}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = -cplSucSuVZ(i2,gt1)
coup2L = cplcFeFeVZL(gt2,i3)
coup2R = cplcFeFeVZR(gt2,i3)
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


! {bar[Cha], bar[Fd], Sv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFeChaSvL(gt2,i1,i3)
coup2R = cplcFeChaSvR(gt2,i1,i3)
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


! {bar[Fe], bar[Fd], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MAh(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFeAhL(gt2,i1,i3)
coup2R = cplcFeFeAhR(gt2,i1,i3)
coup3L = cplcFdFdAhL(i2,gt3,i3)
coup3R = cplcFdFdAhR(i2,gt3,i3)
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


! {bar[Fe], bar[Fd], hh}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFehhL(gt2,i1,i3)
coup2R = cplcFeFehhR(gt2,i1,i3)
coup3L = cplcFdFdhhL(i2,gt3,i3)
coup3R = cplcFdFdhhR(i2,gt3,i3)
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


! {bar[Fe], bar[Fd], Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFeSvL(gt2,i1,i3)
coup2R = cplcFeFeSvR(gt2,i1,i3)
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


! {bar[Fe], bar[Fd], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFeVPL(gt2,i1)
coup2R = cplcFeFeVPR(gt2,i1)
coup3L = cplcFdFdVPL(i2,gt3)
coup3R = cplcFdFdVPR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], bar[Fd], VZ}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MVZ 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFeVZL(gt2,i1)
coup2R = cplcFeFeVZR(gt2,i1)
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


! {bar[Fe], bar[Fd], conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFecSvL(gt2,i1,i3)
coup2R = cplcFeFecSvR(gt2,i1,i3)
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


! {conj[Hpm], conj[Sd], Fv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = 0. 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2L = cplcFeFvHpmL(gt2,i3,i1)
coup2R = cplcFeFvHpmR(gt2,i3,i1)
coup3L = cplFvFdcSdL(i3,gt3,i2)
coup3R = cplFvFdcSdR(i3,gt3,i2)
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


! {conj[Se], conj[Sd], Chi}
Do i1=1,6
  Do i2=1,6
    Do i3=1,4
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MChi(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2L = cplcFeChiSeL(gt2,i3,i1)
coup2R = cplcFeChiSeR(gt2,i3,i1)
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


! {conj[Se], conj[Sd], Fv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = 0. 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2L = cplcFeFvSeL(gt2,i3,i1)
coup2R = cplcFeFvSeR(gt2,i3,i1)
coup3L = cplFvFdcSdL(i3,gt3,i2)
coup3R = cplFvFdcSdR(i3,gt3,i2)
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


! {conj[VWm], conj[Sd], Fv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = 0. 
coup1 = -cplSdcSucVWm(i2,gt1)
coup2L = cplcFeFvVWmL(gt2,i3)
coup2R = cplcFeFvVWmR(gt2,i3)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocFeFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplAhSucSu,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,cplChiFucSuR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFeFehhL,cplcFeFehhR,           & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFeFvHpmL,cplcFeFvHpmR,         & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSucSu,cplcFecFuSdL,             & 
& cplcFecFuSdR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,              & 
& cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplAhSucSu(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFeChiSeL(3,4,6),       & 
& cplcFeChiSeR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),            & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),           & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),             & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),           & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplhhSucSu(2,6,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),         & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MFd(gt3) 


! {Su, VG, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MFd(i3) 
coup1 = -cplSucSuVG(i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
coup3L = cplcFdFdVGL(i3,gt3)
coup3R = cplcFdFdVGR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Su, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSucSuVP(i1,gt1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VP, conj[Su], Fe}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MFe(i3) 
coup1 = -cplSucSuVP(i2,gt1)
coup2L = cplcFeFeVPL(gt2,i3)
coup2R = cplcFeFeVPR(gt2,i3)
coup3L = cplcFeFdcSuL(i3,gt3,i2)
coup3R = cplcFeFdcSuR(i3,gt3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Fe], bar[Fd], VP}
Do i1=1,3
  Do i2=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MVP 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFeFeVPL(gt2,i1)
coup2R = cplcFeFeVPR(gt2,i1)
coup3L = cplcFdFdVPL(i2,gt3)
coup3R = cplcFdFdVPR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocFeFd


Subroutine Amplitude_Tree_MSSMTriLnV_SuToGluFu(cplGluFucSuL,cplGluFucSuR,             & 
& MFu,MGlu,MSu,MFu2,MGlu2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MGlu,MSu(6),MFu2(3),MGlu2,MSu2(6)

Complex(dp), Intent(in) :: cplGluFucSuL(3,6),cplGluFucSuR(3,6)

Complex(dp) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
    Do gt3=1,3
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MGlu 
Mex3 = MFu(gt3) 
! Tree-Level Vertex 
coupT1L = cplGluFucSuL(gt3,gt1)
coupT1R = cplGluFucSuR(gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt3) = AmpC 
    End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuToGluFu


Subroutine Gamma_Real_MSSMTriLnV_SuToGluFu(MLambda,em,gs,cplGluFucSuL,cplGluFucSuR,   & 
& MFu,MGlu,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplGluFucSuL(3,6),cplGluFucSuR(3,6)

Real(dp), Intent(in) :: MFu(3),MGlu,MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3), GammarealGluon(6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
    Do i3=1,3
CoupL = cplGluFucSuL(i3,i1)
CoupR = cplGluFucSuR(i3,i1)
Mex1 = MSu(i1)
Mex2 = MGlu
Mex3 = MFu(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,16._dp/27._dp,0._dp,16._dp/27._dp,0._dp,0._dp,16._dp/27._dp,CoupL,CoupR,Gammarealphoton(i1,i3),kont)
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,gs,16._dp/9._dp,2._dp,-2._dp/9._dp,4._dp,-2._dp,16._dp/9._dp,CoupL,CoupR,Gammarealgluon(i1,i3),kont)
Else 
  GammarealGluon(i1,i3) = 0._dp 
  GammarealPhoton(i1,i3) = 0._dp 

End if 
    End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuToGluFu


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToGluFu(cplGluFucSuL,cplGluFucSuR,             & 
& ctcplGluFucSuL,ctcplGluFucSuR,MFu,MFu2,MGlu,MGlu2,MSu,MSu2,ZffG,ZfFUL,ZfFUR,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MGlu,MGlu2,MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplGluFucSuL(3,6),cplGluFucSuR(3,6)

Complex(dp), Intent(in) :: ctcplGluFucSuL(3,6),ctcplGluFucSuR(3,6)

Complex(dp), Intent(in) :: ZffG,ZfFUL(3,3),ZfFUR(3,3),ZfSu(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MGlu 
Mex3 = MFu(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplGluFucSuL(gt3,gt1) 
ZcoupT1R = ctcplGluFucSuR(gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplGluFucSuL(gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplGluFucSuR(gt3,i1)
End Do


! External Field 2 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZffG*cplGluFucSuL(gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZffG)*cplGluFucSuR(gt3,gt1)


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt3)*cplGluFucSuL(i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt3))*cplGluFucSuR(i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt3) = 4._dp/3._dp*AmpC 
    End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToGluFu


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToGluFu(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSucSu(2,6,6),cplChaFucSdL(2,3,6),          & 
& cplChaFucSdR(2,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplGluFdcSdL(3,6),         & 
& cplGluFdcSdR(3,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),       & 
& cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),           & 
& cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),           & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),            & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL(3,6),         & 
& cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),               & 
& cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSucSuVG(6,6),              & 
& cplSucSuVP(6,6),cplSucSuVZ(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MGlu 
Mex3 = MFu(gt3) 


! {Fd, Cha, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MSd(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3L = cplChaFucSdL(i2,gt3,i3)
coup3R = cplChaFucSdR(i2,gt3,i3)
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


! {Fd, Fe, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MSd(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3L = cplFeFucSdL(i2,gt3,i3)
coup3R = cplFeFucSdR(i2,gt3,i3)
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


! {Fu, Chi, Su}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MSu(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3L = cplChiFucSuL(i2,gt3,i3)
coup3R = cplChiFucSuR(i2,gt3,i3)
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


! {Fu, Glu, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MGlu 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,gt1)
coup1R = cplGluFucSuR(i1,gt1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3L = cplGluFucSuL(gt3,i3)
coup3R = cplGluFucSuR(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Glu, bar[Fu], VG}
  Do i2=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MVG 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplcFuFuVGL(i2,gt3)
coup3R = cplcFuFuVGR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(2*(0.,1._dp))*AmpC 
  End Do


! {Sd, Hpm, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFuHpmL(i3,gt3,i2)
coup3R = cplcFdFuHpmR(i3,gt3,i2)
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


! {Sd, Se, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFuSeL(i3,gt3,i2)
coup3R = cplcFdFuSeR(i3,gt3,i2)
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


! {Sd, VWm, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MFd(i3) 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFuVWmL(i3,gt3)
coup3R = cplcFdFuVWmR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Su, Ah, Fu}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuAhL(i3,gt3,i2)
coup3R = cplcFuFuAhR(i3,gt3,i2)
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


! {Su, hh, Fu}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MFu(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuhhL(i3,gt3,i2)
coup3R = cplcFuFuhhR(i3,gt3,i2)
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


! {Su, VG, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MFu(i3) 
coup1 = -cplSucSuVG(i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuVGL(i3,gt3)
coup3R = cplcFuFuVGR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Su, VP, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MFu(i3) 
coup1 = -cplSucSuVP(i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuVPL(i3,gt3)
coup3R = cplcFuFuVPR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Su, VZ, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MFu(i3) 
coup1 = -cplSucSuVZ(i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuVZL(i3,gt3)
coup3R = cplcFuFuVZR(i3,gt3)
If ((Abs(coup1))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VG, conj[Su], Glu}
  Do i2=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MGlu 
coup1 = -cplSucSuVG(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplGluFucSuL(gt3,i2)
coup3R = cplGluFucSuR(gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToGluFu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,        & 
& cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,            & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,           & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSucSu(2,6,6),cplChaFucSdL(2,3,6),          & 
& cplChaFucSdR(2,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplGluFdcSdL(3,6),         & 
& cplGluFdcSdR(3,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),       & 
& cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),           & 
& cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),           & 
& cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),            & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL(3,6),         & 
& cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),               & 
& cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSucSuVG(6,6),              & 
& cplSucSuVP(6,6),cplSucSuVZ(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MGlu 
Mex3 = MFu(gt3) 


! {Glu, bar[Fu], VG}
  Do i2=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MVG 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplcFuFuVGL(i2,gt3)
coup3R = cplcFuFuVGR(i2,gt3)
Call Amp_VERTEX_StoFF_Topology1_FFV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(2*(0.,1._dp))*AmpC 
  End Do


! {Su, VG, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MFu(i3) 
coup1 = -cplSucSuVG(i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuVGL(i3,gt3)
coup3R = cplcFuFuVGR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Su, VP, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MFu(i3) 
coup1 = -cplSucSuVP(i1,gt1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuVPL(i3,gt3)
coup3R = cplcFuFuVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VG, conj[Su], Glu}
  Do i2=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MGlu 
coup1 = -cplSucSuVG(i2,gt1)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplGluFucSuL(gt3,i2)
coup3R = cplGluFucSuR(gt3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2*(0.,1._dp))*AmpC 
  End Do
    End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToGluFu


Subroutine Amplitude_Tree_MSSMTriLnV_SuToSuhh(cplhhSucSu,Mhh,MSu,Mhh2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),MSu(6),Mhh2(2),MSu2(6)

Complex(dp), Intent(in) :: cplhhSucSu(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = Mhh(gt3) 
! Tree-Level Vertex 
coupT1 = cplhhSucSu(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuToSuhh


Subroutine Gamma_Real_MSSMTriLnV_SuToSuhh(MLambda,em,gs,cplhhSucSu,Mhh,               & 
& MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplhhSucSu(2,6,6)

Real(dp), Intent(in) :: Mhh(2),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
Coup = cplhhSucSu(i3,i2,i1)
Mex1 = MSu(i1)
Mex2 = MSu(i2)
Mex3 = Mhh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,4._dp/9._dp,0._dp,4._dp/9._dp,0._dp,0._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuToSuhh


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuhh(cplhhSucSu,ctcplhhSucSu,Mhh,            & 
& Mhh2,MSu,MSu2,Zfhh,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplhhSucSu(2,6,6)

Complex(dp), Intent(in) :: ctcplhhSucSu(2,6,6)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSu(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = Mhh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplhhSucSu(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplhhSucSu(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplhhSucSu(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt3)*cplhhSucSu(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuhh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,              & 
& cplAhhhVZ,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,     & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa, & 
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhSucSu(2,6,6),cplcChaChahhL(2,2,2),               & 
& cplcChaChahhR(2,2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiChihhL(4,4,2),      & 
& cplChiChihhR(4,4,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcChaFdcSuL(2,3,6),        & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFeFehhL(3,3,2),       & 
& cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),            & 
& cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuGluSuL(3,6),             & 
& cplcFuGluSuR(3,6),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplSdcHpmcSu(6,2,6), & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),& 
& cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplAhAhSucSuaa(2,2,6,6),cplhhhhSucSuaa(2,2,6,6),      & 
& cplhhHpmSucSdaa(2,2,6,6),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSecSuaa(2,6,6,6),           & 
& cplhhSeSucSdaa(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSeSucSecSuaa(6,6,6,6),cplSuSucSucSuabba(6,6,6,6),        & 
& cplSuSucSucSuabab(6,6,6,6),cplSuSvcSucSvaa(6,3,6,3),cplSucSucVWmVWmaa(6,6),            & 
& cplSucSuVZVZaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = Mhh(gt3) 


! {Ah, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
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


! {Chi, bar[Fu], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
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


! {Fd, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fu, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,i3,gt2)
coup2R = cplcFuChiSuR(i1,i3,gt2)
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


! {Glu, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
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


! {Sd, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
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


! {Sd, VWm, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Su, Ah, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, VZ, Ah}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MAh(i3) 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, hh, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, Ah, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MVZ 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = -cplSucSuVZ(gt2,i1)
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


! {Su, VZ, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = -cplSucSuVZ(gt2,i1)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
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


! {VZ, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = -cplSucSuVZ(gt2,i3)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = -cplSucSdVWm(gt2,i3)
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


! {hh, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhhhSucSuaa(gt3,i1,gt2,i2)
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
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplhhHpmSucSdaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplhhSeSucSdaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhhhSucSuaa(gt3,i1,i2,gt1)
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
coup1 = cplhhSdcHpmcSuaa(gt3,i1,i2,gt1)
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
coup1 = cplhhSdcSecSuaa(gt3,i1,i2,gt1)
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


! {Ah, Ah}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MAh(i2) 
coup1 = cplAhAhSucSuaa(i1,i2,gt2,gt1)
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
coup1 = cplhhhhSucSuaa(i1,i2,gt2,gt1)
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
coup1 = cplHpmSucHpmcSuaa(i1,gt2,i2,gt1)
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
coup1 = cplSdSucSdcSuabba(i1,gt2,i2,gt1)
coup2 = cplhhSdcSd(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSucSdcSuabab(i1,gt2,i2,gt1)
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
coup1 = cplSeSucSecSuaa(i1,gt2,i2,gt1)
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
coup1 = cplSuSucSucSuabba(gt2,i1,gt1,i2)
coup2 = cplhhSucSu(gt3,i2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSuSucSucSuabab(gt2,i1,gt1,i2)
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
coup1 = cplSuSvcSucSvaa(gt2,i1,gt1,i2)
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
coup1 = cplSucSucVWmVWmaa(gt2,gt1)
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
coup1 = cplSucSuVZVZaa(gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,         & 
& cplAhhhVZ,cplAhSucSu,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,cplcFdChaSuR,            & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuGluSuL,cplcFuGluSuR,cplhhhhhh,cplhhHpmcHpm,              & 
& cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,    & 
& cplhhVZVZ,cplHpmSucSd,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,     & 
& cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplAhAhSucSuaa,cplhhhhSucSuaa,cplhhHpmSucSdaa,       & 
& cplhhSdcHpmcSuaa,cplhhSdcSecSuaa,cplhhSeSucSdaa,cplHpmSucHpmcSuaa,cplSdSucSdcSuabba,   & 
& cplSdSucSdcSuabab,cplSeSucSecSuaa,cplSuSucSucSuabba,cplSuSucSucSuabab,cplSuSvcSucSvaa, & 
& cplSucSucVWmVWmaa,cplSucSuVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhSucSu(2,6,6),cplcChaChahhL(2,2,2),               & 
& cplcChaChahhR(2,2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiChihhL(4,4,2),      & 
& cplChiChihhR(4,4,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcChaFdcSuL(2,3,6),        & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFeFehhL(3,3,2),       & 
& cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),            & 
& cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuGluSuL(3,6),             & 
& cplcFuGluSuR(3,6),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),               & 
& cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSucSd(2,6,6),cplSdcHpmcSu(6,2,6), & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),& 
& cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplAhAhSucSuaa(2,2,6,6),cplhhhhSucSuaa(2,2,6,6),      & 
& cplhhHpmSucSdaa(2,2,6,6),cplhhSdcHpmcSuaa(2,6,2,6),cplhhSdcSecSuaa(2,6,6,6),           & 
& cplhhSeSucSdaa(2,6,6,6),cplHpmSucHpmcSuaa(2,6,2,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSeSucSecSuaa(6,6,6,6),cplSuSucSucSuabba(6,6,6,6),        & 
& cplSuSucSucSuabab(6,6,6,6),cplSuSvcSucSvaa(6,3,6,3),cplSucSucVWmVWmaa(6,6),            & 
& cplSucSuVZVZaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = Mhh(gt3) 


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = -cplSucSuVG(gt2,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = -cplSucSuVP(gt2,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuhh


Subroutine Amplitude_Tree_MSSMTriLnV_SuTocHpmSd(cplSdcHpmcSu,MHpm,MSd,MSu,            & 
& MHpm2,MSd2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MSd(6),MSu(6),MHpm2(2),MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplSdcHpmcSu(6,2,6)

Complex(dp) :: Amp(6,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdcHpmcSu(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuTocHpmSd


Subroutine Gamma_Real_MSSMTriLnV_SuTocHpmSd(MLambda,em,gs,cplSdcHpmcSu,               & 
& MHpm,MSd,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcHpmcSu(6,2,6)

Real(dp), Intent(in) :: MHpm(2),MSd(6),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,2,6), GammarealGluon(6,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=2,2
    Do i3=1,6
Coup = cplSdcHpmcSu(i3,i2,i1)
Mex1 = MSu(i1)
Mex2 = MHpm(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,2._dp/3._dp,-2._dp/9._dp,1._dp,-1._dp/3._dp,1._dp/9._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuTocHpmSd


Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocHpmSd(cplSdcHpmcSu,ctcplSdcHpmcSu,          & 
& MHpm,MHpm2,MSd,MSd2,MSu,MSu2,ZfHpm,ZfSd,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSd(6),MSd2(6),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplSdcHpmcSu(6,2,6)

Complex(dp), Intent(in) :: ctcplSdcHpmcSu(6,2,6)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSd(6,6),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(6,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcHpmcSu(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplSdcHpmcSu(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfHpm(i1,gt2))*cplSdcHpmcSu(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdcHpmcSu(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocHpmSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocHpmSd(MAh,MCha,MChi,MFd,MFe,              & 
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

Complex(dp), Intent(out) :: Amp(6,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSd(gt3) 


! {Ah, conj[Su], Hpm}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhHpmcHpm(i1,i3,gt2)
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


! {Ah, conj[Su], VWm}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhcHpmVWm(i1,gt2)
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


! {Chi, bar[Fu], Cha}
Do i1=1,4
  Do i2=1,3
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplChiChacHpmL(i1,i3,gt2)
coup2R = cplChiChacHpmR(i1,i3,gt2)
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


! {Fu, Chi, Fd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuFdcHpmL(i1,i3,gt2)
coup2R = cplcFuFdcHpmR(i1,i3,gt2)
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


! {Fu, Glu, Fd}
Do i1=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplGluFucSuL(i1,gt1)
coup1R = cplGluFucSuR(i1,gt1)
coup2L = cplcFuFdcHpmL(i1,i3,gt2)
coup2R = cplcFuFdcHpmR(i1,i3,gt2)
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


! {hh, conj[Su], Hpm}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhHpmcHpm(i1,i3,gt2)
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


! {hh, conj[Su], VWm}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhcHpmVWm(i1,gt2)
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


! {Su, Ah, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
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


! {Su, hh, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
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


! {Su, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSucSuVG(i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
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


! {Su, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
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


! {Su, VZ, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
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


! {VP, conj[Su], Hpm}
  Do i2=1,6
    Do i3=1,2
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplHpmcHpmVP(i3,gt2)
coup3 = cplSdcHpmcSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[Su], VWm}
  Do i2=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplSdcSucVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VZ, conj[Su], Hpm}
  Do i2=1,6
    Do i3=1,2
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplHpmcHpmVZ(i3,gt2)
coup3 = cplSdcHpmcSu(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Su], VWm}
  Do i2=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplcHpmVWmVZ(gt2)
coup3 = cplSdcSucVWm(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {bar[Cha], bar[Fd], Chi}
Do i1=1,2
  Do i2=1,3
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplChiChacHpmL(i3,i1,gt2)
coup2R = cplChiChacHpmR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplFvFecHpmL(i3,i1,gt2)
coup2R = cplFvFecHpmR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], Ah}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplAhHpmcHpm(i3,i1,gt2)
coup3 = cplAhSdcSd(i3,gt3,i2)
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


! {conj[Hpm], conj[Sd], hh}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplhhHpmcHpm(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], VP}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], conj[Sd], VZ}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmcHpmVZ(i1,gt2)
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


! {conj[Se], conj[Sd], conj[Sv]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSecHpmcSv(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], Ah}
  Do i2=1,6
    Do i3=1,2
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplAhcHpmVWm(i3,gt2)
coup3 = cplAhSdcSd(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Sd], hh}
  Do i2=1,6
    Do i3=1,2
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplhhcHpmVWm(i3,gt2)
coup3 = cplhhSdcSd(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[VWm], conj[Sd], VP}
  Do i2=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplSdcSdVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {conj[VWm], conj[Sd], VZ}
  Do i2=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplcHpmVWmVZ(gt2)
coup3 = cplSdcSdVZ(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {Ah, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSdcHpmcSuaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSdcHpmcSuaa(i1,gt3,gt2,i2)
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
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSdcHpmcSdaa(i2,gt3,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSdSecHpmcSdaa(gt3,i2,gt2,i1)
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
coup1 = cplAhSdcHpmcSuaa(i1,gt3,i2,gt1)
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
coup1 = cplhhSdcHpmcSuaa(i1,gt3,i2,gt1)
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
coup1 = cplSdSucSdcSuabba(gt3,i1,i2,gt1)
coup2 = cplSdcHpmcSu(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

coup1 = cplSdSucSdcSuabab(gt3,i1,i2,gt1)
coup2 = cplSdcHpmcSu(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sv, Se}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
coup1 = cplSdSvcSecSuaa(gt3,i1,i2,gt1)
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
coup1 = cplSdcSucVWmVPaa(gt3,gt1)
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
coup1 = cplSdcSucVWmVZaa(gt3,gt1)
coup2 = cplcHpmVWmVZ(gt2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 



! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcHpmcSuaa(i1,i2,gt2,gt1)
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
coup1 = cplhhSdcHpmcSuaa(i1,i2,gt2,gt1)
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
coup1 = cplHpmSucHpmcSuaa(i1,i2,gt2,gt1)
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
coup1 = cplSdcHpmcSucSvaa(i1,gt2,gt1,i2)
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


! {Sd, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MSv(i2) 
coup1 = cplSdSvcHpmcSuaa(i1,i2,gt2,gt1)
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
coup1 = cplSeSucHpmcSuaa(i1,i2,gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocHpmSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd(MAh,MCha,MChi,MFd,               & 
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

Complex(dp), Intent(out) :: Amp(6,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,6
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSd(gt3) 


! {Su, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSucSuVG(i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
coup3 = cplSdcSdVG(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Su, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcHpmcSu(i3,gt2,i1)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VP, conj[Su], Hpm}
  Do i2=1,6
    Do i3=1,2
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplHpmcHpmVP(i3,gt2)
coup3 = cplSdcHpmcSu(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VP, conj[Su], VWm}
  Do i2=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplSdcSucVWm(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {conj[Hpm], conj[Sd], VP}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmcHpmVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[VWm], conj[Sd], VP}
  Do i2=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplcHpmVPVWm(gt2)
coup3 = cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do


! {VP, VWm}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplSdcSucVWmVPaa(gt3,gt1)
coup2 = cplcHpmVPVWm(gt2)
Call Amp_VERTEX_StoSS_Topology3_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocHpmSd


Subroutine Amplitude_Tree_MSSMTriLnV_SuTocSeSd(cplSdcSecSu,MSd,MSe,MSu,               & 
& MSd2,MSe2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSe(6),MSu(6),MSd2(6),MSe2(6),MSu2(6)

Complex(dp), Intent(in) :: cplSdcSecSu(6,6,6)

Complex(dp) :: Amp(6,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,6
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdcSecSu(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuTocSeSd


Subroutine Gamma_Real_MSSMTriLnV_SuTocSeSd(MLambda,em,gs,cplSdcSecSu,MSd,             & 
& MSe,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcSecSu(6,6,6)

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
Coup = cplSdcSecSu(i3,i2,i1)
Mex1 = MSu(i1)
Mex2 = MSe(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,2._dp/3._dp,-2._dp/9._dp,1._dp,-1._dp/3._dp,1._dp/9._dp,Coup,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationSSS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,Coup,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuTocSeSd


Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocSeSd(cplSdcSecSu,ctcplSdcSecSu,             & 
& MSd,MSd2,MSe,MSe2,MSu,MSu2,ZfSd,ZfSe,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplSdcSecSu(6,6,6)

Complex(dp), Intent(in) :: ctcplSdcSecSu(6,6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSecSu(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplSdcSecSu(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt2))*cplSdcSecSu(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdcSecSu(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuTocSeSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocSeSd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplAhSecSe,cplAhSucSu,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,             & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,       & 
& cplSucSuVZ,cplSvcSeVWm,cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,               & 
& cplHpmSucSecSuaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplFvChacSeL(3,2,6),            & 
& cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcChaFdcSuL(2,3,6),      & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcSeL(3,3,6),      & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplGluFucSuL(3,6),           & 
& cplGluFucSuR(3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),               & 
& cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),  & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecSecSv(6,6,3),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),   & 
& cplAhSdcSecSuaa(2,6,6,6),cplhhSdcSecSuaa(2,6,6,6),cplHpmSdcSdcSeaa(2,6,6,6),           & 
& cplHpmSucSecSuaa(2,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSvcSecSuaa(6,3,6,6),cplSdcHpmcSucSvaa(6,2,6,3),        & 
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
Mex1 = MSu(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSd(gt3) 


! {Ah, conj[Su], Se}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSecSe(i1,i3,gt2)
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


! {Chi, bar[Fu], Fe}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplChiFecSeL(i1,i3,gt2)
coup2R = cplChiFecSeR(i1,i3,gt2)
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


! {Fu, Chi, Fd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuFdcSeL(i1,i3,gt2)
coup2R = cplcFuFdcSeR(i1,i3,gt2)
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


! {Fu, Glu, Fd}
Do i1=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplGluFucSuL(i1,gt1)
coup1R = cplGluFucSuR(i1,gt1)
coup2L = cplcFuFdcSeL(i1,i3,gt2)
coup2R = cplcFuFdcSeR(i1,i3,gt2)
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


! {hh, conj[Su], Se}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSecSe(i1,i3,gt2)
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


! {Su, Ah, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
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


! {Su, hh, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
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


! {Su, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSucSuVG(i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
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


! {Su, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
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


! {Su, VZ, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
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


! {VP, conj[Su], Se}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSecSeVP(i3,gt2)
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


! {VZ, conj[Su], Se}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplSecSeVZ(i3,gt2)
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


! {bar[Cha], bar[Fd], Fv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplFvChacSeL(i3,i1,gt2)
coup2R = cplFvChacSeR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplChiFecSeL(i3,i1,gt2)
coup2R = cplChiFecSeR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplFvFecSeL(i3,i1,gt2)
coup2R = cplFvFecSeR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], Sv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSvcSe(i1,i3,gt2)
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


! {conj[Se], conj[Sd], Ah}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplAhSecSe(i3,i1,gt2)
coup3 = cplAhSdcSd(i3,gt3,i2)
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


! {conj[Se], conj[Sd], hh}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplhhSecSe(i3,i1,gt2)
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


! {conj[Se], conj[Sd], Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSvcSe(i1,i3,gt2)
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


! {conj[Se], conj[Sd], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSecSeVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Se], conj[Sd], VZ}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSecSeVZ(i1,gt2)
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


! {conj[Se], conj[Sd], conj[Sv]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSecSecSv(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], Sv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplSvcSeVWm(i3,gt2)
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


! {Ah, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSdcSecSuaa(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Su]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSdcSecSuaa(i1,gt3,gt2,i2)
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
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSdcSdcSeaa(i2,gt3,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSdSecSdcSeaa(gt3,i2,i1,gt2)
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
coup1 = cplAhSdcSecSuaa(i1,gt3,i2,gt1)
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
coup1 = cplhhSdcSecSuaa(i1,gt3,i2,gt1)
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
coup1 = cplSdSucSdcSuabba(gt3,i1,i2,gt1)
coup2 = cplSdcSecSu(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 

coup1 = cplSdSucSdcSuabab(gt3,i1,i2,gt1)
coup2 = cplSdcSecSu(i2,gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

  End Do
End Do


! {Sv, Se}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
coup1 = cplSdSvcSecSuaa(gt3,i1,i2,gt1)
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
coup1 = cplSdcHpmcSucSvaa(gt3,i1,gt1,i2)
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


! {Ah, conj[Sd]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSd(i2) 
coup1 = cplAhSdcSecSuaa(i1,i2,gt2,gt1)
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
coup1 = cplhhSdcSecSuaa(i1,i2,gt2,gt1)
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
coup1 = cplHpmSucSecSuaa(i1,i2,gt2,gt1)
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
coup1 = cplSdSvcSecSuaa(i1,i2,gt2,gt1)
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
coup1 = cplSeSucSecSuaa(i1,i2,gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuTocSeSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhSdcSd,        & 
& cplAhSecSe,cplAhSucSu,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,             & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,       & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSvcSe,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,         & 
& cplSdcSdVZ,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSucSuVG,cplSucSuVP,       & 
& cplSucSuVZ,cplSvcSeVWm,cplAhSdcSecSuaa,cplhhSdcSecSuaa,cplHpmSdcSdcSeaa,               & 
& cplHpmSucSecSuaa,cplSdSecSdcSeaa,cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcSecSuaa,  & 
& cplSdcHpmcSucSvaa,cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplFvChacSeL(3,2,6),            & 
& cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcChaFdcSuL(2,3,6),      & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcSeL(3,3,6),      & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplGluFucSuL(3,6),           & 
& cplGluFucSuR(3,6),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),             & 
& cplcFdGluSdR(3,6),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),               & 
& cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),  & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),        & 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecSecSv(6,6,3),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),   & 
& cplAhSdcSecSuaa(2,6,6,6),cplhhSdcSecSuaa(2,6,6,6),cplHpmSdcSdcSeaa(2,6,6,6),           & 
& cplHpmSucSecSuaa(2,6,6,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSucSdcSuabba(6,6,6,6),         & 
& cplSdSucSdcSuabab(6,6,6,6),cplSdSvcSecSuaa(6,3,6,6),cplSdcHpmcSucSvaa(6,2,6,3),        & 
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
Mex1 = MSu(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MSd(gt3) 


! {Su, VG, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1 = cplSucSuVG(i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
coup3 = cplSdcSdVG(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Su, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcSecSu(i3,gt2,i1)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VP, conj[Su], Se}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSecSeVP(i3,gt2)
coup3 = cplSdcSecSu(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {conj[Se], conj[Sd], VP}
Do i1=1,6
  Do i2=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSecSeVP(i1,gt2)
coup3 = cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_StoSS_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuTocSeSd


Subroutine Amplitude_Tree_MSSMTriLnV_SuToSdcVWm(cplSdcSucVWm,MSd,MSu,MVWm,            & 
& MSd2,MSu2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSu(6),MVWm,MSd2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplSdcSucVWm(6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = -cplSdcSucVWm(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuToSdcVWm


Subroutine Gamma_Real_MSSMTriLnV_SuToSdcVWm(MLambda,em,gs,cplSdcSucVWm,               & 
& MSd,MSu,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSdcSucVWm(6,6)

Real(dp), Intent(in) :: MSd(6),MSu(6),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6), GammarealGluon(6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
Coup = cplSdcSucVWm(i2,i1)
Mex1 = MSu(i1)
Mex2 = MSd(i2)
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,2._dp/3._dp,-1._dp/3._dp,1._dp,Coup,Gammarealphoton(i1,i2),kont)
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,gs,1._dp,1._dp,0._dp,Coup,Gammarealgluon(i1,i2),kont)
 GammarealGluon(i1,i2) = GammarealGluon(i1,i2)*4._dp/3._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuToSdcVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSdcVWm(cplSdcSucVWm,ctcplSdcSucVWm,          & 
& MSd,MSd2,MSu,MSu2,MVWm,MVWm2,ZfSd,ZfSu,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSd(6),MSd2(6),MSu(6),MSu2(6),MVWm,MVWm2

Complex(dp), Intent(in) :: cplSdcSucVWm(6,6)

Complex(dp), Intent(in) :: ctcplSdcSucVWm(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSucVWm(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplSdcSucVWm(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt2)*cplSdcSucVWm(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplSdcSucVWm(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSdcVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSdcVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplAhHpmcVWm,      & 
& cplAhSdcSd,cplAhSucSu,cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,cplChiFucSuR,         & 
& cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,cplGluFucSuR,       & 
& cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,cplhhSdcSd,             & 
& cplhhSucSu,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSdVG,               & 
& cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,cplSdcSecSu,            & 
& cplSdcSucVWm,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,               & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1,cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,            & 
& cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplChiChacVWmL(4,2),            & 
& cplChiChacVWmR(4,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),       & 
& cplcFdChiSdR(3,4,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),     & 
& cplcFeFdcSuR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFdFvSdL(3,3,6),              & 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplhhcVWmVWm(2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),   & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),         & 
& cplSecSvcVWm(6,3),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplcVWmVPVWm,        & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSdcSucVWmVPaa(6,6),cplSdcSdcVWmVWmaa(6,6),& 
& cplSdcSucVWmVZaa(6,6),cplSucSucVWmVWmaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVWm 


! {Ah, conj[Su], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSdcSd(i1,gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
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


! {Chi, bar[Fu], bar[Fd]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFdChiSdL(i3,i1,gt2)
coup2R = cplcFdChiSdR(i3,i1,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
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


! {Fd, Cha, Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdChiSdL(i1,i3,gt2)
coup2R = cplcFdChiSdR(i1,i3,gt2)
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


! {Fd, Fe, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,i3,gt2)
coup2R = cplcFdFvSdR(i1,i3,gt2)
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


! {Fu, Chi, bar[Cha]}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i3,i1,gt2)
coup2R = cplcChacFuSdR(i3,i1,gt2)
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


! {Glu, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplcFdGluSdL(i3,gt2)
coup2R = cplcFdGluSdR(i3,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSdcSd(i1,gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
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


! {Sd, Hpm, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplAhSdcSd(i3,gt2,i1)
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


! {Sd, Hpm, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, VWm, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplhhSdcSd(i3,gt2,i1)
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


! {Sd, Se, Sv}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSdSvcSd(gt2,i3,i1)
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


! {Sd, Hpm, VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplSdcSdVP(gt2,i1)
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


! {Sd, VWm, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, Hpm, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplSdcSdVZ(gt2,i1)
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


! {Sd, VWm, VZ}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplSdcSdVZ(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, Ah, conj[Hpm]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, hh, conj[Hpm]}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
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


! {Su, VP, conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSucSuVP(i1,gt1)
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


! {Su, VZ, conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplSucSuVZ(i1,gt1)
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


! {Su, hh, conj[VWm]}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
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


! {Su, VP, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VZ, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplSdcSdVZ(gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2 = cplSdcSdcVWmVWmaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSdcSucVWmVGLamct4ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSdcSucVWmVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
coup1 = -cplSucSuVZ(i1,gt1)
coup2 = cplSdcSucVWmVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSucVWmVGLamct4ct2ct1(i1,gt1)
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
coup1 = cplSdcSucVWmVPaa(i1,gt1)
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
coup1 = cplSdcSucVWmVZaa(i1,gt1)
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
coup1 = cplSucSucVWmVWmaa(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSdcVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplAhHpmcVWm,cplAhSdcSd,cplAhSucSu,cplChiChacVWmL,cplChiChacVWmR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,       & 
& cplcFeFdcSuR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplGluFucSuL,       & 
& cplGluFucSuR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplhhHpmcVWm,           & 
& cplhhSdcSd,cplhhSucSu,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,cplSdSvcSd,               & 
& cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplSdcHpmcSu,             & 
& cplSdcSecSu,cplSdcSucVWm,cplSecSvcVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,cplcVWmVPVWm,   & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1,cplSdcSucVWmVPaa,cplSdcSdcVWmVWmaa,            & 
& cplSdcSucVWmVZaa,cplSucSucVWmVWmaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcVWm(2,2),cplAhSdcSd(2,6,6),cplAhSucSu(2,6,6),cplChiChacVWmL(4,2),            & 
& cplChiChacVWmR(4,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),       & 
& cplcFdChiSdR(3,4,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),     & 
& cplcFeFdcSuR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFdFvSdL(3,3,6),              & 
& cplcFdFvSdR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6),cplhhcVWmVWm(2),cplHpmcVWmVP(2),cplHpmcVWmVZ(2),   & 
& cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),         & 
& cplSecSvcVWm(6,3),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSuVZ(6,6),cplcVWmVPVWm,        & 
& cplcVWmVWmVZ,cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSdcSucVWmVPaa(6,6),cplSdcSdcVWmVWmaa(6,6),& 
& cplSdcSucVWmVZaa(6,6),cplSucSucVWmVWmaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSd(gt2) 
Mex3 = MVWm 


! {Sd, Hpm, VP}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplSdcSdVP(gt2,i1)
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_StoSV_Topology1_SSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, VWm, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VP, conj[Hpm]}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcHpmcSu(gt2,i3,i1)
coup3 = cplHpmcVWmVP(i3)
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Su, VP, conj[VWm]}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSucSuVP(i1,gt1)
coup2 = cplSdcSucVWm(gt2,i1)
coup3 = cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSdcSdVG(gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSdcSdVP(gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSdcSucVWmVGLamct4ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSdcSucVWmVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VG}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVG 
coup1 = cplSdcSucVWmVGLamct4ct2ct1(i1,gt1)
coup2 = cplSdcSdVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Sd, VP}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVP 
coup1 = cplSdcSucVWmVPaa(i1,gt1)
coup2 = cplSdcSdVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSdcVWm


Subroutine Amplitude_Tree_MSSMTriLnV_SuToSuVZ(cplSucSuVZ,MSu,MVZ,MSu2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MVZ,MSu2(6),MVZ2

Complex(dp), Intent(in) :: cplSucSuVZ(6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1 = -cplSucSuVZ(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SuToSuVZ


Subroutine Gamma_Real_MSSMTriLnV_SuToSuVZ(MLambda,em,gs,cplSucSuVZ,MSu,               & 
& MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSucSuVZ(6,6)

Real(dp), Intent(in) :: MSu(6),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6), GammarealGluon(6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
Coup = cplSucSuVZ(i2,i1)
Mex1 = MSu(i1)
Mex2 = MSu(i2)
Mex3 = MVZ
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,em,2._dp/3._dp,2._dp/3._dp,0._dp,Coup,Gammarealphoton(i1,i2),kont)
 Call hardradiationSSV(Mex1,Mex2,Mex3,MLambda,gs,1._dp,1._dp,0._dp,Coup,Gammarealgluon(i1,i2),kont)
 GammarealGluon(i1,i2) = GammarealGluon(i1,i2)*4._dp/3._dp 
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SuToSuVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuVZ(cplSucSuVP,cplSucSuVZ,ctcplSucSuVP,     & 
& ctcplSucSuVZ,MSu,MSu2,MVP,MVP2,MVZ,MVZ2,ZfSu,ZfVPVZ,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MSu2(6),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplSucSuVP(6,6),cplSucSuVZ(6,6)

Complex(dp), Intent(in) :: ctcplSucSuVP(6,6),ctcplSucSuVZ(6,6)

Complex(dp), Intent(in) :: ZfSu(6,6),ZfVPVZ,ZfVZ

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSucSuVZ(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplSucSuVZ(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplSucSuVZ(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVPVZ*cplSucSuVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplSucSuVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSucSu,             & 
& cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,     & 
& cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,cplSucSuVPVZaa,cplSucSdVWmVZaa,              & 
& cplSucSuVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),             & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),             & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),           & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),         & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuVZL(3,3),& 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),cplhhVZVZ(2),   & 
& cplHpmSucSd(2,6,6),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcHpmcSu(6,2,6),& 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSecSeVZ(6,6),cplSucSuVG(6,6),& 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplcHpmVWmVZ(2),cplcVWmVWmVZ,         & 
& cplSdcSucVWmVZaa(6,6),cplSucSuVGVZLamct3ct2ct1(6,6),cplSucSuVPVZaa(6,6),               & 
& cplSucSdVWmVZaa(6,6),cplSucSuVZVZaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVZ 


! {Ah, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
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


! {Chi, bar[Fu], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
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


! {Fd, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fu, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFucSuL(i2,i1,gt1)
coup1R = cplChiFucSuR(i2,i1,gt1)
coup2L = cplcFuChiSuL(i1,i3,gt2)
coup2R = cplcFuChiSuR(i1,i3,gt2)
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


! {Glu, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
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


! {Sd, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSdcSucVWm(i1,gt1)
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


! {Sd, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplSucSdVWm(gt2,i1)
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


! {Sd, VWm, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, hh, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplAhSucSu(i3,gt2,i1)
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


! {Su, Ah, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSucSu(i2,i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, VZ, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSucSuVZ(i1,gt1)
coup2 = cplhhSucSu(i3,gt2,i1)
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


! {Su, hh, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSu(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSucSu(i2,i1,gt1)
coup2 = cplSucSuVZ(gt2,i1)
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


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSuVZ(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
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


! {VZ, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplSucSuVZ(gt2,i3)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplSucSdVWm(gt2,i3)
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


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2 = cplSucSdVWmVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSucSuVGVZLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSucSuVPVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
coup1 = -cplSucSuVZ(i1,gt1)
coup2 = cplSucSuVZVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = cplSdcSucVWmVZaa(i1,gt1)
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
coup1 = cplSucSuVGVZLamct3ct2ct1(i1,gt1)
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
coup1 = cplSucSuVPVZaa(i1,gt1)
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
coup1 = cplSucSuVZVZaa(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSucSu,        & 
& cplcFdChaSuL,cplcFdChaSuR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,       & 
& cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,cplcFdFdVZR,           & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,         & 
& cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplhhVZVZ,cplHpmSucSd,cplHpmcHpmVZ,               & 
& cplHpmcVWmVZ,cplSdcSdVZ,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,              & 
& cplSecSeVZ,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,     & 
& cplSdcSucVWmVZaa,cplSucSuVGVZLamct3ct2ct1,cplSucSuVPVZaa,cplSucSdVWmVZaa,              & 
& cplSucSuVZVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),             & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),             & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),           & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),         & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuVZL(3,3),& 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),cplhhVZVZ(2),   & 
& cplHpmSucSd(2,6,6),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcHpmcSu(6,2,6),& 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSecSeVZ(6,6),cplSucSuVG(6,6),& 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplcHpmVWmVZ(2),cplcVWmVWmVZ,         & 
& cplSdcSucVWmVZaa(6,6),cplSucSuVGVZLamct3ct2ct1(6,6),cplSucSuVPVZaa(6,6),               & 
& cplSucSdVWmVZaa(6,6),cplSucSuVZVZaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVZ 


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSuVZ(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
coup3 = cplSucSuVZ(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSucSuVGVZLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSucSuVPVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = cplSucSuVGVZLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = cplSucSuVPVZaa(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToFuFv(MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,          & 
& ZfFvL,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfFvL(3,3),ZfSu(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToFuFv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToFuFv(MCha,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,cplChaFucSdL,             & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,          & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,           & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvHpmL,           & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),           & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),             & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),            & 
& cplSdcSucVWm(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = 0. 


! {Fd, Fe, Hpm}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
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


! {Fd, Cha, Se}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MSe(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
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


! {Fd, Fe, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
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


! {Fd, Fe, VWm}
Do i1=1,3
  Do i2=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MVWm 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
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


! {Sd, Se, Cha}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MCha(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
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


! {Sd, Hpm, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MFe(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, Se, Fe}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {Sd, VWm, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MFe(i3) 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
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


! {bar[Cha], bar[Fd], conj[Sd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3L = cplcFdFvSdL(i2,gt3,i3)
coup3R = cplcFdFvSdR(i2,gt3,i3)
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


! {bar[Fe], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3L = cplcFdFvSdL(i2,gt3,i3)
coup3R = cplcFdFvSdR(i2,gt3,i3)
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


! {conj[Hpm], conj[Sd], bar[Fd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplFvFdcSdL(gt3,i3,i2)
coup3R = cplFvFdcSdR(gt3,i3,i2)
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


! {conj[Se], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplFvFdcSdL(gt3,i3,i2)
coup3R = cplFvFdcSdR(gt3,i3,i2)
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


! {conj[VWm], conj[Sd], bar[Fd]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = -cplSdcSucVWm(i2,gt1)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
coup3L = cplFvFdcSdL(gt3,i3,i2)
coup3R = cplFvFdcSdR(gt3,i3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToFuFv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuFv(MCha,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSu,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,cplChaFucSdL,         & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplFvFdcSdL,cplFvFdcSdR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,          & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFuHpmL,           & 
& cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvHpmL,           & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),           & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),             & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),            & 
& cplSdcSucVWm(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = 0. 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToFuFv


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuSv(MSu,MSu2,MSv,MSv2,ZfSu,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MSu2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfSu(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(6,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,3
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuSv(MCha,MFd,MFe,MHpm,MSd,MSe,            & 
& MSu,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,             & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,           & 
& cplcFeFeSvR,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSecSu,               & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSucSdVWm,cplSvcSeVWm,cplHpmSuSvcSdaa,            & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa,cplSeSucHpmcSuaa, & 
& cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),      & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),           & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),            & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplHpmSuSvcSdaa(2,6,3,6),& 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),       & 
& cplSdSvcSecSuaa(6,3,6,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(6,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Cha, Fe}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MFe(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Fd, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Sd, Hpm, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, VWm, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MSe(i3) 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = -cplSucSdVWm(gt2,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
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
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSuSvcSdaa(i2,gt2,gt3,i1)
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
coup1 = cplSdSvcHpmcSuaa(i1,gt3,i2,gt1)
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
coup1 = cplSdSvcSecSuaa(i1,gt3,i2,gt1)
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


! {Sd, Sd}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSd(i2) 
coup1 = cplSdSucSdcSuabba(i1,gt2,i2,gt1)
coup2 = cplSdSvcSd(i2,gt3,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSucSdcSuabab(i1,gt2,i2,gt1)
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
coup1 = cplSeSucHpmcSuaa(i1,gt2,i2,gt1)
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
coup1 = cplSeSucSecSuaa(i1,gt2,i2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuSv(MCha,MFd,MFe,MHpm,MSd,             & 
& MSe,MSu,MSv,MVWm,MCha2,MFd2,MFe2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdChaSuL,         & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,          & 
& cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,           & 
& cplcFeFeSvR,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSecSu,               & 
& cplSdcSucVWm,cplSeSucSd,cplSeSvcSe,cplSucSdVWm,cplSvcSeVWm,cplHpmSuSvcSdaa,            & 
& cplSdSucSdcSuabba,cplSdSucSdcSuabab,cplSdSvcHpmcSuaa,cplSdSvcSecSuaa,cplSeSucHpmcSuaa, & 
& cplSeSucSecSuaa,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),      & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),       & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),         & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),           & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),            & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplHpmSuSvcSdaa(2,6,3,6),& 
& cplSdSucSdcSuabba(6,6,6,6),cplSdSucSdcSuabab(6,6,6,6),cplSdSvcHpmcSuaa(6,3,2,6),       & 
& cplSdSvcSecSuaa(6,3,6,6),cplSeSucHpmcSuaa(6,6,2,6),cplSeSucSecSuaa(6,6,6,6)

Complex(dp), Intent(out) :: Amp(6,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuSv


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuVG(cplSucSuVG,ctcplSucSuVG,MSu,            & 
& MSu2,MVG,MVG2,ZfSu,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MSu2(6),MVG,MVG2

Complex(dp), Intent(in) :: cplSucSuVG(6,6)

Complex(dp), Intent(in) :: ctcplSucSuVG(6,6)

Complex(dp), Intent(in) :: ZfSu(6,6),ZfVG

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVG 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSucSuVG(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplSucSuVG(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplSucSuVG(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVG*cplSucSuVG(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 4._dp/3._dp*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuVG(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhSucSu,cplcFdChaSuL,          & 
& cplcFdChaSuR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,          & 
& cplcFdFdVGR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcSdVG,              & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplVGVGVG,cplSdcSucVWmVGLamct4ct2ct1,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSucSuVGVPLamct3ct2ct1,cplSucSdVGVWmLamct3ct2ct1,& 
& cplSucSuVGVZLamct3ct2ct1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiFucSuL(4,3,6),        & 
& cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFdFdVGL(3,3),          & 
& cplcFdFdVGR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),        & 
& cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),           & 
& cplGluFucSuR(3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR,         & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdcSdVG(6,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),              & 
& cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),    & 
& cplVGVGVG,cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSucSuVGVPLamct3ct2ct1(6,6),          & 
& cplSucSdVGVWmLamct3ct2ct1(6,6),cplSucSuVGVZLamct3ct2ct1(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVG 


! {Ah, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
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


! {Chi, bar[Fu], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
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


! {Fu, Glu, Glu}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MGlu 
ML3 = MGlu 
coup1L = cplGluFucSuL(i1,gt1)
coup1R = cplGluFucSuR(i1,gt1)
coup2L = cplcFuGluSuL(i1,gt2)
coup2R = cplcFuGluSuR(i1,gt2)
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


! {Glu, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
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


! {Su, VG, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MVG 
coup1 = cplSucSuVG(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
coup3 = cplVGVGVG
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
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


! {VZ, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplSucSuVZ(gt2,i3)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplSucSdVWm(gt2,i3)
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


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2 = cplSucSdVGVWmLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
coup2 = cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSucSuVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
coup1 = -cplSucSuVZ(i1,gt1)
coup2 = cplSucSuVGVZLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = cplSdcSucVWmVGLamct4ct2ct1(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 

coup1 = cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 

End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = cplSucSuVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
coup1 = cplSucSuVGVZLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVZ(gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVG(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhSucSu,cplcFdChaSuL,     & 
& cplcFdChaSuR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVGL,          & 
& cplcFdFdVGR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFdFeSuL,         & 
& cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplSdcSdVG,              & 
& cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,    & 
& cplSucSuVZ,cplVGVGVG,cplSdcSucVWmVGLamct4ct2ct1,cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1,& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1,cplSucSuVGVPLamct3ct2ct1,cplSucSdVGVWmLamct3ct2ct1,& 
& cplSucSuVGVZLamct3ct2ct1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiFucSuL(4,3,6),        & 
& cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFdFdVGL(3,3),          & 
& cplcFdFdVGR(3,3),cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),        & 
& cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),           & 
& cplGluFucSuR(3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR,         & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),              & 
& cplSdcSdVG(6,6),cplSdcHpmcSu(6,2,6),cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),              & 
& cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),    & 
& cplVGVGVG,cplSdcSucVWmVGLamct4ct2ct1(6,6),cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(6,6),& 
& cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(6,6),cplSucSuVGVPLamct3ct2ct1(6,6),          & 
& cplSucSdVGVWmLamct3ct2ct1(6,6),cplSucSuVGVZLamct3ct2ct1(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVG 


! {Su, VG, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
ML3 = MVG 
coup1 = cplSucSuVG(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
coup3 = cplVGVGVG
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSuVG(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
coup3 = cplSucSuVG(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
coup2 = cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSucSuVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = cplSucSuVGVGsumj113Lamct3ct2j1Lamct4j1ct1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(16._dp/9._dp)*AmpC 

coup1 = cplSucSuVGVGsumj113Lamct3j1ct1Lamct4ct2j1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 

End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = cplSucSuVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVG


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuVP(cplSucSuVP,cplSucSuVZ,ctcplSucSuVP,     & 
& ctcplSucSuVZ,MSu,MSu2,MVP,MVP2,ZfSu,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MSu2(6),MVP,MVP2

Complex(dp), Intent(in) :: cplSucSuVP(6,6),cplSucSuVZ(6,6)

Complex(dp), Intent(in) :: ctcplSucSuVP(6,6),ctcplSucSuVZ(6,6)

Complex(dp), Intent(in) :: ZfSu(6,6),ZfVP,ZfVZVP

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt1))*cplSucSuVP(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSu(i1,gt2)*cplSucSuVP(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVP*cplSucSuVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZVP*cplSucSuVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSuVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuVP(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhSucSu,cplcFdChaSuL,          & 
& cplcFdChaSuR,cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcFdFdVPL,cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,         & 
& cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,             & 
& cplGluFucSuR,cplcFuFuVPL,cplcFuFuVPR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,             & 
& cplHpmSucSd,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,       & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSdcSucVWmVPaa,cplSucSuVGVPLamct3ct2ct1,cplSucSuVPVPaa,    & 
& cplSucSdVPVWmaa,cplSucSuVPVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcChaChaVPL(2,2),         & 
& cplcChaChaVPR(2,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),        & 
& cplcFuChiSuR(3,4,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcChaFdcSuL(2,3,6),            & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),       & 
& cplcFdFeSuR(3,3,6),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),& 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),& 
& cplHpmSucSd(2,6,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSdcHpmcSu(6,2,6),& 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSecSeVP(6,6),cplSucSuVG(6,6),& 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,         & 
& cplSdcSucVWmVPaa(6,6),cplSucSuVGVPLamct3ct2ct1(6,6),cplSucSuVPVPaa(6,6),               & 
& cplSucSdVPVWmaa(6,6),cplSucSuVPVZaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVP 


! {Ah, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSucSu(i1,i2,gt1)
coup2 = cplAhSucSu(i1,gt2,i3)
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


! {Chi, bar[Fu], bar[Fu]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFucSuL(i1,i2,gt1)
coup1R = cplChiFucSuR(i1,i2,gt1)
coup2L = cplcFuChiSuL(i3,i1,gt2)
coup2R = cplcFuChiSuR(i3,i1,gt2)
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


! {Fd, Cha, Cha}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChaFdcSuL(i2,i1,gt1)
coup1R = cplcChaFdcSuR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Glu, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MGlu 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,gt1)
coup1R = cplGluFucSuR(i2,gt1)
coup2L = cplcFuGluSuL(i3,gt2)
coup2R = cplcFuGluSuR(i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_FFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, conj[Su], conj[Su]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSucSu(i1,i2,gt1)
coup2 = cplhhSucSu(i1,gt2,i3)
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


! {Sd, Hpm, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, VWm, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSdcSucVWm(i1,gt1)
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


! {Sd, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Hpm, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplSucSdVWm(gt2,i1)
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


! {Sd, VWm, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSdcSucVWm(i1,gt1)
coup2 = cplSucSdVWm(gt2,i1)
coup3 = cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSuVP(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
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


! {VZ, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVZ(i2,gt1)
coup2 = cplSucSuVZ(gt2,i3)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = cplSucSdVWm(gt2,i3)
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


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = -cplSdcSucVWm(i1,gt1)
coup2 = cplSucSdVPVWmaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSucSuVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSucSuVPVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VZ}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVZ 
coup1 = -cplSucSuVZ(i1,gt1)
coup2 = cplSucSuVPVZaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sd, VWm}
Do i1=1,6
ML1 = MSd(i1) 
ML2 = MVWm 
coup1 = cplSdcSucVWmVPaa(i1,gt1)
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
coup1 = cplSucSuVGVPLamct3ct2ct1(i1,gt1)
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
coup1 = cplSucSuVPVPaa(i1,gt1)
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
coup1 = cplSucSuVPVZaa(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSuVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVP(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhSucSu,cplcFdChaSuL,     & 
& cplcFdChaSuR,cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcFdFdVPL,cplcFdFdVPR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,         & 
& cplcFeFdcSuR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,             & 
& cplGluFucSuR,cplcFuFuVPL,cplcFuFuVPR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,             & 
& cplHpmSucSd,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSdcHpmcSu,cplSdcSecSu,             & 
& cplSdcSucVWm,cplSeSucSd,cplSecSeVP,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,       & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSdcSucVWmVPaa,cplSucSuVGVPLamct3ct2ct1,cplSucSuVPVPaa,    & 
& cplSucSdVPVWmaa,cplSucSuVPVZaa,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcChaChaVPL(2,2),         & 
& cplcChaChaVPR(2,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),        & 
& cplcFuChiSuR(3,4,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcChaFdcSuL(2,3,6),            & 
& cplcChaFdcSuR(2,3,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFdFeSuL(3,3,6),       & 
& cplcFdFeSuR(3,3,6),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),& 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),& 
& cplHpmSucSd(2,6,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSdcHpmcSu(6,2,6),& 
& cplSdcSecSu(6,6,6),cplSdcSucVWm(6,6),cplSeSucSd(6,6,6),cplSecSeVP(6,6),cplSucSuVG(6,6),& 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm,         & 
& cplSdcSucVWmVPaa(6,6),cplSucSuVGVPLamct3ct2ct1(6,6),cplSucSuVPVPaa(6,6),               & 
& cplSucSdVPVWmaa(6,6),cplSucSuVPVZaa(6,6)

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
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MVP 


! {VG, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVG 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVG(i2,gt1)
coup2 = cplSucSuVG(gt2,i3)
coup3 = cplSucSuVP(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSucSuVP(i2,gt1)
coup2 = cplSucSuVP(gt2,i3)
coup3 = cplSucSuVP(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = -cplSucSuVG(i1,gt1)
coup2 = cplSucSuVGVPLamct3ct2ct1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = -cplSucSuVP(i1,gt1)
coup2 = cplSucSuVPVPaa(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Su, VG}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVG 
coup1 = cplSucSuVGVPLamct3ct2ct1(i1,gt1)
coup2 = cplSucSuVG(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 

End Do


! {Su, VP}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MVP 
coup1 = cplSucSuVPVPaa(i1,gt1)
coup2 = cplSucSuVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSuVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSucSv(MSu,MSu2,MSv,MSv2,ZfSu,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSu(6),MSu2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfSu(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(6,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,3
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SuToSucSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSucSv(MCha,MFd,MFe,MHpm,MSd,               & 
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

Complex(dp), Intent(out) :: Amp(6,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Fe, Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MCha(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,i3,gt2)
coup2R = cplcFdChaSuR(i1,i3,gt2)
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


! {Fd, Fe, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFeFdcSuL(i2,i1,gt1)
coup1R = cplcFeFdcSuR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,i3,gt2)
coup2R = cplcFdFeSuR(i1,i3,gt2)
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


! {Sd, Se, Hpm}
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MHpm(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplHpmSucSd(i3,gt2,i1)
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


! {Sd, Se, Se}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSd(i3,gt2,i1)
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


! {Sd, Se, VWm}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
ML3 = MVWm 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = -cplSucSdVWm(gt2,i1)
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


! {bar[Cha], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcChaFdcSuL(i1,i2,gt1)
coup1R = cplcChaFdcSuR(i1,i2,gt1)
coup2L = cplcFdChaSuL(i3,i1,gt2)
coup2R = cplcFdChaSuR(i3,i1,gt2)
coup3L = cplcFdFdcSvL(i2,i3,gt3)
coup3R = cplcFdFdcSvR(i2,i3,gt3)
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


! {bar[Fe], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFeFdcSuL(i1,i2,gt1)
coup1R = cplcFeFdcSuR(i1,i2,gt1)
coup2L = cplcFdFeSuL(i3,i1,gt2)
coup2R = cplcFdFeSuR(i3,i1,gt2)
coup3L = cplcFdFdcSvL(i2,i3,gt3)
coup3R = cplcFdFdcSvR(i2,i3,gt3)
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


! {conj[Hpm], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcHpmcSu(i2,i1,gt1)
coup2 = cplHpmSucSd(i1,gt2,i3)
coup3 = cplSdcSdcSv(i3,i2,gt3)
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


! {conj[Se], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,i1,gt1)
coup2 = cplSeSucSd(i1,gt2,i3)
coup3 = cplSdcSdcSv(i3,i2,gt3)
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


! {conj[VWm], conj[Sd], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVWm 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSucVWm(i2,gt1)
coup2 = -cplSucSdVWm(gt2,i3)
coup3 = cplSdcSdcSv(i3,i2,gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
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
coup1 = cplSdcHpmcSu(i1,i2,gt1)
coup2 = cplHpmSucSdcSvaa(i2,gt2,i1,gt3)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Se}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSe(i2) 
coup1 = cplSdcSecSu(i1,i2,gt1)
coup2 = cplSeSucSdcSvaa(i2,gt2,i1,gt3)
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
coup1 = cplSdcHpmcSucSvaa(i1,i2,gt1,gt3)
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


! {Hpm, Se}
Do i1=1,2
  Do i2=1,6
ML1 = MHpm(i1) 
ML2 = MSe(i2) 
coup1 = cplHpmSucSecSuaa(i1,gt2,i2,gt1)
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
coup1 = cplSdSucSdcSuabba(i1,gt2,i2,gt1)
coup2 = cplSdcSdcSv(i2,i1,gt3)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology4_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

coup1 = cplSdSucSdcSuabab(i1,gt2,i2,gt1)
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
coup1 = cplSeSucSecSuaa(i1,gt2,i2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SuToSucSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSucSv(MCha,MFd,MFe,MHpm,MSd,            & 
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

Complex(dp), Intent(out) :: Amp(6,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSu(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SuToSucSv



End Module OneLoopDecay_Su_MSSMTriLnV
