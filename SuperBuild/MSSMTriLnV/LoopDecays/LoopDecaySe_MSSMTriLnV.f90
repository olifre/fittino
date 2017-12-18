! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 11:54 on 24.4.2017   
! ----------------------------------------------------------------------  
 
 
Module OneLoopDecay_Se_MSSMTriLnV
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

Subroutine Amplitude_Tree_MSSMTriLnV_SeToSeAh(cplAhSecSe,MAh,MSe,MAh2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MSe(6),MAh2(2),MSe2(6)

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MAh(gt3) 
! Tree-Level Vertex 
coupT1 = cplAhSecSe(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToSeAh


Subroutine Gamma_Real_MSSMTriLnV_SeToSeAh(MLambda,em,gs,cplAhSecSe,MAh,               & 
& MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6)

Real(dp), Intent(in) :: MAh(2),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=2,2
Coup = cplAhSecSe(i3,i2,i1)
Mex1 = MSe(i1)
Mex2 = MSe(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToSeAh


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSeAh(cplAhSecSe,ctcplAhSecSe,MAh,            & 
& MAh2,MSe,MSe2,ZfAh,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6)

Complex(dp), Intent(in) :: ctcplAhSecSe(2,6,6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSe(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MAh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplAhSecSe(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplAhSecSe(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt2)*cplAhSecSe(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfAh(i1,gt3)*cplAhSecSe(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSeAh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSeAh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplcChaChaAhL,cplcChaChaAhR,       & 
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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MAh(gt3) 


! {Ah, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSecSe(i1,gt2,i3)
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


! {Chi, bar[Fe], bar[Fe]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplcFeChiSeL(i3,i1,gt2)
coup2R = cplcFeChiSeR(i3,i1,gt2)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,i3,gt2)
coup2R = cplcFdFuSeR(i1,i3,gt2)
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


! {Fe, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,i3,gt2)
coup2R = cplcFeChiSeR(i1,i3,gt2)
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


! {Fv, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplcChaFvSeL(i3,i1,gt2)
coup2R = cplcChaFvSeR(i3,i1,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
coup2L = cplcFeFvSeL(i3,i1,gt2)
coup2R = cplcFeFvSeR(i3,i1,gt2)
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


! {hh, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSecSe(i1,gt2,i3)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplSeSucSd(gt2,i3,i1)
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


! {Se, hh, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplAhSecSe(i3,gt2,i1)
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


! {Se, Ah, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
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


! {Se, VZ, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
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


! {Se, hh, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = -cplSecSeVZ(gt2,i1)
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


! {Sv, conj[Hpm], conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[VWm], conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2 = cplSecSecSv(gt2,i3,i1)
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


! {Sv, conj[Hpm], conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = -cplSecSvcVWm(gt2,i1)
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


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = -cplSecSeVP(gt2,i3)
coup3 = cplAhSecSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {VZ, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = -cplSecSeVZ(gt2,i3)
coup3 = cplAhSecSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplcFdFuSeL(i3,i1,gt2)
coup2R = cplcFdFuSeR(i3,i1,gt2)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2 = cplSeSucSd(gt2,i1,i3)
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
coup1 = cplSecSecSv(i2,gt1,i1)
coup2 = cplSeSvcSe(gt2,i1,i3)
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


! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhAhSecSe1(gt3,i1,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplAhSecHpmcSv1(gt3,gt2,i1,i2)
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
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplAhSeSucSdaa(gt3,gt2,i2,i1)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplAhSeSvcSe1(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplAhSecSecSv1(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhAhSecSe1(gt3,i1,i2,gt1)
coup2 = cplAhSecSe(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplAhHpmSvcSe1(gt3,i1,i2,gt1)
coup2 = cplSecHpmcSv(gt2,i1,i2)
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
coup1 = cplAhSdcSecSuaa(gt3,i1,gt1,i2)
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
coup1 = cplAhSecSecSv1(gt3,i1,gt1,i2)
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


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplAhSeSvcSe1(gt3,i1,i2,gt1)
coup2 = cplSecSecSv(gt2,i1,i2)
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
coup1 = cplHpmSecHpmcSe1(i1,gt2,i2,gt1)
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
coup1 = cplSdSecSdcSeaa(i1,gt2,i2,gt1)
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
coup1 = cplSeSecSecSe1(gt2,i1,gt1,i2)
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
coup1 = cplSeSucSecSuaa(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSeAh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh(MAh,MCha,MChi,MFd,MFe,             & 
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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MAh(gt3) 


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = -cplSecSeVP(gt2,i3)
coup3 = cplAhSecSe(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeAh


Subroutine Amplitude_Tree_MSSMTriLnV_SeToFvCha(cplFvChacSeL,cplFvChacSeR,             & 
& MCha,MSe,MCha2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MSe(6),MCha2(2),MSe2(6)

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

Complex(dp) :: Amp(2,6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MCha(gt3) 
! Tree-Level Vertex 
coupT1L = cplFvChacSeL(gt2,gt3,gt1)
coupT1R = cplFvChacSeR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToFvCha


Subroutine Gamma_Real_MSSMTriLnV_SeToFvCha(MLambda,em,gs,cplFvChacSeL,cplFvChacSeR,   & 
& MCha,MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

Real(dp), Intent(in) :: MCha(2),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,2), GammarealGluon(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
CoupL = cplFvChacSeL(i2,i3,i1)
CoupR = cplFvChacSeR(i2,i3,i1)
Mex1 = MSe(i1)
Mex2 = 0.
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToFvCha


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToFvCha(cplFvChacSeL,cplFvChacSeR,             & 
& ctcplFvChacSeL,ctcplFvChacSeR,MCha,MCha2,MSe,MSe2,ZfFvL,ZfLm,ZfLp,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6)

Complex(dp), Intent(in) :: ctcplFvChacSeL(3,2,6),ctcplFvChacSeR(3,2,6)

Complex(dp), Intent(in) :: ZfFvL(3,3),ZfLm(2,2),ZfLp(2,2),ZfSe(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MCha(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplFvChacSeL(gt2,gt3,gt1) 
ZcoupT1R = ctcplFvChacSeR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplFvChacSeL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplFvChacSeR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFvL(i1,gt2)*cplFvChacSeL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFvL(i1,gt2))*cplFvChacSeR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfLm(i1,gt3)*cplFvChacSeL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfLp(i1,gt3))*cplFvChacSeR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToFvCha


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToFvCha(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,            & 
& cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,   & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplAhSecSe(2,6,6),cplChiChacHpmL(4,2,2),    & 
& cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),     & 
& cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),      & 
& cplcChaChahhR(2,2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),      & 
& cplcFeChaSvR(3,2,3),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),          & 
& cplcChaChaVZR(2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),        & 
& cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcFuFdcSeL(3,3,6),         & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFvVZL(3,3),             & 
& cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),            & 
& cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplhhSecSe(2,6,6),              & 
& cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),& 
& cplSvcSeVWm(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MCha(gt3) 


! {Cha, Fv, Se}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i1,gt2,i3)
coup2R = cplcChaFvSeR(i1,gt2,i3)
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


! {Chi, bar[Fe], conj[Sv]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,gt2,i3)
coup2R = cplChiFvcSvR(i1,gt2,i3)
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


! {Fd, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFvSdL(i1,gt2,i3)
coup2R = cplcFdFvSdR(i1,gt2,i3)
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


! {Fe, Chi, Hpm}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MHpm(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,gt2,i3)
coup2R = cplcFeFvHpmR(i1,gt2,i3)
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


! {Fe, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
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


! {Fe, Chi, VWm}
Do i1=1,3
  Do i2=1,4
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MVWm 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = -cplcFeFvVWmR(i1,gt2)
coup2R = -cplcFeFvVWmL(i1,gt2)
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


! {Fv, bar[Cha], VZ}
Do i1=1,3
  Do i2=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MVZ 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplFvFvVZL(gt2,i1)
coup2R = cplFvFvVZR(gt2,i1)
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


! {Sd, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2L = cplFvFdcSdL(gt2,i3,i1)
coup2R = cplFvFdcSdR(gt2,i3,i1)
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


! {Se, Ah, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MCha(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
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


! {Se, hh, Cha}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MCha(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
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


! {Se, VP, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = -cplSecSeVP(i1,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
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


! {Se, VZ, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MCha(i3) 
coup1 = -cplSecSeVZ(i1,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
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


! {Se, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
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


! {Sv, conj[Hpm], Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MChi(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2L = cplChiFvcSvL(i3,gt2,i1)
coup2R = cplChiFvcSvR(i3,gt2,i1)
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


! {Sv, conj[VWm], Chi}
Do i1=1,3
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MChi(i3) 
coup1 = -cplSvcSeVWm(i1,gt1)
coup2L = cplChiFvcSvL(i3,gt2,i1)
coup2R = cplChiFvcSvR(i3,gt2,i1)
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


! {VZ, conj[Se], Fv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = -cplSecSeVZ(i2,gt1)
coup2L = cplFvFvVZL(gt2,i3)
coup2R = cplFvFvVZR(gt2,i3)
coup3L = cplFvChacSeL(i3,gt3,i2)
coup3R = cplFvChacSeR(i3,gt3,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToFvCha


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcChaChaAhL,cplcChaChaAhR,            & 
& cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,cplChiChacVWmR,cplChaFucSdL,   & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplcFdChaSuL,       & 
& cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplcChaChaVPL,cplcChaChaVPR,cplcChaChaVZL,      & 
& cplcChaChaVZR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,         & 
& cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,             & 
& cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,             & 
& cplHpmSvcSe,cplSdcSecSu,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcChaChaAhL(2,2,2),cplcChaChaAhR(2,2,2),cplAhSecSe(2,6,6),cplChiChacHpmL(4,2,2),    & 
& cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),cplChiChacVWmR(4,2),cplChaFucSdL(2,3,6),     & 
& cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChahhL(2,2,2),      & 
& cplcChaChahhR(2,2,2),cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),      & 
& cplcFeChaSvR(3,2,3),cplcChaChaVPL(2,2),cplcChaChaVPR(2,2),cplcChaChaVZL(2,2),          & 
& cplcChaChaVZR(2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),        & 
& cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplcFuFdcSeL(3,3,6),         & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFvVZL(3,3),             & 
& cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFdFvSdL(3,3,6),            & 
& cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplhhSecSe(2,6,6),              & 
& cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),& 
& cplSvcSeVWm(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MCha(gt3) 


! {Se, VP, Cha}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MCha(i3) 
coup1 = -cplSecSeVP(i1,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
coup3L = cplcChaChaVPL(i3,gt3)
coup3R = cplcChaChaVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvCha


Subroutine Amplitude_Tree_MSSMTriLnV_SeToFeChi(cplChiFecSeL,cplChiFecSeR,             & 
& MChi,MFe,MSe,MChi2,MFe2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MFe(3),MSe(6),MChi2(4),MFe2(3),MSe2(6)

Complex(dp), Intent(in) :: cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

Complex(dp) :: Amp(2,6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,4
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MChi(gt3) 
! Tree-Level Vertex 
coupT1L = cplChiFecSeL(gt3,gt2,gt1)
coupT1R = cplChiFecSeR(gt3,gt2,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToFeChi


Subroutine Gamma_Real_MSSMTriLnV_SeToFeChi(MLambda,em,gs,cplChiFecSeL,cplChiFecSeR,   & 
& MChi,MFe,MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

Real(dp), Intent(in) :: MChi(4),MFe(3),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,4), GammarealGluon(6,3,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,4
CoupL = cplChiFecSeL(i3,i2,i1)
CoupR = cplChiFecSeR(i3,i2,i1)
Mex1 = MSe(i1)
Mex2 = MFe(i2)
Mex3 = MChi(i3)
If (Mex1.gt.(Mex2+Mex3)) Then 
 Call hardradiationSFF(Mex1,Mex2,Mex3,MLambda,em,1._dp,1._dp,0._dp,1._dp,0._dp,0._dp,CoupL,CoupR,Gammarealphoton(i1,i2,i3),kont)
  GammarealGluon(i1,i2,i3) = 0._dp 
Else 
  GammarealGluon(i1,i2,i3) = 0._dp 
  GammarealPhoton(i1,i2,i3) = 0._dp 

End if 
    End Do
  End Do
End Do
End Subroutine Gamma_Real_MSSMTriLnV_SeToFeChi


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToFeChi(cplChiFecSeL,cplChiFecSeR,             & 
& ctcplChiFecSeL,ctcplChiFecSeR,MChi,MChi2,MFe,MFe2,MSe,MSe2,ZfFEL,ZfFER,ZfL0,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MChi(4),MChi2(4),MFe(3),MFe2(3),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6)

Complex(dp), Intent(in) :: ctcplChiFecSeL(4,3,6),ctcplChiFecSeR(4,3,6)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfL0(4,4),ZfSe(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MChi(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplChiFecSeL(gt3,gt2,gt1) 
ZcoupT1R = ctcplChiFecSeR(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplChiFecSeL(gt3,gt2,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplChiFecSeR(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt2)*cplChiFecSeL(gt3,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt2))*cplChiFecSeR(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,4
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfL0(i1,gt3)*cplChiFecSeL(i1,gt2,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfL0(i1,gt3))*cplChiFecSeR(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToFeChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToFeChi(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,              & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,      & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),        & 
& cplAhSecSe(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvFecHpmL(3,3,2),         & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),            & 
& cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),             & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),               & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplhhSecSe(2,6,6),        & 
& cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),               & 
& cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSvcSeVWm(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MChi(gt3) 


! {Ah, conj[Se], bar[Fe]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2L = cplcFeFeAhL(i3,gt2,i1)
coup2R = cplcFeFeAhR(i3,gt2,i1)
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


! {Cha, Fv, conj[Sv]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFecSvL(i1,gt2,i3)
coup2R = cplcChaFecSvR(i1,gt2,i3)
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


! {Chi, bar[Fe], conj[Se]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFecSeL(i1,gt2,i3)
coup2R = cplChiFecSeR(i1,gt2,i3)
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


! {Fd, Fu, Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFeSuL(i1,gt2,i3)
coup2R = cplcFdFeSuR(i1,gt2,i3)
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


! {Fe, Chi, Ah}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MAh(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,gt2,i3)
coup2R = cplcFeFeAhR(i1,gt2,i3)
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


! {Fe, Chi, hh}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = Mhh(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,gt2,i3)
coup2R = cplcFeFehhR(i1,gt2,i3)
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


! {Fe, Fv, Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,gt2,i3)
coup2R = cplcFeFeSvR(i1,gt2,i3)
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


! {Fe, Chi, VZ}
Do i1=1,3
  Do i2=1,4
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MVZ 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = -cplcFeFeVZR(i1,gt2)
coup2R = -cplcFeFeVZL(i1,gt2)
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


! {Fe, Fv, conj[Sv]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFecSvL(i1,gt2,i3)
coup2R = cplcFeFecSvR(i1,gt2,i3)
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


! {Fv, bar[Cha], conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MHpm(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplFvFecHpmL(i1,gt2,i3)
coup2R = cplFvFecHpmR(i1,gt2,i3)
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


! {Fv, bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
coup2L = cplFvFecSeL(i1,gt2,i3)
coup2R = cplFvFecSeR(i1,gt2,i3)
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


! {Fv, bar[Cha], conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MVWm 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = -cplFvFecVWmR(i1,gt2)
coup2R = -cplFvFecVWmL(i1,gt2)
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


! {hh, conj[Se], bar[Fe]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2L = cplcFeFehhL(i3,gt2,i1)
coup2R = cplcFeFehhR(i3,gt2,i1)
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


! {Hpm, conj[Sv], Fv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2L = cplFvFecHpmL(i3,gt2,i1)
coup2R = cplFvFecHpmR(i3,gt2,i1)
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


! {Sd, Su, Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2L = cplFeFucSdL(gt2,i3,i1)
coup2R = cplFeFucSdR(gt2,i3,i1)
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


! {Se, Ah, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MChi(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2L = cplChiFecSeL(i3,gt2,i1)
coup2R = cplChiFecSeR(i3,gt2,i1)
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


! {Se, hh, Chi}
Do i1=1,6
  Do i2=1,2
    Do i3=1,4
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MChi(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2L = cplChiFecSeL(i3,gt2,i1)
coup2R = cplChiFecSeR(i3,gt2,i1)
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


! {Se, VZ, Chi}
Do i1=1,6
    Do i3=1,4
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MChi(i3) 
coup1 = -cplSecSeVZ(i1,gt1)
coup2L = cplChiFecSeL(i3,gt2,i1)
coup2R = cplChiFecSeR(i3,gt2,i1)
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


! {Se, Sv, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2L = cplFvFecSeL(i3,gt2,i1)
coup2R = cplFvFecSeR(i3,gt2,i1)
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


! {Se, conj[Sv], Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2L = cplFvFecSeL(i3,gt2,i1)
coup2R = cplFvFecSeR(i3,gt2,i1)
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


! {Sv, conj[Hpm], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MCha(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2L = cplcChaFecSvL(i3,gt2,i1)
coup2R = cplcChaFecSvR(i3,gt2,i1)
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


! {Sv, conj[VWm], bar[Cha]}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MCha(i3) 
coup1 = -cplSvcSeVWm(i1,gt1)
coup2L = cplcChaFecSvL(i3,gt2,i1)
coup2R = cplcChaFecSvR(i3,gt2,i1)
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


! {Sv, conj[Se], bar[Fe]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2L = cplcFeFecSvL(i3,gt2,i1)
coup2R = cplcFeFecSvR(i3,gt2,i1)
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


! {VP, conj[Se], bar[Fe]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = -cplSecSeVP(i2,gt1)
coup2L = -cplcFeFeVPR(i3,gt2)
coup2R = -cplcFeFeVPL(i3,gt2)
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


! {VWm, conj[Sv], Fv}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = -cplSvcSeVWm(i2,gt1)
coup2L = -cplFvFecVWmR(i3,gt2)
coup2R = -cplFvFecVWmL(i3,gt2)
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


! {VZ, conj[Se], bar[Fe]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = -cplSecSeVZ(i2,gt1)
coup2L = -cplcFeFeVZR(i3,gt2)
coup2R = -cplcFeFeVZL(i3,gt2)
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


! {bar[Fu], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplFeFucSdL(gt2,i1,i3)
coup2R = cplFeFucSdR(gt2,i1,i3)
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


! {conj[Su], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2L = cplcFdFeSuL(i3,gt2,i1)
coup2R = cplcFdFeSuR(i3,gt2,i1)
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


! {conj[Sv], conj[Se], bar[Fe]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i2,gt1,i1)
coup2L = cplcFeFeSvL(i3,gt2,i1)
coup2R = cplcFeFeSvR(i3,gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToFeChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplChiChiAhL,cplChiChiAhR,              & 
& cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,cplChiChacHpmL,cplChiChacHpmR,cplChiChacVWmL,       & 
& cplChiChacVWmR,cplFvChacSeL,cplFvChacSeR,cplChiChihhL,cplChiChihhR,cplChiChiVZL,       & 
& cplChiChiVZR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcChaChiHpmL,         & 
& cplcChaChiHpmR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,       & 
& cplcFuChiSuR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,      & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplFvFecVWmL,            & 
& cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,              & 
& cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplhhSecSe,cplHpmSvcSe,cplSdcSecSu,            & 
& cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplChiChiAhL(4,4,2),cplChiChiAhR(4,4,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),        & 
& cplAhSecSe(2,6,6),cplChiChacHpmL(4,2,2),cplChiChacHpmR(4,2,2),cplChiChacVWmL(4,2),     & 
& cplChiChacVWmR(4,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiChihhL(4,4,2),       & 
& cplChiChihhR(4,4,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),cplChiFdcSdL(4,3,6),           & 
& cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFucSuL(4,3,6),       & 
& cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),         & 
& cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),cplcFdChiSdL(3,4,6),   & 
& cplcFdChiSdR(3,4,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),       & 
& cplcFuChiSuR(3,4,6),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvFecHpmL(3,3,2),         & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),            & 
& cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),             & 
& cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcChaFecSvL(2,3,3),               & 
& cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplhhSecSe(2,6,6),        & 
& cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),               & 
& cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSvcSeVWm(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = MFe(gt2) 
Mex3 = MChi(gt3) 


! {VP, conj[Se], bar[Fe]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = -cplSecSeVP(i2,gt1)
coup2L = -cplcFeFeVPR(i3,gt2)
coup2R = -cplcFeFeVPL(i3,gt2)
coup3L = cplChiFecSeL(gt3,i3,i2)
coup3R = cplChiFecSeR(gt3,i3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToFeChi


Subroutine Amplitude_Tree_MSSMTriLnV_SeTocFuFd(cplcFuFdcSeL,cplcFuFdcSeR,             & 
& MFd,MFu,MSe,MFd2,MFu2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFu(3),MSe(6),MFd2(3),MFu2(3),MSe2(6)

Complex(dp), Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Complex(dp) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 
! Tree-Level Vertex 
coupT1L = cplcFuFdcSeL(gt2,gt3,gt1)
coupT1R = cplcFuFdcSeR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeTocFuFd


Subroutine Gamma_Real_MSSMTriLnV_SeTocFuFd(MLambda,em,gs,cplcFuFdcSeL,cplcFuFdcSeR,   & 
& MFd,MFu,MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Real(dp), Intent(in) :: MFd(3),MFu(3),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,3), GammarealGluon(6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
CoupL = cplcFuFdcSeL(i2,i3,i1)
CoupR = cplcFuFdcSeR(i2,i3,i1)
Mex1 = MSe(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeTocFuFd


Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocFuFd(cplcFuFdcSeL,cplcFuFdcSeR,             & 
& ctcplcFuFdcSeL,ctcplcFuFdcSeR,MFd,MFd2,MFu,MFu2,MSe,MSe2,ZfFDL,ZfFDR,ZfFUL,            & 
& ZfFUR,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFd2(3),MFu(3),MFu2(3),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6)

Complex(dp), Intent(in) :: ctcplcFuFdcSeL(3,3,6),ctcplcFuFdcSeR(3,3,6)

Complex(dp), Intent(in) :: ZfFDL(3,3),ZfFDR(3,3),ZfFUL(3,3),ZfFUR(3,3),ZfSe(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplcFuFdcSeL(gt2,gt3,gt1) 
ZcoupT1R = ctcplcFuFdcSeR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplcFuFdcSeL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplcFuFdcSeR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFUR(i1,gt2)*cplcFuFdcSeL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFUL(i1,gt2))*cplcFuFdcSeR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFDL(i1,gt3)*cplcFuFdcSeL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFDR(i1,gt3))*cplcFuFdcSeR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocFuFd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocFuFd(MAh,MCha,MChi,MFd,MFe,               & 
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
Mex1 = MSe(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 


! {Ah, conj[Se], Fu}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2L = cplcFuFuAhL(gt2,i3,i1)
coup2R = cplcFuFuAhR(gt2,i3,i1)
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


! {Cha, Fv, Sd}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MSd(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChacFuSdL(i1,gt2,i3)
coup2R = cplcChacFuSdR(i1,gt2,i3)
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


! {Chi, bar[Fe], Su}
Do i1=1,4
  Do i2=1,3
    Do i3=1,6
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MSu(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplcFuChiSuL(gt2,i1,i3)
coup2R = cplcFuChiSuR(gt2,i1,i3)
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


! {Fe, Chi, Sd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MSd(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFecFuSdL(i1,gt2,i3)
coup2R = cplcFecFuSdR(i1,gt2,i3)
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


! {Fe, Fv, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSd(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {hh, conj[Se], Fu}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2L = cplcFuFuhhL(gt2,i3,i1)
coup2R = cplcFuFuhhR(gt2,i3,i1)
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


! {Hpm, conj[Sv], Fd}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2L = cplcFuFdcHpmL(gt2,i3,i1)
coup2R = cplcFuFdcHpmR(gt2,i3,i1)
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


! {Se, Ah, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MFd(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
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


! {Se, hh, Fd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MFd(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
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


! {Se, Sv, Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {Se, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSecSeVP(i1,gt1)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
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


! {Se, VZ, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MFd(i3) 
coup1 = -cplSecSeVZ(i1,gt1)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
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


! {Se, conj[Sv], Fd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
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


! {VP, conj[Se], Fu}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = -cplSecSeVP(i2,gt1)
coup2L = cplcFuFuVPL(gt2,i3)
coup2R = cplcFuFuVPR(gt2,i3)
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


! {VWm, conj[Sv], Fd}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = MFd(i3) 
coup1 = -cplSvcSeVWm(i2,gt1)
coup2L = cplcFuFdcVWmL(gt2,i3)
coup2R = cplcFuFdcVWmR(gt2,i3)
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


! {VZ, conj[Se], Fu}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = -cplSecSeVZ(i2,gt1)
coup2L = cplcFuFuVZL(gt2,i3)
coup2R = cplcFuFuVZR(gt2,i3)
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


! {bar[Fu], bar[Fd], Ah}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MAh(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocFuFd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd(MAh,MCha,MChi,MFd,MFe,            & 
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
Mex1 = MSe(gt1) 
Mex2 = MFu(gt2) 
Mex3 = MFd(gt3) 


! {Se, VP, Fd}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MFd(i3) 
coup1 = -cplSecSeVP(i1,gt1)
coup2L = cplcFuFdcSeL(gt2,i3,i1)
coup2R = cplcFuFdcSeR(gt2,i3,i1)
coup3L = cplcFdFdVPL(i3,gt3)
coup3R = cplcFdFdVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {VP, conj[Se], Fu}
  Do i2=1,6
    Do i3=1,3
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MFu(i3) 
coup1 = -cplSecSeVP(i2,gt1)
coup2L = cplcFuFuVPL(gt2,i3)
coup2R = cplcFuFuVPR(gt2,i3)
coup3L = cplcFuFdcSeL(i3,gt3,i2)
coup3R = cplcFuFdcSeR(i3,gt3,i2)
Call Amp_VERTEX_StoFF_Topology1_VSF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {bar[Fu], bar[Fd], VG}
Do i1=1,3
  Do i2=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MVG 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocFuFd


Subroutine Amplitude_Tree_MSSMTriLnV_SeToFvFe(cplFvFecSeL,cplFvFecSeR,MFe,            & 
& MSe,MFe2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MSe(6),MFe2(3),MSe2(6)

Complex(dp), Intent(in) :: cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

Complex(dp) :: Amp(2,6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,3
! External masses 
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 
! Tree-Level Vertex 
coupT1L = cplFvFecSeL(gt2,gt3,gt1)
coupT1R = cplFvFecSeR(gt2,gt3,gt1)
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,coupT1L,coupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToFvFe


Subroutine Gamma_Real_MSSMTriLnV_SeToFvFe(MLambda,em,gs,cplFvFecSeL,cplFvFecSeR,      & 
& MFe,MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

Real(dp), Intent(in) :: MFe(3),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,3), GammarealGluon(6,3,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: CoupL, CoupR 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
CoupL = cplFvFecSeL(i2,i3,i1)
CoupR = cplFvFecSeR(i2,i3,i1)
Mex1 = MSe(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToFvFe


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToFvFe(cplFvFecSeL,cplFvFecSeR,ctcplFvFecSeL,  & 
& ctcplFvFecSeR,MFe,MFe2,MSe,MSe2,ZfFEL,ZfFER,ZfFvL,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MFe(3),MFe2(3),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6)

Complex(dp), Intent(in) :: ctcplFvFecSeL(3,3,6),ctcplFvFecSeR(3,3,6)

Complex(dp), Intent(in) :: ZfFEL(3,3),ZfFER(3,3),ZfFvL(3,3),ZfSe(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1L = ctcplFvFecSeL(gt2,gt3,gt1) 
ZcoupT1R = ctcplFvFecSeR(gt2,gt3,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1L = ZcoupT1L + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplFvFecSeL(gt2,gt3,i1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplFvFecSeR(gt2,gt3,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFvL(i1,gt2)*cplFvFecSeL(i1,gt3,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFvL(i1,gt2))*cplFvFecSeR(i1,gt3,gt1)
End Do


! External Field 3 
Do i1=1,3
ZcoupT1L = ZcoupT1L + 0.5_dp*ZfFEL(i1,gt3)*cplFvFecSeL(gt2,i1,gt1)
ZcoupT1R = ZcoupT1R + 0.5_dp*Conjg(ZfFER(i1,gt3))*cplFvFecSeR(gt2,i1,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoFF(Mex1,Mex2,Mex3,ZcoupT1L,ZcoupT1R,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToFvFe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToFvFe(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,          & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,              & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),          & 
& cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),         & 
& cplFvFdcSdR(3,3,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),         & 
& cplFeFucSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),             & 
& cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),           & 
& cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),             & 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSvcSeVWm(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 


! {Cha, Fv, Se}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i1,gt2,i3)
coup2R = cplcChaFvSeR(i1,gt2,i3)
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


! {Chi, bar[Fe], Sv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,gt2,i3)
coup2R = cplChiFvSvR(i1,gt2,i3)
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


! {Chi, bar[Fe], conj[Sv]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MSv(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,gt2,i3)
coup2R = cplChiFvcSvR(i1,gt2,i3)
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


! {Fd, Fu, Sd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Fe, Chi, Se}
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MSe(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFvSeL(i1,gt2,i3)
coup2R = cplcFeFvSeR(i1,gt2,i3)
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


! {Fe, Fv, Se}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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


! {Hpm, conj[Sv], Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2L = cplFvFecHpmL(gt2,i3,i1)
coup2R = cplFvFecHpmR(gt2,i3,i1)
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


! {Sd, Su, Fd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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


! {Se, conj[Sv], Cha}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MCha(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2L = cplFvChacSeL(gt2,i3,i1)
coup2R = cplFvChacSeR(gt2,i3,i1)
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


! {Se, Ah, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MFe(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
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


! {Se, hh, Fe}
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MFe(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
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


! {Se, Sv, Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {Se, VP, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = -cplSecSeVP(i1,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
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


! {Se, VZ, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MFe(i3) 
coup1 = -cplSecSeVZ(i1,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
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


! {Se, conj[Sv], Fe}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
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


! {Sv, conj[Se], Chi}
Do i1=1,3
  Do i2=1,6
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2L = cplChiFvcSvL(i3,gt2,i1)
coup2R = cplChiFvcSvR(i3,gt2,i1)
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


! {VWm, conj[Sv], Fe}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = MFe(i3) 
coup1 = -cplSvcSeVWm(i2,gt1)
coup2L = cplFvFecVWmL(gt2,i3)
coup2R = cplFvFecVWmR(gt2,i3)
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


! {VZ, conj[Se], Fv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = 0. 
coup1 = -cplSecSeVZ(i2,gt1)
coup2L = cplFvFvVZL(gt2,i3)
coup2R = cplFvFvVZR(gt2,i3)
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


! {conj[Sv], conj[Se], Chi}
Do i1=1,3
  Do i2=1,6
    Do i3=1,4
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MChi(i3) 
coup1 = cplSecSecSv(i2,gt1,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToFvFe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplcFeFeAhL,cplcFeFeAhR,cplAhSecSe,     & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,           & 
& cplChiFvcSvL,cplChiFvcSvR,cplFvFdcSdL,cplFvFdcSdR,cplcFuFdcSeL,cplcFuFdcSeR,           & 
& cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,             & 
& cplFvFecVWmL,cplFvFecVWmR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFeFeVPL,cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,               & 
& cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplFvFvVZL,cplFvFvVZR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,           & 
& cplcFeFvSeL,cplcFeFvSeR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplHpmSvcSe,              & 
& cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),          & 
& cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplFvFdcSdL(3,3,6),         & 
& cplFvFdcSdR(3,3,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),         & 
& cplFeFucSdR(3,3,6),cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),         & 
& cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),cplFvFecVWmR(3,3),cplcFeFehhL(3,3,2),             & 
& cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),cplcFeFeSvL(3,3,3),           & 
& cplcFeFeSvR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),& 
& cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),     & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),             & 
& cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),             & 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSvcSeVWm(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = 0. 
Mex3 = MFe(gt3) 


! {Se, VP, Fe}
Do i1=1,6
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MFe(i3) 
coup1 = -cplSecSeVP(i1,gt1)
coup2L = cplFvFecSeL(gt2,i3,i1)
coup2R = cplFvFecSeR(gt2,i3,i1)
coup3L = cplcFeFeVPL(i3,gt3)
coup3R = cplcFeFeVPR(i3,gt3)
Call Amp_VERTEX_StoFF_Topology1_SVF(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2L,coup2R,coup3L,coup3R,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2, gt3) = Amp(:,gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToFvFe


Subroutine Amplitude_Tree_MSSMTriLnV_SeToSehh(cplhhSecSe,Mhh,MSe,Mhh2,MSe2,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),MSe(6),Mhh2(2),MSe2(6)

Complex(dp), Intent(in) :: cplhhSecSe(2,6,6)

Complex(dp) :: Amp(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = Mhh(gt3) 
! Tree-Level Vertex 
coupT1 = cplhhSecSe(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToSehh


Subroutine Gamma_Real_MSSMTriLnV_SeToSehh(MLambda,em,gs,cplhhSecSe,Mhh,               & 
& MSe,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplhhSecSe(2,6,6)

Real(dp), Intent(in) :: Mhh(2),MSe(6)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6,2), GammarealGluon(6,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
    Do i3=1,2
Coup = cplhhSecSe(i3,i2,i1)
Mex1 = MSe(i1)
Mex2 = MSe(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToSehh


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSehh(cplhhSecSe,ctcplhhSecSe,Mhh,            & 
& Mhh2,MSe,MSe2,Zfhh,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: cplhhSecSe(2,6,6)

Complex(dp), Intent(in) :: ctcplhhSecSe(2,6,6)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSe(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = Mhh(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplhhSecSe(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplhhSecSe(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt2)*cplhhSecSe(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*Zfhh(i1,gt3)*cplhhSecSe(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSehh


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSehh(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhSecSe,              & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,     & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa, & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),& 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),     & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),           & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),  & 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),& 
& cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplAhAhSecSe1(2,2,6,6),cplhhhhSecSe1(2,2,6,6),      & 
& cplhhHpmSvcSe1(2,2,3,6),cplhhSdcSecSuaa(2,6,6,6),cplhhSeSucSdaa(2,6,6,6),              & 
& cplhhSeSvcSe1(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSecSv1(2,6,6,3),               & 
& cplHpmSecHpmcSe1(2,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSeSecSecSe1(6,6,6,6),            & 
& cplSeSucSecSuaa(6,6,6,6),cplSeSvcSecSv1(6,3,6,3),cplSecSecVWmVWm1(6,6),cplSecSeVZVZ1(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = Mhh(gt3) 


! {Ah, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSecSe(i1,gt2,i3)
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


! {Chi, bar[Fe], bar[Fe]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplcFeChiSeL(i3,i1,gt2)
coup2R = cplcFeChiSeR(i3,i1,gt2)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFuSeL(i1,i3,gt2)
coup2R = cplcFdFuSeR(i1,i3,gt2)
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


! {Fe, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,i3,gt2)
coup2R = cplcFeChiSeR(i1,i3,gt2)
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


! {Fv, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplcChaFvSeL(i3,i1,gt2)
coup2R = cplcChaFvSeR(i3,i1,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
coup2L = cplcFeFvSeL(i3,i1,gt2)
coup2R = cplcFeFvSeR(i3,i1,gt2)
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


! {hh, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSecSe(i1,gt2,i3)
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


! {Hpm, conj[Sv], conj[Sv]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplSecHpmcSv(gt2,i1,i3)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplSeSucSd(gt2,i3,i1)
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


! {Se, Ah, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MAh(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplAhSecSe(i3,gt2,i1)
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


! {Se, VZ, Ah}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MAh(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplAhSecSe(i3,gt2,i1)
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


! {Se, hh, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = Mhh(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
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


! {Se, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSeSvcSe(gt2,i3,i1)
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


! {Se, Ah, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MVZ 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = -cplSecSeVZ(gt2,i1)
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


! {Se, VZ, VZ}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MVZ 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = -cplSecSeVZ(gt2,i1)
coup3 = cplhhVZVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Se, conj[Sv], conj[Sv]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplSecSecSv(gt2,i1,i3)
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


! {Sv, conj[Hpm], conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[VWm], conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2 = cplSecSecSv(gt2,i3,i1)
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


! {Sv, conj[Hpm], conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = -cplSecSvcVWm(gt2,i1)
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


! {Sv, conj[VWm], conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = -cplSecSvcVWm(gt2,i1)
coup3 = cplhhcVWmVWm(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = -cplSecSeVP(gt2,i3)
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


! {VWm, conj[Sv], conj[Sv]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSvcSeVWm(i2,gt1)
coup2 = -cplSecSvcVWm(gt2,i3)
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


! {VZ, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = -cplSecSeVZ(gt2,i3)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplcFdFuSeL(i3,i1,gt2)
coup2R = cplcFdFuSeR(i3,i1,gt2)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2 = cplSeSucSd(gt2,i1,i3)
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
coup1 = cplSecSecSv(i2,gt1,i1)
coup2 = cplSeSvcSe(gt2,i1,i3)
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


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhhhSecSe1(gt3,i1,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplhhSecHpmcSv1(gt3,gt2,i1,i2)
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
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplhhSeSucSdaa(gt3,gt2,i2,i1)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplhhSeSvcSe1(gt3,gt2,i2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplhhSecSecSv1(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhhhSecSe1(gt3,i1,i2,gt1)
coup2 = cplhhSecSe(i1,gt2,i2)
If (Abs(coup1)*Abs(coup2).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology3_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
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
coup1 = cplhhHpmSvcSe1(gt3,i1,i2,gt1)
coup2 = cplSecHpmcSv(gt2,i1,i2)
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
coup1 = cplhhSdcSecSuaa(gt3,i1,gt1,i2)
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
coup1 = cplhhSecSecSv1(gt3,i1,gt1,i2)
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


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplhhSeSvcSe1(gt3,i1,i2,gt1)
coup2 = cplSecSecSv(gt2,i1,i2)
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
coup1 = cplAhAhSecSe1(i1,i2,gt2,gt1)
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
coup1 = cplhhhhSecSe1(i1,i2,gt2,gt1)
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
coup1 = cplHpmSecHpmcSe1(i1,gt2,i2,gt1)
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
coup1 = cplSdSecSdcSeaa(i1,gt2,i2,gt1)
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
coup1 = cplSeSecSecSe1(gt2,i1,gt1,i2)
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
coup1 = cplSeSucSecSuaa(gt2,i1,gt1,i2)
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
coup1 = cplSeSvcSecSv1(gt2,i1,gt1,i2)
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
coup1 = cplSecSecVWmVWm1(gt2,gt1)
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
coup1 = cplSecSeVZVZ1(gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSehh


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhAhhh,cplAhhhVZ,cplAhSecSe,         & 
& cplFvChacSeL,cplFvChacSeR,cplcChaChahhL,cplcChaChahhR,cplChiChihhL,cplChiChihhR,       & 
& cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdhhL,cplcFdFdhhR,           & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhhhhh,cplhhHpmcHpm,cplhhHpmcVWm,cplhhSdcSd,cplhhSecSe,     & 
& cplhhSucSu,cplhhSvcSv,cplhhcHpmVWm,cplhhcVWmVWm,cplhhVZVZ,cplHpmSvcSe,cplSdcSecSu,     & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplAhAhSecSe1,cplhhhhSecSe1,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSeSucSdaa, & 
& cplhhSeSvcSe1,cplhhSecHpmcSv1,cplhhSecSecSv1,cplHpmSecHpmcSe1,cplSdSecSdcSeaa,         & 
& cplSeSecSecSe1,cplSeSucSecSuaa,cplSeSvcSecSv1,cplSecSecVWmVWm1,cplSecSeVZVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhAhhh(2,2,2),cplAhhhVZ(2,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),& 
& cplcChaChahhL(2,2,2),cplcChaChahhR(2,2,2),cplChiChihhL(4,4,2),cplChiChihhR(4,4,2),     & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),           & 
& cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),         & 
& cplhhhhhh(2,2,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),               & 
& cplhhcVWmVWm(2),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),  & 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),& 
& cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplAhAhSecSe1(2,2,6,6),cplhhhhSecSe1(2,2,6,6),      & 
& cplhhHpmSvcSe1(2,2,3,6),cplhhSdcSecSuaa(2,6,6,6),cplhhSeSucSdaa(2,6,6,6),              & 
& cplhhSeSvcSe1(2,6,3,6),cplhhSecHpmcSv1(2,6,2,3),cplhhSecSecSv1(2,6,6,3),               & 
& cplHpmSecHpmcSe1(2,6,2,6),cplSdSecSdcSeaa(6,6,6,6),cplSeSecSecSe1(6,6,6,6),            & 
& cplSeSucSecSuaa(6,6,6,6),cplSeSvcSecSv1(6,3,6,3),cplSecSecVWmVWm1(6,6),cplSecSeVZVZ1(6,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = Mhh(gt3) 


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = -cplSecSeVP(gt2,i3)
coup3 = cplhhSecSe(gt3,i3,i2)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
  End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSehh


Subroutine Amplitude_Tree_MSSMTriLnV_SeToSvHpm(cplHpmSvcSe,MHpm,MSe,MSv,              & 
& MHpm2,MSe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MSe(6),MSv(3),MHpm2(2),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplHpmSvcSe(2,3,6)

Complex(dp) :: Amp(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MHpm(gt3) 
! Tree-Level Vertex 
coupT1 = cplHpmSvcSe(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToSvHpm


Subroutine Gamma_Real_MSSMTriLnV_SeToSvHpm(MLambda,em,gs,cplHpmSvcSe,MHpm,            & 
& MSe,MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplHpmSvcSe(2,3,6)

Real(dp), Intent(in) :: MHpm(2),MSe(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,2), GammarealGluon(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,3
    Do i3=2,2
Coup = cplHpmSvcSe(i3,i2,i1)
Mex1 = MSe(i1)
Mex2 = MSv(i2)
Mex3 = MHpm(i3)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToSvHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSvHpm(cplHpmSvcSe,ctcplHpmSvcSe,             & 
& MHpm,MHpm2,MSe,MSe2,MSv,MSv2,ZfHpm,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplHpmSvcSe(2,3,6)

Complex(dp), Intent(in) :: ctcplHpmSvcSe(2,3,6)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MHpm(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplHpmSvcSe(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplHpmSvcSe(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSv(i1,gt2)*cplHpmSvcSe(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,2
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfHpm(i1,gt3)*cplHpmSvcSe(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSvHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSvHpm(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,           & 
& cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,          & 
& cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,               & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,              & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,               & 
& cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSuSvcSdaa,      & 
& cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,cplSdSvcSecSuaa,cplSeSvcSecSv1,cplSvcSeVPVWm1,        & 
& cplSvcSeVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),          & 
& cplFvChacSeR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFecSeL(4,3,6),       & 
& cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcChaChiHpmL(2,4,2),       & 
& cplcChaChiHpmR(2,4,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),        & 
& cplcFeFvHpmR(3,3,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSecSe(2,6,6),           & 
& cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),             & 
& cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6),cplSdcSecSu(6,6,6),& 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSvcSeVWm(3,6), & 
& cplSvcSvVZ(3,3),cplAhHpmSvcSe1(2,2,3,6),cplhhHpmSvcSe1(2,2,3,6),cplHpmSdcSdcSeaa(2,6,6,6),& 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSecSecSe1(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),           & 
& cplHpmSvcHpmcSv1(2,3,2,3),cplHpmSvcSecSv1(2,3,6,3),cplSdSvcSecSuaa(6,3,6,6),           & 
& cplSeSvcSecSv1(6,3,6,3),cplSvcSeVPVWm1(3,6),cplSvcSeVWmVZ1(3,6)

Complex(dp), Intent(out) :: Amp(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MHpm(gt3) 


! {Chi, bar[Fe], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
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


! {Fe, Chi, Cha}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
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


! {Fv, bar[Cha], Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i3,i1,gt2)
coup2R = cplChiFvSvR(i3,i1,gt2)
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


! {hh, conj[Se], conj[Sv]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i3)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplSdSvcSd(i3,gt2,i1)
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


! {Se, Ah, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, hh, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, VZ, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, Ah, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MVWm 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
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


! {Se, hh, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
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


! {Se, VP, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSecSeVP(i1,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = cplHpmcVWmVP(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Se, VZ, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = cplHpmcVWmVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[Hpm], hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
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


! {Sv, conj[VWm], hh}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
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


! {Sv, conj[Hpm], VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = -cplSvcSvVZ(gt2,i1)
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


! {Sv, conj[VWm], VZ}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = -cplSvcSvVZ(gt2,i1)
coup3 = cplHpmcVWmVZ(gt3)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VZ, conj[Se], conj[Sv]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = -cplSvcSvVZ(gt2,i3)
coup3 = cplHpmSvcSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
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
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhHpmSvcSe1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhHpmSvcSe1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplHpmSvcHpmcSv1(gt3,gt2,i1,i2)
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
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplHpmSuSvcSdaa(gt3,i2,gt2,i1)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplHpmSvcSecSv1(gt3,gt2,i1,i2)
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
coup1 = cplhhHpmSvcSe1(i1,gt3,i2,gt1)
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
coup1 = cplHpmSdcSdcSeaa(gt3,i1,i2,gt1)
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
coup1 = cplHpmSecHpmcSe1(gt3,i1,i2,gt1)
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
coup1 = cplHpmSecSecSe1(gt3,i1,gt1,i2)
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


! {Ah, conj[Hpm]}
Do i1=1,2
  Do i2=1,2
ML1 = MAh(i1) 
ML2 = MHpm(i2) 
coup1 = cplAhHpmSvcSe1(i1,i2,gt2,gt1)
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
coup1 = cplhhHpmSvcSe1(i1,i2,gt2,gt1)
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
coup1 = cplSdSvcSecSuaa(i1,gt2,gt1,i2)
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
coup1 = cplSeSvcSecSv1(i1,gt2,gt1,i2)
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
coup1 = cplSvcSeVPVWm1(gt2,gt1)
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
coup1 = cplSvcSeVWmVZ1(gt2,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSvHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhHpmcHpm,cplAhHpmcVWm,              & 
& cplAhSecSe,cplFvChacSeL,cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,           & 
& cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdSvL,        & 
& cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,             & 
& cplcFeFeSvR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplhhHpmcHpm,          & 
& cplhhHpmcVWm,cplhhSecSe,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplHpmcHpmVP,               & 
& cplHpmcVWmVP,cplHpmcHpmVZ,cplHpmcVWmVZ,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,              & 
& cplSecSeVP,cplSecSeVZ,cplSecSecSv,cplSvcSeVWm,cplSvcSvVZ,cplAhHpmSvcSe1,               & 
& cplhhHpmSvcSe1,cplHpmSdcSdcSeaa,cplHpmSecHpmcSe1,cplHpmSecSecSe1,cplHpmSuSvcSdaa,      & 
& cplHpmSvcHpmcSv1,cplHpmSvcSecSv1,cplSdSvcSecSuaa,cplSeSvcSecSv1,cplSvcSeVPVWm1,        & 
& cplSvcSeVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhHpmcHpm(2,2,2),cplAhHpmcVWm(2,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),          & 
& cplFvChacSeR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFecSeL(4,3,6),       & 
& cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcChaChiHpmL(2,4,2),       & 
& cplcChaChiHpmR(2,4,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcSeL(3,3,6),       & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFeFvHpmL(3,3,2),        & 
& cplcFeFvHpmR(3,3,2),cplhhHpmcHpm(2,2,2),cplhhHpmcVWm(2,2),cplhhSecSe(2,6,6),           & 
& cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),             & 
& cplHpmcVWmVP(2),cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdSvcSd(6,3,6),cplSdcSecSu(6,6,6),& 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSvcSeVWm(3,6), & 
& cplSvcSvVZ(3,3),cplAhHpmSvcSe1(2,2,3,6),cplhhHpmSvcSe1(2,2,3,6),cplHpmSdcSdcSeaa(2,6,6,6),& 
& cplHpmSecHpmcSe1(2,6,2,6),cplHpmSecSecSe1(2,6,6,6),cplHpmSuSvcSdaa(2,6,3,6),           & 
& cplHpmSvcHpmcSv1(2,3,2,3),cplHpmSvcSecSv1(2,3,6,3),cplSdSvcSecSuaa(6,3,6,6),           & 
& cplSeSvcSecSv1(6,3,6,3),cplSvcSeVPVWm1(3,6),cplSvcSeVWmVZ1(3,6)

Complex(dp), Intent(out) :: Amp(6,3,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MHpm(gt3) 


! {Se, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplHpmcHpmVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, VP, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSecSeVP(i1,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
coup3 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
End Do


! {VP, conj[VWm]}
ML1 = MVP 
ML2 = MVWm 
coup1 = cplSvcSeVPVWm1(gt2,gt1)
coup2 = cplHpmcVWmVP(gt3)
Call Amp_VERTEX_StoSS_Topology4_VV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 

    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvHpm


Subroutine Amplitude_Tree_MSSMTriLnV_SeTocSuSd(cplSdcSecSu,MSd,MSe,MSu,               & 
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
Mex1 = MSe(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 
! Tree-Level Vertex 
coupT1 = cplSdcSecSu(gt3,gt1,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeTocSuSd


Subroutine Gamma_Real_MSSMTriLnV_SeTocSuSd(MLambda,em,gs,cplSdcSecSu,MSd,             & 
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
Coup = cplSdcSecSu(i3,i1,i2)
Mex1 = MSe(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeTocSuSd


Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocSuSd(cplSdcSecSu,ctcplSdcSecSu,             & 
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
Mex1 = MSe(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSdcSecSu(gt3,gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplSdcSecSu(gt3,i1,gt2)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSu(i1,gt2))*cplSdcSecSu(gt3,gt1,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSd(i1,gt3)*cplSdcSecSu(i1,gt1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 3*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocSuSd


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocSuSd(MAh,MCha,MChi,MFd,MFe,               & 
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
Mex1 = MSe(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 


! {Ah, conj[Se], Su}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSucSu(i1,i3,gt2)
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


! {Cha, Fv, Fd}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MFd(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFdcSuL(i1,i3,gt2)
coup2R = cplcChaFdcSuR(i1,i3,gt2)
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


! {Chi, bar[Fe], Fu}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MFu(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFucSuL(i1,i3,gt2)
coup2R = cplChiFucSuR(i1,i3,gt2)
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


! {Fe, Chi, Fd}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MFd(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFdcSuL(i1,i3,gt2)
coup2R = cplcFeFdcSuR(i1,i3,gt2)
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


! {Fe, Fv, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFd(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {hh, conj[Se], Su}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSucSu(i1,i3,gt2)
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


! {Hpm, conj[Sv], Sd}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplSdcHpmcSu(i3,i1,gt2)
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


! {Se, Ah, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MSd(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplSdcSecSu(i3,i1,gt2)
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


! {Se, hh, Sd}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MSd(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplSdcSecSu(i3,i1,gt2)
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


! {Se, Sv, Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {Se, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSdcSecSu(i3,i1,gt2)
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


! {Se, VZ, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MSd(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplSdcSecSu(i3,i1,gt2)
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


! {Se, conj[Sv], Sd}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplSdcSecSu(i3,i1,gt2)
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


! {VP, conj[Se], Su}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = cplSucSuVP(i3,gt2)
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


! {VWm, conj[Sv], Sd}
  Do i2=1,3
    Do i3=1,6
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = MSd(i3) 
coup1 = cplSvcSeVWm(i2,gt1)
coup2 = cplSdcSucVWm(i3,gt2)
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


! {VZ, conj[Se], Su}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = cplSucSuVZ(i3,gt2)
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


! {bar[Fu], bar[Fd], Chi}
Do i1=1,3
  Do i2=1,3
    Do i3=1,4
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MChi(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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


! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSdcSecSuaa(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSdcSecSuaa(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplSdcHpmcSucSvaa(gt3,i1,gt2,i2)
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
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSdSvcSecSuaa(gt3,i2,i1,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
  End Do
End Do


! {Ah, Su}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSu(i2) 
coup1 = cplAhSdcSecSuaa(i1,gt3,gt1,i2)
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
coup1 = cplhhSdcSecSuaa(i1,gt3,gt1,i2)
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
coup1 = cplHpmSdcSdcSeaa(i1,gt3,i2,gt1)
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
coup1 = cplSdSecSdcSeaa(gt3,i1,i2,gt1)
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
coup1 = cplAhSdcSecSuaa(i1,i2,gt1,gt2)
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
coup1 = cplhhSdcSecSuaa(i1,i2,gt1,gt2)
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
coup1 = cplHpmSucSecSuaa(i1,i2,gt1,gt2)
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
coup1 = cplSdSvcSecSuaa(i1,i2,gt1,gt2)
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
coup1 = cplSeSucSecSuaa(i1,i2,gt1,gt2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocSuSd


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd(MAh,MCha,MChi,MFd,MFe,            & 
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
Mex1 = MSe(gt1) 
Mex2 = MSu(gt2) 
Mex3 = MSd(gt3) 


! {Se, VP, Sd}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MSd(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSdcSecSu(i3,i1,gt2)
coup3 = cplSdcSdVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
End Do


! {VP, conj[Se], Su}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSu(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = cplSucSuVP(i3,gt2)
coup3 = cplSdcSecSu(gt3,i2,i3)
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(3)*AmpC 
    End Do
  End Do


! {conj[Su], conj[Sd], VG}
Do i1=1,6
  Do i2=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MVG 
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2 = cplSucSuVP(i1,gt2)
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
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSuSd


Subroutine Amplitude_Tree_MSSMTriLnV_SeToSvSe(cplSeSvcSe,MSe,MSv,MSe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSv(3),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSeSvcSe(6,3,6)

Complex(dp) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplSeSvcSe(gt3,gt2,gt1)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToSvSe


Subroutine Gamma_Real_MSSMTriLnV_SeToSvSe(MLambda,em,gs,cplSeSvcSe,MSe,               & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSeSvcSe(6,3,6)

Real(dp), Intent(in) :: MSe(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,6), GammarealGluon(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
Coup = cplSeSvcSe(i3,i2,i1)
Mex1 = MSe(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToSvSe


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSvSe(cplSeSvcSe,ctcplSeSvcSe,MSe,            & 
& MSe2,MSv,MSv2,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSeSvcSe(6,3,6)

Complex(dp), Intent(in) :: ctcplSeSvcSe(6,3,6)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfSv(3,3)

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
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSeSvcSe(gt3,gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplSeSvcSe(gt3,gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSv(i1,gt2)*cplSeSvcSe(gt3,i1,gt1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplSeSvcSe(i1,gt2,gt1)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSvSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSvSe(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,        & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,      & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFecSeL(4,3,6),        & 
& cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFeChiSeL(3,4,6),         & 
& cplcFeChiSeR(3,4,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcSeL(3,3,6),         & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),          & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),           & 
& cplhhSvcSv(2,3,3),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSecSu(6,6,6),             & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),& 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhSeSvcSe1(2,6,3,6),& 
& cplhhSeSvcSe1(2,6,3,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSvcSecSuaa(6,3,6,6),              & 
& cplSeSecHpmcSe1(6,6,2,6),cplSeSecSecSe1(6,6,6,6),cplSeSvcHpmcSv1(6,3,2,3),             & 
& cplSeSvcSecSv1(6,3,6,3)

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
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 


! {Chi, bar[Fe], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFdSvL(i1,i3,gt2)
coup2R = cplcFdFdSvR(i1,i3,gt2)
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


! {Fe, Fv, Cha}
Do i1=1,3
  Do i2=1,3
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MCha(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
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


! {Fe, Chi, Fe}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFeSvL(i1,i3,gt2)
coup2R = cplcFeFeSvR(i1,i3,gt2)
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
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i3,i1,gt2)
coup2R = cplChiFvSvR(i3,i1,gt2)
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


! {hh, conj[Se], conj[Sv]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i3)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplSdSvcSd(i3,gt2,i1)
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


! {Se, conj[Sv], Hpm}
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MHpm(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, Ah, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, hh, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, VP, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, VZ, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, conj[Sv], Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
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


! {Se, conj[Sv], VWm}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MVWm 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = -cplSvcSeVWm(gt2,i1)
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


! {Sv, conj[Se], hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
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


! {Sv, conj[Se], VZ}
Do i1=1,3
  Do i2=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MVZ 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2 = -cplSvcSvVZ(gt2,i1)
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


! {VZ, conj[Se], conj[Sv]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = -cplSvcSvVZ(gt2,i3)
coup3 = cplSeSvcSe(gt3,i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSS_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
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
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSeSvcSe1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSeSvcSe1(i1,gt3,gt2,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Hpm, conj[Sv]}
Do i1=1,2
  Do i2=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplSeSvcHpmcSv1(gt3,gt2,i1,i2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {Se, conj[Sv]}
Do i1=1,6
  Do i2=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplSeSvcSecSv1(gt3,gt2,i1,i2)
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
coup1 = cplhhSeSvcSe1(i1,gt3,i2,gt1)
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
coup1 = cplSdSecSdcSeaa(i1,gt3,i2,gt1)
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
coup1 = cplSeSecHpmcSe1(gt3,i1,i2,gt1)
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
coup1 = cplSeSecSecSe1(gt3,i1,gt1,i2)
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


! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSeSvcSe1(i1,i2,gt2,gt1)
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
coup1 = cplhhSeSvcSe1(i1,i2,gt2,gt1)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdSvcSecSuaa(i1,gt2,gt1,i2)
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
coup1 = cplSeSvcSecSv1(i1,gt2,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSvSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplcFeChaSvL,cplcFeChaSvR,   & 
& cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,cplChiFvSvR,cplcFeChiSeL,cplcFeChiSeR,           & 
& cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeSvL,cplcFeFeSvR,cplcFdFuSeL,cplcFdFuSeR,cplcChaFvSeL,cplcChaFvSeR,             & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhSvcSv,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,      & 
& cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,     & 
& cplSvcSeVWm,cplSvcSvVZ,cplAhSeSvcSe1,cplhhSeSvcSe1,cplSdSecSdcSeaa,cplSdSvcSecSuaa,    & 
& cplSeSecHpmcSe1,cplSeSecSecSe1,cplSeSvcHpmcSv1,cplSeSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFecSeL(4,3,6),        & 
& cplChiFecSeR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcFeChiSeL(3,4,6),         & 
& cplcFeChiSeR(3,4,6),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcSeL(3,3,6),         & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcChaFvSeL(2,3,6),          & 
& cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),           & 
& cplhhSvcSv(2,3,3),cplHpmSvcSe(2,3,6),cplSdSvcSd(6,3,6),cplSdcSecSu(6,6,6),             & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),& 
& cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplAhSeSvcSe1(2,6,3,6),& 
& cplhhSeSvcSe1(2,6,3,6),cplSdSecSdcSeaa(6,6,6,6),cplSdSvcSecSuaa(6,3,6,6),              & 
& cplSeSecHpmcSe1(6,6,2,6),cplSeSecSecSe1(6,6,6,6),cplSeSvcHpmcSv1(6,3,2,3),             & 
& cplSeSvcSecSv1(6,3,6,3)

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
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 


! {Se, VP, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSeSvcSe(i3,gt2,i1)
coup3 = cplSecSeVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvSe


Subroutine Amplitude_Tree_MSSMTriLnV_SeToSeVZ(cplSecSeVZ,MSe,MVZ,MSe2,MVZ2,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MVZ,MSe2(6),MVZ2

Complex(dp), Intent(in) :: cplSecSeVZ(6,6)

Complex(dp) :: Amp(2,6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,6
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVZ 
! Tree-Level Vertex 
coupT1 = -cplSecSeVZ(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToSeVZ


Subroutine Gamma_Real_MSSMTriLnV_SeToSeVZ(MLambda,em,gs,cplSecSeVZ,MSe,               & 
& MVZ,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSecSeVZ(6,6)

Real(dp), Intent(in) :: MSe(6),MVZ

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,6), GammarealGluon(6,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,6
Coup = cplSecSeVZ(i2,i1)
Mex1 = MSe(i1)
Mex2 = MSe(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToSeVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSeVZ(cplSecSeVP,cplSecSeVZ,ctcplSecSeVP,     & 
& ctcplSecSeVZ,MSe,MSe2,MVP,MVP2,MVZ,MVZ2,ZfSe,ZfVPVZ,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MVP,MVP2,MVZ,MVZ2

Complex(dp), Intent(in) :: cplSecSeVP(6,6),cplSecSeVZ(6,6)

Complex(dp), Intent(in) :: ctcplSecSeVP(6,6),ctcplSecSeVZ(6,6)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfVPVZ,ZfVZ

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVZ 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSecSeVZ(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplSecSeVZ(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt2)*cplSecSeVZ(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVPVZ*cplSecSeVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZ*cplSecSeVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSeVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSeVZ(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,           & 
& cplFvChacSeR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,       & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,   & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),             & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),             & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),             & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),               & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),               & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),& 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),& 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),& 
& cplSecSvcVWm(6,3),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplcHpmVWmVZ(2),    & 
& cplcVWmVWmVZ,cplSecSeVPVZ1(6,6),cplSecSeVZVZ1(6,6),cplSecSvcVWmVZ1(6,3),               & 
& cplSvcSeVWmVZ1(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVZ 


! {Ah, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSecSe(i1,gt2,i3)
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


! {Cha, Fv, Fv}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFvSeL(i1,i3,gt2)
coup2R = cplcChaFvSeR(i1,i3,gt2)
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


! {Chi, bar[Fe], bar[Fe]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplcFeChiSeL(i3,i1,gt2)
coup2R = cplcFeChiSeR(i3,i1,gt2)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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


! {Fe, Chi, Chi}
Do i1=1,3
  Do i2=1,4
    Do i3=1,4
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MChi(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeChiSeL(i1,i3,gt2)
coup2R = cplcFeChiSeR(i1,i3,gt2)
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


! {Fe, Fv, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Fv, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplcChaFvSeL(i3,i1,gt2)
coup2R = cplcChaFvSeR(i3,i1,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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


! {hh, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSecSe(i1,gt2,i3)
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


! {Hpm, conj[Sv], conj[Sv]}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplSecHpmcSv(gt2,i1,i3)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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


! {Se, hh, Ah}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MAh(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplAhSecSe(i3,gt2,i1)
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


! {Se, Ah, hh}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = Mhh(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
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


! {Se, VZ, hh}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = Mhh(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplhhSecSe(i3,gt2,i1)
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


! {Se, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {Se, hh, VZ}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MVZ 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplSecSeVZ(gt2,i1)
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


! {Se, conj[Sv], conj[Sv]}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplSecSecSv(gt2,i1,i3)
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


! {Sv, conj[Hpm], conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[VWm], conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSvcSeVWm(i1,gt1)
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


! {Sv, conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2 = cplSecSecSv(gt2,i3,i1)
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


! {Sv, conj[Hpm], conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
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


! {Sv, conj[VWm], conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = cplSecSeVP(gt2,i3)
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


! {VWm, conj[Sv], conj[Sv]}
  Do i2=1,3
    Do i3=1,3
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSvcSeVWm(i2,gt1)
coup2 = cplSecSvcVWm(gt2,i3)
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


! {VZ, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = cplSecSeVZ(gt2,i3)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = -cplSecSeVP(i1,gt1)
coup2 = cplSecSeVPVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VZ}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
coup1 = -cplSecSeVZ(i1,gt1)
coup2 = cplSecSeVZVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
coup1 = -cplSvcSeVWm(i1,gt1)
coup2 = cplSecSvcVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = cplSecSeVPVZ1(i1,gt1)
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
coup1 = cplSecSeVZVZ1(i1,gt1)
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
coup1 = cplSvcSeVWmVZ1(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSeVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhhhVZ,cplAhSecSe,cplFvChacSeL,      & 
& cplFvChacSeR,cplcChaChaVZL,cplcChaChaVZR,cplChiChiVZL,cplChiChiVZR,cplChiFecSeL,       & 
& cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,cplcFdFdVZL,cplcFdFdVZR,cplcFuFdcSeL,           & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,cplcFdFuSeL,              & 
& cplcFdFuSeR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,cplcChaFvSeL,cplcChaFvSeR,   & 
& cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplhhVZVZ,cplHpmSvcSe,cplHpmcHpmVZ,cplHpmcVWmVZ,    & 
& cplSdcSdVZ,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,cplSecHpmcSv,       & 
& cplSecSecSv,cplSecSvcVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVWmVZ,               & 
& cplcVWmVWmVZ,cplSecSeVPVZ1,cplSecSeVZVZ1,cplSecSvcVWmVZ1,cplSvcSeVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhhhVZ(2,2),cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),             & 
& cplcChaChaVZL(2,2),cplcChaChaVZR(2,2),cplChiChiVZL(4,4),cplChiChiVZR(4,4),             & 
& cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),       & 
& cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),             & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),               & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),               & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),cplhhVZVZ(2),cplHpmSvcSe(2,3,6),& 
& cplHpmcHpmVZ(2,2),cplHpmcVWmVZ(2),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),& 
& cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),& 
& cplSecSvcVWm(6,3),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplcHpmVWmVZ(2),    & 
& cplcVWmVWmVZ,cplSecSeVPVZ1(6,6),cplSecSeVZVZ1(6,6),cplSecSvcVWmVZ1(6,3),               & 
& cplSvcSeVWmVZ1(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVZ 


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = cplSecSeVP(gt2,i3)
coup3 = cplSecSeVZ(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = -cplSecSeVP(i1,gt1)
coup2 = cplSecSeVPVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = cplSecSeVPVZ1(i1,gt1)
coup2 = cplSecSeVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVZ


Subroutine Amplitude_Tree_MSSMTriLnV_SeTocSvSe(cplSecSecSv,MSe,MSv,MSe2,MSv2,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSv(3),MSe2(6),MSv2(3)

Complex(dp), Intent(in) :: cplSecSecSv(6,6,3)

Complex(dp) :: Amp(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
    Do gt3=1,6
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 
! Tree-Level Vertex 
coupT1 = cplSecSecSv(gt3,gt1,gt2)
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeTocSvSe


Subroutine Gamma_Real_MSSMTriLnV_SeTocSvSe(MLambda,em,gs,cplSecSecSv,MSe,             & 
& MSv,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSecSecSv(6,6,3)

Real(dp), Intent(in) :: MSe(6),MSv(3)

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3,6), GammarealGluon(6,3,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
Coup = cplSecSecSv(i3,i1,i2)
Mex1 = MSe(i1)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeTocSvSe


Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocSvSe(cplSecSecSv,ctcplSecSecSv,             & 
& MSe,MSe2,MSv,MSv2,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: cplSecSecSv(6,6,3)

Complex(dp), Intent(in) :: ctcplSecSecSv(6,6,3)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfSv(3,3)

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
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSecSecSv(gt3,gt1,gt2) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplSecSecSv(gt3,i1,gt2)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSv(i1,gt2))*cplSecSecSv(gt3,gt1,i1)
End Do


! External Field 3 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt3)*cplSecSecSv(i1,gt1,gt2)
End Do


! Getting the amplitude 
Call TreeAmp_StoSS(Mex1,Mex2,Mex3,ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(gt1, gt2, gt3) = 1*AmpC 
    End Do
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocSvSe


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocSvSe(MAh,MCha,MChi,MFd,MFe,               & 
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
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 


! {Cha, Fv, Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFecSvL(i1,i3,gt2)
coup2R = cplcChaFecSvR(i1,i3,gt2)
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


! {Chi, bar[Fe], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,i3,gt2)
coup2R = cplChiFvcSvR(i1,i3,gt2)
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


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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


! {Fe, Chi, Fe}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFecSvL(i1,i3,gt2)
coup2R = cplcFeFecSvR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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


! {hh, conj[Se], Sv}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,i3,gt2)
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


! {Hpm, conj[Sv], Se}
Do i1=1,2
  Do i2=1,3
    Do i3=1,6
ML1 = MHpm(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplHpmSvcSe(i1,i2,gt1)
coup2 = cplSecHpmcSv(i3,i1,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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


! {Se, Ah, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
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


! {Se, hh, Se}
Do i1=1,6
  Do i2=1,2
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {Se, VP, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
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


! {Se, VZ, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MSe(i3) 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
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


! {Se, conj[Sv], Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
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


! {VWm, conj[Sv], Se}
  Do i2=1,3
    Do i3=1,6
ML1 = MVWm 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSvcSeVWm(i2,gt1)
coup2 = cplSecSvcVWm(i3,gt2)
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


! {VZ, conj[Se], Sv}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = cplSvcSvVZ(i3,gt2)
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


! {conj[Sv], conj[Se], hh}
Do i1=1,3
  Do i2=1,6
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = Mhh(i3) 
coup1 = cplSecSecSv(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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


! {Ah, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSecSecSv1(i1,gt3,i2,gt2)
Call Amp_VERTEX_StoSS_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
  End Do
End Do


! {hh, conj[Se]}
Do i1=1,2
  Do i2=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSecSecSv1(i1,gt3,i2,gt2)
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
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSeSvcSecSv1(gt3,i2,i1,gt2)
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
coup1 = cplhhSecSecSv1(i1,gt3,gt1,i2)
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
coup1 = cplHpmSecSecSe1(i1,gt3,gt1,i2)
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
coup1 = cplSdSecSdcSeaa(i1,gt3,i2,gt1)
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
coup1 = cplSeSecSecSe1(gt3,i1,gt1,i2)
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
coup1 = cplAhSecSecSv1(i1,i2,gt1,gt2)
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
coup1 = cplhhSecSecSv1(i1,i2,gt1,gt2)
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
coup1 = cplHpmSvcSecSv1(i1,i2,gt1,gt2)
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
coup1 = cplSeSvcSecSv1(i1,i2,gt1,gt2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocSvSe


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe(MAh,MCha,MChi,MFd,MFe,            & 
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
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MSe(gt3) 


! {Se, VP, Se}
Do i1=1,6
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSecSecSv(i3,i1,gt2)
coup3 = cplSecSeVP(gt3,i3)
Call Amp_VERTEX_StoSS_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(gt1, gt2, gt3) = Amp(gt1, gt2, gt3) + oo16pi2*(1)*AmpC 
    End Do
End Do
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvSe


Subroutine Amplitude_Tree_MSSMTriLnV_SeToSvVWm(cplSvcSeVWm,MSe,MSv,MVWm,              & 
& MSe2,MSv2,MVWm2,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSv(3),MVWm,MSe2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplSvcSeVWm(3,6)

Complex(dp) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 

Do gt1=1,6
  Do gt2=1,3
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 
! Tree-Level Vertex 
coupT1 = -cplSvcSeVWm(gt2,gt1)
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,coupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = AmpC 
  End Do
End Do
End Subroutine Amplitude_Tree_MSSMTriLnV_SeToSvVWm


Subroutine Gamma_Real_MSSMTriLnV_SeToSvVWm(MLambda,em,gs,cplSvcSeVWm,MSe,             & 
& MSv,MVWm,GammarealPhoton,GammarealGluon)

Implicit None

Complex(dp), Intent(in) :: cplSvcSeVWm(3,6)

Real(dp), Intent(in) :: MSe(6),MSv(3),MVWm

Real(dp), Intent(in) :: MLambda, em, gs 

Real(dp), Intent(out) :: GammarealPhoton(6,3), GammarealGluon(6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 

Real(dp) :: Mloop1, Mloop2, Mloop3 
Complex(dp) :: Coup 
 
Do i1=1,6
  Do i2=1,3
Coup = cplSvcSeVWm(i2,i1)
Mex1 = MSe(i1)
Mex2 = MSv(i2)
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
End Subroutine Gamma_Real_MSSMTriLnV_SeToSvVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSvVWm(cplSvcSeVWm,ctcplSvcSeVWm,             & 
& MSe,MSe2,MSv,MSv2,MVWm,MVWm2,ZfSe,ZfSv,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: cplSvcSeVWm(3,6)

Complex(dp), Intent(in) :: ctcplSvcSeVWm(3,6)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfSv(3,3),ZfVWm

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 
!----------------------------- 
! Coupling counter term 
!----------------------------- 
ZcoupT1 = ctcplSvcSeVWm(gt2,gt1) 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplSvcSeVWm(gt2,i1)
End Do


! External Field 2 
Do i1=1,3
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSv(i1,gt2)*cplSvcSeVWm(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVWm*cplSvcSeVWm(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSvVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSvVWm(MAh,MCha,MChi,MFd,MFe,               & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,             & 
& cplhhcVWmVWm,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,cplcVWmVPVWm,              & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,              & 
& cplSvcSvcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplAhcHpmVWm(2,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),          & 
& cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplhhSecSe(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmSvcSe(2,3,6),& 
& cplSdSvcSd(6,3,6),cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecSecSv(6,6,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplcHpmVPVWm(2),  & 
& cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplSecSecVWmVWm1(6,6),cplSvcSeVPVWm1(3,6),   & 
& cplSvcSeVWmVZ1(3,6),cplSvcSvcVWmVWm1(3,3)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 


! {Chi, bar[Fe], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i1,i3,gt2)
coup2R = cplChiFvSvR(i1,i3,gt2)
coup3L = cplcFeFvVWmL(i2,i3)
coup3R = cplcFeFvVWmR(i2,i3)
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
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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


! {Fe, Chi, Cha}
Do i1=1,3
  Do i2=1,4
    Do i3=1,2
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = MCha(i3) 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,i3,gt2)
coup2R = cplcFeChaSvR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Fv, bar[Cha], Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplChiFvSvL(i3,i1,gt2)
coup2R = cplChiFvSvR(i3,i1,gt2)
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


! {hh, conj[Se], conj[Sv]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSvcSv(i1,gt2,i3)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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


! {Se, Ah, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MAh(i2) 
ML3 = MHpm(i3) 
coup1 = cplAhSecSe(i2,i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, hh, Hpm}
Do i1=1,6
  Do i2=1,2
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MHpm(i3) 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
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


! {Se, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSecSeVP(i1,gt1)
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


! {Se, VZ, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MHpm(i3) 
coup1 = cplSecSeVZ(i1,gt1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {Se, hh, VWm}
Do i1=1,6
  Do i2=1,2
ML1 = MSe(i1) 
ML2 = Mhh(i2) 
ML3 = MVWm 
coup1 = cplhhSecSe(i2,i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
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


! {Se, VP, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VZ, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
ML3 = MVWm 
coup1 = cplSecSeVZ(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[Hpm], hh}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = Mhh(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
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


! {Sv, conj[VWm], hh}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = Mhh(i3) 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplhhSvcSv(i3,gt2,i1)
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


! {Sv, conj[Hpm], VZ}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MVZ 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSvcSvVZ(gt2,i1)
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


! {Sv, conj[VWm], VZ}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MVZ 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplSvcSvVZ(gt2,i1)
coup3 = -cplcVWmVWmVZ
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VZ, conj[Se], conj[Sv]}
  Do i2=1,6
    Do i3=1,3
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = cplSvcSvVZ(gt2,i3)
coup3 = cplSvcSeVWm(i3,i2)
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = -cplSecSeVP(i1,gt1)
coup2 = cplSvcSeVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VZ}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
coup1 = -cplSecSeVZ(i1,gt1)
coup2 = cplSvcSeVWmVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
coup1 = -cplSvcSeVWm(i1,gt1)
coup2 = cplSvcSvcVWmVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVWm 
coup1 = cplSecSecVWmVWm1(i1,gt1)
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
coup1 = cplSvcSeVWmVZ1(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSvVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm(MAh,MCha,MChi,MFd,MFe,            & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplAhcHpmVWm,cplFvChacSeL,   & 
& cplFvChacSeR,cplcFeChaSvL,cplcFeChaSvR,cplChiFecSeL,cplChiFecSeR,cplChiFvSvL,          & 
& cplChiFvSvR,cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdSvL,cplcFdFdSvR,cplcFuFdcSeL,        & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeSvL,cplcFeFeSvR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplhhSecSe,cplhhSvcSv,cplhhcHpmVWm,             & 
& cplhhcVWmVWm,cplHpmSvcSe,cplSdSvcSd,cplSdcSecSu,cplSeSvcSe,cplSecSeVP,cplSecSeVZ,      & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,cplSvcSvVZ,cplcHpmVPVWm,cplcVWmVPVWm,              & 
& cplcHpmVWmVZ,cplcVWmVWmVZ,cplSecSecVWmVWm1,cplSvcSeVPVWm1,cplSvcSeVWmVZ1,              & 
& cplSvcSvcVWmVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplAhcHpmVWm(2,2),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),          & 
& cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),         & 
& cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),         & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),           & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),               & 
& cplhhSecSe(2,6,6),cplhhSvcSv(2,3,3),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplHpmSvcSe(2,3,6),& 
& cplSdSvcSd(6,3,6),cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSeVP(6,6),cplSecSeVZ(6,6),& 
& cplSecSecSv(6,6,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplSvcSvVZ(3,3),cplcHpmVPVWm(2),  & 
& cplcVWmVPVWm,cplcHpmVWmVZ(2),cplcVWmVWmVZ,cplSecSecVWmVWm1(6,6),cplSvcSeVPVWm1(3,6),   & 
& cplSvcSeVWmVZ1(3,6),cplSvcSvcVWmVWm1(3,3)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 


! {Se, VP, Hpm}
Do i1=1,6
    Do i3=1,2
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MHpm(i3) 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplHpmSvcSe(i3,gt2,i1)
coup3 = cplcHpmVPVWm(i3)
Call Amp_VERTEX_StoSV_Topology1_SVS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
End Do


! {Se, VP, VWm}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
ML3 = MVWm 
coup1 = cplSecSeVP(i1,gt1)
coup2 = cplSvcSeVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = -cplSecSeVP(i1,gt1)
coup2 = cplSvcSeVPVWm1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSvVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToAhHpm(MAh,MAh2,MHpm,MHpm2,MSe,               & 
& MSe2,ZfAh,ZfHpm,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MHpm(2),MHpm2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: ZfAh(2,2),ZfHpm(2,2),ZfSe(6,6)

Complex(dp), Intent(out) :: Amp(6,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MAh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToAhHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToAhHpm(MAh,MFd,MFe,MFu,MHpm,MSd,            & 
& MSe,MSu,MSv,MAh2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdAhL,cplcFdFdAhR,     & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,cplSecSecSv,             & 
& cplAhHpmSucSdaa,cplAhHpmSvcSe1,cplAhSdcSecSuaa,cplAhSecSecSv1,cplHpmSdcSdcSeaa,        & 
& cplHpmSecSecSe1,cplHpmSucSecSuaa,Amp)

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

Complex(dp), Intent(out) :: Amp(6,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MHpm(gt3) 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFdAhL(i1,i3,gt2)
coup2R = cplcFdFdAhR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFeAhL(i1,i3,gt2)
coup2R = cplcFeFeAhR(i1,i3,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplAhSdcSd(gt2,i3,i1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplAhSecSe(gt2,i3,i1)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplcFuFuAhL(i3,i1,gt2)
coup2R = cplcFuFuAhR(i3,i1,gt2)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2 = cplAhSucSu(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplAhHpmSucSdaa(gt2,gt3,i2,i1)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplAhHpmSvcSe1(gt2,gt3,i2,i1)
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
coup1 = cplHpmSdcSdcSeaa(gt3,i1,i2,gt1)
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
coup1 = cplHpmSecSecSe1(gt3,i1,gt1,i2)
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
coup1 = cplHpmSucSecSuaa(gt3,i1,gt1,i2)
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
coup1 = cplAhSdcSecSuaa(gt2,i1,gt1,i2)
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
coup1 = cplAhSecSecSv1(gt2,i1,gt1,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToAhHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToAhHpm(MAh,MFd,MFe,MFu,MHpm,             & 
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

Complex(dp), Intent(out) :: Amp(6,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MHpm(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToAhHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToAhVWm(MAh,MAh2,MSe,MSe2,MVWm,MVWm2,          & 
& ZfAh,ZfSe,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MAh2(2),MSe(6),MSe2(6),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfAh(2,2),ZfSe(6,6),ZfVWm

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MAh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToAhVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToAhVWm(MAh,MFd,MFe,MFu,MSd,MSe,             & 
& MSu,MSv,MVWm,MAh2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdAhL,cplcFdFdAhR,    & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,cplAhSucSu,      & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuVWmL,cplcFdFuVWmR,           & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MAh2(2),MFd2(3),         & 
& MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),          & 
& cplFvFecSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),              & 
& cplcFeFvVWmR(3,3),cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplSucSdVWm(6,6),              & 
& cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVWm 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToAhVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToAhVWm(MAh,MFd,MFe,MFu,MSd,              & 
& MSe,MSu,MSv,MVWm,MAh2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdAhL,            & 
& cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhSdcSd,cplAhSecSe,     & 
& cplAhSucSu,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFdFuVWmL,             & 
& cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,            & 
& cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MAh2(2),MFd2(3),         & 
& MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),          & 
& cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),             & 
& cplAhSucSu(2,6,6),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),          & 
& cplFvFecSeR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),              & 
& cplcFeFvVWmR(3,3),cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplSucSdVWm(6,6),              & 
& cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MAh(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToAhVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToChaChi(MCha,MCha2,MChi,MChi2,MSe,            & 
& MSe2,ZfL0,ZfLm,ZfLp,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MCha2(2),MChi(4),MChi2(4),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: ZfL0(4,4),ZfLm(2,2),ZfLp(2,2),ZfSe(6,6)

Complex(dp), Intent(out) :: Amp(2,6,2,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,4
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MCha(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToChaChi


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToChaChi(MCha,MChi,MFd,MFe,MFu,              & 
& MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,           & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,         & 
& cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,           & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,         & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplSdcSecSu,cplSeSvcSe,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MCha2(2),            & 
& MChi2(4),MFd2(3),MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,6,2,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MChi(gt3) 


! {Fd, Fu, Su}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MSu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdChaSuL(i1,gt2,i3)
coup2R = cplcFdChaSuR(i1,gt2,i3)
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


! {Fe, Fv, Sv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MSv(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeChaSvL(i1,gt2,i3)
coup2R = cplcFeChaSvR(i1,gt2,i3)
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


! {Fv, bar[Fe], conj[Se]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MSe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
coup2L = cplFvChacSeL(i1,gt2,i3)
coup2R = cplFvChacSeR(i1,gt2,i3)
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


! {Sd, Su, Fu}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MFu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2L = cplChaFucSdL(gt2,i3,i1)
coup2R = cplChaFucSdR(gt2,i3,i1)
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


! {Se, Sv, Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2L = cplFvChacSeL(i3,gt2,i1)
coup2R = cplFvChacSeR(i3,gt2,i1)
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


! {Se, conj[Sv], Fv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = 0. 
coup1 = cplSeSvcSe(i1,i2,gt1)
coup2L = cplFvChacSeL(i3,gt2,i1)
coup2R = cplFvChacSeR(i3,gt2,i1)
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


! {bar[Fu], bar[Fd], conj[Sd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MSd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplChaFucSdL(gt2,i1,i3)
coup2R = cplChaFucSdR(gt2,i1,i3)
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


! {conj[Su], conj[Sd], bar[Fd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,3
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MFd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2L = cplcFdChaSuL(i3,gt2,i1)
coup2R = cplcFdChaSuR(i3,gt2,i1)
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


! {conj[Sv], conj[Se], bar[Fe]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MFe(i3) 
coup1 = cplSecSecSv(i2,gt1,i1)
coup2L = cplcFeChaSvL(i3,gt2,i1)
coup2R = cplcFeChaSvR(i3,gt2,i1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToChaChi


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToChaChi(MCha,MChi,MFd,MFe,               & 
& MFu,MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,cplChaFucSdL,       & 
& cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,         & 
& cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,         & 
& cplChiFucSuR,cplChiFvSvL,cplChiFvSvR,cplChiFvcSvL,cplChiFvcSvR,cplcFdChiSdL,           & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplcFuFdcSeL,         & 
& cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplSdcSecSu,cplSeSvcSe,cplSecSecSv,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MCha2(2),            & 
& MChi2(4),MFd2(3),MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),      & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplChiFvSvL(4,3,3),cplChiFvSvR(4,3,3),         & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplSdcSecSu(6,6,6),cplSeSvcSe(6,3,6),cplSecSecSv(6,6,3)

Complex(dp), Intent(out) :: Amp(2,6,2,4) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,4
Amp(:,gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MCha(gt2) 
Mex3 = MChi(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToChaChi


Subroutine Amplitude_WAVE_MSSMTriLnV_SeTohhHpm(Mhh,Mhh2,MHpm,MHpm2,MSe,               & 
& MSe2,Zfhh,ZfHpm,ZfSe,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSe(6),MSe2(6)

Complex(dp), Intent(in) :: Zfhh(2,2),ZfHpm(2,2),ZfSe(6,6)

Complex(dp), Intent(out) :: Amp(6,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = Mhh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeTohhHpm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTohhHpm(MFd,MFe,MFu,Mhh,MHpm,MSd,            & 
& MSe,MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,cplcFdFdhhR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,cplSdcSecSu,       & 
& cplSecSecSv,cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1,             & 
& cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,cplHpmSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),              & 
& MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),        & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),           & 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplhhHpmSucSdaa(2,2,6,6),cplhhHpmSvcSe1(2,2,3,6),& 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSecSecSv1(2,6,6,3),cplHpmSdcSdcSeaa(2,6,6,6),            & 
& cplHpmSecSecSe1(2,6,6,6),cplHpmSucSecSuaa(2,6,6,6),cplHpmSvcSecSv1(2,3,6,3)

Complex(dp), Intent(out) :: Amp(6,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MHpm(gt3) 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = cplcFdFdhhL(i1,i3,gt2)
coup2R = cplcFdFdhhR(i1,i3,gt2)
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


! {Fe, Fv, Fe}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = cplcFeFehhL(i1,i3,gt2)
coup2R = cplcFeFehhR(i1,i3,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplhhSdcSd(gt2,i3,i1)
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


! {Se, Sv, Se}
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplhhSecSe(gt2,i3,i1)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplcFuFuhhL(i3,i1,gt2)
coup2R = cplcFuFuhhR(i3,i1,gt2)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2 = cplhhSucSu(gt2,i1,i3)
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


! {conj[Sv], conj[Se], conj[Sv]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i2,gt1,i1)
coup2 = cplhhSvcSv(gt2,i1,i3)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = cplhhHpmSucSdaa(gt2,gt3,i2,i1)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplhhHpmSvcSe1(gt2,gt3,i2,i1)
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
coup1 = cplHpmSdcSdcSeaa(gt3,i1,i2,gt1)
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
coup1 = cplHpmSecSecSe1(gt3,i1,gt1,i2)
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
coup1 = cplHpmSucSecSuaa(gt3,i1,gt1,i2)
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
coup1 = cplHpmSvcSecSv1(gt3,i1,gt1,i2)
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
coup1 = cplhhSdcSecSuaa(gt2,i1,gt1,i2)
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
coup1 = cplhhSecSecSv1(gt2,i1,gt1,i2)
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
    End Do
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTohhHpm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTohhHpm(MFd,MFe,MFu,Mhh,MHpm,             & 
& MSd,MSe,MSu,MSv,MFd2,MFe2,MFu2,Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,cplcFdFdhhL,             & 
& cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplHpmSucSd,cplHpmSvcSe,      & 
& cplSdcSecSu,cplSecSecSv,cplhhHpmSucSdaa,cplhhHpmSvcSe1,cplhhSdcSecSuaa,cplhhSecSecSv1, & 
& cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSecSuaa,cplHpmSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MFd2(3),              & 
& MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),        & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),           & 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplhhHpmSucSdaa(2,2,6,6),cplhhHpmSvcSe1(2,2,3,6),& 
& cplhhSdcSecSuaa(2,6,6,6),cplhhSecSecSv1(2,6,6,3),cplHpmSdcSdcSeaa(2,6,6,6),            & 
& cplHpmSecSecSe1(2,6,6,6),cplHpmSucSecSuaa(2,6,6,6),cplHpmSvcSecSv1(2,3,6,3)

Complex(dp), Intent(out) :: Amp(6,2,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,2
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MHpm(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTohhHpm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeTohhVWm(Mhh,Mhh2,MSe,MSe2,MVWm,MVWm2,          & 
& Zfhh,ZfSe,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: Mhh(2),Mhh2(2),MSe(6),MSe2(6),MVWm,MVWm2

Complex(dp), Intent(in) :: Zfhh(2,2),ZfSe(6,6),ZfVWm

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = Mhh(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeTohhVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTohhVWm(MFd,MFe,MFu,Mhh,MSd,MSe,             & 
& MSu,MSv,MVWm,MFd2,MFe2,MFu2,Mhh2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdhhL,cplcFdFdhhR,    & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,             & 
& cplcFuFuhhL,cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcSecSu,cplSecSecSv,cplSucSdVWm,       & 
& cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),Mhh(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),         & 
& MFu2(3),Mhh2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),        & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),             & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),               & 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),             & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVWm 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTohhVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTohhVWm(MFd,MFe,MFu,Mhh,MSd,              & 
& MSe,MSu,MSv,MVWm,MFd2,MFe2,MFu2,Mhh2,MSd2,MSe2,MSu2,MSv2,MVWm2,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplhhSvcSv,cplSdcSecSu,cplSecSecSv,      & 
& cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),Mhh(2),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MFd2(3),MFe2(3),         & 
& MFu2(3),Mhh2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),        & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),             & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplhhSdcSd(2,6,6),cplhhSecSe(2,6,6),               & 
& cplhhSucSu(2,6,6),cplhhSvcSv(2,3,3),cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),             & 
& cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = Mhh(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTohhVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToHpmVP(MHpm,MHpm2,MSe,MSe2,MVP,               & 
& MVP2,ZfHpm,ZfSe,ZfVP,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MVP,MVP2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfVP

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToHpmVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToHpmVP(MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MVP,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,cplcFdFdVPR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,cplcFuFuVPR,cplcFeFvHpmL,cplcFeFvHpmR,           & 
& cplHpmSucSd,cplHpmSvcSe,cplSdcSdVP,cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVP,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),             & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),         & 
& cplSdcSdVP(6,6),cplSdcSecSu(6,6,6),cplSecSeVP(6,6),cplSecSecSv(6,6,3),cplSucSuVP(6,6)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVP 


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToHpmVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToHpmVP(MFd,MFe,MFu,MHpm,MSd,             & 
& MSe,MSu,MSv,MVP,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,cplcFdFdVPL,             & 
& cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVPL,cplcFuFuVPR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdVP,cplSdcSecSu,cplSecSeVP,cplSecSecSv,    & 
& cplSucSuVP,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVP,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),             & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),         & 
& cplSdcSdVP(6,6),cplSdcSecSu(6,6,6),cplSecSeVP(6,6),cplSecSecSv(6,6,3),cplSucSuVP(6,6)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVP 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToHpmVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToHpmVZ(MHpm,MHpm2,MSe,MSe2,MVZ,               & 
& MVZ2,ZfHpm,ZfSe,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MVZ,MVZ2

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfVZ

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToHpmVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToHpmVZ(MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MSv,MVZ,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,     & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdVZ,cplSdcSecSu,              & 
& cplSecSeVZ,cplSecSecSv,cplSucSuVZ,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVZ,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),              & 
& cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSucSuVZ(6,6),cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVZ 


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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
  End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToHpmVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToHpmVZ(MFd,MFe,MFu,MHpm,MSd,             & 
& MSe,MSu,MSv,MVZ,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVZ2,cplcFdFdVZL,             & 
& cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,             & 
& cplcFeFeVZR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,cplSdcSdVZ,               & 
& cplSdcSecSu,cplSecSeVZ,cplSecSecSv,cplSucSuVZ,cplSvcSvVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),MVZ,MFd2(3),MFe2(3),         & 
& MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),             & 
& cplFvFvVZL(3,3),cplFvFvVZR(3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),               & 
& cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),              & 
& cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSucSuVZ(6,6),cplSvcSvVZ(3,3)

Complex(dp), Intent(out) :: Amp(2,6,2) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MVZ 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToHpmVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToHpmcSv(MHpm,MHpm2,MSe,MSe2,MSv,              & 
& MSv2,ZfHpm,ZfSe,ZfSv,Amp)

Implicit None

Real(dp), Intent(in) :: MHpm(2),MHpm2(2),MSe(6),MSe2(6),MSv(3),MSv2(3)

Complex(dp), Intent(in) :: ZfHpm(2,2),ZfSe(6,6),ZfSv(3,3)

Complex(dp), Intent(out) :: Amp(6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
! External masses 
Mex1 = MSe(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToHpmcSv


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToHpmcSv(MCha,MChi,MFd,MFe,MFu,              & 
& MHpm,MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,MSv2,             & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSdcSvaa, & 
& cplHpmSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),             & 
& MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),       & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),       & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),         & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplHpmSdcSdcSeaa(2,6,6,6),    & 
& cplHpmSecSecSe1(2,6,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplHpmSvcSecSv1(2,3,6,3)

Complex(dp), Intent(out) :: Amp(6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSv(gt3) 


! {Cha, Fv, Chi}
Do i1=1,2
  Do i2=1,3
    Do i3=1,4
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MChi(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaChiHpmL(i1,i3,gt2)
coup2R = cplcChaChiHpmR(i1,i3,gt2)
coup3L = cplChiFvcSvL(i3,i2,gt3)
coup3R = cplChiFvcSvR(i3,i2,gt3)
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


! {Fe, Chi, Fv}
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = MChi(i2) 
ML3 = 0. 
coup1L = cplChiFecSeL(i2,i1,gt1)
coup1R = cplChiFecSeR(i2,i1,gt1)
coup2L = cplcFeFvHpmL(i1,i3,gt2)
coup2R = cplcFeFvHpmR(i1,i3,gt2)
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


! {Fv, bar[Cha], bar[Fe]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MFe(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplcFeFvHpmL(i3,i1,gt2)
coup2R = cplcFeFvHpmR(i3,i1,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplHpmSvcSecSv1(gt2,i2,i1,gt3)
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
coup1 = cplHpmSdcSdcSeaa(gt2,i1,i2,gt1)
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
coup1 = cplHpmSecSecSe1(gt2,i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToHpmcSv


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToHpmcSv(MCha,MChi,MFd,MFe,               & 
& MFu,MHpm,MSd,MSe,MSu,MSv,MCha2,MChi2,MFd2,MFe2,MFu2,MHpm2,MSd2,MSe2,MSu2,              & 
& MSv2,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,    & 
& cplcChaChiHpmL,cplcChaChiHpmR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFdFuHpmL,cplcFdFuHpmR,cplcFeFvHpmL,cplcFeFvHpmR,cplHpmSucSd,cplHpmSvcSe,           & 
& cplSdcSdcSv,cplSdcSecSu,cplSecSecSv,cplHpmSdcSdcSeaa,cplHpmSecSecSe1,cplHpmSucSdcSvaa, & 
& cplHpmSvcSecSv1,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MSv(3),             & 
& MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3)

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiHpmL(2,4,2),cplcChaChiHpmR(2,4,2),   & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),       & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),       & 
& cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),         & 
& cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),cplSecSecSv(6,6,3),cplHpmSdcSdcSeaa(2,6,6,6),    & 
& cplHpmSecSecSe1(2,6,6,6),cplHpmSucSdcSvaa(2,6,6,3),cplHpmSvcSecSv1(2,3,6,3)

Complex(dp), Intent(out) :: Amp(6,2,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,2
    Do gt3=1,3
Amp(gt1, gt2, gt3) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MHpm(gt2) 
Mex3 = MSv(gt3) 
    End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToHpmcSv


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSeVP(cplSecSeVP,cplSecSeVZ,ctcplSecSeVP,     & 
& ctcplSecSeVZ,MSe,MSe2,MVP,MVP2,ZfSe,ZfVP,ZfVZVP,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MVP,MVP2

Complex(dp), Intent(in) :: cplSecSeVP(6,6),cplSecSeVZ(6,6)

Complex(dp), Intent(in) :: ctcplSecSeVP(6,6),ctcplSecSeVZ(6,6)

Complex(dp), Intent(in) :: ZfSe(6,6),ZfVP,ZfVZVP

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVP 
ZcoupT1 = 0._dp 
!----------------------------- 
! Multiply Z-factors 
!----------------------------- 
! External Field 1 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*Conjg(ZfSe(i1,gt1))*cplSecSeVP(gt2,i1)
End Do


! External Field 2 
Do i1=1,6
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfSe(i1,gt2)*cplSecSeVP(i1,gt1)
End Do


! External Field 3 
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVP*cplSecSeVP(gt2,gt1)
ZcoupT1 = ZcoupT1 + 0.5_dp*ZfVZVP*cplSecSeVZ(gt2,gt1)


! Getting the amplitude 
Call TreeAmp_StoSV(Mex1,Mex2,Mex3,-ZcoupT1,AmpC) 
! Colour and symmetry factor 
Amp(:,gt1, gt2) = 1*AmpC 
  End Do
End Do
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToSeVP


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSeVP(MAh,MCha,MChi,MFd,MFe,MFu,            & 
& Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,Mhh2,            & 
& MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,        & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplHpmSvcSe,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,     & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVP,cplSvcSeVWm,               & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSvcVWmVP1,cplSvcSeVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChaVPL(2,2),         & 
& cplcChaChaVPR(2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),        & 
& cplcFeChiSeR(3,4,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcSeL(3,3,6),             & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVPL(3,3),            & 
& cplcFeFeVPR(3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVPL(3,3),               & 
& cplcFuFuVPR(3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),           & 
& cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),             & 
& cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),& 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),& 
& cplSucSuVP(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplSecSeVPVP1(6,6),      & 
& cplSecSeVPVZ1(6,6),cplSecSvcVWmVP1(6,3),cplSvcSeVPVWm1(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVP 


! {Ah, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = MAh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplAhSecSe(i1,i2,gt1)
coup2 = cplAhSecSe(i1,gt2,i3)
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


! {Chi, bar[Fe], bar[Fe]}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplcFeChiSeL(i3,i1,gt2)
coup2R = cplcFeChiSeR(i3,i1,gt2)
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


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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


! {Fv, bar[Cha], bar[Cha]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MCha(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplcChaFvSeL(i3,i1,gt2)
coup2R = cplcChaFvSeR(i3,i1,gt2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
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


! {hh, conj[Se], conj[Se]}
Do i1=1,2
  Do i2=1,6
    Do i3=1,6
ML1 = Mhh(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplhhSecSe(i1,i2,gt1)
coup2 = cplhhSecSe(i1,gt2,i3)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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


! {Sv, conj[Hpm], conj[Hpm]}
Do i1=1,3
  Do i2=1,2
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MHpm(i3) 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[VWm], conj[Hpm]}
Do i1=1,3
    Do i3=1,2
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MHpm(i3) 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplSecHpmcSv(gt2,i3,i1)
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


! {Sv, conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSeSvcSe(i2,i1,gt1)
coup2 = cplSecSecSv(gt2,i3,i1)
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


! {Sv, conj[Hpm], conj[VWm]}
Do i1=1,3
  Do i2=1,2
ML1 = MSv(i1) 
ML2 = MHpm(i2) 
ML3 = MVWm 
coup1 = cplHpmSvcSe(i2,i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
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


! {Sv, conj[VWm], conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
ML3 = MVWm 
coup1 = cplSvcSeVWm(i1,gt1)
coup2 = cplSecSvcVWm(gt2,i1)
coup3 = -cplcVWmVPVWm
If ((Abs(coup1))*(Abs(coup2))*(Abs(coup3)).gt.epsCoup) Then 
Call Amp_VERTEX_StoSV_Topology1_SVV(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
Else
 AmpC = 0._dp
End if
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = cplSecSeVP(gt2,i3)
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


! {VZ, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVZ 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVZ(i2,gt1)
coup2 = cplSecSeVZ(gt2,i3)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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
coup1 = cplSdcSecSu(i2,gt1,i1)
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
coup1 = cplSecSecSv(i2,gt1,i1)
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


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = -cplSecSeVP(i1,gt1)
coup2 = cplSecSeVPVP1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VZ}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVZ 
coup1 = -cplSecSeVZ(i1,gt1)
coup2 = cplSecSeVPVZ1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Sv, conj[VWm]}
Do i1=1,3
ML1 = MSv(i1) 
ML2 = MVWm 
coup1 = -cplSvcSeVWm(i1,gt1)
coup2 = cplSecSvcVWmVP1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = cplSecSeVPVP1(i1,gt1)
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
coup1 = cplSecSeVPVZ1(i1,gt1)
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
coup1 = cplSvcSeVPVWm1(i1,gt1)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToSeVP


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVP(MAh,MCha,MChi,MFd,MFe,             & 
& MFu,Mhh,MHpm,MSd,MSe,MSu,MSv,MVP,MVWm,MVZ,MAh2,MCha2,MChi2,MFd2,MFe2,MFu2,             & 
& Mhh2,MHpm2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,MVZ2,cplAhSecSe,cplFvChacSeL,cplFvChacSeR,   & 
& cplcChaChaVPL,cplcChaChaVPR,cplChiFecSeL,cplChiFecSeR,cplcFeChiSeL,cplcFeChiSeR,       & 
& cplcFdFdVPL,cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,             & 
& cplcFeFeVPL,cplcFeFeVPR,cplcFdFuSeL,cplcFdFuSeR,cplcFuFuVPL,cplcFuFuVPR,               & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplhhSecSe,cplHpmSvcSe,              & 
& cplHpmcHpmVP,cplHpmcVWmVP,cplSdcSdVP,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecSeVP,     & 
& cplSecSeVZ,cplSecHpmcSv,cplSecSecSv,cplSecSvcVWm,cplSucSuVP,cplSvcSeVWm,               & 
& cplcHpmVPVWm,cplcVWmVPVWm,cplSecSeVPVP1,cplSecSeVPVZ1,cplSecSvcVWmVP1,cplSvcSeVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVP,MVWm,MVZ,MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),          & 
& Mhh2(2),MHpm2(2),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2,MVZ2

Complex(dp), Intent(in) :: cplAhSecSe(2,6,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplcChaChaVPL(2,2),         & 
& cplcChaChaVPR(2,2),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),cplcFeChiSeL(3,4,6),        & 
& cplcFeChiSeR(3,4,6),cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcSeL(3,3,6),             & 
& cplcFuFdcSeR(3,3,6),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVPL(3,3),            & 
& cplcFeFeVPR(3,3),cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFuFuVPL(3,3),               & 
& cplcFuFuVPR(3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFeFvSeL(3,3,6),           & 
& cplcFeFvSeR(3,3,6),cplhhSecSe(2,6,6),cplHpmSvcSe(2,3,6),cplHpmcHpmVP(2,2),             & 
& cplHpmcVWmVP(2),cplSdcSdVP(6,6),cplSdcSecSu(6,6,6),cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),& 
& cplSecSeVP(6,6),cplSecSeVZ(6,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),cplSecSvcVWm(6,3),& 
& cplSucSuVP(6,6),cplSvcSeVWm(3,6),cplcHpmVPVWm(2),cplcVWmVPVWm,cplSecSeVPVP1(6,6),      & 
& cplSecSeVPVZ1(6,6),cplSecSvcVWmVP1(6,3),cplSvcSeVPVWm1(3,6)

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
Mex1 = MSe(gt1) 
Mex2 = MSe(gt2) 
Mex3 = MVP 


! {VP, conj[Se], conj[Se]}
  Do i2=1,6
    Do i3=1,6
ML1 = MVP 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSeVP(i2,gt1)
coup2 = cplSecSeVP(gt2,i3)
coup3 = cplSecSeVP(i3,i2)
Call Amp_VERTEX_StoSV_Topology1_VSS(Mex1,Mex2,Mex3,ML1,ML2,ML3,coup1,coup2,coup3,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
    End Do
  End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = -cplSecSeVP(i1,gt1)
coup2 = cplSecSeVPVP1(gt2,i1)
Call Amp_VERTEX_StoSV_Topology2_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 
End Do


! {Se, VP}
Do i1=1,6
ML1 = MSe(i1) 
ML2 = MVP 
coup1 = cplSecSeVPVP1(i1,gt1)
coup2 = cplSecSeVP(gt2,i1)
Call Amp_VERTEX_StoSV_Topology3_SV(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1, gt2) = Amp(:,gt1, gt2) + oo16pi2*(1)*AmpC 

End Do
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToSeVP


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToVPVWm(MSe,MSe2,MVP,MVP2,MVWm,MVWm2,          & 
& ZfSe,ZfVP,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MVP,MVP2,MVWm,MVWm2

Complex(dp), Intent(in) :: ZfSe(6,6),ZfVP,ZfVWm

Complex(dp), Intent(out) :: Amp(2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MVP 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToVPVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToVPVWm(MFd,MFe,MFu,MSd,MSe,MSu,             & 
& MSv,MVP,MVWm,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,cplcFdFdVPL,cplcFdFdVPR,    & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,cplcFeFeVPR,             & 
& cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,           & 
& cplSdcSdVP,cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,cplSucSdVWm,cplSvcSeVWm,      & 
& cplSucSdVPVWmaa,cplSvcSeVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVP,MVWm,MFd2(3),MFe2(3),            & 
& MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),& 
& cplcFeFvVWmR(3,3),cplSdcSdVP(6,6),cplSdcSecSu(6,6,6),cplSecSeVP(6,6),cplSecSecSv(6,6,3),& 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplSucSdVPVWmaa(6,6),cplSvcSeVPVWm1(3,6)

Complex(dp), Intent(out) :: Amp(2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MVP 
Mex3 = MVWm 


! {Fd, Fu, Fd}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
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


! {bar[Fu], bar[Fd], bar[Fu]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
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


! {conj[Su], conj[Sd], conj[Su]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSvcSeVPVWm1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToVPVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToVPVWm(MFd,MFe,MFu,MSd,MSe,              & 
& MSu,MSv,MVP,MVWm,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVP2,MVWm2,cplcFdFdVPL,            & 
& cplcFdFdVPR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVPL,             & 
& cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,            & 
& cplcFeFvVWmR,cplSdcSdVP,cplSdcSecSu,cplSecSeVP,cplSecSecSv,cplSucSuVP,cplSucSdVWm,     & 
& cplSvcSeVWm,cplSucSdVPVWmaa,cplSvcSeVPVWm1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVP,MVWm,MFd2(3),MFe2(3),            & 
& MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVP2,MVWm2

Complex(dp), Intent(in) :: cplcFdFdVPL(3,3),cplcFdFdVPR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),               & 
& cplcFuFuVPL(3,3),cplcFuFuVPR(3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFeFvVWmL(3,3),& 
& cplcFeFvVWmR(3,3),cplSdcSdVP(6,6),cplSdcSecSu(6,6,6),cplSecSeVP(6,6),cplSecSecSv(6,6,3),& 
& cplSucSuVP(6,6),cplSucSdVWm(6,6),cplSvcSeVWm(3,6),cplSucSdVPVWmaa(6,6),cplSvcSeVPVWm1(3,6)

Complex(dp), Intent(out) :: Amp(2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MVP 
Mex3 = MVWm 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToVPVWm


Subroutine Amplitude_WAVE_MSSMTriLnV_SeToVWmVZ(MSe,MSe2,MVWm,MVWm2,MVZ,               & 
& MVZ2,ZfSe,ZfVWm,ZfVZ,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MVWm,MVWm2,MVZ,MVZ2

Complex(dp), Intent(in) :: ZfSe(6,6),ZfVWm,ZfVZ

Complex(dp), Intent(out) :: Amp(2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MVWm 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeToVWmVZ


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToVWmVZ(MFd,MFe,MFu,MSd,MSe,MSu,             & 
& MSv,MVWm,MVZ,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplcFdFdVZL,cplcFdFdVZR,    & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,cplcFeFeVZR,             & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,cplFvFvVZR,               & 
& cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVZ,cplSdcSecSu,cplSecSeVZ,cplSecSecSv,               & 
& cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MVZ,MFd2(3),MFe2(3),            & 
& MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplFvFvVZL(3,3), & 
& cplFvFvVZR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),& 
& cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),  & 
& cplSvcSvVZ(3,3),cplSucSdVWmVZaa(6,6),cplSvcSeVWmVZ1(3,6)

Complex(dp), Intent(out) :: Amp(2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
Amp(:,gt1) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MVWm 
Mex3 = MVZ 


! {Fd, Fu, Fu}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFd(i1) 
ML2 = MFu(i2) 
ML3 = MFu(i3) 
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
coup2L = -cplcFdFuVWmR(i1,i3)
coup2R = -cplcFdFuVWmL(i1,i3)
coup3L = -cplcFuFuVZR(i3,i2)
coup3R = -cplcFuFuVZL(i3,i2)
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


! {Fe, Fv, Fv}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFe(i1) 
ML2 = 0. 
ML3 = 0. 
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
coup2L = -cplcFeFvVWmR(i1,i3)
coup2R = -cplcFeFvVWmL(i1,i3)
coup3L = -cplFvFvVZR(i3,i2)
coup3R = -cplFvFvVZL(i3,i2)
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


! {Fv, bar[Fe], bar[Fe]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = 0. 
ML2 = MFe(i2) 
ML3 = MFe(i3) 
coup1L = cplFvFecSeL(i1,i2,gt1)
coup1R = cplFvFecSeR(i1,i2,gt1)
coup2L = cplcFeFvVWmL(i3,i1)
coup2R = cplcFeFvVWmR(i3,i1)
coup3L = cplcFeFeVZL(i2,i3)
coup3R = cplcFeFeVZR(i2,i3)
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


! {Sd, Su, Su}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSu(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
coup2 = -cplSucSdVWm(i3,i1)
coup3 = -cplSucSuVZ(i2,i3)
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


! {Se, Sv, Sv}
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
ML1 = MSe(i1) 
ML2 = MSv(i2) 
ML3 = MSv(i3) 
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = -cplSvcSeVWm(i3,i1)
coup3 = -cplSvcSvVZ(i2,i3)
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


! {bar[Fu], bar[Fd], bar[Fd]}
Do i1=1,3
  Do i2=1,3
    Do i3=1,3
ML1 = MFu(i1) 
ML2 = MFd(i2) 
ML3 = MFd(i3) 
coup1L = cplcFuFdcSeL(i1,i2,gt1)
coup1R = cplcFuFdcSeR(i1,i2,gt1)
coup2L = cplcFdFuVWmL(i3,i1)
coup2R = cplcFdFuVWmR(i3,i1)
coup3L = cplcFdFdVZL(i2,i3)
coup3R = cplcFdFdVZR(i2,i3)
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


! {conj[Su], conj[Sd], conj[Sd]}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSu(i1) 
ML2 = MSd(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i2,gt1,i1)
coup2 = cplSucSdVWm(i1,i3)
coup3 = cplSdcSdVZ(i3,i2)
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


! {conj[Sv], conj[Se], conj[Se]}
Do i1=1,3
  Do i2=1,6
    Do i3=1,6
ML1 = MSv(i1) 
ML2 = MSe(i2) 
ML3 = MSe(i3) 
coup1 = cplSecSecSv(i2,gt1,i1)
coup2 = cplSvcSeVWm(i1,i3)
coup3 = cplSecSeVZ(i3,i2)
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


! {Sd, Su}
Do i1=1,6
  Do i2=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
coup2 = cplSvcSeVWmVZ1(i2,i1)
Call Amp_VERTEX_StoVV_Topology2_SS(Mex1,Mex2,Mex3,ML1,ML2,coup1,coup2,AmpC) 
! Colour and symmetry Factor 
Amp(:,gt1) = Amp(:,gt1) + oo16pi2*(1)*AmpC 
  End Do
End Do
End Do
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeToVWmVZ


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToVWmVZ(MFd,MFe,MFu,MSd,MSe,              & 
& MSu,MSv,MVWm,MVZ,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,MVZ2,cplcFdFdVZL,            & 
& cplcFdFdVZR,cplcFuFdcSeL,cplcFuFdcSeR,cplFvFecSeL,cplFvFecSeR,cplcFeFeVZL,             & 
& cplcFeFeVZR,cplcFdFuVWmL,cplcFdFuVWmR,cplcFuFuVZL,cplcFuFuVZR,cplFvFvVZL,              & 
& cplFvFvVZR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdVZ,cplSdcSecSu,cplSecSeVZ,cplSecSecSv,    & 
& cplSucSdVWm,cplSucSuVZ,cplSvcSeVWm,cplSvcSvVZ,cplSucSdVWmVZaa,cplSvcSeVWmVZ1,Amp)

Implicit None

Real(dp), Intent(in) :: MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MVZ,MFd2(3),MFe2(3),            & 
& MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2,MVZ2

Complex(dp), Intent(in) :: cplcFdFdVZL(3,3),cplcFdFdVZR(3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),            & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),               & 
& cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFuFuVZL(3,3),cplcFuFuVZR(3,3),cplFvFvVZL(3,3), & 
& cplFvFvVZR(3,3),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcSdVZ(6,6),cplSdcSecSu(6,6,6),& 
& cplSecSeVZ(6,6),cplSecSecSv(6,6,3),cplSucSdVWm(6,6),cplSucSuVZ(6,6),cplSvcSeVWm(3,6),  & 
& cplSvcSvVZ(3,3),cplSucSdVWmVZaa(6,6),cplSvcSeVWmVZ1(3,6)

Complex(dp), Intent(out) :: Amp(2,6) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
Amp(:,gt1) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MVWm 
Mex3 = MVZ 
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeToVWmVZ


Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocSvVWm(MSe,MSe2,MSv,MSv2,MVWm,               & 
& MVWm2,ZfSe,ZfSv,ZfVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MSe(6),MSe2(6),MSv(3),MSv2(3),MVWm,MVWm2

Complex(dp), Intent(in) :: ZfSe(6,6),ZfSv(3,3),ZfVWm

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Complex(dp) :: coupT1, coupT1L, coupT1R 
Complex(dp) :: TcoupT1, TcoupT1L, TcoupT1R 
Complex(dp) :: ZcoupT1, ZcoupT1L, ZcoupT1R 

Do gt1=1,6
  Do gt2=1,3
! External masses 
Mex1 = MSe(gt1) 
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
End Subroutine Amplitude_WAVE_MSSMTriLnV_SeTocSvVWm


Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocSvVWm(MCha,MChi,MFd,MFe,MFu,              & 
& MSd,MSe,MSu,MSv,MVWm,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,MVWm2,             & 
& cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,         & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSdcSecSu,           & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MCha2(2),       & 
& MChi2(4),MFd2(3),MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),       & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),       & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),           & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),             & 
& cplSecSecSv(6,6,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 


! {Cha, Fv, Fe}
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
ML1 = MCha(i1) 
ML2 = 0. 
ML3 = MFe(i3) 
coup1L = cplFvChacSeL(i2,i1,gt1)
coup1R = cplFvChacSeR(i2,i1,gt1)
coup2L = cplcChaFecSvL(i1,i3,gt2)
coup2R = cplcChaFecSvR(i1,i3,gt2)
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


! {Chi, bar[Fe], Fv}
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
ML1 = MChi(i1) 
ML2 = MFe(i2) 
ML3 = 0. 
coup1L = cplChiFecSeL(i1,i2,gt1)
coup1R = cplChiFecSeR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i1,i3,gt2)
coup2R = cplChiFvcSvR(i1,i3,gt2)
coup3L = cplcFeFvVWmL(i2,i3)
coup3R = cplcFeFvVWmR(i2,i3)
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
coup1L = cplcFuFdcSeL(i2,i1,gt1)
coup1R = cplcFuFdcSeR(i2,i1,gt1)
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
coup1L = cplFvFecSeL(i2,i1,gt1)
coup1R = cplFvFecSeR(i2,i1,gt1)
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


! {Fv, bar[Cha], Chi}
Do i1=1,3
  Do i2=1,2
    Do i3=1,4
ML1 = 0. 
ML2 = MCha(i2) 
ML3 = MChi(i3) 
coup1L = cplFvChacSeL(i1,i2,gt1)
coup1R = cplFvChacSeR(i1,i2,gt1)
coup2L = cplChiFvcSvL(i3,i1,gt2)
coup2R = cplChiFvcSvR(i3,i1,gt2)
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


! {Sd, Su, Sd}
Do i1=1,6
  Do i2=1,6
    Do i3=1,6
ML1 = MSd(i1) 
ML2 = MSu(i2) 
ML3 = MSd(i3) 
coup1 = cplSdcSecSu(i1,gt1,i2)
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
coup1 = cplSecSecSv(i1,gt1,i2)
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
End Subroutine Amplitude_VERTEX_MSSMTriLnV_SeTocSvVWm


Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvVWm(MCha,MChi,MFd,MFe,               & 
& MFu,MSd,MSe,MSu,MSv,MVWm,MCha2,MChi2,MFd2,MFe2,MFu2,MSd2,MSe2,MSu2,MSv2,               & 
& MVWm2,cplFvChacSeL,cplFvChacSeR,cplChiFecSeL,cplChiFecSeR,cplChiFvcSvL,cplChiFvcSvR,   & 
& cplcChaChiVWmL,cplcChaChiVWmR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFuFdcSeL,cplcFuFdcSeR,     & 
& cplFvFecSeL,cplFvFecSeR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplcFdFuVWmL,cplcFdFuVWmR,cplcFeFvVWmL,cplcFeFvVWmR,cplSdcSdcSv,cplSdcSecSu,           & 
& cplSecSecSv,cplSucSdVWm,cplSvcSeVWm,Amp)

Implicit None

Real(dp), Intent(in) :: MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),MSd(6),MSe(6),MSu(6),MSv(3),MVWm,MCha2(2),       & 
& MChi2(4),MFd2(3),MFe2(3),MFu2(3),MSd2(6),MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp), Intent(in) :: cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),      & 
& cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),       & 
& cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),       & 
& cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),           & 
& cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),             & 
& cplSecSecSv(6,6,3),cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

Complex(dp), Intent(out) :: Amp(2,6,3) 

Integer :: i1, i2, i3, gt1, gt2, gt3 
Complex(dp) :: AmpC(2) 
Real(dp) :: Mex1, Mex2, Mex3, ExtRMsq 
Real(dp) :: ML1, ML2, ML3 
Complex(dp) :: coupT1, coupT1L, coupT1R, coup1, coup1L, coup1R 
Complex(dp) :: coup2, coup2L, coup2R, coup3, coup3L, coup3R, coup2a,coup2b,coup2c 
Do gt1=1,6
  Do gt2=1,3
Amp(:,gt1, gt2) = 0._dp 
IRdivOnly =.true. 
! External masses 
Mex1 = MSe(gt1) 
Mex2 = MSv(gt2) 
Mex3 = MVWm 
  End Do
End Do

IRdivOnly =.false. 
End Subroutine Amplitude_IR_VERTEX_MSSMTriLnV_SeTocSvVWm



End Module OneLoopDecay_Se_MSSMTriLnV
