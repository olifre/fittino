! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.12.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 13:02 on 7.2.2018   
! ----------------------------------------------------------------------  
 
 
Module LoopCouplings_MSSMTriLnV 
 
Use Control 
Use Settings 
Use Couplings_MSSMTriLnV 
Use Mathematics 
Use LoopFunctions 
Use StandardModel 
 
 Contains 
 
Real(dp) Function Alpha_MSbar(Q,mW,mt) 
Implicit None 
Real(dp),Intent(in)::Q,mW 
Real(dp),Intent(in),Optional::mt 
Real(dp)::DeltaAlpha 
If (MZ_input) Then 
Alpha_MSbar=Alpha_mZ_MS 
If (Present(mt)) Then 
DeltaAlpha=-8._dp*Log(Q/mt)/(9._dp*Pi) 
Alpha_MSbar=Alpha_MSbar/(1._dp+DeltaAlpha*alpha) 
End If 
Else 
DeltaAlpha=3.5_dp*Log(Q/mW)/Pi+0.5_dp*oo3pi 
If (Present(mt)) DeltaAlpha=DeltaAlpha-8._dp*Log(Q/mt)/(9._dp*Pi) 
Alpha_MSbar=Alpha/(1._dp-Delta_Alpha_Lepton-Delta_Alpha_Hadron& 
&+DeltaAlpha*alpha) 
Alpha_MZ_MS=Alpha_MSbar 
End If 
End Function Alpha_MSbar
 
 
Real(dp) Function AlphaEwDR(Q,MVWm,MSd,MSu,MSe,MHpm,MCha,MFe,MFd,MFu) 
 
Real(dp),Intent(in)::Q,MVWm,MSd(6),MSu(6),MSe(6),MHpm(2),MCha(2),MFe(3),MFd(3),MFu(3)
Integer::i1 
Real(dp)::DeltaAlpha 
If (MZ_input) then 
DeltaAlpha=1._dp-Alpha/Alpha_MZ_MS! MSbar value^=mW+light fermions 
DeltaAlpha=DeltaAlpha+alpha/(6._dp*Pi)*(1._dp-rMS)! conversion to DRbar if necessary 
If (MVWm.gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/3._dp*Log(MVWm/ Q)*Alpha/(2._dp*pi) 
End if 
Do i1=1,6
If (MSd(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/9._dp*Log(MSd(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,6
If (MSu(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/9._dp*Log(MSu(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,6
If (MSe(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/3._dp*Log(MSe(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=2,2
If (MHpm(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/3._dp*Log(MHpm(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,2
If (MCha(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/3._dp*Log(MCha(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,3
If (MFe(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/3._dp*Log(MFe(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,3
If (MFd(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/9._dp*Log(MFd(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,3
If (MFu(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-16._dp/9._dp*Log(MFu(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Else 
DeltaAlpha=7._dp*Log(Q/mW)
If (MVWm.gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MVWm/ Q)
End if 
Do i1=1,6
If (MSd(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/9._dp*Log(MSd(i1)/ Q) 
End if 
End Do 
Do i1=1,6
If (MSu(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/9._dp*Log(MSu(i1)/ Q) 
End if 
End Do 
Do i1=1,6
If (MSe(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MSe(i1)/ Q) 
End if 
End Do 
Do i1=2,2
If (MHpm(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MHpm(i1)/ Q) 
End if 
End Do 
Do i1=1,2
If (MCha(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/3._dp*Log(MCha(i1)/ Q) 
End if 
End Do 
Do i1=1,3
If (MFe(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/3._dp*Log(MFe(i1)/ Q) 
End if 
End Do 
Do i1=1,3
If (MFd(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/9._dp*Log(MFd(i1)/ Q) 
End if 
End Do 
Do i1=1,3
If (MFu(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+16._dp/9._dp*Log(MFu(i1)/ Q) 
End if 
End Do 
DeltaAlpha=Delta_Alpha_Lepton+Delta_Alpha_Hadron& 
    &-alpha*DeltaAlpha/(2._dp*Pi) 
End If 
 
AlphaEwDR=Alpha/(1._dp-DeltaAlpha) 
 
End Function AlphaEwDR 
 
 
Real(dp) Function AlphaSDR(Q,MSd,MSu,MGlu,MFd,MFu) 
Real(dp),Intent(in)::Q,MSd(6),MSu(6),MGlu,MFd(3),MFu(3) 
Integer::i1 
Real(dp)::DeltaAlpha 
DeltaAlpha = 0._dp 
If (rMS.lt.0.5_dp) Then 
DeltaAlpha = 0.5_dp 
End if 
Do i1=1,6
 If (Abs(MSd(i1)/ Q).gt.1._dp) Then 
  DeltaAlpha=DeltaAlpha-1._dp/6._dp*Log(MSd(i1)/ Q) 
 End If 
End Do 
Do i1=1,6
 If (Abs(MSu(i1)/ Q).gt.1._dp) Then 
  DeltaAlpha=DeltaAlpha-1._dp/6._dp*Log(MSu(i1)/ Q) 
 End If 
End Do 
DeltaAlpha=DeltaAlpha-2*Log(MGlu/ Q) 
Do i1=1,3
 If (Abs(MFd(i1)/ Q).gt.1._dp) Then 
  DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFd(i1)/ Q) 
 End If 
End Do 
Do i1=1,3
 If (Abs(MFu(i1)/ Q).gt.1._dp) Then 
  DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFu(i1)/ Q) 
 End If 
End Do 
DeltaAlpha=AlphaS_mZ*DeltaAlpha/(2._dp*Pi) 
AlphaSDR=AlphaS_mZ/(1._dp-DeltaAlpha)
 
End Function AlphaSDR 
Real(dp) Function AlphaEW_T(AlphaEW_In, Q,MVWm,MSd,MSu,MSe,MHpm,MCha,MFe,MFd,MFu) 
 
Real(dp),Intent(in)::AlphaEW_In, Q,MVWm,MSd(6),MSu(6),MSe(6),MHpm(2),MCha(2),MFe(3),MFd(3),MFu(3)
Integer::i1 
Real(dp)::DeltaAlpha 
DeltaAlpha=1._dp/(6._dp)*(1._dp-rMS)! conversion to DRbar if necessary 
Do i1=1,6
DeltaAlpha=DeltaAlpha+1._dp/9._dp*Log(MSd(i1)/ Q) 
End Do 
Do i1=1,6
DeltaAlpha=DeltaAlpha+4._dp/9._dp*Log(MSu(i1)/ Q) 
End Do 
Do i1=1,6
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MSe(i1)/ Q) 
End Do 
Do i1=2,2
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MHpm(i1)/ Q) 
End Do 
Do i1=1,2
DeltaAlpha=DeltaAlpha+4._dp/3._dp*Log(MCha(i1)/ Q) 
End Do 
DeltaAlpha=-AlphaEW_in*DeltaAlpha/(2._dp*Pi) 
AlphaEW_T=AlphaEW_in/(1._dp-DeltaAlpha) 
 
End Function AlphaEW_T 
 
 
Real(dp) Function AlphaS_T(AlphaS_In, Q,MSd,MSu,MGlu,MFd,MFu) 
Real(dp),Intent(in):: AlphaS_In, Q,MSd(6),MSu(6),MGlu,MFd(3),MFu(3) 
Integer::i1 
Real(dp)::DeltaAlpha 
DeltaAlpha=0._dp 
!Conversion to DR bar if necessary 
If (rMS.lt.0.5_dp) Then 
DeltaAlpha=0.5_dp 
End if
Do i1=1,6
DeltaAlpha=DeltaAlpha-1._dp/6._dp*Log(MSd(i1)/ Q) 
End Do 
Do i1=1,6
DeltaAlpha=DeltaAlpha-1._dp/6._dp*Log(MSu(i1)/ Q) 
End Do 
DeltaAlpha=DeltaAlpha-2*Log(MGlu/ Q) 
Do i1=4,3
DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFd(i1)/ Q) 
End Do 
Do i1=4,3
DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFu(i1)/ Q) 
End Do 
DeltaAlpha=AlphaS_In*DeltaAlpha/(2._dp*Pi) 
   AlphaS_T=AlphaS_In/(1._dp-DeltaAlpha)
 
End Function AlphaS_T



Subroutine DeltaVB(sinW2,sinW2_dr,rho,MAh,MCha,MChi,MFd,MFe,MFu,Mhh,MHpm,             & 
& MSd,MSe,MSu,MSv,MVWm,g1,g2,L1,L2,UM,UP,vd,vu,Ye,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,              & 
& ZH,ZN,ZP,ZU,ZUL,ZV,res)

Implicit None 
Real(dp),Intent(in) :: MAh(2),MCha(2),MChi(4),MFd(3),MFe(3),MFu(3),Mhh(2),MHpm(2),MSd(6),MSe(6),             & 
& MSu(6),MSv(3),MVWm,g1,g2,vd,vu,ZA(2,2),ZH(2,2),ZP(2,2)

Complex(dp),Intent(in) :: L1(3,3,3),L2(3,3,3),UM(2,2),UP(2,2),Ye(3,3),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),        & 
& ZEL(3,3),ZER(3,3),ZN(4,4),ZU(6,6),ZUL(3,3),ZV(3,3)

Real(dp) :: MAh2(2),MCha2(2),MChi2(4),MFd2(3),MFe2(3),MFu2(3),Mhh2(2),MHpm2(2),MSd2(6),           & 
& MSe2(6),MSu2(6),MSv2(3),MVWm2

Complex(dp) :: cplAhcHpmVWm(2,2),cplcChaChiVWmL(2,4),cplcChaChiVWmR(2,4),cplcChaFecSvL(2,3,3),       & 
& cplcChaFecSvR(2,3,3),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),cplcFdFeSuL(3,3,6),       & 
& cplcFdFeSuR(3,3,6),cplcFdFuVWmL(3,3),cplcFdFuVWmR(3,3),cplcFdFvSdL(3,3,6),             & 
& cplcFdFvSdR(3,3,6),cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFeChaSvL(3,2,3),        & 
& cplcFeChaSvR(3,2,3),cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFeFdcSuL(3,3,6),       & 
& cplcFeFdcSuR(3,3,6),cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFeFecSvL(3,3,3),         & 
& cplcFeFecSvR(3,3,3),cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFeFeSvL(3,3,3),          & 
& cplcFeFeSvR(3,3,3),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),cplcFeFvSeL(3,3,6),         & 
& cplcFeFvSeR(3,3,6),cplcFeFvVWmL(3,3),cplcFeFvVWmR(3,3),cplChiFecSeL(4,3,6),            & 
& cplChiFecSeR(4,3,6),cplChiFvcSvL(4,3,3),cplChiFvcSvR(4,3,3),cplChiFvSvL(4,3,3),        & 
& cplChiFvSvR(4,3,3),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),cplFvChacSeL(3,2,6),          & 
& cplFvChacSeR(3,2,6),cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplFvFecHpmL(3,3,2),         & 
& cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),cplFvFecVWmL(3,3),           & 
& cplFvFecVWmR(3,3),cplhhcHpmVWm(2,2),cplhhcVWmVWm(2),cplSucSdVWm(6,6),cplSvcSeVWm(3,6)

Integer :: i1,i2,i3,i4,gt1,gt2,gt3,gt4 
Real(dp), Intent(in) :: sinW2,sinW2_Dr, rho 
Real(dp), Intent(out) :: res 
 
Complex(dp) :: sumI, coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,coup3, coup4L,coup4R, teil 
Complex(dp) :: D27m2, D0m2, vertex, phase 
Real(dp) :: cosW2, cosW2_Dr, chargefactor 
Iname = Iname+1
NameOfUnit(Iname) = "DeltaVB" 
MAh2 = MAh**2 
MCha2 = MCha**2 
MChi2 = MChi**2 
MFd2 = MFd**2 
MFe2 = MFe**2 
MFu2 = MFu**2 
Mhh2 = Mhh**2 
MHpm2 = MHpm**2 
MSd2 = MSd**2 
MSe2 = MSe**2 
MSu2 = MSu**2 
MSv2 = MSv**2 
MVWm2 = MVWm**2 

 
 ! Fix neutrino phases 
 
cplcFeFeAhL = 0._dp 
cplcFeFeAhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingcFeFeAhT(gt1,gt2,gt3,Ye,ZA,ZEL,ZER,cplcFeFeAhL(gt1,gt2,gt3)              & 
& ,cplcFeFeAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhcHpmVWm = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 2
Call CouplingAhcHpmVWmT(gt1,gt2,g2,ZA,ZP,cplAhcHpmVWm(gt1,gt2))

 End Do 
End Do 


cplFvChacSeL = 0._dp 
cplFvChacSeR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 2
  Do gt3 = 1, 6
Call CouplingFvChacSeT(gt1,gt2,gt3,g2,Ye,ZE,UM,cplFvChacSeL(gt1,gt2,gt3)              & 
& ,cplFvChacSeR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeChaSvL = 0._dp 
cplcFeChaSvR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 2
  Do gt3 = 1, 3
Call CouplingcFeChaSvT(gt1,gt2,gt3,g2,Ye,ZV,UM,UP,ZEL,ZER,cplcFeChaSvL(gt1,gt2,gt3)   & 
& ,cplcFeChaSvR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplChiFecSeL = 0._dp 
cplChiFecSeR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingChiFecSeT(gt1,gt2,gt3,g1,g2,Ye,ZE,ZN,ZEL,ZER,cplChiFecSeL(gt1,gt2,gt3)   & 
& ,cplChiFecSeR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplChiFvSvL = 0._dp 
cplChiFvSvR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingChiFvSvT(gt1,gt2,gt3,g1,g2,ZV,ZN,cplChiFvSvL(gt1,gt2,gt3),               & 
& cplChiFvSvR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplChiFvcSvL = 0._dp 
cplChiFvcSvR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingChiFvcSvT(gt1,gt2,gt3,g1,g2,ZV,ZN,cplChiFvcSvL(gt1,gt2,gt3)              & 
& ,cplChiFvcSvR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeChiSeL = 0._dp 
cplcFeChiSeR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 6
Call CouplingcFeChiSeT(gt1,gt2,gt3,g1,g2,Ye,ZE,ZN,ZEL,ZER,cplcFeChiSeL(gt1,gt2,gt3)   & 
& ,cplcFeChiSeR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcChaChiVWmL = 0._dp 
cplcChaChiVWmR = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 4
Call CouplingcChaChiVWmT(gt1,gt2,g2,ZN,UM,UP,cplcChaChiVWmL(gt1,gt2),cplcChaChiVWmR(gt1,gt2))

 End Do 
End Do 


cplFvFdcSdL = 0._dp 
cplFvFdcSdR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingFvFdcSdT(gt1,gt2,gt3,L2,ZD,ZDL,ZDR,cplFvFdcSdL(gt1,gt2,gt3)              & 
& ,cplFvFdcSdR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFdcSuL = 0._dp 
cplcFeFdcSuR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingcFeFdcSuT(gt1,gt2,gt3,L2,ZU,ZEL,ZDR,cplcFeFdcSuL(gt1,gt2,gt3)            & 
& ,cplcFeFdcSuR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplFeFucSdL = 0._dp 
cplFeFucSdR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingFeFucSdT(gt1,gt2,gt3,L2,ZD,ZEL,ZUL,cplFeFucSdL(gt1,gt2,gt3)              & 
& ,cplFeFucSdR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplFvFecHpmL = 0._dp 
cplFvFecHpmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingFvFecHpmT(gt1,gt2,gt3,Ye,ZP,ZER,cplFvFecHpmL(gt1,gt2,gt3),               & 
& cplFvFecHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplFvFecSeL = 0._dp 
cplFvFecSeR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingFvFecSeT(gt1,gt2,gt3,L1,ZE,ZEL,ZER,cplFvFecSeL(gt1,gt2,gt3)              & 
& ,cplFvFecSeR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplFvFecVWmL = 0._dp 
cplFvFecVWmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingFvFecVWmT(gt1,gt2,g2,ZEL,cplFvFecVWmL(gt1,gt2),cplFvFecVWmR(gt1,gt2))

 End Do 
End Do 


cplcFeFehhL = 0._dp 
cplcFeFehhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingcFeFehhT(gt1,gt2,gt3,Ye,ZH,ZEL,ZER,cplcFeFehhL(gt1,gt2,gt3)              & 
& ,cplcFeFehhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFeSuL = 0._dp 
cplcFdFeSuR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingcFdFeSuT(gt1,gt2,gt3,L2,ZU,ZEL,ZDR,cplcFdFeSuL(gt1,gt2,gt3)              & 
& ,cplcFdFeSuR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFeSvL = 0._dp 
cplcFeFeSvR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFeSvT(gt1,gt2,gt3,L1,ZV,ZEL,ZER,cplcFeFeSvL(gt1,gt2,gt3)              & 
& ,cplcFeFeSvR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcChaFecSvL = 0._dp 
cplcChaFecSvR = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcChaFecSvT(gt1,gt2,gt3,g2,Ye,ZV,UM,UP,ZEL,ZER,cplcChaFecSvL(gt1,gt2,gt3) & 
& ,cplcChaFecSvR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFecSvL = 0._dp 
cplcFeFecSvR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFecSvT(gt1,gt2,gt3,L1,ZV,ZEL,ZER,cplcFeFecSvL(gt1,gt2,gt3)            & 
& ,cplcFeFecSvR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFuVWmL = 0._dp 
cplcFdFuVWmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFdFuVWmT(gt1,gt2,g2,ZDL,ZUL,cplcFdFuVWmL(gt1,gt2),cplcFdFuVWmR(gt1,gt2))

 End Do 
End Do 


cplcFeFvHpmL = 0._dp 
cplcFeFvHpmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingcFeFvHpmT(gt1,gt2,gt3,Ye,ZP,ZER,cplcFeFvHpmL(gt1,gt2,gt3),               & 
& cplcFeFvHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFvSdL = 0._dp 
cplcFdFvSdR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingcFdFvSdT(gt1,gt2,gt3,L2,ZD,ZDL,ZDR,cplcFdFvSdL(gt1,gt2,gt3)              & 
& ,cplcFdFvSdR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcChaFvSeL = 0._dp 
cplcChaFvSeR = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingcChaFvSeT(gt1,gt2,gt3,g2,Ye,ZE,UM,cplcChaFvSeL(gt1,gt2,gt3)              & 
& ,cplcChaFvSeR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFvSeL = 0._dp 
cplcFeFvSeR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingcFeFvSeT(gt1,gt2,gt3,L1,ZE,ZEL,ZER,cplcFeFvSeL(gt1,gt2,gt3)              & 
& ,cplcFeFvSeR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFvVWmL = 0._dp 
cplcFeFvVWmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFvVWmT(gt1,gt2,g2,ZEL,cplcFeFvVWmL(gt1,gt2),cplcFeFvVWmR(gt1,gt2))

 End Do 
End Do 


cplhhcHpmVWm = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 2
Call CouplinghhcHpmVWmT(gt1,gt2,g2,ZH,ZP,cplhhcHpmVWm(gt1,gt2))

 End Do 
End Do 


cplhhcVWmVWm = 0._dp 
Do gt1 = 1, 2
Call CouplinghhcVWmVWmT(gt1,g2,vd,vu,ZH,cplhhcVWmVWm(gt1))

End Do 


cplcFecFuSdL = 0._dp 
cplcFecFuSdR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 6
Call CouplingcFecFuSdT(gt1,gt2,gt3,L2,ZD,ZEL,ZUL,cplcFecFuSdL(gt1,gt2,gt3)            & 
& ,cplcFecFuSdR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplSucSdVWm = 0._dp 
Do gt1 = 1, 6
 Do gt2 = 1, 6
Call CouplingSucSdVWmT(gt1,gt2,g2,ZD,ZU,cplSucSdVWm(gt1,gt2))

 End Do 
End Do 


cplSvcSeVWm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 6
Call CouplingSvcSeVWmT(gt1,gt2,g2,ZV,ZE,cplSvcSeVWm(gt1,gt2))

 End Do 
End Do 


!-------------------------- 
!SM Contributions 
!-------------------------- 
cosW2 = 1._dp - sinW2 
cosW2_DR = 1._dp - sinW2_DR 
sumI = 6._dp & 
  & + Log(cosW2)*(3.5_dp - 2.5_dp *sinW2   & 
  & - sinW2_DR*(5._dp - 1.5_dp*cosW2/cosW2_DR))/sinW2   
res = sumI*g2**2*rho 
 
 
If (IncludeBSMdeltaVB) Then 
!-------------------------- 
!BSM  Contributions 
!-------------------------- 
teil = 0._dp 
 
Do gt1=1,3 
 Do gt2=1,3 
sumI = 0._dp 
 
chargefactor = 1 
Do i1=1,2
  Do i2=1,6
If ((MCha2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i1,i2)
coup1R = cplFvChacSeR(gt1,i1,i2)
coup2R = Conjg(cplFvChacSeL(gt2,i1,i2))
coup2L = Conjg(cplFvChacSeR(gt2,i1,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MCha2(i1),MSe2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,4
  Do i2=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2))) Then
coup1L = cplChiFvSvL(i1,gt1,i2)
coup1R = cplChiFvSvR(i1,gt1,i2)
coup2R = Conjg(cplChiFvSvL(i1,gt2,i2))
coup2L = Conjg(cplChiFvSvR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MChi2(i1),MSv2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,4
  Do i2=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i1,gt1,i2)
coup1R = cplChiFvcSvR(i1,gt1,i2)
coup2R = Conjg(cplChiFvcSvL(i1,gt2,i2))
coup2L = Conjg(cplChiFvcSvR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MChi2(i1),MSv2(i2))  
End if 
   End Do
  End Do




chargefactor = 3 
Do i1=1,3
  Do i2=1,6
If ((MFd2(i1).gt.mf_l2(2)).Or.(MSd2(i2).gt.mf_l2(2))) Then
coup1L = cplFvFdcSdL(gt1,i1,i2)
coup1R = cplFvFdcSdR(gt1,i1,i2)
coup2R = Conjg(cplFvFdcSdL(gt2,i1,i2))
coup2L = Conjg(cplFvFdcSdR(gt2,i1,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFd2(i1),MSd2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,2
If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i1,i2)
coup1R = cplFvFecHpmR(gt1,i1,i2)
coup2R = Conjg(cplFvFecHpmL(gt2,i1,i2))
coup2L = Conjg(cplFvFecHpmR(gt2,i1,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i1),MHpm2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,6
If ((MFe2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i1,i2)
coup1R = cplFvFecSeR(gt1,i1,i2)
coup2R = Conjg(cplFvFecSeL(gt2,i1,i2))
coup2L = Conjg(cplFvFecSeR(gt2,i1,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i1),MSe2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,2
  Do i2=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFvHpmL(i2,gt1,i1)
coup1R = cplcFeFvHpmR(i2,gt1,i1)
coup2R = Conjg(cplcFeFvHpmL(i2,gt2,i1))
coup2L = Conjg(cplcFeFvHpmR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),MHpm2(i1))  
End if 
   End Do
  End Do




chargefactor = 3 
Do i1=1,6
  Do i2=1,3
If ((MSd2(i1).gt.mf_l2(2)).Or.(MFd2(i2).gt.mf_l2(2))) Then
coup1L = cplcFdFvSdL(i2,gt1,i1)
coup1R = cplcFdFvSdR(i2,gt1,i1)
coup2R = Conjg(cplcFdFvSdL(i2,gt2,i1))
coup2L = Conjg(cplcFdFvSdR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFd2(i2),MSd2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,6
  Do i2=1,2
If ((MSe2(i1).gt.mf_l2(2)).Or.(MCha2(i2).gt.mf_l2(2))) Then
coup1L = cplcChaFvSeL(i2,gt1,i1)
coup1R = cplcChaFvSeR(i2,gt1,i1)
coup2R = Conjg(cplcChaFvSeL(i2,gt2,i1))
coup2L = Conjg(cplcChaFvSeR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MCha2(i2),MSe2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,6
  Do i2=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFvSeL(i2,gt1,i1)
coup1R = cplcFeFvSeR(i2,gt1,i1)
coup2R = Conjg(cplcFeFvSeL(i2,gt2,i1))
coup2L = Conjg(cplcFeFvSeR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),MSe2(i1))  
End if 
   End Do
  End Do




res = res + sumI*(Kronecker(gt2,1)+Kronecker(gt2,2)) 
End Do 
 
End Do 
 
Do gt1=1,2 
Do  gt2=1,3 
sumI = 0._dp 
 
chargefactor = 1 
Do i1=1,2
  Do i2=1,3
If ((MAh2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFeAhL(i2,gt1,i1)
coup1R = cplcFeFeAhR(i2,gt1,i1)
coup2R = Conjg(cplcFeFeAhL(i2,gt2,i1))
coup2L = Conjg(cplcFeFeAhR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),MAh2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,4
  Do i2=1,6
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2))) Then
coup1L = cplChiFecSeL(i1,gt1,i2)
coup1R = cplChiFecSeR(i1,gt1,i2)
coup2R = Conjg(cplChiFecSeL(i1,gt2,i2))
coup2L = Conjg(cplChiFecSeR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MChi2(i1),MSe2(i2))  
End if 
   End Do
  End Do




chargefactor = 3 
Do i1=1,3
  Do i2=1,6
If ((MFu2(i1).gt.mf_l2(2)).Or.(MSd2(i2).gt.mf_l2(2))) Then
coup1L = cplFeFucSdL(gt1,i1,i2)
coup1R = cplFeFucSdR(gt1,i1,i2)
coup2R = Conjg(cplFeFucSdL(gt2,i1,i2))
coup2L = Conjg(cplFeFucSdR(gt2,i1,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFu2(i1),MSd2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,2
If ((0._dp.gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(i1,gt1,i2)
coup1R = cplFvFecHpmR(i1,gt1,i2)
coup2R = Conjg(cplFvFecHpmL(i1,gt2,i2))
coup2L = Conjg(cplFvFecHpmR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,0._dp,MHpm2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,6
If ((0._dp.gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(i1,gt1,i2)
coup1R = cplFvFecSeR(i1,gt1,i2)
coup2R = Conjg(cplFvFecSeL(i1,gt2,i2))
coup2L = Conjg(cplFvFecSeR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,0._dp,MSe2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,2
  Do i2=1,3
If ((Mhh2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFehhL(i2,gt1,i1)
coup1R = cplcFeFehhR(i2,gt1,i1)
coup2R = Conjg(cplcFeFehhL(i2,gt2,i1))
coup2L = Conjg(cplcFeFehhR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),Mhh2(i1))  
End if 
   End Do
  End Do




chargefactor = 3 
Do i1=1,6
  Do i2=1,3
If ((MSu2(i1).gt.mf_l2(2)).Or.(MFd2(i2).gt.mf_l2(2))) Then
coup1L = cplcFdFeSuL(i2,gt1,i1)
coup1R = cplcFdFeSuR(i2,gt1,i1)
coup2R = Conjg(cplcFdFeSuL(i2,gt2,i1))
coup2L = Conjg(cplcFdFeSuR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFd2(i2),MSu2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,3
If ((MSv2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFeSvL(i2,gt1,i1)
coup1R = cplcFeFeSvR(i2,gt1,i1)
coup2R = Conjg(cplcFeFeSvL(i2,gt2,i1))
coup2L = Conjg(cplcFeFeSvR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),MSv2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,2
  Do i2=1,3
If ((MCha2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2))) Then
coup1L = cplcChaFecSvL(i1,gt1,i2)
coup1R = cplcChaFecSvR(i1,gt1,i2)
coup2R = Conjg(cplcChaFecSvL(i1,gt2,i2))
coup2L = Conjg(cplcChaFecSvR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MCha2(i1),MSv2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,3
If ((MFe2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFecSvL(i1,gt1,i2)
coup1R = cplcFeFecSvR(i1,gt1,i2)
coup2R = Conjg(cplcFeFecSvL(i1,gt2,i2))
coup2L = Conjg(cplcFeFecSvR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i1),MSv2(i2))  
End if 
   End Do
  End Do




res = res + sumI 
End Do 
 
End Do 
 
vertex = 0._dp 
 
Do gt1=1,3 
 Do gt2=1,2 
chargefactor = 1 
Do i1= 1,4
  Do i2= 1,3
   Do i3= 1,6
  If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2)).Or.(MSe2(i3).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i1,gt1,i2)
coup1R = cplChiFvcSvR(i1,gt1,i2)
coup2L = cplcFeChiSeL(gt2,i1,i3)
coup2R = cplcFeChiSeR(gt2,i1,i3)
coup3 = cplSvcSeVWm(i2,i3)
vertex = vertex + chargefactor*(0.5_dp*sqrt2*coup1L*coup2R*coup3*(MChi2(i1)*C0_3m(MChi2(i1),MSv2(i2),MSe2(i3)) + B0(0._dp,MSv2(i2),MSe2(i3)) +0.5_dp)) 
End if 
   End Do
  End Do
End Do


chargefactor = 3 
Do i1= 1,3
  Do i2= 1,6
   Do i3= 1,6
  If ((MFd2(i1).gt.mf_l2(2)).Or.(MSd2(i2).gt.mf_l2(2)).Or.(MSu2(i3).gt.mf_l2(2))) Then
coup1L = cplcFdFvSdL(i1,gt1,i2)
coup1R = cplcFdFvSdR(i1,gt1,i2)
coup2L = cplcFeFdcSuL(gt2,i1,i3)
coup2R = cplcFeFdcSuR(gt2,i1,i3)
coup3 = -cplSucSdVWm(i3,i2)
vertex = vertex + chargefactor*(0.5_dp*sqrt2*coup1L*coup2R*coup3*(MFd2(i1)*C0_3m(MFd2(i1),MSd2(i2),MSu2(i3)) + B0(0._dp,MSd2(i2),MSu2(i3)) +0.5_dp)) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,3
  Do i2= 1,2
   Do i3= 1,2
  If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2)).Or.(MAh2(i3).gt.mf_l2(2))) Then
coup1L = cplcFeFvHpmL(i1,gt1,i2)
coup1R = cplcFeFvHpmR(i1,gt1,i2)
coup2L = cplcFeFeAhL(gt2,i1,i3)
coup2R = cplcFeFeAhR(gt2,i1,i3)
coup3 = -cplAhcHpmVWm(i3,i2)
vertex = vertex + chargefactor*(0.5_dp*sqrt2*coup1L*coup2R*coup3*(MFe2(i1)*C0_3m(MFe2(i1),MHpm2(i2),MAh2(i3)) + B0(0._dp,MHpm2(i2),MAh2(i3)) +0.5_dp)) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,3
  Do i2= 1,2
   Do i3= 1,2
  If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2)).Or.(Mhh2(i3).gt.mf_l2(2))) Then
coup1L = cplcFeFvHpmL(i1,gt1,i2)
coup1R = cplcFeFvHpmR(i1,gt1,i2)
coup2L = cplcFeFehhL(gt2,i1,i3)
coup2R = cplcFeFehhR(gt2,i1,i3)
coup3 = -cplhhcHpmVWm(i3,i2)
vertex = vertex + chargefactor*(0.5_dp*sqrt2*coup1L*coup2R*coup3*(MFe2(i1)*C0_3m(MFe2(i1),MHpm2(i2),Mhh2(i3)) + B0(0._dp,MHpm2(i2),Mhh2(i3)) +0.5_dp)) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,3
   Do i3= 1,2
  If ((MFe2(i1).gt.mf_l2(2)).Or.(MVWm2.gt.mf_l2(2)).Or.(Mhh2(i3).gt.mf_l2(2))) Then
coup1L = cplcFeFvVWmL(i1,gt1)
coup1R = cplcFeFvVWmR(i1,gt1)
coup2L = cplcFeFehhL(gt2,i1,i3)
coup2R = cplcFeFehhR(gt2,i1,i3)
coup3 = cplhhcVWmVWm(i3)
End if 
   End Do
End Do


chargefactor = 1 
Do i1= 1,3
  Do i2= 1,6
   Do i3= 1,3
  If ((MFe2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2))) Then
coup1L = cplcFeFvSeL(i1,gt1,i2)
coup1R = cplcFeFvSeR(i1,gt1,i2)
coup2L = cplcFeFecSvL(gt2,i1,i3)
coup2R = cplcFeFecSvR(gt2,i1,i3)
coup3 = -cplSvcSeVWm(i3,i2)
vertex = vertex + chargefactor*(0.5_dp*sqrt2*coup1L*coup2R*coup3*(MFe2(i1)*C0_3m(MFe2(i1),MSe2(i2),MSv2(i3)) + B0(0._dp,MSe2(i2),MSv2(i3)) +0.5_dp)) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,2
  Do i2= 1,3
   Do i3= 1,3
  If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i2,i1)
coup1R = cplFvFecHpmR(gt1,i2,i1)
coup2L = cplcFeFvHpmL(gt2,i3,i1)
coup2R = cplcFeFvHpmR(gt2,i3,i1)
coup3L = cplcFeFvVWmL(i2,i3)
coup3R = cplcFeFvVWmR(i2,i3)
vertex = vertex + chargefactor*(coup1L*coup2R*(-sqrt2*coup3R*MFe(i2)*0.& 
& *C0_3m(MHpm2(i1),MFe2(i2),0._dp) + oosqrt2*coup3L* & 
& (B0(0._dp,MFe2(i2),0._dp)-0.5_dp +MHpm2(i1)*C0_3m(MHpm2(i1),MFe2(i2),0._dp)))) 
End if 
   End Do
  End Do
End Do


chargefactor = 3 
Do i1= 1,6
  Do i2= 1,3
   Do i3= 1,3
  If ((MSd2(i1).gt.mf_l2(2)).Or.(MFd2(i2).gt.mf_l2(2)).Or.(MFu2(i3).gt.mf_l2(2))) Then
coup1L = cplFvFdcSdL(gt1,i2,i1)
coup1R = cplFvFdcSdR(gt1,i2,i1)
coup2L = cplcFecFuSdL(gt2,i3,i1)
coup2R = cplcFecFuSdR(gt2,i3,i1)
coup3L = cplcFdFuVWmL(i2,i3)
coup3R = cplcFdFuVWmR(i2,i3)
vertex = vertex + chargefactor*(coup1L*coup2R*(-sqrt2*coup3R*MFd(i2)*MFu(i3)& 
& *C0_3m(MSd2(i1),MFd2(i2),MFu2(i3)) + oosqrt2*coup3L* & 
& (B0(0._dp,MFd2(i2),MFu2(i3))-0.5_dp +MSd2(i1)*C0_3m(MSd2(i1),MFd2(i2),MFu2(i3))))) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,6
  Do i2= 1,2
   Do i3= 1,4
  If ((MSe2(i1).gt.mf_l2(2)).Or.(MCha2(i2).gt.mf_l2(2)).Or.(MChi2(i3).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i2,i1)
coup1R = cplFvChacSeR(gt1,i2,i1)
coup2L = cplcFeChiSeL(gt2,i3,i1)
coup2R = cplcFeChiSeR(gt2,i3,i1)
coup3L = cplcChaChiVWmL(i2,i3)
coup3R = cplcChaChiVWmR(i2,i3)
vertex = vertex + chargefactor*(coup1L*coup2R*(-sqrt2*coup3R*MCha(i2)*MChi(i3)& 
& *C0_3m(MSe2(i1),MCha2(i2),MChi2(i3)) + oosqrt2*coup3L* & 
& (B0(0._dp,MCha2(i2),MChi2(i3))-0.5_dp +MSe2(i1)*C0_3m(MSe2(i1),MCha2(i2),MChi2(i3))))) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,6
  Do i2= 1,3
   Do i3= 1,3
  If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i2,i1)
coup1R = cplFvFecSeR(gt1,i2,i1)
coup2L = cplcFeFvSeL(gt2,i3,i1)
coup2R = cplcFeFvSeR(gt2,i3,i1)
coup3L = cplcFeFvVWmL(i2,i3)
coup3R = cplcFeFvVWmR(i2,i3)
vertex = vertex + chargefactor*(coup1L*coup2R*(-sqrt2*coup3R*MFe(i2)*0.& 
& *C0_3m(MSe2(i1),MFe2(i2),0._dp) + oosqrt2*coup3L* & 
& (B0(0._dp,MFe2(i2),0._dp)-0.5_dp +MSe2(i1)*C0_3m(MSe2(i1),MFe2(i2),0._dp)))) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
Do i1= 1,3
  Do i2= 1,4
   Do i3= 1,2
  If ((MSv2(i1).gt.mf_l2(2)).Or.(MChi2(i2).gt.mf_l2(2)).Or.(MCha2(i3).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i2,gt1,i1)
coup1R = cplChiFvcSvR(i2,gt1,i1)
coup2L = cplcFeChaSvL(gt2,i3,i1)
coup2R = cplcFeChaSvR(gt2,i3,i1)
coup3L = -cplcChaChiVWmR(i3,i2)
coup3R = -cplcChaChiVWmL(i3,i2)
vertex = vertex + chargefactor*(coup1L*coup2R*(-sqrt2*coup3R*MChi(i2)*MCha(i3)& 
& *C0_3m(MSv2(i1),MChi2(i2),MCha2(i3)) + oosqrt2*coup3L* & 
& (B0(0._dp,MChi2(i2),MCha2(i3))-0.5_dp +MSv2(i1)*C0_3m(MSv2(i1),MChi2(i2),MCha2(i3))))) 
End if 
   End Do
  End Do
End Do


chargefactor = 1 
  Do i2= 1,3
   Do i3= 1,3
  If ((MVWm2.gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2))) Then
coup1L = cplFvFecVWmL(gt1,i2)
coup1R = cplFvFecVWmR(gt1,i2)
coup2L = cplcFeFvVWmL(gt2,i3)
coup2R = cplcFeFvVWmR(gt2,i3)
coup3L = cplcFeFvVWmL(i2,i3)
coup3R = cplcFeFvVWmR(i2,i3)
End if 
  End Do
End Do


 End Do 
 
End Do 
 
res = res + vertex/g2 
Do gt1=1,3 
 Do gt2=1,3 
gt3 = 2 
gt4 = 1 
! Cha,Se,Chi,Se
chargefactor = 1 
Do i1=1,2
  Do i2=1,6
    Do i3=1,4
      Do i4=1,6
If ((MCha2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2)).Or.(MChi2(i3).gt.mf_l2(2)).Or.(MSe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i1,i4)
coup1R = cplFvChacSeR(gt1,i1,i4)
coup2L = cplcChaFvSeL(i1,gt2,i2)
coup2R = cplcChaFvSeR(i1,gt2,i2)
coup3L = cplChiFecSeL(i3,gt3,i2)
coup3R = cplChiFecSeR(i3,gt3,i2)
coup4L = cplcFeChiSeL(gt4,i3,i4)
coup4R = cplcFeChiSeR(gt4,i3,i4)
D27m2 = D27_Bagger(MSe2(i2),MSe2(i4),MCha2(i1),MChi2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Cha,Se,Fv,Se
chargefactor = 1 
Do i1=1,2
  Do i2=1,6
    Do i3=1,3
      Do i4=1,6
If ((MCha2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MSe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i1,i4)
coup1R = cplFvChacSeR(gt1,i1,i4)
coup2L = cplcChaFvSeL(i1,gt2,i2)
coup2R = cplcChaFvSeR(i1,gt2,i2)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
coup4L = cplcFeFvSeL(gt4,i3,i4)
coup4R = cplcFeFvSeR(gt4,i3,i4)
D27m2 = D27_Bagger(MSe2(i2),MSe2(i4),MCha2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Chi,Sv,bar[Cha],Sv
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,2
      Do i4=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2)).Or.(MCha2(i3).gt.mf_l2(2)).Or.(MSv2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i1,gt1,i4)
coup1R = cplChiFvcSvR(i1,gt1,i4)
coup2L = cplChiFvSvL(i1,gt2,i2)
coup2R = cplChiFvSvR(i1,gt2,i2)
coup3L = cplcChaFecSvL(i3,gt3,i2)
coup3R = cplcChaFecSvR(i3,gt3,i2)
coup4L = cplcFeChaSvL(gt4,i3,i4)
coup4R = cplcFeChaSvR(gt4,i3,i4)
D27m2 = D27_Bagger(MSv2(i2),MSv2(i4),MChi2(i1),MCha2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Chi,Sv,bar[Fe],Sv
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2)).Or.(MFe2(i3).gt.mf_l2(2)).Or.(MSv2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i1,gt1,i4)
coup1R = cplChiFvcSvR(i1,gt1,i4)
coup2L = cplChiFvSvL(i1,gt2,i2)
coup2R = cplChiFvSvR(i1,gt2,i2)
coup3L = cplcFeFecSvL(i3,gt3,i2)
coup3R = cplcFeFecSvR(i3,gt3,i2)
coup4L = cplcFeFeSvL(gt4,i3,i4)
coup4R = cplcFeFeSvR(gt4,i3,i4)
D27m2 = D27_Bagger(MSv2(i2),MSv2(i4),MChi2(i1),MFe2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Chi,Sv,bar[Fe],conj[Sv]
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2)).Or.(MFe2(i3).gt.mf_l2(2)).Or.(MSv2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvSvL(i1,gt1,i4)
coup1R = cplChiFvSvR(i1,gt1,i4)
coup2L = cplChiFvSvL(i1,gt2,i2)
coup2R = cplChiFvSvR(i1,gt2,i2)
coup3L = cplcFeFecSvL(i3,gt3,i2)
coup3R = cplcFeFecSvR(i3,gt3,i2)
coup4L = cplcFeFecSvL(gt4,i3,i4)
coup4R = cplcFeFecSvR(gt4,i3,i4)
D27m2 = D27_Bagger(MSv2(i2),MSv2(i4),MChi2(i1),MFe2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Chi,conj[Sv],bar[Fe],Sv
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2)).Or.(MFe2(i3).gt.mf_l2(2)).Or.(MSv2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i1,gt1,i4)
coup1R = cplChiFvcSvR(i1,gt1,i4)
coup2L = cplChiFvcSvL(i1,gt2,i2)
coup2R = cplChiFvcSvR(i1,gt2,i2)
coup3L = cplcFeFeSvL(i3,gt3,i2)
coup3R = cplcFeFeSvR(i3,gt3,i2)
coup4L = cplcFeFeSvL(gt4,i3,i4)
coup4R = cplcFeFeSvR(gt4,i3,i4)
D27m2 = D27_Bagger(MSv2(i2),MSv2(i4),MChi2(i1),MFe2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Chi,conj[Sv],bar[Fe],conj[Sv]
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MChi2(i1).gt.mf_l2(2)).Or.(MSv2(i2).gt.mf_l2(2)).Or.(MFe2(i3).gt.mf_l2(2)).Or.(MSv2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvSvL(i1,gt1,i4)
coup1R = cplChiFvSvR(i1,gt1,i4)
coup2L = cplChiFvcSvL(i1,gt2,i2)
coup2R = cplChiFvcSvR(i1,gt2,i2)
coup3L = cplcFeFeSvL(i3,gt3,i2)
coup3R = cplcFeFeSvR(i3,gt3,i2)
coup4L = cplcFeFecSvL(gt4,i3,i4)
coup4R = cplcFeFecSvR(gt4,i3,i4)
D27m2 = D27_Bagger(MSv2(i2),MSv2(i4),MChi2(i1),MFe2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fd,Sd,Fu,Sd
chargefactor = 3 
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
      Do i4=1,6
If ((MFd2(i1).gt.mf_l2(2)).Or.(MSd2(i2).gt.mf_l2(2)).Or.(MFu2(i3).gt.mf_l2(2)).Or.(MSd2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFdcSdL(gt1,i1,i4)
coup1R = cplFvFdcSdR(gt1,i1,i4)
coup2L = cplcFdFvSdL(i1,gt2,i2)
coup2R = cplcFdFvSdR(i1,gt2,i2)
coup3L = cplFeFucSdL(gt3,i3,i2)
coup3R = cplFeFucSdR(gt3,i3,i2)
coup4L = cplcFecFuSdL(gt4,i3,i4)
coup4R = cplcFecFuSdR(gt4,i3,i4)
D27m2 = D27_Bagger(MSd2(i2),MSd2(i4),MFd2(i1),MFu2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fe,Hpm,Fv,Hpm
chargefactor = 1 
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
      Do i4=1,2
If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MHpm2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i1,i4)
coup1R = cplFvFecHpmR(gt1,i1,i4)
coup2L = cplcFeFvHpmL(i1,gt2,i2)
coup2R = cplcFeFvHpmR(i1,gt2,i2)
coup3L = cplFvFecHpmL(i3,gt3,i2)
coup3R = cplFvFecHpmR(i3,gt3,i2)
coup4L = cplcFeFvHpmL(gt4,i3,i4)
coup4R = cplcFeFvHpmR(gt4,i3,i4)
D27m2 = D27_Bagger(MHpm2(i2),MHpm2(i4),MFe2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fe,Hpm,Fv,Se
chargefactor = 1 
Do i1=1,3
  Do i2=1,2
    Do i3=1,3
      Do i4=1,6
If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MSe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i1,i4)
coup1R = cplFvFecSeR(gt1,i1,i4)
coup2L = cplcFeFvHpmL(i1,gt2,i2)
coup2R = cplcFeFvHpmR(i1,gt2,i2)
coup3L = cplFvFecHpmL(i3,gt3,i2)
coup3R = cplFvFecHpmR(i3,gt3,i2)
coup4L = cplcFeFvSeL(gt4,i3,i4)
coup4R = cplcFeFvSeR(gt4,i3,i4)
D27m2 = D27_Bagger(MHpm2(i2),MSe2(i4),MFe2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fe,Se,Chi,Se
chargefactor = 1 
Do i1=1,3
  Do i2=1,6
    Do i3=1,4
      Do i4=1,6
If ((MFe2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2)).Or.(MChi2(i3).gt.mf_l2(2)).Or.(MSe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i1,i4)
coup1R = cplFvFecSeR(gt1,i1,i4)
coup2L = cplcFeFvSeL(i1,gt2,i2)
coup2R = cplcFeFvSeR(i1,gt2,i2)
coup3L = cplChiFecSeL(i3,gt3,i2)
coup3R = cplChiFecSeR(i3,gt3,i2)
coup4L = cplcFeChiSeL(gt4,i3,i4)
coup4R = cplcFeChiSeR(gt4,i3,i4)
D27m2 = D27_Bagger(MSe2(i2),MSe2(i4),MFe2(i1),MChi2(i3))
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fe,Se,Fv,Hpm
chargefactor = 1 
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
      Do i4=1,2
If ((MFe2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MHpm2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i1,i4)
coup1R = cplFvFecHpmR(gt1,i1,i4)
coup2L = cplcFeFvSeL(i1,gt2,i2)
coup2R = cplcFeFvSeR(i1,gt2,i2)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
coup4L = cplcFeFvHpmL(gt4,i3,i4)
coup4R = cplcFeFvHpmR(gt4,i3,i4)
D27m2 = D27_Bagger(MSe2(i2),MHpm2(i4),MFe2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fe,Se,Fv,Se
chargefactor = 1 
Do i1=1,3
  Do i2=1,6
    Do i3=1,3
      Do i4=1,6
If ((MFe2(i1).gt.mf_l2(2)).Or.(MSe2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MSe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i1,i4)
coup1R = cplFvFecSeR(gt1,i1,i4)
coup2L = cplcFeFvSeL(i1,gt2,i2)
coup2R = cplcFeFvSeR(i1,gt2,i2)
coup3L = cplFvFecSeL(i3,gt3,i2)
coup3R = cplFvFecSeR(i3,gt3,i2)
coup4L = cplcFeFvSeL(gt4,i3,i4)
coup4R = cplcFeFvSeR(gt4,i3,i4)
D27m2 = D27_Bagger(MSe2(i2),MSe2(i4),MFe2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Sv,Chi,Se,Chi
chargefactor = 1 
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
      Do i4=1,4
If ((MSv2(i1).gt.mf_l2(2)).Or.(MChi2(i2).gt.mf_l2(2)).Or.(MSe2(i3).gt.mf_l2(2)).Or.(MChi2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvSvL(i4,gt1,i1)
coup1R = cplChiFvSvR(i4,gt1,i1)
coup2L = cplChiFvcSvL(i2,gt2,i1)
coup2R = cplChiFvcSvR(i2,gt2,i1)
coup3L = cplcFeChiSeL(gt4,i2,i3)
coup3R = cplcFeChiSeR(gt4,i2,i3)
coup4L = cplChiFecSeL(i4,gt3,i3)
coup4R = cplChiFecSeR(i4,gt3,i3)
D0m2 = D0_Bagger(MSv2(i1),MSe2(i3),MChi2(i2),MChi2(i4))*MChi(i2)*MChi(i4) 
D27m2 = D27_Bagger(MSv2(i1),MSe2(i3),MChi2(i2),MChi2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Hpm],bar[Fe],Ah,bar[Fe]
chargefactor = 1 
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MAh2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i4,i1)
coup1R = cplFvFecHpmR(gt1,i4,i1)
coup2L = cplcFeFvHpmL(i2,gt2,i1)
coup2R = cplcFeFvHpmR(i2,gt2,i1)
coup3L = cplcFeFeAhL(gt4,i2,i3)
coup3R = cplcFeFeAhR(gt4,i2,i3)
coup4L = cplcFeFeAhL(i4,gt3,i3)
coup4R = cplcFeFeAhR(i4,gt3,i3)
D0m2 = D0_Bagger(MHpm2(i1),MAh2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MHpm2(i1),MAh2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Hpm],bar[Fe],hh,bar[Fe]
chargefactor = 1 
Do i1=1,2
  Do i2=1,3
    Do i3=1,2
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(Mhh2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i4,i1)
coup1R = cplFvFecHpmR(gt1,i4,i1)
coup2L = cplcFeFvHpmL(i2,gt2,i1)
coup2R = cplcFeFvHpmR(i2,gt2,i1)
coup3L = cplcFeFehhL(gt4,i2,i3)
coup3R = cplcFeFehhR(gt4,i2,i3)
coup4L = cplcFeFehhL(i4,gt3,i3)
coup4R = cplcFeFehhR(i4,gt3,i3)
D0m2 = D0_Bagger(MHpm2(i1),Mhh2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MHpm2(i1),Mhh2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Hpm],bar[Fe],Sv,bar[Fe]
chargefactor = 1 
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i4,i1)
coup1R = cplFvFecHpmR(gt1,i4,i1)
coup2L = cplcFeFvHpmL(i2,gt2,i1)
coup2R = cplcFeFvHpmR(i2,gt2,i1)
coup3L = cplcFeFeSvL(gt4,i2,i3)
coup3R = cplcFeFeSvR(gt4,i2,i3)
coup4L = cplcFeFecSvL(i4,gt3,i3)
coup4R = cplcFeFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MHpm2(i1),MSv2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MHpm2(i1),MSv2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Hpm],bar[Fe],conj[Sv],bar[Fe]
chargefactor = 1 
Do i1=1,2
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecHpmL(gt1,i4,i1)
coup1R = cplFvFecHpmR(gt1,i4,i1)
coup2L = cplcFeFvHpmL(i2,gt2,i1)
coup2R = cplcFeFvHpmR(i2,gt2,i1)
coup3L = cplcFeFecSvL(gt4,i2,i3)
coup3R = cplcFeFecSvR(gt4,i2,i3)
coup4L = cplcFeFeSvL(i4,gt3,i3)
coup4R = cplcFeFeSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MHpm2(i1),MSv2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MHpm2(i1),MSv2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Sd],bar[Fd],conj[Su],bar[Fd]
chargefactor = 3 
Do i1=1,6
  Do i2=1,3
    Do i3=1,6
      Do i4=1,3
If ((MSd2(i1).gt.mf_l2(2)).Or.(MFd2(i2).gt.mf_l2(2)).Or.(MSu2(i3).gt.mf_l2(2)).Or.(MFd2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFdcSdL(gt1,i4,i1)
coup1R = cplFvFdcSdR(gt1,i4,i1)
coup2L = cplcFdFvSdL(i2,gt2,i1)
coup2R = cplcFdFvSdR(i2,gt2,i1)
coup3L = cplcFeFdcSuL(gt4,i2,i3)
coup3R = cplcFeFdcSuR(gt4,i2,i3)
coup4L = cplcFdFeSuL(i4,gt3,i3)
coup4R = cplcFdFeSuR(i4,gt3,i3)
D0m2 = D0_Bagger(MSd2(i1),MSu2(i3),MFd2(i2),MFd2(i4))*MFd(i2)*MFd(i4) 
D27m2 = D27_Bagger(MSd2(i1),MSu2(i3),MFd2(i2),MFd2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Cha],Sv,bar[Cha]
chargefactor = 1 
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
      Do i4=1,2
If ((MSe2(i1).gt.mf_l2(2)).Or.(MCha2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MCha2(i4).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i4,i1)
coup1R = cplFvChacSeR(gt1,i4,i1)
coup2L = cplcChaFvSeL(i2,gt2,i1)
coup2R = cplcChaFvSeR(i2,gt2,i1)
coup3L = cplcFeChaSvL(gt4,i2,i3)
coup3R = cplcFeChaSvR(gt4,i2,i3)
coup4L = cplcChaFecSvL(i4,gt3,i3)
coup4R = cplcChaFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MCha2(i2),MCha2(i4))*MCha(i2)*MCha(i4) 
D27m2 = D27_Bagger(MSe2(i1),MSv2(i3),MCha2(i2),MCha2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Cha],Sv,bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,2
    Do i3=1,3
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MCha2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcChaFvSeL(i2,gt2,i1)
coup2R = cplcChaFvSeR(i2,gt2,i1)
coup3L = cplcFeChaSvL(gt4,i2,i3)
coup3R = cplcFeChaSvR(gt4,i2,i3)
coup4L = cplcFeFecSvL(i4,gt3,i3)
coup4R = cplcFeFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MCha2(i2),MFe2(i4))*MCha(i2)*MFe(i4) 
D27m2 = D27_Bagger(MSe2(i1),MSv2(i3),MCha2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Fe],Ah,bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MAh2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcFeFvSeL(i2,gt2,i1)
coup2R = cplcFeFvSeR(i2,gt2,i1)
coup3L = cplcFeFeAhL(gt4,i2,i3)
coup3R = cplcFeFeAhR(gt4,i2,i3)
coup4L = cplcFeFeAhL(i4,gt3,i3)
coup4R = cplcFeFeAhR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MAh2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MSe2(i1),MAh2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Fe],hh,bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,3
    Do i3=1,2
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(Mhh2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcFeFvSeL(i2,gt2,i1)
coup2R = cplcFeFvSeR(i2,gt2,i1)
coup3L = cplcFeFehhL(gt4,i2,i3)
coup3R = cplcFeFehhR(gt4,i2,i3)
coup4L = cplcFeFehhL(i4,gt3,i3)
coup4R = cplcFeFehhR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),Mhh2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MSe2(i1),Mhh2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Fe],Sv,bar[Cha]
chargefactor = 1 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
      Do i4=1,2
If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MCha2(i4).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i4,i1)
coup1R = cplFvChacSeR(gt1,i4,i1)
coup2L = cplcFeFvSeL(i2,gt2,i1)
coup2R = cplcFeFvSeR(i2,gt2,i1)
coup3L = cplcFeFeSvL(gt4,i2,i3)
coup3R = cplcFeFeSvR(gt4,i2,i3)
coup4L = cplcChaFecSvL(i4,gt3,i3)
coup4R = cplcChaFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MFe2(i2),MCha2(i4))*MFe(i2)*MCha(i4) 
D27m2 = D27_Bagger(MSe2(i1),MSv2(i3),MFe2(i2),MCha2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Fe],Sv,bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcFeFvSeL(i2,gt2,i1)
coup2R = cplcFeFvSeR(i2,gt2,i1)
coup3L = cplcFeFeSvL(gt4,i2,i3)
coup3R = cplcFeFeSvR(gt4,i2,i3)
coup4L = cplcFeFecSvL(i4,gt3,i3)
coup4R = cplcFeFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MSe2(i1),MSv2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],bar[Fe],conj[Sv],bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcFeFvSeL(i2,gt2,i1)
coup2R = cplcFeFvSeR(i2,gt2,i1)
coup3L = cplcFeFecSvL(gt4,i2,i3)
coup3R = cplcFeFecSvR(gt4,i2,i3)
coup4L = cplcFeFeSvL(i4,gt3,i3)
coup4R = cplcFeFeSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MSe2(i1),MSv2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Sv],Chi,Se,Chi
chargefactor = 1 
Do i1=1,3
  Do i2=1,4
    Do i3=1,6
      Do i4=1,4
If ((MSv2(i1).gt.mf_l2(2)).Or.(MChi2(i2).gt.mf_l2(2)).Or.(MSe2(i3).gt.mf_l2(2)).Or.(MChi2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i4,gt1,i1)
coup1R = cplChiFvcSvR(i4,gt1,i1)
coup2L = cplChiFvSvL(i2,gt2,i1)
coup2R = cplChiFvSvR(i2,gt2,i1)
coup3L = cplcFeChiSeL(gt4,i2,i3)
coup3R = cplcFeChiSeR(gt4,i2,i3)
coup4L = cplChiFecSeL(i4,gt3,i3)
coup4R = cplChiFecSeR(i4,gt3,i3)
D0m2 = D0_Bagger(MSv2(i1),MSe2(i3),MChi2(i2),MChi2(i4))*MChi(i2)*MChi(i4) 
D27m2 = D27_Bagger(MSv2(i1),MSe2(i3),MChi2(i2),MChi2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Sv,Fe,Se,Chi
chargefactor = 1 
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
      Do i4=1,4
If ((MSv2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSe2(i3).gt.mf_l2(2)).Or.(MChi2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvSvL(i4,gt1,i1)
coup1R = cplChiFvSvR(i4,gt1,i1)
coup2L = cplcFeFecSvL(gt4,i2,i1)
coup2R = cplcFeFecSvR(gt4,i2,i1)
coup3L = cplcFeFvSeL(i2,gt2,i3)
coup3R = cplcFeFvSeR(i2,gt2,i3)
coup4L = cplChiFecSeL(i4,gt3,i3)
coup4R = cplChiFecSeR(i4,gt3,i3)
D0m2 = D0_Bagger(MSv2(i1),MSe2(i3),MFe2(i2),MChi2(i4))*MFe(i2)*MChi(i4) 
If (Real(D0m2,dp).eq.Real(D0m2,dp)) Then 
teil = teil + 0.5_dp*chargefactor*D0m2*coup1L*coup2R*coup3R*coup4L 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],Chi,Sv,bar[Cha]
chargefactor = 1 
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
      Do i4=1,2
If ((MSe2(i1).gt.mf_l2(2)).Or.(MChi2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MCha2(i4).gt.mf_l2(2))) Then
coup1L = cplFvChacSeL(gt1,i4,i1)
coup1R = cplFvChacSeR(gt1,i4,i1)
coup2L = cplcFeChiSeL(gt4,i2,i1)
coup2R = cplcFeChiSeR(gt4,i2,i1)
coup3L = cplChiFvSvL(i2,gt2,i3)
coup3R = cplChiFvSvR(i2,gt2,i3)
coup4L = cplcChaFecSvL(i4,gt3,i3)
coup4R = cplcChaFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MChi2(i2),MCha2(i4))*MChi(i2)*MCha(i4) 
If (Real(D0m2,dp).eq.Real(D0m2,dp)) Then 
teil = teil + 0.5_dp*chargefactor*D0m2*coup1L*coup2R*coup3R*coup4L 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],Chi,Sv,bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MChi2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcFeChiSeL(gt4,i2,i1)
coup2R = cplcFeChiSeR(gt4,i2,i1)
coup3L = cplChiFvSvL(i2,gt2,i3)
coup3R = cplChiFvSvR(i2,gt2,i3)
coup4L = cplcFeFecSvL(i4,gt3,i3)
coup4R = cplcFeFecSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MChi2(i2),MFe2(i4))*MChi(i2)*MFe(i4) 
If (Real(D0m2,dp).eq.Real(D0m2,dp)) Then 
teil = teil + 0.5_dp*chargefactor*D0m2*coup1L*coup2R*coup3R*coup4L 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Se],Chi,conj[Sv],bar[Fe]
chargefactor = 1 
Do i1=1,6
  Do i2=1,4
    Do i3=1,3
      Do i4=1,3
If ((MSe2(i1).gt.mf_l2(2)).Or.(MChi2(i2).gt.mf_l2(2)).Or.(MSv2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFvFecSeL(gt1,i4,i1)
coup1R = cplFvFecSeR(gt1,i4,i1)
coup2L = cplcFeChiSeL(gt4,i2,i1)
coup2R = cplcFeChiSeR(gt4,i2,i1)
coup3L = cplChiFvcSvL(i2,gt2,i3)
coup3R = cplChiFvcSvR(i2,gt2,i3)
coup4L = cplcFeFeSvL(i4,gt3,i3)
coup4R = cplcFeFeSvR(i4,gt3,i3)
D0m2 = D0_Bagger(MSe2(i1),MSv2(i3),MChi2(i2),MFe2(i4))*MChi(i2)*MFe(i4) 
If (Real(D0m2,dp).eq.Real(D0m2,dp)) Then 
teil = teil + 0.5_dp*chargefactor*D0m2*coup1L*coup2R*coup3R*coup4L 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Sv],Cha,Se,Chi
chargefactor = 1 
Do i1=1,3
  Do i2=1,2
    Do i3=1,6
      Do i4=1,4
If ((MSv2(i1).gt.mf_l2(2)).Or.(MCha2(i2).gt.mf_l2(2)).Or.(MSe2(i3).gt.mf_l2(2)).Or.(MChi2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i4,gt1,i1)
coup1R = cplChiFvcSvR(i4,gt1,i1)
coup2L = cplcFeChaSvL(gt4,i2,i1)
coup2R = cplcFeChaSvR(gt4,i2,i1)
coup3L = cplcChaFvSeL(i2,gt2,i3)
coup3R = cplcChaFvSeR(i2,gt2,i3)
coup4L = cplChiFecSeL(i4,gt3,i3)
coup4R = cplChiFecSeR(i4,gt3,i3)
D0m2 = D0_Bagger(MSv2(i1),MSe2(i3),MCha2(i2),MChi2(i4))*MCha(i2)*MChi(i4) 
If (Real(D0m2,dp).eq.Real(D0m2,dp)) Then 
teil = teil + 0.5_dp*chargefactor*D0m2*coup1L*coup2R*coup3R*coup4L 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Sv],Fe,Se,Chi
chargefactor = 1 
Do i1=1,3
  Do i2=1,3
    Do i3=1,6
      Do i4=1,4
If ((MSv2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MSe2(i3).gt.mf_l2(2)).Or.(MChi2(i4).gt.mf_l2(2))) Then
coup1L = cplChiFvcSvL(i4,gt1,i1)
coup1R = cplChiFvcSvR(i4,gt1,i1)
coup2L = cplcFeFeSvL(gt4,i2,i1)
coup2R = cplcFeFeSvR(gt4,i2,i1)
coup3L = cplcFeFvSeL(i2,gt2,i3)
coup3R = cplcFeFvSeR(i2,gt2,i3)
coup4L = cplChiFecSeL(i4,gt3,i3)
coup4R = cplChiFecSeR(i4,gt3,i3)
D0m2 = D0_Bagger(MSv2(i1),MSe2(i3),MFe2(i2),MChi2(i4))*MFe(i2)*MChi(i4) 
If (Real(D0m2,dp).eq.Real(D0m2,dp)) Then 
teil = teil + 0.5_dp*chargefactor*D0m2*coup1L*coup2R*coup3R*coup4L 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


  End Do 
 
End Do 
 

 
sumI = -2._dp*cosW2_DR*mz2*Real(teil,dp)/g2**2 
res = res + SumI 
End if ! BSM part 
res = res*oo16pi2 
Iname = Iname-1
End subroutine DeltaVB 
 
 
Subroutine CoupHiggsToPhoton(mHiggs,inG,ratCha,ratFd,ratFe,ratFu,ratHpm,              & 
& ratSd,ratSe,ratSu,ratVWm,MCha,MFd,MFe,MFu,MHpm,MSd,MSe,MSu,MVWm,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratCha(2),ratFd(3),ratFe(3),ratFu(3),ratHpm(2),ratSd(6),ratSe(6),ratSu(6),ratVWm

Real(dp),Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm

Integer, Intent(in) :: inG 
Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
coup = coup + 1*(-1)**2*ratVWm*A_one(mH2p/MVWm**2)
HPPloopVWm(inG) = HPPloopVWm(inG)+1*(-1)**2*ratVWm*A_one(mH2p/MVWm**2)
Do i1 = 1 , 6
coup = coup + cNLO_zero(mHiggs,MSd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratSd(i1)*A_zero(mH2p/MSd(i1)**2)
HPPloopSd(i1,inG) = HPPloopSd(i1,inG) + cNLO_zero(mHiggs,MSd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratSd(i1)*A_zero(mH2p/MSd(i1)**2)
End Do 
Do i1 = 1 , 6
coup = coup + cNLO_zero(mHiggs,MSu(i1),gNLO)*3*(2._dp/3._dp)**2*ratSu(i1)*A_zero(mH2p/MSu(i1)**2)
HPPloopSu(i1,inG) = HPPloopSu(i1,inG) + cNLO_zero(mHiggs,MSu(i1),gNLO)*3*(2._dp/3._dp)**2*ratSu(i1)*A_zero(mH2p/MSu(i1)**2)
End Do 
Do i1 = 1 , 6
coup = coup + 1*(-1)**2*ratSe(i1)*A_zero(mH2p/MSe(i1)**2)
HPPloopSe(i1,inG) = HPPloopSe(i1,inG)+1*(-1)**2*ratSe(i1)*A_zero(mH2p/MSe(i1)**2)
End Do 
Do i1 = 2 , 2
coup = coup + 1*(-1)**2*ratHpm(i1)*A_zero(mH2p/MHpm(i1)**2)
HPPloopHpm(i1,inG) = HPPloopHpm(i1,inG)+1*(-1)**2*ratHpm(i1)*A_zero(mH2p/MHpm(i1)**2)
End Do 
Do i1 = 1 , 2
coup = coup + 1*(-1)**2*ratCha(i1)*A_onehalf(mH2p/MCha(i1)**2)
HPPloopCha(i1,inG) = HPPloopCha(i1,inG)+1*(-1)**2*ratCha(i1)*A_onehalf(mH2p/MCha(i1)**2)
End Do 
Do i1 = 1 , 3
coup = coup + 1*(-1)**2*ratFe(i1)*A_onehalf(mH2p/MFe(i1)**2)
HPPloopFe(i1,inG) = HPPloopFe(i1,inG)+1*(-1)**2*ratFe(i1)*A_onehalf(mH2p/MFe(i1)**2)
End Do 
Do i1 = 1 , 3
coup = coup + cNLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratFd(i1)*A_onehalf(mH2p/MFd(i1)**2)
HPPloopFd(i1,inG) = HPPloopFd(i1,inG) + cNLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratFd(i1)*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 = 1 , 3
coup = coup + cNLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*ratFu(i1)*A_onehalf(mH2p/MFu(i1)**2)
HPPloopFu(i1,inG) = HPPloopFu(i1,inG) + cNLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*ratFu(i1)*A_onehalf(mH2p/MFu(i1)**2)
End Do 
End Subroutine CoupHiggsToPhoton

Subroutine CoupHiggsToGluon(mHiggs,inG,ratFd,ratFu,ratSd,ratSu,MFd,MFu,               & 
& MSd,MSu,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratFd(3),ratFu(3),ratSd(6),ratSu(6)

Real(dp),Intent(in) :: MFd(3),MFu(3),MSd(6),MSu(6)

Integer, Intent(in) :: inG 
Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 = 1 , 6
coup = coup + 1*ratSd(i1)*A_zero(mH2p/MSd(i1)**2)
End Do 
Do i1 = 1 , 6
coup = coup + 1*ratSu(i1)*A_zero(mH2p/MSu(i1)**2)
End Do 
Do i1 = 1 , 3
coup = coup + 1*ratFd(i1)*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 = 1 , 3
coup = coup + 1*ratFu(i1)*A_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupHiggsToGluon

Subroutine CoupHiggsToPhotonSM(mHiggs,MCha,MFd,MFe,MFu,MHpm,MSd,MSe,MSu,              & 
& MVWm,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
coup = coup + 1*(-1)**2*A_one(mH2p/MVWm**2)
Do i1 =1, 3 
coup = coup + 1*(-1)**2*A_onehalf(mH2p/MFe(i1)**2)
End Do 
Do i1 =1, 3 
coup = coup + cNLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3 
coup = coup + cNLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*A_onehalf(mH2p/MFu(i1)**2)
End Do 
End Subroutine CoupHiggsToPhotonSM 

Subroutine CoupHiggsToGluonSM(mHiggs,MFd,MFu,MSd,MSu,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MFd(3),MFu(3),MSd(6),MSu(6)

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 3 
coup = coup + 1*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3 
coup = coup + 1*A_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupHiggsToGluonSM 

Subroutine CoupPseudoHiggsToPhoton(mHiggs,inG,ratCha,ratFd,ratFe,ratFu,               & 
& ratHpm,ratSd,ratSe,ratSu,ratVWm,MCha,MFd,MFe,MFu,MHpm,MSd,MSe,MSu,MVWm,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratCha(2),ratFd(3),ratFe(3),ratFu(3),ratHpm(2),ratSd(6),ratSe(6),ratSu(6),ratVWm

Real(dp),Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Integer, Intent(in) :: inG 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 2
coup = coup + cANLO_onehalf(mHiggs,MCha(i1),gNLO)*1*(-1)**2*ratCha(i1)*AP_onehalf(mH2p/MCha(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFe(i1),gNLO)*1*(-1)**2*ratFe(i1)*AP_onehalf(mH2p/MFe(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratFd(i1)*AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*ratFu(i1)*AP_onehalf(mH2p/MFu(i1)**2)
End Do 
End Subroutine CoupPseudoHiggsToPhoton

Subroutine CoupPseudoHiggsToGluon(mHiggs,inG,ratFd,ratFu,ratSd,ratSu,MFd,             & 
& MFu,MSd,MSu,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratFd(3),ratFu(3),ratSd(6),ratSu(6)

Real(dp),Intent(in) :: MFd(3),MFu(3),MSd(6),MSu(6)

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Integer, Intent(in) :: inG 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 3
coup = coup + 1*ratFd(i1)*AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + 1*ratFu(i1)*AP_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupPseudoHiggsToGluon

Subroutine CoupPseudoHiggsToPhotonSM(mHiggs,MCha,MFd,MFe,MFu,MHpm,MSd,MSe,            & 
& MSu,MVWm,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MCha(2),MFd(3),MFe(3),MFu(3),MHpm(2),MSd(6),MSe(6),MSu(6),MVWm

Real(dp), Intent(in) :: mHiggs,gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFe(i1),gNLO)*1*(-1)**2**AP_onehalf(mH2p/MFe(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2**AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2**AP_onehalf(mH2p/MFu(i1)**2)
End Do 
End Subroutine CoupPseudoHiggsToPhotonSM 

Subroutine CoupPseudoHiggsToGluonSM(mHiggs,MFd,MFu,MSd,MSu,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MFd(3),MFu(3),MSd(6),MSu(6)

Real(dp), Intent(in) :: mHiggs,gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 3
coup = coup + 1*AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + 1*AP_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupPseudoHiggsToGluonSM 

Complex(dp) Function cNLO_onehalf(mH,mQ,g) 
Real(dp), Intent(in) :: mH, mQ, g
Real(dp)::tau 
tau=mH**2/(4._dp*mQ**2) 
If (g.lt.0._dp) Then 
  cNLO_onehalf = 1._dp 
Else 
  If (mH.lt.mQ) Then 
    cNLO_onehalf = 1._dp - oo4pi2*g**2  
  Else if (mH.gt.(2._dp*mQ)) Then 
   If (tau.lt.100._dp) Then 
    If (tau.lt.1.1_dp) Then 
      cNLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.033208159703536+7.10655096733206*tau-88.20900604676405*tau**2+598.6773733788388*tau**3-1967.3257953814561*tau**4+& 
       & 3247.6715405319346*tau**5-2330.127086890616*tau**6+677.9294006001846*tau**8-142.7923161120851*tau**10)& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-&
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    Else 
      cNLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.6170280814404576+0.40530581525102677/tau**3-0.33530992103515084/tau**2+3.9718559902660684/tau-0.000111953515865919*tau+& 
       & 9.129881821626589e-6*tau*Log(tau)+0.1338033886479311*Log(4*tau)-1.121902907800696e-12*tau**2*Log(tau**2))& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-& 
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    End if 
   Else ! mQ->0 
     cNLO_onehalf=1._dp+(g**2/(4*Pi**2))*&
      & (-(2._dp*Log(mH**2/mQ**2))/3._dp+(Pi**2-(Log(mH**2/mQ**2))**2)/18._dp+2*log(mH**2/4/mQ**2)&
      &+(0._dp,1._dp)*Pi/3*((Log(mH**2/mQ**2))/3+2._dp))
    End if 
  Else ! mQ~mH 
    cNLO_onehalf = 1._dp 
  End if 
End if 
End Function cNLO_onehalf 
 
Complex(dp) Function cANLO_onehalf(mH,mQ,g) 
Real(dp), Intent(in) :: mH, mQ, g
Real(dp)::tau 
tau=mH**2/(4._dp*mQ**2) 
If (g.lt.0._dp) Then 
  cANLO_onehalf = 1._dp 
Else 
  If (mH.lt.mQ) Then 
    cANLO_onehalf = 1._dp  
  Else if (mH.gt.(2._dp*mQ)) Then 
   If (tau.lt.100._dp) Then 
    If (tau.lt.1.1_dp) Then 
      cANLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.033208159703536+7.10655096733206*tau-88.20900604676405*tau**2+598.6773733788388*tau**3-1967.3257953814561*tau**4+& 
       & 3247.6715405319346*tau**5-2330.127086890616*tau**6+677.9294006001846*tau**8-142.7923161120851*tau**10)& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-&
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    Else 
      cANLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.6170280814404576+0.40530581525102677/tau**3-0.33530992103515084/tau**2+3.9718559902660684/tau-0.000111953515865919*tau+& 
       & 9.129881821626589e-6*tau*Log(tau)+0.1338033886479311*Log(4*tau)-1.121902907800696e-12*tau**2*Log(tau**2))& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-& 
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    End if 
   Else ! mQ->0 
     cANLO_onehalf=1._dp+(g**2/(4*Pi**2))*&
      & (-(2._dp*Log(mH**2/mQ**2))/3._dp+(Pi**2-(Log(mH**2/mQ**2))**2)/18._dp+2*log(mH**2/4/mQ**2)&
      &+(0._dp,1._dp)*Pi/3*((Log(mH**2/mQ**2))/3+2._dp))
    End if 
  Else ! mQ~mH 
    cANLO_onehalf = 1._dp 
  End if 
End if 
End Function cANLO_onehalf 
 
Real(dp) Function cNLO_zero(mH,mQ,g) 
Real(dp), Intent(in) :: mH, mQ, g
If (g.lt.0._dp) Then 
   cNLO_zero= 1._dp 
Else 
  If (mH.lt.mQ) Then 
    cNLO_zero = 1._dp + 2._dp*oo3pi2*g**2  
  Else  
    cNLO_zero = 1._dp 
  End if 
End if 
End Function cNLO_zero 
End Module LoopCouplings_MSSMTriLnV 
 
