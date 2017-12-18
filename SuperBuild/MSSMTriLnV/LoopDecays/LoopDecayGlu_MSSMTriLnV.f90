! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:58 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Glu_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_GluToFdcSd(cplGluFdcSdL,cplGluFdcSdR,            & 
& MFd,MGlu,MSd,MFd2,MGlu2,MSd2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MFd2(3),MGlu2,MSd2(6)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6)

Complex(dp) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MGlu 
Mex2 = MFd(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1L = cplGluFdcSdL(gt2,gt3)
coupT1R = cplGluFdcSdR(gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt2, gt3) = AmpC 
    End Do
  End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_GluToFdcSd


Subroutine Gamma_Real_MSSMTriLnV_GluToFdcSd(MLambda,em,gs,cplGluFdcSdL,               & 
& cplGluFdcSdR,MFd,MGlu,MSd,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6)

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,6), GammarealGluon(3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
  Do i2=1,3
    Do i3=1,6
CoupL = cplGluFdcSdL(i2,i3)
CoupR = cplGluFdcSdR(i2,i3)
Mex1 = MGlu
Mex2 = MFd(i2)
Mex3 = MSd(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,1._dp/18._dp,-1._dp/18._dp,1._dp/18._dp,CoupL,CoupR,Gammarealphoton(i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,3._dp/2._dp,3._dp/4._dp,3._dp/4._dp,2._dp/3._dp,1._dp/12._dp,2._dp/3._dp,CoupL,CoupR,Gammarealgluon(i2,i3),kont)
Else 
  GammarealGluon(i2,i3) = 0._dp 
  GammarealPhoton(i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Subroutine Gamma_Real_MSSMTriLnV_GluToFdcSd


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToFdcSd(cplGluFdcSdL,cplGluFdcSdR,            & 
& ctcplGluFdcSdL,ctcplGluFdcSdR,MFd,MFd2,MGlu,MGlu2,MSd,MSd2,ZfFDL,ZfFDR,ZffG,ZfSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MGlu,MGlu2,MSd(6),MSd2(6)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6)

Complex(dp), Intent(in) :: ctcplGluFdcSdL(3,6),ctcplGluFdcSdR(3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZffG,ZfSd(6,6)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MGlu 
Mex2 = MFd(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplGluFdcSdL(gt2,gt3) 
ZcoupT1R = ctcplGluFdcSdR(gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZffG*cplGluFdcSdL(gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZffG)*cplGluFdcSdR(gt2,gt3)


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt2)*cplGluFdcSdL(i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt2))*cplGluFdcSdR(i1,gt3)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSd(i1,gt3))*cplGluFdcSdL(gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSd(i1,gt3))*cplGluFdcSdR(gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt2, gt3) = 1._dp/2._dp*AmpC 
    End Do
  End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToFdcSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToFdcSd(MAh,MCha,MChi,MFd,MFe,              & 
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

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt2, gt3) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MFd(gt2) 
Mex3 = MSd(gt3) 


! {Fd, Sd, Ah}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MAh(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFdAhL(i1,gt2,i3)
coup2R = cplcFdFdAhR(i1,gt2,i3)
coup3 = cplAhSdcSd(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Sd, hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = Mhh(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFdhhL(i1,gt2,i3)
coup2R = cplcFdFdhhR(i1,gt2,i3)
coup3 = cplhhSdcSd(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Sd, Sv}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFdSvL(i1,gt2,i3)
coup2R = cplcFdFdSvR(i1,gt2,i3)
coup3 = cplSdcSdcSv(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Sd, VG}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = -cplcFdFdVGR(i1,gt2)
coup2R = -cplcFdFdVGL(i1,gt2)
coup3 = cplSdcSdVG(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-1._dp/12._dp)*AmpC 
  End Do
End Do


! {Fd, Sd, VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplSdcSdVP(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Fd, Sd, VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MVZ 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = -cplcFdFdVZR(i1,gt2)
coup2R = -cplcFdFdVZL(i1,gt2)
coup3 = cplSdcSdVZ(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Fd, Sd, conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSv(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFdcSvL(i1,gt2,i3)
coup2R = cplcFdFdcSvR(i1,gt2,i3)
coup3 = cplSdSvcSd(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, conj[Hpm]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MHpm(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuFdcHpmL(i1,gt2,i3)
coup2R = cplcFuFdcHpmR(i1,gt2,i3)
coup3 = cplHpmSucSd(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSe(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuFdcSeL(i1,gt2,i3)
coup2R = cplcFuFdcSeR(i1,gt2,i3)
coup3 = cplSeSucSd(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, conj[VWm]}
Do i1=1,3
  Do i2=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MVWm 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = -cplcFuFdcVWmR(i1,gt2)
coup2R = -cplcFuFdcVWmL(i1,gt2)
coup3 = cplSucSdVWm(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Glu, VG, conj[Sd]}
    Do i3=1,6
ML1 = MGlu 
ML2 = MVG 
ML3 = MSd(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluFdcSdL(gt2,i3)
coup2R = cplGluFdcSdR(gt2,i3)
coup3 = cplSdcSdVG(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do


! {Sd, Fd, Chi}
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplChiFdcSdL(i3,gt2,i1)
coup2R = cplChiFdcSdR(i3,gt2,i1)
coup3L = cplChiFdcSdL(i3,i2,gt3)
coup3R = cplChiFdcSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = 0. 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplFvFdcSdL(i3,gt2,i1)
coup2R = cplFvFdcSdR(i3,gt2,i1)
coup3L = cplFvFdcSdL(i3,i2,gt3)
coup3R = cplFvFdcSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Glu}
Do i1=1,6
  Do i2=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MGlu 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(gt2,i1)
coup2R = cplGluFdcSdR(gt2,i1)
coup3L = cplGluFdcSdL(i2,gt3)
coup3R = cplGluFdcSdR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-1._dp/12._dp)*AmpC 
  End Do
End Do


! {Su, Fu, bar[Cha]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MCha(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplcChaFdcSuL(i3,gt2,i1)
coup2R = cplcChaFdcSuR(i3,gt2,i1)
coup3L = cplChaFucSdL(i3,i2,gt3)
coup3R = cplChaFucSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, bar[Fe]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFe(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplcFeFdcSuL(i3,gt2,i1)
coup2R = cplcFeFdcSuR(i3,gt2,i1)
coup3L = cplFeFucSdL(i3,i2,gt3)
coup3R = cplFeFucSdR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {VG, Glu, bar[Fd]}
    Do i3=1,3
ML1 = MVG 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplGluFdcSdL(i3,gt3)
coup3R = cplGluFdcSdR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
    End Do
  End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToFdcSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,               & 
& MFd2,MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVG2,MVP2,MVWm2,MVZ2,              & 
& cplcFdFdAhL,cplcFdFdAhR,cplAhSdcSd,cplChaFucSdL,cplChaFucSdR,cplChiFdcSdL,             & 
& cplChiFdcSdR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcFdFdVGL,cplcFdFdVGR,cplcFdFdVPL,               & 
& cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,          & 
& cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,       & 
& cplcFuFdcSeR,cplcFuFdcVWmL,cplcFuFdcVWmR,cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,         & 
& cplGluFucSuR,cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,         & 
& cplcFuGluSuR,cplhhSdcSd,cplHpmSucSd,cplSdSvcSd,cplSdcSdVG,cplSdcSdVP,cplSdcSdVZ,       & 
& cplSdcSdcSv,cplSeSucSd,cplSucSdVWm,Amp)

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

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MFd(gt2) 
Mex3 = MSd(gt3) 


! {Fd, Sd, VG}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = -cplcFdFdVGR(i1,gt2)
coup2R = -cplcFdFdVGL(i1,gt2)
coup3 = cplSdcSdVG(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-1._dp/12._dp)*AmpC 
  End Do
End Do


! {Fd, Sd, VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MVP 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = -cplcFdFdVPR(i1,gt2)
coup2R = -cplcFdFdVPL(i1,gt2)
coup3 = cplSdcSdVP(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Glu, VG, conj[Sd]}
    Do i3=1,6
ML1 = MGlu 
ML2 = MVG 
ML3 = MSd(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluFdcSdL(gt2,i3)
coup2R = cplGluFdcSdR(gt2,i3)
coup3 = cplSdcSdVG(i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do


! {VG, Glu, bar[Fd]}
    Do i3=1,3
ML1 = MVG 
ML2 = MGlu 
ML3 = MFd(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = -cplcFdFdVGR(i3,gt2)
coup2R = -cplcFdFdVGL(i3,gt2)
coup3L = cplGluFdcSdL(i3,gt3)
coup3R = cplGluFdcSdR(i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
    End Do
  End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToFdcSd


Subroutine Amplitude_Tree_MSSMTriLnV_GluToFucSu(cplGluFucSuL,cplGluFucSuR,            & 
& MFu,MGlu,MSu,MFu2,MGlu2,MSu2,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MGlu,MSu(6),MFu2(3),MGlu2,MSu2(6)

Complex(dp), Intent(in) :: cplGluFucSuL(3,6),cplGluFucSuR(3,6)

Complex(dp) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MGlu 
Mex2 = MFu(gt2) 
Mex3 = MSu(gt3) 
! Tree-Level Vertex 
coupT1L = cplGluFucSuL(gt2,gt3)
coupT1R = cplGluFucSuR(gt2,gt3)
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt2, gt3) = AmpC 
    End Do
  End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_GluToFucSu


Subroutine Gamma_Real_MSSMTriLnV_GluToFucSu(MLambda,em,gs,cplGluFucSuL,               & 
& cplGluFucSuR,MFu,MGlu,MSu,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplGluFucSuL(3,6),cplGluFucSuR(3,6)

Real(dp), Intent(in) :: MFu(3),MGlu,MSu(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(3,6), GammarealGluon(3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
  Do i2=1,3
    Do i3=1,6
CoupL = cplGluFucSuL(i2,i3)
CoupR = cplGluFucSuR(i2,i3)
Mex1 = MGlu
Mex2 = MFu(i2)
Mex3 = MSu(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,em,0._dp,0._dp,0._dp,2._dp/9._dp,-2._dp/9._dp,2._dp/9._dp,CoupL,CoupR,Gammarealphoton(i2,i3),kont)
 Call hardradiationFFS(Mex1,Mex2,Mex3,MLambda,gs,3._dp/2._dp,3._dp/4._dp,3._dp/4._dp,2._dp/3._dp,1._dp/12._dp,2._dp/3._dp,CoupL,CoupR,Gammarealgluon(i2,i3),kont)
Else 
  GammarealGluon(i2,i3) = 0._dp 
  GammarealPhoton(i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Subroutine Gamma_Real_MSSMTriLnV_GluToFucSu


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToFucSu(cplGluFucSuL,cplGluFucSuR,            & 
& ctcplGluFucSuL,ctcplGluFucSuR,MFu,MFu2,MGlu,MGlu2,MSu,MSu2,ZffG,ZfFUL,ZfFUR,ZfSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFu(3),MFu2(3),MGlu,MGlu2,MSu(6),MSu2(6)

Complex(dp), Intent(in) :: cplGluFucSuL(3,6),cplGluFucSuR(3,6)

Complex(dp), Intent(in) :: ctcplGluFucSuL(3,6),ctcplGluFucSuR(3,6)

Complex(dp), Intent(in) :: ZffG,ZfFUL(3,3),ZfFUR(3,3),ZfSu(6,6)

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MGlu 
Mex2 = MFu(gt2) 
Mex3 = MSu(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplGluFucSuL(gt2,gt3) 
ZcoupT1R = ctcplGluFucSuR(gt2,gt3) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZffG*cplGluFucSuL(gt2,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZffG)*cplGluFucSuR(gt2,gt3)


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUL(i1,gt2)*cplGluFucSuL(i1,gt3)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUR(i1,gt2))*cplGluFucSuR(i1,gt3)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSu(i1,gt3))*cplGluFucSuL(gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSu(i1,gt3))*cplGluFucSuR(gt2,i1)
End Do


! Getting the amplitude 
Call TreeAmp_FtoFS(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt2, gt3) = 1._dp/2._dp*AmpC 
    End Do
  End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToFucSu


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToFucSu(MAh,MCha,MChi,MFd,MFe,              & 
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

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt2, gt3) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MFu(gt2) 
Mex3 = MSu(gt3) 


! {Fd, Sd, Hpm}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MHpm(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFuHpmL(i1,gt2,i3)
coup2R = cplcFdFuHpmR(i1,gt2,i3)
coup3 = cplSdcHpmcSu(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Sd, Se}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSe(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFuSeL(i1,gt2,i3)
coup2R = cplcFdFuSeR(i1,gt2,i3)
coup3 = cplSdcSecSu(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fd, Sd, VWm}
Do i1=1,3
  Do i2=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MVWm 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = -cplcFdFuVWmR(i1,gt2)
coup2R = -cplcFdFuVWmL(i1,gt2)
coup3 = cplSdcSucVWm(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Fu, Su, Ah}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MAh(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuFuAhL(i1,gt2,i3)
coup2R = cplcFuFuAhR(i1,gt2,i3)
coup3 = cplAhSucSu(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = Mhh(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuFuhhL(i1,gt2,i3)
coup2R = cplcFuFuhhR(i1,gt2,i3)
coup3 = cplhhSucSu(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, VG}
Do i1=1,3
  Do i2=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MVG 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = -cplcFuFuVGR(i1,gt2)
coup2R = -cplcFuFuVGL(i1,gt2)
coup3 = cplSucSuVG(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-1._dp/12._dp)*AmpC 
  End Do
End Do


! {Fu, Su, VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MVP 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = -cplcFuFuVPR(i1,gt2)
coup2R = -cplcFuFuVPL(i1,gt2)
coup3 = cplSucSuVP(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Fu, Su, VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MVZ 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = -cplcFuFuVZR(i1,gt2)
coup2R = -cplcFuFuVZL(i1,gt2)
coup3 = cplSucSuVZ(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Glu, VG, conj[Su]}
    Do i3=1,6
ML1 = MGlu 
ML2 = MVG 
ML3 = MSu(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplSucSuVG(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do


! {Sd, Fd, Cha}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MCha(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplChaFucSdL(i3,gt2,i1)
coup2R = cplChaFucSdR(i3,gt2,i1)
coup3L = cplcChaFdcSuL(i3,i2,gt3)
coup3R = cplcChaFdcSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFe(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplFeFucSdL(i3,gt2,i1)
coup2R = cplFeFucSdR(i3,gt2,i1)
coup3L = cplcFeFdcSuL(i3,i2,gt3)
coup3R = cplcFeFdcSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Chi}
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplChiFucSuL(i3,gt2,i1)
coup2R = cplChiFucSuR(i3,gt2,i1)
coup3L = cplChiFucSuL(i3,i2,gt3)
coup3R = cplChiFucSuR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Glu}
Do i1=1,6
  Do i2=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MGlu 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplGluFucSuL(gt2,i1)
coup2R = cplGluFucSuR(gt2,i1)
coup3L = cplGluFucSuL(i2,gt3)
coup3R = cplGluFucSuR(i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-1._dp/12._dp)*AmpC 
  End Do
End Do


! {VG, Glu, bar[Fu]}
    Do i3=1,3
ML1 = MVG 
ML2 = MGlu 
ML3 = MFu(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplGluFucSuL(i3,gt3)
coup3R = cplGluFucSuR(i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
    End Do
  End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToFucSu


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu(MAh,MCha,MChi,MFd,               & 
& MFe,MFu,MGlu,Mhh,MHpm,MSd,MSe,MSu,MVG,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,              & 
& MFe2,MFu2,MGlu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MVG2,MVP2,MVWm2,MVZ2,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplAhSucSu,cplChaFucSdL,cplChaFucSdR,cplChiFucSuL,cplChiFucSuR,            & 
& cplGluFdcSdL,cplGluFdcSdR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFeFdcSuL,cplcFeFdcSuR,       & 
& cplFeFucSdL,cplFeFucSdR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVGL,cplcFuFuVGR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,             & 
& cplGluGluVGL,cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,         & 
& cplhhSucSu,cplSdcHpmcSu,cplSdcSecSu,cplSdcSucVWm,cplSucSuVG,cplSucSuVP,cplSucSuVZ,Amp)

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

Complex(dp), Intent(out) :: Amp(2,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,3
    Do gt3=1,6
Amp(:,gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MFu(gt2) 
Mex3 = MSu(gt3) 


! {Fu, Su, VG}
Do i1=1,3
  Do i2=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MVG 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = -cplcFuFuVGR(i1,gt2)
coup2R = -cplcFuFuVGL(i1,gt2)
coup3 = cplSucSuVG(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-1._dp/12._dp)*AmpC 
  End Do
End Do


! {Fu, Su, VP}
Do i1=1,3
  Do i2=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MVP 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = -cplcFuFuVPR(i1,gt2)
coup2R = -cplcFuFuVPL(i1,gt2)
coup3 = cplSucSuVP(i2,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FSV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
  End Do
End Do


! {Glu, VG, conj[Su]}
    Do i3=1,6
ML1 = MGlu 
ML2 = MVG 
ML3 = MSu(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluFucSuL(gt2,i3)
coup2R = cplGluFucSuR(gt2,i3)
coup3 = cplSucSuVG(i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_FVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do


! {VG, Glu, bar[Fu]}
    Do i3=1,3
ML1 = MVG 
ML2 = MGlu 
ML3 = MFu(i3) 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = -cplcFuFuVGR(i3,gt2)
coup2R = -cplcFuFuVGL(i3,gt2)
coup3L = cplGluFucSuL(i3,gt3)
coup3R = cplGluFucSuR(i3,gt3)
Call Amp_VERTEX_FtoFS_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt2, gt3) = Amp(:,gt2, gt3) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
    End Do
  End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToFucSu


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToChiVG(MChi,MChi2,MGlu,MGlu2,MVG,            & 
& MVG2,ZffG,ZfL0,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MGlu,MGlu2,MVG,MVG2

Complex(dp), Intent(in) :: ZffG,ZfL0(4,4),ZfVG

Complex(dp), Intent(out) :: Amp(4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

  Do gt2=1,4
! External masses 
Mex1 = MGlu 
Mex2 = MChi(gt2) 
Mex3 = MVG 
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


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt2) = -3*AmpC 
  End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToChiVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToChiVG(MChi,MFd,MFu,MGlu,MSd,              & 
& MSu,MVG,MChi2,MFd2,MFu2,MGlu2,MSd2,MSu2,MVG2,cplChiFdcSdL,cplChiFdcSdR,cplChiFucSuL,   & 
& cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,cplGluFdcSdL,         & 
& cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,            & 
& cplcFuFuVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,            & 
& cplSucSuVG,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVG,MChi2(4),MFd2(3),MFu2(3),MGlu2,          & 
& MSd2(6),MSu2(6),MVG2

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),      & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),& 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplSdcSdVG(6,6),cplSucSuVG(6,6)

Complex(dp), Intent(out) :: Amp(4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,4
Amp(:,gt2) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MChi(gt2) 
Mex3 = MVG 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdChiSdL(i1,gt2,i3)
coup2R = cplcFdChiSdR(i1,gt2,i3)
coup3 = -cplSdcSdVG(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, Su}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuChiSuL(i1,gt2,i3)
coup2R = cplcFuChiSuR(i1,gt2,i3)
coup3 = -cplSucSuVG(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplChiFdcSdL(gt2,i3,i1)
coup2R = cplChiFdcSdR(gt2,i3,i1)
coup3L = -cplcFdFdVGR(i3,i2)
coup3R = -cplcFdFdVGL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Fu}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplChiFucSuL(gt2,i3,i1)
coup2R = cplChiFucSuR(gt2,i3,i1)
coup3L = -cplcFuFuVGR(i3,i2)
coup3R = -cplcFuFuVGL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplChiFdcSdL(gt2,i1,i3)
coup2R = cplChiFdcSdR(gt2,i1,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fu], conj[Su], conj[Su]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(i1,i2)
coup1R = cplcFuGluSuR(i1,i2)
coup2L = cplChiFucSuL(gt2,i1,i3)
coup2R = cplChiFucSuR(gt2,i1,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdChiSdL(i3,gt2,i1)
coup2R = cplcFdChiSdR(i3,gt2,i1)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Su], bar[Fu], bar[Fu]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,i1)
coup1R = cplGluFucSuR(i2,i1)
coup2L = cplcFuChiSuL(i3,gt2,i1)
coup2R = cplcFuChiSuR(i3,gt2,i1)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
  End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToChiVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToChiVG(MChi,MFd,MFu,MGlu,               & 
& MSd,MSu,MVG,MChi2,MFd2,MFu2,MGlu2,MSd2,MSu2,MVG2,cplChiFdcSdL,cplChiFdcSdR,            & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFuChiSuL,cplcFuChiSuR,         & 
& cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,cplcFdFdVGR,cplGluFucSuL,cplGluFucSuR,           & 
& cplcFuFuVGL,cplcFuFuVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,           & 
& cplSdcSdVG,cplSucSuVG,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVG,MChi2(4),MFd2(3),MFu2(3),MGlu2,          & 
& MSd2(6),MSu2(6),MVG2

Complex(dp), Intent(in) :: cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),      & 
& cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),& 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplSdcSdVG(6,6),cplSucSuVG(6,6)

Complex(dp), Intent(out) :: Amp(4,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,4
Amp(:,gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MChi(gt2) 
Mex3 = MVG 
  End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToChiVG


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToFvVG(MGlu,MGlu2,MVG,MVG2,ZffG,              & 
& ZfFvL,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MGlu,MGlu2,MVG,MVG2

Complex(dp), Intent(in) :: ZffG,ZfFvL(3,3),ZfVG

Complex(dp), Intent(out) :: Amp(4,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

  Do gt2=1,3
! External masses 
Mex1 = MGlu 
Mex2 = 0. 
Mex3 = MVG 
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


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:,gt2) = -3*AmpC 
  End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToFvVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToFvVG(MFd,MGlu,MSd,MVG,MFd2,               & 
& MGlu2,MSd2,MVG2,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,         & 
& cplcFdFdVGR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplSdcSdVG,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MVG,MFd2(3),MGlu2,MSd2(6),MVG2

Complex(dp), Intent(in) :: cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),            & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),               & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplSdcSdVG(6,6)

Complex(dp), Intent(out) :: Amp(4,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,3
Amp(:,gt2) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = 0. 
Mex3 = MVG 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
coup3 = -cplSdcSdVG(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
coup3L = -cplcFdFdVGR(i3,i2)
coup3R = -cplcFdFdVGL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplFvFdcSdL(gt2,i1,i3)
coup2R = cplFvFdcSdR(gt2,i1,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdFvSdL(i3,gt2,i1)
coup2R = cplcFdFvSdR(i3,gt2,i1)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt2) = Amp(:,gt2) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
  End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToFvVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToFvVG(MFd,MGlu,MSd,MVG,MFd2,            & 
& MGlu2,MSd2,MVG2,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,         & 
& cplcFdFdVGR,cplcFdFvSdL,cplcFdFvSdR,cplcFdGluSdL,cplcFdGluSdR,cplSdcSdVG,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MVG,MFd2(3),MGlu2,MSd2(6),MVG2

Complex(dp), Intent(in) :: cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),            & 
& cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),               & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplSdcSdVG(6,6)

Complex(dp), Intent(out) :: Amp(4,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
  Do gt2=1,3
Amp(:,gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = 0. 
Mex3 = MVG 
  End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToFvVG


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluAh(MAh,MAh2,MGlu,MGlu2,ZfAh,ZffG,Amp)

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

    Do gt3=1,2
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MAh(gt3) 
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
Amp(:,gt3) = 3*AmpC 
    End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluAh(MAh,MFd,MFu,MGlu,MSd,               & 
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
    Do gt3=1,2
Amp(:,gt3) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MAh(gt3) 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = cplAhSdcSd(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, Su}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = cplAhSucSu(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdAhL(i3,i2,gt3)
coup3R = cplcFdFdAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Fu}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuAhL(i3,i2,gt3)
coup3R = cplcFuFuAhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3 = cplAhSdcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fu], conj[Su], conj[Su]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(i1,i2)
coup1R = cplcFuGluSuR(i1,i2)
coup2L = cplGluFucSuL(i1,i3)
coup2R = cplGluFucSuR(i1,i3)
coup3 = cplAhSucSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplcFdFdAhL(i2,i3,gt3)
coup3R = cplcFdFdAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Su], bar[Fu], bar[Fu]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,i1)
coup1R = cplGluFucSuR(i2,i1)
coup2L = cplcFuGluSuL(i3,i1)
coup2R = cplcFuGluSuR(i3,i1)
coup3L = cplcFuFuAhL(i2,i3,gt3)
coup3R = cplcFuFuAhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
    End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluAh(MAh,MFd,MFu,MGlu,MSd,            & 
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
    Do gt3=1,2
Amp(:,gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MAh(gt3) 
    End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluAh


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluhh(MGlu,MGlu2,Mhh,Mhh2,ZffG,Zfhh,Amp)

Implicit None

Real(dp), Intent(in) :: MGlu,MGlu2,Mhh(2),Mhh2(2)

Complex(dp), Intent(in) :: ZffG,Zfhh(2,2)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

    Do gt3=1,2
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = Mhh(gt3) 
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
Amp(:,gt3) = 3*AmpC 
    End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluhh


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluhh(MFd,MFu,MGlu,Mhh,MSd,               & 
& MSu,MFd2,MFu2,MGlu2,Mhh2,MSd2,MSu2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,              & 
& cplcFdFdhhR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,Mhh(2),MSd(6),MSu(6),MFd2(3),MFu2(3),MGlu2,Mhh2(2),MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),            & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),             & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),               & 
& cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
    Do gt3=1,2
Amp(:,gt3) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = Mhh(gt3) 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = cplhhSdcSd(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, Su}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = cplhhSucSu(gt3,i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdhhL(i3,i2,gt3)
coup3R = cplcFdFdhhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Fu}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = cplcFuFuhhL(i3,i2,gt3)
coup3R = cplcFuFuhhR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3 = cplhhSdcSd(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fu], conj[Su], conj[Su]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(i1,i2)
coup1R = cplcFuGluSuR(i1,i2)
coup2L = cplGluFucSuL(i1,i3)
coup2R = cplGluFucSuR(i1,i3)
coup3 = cplhhSucSu(gt3,i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplcFdFdhhL(i2,i3,gt3)
coup3R = cplcFdFdhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Su], bar[Fu], bar[Fu]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,i1)
coup1R = cplGluFucSuR(i2,i1)
coup2L = cplcFuGluSuL(i3,i1)
coup2R = cplcFuGluSuR(i3,i1)
coup3L = cplcFuFuhhL(i2,i3,gt3)
coup3R = cplcFuFuhhR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
    End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluhh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluhh(MFd,MFu,MGlu,Mhh,MSd,            & 
& MSu,MFd2,MFu2,MGlu2,Mhh2,MSd2,MSu2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,              & 
& cplcFdFdhhR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplhhSdcSd,cplhhSucSu,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,Mhh(2),MSd(6),MSu(6),MFd2(3),MFu2(3),MGlu2,Mhh2(2),MSd2(6),MSu2(6)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),            & 
& cplGluFucSuL(3,6),cplGluFucSuR(3,6),cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),             & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),               & 
& cplhhSdcSd(2,6,6),cplhhSucSu(2,6,6)

Complex(dp), Intent(out) :: Amp(2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
    Do gt3=1,2
Amp(:,gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = Mhh(gt3) 
    End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluhh


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluSv(MGlu,MGlu2,MSv,MSv2,ZffG,ZfSv,Amp)

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

    Do gt3=1,3
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
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
Amp(:,gt3) = 3*AmpC 
    End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluSv(MFd,MGlu,MSd,MSv,MFd2,              & 
& MGlu2,MSd2,MSv2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,cplcFdFdSvR,cplcFdGluSdL,        & 
& cplcFdGluSdR,cplSdSvcSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MSv(3),MFd2(3),MGlu2,MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),            & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplSdSvcSd(6,3,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
    Do gt3=1,3
Amp(:,gt3) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MSv(gt3) 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = cplSdSvcSd(i2,gt3,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = cplcFdFdSvL(i3,i2,gt3)
coup3R = cplcFdFdSvR(i3,i2,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3 = cplSdSvcSd(i3,gt3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplcFdFdSvL(i2,i3,gt3)
coup3R = cplcFdFdSvR(i2,i3,gt3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFS_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt3) = Amp(:,gt3) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
    End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluSv(MFd,MGlu,MSd,MSv,MFd2,           & 
& MGlu2,MSd2,MSv2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdSvL,cplcFdFdSvR,cplcFdGluSdL,        & 
& cplcFdGluSdR,cplSdSvcSd,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MGlu,MSd(6),MSv(3),MFd2(3),MGlu2,MSd2(6),MSv2(3)

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),            & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplSdSvcSd(6,3,6)

Complex(dp), Intent(out) :: Amp(2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
    Do gt3=1,3
Amp(:,gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MSv(gt3) 
    End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluSv


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluVG(cplGluGluVGL,cplGluGluVGR,            & 
& ctcplGluGluVGL,ctcplGluGluVGR,MGlu,MGlu2,MVG,MVG2,ZffG,ZfVG,Amp)

Implicit None

Real(dp), Intent(in) :: MGlu,MGlu2,MVG,MVG2

Complex(dp), Intent(in) :: cplGluGluVGL,cplGluGluVGR

Complex(dp), Intent(in) :: ctcplGluGluVGL,ctcplGluGluVGR

Complex(dp), Intent(in) :: ZffG,ZfVG

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVG 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplGluGluVGL 
ZcoupT1R = ctcplGluGluVGR
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZffG)*cplGluGluVGL
ZcoupT1R = ZcoupT1R + 0.5_dp*ZffG*cplGluGluVGR


! External Field 2 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZffG*cplGluGluVGL
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZffG)*cplGluGluVGR


! External Field 3 
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfVG*cplGluGluVGL
ZcoupT1R = ZcoupT1R + 0.5_dp*ZfVG*cplGluGluVGR


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:) = -3*AmpC 
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluVG


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluVG(MFd,MFu,MGlu,MSd,MSu,               & 
& MVG,MFd2,MFu2,MGlu2,MSd2,MSu2,MVG2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,           & 
& cplSucSuVG,cplVGVGVG,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVG,MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6),MVG2

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR,         & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),               & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Amp(:) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVG 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = -cplSdcSdVG(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, Su}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVG(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {Glu, VG, VG}
ML1 = MGlu 
ML2 = MVG 
ML3 = MVG 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3 = cplVGVGVG
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-9._dp/2._dp)*AmpC 


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = -cplcFdFdVGR(i3,i2)
coup3R = -cplcFdFdVGL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Fu}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = -cplcFuFuVGR(i3,i2)
coup3R = -cplcFuFuVGL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {VG, Glu, Glu}
ML1 = MVG 
ML2 = MGlu 
ML3 = MGlu 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplGluGluVGL
coup3R = cplGluGluVGR
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-9._dp/2._dp)*AmpC 


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3 = cplSdcSdVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {bar[Fu], conj[Su], conj[Su]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(i1,i2)
coup1R = cplcFuGluSuR(i1,i2)
coup2L = cplGluFucSuL(i1,i3)
coup2R = cplGluFucSuR(i1,i3)
coup3 = cplSucSuVG(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplcFdFdVGL(i2,i3)
coup3R = cplcFdFdVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do


! {conj[Su], bar[Fu], bar[Fu]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,i1)
coup1R = cplGluFucSuR(i2,i1)
coup2L = cplcFuGluSuL(i3,i1)
coup2R = cplcFuGluSuR(i3,i1)
coup3L = cplcFuFuVGL(i2,i3)
coup3R = cplcFuFuVGR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(3._dp/4._dp*(0.,1._dp))*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluVG


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluVG(MFd,MFu,MGlu,MSd,MSu,            & 
& MVG,MFd2,MFu2,MGlu2,MSd2,MSu2,MVG2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVGL,              & 
& cplcFdFdVGR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,            & 
& cplGluGluVGR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVG,           & 
& cplSucSuVG,cplVGVGVG,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVG,MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6),MVG2

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR,         & 
& cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),               & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Amp(:) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVG 


! {Glu, VG, VG}
ML1 = MGlu 
ML2 = MVG 
ML3 = MVG 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3 = cplVGVGVG
Call Amp_VERTEX_FtoFV_Topology1_FVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-9._dp/2._dp)*AmpC 


! {VG, Glu, Glu}
ML1 = MVG 
ML2 = MGlu 
ML3 = MGlu 
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
coup3L = cplGluGluVGL
coup3R = cplGluGluVGR
Call Amp_VERTEX_FtoFV_Topology1_VFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(-9._dp/2._dp)*AmpC 

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluVG


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluVP(MGlu,MGlu2,MVP,MVP2,ZffG,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MGlu,MGlu2,MVP,MVP2

Complex(dp), Intent(in) :: ZffG,ZfVP

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVP 
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


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:) = -3*AmpC 
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluVP(MFd,MFu,MGlu,MSd,MSu,               & 
& MVP,MFd2,MFu2,MGlu2,MSd2,MSu2,MVP2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,              & 
& cplcFdFdVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVPL,cplcFuFuVPR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVP,cplSucSuVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVP,MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6),MVP2

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),& 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplSdcSdVP(6,6),cplSucSuVP(6,6)

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Amp(:) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVP 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = -cplSdcSdVP(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, Su}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVP(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = -cplcFdFdVPR(i3,i2)
coup3R = -cplcFdFdVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Fu}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = -cplcFuFuVPR(i3,i2)
coup3R = -cplcFuFuVPL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3 = cplSdcSdVP(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fu], conj[Su], conj[Su]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(i1,i2)
coup1R = cplcFuGluSuR(i1,i2)
coup2L = cplGluFucSuL(i1,i3)
coup2R = cplGluFucSuR(i1,i3)
coup3 = cplSucSuVP(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplcFdFdVPL(i2,i3)
coup3R = cplcFdFdVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Su], bar[Fu], bar[Fu]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,i1)
coup1R = cplGluFucSuR(i2,i1)
coup2L = cplcFuGluSuL(i3,i1)
coup2R = cplcFuGluSuR(i3,i1)
coup3L = cplcFuFuVPL(i2,i3)
coup3R = cplcFuFuVPR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluVP(MFd,MFu,MGlu,MSd,MSu,            & 
& MVP,MFd2,MFu2,MGlu2,MSd2,MSu2,MVP2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVPL,              & 
& cplcFdFdVPR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVPL,cplcFuFuVPR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVP,cplSucSuVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVP,MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6),MVP2

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),& 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplSdcSdVP(6,6),cplSucSuVP(6,6)

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Amp(:) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVP 

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluVP


Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluVZ(MGlu,MGlu2,MVZ,MVZ2,ZffG,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MGlu,MGlu2,MVZ,MVZ2

Complex(dp), Intent(in) :: ZffG,ZfVZ

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVZ 
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


! Getting the amplitude 
Call TreeAmp_FtoFV(Mex1,Mex2,Mex3,ZcoupT1R,ZcoupT1L,AmpC) 
! Colour and symmetry factor 
Amp(:) = -3*AmpC 
End Subroutine Amplitude_WAVE_MSSMTriLnV_GluToGluVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluVZ(MFd,MFu,MGlu,MSd,MSu,               & 
& MVZ,MFd2,MFu2,MGlu2,MSd2,MSu2,MVZ2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,              & 
& cplcFdFdVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVZ,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVZ,MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6),MVZ2

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),& 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplSdcSdVZ(6,6),cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Amp(:) = 0._dp 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVZ 


! {Fd, Sd, Sd}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplGluFdcSdL(i1,i2)
coup1R = cplGluFdcSdR(i1,i2)
coup2L = cplcFdGluSdL(i1,i3)
coup2R = cplcFdGluSdR(i1,i3)
coup3 = -cplSdcSdVZ(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Fu, Su, Su}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplGluFucSuL(i1,i2)
coup1R = cplGluFucSuR(i1,i2)
coup2L = cplcFuGluSuL(i1,i3)
coup2R = cplcFuGluSuR(i1,i3)
coup3 = -cplSucSuVZ(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Sd, Fd, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFdGluSdL(i2,i1)
coup1R = cplcFdGluSdR(i2,i1)
coup2L = cplGluFdcSdL(i3,i1)
coup2R = cplGluFdcSdR(i3,i1)
coup3L = -cplcFdFdVZR(i3,i2)
coup3R = -cplcFdFdVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {Su, Fu, Fu}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuGluSuL(i2,i1)
coup1R = cplcFuGluSuR(i2,i1)
coup2L = cplGluFucSuL(i3,i1)
coup2R = cplGluFucSuR(i3,i1)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fd], conj[Sd], conj[Sd]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFdGluSdL(i1,i2)
coup1R = cplcFdGluSdR(i1,i2)
coup2L = cplGluFdcSdL(i1,i3)
coup2R = cplGluFdcSdR(i1,i3)
coup3 = cplSdcSdVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {bar[Fu], conj[Su], conj[Su]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuGluSuL(i1,i2)
coup1R = cplcFuGluSuR(i1,i2)
coup2L = cplGluFucSuL(i1,i3)
coup2R = cplGluFucSuR(i1,i3)
coup3 = cplSucSuVZ(i3,i2)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_FSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Sd], bar[Fd], bar[Fd]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplGluFdcSdL(i2,i1)
coup1R = cplGluFdcSdR(i2,i1)
coup2L = cplcFdGluSdL(i3,i1)
coup2R = cplcFdGluSdR(i3,i1)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do


! {conj[Su], bar[Fu], bar[Fu]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplGluFucSuL(i2,i1)
coup1R = cplGluFucSuR(i2,i1)
coup2L = cplcFuGluSuL(i3,i1)
coup2R = cplcFuGluSuR(i3,i1)
coup3L = cplcFuFuVZL(i2,i3)
coup3R = cplcFuFuVZR(i2,i3)
If ((Abs(coup1L)+Abs(coup1R))*(Abs(coup2L)+Abs(coup2R))*(Abs(coup3L)+Abs(coup3R)).gt.epsCoup) Then 
Call Amp_VERTEX_FtoFV_Topology1_SFF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:) = Amp(:) + oo16pi2*(1._dp/2._dp)*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_GluToGluVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluVZ(MFd,MFu,MGlu,MSd,MSu,            & 
& MVZ,MFd2,MFu2,MGlu2,MSd2,MSu2,MVZ2,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdVZL,              & 
& cplcFdFdVZR,cplGluFucSuL,cplGluFucSuR,cplcFuFuVZL,cplcFuFuVZR,cplcFdGluSdL,            & 
& cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplSdcSdVZ,cplSucSuVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MGlu,MSd(6),MSu(6),MVZ,MFd2(3),MFu2(3),MGlu2,MSd2(6),MSu2(6),MVZ2

Complex(dp), Intent(in) :: cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplGluFucSuL(3,6),& 
& cplGluFucSuR(3,6),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),& 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplSdcSdVZ(6,6),cplSucSuVZ(6,6)

Complex(dp), Intent(out) :: Amp(4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(4) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Amp(:) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MGlu 
Mex2 = MGlu 
Mex3 = MVZ 

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_GluToGluVZ



End Module OneLoopDecay_Glu_MSSMTriLnV
