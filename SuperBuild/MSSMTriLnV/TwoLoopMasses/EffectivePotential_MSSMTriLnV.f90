Module EffectivePotential_MSSMTriLnV 
 
Use Control 
Use Settings 
Use Couplings_MSSMTriLnV 
Use LoopFunctions 
Use Mathematics 
Use MathematicsQP 
Use Model_Data_MSSMTriLnV 
Use StandardModel 
Use TreeLevelMasses_MSSMTriLnV 
Use EffPotFunctions
Use DerivativesEffPotFunctions
 
Contains 
 
Subroutine CalculateCorrectionsEffPot(ti_ep2L,pi_ep2L,vd,vu,g1,g2,g3,Yd,              & 
& Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Integer , Intent(inout):: kont 
Integer :: iout 
Real(dp) :: err,h_start,vevs(2) 
Real(dp), Intent(out) :: ti_ep2L(2)  
Real(dp), Intent(out) :: pi_ep2L(2,2)


err2L = 0._dp 
If (.not.PurelyNumericalEffPot) Then 
epsM = 1.0E-8_dp 
epsD = 1.0E-8_dp 
! 2nd deriv. also calculates the 1st deriv. of V
Call SecondDerivativeEffPot2Loop(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,              & 
& T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,pi_ep2L,ti_ep2L)

Else 
epsM = 1.0E-6_dp 
epsD = 1.0E-6_dp 
vevs = (/vd,vu/) 
! Calculate 1st (ti_ep) and 2nd derivatives (pi_ep)
ti_ep2L(1) = partialDiff_Ridders(EffPotFunction2Loop,vevs,1,2,err,h_start,iout) 
If (err.gt.err2L) err2L = err 
ti_ep2L(2) = partialDiff_Ridders(EffPotFunction2Loop,vevs,2,2,err,h_start,iout) 
If (err.gt.err2L) err2L = err 
pi_ep2L(1,1) = partialDiffXY_Ridders(EffPotFunction2Loop,vevs,1,1,2,err,h_start,iout) 
If (err.gt.err2L) err2L = err 
pi_ep2L(2,1) = partialDiffXY_Ridders(EffPotFunction2Loop,vevs,2,1,2,err,h_start,iout) 
If (err.gt.err2L) err2L = err 
pi_ep2L(2,2) = partialDiffXY_Ridders(EffPotFunction2Loop,vevs,2,2,2,err,h_start,iout) 
If (err.gt.err2L) err2L = err 
pi_ep2L(1,2)=pi_ep2L(2,1)
End If 
Contains 

Real(dp) Function EffPotFunction(vevs) 
  ! a wrapping function to be passed to numerical differentiation 
  Implicit None 
  Real(dp), Intent(in) :: vevs(2) 
  Real(dp) :: effPot 
Call CalculateEffPot(vevs(1),vevs(2),g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,             & 
& T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,effPot)

  EffPotFunction = effPot 
  End Function 

Real(dp) Function EffPotFunction2Loop(vevs) 
  ! a wrapping function to be passed to numerical differentiation 
  Implicit None 
  Real(dp), Intent(in) :: vevs(2) 
  Real(dp) :: effPot2L 
Call CalculateEffPot2Loop(vevs(1),vevs(2),g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,              & 
& Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,effPot2L)

  EffPotFunction2Loop = effPot2L 
  End Function 

End subroutine CalculateCorrectionsEffPot 


Subroutine CalculateEffPot(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,              & 
& Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,effPot)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Real(dp) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

Integer, Intent(inout):: kont
Integer :: i 
Real(dp) :: effpot,Qscale,result,temp


Call TreeMasses(MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,MVWm,               & 
& MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,ZUR,             & 
& ZV,ZW,ZZ,alphaH,betaH,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,             & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,.True.,kont)

Qscale= getRenormalizationScale()
result=0._dp
temp=0._dp
! sum over real scalars (color *[2 if complex]) 
Do i=1,6
temp=temp+(3*2) * h_SMartin(MSd2(i),Qscale) ! Sd
End Do
Do i=1,3
temp=temp+(2)    * h_SMartin(MSv2(i),Qscale) ! Sv
End Do
Do i=1,6
temp=temp+(3*2) * h_SMartin(MSu2(i),Qscale) ! Su
End Do
Do i=1,6
temp=temp+(2)    * h_SMartin(MSe2(i),Qscale) ! Se
End Do
Do i=1,2
temp=temp+          h_SMartin(Mhh2(i),Qscale) ! hh
End Do
Do i=2,2
temp=temp+          h_SMartin(MAh2(i),Qscale) ! Ah
End Do
Do i=2,2
temp=temp+(2)    * h_SMartin(MHpm2(i),Qscale) ! Hpm
End Do
result=(+1)*temp !scalars

temp=0._dp
! sum over two-component fermions (*color [*2 if Dirac Fermion]) 
Do i=1,2
temp=temp+          h_SMartin(MCha2(i),Qscale)*2 ! Cha
End Do
Do i=1,4
temp=temp+          h_SMartin(MChi2(i),Qscale)*1 ! Chi
End Do
Do i=1,3
temp=temp+(3)   * h_SMartin(MFd2(i),Qscale)*2 ! Fd
End Do
Do i=1,3
temp=temp+          h_SMartin(MFe2(i),Qscale)*2 ! Fe
End Do
Do i=1,3
temp=temp+(3)   * h_SMartin(MFu2(i),Qscale)*2 ! Fu
End Do
Do i=1,3
temp=temp+          h_SMartin(0._dp,Qscale)*1 ! Fv
End Do
temp=temp+(8)   * h_SMartin(MGlu2,Qscale)*1 ! Glu
result=result+(-2)*temp ! fermions

temp=0._dp
! sum over real vectors (color *[2 if complex]) 
temp=temp+(8)   * h_SMartin(0._dp,Qscale) ! VG
temp=temp+          h_SMartin(0._dp,Qscale) ! VP
temp=temp+          h_SMartin(MVZ2,Qscale) ! VZ
temp=temp+(2)    * h_SMartin(MVWm2,Qscale) ! VWm
result=result+(+3)*temp ! vectors

effPot = result * oo16pi2

End Subroutine CalculateEffPot 



 
 
Subroutine CalculateEffPot2Loop(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,               & 
& T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,effPot2L)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Real(dp) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

Integer, Intent(inout):: kont
Real(dp), Intent(out) :: effpot2L
Integer :: i,i1,i2,i3,includeGhosts,NrContr 
Integer :: NrContr1,NrContr2 !nr of contributing diagrams
Real(dp) :: Qscale,result,colorfactor,coeff,coeffbar
Complex(dp) :: temp,coupx,coupxbar,coup1,coup2,coup1L,coup1R,coup2L,coup2R
Complex(dp) :: dcoupx,dcoupxbar,dcoup1,dcoup2,dcoup1L,dcoup1R,dcoup2L,dcoup2R
Complex(dp) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

Real(dp) :: results1(41),results2(20)


Call TreeMassesEffPot(MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,             & 
& Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,.True.,kont)

Call CouplingsForEffPot3(Mu,Yd,Td,ZD,ZA,Ye,Te,ZE,Yu,Tu,ZU,vd,ZH,vu,ZP,ZV,             & 
& L2,T2,L1,T1,g3,ZDL,ZDR,ZEL,ZER,ZUL,ZUR,UM,UP,ZN,pG,cplAhSdcSd,cplAhSecSe,              & 
& cplAhSucSu,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,        & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,               & 
& cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,            & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,        & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,         & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR)

Call CouplingsForEffPot4(Yd,ZD,ZA,Ye,ZE,Yu,ZU,ZH,ZP,ZV,g3,L2,L1,cplAhAhSdcSd,         & 
& cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,cplHpmSdcHpmcSd,      & 
& cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,cplSdSecSdcSe,           & 
& cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,cplSuSucSucSu,   & 
& cplSdcSdVGVG,cplSucSuVGVG)


Qscale = getRenormalizationScale()
result=0._dp
results1=0._dp
results2=0._dp
temp=0._dp
! ----- Topology1 (sunrise): diagrams w. 3 Particles and 2 Vertices

! ----- diagrams of type SSS, 11 ------ 
! ---- Ah,Sd,conj[Sd] ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSdcSd(i1,i2,i3)
coup2 = cplAhSdcSd(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSS(MAh2(i1),MSd2(i2),MSd2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Ah, Sd, conj[Sd]]' 
    End Do
  End Do
End Do
results1(1)=temp
! ---- Ah,Se,conj[Se] ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSecSe(i1,i2,i3)
coup2 = cplAhSecSe(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSS(MAh2(i1),MSe2(i2),MSe2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Ah, Se, conj[Se]]' 
    End Do
  End Do
End Do
results1(2)=temp
! ---- Ah,Su,conj[Su] ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSucSu(i1,i2,i3)
coup2 = cplAhSucSu(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSS(MAh2(i1),MSu2(i2),MSu2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Ah, Su, conj[Su]]' 
    End Do
  End Do
End Do
results1(3)=temp
! ---- hh,Sd,conj[Sd] ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSdcSd(i1,i2,i3)
coup2 = cplhhSdcSd(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSS(Mhh2(i1),MSd2(i2),MSd2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[hh, Sd, conj[Sd]]' 
    End Do
  End Do
End Do
results1(4)=temp
! ---- hh,Se,conj[Se] ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSecSe(i1,i2,i3)
coup2 = cplhhSecSe(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSS(Mhh2(i1),MSe2(i2),MSe2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[hh, Se, conj[Se]]' 
    End Do
  End Do
End Do
results1(5)=temp
! ---- hh,Su,conj[Su] ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSucSu(i1,i2,i3)
coup2 = cplhhSucSu(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSS(Mhh2(i1),MSu2(i2),MSu2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[hh, Su, conj[Su]]' 
    End Do
  End Do
End Do
results1(6)=temp
! ---- Sd,conj[Hpm],conj[Su] ----
temp=0._dp
Do i1=1,6
 Do i2=1,2
    Do i3=1,6
coup1 = cplSdcHpmcSu(i1,i2,i3)
coup2 = cplHpmSucSd(i2,i3,i1)
colorfactor=3
temp=temp+colorfactor*1._dp*abs(coup1)**2*Fep_SSS(MSd2(i1),MHpm2(i2),MSu2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Sd, conj[Hpm], conj[Su]]' 
    End Do
  End Do
End Do
results1(7)=temp
! ---- Sd,conj[Sd],conj[Sv] ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
    Do i3=1,3
coup1 = cplSdcSdcSv(i1,i2,i3)
coup2 = cplSdSvcSd(i2,i3,i1)
colorfactor=3
temp=temp+colorfactor*1._dp*abs(coup1)**2*Fep_SSS(MSd2(i1),MSd2(i2),MSv2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Sd, conj[Sd], conj[Sv]]' 
    End Do
  End Do
End Do
results1(8)=temp
! ---- Se,Su,conj[Sd] ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
    Do i3=1,6
coup1 = cplSeSucSd(i1,i2,i3)
coup2 = cplSdcSecSu(i3,i1,i2)
colorfactor=3
temp=temp+colorfactor*1._dp*abs(coup1)**2*Fep_SSS(MSe2(i1),MSu2(i2),MSd2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Se, Su, conj[Sd]]' 
    End Do
  End Do
End Do
results1(9)=temp
! ---- Se,conj[Hpm],conj[Sv] ----
temp=0._dp
Do i1=1,6
 Do i2=1,2
    Do i3=1,3
coup1 = cplSecHpmcSv(i1,i2,i3)
coup2 = cplHpmSvcSe(i2,i3,i1)
colorfactor=1
temp=temp+colorfactor*1._dp*abs(coup1)**2*Fep_SSS(MSe2(i1),MHpm2(i2),MSv2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Se, conj[Hpm], conj[Sv]]' 
    End Do
  End Do
End Do
results1(10)=temp
! ---- Se,conj[Se],conj[Sv] ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
    Do i3=1,3
coup1 = cplSecSecSv(i1,i2,i3)
coup2 = cplSeSvcSe(i2,i3,i1)
colorfactor=1
temp=temp+colorfactor*1._dp*abs(coup1)**2*Fep_SSS(MSe2(i1),MSe2(i2),MSv2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Se, conj[Se], conj[Sv]]' 
    End Do
  End Do
End Do
results1(11)=temp
! ----- diagrams of type FFS, 24 ------ 
! ---- Ah,Fd,bar[Fd] ----
temp=0._dp
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFdFdAhL(i3,i2,i1)
coup1R = cplcFdFdAhR(i3,i2,i1)
coup2L = cplcFdFdAhL(i2,i3,i1)
coup2R = cplcFdFdAhR(i2,i3,i1)
colorfactor=3
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MFd2(i2),MAh2(i1),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Ah, Fd, bar[Fd]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFd(i2)*MFd(i3)*Fep_FFSbar(MFd2(i3),MFd2(i2),MAh2(i1),Qscale)
    End Do
  End Do
End Do
results1(12)=temp
! ---- Ah,Fe,bar[Fe] ----
temp=0._dp
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFeFeAhL(i3,i2,i1)
coup1R = cplcFeFeAhR(i3,i2,i1)
coup2L = cplcFeFeAhL(i2,i3,i1)
coup2R = cplcFeFeAhR(i2,i3,i1)
colorfactor=1
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFe2(i3),MFe2(i2),MAh2(i1),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Ah, Fe, bar[Fe]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFe(i2)*MFe(i3)*Fep_FFSbar(MFe2(i3),MFe2(i2),MAh2(i1),Qscale)
    End Do
  End Do
End Do
results1(13)=temp
! ---- Ah,Fu,bar[Fu] ----
temp=0._dp
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFuFuAhL(i3,i2,i1)
coup1R = cplcFuFuAhR(i3,i2,i1)
coup2L = cplcFuFuAhL(i2,i3,i1)
coup2R = cplcFuFuAhR(i2,i3,i1)
colorfactor=3
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFu2(i3),MFu2(i2),MAh2(i1),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Ah, Fu, bar[Fu]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFu(i2)*MFu(i3)*Fep_FFSbar(MFu2(i3),MFu2(i2),MAh2(i1),Qscale)
    End Do
  End Do
End Do
results1(14)=temp
! ---- Chi,Sd,bar[Fd] ----
temp=0._dp
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdChiSdL(i3,i1,i2)
coup1R = cplcFdChiSdR(i3,i1,i2)
coup2L = cplChiFdcSdL(i1,i3,i2)
coup2R = cplChiFdcSdR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MChi2(i1),MSd2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Chi, Sd, bar[Fd]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MChi(i1)*MFd(i3)*Fep_FFSbar(MFd2(i3),MChi2(i1),MSd2(i2),Qscale)
    End Do
  End Do
End Do
results1(15)=temp
! ---- Chi,Se,bar[Fe] ----
temp=0._dp
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFeChiSeL(i3,i1,i2)
coup1R = cplcFeChiSeR(i3,i1,i2)
coup2L = cplChiFecSeL(i1,i3,i2)
coup2R = cplChiFecSeR(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFe2(i3),MChi2(i1),MSe2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Chi, Se, bar[Fe]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MChi(i1)*MFe(i3)*Fep_FFSbar(MFe2(i3),MChi2(i1),MSe2(i2),Qscale)
    End Do
  End Do
End Do
results1(16)=temp
! ---- Chi,Su,bar[Fu] ----
temp=0._dp
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFuChiSuL(i3,i1,i2)
coup1R = cplcFuChiSuR(i3,i1,i2)
coup2L = cplChiFucSuL(i1,i3,i2)
coup2R = cplChiFucSuR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFu2(i3),MChi2(i1),MSu2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Chi, Su, bar[Fu]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MChi(i1)*MFu(i3)*Fep_FFSbar(MFu2(i3),MChi2(i1),MSu2(i2),Qscale)
    End Do
  End Do
End Do
results1(17)=temp
! ---- Fd,hh,bar[Fd] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFdFdhhL(i3,i1,i2)
coup1R = cplcFdFdhhR(i3,i1,i2)
coup2L = cplcFdFdhhL(i1,i3,i2)
coup2R = cplcFdFdhhR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MFd2(i1),Mhh2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fd, hh, bar[Fd]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFd(i1)*MFd(i3)*Fep_FFSbar(MFd2(i3),MFd2(i1),Mhh2(i2),Qscale)
    End Do
  End Do
End Do
results1(18)=temp
! ---- Fd,bar[Cha],conj[Su] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,6
coup1L = cplcChaFdcSuL(i2,i1,i3)
coup1R = cplcChaFdcSuR(i2,i1,i3)
coup2L = cplcFdChaSuL(i1,i2,i3)
coup2R = cplcFdChaSuR(i1,i2,i3)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MCha2(i2),MFd2(i1),MSu2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fd, bar[Cha], conj[Su]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MFd(i1)*MCha(i2)*Fep_FFSbar(MCha2(i2),MFd2(i1),MSu2(i3),Qscale)
    End Do
  End Do
End Do
results1(19)=temp
! ---- Fd,bar[Fd],conj[Sv] ----
temp=0._dp
Do i1=1,3
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFdFdcSvL(i2,i1,i3)
coup1R = cplcFdFdcSvR(i2,i1,i3)
coup2L = cplcFdFdSvL(i1,i2,i3)
coup2R = cplcFdFdSvR(i1,i2,i3)
colorfactor=3
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i2),MFd2(i1),MSv2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fd, bar[Fd], conj[Sv]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFd(i1)*MFd(i2)*Fep_FFSbar(MFd2(i2),MFd2(i1),MSv2(i3),Qscale)
    End Do
  End Do
End Do
results1(20)=temp
! ---- Fe,hh,bar[Fe] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFeFehhL(i3,i1,i2)
coup1R = cplcFeFehhR(i3,i1,i2)
coup2L = cplcFeFehhL(i1,i3,i2)
coup2R = cplcFeFehhR(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFe2(i3),MFe2(i1),Mhh2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, hh, bar[Fe]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFe(i1)*MFe(i3)*Fep_FFSbar(MFe2(i3),MFe2(i1),Mhh2(i2),Qscale)
    End Do
  End Do
End Do
results1(21)=temp
! ---- Fe,Su,bar[Fd] ----
temp=0._dp
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFeSuL(i3,i1,i2)
coup1R = cplcFdFeSuR(i3,i1,i2)
coup2L = cplcFeFdcSuL(i1,i3,i2)
coup2R = cplcFeFdcSuR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MFe2(i1),MSu2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, Su, bar[Fd]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MFe(i1)*MFd(i3)*Fep_FFSbar(MFd2(i3),MFe2(i1),MSu2(i2),Qscale)
    End Do
  End Do
End Do
results1(22)=temp
! ---- Fe,bar[Cha],conj[Sv] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcChaFecSvL(i2,i1,i3)
coup1R = cplcChaFecSvR(i2,i1,i3)
coup2L = cplcFeChaSvL(i1,i2,i3)
coup2R = cplcFeChaSvR(i1,i2,i3)
colorfactor=1
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MCha2(i2),MFe2(i1),MSv2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, bar[Cha], conj[Sv]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MFe(i1)*MCha(i2)*Fep_FFSbar(MCha2(i2),MFe2(i1),MSv2(i3),Qscale)
    End Do
  End Do
End Do
results1(23)=temp
! ---- Fe,bar[Fe],conj[Sv] ----
temp=0._dp
Do i1=1,3
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFeFecSvL(i2,i1,i3)
coup1R = cplcFeFecSvR(i2,i1,i3)
coup2L = cplcFeFeSvL(i1,i2,i3)
coup2R = cplcFeFeSvR(i1,i2,i3)
colorfactor=1
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFe2(i2),MFe2(i1),MSv2(i3),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, bar[Fe], conj[Sv]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFe(i1)*MFe(i2)*Fep_FFSbar(MFe2(i2),MFe2(i1),MSv2(i3),Qscale)
    End Do
  End Do
End Do
results1(24)=temp
! ---- Fu,hh,bar[Fu] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFuFuhhL(i3,i1,i2)
coup1R = cplcFuFuhhR(i3,i1,i2)
coup2L = cplcFuFuhhL(i1,i3,i2)
coup2R = cplcFuFuhhR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFu2(i3),MFu2(i1),Mhh2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fu, hh, bar[Fu]]' 
temp=temp+colorfactor*0.5_dp*2*Real(coup1L*conjg(coup1R),dp)*MFu(i1)*MFu(i3)*Fep_FFSbar(MFu2(i3),MFu2(i1),Mhh2(i2),Qscale)
    End Do
  End Do
End Do
results1(25)=temp
! ---- Fu,Hpm,bar[Fd] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFdFuHpmL(i3,i1,i2)
coup1R = cplcFdFuHpmR(i3,i1,i2)
coup2L = cplcFuFdcHpmL(i1,i3,i2)
coup2R = cplcFuFdcHpmR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MFu2(i1),MHpm2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fu, Hpm, bar[Fd]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MFu(i1)*MFd(i3)*Fep_FFSbar(MFd2(i3),MFu2(i1),MHpm2(i2),Qscale)
    End Do
  End Do
End Do
results1(26)=temp
! ---- Fu,Se,bar[Fd] ----
temp=0._dp
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFuSeL(i3,i1,i2)
coup1R = cplcFdFuSeR(i3,i1,i2)
coup2L = cplcFuFdcSeL(i1,i3,i2)
coup2R = cplcFuFdcSeR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MFu2(i1),MSe2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fu, Se, bar[Fd]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MFu(i1)*MFd(i3)*Fep_FFSbar(MFd2(i3),MFu2(i1),MSe2(i2),Qscale)
    End Do
  End Do
End Do
results1(27)=temp
! ---- Fv,Hpm,bar[Fe] ----
temp=0._dp
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFeFvHpmL(i3,i1,i2)
coup1R = cplcFeFvHpmR(i3,i1,i2)
coup2L = cplFvFecHpmL(i1,i3,i2)
coup2R = cplFvFecHpmR(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFe2(i3),0._dp,MHpm2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Hpm, bar[Fe]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*0.*MFe(i3)*Fep_FFSbar(MFe2(i3),0._dp,MHpm2(i2),Qscale)
    End Do
  End Do
End Do
results1(28)=temp
! ---- Fv,Sd,bar[Fd] ----
temp=0._dp
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFvSdL(i3,i1,i2)
coup1R = cplcFdFvSdR(i3,i1,i2)
coup2L = cplFvFdcSdL(i1,i3,i2)
coup2R = cplFvFdcSdR(i1,i3,i2)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),0._dp,MSd2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Sd, bar[Fd]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*0.*MFd(i3)*Fep_FFSbar(MFd2(i3),0._dp,MSd2(i2),Qscale)
    End Do
  End Do
End Do
results1(29)=temp
! ---- Fv,Se,bar[Cha] ----
temp=0._dp
Do i1=1,3
 Do i2=1,6
    Do i3=1,2
coup1L = cplcChaFvSeL(i3,i1,i2)
coup1R = cplcChaFvSeR(i3,i1,i2)
coup2L = cplFvChacSeL(i1,i3,i2)
coup2R = cplFvChacSeR(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MCha2(i3),0._dp,MSe2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Se, bar[Cha]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*0.*MCha(i3)*Fep_FFSbar(MCha2(i3),0._dp,MSe2(i2),Qscale)
    End Do
  End Do
End Do
results1(30)=temp
! ---- Fv,Se,bar[Fe] ----
temp=0._dp
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFeFvSeL(i3,i1,i2)
coup1R = cplcFeFvSeR(i3,i1,i2)
coup2L = cplFvFecSeL(i1,i3,i2)
coup2R = cplFvFecSeR(i1,i3,i2)
colorfactor=1
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFe2(i3),0._dp,MSe2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Se, bar[Fe]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*0.*MFe(i3)*Fep_FFSbar(MFe2(i3),0._dp,MSe2(i2),Qscale)
    End Do
  End Do
End Do
results1(31)=temp
! ---- Glu,Sd,bar[Fd] ----
temp=0._dp
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdGluSdL(i3,i2)
coup1R = cplcFdGluSdR(i3,i2)
coup2L = cplGluFdcSdL(i3,i2)
coup2R = cplGluFdcSdR(i3,i2)
colorfactor=4
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFd2(i3),MGlu2,MSd2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Glu, Sd, bar[Fd]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MGlu*MFd(i3)*Fep_FFSbar(MFd2(i3),MGlu2,MSd2(i2),Qscale)
    End Do
  End Do
results1(32)=temp
! ---- Glu,Su,bar[Fu] ----
temp=0._dp
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFuGluSuL(i3,i2)
coup1R = cplcFuGluSuR(i3,i2)
coup2L = cplGluFucSuL(i3,i2)
coup2R = cplGluFucSuR(i3,i2)
colorfactor=4
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFu2(i3),MGlu2,MSu2(i2),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Glu, Su, bar[Fu]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MGlu*MFu(i3)*Fep_FFSbar(MFu2(i3),MGlu2,MSu2(i2),Qscale)
    End Do
  End Do
results1(33)=temp
! ---- Sd,bar[Cha],bar[Fu] ----
temp=0._dp
Do i1=1,6
 Do i2=1,2
    Do i3=1,3
coup1L = cplcChacFuSdL(i2,i3,i1)
coup1R = cplcChacFuSdR(i2,i3,i1)
coup2L = cplChaFucSdL(i2,i3,i1)
coup2R = cplChaFucSdR(i2,i3,i1)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFu2(i3),MCha2(i2),MSd2(i1),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Sd, bar[Cha], bar[Fu]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MCha(i2)*MFu(i3)*Fep_FFSbar(MFu2(i3),MCha2(i2),MSd2(i1),Qscale)
    End Do
  End Do
End Do
results1(34)=temp
! ---- Sd,bar[Fe],bar[Fu] ----
temp=0._dp
Do i1=1,6
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFecFuSdL(i2,i3,i1)
coup1R = cplcFecFuSdR(i2,i3,i1)
coup2L = cplFeFucSdL(i2,i3,i1)
coup2R = cplFeFucSdR(i2,i3,i1)
colorfactor=3
temp=temp+colorfactor*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFS(MFu2(i3),MFe2(i2),MSd2(i1),Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Sd, bar[Fe], bar[Fu]]' 
temp=temp+colorfactor*2*Real(coup1L*conjg(coup1R),dp)*MFe(i2)*MFu(i3)*Fep_FFSbar(MFu2(i3),MFe2(i2),MSd2(i1),Qscale)
    End Do
  End Do
End Do
results1(35)=temp
! ----- diagrams of type SSV, 2 ------ 
! ---- Sd,VG,conj[Sd] ----
temp=0._dp
Do i1=1,6
    Do i3=1,6
coup1 = cplSdcSdVG(i1,i3)
coup2 = cplSdcSdVG(i3,i1)
colorfactor=4
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSV(MSd2(i3),MSd2(i1),0._dp,Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSV C[Sd, VG, conj[Sd]]' 
    End Do
End Do
results1(36)=temp
! ---- Su,VG,conj[Su] ----
temp=0._dp
Do i1=1,6
    Do i3=1,6
coup1 = cplSucSuVG(i1,i3)
coup2 = cplSucSuVG(i3,i1)
colorfactor=4
temp=temp+colorfactor*0.5_dp*abs(coup1)**2*Fep_SSV(MSu2(i3),MSu2(i1),0._dp,Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSV C[Su, VG, conj[Su]]' 
    End Do
End Do
results1(37)=temp
! ----- diagrams of type FFV, 3 ------ 
! ---- Fd,VG,bar[Fd] ----
temp=0._dp
Do i1=1,3
    Do i3=1,3
coup1L = cplcFdFdVGL(i3,i1)
coup1R = cplcFdFdVGR(i3,i1)
coup2L = cplcFdFdVGL(i1,i3)
coup2R = cplcFdFdVGR(i1,i3)
colorfactor=4
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFV(MFd2(i3),MFd2(i1),0._dp,Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFV C[Fd, VG, bar[Fd]]' 
temp=temp+colorfactor*0.5_dp*2*Real(-coup1L*conjg(coup1R),dp)*MFd(i1)*MFd(i3)*Fep_FFVbar(MFd2(i3),MFd2(i1),0._dp,Qscale)
    End Do
End Do
results1(38)=temp
! ---- Fu,VG,bar[Fu] ----
temp=0._dp
Do i1=1,3
    Do i3=1,3
coup1L = cplcFuFuVGL(i3,i1)
coup1R = cplcFuFuVGR(i3,i1)
coup2L = cplcFuFuVGL(i1,i3)
coup2R = cplcFuFuVGR(i1,i3)
colorfactor=4
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2+abs(coup1R)**2)*Fep_FFV(MFu2(i3),MFu2(i1),0._dp,Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFV C[Fu, VG, bar[Fu]]' 
temp=temp+colorfactor*0.5_dp*2*Real(-coup1L*conjg(coup1R),dp)*MFu(i1)*MFu(i3)*Fep_FFVbar(MFu2(i3),MFu2(i1),0._dp,Qscale)
    End Do
End Do
results1(39)=temp
! ---- Glu,Glu,VG ----
temp=0._dp
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
colorfactor=24
temp=temp+colorfactor*0.5_dp*(abs(coup1L)**2)*Fep_FFV(MGlu2,MGlu2,0._dp,Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFV C[Glu, Glu, VG]' 
temp=temp+colorfactor*0.5_dp*Real(coup1L**2,dp)*MGlu*MGlu*Fep_FFVbar(MGlu2,MGlu2,0._dp,Qscale)
results1(40)=temp
! ----- diagrams of type VVV, 1 ------ 
! ---- VG,VG,VG ----
temp=0._dp
coup1 = cplVGVGVG
coup2 = cplVGVGVG
colorfactor=24
temp=temp+colorfactor*1._dp/12._dp*(coup1)**2*Fep_gauge(0._dp,0._dp,0._dp,Qscale)
 if (.not.(temp.eq.temp))  write(*,*) 'NaN at VVV C[VG, VG, VG]' 
results1(41)=temp
! ----- Topology2: diagrams w. 2 Particles and 1 Vertex

! ----- diagrams of type SS, 18 ------ 
! ---- Ah,Sd ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSdcSd(i1,i1,i2,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(MAh2(i1),MSd2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Ah, Ah, Sd, conj[Sd]]' 
  End Do
End Do
results2(1)=temp
! ---- Ah,Se ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSecSe(i1,i1,i2,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(MAh2(i1),MSe2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Ah, Ah, Se, conj[Se]]' 
  End Do
End Do
results2(2)=temp
! ---- Ah,Su ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSucSu(i1,i1,i2,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(MAh2(i1),MSu2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Ah, Ah, Su, conj[Su]]' 
  End Do
End Do
results2(3)=temp
! ---- hh,Sd ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSdcSd(i1,i1,i2,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(Mhh2(i1),MSd2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[hh, hh, Sd, conj[Sd]]' 
  End Do
End Do
results2(4)=temp
! ---- hh,Se ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSecSe(i1,i1,i2,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(Mhh2(i1),MSe2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[hh, hh, Se, conj[Se]]' 
  End Do
End Do
results2(5)=temp
! ---- hh,Su ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSucSu(i1,i1,i2,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(Mhh2(i1),MSu2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[hh, hh, Su, conj[Su]]' 
  End Do
End Do
results2(6)=temp
! ---- Hpm,Sd ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSdcHpmcSd(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MHpm2(i1),MSd2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Sd, conj[Hpm], conj[Sd]]' 
  End Do
End Do
results2(7)=temp
! ---- Hpm,Se ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSecHpmcSe(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MHpm2(i1),MSe2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Se, conj[Hpm], conj[Se]]' 
  End Do
End Do
results2(8)=temp
! ---- Hpm,Su ----
temp=0._dp
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSucHpmcSu(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MHpm2(i1),MSu2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Su, conj[Hpm], conj[Su]]' 
  End Do
End Do
results2(9)=temp
! ---- Hpm,Sv ----
temp=0._dp
Do i1=1,2
 Do i2=1,3
coup1 = cplHpmSvcHpmcSv(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MHpm2(i1),MSv2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Sv, conj[Hpm], conj[Sv]]' 
  End Do
End Do
results2(10)=temp
! ---- Sd,Sd ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSdcSdcSd(i1,i2,i1,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(MSd2(i1),MSd2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Sd, conj[Sd], conj[Sd]]' 
  End Do
End Do
results2(11)=temp
! ---- Sd,Se ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSecSdcSe(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MSd2(i1),MSe2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Se, conj[Sd], conj[Se]]' 
  End Do
End Do
results2(12)=temp
! ---- Sd,Su ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSucSdcSu(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MSd2(i1),MSu2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Su, conj[Sd], conj[Su]]' 
  End Do
End Do
results2(13)=temp
! ---- Sd,Sv ----
temp=0._dp
Do i1=1,6
 Do i2=1,3
coup1 = cplSdSvcSdcSv(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MSd2(i1),MSv2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Sv, conj[Sd], conj[Sv]]' 
  End Do
End Do
results2(14)=temp
! ---- Se,Se ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
coup1 = cplSeSecSecSe(i1,i2,i1,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(MSe2(i1),MSe2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Se, Se, conj[Se], conj[Se]]' 
  End Do
End Do
results2(15)=temp
! ---- Se,Su ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
coup1 = cplSeSucSecSu(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MSe2(i1),MSu2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Se, Su, conj[Se], conj[Su]]' 
  End Do
End Do
results2(16)=temp
! ---- Se,Sv ----
temp=0._dp
Do i1=1,6
 Do i2=1,3
coup1 = cplSeSvcSecSv(i1,i2,i1,i2)
temp=temp+(-1._dp)*(-coup1)*Fep_SS(MSe2(i1),MSv2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Se, Sv, conj[Se], conj[Sv]]' 
  End Do
End Do
results2(17)=temp
! ---- Su,Su ----
temp=0._dp
Do i1=1,6
 Do i2=1,6
coup1 = cplSuSucSucSu(i1,i2,i1,i2)
temp=temp+(-0.5_dp)*(-coup1)*Fep_SS(MSu2(i1),MSu2(i2),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Su, Su, conj[Su], conj[Su]]' 
  End Do
End Do
results2(18)=temp
! ----- diagrams of type VS, 2 ------ 
! ---- Sd,VG ----
temp=0._dp
Do i1=1,6
coup1 = cplSdcSdVGVG(i1,i1)
temp=temp+0.25_dp*coup1*Fep_VS(0._dp,MSd2(i1),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at VS C[Sd, VG, VG, conj[Sd]]' 
End Do
results2(19)=temp
! ---- Su,VG ----
temp=0._dp
Do i1=1,6
coup1 = cplSucSuVGVG(i1,i1)
temp=temp+0.25_dp*coup1*Fep_VS(0._dp,MSu2(i1),Qscale)
if (.not.(temp.eq.temp))  write(*,*) 'NaN at VS C[Su, VG, VG, conj[Su]]' 
End Do
results2(20)=temp
result = sum(results1)+sum(results2) 
effPot2L = result * oo16pi2 * oo16Pi2
End Subroutine CalculateEffPot2Loop


Subroutine SecondDerivativeEffPot2Loop(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,              & 
& Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,pi2L,ti2L)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Integer, Intent(inout):: kont
Real(dp), Intent(out) :: pi2L(2,2),ti2L(2)
Integer :: i,i1,i2,i3,NrContr 
Integer :: iv1, iv2 
Integer :: NrContr1,NrContr2 !nr of contributing diagrams
Real(dp) :: Q2,colorfactor,coeff,coeffbar
Complex(dp) :: result,result_ti,temp,temp_ti,temp_tj,tempbar,tempbar_ti,tempbar_tj
Complex(dp) :: coup1,coup2,coup1L,coup1R,coup2L,coup2R,coupx,coupxbar
Complex(dp) :: Di_coup1,Di_coup2,Di_coup1L,Di_coup1R,Di_coup2L,Di_coup2R,Di_coupx,Di_coupxbar
Complex(dp) :: Dj_coup1,Dj_coup2,Dj_coup1L,Dj_coup1R,Dj_coup2L,Dj_coup2R,Dj_coupx,Dj_coupxbar
Complex(dp) :: DDcoup1,DDcoup2,DDcoup1L,DDcoup1R,DDcoup2L,DDcoup2R,DDcoupx,DDcoupxbar
Complex(dp) :: results1(41),results2(20)
Complex(dp) :: results1_ti(41),results2_ti(20)
Real(dp) :: gout(29328) 
Complex(dp) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

Complex(dp) :: dcplAhSdcSd(2,6,6,2),dcplAhSecSe(2,6,6,2),dcplAhSucSu(2,6,6,2),dcplhhSdcSd(2,6,6,2),  & 
& dcplhhSecSe(2,6,6,2),dcplhhSucSu(2,6,6,2),dcplHpmSucSd(2,6,6,2),dcplHpmSvcSe(2,3,6,2), & 
& dcplSdSvcSd(6,3,6,2),dcplSdcHpmcSu(6,2,6,2),dcplSdcSdcSv(6,6,3,2),dcplSdcSecSu(6,6,6,2),& 
& dcplSeSucSd(6,6,6,2),dcplSeSvcSe(6,3,6,2),dcplSecHpmcSv(6,2,3,2),dcplSecSecSv(6,6,3,2),& 
& dcplSdcSdVG(6,6,2),dcplSucSuVG(6,6,2),dcplVGVGVG(2),dcplcFdFdAhL(3,3,2,2),             & 
& dcplcFdFdAhR(3,3,2,2),dcplcFeFeAhL(3,3,2,2),dcplcFeFeAhR(3,3,2,2),dcplcFuFuAhL(3,3,2,2),& 
& dcplcFuFuAhR(3,3,2,2),dcplChaFucSdL(2,3,6,2),dcplChaFucSdR(2,3,6,2),dcplFvChacSeL(3,2,6,2),& 
& dcplFvChacSeR(3,2,6,2),dcplcFdChaSuL(3,2,6,2),dcplcFdChaSuR(3,2,6,2),dcplcFeChaSvL(3,2,3,2),& 
& dcplcFeChaSvR(3,2,3,2),dcplChiFdcSdL(4,3,6,2),dcplChiFdcSdR(4,3,6,2),dcplChiFecSeL(4,3,6,2),& 
& dcplChiFecSeR(4,3,6,2),dcplChiFucSuL(4,3,6,2),dcplChiFucSuR(4,3,6,2),dcplcFdChiSdL(3,4,6,2),& 
& dcplcFdChiSdR(3,4,6,2),dcplcFeChiSeL(3,4,6,2),dcplcFeChiSeR(3,4,6,2),dcplcFuChiSuL(3,4,6,2),& 
& dcplcFuChiSuR(3,4,6,2),dcplFvFdcSdL(3,3,6,2),dcplFvFdcSdR(3,3,6,2),dcplGluFdcSdL(3,6,2),& 
& dcplGluFdcSdR(3,6,2),dcplcFdFdhhL(3,3,2,2),dcplcFdFdhhR(3,3,2,2),dcplcFdFdSvL(3,3,3,2),& 
& dcplcFdFdSvR(3,3,3,2),dcplcChaFdcSuL(2,3,6,2),dcplcChaFdcSuR(2,3,6,2),dcplcFdFdcSvL(3,3,3,2),& 
& dcplcFdFdcSvR(3,3,3,2),dcplcFeFdcSuL(3,3,6,2),dcplcFeFdcSuR(3,3,6,2),dcplcFuFdcHpmL(3,3,2,2),& 
& dcplcFuFdcHpmR(3,3,2,2),dcplcFuFdcSeL(3,3,6,2),dcplcFuFdcSeR(3,3,6,2),dcplFeFucSdL(3,3,6,2),& 
& dcplFeFucSdR(3,3,6,2),dcplFvFecHpmL(3,3,2,2),dcplFvFecHpmR(3,3,2,2),dcplFvFecSeL(3,3,6,2),& 
& dcplFvFecSeR(3,3,6,2),dcplcFeFehhL(3,3,2,2),dcplcFeFehhR(3,3,2,2),dcplcFdFeSuL(3,3,6,2),& 
& dcplcFdFeSuR(3,3,6,2),dcplcFeFeSvL(3,3,3,2),dcplcFeFeSvR(3,3,3,2),dcplcChaFecSvL(2,3,3,2),& 
& dcplcChaFecSvR(2,3,3,2),dcplcFeFecSvL(3,3,3,2),dcplcFeFecSvR(3,3,3,2),dcplGluFucSuL(3,6,2),& 
& dcplGluFucSuR(3,6,2),dcplcFuFuhhL(3,3,2,2),dcplcFuFuhhR(3,3,2,2),dcplcFdFuHpmL(3,3,2,2),& 
& dcplcFdFuHpmR(3,3,2,2),dcplcFdFuSeL(3,3,6,2),dcplcFdFuSeR(3,3,6,2),dcplcFeFvHpmL(3,3,2,2),& 
& dcplcFeFvHpmR(3,3,2,2),dcplcFdFvSdL(3,3,6,2),dcplcFdFvSdR(3,3,6,2),dcplcChaFvSeL(2,3,6,2),& 
& dcplcChaFvSeR(2,3,6,2),dcplcFeFvSeL(3,3,6,2),dcplcFeFvSeR(3,3,6,2),dcplcFdGluSdL(3,6,2),& 
& dcplcFdGluSdR(3,6,2),dcplcFuGluSuL(3,6,2),dcplcFuGluSuR(3,6,2),dcplcChacFuSdL(2,3,6,2),& 
& dcplcChacFuSdR(2,3,6,2),dcplcFecFuSdL(3,3,6,2),dcplcFecFuSdR(3,3,6,2),dcplcFdFdVGL(3,3,2),& 
& dcplcFdFdVGR(3,3,2),dcplcFuFuVGL(3,3,2),dcplcFuFuVGR(3,3,2),dcplGluGluVGL(2),          & 
& dcplGluGluVGR(2)

Complex(dp) :: dcplAhAhSdcSd(2,2,6,6,2),dcplAhAhSecSe(2,2,6,6,2),dcplAhAhSucSu(2,2,6,6,2),           & 
& dcplhhhhSdcSd(2,2,6,6,2),dcplhhhhSecSe(2,2,6,6,2),dcplhhhhSucSu(2,2,6,6,2),            & 
& dcplHpmSdcHpmcSd(2,6,2,6,2),dcplHpmSecHpmcSe(2,6,2,6,2),dcplHpmSucHpmcSu(2,6,2,6,2),   & 
& dcplHpmSvcHpmcSv(2,3,2,3,2),dcplSdSdcSdcSd(6,6,6,6,2),dcplSdSecSdcSe(6,6,6,6,2),       & 
& dcplSdSucSdcSu(6,6,6,6,2),dcplSdSvcSdcSv(6,3,6,3,2),dcplSeSecSecSe(6,6,6,6,2),         & 
& dcplSeSucSecSu(6,6,6,6,2),dcplSeSvcSecSv(6,3,6,3,2),dcplSuSucSucSu(6,6,6,6,2),         & 
& dcplSdcSdVGVG(6,6,2),dcplSucSuVGVG(6,6,2)

Complex(dp) :: ddcplAhSdcSd(2,6,6,2,2),ddcplAhSecSe(2,6,6,2,2),ddcplAhSucSu(2,6,6,2,2),              & 
& ddcplhhSdcSd(2,6,6,2,2),ddcplhhSecSe(2,6,6,2,2),ddcplhhSucSu(2,6,6,2,2),               & 
& ddcplHpmSucSd(2,6,6,2,2),ddcplHpmSvcSe(2,3,6,2,2),ddcplSdSvcSd(6,3,6,2,2),             & 
& ddcplSdcHpmcSu(6,2,6,2,2),ddcplSdcSdcSv(6,6,3,2,2),ddcplSdcSecSu(6,6,6,2,2),           & 
& ddcplSeSucSd(6,6,6,2,2),ddcplSeSvcSe(6,3,6,2,2),ddcplSecHpmcSv(6,2,3,2,2),             & 
& ddcplSecSecSv(6,6,3,2,2),ddcplSdcSdVG(6,6,2,2),ddcplSucSuVG(6,6,2,2),ddcplVGVGVG(2,2), & 
& ddcplcFdFdAhL(3,3,2,2,2),ddcplcFdFdAhR(3,3,2,2,2),ddcplcFeFeAhL(3,3,2,2,2),            & 
& ddcplcFeFeAhR(3,3,2,2,2),ddcplcFuFuAhL(3,3,2,2,2),ddcplcFuFuAhR(3,3,2,2,2),            & 
& ddcplChaFucSdL(2,3,6,2,2),ddcplChaFucSdR(2,3,6,2,2),ddcplFvChacSeL(3,2,6,2,2),         & 
& ddcplFvChacSeR(3,2,6,2,2),ddcplcFdChaSuL(3,2,6,2,2),ddcplcFdChaSuR(3,2,6,2,2),         & 
& ddcplcFeChaSvL(3,2,3,2,2),ddcplcFeChaSvR(3,2,3,2,2),ddcplChiFdcSdL(4,3,6,2,2),         & 
& ddcplChiFdcSdR(4,3,6,2,2),ddcplChiFecSeL(4,3,6,2,2),ddcplChiFecSeR(4,3,6,2,2),         & 
& ddcplChiFucSuL(4,3,6,2,2),ddcplChiFucSuR(4,3,6,2,2),ddcplcFdChiSdL(3,4,6,2,2),         & 
& ddcplcFdChiSdR(3,4,6,2,2),ddcplcFeChiSeL(3,4,6,2,2),ddcplcFeChiSeR(3,4,6,2,2),         & 
& ddcplcFuChiSuL(3,4,6,2,2),ddcplcFuChiSuR(3,4,6,2,2),ddcplFvFdcSdL(3,3,6,2,2),          & 
& ddcplFvFdcSdR(3,3,6,2,2),ddcplGluFdcSdL(3,6,2,2),ddcplGluFdcSdR(3,6,2,2),              & 
& ddcplcFdFdhhL(3,3,2,2,2),ddcplcFdFdhhR(3,3,2,2,2),ddcplcFdFdSvL(3,3,3,2,2),            & 
& ddcplcFdFdSvR(3,3,3,2,2),ddcplcChaFdcSuL(2,3,6,2,2),ddcplcChaFdcSuR(2,3,6,2,2),        & 
& ddcplcFdFdcSvL(3,3,3,2,2),ddcplcFdFdcSvR(3,3,3,2,2),ddcplcFeFdcSuL(3,3,6,2,2),         & 
& ddcplcFeFdcSuR(3,3,6,2,2),ddcplcFuFdcHpmL(3,3,2,2,2),ddcplcFuFdcHpmR(3,3,2,2,2),       & 
& ddcplcFuFdcSeL(3,3,6,2,2),ddcplcFuFdcSeR(3,3,6,2,2),ddcplFeFucSdL(3,3,6,2,2),          & 
& ddcplFeFucSdR(3,3,6,2,2),ddcplFvFecHpmL(3,3,2,2,2),ddcplFvFecHpmR(3,3,2,2,2),          & 
& ddcplFvFecSeL(3,3,6,2,2),ddcplFvFecSeR(3,3,6,2,2),ddcplcFeFehhL(3,3,2,2,2),            & 
& ddcplcFeFehhR(3,3,2,2,2),ddcplcFdFeSuL(3,3,6,2,2),ddcplcFdFeSuR(3,3,6,2,2),            & 
& ddcplcFeFeSvL(3,3,3,2,2),ddcplcFeFeSvR(3,3,3,2,2),ddcplcChaFecSvL(2,3,3,2,2),          & 
& ddcplcChaFecSvR(2,3,3,2,2),ddcplcFeFecSvL(3,3,3,2,2),ddcplcFeFecSvR(3,3,3,2,2),        & 
& ddcplGluFucSuL(3,6,2,2),ddcplGluFucSuR(3,6,2,2),ddcplcFuFuhhL(3,3,2,2,2),              & 
& ddcplcFuFuhhR(3,3,2,2,2),ddcplcFdFuHpmL(3,3,2,2,2),ddcplcFdFuHpmR(3,3,2,2,2),          & 
& ddcplcFdFuSeL(3,3,6,2,2),ddcplcFdFuSeR(3,3,6,2,2),ddcplcFeFvHpmL(3,3,2,2,2),           & 
& ddcplcFeFvHpmR(3,3,2,2,2),ddcplcFdFvSdL(3,3,6,2,2),ddcplcFdFvSdR(3,3,6,2,2),           & 
& ddcplcChaFvSeL(2,3,6,2,2),ddcplcChaFvSeR(2,3,6,2,2),ddcplcFeFvSeL(3,3,6,2,2),          & 
& ddcplcFeFvSeR(3,3,6,2,2),ddcplcFdGluSdL(3,6,2,2),ddcplcFdGluSdR(3,6,2,2),              & 
& ddcplcFuGluSuL(3,6,2,2),ddcplcFuGluSuR(3,6,2,2),ddcplcChacFuSdL(2,3,6,2,2),            & 
& ddcplcChacFuSdR(2,3,6,2,2),ddcplcFecFuSdL(3,3,6,2,2),ddcplcFecFuSdR(3,3,6,2,2),        & 
& ddcplcFdFdVGL(3,3,2,2),ddcplcFdFdVGR(3,3,2,2),ddcplcFuFuVGL(3,3,2,2),ddcplcFuFuVGR(3,3,2,2),& 
& ddcplGluGluVGL(2,2),ddcplGluGluVGR(2,2)

Complex(dp) :: ddcplAhAhSdcSd(2,2,6,6,2,2),ddcplAhAhSecSe(2,2,6,6,2,2),ddcplAhAhSucSu(2,2,6,6,2,2),  & 
& ddcplhhhhSdcSd(2,2,6,6,2,2),ddcplhhhhSecSe(2,2,6,6,2,2),ddcplhhhhSucSu(2,2,6,6,2,2),   & 
& ddcplHpmSdcHpmcSd(2,6,2,6,2,2),ddcplHpmSecHpmcSe(2,6,2,6,2,2),ddcplHpmSucHpmcSu(2,6,2,6,2,2),& 
& ddcplHpmSvcHpmcSv(2,3,2,3,2,2),ddcplSdSdcSdcSd(6,6,6,6,2,2),ddcplSdSecSdcSe(6,6,6,6,2,2),& 
& ddcplSdSucSdcSu(6,6,6,6,2,2),ddcplSdSvcSdcSv(6,3,6,3,2,2),ddcplSeSecSecSe(6,6,6,6,2,2),& 
& ddcplSeSucSecSu(6,6,6,6,2,2),ddcplSeSvcSecSv(6,3,6,3,2,2),ddcplSuSucSucSu(6,6,6,6,2,2),& 
& ddcplSdcSdVGVG(6,6,2,2),ddcplSucSuVGVG(6,6,2,2)

Real(dp) :: MSd(6),MSd2(6),MSv(3),MSv2(3),MSu(6),MSu2(6),MSe(6),MSe2(6),Mhh(2),Mhh2(2),           & 
& MAh(2),MAh2(2),MHpm(2),MHpm2(2),MChi(4),MChi2(4),MCha(2),MCha2(2),MFe(3),              & 
& MFe2(3),MFd(3),MFd2(3),MFu(3),MFu2(3),MGlu,MGlu2,MVZ,MVZ2,MVWm,MVWm2

Complex(dp) :: dMSd(6,2),dMSd2(6,2),dMSv(3,2),dMSv2(3,2),dMSu(6,2),dMSu2(6,2),dMSe(6,2),             & 
& dMSe2(6,2),dMhh(2,2),dMhh2(2,2),dMAh(2,2),dMAh2(2,2),dMHpm(2,2),dMHpm2(2,2),           & 
& dMChi(4,2),dMChi2(4,2),dMCha(2,2),dMCha2(2,2),dMFe(3,2),dMFe2(3,2),dMFd(3,2),          & 
& dMFd2(3,2),dMFu(3,2),dMFu2(3,2),dMGlu(1,2),dMGlu2(1,2),dMVZ(1,2),dMVZ2(1,2),           & 
& dMVWm(1,2),dMVWm2(1,2)

Complex(dp) :: ddMSd(6,2,2),ddMSd2(6,2,2),ddMSv(3,2,2),ddMSv2(3,2,2),ddMSu(6,2,2),ddMSu2(6,2,2),     & 
& ddMSe(6,2,2),ddMSe2(6,2,2),ddMhh(2,2,2),ddMhh2(2,2,2),ddMAh(2,2,2),ddMAh2(2,2,2),      & 
& ddMHpm(2,2,2),ddMHpm2(2,2,2),ddMChi(4,2,2),ddMChi2(4,2,2),ddMCha(2,2,2),               & 
& ddMCha2(2,2,2),ddMFe(3,2,2),ddMFe2(3,2,2),ddMFd(3,2,2),ddMFd2(3,2,2),ddMFu(3,2,2),     & 
& ddMFu2(3,2,2),ddMGlu(1,2,2),ddMGlu2(1,2,2),ddMVZ(1,2,2),ddMVZ2(1,2,2),ddMVWm(1,2,2),   & 
& ddMVWm2(1,2,2)

!! ------------------------------------------------- 
!! Calculate masses, couplings and their derivatives 
!! ------------------------------------------------- 

Do i1=1,2
Call FirstDerivativeMassesCoups(i1,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,               & 
& Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

Call GToMassesCoups(gout,MSd,MSd2,MSv,MSv2,MSu,MSu2,MSe,MSe2,Mhh,Mhh2,MAh,            & 
& MAh2,MHpm,MHpm2,MChi,MChi2,MCha,MCha2,MFe,MFe2,MFd,MFd2,MFu,MFu2,MGlu,MGlu2,           & 
& MVZ,MVZ2,MVWm,MVWm2,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplhhSdcSd,cplhhSecSe,            & 
& cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,    & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,             & 
& cplAhAhSdcSd,cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,         & 
& cplHpmSdcHpmcSd,cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,         & 
& cplSdSecSdcSe,cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,   & 
& cplSuSucSucSu,cplSdcSdVGVG,cplSucSuVGVG)

dMSd(:,i1) = MSd
dMSd2(:,i1) = MSd2
dMSv(:,i1) = MSv
dMSv2(:,i1) = MSv2
dMSu(:,i1) = MSu
dMSu2(:,i1) = MSu2
dMSe(:,i1) = MSe
dMSe2(:,i1) = MSe2
dMhh(:,i1) = Mhh
dMhh2(:,i1) = Mhh2
dMAh(:,i1) = MAh
dMAh2(:,i1) = MAh2
dMHpm(:,i1) = MHpm
dMHpm2(:,i1) = MHpm2
dMChi(:,i1) = MChi
dMChi2(:,i1) = MChi2
dMCha(:,i1) = MCha
dMCha2(:,i1) = MCha2
dMFe(:,i1) = MFe
dMFe2(:,i1) = MFe2
dMFd(:,i1) = MFd
dMFd2(:,i1) = MFd2
dMFu(:,i1) = MFu
dMFu2(:,i1) = MFu2
dMGlu(:,i1) = MGlu
dMGlu2(:,i1) = MGlu2
dMVZ(:,i1) = MVZ
dMVZ2(:,i1) = MVZ2
dMVWm(:,i1) = MVWm
dMVWm2(:,i1) = MVWm2
dcplAhSdcSd(:,:,:,i1) = cplAhSdcSd
dcplAhSecSe(:,:,:,i1) = cplAhSecSe
dcplAhSucSu(:,:,:,i1) = cplAhSucSu
dcplhhSdcSd(:,:,:,i1) = cplhhSdcSd
dcplhhSecSe(:,:,:,i1) = cplhhSecSe
dcplhhSucSu(:,:,:,i1) = cplhhSucSu
dcplHpmSucSd(:,:,:,i1) = cplHpmSucSd
dcplHpmSvcSe(:,:,:,i1) = cplHpmSvcSe
dcplSdSvcSd(:,:,:,i1) = cplSdSvcSd
dcplSdcHpmcSu(:,:,:,i1) = cplSdcHpmcSu
dcplSdcSdcSv(:,:,:,i1) = cplSdcSdcSv
dcplSdcSecSu(:,:,:,i1) = cplSdcSecSu
dcplSeSucSd(:,:,:,i1) = cplSeSucSd
dcplSeSvcSe(:,:,:,i1) = cplSeSvcSe
dcplSecHpmcSv(:,:,:,i1) = cplSecHpmcSv
dcplSecSecSv(:,:,:,i1) = cplSecSecSv
dcplSdcSdVG(:,:,i1) = cplSdcSdVG
dcplSucSuVG(:,:,i1) = cplSucSuVG
dcplVGVGVG(i1) = cplVGVGVG
dcplcFdFdAhL(:,:,:,i1) = cplcFdFdAhL
dcplcFdFdAhR(:,:,:,i1) = cplcFdFdAhR
dcplcFeFeAhL(:,:,:,i1) = cplcFeFeAhL
dcplcFeFeAhR(:,:,:,i1) = cplcFeFeAhR
dcplcFuFuAhL(:,:,:,i1) = cplcFuFuAhL
dcplcFuFuAhR(:,:,:,i1) = cplcFuFuAhR
dcplChaFucSdL(:,:,:,i1) = cplChaFucSdL
dcplChaFucSdR(:,:,:,i1) = cplChaFucSdR
dcplFvChacSeL(:,:,:,i1) = cplFvChacSeL
dcplFvChacSeR(:,:,:,i1) = cplFvChacSeR
dcplcFdChaSuL(:,:,:,i1) = cplcFdChaSuL
dcplcFdChaSuR(:,:,:,i1) = cplcFdChaSuR
dcplcFeChaSvL(:,:,:,i1) = cplcFeChaSvL
dcplcFeChaSvR(:,:,:,i1) = cplcFeChaSvR
dcplChiFdcSdL(:,:,:,i1) = cplChiFdcSdL
dcplChiFdcSdR(:,:,:,i1) = cplChiFdcSdR
dcplChiFecSeL(:,:,:,i1) = cplChiFecSeL
dcplChiFecSeR(:,:,:,i1) = cplChiFecSeR
dcplChiFucSuL(:,:,:,i1) = cplChiFucSuL
dcplChiFucSuR(:,:,:,i1) = cplChiFucSuR
dcplcFdChiSdL(:,:,:,i1) = cplcFdChiSdL
dcplcFdChiSdR(:,:,:,i1) = cplcFdChiSdR
dcplcFeChiSeL(:,:,:,i1) = cplcFeChiSeL
dcplcFeChiSeR(:,:,:,i1) = cplcFeChiSeR
dcplcFuChiSuL(:,:,:,i1) = cplcFuChiSuL
dcplcFuChiSuR(:,:,:,i1) = cplcFuChiSuR
dcplFvFdcSdL(:,:,:,i1) = cplFvFdcSdL
dcplFvFdcSdR(:,:,:,i1) = cplFvFdcSdR
dcplGluFdcSdL(:,:,i1) = cplGluFdcSdL
dcplGluFdcSdR(:,:,i1) = cplGluFdcSdR
dcplcFdFdhhL(:,:,:,i1) = cplcFdFdhhL
dcplcFdFdhhR(:,:,:,i1) = cplcFdFdhhR
dcplcFdFdSvL(:,:,:,i1) = cplcFdFdSvL
dcplcFdFdSvR(:,:,:,i1) = cplcFdFdSvR
dcplcChaFdcSuL(:,:,:,i1) = cplcChaFdcSuL
dcplcChaFdcSuR(:,:,:,i1) = cplcChaFdcSuR
dcplcFdFdcSvL(:,:,:,i1) = cplcFdFdcSvL
dcplcFdFdcSvR(:,:,:,i1) = cplcFdFdcSvR
dcplcFeFdcSuL(:,:,:,i1) = cplcFeFdcSuL
dcplcFeFdcSuR(:,:,:,i1) = cplcFeFdcSuR
dcplcFuFdcHpmL(:,:,:,i1) = cplcFuFdcHpmL
dcplcFuFdcHpmR(:,:,:,i1) = cplcFuFdcHpmR
dcplcFuFdcSeL(:,:,:,i1) = cplcFuFdcSeL
dcplcFuFdcSeR(:,:,:,i1) = cplcFuFdcSeR
dcplFeFucSdL(:,:,:,i1) = cplFeFucSdL
dcplFeFucSdR(:,:,:,i1) = cplFeFucSdR
dcplFvFecHpmL(:,:,:,i1) = cplFvFecHpmL
dcplFvFecHpmR(:,:,:,i1) = cplFvFecHpmR
dcplFvFecSeL(:,:,:,i1) = cplFvFecSeL
dcplFvFecSeR(:,:,:,i1) = cplFvFecSeR
dcplcFeFehhL(:,:,:,i1) = cplcFeFehhL
dcplcFeFehhR(:,:,:,i1) = cplcFeFehhR
dcplcFdFeSuL(:,:,:,i1) = cplcFdFeSuL
dcplcFdFeSuR(:,:,:,i1) = cplcFdFeSuR
dcplcFeFeSvL(:,:,:,i1) = cplcFeFeSvL
dcplcFeFeSvR(:,:,:,i1) = cplcFeFeSvR
dcplcChaFecSvL(:,:,:,i1) = cplcChaFecSvL
dcplcChaFecSvR(:,:,:,i1) = cplcChaFecSvR
dcplcFeFecSvL(:,:,:,i1) = cplcFeFecSvL
dcplcFeFecSvR(:,:,:,i1) = cplcFeFecSvR
dcplGluFucSuL(:,:,i1) = cplGluFucSuL
dcplGluFucSuR(:,:,i1) = cplGluFucSuR
dcplcFuFuhhL(:,:,:,i1) = cplcFuFuhhL
dcplcFuFuhhR(:,:,:,i1) = cplcFuFuhhR
dcplcFdFuHpmL(:,:,:,i1) = cplcFdFuHpmL
dcplcFdFuHpmR(:,:,:,i1) = cplcFdFuHpmR
dcplcFdFuSeL(:,:,:,i1) = cplcFdFuSeL
dcplcFdFuSeR(:,:,:,i1) = cplcFdFuSeR
dcplcFeFvHpmL(:,:,:,i1) = cplcFeFvHpmL
dcplcFeFvHpmR(:,:,:,i1) = cplcFeFvHpmR
dcplcFdFvSdL(:,:,:,i1) = cplcFdFvSdL
dcplcFdFvSdR(:,:,:,i1) = cplcFdFvSdR
dcplcChaFvSeL(:,:,:,i1) = cplcChaFvSeL
dcplcChaFvSeR(:,:,:,i1) = cplcChaFvSeR
dcplcFeFvSeL(:,:,:,i1) = cplcFeFvSeL
dcplcFeFvSeR(:,:,:,i1) = cplcFeFvSeR
dcplcFdGluSdL(:,:,i1) = cplcFdGluSdL
dcplcFdGluSdR(:,:,i1) = cplcFdGluSdR
dcplcFuGluSuL(:,:,i1) = cplcFuGluSuL
dcplcFuGluSuR(:,:,i1) = cplcFuGluSuR
dcplcChacFuSdL(:,:,:,i1) = cplcChacFuSdL
dcplcChacFuSdR(:,:,:,i1) = cplcChacFuSdR
dcplcFecFuSdL(:,:,:,i1) = cplcFecFuSdL
dcplcFecFuSdR(:,:,:,i1) = cplcFecFuSdR
dcplcFdFdVGL(:,:,i1) = cplcFdFdVGL
dcplcFdFdVGR(:,:,i1) = cplcFdFdVGR
dcplcFuFuVGL(:,:,i1) = cplcFuFuVGL
dcplcFuFuVGR(:,:,i1) = cplcFuFuVGR
dcplGluGluVGL(i1) = cplGluGluVGL
dcplGluGluVGR(i1) = cplGluGluVGR
dcplAhAhSdcSd(:,:,:,:,i1) = cplAhAhSdcSd
dcplAhAhSecSe(:,:,:,:,i1) = cplAhAhSecSe
dcplAhAhSucSu(:,:,:,:,i1) = cplAhAhSucSu
dcplhhhhSdcSd(:,:,:,:,i1) = cplhhhhSdcSd
dcplhhhhSecSe(:,:,:,:,i1) = cplhhhhSecSe
dcplhhhhSucSu(:,:,:,:,i1) = cplhhhhSucSu
dcplHpmSdcHpmcSd(:,:,:,:,i1) = cplHpmSdcHpmcSd
dcplHpmSecHpmcSe(:,:,:,:,i1) = cplHpmSecHpmcSe
dcplHpmSucHpmcSu(:,:,:,:,i1) = cplHpmSucHpmcSu
dcplHpmSvcHpmcSv(:,:,:,:,i1) = cplHpmSvcHpmcSv
dcplSdSdcSdcSd(:,:,:,:,i1) = cplSdSdcSdcSd
dcplSdSecSdcSe(:,:,:,:,i1) = cplSdSecSdcSe
dcplSdSucSdcSu(:,:,:,:,i1) = cplSdSucSdcSu
dcplSdSvcSdcSv(:,:,:,:,i1) = cplSdSvcSdcSv
dcplSeSecSecSe(:,:,:,:,i1) = cplSeSecSecSe
dcplSeSucSecSu(:,:,:,:,i1) = cplSeSucSecSu
dcplSeSvcSecSv(:,:,:,:,i1) = cplSeSvcSecSv
dcplSuSucSucSu(:,:,:,:,i1) = cplSuSucSucSu
dcplSdcSdVGVG(:,:,i1) = cplSdcSdVGVG
dcplSucSuVGVG(:,:,i1) = cplSucSuVGVG
End Do 
 
Do i1=1,2
  Do i2=i1,2
Call SecondDerivativeMassesCoups(i1,i2,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,              & 
& Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

Call GToMassesCoups(gout,MSd,MSd2,MSv,MSv2,MSu,MSu2,MSe,MSe2,Mhh,Mhh2,MAh,            & 
& MAh2,MHpm,MHpm2,MChi,MChi2,MCha,MCha2,MFe,MFe2,MFd,MFd2,MFu,MFu2,MGlu,MGlu2,           & 
& MVZ,MVZ2,MVWm,MVWm2,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplhhSdcSd,cplhhSecSe,            & 
& cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,    & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,             & 
& cplAhAhSdcSd,cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,         & 
& cplHpmSdcHpmcSd,cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,         & 
& cplSdSecSdcSe,cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,   & 
& cplSuSucSucSu,cplSdcSdVGVG,cplSucSuVGVG)

ddMSd(:,i1,i2) = MSd
ddMSd2(:,i1,i2) = MSd2
ddMSv(:,i1,i2) = MSv
ddMSv2(:,i1,i2) = MSv2
ddMSu(:,i1,i2) = MSu
ddMSu2(:,i1,i2) = MSu2
ddMSe(:,i1,i2) = MSe
ddMSe2(:,i1,i2) = MSe2
ddMhh(:,i1,i2) = Mhh
ddMhh2(:,i1,i2) = Mhh2
ddMAh(:,i1,i2) = MAh
ddMAh2(:,i1,i2) = MAh2
ddMHpm(:,i1,i2) = MHpm
ddMHpm2(:,i1,i2) = MHpm2
ddMChi(:,i1,i2) = MChi
ddMChi2(:,i1,i2) = MChi2
ddMCha(:,i1,i2) = MCha
ddMCha2(:,i1,i2) = MCha2
ddMFe(:,i1,i2) = MFe
ddMFe2(:,i1,i2) = MFe2
ddMFd(:,i1,i2) = MFd
ddMFd2(:,i1,i2) = MFd2
ddMFu(:,i1,i2) = MFu
ddMFu2(:,i1,i2) = MFu2
ddMGlu(:,i1,i2) = MGlu
ddMGlu2(:,i1,i2) = MGlu2
ddMVZ(:,i1,i2) = MVZ
ddMVZ2(:,i1,i2) = MVZ2
ddMVWm(:,i1,i2) = MVWm
ddMVWm2(:,i1,i2) = MVWm2
ddcplAhSdcSd(:,:,:,i1,i2) = cplAhSdcSd
ddcplAhSecSe(:,:,:,i1,i2) = cplAhSecSe
ddcplAhSucSu(:,:,:,i1,i2) = cplAhSucSu
ddcplhhSdcSd(:,:,:,i1,i2) = cplhhSdcSd
ddcplhhSecSe(:,:,:,i1,i2) = cplhhSecSe
ddcplhhSucSu(:,:,:,i1,i2) = cplhhSucSu
ddcplHpmSucSd(:,:,:,i1,i2) = cplHpmSucSd
ddcplHpmSvcSe(:,:,:,i1,i2) = cplHpmSvcSe
ddcplSdSvcSd(:,:,:,i1,i2) = cplSdSvcSd
ddcplSdcHpmcSu(:,:,:,i1,i2) = cplSdcHpmcSu
ddcplSdcSdcSv(:,:,:,i1,i2) = cplSdcSdcSv
ddcplSdcSecSu(:,:,:,i1,i2) = cplSdcSecSu
ddcplSeSucSd(:,:,:,i1,i2) = cplSeSucSd
ddcplSeSvcSe(:,:,:,i1,i2) = cplSeSvcSe
ddcplSecHpmcSv(:,:,:,i1,i2) = cplSecHpmcSv
ddcplSecSecSv(:,:,:,i1,i2) = cplSecSecSv
ddcplSdcSdVG(:,:,i1,i2) = cplSdcSdVG
ddcplSucSuVG(:,:,i1,i2) = cplSucSuVG
ddcplVGVGVG(i1,i2) = cplVGVGVG
ddcplcFdFdAhL(:,:,:,i1,i2) = cplcFdFdAhL
ddcplcFdFdAhR(:,:,:,i1,i2) = cplcFdFdAhR
ddcplcFeFeAhL(:,:,:,i1,i2) = cplcFeFeAhL
ddcplcFeFeAhR(:,:,:,i1,i2) = cplcFeFeAhR
ddcplcFuFuAhL(:,:,:,i1,i2) = cplcFuFuAhL
ddcplcFuFuAhR(:,:,:,i1,i2) = cplcFuFuAhR
ddcplChaFucSdL(:,:,:,i1,i2) = cplChaFucSdL
ddcplChaFucSdR(:,:,:,i1,i2) = cplChaFucSdR
ddcplFvChacSeL(:,:,:,i1,i2) = cplFvChacSeL
ddcplFvChacSeR(:,:,:,i1,i2) = cplFvChacSeR
ddcplcFdChaSuL(:,:,:,i1,i2) = cplcFdChaSuL
ddcplcFdChaSuR(:,:,:,i1,i2) = cplcFdChaSuR
ddcplcFeChaSvL(:,:,:,i1,i2) = cplcFeChaSvL
ddcplcFeChaSvR(:,:,:,i1,i2) = cplcFeChaSvR
ddcplChiFdcSdL(:,:,:,i1,i2) = cplChiFdcSdL
ddcplChiFdcSdR(:,:,:,i1,i2) = cplChiFdcSdR
ddcplChiFecSeL(:,:,:,i1,i2) = cplChiFecSeL
ddcplChiFecSeR(:,:,:,i1,i2) = cplChiFecSeR
ddcplChiFucSuL(:,:,:,i1,i2) = cplChiFucSuL
ddcplChiFucSuR(:,:,:,i1,i2) = cplChiFucSuR
ddcplcFdChiSdL(:,:,:,i1,i2) = cplcFdChiSdL
ddcplcFdChiSdR(:,:,:,i1,i2) = cplcFdChiSdR
ddcplcFeChiSeL(:,:,:,i1,i2) = cplcFeChiSeL
ddcplcFeChiSeR(:,:,:,i1,i2) = cplcFeChiSeR
ddcplcFuChiSuL(:,:,:,i1,i2) = cplcFuChiSuL
ddcplcFuChiSuR(:,:,:,i1,i2) = cplcFuChiSuR
ddcplFvFdcSdL(:,:,:,i1,i2) = cplFvFdcSdL
ddcplFvFdcSdR(:,:,:,i1,i2) = cplFvFdcSdR
ddcplGluFdcSdL(:,:,i1,i2) = cplGluFdcSdL
ddcplGluFdcSdR(:,:,i1,i2) = cplGluFdcSdR
ddcplcFdFdhhL(:,:,:,i1,i2) = cplcFdFdhhL
ddcplcFdFdhhR(:,:,:,i1,i2) = cplcFdFdhhR
ddcplcFdFdSvL(:,:,:,i1,i2) = cplcFdFdSvL
ddcplcFdFdSvR(:,:,:,i1,i2) = cplcFdFdSvR
ddcplcChaFdcSuL(:,:,:,i1,i2) = cplcChaFdcSuL
ddcplcChaFdcSuR(:,:,:,i1,i2) = cplcChaFdcSuR
ddcplcFdFdcSvL(:,:,:,i1,i2) = cplcFdFdcSvL
ddcplcFdFdcSvR(:,:,:,i1,i2) = cplcFdFdcSvR
ddcplcFeFdcSuL(:,:,:,i1,i2) = cplcFeFdcSuL
ddcplcFeFdcSuR(:,:,:,i1,i2) = cplcFeFdcSuR
ddcplcFuFdcHpmL(:,:,:,i1,i2) = cplcFuFdcHpmL
ddcplcFuFdcHpmR(:,:,:,i1,i2) = cplcFuFdcHpmR
ddcplcFuFdcSeL(:,:,:,i1,i2) = cplcFuFdcSeL
ddcplcFuFdcSeR(:,:,:,i1,i2) = cplcFuFdcSeR
ddcplFeFucSdL(:,:,:,i1,i2) = cplFeFucSdL
ddcplFeFucSdR(:,:,:,i1,i2) = cplFeFucSdR
ddcplFvFecHpmL(:,:,:,i1,i2) = cplFvFecHpmL
ddcplFvFecHpmR(:,:,:,i1,i2) = cplFvFecHpmR
ddcplFvFecSeL(:,:,:,i1,i2) = cplFvFecSeL
ddcplFvFecSeR(:,:,:,i1,i2) = cplFvFecSeR
ddcplcFeFehhL(:,:,:,i1,i2) = cplcFeFehhL
ddcplcFeFehhR(:,:,:,i1,i2) = cplcFeFehhR
ddcplcFdFeSuL(:,:,:,i1,i2) = cplcFdFeSuL
ddcplcFdFeSuR(:,:,:,i1,i2) = cplcFdFeSuR
ddcplcFeFeSvL(:,:,:,i1,i2) = cplcFeFeSvL
ddcplcFeFeSvR(:,:,:,i1,i2) = cplcFeFeSvR
ddcplcChaFecSvL(:,:,:,i1,i2) = cplcChaFecSvL
ddcplcChaFecSvR(:,:,:,i1,i2) = cplcChaFecSvR
ddcplcFeFecSvL(:,:,:,i1,i2) = cplcFeFecSvL
ddcplcFeFecSvR(:,:,:,i1,i2) = cplcFeFecSvR
ddcplGluFucSuL(:,:,i1,i2) = cplGluFucSuL
ddcplGluFucSuR(:,:,i1,i2) = cplGluFucSuR
ddcplcFuFuhhL(:,:,:,i1,i2) = cplcFuFuhhL
ddcplcFuFuhhR(:,:,:,i1,i2) = cplcFuFuhhR
ddcplcFdFuHpmL(:,:,:,i1,i2) = cplcFdFuHpmL
ddcplcFdFuHpmR(:,:,:,i1,i2) = cplcFdFuHpmR
ddcplcFdFuSeL(:,:,:,i1,i2) = cplcFdFuSeL
ddcplcFdFuSeR(:,:,:,i1,i2) = cplcFdFuSeR
ddcplcFeFvHpmL(:,:,:,i1,i2) = cplcFeFvHpmL
ddcplcFeFvHpmR(:,:,:,i1,i2) = cplcFeFvHpmR
ddcplcFdFvSdL(:,:,:,i1,i2) = cplcFdFvSdL
ddcplcFdFvSdR(:,:,:,i1,i2) = cplcFdFvSdR
ddcplcChaFvSeL(:,:,:,i1,i2) = cplcChaFvSeL
ddcplcChaFvSeR(:,:,:,i1,i2) = cplcChaFvSeR
ddcplcFeFvSeL(:,:,:,i1,i2) = cplcFeFvSeL
ddcplcFeFvSeR(:,:,:,i1,i2) = cplcFeFvSeR
ddcplcFdGluSdL(:,:,i1,i2) = cplcFdGluSdL
ddcplcFdGluSdR(:,:,i1,i2) = cplcFdGluSdR
ddcplcFuGluSuL(:,:,i1,i2) = cplcFuGluSuL
ddcplcFuGluSuR(:,:,i1,i2) = cplcFuGluSuR
ddcplcChacFuSdL(:,:,:,i1,i2) = cplcChacFuSdL
ddcplcChacFuSdR(:,:,:,i1,i2) = cplcChacFuSdR
ddcplcFecFuSdL(:,:,:,i1,i2) = cplcFecFuSdL
ddcplcFecFuSdR(:,:,:,i1,i2) = cplcFecFuSdR
ddcplcFdFdVGL(:,:,i1,i2) = cplcFdFdVGL
ddcplcFdFdVGR(:,:,i1,i2) = cplcFdFdVGR
ddcplcFuFuVGL(:,:,i1,i2) = cplcFuFuVGL
ddcplcFuFuVGR(:,:,i1,i2) = cplcFuFuVGR
ddcplGluGluVGL(i1,i2) = cplGluGluVGL
ddcplGluGluVGR(i1,i2) = cplGluGluVGR
ddcplAhAhSdcSd(:,:,:,:,i1,i2) = cplAhAhSdcSd
ddcplAhAhSecSe(:,:,:,:,i1,i2) = cplAhAhSecSe
ddcplAhAhSucSu(:,:,:,:,i1,i2) = cplAhAhSucSu
ddcplhhhhSdcSd(:,:,:,:,i1,i2) = cplhhhhSdcSd
ddcplhhhhSecSe(:,:,:,:,i1,i2) = cplhhhhSecSe
ddcplhhhhSucSu(:,:,:,:,i1,i2) = cplhhhhSucSu
ddcplHpmSdcHpmcSd(:,:,:,:,i1,i2) = cplHpmSdcHpmcSd
ddcplHpmSecHpmcSe(:,:,:,:,i1,i2) = cplHpmSecHpmcSe
ddcplHpmSucHpmcSu(:,:,:,:,i1,i2) = cplHpmSucHpmcSu
ddcplHpmSvcHpmcSv(:,:,:,:,i1,i2) = cplHpmSvcHpmcSv
ddcplSdSdcSdcSd(:,:,:,:,i1,i2) = cplSdSdcSdcSd
ddcplSdSecSdcSe(:,:,:,:,i1,i2) = cplSdSecSdcSe
ddcplSdSucSdcSu(:,:,:,:,i1,i2) = cplSdSucSdcSu
ddcplSdSvcSdcSv(:,:,:,:,i1,i2) = cplSdSvcSdcSv
ddcplSeSecSecSe(:,:,:,:,i1,i2) = cplSeSecSecSe
ddcplSeSucSecSu(:,:,:,:,i1,i2) = cplSeSucSecSu
ddcplSeSvcSecSv(:,:,:,:,i1,i2) = cplSeSvcSecSv
ddcplSuSucSucSu(:,:,:,:,i1,i2) = cplSuSucSucSu
ddcplSdcSdVGVG(:,:,i1,i2) = cplSdcSdVGVG
ddcplSucSuVGVG(:,:,i1,i2) = cplSucSuVGVG
  End Do 
 End Do 
 
Call TreeMassesEffPot(MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,             & 
& Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,.True.,kont)

Call CouplingsForEffPot3(Mu,Yd,Td,ZD,ZA,Ye,Te,ZE,Yu,Tu,ZU,vd,ZH,vu,ZP,ZV,             & 
& L2,T2,L1,T1,g3,ZDL,ZDR,ZEL,ZER,ZUL,ZUR,UM,UP,ZN,pG,cplAhSdcSd,cplAhSecSe,              & 
& cplAhSucSu,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,        & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,               & 
& cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,            & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,        & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,         & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR)

Call CouplingsForEffPot4(Yd,ZD,ZA,Ye,ZE,Yu,ZU,ZH,ZP,ZV,g3,L2,L1,cplAhAhSdcSd,         & 
& cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,cplHpmSdcHpmcSd,      & 
& cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,cplSdSecSdcSe,           & 
& cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,cplSuSucSucSu,   & 
& cplSdcSdVGVG,cplSucSuVGVG)



!! ------------------------------------------------- 
!! Calculate derivative of effective potential      
!! ------------------------------------------------- 



Q2 = getRenormalizationScale()
Do iv1=1,2
  Do iv2=iv1,2
    result = ZeroC
    result_ti = ZeroC
    results1 = ZeroC
    results1_ti = ZeroC
    results2 = ZeroC
    results2_ti = ZeroC


! ----- Topology1 (sunrise): diagrams w. 3 Particles and 2 Vertices


! ----- diagrams of type SSS, 11 ------ 

! ---- Ah,Sd,conj[Sd] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSdcSd(i1,i2,i3)
coup2 = cplAhSdcSd(i1,i3,i2)
Di_coup1 = dcplAhSdcSd(i1,i2,i3,iv1)
Dj_coup1 = dcplAhSdcSd(i1,i2,i3,iv2)
DDcoup1 = ddcplAhSdcSd(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MAh2(i1),MSd2(i2),MSd2(i3),dMAh2(i1,iv1)            & 
& ,dMSd2(i2,iv1),dMSd2(i3,iv1),dMAh2(i1,iv2),dMSd2(i2,iv2),dMSd2(i3,iv2),ddMAh2(i1,iv1,iv2)& 
& ,ddMSd2(i2,iv1,iv2),ddMSd2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 3
results1(1)=results1(1) + coeff*colorfactor*temp
results1_ti(1)=results1_ti(1) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(1).eq.results1(1)))  write(*,*) 'NaN at SSS C[Ah, Sd, conj[Sd]]' 
! ---- Ah,Se,conj[Se] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSecSe(i1,i2,i3)
coup2 = cplAhSecSe(i1,i3,i2)
Di_coup1 = dcplAhSecSe(i1,i2,i3,iv1)
Dj_coup1 = dcplAhSecSe(i1,i2,i3,iv2)
DDcoup1 = ddcplAhSecSe(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MAh2(i1),MSe2(i2),MSe2(i3),dMAh2(i1,iv1)            & 
& ,dMSe2(i2,iv1),dMSe2(i3,iv1),dMAh2(i1,iv2),dMSe2(i2,iv2),dMSe2(i3,iv2),ddMAh2(i1,iv1,iv2)& 
& ,ddMSe2(i2,iv1,iv2),ddMSe2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 1
results1(2)=results1(2) + coeff*colorfactor*temp
results1_ti(2)=results1_ti(2) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(2).eq.results1(2)))  write(*,*) 'NaN at SSS C[Ah, Se, conj[Se]]' 
! ---- Ah,Su,conj[Su] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSucSu(i1,i2,i3)
coup2 = cplAhSucSu(i1,i3,i2)
Di_coup1 = dcplAhSucSu(i1,i2,i3,iv1)
Dj_coup1 = dcplAhSucSu(i1,i2,i3,iv2)
DDcoup1 = ddcplAhSucSu(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MAh2(i1),MSu2(i2),MSu2(i3),dMAh2(i1,iv1)            & 
& ,dMSu2(i2,iv1),dMSu2(i3,iv1),dMAh2(i1,iv2),dMSu2(i2,iv2),dMSu2(i3,iv2),ddMAh2(i1,iv1,iv2)& 
& ,ddMSu2(i2,iv1,iv2),ddMSu2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 3
results1(3)=results1(3) + coeff*colorfactor*temp
results1_ti(3)=results1_ti(3) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(3).eq.results1(3)))  write(*,*) 'NaN at SSS C[Ah, Su, conj[Su]]' 
! ---- hh,Sd,conj[Sd] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSdcSd(i1,i2,i3)
coup2 = cplhhSdcSd(i1,i3,i2)
Di_coup1 = dcplhhSdcSd(i1,i2,i3,iv1)
Dj_coup1 = dcplhhSdcSd(i1,i2,i3,iv2)
DDcoup1 = ddcplhhSdcSd(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(Mhh2(i1),MSd2(i2),MSd2(i3),dMhh2(i1,iv1)            & 
& ,dMSd2(i2,iv1),dMSd2(i3,iv1),dMhh2(i1,iv2),dMSd2(i2,iv2),dMSd2(i3,iv2),ddMhh2(i1,iv1,iv2)& 
& ,ddMSd2(i2,iv1,iv2),ddMSd2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 3
results1(4)=results1(4) + coeff*colorfactor*temp
results1_ti(4)=results1_ti(4) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(4).eq.results1(4)))  write(*,*) 'NaN at SSS C[hh, Sd, conj[Sd]]' 
! ---- hh,Se,conj[Se] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSecSe(i1,i2,i3)
coup2 = cplhhSecSe(i1,i3,i2)
Di_coup1 = dcplhhSecSe(i1,i2,i3,iv1)
Dj_coup1 = dcplhhSecSe(i1,i2,i3,iv2)
DDcoup1 = ddcplhhSecSe(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(Mhh2(i1),MSe2(i2),MSe2(i3),dMhh2(i1,iv1)            & 
& ,dMSe2(i2,iv1),dMSe2(i3,iv1),dMhh2(i1,iv2),dMSe2(i2,iv2),dMSe2(i3,iv2),ddMhh2(i1,iv1,iv2)& 
& ,ddMSe2(i2,iv1,iv2),ddMSe2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 1
results1(5)=results1(5) + coeff*colorfactor*temp
results1_ti(5)=results1_ti(5) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(5).eq.results1(5)))  write(*,*) 'NaN at SSS C[hh, Se, conj[Se]]' 
! ---- hh,Su,conj[Su] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSucSu(i1,i2,i3)
coup2 = cplhhSucSu(i1,i3,i2)
Di_coup1 = dcplhhSucSu(i1,i2,i3,iv1)
Dj_coup1 = dcplhhSucSu(i1,i2,i3,iv2)
DDcoup1 = ddcplhhSucSu(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(Mhh2(i1),MSu2(i2),MSu2(i3),dMhh2(i1,iv1)            & 
& ,dMSu2(i2,iv1),dMSu2(i3,iv1),dMhh2(i1,iv2),dMSu2(i2,iv2),dMSu2(i3,iv2),ddMhh2(i1,iv1,iv2)& 
& ,ddMSu2(i2,iv1,iv2),ddMSu2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 3
results1(6)=results1(6) + coeff*colorfactor*temp
results1_ti(6)=results1_ti(6) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(6).eq.results1(6)))  write(*,*) 'NaN at SSS C[hh, Su, conj[Su]]' 
! ---- Sd,conj[Hpm],conj[Su] ----
Do i1=1,6
 Do i2=1,2
    Do i3=1,6
coup1 = cplSdcHpmcSu(i1,i2,i3)
coup2 = cplHpmSucSd(i2,i3,i1)
Di_coup1 = dcplSdcHpmcSu(i1,i2,i3,iv1)
Dj_coup1 = dcplSdcHpmcSu(i1,i2,i3,iv2)
DDcoup1 = ddcplSdcHpmcSu(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSd2(i1),MHpm2(i2),MSu2(i3),dMSd2(i1,iv1)           & 
& ,dMHpm2(i2,iv1),dMSu2(i3,iv1),dMSd2(i1,iv2),dMHpm2(i2,iv2),dMSu2(i3,iv2)               & 
& ,ddMSd2(i1,iv1,iv2),ddMHpm2(i2,iv1,iv2),ddMSu2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 1._dp
colorfactor = 3
results1(7)=results1(7) + coeff*colorfactor*temp
results1_ti(7)=results1_ti(7) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(7).eq.results1(7)))  write(*,*) 'NaN at SSS C[Sd, conj[Hpm], conj[Su]]' 
! ---- Sd,conj[Sd],conj[Sv] ----
Do i1=1,6
 Do i2=1,6
    Do i3=1,3
coup1 = cplSdcSdcSv(i1,i2,i3)
coup2 = cplSdSvcSd(i2,i3,i1)
Di_coup1 = dcplSdcSdcSv(i1,i2,i3,iv1)
Dj_coup1 = dcplSdcSdcSv(i1,i2,i3,iv2)
DDcoup1 = ddcplSdcSdcSv(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSd2(i1),MSd2(i2),MSv2(i3),dMSd2(i1,iv1)            & 
& ,dMSd2(i2,iv1),dMSv2(i3,iv1),dMSd2(i1,iv2),dMSd2(i2,iv2),dMSv2(i3,iv2),ddMSd2(i1,iv1,iv2)& 
& ,ddMSd2(i2,iv1,iv2),ddMSv2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 1._dp
colorfactor = 3
results1(8)=results1(8) + coeff*colorfactor*temp
results1_ti(8)=results1_ti(8) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(8).eq.results1(8)))  write(*,*) 'NaN at SSS C[Sd, conj[Sd], conj[Sv]]' 
! ---- Se,Su,conj[Sd] ----
Do i1=1,6
 Do i2=1,6
    Do i3=1,6
coup1 = cplSeSucSd(i1,i2,i3)
coup2 = cplSdcSecSu(i3,i1,i2)
Di_coup1 = dcplSeSucSd(i1,i2,i3,iv1)
Dj_coup1 = dcplSeSucSd(i1,i2,i3,iv2)
DDcoup1 = ddcplSeSucSd(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSe2(i1),MSu2(i2),MSd2(i3),dMSe2(i1,iv1)            & 
& ,dMSu2(i2,iv1),dMSd2(i3,iv1),dMSe2(i1,iv2),dMSu2(i2,iv2),dMSd2(i3,iv2),ddMSe2(i1,iv1,iv2)& 
& ,ddMSu2(i2,iv1,iv2),ddMSd2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 1._dp
colorfactor = 3
results1(9)=results1(9) + coeff*colorfactor*temp
results1_ti(9)=results1_ti(9) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(9).eq.results1(9)))  write(*,*) 'NaN at SSS C[Se, Su, conj[Sd]]' 
! ---- Se,conj[Hpm],conj[Sv] ----
Do i1=1,6
 Do i2=1,2
    Do i3=1,3
coup1 = cplSecHpmcSv(i1,i2,i3)
coup2 = cplHpmSvcSe(i2,i3,i1)
Di_coup1 = dcplSecHpmcSv(i1,i2,i3,iv1)
Dj_coup1 = dcplSecHpmcSv(i1,i2,i3,iv2)
DDcoup1 = ddcplSecHpmcSv(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSe2(i1),MHpm2(i2),MSv2(i3),dMSe2(i1,iv1)           & 
& ,dMHpm2(i2,iv1),dMSv2(i3,iv1),dMSe2(i1,iv2),dMHpm2(i2,iv2),dMSv2(i3,iv2)               & 
& ,ddMSe2(i1,iv1,iv2),ddMHpm2(i2,iv1,iv2),ddMSv2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 1._dp
colorfactor = 1
results1(10)=results1(10) + coeff*colorfactor*temp
results1_ti(10)=results1_ti(10) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(10).eq.results1(10)))  write(*,*) 'NaN at SSS C[Se, conj[Hpm], conj[Sv]]' 
! ---- Se,conj[Se],conj[Sv] ----
Do i1=1,6
 Do i2=1,6
    Do i3=1,3
coup1 = cplSecSecSv(i1,i2,i3)
coup2 = cplSeSvcSe(i2,i3,i1)
Di_coup1 = dcplSecSecSv(i1,i2,i3,iv1)
Dj_coup1 = dcplSecSecSv(i1,i2,i3,iv2)
DDcoup1 = ddcplSecSecSv(i1,i2,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSe2(i1),MSe2(i2),MSv2(i3),dMSe2(i1,iv1)            & 
& ,dMSe2(i2,iv1),dMSv2(i3,iv1),dMSe2(i1,iv2),dMSe2(i2,iv2),dMSv2(i3,iv2),ddMSe2(i1,iv1,iv2)& 
& ,ddMSe2(i2,iv1,iv2),ddMSv2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'SSS   ',Q2,temp,temp_ti,temp_tj)
coeff = 1._dp
colorfactor = 1
results1(11)=results1(11) + coeff*colorfactor*temp
results1_ti(11)=results1_ti(11) + coeff*colorfactor*temp_ti
    End Do
  End Do
End Do
if (.not.(results1(11).eq.results1(11)))  write(*,*) 'NaN at SSS C[Se, conj[Se], conj[Sv]]' 

! ----- diagrams of type FFS, 24 ------ 

! ---- Ah,Fd,bar[Fd] ----
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFdFdAhL(i3,i2,i1)
coup1R = cplcFdFdAhR(i3,i2,i1)
coup2L = cplcFdFdAhL(i2,i3,i1)
coup2R = cplcFdFdAhR(i2,i3,i1)
Di_coup1L = dcplcFdFdAhL(i3,i2,i1,iv1)
Di_coup1R = dcplcFdFdAhR(i3,i2,i1,iv1)
Dj_coup1L = dcplcFdFdAhL(i3,i2,i1,iv2)
Dj_coup1R = dcplcFdFdAhR(i3,i2,i1,iv2)
DDcoup1L = ddcplcFdFdAhL(i3,i2,i1,iv1,iv2)
DDcoup1R = ddcplcFdFdAhR(i3,i2,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFd2(i2),MAh2(i1),dMFd2(i3,iv1)            & 
& ,dMFd2(i2,iv1),dMAh2(i1,iv1),dMFd2(i3,iv2),dMFd2(i2,iv2),dMAh2(i1,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFd2(i2,iv1,iv2),ddMAh2(i1,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFd2(i2),MAh2(i1),dMFd2(i3,iv1)            & 
& ,dMFd2(i2,iv1),dMAh2(i1,iv1),dMFd2(i3,iv2),dMFd2(i2,iv2),dMAh2(i1,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFd2(i2,iv1,iv2),ddMAh2(i1,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 3
results1(12)=results1(12) + coeff*colorfactor*temp
results1_ti(12)=results1_ti(12) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(12)=results1(12) + coeffbar*colorfactor*tempbar
results1_ti(12)=results1_ti(12) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(12).eq.results1(12)))  write(*,*) 'NaN at FFS C[Ah, Fd, bar[Fd]]' 
! ---- Ah,Fe,bar[Fe] ----
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFeFeAhL(i3,i2,i1)
coup1R = cplcFeFeAhR(i3,i2,i1)
coup2L = cplcFeFeAhL(i2,i3,i1)
coup2R = cplcFeFeAhR(i2,i3,i1)
Di_coup1L = dcplcFeFeAhL(i3,i2,i1,iv1)
Di_coup1R = dcplcFeFeAhR(i3,i2,i1,iv1)
Dj_coup1L = dcplcFeFeAhL(i3,i2,i1,iv2)
Dj_coup1R = dcplcFeFeAhR(i3,i2,i1,iv2)
DDcoup1L = ddcplcFeFeAhL(i3,i2,i1,iv1,iv2)
DDcoup1R = ddcplcFeFeAhR(i3,i2,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFe2(i3),MFe2(i2),MAh2(i1),dMFe2(i3,iv1)            & 
& ,dMFe2(i2,iv1),dMAh2(i1,iv1),dMFe2(i3,iv2),dMFe2(i2,iv2),dMAh2(i1,iv2),ddMFe2(i3,iv1,iv2)& 
& ,ddMFe2(i2,iv1,iv2),ddMAh2(i1,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFe2(i3),MFe2(i2),MAh2(i1),dMFe2(i3,iv1)            & 
& ,dMFe2(i2,iv1),dMAh2(i1,iv1),dMFe2(i3,iv2),dMFe2(i2,iv2),dMAh2(i1,iv2),ddMFe2(i3,iv1,iv2)& 
& ,ddMFe2(i2,iv1,iv2),ddMAh2(i1,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 1
results1(13)=results1(13) + coeff*colorfactor*temp
results1_ti(13)=results1_ti(13) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(13)=results1(13) + coeffbar*colorfactor*tempbar
results1_ti(13)=results1_ti(13) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(13).eq.results1(13)))  write(*,*) 'NaN at FFS C[Ah, Fe, bar[Fe]]' 
! ---- Ah,Fu,bar[Fu] ----
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFuFuAhL(i3,i2,i1)
coup1R = cplcFuFuAhR(i3,i2,i1)
coup2L = cplcFuFuAhL(i2,i3,i1)
coup2R = cplcFuFuAhR(i2,i3,i1)
Di_coup1L = dcplcFuFuAhL(i3,i2,i1,iv1)
Di_coup1R = dcplcFuFuAhR(i3,i2,i1,iv1)
Dj_coup1L = dcplcFuFuAhL(i3,i2,i1,iv2)
Dj_coup1R = dcplcFuFuAhR(i3,i2,i1,iv2)
DDcoup1L = ddcplcFuFuAhL(i3,i2,i1,iv1,iv2)
DDcoup1R = ddcplcFuFuAhR(i3,i2,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFu2(i2),MAh2(i1),dMFu2(i3,iv1)            & 
& ,dMFu2(i2,iv1),dMAh2(i1,iv1),dMFu2(i3,iv2),dMFu2(i2,iv2),dMAh2(i1,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMFu2(i2,iv1,iv2),ddMAh2(i1,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFu2(i2),MAh2(i1),dMFu2(i3,iv1)            & 
& ,dMFu2(i2,iv1),dMAh2(i1,iv1),dMFu2(i3,iv2),dMFu2(i2,iv2),dMAh2(i1,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMFu2(i2,iv1,iv2),ddMAh2(i1,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 3
results1(14)=results1(14) + coeff*colorfactor*temp
results1_ti(14)=results1_ti(14) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(14)=results1(14) + coeffbar*colorfactor*tempbar
results1_ti(14)=results1_ti(14) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(14).eq.results1(14)))  write(*,*) 'NaN at FFS C[Ah, Fu, bar[Fu]]' 
! ---- Chi,Sd,bar[Fd] ----
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdChiSdL(i3,i1,i2)
coup1R = cplcFdChiSdR(i3,i1,i2)
coup2L = cplChiFdcSdL(i1,i3,i2)
coup2R = cplChiFdcSdR(i1,i3,i2)
Di_coup1L = dcplcFdChiSdL(i3,i1,i2,iv1)
Di_coup1R = dcplcFdChiSdR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFdChiSdL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFdChiSdR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFdChiSdL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFdChiSdR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MChi2(i1),MSd2(i2),dMFd2(i3,iv1)           & 
& ,dMChi2(i1,iv1),dMSd2(i2,iv1),dMFd2(i3,iv2),dMChi2(i1,iv2),dMSd2(i2,iv2)               & 
& ,ddMFd2(i3,iv1,iv2),ddMChi2(i1,iv1,iv2),ddMSd2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MChi2(i1),MSd2(i2),dMFd2(i3,iv1)           & 
& ,dMChi2(i1,iv1),dMSd2(i2,iv1),dMFd2(i3,iv2),dMChi2(i1,iv2),dMSd2(i2,iv2)               & 
& ,ddMFd2(i3,iv1,iv2),ddMChi2(i1,iv1,iv2),ddMSd2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(15)=results1(15) + coeff*colorfactor*temp
results1_ti(15)=results1_ti(15) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(15)=results1(15) + coeffbar*colorfactor*tempbar
results1_ti(15)=results1_ti(15) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(15).eq.results1(15)))  write(*,*) 'NaN at FFS C[Chi, Sd, bar[Fd]]' 
! ---- Chi,Se,bar[Fe] ----
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFeChiSeL(i3,i1,i2)
coup1R = cplcFeChiSeR(i3,i1,i2)
coup2L = cplChiFecSeL(i1,i3,i2)
coup2R = cplChiFecSeR(i1,i3,i2)
Di_coup1L = dcplcFeChiSeL(i3,i1,i2,iv1)
Di_coup1R = dcplcFeChiSeR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFeChiSeL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFeChiSeR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFeChiSeL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFeChiSeR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFe2(i3),MChi2(i1),MSe2(i2),dMFe2(i3,iv1)           & 
& ,dMChi2(i1,iv1),dMSe2(i2,iv1),dMFe2(i3,iv2),dMChi2(i1,iv2),dMSe2(i2,iv2)               & 
& ,ddMFe2(i3,iv1,iv2),ddMChi2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFe2(i3),MChi2(i1),MSe2(i2),dMFe2(i3,iv1)           & 
& ,dMChi2(i1,iv1),dMSe2(i2,iv1),dMFe2(i3,iv2),dMChi2(i1,iv2),dMSe2(i2,iv2)               & 
& ,ddMFe2(i3,iv1,iv2),ddMChi2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 1
results1(16)=results1(16) + coeff*colorfactor*temp
results1_ti(16)=results1_ti(16) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(16)=results1(16) + coeffbar*colorfactor*tempbar
results1_ti(16)=results1_ti(16) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(16).eq.results1(16)))  write(*,*) 'NaN at FFS C[Chi, Se, bar[Fe]]' 
! ---- Chi,Su,bar[Fu] ----
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFuChiSuL(i3,i1,i2)
coup1R = cplcFuChiSuR(i3,i1,i2)
coup2L = cplChiFucSuL(i1,i3,i2)
coup2R = cplChiFucSuR(i1,i3,i2)
Di_coup1L = dcplcFuChiSuL(i3,i1,i2,iv1)
Di_coup1R = dcplcFuChiSuR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFuChiSuL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFuChiSuR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFuChiSuL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFuChiSuR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MChi2(i1),MSu2(i2),dMFu2(i3,iv1)           & 
& ,dMChi2(i1,iv1),dMSu2(i2,iv1),dMFu2(i3,iv2),dMChi2(i1,iv2),dMSu2(i2,iv2)               & 
& ,ddMFu2(i3,iv1,iv2),ddMChi2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MChi2(i1),MSu2(i2),dMFu2(i3,iv1)           & 
& ,dMChi2(i1,iv1),dMSu2(i2,iv1),dMFu2(i3,iv2),dMChi2(i1,iv2),dMSu2(i2,iv2)               & 
& ,ddMFu2(i3,iv1,iv2),ddMChi2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(17)=results1(17) + coeff*colorfactor*temp
results1_ti(17)=results1_ti(17) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(17)=results1(17) + coeffbar*colorfactor*tempbar
results1_ti(17)=results1_ti(17) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(17).eq.results1(17)))  write(*,*) 'NaN at FFS C[Chi, Su, bar[Fu]]' 
! ---- Fd,hh,bar[Fd] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFdFdhhL(i3,i1,i2)
coup1R = cplcFdFdhhR(i3,i1,i2)
coup2L = cplcFdFdhhL(i1,i3,i2)
coup2R = cplcFdFdhhR(i1,i3,i2)
Di_coup1L = dcplcFdFdhhL(i3,i1,i2,iv1)
Di_coup1R = dcplcFdFdhhR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFdFdhhL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFdFdhhR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFdFdhhL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFdFdhhR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),Mhh2(i2),dMFd2(i3,iv1)            & 
& ,dMFd2(i1,iv1),dMhh2(i2,iv1),dMFd2(i3,iv2),dMFd2(i1,iv2),dMhh2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFd2(i1,iv1,iv2),ddMhh2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),Mhh2(i2),dMFd2(i3,iv1)            & 
& ,dMFd2(i1,iv1),dMhh2(i2,iv1),dMFd2(i3,iv2),dMFd2(i1,iv2),dMhh2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFd2(i1,iv1,iv2),ddMhh2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 3
results1(18)=results1(18) + coeff*colorfactor*temp
results1_ti(18)=results1_ti(18) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(18)=results1(18) + coeffbar*colorfactor*tempbar
results1_ti(18)=results1_ti(18) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(18).eq.results1(18)))  write(*,*) 'NaN at FFS C[Fd, hh, bar[Fd]]' 
! ---- Fd,bar[Cha],conj[Su] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,6
coup1L = cplcChaFdcSuL(i2,i1,i3)
coup1R = cplcChaFdcSuR(i2,i1,i3)
coup2L = cplcFdChaSuL(i1,i2,i3)
coup2R = cplcFdChaSuR(i1,i2,i3)
Di_coup1L = dcplcChaFdcSuL(i2,i1,i3,iv1)
Di_coup1R = dcplcChaFdcSuR(i2,i1,i3,iv1)
Dj_coup1L = dcplcChaFdcSuL(i2,i1,i3,iv2)
Dj_coup1R = dcplcChaFdcSuR(i2,i1,i3,iv2)
DDcoup1L = ddcplcChaFdcSuL(i2,i1,i3,iv1,iv2)
DDcoup1R = ddcplcChaFdcSuR(i2,i1,i3,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MCha2(i2),MFd2(i1),MSu2(i3),dMCha2(i2,iv1)          & 
& ,dMFd2(i1,iv1),dMSu2(i3,iv1),dMCha2(i2,iv2),dMFd2(i1,iv2),dMSu2(i3,iv2),ddMCha2(i2,iv1,iv2)& 
& ,ddMFd2(i1,iv1,iv2),ddMSu2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MCha2(i2),MFd2(i1),MSu2(i3),dMCha2(i2,iv1)          & 
& ,dMFd2(i1,iv1),dMSu2(i3,iv1),dMCha2(i2,iv2),dMFd2(i1,iv2),dMSu2(i3,iv2),ddMCha2(i2,iv1,iv2)& 
& ,ddMFd2(i1,iv1,iv2),ddMSu2(i3,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(19)=results1(19) + coeff*colorfactor*temp
results1_ti(19)=results1_ti(19) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(19)=results1(19) + coeffbar*colorfactor*tempbar
results1_ti(19)=results1_ti(19) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(19).eq.results1(19)))  write(*,*) 'NaN at FFS C[Fd, bar[Cha], conj[Su]]' 
! ---- Fd,bar[Fd],conj[Sv] ----
Do i1=1,3
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFdFdcSvL(i2,i1,i3)
coup1R = cplcFdFdcSvR(i2,i1,i3)
coup2L = cplcFdFdSvL(i1,i2,i3)
coup2R = cplcFdFdSvR(i1,i2,i3)
Di_coup1L = dcplcFdFdcSvL(i2,i1,i3,iv1)
Di_coup1R = dcplcFdFdcSvR(i2,i1,i3,iv1)
Dj_coup1L = dcplcFdFdcSvL(i2,i1,i3,iv2)
Dj_coup1R = dcplcFdFdcSvR(i2,i1,i3,iv2)
DDcoup1L = ddcplcFdFdcSvL(i2,i1,i3,iv1,iv2)
DDcoup1R = ddcplcFdFdcSvR(i2,i1,i3,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i2),MFd2(i1),MSv2(i3),dMFd2(i2,iv1)            & 
& ,dMFd2(i1,iv1),dMSv2(i3,iv1),dMFd2(i2,iv2),dMFd2(i1,iv2),dMSv2(i3,iv2),ddMFd2(i2,iv1,iv2)& 
& ,ddMFd2(i1,iv1,iv2),ddMSv2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i2),MFd2(i1),MSv2(i3),dMFd2(i2,iv1)            & 
& ,dMFd2(i1,iv1),dMSv2(i3,iv1),dMFd2(i2,iv2),dMFd2(i1,iv2),dMSv2(i3,iv2),ddMFd2(i2,iv1,iv2)& 
& ,ddMFd2(i1,iv1,iv2),ddMSv2(i3,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 3
results1(20)=results1(20) + coeff*colorfactor*temp
results1_ti(20)=results1_ti(20) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(20)=results1(20) + coeffbar*colorfactor*tempbar
results1_ti(20)=results1_ti(20) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(20).eq.results1(20)))  write(*,*) 'NaN at FFS C[Fd, bar[Fd], conj[Sv]]' 
! ---- Fe,hh,bar[Fe] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFeFehhL(i3,i1,i2)
coup1R = cplcFeFehhR(i3,i1,i2)
coup2L = cplcFeFehhL(i1,i3,i2)
coup2R = cplcFeFehhR(i1,i3,i2)
Di_coup1L = dcplcFeFehhL(i3,i1,i2,iv1)
Di_coup1R = dcplcFeFehhR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFeFehhL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFeFehhR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFeFehhL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFeFehhR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFe2(i3),MFe2(i1),Mhh2(i2),dMFe2(i3,iv1)            & 
& ,dMFe2(i1,iv1),dMhh2(i2,iv1),dMFe2(i3,iv2),dMFe2(i1,iv2),dMhh2(i2,iv2),ddMFe2(i3,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMhh2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFe2(i3),MFe2(i1),Mhh2(i2),dMFe2(i3,iv1)            & 
& ,dMFe2(i1,iv1),dMhh2(i2,iv1),dMFe2(i3,iv2),dMFe2(i1,iv2),dMhh2(i2,iv2),ddMFe2(i3,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMhh2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 1
results1(21)=results1(21) + coeff*colorfactor*temp
results1_ti(21)=results1_ti(21) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(21)=results1(21) + coeffbar*colorfactor*tempbar
results1_ti(21)=results1_ti(21) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(21).eq.results1(21)))  write(*,*) 'NaN at FFS C[Fe, hh, bar[Fe]]' 
! ---- Fe,Su,bar[Fd] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFeSuL(i3,i1,i2)
coup1R = cplcFdFeSuR(i3,i1,i2)
coup2L = cplcFeFdcSuL(i1,i3,i2)
coup2R = cplcFeFdcSuR(i1,i3,i2)
Di_coup1L = dcplcFdFeSuL(i3,i1,i2,iv1)
Di_coup1R = dcplcFdFeSuR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFdFeSuL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFdFeSuR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFdFeSuL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFdFeSuR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFe2(i1),MSu2(i2),dMFd2(i3,iv1)            & 
& ,dMFe2(i1,iv1),dMSu2(i2,iv1),dMFd2(i3,iv2),dMFe2(i1,iv2),dMSu2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFe2(i1),MSu2(i2),dMFd2(i3,iv1)            & 
& ,dMFe2(i1,iv1),dMSu2(i2,iv1),dMFd2(i3,iv2),dMFe2(i1,iv2),dMSu2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(22)=results1(22) + coeff*colorfactor*temp
results1_ti(22)=results1_ti(22) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(22)=results1(22) + coeffbar*colorfactor*tempbar
results1_ti(22)=results1_ti(22) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(22).eq.results1(22)))  write(*,*) 'NaN at FFS C[Fe, Su, bar[Fd]]' 
! ---- Fe,bar[Cha],conj[Sv] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcChaFecSvL(i2,i1,i3)
coup1R = cplcChaFecSvR(i2,i1,i3)
coup2L = cplcFeChaSvL(i1,i2,i3)
coup2R = cplcFeChaSvR(i1,i2,i3)
Di_coup1L = dcplcChaFecSvL(i2,i1,i3,iv1)
Di_coup1R = dcplcChaFecSvR(i2,i1,i3,iv1)
Dj_coup1L = dcplcChaFecSvL(i2,i1,i3,iv2)
Dj_coup1R = dcplcChaFecSvR(i2,i1,i3,iv2)
DDcoup1L = ddcplcChaFecSvL(i2,i1,i3,iv1,iv2)
DDcoup1R = ddcplcChaFecSvR(i2,i1,i3,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MCha2(i2),MFe2(i1),MSv2(i3),dMCha2(i2,iv1)          & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),dMCha2(i2,iv2),dMFe2(i1,iv2),dMSv2(i3,iv2),ddMCha2(i2,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMSv2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MCha2(i2),MFe2(i1),MSv2(i3),dMCha2(i2,iv1)          & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),dMCha2(i2,iv2),dMFe2(i1,iv2),dMSv2(i3,iv2),ddMCha2(i2,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMSv2(i3,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 1
results1(23)=results1(23) + coeff*colorfactor*temp
results1_ti(23)=results1_ti(23) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(23)=results1(23) + coeffbar*colorfactor*tempbar
results1_ti(23)=results1_ti(23) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(23).eq.results1(23)))  write(*,*) 'NaN at FFS C[Fe, bar[Cha], conj[Sv]]' 
! ---- Fe,bar[Fe],conj[Sv] ----
Do i1=1,3
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFeFecSvL(i2,i1,i3)
coup1R = cplcFeFecSvR(i2,i1,i3)
coup2L = cplcFeFeSvL(i1,i2,i3)
coup2R = cplcFeFeSvR(i1,i2,i3)
Di_coup1L = dcplcFeFecSvL(i2,i1,i3,iv1)
Di_coup1R = dcplcFeFecSvR(i2,i1,i3,iv1)
Dj_coup1L = dcplcFeFecSvL(i2,i1,i3,iv2)
Dj_coup1R = dcplcFeFecSvR(i2,i1,i3,iv2)
DDcoup1L = ddcplcFeFecSvL(i2,i1,i3,iv1,iv2)
DDcoup1R = ddcplcFeFecSvR(i2,i1,i3,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFe2(i2),MFe2(i1),MSv2(i3),dMFe2(i2,iv1)            & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),dMFe2(i2,iv2),dMFe2(i1,iv2),dMSv2(i3,iv2),ddMFe2(i2,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMSv2(i3,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFe2(i2),MFe2(i1),MSv2(i3),dMFe2(i2,iv1)            & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),dMFe2(i2,iv2),dMFe2(i1,iv2),dMSv2(i3,iv2),ddMFe2(i2,iv1,iv2)& 
& ,ddMFe2(i1,iv1,iv2),ddMSv2(i3,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 1
results1(24)=results1(24) + coeff*colorfactor*temp
results1_ti(24)=results1_ti(24) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(24)=results1(24) + coeffbar*colorfactor*tempbar
results1_ti(24)=results1_ti(24) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(24).eq.results1(24)))  write(*,*) 'NaN at FFS C[Fe, bar[Fe], conj[Sv]]' 
! ---- Fu,hh,bar[Fu] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFuFuhhL(i3,i1,i2)
coup1R = cplcFuFuhhR(i3,i1,i2)
coup2L = cplcFuFuhhL(i1,i3,i2)
coup2R = cplcFuFuhhR(i1,i3,i2)
Di_coup1L = dcplcFuFuhhL(i3,i1,i2,iv1)
Di_coup1R = dcplcFuFuhhR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFuFuhhL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFuFuhhR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFuFuhhL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFuFuhhR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),Mhh2(i2),dMFu2(i3,iv1)            & 
& ,dMFu2(i1,iv1),dMhh2(i2,iv1),dMFu2(i3,iv2),dMFu2(i1,iv2),dMhh2(i2,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMFu2(i1,iv1,iv2),ddMhh2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),Mhh2(i2),dMFu2(i3,iv1)            & 
& ,dMFu2(i1,iv1),dMhh2(i2,iv1),dMFu2(i3,iv2),dMFu2(i1,iv2),dMhh2(i2,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMFu2(i1,iv1,iv2),ddMhh2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 3
results1(25)=results1(25) + coeff*colorfactor*temp
results1_ti(25)=results1_ti(25) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(25)=results1(25) + coeffbar*colorfactor*tempbar
results1_ti(25)=results1_ti(25) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(25).eq.results1(25)))  write(*,*) 'NaN at FFS C[Fu, hh, bar[Fu]]' 
! ---- Fu,Hpm,bar[Fd] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFdFuHpmL(i3,i1,i2)
coup1R = cplcFdFuHpmR(i3,i1,i2)
coup2L = cplcFuFdcHpmL(i1,i3,i2)
coup2R = cplcFuFdcHpmR(i1,i3,i2)
Di_coup1L = dcplcFdFuHpmL(i3,i1,i2,iv1)
Di_coup1R = dcplcFdFuHpmR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFdFuHpmL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFdFuHpmR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFdFuHpmL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFdFuHpmR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MHpm2(i2),dMFd2(i3,iv1)           & 
& ,dMFu2(i1,iv1),dMHpm2(i2,iv1),dMFd2(i3,iv2),dMFu2(i1,iv2),dMHpm2(i2,iv2)               & 
& ,ddMFd2(i3,iv1,iv2),ddMFu2(i1,iv1,iv2),ddMHpm2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MHpm2(i2),dMFd2(i3,iv1)           & 
& ,dMFu2(i1,iv1),dMHpm2(i2,iv1),dMFd2(i3,iv2),dMFu2(i1,iv2),dMHpm2(i2,iv2)               & 
& ,ddMFd2(i3,iv1,iv2),ddMFu2(i1,iv1,iv2),ddMHpm2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(26)=results1(26) + coeff*colorfactor*temp
results1_ti(26)=results1_ti(26) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(26)=results1(26) + coeffbar*colorfactor*tempbar
results1_ti(26)=results1_ti(26) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(26).eq.results1(26)))  write(*,*) 'NaN at FFS C[Fu, Hpm, bar[Fd]]' 
! ---- Fu,Se,bar[Fd] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFuSeL(i3,i1,i2)
coup1R = cplcFdFuSeR(i3,i1,i2)
coup2L = cplcFuFdcSeL(i1,i3,i2)
coup2R = cplcFuFdcSeR(i1,i3,i2)
Di_coup1L = dcplcFdFuSeL(i3,i1,i2,iv1)
Di_coup1R = dcplcFdFuSeR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFdFuSeL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFdFuSeR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFdFuSeL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFdFuSeR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MSe2(i2),dMFd2(i3,iv1)            & 
& ,dMFu2(i1,iv1),dMSe2(i2,iv1),dMFd2(i3,iv2),dMFu2(i1,iv2),dMSe2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFu2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MSe2(i2),dMFd2(i3,iv1)            & 
& ,dMFu2(i1,iv1),dMSe2(i2,iv1),dMFd2(i3,iv2),dMFu2(i1,iv2),dMSe2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMFu2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(27)=results1(27) + coeff*colorfactor*temp
results1_ti(27)=results1_ti(27) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(27)=results1(27) + coeffbar*colorfactor*tempbar
results1_ti(27)=results1_ti(27) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(27).eq.results1(27)))  write(*,*) 'NaN at FFS C[Fu, Se, bar[Fd]]' 
! ---- Fv,Hpm,bar[Fe] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFeFvHpmL(i3,i1,i2)
coup1R = cplcFeFvHpmR(i3,i1,i2)
coup2L = cplFvFecHpmL(i1,i3,i2)
coup2R = cplFvFecHpmR(i1,i3,i2)
Di_coup1L = dcplcFeFvHpmL(i3,i1,i2,iv1)
Di_coup1R = dcplcFeFvHpmR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFeFvHpmL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFeFvHpmR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFeFvHpmL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFeFvHpmR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFe2(i3),0._dp,MHpm2(i2),dMFe2(i3,iv1)              & 
& ,ZeroC,dMHpm2(i2,iv1),dMFe2(i3,iv2),ZeroC,dMHpm2(i2,iv2),ddMFe2(i3,iv1,iv2)            & 
& ,ZeroC,ddMHpm2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFe2(i3),0._dp,MHpm2(i2),dMFe2(i3,iv1)              & 
& ,ZeroC,dMHpm2(i2,iv1),dMFe2(i3,iv2),ZeroC,dMHpm2(i2,iv2),ddMFe2(i3,iv1,iv2)            & 
& ,ZeroC,ddMHpm2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 1
results1(28)=results1(28) + coeff*colorfactor*temp
results1_ti(28)=results1_ti(28) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(28)=results1(28) + coeffbar*colorfactor*tempbar
results1_ti(28)=results1_ti(28) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(28).eq.results1(28)))  write(*,*) 'NaN at FFS C[Fv, Hpm, bar[Fe]]' 
! ---- Fv,Sd,bar[Fd] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFvSdL(i3,i1,i2)
coup1R = cplcFdFvSdR(i3,i1,i2)
coup2L = cplFvFdcSdL(i1,i3,i2)
coup2R = cplFvFdcSdR(i1,i3,i2)
Di_coup1L = dcplcFdFvSdL(i3,i1,i2,iv1)
Di_coup1R = dcplcFdFvSdR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFdFvSdL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFdFvSdR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFdFvSdL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFdFvSdR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),0._dp,MSd2(i2),dMFd2(i3,iv1)               & 
& ,ZeroC,dMSd2(i2,iv1),dMFd2(i3,iv2),ZeroC,dMSd2(i2,iv2),ddMFd2(i3,iv1,iv2)              & 
& ,ZeroC,ddMSd2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),0._dp,MSd2(i2),dMFd2(i3,iv1)               & 
& ,ZeroC,dMSd2(i2,iv1),dMFd2(i3,iv2),ZeroC,dMSd2(i2,iv2),ddMFd2(i3,iv1,iv2)              & 
& ,ZeroC,ddMSd2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(29)=results1(29) + coeff*colorfactor*temp
results1_ti(29)=results1_ti(29) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(29)=results1(29) + coeffbar*colorfactor*tempbar
results1_ti(29)=results1_ti(29) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(29).eq.results1(29)))  write(*,*) 'NaN at FFS C[Fv, Sd, bar[Fd]]' 
! ---- Fv,Se,bar[Cha] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,2
coup1L = cplcChaFvSeL(i3,i1,i2)
coup1R = cplcChaFvSeR(i3,i1,i2)
coup2L = cplFvChacSeL(i1,i3,i2)
coup2R = cplFvChacSeR(i1,i3,i2)
Di_coup1L = dcplcChaFvSeL(i3,i1,i2,iv1)
Di_coup1R = dcplcChaFvSeR(i3,i1,i2,iv1)
Dj_coup1L = dcplcChaFvSeL(i3,i1,i2,iv2)
Dj_coup1R = dcplcChaFvSeR(i3,i1,i2,iv2)
DDcoup1L = ddcplcChaFvSeL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcChaFvSeR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MCha2(i3),0._dp,MSe2(i2),dMCha2(i3,iv1)             & 
& ,ZeroC,dMSe2(i2,iv1),dMCha2(i3,iv2),ZeroC,dMSe2(i2,iv2),ddMCha2(i3,iv1,iv2)            & 
& ,ZeroC,ddMSe2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MCha2(i3),0._dp,MSe2(i2),dMCha2(i3,iv1)             & 
& ,ZeroC,dMSe2(i2,iv1),dMCha2(i3,iv2),ZeroC,dMSe2(i2,iv2),ddMCha2(i3,iv1,iv2)            & 
& ,ZeroC,ddMSe2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 1
results1(30)=results1(30) + coeff*colorfactor*temp
results1_ti(30)=results1_ti(30) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(30)=results1(30) + coeffbar*colorfactor*tempbar
results1_ti(30)=results1_ti(30) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(30).eq.results1(30)))  write(*,*) 'NaN at FFS C[Fv, Se, bar[Cha]]' 
! ---- Fv,Se,bar[Fe] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFeFvSeL(i3,i1,i2)
coup1R = cplcFeFvSeR(i3,i1,i2)
coup2L = cplFvFecSeL(i1,i3,i2)
coup2R = cplFvFecSeR(i1,i3,i2)
Di_coup1L = dcplcFeFvSeL(i3,i1,i2,iv1)
Di_coup1R = dcplcFeFvSeR(i3,i1,i2,iv1)
Dj_coup1L = dcplcFeFvSeL(i3,i1,i2,iv2)
Dj_coup1R = dcplcFeFvSeR(i3,i1,i2,iv2)
DDcoup1L = ddcplcFeFvSeL(i3,i1,i2,iv1,iv2)
DDcoup1R = ddcplcFeFvSeR(i3,i1,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFe2(i3),0._dp,MSe2(i2),dMFe2(i3,iv1)               & 
& ,ZeroC,dMSe2(i2,iv1),dMFe2(i3,iv2),ZeroC,dMSe2(i2,iv2),ddMFe2(i3,iv1,iv2)              & 
& ,ZeroC,ddMSe2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFe2(i3),0._dp,MSe2(i2),dMFe2(i3,iv1)               & 
& ,ZeroC,dMSe2(i2,iv1),dMFe2(i3,iv2),ZeroC,dMSe2(i2,iv2),ddMFe2(i3,iv1,iv2)              & 
& ,ZeroC,ddMSe2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 1
results1(31)=results1(31) + coeff*colorfactor*temp
results1_ti(31)=results1_ti(31) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(31)=results1(31) + coeffbar*colorfactor*tempbar
results1_ti(31)=results1_ti(31) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(31).eq.results1(31)))  write(*,*) 'NaN at FFS C[Fv, Se, bar[Fe]]' 
! ---- Glu,Sd,bar[Fd] ----
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdGluSdL(i3,i2)
coup1R = cplcFdGluSdR(i3,i2)
coup2L = cplGluFdcSdL(i3,i2)
coup2R = cplGluFdcSdR(i3,i2)
Di_coup1L = dcplcFdGluSdL(i3,i2,iv1)
Di_coup1R = dcplcFdGluSdR(i3,i2,iv1)
Dj_coup1L = dcplcFdGluSdL(i3,i2,iv2)
Dj_coup1R = dcplcFdGluSdR(i3,i2,iv2)
DDcoup1L = ddcplcFdGluSdL(i3,i2,iv1,iv2)
DDcoup1R = ddcplcFdGluSdR(i3,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MGlu2,MSd2(i2),dMFd2(i3,iv1)               & 
& ,dMGlu2(1,iv1),dMSd2(i2,iv1),dMFd2(i3,iv2),dMGlu2(1,iv2),dMSd2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMGlu2(1,iv1,iv2),ddMSd2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MGlu2,MSd2(i2),dMFd2(i3,iv1)               & 
& ,dMGlu2(1,iv1),dMSd2(i2,iv1),dMFd2(i3,iv2),dMGlu2(1,iv2),dMSd2(i2,iv2),ddMFd2(i3,iv1,iv2)& 
& ,ddMGlu2(1,iv1,iv2),ddMSd2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 4
results1(32)=results1(32) + coeff*colorfactor*temp
results1_ti(32)=results1_ti(32) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(32)=results1(32) + coeffbar*colorfactor*tempbar
results1_ti(32)=results1_ti(32) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
if (.not.(results1(32).eq.results1(32)))  write(*,*) 'NaN at FFS C[Glu, Sd, bar[Fd]]' 
! ---- Glu,Su,bar[Fu] ----
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFuGluSuL(i3,i2)
coup1R = cplcFuGluSuR(i3,i2)
coup2L = cplGluFucSuL(i3,i2)
coup2R = cplGluFucSuR(i3,i2)
Di_coup1L = dcplcFuGluSuL(i3,i2,iv1)
Di_coup1R = dcplcFuGluSuR(i3,i2,iv1)
Dj_coup1L = dcplcFuGluSuL(i3,i2,iv2)
Dj_coup1R = dcplcFuGluSuR(i3,i2,iv2)
DDcoup1L = ddcplcFuGluSuL(i3,i2,iv1,iv2)
DDcoup1R = ddcplcFuGluSuR(i3,i2,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MGlu2,MSu2(i2),dMFu2(i3,iv1)               & 
& ,dMGlu2(1,iv1),dMSu2(i2,iv1),dMFu2(i3,iv2),dMGlu2(1,iv2),dMSu2(i2,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMGlu2(1,iv1,iv2),ddMSu2(i2,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MGlu2,MSu2(i2),dMFu2(i3,iv1)               & 
& ,dMGlu2(1,iv1),dMSu2(i2,iv1),dMFu2(i3,iv2),dMGlu2(1,iv2),dMSu2(i2,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMGlu2(1,iv1,iv2),ddMSu2(i2,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 4
results1(33)=results1(33) + coeff*colorfactor*temp
results1_ti(33)=results1_ti(33) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(33)=results1(33) + coeffbar*colorfactor*tempbar
results1_ti(33)=results1_ti(33) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
if (.not.(results1(33).eq.results1(33)))  write(*,*) 'NaN at FFS C[Glu, Su, bar[Fu]]' 
! ---- Sd,bar[Cha],bar[Fu] ----
Do i1=1,6
 Do i2=1,2
    Do i3=1,3
coup1L = cplcChacFuSdL(i2,i3,i1)
coup1R = cplcChacFuSdR(i2,i3,i1)
coup2L = cplChaFucSdL(i2,i3,i1)
coup2R = cplChaFucSdR(i2,i3,i1)
Di_coup1L = dcplcChacFuSdL(i2,i3,i1,iv1)
Di_coup1R = dcplcChacFuSdR(i2,i3,i1,iv1)
Dj_coup1L = dcplcChacFuSdL(i2,i3,i1,iv2)
Dj_coup1R = dcplcChacFuSdR(i2,i3,i1,iv2)
DDcoup1L = ddcplcChacFuSdL(i2,i3,i1,iv1,iv2)
DDcoup1R = ddcplcChacFuSdR(i2,i3,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MCha2(i2),MSd2(i1),dMFu2(i3,iv1)           & 
& ,dMCha2(i2,iv1),dMSd2(i1,iv1),dMFu2(i3,iv2),dMCha2(i2,iv2),dMSd2(i1,iv2)               & 
& ,ddMFu2(i3,iv1,iv2),ddMCha2(i2,iv1,iv2),ddMSd2(i1,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MCha2(i2),MSd2(i1),dMFu2(i3,iv1)           & 
& ,dMCha2(i2,iv1),dMSd2(i1,iv1),dMFu2(i3,iv2),dMCha2(i2,iv2),dMSd2(i1,iv2)               & 
& ,ddMFu2(i3,iv1,iv2),ddMCha2(i2,iv1,iv2),ddMSd2(i1,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(34)=results1(34) + coeff*colorfactor*temp
results1_ti(34)=results1_ti(34) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(34)=results1(34) + coeffbar*colorfactor*tempbar
results1_ti(34)=results1_ti(34) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(34).eq.results1(34)))  write(*,*) 'NaN at FFS C[Sd, bar[Cha], bar[Fu]]' 
! ---- Sd,bar[Fe],bar[Fu] ----
Do i1=1,6
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFecFuSdL(i2,i3,i1)
coup1R = cplcFecFuSdR(i2,i3,i1)
coup2L = cplFeFucSdL(i2,i3,i1)
coup2R = cplFeFucSdR(i2,i3,i1)
Di_coup1L = dcplcFecFuSdL(i2,i3,i1,iv1)
Di_coup1R = dcplcFecFuSdR(i2,i3,i1,iv1)
Dj_coup1L = dcplcFecFuSdL(i2,i3,i1,iv2)
Dj_coup1R = dcplcFecFuSdR(i2,i3,i1,iv2)
DDcoup1L = ddcplcFecFuSdL(i2,i3,i1,iv1,iv2)
DDcoup1R = ddcplcFecFuSdR(i2,i3,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFe2(i2),MSd2(i1),dMFu2(i3,iv1)            & 
& ,dMFe2(i2,iv1),dMSd2(i1,iv1),dMFu2(i3,iv2),dMFe2(i2,iv2),dMSd2(i1,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMFe2(i2,iv1,iv2),ddMSd2(i1,iv1,iv2),coupx,Di_coupx,Dj_coupx,DDcoupx,'FFS   ',Q2,temp,temp_ti,temp_tj)
coupxbar = 2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = 2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = 2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = 2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFe2(i2),MSd2(i1),dMFu2(i3,iv1)            & 
& ,dMFe2(i2,iv1),dMSd2(i1,iv1),dMFu2(i3,iv2),dMFe2(i2,iv2),dMSd2(i1,iv2),ddMFu2(i3,iv1,iv2)& 
& ,ddMFe2(i2,iv1,iv2),ddMSd2(i1,iv1,iv2),coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFSbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 1._dp
colorfactor = 3
results1(35)=results1(35) + coeff*colorfactor*temp
results1_ti(35)=results1_ti(35) + coeff*colorfactor*temp_ti
coeffbar = 1._dp
results1(35)=results1(35) + coeffbar*colorfactor*tempbar
results1_ti(35)=results1_ti(35) + coeffbar*colorfactor*tempbar_ti
    End Do
  End Do
End Do
if (.not.(results1(35).eq.results1(35)))  write(*,*) 'NaN at FFS C[Sd, bar[Fe], bar[Fu]]' 

! ----- diagrams of type SSV, 2 ------ 

! ---- Sd,VG,conj[Sd] ----
Do i1=1,6
    Do i3=1,6
coup1 = cplSdcSdVG(i1,i3)
coup2 = cplSdcSdVG(i3,i1)
Di_coup1 = dcplSdcSdVG(i1,i3,iv1)
Dj_coup1 = dcplSdcSdVG(i1,i3,iv2)
DDcoup1 = ddcplSdcSdVG(i1,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSd2(i3),MSd2(i1),0._dp,dMSd2(i3,iv1)               & 
& ,dMSd2(i1,iv1),ZeroC,dMSd2(i3,iv2),dMSd2(i1,iv2),ZeroC,ddMSd2(i3,iv1,iv2)              & 
& ,ddMSd2(i1,iv1,iv2),ZeroC,coupx,Di_coupx,Dj_coupx,DDcoupx,'SSV   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 4
results1(36)=results1(36) + coeff*colorfactor*temp
results1_ti(36)=results1_ti(36) + coeff*colorfactor*temp_ti
    End Do
End Do
if (.not.(results1(36).eq.results1(36)))  write(*,*) 'NaN at SSV C[Sd, VG, conj[Sd]]' 
! ---- Su,VG,conj[Su] ----
Do i1=1,6
    Do i3=1,6
coup1 = cplSucSuVG(i1,i3)
coup2 = cplSucSuVG(i3,i1)
Di_coup1 = dcplSucSuVG(i1,i3,iv1)
Dj_coup1 = dcplSucSuVG(i1,i3,iv2)
DDcoup1 = ddcplSucSuVG(i1,i3,iv1,iv2)
coupx=abs(coup1)**2 
Di_coupx=Di_coup1*conjg(coup1)+coup1*conjg(Di_coup1) 
Dj_coupx=Dj_coup1*conjg(coup1)+coup1*conjg(Dj_coup1) 
DDcoupx = DDcoup1*conjg(coup1)+coup1*conjg(DDcoup1) & 
& + Di_coup1*conjg(Dj_coup1)+Dj_coup1*conjg(Di_coup1)  
Call SecondDerivativeVeff_sunrise(MSu2(i3),MSu2(i1),0._dp,dMSu2(i3,iv1)               & 
& ,dMSu2(i1,iv1),ZeroC,dMSu2(i3,iv2),dMSu2(i1,iv2),ZeroC,ddMSu2(i3,iv1,iv2)              & 
& ,ddMSu2(i1,iv1,iv2),ZeroC,coupx,Di_coupx,Dj_coupx,DDcoupx,'SSV   ',Q2,temp,temp_ti,temp_tj)
coeff = 0.5_dp
colorfactor = 4
results1(37)=results1(37) + coeff*colorfactor*temp
results1_ti(37)=results1_ti(37) + coeff*colorfactor*temp_ti
    End Do
End Do
if (.not.(results1(37).eq.results1(37)))  write(*,*) 'NaN at SSV C[Su, VG, conj[Su]]' 

! ----- diagrams of type FFV, 3 ------ 

! ---- Fd,VG,bar[Fd] ----
Do i1=1,3
    Do i3=1,3
coup1L = cplcFdFdVGL(i3,i1)
coup1R = cplcFdFdVGR(i3,i1)
coup2L = cplcFdFdVGL(i1,i3)
coup2R = cplcFdFdVGR(i1,i3)
Di_coup1L = dcplcFdFdVGL(i3,i1,iv1)
Di_coup1R = dcplcFdFdVGR(i3,i1,iv1)
Dj_coup1L = dcplcFdFdVGL(i3,i1,iv2)
Dj_coup1R = dcplcFdFdVGR(i3,i1,iv2)
DDcoup1L = ddcplcFdFdVGL(i3,i1,iv1,iv2)
DDcoup1R = ddcplcFdFdVGR(i3,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),0._dp,dMFd2(i3,iv1)               & 
& ,dMFd2(i1,iv1),ZeroC,dMFd2(i3,iv2),dMFd2(i1,iv2),ZeroC,ddMFd2(i3,iv1,iv2)              & 
& ,ddMFd2(i1,iv1,iv2),ZeroC,coupx,Di_coupx,Dj_coupx,DDcoupx,'FFV   ',Q2,temp,temp_ti,temp_tj)
coupxbar = -2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = -2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = -2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = -2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),0._dp,dMFd2(i3,iv1)               & 
& ,dMFd2(i1,iv1),ZeroC,dMFd2(i3,iv2),dMFd2(i1,iv2),ZeroC,ddMFd2(i3,iv1,iv2)              & 
& ,ddMFd2(i1,iv1,iv2),ZeroC,coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFVbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 4
results1(38)=results1(38) + coeff*colorfactor*temp
results1_ti(38)=results1_ti(38) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(38)=results1(38) + coeffbar*colorfactor*tempbar
results1_ti(38)=results1_ti(38) + coeffbar*colorfactor*tempbar_ti
    End Do
End Do
if (.not.(results1(38).eq.results1(38)))  write(*,*) 'NaN at FFV C[Fd, VG, bar[Fd]]' 
! ---- Fu,VG,bar[Fu] ----
Do i1=1,3
    Do i3=1,3
coup1L = cplcFuFuVGL(i3,i1)
coup1R = cplcFuFuVGR(i3,i1)
coup2L = cplcFuFuVGL(i1,i3)
coup2R = cplcFuFuVGR(i1,i3)
Di_coup1L = dcplcFuFuVGL(i3,i1,iv1)
Di_coup1R = dcplcFuFuVGR(i3,i1,iv1)
Dj_coup1L = dcplcFuFuVGL(i3,i1,iv2)
Dj_coup1R = dcplcFuFuVGR(i3,i1,iv2)
DDcoup1L = ddcplcFuFuVGL(i3,i1,iv1,iv2)
DDcoup1R = ddcplcFuFuVGR(i3,i1,iv1,iv2)
coupx = (abs(coup1L)**2 + abs(coup1R)**2) 
Di_coupx = Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) &
& + Di_coup1R*conjg(coup1R)+coup1R*conjg(Di_coup1R) 
Dj_coupx = Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) &
& + Dj_coup1R*conjg(coup1R)+coup1R*conjg(Dj_coup1R) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L) & 
& + DDcoup1R*conjg(coup1R)+coup1R*conjg(DDcoup1R) & 
& + Di_coup1R*conjg(Dj_coup1R)+Dj_coup1R*conjg(Di_coup1R)  
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),0._dp,dMFu2(i3,iv1)               & 
& ,dMFu2(i1,iv1),ZeroC,dMFu2(i3,iv2),dMFu2(i1,iv2),ZeroC,ddMFu2(i3,iv1,iv2)              & 
& ,ddMFu2(i1,iv1,iv2),ZeroC,coupx,Di_coupx,Dj_coupx,DDcoupx,'FFV   ',Q2,temp,temp_ti,temp_tj)
coupxbar = -2*Real(coup1L*conjg(coup1R),dp) 
Di_coupxbar = -2*Real(Di_coup1L*conjg(coup1R)+coup1L*conjg(Di_coup1R),dp) 
Dj_coupxbar = -2*Real(Dj_coup1L*conjg(coup1R)+coup1L*conjg(Dj_coup1R),dp) 
DDcoupxbar = -2*Real(DDcoup1L*conjg(coup1R)+coup1L*conjg(DDcoup1R) &  
&          + Di_coup1L*conjg(Dj_coup1R)+Dj_coup1L*conjg(Di_coup1R)  ,dp) 
Call SecondDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),0._dp,dMFu2(i3,iv1)               & 
& ,dMFu2(i1,iv1),ZeroC,dMFu2(i3,iv2),dMFu2(i1,iv2),ZeroC,ddMFu2(i3,iv1,iv2)              & 
& ,ddMFu2(i1,iv1,iv2),ZeroC,coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFVbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 4
results1(39)=results1(39) + coeff*colorfactor*temp
results1_ti(39)=results1_ti(39) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(39)=results1(39) + coeffbar*colorfactor*tempbar
results1_ti(39)=results1_ti(39) + coeffbar*colorfactor*tempbar_ti
    End Do
End Do
if (.not.(results1(39).eq.results1(39)))  write(*,*) 'NaN at FFV C[Fu, VG, bar[Fu]]' 
! ---- Glu,Glu,VG ----
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
Di_coup1L = dcplGluGluVGL(iv1)
Di_coup1R = dcplGluGluVGR(iv1)
Dj_coup1L = dcplGluGluVGL(iv2)
Dj_coup1R = dcplGluGluVGR(iv2)
DDcoup1L = ddcplGluGluVGL(iv1,iv2)
DDcoup1R = ddcplGluGluVGR(iv1,iv2)
coupx = abs(coup1L)**2
Di_coupx=Di_coup1L*conjg(coup1L)+coup1L*conjg(Di_coup1L) 
Dj_coupx=Dj_coup1L*conjg(coup1L)+coup1L*conjg(Dj_coup1L) 
DDcoupx = DDcoup1L*conjg(coup1L)+coup1L*conjg(DDcoup1L) & 
& + Di_coup1L*conjg(Dj_coup1L)+Dj_coup1L*conjg(Di_coup1L)  
Call SecondDerivativeVeff_sunrise(MGlu2,MGlu2,0._dp,dMGlu2(1,iv1),dMGlu2(1,iv1)       & 
& ,ZeroC,dMGlu2(1,iv2),dMGlu2(1,iv2),ZeroC,ddMGlu2(1,iv1,iv2),ddMGlu2(1,iv1,iv2)         & 
& ,ZeroC,coupx,Di_coupx,Dj_coupx,DDcoupx,'FFV   ',Q2,temp,temp_ti,temp_tj)
coupxbar = Real(coup1L**2,dp) 
Di_coupxbar = Real(2*Di_coup1L*coup1L,dp) 
Dj_coupxbar = Real(2*Dj_coup1L*coup1L,dp) 
DDcoupxbar = Real(2*DDcoup1L*coup1L + 2*Di_coup1L*Dj_coup1L,dp) 
Call SecondDerivativeVeff_sunrise(MGlu2,MGlu2,0._dp,dMGlu2(1,iv1),dMGlu2(1,iv1)       & 
& ,ZeroC,dMGlu2(1,iv2),dMGlu2(1,iv2),ZeroC,ddMGlu2(1,iv1,iv2),ddMGlu2(1,iv1,iv2)         & 
& ,ZeroC,coupxbar,Di_coupxbar,Dj_coupxbar,DDcoupxbar,'FFVbar',Q2,tempbar,tempbar_ti,tempbar_tj)
coeff = 0.5_dp
colorfactor = 24
results1(40)=results1(40) + coeff*colorfactor*temp
results1_ti(40)=results1_ti(40) + coeff*colorfactor*temp_ti
coeffbar = 0.5_dp
results1(40)=results1(40) + coeffbar*colorfactor*tempbar
results1_ti(40)=results1_ti(40) + coeffbar*colorfactor*tempbar_ti
if (.not.(results1(40).eq.results1(40)))  write(*,*) 'NaN at FFV C[Glu, Glu, VG]' 

! ----- diagrams of type VVV, 1 ------ 

! ---- VG,VG,VG ----
coup1 = cplVGVGVG
coup2 = cplVGVGVG
Di_coup1 = dcplVGVGVG(iv1)
Dj_coup1 = dcplVGVGVG(iv2)
DDcoup1 = ddcplVGVGVG(iv1,iv2)
coeff = 0.000
colorfactor = 24
results1(41)=results1(41) + coeff*colorfactor*temp
results1_ti(41)=results1_ti(41) + coeff*colorfactor*temp_ti
if (.not.(results1(41).eq.results1(41)))  write(*,*) 'NaN at VVV C[VG, VG, VG]' 
! ----- Topology2: diagrams w. 2 Particles and 1 Vertex


! ----- diagrams of type SS, 18 ------ 

! ---- Ah,Sd ----
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSdcSd(i1,i1,i2,i2)
Di_coup1 = dcplAhAhSdcSd(i1,i1,i2,i2,iv1)
Dj_coup1 = dcplAhAhSdcSd(i1,i1,i2,i2,iv2)
DDcoup1 = ddcplAhAhSdcSd(i1,i1,i2,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MAh2(i1),MSd2(i2),dMAh2(i1,iv1),dMSd2(i2,iv1)         & 
& ,dMAh2(i1,iv2),dMSd2(i2,iv2),ddMAh2(i1,iv1,iv2),ddMSd2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(1)=results2(1) + coeff*temp
results2_ti(1)=results2_ti(1) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(1).eq.results2(1)))  write(*,*) 'NaN at SS C[Ah, Ah, Sd, conj[Sd]]' 
! ---- Ah,Se ----
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSecSe(i1,i1,i2,i2)
Di_coup1 = dcplAhAhSecSe(i1,i1,i2,i2,iv1)
Dj_coup1 = dcplAhAhSecSe(i1,i1,i2,i2,iv2)
DDcoup1 = ddcplAhAhSecSe(i1,i1,i2,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MAh2(i1),MSe2(i2),dMAh2(i1,iv1),dMSe2(i2,iv1)         & 
& ,dMAh2(i1,iv2),dMSe2(i2,iv2),ddMAh2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(2)=results2(2) + coeff*temp
results2_ti(2)=results2_ti(2) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(2).eq.results2(2)))  write(*,*) 'NaN at SS C[Ah, Ah, Se, conj[Se]]' 
! ---- Ah,Su ----
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSucSu(i1,i1,i2,i2)
Di_coup1 = dcplAhAhSucSu(i1,i1,i2,i2,iv1)
Dj_coup1 = dcplAhAhSucSu(i1,i1,i2,i2,iv2)
DDcoup1 = ddcplAhAhSucSu(i1,i1,i2,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MAh2(i1),MSu2(i2),dMAh2(i1,iv1),dMSu2(i2,iv1)         & 
& ,dMAh2(i1,iv2),dMSu2(i2,iv2),ddMAh2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(3)=results2(3) + coeff*temp
results2_ti(3)=results2_ti(3) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(3).eq.results2(3)))  write(*,*) 'NaN at SS C[Ah, Ah, Su, conj[Su]]' 
! ---- hh,Sd ----
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSdcSd(i1,i1,i2,i2)
Di_coup1 = dcplhhhhSdcSd(i1,i1,i2,i2,iv1)
Dj_coup1 = dcplhhhhSdcSd(i1,i1,i2,i2,iv2)
DDcoup1 = ddcplhhhhSdcSd(i1,i1,i2,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(Mhh2(i1),MSd2(i2),dMhh2(i1,iv1),dMSd2(i2,iv1)         & 
& ,dMhh2(i1,iv2),dMSd2(i2,iv2),ddMhh2(i1,iv1,iv2),ddMSd2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(4)=results2(4) + coeff*temp
results2_ti(4)=results2_ti(4) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(4).eq.results2(4)))  write(*,*) 'NaN at SS C[hh, hh, Sd, conj[Sd]]' 
! ---- hh,Se ----
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSecSe(i1,i1,i2,i2)
Di_coup1 = dcplhhhhSecSe(i1,i1,i2,i2,iv1)
Dj_coup1 = dcplhhhhSecSe(i1,i1,i2,i2,iv2)
DDcoup1 = ddcplhhhhSecSe(i1,i1,i2,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(Mhh2(i1),MSe2(i2),dMhh2(i1,iv1),dMSe2(i2,iv1)         & 
& ,dMhh2(i1,iv2),dMSe2(i2,iv2),ddMhh2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(5)=results2(5) + coeff*temp
results2_ti(5)=results2_ti(5) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(5).eq.results2(5)))  write(*,*) 'NaN at SS C[hh, hh, Se, conj[Se]]' 
! ---- hh,Su ----
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSucSu(i1,i1,i2,i2)
Di_coup1 = dcplhhhhSucSu(i1,i1,i2,i2,iv1)
Dj_coup1 = dcplhhhhSucSu(i1,i1,i2,i2,iv2)
DDcoup1 = ddcplhhhhSucSu(i1,i1,i2,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(Mhh2(i1),MSu2(i2),dMhh2(i1,iv1),dMSu2(i2,iv1)         & 
& ,dMhh2(i1,iv2),dMSu2(i2,iv2),ddMhh2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(6)=results2(6) + coeff*temp
results2_ti(6)=results2_ti(6) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(6).eq.results2(6)))  write(*,*) 'NaN at SS C[hh, hh, Su, conj[Su]]' 
! ---- Hpm,Sd ----
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSdcHpmcSd(i1,i2,i1,i2)
Di_coup1 = dcplHpmSdcHpmcSd(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplHpmSdcHpmcSd(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplHpmSdcHpmcSd(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MHpm2(i1),MSd2(i2),dMHpm2(i1,iv1),dMSd2(i2,iv1)       & 
& ,dMHpm2(i1,iv2),dMSd2(i2,iv2),ddMHpm2(i1,iv1,iv2),ddMSd2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(7)=results2(7) + coeff*temp
results2_ti(7)=results2_ti(7) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(7).eq.results2(7)))  write(*,*) 'NaN at SS C[Hpm, Sd, conj[Hpm], conj[Sd]]' 
! ---- Hpm,Se ----
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSecHpmcSe(i1,i2,i1,i2)
Di_coup1 = dcplHpmSecHpmcSe(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplHpmSecHpmcSe(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplHpmSecHpmcSe(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MHpm2(i1),MSe2(i2),dMHpm2(i1,iv1),dMSe2(i2,iv1)       & 
& ,dMHpm2(i1,iv2),dMSe2(i2,iv2),ddMHpm2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(8)=results2(8) + coeff*temp
results2_ti(8)=results2_ti(8) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(8).eq.results2(8)))  write(*,*) 'NaN at SS C[Hpm, Se, conj[Hpm], conj[Se]]' 
! ---- Hpm,Su ----
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSucHpmcSu(i1,i2,i1,i2)
Di_coup1 = dcplHpmSucHpmcSu(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplHpmSucHpmcSu(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplHpmSucHpmcSu(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MHpm2(i1),MSu2(i2),dMHpm2(i1,iv1),dMSu2(i2,iv1)       & 
& ,dMHpm2(i1,iv2),dMSu2(i2,iv2),ddMHpm2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(9)=results2(9) + coeff*temp
results2_ti(9)=results2_ti(9) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(9).eq.results2(9)))  write(*,*) 'NaN at SS C[Hpm, Su, conj[Hpm], conj[Su]]' 
! ---- Hpm,Sv ----
Do i1=1,2
 Do i2=1,3
coup1 = cplHpmSvcHpmcSv(i1,i2,i1,i2)
Di_coup1 = dcplHpmSvcHpmcSv(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplHpmSvcHpmcSv(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplHpmSvcHpmcSv(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MHpm2(i1),MSv2(i2),dMHpm2(i1,iv1),dMSv2(i2,iv1)       & 
& ,dMHpm2(i1,iv2),dMSv2(i2,iv2),ddMHpm2(i1,iv1,iv2),ddMSv2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(10)=results2(10) + coeff*temp
results2_ti(10)=results2_ti(10) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(10).eq.results2(10)))  write(*,*) 'NaN at SS C[Hpm, Sv, conj[Hpm], conj[Sv]]' 
! ---- Sd,Sd ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSdcSdcSd(i1,i2,i1,i2)
Di_coup1 = dcplSdSdcSdcSd(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSdSdcSdcSd(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSdSdcSdcSd(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSd2(i1),MSd2(i2),dMSd2(i1,iv1),dMSd2(i2,iv1)         & 
& ,dMSd2(i1,iv2),dMSd2(i2,iv2),ddMSd2(i1,iv1,iv2),ddMSd2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(11)=results2(11) + coeff*temp
results2_ti(11)=results2_ti(11) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(11).eq.results2(11)))  write(*,*) 'NaN at SS C[Sd, Sd, conj[Sd], conj[Sd]]' 
! ---- Sd,Se ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSecSdcSe(i1,i2,i1,i2)
Di_coup1 = dcplSdSecSdcSe(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSdSecSdcSe(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSdSecSdcSe(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSd2(i1),MSe2(i2),dMSd2(i1,iv1),dMSe2(i2,iv1)         & 
& ,dMSd2(i1,iv2),dMSe2(i2,iv2),ddMSd2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(12)=results2(12) + coeff*temp
results2_ti(12)=results2_ti(12) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(12).eq.results2(12)))  write(*,*) 'NaN at SS C[Sd, Se, conj[Sd], conj[Se]]' 
! ---- Sd,Su ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSucSdcSu(i1,i2,i1,i2)
Di_coup1 = dcplSdSucSdcSu(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSdSucSdcSu(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSdSucSdcSu(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSd2(i1),MSu2(i2),dMSd2(i1,iv1),dMSu2(i2,iv1)         & 
& ,dMSd2(i1,iv2),dMSu2(i2,iv2),ddMSd2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(13)=results2(13) + coeff*temp
results2_ti(13)=results2_ti(13) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(13).eq.results2(13)))  write(*,*) 'NaN at SS C[Sd, Su, conj[Sd], conj[Su]]' 
! ---- Sd,Sv ----
Do i1=1,6
 Do i2=1,3
coup1 = cplSdSvcSdcSv(i1,i2,i1,i2)
Di_coup1 = dcplSdSvcSdcSv(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSdSvcSdcSv(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSdSvcSdcSv(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSd2(i1),MSv2(i2),dMSd2(i1,iv1),dMSv2(i2,iv1)         & 
& ,dMSd2(i1,iv2),dMSv2(i2,iv2),ddMSd2(i1,iv1,iv2),ddMSv2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(14)=results2(14) + coeff*temp
results2_ti(14)=results2_ti(14) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(14).eq.results2(14)))  write(*,*) 'NaN at SS C[Sd, Sv, conj[Sd], conj[Sv]]' 
! ---- Se,Se ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSeSecSecSe(i1,i2,i1,i2)
Di_coup1 = dcplSeSecSecSe(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSeSecSecSe(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSeSecSecSe(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSe2(i1),MSe2(i2),dMSe2(i1,iv1),dMSe2(i2,iv1)         & 
& ,dMSe2(i1,iv2),dMSe2(i2,iv2),ddMSe2(i1,iv1,iv2),ddMSe2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(15)=results2(15) + coeff*temp
results2_ti(15)=results2_ti(15) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(15).eq.results2(15)))  write(*,*) 'NaN at SS C[Se, Se, conj[Se], conj[Se]]' 
! ---- Se,Su ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSeSucSecSu(i1,i2,i1,i2)
Di_coup1 = dcplSeSucSecSu(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSeSucSecSu(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSeSucSecSu(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSe2(i1),MSu2(i2),dMSe2(i1,iv1),dMSu2(i2,iv1)         & 
& ,dMSe2(i1,iv2),dMSu2(i2,iv2),ddMSe2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(16)=results2(16) + coeff*temp
results2_ti(16)=results2_ti(16) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(16).eq.results2(16)))  write(*,*) 'NaN at SS C[Se, Su, conj[Se], conj[Su]]' 
! ---- Se,Sv ----
Do i1=1,6
 Do i2=1,3
coup1 = cplSeSvcSecSv(i1,i2,i1,i2)
Di_coup1 = dcplSeSvcSecSv(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSeSvcSecSv(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSeSvcSecSv(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSe2(i1),MSv2(i2),dMSe2(i1,iv1),dMSv2(i2,iv1)         & 
& ,dMSe2(i1,iv2),dMSv2(i2,iv2),ddMSe2(i1,iv1,iv2),ddMSv2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-1._dp)
results2(17)=results2(17) + coeff*temp
results2_ti(17)=results2_ti(17) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(17).eq.results2(17)))  write(*,*) 'NaN at SS C[Se, Sv, conj[Se], conj[Sv]]' 
! ---- Su,Su ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSuSucSucSu(i1,i2,i1,i2)
Di_coup1 = dcplSuSucSucSu(i1,i2,i1,i2,iv1)
Dj_coup1 = dcplSuSucSucSu(i1,i2,i1,i2,iv2)
DDcoup1 = ddcplSuSucSucSu(i1,i2,i1,i2,iv1,iv2)
Call SecondDerivativeVeff_balls(MSu2(i1),MSu2(i2),dMSu2(i1,iv1),dMSu2(i2,iv1)         & 
& ,dMSu2(i1,iv2),dMSu2(i2,iv2),ddMSu2(i1,iv1,iv2),ddMSu2(i2,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'SS',Q2,temp,temp_ti,temp_tj)
coeff = (-0.5_dp)
results2(18)=results2(18) + coeff*temp
results2_ti(18)=results2_ti(18) + coeff*temp_ti
  End Do
End Do
if (.not.(results2(18).eq.results2(18)))  write(*,*) 'NaN at SS C[Su, Su, conj[Su], conj[Su]]' 

! ----- diagrams of type VS, 2 ------ 

! ---- Sd,VG ----
Do i1=1,6
coup1 = cplSdcSdVGVG(i1,i1)
Di_coup1 = dcplSdcSdVGVG(i1,i1,iv1)
Dj_coup1 = dcplSdcSdVGVG(i1,i1,iv2)
DDcoup1 = ddcplSdcSdVGVG(i1,i1,iv1,iv2)
Call SecondDerivativeVeff_balls(0._dp,MSd2(i1),ZeroC,dMSd2(i1,iv1),ZeroC,dMSd2(i1,iv2)& 
& ,ZeroC,ddMSd2(i1,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'VS',Q2,temp,temp_ti,temp_tj)
coeff = 0._dp
results2(19)=results2(19) + coeff*temp
results2_ti(19)=results2_ti(19) + coeff*temp_ti
End Do
if (.not.(results2(19).eq.results2(19)))  write(*,*) 'NaN at VS C[Sd, VG, VG, conj[Sd]]' 
! ---- Su,VG ----
Do i1=1,6
coup1 = cplSucSuVGVG(i1,i1)
Di_coup1 = dcplSucSuVGVG(i1,i1,iv1)
Dj_coup1 = dcplSucSuVGVG(i1,i1,iv2)
DDcoup1 = ddcplSucSuVGVG(i1,i1,iv1,iv2)
Call SecondDerivativeVeff_balls(0._dp,MSu2(i1),ZeroC,dMSu2(i1,iv1),ZeroC,dMSu2(i1,iv2)& 
& ,ZeroC,ddMSu2(i1,iv1,iv2),coup1,Di_coup1,Dj_coup1,DDcoup1,'VS',Q2,temp,temp_ti,temp_tj)
coeff = 0._dp
results2(20)=results2(20) + coeff*temp
results2_ti(20)=results2_ti(20) + coeff*temp_ti
End Do
if (.not.(results2(20).eq.results2(20)))  write(*,*) 'NaN at VS C[Su, VG, VG, conj[Su]]' 

  result = sum(results1)+sum(results2) ! 2nd deriv. of V
  result_ti = sum(results1_ti)+sum(results2_ti) ! 1st deriv. of V
  pi2L(iv1,iv2) = oo16pi2**2 * Real(result,dp) 
  End Do 
  ti2L(iv1) = oo16pi2**2 * Real(result_ti,dp) 
End Do 
Do iv1=1,2
  Do iv2=1,iv1-1
  pi2L(iv1,iv2) = pi2L(iv2,iv1) 
  End Do 
End Do 
End Subroutine SecondDerivativeEffPot2Loop 





Subroutine FirstDerivativeEffPot2Loop(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,               & 
& Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,kont,ti2L)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Integer, Intent(inout):: kont
Real(dp), Intent(out) :: ti2L(2)
Integer :: i,i1,i2,i3,includeGhosts,NrContr 
Integer :: iv1, iv2 
Integer :: NrContr1,NrContr2 !nr of contributing diagrams
Real(dp) :: Q2,colorfactor,coeff,coeffbar
Complex(dp) :: result,temp,tempbar
Complex(dp) :: coup1,coup2,coup1L,coup1R,coup2L,coup2R,coupx,coupxbar
Complex(dp) :: dcoup1,dcoup2,dcoup1L,dcoup1R,dcoup2L,dcoup2R,dcoupx,dcoupxbar
Real(dp) :: gout(29328) 
Real(dp) :: results1(41),results2(20)
Complex(dp) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

Complex(dp) :: dcplAhSdcSd(2,6,6,2),dcplAhSecSe(2,6,6,2),dcplAhSucSu(2,6,6,2),dcplhhSdcSd(2,6,6,2),  & 
& dcplhhSecSe(2,6,6,2),dcplhhSucSu(2,6,6,2),dcplHpmSucSd(2,6,6,2),dcplHpmSvcSe(2,3,6,2), & 
& dcplSdSvcSd(6,3,6,2),dcplSdcHpmcSu(6,2,6,2),dcplSdcSdcSv(6,6,3,2),dcplSdcSecSu(6,6,6,2),& 
& dcplSeSucSd(6,6,6,2),dcplSeSvcSe(6,3,6,2),dcplSecHpmcSv(6,2,3,2),dcplSecSecSv(6,6,3,2),& 
& dcplSdcSdVG(6,6,2),dcplSucSuVG(6,6,2),dcplVGVGVG(2),dcplcFdFdAhL(3,3,2,2),             & 
& dcplcFdFdAhR(3,3,2,2),dcplcFeFeAhL(3,3,2,2),dcplcFeFeAhR(3,3,2,2),dcplcFuFuAhL(3,3,2,2),& 
& dcplcFuFuAhR(3,3,2,2),dcplChaFucSdL(2,3,6,2),dcplChaFucSdR(2,3,6,2),dcplFvChacSeL(3,2,6,2),& 
& dcplFvChacSeR(3,2,6,2),dcplcFdChaSuL(3,2,6,2),dcplcFdChaSuR(3,2,6,2),dcplcFeChaSvL(3,2,3,2),& 
& dcplcFeChaSvR(3,2,3,2),dcplChiFdcSdL(4,3,6,2),dcplChiFdcSdR(4,3,6,2),dcplChiFecSeL(4,3,6,2),& 
& dcplChiFecSeR(4,3,6,2),dcplChiFucSuL(4,3,6,2),dcplChiFucSuR(4,3,6,2),dcplcFdChiSdL(3,4,6,2),& 
& dcplcFdChiSdR(3,4,6,2),dcplcFeChiSeL(3,4,6,2),dcplcFeChiSeR(3,4,6,2),dcplcFuChiSuL(3,4,6,2),& 
& dcplcFuChiSuR(3,4,6,2),dcplFvFdcSdL(3,3,6,2),dcplFvFdcSdR(3,3,6,2),dcplGluFdcSdL(3,6,2),& 
& dcplGluFdcSdR(3,6,2),dcplcFdFdhhL(3,3,2,2),dcplcFdFdhhR(3,3,2,2),dcplcFdFdSvL(3,3,3,2),& 
& dcplcFdFdSvR(3,3,3,2),dcplcChaFdcSuL(2,3,6,2),dcplcChaFdcSuR(2,3,6,2),dcplcFdFdcSvL(3,3,3,2),& 
& dcplcFdFdcSvR(3,3,3,2),dcplcFeFdcSuL(3,3,6,2),dcplcFeFdcSuR(3,3,6,2),dcplcFuFdcHpmL(3,3,2,2),& 
& dcplcFuFdcHpmR(3,3,2,2),dcplcFuFdcSeL(3,3,6,2),dcplcFuFdcSeR(3,3,6,2),dcplFeFucSdL(3,3,6,2),& 
& dcplFeFucSdR(3,3,6,2),dcplFvFecHpmL(3,3,2,2),dcplFvFecHpmR(3,3,2,2),dcplFvFecSeL(3,3,6,2),& 
& dcplFvFecSeR(3,3,6,2),dcplcFeFehhL(3,3,2,2),dcplcFeFehhR(3,3,2,2),dcplcFdFeSuL(3,3,6,2),& 
& dcplcFdFeSuR(3,3,6,2),dcplcFeFeSvL(3,3,3,2),dcplcFeFeSvR(3,3,3,2),dcplcChaFecSvL(2,3,3,2),& 
& dcplcChaFecSvR(2,3,3,2),dcplcFeFecSvL(3,3,3,2),dcplcFeFecSvR(3,3,3,2),dcplGluFucSuL(3,6,2),& 
& dcplGluFucSuR(3,6,2),dcplcFuFuhhL(3,3,2,2),dcplcFuFuhhR(3,3,2,2),dcplcFdFuHpmL(3,3,2,2),& 
& dcplcFdFuHpmR(3,3,2,2),dcplcFdFuSeL(3,3,6,2),dcplcFdFuSeR(3,3,6,2),dcplcFeFvHpmL(3,3,2,2),& 
& dcplcFeFvHpmR(3,3,2,2),dcplcFdFvSdL(3,3,6,2),dcplcFdFvSdR(3,3,6,2),dcplcChaFvSeL(2,3,6,2),& 
& dcplcChaFvSeR(2,3,6,2),dcplcFeFvSeL(3,3,6,2),dcplcFeFvSeR(3,3,6,2),dcplcFdGluSdL(3,6,2),& 
& dcplcFdGluSdR(3,6,2),dcplcFuGluSuL(3,6,2),dcplcFuGluSuR(3,6,2),dcplcChacFuSdL(2,3,6,2),& 
& dcplcChacFuSdR(2,3,6,2),dcplcFecFuSdL(3,3,6,2),dcplcFecFuSdR(3,3,6,2),dcplcFdFdVGL(3,3,2),& 
& dcplcFdFdVGR(3,3,2),dcplcFuFuVGL(3,3,2),dcplcFuFuVGR(3,3,2),dcplGluGluVGL(2),          & 
& dcplGluGluVGR(2)

Complex(dp) :: dcplAhAhSdcSd(2,2,6,6,2),dcplAhAhSecSe(2,2,6,6,2),dcplAhAhSucSu(2,2,6,6,2),           & 
& dcplhhhhSdcSd(2,2,6,6,2),dcplhhhhSecSe(2,2,6,6,2),dcplhhhhSucSu(2,2,6,6,2),            & 
& dcplHpmSdcHpmcSd(2,6,2,6,2),dcplHpmSecHpmcSe(2,6,2,6,2),dcplHpmSucHpmcSu(2,6,2,6,2),   & 
& dcplHpmSvcHpmcSv(2,3,2,3,2),dcplSdSdcSdcSd(6,6,6,6,2),dcplSdSecSdcSe(6,6,6,6,2),       & 
& dcplSdSucSdcSu(6,6,6,6,2),dcplSdSvcSdcSv(6,3,6,3,2),dcplSeSecSecSe(6,6,6,6,2),         & 
& dcplSeSucSecSu(6,6,6,6,2),dcplSeSvcSecSv(6,3,6,3,2),dcplSuSucSucSu(6,6,6,6,2),         & 
& dcplSdcSdVGVG(6,6,2),dcplSucSuVGVG(6,6,2)

Real(dp) :: MSd(6),MSd2(6),MSv(3),MSv2(3),MSu(6),MSu2(6),MSe(6),MSe2(6),Mhh(2),Mhh2(2),           & 
& MAh(2),MAh2(2),MHpm(2),MHpm2(2),MChi(4),MChi2(4),MCha(2),MCha2(2),MFe(3),              & 
& MFe2(3),MFd(3),MFd2(3),MFu(3),MFu2(3),MGlu,MGlu2,MVZ,MVZ2,MVWm,MVWm2

Complex(dp) :: dMSd(6,2),dMSd2(6,2),dMSv(3,2),dMSv2(3,2),dMSu(6,2),dMSu2(6,2),dMSe(6,2),             & 
& dMSe2(6,2),dMhh(2,2),dMhh2(2,2),dMAh(2,2),dMAh2(2,2),dMHpm(2,2),dMHpm2(2,2),           & 
& dMChi(4,2),dMChi2(4,2),dMCha(2,2),dMCha2(2,2),dMFe(3,2),dMFe2(3,2),dMFd(3,2),          & 
& dMFd2(3,2),dMFu(3,2),dMFu2(3,2),dMGlu(1,2),dMGlu2(1,2),dMVZ(1,2),dMVZ2(1,2),           & 
& dMVWm(1,2),dMVWm2(1,2)

!! ------------------------------------------------- 
!! Calculate masses, couplings and their derivatives 
!! ------------------------------------------------- 

Do i1=1,2
Call FirstDerivativeMassesCoups(i1,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,               & 
& Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

Call GToMassesCoups(gout,MSd,MSd2,MSv,MSv2,MSu,MSu2,MSe,MSe2,Mhh,Mhh2,MAh,            & 
& MAh2,MHpm,MHpm2,MChi,MChi2,MCha,MCha2,MFe,MFe2,MFd,MFd2,MFu,MFu2,MGlu,MGlu2,           & 
& MVZ,MVZ2,MVWm,MVWm2,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplhhSdcSd,cplhhSecSe,            & 
& cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,    & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,             & 
& cplAhAhSdcSd,cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,         & 
& cplHpmSdcHpmcSd,cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,         & 
& cplSdSecSdcSe,cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,   & 
& cplSuSucSucSu,cplSdcSdVGVG,cplSucSuVGVG)

dMSd(:,i1) = MSd
dMSd2(:,i1) = MSd2
dMSv(:,i1) = MSv
dMSv2(:,i1) = MSv2
dMSu(:,i1) = MSu
dMSu2(:,i1) = MSu2
dMSe(:,i1) = MSe
dMSe2(:,i1) = MSe2
dMhh(:,i1) = Mhh
dMhh2(:,i1) = Mhh2
dMAh(:,i1) = MAh
dMAh2(:,i1) = MAh2
dMHpm(:,i1) = MHpm
dMHpm2(:,i1) = MHpm2
dMChi(:,i1) = MChi
dMChi2(:,i1) = MChi2
dMCha(:,i1) = MCha
dMCha2(:,i1) = MCha2
dMFe(:,i1) = MFe
dMFe2(:,i1) = MFe2
dMFd(:,i1) = MFd
dMFd2(:,i1) = MFd2
dMFu(:,i1) = MFu
dMFu2(:,i1) = MFu2
dMGlu(:,i1) = MGlu
dMGlu2(:,i1) = MGlu2
dMVZ(:,i1) = MVZ
dMVZ2(:,i1) = MVZ2
dMVWm(:,i1) = MVWm
dMVWm2(:,i1) = MVWm2
dcplAhSdcSd(:,:,:,i1) = cplAhSdcSd
dcplAhSecSe(:,:,:,i1) = cplAhSecSe
dcplAhSucSu(:,:,:,i1) = cplAhSucSu
dcplhhSdcSd(:,:,:,i1) = cplhhSdcSd
dcplhhSecSe(:,:,:,i1) = cplhhSecSe
dcplhhSucSu(:,:,:,i1) = cplhhSucSu
dcplHpmSucSd(:,:,:,i1) = cplHpmSucSd
dcplHpmSvcSe(:,:,:,i1) = cplHpmSvcSe
dcplSdSvcSd(:,:,:,i1) = cplSdSvcSd
dcplSdcHpmcSu(:,:,:,i1) = cplSdcHpmcSu
dcplSdcSdcSv(:,:,:,i1) = cplSdcSdcSv
dcplSdcSecSu(:,:,:,i1) = cplSdcSecSu
dcplSeSucSd(:,:,:,i1) = cplSeSucSd
dcplSeSvcSe(:,:,:,i1) = cplSeSvcSe
dcplSecHpmcSv(:,:,:,i1) = cplSecHpmcSv
dcplSecSecSv(:,:,:,i1) = cplSecSecSv
dcplSdcSdVG(:,:,i1) = cplSdcSdVG
dcplSucSuVG(:,:,i1) = cplSucSuVG
dcplVGVGVG(i1) = cplVGVGVG
dcplcFdFdAhL(:,:,:,i1) = cplcFdFdAhL
dcplcFdFdAhR(:,:,:,i1) = cplcFdFdAhR
dcplcFeFeAhL(:,:,:,i1) = cplcFeFeAhL
dcplcFeFeAhR(:,:,:,i1) = cplcFeFeAhR
dcplcFuFuAhL(:,:,:,i1) = cplcFuFuAhL
dcplcFuFuAhR(:,:,:,i1) = cplcFuFuAhR
dcplChaFucSdL(:,:,:,i1) = cplChaFucSdL
dcplChaFucSdR(:,:,:,i1) = cplChaFucSdR
dcplFvChacSeL(:,:,:,i1) = cplFvChacSeL
dcplFvChacSeR(:,:,:,i1) = cplFvChacSeR
dcplcFdChaSuL(:,:,:,i1) = cplcFdChaSuL
dcplcFdChaSuR(:,:,:,i1) = cplcFdChaSuR
dcplcFeChaSvL(:,:,:,i1) = cplcFeChaSvL
dcplcFeChaSvR(:,:,:,i1) = cplcFeChaSvR
dcplChiFdcSdL(:,:,:,i1) = cplChiFdcSdL
dcplChiFdcSdR(:,:,:,i1) = cplChiFdcSdR
dcplChiFecSeL(:,:,:,i1) = cplChiFecSeL
dcplChiFecSeR(:,:,:,i1) = cplChiFecSeR
dcplChiFucSuL(:,:,:,i1) = cplChiFucSuL
dcplChiFucSuR(:,:,:,i1) = cplChiFucSuR
dcplcFdChiSdL(:,:,:,i1) = cplcFdChiSdL
dcplcFdChiSdR(:,:,:,i1) = cplcFdChiSdR
dcplcFeChiSeL(:,:,:,i1) = cplcFeChiSeL
dcplcFeChiSeR(:,:,:,i1) = cplcFeChiSeR
dcplcFuChiSuL(:,:,:,i1) = cplcFuChiSuL
dcplcFuChiSuR(:,:,:,i1) = cplcFuChiSuR
dcplFvFdcSdL(:,:,:,i1) = cplFvFdcSdL
dcplFvFdcSdR(:,:,:,i1) = cplFvFdcSdR
dcplGluFdcSdL(:,:,i1) = cplGluFdcSdL
dcplGluFdcSdR(:,:,i1) = cplGluFdcSdR
dcplcFdFdhhL(:,:,:,i1) = cplcFdFdhhL
dcplcFdFdhhR(:,:,:,i1) = cplcFdFdhhR
dcplcFdFdSvL(:,:,:,i1) = cplcFdFdSvL
dcplcFdFdSvR(:,:,:,i1) = cplcFdFdSvR
dcplcChaFdcSuL(:,:,:,i1) = cplcChaFdcSuL
dcplcChaFdcSuR(:,:,:,i1) = cplcChaFdcSuR
dcplcFdFdcSvL(:,:,:,i1) = cplcFdFdcSvL
dcplcFdFdcSvR(:,:,:,i1) = cplcFdFdcSvR
dcplcFeFdcSuL(:,:,:,i1) = cplcFeFdcSuL
dcplcFeFdcSuR(:,:,:,i1) = cplcFeFdcSuR
dcplcFuFdcHpmL(:,:,:,i1) = cplcFuFdcHpmL
dcplcFuFdcHpmR(:,:,:,i1) = cplcFuFdcHpmR
dcplcFuFdcSeL(:,:,:,i1) = cplcFuFdcSeL
dcplcFuFdcSeR(:,:,:,i1) = cplcFuFdcSeR
dcplFeFucSdL(:,:,:,i1) = cplFeFucSdL
dcplFeFucSdR(:,:,:,i1) = cplFeFucSdR
dcplFvFecHpmL(:,:,:,i1) = cplFvFecHpmL
dcplFvFecHpmR(:,:,:,i1) = cplFvFecHpmR
dcplFvFecSeL(:,:,:,i1) = cplFvFecSeL
dcplFvFecSeR(:,:,:,i1) = cplFvFecSeR
dcplcFeFehhL(:,:,:,i1) = cplcFeFehhL
dcplcFeFehhR(:,:,:,i1) = cplcFeFehhR
dcplcFdFeSuL(:,:,:,i1) = cplcFdFeSuL
dcplcFdFeSuR(:,:,:,i1) = cplcFdFeSuR
dcplcFeFeSvL(:,:,:,i1) = cplcFeFeSvL
dcplcFeFeSvR(:,:,:,i1) = cplcFeFeSvR
dcplcChaFecSvL(:,:,:,i1) = cplcChaFecSvL
dcplcChaFecSvR(:,:,:,i1) = cplcChaFecSvR
dcplcFeFecSvL(:,:,:,i1) = cplcFeFecSvL
dcplcFeFecSvR(:,:,:,i1) = cplcFeFecSvR
dcplGluFucSuL(:,:,i1) = cplGluFucSuL
dcplGluFucSuR(:,:,i1) = cplGluFucSuR
dcplcFuFuhhL(:,:,:,i1) = cplcFuFuhhL
dcplcFuFuhhR(:,:,:,i1) = cplcFuFuhhR
dcplcFdFuHpmL(:,:,:,i1) = cplcFdFuHpmL
dcplcFdFuHpmR(:,:,:,i1) = cplcFdFuHpmR
dcplcFdFuSeL(:,:,:,i1) = cplcFdFuSeL
dcplcFdFuSeR(:,:,:,i1) = cplcFdFuSeR
dcplcFeFvHpmL(:,:,:,i1) = cplcFeFvHpmL
dcplcFeFvHpmR(:,:,:,i1) = cplcFeFvHpmR
dcplcFdFvSdL(:,:,:,i1) = cplcFdFvSdL
dcplcFdFvSdR(:,:,:,i1) = cplcFdFvSdR
dcplcChaFvSeL(:,:,:,i1) = cplcChaFvSeL
dcplcChaFvSeR(:,:,:,i1) = cplcChaFvSeR
dcplcFeFvSeL(:,:,:,i1) = cplcFeFvSeL
dcplcFeFvSeR(:,:,:,i1) = cplcFeFvSeR
dcplcFdGluSdL(:,:,i1) = cplcFdGluSdL
dcplcFdGluSdR(:,:,i1) = cplcFdGluSdR
dcplcFuGluSuL(:,:,i1) = cplcFuGluSuL
dcplcFuGluSuR(:,:,i1) = cplcFuGluSuR
dcplcChacFuSdL(:,:,:,i1) = cplcChacFuSdL
dcplcChacFuSdR(:,:,:,i1) = cplcChacFuSdR
dcplcFecFuSdL(:,:,:,i1) = cplcFecFuSdL
dcplcFecFuSdR(:,:,:,i1) = cplcFecFuSdR
dcplcFdFdVGL(:,:,i1) = cplcFdFdVGL
dcplcFdFdVGR(:,:,i1) = cplcFdFdVGR
dcplcFuFuVGL(:,:,i1) = cplcFuFuVGL
dcplcFuFuVGR(:,:,i1) = cplcFuFuVGR
dcplGluGluVGL(i1) = cplGluGluVGL
dcplGluGluVGR(i1) = cplGluGluVGR
dcplAhAhSdcSd(:,:,:,:,i1) = cplAhAhSdcSd
dcplAhAhSecSe(:,:,:,:,i1) = cplAhAhSecSe
dcplAhAhSucSu(:,:,:,:,i1) = cplAhAhSucSu
dcplhhhhSdcSd(:,:,:,:,i1) = cplhhhhSdcSd
dcplhhhhSecSe(:,:,:,:,i1) = cplhhhhSecSe
dcplhhhhSucSu(:,:,:,:,i1) = cplhhhhSucSu
dcplHpmSdcHpmcSd(:,:,:,:,i1) = cplHpmSdcHpmcSd
dcplHpmSecHpmcSe(:,:,:,:,i1) = cplHpmSecHpmcSe
dcplHpmSucHpmcSu(:,:,:,:,i1) = cplHpmSucHpmcSu
dcplHpmSvcHpmcSv(:,:,:,:,i1) = cplHpmSvcHpmcSv
dcplSdSdcSdcSd(:,:,:,:,i1) = cplSdSdcSdcSd
dcplSdSecSdcSe(:,:,:,:,i1) = cplSdSecSdcSe
dcplSdSucSdcSu(:,:,:,:,i1) = cplSdSucSdcSu
dcplSdSvcSdcSv(:,:,:,:,i1) = cplSdSvcSdcSv
dcplSeSecSecSe(:,:,:,:,i1) = cplSeSecSecSe
dcplSeSucSecSu(:,:,:,:,i1) = cplSeSucSecSu
dcplSeSvcSecSv(:,:,:,:,i1) = cplSeSvcSecSv
dcplSuSucSucSu(:,:,:,:,i1) = cplSuSucSucSu
dcplSdcSdVGVG(:,:,i1) = cplSdcSdVGVG
dcplSucSuVGVG(:,:,i1) = cplSucSuVGVG
End Do 
 
Call TreeMassesEffPot(MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,             & 
& Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,.True.,kont)

Call CouplingsForEffPot3(Mu,Yd,Td,ZD,ZA,Ye,Te,ZE,Yu,Tu,ZU,vd,ZH,vu,ZP,ZV,             & 
& L2,T2,L1,T1,g3,ZDL,ZDR,ZEL,ZER,ZUL,ZUR,UM,UP,ZN,pG,cplAhSdcSd,cplAhSecSe,              & 
& cplAhSucSu,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,        & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,               & 
& cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,            & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,        & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,         & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR)

Call CouplingsForEffPot4(Yd,ZD,ZA,Ye,ZE,Yu,ZU,ZH,ZP,ZV,g3,L2,L1,cplAhAhSdcSd,         & 
& cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,cplHpmSdcHpmcSd,      & 
& cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,cplSdSecSdcSe,           & 
& cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,cplSuSucSucSu,   & 
& cplSdcSdVGVG,cplSucSuVGVG)



!! ------------------------------------------------- 
!! Calculate derivative of effective potential      
!! ------------------------------------------------- 



Q2 = getRenormalizationScale()
ti2L = 0._dp
result = ZeroC
results1 = ZeroC
results2 = ZeroC
Do iv1=1,2
! ----- Topology1 (sunrise): diagrams w. 3 Particles and 2 Vertices

! ----- diagrams of type SSS, 11 ------ 
! ---- Ah,Sd,conj[Sd] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSdcSd(i1,i2,i3)
coup2 = cplAhSdcSd(i1,i3,i2)
dcoup1 = dcplAhSdcSd(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MAh2(i1),MSd2(i2),MSd2(i3),dMAh2(i1,iv1)             & 
& ,dMSd2(i2,iv1),dMSd2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 3
results1(1)=results1(1) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Ah, Sd, conj[Sd]]' 
    End Do
  End Do
End Do
! ---- Ah,Se,conj[Se] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSecSe(i1,i2,i3)
coup2 = cplAhSecSe(i1,i3,i2)
dcoup1 = dcplAhSecSe(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MAh2(i1),MSe2(i2),MSe2(i3),dMAh2(i1,iv1)             & 
& ,dMSe2(i2,iv1),dMSe2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 1
results1(2)=results1(2) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Ah, Se, conj[Se]]' 
    End Do
  End Do
End Do
! ---- Ah,Su,conj[Su] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplAhSucSu(i1,i2,i3)
coup2 = cplAhSucSu(i1,i3,i2)
dcoup1 = dcplAhSucSu(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MAh2(i1),MSu2(i2),MSu2(i3),dMAh2(i1,iv1)             & 
& ,dMSu2(i2,iv1),dMSu2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 3
results1(3)=results1(3) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Ah, Su, conj[Su]]' 
    End Do
  End Do
End Do
! ---- hh,Sd,conj[Sd] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSdcSd(i1,i2,i3)
coup2 = cplhhSdcSd(i1,i3,i2)
dcoup1 = dcplhhSdcSd(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(Mhh2(i1),MSd2(i2),MSd2(i3),dMhh2(i1,iv1)             & 
& ,dMSd2(i2,iv1),dMSd2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 3
results1(4)=results1(4) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[hh, Sd, conj[Sd]]' 
    End Do
  End Do
End Do
! ---- hh,Se,conj[Se] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSecSe(i1,i2,i3)
coup2 = cplhhSecSe(i1,i3,i2)
dcoup1 = dcplhhSecSe(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(Mhh2(i1),MSe2(i2),MSe2(i3),dMhh2(i1,iv1)             & 
& ,dMSe2(i2,iv1),dMSe2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 1
results1(5)=results1(5) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[hh, Se, conj[Se]]' 
    End Do
  End Do
End Do
! ---- hh,Su,conj[Su] ----
Do i1=1,2
 Do i2=1,6
    Do i3=1,6
coup1 = cplhhSucSu(i1,i2,i3)
coup2 = cplhhSucSu(i1,i3,i2)
dcoup1 = dcplhhSucSu(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(Mhh2(i1),MSu2(i2),MSu2(i3),dMhh2(i1,iv1)             & 
& ,dMSu2(i2,iv1),dMSu2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 3
results1(6)=results1(6) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[hh, Su, conj[Su]]' 
    End Do
  End Do
End Do
! ---- Sd,conj[Hpm],conj[Su] ----
Do i1=1,6
 Do i2=1,2
    Do i3=1,6
coup1 = cplSdcHpmcSu(i1,i2,i3)
coup2 = cplHpmSucSd(i2,i3,i1)
dcoup1 = dcplSdcHpmcSu(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSd2(i1),MHpm2(i2),MSu2(i3),dMSd2(i1,iv1)            & 
& ,dMHpm2(i2,iv1),dMSu2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 1._dp
colorfactor = 3
results1(7)=results1(7) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Sd, conj[Hpm], conj[Su]]' 
    End Do
  End Do
End Do
! ---- Sd,conj[Sd],conj[Sv] ----
Do i1=1,6
 Do i2=1,6
    Do i3=1,3
coup1 = cplSdcSdcSv(i1,i2,i3)
coup2 = cplSdSvcSd(i2,i3,i1)
dcoup1 = dcplSdcSdcSv(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSd2(i1),MSd2(i2),MSv2(i3),dMSd2(i1,iv1)             & 
& ,dMSd2(i2,iv1),dMSv2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 1._dp
colorfactor = 3
results1(8)=results1(8) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Sd, conj[Sd], conj[Sv]]' 
    End Do
  End Do
End Do
! ---- Se,Su,conj[Sd] ----
Do i1=1,6
 Do i2=1,6
    Do i3=1,6
coup1 = cplSeSucSd(i1,i2,i3)
coup2 = cplSdcSecSu(i3,i1,i2)
dcoup1 = dcplSeSucSd(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSe2(i1),MSu2(i2),MSd2(i3),dMSe2(i1,iv1)             & 
& ,dMSu2(i2,iv1),dMSd2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 1._dp
colorfactor = 3
results1(9)=results1(9) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Se, Su, conj[Sd]]' 
    End Do
  End Do
End Do
! ---- Se,conj[Hpm],conj[Sv] ----
Do i1=1,6
 Do i2=1,2
    Do i3=1,3
coup1 = cplSecHpmcSv(i1,i2,i3)
coup2 = cplHpmSvcSe(i2,i3,i1)
dcoup1 = dcplSecHpmcSv(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSe2(i1),MHpm2(i2),MSv2(i3),dMSe2(i1,iv1)            & 
& ,dMHpm2(i2,iv1),dMSv2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 1._dp
colorfactor = 1
results1(10)=results1(10) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Se, conj[Hpm], conj[Sv]]' 
    End Do
  End Do
End Do
! ---- Se,conj[Se],conj[Sv] ----
Do i1=1,6
 Do i2=1,6
    Do i3=1,3
coup1 = cplSecSecSv(i1,i2,i3)
coup2 = cplSeSvcSe(i2,i3,i1)
dcoup1 = dcplSecSecSv(i1,i2,i3,iv1)
coupx=abs(coup1)**2 
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSe2(i1),MSe2(i2),MSv2(i3),dMSe2(i1,iv1)             & 
& ,dMSe2(i2,iv1),dMSv2(i3,iv1),coupx,dcoupx,'SSS   ',Q2,temp)
coeff = 1._dp
colorfactor = 1
results1(11)=results1(11) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSS C[Se, conj[Se], conj[Sv]]' 
    End Do
  End Do
End Do
! ----- diagrams of type FFS, 24 ------ 
! ---- Ah,Fd,bar[Fd] ----
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFdFdAhL(i3,i2,i1)
coup1R = cplcFdFdAhR(i3,i2,i1)
coup2L = cplcFdFdAhL(i2,i3,i1)
coup2R = cplcFdFdAhR(i2,i3,i1)
dcoup1L = dcplcFdFdAhL(i3,i2,i1,iv1)
dcoup1R = dcplcFdFdAhR(i3,i2,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFd2(i2),MAh2(i1),dMFd2(i3,iv1)             & 
& ,dMFd2(i2,iv1),dMAh2(i1,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFd2(i2),MAh2(i1),dMFd2(i3,iv1)             & 
& ,dMFd2(i2,iv1),dMAh2(i1,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 3
results1(12)=results1(12) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Ah, Fd, bar[Fd]]' 
coeffbar = 0.5_dp
results1(12)=results1(12) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Ah,Fe,bar[Fe] ----
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFeFeAhL(i3,i2,i1)
coup1R = cplcFeFeAhR(i3,i2,i1)
coup2L = cplcFeFeAhL(i2,i3,i1)
coup2R = cplcFeFeAhR(i2,i3,i1)
dcoup1L = dcplcFeFeAhL(i3,i2,i1,iv1)
dcoup1R = dcplcFeFeAhR(i3,i2,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFe2(i3),MFe2(i2),MAh2(i1),dMFe2(i3,iv1)             & 
& ,dMFe2(i2,iv1),dMAh2(i1,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFe2(i3),MFe2(i2),MAh2(i1),dMFe2(i3,iv1)             & 
& ,dMFe2(i2,iv1),dMAh2(i1,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 1
results1(13)=results1(13) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Ah, Fe, bar[Fe]]' 
coeffbar = 0.5_dp
results1(13)=results1(13) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Ah,Fu,bar[Fu] ----
Do i1=1,2
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFuFuAhL(i3,i2,i1)
coup1R = cplcFuFuAhR(i3,i2,i1)
coup2L = cplcFuFuAhL(i2,i3,i1)
coup2R = cplcFuFuAhR(i2,i3,i1)
dcoup1L = dcplcFuFuAhL(i3,i2,i1,iv1)
dcoup1R = dcplcFuFuAhR(i3,i2,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFu2(i2),MAh2(i1),dMFu2(i3,iv1)             & 
& ,dMFu2(i2,iv1),dMAh2(i1,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFu2(i2),MAh2(i1),dMFu2(i3,iv1)             & 
& ,dMFu2(i2,iv1),dMAh2(i1,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 3
results1(14)=results1(14) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Ah, Fu, bar[Fu]]' 
coeffbar = 0.5_dp
results1(14)=results1(14) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Chi,Sd,bar[Fd] ----
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdChiSdL(i3,i1,i2)
coup1R = cplcFdChiSdR(i3,i1,i2)
coup2L = cplChiFdcSdL(i1,i3,i2)
coup2R = cplChiFdcSdR(i1,i3,i2)
dcoup1L = dcplcFdChiSdL(i3,i1,i2,iv1)
dcoup1R = dcplcFdChiSdR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MChi2(i1),MSd2(i2),dMFd2(i3,iv1)            & 
& ,dMChi2(i1,iv1),dMSd2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MChi2(i1),MSd2(i2),dMFd2(i3,iv1)            & 
& ,dMChi2(i1,iv1),dMSd2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(15)=results1(15) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Chi, Sd, bar[Fd]]' 
coeffbar = 1._dp
results1(15)=results1(15) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Chi,Se,bar[Fe] ----
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFeChiSeL(i3,i1,i2)
coup1R = cplcFeChiSeR(i3,i1,i2)
coup2L = cplChiFecSeL(i1,i3,i2)
coup2R = cplChiFecSeR(i1,i3,i2)
dcoup1L = dcplcFeChiSeL(i3,i1,i2,iv1)
dcoup1R = dcplcFeChiSeR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFe2(i3),MChi2(i1),MSe2(i2),dMFe2(i3,iv1)            & 
& ,dMChi2(i1,iv1),dMSe2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFe2(i3),MChi2(i1),MSe2(i2),dMFe2(i3,iv1)            & 
& ,dMChi2(i1,iv1),dMSe2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 1
results1(16)=results1(16) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Chi, Se, bar[Fe]]' 
coeffbar = 1._dp
results1(16)=results1(16) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Chi,Su,bar[Fu] ----
Do i1=1,4
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFuChiSuL(i3,i1,i2)
coup1R = cplcFuChiSuR(i3,i1,i2)
coup2L = cplChiFucSuL(i1,i3,i2)
coup2R = cplChiFucSuR(i1,i3,i2)
dcoup1L = dcplcFuChiSuL(i3,i1,i2,iv1)
dcoup1R = dcplcFuChiSuR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MChi2(i1),MSu2(i2),dMFu2(i3,iv1)            & 
& ,dMChi2(i1,iv1),dMSu2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MChi2(i1),MSu2(i2),dMFu2(i3,iv1)            & 
& ,dMChi2(i1,iv1),dMSu2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(17)=results1(17) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Chi, Su, bar[Fu]]' 
coeffbar = 1._dp
results1(17)=results1(17) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fd,hh,bar[Fd] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFdFdhhL(i3,i1,i2)
coup1R = cplcFdFdhhR(i3,i1,i2)
coup2L = cplcFdFdhhL(i1,i3,i2)
coup2R = cplcFdFdhhR(i1,i3,i2)
dcoup1L = dcplcFdFdhhL(i3,i1,i2,iv1)
dcoup1R = dcplcFdFdhhR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),Mhh2(i2),dMFd2(i3,iv1)             & 
& ,dMFd2(i1,iv1),dMhh2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),Mhh2(i2),dMFd2(i3,iv1)             & 
& ,dMFd2(i1,iv1),dMhh2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 3
results1(18)=results1(18) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fd, hh, bar[Fd]]' 
coeffbar = 0.5_dp
results1(18)=results1(18) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fd,bar[Cha],conj[Su] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,6
coup1L = cplcChaFdcSuL(i2,i1,i3)
coup1R = cplcChaFdcSuR(i2,i1,i3)
coup2L = cplcFdChaSuL(i1,i2,i3)
coup2R = cplcFdChaSuR(i1,i2,i3)
dcoup1L = dcplcChaFdcSuL(i2,i1,i3,iv1)
dcoup1R = dcplcChaFdcSuR(i2,i1,i3,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MCha2(i2),MFd2(i1),MSu2(i3),dMCha2(i2,iv1)           & 
& ,dMFd2(i1,iv1),dMSu2(i3,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MCha2(i2),MFd2(i1),MSu2(i3),dMCha2(i2,iv1)           & 
& ,dMFd2(i1,iv1),dMSu2(i3,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(19)=results1(19) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fd, bar[Cha], conj[Su]]' 
coeffbar = 1._dp
results1(19)=results1(19) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fd,bar[Fd],conj[Sv] ----
Do i1=1,3
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFdFdcSvL(i2,i1,i3)
coup1R = cplcFdFdcSvR(i2,i1,i3)
coup2L = cplcFdFdSvL(i1,i2,i3)
coup2R = cplcFdFdSvR(i1,i2,i3)
dcoup1L = dcplcFdFdcSvL(i2,i1,i3,iv1)
dcoup1R = dcplcFdFdcSvR(i2,i1,i3,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i2),MFd2(i1),MSv2(i3),dMFd2(i2,iv1)             & 
& ,dMFd2(i1,iv1),dMSv2(i3,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i2),MFd2(i1),MSv2(i3),dMFd2(i2,iv1)             & 
& ,dMFd2(i1,iv1),dMSv2(i3,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 3
results1(20)=results1(20) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fd, bar[Fd], conj[Sv]]' 
coeffbar = 0.5_dp
results1(20)=results1(20) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fe,hh,bar[Fe] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFeFehhL(i3,i1,i2)
coup1R = cplcFeFehhR(i3,i1,i2)
coup2L = cplcFeFehhL(i1,i3,i2)
coup2R = cplcFeFehhR(i1,i3,i2)
dcoup1L = dcplcFeFehhL(i3,i1,i2,iv1)
dcoup1R = dcplcFeFehhR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFe2(i3),MFe2(i1),Mhh2(i2),dMFe2(i3,iv1)             & 
& ,dMFe2(i1,iv1),dMhh2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFe2(i3),MFe2(i1),Mhh2(i2),dMFe2(i3,iv1)             & 
& ,dMFe2(i1,iv1),dMhh2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 1
results1(21)=results1(21) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, hh, bar[Fe]]' 
coeffbar = 0.5_dp
results1(21)=results1(21) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fe,Su,bar[Fd] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFeSuL(i3,i1,i2)
coup1R = cplcFdFeSuR(i3,i1,i2)
coup2L = cplcFeFdcSuL(i1,i3,i2)
coup2R = cplcFeFdcSuR(i1,i3,i2)
dcoup1L = dcplcFdFeSuL(i3,i1,i2,iv1)
dcoup1R = dcplcFdFeSuR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFe2(i1),MSu2(i2),dMFd2(i3,iv1)             & 
& ,dMFe2(i1,iv1),dMSu2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFe2(i1),MSu2(i2),dMFd2(i3,iv1)             & 
& ,dMFe2(i1,iv1),dMSu2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(22)=results1(22) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, Su, bar[Fd]]' 
coeffbar = 1._dp
results1(22)=results1(22) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fe,bar[Cha],conj[Sv] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcChaFecSvL(i2,i1,i3)
coup1R = cplcChaFecSvR(i2,i1,i3)
coup2L = cplcFeChaSvL(i1,i2,i3)
coup2R = cplcFeChaSvR(i1,i2,i3)
dcoup1L = dcplcChaFecSvL(i2,i1,i3,iv1)
dcoup1R = dcplcChaFecSvR(i2,i1,i3,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MCha2(i2),MFe2(i1),MSv2(i3),dMCha2(i2,iv1)           & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MCha2(i2),MFe2(i1),MSv2(i3),dMCha2(i2,iv1)           & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 1
results1(23)=results1(23) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, bar[Cha], conj[Sv]]' 
coeffbar = 1._dp
results1(23)=results1(23) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fe,bar[Fe],conj[Sv] ----
Do i1=1,3
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFeFecSvL(i2,i1,i3)
coup1R = cplcFeFecSvR(i2,i1,i3)
coup2L = cplcFeFeSvL(i1,i2,i3)
coup2R = cplcFeFeSvR(i1,i2,i3)
dcoup1L = dcplcFeFecSvL(i2,i1,i3,iv1)
dcoup1R = dcplcFeFecSvR(i2,i1,i3,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFe2(i2),MFe2(i1),MSv2(i3),dMFe2(i2,iv1)             & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFe2(i2),MFe2(i1),MSv2(i3),dMFe2(i2,iv1)             & 
& ,dMFe2(i1,iv1),dMSv2(i3,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 1
results1(24)=results1(24) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fe, bar[Fe], conj[Sv]]' 
coeffbar = 0.5_dp
results1(24)=results1(24) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fu,hh,bar[Fu] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFuFuhhL(i3,i1,i2)
coup1R = cplcFuFuhhR(i3,i1,i2)
coup2L = cplcFuFuhhL(i1,i3,i2)
coup2R = cplcFuFuhhR(i1,i3,i2)
dcoup1L = dcplcFuFuhhL(i3,i1,i2,iv1)
dcoup1R = dcplcFuFuhhR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),Mhh2(i2),dMFu2(i3,iv1)             & 
& ,dMFu2(i1,iv1),dMhh2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),Mhh2(i2),dMFu2(i3,iv1)             & 
& ,dMFu2(i1,iv1),dMhh2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 0.5_dp
colorfactor = 3
results1(25)=results1(25) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fu, hh, bar[Fu]]' 
coeffbar = 0.5_dp
results1(25)=results1(25) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fu,Hpm,bar[Fd] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFdFuHpmL(i3,i1,i2)
coup1R = cplcFdFuHpmR(i3,i1,i2)
coup2L = cplcFuFdcHpmL(i1,i3,i2)
coup2R = cplcFuFdcHpmR(i1,i3,i2)
dcoup1L = dcplcFdFuHpmL(i3,i1,i2,iv1)
dcoup1R = dcplcFdFuHpmR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MHpm2(i2),dMFd2(i3,iv1)            & 
& ,dMFu2(i1,iv1),dMHpm2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MHpm2(i2),dMFd2(i3,iv1)            & 
& ,dMFu2(i1,iv1),dMHpm2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(26)=results1(26) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fu, Hpm, bar[Fd]]' 
coeffbar = 1._dp
results1(26)=results1(26) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fu,Se,bar[Fd] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFuSeL(i3,i1,i2)
coup1R = cplcFdFuSeR(i3,i1,i2)
coup2L = cplcFuFdcSeL(i1,i3,i2)
coup2R = cplcFuFdcSeR(i1,i3,i2)
dcoup1L = dcplcFdFuSeL(i3,i1,i2,iv1)
dcoup1R = dcplcFdFuSeR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MSe2(i2),dMFd2(i3,iv1)             & 
& ,dMFu2(i1,iv1),dMSe2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFu2(i1),MSe2(i2),dMFd2(i3,iv1)             & 
& ,dMFu2(i1,iv1),dMSe2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(27)=results1(27) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fu, Se, bar[Fd]]' 
coeffbar = 1._dp
results1(27)=results1(27) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fv,Hpm,bar[Fe] ----
Do i1=1,3
 Do i2=1,2
    Do i3=1,3
coup1L = cplcFeFvHpmL(i3,i1,i2)
coup1R = cplcFeFvHpmR(i3,i1,i2)
coup2L = cplFvFecHpmL(i1,i3,i2)
coup2R = cplFvFecHpmR(i1,i3,i2)
dcoup1L = dcplcFeFvHpmL(i3,i1,i2,iv1)
dcoup1R = dcplcFeFvHpmR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFe2(i3),0._dp,MHpm2(i2),dMFe2(i3,iv1)               & 
& ,ZeroC,dMHpm2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFe2(i3),0._dp,MHpm2(i2),dMFe2(i3,iv1)               & 
& ,ZeroC,dMHpm2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 1
results1(28)=results1(28) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Hpm, bar[Fe]]' 
coeffbar = 1._dp
results1(28)=results1(28) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fv,Sd,bar[Fd] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdFvSdL(i3,i1,i2)
coup1R = cplcFdFvSdR(i3,i1,i2)
coup2L = cplFvFdcSdL(i1,i3,i2)
coup2R = cplFvFdcSdR(i1,i3,i2)
dcoup1L = dcplcFdFvSdL(i3,i1,i2,iv1)
dcoup1R = dcplcFdFvSdR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),0._dp,MSd2(i2),dMFd2(i3,iv1),ZeroC,dMSd2(i2,iv1)& 
& ,coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),0._dp,MSd2(i2),dMFd2(i3,iv1),ZeroC,dMSd2(i2,iv1)& 
& ,coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(29)=results1(29) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Sd, bar[Fd]]' 
coeffbar = 1._dp
results1(29)=results1(29) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fv,Se,bar[Cha] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,2
coup1L = cplcChaFvSeL(i3,i1,i2)
coup1R = cplcChaFvSeR(i3,i1,i2)
coup2L = cplFvChacSeL(i1,i3,i2)
coup2R = cplFvChacSeR(i1,i3,i2)
dcoup1L = dcplcChaFvSeL(i3,i1,i2,iv1)
dcoup1R = dcplcChaFvSeR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MCha2(i3),0._dp,MSe2(i2),dMCha2(i3,iv1)              & 
& ,ZeroC,dMSe2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MCha2(i3),0._dp,MSe2(i2),dMCha2(i3,iv1)              & 
& ,ZeroC,dMSe2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 1
results1(30)=results1(30) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Se, bar[Cha]]' 
coeffbar = 1._dp
results1(30)=results1(30) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Fv,Se,bar[Fe] ----
Do i1=1,3
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFeFvSeL(i3,i1,i2)
coup1R = cplcFeFvSeR(i3,i1,i2)
coup2L = cplFvFecSeL(i1,i3,i2)
coup2R = cplFvFecSeR(i1,i3,i2)
dcoup1L = dcplcFeFvSeL(i3,i1,i2,iv1)
dcoup1R = dcplcFeFvSeR(i3,i1,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFe2(i3),0._dp,MSe2(i2),dMFe2(i3,iv1),ZeroC,dMSe2(i2,iv1)& 
& ,coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFe2(i3),0._dp,MSe2(i2),dMFe2(i3,iv1),ZeroC,dMSe2(i2,iv1)& 
& ,coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 1
results1(31)=results1(31) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Fv, Se, bar[Fe]]' 
coeffbar = 1._dp
results1(31)=results1(31) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Glu,Sd,bar[Fd] ----
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFdGluSdL(i3,i2)
coup1R = cplcFdGluSdR(i3,i2)
coup2L = cplGluFdcSdL(i3,i2)
coup2R = cplGluFdcSdR(i3,i2)
dcoup1L = dcplcFdGluSdL(i3,i2,iv1)
dcoup1R = dcplcFdGluSdR(i3,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MGlu2,MSd2(i2),dMFd2(i3,iv1),dMGlu2(1,iv1)  & 
& ,dMSd2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MGlu2,MSd2(i2),dMFd2(i3,iv1),dMGlu2(1,iv1)  & 
& ,dMSd2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 4
results1(32)=results1(32) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Glu, Sd, bar[Fd]]' 
coeffbar = 1._dp
results1(32)=results1(32) + coeffbar*colorfactor*tempbar
    End Do
  End Do
! ---- Glu,Su,bar[Fu] ----
 Do i2=1,6
    Do i3=1,3
coup1L = cplcFuGluSuL(i3,i2)
coup1R = cplcFuGluSuR(i3,i2)
coup2L = cplGluFucSuL(i3,i2)
coup2R = cplGluFucSuR(i3,i2)
dcoup1L = dcplcFuGluSuL(i3,i2,iv1)
dcoup1R = dcplcFuGluSuR(i3,i2,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MGlu2,MSu2(i2),dMFu2(i3,iv1),dMGlu2(1,iv1)  & 
& ,dMSu2(i2,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MGlu2,MSu2(i2),dMFu2(i3,iv1),dMGlu2(1,iv1)  & 
& ,dMSu2(i2,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 4
results1(33)=results1(33) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Glu, Su, bar[Fu]]' 
coeffbar = 1._dp
results1(33)=results1(33) + coeffbar*colorfactor*tempbar
    End Do
  End Do
! ---- Sd,bar[Cha],bar[Fu] ----
Do i1=1,6
 Do i2=1,2
    Do i3=1,3
coup1L = cplcChacFuSdL(i2,i3,i1)
coup1R = cplcChacFuSdR(i2,i3,i1)
coup2L = cplChaFucSdL(i2,i3,i1)
coup2R = cplChaFucSdR(i2,i3,i1)
dcoup1L = dcplcChacFuSdL(i2,i3,i1,iv1)
dcoup1R = dcplcChacFuSdR(i2,i3,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MCha2(i2),MSd2(i1),dMFu2(i3,iv1)            & 
& ,dMCha2(i2,iv1),dMSd2(i1,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MCha2(i2),MSd2(i1),dMFu2(i3,iv1)            & 
& ,dMCha2(i2,iv1),dMSd2(i1,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(34)=results1(34) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Sd, bar[Cha], bar[Fu]]' 
coeffbar = 1._dp
results1(34)=results1(34) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ---- Sd,bar[Fe],bar[Fu] ----
Do i1=1,6
 Do i2=1,3
    Do i3=1,3
coup1L = cplcFecFuSdL(i2,i3,i1)
coup1R = cplcFecFuSdR(i2,i3,i1)
coup2L = cplFeFucSdL(i2,i3,i1)
coup2R = cplFeFucSdR(i2,i3,i1)
dcoup1L = dcplcFecFuSdL(i2,i3,i1,iv1)
dcoup1R = dcplcFecFuSdR(i2,i3,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFe2(i2),MSd2(i1),dMFu2(i3,iv1)             & 
& ,dMFe2(i2,iv1),dMSd2(i1,iv1),coupx,dcoupx,'FFS   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFe2(i2),MSd2(i1),dMFu2(i3,iv1)             & 
& ,dMFe2(i2,iv1),dMSd2(i1,iv1),coupxbar,dcoupxbar,'FFSbar',Q2,tempbar)
coeff = 1._dp
colorfactor = 3
results1(35)=results1(35) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFS C[Sd, bar[Fe], bar[Fu]]' 
coeffbar = 1._dp
results1(35)=results1(35) + coeffbar*colorfactor*tempbar
    End Do
  End Do
End Do
! ----- diagrams of type SSV, 2 ------ 
! ---- Sd,VG,conj[Sd] ----
Do i1=1,6
    Do i3=1,6
coup1 = cplSdcSdVG(i1,i3)
coup2 = cplSdcSdVG(i3,i1)
dcoup1 = dcplSdcSdVG(i1,i3,iv1)
coupx=abs(coup1)**2
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSd2(i3),MSd2(i1),0._dp,dMSd2(i3,iv1),dMSd2(i1,iv1)  & 
& ,ZeroC,coupx,dcoupx,'SSV   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 4
results1(36)=results1(36) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSV C[Sd, VG, conj[Sd]]' 
    End Do
End Do
! ---- Su,VG,conj[Su] ----
Do i1=1,6
    Do i3=1,6
coup1 = cplSucSuVG(i1,i3)
coup2 = cplSucSuVG(i3,i1)
dcoup1 = dcplSucSuVG(i1,i3,iv1)
coupx=abs(coup1)**2
dcoupx=dcoup1*conjg(coup1)+coup1*conjg(dcoup1) 
Call FirstDerivativeVeff_sunrise(MSu2(i3),MSu2(i1),0._dp,dMSu2(i3,iv1),dMSu2(i1,iv1)  & 
& ,ZeroC,coupx,dcoupx,'SSV   ',Q2,temp)
coeff = 0.5_dp
colorfactor = 4
results1(37)=results1(37) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SSV C[Su, VG, conj[Su]]' 
    End Do
End Do
! ----- diagrams of type FFV, 3 ------ 
! ---- Fd,VG,bar[Fd] ----
Do i1=1,3
    Do i3=1,3
coup1L = cplcFdFdVGL(i3,i1)
coup1R = cplcFdFdVGR(i3,i1)
coup2L = cplcFdFdVGL(i1,i3)
coup2R = cplcFdFdVGR(i1,i3)
dcoup1L = dcplcFdFdVGL(i3,i1,iv1)
dcoup1R = dcplcFdFdVGR(i3,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=-2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=-2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),0._dp,dMFd2(i3,iv1),dMFd2(i1,iv1)  & 
& ,ZeroC,coupx,dcoupx,'FFV   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFd2(i3),MFd2(i1),0._dp,dMFd2(i3,iv1),dMFd2(i1,iv1)  & 
& ,ZeroC,coupxbar,dcoupxbar,'FFVbar',Q2,temp)
coeff = 0.5_dp
colorfactor = 4
results1(38)=results1(38) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFV C[Fd, VG, bar[Fd]]' 
coeffbar = 0.5_dp
results1(38)=results1(38) + coeffbar*colorfactor*tempbar
    End Do
End Do
! ---- Fu,VG,bar[Fu] ----
Do i1=1,3
    Do i3=1,3
coup1L = cplcFuFuVGL(i3,i1)
coup1R = cplcFuFuVGR(i3,i1)
coup2L = cplcFuFuVGL(i1,i3)
coup2R = cplcFuFuVGR(i1,i3)
dcoup1L = dcplcFuFuVGL(i3,i1,iv1)
dcoup1R = dcplcFuFuVGR(i3,i1,iv1)
coupx=(abs(coup1L)**2+abs(coup1R)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L)+dcoup1R*conjg(coup1R)+coup1R*conjg(dcoup1R) 
coupxbar=-2*Real(coup1L*conjg(coup1R),dp) 
dcoupxbar=-2*Real(dcoup1L*conjg(coup1R)+coup1L*conjg(dcoup1R),dp) 
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),0._dp,dMFu2(i3,iv1),dMFu2(i1,iv1)  & 
& ,ZeroC,coupx,dcoupx,'FFV   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MFu2(i3),MFu2(i1),0._dp,dMFu2(i3,iv1),dMFu2(i1,iv1)  & 
& ,ZeroC,coupxbar,dcoupxbar,'FFVbar',Q2,temp)
coeff = 0.5_dp
colorfactor = 4
results1(39)=results1(39) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFV C[Fu, VG, bar[Fu]]' 
coeffbar = 0.5_dp
results1(39)=results1(39) + coeffbar*colorfactor*tempbar
    End Do
End Do
! ---- Glu,Glu,VG ----
coup1L = cplGluGluVGL
coup1R = cplGluGluVGR
coup2L = cplGluGluVGL
coup2R = cplGluGluVGR
dcoup1L = dcplGluGluVGL(iv1)
dcoup1R = dcplGluGluVGR(iv1)
coupx=(abs(coup1L)**2) 
dcoupx=dcoup1L*conjg(coup1L)+coup1L*conjg(dcoup1L) 
coupxbar=Real(coup1L**2,dp) 
dcoupxbar=Real(2*dcoup1L*coup1L,dp) 
Call FirstDerivativeVeff_sunrise(MGlu2,MGlu2,0._dp,dMGlu2(1,iv1),dMGlu2(1,iv1)        & 
& ,ZeroC,coupx,dcoupx,'FFV   ',Q2,temp)
Call FirstDerivativeVeff_sunrise(MGlu2,MGlu2,0._dp,dMGlu2(1,iv1),dMGlu2(1,iv1)        & 
& ,ZeroC,coupxbar,dcoupxbar,'FFVbar',Q2,temp)
coeff = 0.5_dp
colorfactor = 24
results1(40)=results1(40) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at FFV C[Glu, Glu, VG]' 
coeffbar = 0.5_dp
results1(40)=results1(40) + coeffbar*colorfactor*tempbar
! ----- diagrams of type VVV, 1 ------ 
! ---- VG,VG,VG ----
coup1 = cplVGVGVG
coup2 = cplVGVGVG
dcoup1 = dcplVGVGVG(iv1)
coeff = 0.0000
colorfactor = 24
results1(41)=results1(41) + coeff*colorfactor*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at VVV C[VG, VG, VG]' 
! ----- Topology2: diagrams w. 2 Particles and 1 Vertex

! ----- diagrams of type SS, 18 ------ 
! ---- Ah,Sd ----
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSdcSd(i1,i1,i2,i2)
dcoup1 = dcplAhAhSdcSd(i1,i1,i2,i2,iv1)
Call FirstDerivativeVeff_balls(MAh2(i1),MSd2(i2),dMAh2(i1,iv1),dMSd2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(1)=results2(1) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Ah, Ah, Sd, conj[Sd]]' 
  End Do
End Do
! ---- Ah,Se ----
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSecSe(i1,i1,i2,i2)
dcoup1 = dcplAhAhSecSe(i1,i1,i2,i2,iv1)
Call FirstDerivativeVeff_balls(MAh2(i1),MSe2(i2),dMAh2(i1,iv1),dMSe2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(2)=results2(2) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Ah, Ah, Se, conj[Se]]' 
  End Do
End Do
! ---- Ah,Su ----
Do i1=1,2
 Do i2=1,6
coup1 = cplAhAhSucSu(i1,i1,i2,i2)
dcoup1 = dcplAhAhSucSu(i1,i1,i2,i2,iv1)
Call FirstDerivativeVeff_balls(MAh2(i1),MSu2(i2),dMAh2(i1,iv1),dMSu2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(3)=results2(3) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Ah, Ah, Su, conj[Su]]' 
  End Do
End Do
! ---- hh,Sd ----
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSdcSd(i1,i1,i2,i2)
dcoup1 = dcplhhhhSdcSd(i1,i1,i2,i2,iv1)
Call FirstDerivativeVeff_balls(Mhh2(i1),MSd2(i2),dMhh2(i1,iv1),dMSd2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(4)=results2(4) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[hh, hh, Sd, conj[Sd]]' 
  End Do
End Do
! ---- hh,Se ----
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSecSe(i1,i1,i2,i2)
dcoup1 = dcplhhhhSecSe(i1,i1,i2,i2,iv1)
Call FirstDerivativeVeff_balls(Mhh2(i1),MSe2(i2),dMhh2(i1,iv1),dMSe2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(5)=results2(5) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[hh, hh, Se, conj[Se]]' 
  End Do
End Do
! ---- hh,Su ----
Do i1=1,2
 Do i2=1,6
coup1 = cplhhhhSucSu(i1,i1,i2,i2)
dcoup1 = dcplhhhhSucSu(i1,i1,i2,i2,iv1)
Call FirstDerivativeVeff_balls(Mhh2(i1),MSu2(i2),dMhh2(i1,iv1),dMSu2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(6)=results2(6) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[hh, hh, Su, conj[Su]]' 
  End Do
End Do
! ---- Hpm,Sd ----
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSdcHpmcSd(i1,i2,i1,i2)
dcoup1 = dcplHpmSdcHpmcSd(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MHpm2(i1),MSd2(i2),dMHpm2(i1,iv1),dMSd2(i2,iv1)        & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(7)=results2(7) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Sd, conj[Hpm], conj[Sd]]' 
  End Do
End Do
! ---- Hpm,Se ----
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSecHpmcSe(i1,i2,i1,i2)
dcoup1 = dcplHpmSecHpmcSe(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MHpm2(i1),MSe2(i2),dMHpm2(i1,iv1),dMSe2(i2,iv1)        & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(8)=results2(8) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Se, conj[Hpm], conj[Se]]' 
  End Do
End Do
! ---- Hpm,Su ----
Do i1=1,2
 Do i2=1,6
coup1 = cplHpmSucHpmcSu(i1,i2,i1,i2)
dcoup1 = dcplHpmSucHpmcSu(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MHpm2(i1),MSu2(i2),dMHpm2(i1,iv1),dMSu2(i2,iv1)        & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(9)=results2(9) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Su, conj[Hpm], conj[Su]]' 
  End Do
End Do
! ---- Hpm,Sv ----
Do i1=1,2
 Do i2=1,3
coup1 = cplHpmSvcHpmcSv(i1,i2,i1,i2)
dcoup1 = dcplHpmSvcHpmcSv(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MHpm2(i1),MSv2(i2),dMHpm2(i1,iv1),dMSv2(i2,iv1)        & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(10)=results2(10) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Hpm, Sv, conj[Hpm], conj[Sv]]' 
  End Do
End Do
! ---- Sd,Sd ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSdcSdcSd(i1,i2,i1,i2)
dcoup1 = dcplSdSdcSdcSd(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSd2(i1),MSd2(i2),dMSd2(i1,iv1),dMSd2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(11)=results2(11) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Sd, conj[Sd], conj[Sd]]' 
  End Do
End Do
! ---- Sd,Se ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSecSdcSe(i1,i2,i1,i2)
dcoup1 = dcplSdSecSdcSe(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSd2(i1),MSe2(i2),dMSd2(i1,iv1),dMSe2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(12)=results2(12) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Se, conj[Sd], conj[Se]]' 
  End Do
End Do
! ---- Sd,Su ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSdSucSdcSu(i1,i2,i1,i2)
dcoup1 = dcplSdSucSdcSu(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSd2(i1),MSu2(i2),dMSd2(i1,iv1),dMSu2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(13)=results2(13) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Su, conj[Sd], conj[Su]]' 
  End Do
End Do
! ---- Sd,Sv ----
Do i1=1,6
 Do i2=1,3
coup1 = cplSdSvcSdcSv(i1,i2,i1,i2)
dcoup1 = dcplSdSvcSdcSv(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSd2(i1),MSv2(i2),dMSd2(i1,iv1),dMSv2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(14)=results2(14) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Sd, Sv, conj[Sd], conj[Sv]]' 
  End Do
End Do
! ---- Se,Se ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSeSecSecSe(i1,i2,i1,i2)
dcoup1 = dcplSeSecSecSe(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSe2(i1),MSe2(i2),dMSe2(i1,iv1),dMSe2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(15)=results2(15) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Se, Se, conj[Se], conj[Se]]' 
  End Do
End Do
! ---- Se,Su ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSeSucSecSu(i1,i2,i1,i2)
dcoup1 = dcplSeSucSecSu(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSe2(i1),MSu2(i2),dMSe2(i1,iv1),dMSu2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(16)=results2(16) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Se, Su, conj[Se], conj[Su]]' 
  End Do
End Do
! ---- Se,Sv ----
Do i1=1,6
 Do i2=1,3
coup1 = cplSeSvcSecSv(i1,i2,i1,i2)
dcoup1 = dcplSeSvcSecSv(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSe2(i1),MSv2(i2),dMSe2(i1,iv1),dMSv2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-1._dp)
results2(17)=results2(17) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Se, Sv, conj[Se], conj[Sv]]' 
  End Do
End Do
! ---- Su,Su ----
Do i1=1,6
 Do i2=1,6
coup1 = cplSuSucSucSu(i1,i2,i1,i2)
dcoup1 = dcplSuSucSucSu(i1,i2,i1,i2,iv1)
Call FirstDerivativeVeff_balls(MSu2(i1),MSu2(i2),dMSu2(i1,iv1),dMSu2(i2,iv1)          & 
& ,coup1,dcoup1,'SS',Q2,temp)
coeff = (-0.5_dp)
results2(18)=results2(18) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at SS C[Su, Su, conj[Su], conj[Su]]' 
  End Do
End Do
! ----- diagrams of type VS, 2 ------ 
! ---- Sd,VG ----
Do i1=1,6
coup1 = cplSdcSdVGVG(i1,i1)
dcoup1 = dcplSdcSdVGVG(i1,i1,iv1)
Call FirstDerivativeVeff_balls(0._dp,MSd2(i1),ZeroC,dMSd2(i1,iv1),coup1,dcoup1,'VS',Q2,temp)
coeff = 0._dp
results2(19)=results2(19) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at VS C[Sd, VG, VG, conj[Sd]]' 
End Do
! ---- Su,VG ----
Do i1=1,6
coup1 = cplSucSuVGVG(i1,i1)
dcoup1 = dcplSucSuVGVG(i1,i1,iv1)
Call FirstDerivativeVeff_balls(0._dp,MSu2(i1),ZeroC,dMSu2(i1,iv1),coup1,dcoup1,'VS',Q2,temp)
coeff = 0._dp
results2(20)=results2(20) + coeff*temp
if (.not.(temp.eq.temp))  write(*,*) 'NaN at VS C[Su, VG, VG, conj[Su]]' 
End Do
result = sum(results1)+sum(results2) 


 
ti2L(iv1) = oo16pi2**2 * Real(result,dp) 
End Do 
End Subroutine FirstDerivativeEffPot2Loop 


Subroutine SecondDerivativeMassesCoups(i1,i2,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,              & 
& Yu,Mu,Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Real(dp), Intent(out) :: gout(:) 
Real(dp) :: err, vevs(2) 
Integer :: iout 
Integer, Intent(in) :: i1,i2 
vevs = (/vd,vu/) 
gout = partialDiffXY_RiddersMulDim(AllMassesCouplings,29328,vevs,i1,i2,2,err) 
If (err.gt.err2L) err2L = err 
End Subroutine SecondDerivativeMassesCoups

Subroutine FirstDerivativeMassesCoups(i1,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,               & 
& Mu,Td,Te,T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Real(dp), Intent(out) :: gout(:) 
Real(dp) :: err, vevs(2) 
Integer :: iout 
Integer, Intent(in) :: i1 
vevs = (/vd,vu/) 
gout = partialDiff_RiddersMulDim(AllMassesCouplings,29328,vevs,i1,2,err) 
If (err.gt.err2L) err2L = err 
End Subroutine FirstDerivativeMassesCoups

Subroutine AllMassesCouplings(vevs,gout) 
Implicit None 
Real(dp), Intent(out) :: gout(29328) 
Real(dp), Intent(in) :: vevs(2) 
Integer :: kont 
Real(dp) :: vd,vu

Complex(dp) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

Real(dp) :: MAh(2),MAh2(2),MCha(2),MCha2(2),MChi(4),MChi2(4),MFd(3),MFd2(3),MFe(3),               & 
& MFe2(3),MFu(3),MFu2(3),MGlu,MGlu2,Mhh(2),Mhh2(2),MHpm(2),MHpm2(2),MSd(6),              & 
& MSd2(6),MSe(6),MSe2(6),MSu(6),MSu2(6),MSv(3),MSv2(3),MVWm,MVWm2,MVZ,MVZ2,              & 
& TW,v,ZA(2,2),ZH(2,2),ZP(2,2),ZZ(2,2),alphaH,betaH

Complex(dp) :: pG,UM(2,2),UP(2,2),ZD(6,6),ZDL(3,3),ZDR(3,3),ZE(6,6),ZEL(3,3),ZER(3,3),               & 
& ZN(4,4),ZU(6,6),ZUL(3,3),ZUR(3,3),ZV(3,3),ZW(2,2)

vd=vevs(1) 
vu=vevs(2) 
Call WrapperForDerivatives(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,              & 
& Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

End Subroutine 

Subroutine WrapperForDerivatives(vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,              & 
& T1,T2,Tu,Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,gout)

Implicit None 
Real(dp),Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Real(dp),Intent(in) :: vd,vu

Real(dp), Intent(out) :: gout(:) 
Integer :: kont 
Real(dp) :: MSd(6),MSd2(6),MSv(3),MSv2(3),MSu(6),MSu2(6),MSe(6),MSe2(6),Mhh(2),Mhh2(2),           & 
& MAh(2),MAh2(2),MHpm(2),MHpm2(2),MChi(4),MChi2(4),MCha(2),MCha2(2),MFe(3),              & 
& MFe2(3),MFd(3),MFd2(3),MFu(3),MFu2(3),MGlu,MGlu2,MVZ,MVZ2,MVWm,MVWm2

Complex(dp) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

Call TreeMassesEffPot(MAh,MAh2,MCha,MCha2,MChi,MChi2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MGlu,MGlu2,Mhh,Mhh2,MHpm,MHpm2,MSd,MSd2,MSe,MSe2,MSu,MSu2,MSv,MSv2,           & 
& MVWm,MVWm2,MVZ,MVZ2,pG,TW,UM,UP,v,ZA,ZD,ZDL,ZDR,ZE,ZEL,ZER,ZH,ZN,ZP,ZU,ZUL,            & 
& ZUR,ZV,ZW,ZZ,alphaH,betaH,vd,vu,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,             & 
& Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,.True.,kont)

Call CouplingsForEffPot3(Mu,Yd,Td,ZD,ZA,Ye,Te,ZE,Yu,Tu,ZU,vd,ZH,vu,ZP,ZV,             & 
& L2,T2,L1,T1,g3,ZDL,ZDR,ZEL,ZER,ZUL,ZUR,UM,UP,ZN,pG,cplAhSdcSd,cplAhSecSe,              & 
& cplAhSucSu,cplhhSdcSd,cplhhSecSe,cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,        & 
& cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,               & 
& cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,       & 
& cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,            & 
& cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,         & 
& cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,         & 
& cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,          & 
& cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,             & 
& cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,        & 
& cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,        & 
& cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,             & 
& cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,             & 
& cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,         & 
& cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,            & 
& cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,            & 
& cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,         & 
& cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,           & 
& cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR)

Call CouplingsForEffPot4(Yd,ZD,ZA,Ye,ZE,Yu,ZU,ZH,ZP,ZV,g3,L2,L1,cplAhAhSdcSd,         & 
& cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,cplHpmSdcHpmcSd,      & 
& cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,cplSdSecSdcSe,           & 
& cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,cplSuSucSucSu,   & 
& cplSdcSdVGVG,cplSucSuVGVG)

Call MassesCoupsToG(MSd,MSd2,MSv,MSv2,MSu,MSu2,MSe,MSe2,Mhh,Mhh2,MAh,MAh2,            & 
& MHpm,MHpm2,MChi,MChi2,MCha,MCha2,MFe,MFe2,MFd,MFd2,MFu,MFu2,MGlu,MGlu2,MVZ,            & 
& MVZ2,MVWm,MVWm2,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplhhSdcSd,cplhhSecSe,cplhhSucSu,     & 
& cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,               & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,             & 
& cplAhAhSdcSd,cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,         & 
& cplHpmSdcHpmcSd,cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,         & 
& cplSdSecSdcSe,cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,   & 
& cplSuSucSucSu,cplSdcSdVGVG,cplSucSuVGVG,gout)

End Subroutine WrapperForDerivatives

Subroutine MassesCoupsToG(MSd,MSd2,MSv,MSv2,MSu,MSu2,MSe,MSe2,Mhh,Mhh2,               & 
& MAh,MAh2,MHpm,MHpm2,MChi,MChi2,MCha,MCha2,MFe,MFe2,MFd,MFd2,MFu,MFu2,MGlu,             & 
& MGlu2,MVZ,MVZ2,MVWm,MVWm2,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplhhSdcSd,cplhhSecSe,      & 
& cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,    & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,             & 
& cplAhAhSdcSd,cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,         & 
& cplHpmSdcHpmcSd,cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,         & 
& cplSdSecSdcSe,cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,   & 
& cplSuSucSucSu,cplSdcSdVGVG,cplSucSuVGVG,g)

Implicit None 
Real(dp), Intent(out) :: g(:) 
Integer :: i1,i2,i3,i4, sumI
Real(dp),Intent(in) :: MSd(6),MSd2(6),MSv(3),MSv2(3),MSu(6),MSu2(6),MSe(6),MSe2(6),Mhh(2),Mhh2(2),           & 
& MAh(2),MAh2(2),MHpm(2),MHpm2(2),MChi(4),MChi2(4),MCha(2),MCha2(2),MFe(3),              & 
& MFe2(3),MFd(3),MFd2(3),MFu(3),MFu2(3),MGlu,MGlu2,MVZ,MVZ2,MVWm,MVWm2

Complex(dp),Intent(in) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp),Intent(in) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

g(1:6) = MSd
g(7:12) = MSd2
g(13:15) = MSv
g(16:18) = MSv2
g(19:24) = MSu
g(25:30) = MSu2
g(31:36) = MSe
g(37:42) = MSe2
g(43:44) = Mhh
g(45:46) = Mhh2
g(47:48) = MAh
g(49:50) = MAh2
g(51:52) = MHpm
g(53:54) = MHpm2
g(55:58) = MChi
g(59:62) = MChi2
g(63:64) = MCha
g(65:66) = MCha2
g(67:69) = MFe
g(70:72) = MFe2
g(73:75) = MFd
g(76:78) = MFd2
g(79:81) = MFu
g(82:84) = MFu2
g(85) = MGlu
g(86) = MGlu2
g(87) = MVZ
g(88) = MVZ2
g(89) = MVWm
g(90) = MVWm2
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+91) = Real(cplAhSdcSd(i1,i2,i3), dp) 
g(SumI+92) = Aimag(cplAhSdcSd(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+235) = Real(cplAhSecSe(i1,i2,i3), dp) 
g(SumI+236) = Aimag(cplAhSecSe(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+379) = Real(cplAhSucSu(i1,i2,i3), dp) 
g(SumI+380) = Aimag(cplAhSucSu(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+523) = Real(cplhhSdcSd(i1,i2,i3), dp) 
g(SumI+524) = Aimag(cplhhSdcSd(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+667) = Real(cplhhSecSe(i1,i2,i3), dp) 
g(SumI+668) = Aimag(cplhhSecSe(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+811) = Real(cplhhSucSu(i1,i2,i3), dp) 
g(SumI+812) = Aimag(cplhhSucSu(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+955) = Real(cplHpmSucSd(i1,i2,i3), dp) 
g(SumI+956) = Aimag(cplHpmSucSd(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+1099) = Real(cplHpmSvcSe(i1,i2,i3), dp) 
g(SumI+1100) = Aimag(cplHpmSvcSe(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+1171) = Real(cplSdSvcSd(i1,i2,i3), dp) 
g(SumI+1172) = Aimag(cplSdSvcSd(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
g(SumI+1387) = Real(cplSdcHpmcSu(i1,i2,i3), dp) 
g(SumI+1388) = Aimag(cplSdcHpmcSu(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*18
SumI = SumI*2 
g(SumI+1531) = Real(cplSdcSdcSv(i1,i2,i3), dp) 
g(SumI+1532) = Aimag(cplSdcSdcSv(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+1747) = Real(cplSdcSecSu(i1,i2,i3), dp) 
g(SumI+1748) = Aimag(cplSdcSecSu(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
g(SumI+2179) = Real(cplSeSucSd(i1,i2,i3), dp) 
g(SumI+2180) = Aimag(cplSeSucSd(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+2611) = Real(cplSeSvcSe(i1,i2,i3), dp) 
g(SumI+2612) = Aimag(cplSeSvcSe(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,2
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*6
SumI = SumI*2 
g(SumI+2827) = Real(cplSecHpmcSv(i1,i2,i3), dp) 
g(SumI+2828) = Aimag(cplSecHpmcSv(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*18
SumI = SumI*2 
g(SumI+2899) = Real(cplSecSecSv(i1,i2,i3), dp) 
g(SumI+2900) = Aimag(cplSecSecSv(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+3115) = Real(cplSdcSdVG(i1,i2), dp) 
g(SumI+3116) = Aimag(cplSdcSdVG(i1,i2)) 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+3187) = Real(cplSucSuVG(i1,i2), dp) 
g(SumI+3188) = Aimag(cplSucSuVG(i1,i2)) 
End Do 
End Do 

g(3259) = Real(cplVGVGVG,dp)  
g(3260) = Aimag(cplVGVGVG)  
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+3261) = Real(cplcFdFdAhL(i1,i2,i3), dp) 
g(SumI+3262) = Aimag(cplcFdFdAhL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+3297) = Real(cplcFdFdAhR(i1,i2,i3), dp) 
g(SumI+3298) = Aimag(cplcFdFdAhR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+3333) = Real(cplcFeFeAhL(i1,i2,i3), dp) 
g(SumI+3334) = Aimag(cplcFeFeAhL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+3369) = Real(cplcFeFeAhR(i1,i2,i3), dp) 
g(SumI+3370) = Aimag(cplcFeFeAhR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+3405) = Real(cplcFuFuAhL(i1,i2,i3), dp) 
g(SumI+3406) = Aimag(cplcFuFuAhL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+3441) = Real(cplcFuFuAhR(i1,i2,i3), dp) 
g(SumI+3442) = Aimag(cplcFuFuAhR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+3477) = Real(cplChaFucSdL(i1,i2,i3), dp) 
g(SumI+3478) = Aimag(cplChaFucSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+3549) = Real(cplChaFucSdR(i1,i2,i3), dp) 
g(SumI+3550) = Aimag(cplChaFucSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
g(SumI+3621) = Real(cplFvChacSeL(i1,i2,i3), dp) 
g(SumI+3622) = Aimag(cplFvChacSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
g(SumI+3693) = Real(cplFvChacSeR(i1,i2,i3), dp) 
g(SumI+3694) = Aimag(cplFvChacSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
g(SumI+3765) = Real(cplcFdChaSuL(i1,i2,i3), dp) 
g(SumI+3766) = Aimag(cplcFdChaSuL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
g(SumI+3837) = Real(cplcFdChaSuR(i1,i2,i3), dp) 
g(SumI+3838) = Aimag(cplcFdChaSuR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*6
SumI = SumI*2 
g(SumI+3909) = Real(cplcFeChaSvL(i1,i2,i3), dp) 
g(SumI+3910) = Aimag(cplcFeChaSvL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*6
SumI = SumI*2 
g(SumI+3945) = Real(cplcFeChaSvR(i1,i2,i3), dp) 
g(SumI+3946) = Aimag(cplcFeChaSvR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+3981) = Real(cplChiFdcSdL(i1,i2,i3), dp) 
g(SumI+3982) = Aimag(cplChiFdcSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+4125) = Real(cplChiFdcSdR(i1,i2,i3), dp) 
g(SumI+4126) = Aimag(cplChiFdcSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+4269) = Real(cplChiFecSeL(i1,i2,i3), dp) 
g(SumI+4270) = Aimag(cplChiFecSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+4413) = Real(cplChiFecSeR(i1,i2,i3), dp) 
g(SumI+4414) = Aimag(cplChiFecSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+4557) = Real(cplChiFucSuL(i1,i2,i3), dp) 
g(SumI+4558) = Aimag(cplChiFucSuL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+4701) = Real(cplChiFucSuR(i1,i2,i3), dp) 
g(SumI+4702) = Aimag(cplChiFucSuR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
g(SumI+4845) = Real(cplcFdChiSdL(i1,i2,i3), dp) 
g(SumI+4846) = Aimag(cplcFdChiSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
g(SumI+4989) = Real(cplcFdChiSdR(i1,i2,i3), dp) 
g(SumI+4990) = Aimag(cplcFdChiSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
g(SumI+5133) = Real(cplcFeChiSeL(i1,i2,i3), dp) 
g(SumI+5134) = Aimag(cplcFeChiSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
g(SumI+5277) = Real(cplcFeChiSeR(i1,i2,i3), dp) 
g(SumI+5278) = Aimag(cplcFeChiSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
g(SumI+5421) = Real(cplcFuChiSuL(i1,i2,i3), dp) 
g(SumI+5422) = Aimag(cplcFuChiSuL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
g(SumI+5565) = Real(cplcFuChiSuR(i1,i2,i3), dp) 
g(SumI+5566) = Aimag(cplcFuChiSuR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+5709) = Real(cplFvFdcSdL(i1,i2,i3), dp) 
g(SumI+5710) = Aimag(cplFvFdcSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+5817) = Real(cplFvFdcSdR(i1,i2,i3), dp) 
g(SumI+5818) = Aimag(cplFvFdcSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+5925) = Real(cplGluFdcSdL(i1,i2), dp) 
g(SumI+5926) = Aimag(cplGluFdcSdL(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+5961) = Real(cplGluFdcSdR(i1,i2), dp) 
g(SumI+5962) = Aimag(cplGluFdcSdR(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+5997) = Real(cplcFdFdhhL(i1,i2,i3), dp) 
g(SumI+5998) = Aimag(cplcFdFdhhL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+6033) = Real(cplcFdFdhhR(i1,i2,i3), dp) 
g(SumI+6034) = Aimag(cplcFdFdhhR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+6069) = Real(cplcFdFdSvL(i1,i2,i3), dp) 
g(SumI+6070) = Aimag(cplcFdFdSvL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+6123) = Real(cplcFdFdSvR(i1,i2,i3), dp) 
g(SumI+6124) = Aimag(cplcFdFdSvR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6177) = Real(cplcChaFdcSuL(i1,i2,i3), dp) 
g(SumI+6178) = Aimag(cplcChaFdcSuL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6249) = Real(cplcChaFdcSuR(i1,i2,i3), dp) 
g(SumI+6250) = Aimag(cplcChaFdcSuR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+6321) = Real(cplcFdFdcSvL(i1,i2,i3), dp) 
g(SumI+6322) = Aimag(cplcFdFdcSvL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+6375) = Real(cplcFdFdcSvR(i1,i2,i3), dp) 
g(SumI+6376) = Aimag(cplcFdFdcSvR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6429) = Real(cplcFeFdcSuL(i1,i2,i3), dp) 
g(SumI+6430) = Aimag(cplcFeFdcSuL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6537) = Real(cplcFeFdcSuR(i1,i2,i3), dp) 
g(SumI+6538) = Aimag(cplcFeFdcSuR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+6645) = Real(cplcFuFdcHpmL(i1,i2,i3), dp) 
g(SumI+6646) = Aimag(cplcFuFdcHpmL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+6681) = Real(cplcFuFdcHpmR(i1,i2,i3), dp) 
g(SumI+6682) = Aimag(cplcFuFdcHpmR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6717) = Real(cplcFuFdcSeL(i1,i2,i3), dp) 
g(SumI+6718) = Aimag(cplcFuFdcSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6825) = Real(cplcFuFdcSeR(i1,i2,i3), dp) 
g(SumI+6826) = Aimag(cplcFuFdcSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+6933) = Real(cplFeFucSdL(i1,i2,i3), dp) 
g(SumI+6934) = Aimag(cplFeFucSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+7041) = Real(cplFeFucSdR(i1,i2,i3), dp) 
g(SumI+7042) = Aimag(cplFeFucSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+7149) = Real(cplFvFecHpmL(i1,i2,i3), dp) 
g(SumI+7150) = Aimag(cplFvFecHpmL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+7185) = Real(cplFvFecHpmR(i1,i2,i3), dp) 
g(SumI+7186) = Aimag(cplFvFecHpmR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+7221) = Real(cplFvFecSeL(i1,i2,i3), dp) 
g(SumI+7222) = Aimag(cplFvFecSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+7329) = Real(cplFvFecSeR(i1,i2,i3), dp) 
g(SumI+7330) = Aimag(cplFvFecSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+7437) = Real(cplcFeFehhL(i1,i2,i3), dp) 
g(SumI+7438) = Aimag(cplcFeFehhL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+7473) = Real(cplcFeFehhR(i1,i2,i3), dp) 
g(SumI+7474) = Aimag(cplcFeFehhR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+7509) = Real(cplcFdFeSuL(i1,i2,i3), dp) 
g(SumI+7510) = Aimag(cplcFdFeSuL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+7617) = Real(cplcFdFeSuR(i1,i2,i3), dp) 
g(SumI+7618) = Aimag(cplcFdFeSuR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+7725) = Real(cplcFeFeSvL(i1,i2,i3), dp) 
g(SumI+7726) = Aimag(cplcFeFeSvL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+7779) = Real(cplcFeFeSvR(i1,i2,i3), dp) 
g(SumI+7780) = Aimag(cplcFeFeSvR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+7833) = Real(cplcChaFecSvL(i1,i2,i3), dp) 
g(SumI+7834) = Aimag(cplcChaFecSvL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+7869) = Real(cplcChaFecSvR(i1,i2,i3), dp) 
g(SumI+7870) = Aimag(cplcChaFecSvR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+7905) = Real(cplcFeFecSvL(i1,i2,i3), dp) 
g(SumI+7906) = Aimag(cplcFeFecSvL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+7959) = Real(cplcFeFecSvR(i1,i2,i3), dp) 
g(SumI+7960) = Aimag(cplcFeFecSvR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+8013) = Real(cplGluFucSuL(i1,i2), dp) 
g(SumI+8014) = Aimag(cplGluFucSuL(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+8049) = Real(cplGluFucSuR(i1,i2), dp) 
g(SumI+8050) = Aimag(cplGluFucSuR(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+8085) = Real(cplcFuFuhhL(i1,i2,i3), dp) 
g(SumI+8086) = Aimag(cplcFuFuhhL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+8121) = Real(cplcFuFuhhR(i1,i2,i3), dp) 
g(SumI+8122) = Aimag(cplcFuFuhhR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+8157) = Real(cplcFdFuHpmL(i1,i2,i3), dp) 
g(SumI+8158) = Aimag(cplcFdFuHpmL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+8193) = Real(cplcFdFuHpmR(i1,i2,i3), dp) 
g(SumI+8194) = Aimag(cplcFdFuHpmR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8229) = Real(cplcFdFuSeL(i1,i2,i3), dp) 
g(SumI+8230) = Aimag(cplcFdFuSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8337) = Real(cplcFdFuSeR(i1,i2,i3), dp) 
g(SumI+8338) = Aimag(cplcFdFuSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+8445) = Real(cplcFeFvHpmL(i1,i2,i3), dp) 
g(SumI+8446) = Aimag(cplcFeFvHpmL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
g(SumI+8481) = Real(cplcFeFvHpmR(i1,i2,i3), dp) 
g(SumI+8482) = Aimag(cplcFeFvHpmR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8517) = Real(cplcFdFvSdL(i1,i2,i3), dp) 
g(SumI+8518) = Aimag(cplcFdFvSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8625) = Real(cplcFdFvSdR(i1,i2,i3), dp) 
g(SumI+8626) = Aimag(cplcFdFvSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8733) = Real(cplcChaFvSeL(i1,i2,i3), dp) 
g(SumI+8734) = Aimag(cplcChaFvSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8805) = Real(cplcChaFvSeR(i1,i2,i3), dp) 
g(SumI+8806) = Aimag(cplcChaFvSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8877) = Real(cplcFeFvSeL(i1,i2,i3), dp) 
g(SumI+8878) = Aimag(cplcFeFvSeL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+8985) = Real(cplcFeFvSeR(i1,i2,i3), dp) 
g(SumI+8986) = Aimag(cplcFeFvSeR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+9093) = Real(cplcFdGluSdL(i1,i2), dp) 
g(SumI+9094) = Aimag(cplcFdGluSdL(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+9129) = Real(cplcFdGluSdR(i1,i2), dp) 
g(SumI+9130) = Aimag(cplcFdGluSdR(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+9165) = Real(cplcFuGluSuL(i1,i2), dp) 
g(SumI+9166) = Aimag(cplcFuGluSuL(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+9201) = Real(cplcFuGluSuR(i1,i2), dp) 
g(SumI+9202) = Aimag(cplcFuGluSuR(i1,i2)) 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+9237) = Real(cplcChacFuSdL(i1,i2,i3), dp) 
g(SumI+9238) = Aimag(cplcChacFuSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+9309) = Real(cplcChacFuSdR(i1,i2,i3), dp) 
g(SumI+9310) = Aimag(cplcChacFuSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+9381) = Real(cplcFecFuSdL(i1,i2,i3), dp) 
g(SumI+9382) = Aimag(cplcFecFuSdL(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+9489) = Real(cplcFecFuSdR(i1,i2,i3), dp) 
g(SumI+9490) = Aimag(cplcFecFuSdR(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+9597) = Real(cplcFdFdVGL(i1,i2), dp) 
g(SumI+9598) = Aimag(cplcFdFdVGL(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+9615) = Real(cplcFdFdVGR(i1,i2), dp) 
g(SumI+9616) = Aimag(cplcFdFdVGR(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+9633) = Real(cplcFuFuVGL(i1,i2), dp) 
g(SumI+9634) = Aimag(cplcFuFuVGL(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+9651) = Real(cplcFuFuVGR(i1,i2), dp) 
g(SumI+9652) = Aimag(cplcFuFuVGR(i1,i2)) 
End Do 
End Do 

g(9669) = Real(cplGluGluVGL,dp)  
g(9670) = Aimag(cplGluGluVGL)  
g(9671) = Real(cplGluGluVGR,dp)  
g(9672) = Aimag(cplGluGluVGR)  
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
g(SumI+9673) = Real(cplAhAhSdcSd(i1,i2,i3,i4), dp) 
g(SumI+9674) = Aimag(cplAhAhSdcSd(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
g(SumI+9961) = Real(cplAhAhSecSe(i1,i2,i3,i4), dp) 
g(SumI+9962) = Aimag(cplAhAhSecSe(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
g(SumI+10249) = Real(cplAhAhSucSu(i1,i2,i3,i4), dp) 
g(SumI+10250) = Aimag(cplAhAhSucSu(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
g(SumI+10537) = Real(cplhhhhSdcSd(i1,i2,i3,i4), dp) 
g(SumI+10538) = Aimag(cplhhhhSdcSd(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
g(SumI+10825) = Real(cplhhhhSecSe(i1,i2,i3,i4), dp) 
g(SumI+10826) = Aimag(cplhhhhSecSe(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
g(SumI+11113) = Real(cplhhhhSucSu(i1,i2,i3,i4), dp) 
g(SumI+11114) = Aimag(cplhhhhSucSu(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,2
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*12 + (i1-1)*72
SumI = SumI*2 
g(SumI+11401) = Real(cplHpmSdcHpmcSd(i1,i2,i3,i4), dp) 
g(SumI+11402) = Aimag(cplHpmSdcHpmcSd(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,2
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*12 + (i1-1)*72
SumI = SumI*2 
g(SumI+11689) = Real(cplHpmSecHpmcSe(i1,i2,i3,i4), dp) 
g(SumI+11690) = Aimag(cplHpmSecHpmcSe(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,2
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*12 + (i1-1)*72
SumI = SumI*2 
g(SumI+11977) = Real(cplHpmSucHpmcSu(i1,i2,i3,i4), dp) 
g(SumI+11978) = Aimag(cplHpmSucHpmcSu(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,2
Do i4 = 1,3
SumI = (i4-1) + (i3-1)*3 + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
g(SumI+12265) = Real(cplHpmSvcHpmcSv(i1,i2,i3,i4), dp) 
g(SumI+12266) = Aimag(cplHpmSvcHpmcSv(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
g(SumI+12337) = Real(cplSdSdcSdcSd(i1,i2,i3,i4), dp) 
g(SumI+12338) = Aimag(cplSdSdcSdcSd(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
g(SumI+14929) = Real(cplSdSecSdcSe(i1,i2,i3,i4), dp) 
g(SumI+14930) = Aimag(cplSdSecSdcSe(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
g(SumI+17521) = Real(cplSdSucSdcSu(i1,i2,i3,i4), dp) 
g(SumI+17522) = Aimag(cplSdSucSdcSu(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
Do i4 = 1,3
SumI = (i4-1) + (i3-1)*3 + (i2-1)*18 + (i1-1)*54
SumI = SumI*2 
g(SumI+20113) = Real(cplSdSvcSdcSv(i1,i2,i3,i4), dp) 
g(SumI+20114) = Aimag(cplSdSvcSdcSv(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
g(SumI+20761) = Real(cplSeSecSecSe(i1,i2,i3,i4), dp) 
g(SumI+20762) = Aimag(cplSeSecSecSe(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
g(SumI+23353) = Real(cplSeSucSecSu(i1,i2,i3,i4), dp) 
g(SumI+23354) = Aimag(cplSeSucSecSu(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
Do i4 = 1,3
SumI = (i4-1) + (i3-1)*3 + (i2-1)*18 + (i1-1)*54
SumI = SumI*2 
g(SumI+25945) = Real(cplSeSvcSecSv(i1,i2,i3,i4), dp) 
g(SumI+25946) = Aimag(cplSeSvcSecSv(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
g(SumI+26593) = Real(cplSuSucSucSu(i1,i2,i3,i4), dp) 
g(SumI+26594) = Aimag(cplSuSucSucSu(i1,i2,i3,i4)) 
End Do 
End Do 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+29185) = Real(cplSdcSdVGVG(i1,i2), dp) 
g(SumI+29186) = Aimag(cplSdcSdVGVG(i1,i2)) 
End Do 
End Do 

Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
g(SumI+29257) = Real(cplSucSuVGVG(i1,i2), dp) 
g(SumI+29258) = Aimag(cplSucSuVGVG(i1,i2)) 
End Do 
End Do 

End Subroutine MassesCoupsToG

Subroutine GToMassesCoups(g,MSd,MSd2,MSv,MSv2,MSu,MSu2,MSe,MSe2,Mhh,Mhh2,             & 
& MAh,MAh2,MHpm,MHpm2,MChi,MChi2,MCha,MCha2,MFe,MFe2,MFd,MFd2,MFu,MFu2,MGlu,             & 
& MGlu2,MVZ,MVZ2,MVWm,MVWm2,cplAhSdcSd,cplAhSecSe,cplAhSucSu,cplhhSdcSd,cplhhSecSe,      & 
& cplhhSucSu,cplHpmSucSd,cplHpmSvcSe,cplSdSvcSd,cplSdcHpmcSu,cplSdcSdcSv,cplSdcSecSu,    & 
& cplSeSucSd,cplSeSvcSe,cplSecHpmcSv,cplSecSecSv,cplSdcSdVG,cplSucSuVG,cplVGVGVG,        & 
& cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,               & 
& cplChaFucSdL,cplChaFucSdR,cplFvChacSeL,cplFvChacSeR,cplcFdChaSuL,cplcFdChaSuR,         & 
& cplcFeChaSvL,cplcFeChaSvR,cplChiFdcSdL,cplChiFdcSdR,cplChiFecSeL,cplChiFecSeR,         & 
& cplChiFucSuL,cplChiFucSuR,cplcFdChiSdL,cplcFdChiSdR,cplcFeChiSeL,cplcFeChiSeR,         & 
& cplcFuChiSuL,cplcFuChiSuR,cplFvFdcSdL,cplFvFdcSdR,cplGluFdcSdL,cplGluFdcSdR,           & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFdFdSvL,cplcFdFdSvR,cplcChaFdcSuL,cplcChaFdcSuR,           & 
& cplcFdFdcSvL,cplcFdFdcSvR,cplcFeFdcSuL,cplcFeFdcSuR,cplcFuFdcHpmL,cplcFuFdcHpmR,       & 
& cplcFuFdcSeL,cplcFuFdcSeR,cplFeFucSdL,cplFeFucSdR,cplFvFecHpmL,cplFvFecHpmR,           & 
& cplFvFecSeL,cplFvFecSeR,cplcFeFehhL,cplcFeFehhR,cplcFdFeSuL,cplcFdFeSuR,               & 
& cplcFeFeSvL,cplcFeFeSvR,cplcChaFecSvL,cplcChaFecSvR,cplcFeFecSvL,cplcFeFecSvR,         & 
& cplGluFucSuL,cplGluFucSuR,cplcFuFuhhL,cplcFuFuhhR,cplcFdFuHpmL,cplcFdFuHpmR,           & 
& cplcFdFuSeL,cplcFdFuSeR,cplcFeFvHpmL,cplcFeFvHpmR,cplcFdFvSdL,cplcFdFvSdR,             & 
& cplcChaFvSeL,cplcChaFvSeR,cplcFeFvSeL,cplcFeFvSeR,cplcFdGluSdL,cplcFdGluSdR,           & 
& cplcFuGluSuL,cplcFuGluSuR,cplcChacFuSdL,cplcChacFuSdR,cplcFecFuSdL,cplcFecFuSdR,       & 
& cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplGluGluVGL,cplGluGluVGR,             & 
& cplAhAhSdcSd,cplAhAhSecSe,cplAhAhSucSu,cplhhhhSdcSd,cplhhhhSecSe,cplhhhhSucSu,         & 
& cplHpmSdcHpmcSd,cplHpmSecHpmcSe,cplHpmSucHpmcSu,cplHpmSvcHpmcSv,cplSdSdcSdcSd,         & 
& cplSdSecSdcSe,cplSdSucSdcSu,cplSdSvcSdcSv,cplSeSecSecSe,cplSeSucSecSu,cplSeSvcSecSv,   & 
& cplSuSucSucSu,cplSdcSdVGVG,cplSucSuVGVG)

Implicit None 
Real(dp), Intent(in) :: g(:) 
Integer :: i1,i2,i3,i4, sumI
Real(dp),Intent(inout) :: MSd(6),MSd2(6),MSv(3),MSv2(3),MSu(6),MSu2(6),MSe(6),MSe2(6),Mhh(2),Mhh2(2),           & 
& MAh(2),MAh2(2),MHpm(2),MHpm2(2),MChi(4),MChi2(4),MCha(2),MCha2(2),MFe(3),              & 
& MFe2(3),MFd(3),MFd2(3),MFu(3),MFu2(3),MGlu,MGlu2,MVZ,MVZ2,MVWm,MVWm2

Complex(dp),Intent(inout) :: cplAhSdcSd(2,6,6),cplAhSecSe(2,6,6),cplAhSucSu(2,6,6),cplhhSdcSd(2,6,6),              & 
& cplhhSecSe(2,6,6),cplhhSucSu(2,6,6),cplHpmSucSd(2,6,6),cplHpmSvcSe(2,3,6),             & 
& cplSdSvcSd(6,3,6),cplSdcHpmcSu(6,2,6),cplSdcSdcSv(6,6,3),cplSdcSecSu(6,6,6),           & 
& cplSeSucSd(6,6,6),cplSeSvcSe(6,3,6),cplSecHpmcSv(6,2,3),cplSecSecSv(6,6,3),            & 
& cplSdcSdVG(6,6),cplSucSuVG(6,6),cplVGVGVG,cplcFdFdAhL(3,3,2),cplcFdFdAhR(3,3,2),       & 
& cplcFeFeAhL(3,3,2),cplcFeFeAhR(3,3,2),cplcFuFuAhL(3,3,2),cplcFuFuAhR(3,3,2),           & 
& cplChaFucSdL(2,3,6),cplChaFucSdR(2,3,6),cplFvChacSeL(3,2,6),cplFvChacSeR(3,2,6),       & 
& cplcFdChaSuL(3,2,6),cplcFdChaSuR(3,2,6),cplcFeChaSvL(3,2,3),cplcFeChaSvR(3,2,3),       & 
& cplChiFdcSdL(4,3,6),cplChiFdcSdR(4,3,6),cplChiFecSeL(4,3,6),cplChiFecSeR(4,3,6),       & 
& cplChiFucSuL(4,3,6),cplChiFucSuR(4,3,6),cplcFdChiSdL(3,4,6),cplcFdChiSdR(3,4,6),       & 
& cplcFeChiSeL(3,4,6),cplcFeChiSeR(3,4,6),cplcFuChiSuL(3,4,6),cplcFuChiSuR(3,4,6),       & 
& cplFvFdcSdL(3,3,6),cplFvFdcSdR(3,3,6),cplGluFdcSdL(3,6),cplGluFdcSdR(3,6),             & 
& cplcFdFdhhL(3,3,2),cplcFdFdhhR(3,3,2),cplcFdFdSvL(3,3,3),cplcFdFdSvR(3,3,3),           & 
& cplcChaFdcSuL(2,3,6),cplcChaFdcSuR(2,3,6),cplcFdFdcSvL(3,3,3),cplcFdFdcSvR(3,3,3),     & 
& cplcFeFdcSuL(3,3,6),cplcFeFdcSuR(3,3,6),cplcFuFdcHpmL(3,3,2),cplcFuFdcHpmR(3,3,2),     & 
& cplcFuFdcSeL(3,3,6),cplcFuFdcSeR(3,3,6),cplFeFucSdL(3,3,6),cplFeFucSdR(3,3,6),         & 
& cplFvFecHpmL(3,3,2),cplFvFecHpmR(3,3,2),cplFvFecSeL(3,3,6),cplFvFecSeR(3,3,6),         & 
& cplcFeFehhL(3,3,2),cplcFeFehhR(3,3,2),cplcFdFeSuL(3,3,6),cplcFdFeSuR(3,3,6),           & 
& cplcFeFeSvL(3,3,3),cplcFeFeSvR(3,3,3),cplcChaFecSvL(2,3,3),cplcChaFecSvR(2,3,3),       & 
& cplcFeFecSvL(3,3,3),cplcFeFecSvR(3,3,3),cplGluFucSuL(3,6),cplGluFucSuR(3,6),           & 
& cplcFuFuhhL(3,3,2),cplcFuFuhhR(3,3,2),cplcFdFuHpmL(3,3,2),cplcFdFuHpmR(3,3,2),         & 
& cplcFdFuSeL(3,3,6),cplcFdFuSeR(3,3,6),cplcFeFvHpmL(3,3,2),cplcFeFvHpmR(3,3,2),         & 
& cplcFdFvSdL(3,3,6),cplcFdFvSdR(3,3,6),cplcChaFvSeL(2,3,6),cplcChaFvSeR(2,3,6),         & 
& cplcFeFvSeL(3,3,6),cplcFeFvSeR(3,3,6),cplcFdGluSdL(3,6),cplcFdGluSdR(3,6),             & 
& cplcFuGluSuL(3,6),cplcFuGluSuR(3,6),cplcChacFuSdL(2,3,6),cplcChacFuSdR(2,3,6),         & 
& cplcFecFuSdL(3,3,6),cplcFecFuSdR(3,3,6),cplcFdFdVGL(3,3),cplcFdFdVGR(3,3),             & 
& cplcFuFuVGL(3,3),cplcFuFuVGR(3,3),cplGluGluVGL,cplGluGluVGR

Complex(dp),Intent(inout) :: cplAhAhSdcSd(2,2,6,6),cplAhAhSecSe(2,2,6,6),cplAhAhSucSu(2,2,6,6),cplhhhhSdcSd(2,2,6,6),& 
& cplhhhhSecSe(2,2,6,6),cplhhhhSucSu(2,2,6,6),cplHpmSdcHpmcSd(2,6,2,6),cplHpmSecHpmcSe(2,6,2,6),& 
& cplHpmSucHpmcSu(2,6,2,6),cplHpmSvcHpmcSv(2,3,2,3),cplSdSdcSdcSd(6,6,6,6),              & 
& cplSdSecSdcSe(6,6,6,6),cplSdSucSdcSu(6,6,6,6),cplSdSvcSdcSv(6,3,6,3),cplSeSecSecSe(6,6,6,6),& 
& cplSeSucSecSu(6,6,6,6),cplSeSvcSecSv(6,3,6,3),cplSuSucSucSu(6,6,6,6),cplSdcSdVGVG(6,6),& 
& cplSucSuVGVG(6,6)

MSd=g(1:6) 
MSd2=g(7:12) 
MSv=g(13:15) 
MSv2=g(16:18) 
MSu=g(19:24) 
MSu2=g(25:30) 
MSe=g(31:36) 
MSe2=g(37:42) 
Mhh=g(43:44) 
Mhh2=g(45:46) 
MAh=g(47:48) 
MAh2=g(49:50) 
MHpm=g(51:52) 
MHpm2=g(53:54) 
MChi=g(55:58) 
MChi2=g(59:62) 
MCha=g(63:64) 
MCha2=g(65:66) 
MFe=g(67:69) 
MFe2=g(70:72) 
MFd=g(73:75) 
MFd2=g(76:78) 
MFu=g(79:81) 
MFu2=g(82:84) 
MGlu=g(85) 
MGlu2=g(86) 
MVZ=g(87) 
MVZ2=g(88) 
MVWm=g(89) 
MVWm2=g(90) 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplAhSdcSd(i1,i2,i3) = Cmplx( g(SumI+91), g(SumI+92), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplAhSecSe(i1,i2,i3) = Cmplx( g(SumI+235), g(SumI+236), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplAhSucSu(i1,i2,i3) = Cmplx( g(SumI+379), g(SumI+380), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplhhSdcSd(i1,i2,i3) = Cmplx( g(SumI+523), g(SumI+524), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplhhSecSe(i1,i2,i3) = Cmplx( g(SumI+667), g(SumI+668), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplhhSucSu(i1,i2,i3) = Cmplx( g(SumI+811), g(SumI+812), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplHpmSucSd(i1,i2,i3) = Cmplx( g(SumI+955), g(SumI+956), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplHpmSvcSe(i1,i2,i3) = Cmplx( g(SumI+1099), g(SumI+1100), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplSdSvcSd(i1,i2,i3) = Cmplx( g(SumI+1171), g(SumI+1172), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
cplSdcHpmcSu(i1,i2,i3) = Cmplx( g(SumI+1387), g(SumI+1388), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*18
SumI = SumI*2 
cplSdcSdcSv(i1,i2,i3) = Cmplx( g(SumI+1531), g(SumI+1532), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplSdcSecSu(i1,i2,i3) = Cmplx( g(SumI+1747), g(SumI+1748), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*36
SumI = SumI*2 
cplSeSucSd(i1,i2,i3) = Cmplx( g(SumI+2179), g(SumI+2180), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplSeSvcSe(i1,i2,i3) = Cmplx( g(SumI+2611), g(SumI+2612), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,2
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*6
SumI = SumI*2 
cplSecHpmcSv(i1,i2,i3) = Cmplx( g(SumI+2827), g(SumI+2828), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*18
SumI = SumI*2 
cplSecSecSv(i1,i2,i3) = Cmplx( g(SumI+2899), g(SumI+2900), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplSdcSdVG(i1,i2) = Cmplx( g(SumI+3115), g(SumI+3116), dp) 
End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplSucSuVG(i1,i2) = Cmplx( g(SumI+3187), g(SumI+3188), dp) 
End Do 
 End Do 
 
cplVGVGVG= Cmplx(g(3259),g(3260),dp) 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFdFdAhL(i1,i2,i3) = Cmplx( g(SumI+3261), g(SumI+3262), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFdFdAhR(i1,i2,i3) = Cmplx( g(SumI+3297), g(SumI+3298), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFeFeAhL(i1,i2,i3) = Cmplx( g(SumI+3333), g(SumI+3334), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFeFeAhR(i1,i2,i3) = Cmplx( g(SumI+3369), g(SumI+3370), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFuFuAhL(i1,i2,i3) = Cmplx( g(SumI+3405), g(SumI+3406), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFuFuAhR(i1,i2,i3) = Cmplx( g(SumI+3441), g(SumI+3442), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChaFucSdL(i1,i2,i3) = Cmplx( g(SumI+3477), g(SumI+3478), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChaFucSdR(i1,i2,i3) = Cmplx( g(SumI+3549), g(SumI+3550), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
cplFvChacSeL(i1,i2,i3) = Cmplx( g(SumI+3621), g(SumI+3622), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
cplFvChacSeR(i1,i2,i3) = Cmplx( g(SumI+3693), g(SumI+3694), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
cplcFdChaSuL(i1,i2,i3) = Cmplx( g(SumI+3765), g(SumI+3766), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*12
SumI = SumI*2 
cplcFdChaSuR(i1,i2,i3) = Cmplx( g(SumI+3837), g(SumI+3838), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*6
SumI = SumI*2 
cplcFeChaSvL(i1,i2,i3) = Cmplx( g(SumI+3909), g(SumI+3910), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,2
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*6
SumI = SumI*2 
cplcFeChaSvR(i1,i2,i3) = Cmplx( g(SumI+3945), g(SumI+3946), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChiFdcSdL(i1,i2,i3) = Cmplx( g(SumI+3981), g(SumI+3982), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChiFdcSdR(i1,i2,i3) = Cmplx( g(SumI+4125), g(SumI+4126), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChiFecSeL(i1,i2,i3) = Cmplx( g(SumI+4269), g(SumI+4270), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChiFecSeR(i1,i2,i3) = Cmplx( g(SumI+4413), g(SumI+4414), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChiFucSuL(i1,i2,i3) = Cmplx( g(SumI+4557), g(SumI+4558), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,4
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplChiFucSuR(i1,i2,i3) = Cmplx( g(SumI+4701), g(SumI+4702), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
cplcFdChiSdL(i1,i2,i3) = Cmplx( g(SumI+4845), g(SumI+4846), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
cplcFdChiSdR(i1,i2,i3) = Cmplx( g(SumI+4989), g(SumI+4990), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
cplcFeChiSeL(i1,i2,i3) = Cmplx( g(SumI+5133), g(SumI+5134), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
cplcFeChiSeR(i1,i2,i3) = Cmplx( g(SumI+5277), g(SumI+5278), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
cplcFuChiSuL(i1,i2,i3) = Cmplx( g(SumI+5421), g(SumI+5422), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,4
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*24
SumI = SumI*2 
cplcFuChiSuR(i1,i2,i3) = Cmplx( g(SumI+5565), g(SumI+5566), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplFvFdcSdL(i1,i2,i3) = Cmplx( g(SumI+5709), g(SumI+5710), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplFvFdcSdR(i1,i2,i3) = Cmplx( g(SumI+5817), g(SumI+5818), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplGluFdcSdL(i1,i2) = Cmplx( g(SumI+5925), g(SumI+5926), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplGluFdcSdR(i1,i2) = Cmplx( g(SumI+5961), g(SumI+5962), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFdFdhhL(i1,i2,i3) = Cmplx( g(SumI+5997), g(SumI+5998), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFdFdhhR(i1,i2,i3) = Cmplx( g(SumI+6033), g(SumI+6034), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFdFdSvL(i1,i2,i3) = Cmplx( g(SumI+6069), g(SumI+6070), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFdFdSvR(i1,i2,i3) = Cmplx( g(SumI+6123), g(SumI+6124), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcChaFdcSuL(i1,i2,i3) = Cmplx( g(SumI+6177), g(SumI+6178), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcChaFdcSuR(i1,i2,i3) = Cmplx( g(SumI+6249), g(SumI+6250), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFdFdcSvL(i1,i2,i3) = Cmplx( g(SumI+6321), g(SumI+6322), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFdFdcSvR(i1,i2,i3) = Cmplx( g(SumI+6375), g(SumI+6376), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFeFdcSuL(i1,i2,i3) = Cmplx( g(SumI+6429), g(SumI+6430), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFeFdcSuR(i1,i2,i3) = Cmplx( g(SumI+6537), g(SumI+6538), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFuFdcHpmL(i1,i2,i3) = Cmplx( g(SumI+6645), g(SumI+6646), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFuFdcHpmR(i1,i2,i3) = Cmplx( g(SumI+6681), g(SumI+6682), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFuFdcSeL(i1,i2,i3) = Cmplx( g(SumI+6717), g(SumI+6718), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFuFdcSeR(i1,i2,i3) = Cmplx( g(SumI+6825), g(SumI+6826), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplFeFucSdL(i1,i2,i3) = Cmplx( g(SumI+6933), g(SumI+6934), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplFeFucSdR(i1,i2,i3) = Cmplx( g(SumI+7041), g(SumI+7042), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplFvFecHpmL(i1,i2,i3) = Cmplx( g(SumI+7149), g(SumI+7150), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplFvFecHpmR(i1,i2,i3) = Cmplx( g(SumI+7185), g(SumI+7186), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplFvFecSeL(i1,i2,i3) = Cmplx( g(SumI+7221), g(SumI+7222), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplFvFecSeR(i1,i2,i3) = Cmplx( g(SumI+7329), g(SumI+7330), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFeFehhL(i1,i2,i3) = Cmplx( g(SumI+7437), g(SumI+7438), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFeFehhR(i1,i2,i3) = Cmplx( g(SumI+7473), g(SumI+7474), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFdFeSuL(i1,i2,i3) = Cmplx( g(SumI+7509), g(SumI+7510), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFdFeSuR(i1,i2,i3) = Cmplx( g(SumI+7617), g(SumI+7618), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFeFeSvL(i1,i2,i3) = Cmplx( g(SumI+7725), g(SumI+7726), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFeFeSvR(i1,i2,i3) = Cmplx( g(SumI+7779), g(SumI+7780), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcChaFecSvL(i1,i2,i3) = Cmplx( g(SumI+7833), g(SumI+7834), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcChaFecSvR(i1,i2,i3) = Cmplx( g(SumI+7869), g(SumI+7870), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFeFecSvL(i1,i2,i3) = Cmplx( g(SumI+7905), g(SumI+7906), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
cplcFeFecSvR(i1,i2,i3) = Cmplx( g(SumI+7959), g(SumI+7960), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplGluFucSuL(i1,i2) = Cmplx( g(SumI+8013), g(SumI+8014), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplGluFucSuR(i1,i2) = Cmplx( g(SumI+8049), g(SumI+8050), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFuFuhhL(i1,i2,i3) = Cmplx( g(SumI+8085), g(SumI+8086), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFuFuhhR(i1,i2,i3) = Cmplx( g(SumI+8121), g(SumI+8122), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFdFuHpmL(i1,i2,i3) = Cmplx( g(SumI+8157), g(SumI+8158), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFdFuHpmR(i1,i2,i3) = Cmplx( g(SumI+8193), g(SumI+8194), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFdFuSeL(i1,i2,i3) = Cmplx( g(SumI+8229), g(SumI+8230), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFdFuSeR(i1,i2,i3) = Cmplx( g(SumI+8337), g(SumI+8338), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFeFvHpmL(i1,i2,i3) = Cmplx( g(SumI+8445), g(SumI+8446), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,2
SumI = (i3-1) + (i2-1)*2 + (i1-1)*6
SumI = SumI*2 
cplcFeFvHpmR(i1,i2,i3) = Cmplx( g(SumI+8481), g(SumI+8482), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFdFvSdL(i1,i2,i3) = Cmplx( g(SumI+8517), g(SumI+8518), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFdFvSdR(i1,i2,i3) = Cmplx( g(SumI+8625), g(SumI+8626), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcChaFvSeL(i1,i2,i3) = Cmplx( g(SumI+8733), g(SumI+8734), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcChaFvSeR(i1,i2,i3) = Cmplx( g(SumI+8805), g(SumI+8806), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFeFvSeL(i1,i2,i3) = Cmplx( g(SumI+8877), g(SumI+8878), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFeFvSeR(i1,i2,i3) = Cmplx( g(SumI+8985), g(SumI+8986), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplcFdGluSdL(i1,i2) = Cmplx( g(SumI+9093), g(SumI+9094), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplcFdGluSdR(i1,i2) = Cmplx( g(SumI+9129), g(SumI+9130), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplcFuGluSuL(i1,i2) = Cmplx( g(SumI+9165), g(SumI+9166), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplcFuGluSuR(i1,i2) = Cmplx( g(SumI+9201), g(SumI+9202), dp) 
End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcChacFuSdL(i1,i2,i3) = Cmplx( g(SumI+9237), g(SumI+9238), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcChacFuSdR(i1,i2,i3) = Cmplx( g(SumI+9309), g(SumI+9310), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFecFuSdL(i1,i2,i3) = Cmplx( g(SumI+9381), g(SumI+9382), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,6
SumI = (i3-1) + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplcFecFuSdR(i1,i2,i3) = Cmplx( g(SumI+9489), g(SumI+9490), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
cplcFdFdVGL(i1,i2) = Cmplx( g(SumI+9597), g(SumI+9598), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
cplcFdFdVGR(i1,i2) = Cmplx( g(SumI+9615), g(SumI+9616), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
cplcFuFuVGL(i1,i2) = Cmplx( g(SumI+9633), g(SumI+9634), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
cplcFuFuVGR(i1,i2) = Cmplx( g(SumI+9651), g(SumI+9652), dp) 
End Do 
 End Do 
 
cplGluGluVGL= Cmplx(g(9669),g(9670),dp) 
cplGluGluVGR= Cmplx(g(9671),g(9672),dp) 
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
cplAhAhSdcSd(i1,i2,i3,i4) = Cmplx( g(SumI+9673), g(SumI+9674), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
cplAhAhSecSe(i1,i2,i3,i4) = Cmplx( g(SumI+9961), g(SumI+9962), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
cplAhAhSucSu(i1,i2,i3,i4) = Cmplx( g(SumI+10249), g(SumI+10250), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
cplhhhhSdcSd(i1,i2,i3,i4) = Cmplx( g(SumI+10537), g(SumI+10538), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
cplhhhhSecSe(i1,i2,i3,i4) = Cmplx( g(SumI+10825), g(SumI+10826), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,2
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*72
SumI = SumI*2 
cplhhhhSucSu(i1,i2,i3,i4) = Cmplx( g(SumI+11113), g(SumI+11114), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,2
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*12 + (i1-1)*72
SumI = SumI*2 
cplHpmSdcHpmcSd(i1,i2,i3,i4) = Cmplx( g(SumI+11401), g(SumI+11402), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,2
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*12 + (i1-1)*72
SumI = SumI*2 
cplHpmSecHpmcSe(i1,i2,i3,i4) = Cmplx( g(SumI+11689), g(SumI+11690), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,6
Do i3 = 1,2
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*12 + (i1-1)*72
SumI = SumI*2 
cplHpmSucHpmcSu(i1,i2,i3,i4) = Cmplx( g(SumI+11977), g(SumI+11978), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,2
Do i2 = 1,3
Do i3 = 1,2
Do i4 = 1,3
SumI = (i4-1) + (i3-1)*3 + (i2-1)*6 + (i1-1)*18
SumI = SumI*2 
cplHpmSvcHpmcSv(i1,i2,i3,i4) = Cmplx( g(SumI+12265), g(SumI+12266), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
cplSdSdcSdcSd(i1,i2,i3,i4) = Cmplx( g(SumI+12337), g(SumI+12338), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
cplSdSecSdcSe(i1,i2,i3,i4) = Cmplx( g(SumI+14929), g(SumI+14930), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
cplSdSucSdcSu(i1,i2,i3,i4) = Cmplx( g(SumI+17521), g(SumI+17522), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
Do i4 = 1,3
SumI = (i4-1) + (i3-1)*3 + (i2-1)*18 + (i1-1)*54
SumI = SumI*2 
cplSdSvcSdcSv(i1,i2,i3,i4) = Cmplx( g(SumI+20113), g(SumI+20114), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
cplSeSecSecSe(i1,i2,i3,i4) = Cmplx( g(SumI+20761), g(SumI+20762), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
cplSeSucSecSu(i1,i2,i3,i4) = Cmplx( g(SumI+23353), g(SumI+23354), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,3
Do i3 = 1,6
Do i4 = 1,3
SumI = (i4-1) + (i3-1)*3 + (i2-1)*18 + (i1-1)*54
SumI = SumI*2 
cplSeSvcSecSv(i1,i2,i3,i4) = Cmplx( g(SumI+25945), g(SumI+25946), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
Do i3 = 1,6
Do i4 = 1,6
SumI = (i4-1) + (i3-1)*6 + (i2-1)*36 + (i1-1)*216
SumI = SumI*2 
cplSuSucSucSu(i1,i2,i3,i4) = Cmplx( g(SumI+26593), g(SumI+26594), dp) 
End Do 
 End Do 
 End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplSdcSdVGVG(i1,i2) = Cmplx( g(SumI+29185), g(SumI+29186), dp) 
End Do 
 End Do 
 
Do i1 = 1,6
Do i2 = 1,6
SumI = (i2-1) + (i1-1)*6
SumI = SumI*2 
cplSucSuVGVG(i1,i2) = Cmplx( g(SumI+29257), g(SumI+29258), dp) 
End Do 
 End Do 
 
End Subroutine GToMassesCoups

End Module EffectivePotential_MSSMTriLnV 
 
