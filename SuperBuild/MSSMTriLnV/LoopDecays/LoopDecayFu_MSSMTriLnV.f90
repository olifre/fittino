! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 12:00 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Fu_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_FuToFuAh(cplcFuFuAhL,cplcFuFuAhR,MAh,            & 
& MFu,MAh2,MFu2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFu(3),MAh2(2),MFu2(3)

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

Complex(dp) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MAh(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFuAhL(gt1,gt2,gt3)
coupT1R = cplcFuFuAhR(gt1,gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToFuAh


Subroutine Gamma_Real_MSSMTriLnV_FuToFuAh(MLambda,em,gs,cplcFuFuAhL,cplcFuFuAhR,      & 
& MAh,MFu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

Real(dp), Intent(in) :: MAh(2),MFu(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,2), GammarealGluon(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=2,2
CoupL = cplcFuFuAhL(i1,i2,i3)
CoupR = cplcFuFuAhR(i1,i2,i3)
Mex1 = MFu(i1)
Mex2 = MFu(i2)
Mex3 = MAh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,4._dp/9._dp,0._dp,4._dp/9._dp,0._dp,0._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToFuAh


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuAh(cplcFuFuAhL,cplcFuFuAhR,ctcplcFuFuAhL,  & 
& ctcplcFuFuAhR,MAh,MAh2,MFu,MFu2,ZfAh,ZfFUL,ZfFUR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MFu(3),MFu2(3)

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFuFuAhL(3,3,2),ctcplcFuFuAhR(3,3,2)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfFUL(3,3),ZfFUR(3,3)

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MAh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFuAhL(gt1,gt2,gt3) 
ZcoupT1R = ctcplcFuFuAhR(gt1,gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFuAhL(i1,gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFuAhR(i1,gt2,gt3)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplcFuFuAhL(gt1,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplcFuFuAhR(gt1,i1,gt3)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfAh(i1,gt3)*cplcFuFuAhL(gt1,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfAh(i1,gt3)*cplcFuFuAhR(gt1,gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuAh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,          & 
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

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MAh(gt3) 


! {Ah, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Su]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, Hpm}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = cplAhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Hpm}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = -cplAhcHpmVWm(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Se, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = cplAhSecSe(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, VWm}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
coup3 = -cplAhHpmcVWm(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, hh, Ah}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
coup3 = cplAhAhhh(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, Ah, hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
coup3 = cplAhAhhh(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VZ, hh}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
coup3 = -cplAhhhVZ(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, hh, VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
coup3 = -cplAhhhVZ(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Glu, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = cplcChaChaAhL(i3,i2,gt3)
coup3R = cplcChaChaAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeFeAhL(i3,i2,gt3)
coup3R = cplcFeFeAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Chi}
Do i1=1,6
  Do i2=1,4
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
coup3L = cplChiChiAhL(i3,i2,gt3)
coup3R = cplChiChiAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = -cplcFuFuVZR(i3,gt2)
coup2R = -cplcFuFuVZL(i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh(MAh,MCha,MChi,MFd,MFe,             & 
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

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MAh(gt3) 


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuAh


Subroutine Amplitude_Tree_MSSMTriLnV_FuToChiSu(cplcFuChiSuL,cplcFuChiSuR,             & 
& MChi,MFu,MSu,MChi2,MFu2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFu(3),MSu(6),MChi2(4),MFu2(3),MSu2(6)

Complex(dp), Intent(in) :: cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6)

Complex(dp) :: Amp(2,3,4,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MSu(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuChiSuL(gt1,gt2,gt3)
coupT1R = cplcFuChiSuR(gt1,gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToChiSu


Subroutine Gamma_Real_MSSMTriLnV_FuToChiSu(MLambda,em,gs,cplcFuChiSuL,cplcFuChiSuR,   & 
& MChi,MFu,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6)

Real(dp), Intent(in) :: MChi(4),MFu(3),MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,4,6), GammarealGluon(3,4,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
CoupL = cplcFuChiSuL(i1,i2,i3)
CoupR = cplcFuChiSuR(i1,i2,i3)
Mex1 = MFu(i1)
Mex2 = MChi(i2)
Mex3 = MSu(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,0._dp,4._dp/9._dp,0._dp,0._dp,4._dp/9._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToChiSu


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToChiSu(cplcFuChiSuL,cplcFuChiSuR,             & 
& ctcplcFuChiSuL,ctcplcFuChiSuR,MChi,MChi2,MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,ZfL0,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MFu(3),MFu2(3),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6)

Complex(dp), Intent(in) :: ctcplcFuChiSuL(3,4,6),ctcplcFuChiSuR(3,4,6)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfL0(4,4),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(2,3,4,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MSu(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuChiSuL(gt1,gt2,gt3) 
ZcoupT1R = ctcplcFuChiSuR(gt1,gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFuChiSuL(i1,gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuChiSuR(i1,gt2,gt3)
End Do


! External Field 2 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt2)*cplcFuChiSuL(gt1,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt2))*cplcFuChiSuR(gt1,i1,gt3)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfSu(i1,gt3)*cplcFuChiSuL(gt1,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfSu(i1,gt3)*cplcFuChiSuR(gt1,gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToChiSu


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToChiSu(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,   & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,    & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,              & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),        & 
& cplAhSucSu(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFuFuhhL(3,3,2),           & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),& 
& cplHpmSucSd(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),      & 
& cplcFecFuSdR(3,3,6),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),& 
& cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,3,4,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MSu(gt3) 


! {Ah, bar[Fu], Chi}
Do i1=1,2
  Do i2=1,3
    Do i3=1,4
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplChiChiAhL(gt2,i3,i1)
coup2R = cplChiChiAhR(gt2,i3,i1)
coup3L = cplcFuChiSuL(i2,i3,gt3)
coup3R = cplcFuChiSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], Ah}
Do i1=1,4
  Do i2=1,6
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiChiAhL(gt2,i1,i3)
coup2R = cplChiChiAhR(gt2,i1,i3)
coup3 = cplAhSucSu(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], hh}
Do i1=1,4
  Do i2=1,6
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiChihhL(gt2,i1,i3)
coup2R = cplChiChihhR(gt2,i1,i3)
coup3 = cplhhSucSu(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], VZ}
Do i1=1,4
  Do i2=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MVZ 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiChiVZL(gt2,i1)
coup2R = cplChiChiVZR(gt2,i1)
coup3 = -cplSucSuVZ(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, Hpm, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
coup3 = cplHpmSucSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
coup3 = cplSeSucSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MSd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
coup3 = -cplSucSdVWm(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, Ah, Su}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = cplAhSucSu(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, Su}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = cplhhSucSu(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VG, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = -cplSucSuVG(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = -cplSucSuVP(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VZ, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = -cplSucSuVZ(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {hh, bar[Fu], Chi}
Do i1=1,2
  Do i2=1,3
    Do i3=1,4
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplChiChihhL(gt2,i3,i1)
coup2R = cplChiChihhR(gt2,i3,i1)
coup3L = cplcFuChiSuL(i2,i3,gt3)
coup3R = cplcFuChiSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MFd(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
coup3L = cplcFdChaSuL(i3,i2,gt3)
coup3R = cplcFdChaSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFd(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
coup3L = cplcFdFeSuL(i3,i2,gt3)
coup3R = cplcFdFeSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Fu}
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplChiFucSuL(gt2,i3,i1)
coup2R = cplChiFucSuR(gt2,i3,i1)
coup3L = cplcFuChiSuL(i3,i2,gt3)
coup3R = cplcFuChiSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Glu, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MGlu 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(gt1,i1)
coup1R = cplcFuGluSuR(gt1,i1)
coup2L = cplChiFucSuL(gt2,i3,i1)
coup2R = cplChiFucSuR(gt2,i3,i1)
coup3L = cplcFuGluSuL(i3,gt3)
coup3R = cplcFuGluSuR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VZ, bar[Fu], Chi}
  Do i2=1,3
    Do i3=1,4
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MChi(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = cplChiChiVZL(gt2,i3)
coup2R = cplChiChiVZR(gt2,i3)
coup3L = cplcFuChiSuL(i2,i3,gt3)
coup3R = cplcFuChiSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], conj[Hpm]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MHpm(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChiChacHpmL(gt2,i1,i3)
coup2R = cplChiChacHpmR(gt2,i1,i3)
coup3 = cplHpmSucSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], conj[Sd], conj[VWm]}
Do i1=1,2
  Do i2=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MVWm 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChiChacVWmL(gt2,i1)
coup2R = cplChiChacVWmR(gt2,i1)
coup3 = -cplSucSdVWm(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSe(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplChiFecSeL(gt2,i1,i3)
coup2R = cplChiFecSeR(gt2,i1,i3)
coup3 = cplSeSucSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Cha]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcChaChiHpmL(i3,gt2,i1)
coup2R = cplcChaChiHpmR(i3,gt2,i1)
coup3L = cplcFdChaSuL(i2,i3,gt3)
coup3R = cplcFdChaSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fe]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFeChiSeL(i3,gt2,i1)
coup2R = cplcFeChiSeR(i3,gt2,i1)
coup3L = cplcFdFeSuL(i2,i3,gt3)
coup3R = cplcFdFeSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Cha]}
  Do i2=1,3
    Do i3=1,2
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MCha(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = -cplcChaChiVWmR(i3,gt2)
coup2R = -cplcChaChiVWmL(i3,gt2)
coup3L = cplcFdChaSuL(i2,i3,gt3)
coup3R = cplcFdChaSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToChiSu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,   & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhSucSu,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplcFdChaSuL,cplcFdChaSuR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,     & 
& cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcHpmL,    & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFdFeSuL,       & 
& cplcFdFeSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,               & 
& cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhSucSu,              & 
& cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,          & 
& cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),        & 
& cplAhSucSu(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFuFuhhL(3,3,2),           & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),& 
& cplHpmSucSd(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),      & 
& cplcFecFuSdR(3,3,6),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),& 
& cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,3,4,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,4
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MChi(gt2) 
Mex3 = MSu(gt3) 


! {Fu, VG, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = -cplSucSuVG(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = -cplSucSuVP(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToChiSu


Subroutine Amplitude_Tree_MSSMTriLnV_FuToFdcHpm(cplcFuFdcHpmL,cplcFuFdcHpmR,          & 
& MFd,MFu,MHpm,MFd2,MFu2,MHpm2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MHpm(2),MFd2(3),MFu2(3),MHpm2(2)

Complex(dp), Intent(in) :: cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2)

Complex(dp) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MHpm(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFdcHpmL(gt1,gt2,gt3)
coupT1R = cplcFuFdcHpmR(gt1,gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToFdcHpm


Subroutine Gamma_Real_MSSMTriLnV_FuToFdcHpm(MLambda,em,gs,cplcFuFdcHpmL,              & 
& cplcFuFdcHpmR,MFd,MFu,MHpm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2)

Real(dp), Intent(in) :: MFd(3),MFu(3),MHpm(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,2), GammarealGluon(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=2,2
CoupL = cplcFuFdcHpmL(i1,i2,i3)
CoupR = cplcFuFdcHpmR(i1,i2,i3)
Mex1 = MFu(i1)
Mex2 = MFd(i2)
Mex3 = MHpm(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,-2._dp/9._dp,2._dp/3._dp,1._dp/9._dp,-1._dp/3._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToFdcHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFdcHpm(cplcFuFdcHpmL,cplcFuFdcHpmR,          & 
& ctcplcFuFdcHpmL,ctcplcFuFdcHpmR,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,ZfFDL,ZfFDR,              & 
& ZfFUL,ZfFUR,ZfHpm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MFu(3),MFu2(3),MHpm(2),MHpm2(2)

Complex(dp), Intent(in) :: cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFuFdcHpmL(3,3,2),ctcplcFuFdcHpmR(3,3,2)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfHpm(2,2)

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MHpm(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFdcHpmL(gt1,gt2,gt3) 
ZcoupT1R = ctcplcFuFdcHpmR(gt1,gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFdcHpmL(i1,gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFdcHpmR(i1,gt2,gt3)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt2)*cplcFuFdcHpmL(gt1,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt2))*cplcFuFdcHpmR(gt1,i1,gt3)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfHpm(i1,gt3))*cplcFuFdcHpmL(gt1,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfHpm(i1,gt3))*cplcFuFdcHpmR(gt1,gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFdcHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFdcHpm(MAh,MCha,MChi,MFd,MFe,              & 
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

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MHpm(gt3) 


! {Ah, bar[Fu], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFdFdAhL(i3,gt2,i1)
coup2R = cplcFdFdAhR(i3,gt2,i1)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Sd]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFdcSdL(i1,gt2,i3)
coup2R = cplChiFdcSdR(i1,gt2,i3)
coup3 = cplSdcHpmcSu(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, Ah}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdAhL(i1,gt2,i3)
coup2R = cplcFdFdAhR(i1,gt2,i3)
coup3 = cplAhHpmcHpm(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Ah}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MAh(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFdAhL(i1,gt2,i3)
coup2R = cplcFdFdAhR(i1,gt2,i3)
coup3 = cplAhcHpmVWm(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Hpm, hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
coup3 = cplhhHpmcHpm(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, hh}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
coup3 = cplhhcHpmVWm(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Se, Sv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFdSvL(i1,gt2,i3)
coup2R = cplcFdFdSvR(i1,gt2,i3)
coup3 = cplSecHpmcSv(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, VP}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplHpmcHpmVP(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VP}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplcHpmVPVWm(gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Fd, Hpm, VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = -cplcFdFdVZR(i1,gt2)
coup2R = -cplcFdFdVZL(i1,gt2)
coup3 = cplHpmcHpmVZ(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VZ}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = -cplcFdFdVZR(i1,gt2)
coup2R = -cplcFdFdVZL(i1,gt2)
coup3 = cplcHpmVWmVZ(gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Fu, Ah, conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplAhHpmcHpm(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplhhHpmcHpm(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VP, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmcHpmVP(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VZ, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmcHpmVZ(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, Ah, conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MVWm 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
coup3 = cplAhcHpmVWm(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, hh, conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
coup3 = cplhhcHpmVWm(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, VP, conj[VWm]}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
coup3 = cplcHpmVPVWm(gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Fu, VZ, conj[VWm]}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
coup3 = cplcHpmVWmVZ(gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Glu, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFdcSdL(gt2,i3)
coup2R = cplGluFdcSdR(gt2,i3)
coup3 = cplSdcHpmcSu(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFdFdhhL(i3,gt2,i1)
coup2R = cplcFdFdhhR(i3,gt2,i1)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
coup3L = cplChiChacHpmL(i3,i2,gt3)
coup3R = cplChiChacHpmR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = cplFvFecHpmL(i3,i2,gt3)
coup3R = cplFvFecHpmR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, bar[Cha]}
Do i1=1,6
  Do i2=1,4
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplcChaFdcSuL(i3,gt2,i1)
coup2R = cplcChaFdcSuR(i3,gt2,i1)
coup3L = cplChiChacHpmL(i2,i3,gt3)
coup3R = cplChiChacHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFdFdVPR(i3,gt2)
coup2R = -cplcFdFdVPL(i3,gt2)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = -cplcFdFdVZR(i3,gt2)
coup2R = -cplcFdFdVZL(i3,gt2)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFdcHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm(MAh,MCha,MChi,MFd,               & 
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

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MHpm(gt3) 


! {Fd, Hpm, VP}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplHpmcHpmVP(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VP}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplcHpmVPVWm(gt3)
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Fu, VP, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmcHpmVP(i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VP, conj[VWm]}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
coup3 = cplcHpmVPVWm(gt3)
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VG, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFdFdVPR(i3,gt2)
coup2R = -cplcFdFdVPL(i3,gt2)
coup3L = cplcFuFdcHpmL(i2,i3,gt3)
coup3R = cplcFuFdcHpmR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcHpm


Subroutine Amplitude_Tree_MSSMTriLnV_FuToFdcSe(cplcFuFdcSeL,cplcFuFdcSeR,             & 
& MFd,MFu,MSe,MFd2,MFu2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MSe(6),MFd2(3),MFu2(3),MSe2(6)

Complex(dp), Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Complex(dp) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFdcSeL(gt1,gt2,gt3)
coupT1R = cplcFuFdcSeR(gt1,gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToFdcSe


Subroutine Gamma_Real_MSSMTriLnV_FuToFdcSe(MLambda,em,gs,cplcFuFdcSeL,cplcFuFdcSeR,   & 
& MFd,MFu,MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Real(dp), Intent(in) :: MFd(3),MFu(3),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,6), GammarealGluon(3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
CoupL = cplcFuFdcSeL(i1,i2,i3)
CoupR = cplcFuFdcSeR(i1,i2,i3)
Mex1 = MFu(i1)
Mex2 = MFd(i2)
Mex3 = MSe(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,-2._dp/9._dp,2._dp/3._dp,1._dp/9._dp,-1._dp/3._dp,1._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToFdcSe


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFdcSe(cplcFuFdcSeL,cplcFuFdcSeR,             & 
& ctcplcFuFdcSeL,ctcplcFuFdcSeR,MFd,MFd2,MFu,MFu2,MSe,MSe2,ZfFDL,ZfFDR,ZfFUL,            & 
& ZfFUR,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MFu(3),MFu2(3),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Complex(dp), Intent(in) :: ctcplcFuFdcSeL(3,3,6),ctcplcFuFdcSeR(3,3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfSe(6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFdcSeL(gt1,gt2,gt3) 
ZcoupT1R = ctcplcFuFdcSeR(gt1,gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFdcSeL(i1,gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFdcSeR(i1,gt2,gt3)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt2)*cplcFuFdcSeL(gt1,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt2))*cplcFuFdcSeR(gt1,i1,gt3)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSe(i1,gt3))*cplcFuFdcSeL(gt1,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSe(i1,gt3))*cplcFuFdcSeR(gt1,gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFdcSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFdcSe(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,             & 
& cplhhSecSe,cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),            & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),             & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),& 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),& 
& cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MSe(gt3) 


! {Ah, bar[Fu], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFdFdAhL(i3,gt2,i1)
coup2R = cplcFdFdAhR(i3,gt2,i1)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Sd]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFdcSdL(i1,gt2,i3)
coup2R = cplChiFdcSdR(i1,gt2,i3)
coup3 = cplSdcSecSu(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Ah}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFdAhL(i1,gt2,i3)
coup2R = cplcFdFdAhR(i1,gt2,i3)
coup3 = cplAhSecSe(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
coup3 = cplhhSecSe(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Sv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFdSvL(i1,gt2,i3)
coup2R = cplcFdFdSvR(i1,gt2,i3)
coup3 = cplSecSecSv(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplSecSeVP(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, Se, VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = -cplcFdFdVZR(i1,gt2)
coup2R = -cplcFdFdVZL(i1,gt2)
coup3 = cplSecSeVZ(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, Hpm, conj[Sv]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MSv(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdcSvL(i1,gt2,i3)
coup2R = cplcFdFdcSvR(i1,gt2,i3)
coup3 = cplHpmSvcSe(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFdcSvL(i1,gt2,i3)
coup2R = cplcFdFdcSvR(i1,gt2,i3)
coup3 = cplSeSvcSe(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, conj[Sv]}
Do i1=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MSv(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFdcSvL(i1,gt2,i3)
coup2R = cplcFdFdcSvR(i1,gt2,i3)
coup3 = cplSvcSeVWm(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, Ah, conj[Se]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
coup3 = cplAhSecSe(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, conj[Se]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
coup3 = cplhhSecSe(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VP, conj[Se]}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
coup3 = cplSecSeVP(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VZ, conj[Se]}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
coup3 = cplSecSeVZ(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Glu, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFdcSdL(gt2,i3)
coup2R = cplGluFdcSdR(gt2,i3)
coup3 = cplSdcSecSu(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFdFdhhL(i3,gt2,i1)
coup2R = cplcFdFdhhR(i3,gt2,i1)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Chi}
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MChi(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
coup3L = cplChiFecSeL(i3,i2,gt3)
coup3R = cplChiFecSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Fv}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = 0. 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = cplFvChacSeL(i3,i2,gt3)
coup3R = cplFvChacSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = cplFvFecSeL(i3,i2,gt3)
coup3R = cplFvFecSeR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, bar[Fe]}
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplcFeFdcSuL(i3,gt2,i1)
coup2R = cplcFeFdcSuR(i3,gt2,i1)
coup3L = cplChiFecSeL(i2,i3,gt3)
coup3R = cplChiFecSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFdFdVPR(i3,gt2)
coup2R = -cplcFdFdVPL(i3,gt2)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = -cplcFdFdVZR(i3,gt2)
coup2R = -cplcFdFdVZL(i3,gt2)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFdcSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,              & 
& cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,             & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,               & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,           & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,               & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,             & 
& cplhhSecSe,cplHpmSvcSe,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,          & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),           & 
& cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),            & 
& cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),& 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),             & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),           & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),& 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),& 
& cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MSe(gt3) 


! {Fd, Se, VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MVP 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplSecSeVP(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, VP, conj[Se]}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
coup3 = cplSecSeVP(i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VG, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFdFdVPR(i3,gt2)
coup2R = -cplcFdFdVPL(i3,gt2)
coup3L = cplcFuFdcSeL(i2,i3,gt3)
coup3R = cplcFuFdcSeR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcSe


Subroutine Amplitude_Tree_MSSMTriLnV_FuToFdcVWm(cplcFuFdcVWmL,cplcFuFdcVWmR,          & 
& MFd,MFu,MVWm,MFd2,MFu2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MVWm,MFd2(3),MFu2(3),MVWm2

Complex(dp), Intent(in) :: cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3)

Complex(dp) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1L = cplcFuFdcVWmL(gt1,gt2)
coupT1R = cplcFuFdcVWmR(gt1,gt2)
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,coupT1R,coupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = -AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToFdcVWm


Subroutine Gamma_Real_MSSMTriLnV_FuToFdcVWm(MLambda,em,gs,cplcFuFdcVWmL,              & 
& cplcFuFdcVWmR,MFd,MFu,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3)

Real(dp), Intent(in) :: MFd(3),MFu(3),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3), GammarealGluon(3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
CoupL = cplcFuFdcVWmL(i1,i2)
CoupR = cplcFuFdcVWmR(i1,i2)
Mex1 = MFu(i1)
Mex2 = MFd(i2)
Mex3 = MVWm
If (Mex1.gt.(Mex2+Mex3)) Then 
  Call hardphotonFFW(Mex1,Mex2,Mex3,MLambda,2._dp/3._dp,-1._dp/3._dp,CoupL,CoupR,(0,1)*em,GammaRealPhoton(i1,i2),kont)
  Call hardgluonFFZW(Mex1,Mex2,Mex3,MLambda,4._dp/3._dp,gs,CoupL,CoupR,Gammarealgluon(i1,i2),kont)
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToFdcVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFdcVWm(cplcFuFdcVWmL,cplcFuFdcVWmR,          & 
& ctcplcFuFdcVWmL,ctcplcFuFdcVWmR,MFd,MFd2,MFu,MFu2,MVWm,MVWm2,ZfFDL,ZfFDR,              & 
& ZfFUL,ZfFUR,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MFu(3),MFu2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3)

Complex(dp), Intent(in) :: ctcplcFuFdcVWmL(3,3),ctcplcFuFdcVWmR(3,3)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfVWm

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFdcVWmL(gt1,gt2) 
ZcoupT1R = ctcplcFuFdcVWmR(gt1,gt2)
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFdcVWmL(i1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFdcVWmR(i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt2)*cplcFuFdcVWmL(gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt2))*cplcFuFdcVWmR(gt1,i1)
End Do


! External Field 3 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVWm*cplcFuFdcVWmL(gt1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVWm*cplcFuFdcVWmR(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = -1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFdcVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFdcVWm(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFdFdAhL,       & 
& cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,cplChiChacVWmR,        & 
& cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,           & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,             & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,               & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,cplcFuFuhhR,         & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmcVWmVP,cplHpmcVWmVZ,         & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,cplSecSvcVWm,       & 
& cplcVWmVPVWm,cplcVWmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhHpmcVWm(2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),   & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhHpmcVWm(2,2),cplhhcVWmVWm(2),& 
& cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcSucVWm(6,6),cplSecSvcVWm(6,3),           & 
& cplcVWmVPVWm,cplcVWmVWmVZ

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MVWm 


! {Ah, bar[Fu], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFdFdAhL(i3,gt2,i1)
coup2R = cplcFdFdAhR(i3,gt2,i1)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Sd]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFdcSdL(i1,gt2,i3)
coup2R = cplChiFdcSdR(i1,gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, Ah}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdAhL(i1,gt2,i3)
coup2R = cplcFdFdAhR(i1,gt2,i3)
coup3 = cplAhHpmcVWm(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
coup3 = cplhhHpmcVWm(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, hh}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
coup3 = cplhhcVWmVWm(i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Se, Sv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFdSvL(i1,gt2,i3)
coup2R = cplcFdFdSvR(i1,gt2,i3)
coup3 = -cplSecSvcVWm(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, VP}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdVPL(i1,gt2)
coup2R = cplcFdFdVPR(i1,gt2)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VP}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFdVPL(i1,gt2)
coup2R = cplcFdFdVPR(i1,gt2)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Fd, Hpm, VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdVZL(i1,gt2)
coup2R = cplcFdFdVZR(i1,gt2)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VZ}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFdVZL(i1,gt2)
coup2R = cplcFdFdVZR(i1,gt2)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Fu, Ah, conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = -cplAhHpmcVWm(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = -cplhhHpmcVWm(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VP, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1L = cplcFuFuVPL(gt1,i1)
coup1R = cplcFuFuVPR(gt1,i1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmcVWmVP(i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VZ, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1L = cplcFuFuVZL(gt1,i1)
coup1R = cplcFuFuVZR(gt1,i1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmcVWmVZ(i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, hh, conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFdcVWmL(i1,gt2)
coup2R = cplcFuFdcVWmR(i1,gt2)
coup3 = cplhhcVWmVWm(i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, VP, conj[VWm]}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1L = cplcFuFuVPL(gt1,i1)
coup1R = cplcFuFuVPR(gt1,i1)
coup2L = cplcFuFdcVWmL(i1,gt2)
coup2R = cplcFuFdcVWmR(i1,gt2)
coup3 = cplcVWmVPVWm
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Fu, VZ, conj[VWm]}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1L = cplcFuFuVZL(gt1,i1)
coup1R = cplcFuFuVZR(gt1,i1)
coup2L = cplcFuFdcVWmL(i1,gt2)
coup2R = cplcFuFdcVWmR(i1,gt2)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Glu, conj[Su], conj[Sd]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFdcSdL(gt2,i3)
coup2R = cplGluFdcSdR(gt2,i3)
coup3 = cplSdcSucVWm(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFdFdhhL(i3,gt2,i1)
coup2R = cplcFdFdhhR(i3,gt2,i1)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
coup3L = -cplChiChacVWmR(i3,i2)
coup3R = -cplChiChacVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = -cplFvFecVWmR(i3,i2)
coup3R = -cplFvFecVWmL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, bar[Cha]}
Do i1=1,6
  Do i2=1,4
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplcChaFdcSuL(i3,gt2,i1)
coup2R = cplcChaFdcSuR(i3,gt2,i1)
coup3L = cplChiChacVWmL(i2,i3)
coup3R = cplChiChacVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFdFdVGL(i3,gt2)
coup2R = cplcFdFdVGR(i3,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFdFdVPL(i3,gt2)
coup2R = cplcFdFdVPR(i3,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuVZL(gt1,i2)
coup1R = cplcFuFuVZR(gt1,i2)
coup2L = cplcFdFdVZL(i3,gt2)
coup2R = cplcFdFdVZR(i3,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFdcVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhHpmcVWm,cplChiChacVWmL,           & 
& cplChiChacVWmR,cplChiFdcSdL,cplChiFdcSdR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,        & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,               & 
& cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,      & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecVWmL,cplFvFecVWmR,cplcFuFuhhL,        & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhHpmcVWm,cplhhcVWmVWm,cplHpmcVWmVP,          & 
& cplHpmcVWmVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSucVWm,       & 
& cplSecSvcVWm,cplcVWmVPVWm,cplcVWmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhHpmcVWm(2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChiFdcSdL(4,3,6),         & 
& cplChiFdcSdR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplFvFdcSdL(3,3,6),        & 
& cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),             & 
& cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFdFdVGL(3,3),             & 
& cplcFdFdVGR(3,3),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),  & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),   & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhHpmcVWm(2,2),cplhhcVWmVWm(2),& 
& cplHpmcVWmVP(2),cplHpmcVWmVZ(2),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),             & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSdcSucVWm(6,6),cplSecSvcVWm(6,3),           & 
& cplcVWmVPVWm,cplcVWmVWmVZ

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFd(gt2) 
Mex3 = MVWm 


! {Fd, Hpm, VP}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVP 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFdVPL(i1,gt2)
coup2R = cplcFdFdVPR(i1,gt2)
coup3 = cplHpmcVWmVP(i2)
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VP}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVP 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFdVPL(i1,gt2)
coup2R = cplcFdFdVPR(i1,gt2)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Fu, VP, conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1L = cplcFuFuVPL(gt1,i1)
coup1R = cplcFuFuVPR(gt1,i1)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmcVWmVP(i3)
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VP, conj[VWm]}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1L = cplcFuFuVPL(gt1,i1)
coup1R = cplcFuFuVPR(gt1,i1)
coup2L = cplcFuFdcVWmL(i1,gt2)
coup2R = cplcFuFdcVWmR(i1,gt2)
coup3 = cplcVWmVPVWm
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VG, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFdFdVGL(i3,gt2)
coup2R = cplcFdFdVGR(i3,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFdFdVPL(i3,gt2)
coup2R = cplcFdFdVPR(i3,gt2)
coup3L = cplcFuFdcVWmL(i2,i3)
coup3R = cplcFuFdcVWmR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFdcVWm


Subroutine Amplitude_Tree_MSSMTriLnV_FuToFuhh(cplcFuFuhhL,cplcFuFuhhR,MFu,            & 
& Mhh,MFu2,Mhh2,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),Mhh(2),MFu2(3),Mhh2(2)

Complex(dp), Intent(in) :: cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2)

Complex(dp) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = Mhh(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFuhhL(gt1,gt2,gt3)
coupT1R = cplcFuFuhhR(gt1,gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToFuhh


Subroutine Gamma_Real_MSSMTriLnV_FuToFuhh(MLambda,em,gs,cplcFuFuhhL,cplcFuFuhhR,      & 
& MFu,Mhh,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2)

Real(dp), Intent(in) :: MFu(3),Mhh(2)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,2), GammarealGluon(3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
CoupL = cplcFuFuhhL(i1,i2,i3)
CoupR = cplcFuFuhhR(i1,i2,i3)
Mex1 = MFu(i1)
Mex2 = MFu(i2)
Mex3 = Mhh(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,4._dp/9._dp,0._dp,4._dp/9._dp,0._dp,0._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToFuhh


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuhh(cplcFuFuhhL,cplcFuFuhhR,ctcplcFuFuhhL,  & 
& ctcplcFuFuhhR,MFu,MFu2,Mhh,Mhh2,ZfFUL,ZfFUR,Zfhh,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),Mhh(2),Mhh2(2)

Complex(dp), Intent(in) :: cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2)

Complex(dp), Intent(in) :: ctcplcFuFuhhL(3,3,2),ctcplcFuFuhhR(3,3,2)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),Zfhh(2,2)

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = Mhh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFuhhL(gt1,gt2,gt3) 
ZcoupT1R = ctcplcFuFuhhR(gt1,gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFuhhL(i1,gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFuhhR(i1,gt2,gt3)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplcFuFuhhL(gt1,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplcFuFuhhR(gt1,i1,gt3)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*Zfhh(i1,gt3)*cplcFuFuhhL(gt1,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Zfhh(i1,gt3)*cplcFuFuhhR(gt1,gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuhh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),cplChaFucSdL(2,3,6),& 
& cplChaFucSdR(2,3,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),     & 
& cplChiChihhR(4,4,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),        & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFeFehhL(3,3,2),           & 
& cplcFeFehhR(3,3,2),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),& 
& cplcFuGluSuR(3,6),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),& 
& cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = Mhh(gt3) 


! {Ah, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Su]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, Hpm}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = cplhhHpmcHpm(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Hpm}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = -cplhhcHpmVWm(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Se, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = cplhhSecSe(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, VWm}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
coup3 = -cplhhHpmcVWm(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VWm}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Fu, Ah, Ah}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
coup3 = cplAhAhhh(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VZ, Ah}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MAh(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
coup3 = cplAhhhVZ(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, hh, hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
coup3 = cplhhhhhh(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, Ah, VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MVZ 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
coup3 = cplAhhhVZ(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, VZ, VZ}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MVZ 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Glu, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = cplcChaChahhL(i3,i2,gt3)
coup3R = cplcChaChahhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeFehhL(i3,i2,gt3)
coup3R = cplcFeFehhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Chi}
Do i1=1,6
  Do i2=1,4
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
coup3L = cplChiChihhL(i3,i2,gt3)
coup3R = cplChiChihhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = -cplcFuFuVZR(i3,gt2)
coup2R = -cplcFuFuVZL(i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcFuFuAhL,       & 
& cplcFuFuAhR,cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChahhL,cplcChaChahhR,           & 
& cplChiChihhL,cplChiChihhR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFehhL,cplcFeFehhR,           & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhcHpmVWm,     & 
& cplhhcVWmVWm,cplhhVZVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),cplChaFucSdL(2,3,6),& 
& cplChaFucSdR(2,3,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),     & 
& cplChiChihhR(4,4,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcHpmL(3,3,2),        & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFeFehhL(3,3,2),           & 
& cplcFeFehhR(3,3,2),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),& 
& cplcFuGluSuR(3,6),cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),              & 
& cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),& 
& cplcFecFuSdR(3,3,6)

Complex(dp), Intent(out) :: Amp(2,3,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,2
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = Mhh(gt3) 


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = -cplcFuFuVPR(i3,gt2)
coup2R = -cplcFuFuVPL(i3,gt2)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuhh


Subroutine Amplitude_Tree_MSSMTriLnV_FuToFuVZ(cplcFuFuVZL,cplcFuFuVZR,MFu,            & 
& MVZ,MFu2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MVZ,MFu2(3),MVZ2

Complex(dp), Intent(in) :: cplcFuFuVZL(3,3),cplcFuFuVZR(3,3)

Complex(dp) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1L = cplcFuFuVZL(gt1,gt2)
coupT1R = cplcFuFuVZR(gt1,gt2)
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,coupT1R,coupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = -AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToFuVZ


Subroutine Gamma_Real_MSSMTriLnV_FuToFuVZ(MLambda,em,gs,cplcFuFuVZL,cplcFuFuVZR,      & 
& MFu,MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFuVZL(3,3),cplcFuFuVZR(3,3)

Real(dp), Intent(in) :: MFu(3),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3), GammarealGluon(3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
CoupL = cplcFuFuVZL(i1,i2)
CoupR = cplcFuFuVZR(i1,i2)
Mex1 = MFu(i1)
Mex2 = MFu(i2)
Mex3 = MVZ
If (Mex1.gt.(Mex2+Mex3)) Then 
  Call hardphotonFFZ(Mex1,Mex2,Mex3,MLambda,2._dp/3._dp,2._dp/3._dp,CoupL,CoupR,(0,1)*em,GammaRealPhoton(i1,i2),kont)
  Call hardgluonFFZW(Mex1,Mex2,Mex3,MLambda,4._dp/3._dp,gs,CoupL,CoupR,Gammarealgluon(i1,i2),kont)
Else 
  GammarealGluon(i1,i2) = 0._dp 
  GammarealPhoton(i1,i2) = 0._dp 

End if 
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToFuVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuVZ(cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,    & 
& cplcFuFuVZR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,MFu,               & 
& MFu2,MVP,MVP2,MVZ,MVZ2,ZfFUL,ZfFUR,ZfVPVZ,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3)

Complex(dp), Intent(in) :: ctcplcFuFuVPL(3,3),ctcplcFuFuVPR(3,3),ctcplcFuFuVZL(3,3),ctcplcFuFuVZR(3,3)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfVPVZ,ZfVZ

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFuVZL(gt1,gt2) 
ZcoupT1R = ctcplcFuFuVZR(gt1,gt2)
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFuVZL(i1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFuVZR(i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplcFuFuVZL(gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplcFuFuVZR(gt1,i1)
End Do


! External Field 3 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVPVZ*cplcFuFuVPL(gt1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVPVZ*cplcFuFuVPR(gt1,gt2)
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVZ*cplcFuFuVZL(gt1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVZ*cplcFuFuVZR(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = -1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,          & 
& cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,          & 
& cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,            & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,              & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),cplChaFucSdL(2,3,6),             & 
& cplChaFucSdR(2,3,6),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),           & 
& cplChiChiVZR(4,4),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),         & 
& cplcFuChiSuR(3,4,6),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),            & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFeFeVZL(3,3),             & 
& cplcFeFeVZR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),               & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),& 
& cplcFuGluSuR(3,6),cplhhVZVZ(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),      & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSecSeVZ(6,6),cplSucSuVZ(6,6),cplcHpmVWmVZ(2),cplcVWmVWmVZ

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVZ 


! {Ah, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Su]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3 = cplSucSuVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, Hpm}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = -cplHpmcHpmVZ(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Hpm}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = cplcHpmVWmVZ(i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Se, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = -cplSecSeVZ(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, VWm}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuVWmL(i1,gt2)
coup2R = cplcFdFuVWmR(i1,gt2)
coup3 = cplHpmcVWmVZ(i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VWm}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFuVWmL(i1,gt2)
coup2R = cplcFdFuVWmR(i1,gt2)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Fu, hh, Ah}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
coup3 = cplAhhhVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, Ah, hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
coup3 = -cplAhhhVZ(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VZ, hh}
Do i1=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1L = cplcFuFuVZL(gt1,i1)
coup1R = cplcFuFuVZR(gt1,i1)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
coup3 = cplhhVZVZ(i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, hh, VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuFuVZL(i1,gt2)
coup2R = cplcFuFuVZR(i1,gt2)
coup3 = cplhhVZVZ(i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Glu, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplSucSuVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = -cplcChaChaVZR(i3,i2)
coup3R = -cplcChaChaVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = -cplcFeFeVZR(i3,i2)
coup3R = -cplcFeFeVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Chi}
Do i1=1,6
  Do i2=1,4
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
coup3L = -cplChiChiVZR(i3,i2)
coup3R = -cplChiChiVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFuFuVGL(i3,gt2)
coup2R = cplcFuFuVGR(i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFuFuVPL(i3,gt2)
coup2R = cplcFuFuVPR(i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVZL(gt1,i2)
coup1R = cplcFuFuVZR(gt1,i2)
coup2L = cplcFuFuVZL(i3,gt2)
coup2R = cplcFuFuVZR(i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplSdcSdVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcVWmL(gt1,i2)
coup1R = cplcFuFdcVWmR(gt1,i2)
coup2L = cplcFdFuVWmL(i3,gt2)
coup2R = cplcFdFuVWmR(i3,gt2)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhhhVZ,cplChaFucSdL,cplChaFucSdR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,          & 
& cplChiChiVZR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVZL,          & 
& cplcFdFdVZR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,       & 
& cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplcFeFeVZL,cplcFeFeVZR,cplGluFucSuL,            & 
& cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,            & 
& cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,              & 
& cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplcFuGluSuL,cplcFuGluSuR,cplhhVZVZ,              & 
& cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,         & 
& cplcFecFuSdR,cplSecSeVZ,cplSucSuVZ,cplcHpmVWmVZ,cplcVWmVWmVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhhhVZ(2,2),cplChaFucSdL(2,3,6),             & 
& cplChaFucSdR(2,3,6),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),           & 
& cplChiChiVZR(4,4),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),         & 
& cplcFuChiSuR(3,4,6),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcHpmL(3,3,2),            & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFeFeVZL(3,3),             & 
& cplcFeFeVZR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),               & 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),& 
& cplcFuGluSuR(3,6),cplhhVZVZ(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),      & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSecSeVZ(6,6),cplSucSuVZ(6,6),cplcHpmVWmVZ(2),cplcVWmVWmVZ

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVZ 


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFuFuVGL(i3,gt2)
coup2R = cplcFuFuVGR(i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFuFuVPL(i3,gt2)
coup2R = cplcFuFuVPR(i3,gt2)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVZ


Subroutine Amplitude_Tree_MSSMTriLnV_FuToGluSu(cplcFuGluSuL,cplcFuGluSuR,             & 
& MFu,MGlu,MSu,MFu2,MGlu2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MGlu,MSu(6),MFu2(3),MGlu2,MSu2(6)

Complex(dp), Intent(in) :: cplcFuGluSuL(3,6),cplcFuGluSuR(3,6)

Complex(dp) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MGlu 
Mex3 = MSu(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuGluSuL(gt1,gt3)
coupT1R = cplcFuGluSuR(gt1,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt3) = AmpC 
    End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuToGluSu


Subroutine Gamma_Real_MSSMTriLnV_FuToGluSu(MLambda,em,gs,cplcFuGluSuL,cplcFuGluSuR,   & 
& MFu,MGlu,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuGluSuL(3,6),cplcFuGluSuR(3,6)

Real(dp), Intent(in) :: MFu(3),MGlu,MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,6), GammarealGluon(3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
    Do i3=1,6
CoupL = cplcFuGluSuL(i1,i3)
CoupR = cplcFuGluSuR(i1,i3)
Mex1 = MFu(i1)
Mex2 = MGlu
Mex3 = MSu(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,16._dp/27._dp,0._dp,16._dp/27._dp,0._dp,0._dp,16._dp/27._dp,CoupL,CoupR,Gammarealphoton(i1,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,16._dp/9._dp,2._dp,-2._dp/9._dp,4._dp,-2._dp,16._dp/9._dp,CoupL,CoupR,Gammarealgluon(i1,i3),kont)
Else 
  GammarealGluon(i1,i3) = 0._dp 
  GammarealPhoton(i1,i3) = 0._dp 

End if 
    End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuToGluSu


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToGluSu(cplcFuGluSuL,cplcFuGluSuR,             & 
& ctcplcFuGluSuL,ctcplcFuGluSuR,MFu,MFu2,MGlu,MGlu2,MSu,MSu2,ZffG,ZfFUL,ZfFUR,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MGlu,MGlu2,MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplcFuGluSuL(3,6),cplcFuGluSuR(3,6)

Complex(dp), Intent(in) :: ctcplcFuGluSuL(3,6),ctcplcFuGluSuR(3,6)

Complex(dp), Intent(in) :: ZffG,ZfFUL(3,3),ZfFUR(3,3),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MGlu 
Mex3 = MSu(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuGluSuL(gt1,gt3) 
ZcoupT1R = ctcplcFuGluSuR(gt1,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFuGluSuL(i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuGluSuR(i1,gt3)
End Do


! External Field 2 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZffG*cplcFuGluSuL(gt1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZffG)*cplcFuGluSuR(gt1,gt3)


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfSu(i1,gt3)*cplcFuGluSuL(gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfSu(i1,gt3)*cplcFuGluSuR(gt1,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt3) = 4._dp/3._dp*AmpC 
    End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToGluSu


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToGluSu(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,          & 
& cplcFecFuSdR,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),          & 
& cplcFdChaSuR(3,2,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplGluFdcSdL(3,6),         & 
& cplGluFdcSdR(3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcFdFeSuL(3,3,6),          & 
& cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL(3,6),         & 
& cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),               & 
& cplHpmSucSd(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),      & 
& cplcFecFuSdR(3,3,6),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),& 
& cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
    Do gt3=1,6
Amp(:,gt1, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MGlu 
Mex3 = MSu(gt3) 


! {Fd, Hpm, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = cplHpmSucSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = cplSeSucSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MSd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = -cplSucSdVWm(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, Ah, Su}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = cplAhSucSu(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, Su}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = cplhhSucSu(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, VG, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVG(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVP(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VZ, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVZ(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Glu, conj[Su], VG}
  Do i2=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MVG 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3 = -cplSucSuVG(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(2*(0.,1._dp))*AmpC 
  End Do


! {Sd, Cha, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MFd(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdChaSuL(i3,i2,gt3)
coup3R = cplcFdChaSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFd(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFeSuL(i3,i2,gt3)
coup3R = cplcFdFeSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Fu}
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuChiSuL(i3,i2,gt3)
coup3R = cplcFuChiSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Glu, Fu}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MGlu 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(gt1,i1)
coup1R = cplcFuGluSuR(gt1,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuGluSuL(i3,gt3)
coup3R = cplcFuGluSuR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {VG, bar[Fu], Glu}
  Do i2=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MGlu 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplcFuGluSuL(i2,gt3)
coup3R = cplcFuGluSuR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2*(0.,1._dp))*AmpC 
  End Do
    End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToGluSu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplAhSucSu,cplcFdChaSuL,cplcFdChaSuR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,           & 
& cplGluFdcSdR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,      & 
& cplcFuFdcVWmR,cplcFdFeSuL,cplcFdFeSuR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,           & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,          & 
& cplcFuGluSuR,cplhhSucSu,cplHpmSucSd,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,          & 
& cplcFecFuSdR,cplSeSucSd,cplSucSuVG,cplSucSuVP,cplSucSdVWm,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSucSu(2,6,6),cplcFdChaSuL(3,2,6),          & 
& cplcFdChaSuR(3,2,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplGluFdcSdL(3,6),         & 
& cplGluFdcSdR(3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcFdFeSuL(3,3,6),          & 
& cplcFdFeSuR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),             & 
& cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL(3,6),         & 
& cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplhhSucSu(2,6,6),               & 
& cplHpmSucSd(2,6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),      & 
& cplcFecFuSdR(3,3,6),cplSeSucSd(6,6,6),cplSucSuVG(6,6),cplSucSuVP(6,6),cplSucSdVWm(6,6),& 
& cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
    Do gt3=1,6
Amp(:,gt1, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MGlu 
Mex3 = MSu(gt3) 


! {Fu, VG, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVG(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Su}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSu(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVP(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Glu, conj[Su], VG}
  Do i2=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MVG 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3 = -cplSucSuVG(gt3,i2)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(2*(0.,1._dp))*AmpC 
  End Do


! {VG, bar[Fu], Glu}
  Do i2=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MGlu 
coup1L = -cplcFuFuVGR(gt1,i2)
coup1R = -cplcFuFuVGL(gt1,i2)
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplcFuGluSuL(i2,gt3)
coup3R = cplcFuGluSuR(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt3) = Amp(:,gt1, gt3) + oo16pi2*(-2*(0.,1._dp))*AmpC 
  End Do
    End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToGluSu


Subroutine Amplitude_Tree_MSSMTriLnV_FuTocChaSd(cplcChacFuSdL,cplcChacFuSdR,          & 
& MCha,MFu,MSd,MCha2,MFu2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFu(3),MSd(6),MCha2(2),MFu2(3),MSd2(6)

Complex(dp), Intent(in) :: cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6)

Complex(dp) :: Amp(2,3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcChacFuSdL(gt2,gt1,gt3)
coupT1R = cplcChacFuSdR(gt2,gt1,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuTocChaSd


Subroutine Gamma_Real_MSSMTriLnV_FuTocChaSd(MLambda,em,gs,cplcChacFuSdL,              & 
& cplcChacFuSdR,MCha,MFu,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6)

Real(dp), Intent(in) :: MCha(2),MFu(3),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,2,6), GammarealGluon(3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
CoupL = cplcChacFuSdL(i2,i1,i3)
CoupR = cplcChacFuSdR(i2,i1,i3)
Mex1 = MFu(i1)
Mex2 = MCha(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,2._dp/3._dp,-2._dp/9._dp,1._dp,-1._dp/3._dp,1._dp/9._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuTocChaSd


Subroutine Amplitude_WAVE_MSSMTriLnV_FuTocChaSd(cplcChacFuSdL,cplcChacFuSdR,          & 
& ctcplcChacFuSdL,ctcplcChacFuSdR,MCha,MCha2,MFu,MFu2,MSd,MSd2,ZfFUL,ZfFUR,              & 
& ZfLm,ZfLp,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MFu(3),MFu2(3),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6)

Complex(dp), Intent(in) :: ctcplcChacFuSdL(2,3,6),ctcplcChacFuSdR(2,3,6)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfLm(2,2),ZfLp(2,2),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcChacFuSdL(gt2,gt1,gt3) 
ZcoupT1R = ctcplcChacFuSdR(gt2,gt1,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcChacFuSdL(gt2,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcChacFuSdR(gt2,i1,gt3)
End Do


! External Field 2 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLp(i1,gt2)*cplcChacFuSdL(i1,gt1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLm(i1,gt2))*cplcChacFuSdR(i1,gt1,gt3)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfSd(i1,gt3)*cplcChacFuSdL(gt2,gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfSd(i1,gt3)*cplcChacFuSdR(gt2,gt1,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuTocChaSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuTocChaSd(MAh,MCha,MChi,MFd,MFe,              & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,     & 
& cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,cplcChaChahhR,          & 
& cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,cplcChaChiHpmR, & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,     & 
& cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,cplcFuFuhhR,       & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcHpmcSu,cplSdcSucVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),      & 
& cplAhSdcSd(2,6,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),        & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplcChaChiHpmL(2,4,2),        & 
& cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFuChiSuL(3,4,6),     & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),      & 
& cplcChaFdcSuR(2,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),    & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcChaFecSvL(2,3,3),        & 
& cplcChaFecSvR(2,3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),           & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),  & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),               & 
& cplhhSdcSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),   & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSdcHpmcSu(6,2,6),cplSdcSucVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MSd(gt3) 


! {Ah, bar[Fu], Cha}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcChaChaAhL(gt2,i3,i1)
coup2R = cplcChaChaAhR(gt2,i3,i1)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], Hpm}
Do i1=1,4
  Do i2=1,6
    Do i3=1,2
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplcChaChiHpmL(gt2,i1,i3)
coup2R = cplcChaChiHpmR(gt2,i1,i3)
coup3 = cplSdcHpmcSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], VWm}
Do i1=1,4
  Do i2=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplcChaChiVWmL(gt2,i1)
coup2R = cplcChaChiVWmR(gt2,i1)
coup3 = -cplSdcSucVWm(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fu, Ah, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = cplAhSdcSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = cplhhSdcSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VG, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVG(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVP(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VZ, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVZ(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {hh, bar[Fu], Cha}
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcChaChahhL(gt2,i3,i1)
coup2R = cplcChaChahhR(gt2,i3,i1)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Fd}
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
coup3L = cplcFdChiSdL(i3,i2,gt3)
coup3R = cplcFdChiSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Glu, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplcFuGluSuL(gt1,i1)
coup1R = cplcFuGluSuR(gt1,i1)
coup2L = cplcChaFdcSuL(gt2,i3,i1)
coup2R = cplcChaFdcSuR(gt2,i3,i1)
coup3L = cplcFdGluSdL(i3,gt3)
coup3R = cplcFdGluSdR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VP, bar[Fu], Cha}
  Do i2=1,3
    Do i3=1,2
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = cplcChaChaVPL(gt2,i3)
coup2R = cplcChaChaVPR(gt2,i3)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], Cha}
  Do i2=1,3
    Do i3=1,2
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = cplcChaChaVZL(gt2,i3)
coup2R = cplcChaChaVZR(gt2,i3)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], Ah}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplcChaChaAhL(gt2,i1,i3)
coup2R = cplcChaChaAhR(gt2,i1,i3)
coup3 = cplAhSdcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], conj[Sd], hh}
Do i1=1,2
  Do i2=1,6
    Do i3=1,2
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplcChaChahhL(gt2,i1,i3)
coup2R = cplcChaChahhR(gt2,i1,i3)
coup3 = cplhhSdcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], conj[Sd], VP}
Do i1=1,2
  Do i2=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3 = -cplSdcSdVP(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Cha], conj[Sd], VZ}
Do i1=1,2
  Do i2=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplcChaChaVZL(gt2,i1)
coup2R = cplcChaChaVZR(gt2,i1)
coup3 = -cplSdcSdVZ(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcChaFecSvL(gt2,i1,i3)
coup2R = cplcChaFecSvR(gt2,i1,i3)
coup3 = cplSdSvcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], Chi}
Do i1=1,2
  Do i2=1,3
    Do i3=1,4
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcChaChiHpmL(gt2,i3,i1)
coup2R = cplcChaChiHpmR(gt2,i3,i1)
coup3L = cplcFdChiSdL(i2,i3,gt3)
coup3R = cplcFdChiSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcChaFvSeL(gt2,i3,i1)
coup2R = cplcChaFvSeR(gt2,i3,i1)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], Chi}
  Do i2=1,3
    Do i3=1,4
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = cplcChaChiVWmL(gt2,i3)
coup2R = cplcChaChiVWmR(gt2,i3)
coup3L = cplcFdChiSdL(i2,i3,gt3)
coup3R = cplcFdChiSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuTocChaSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplcChaChaAhL,cplcChaChaAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcChaChahhL,          & 
& cplcChaChahhR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,cplcChaChaVZR,cplcChaChiHpmL,  & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplcChaChiVWmL,     & 
& cplcChaChiVWmR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,   & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplcChaFecSvL,cplcChaFecSvR,cplcFuFuhhL,      & 
& cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,               & 
& cplSdcSdVP,cplSdcSdVZ,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,           & 
& cplSdcHpmcSu,cplSdcSucVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),      & 
& cplAhSdcSd(2,6,6),cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplcChaChaVPL(2,2),        & 
& cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplcChaChiHpmL(2,4,2),        & 
& cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFuChiSuL(3,4,6),     & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFdcSuL(2,3,6),      & 
& cplcChaFdcSuR(2,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),    & 
& cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplcChaFecSvL(2,3,3),        & 
& cplcChaFecSvR(2,3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFuFuVGL(3,3),           & 
& cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),  & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),               & 
& cplhhSdcSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6),cplSdcSdVZ(6,6),   & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSdcHpmcSu(6,2,6),cplSdcSucVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,3,2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,2
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MSd(gt3) 


! {Fu, VG, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVG(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcChacFuSdL(gt2,i1,i3)
coup2R = cplcChacFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VP, bar[Fu], Cha}
  Do i2=1,3
    Do i3=1,2
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = cplcChaChaVPL(gt2,i3)
coup2R = cplcChaChaVPR(gt2,i3)
coup3L = cplcChacFuSdL(i3,i2,gt3)
coup3R = cplcChacFuSdR(i3,i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], VP}
Do i1=1,2
  Do i2=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplcChaChaVPL(gt2,i1)
coup2R = cplcChaChaVPR(gt2,i1)
coup3 = -cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuTocChaSd


Subroutine Amplitude_Tree_MSSMTriLnV_FuTocFeSd(cplcFecFuSdL,cplcFecFuSdR,             & 
& MFe,MFu,MSd,MFe2,MFu2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFu(3),MSd(6),MFe2(3),MFu2(3),MSd2(6)

Complex(dp), Intent(in) :: cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Complex(dp) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFecFuSdL(gt2,gt1,gt3)
coupT1R = cplcFecFuSdR(gt2,gt1,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_FuTocFeSd


Subroutine Gamma_Real_MSSMTriLnV_FuTocFeSd(MLambda,em,gs,cplcFecFuSdL,cplcFecFuSdR,   & 
& MFe,MFu,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Real(dp), Intent(in) :: MFe(3),MFu(3),MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,3,6), GammarealGluon(3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
CoupL = cplcFecFuSdL(i2,i1,i3)
CoupR = cplcFecFuSdR(i2,i1,i3)
Mex1 = MFu(i1)
Mex2 = MFe(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,4._dp/9._dp,2._dp/3._dp,-2._dp/9._dp,1._dp,-1._dp/3._dp,1._dp/9._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,4._dp/3._dp,0._dp,4._dp/3._dp,0._dp,0._dp,4._dp/3._dp,CoupL,CoupR,Gammarealgluon(i1,i2,i3),kont)
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_FuTocFeSd


Subroutine Amplitude_WAVE_MSSMTriLnV_FuTocFeSd(cplcFecFuSdL,cplcFecFuSdR,             & 
& ctcplcFecFuSdL,ctcplcFecFuSdR,MFe,MFe2,MFu,MFu2,MSd,MSd2,ZfFEL,ZfFER,ZfFUL,            & 
& ZfFUR,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFe2(3),MFu(3),MFu2(3),MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6)

Complex(dp), Intent(in) :: ctcplcFecFuSdL(3,3,6),ctcplcFecFuSdR(3,3,6)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFecFuSdL(gt2,gt1,gt3) 
ZcoupT1R = ctcplcFecFuSdR(gt2,gt1,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt1)*cplcFecFuSdL(gt2,i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFecFuSdR(gt2,i1,gt3)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFER(i1,gt2)*cplcFecFuSdL(i1,gt1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFEL(i1,gt2))*cplcFecFuSdR(i1,gt1,gt3)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfSd(i1,gt3)*cplcFecFuSdL(gt2,gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfSd(i1,gt3)*cplcFecFuSdR(gt2,gt1,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuTocFeSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuTocFeSd(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,           & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFdChiSdL(3,4,6),         & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),           & 
& cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),         & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),           & 
& cplcFdFvSdR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),            & 
& cplcFeFvVWmR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),               & 
& cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6), & 
& cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),         & 
& cplcFecFuSdR(3,3,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MSd(gt3) 


! {Ah, bar[Fu], Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFeFeAhL(gt2,i3,i1)
coup2R = cplcFeFeAhR(gt2,i3,i1)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], Se}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplcFeChiSeL(gt2,i1,i3)
coup2R = cplcFeChiSeR(gt2,i1,i3)
coup3 = cplSdcSecSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, Ah, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuAhL(gt1,i1,i2)
coup1R = cplcFuFuAhR(gt1,i1,i2)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = cplAhSdcSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, hh, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFuhhL(gt1,i1,i2)
coup1R = cplcFuFuhhR(gt1,i1,i2)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = cplhhSdcSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fu, VG, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVG(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVP(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fu, VZ, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVZR(gt1,i1)
coup1R = -cplcFuFuVZL(gt1,i1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVZ(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {hh, bar[Fu], Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFeFehhL(gt2,i3,i1)
coup2R = cplcFeFehhR(gt2,i3,i1)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Chi, Fd}
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuChiSuL(gt1,i2,i1)
coup1R = cplcFuChiSuR(gt1,i2,i1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
coup3L = cplcFdChiSdL(i3,i2,gt3)
coup3R = cplcFdChiSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Su, Glu, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplcFuGluSuL(gt1,i1)
coup1R = cplcFuGluSuR(gt1,i1)
coup2L = cplcFeFdcSuL(gt2,i3,i1)
coup2R = cplcFeFdcSuR(gt2,i3,i1)
coup3L = cplcFdGluSdL(i3,gt3)
coup3R = cplcFdGluSdR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {VP, bar[Fu], Fe}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = cplcFeFeVPL(gt2,i3)
coup2R = cplcFeFeVPR(gt2,i3)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], Fe}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = -cplcFuFuVZR(gt1,i2)
coup1R = -cplcFuFuVZL(gt1,i2)
coup2L = cplcFeFeVZL(gt2,i3)
coup2R = cplcFeFeVZR(gt2,i3)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], Sv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplcFeChaSvL(gt2,i1,i3)
coup2R = cplcFeChaSvR(gt2,i1,i3)
coup3 = cplSdcSdcSv(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], Ah}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFeAhL(gt2,i1,i3)
coup2R = cplcFeFeAhR(gt2,i1,i3)
coup3 = cplAhSdcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFehhL(gt2,i1,i3)
coup2R = cplcFeFehhR(gt2,i1,i3)
coup3 = cplhhSdcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], Sv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFeSvL(gt2,i1,i3)
coup2R = cplcFeFeSvR(gt2,i1,i3)
coup3 = cplSdcSdcSv(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFeVPL(gt2,i1)
coup2R = cplcFeFeVPR(gt2,i1)
coup3 = -cplSdcSdVP(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], conj[Sd], VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFeVZL(gt2,i1)
coup2R = cplcFeFeVZR(gt2,i1)
coup3 = -cplSdcSdVZ(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFecSvL(gt2,i1,i3)
coup2R = cplcFeFecSvR(gt2,i1,i3)
coup3 = cplSdSvcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], Fv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFeFvHpmL(gt2,i3,i1)
coup2R = cplcFeFvHpmR(gt2,i3,i1)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], Chi}
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFeChiSeL(gt2,i3,i1)
coup2R = cplcFeChiSeR(gt2,i3,i1)
coup3L = cplcFdChiSdL(i2,i3,gt3)
coup3R = cplcFdChiSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFeFvSeL(gt2,i3,i1)
coup2R = cplcFeFvSeR(gt2,i3,i1)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], Fv}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = cplcFeFvVWmL(gt2,i3)
coup2R = cplcFeFvVWmR(gt2,i3)
coup3L = cplcFdFvSdL(i2,i3,gt3)
coup3R = cplcFdFvSdR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuTocFeSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplcFeChaSvL,cplcFeChaSvR,              & 
& cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,       & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplcFeFehhL,cplcFeFehhR,cplcFeFeSvL,cplcFeFeSvR,           & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFecSvL,cplcFeFecSvR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcFuFuVZL,cplcFuFuVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,      & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSdcSdcSv,cplSdcSecSu,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MSv(3),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),               & 
& MFe2(3),MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVG2,           & 
& MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),          & 
& cplAhSdcSd(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplcFdChiSdL(3,4,6),         & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),      & 
& cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),       & 
& cplcFuFdcVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),           & 
& cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),         & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),  & 
& cplcFuFuVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),           & 
& cplcFdFvSdR(3,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),            & 
& cplcFeFvVWmR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),               & 
& cplcFuGluSuR(3,6),cplhhSdcSd(2,6,6),cplSdSvcSd(6,3,6),cplSdcSdVG(6,6),cplSdcSdVP(6,6), & 
& cplSdcSdVZ(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),         & 
& cplcFecFuSdR(3,3,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MSd(gt3) 


! {Fu, VG, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVGR(gt1,i1)
coup1R = -cplcFuFuVGL(gt1,i1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVG(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
End Do


! {Fu, VP, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1L = -cplcFuFuVPR(gt1,i1)
coup1R = -cplcFuFuVPL(gt1,i1)
coup2L = cplcFecFuSdL(gt2,i1,i3)
coup2R = cplcFecFuSdR(gt2,i1,i3)
coup3 = -cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {VP, bar[Fu], Fe}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = -cplcFuFuVPR(gt1,i2)
coup1R = -cplcFuFuVPL(gt1,i2)
coup2L = cplcFeFeVPL(gt2,i3)
coup2R = cplcFeFeVPR(gt2,i3)
coup3L = cplcFecFuSdL(i3,i2,gt3)
coup3R = cplcFecFuSdR(i3,i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Fe], conj[Sd], VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplcFeFeVPL(gt2,i1)
coup2R = cplcFeFeVPR(gt2,i1)
coup3 = -cplSdcSdVP(gt3,i2)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuTocFeSd


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuSv(MFu,MFu2,MSv,MSv2,ZfFUL,ZfFUR,ZfSv,Amp)

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
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MSv(gt3) 
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
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuSv(MCha,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,             & 
& cplChaFucSdR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplHpmSvcSe,cplSdSvcSd,cplcChacFuSdL,            & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSvcSe,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),      & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),              & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSeSvcSe(6,3,6),cplSvcSeVWm(3,6)

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
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Hpm, Se}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = cplHpmSvcSe(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = cplSeSvcSe(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Se}
Do i1=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MSe(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = -cplSvcSeVWm(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, Cha, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MFe(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeChaSvL(i3,i2,gt3)
coup3R = cplcFeChaSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeFeSvL(i3,i2,gt3)
coup3R = cplcFeFeSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuSv(MCha,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSv,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSv2,MVWm2,cplChaFucSdL,         & 
& cplChaFucSdR,cplcFeChaSvL,cplcFeChaSvR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,       & 
& cplFeFucSdR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,             & 
& cplcFdFuSeR,cplcFdFuVWmL,cplcFdFuVWmR,cplHpmSvcSe,cplSdSvcSd,cplcChacFuSdL,            & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSvcSe,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSv(3),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),      & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),         & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),              & 
& cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),     & 
& cplSeSvcSe(6,3,6),cplSvcSeVWm(3,6)

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
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuSv


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuVG(cplcFuFuVGL,cplcFuFuVGR,ctcplcFuFuVGL,  & 
& ctcplcFuFuVGR,MFu,MFu2,MVG,MVG2,ZfFUL,ZfFUR,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MVG,MVG2

Complex(dp), Intent(in) :: cplcFuFuVGL(3,3),cplcFuFuVGR(3,3)

Complex(dp), Intent(in) :: ctcplcFuFuVGL(3,3),ctcplcFuFuVGR(3,3)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfVG

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVG 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFuVGL(gt1,gt2) 
ZcoupT1R = ctcplcFuFuVGR(gt1,gt2)
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFuVGL(i1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFuVGR(i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplcFuFuVGL(gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplcFuFuVGR(gt1,i1)
End Do


! External Field 3 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVG*cplcFuFuVGL(gt1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVG*cplcFuFuVGR(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = -4._dp/3._dp*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuVG(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplSdcSdVG,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSucSuVG,           & 
& cplVGVGVG,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),        & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),           & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),             & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),               & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),& 
& cplcFuFuVZR(3,3),cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),        & 
& cplSdcSdVG(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),         & 
& cplcFecFuSdR(3,3,6),cplSucSuVG(6,6),cplVGVGVG

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVG 


! {Ah, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Su]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, VG, VG}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MVG 
coup1L = cplcFuFuVGL(gt1,i1)
coup1R = cplcFuFuVGR(gt1,i1)
coup2L = cplcFuFuVGL(i1,gt2)
coup2R = cplcFuFuVGR(i1,gt2)
coup3 = cplVGVGVG
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {Glu, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Glu, Glu}
Do i1=1,6
ML1 = MSu(i1) 
ML2 = MGlu 
ML3 = MGlu 
coup1L = cplcFuGluSuL(gt1,i1)
coup1R = cplcFuGluSuR(gt1,i1)
coup2L = cplGluFucSuL(gt2,i1)
coup2R = cplGluFucSuR(gt2,i1)
coup3L = cplGluGluVGL
coup3R = cplGluGluVGR
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFuFuVGL(i3,gt2)
coup2R = cplcFuFuVGR(i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFuFuVPL(i3,gt2)
coup2R = cplcFuFuVPR(i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVZL(gt1,i2)
coup1R = cplcFuFuVZR(gt1,i2)
coup2L = cplcFuFuVZL(i3,gt2)
coup2R = cplcFuFuVZR(i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcVWmL(gt1,i2)
coup1R = cplcFuFdcVWmR(gt1,i2)
coup2L = cplcFdFuVWmL(i3,gt2)
coup2R = cplcFdFuVWmR(i3,gt2)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVG(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,         & 
& cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,         & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,             & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,             & 
& cplcFuFuVZL,cplcFuFuVZR,cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplSdcSdVG,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSucSuVG,           & 
& cplVGVGVG,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),        & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),           & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplGluFucSuL(3,6),cplGluFucSuR(3,6),             & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),               & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),& 
& cplcFuFuVZR(3,3),cplGluGluVGL,cplGluGluVGR,cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),        & 
& cplSdcSdVG(6,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),         & 
& cplcFecFuSdR(3,3,6),cplSucSuVG(6,6),cplVGVGVG

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVG 


! {Fu, VG, VG}
Do i1=1,3
ML1 = MFu(i1) 
ML2 = MVG 
ML3 = MVG 
coup1L = cplcFuFuVGL(gt1,i1)
coup1R = cplcFuFuVGR(gt1,i1)
coup2L = cplcFuFuVGL(i1,gt2)
coup2R = cplcFuFuVGR(i1,gt2)
coup3 = cplVGVGVG
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2*(0.,1._dp))*AmpC 
End Do


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFuFuVGL(i3,gt2)
coup2R = cplcFuFuVGR(i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(-2._dp/9._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFuFuVPL(i3,gt2)
coup2R = cplcFuFuVPR(i3,gt2)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVG


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuVP(cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,    & 
& cplcFuFuVZR,ctcplcFuFuVPL,ctcplcFuFuVPR,ctcplcFuFuVZL,ctcplcFuFuVZR,MFu,               & 
& MFu2,MVP,MVP2,ZfFUL,ZfFUR,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MVP,MVP2

Complex(dp), Intent(in) :: cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3)

Complex(dp), Intent(in) :: ctcplcFuFuVPL(3,3),ctcplcFuFuVPR(3,3),ctcplcFuFuVZL(3,3),ctcplcFuFuVZR(3,3)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfVP,ZfVZVP

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVP 
ZcoupT1L = 0._dp 
ZcoupT1R = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfFUL(i1,gt1))*cplcFuFuVPL(i1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfFUR(i1,gt1)*cplcFuFuVPR(i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplcFuFuVPL(gt1,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplcFuFuVPR(gt1,i1)
End Do


! External Field 3 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVP*cplcFuFuVPL(gt1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVP*cplcFuFuVPR(gt1,gt2)
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVZVP*cplcFuFuVZL(gt1,gt2)
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVZVP*cplcFuFuVZR(gt1,gt2)


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = -1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFuVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuVP(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,            & 
& MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,          & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,       & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,            & 
& cplcVWmVPVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),        & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),         & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),             & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),& 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),& 
& cplcFuGluSuR(3,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSecSeVP(6,6),          & 
& cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVP 


! {Ah, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuAhL(gt1,i2,i1)
coup1R = cplcFuFuAhR(gt1,i2,i1)
coup2L = cplcFuFuAhL(i3,gt2,i1)
coup2R = cplcFuFuAhR(i3,gt2,i1)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Chi, conj[Su], conj[Su]}
Do i1=1,4
  Do i2=1,6
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuChiSuL(gt1,i1,i2)
coup1R = cplcFuChiSuR(gt1,i1,i2)
coup2L = cplChiFucSuL(i1,gt2,i3)
coup2R = cplChiFucSuR(i1,gt2,i3)
coup3 = cplSucSuVP(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, Hpm}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = -cplHpmcHpmVP(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Hpm}
Do i1=1,3
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = cplcHpmVPVWm(i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Fd, Se, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = -cplSecSeVP(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Hpm, VWm}
Do i1=1,3
  Do i2=1,2
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFuVWmL(i1,gt2)
coup2R = cplcFdFuVWmR(i1,gt2)
coup3 = cplHpmcVWmVP(i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Fd, VWm, VWm}
Do i1=1,3
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1L = cplcFuFdcVWmL(gt1,i1)
coup1R = cplcFuFdcVWmR(gt1,i1)
coup2L = cplcFdFuVWmL(i1,gt2)
coup2R = cplcFdFuVWmR(i1,gt2)
coup3 = cplcVWmVPVWm
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Glu, conj[Su], conj[Su]}
  Do i2=1,6
    Do i3=1,6
ML1 = MGlu 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(gt1,i2)
coup1R = cplcFuGluSuR(gt1,i2)
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplSucSuVP(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {hh, bar[Fu], bar[Fu]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuhhL(gt1,i2,i1)
coup1R = cplcFuFuhhR(gt1,i2,i1)
coup2L = cplcFuFuhhL(i3,gt2,i1)
coup2R = cplcFuFuhhR(i3,gt2,i1)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Cha, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = -cplcChaChaVPR(i3,i2)
coup3R = -cplcChaChaVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = -cplcFeFeVPR(i3,i2)
coup3R = -cplcFeFeVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFuFuVGL(i3,gt2)
coup2R = cplcFuFuVGR(i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFuFuVPL(i3,gt2)
coup2R = cplcFuFuVPR(i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVZ 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVZL(gt1,i2)
coup1R = cplcFuFuVZR(gt1,i2)
coup2L = cplcFuFuVZL(i3,gt2)
coup2R = cplcFuFuVZR(i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplSdcSdVP(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcVWmL(gt1,i2)
coup1R = cplcFuFdcVWmR(gt1,i2)
coup2L = cplcFdFuVWmL(i3,gt2)
coup2R = cplcFdFuVWmR(i3,gt2)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFuVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVP(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,             & 
& MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,cplcFuFuAhR,     & 
& cplChaFucSdL,cplChaFucSdR,cplcChaChaVPL,cplcChaChaVPR,cplChiFucSuL,cplChiFucSuR,       & 
& cplcFuChiSuL,cplcFuChiSuR,cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcHpmL,cplcFuFdcHpmR,         & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,         & 
& cplcFeFeVPL,cplcFeFeVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplcFuGluSuL,cplcFuGluSuR,cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplcChacFuSdL,          & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSecSeVP,cplSucSuVP,cplcHpmVPVWm,            & 
& cplcVWmVPVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MGlu,Mhh(2),MHpm(2),MSd(6),               & 
& MSe(6),MSu(6),MVG,MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),              & 
& MFu2(3),MGlu2,Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVG2,MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),        & 
& cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),         & 
& cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),             & 
& cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),     & 
& cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),           & 
& cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),& 
& cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFdFuSeL(3,3,6),         & 
& cplcFdFuSeR(3,3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),& 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFuGluSuL(3,6),& 
& cplcFuGluSuR(3,6),cplHpmcHpmVP(2,2),cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplcChacFuSdL(2,3,6),& 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSecSeVP(6,6),          & 
& cplSucSuVP(6,6),cplcHpmVPVWm(2),cplcVWmVPVWm

Complex(dp), Intent(out) :: Amp(4,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MVP 


! {VG, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVG 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVGL(gt1,i2)
coup1R = cplcFuFuVGR(gt1,i2)
coup2L = cplcFuFuVGL(i3,gt2)
coup2R = cplcFuFuVGR(i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(4._dp/3._dp)*AmpC 
    End Do
  End Do


! {VP, bar[Fu], bar[Fu]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVP 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFuVPL(gt1,i2)
coup1R = cplcFuFuVPR(gt1,i2)
coup2L = cplcFuFuVPL(i3,gt2)
coup2R = cplcFuFuVPR(i3,gt2)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFuVP


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFucSv(MFu,MFu2,MSv,MSv2,ZfFUL,               & 
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
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MSv(gt3) 
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
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFucSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFucSv(MCha,MFd,MFe,MFu,MHpm,               & 
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
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MSv(gt3) 


! {Fd, Se, Hpm}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = cplSecHpmcSv(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = cplSecSecSv(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, VWm}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MVWm 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
coup3 = cplSecSvcVWm(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Sd, Fe, Cha}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MCha(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = cplcChaFecSvL(i3,i2,gt3)
coup3R = cplcChaFecSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeFecSvL(i3,i2,gt3)
coup3R = cplcFeFecSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], conj[Sd], conj[Sd]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplChaFucSdL(i1,gt2,i3)
coup2R = cplChaFucSdR(i1,gt2,i3)
coup3 = cplSdcSdcSv(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFeFucSdL(i1,gt2,i3)
coup2R = cplFeFucSdR(i1,gt2,i3)
coup3 = cplSdcSdcSv(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fd]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFdFuHpmL(i3,gt2,i1)
coup2R = cplcFdFuHpmR(i3,gt2,i1)
coup3L = cplcFdFdcSvL(i2,i3,gt3)
coup3R = cplcFdFdcSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFdFuSeL(i3,gt2,i1)
coup2R = cplcFdFuSeR(i3,gt2,i1)
coup3L = cplcFdFdcSvL(i2,i3,gt3)
coup3R = cplcFdFdcSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fd]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = -cplcFdFuVWmR(i3,gt2)
coup2R = -cplcFdFuVWmL(i3,gt2)
coup3L = cplcFdFdcSvL(i2,i3,gt3)
coup3R = cplcFdFdcSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFucSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFucSv(MCha,MFd,MFe,MFu,MHpm,            & 
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
Mex1 = MFu(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFucSv


Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFvSu(MFu,MFu2,MSu,MSu2,ZfFUL,ZfFUR,          & 
& ZfFvL,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MSu(6),MSu2(6)

Complex(dp), Intent(in) :: ZfFUL(3,3),ZfFUR(3,3),ZfFvL(3,3),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MFu(gt1) 
Mex2 = 0. 
Mex3 = MSu(gt3) 
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
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_FuToFvSu


Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFvSu(MCha,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,cplFvChacSeL,             & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,      & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,            & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplHpmSucSd,            & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),      & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),             & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplHpmSucSd(2,6,6),cplcChacFuSdL(2,3,6),           & 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSeSucSd(6,6,6),        & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = 0. 
Mex3 = MSu(gt3) 


! {Fd, Hpm, Sd}
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MHpm(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcHpmL(gt1,i1,i2)
coup1R = cplcFuFdcHpmR(gt1,i1,i2)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3 = cplHpmSucSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, Se, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSe(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(gt1,i1,i2)
coup1R = cplcFuFdcSeR(gt1,i1,i2)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3 = cplSeSucSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Fd, VWm, Sd}
Do i1=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MVWm 
ML3 = MSd(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i1)
coup1R = -cplcFuFdcVWmL(gt1,i1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3 = -cplSucSdVWm(gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Sd, Cha, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MCha(i2) 
ML3 = MFd(i3) 
coup1L = cplcChacFuSdL(i2,gt1,i1)
coup1R = cplcChacFuSdR(i2,gt1,i1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdChaSuL(i3,i2,gt3)
coup3R = cplcFdChaSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fe, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFe(i2) 
ML3 = MFd(i3) 
coup1L = cplcFecFuSdL(i2,gt1,i1)
coup1R = cplcFecFuSdR(i2,gt1,i1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = cplcFdFeSuL(i3,i2,gt3)
coup3R = cplcFdFeSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Cha], conj[Sd], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = MSd(i2) 
ML3 = MSe(i3) 
coup1L = cplcChacFuSdL(i1,gt1,i2)
coup1R = cplcChacFuSdR(i1,gt1,i2)
coup2L = cplFvChacSeL(gt2,i1,i3)
coup2R = cplFvChacSeR(gt2,i1,i3)
coup3 = cplSeSucSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Hpm]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MHpm(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFvFecHpmL(gt2,i1,i3)
coup2R = cplFvFecHpmR(gt2,i1,i3)
coup3 = cplHpmSucSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MSe(i3) 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFvFecSeL(gt2,i1,i3)
coup2R = cplFvFecSeR(gt2,i1,i3)
coup3 = cplSeSucSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {bar[Fe], conj[Sd], conj[VWm]}
Do i1=1,3
  Do i2=1,6
ML1 = MFe(i1) 
ML2 = MSd(i2) 
ML3 = MVWm 
coup1L = cplcFecFuSdL(i1,gt1,i2)
coup1R = cplcFecFuSdR(i1,gt1,i2)
coup2L = cplFvFecVWmL(gt2,i1)
coup2R = cplFvFecVWmR(gt2,i1)
coup3 = -cplSucSdVWm(gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {conj[Hpm], bar[Fd], bar[Fe]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuFdcHpmL(gt1,i2,i1)
coup1R = cplcFuFdcHpmR(gt1,i2,i1)
coup2L = cplcFeFvHpmL(i3,gt2,i1)
coup2R = cplcFeFvHpmR(i3,gt2,i1)
coup3L = cplcFdFeSuL(i2,i3,gt3)
coup3R = cplcFdFeSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Cha]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcChaFvSeL(i3,gt2,i1)
coup2R = cplcChaFvSeR(i3,gt2,i1)
coup3L = cplcFdChaSuL(i2,i3,gt3)
coup3R = cplcFdChaSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[Se], bar[Fd], bar[Fe]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuFdcSeL(gt1,i2,i1)
coup1R = cplcFuFdcSeR(gt1,i2,i1)
coup2L = cplcFeFvSeL(i3,gt2,i1)
coup2R = cplcFeFvSeR(i3,gt2,i1)
coup3L = cplcFdFeSuL(i2,i3,gt3)
coup3R = cplcFdFeSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
End Do


! {conj[VWm], bar[Fd], bar[Fe]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = -cplcFuFdcVWmR(gt1,i2)
coup1R = -cplcFuFdcVWmL(gt1,i2)
coup2L = -cplcFeFvVWmR(i3,gt2)
coup2R = -cplcFeFvVWmL(i3,gt2)
coup3L = cplcFdFeSuL(i2,i3,gt3)
coup3R = cplcFdFeSuR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_FuToFvSu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFvSu(MCha,MFd,MFe,MFu,MHpm,             & 
& MSd,MSe,MSu,MVWm,MCha2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MVWm2,cplFvChacSeL,         & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcHpmL,          & 
& cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFvFecHpmL,      & 
& cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,cplFvFecVWmR,cplcFdFeSuL,            & 
& cplcFdFeSuR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,            & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplHpmSucSd,            & 
& cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplSeSucSd,cplSucSdVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm,MCha2(2),              & 
& MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MVWm2

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),      & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplcFuFdcVWmL(3,3),cplcFuFdcVWmR(3,3),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),             & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),         & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplHpmSucSd(2,6,6),cplcChacFuSdL(2,3,6),           & 
& cplcChacFuSdR(2,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplSeSucSd(6,6,6),        & 
& cplSucSdVWm(6,6)

Complex(dp), Intent(out) :: Amp(2,3,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,3
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MFu(gt1) 
Mex2 = 0. 
Mex3 = MSu(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_FuToFvSu



End Module OneLoopDecay_Fu_MSSMTriLnV
