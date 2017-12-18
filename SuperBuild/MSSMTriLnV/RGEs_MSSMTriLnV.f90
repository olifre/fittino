! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.11.0 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 10:33 on 25.4.2017   
! ----------------------------------------------------------------------  
 
 
Module RGEs_MSSMTriLnV 
 
Use Control 
Use Settings 
Use Model_Data_MSSMTriLnV 
Use Mathematics 
 
Logical,Private,Save::OnlyDiagonal

Real(dp),Parameter::id3R(3,3)=& 
   & Reshape(Source=(/& 
   & 1,0,0,& 
 &0,1,0,& 
 &0,0,1& 
 &/),shape=(/3,3/)) 
Contains 


Subroutine GToParameters165(g,g1,g2,g3,Yd,Ye,L1,L2,Yu)

Implicit None 
Real(dp), Intent(in) :: g(165) 
Real(dp),Intent(out) :: g1,g2,g3

Complex(dp),Intent(out) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3)

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters165' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yd(i1,i2) = Cmplx( g(SumI+4), g(SumI+5), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Ye(i1,i2) = Cmplx( g(SumI+22), g(SumI+23), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
L1(i1,i2,i3) = Cmplx( g(SumI+40), g(SumI+41), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
L2(i1,i2,i3) = Cmplx( g(SumI+94), g(SumI+95), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yu(i1,i2) = Cmplx( g(SumI+148), g(SumI+149), dp) 
End Do 
 End Do 
 
Do i1=1,165 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters165

Subroutine ParametersToG165(g1,g2,g3,Yd,Ye,L1,L2,Yu,g)

Implicit None 
Real(dp), Intent(out) :: g(165) 
Real(dp), Intent(in) :: g1,g2,g3

Complex(dp), Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3)

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG165' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+4) = Real(Yd(i1,i2), dp) 
g(SumI+5) = Aimag(Yd(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+22) = Real(Ye(i1,i2), dp) 
g(SumI+23) = Aimag(Ye(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+40) = Real(L1(i1,i2,i3), dp) 
g(SumI+41) = Aimag(L1(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+94) = Real(L2(i1,i2,i3), dp) 
g(SumI+95) = Aimag(L2(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+148) = Real(Yu(i1,i2), dp) 
g(SumI+149) = Aimag(Yu(i1,i2)) 
End Do 
End Do 

Iname = Iname - 1 
 
End Subroutine ParametersToG165

Subroutine rge165(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,Dg3
Complex(dp) :: Yd(3,3),betaYd1(3,3),betaYd2(3,3),DYd(3,3),adjYd(3,3),Ye(3,3)          & 
& ,betaYe1(3,3),betaYe2(3,3),DYe(3,3),adjYe(3,3),L1(3,3,3),betaL11(3,3,3),               & 
& betaL12(3,3,3),DL1(3,3,3),L2(3,3,3),betaL21(3,3,3),betaL22(3,3,3),DL2(3,3,3)           & 
& ,Yu(3,3),betaYu1(3,3),betaYu2(3,3),DYu(3,3),adjYu(3,3)
Complex(dp) :: YdadjYd(3,3),YeadjYe(3,3),YuadjYu(3,3),adjYdYd(3,3),adjYeYe(3,3),adjYuYu(3,3),        & 
& adjL21L11(3,3),adjL21L12(3,3),adjL21L13(3,3),adjL21L21(3,3),adjL21L22(3,3),            & 
& adjL21L23(3,3),adjL22L11(3,3),adjL22L12(3,3),adjL22L13(3,3),adjL22L21(3,3),            & 
& adjL22L22(3,3),adjL22L23(3,3),adjL23L11(3,3),adjL23L12(3,3),adjL23L13(3,3),            & 
& adjL23L21(3,3),adjL23L22(3,3),adjL23L23(3,3),CYdTpL21(3,3),CYdTpL22(3,3),              & 
& CYdTpL23(3,3),CYeL11(3,3),CYeL12(3,3),CYeL13(3,3),CYeL21(3,3),CYeL22(3,3),             & 
& CYeL23(3,3),CL11L11(3,3),CL11L12(3,3),CL11L13(3,3),CL11L21(3,3),CL11L22(3,3),          & 
& CL11L23(3,3),CL11TpYe(3,3),CL12L11(3,3),CL12L12(3,3),CL12L13(3,3),CL12L21(3,3),        & 
& CL12L22(3,3),CL12L23(3,3),CL12TpYe(3,3),CL13L11(3,3),CL13L12(3,3),CL13L13(3,3),        & 
& CL13L21(3,3),CL13L22(3,3),CL13L23(3,3),CL13TpYe(3,3),CL21TpYd(3,3),CL21TpL21(3,3),     & 
& CL21TpL22(3,3),CL21TpL23(3,3),CL22TpYd(3,3),CL22TpL21(3,3),CL22TpL22(3,3),             & 
& CL22TpL23(3,3),CL23TpYd(3,3),CL23TpL21(3,3),CL23TpL22(3,3),CL23TpL23(3,3),             & 
& YdadjYdYd(3,3),YdadjYuYu(3,3),YdadjL21L21(3,3),YdadjL21L22(3,3),YdadjL21L23(3,3),      & 
& YdadjL22L21(3,3),YdadjL22L22(3,3),YdadjL22L23(3,3),YdadjL23L21(3,3),YdadjL23L22(3,3),  & 
& YdadjL23L23(3,3),YeadjYeYe(3,3),YeCL11L11(3,3),YeCL11L21(3,3),YeCL11L22(3,3),          & 
& YeCL11L23(3,3),YeCL12L12(3,3),YeCL12L21(3,3),YeCL12L22(3,3),YeCL12L23(3,3),            & 
& YeCL13L13(3,3),YeCL13L21(3,3),YeCL13L22(3,3),YeCL13L23(3,3),YeCL21TpL21(3,3),          & 
& YeCL22TpL22(3,3),YeCL23TpL23(3,3),YuadjYdYd(3,3),YuadjYuYu(3,3),YuadjL21L21(3,3),      & 
& YuadjL22L22(3,3),YuadjL23L23(3,3),L11adjYeYe(3,3),L11CL11L11(3,3),L11CL11L12(3,3),     & 
& L11CL11L13(3,3),L11CL11L21(3,3),L11CL11L22(3,3),L11CL11L23(3,3),L11CL11TpYe(3,3),      & 
& L11CL12L12(3,3),L11CL12TpYe(3,3),L11CL13L13(3,3),L11CL13TpYe(3,3),L11CL21TpYd(3,3),    & 
& L11CL21TpL21(3,3),L11CL22TpYd(3,3),L11CL22TpL22(3,3),L11CL23TpYd(3,3),L11CL23TpL23(3,3),& 
& L12adjYeYe(3,3),L12CL11L11(3,3),L12CL11TpYe(3,3),L12CL12L11(3,3),L12CL12L12(3,3),      & 
& L12CL12L13(3,3),L12CL12L21(3,3),L12CL12L22(3,3),L12CL12L23(3,3),L12CL12TpYe(3,3),      & 
& L12CL13L13(3,3),L12CL13TpYe(3,3),L12CL21TpYd(3,3),L12CL21TpL21(3,3),L12CL22TpYd(3,3),  & 
& L12CL22TpL22(3,3),L12CL23TpYd(3,3),L12CL23TpL23(3,3),L13adjYeYe(3,3),L13CL11L11(3,3),  & 
& L13CL11TpYe(3,3),L13CL12L12(3,3),L13CL12TpYe(3,3),L13CL13L11(3,3),L13CL13L12(3,3),     & 
& L13CL13L13(3,3),L13CL13L21(3,3),L13CL13L22(3,3),L13CL13L23(3,3),L13CL13TpYe(3,3),      & 
& L13CL21TpYd(3,3),L13CL21TpL21(3,3),L13CL22TpYd(3,3),L13CL22TpL22(3,3),L13CL23TpYd(3,3),& 
& L13CL23TpL23(3,3),L21adjYdYd(3,3),L21adjYuYu(3,3),L21adjL21L11(3,3),L21adjL21L12(3,3), & 
& L21adjL21L13(3,3),L21adjL21L21(3,3),L21adjL21L22(3,3),L21adjL21L23(3,3),               & 
& L21adjL22L22(3,3),L21adjL23L23(3,3),L22adjYdYd(3,3),L22adjYuYu(3,3),L22adjL21L21(3,3), & 
& L22adjL22L11(3,3),L22adjL22L12(3,3),L22adjL22L13(3,3),L22adjL22L21(3,3),               & 
& L22adjL22L22(3,3),L22adjL22L23(3,3),L22adjL23L23(3,3),L23adjYdYd(3,3),L23adjYuYu(3,3), & 
& L23adjL21L21(3,3),L23adjL22L22(3,3),L23adjL23L11(3,3),L23adjL23L12(3,3),               & 
& L23adjL23L13(3,3),L23adjL23L21(3,3),L23adjL23L22(3,3),L23adjL23L23(3,3),               & 
& TpYeCYeL11(3,3),TpYeCYeL12(3,3),TpYeCYeL13(3,3),TpYeCYeL21(3,3),TpYeCYeL22(3,3)

Complex(dp) :: TpYeCYeL23(3,3)

Complex(dp) :: YuadjYd(3,3),adjYdYdadjYd(3,3),adjYeYeadjYe(3,3),adjYuYuadjYd(3,3),adjYuYuadjYu(3,3), & 
& YdadjYdYdadjYd(3,3),YdadjYuYuadjYd(3,3),YeadjYeYeadjYe(3,3),YuadjYuYuadjYu(3,3),       & 
& adjYdYdadjYdYd(3,3),adjYdYdadjYuYu(3,3),adjYeYeadjYeYe(3,3),adjYuYuadjYdYd(3,3),       & 
& adjYuYuadjYuYu(3,3),YdadjYdYdadjYdYd(3,3),YdadjYuYuadjYdYd(3,3),YdadjYuYuadjYuYu(3,3), & 
& YeadjYeYeadjYeYe(3,3),YuadjYdYdadjYdYd(3,3),YuadjYdYdadjYuYu(3,3),YuadjYuYuadjYuYu(3,3)

Complex(dp) :: TrYdadjYd,TrYeadjYe,TrYuadjYu,TrCL11L11,TrCL11L12,TrCL11L13,TrCL12L11,TrCL12L12,      & 
& TrCL12L13,TrCL13L11,TrCL13L12,TrCL13L13,TrCL21TpL21,TrCL21TpL22,TrCL21TpL23,           & 
& TrCL22TpL21,TrCL22TpL22,TrCL22TpL23,TrCL23TpL21,TrCL23TpL22,TrCL23TpL23

Complex(dp) :: TrYdadjYdYdadjYd,TrYdadjYuYuadjYd,TrYeadjYeYeadjYe,TrYuadjYuYuadjYu

Real(dp) :: g1p2,g1p3,g2p2,g2p3,g3p2,g3p3

Real(dp) :: g1p4,g1p5,g2p4,g2p5,g3p4,g3p5

Complex(dp) :: L11(3,3), adjL11(3,3) 
Complex(dp) :: L12(3,3), adjL12(3,3) 
Complex(dp) :: L13(3,3), adjL13(3,3) 
Complex(dp) :: L21(3,3), adjL21(3,3) 
Complex(dp) :: L22(3,3), adjL22(3,3) 
Complex(dp) :: L23(3,3), adjL23(3,3) 
Iname = Iname +1 
NameOfUnit(Iname) = 'rge165' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters165(gy,g1,g2,g3,Yd,Ye,L1,L2,Yu)

L11=L1(:,:,1) 
Call Adjungate(L11,adjL11) 
L12=L1(:,:,2) 
Call Adjungate(L12,adjL12) 
L13=L1(:,:,3) 
Call Adjungate(L13,adjL13) 
L21=L2(:,:,1) 
Call Adjungate(L21,adjL21) 
L22=L2(:,:,2) 
Call Adjungate(L22,adjL22) 
L23=L2(:,:,3) 
Call Adjungate(L23,adjL23) 
Call Adjungate(Yd,adjYd)
Call Adjungate(Ye,adjYe)
Call Adjungate(Yu,adjYu)
 YdadjYd = Matmul(Yd,adjYd) 
Forall(i2=1:3)  YdadjYd(i2,i2) =  Real(YdadjYd(i2,i2),dp) 
 YeadjYe = Matmul(Ye,adjYe) 
Forall(i2=1:3)  YeadjYe(i2,i2) =  Real(YeadjYe(i2,i2),dp) 
 YuadjYu = Matmul(Yu,adjYu) 
Forall(i2=1:3)  YuadjYu(i2,i2) =  Real(YuadjYu(i2,i2),dp) 
 adjYdYd = Matmul(adjYd,Yd) 
Forall(i2=1:3)  adjYdYd(i2,i2) =  Real(adjYdYd(i2,i2),dp) 
 adjYeYe = Matmul(adjYe,Ye) 
Forall(i2=1:3)  adjYeYe(i2,i2) =  Real(adjYeYe(i2,i2),dp) 
 adjYuYu = Matmul(adjYu,Yu) 
Forall(i2=1:3)  adjYuYu(i2,i2) =  Real(adjYuYu(i2,i2),dp) 
 adjL21L11 = Matmul(adjL21,L11) 
 adjL21L12 = Matmul(adjL21,L12) 
 adjL21L13 = Matmul(adjL21,L13) 
 adjL21L21 = Matmul(adjL21,L21) 
 adjL21L22 = Matmul(adjL21,L22) 
 adjL21L23 = Matmul(adjL21,L23) 
 adjL22L11 = Matmul(adjL22,L11) 
 adjL22L12 = Matmul(adjL22,L12) 
 adjL22L13 = Matmul(adjL22,L13) 
 adjL22L21 = Matmul(adjL22,L21) 
 adjL22L22 = Matmul(adjL22,L22) 
 adjL22L23 = Matmul(adjL22,L23) 
 adjL23L11 = Matmul(adjL23,L11) 
 adjL23L12 = Matmul(adjL23,L12) 
 adjL23L13 = Matmul(adjL23,L13) 
 adjL23L21 = Matmul(adjL23,L21) 
 adjL23L22 = Matmul(adjL23,L22) 
 adjL23L23 = Matmul(adjL23,L23) 
 CYdTpL21 = Matmul(Conjg(Yd),Transpose(L21)) 
 CYdTpL22 = Matmul(Conjg(Yd),Transpose(L22)) 
 CYdTpL23 = Matmul(Conjg(Yd),Transpose(L23)) 
 CYeL11 = Matmul(Conjg(Ye),L11) 
 CYeL12 = Matmul(Conjg(Ye),L12) 
 CYeL13 = Matmul(Conjg(Ye),L13) 
 CYeL21 = Matmul(Conjg(Ye),L21) 
 CYeL22 = Matmul(Conjg(Ye),L22) 
 CYeL23 = Matmul(Conjg(Ye),L23) 
 CL11L11 = Matmul(Conjg(L11),L11) 
 CL11L12 = Matmul(Conjg(L11),L12) 
 CL11L13 = Matmul(Conjg(L11),L13) 
 CL11L21 = Matmul(Conjg(L11),L21) 
 CL11L22 = Matmul(Conjg(L11),L22) 
 CL11L23 = Matmul(Conjg(L11),L23) 
 CL11TpYe = Matmul(Conjg(L11),Transpose(Ye)) 
 CL12L11 = Matmul(Conjg(L12),L11) 
 CL12L12 = Matmul(Conjg(L12),L12) 
 CL12L13 = Matmul(Conjg(L12),L13) 
 CL12L21 = Matmul(Conjg(L12),L21) 
 CL12L22 = Matmul(Conjg(L12),L22) 
 CL12L23 = Matmul(Conjg(L12),L23) 
 CL12TpYe = Matmul(Conjg(L12),Transpose(Ye)) 
 CL13L11 = Matmul(Conjg(L13),L11) 
 CL13L12 = Matmul(Conjg(L13),L12) 
 CL13L13 = Matmul(Conjg(L13),L13) 
 CL13L21 = Matmul(Conjg(L13),L21) 
 CL13L22 = Matmul(Conjg(L13),L22) 
 CL13L23 = Matmul(Conjg(L13),L23) 
 CL13TpYe = Matmul(Conjg(L13),Transpose(Ye)) 
 CL21TpYd = Matmul(Conjg(L21),Transpose(Yd)) 
 CL21TpL21 = Matmul(Conjg(L21),Transpose(L21)) 
Forall(i2=1:3)  CL21TpL21(i2,i2) =  Real(CL21TpL21(i2,i2),dp) 
 CL21TpL22 = Matmul(Conjg(L21),Transpose(L22)) 
 CL21TpL23 = Matmul(Conjg(L21),Transpose(L23)) 
 CL22TpYd = Matmul(Conjg(L22),Transpose(Yd)) 
 CL22TpL21 = Matmul(Conjg(L22),Transpose(L21)) 
 CL22TpL22 = Matmul(Conjg(L22),Transpose(L22)) 
Forall(i2=1:3)  CL22TpL22(i2,i2) =  Real(CL22TpL22(i2,i2),dp) 
 CL22TpL23 = Matmul(Conjg(L22),Transpose(L23)) 
 CL23TpYd = Matmul(Conjg(L23),Transpose(Yd)) 
 CL23TpL21 = Matmul(Conjg(L23),Transpose(L21)) 
 CL23TpL22 = Matmul(Conjg(L23),Transpose(L22)) 
 CL23TpL23 = Matmul(Conjg(L23),Transpose(L23)) 
Forall(i2=1:3)  CL23TpL23(i2,i2) =  Real(CL23TpL23(i2,i2),dp) 
 YdadjYdYd = Matmul(Yd,adjYdYd) 
 YdadjYuYu = Matmul(Yd,adjYuYu) 
 YdadjL21L21 = Matmul(Yd,adjL21L21) 
 YdadjL21L22 = Matmul(Yd,adjL21L22) 
 YdadjL21L23 = Matmul(Yd,adjL21L23) 
 YdadjL22L21 = Matmul(Yd,adjL22L21) 
 YdadjL22L22 = Matmul(Yd,adjL22L22) 
 YdadjL22L23 = Matmul(Yd,adjL22L23) 
 YdadjL23L21 = Matmul(Yd,adjL23L21) 
 YdadjL23L22 = Matmul(Yd,adjL23L22) 
 YdadjL23L23 = Matmul(Yd,adjL23L23) 
 YeadjYeYe = Matmul(Ye,adjYeYe) 
 YeCL11L11 = Matmul(Ye,CL11L11) 
 YeCL11L21 = Matmul(Ye,CL11L21) 
 YeCL11L22 = Matmul(Ye,CL11L22) 
 YeCL11L23 = Matmul(Ye,CL11L23) 
 YeCL12L12 = Matmul(Ye,CL12L12) 
 YeCL12L21 = Matmul(Ye,CL12L21) 
 YeCL12L22 = Matmul(Ye,CL12L22) 
 YeCL12L23 = Matmul(Ye,CL12L23) 
 YeCL13L13 = Matmul(Ye,CL13L13) 
 YeCL13L21 = Matmul(Ye,CL13L21) 
 YeCL13L22 = Matmul(Ye,CL13L22) 
 YeCL13L23 = Matmul(Ye,CL13L23) 
 YeCL21TpL21 = Matmul(Ye,CL21TpL21) 
 YeCL22TpL22 = Matmul(Ye,CL22TpL22) 
 YeCL23TpL23 = Matmul(Ye,CL23TpL23) 
 YuadjYdYd = Matmul(Yu,adjYdYd) 
 YuadjYuYu = Matmul(Yu,adjYuYu) 
 YuadjL21L21 = Matmul(Yu,adjL21L21) 
 YuadjL22L22 = Matmul(Yu,adjL22L22) 
 YuadjL23L23 = Matmul(Yu,adjL23L23) 
 L11adjYeYe = Matmul(L11,adjYeYe) 
 L11CL11L11 = Matmul(L11,CL11L11) 
 L11CL11L12 = Matmul(L11,CL11L12) 
 L11CL11L13 = Matmul(L11,CL11L13) 
 L11CL11L21 = Matmul(L11,CL11L21) 
 L11CL11L22 = Matmul(L11,CL11L22) 
 L11CL11L23 = Matmul(L11,CL11L23) 
 L11CL11TpYe = Matmul(L11,CL11TpYe) 
 L11CL12L12 = Matmul(L11,CL12L12) 
 L11CL12TpYe = Matmul(L11,CL12TpYe) 
 L11CL13L13 = Matmul(L11,CL13L13) 
 L11CL13TpYe = Matmul(L11,CL13TpYe) 
 L11CL21TpYd = Matmul(L11,CL21TpYd) 
 L11CL21TpL21 = Matmul(L11,CL21TpL21) 
 L11CL22TpYd = Matmul(L11,CL22TpYd) 
 L11CL22TpL22 = Matmul(L11,CL22TpL22) 
 L11CL23TpYd = Matmul(L11,CL23TpYd) 
 L11CL23TpL23 = Matmul(L11,CL23TpL23) 
 L12adjYeYe = Matmul(L12,adjYeYe) 
 L12CL11L11 = Matmul(L12,CL11L11) 
 L12CL11TpYe = Matmul(L12,CL11TpYe) 
 L12CL12L11 = Matmul(L12,CL12L11) 
 L12CL12L12 = Matmul(L12,CL12L12) 
 L12CL12L13 = Matmul(L12,CL12L13) 
 L12CL12L21 = Matmul(L12,CL12L21) 
 L12CL12L22 = Matmul(L12,CL12L22) 
 L12CL12L23 = Matmul(L12,CL12L23) 
 L12CL12TpYe = Matmul(L12,CL12TpYe) 
 L12CL13L13 = Matmul(L12,CL13L13) 
 L12CL13TpYe = Matmul(L12,CL13TpYe) 
 L12CL21TpYd = Matmul(L12,CL21TpYd) 
 L12CL21TpL21 = Matmul(L12,CL21TpL21) 
 L12CL22TpYd = Matmul(L12,CL22TpYd) 
 L12CL22TpL22 = Matmul(L12,CL22TpL22) 
 L12CL23TpYd = Matmul(L12,CL23TpYd) 
 L12CL23TpL23 = Matmul(L12,CL23TpL23) 
 L13adjYeYe = Matmul(L13,adjYeYe) 
 L13CL11L11 = Matmul(L13,CL11L11) 
 L13CL11TpYe = Matmul(L13,CL11TpYe) 
 L13CL12L12 = Matmul(L13,CL12L12) 
 L13CL12TpYe = Matmul(L13,CL12TpYe) 
 L13CL13L11 = Matmul(L13,CL13L11) 
 L13CL13L12 = Matmul(L13,CL13L12) 
 L13CL13L13 = Matmul(L13,CL13L13) 
 L13CL13L21 = Matmul(L13,CL13L21) 
 L13CL13L22 = Matmul(L13,CL13L22) 
 L13CL13L23 = Matmul(L13,CL13L23) 
 L13CL13TpYe = Matmul(L13,CL13TpYe) 
 L13CL21TpYd = Matmul(L13,CL21TpYd) 
 L13CL21TpL21 = Matmul(L13,CL21TpL21) 
 L13CL22TpYd = Matmul(L13,CL22TpYd) 
 L13CL22TpL22 = Matmul(L13,CL22TpL22) 
 L13CL23TpYd = Matmul(L13,CL23TpYd) 
 L13CL23TpL23 = Matmul(L13,CL23TpL23) 
 L21adjYdYd = Matmul(L21,adjYdYd) 
 L21adjYuYu = Matmul(L21,adjYuYu) 
 L21adjL21L11 = Matmul(L21,adjL21L11) 
 L21adjL21L12 = Matmul(L21,adjL21L12) 
 L21adjL21L13 = Matmul(L21,adjL21L13) 
 L21adjL21L21 = Matmul(L21,adjL21L21) 
 L21adjL21L22 = Matmul(L21,adjL21L22) 
 L21adjL21L23 = Matmul(L21,adjL21L23) 
 L21adjL22L22 = Matmul(L21,adjL22L22) 
 L21adjL23L23 = Matmul(L21,adjL23L23) 
 L22adjYdYd = Matmul(L22,adjYdYd) 
 L22adjYuYu = Matmul(L22,adjYuYu) 
 L22adjL21L21 = Matmul(L22,adjL21L21) 
 L22adjL22L11 = Matmul(L22,adjL22L11) 
 L22adjL22L12 = Matmul(L22,adjL22L12) 
 L22adjL22L13 = Matmul(L22,adjL22L13) 
 L22adjL22L21 = Matmul(L22,adjL22L21) 
 L22adjL22L22 = Matmul(L22,adjL22L22) 
 L22adjL22L23 = Matmul(L22,adjL22L23) 
 L22adjL23L23 = Matmul(L22,adjL23L23) 
 L23adjYdYd = Matmul(L23,adjYdYd) 
 L23adjYuYu = Matmul(L23,adjYuYu) 
 L23adjL21L21 = Matmul(L23,adjL21L21) 
 L23adjL22L22 = Matmul(L23,adjL22L22) 
 L23adjL23L11 = Matmul(L23,adjL23L11) 
 L23adjL23L12 = Matmul(L23,adjL23L12) 
 L23adjL23L13 = Matmul(L23,adjL23L13) 
 L23adjL23L21 = Matmul(L23,adjL23L21) 
 L23adjL23L22 = Matmul(L23,adjL23L22) 
 L23adjL23L23 = Matmul(L23,adjL23L23) 
 TpYeCYeL11 = Matmul(Transpose(Ye),CYeL11) 
 TpYeCYeL12 = Matmul(Transpose(Ye),CYeL12) 
 TpYeCYeL13 = Matmul(Transpose(Ye),CYeL13) 
 TpYeCYeL21 = Matmul(Transpose(Ye),CYeL21) 
 TpYeCYeL22 = Matmul(Transpose(Ye),CYeL22) 
 TpYeCYeL23 = Matmul(Transpose(Ye),CYeL23) 
 TrYdadjYd = Real(cTrace(YdadjYd),dp) 
 TrYeadjYe = Real(cTrace(YeadjYe),dp) 
 TrYuadjYu = Real(cTrace(YuadjYu),dp) 
 TrCL11L11 = cTrace(CL11L11) 
 TrCL11L12 = cTrace(CL11L12) 
 TrCL11L13 = cTrace(CL11L13) 
 TrCL12L11 = cTrace(CL12L11) 
 TrCL12L12 = cTrace(CL12L12) 
 TrCL12L13 = cTrace(CL12L13) 
 TrCL13L11 = cTrace(CL13L11) 
 TrCL13L12 = cTrace(CL13L12) 
 TrCL13L13 = cTrace(CL13L13) 
 TrCL21TpL21 = Real(cTrace(CL21TpL21),dp) 
 TrCL21TpL22 = cTrace(CL21TpL22) 
 TrCL21TpL23 = cTrace(CL21TpL23) 
 TrCL22TpL21 = cTrace(CL22TpL21) 
 TrCL22TpL22 = Real(cTrace(CL22TpL22),dp) 
 TrCL22TpL23 = cTrace(CL22TpL23) 
 TrCL23TpL21 = cTrace(CL23TpL21) 
 TrCL23TpL22 = cTrace(CL23TpL22) 
 TrCL23TpL23 = Real(cTrace(CL23TpL23),dp) 
 g1p2 =g1**2 
 g1p3 =g1**3 
 g2p2 =g2**2 
 g2p3 =g2**3 
 g3p2 =g3**2 
 g3p3 =g3**3 
 g1p4 =g1**4 
 g1p5 =g1**5 
 g2p4 =g2**4 
 g2p5 =g2**5 
 g3p4 =g3**4 
 g3p5 =g3**5 


If (TwoLoopRGE) Then 
 YuadjYd = Matmul(Yu,adjYd) 
 adjYdYdadjYd = Matmul(adjYd,YdadjYd) 
 adjYeYeadjYe = Matmul(adjYe,YeadjYe) 
 adjYuYuadjYd = Matmul(adjYu,YuadjYd) 
 adjYuYuadjYu = Matmul(adjYu,YuadjYu) 
 YdadjYdYdadjYd = Matmul(Yd,adjYdYdadjYd) 
Forall(i2=1:3)  YdadjYdYdadjYd(i2,i2) =  Real(YdadjYdYdadjYd(i2,i2),dp) 
 YdadjYuYuadjYd = Matmul(Yd,adjYuYuadjYd) 
Forall(i2=1:3)  YdadjYuYuadjYd(i2,i2) =  Real(YdadjYuYuadjYd(i2,i2),dp) 
 YeadjYeYeadjYe = Matmul(Ye,adjYeYeadjYe) 
Forall(i2=1:3)  YeadjYeYeadjYe(i2,i2) =  Real(YeadjYeYeadjYe(i2,i2),dp) 
 YuadjYuYuadjYu = Matmul(Yu,adjYuYuadjYu) 
Forall(i2=1:3)  YuadjYuYuadjYu(i2,i2) =  Real(YuadjYuYuadjYu(i2,i2),dp) 
 adjYdYdadjYdYd = Matmul(adjYd,YdadjYdYd) 
Forall(i2=1:3)  adjYdYdadjYdYd(i2,i2) =  Real(adjYdYdadjYdYd(i2,i2),dp) 
 adjYdYdadjYuYu = Matmul(adjYd,YdadjYuYu) 
 adjYeYeadjYeYe = Matmul(adjYe,YeadjYeYe) 
Forall(i2=1:3)  adjYeYeadjYeYe(i2,i2) =  Real(adjYeYeadjYeYe(i2,i2),dp) 
 adjYuYuadjYdYd = Matmul(adjYu,YuadjYdYd) 
 adjYuYuadjYuYu = Matmul(adjYu,YuadjYuYu) 
Forall(i2=1:3)  adjYuYuadjYuYu(i2,i2) =  Real(adjYuYuadjYuYu(i2,i2),dp) 
 YdadjYdYdadjYdYd = Matmul(Yd,adjYdYdadjYdYd) 
 YdadjYuYuadjYdYd = Matmul(Yd,adjYuYuadjYdYd) 
 YdadjYuYuadjYuYu = Matmul(Yd,adjYuYuadjYuYu) 
 YeadjYeYeadjYeYe = Matmul(Ye,adjYeYeadjYeYe) 
 YuadjYdYdadjYdYd = Matmul(Yu,adjYdYdadjYdYd) 
 YuadjYdYdadjYuYu = Matmul(Yu,adjYdYdadjYuYu) 
 YuadjYuYuadjYuYu = Matmul(Yu,adjYuYuadjYuYu) 
 TrYdadjYdYdadjYd = Real(cTrace(YdadjYdYdadjYd),dp)  
 TrYdadjYuYuadjYd = Real(cTrace(YdadjYuYuadjYd),dp)  
 TrYeadjYeYeadjYe = Real(cTrace(YeadjYeYeadjYe),dp)  
 TrYuadjYuYuadjYu = Real(cTrace(YuadjYuYuadjYu),dp)  
 g1p4 =g1**4 
 g1p5 =g1**5 
 g2p4 =g2**4 
 g2p5 =g2**5 
 g3p4 =g3**4 
 g3p5 =g3**5 
End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 33._dp*(g1p3)/5._dp

 
 
If (TwoLoopRGE) Then 
betag12 = 199._dp*(g1p5)/25._dp + (27*g1p3*g2p2)/5._dp + (88*g1p3*g3p2)/5._dp - (14*g1p3*TrYdadjYd)/5._dp -& 
&  (18*g1p3*TrYeadjYe)/5._dp - (26*g1p3*TrYuadjYu)/5._dp

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = g2p3

 
 
If (TwoLoopRGE) Then 
betag22 = (9*g1p2*g2p3)/5._dp + 25._dp*(g2p5) + 24*g2p3*g3p2 - 6*g2p3*TrYdadjYd -               & 
&  2*g2p3*TrYeadjYe - 6*g2p3*TrYuadjYu

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = -3._dp*(g3p3)

 
 
If (TwoLoopRGE) Then 
betag32 = (11*g1p2*g3p3)/5._dp + 9*g2p2*g3p3 + 14._dp*(g3p5) - 4*g3p3*TrYdadjYd -               & 
&  4*g3p3*TrYuadjYu

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! Yd 
!-------------------- 
 
betaYd1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYd1(i1,i2) = (-7*g1p2*Yd(i1,i2))/15._dp - 3*g2p2*Yd(i1,i2) - (16*g3p2*Yd(i1,i2))/3._dp +           & 
&  3*TrYdadjYd*Yd(i1,i2) + TrYeadjYe*Yd(i1,i2) + YdadjL21L21(i1,i2) + YdadjL22L22(i1,    & 
& i2) + YdadjL23L23(i1,i2) + 3*YdadjYdYd(i1,i2) + YdadjYuYu(i1,i2)
If (1.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL21*Yd(1,i2) + 2*TrCL22TpL21*Yd(2,i2) + 2*TrCL23TpL21*Yd(3,i2) +            & 
&  3*YdadjL21L21(1,i2) + 3*YdadjL22L21(2,i2) + 3*YdadjL23L21(3,i2) - YeCL11L21(1,        & 
& i2) - YeCL12L21(2,i2) - YeCL13L21(3,i2)
End If 
If (2.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL22*Yd(1,i2) + 2*TrCL22TpL22*Yd(2,i2) + 2*TrCL23TpL22*Yd(3,i2) +            & 
&  3*YdadjL21L22(1,i2) + 3*YdadjL22L22(2,i2) + 3*YdadjL23L22(3,i2) - YeCL11L22(1,        & 
& i2) - YeCL12L22(2,i2) - YeCL13L22(3,i2)
End If 
If (3.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL23*Yd(1,i2) + 2*TrCL22TpL23*Yd(2,i2) + 2*TrCL23TpL23*Yd(3,i2) +            & 
&  3*YdadjL21L23(1,i2) + 3*YdadjL22L23(2,i2) + 3*YdadjL23L23(3,i2) - YeCL11L23(1,        & 
& i2) - YeCL12L23(2,i2) - YeCL13L23(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaYd2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYd2(i1,i2) = (287*g1p4*Yd(i1,i2))/90._dp + g1p2*g2p2*Yd(i1,i2) + (15*g2p4*Yd(i1,i2))/2._dp +       & 
&  (8*g1p2*g3p2*Yd(i1,i2))/9._dp + 8*g2p2*g3p2*Yd(i1,i2) - (16*g3p4*Yd(i1,               & 
& i2))/9._dp - (2*g1p2*TrYdadjYd*Yd(i1,i2))/5._dp + 16*g3p2*TrYdadjYd*Yd(i1,             & 
& i2) - 9*TrYdadjYdYdadjYd*Yd(i1,i2) - 3*TrYdadjYuYuadjYd*Yd(i1,i2) + (6*g1p2*TrYeadjYe*Yd(i1,& 
& i2))/5._dp - 3*TrYeadjYeYeadjYe*Yd(i1,i2) + (4*g1p2*YdadjYdYd(i1,i2))/5._dp +          & 
&  6*g2p2*YdadjYdYd(i1,i2) - 9*TrYdadjYd*YdadjYdYd(i1,i2) - 3*TrYeadjYe*YdadjYdYd(i1,    & 
& i2) - 4*YdadjYdYdadjYdYd(i1,i2) + (4*g1p2*YdadjYuYu(i1,i2))/5._dp - 3*TrYuadjYu*YdadjYuYu(i1,& 
& i2) - 2*YdadjYuYuadjYdYd(i1,i2) - 2*YdadjYuYuadjYuYu(i1,i2)
End Do
End Do

 
DYd = oo16pi2*( betaYd1 + oo16pi2 * betaYd2 ) 

 
Else 
DYd = oo16pi2* betaYd1 
End If 
 
 
Call Chop(DYd) 

!-------------------- 
! Ye 
!-------------------- 
 
betaYe1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYe1(i1,i2) = (-9*g1p2*Ye(i1,i2))/5._dp - 3*g2p2*Ye(i1,i2) + 3*TrYdadjYd*Ye(i1,i2) + TrYeadjYe*Ye(i1,& 
& i2) + 3*YeadjYeYe(i1,i2) - YeCL11L11(i1,i2) - YeCL12L12(i1,i2) - YeCL13L13(i1,         & 
& i2) + 3*YeCL21TpL21(i1,i2) + 3*YeCL22TpL22(i1,i2) + 3*YeCL23TpL23(i1,i2)
If (1.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L11CL11TpYe(i2,1) - L11CL12TpYe(i2,2) - L11CL13TpYe(i2,3) - 3*L11CL21TpYd(i2,        & 
& 1) - 3*L11CL22TpYd(i2,2) - 3*L11CL23TpYd(i2,3) - TrCL11L11*Ye(1,i2) - TrCL12L11*Ye(2,  & 
& i2) - TrCL13L11*Ye(3,i2)
End If 
If (2.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L12CL11TpYe(i2,1) - L12CL12TpYe(i2,2) - L12CL13TpYe(i2,3) - 3*L12CL21TpYd(i2,        & 
& 1) - 3*L12CL22TpYd(i2,2) - 3*L12CL23TpYd(i2,3) - TrCL11L12*Ye(1,i2) - TrCL12L12*Ye(2,  & 
& i2) - TrCL13L12*Ye(3,i2)
End If 
If (3.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L13CL11TpYe(i2,1) - L13CL12TpYe(i2,2) - L13CL13TpYe(i2,3) - 3*L13CL21TpYd(i2,        & 
& 1) - 3*L13CL22TpYd(i2,2) - 3*L13CL23TpYd(i2,3) - TrCL11L13*Ye(1,i2) - TrCL12L13*Ye(2,  & 
& i2) - TrCL13L13*Ye(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaYe2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYe2(i1,i2) = (27*g1p4*Ye(i1,i2))/2._dp + (9*g1p2*g2p2*Ye(i1,i2))/5._dp + (15*g2p4*Ye(i1,           & 
& i2))/2._dp - (2*g1p2*TrYdadjYd*Ye(i1,i2))/5._dp + 16*g3p2*TrYdadjYd*Ye(i1,             & 
& i2) - 9*TrYdadjYdYdadjYd*Ye(i1,i2) - 3*TrYdadjYuYuadjYd*Ye(i1,i2) + (6*g1p2*TrYeadjYe*Ye(i1,& 
& i2))/5._dp - 3*TrYeadjYeYeadjYe*Ye(i1,i2) + 6*g2p2*YeadjYeYe(i1,i2) - 9*TrYdadjYd*YeadjYeYe(i1,& 
& i2) - 3*TrYeadjYe*YeadjYeYe(i1,i2) - 4*YeadjYeYeadjYeYe(i1,i2)
End Do
End Do

 
DYe = oo16pi2*( betaYe1 + oo16pi2 * betaYe2 ) 

 
Else 
DYe = oo16pi2* betaYe1 
End If 
 
 
Call Chop(DYe) 

!-------------------- 
! L1 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,1) = L11adjYeYe(i1,i2) - 2*L11CL11L11(i1,i2) - L11CL12L12(i1,i2) - L11CL13L13(i1,          & 
& i2) + 3*L11CL21TpL21(i1,i2) + 3*L11CL22TpL22(i1,i2) + 3*L11CL23TpL23(i1,               & 
& i2) - L12CL12L11(i1,i2) - L13CL13L11(i1,i2) + 3*L21adjL21L11(i1,i2) + 3*L22adjL22L11(i1,& 
& i2) + 3*L23adjL23L11(i1,i2) + TpYeCYeL11(i1,i2) - (9*g1p2*L11(i1,i2))/5._dp -          & 
&  3*g2p2*L11(i1,i2) - TrCL11L11*L11(i1,i2) - TrCL12L11*L12(i1,i2) - TrCL13L11*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,2) = -L11CL11L12(i1,i2) + L12adjYeYe(i1,i2) - L12CL11L11(i1,i2) - 2*L12CL12L12(i1,         & 
& i2) - L12CL13L13(i1,i2) + 3*L12CL21TpL21(i1,i2) + 3*L12CL22TpL22(i1,i2) +              & 
&  3*L12CL23TpL23(i1,i2) - L13CL13L12(i1,i2) + 3*L21adjL21L12(i1,i2) + 3*L22adjL22L12(i1,& 
& i2) + 3*L23adjL23L12(i1,i2) + TpYeCYeL12(i1,i2) - TrCL11L12*L11(i1,i2) -               & 
&  (9*g1p2*L12(i1,i2))/5._dp - 3*g2p2*L12(i1,i2) - TrCL12L12*L12(i1,i2) - TrCL13L12*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,3) = -L11CL11L13(i1,i2) - L12CL12L13(i1,i2) + L13adjYeYe(i1,i2) - L13CL11L11(i1,           & 
& i2) - L13CL12L12(i1,i2) - 2*L13CL13L13(i1,i2) + 3*L13CL21TpL21(i1,i2) + 3*L13CL22TpL22(i1,& 
& i2) + 3*L13CL23TpL23(i1,i2) + 3*L21adjL21L13(i1,i2) + 3*L22adjL22L13(i1,               & 
& i2) + 3*L23adjL23L13(i1,i2) + TpYeCYeL13(i1,i2) - TrCL11L13*L11(i1,i2) -               & 
&  TrCL12L13*L12(i1,i2) - (9*g1p2*L13(i1,i2))/5._dp - 3*g2p2*L13(i1,i2) - TrCL13L13*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL11(i1,i2,i3) = betaL11(i1,i2,i3)-3*CYdTpL21(1,i2)*Ye(i3,i1) - 3*CYdTpL22(2,i2)*Ye(i3,i1) - 3*CYdTpL23(3,              & 
& i2)*Ye(i3,i1) + CYeL11(1,i2)*Ye(i3,i1) + CYeL12(2,i2)*Ye(i3,i1) + CYeL13(3,            & 
& i2)*Ye(i3,i1) + 3*CYdTpL21(1,i1)*Ye(i3,i2) + 3*CYdTpL22(2,i1)*Ye(i3,i2) +              & 
&  3*CYdTpL23(3,i1)*Ye(i3,i2) - CYeL11(1,i1)*Ye(i3,i2) - CYeL12(2,i1)*Ye(i3,             & 
& i2) - CYeL13(3,i1)*Ye(i3,i2) + 2*YeadjYe(i3,1)*L11(i1,i2) + 2*YeadjYe(i3,              & 
& 2)*L12(i1,i2) + 2*YeadjYe(i3,3)*L13(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL12(i1,i2,i3) = betaL12(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DL1 = oo16pi2*( betaL11 + oo16pi2 * betaL12 ) 

 
Else 
DL1 = oo16pi2* betaL11 
End If 
 
 
!-------------------- 
! L2 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,1) = -L11CL11L21(i1,i2) - L12CL12L21(i1,i2) - L13CL13L21(i1,i2) + 4*L21adjL21L21(i1,       & 
& i2) + L21adjL22L22(i1,i2) + L21adjL23L23(i1,i2) + L21adjYdYd(i1,i2) + L21adjYuYu(i1,   & 
& i2) + 3*L22adjL22L21(i1,i2) + 3*L23adjL23L21(i1,i2) + TpYeCYeL21(i1,i2) -              & 
&  (7*g1p2*L21(i1,i2))/15._dp - 3*g2p2*L21(i1,i2) - (16*g3p2*L21(i1,i2))/3._dp +         & 
&  2*TrCL21TpL21*L21(i1,i2) + 2*TrCL22TpL21*L22(i1,i2) + 2*TrCL23TpL21*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,2) = -L11CL11L22(i1,i2) - L12CL12L22(i1,i2) - L13CL13L22(i1,i2) + 3*L21adjL21L22(i1,       & 
& i2) + L22adjL21L21(i1,i2) + 4*L22adjL22L22(i1,i2) + L22adjL23L23(i1,i2) +              & 
&  L22adjYdYd(i1,i2) + L22adjYuYu(i1,i2) + 3*L23adjL23L22(i1,i2) + TpYeCYeL22(i1,        & 
& i2) + 2*TrCL21TpL22*L21(i1,i2) - (7*g1p2*L22(i1,i2))/15._dp - 3*g2p2*L22(i1,           & 
& i2) - (16*g3p2*L22(i1,i2))/3._dp + 2*TrCL22TpL22*L22(i1,i2) + 2*TrCL23TpL22*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,3) = -L11CL11L23(i1,i2) - L12CL12L23(i1,i2) - L13CL13L23(i1,i2) + 3*L21adjL21L23(i1,       & 
& i2) + 3*L22adjL22L23(i1,i2) + L23adjL21L21(i1,i2) + L23adjL22L22(i1,i2) +              & 
&  4*L23adjL23L23(i1,i2) + L23adjYdYd(i1,i2) + L23adjYuYu(i1,i2) + TpYeCYeL23(i1,        & 
& i2) + 2*TrCL21TpL23*L21(i1,i2) + 2*TrCL22TpL23*L22(i1,i2) - (7*g1p2*L23(i1,            & 
& i2))/15._dp - 3*g2p2*L23(i1,i2) - (16*g3p2*L23(i1,i2))/3._dp + 2*TrCL23TpL23*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL21(i1,i2,i3) = betaL21(i1,i2,i3)+3*CYdTpL21(1,i1)*Yd(i3,i2) + 3*CYdTpL22(2,i1)*Yd(i3,i2) + 3*CYdTpL23(3,               & 
& i1)*Yd(i3,i2) - CYeL11(1,i1)*Yd(i3,i2) - CYeL12(2,i1)*Yd(i3,i2) - CYeL13(3,            & 
& i1)*Yd(i3,i2) + 2*YdadjYd(i3,1)*L21(i1,i2) + 2*YdadjYd(i3,2)*L22(i1,i2) +              & 
&  2*YdadjYd(i3,3)*L23(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL22(i1,i2,i3) = betaL22(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DL2 = oo16pi2*( betaL21 + oo16pi2 * betaL22 ) 

 
Else 
DL2 = oo16pi2* betaL21 
End If 
 
 
!-------------------- 
! Yu 
!-------------------- 
 
betaYu1  = (-13*g1p2*Yu)/15._dp - 3*g2p2*Yu - (16*g3p2*Yu)/3._dp + 3*TrYuadjYu*Yu +   & 
&  YuadjL21L21 + YuadjL22L22 + YuadjL23L23 + YuadjYdYd + 3._dp*(YuadjYuYu)

 
 
If (TwoLoopRGE) Then 
betaYu2 = (2743*g1p4*Yu)/450._dp + g1p2*g2p2*Yu + (15*g2p4*Yu)/2._dp + (136*g1p2*g3p2*Yu)/45._dp +& 
&  8*g2p2*g3p2*Yu - (16*g3p4*Yu)/9._dp - 3*TrYdadjYuYuadjYd*Yu + (4*g1p2*TrYuadjYu*Yu)/5._dp +& 
&  16*g3p2*TrYuadjYu*Yu - 9*TrYuadjYuYuadjYu*Yu + (2*g1p2*YuadjYdYd)/5._dp -             & 
&  3*TrYdadjYd*YuadjYdYd - TrYeadjYe*YuadjYdYd - 2._dp*(YuadjYdYdadjYdYd) -              & 
&  2._dp*(YuadjYdYdadjYuYu) + (2*g1p2*YuadjYuYu)/5._dp + 6*g2p2*YuadjYuYu -              & 
&  9*TrYuadjYu*YuadjYuYu - 4._dp*(YuadjYuYuadjYuYu)

 
DYu = oo16pi2*( betaYu1 + oo16pi2 * betaYu2 ) 

 
Else 
DYu = oo16pi2* betaYu1 
End If 
 
 
Call Chop(DYu) 

Call ParametersToG165(Dg1,Dg2,Dg3,DYd,DYe,DL1,DL2,DYu,f)

Iname = Iname - 1 
 
End Subroutine rge165  

Subroutine GToParameters429(g,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,              & 
& Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3)

Implicit None 
Real(dp), Intent(in) :: g(429) 
Real(dp),Intent(out) :: g1,g2,g3,mHd2,mHu2

Complex(dp),Intent(out) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters429' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yd(i1,i2) = Cmplx( g(SumI+4), g(SumI+5), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Ye(i1,i2) = Cmplx( g(SumI+22), g(SumI+23), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
L1(i1,i2,i3) = Cmplx( g(SumI+40), g(SumI+41), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
L2(i1,i2,i3) = Cmplx( g(SumI+94), g(SumI+95), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yu(i1,i2) = Cmplx( g(SumI+148), g(SumI+149), dp) 
End Do 
 End Do 
 
Mu= Cmplx(g(166),g(167),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Td(i1,i2) = Cmplx( g(SumI+168), g(SumI+169), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Te(i1,i2) = Cmplx( g(SumI+186), g(SumI+187), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
T1(i1,i2,i3) = Cmplx( g(SumI+204), g(SumI+205), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
T2(i1,i2,i3) = Cmplx( g(SumI+258), g(SumI+259), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Tu(i1,i2) = Cmplx( g(SumI+312), g(SumI+313), dp) 
End Do 
 End Do 
 
Bmu= Cmplx(g(330),g(331),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
mq2(i1,i2) = Cmplx( g(SumI+332), g(SumI+333), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
ml2(i1,i2) = Cmplx( g(SumI+350), g(SumI+351), dp) 
End Do 
 End Do 
 
mHd2= g(368) 
mHu2= g(369) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
md2(i1,i2) = Cmplx( g(SumI+370), g(SumI+371), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
mu2(i1,i2) = Cmplx( g(SumI+388), g(SumI+389), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
me2(i1,i2) = Cmplx( g(SumI+406), g(SumI+407), dp) 
End Do 
 End Do 
 
M1= Cmplx(g(424),g(425),dp) 
M2= Cmplx(g(426),g(427),dp) 
M3= Cmplx(g(428),g(429),dp) 
Do i1=1,429 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters429

Subroutine ParametersToG429(g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,            & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,g)

Implicit None 
Real(dp), Intent(out) :: g(429) 
Real(dp), Intent(in) :: g1,g2,g3,mHd2,mHu2

Complex(dp), Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG429' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+4) = Real(Yd(i1,i2), dp) 
g(SumI+5) = Aimag(Yd(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+22) = Real(Ye(i1,i2), dp) 
g(SumI+23) = Aimag(Ye(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+40) = Real(L1(i1,i2,i3), dp) 
g(SumI+41) = Aimag(L1(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+94) = Real(L2(i1,i2,i3), dp) 
g(SumI+95) = Aimag(L2(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+148) = Real(Yu(i1,i2), dp) 
g(SumI+149) = Aimag(Yu(i1,i2)) 
End Do 
End Do 

g(166) = Real(Mu,dp)  
g(167) = Aimag(Mu)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+168) = Real(Td(i1,i2), dp) 
g(SumI+169) = Aimag(Td(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+186) = Real(Te(i1,i2), dp) 
g(SumI+187) = Aimag(Te(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+204) = Real(T1(i1,i2,i3), dp) 
g(SumI+205) = Aimag(T1(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+258) = Real(T2(i1,i2,i3), dp) 
g(SumI+259) = Aimag(T2(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+312) = Real(Tu(i1,i2), dp) 
g(SumI+313) = Aimag(Tu(i1,i2)) 
End Do 
End Do 

g(330) = Real(Bmu,dp)  
g(331) = Aimag(Bmu)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+332) = Real(mq2(i1,i2), dp) 
g(SumI+333) = Aimag(mq2(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+350) = Real(ml2(i1,i2), dp) 
g(SumI+351) = Aimag(ml2(i1,i2)) 
End Do 
End Do 

g(368) = mHd2  
g(369) = mHu2  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+370) = Real(md2(i1,i2), dp) 
g(SumI+371) = Aimag(md2(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+388) = Real(mu2(i1,i2), dp) 
g(SumI+389) = Aimag(mu2(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+406) = Real(me2(i1,i2), dp) 
g(SumI+407) = Aimag(me2(i1,i2)) 
End Do 
End Do 

g(424) = Real(M1,dp)  
g(425) = Aimag(M1)  
g(426) = Real(M2,dp)  
g(427) = Aimag(M2)  
g(428) = Real(M3,dp)  
g(429) = Aimag(M3)  
Iname = Iname - 1 
 
End Subroutine ParametersToG429

Subroutine rge429(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,         & 
& Dg3,mHd2,betamHd21,betamHd22,DmHd2,mHu2,betamHu21,betamHu22,DmHu2
Complex(dp) :: Yd(3,3),betaYd1(3,3),betaYd2(3,3),DYd(3,3),adjYd(3,3),Ye(3,3)          & 
& ,betaYe1(3,3),betaYe2(3,3),DYe(3,3),adjYe(3,3),L1(3,3,3),betaL11(3,3,3),               & 
& betaL12(3,3,3),DL1(3,3,3),L2(3,3,3),betaL21(3,3,3),betaL22(3,3,3),DL2(3,3,3)           & 
& ,Yu(3,3),betaYu1(3,3),betaYu2(3,3),DYu(3,3),adjYu(3,3),Mu,betaMu1,betaMu2,             & 
& DMu,Td(3,3),betaTd1(3,3),betaTd2(3,3),DTd(3,3),adjTd(3,3),Te(3,3),betaTe1(3,3)         & 
& ,betaTe2(3,3),DTe(3,3),adjTe(3,3),T1(3,3,3),betaT11(3,3,3),betaT12(3,3,3)              & 
& ,DT1(3,3,3),T2(3,3,3),betaT21(3,3,3),betaT22(3,3,3),DT2(3,3,3),Tu(3,3),betaTu1(3,3)    & 
& ,betaTu2(3,3),DTu(3,3),adjTu(3,3),Bmu,betaBmu1,betaBmu2,DBmu,mq2(3,3),betamq21(3,3)    & 
& ,betamq22(3,3),Dmq2(3,3),ml2(3,3),betaml21(3,3),betaml22(3,3),Dml2(3,3),               & 
& md2(3,3),betamd21(3,3),betamd22(3,3),Dmd2(3,3),mu2(3,3),betamu21(3,3),betamu22(3,3)    & 
& ,Dmu2(3,3),me2(3,3),betame21(3,3),betame22(3,3),Dme2(3,3),M1,betaM11,betaM12,          & 
& DM1,M2,betaM21,betaM22,DM2,M3,betaM31,betaM32,DM3
Real(dp) :: Tr1(3),Tr2(3),Tr3(3) 
Real(dp) :: Tr2U1(3,3) 
Real(dp) :: AbsM1,AbsM2,AbsM3
Complex(dp) :: md2Yd(3,3),me2Ye(3,3),ml2adjYe(3,3),mq2adjYd(3,3),mq2adjYu(3,3),mu2Yu(3,3),           & 
& Ydmq2(3,3),YdadjYd(3,3),Yeml2(3,3),YeadjYe(3,3),Yumq2(3,3),YuadjYu(3,3),               & 
& adjYdmd2(3,3),adjYdYd(3,3),adjYdTd(3,3),adjYeme2(3,3),adjYeYe(3,3),adjYeTe(3,3),       & 
& adjYumu2(3,3),adjYuYu(3,3),adjYuTu(3,3),adjL21L11(3,3),adjL21L12(3,3),adjL21L13(3,3),  & 
& adjL21L21(3,3),adjL21L22(3,3),adjL21L23(3,3),adjL21T11(3,3),adjL21T12(3,3),            & 
& adjL21T13(3,3),adjL21T21(3,3),adjL21T22(3,3),adjL21T23(3,3),adjL22L11(3,3),            & 
& adjL22L12(3,3),adjL22L13(3,3),adjL22L21(3,3),adjL22L22(3,3),adjL22L23(3,3),            & 
& adjL22T11(3,3),adjL22T12(3,3),adjL22T13(3,3),adjL22T21(3,3),adjL22T22(3,3),            & 
& adjL22T23(3,3),adjL23L11(3,3),adjL23L12(3,3),adjL23L13(3,3),adjL23L21(3,3),            & 
& adjL23L22(3,3),adjL23L23(3,3),adjL23T11(3,3),adjL23T12(3,3),adjL23T13(3,3),            & 
& adjL23T21(3,3),adjL23T22(3,3),adjL23T23(3,3),adjTdTd(3,3),adjTeTe(3,3),adjTuTu(3,3),   & 
& adjT21T21(3,3),adjT22T22(3,3),adjT23T23(3,3),Cml2L11(3,3),Cml2L12(3,3),Cml2L13(3,3),   & 
& Cml2L21(3,3),Cml2L22(3,3),Cml2L23(3,3),Cmq2TpL21(3,3),Cmq2TpL22(3,3),Cmq2TpL23(3,3),   & 
& CYdTpL21(3,3),CYdTpL22(3,3),CYdTpL23(3,3),CYdTpTd(3,3),CYdTpT21(3,3),CYdTpT22(3,3),    & 
& CYdTpT23(3,3),CYeL11(3,3),CYeL12(3,3),CYeL13(3,3),CYeL21(3,3),CYeL22(3,3),             & 
& CYeL23(3,3),CYeTpTe(3,3),CYeT11(3,3),CYeT12(3,3),CYeT13(3,3),CYeT21(3,3),              & 
& CYeT22(3,3),CYeT23(3,3),CL11L11(3,3),CL11L12(3,3),CL11L13(3,3),CL11L21(3,3),           & 
& CL11L22(3,3),CL11L23(3,3),CL11TpYe(3,3),CL11TpTe(3,3),CL11T11(3,3),CL11T12(3,3),       & 
& CL11T13(3,3),CL11T21(3,3),CL11T22(3,3),CL11T23(3,3),CL12L11(3,3),CL12L12(3,3),         & 
& CL12L13(3,3),CL12L21(3,3),CL12L22(3,3),CL12L23(3,3),CL12TpYe(3,3),CL12TpTe(3,3),       & 
& CL12T11(3,3),CL12T12(3,3),CL12T13(3,3),CL12T21(3,3),CL12T22(3,3),CL12T23(3,3),         & 
& CL13L11(3,3),CL13L12(3,3),CL13L13(3,3),CL13L21(3,3),CL13L22(3,3),CL13L23(3,3),         & 
& CL13TpYe(3,3),CL13TpTe(3,3),CL13T11(3,3),CL13T12(3,3),CL13T13(3,3),CL13T21(3,3),       & 
& CL13T22(3,3),CL13T23(3,3),CL21TpYd(3,3),CL21TpL21(3,3),CL21TpL22(3,3),CL21TpL23(3,3),  & 
& CL21TpTd(3,3),CL21TpT21(3,3),CL22TpYd(3,3),CL22TpL21(3,3),CL22TpL22(3,3),              & 
& CL22TpL23(3,3),CL22TpTd(3,3),CL22TpT22(3,3),CL23TpYd(3,3),CL23TpL21(3,3),              & 
& CL23TpL22(3,3),CL23TpL23(3,3),CL23TpTd(3,3),CL23TpT23(3,3),CTdTpTd(3,3),               & 
& CTeTpTe(3,3),CTuTpTu(3,3),CT11T11(3,3),CT11T12(3,3),CT11T13(3,3),CT12T11(3,3),         & 
& CT12T12(3,3),CT12T13(3,3),CT13T11(3,3),CT13T12(3,3),CT13T13(3,3),CT21TpT21(3,3),       & 
& CT21TpT22(3,3),CT21TpT23(3,3),CT22TpT21(3,3),CT22TpT22(3,3),CT22TpT23(3,3),            & 
& CT23TpT21(3,3),CT23TpT22(3,3),CT23TpT23(3,3),L11ml2(3,3),L12ml2(3,3),L13ml2(3,3),      & 
& L21mq2(3,3),L22mq2(3,3),L23mq2(3,3),TdadjTd(3,3),TeadjTe(3,3),TuadjTu(3,3),            & 
& TpL21ml2(3,3),TpL22ml2(3,3),TpL23ml2(3,3),md2YdadjYd(3,3),me2YeadjYe(3,3),             & 
& ml2adjYeYe(3,3),ml2CL11L11(3,3),ml2CL11L12(3,3),ml2CL11L13(3,3),ml2CL12L11(3,3),       & 
& ml2CL12L12(3,3),ml2CL12L13(3,3),ml2CL13L11(3,3),ml2CL13L12(3,3),ml2CL13L13(3,3),       & 
& ml2CL21TpL21(3,3),ml2CL21TpL22(3,3),ml2CL21TpL23(3,3),ml2CL22TpL21(3,3),               & 
& ml2CL22TpL22(3,3),ml2CL22TpL23(3,3),ml2CL23TpL21(3,3),ml2CL23TpL22(3,3)

Complex(dp) :: ml2CL23TpL23(3,3),mq2adjYdYd(3,3),mq2adjYuYu(3,3),mq2adjL21L21(3,3),mq2adjL21L22(3,3), & 
& mq2adjL21L23(3,3),mq2adjL22L21(3,3),mq2adjL22L22(3,3),mq2adjL22L23(3,3),               & 
& mq2adjL23L21(3,3),mq2adjL23L22(3,3),mq2adjL23L23(3,3),mu2YuadjYu(3,3),Ydmq2adjYd(3,3), & 
& YdadjYdmd2(3,3),YdadjYdYd(3,3),YdadjYdTd(3,3),YdadjYuYu(3,3),YdadjYuTu(3,3),           & 
& YdadjL21L21(3,3),YdadjL21L22(3,3),YdadjL21L23(3,3),YdadjL21T11(3,3),YdadjL21T12(3,3),  & 
& YdadjL21T13(3,3),YdadjL21T21(3,3),YdadjL21T22(3,3),YdadjL21T23(3,3),YdadjL22L21(3,3),  & 
& YdadjL22L22(3,3),YdadjL22L23(3,3),YdadjL22T11(3,3),YdadjL22T12(3,3),YdadjL22T13(3,3),  & 
& YdadjL22T21(3,3),YdadjL22T22(3,3),YdadjL22T23(3,3),YdadjL23L21(3,3),YdadjL23L22(3,3),  & 
& YdadjL23L23(3,3),YdadjL23T11(3,3),YdadjL23T12(3,3),YdadjL23T13(3,3),YdadjL23T21(3,3),  & 
& YdadjL23T22(3,3),YdadjL23T23(3,3),Yeml2adjYe(3,3),YeadjYeme2(3,3),YeadjYeYe(3,3),      & 
& YeadjYeTe(3,3),YeCL11L11(3,3),YeCL11L21(3,3),YeCL11L22(3,3),YeCL11L23(3,3),            & 
& YeCL11T11(3,3),YeCL11T12(3,3),YeCL11T13(3,3),YeCL11T21(3,3),YeCL11T22(3,3),            & 
& YeCL11T23(3,3),YeCL12L12(3,3),YeCL12L21(3,3),YeCL12L22(3,3),YeCL12L23(3,3),            & 
& YeCL12T11(3,3),YeCL12T12(3,3),YeCL12T13(3,3),YeCL12T21(3,3),YeCL12T22(3,3),            & 
& YeCL12T23(3,3),YeCL13L13(3,3),YeCL13L21(3,3),YeCL13L22(3,3),YeCL13L23(3,3),            & 
& YeCL13T11(3,3),YeCL13T12(3,3),YeCL13T13(3,3),YeCL13T21(3,3),YeCL13T22(3,3),            & 
& YeCL13T23(3,3),YeCL21TpL21(3,3),YeCL21TpT21(3,3),YeCL22TpL22(3,3),YeCL22TpT22(3,3),    & 
& YeCL23TpL23(3,3),YeCL23TpT23(3,3),Yumq2adjYu(3,3),YuadjYdYd(3,3),YuadjYdTd(3,3),       & 
& YuadjYumu2(3,3),YuadjYuYu(3,3),YuadjYuTu(3,3),YuadjL21L21(3,3),YuadjL21T21(3,3),       & 
& YuadjL22L22(3,3),YuadjL22T22(3,3),YuadjL23L23(3,3),YuadjL23T23(3,3),adjYdmd2Yd(3,3),   & 
& adjYdYdmq2(3,3),adjYeme2Ye(3,3),adjYeYeml2(3,3),adjYumu2Yu(3,3),adjYuYumq2(3,3),       & 
& adjL21Cml2L21(3,3),adjL21L21mq2(3,3),adjL22Cml2L22(3,3),adjL22L22mq2(3,3),             & 
& adjL23Cml2L23(3,3),adjL23L23mq2(3,3),CL11Cml2L11(3,3),CL11L11ml2(3,3),CL12Cml2L12(3,3),& 
& CL12L12ml2(3,3),CL13Cml2L13(3,3),CL13L13ml2(3,3),CL21Cmq2TpL21(3,3),CL21TpL21ml2(3,3), & 
& CL22Cmq2TpL22(3,3),CL22TpL22ml2(3,3),CL23Cmq2TpL23(3,3),CL23TpL23ml2(3,3),             & 
& L11adjYeYe(3,3),L11adjYeTe(3,3),L11CL11L11(3,3),L11CL11L12(3,3),L11CL11L13(3,3),       & 
& L11CL11L21(3,3),L11CL11L22(3,3),L11CL11L23(3,3),L11CL11TpYe(3,3),L11CL11TpTe(3,3),     & 
& L11CL11T11(3,3),L11CL11T12(3,3),L11CL11T13(3,3),L11CL11T21(3,3),L11CL11T22(3,3),       & 
& L11CL11T23(3,3),L11CL12L12(3,3),L11CL12TpYe(3,3),L11CL12TpTe(3,3),L11CL12T12(3,3),     & 
& L11CL13L13(3,3),L11CL13TpYe(3,3),L11CL13TpTe(3,3),L11CL13T13(3,3),L11CL21TpYd(3,3),    & 
& L11CL21TpL21(3,3),L11CL21TpTd(3,3),L11CL21TpT21(3,3),L11CL22TpYd(3,3),L11CL22TpL22(3,3),& 
& L11CL22TpTd(3,3),L11CL22TpT22(3,3),L11CL23TpYd(3,3),L11CL23TpL23(3,3),L11CL23TpTd(3,3),& 
& L11CL23TpT23(3,3),L12adjYeYe(3,3),L12adjYeTe(3,3),L12CL11L11(3,3),L12CL11TpYe(3,3),    & 
& L12CL11TpTe(3,3),L12CL11T11(3,3),L12CL12L11(3,3),L12CL12L12(3,3),L12CL12L13(3,3),      & 
& L12CL12L21(3,3),L12CL12L22(3,3),L12CL12L23(3,3),L12CL12TpYe(3,3),L12CL12TpTe(3,3),     & 
& L12CL12T11(3,3),L12CL12T12(3,3),L12CL12T13(3,3),L12CL12T21(3,3),L12CL12T22(3,3),       & 
& L12CL12T23(3,3),L12CL13L13(3,3),L12CL13TpYe(3,3),L12CL13TpTe(3,3),L12CL13T13(3,3)

Complex(dp) :: L12CL21TpYd(3,3),L12CL21TpL21(3,3),L12CL21TpTd(3,3),L12CL21TpT21(3,3),L12CL22TpYd(3,3),& 
& L12CL22TpL22(3,3),L12CL22TpTd(3,3),L12CL22TpT22(3,3),L12CL23TpYd(3,3),L12CL23TpL23(3,3),& 
& L12CL23TpTd(3,3),L12CL23TpT23(3,3),L13adjYeYe(3,3),L13adjYeTe(3,3),L13CL11L11(3,3),    & 
& L13CL11TpYe(3,3),L13CL11TpTe(3,3),L13CL11T11(3,3),L13CL12L12(3,3),L13CL12TpYe(3,3),    & 
& L13CL12TpTe(3,3),L13CL12T12(3,3),L13CL13L11(3,3),L13CL13L12(3,3),L13CL13L13(3,3),      & 
& L13CL13L21(3,3),L13CL13L22(3,3),L13CL13L23(3,3),L13CL13TpYe(3,3),L13CL13TpTe(3,3),     & 
& L13CL13T11(3,3),L13CL13T12(3,3),L13CL13T13(3,3),L13CL13T21(3,3),L13CL13T22(3,3),       & 
& L13CL13T23(3,3),L13CL21TpYd(3,3),L13CL21TpL21(3,3),L13CL21TpTd(3,3),L13CL21TpT21(3,3), & 
& L13CL22TpYd(3,3),L13CL22TpL22(3,3),L13CL22TpTd(3,3),L13CL22TpT22(3,3),L13CL23TpYd(3,3),& 
& L13CL23TpL23(3,3),L13CL23TpTd(3,3),L13CL23TpT23(3,3),L21adjYdYd(3,3),L21adjYdTd(3,3),  & 
& L21adjYuYu(3,3),L21adjYuTu(3,3),L21adjL21L11(3,3),L21adjL21L12(3,3),L21adjL21L13(3,3), & 
& L21adjL21L21(3,3),L21adjL21L22(3,3),L21adjL21L23(3,3),L21adjL21T11(3,3),               & 
& L21adjL21T12(3,3),L21adjL21T13(3,3),L21adjL21T21(3,3),L21adjL21T22(3,3),               & 
& L21adjL21T23(3,3),L21adjL22L22(3,3),L21adjL22T22(3,3),L21adjL23L23(3,3),               & 
& L21adjL23T23(3,3),L22adjYdYd(3,3),L22adjYdTd(3,3),L22adjYuYu(3,3),L22adjYuTu(3,3),     & 
& L22adjL21L21(3,3),L22adjL21T21(3,3),L22adjL22L11(3,3),L22adjL22L12(3,3),               & 
& L22adjL22L13(3,3),L22adjL22L21(3,3),L22adjL22L22(3,3),L22adjL22L23(3,3),               & 
& L22adjL22T11(3,3),L22adjL22T12(3,3),L22adjL22T13(3,3),L22adjL22T21(3,3),               & 
& L22adjL22T22(3,3),L22adjL22T23(3,3),L22adjL23L23(3,3),L22adjL23T23(3,3),               & 
& L23adjYdYd(3,3),L23adjYdTd(3,3),L23adjYuYu(3,3),L23adjYuTu(3,3),L23adjL21L21(3,3),     & 
& L23adjL21T21(3,3),L23adjL22L22(3,3),L23adjL22T22(3,3),L23adjL23L11(3,3),               & 
& L23adjL23L12(3,3),L23adjL23L13(3,3),L23adjL23L21(3,3),L23adjL23L22(3,3),               & 
& L23adjL23L23(3,3),L23adjL23T11(3,3),L23adjL23T12(3,3),L23adjL23T13(3,3),               & 
& L23adjL23T21(3,3),L23adjL23T22(3,3),L23adjL23T23(3,3),TdadjYdYd(3,3),TdadjYuYu(3,3),   & 
& TdadjL21L21(3,3),TdadjL22L22(3,3),TdadjL23L23(3,3),TeadjYeYe(3,3),TeCL11L11(3,3),      & 
& TeCL12L12(3,3),TeCL13L13(3,3),TeCL21TpL21(3,3),TeCL22TpL22(3,3),TeCL23TpL23(3,3),      & 
& TuadjYdYd(3,3),TuadjYuYu(3,3),TuadjL21L21(3,3),TuadjL22L22(3,3),TuadjL23L23(3,3),      & 
& TpYeCYeL11(3,3),TpYeCYeL12(3,3),TpYeCYeL13(3,3),TpYeCYeL21(3,3),TpYeCYeL22(3,3),       & 
& TpYeCYeL23(3,3),TpYeCYeT11(3,3),TpYeCYeT12(3,3),TpYeCYeT13(3,3),TpYeCYeT21(3,3),       & 
& TpYeCYeT22(3,3),TpYeCYeT23(3,3),TpL21CL11TpTe(3,3),TpL21CL12TpTe(3,3),TpL21CL13TpTe(3,3),& 
& TpL21CL21TpTd(3,3),TpL21CL22TpTd(3,3),TpL21CL23TpTd(3,3),TpL22CL11TpTe(3,3),           & 
& TpL22CL12TpTe(3,3),TpL22CL13TpTe(3,3),TpL22CL21TpTd(3,3),TpL22CL22TpTd(3,3),           & 
& TpL22CL23TpTd(3,3),TpL23CL11TpTe(3,3),TpL23CL12TpTe(3,3),TpL23CL13TpTe(3,3),           & 
& TpL23CL21TpTd(3,3),TpL23CL22TpTd(3,3),TpL23CL23TpTd(3,3),TpTeCYeL11(3,3),              & 
& TpTeCYeL12(3,3),TpTeCYeL13(3,3),TpTeCYeL21(3,3),TpTeCYeL22(3,3),TpTeCYeL23(3,3),       & 
& T11adjYeYe(3,3),T11CL11L11(3,3),T11CL11L12(3,3),T11CL11L13(3,3),T11CL11L21(3,3),       & 
& T11CL11L22(3,3),T11CL11L23(3,3),T11CL12L12(3,3),T11CL13L13(3,3),T11CL21TpL21(3,3)

Complex(dp) :: T11CL22TpL22(3,3),T11CL23TpL23(3,3),T12adjYeYe(3,3),T12CL11L11(3,3),T12CL12L11(3,3),   & 
& T12CL12L12(3,3),T12CL12L13(3,3),T12CL12L21(3,3),T12CL12L22(3,3),T12CL12L23(3,3),       & 
& T12CL13L13(3,3),T12CL21TpL21(3,3),T12CL22TpL22(3,3),T12CL23TpL23(3,3),T13adjYeYe(3,3), & 
& T13CL11L11(3,3),T13CL12L12(3,3),T13CL13L11(3,3),T13CL13L12(3,3),T13CL13L13(3,3),       & 
& T13CL13L21(3,3),T13CL13L22(3,3),T13CL13L23(3,3),T13CL21TpL21(3,3),T13CL22TpL22(3,3),   & 
& T13CL23TpL23(3,3),T21adjYdYd(3,3),T21adjYuYu(3,3),T21adjL21L11(3,3),T21adjL21L12(3,3), & 
& T21adjL21L13(3,3),T21adjL21L21(3,3),T21adjL21L22(3,3),T21adjL21L23(3,3),               & 
& T21adjL22L22(3,3),T21adjL23L23(3,3),T22adjYdYd(3,3),T22adjYuYu(3,3),T22adjL21L21(3,3), & 
& T22adjL22L11(3,3),T22adjL22L12(3,3),T22adjL22L13(3,3),T22adjL22L21(3,3),               & 
& T22adjL22L22(3,3),T22adjL22L23(3,3),T22adjL23L23(3,3),T23adjYdYd(3,3),T23adjYuYu(3,3), & 
& T23adjL21L21(3,3),T23adjL22L22(3,3),T23adjL23L11(3,3),T23adjL23L12(3,3),               & 
& T23adjL23L13(3,3),T23adjL23L21(3,3),T23adjL23L22(3,3),T23adjL23L23(3,3)

Complex(dp) :: YdadjYu(3,3),YdadjTd(3,3),YdadjTu(3,3),YeadjTe(3,3),YuadjYd(3,3),YuadjTd(3,3),        & 
& YuadjTu(3,3),adjYdCmd2(3,3),adjYeCme2(3,3),adjYuCmu2(3,3),adjTdYd(3,3),adjTeYe(3,3),   & 
& adjTuYu(3,3),Cml2adjYe(3,3),Cmq2adjYd(3,3),Cmq2adjYu(3,3),CTdTpYd(3,3),CTeTpYe(3,3),   & 
& CTuTpYu(3,3),L11CL11(3,3),L12CL12(3,3),L13CL13(3,3),L21adjL21(3,3),L22adjL22(3,3),     & 
& L23adjL23(3,3),TdadjYd(3,3),TdadjYu(3,3),TdadjTu(3,3),TeadjYe(3,3),TuadjYd(3,3),       & 
& TuadjYu(3,3),TuadjTd(3,3),TpL21CL21(3,3),TpL22CL22(3,3),TpL23CL23(3,3),md2YdadjYu(3,3),& 
& ml2L11CL11(3,3),ml2L12CL12(3,3),ml2L13CL13(3,3),ml2L21adjL21(3,3),ml2L22adjL22(3,3),   & 
& ml2L23adjL23(3,3),mq2TpL21CL21(3,3),mq2TpL22CL22(3,3),mq2TpL23CL23(3,3),               & 
& mu2YuadjYd(3,3),Ydmq2adjYu(3,3),YdadjYdCmd2(3,3),YdadjYumu2(3,3),YdadjTdTd(3,3),       & 
& YdCmq2adjYd(3,3),YeadjYeCme2(3,3),YeadjTeTe(3,3),YeCml2adjYe(3,3),Yumq2adjYd(3,3),     & 
& YuadjYdmd2(3,3),YuadjYuCmu2(3,3),YuadjTuTu(3,3),YuCmq2adjYu(3,3),adjYdYdadjYd(3,3),    & 
& adjYdYdadjYu(3,3),adjYdYdadjTd(3,3),adjYdYdadjTu(3,3),adjYdTdadjYd(3,3),               & 
& adjYdTdadjYu(3,3),adjYdTdadjTd(3,3),adjYdTdadjTu(3,3),adjYeYeadjYe(3,3),               & 
& adjYeYeadjTe(3,3),adjYeTeadjYe(3,3),adjYeTeadjTe(3,3),adjYuYuadjYd(3,3),               & 
& adjYuYuadjYu(3,3),adjYuYuadjTd(3,3),adjYuYuadjTu(3,3),adjYuTuadjYd(3,3),               & 
& adjYuTuadjYu(3,3),adjYuTuadjTd(3,3),adjYuTuadjTu(3,3),adjTdYdadjYd(3,3),               & 
& adjTdYdadjYu(3,3),adjTdTdadjYd(3,3),adjTdTdadjYu(3,3),adjTeYeadjYe(3,3),               & 
& adjTeTeadjYe(3,3),adjTuYuadjYd(3,3),adjTuYuadjYu(3,3),adjTuTuadjYd(3,3),               & 
& adjTuTuadjYu(3,3),TdadjTdYd(3,3),TeadjTeYe(3,3),TuadjTuYu(3,3),md2YdadjYdYd(3,3),      & 
& me2YeadjYeYe(3,3),ml2adjYeYeadjYe(3,3),mq2adjYdYdadjYd(3,3),mq2adjYdYdadjYu(3,3),      & 
& mq2adjYuYuadjYd(3,3),mq2adjYuYuadjYu(3,3),mu2YuadjYuYu(3,3),Ydmq2adjYdYd(3,3),         & 
& YdadjYdmd2Yd(3,3),YdadjYdYdmq2(3,3),YdadjYdYdadjYd(3,3),YdadjYdTdadjYd(3,3),           & 
& YdadjYdTdadjTd(3,3),YdadjYuYuadjYd(3,3),YdadjYuTuadjYd(3,3),YdadjYuTuadjTd(3,3),       & 
& YdadjTdTdadjYd(3,3),YdadjTuTuadjYd(3,3),Yeml2adjYeYe(3,3),YeadjYeme2Ye(3,3),           & 
& YeadjYeYeml2(3,3),YeadjYeYeadjYe(3,3),YeadjYeTeadjYe(3,3),YeadjYeTeadjTe(3,3),         & 
& YeadjTeTeadjYe(3,3),Yumq2adjYuYu(3,3),YuadjYdYdadjYu(3,3),YuadjYdTdadjYu(3,3),         & 
& YuadjYdTdadjTu(3,3),YuadjYumu2Yu(3,3),YuadjYuYumq2(3,3),YuadjYuYuadjYu(3,3),           & 
& YuadjYuTuadjYu(3,3),YuadjYuTuadjTu(3,3),YuadjTdTdadjYu(3,3),YuadjTuTuadjYu(3,3),       & 
& adjYdmd2YdadjYd(3,3),adjYdmd2YdadjYu(3,3),adjYdYdmq2adjYd(3,3),adjYdYdmq2adjYu(3,3),   & 
& adjYdYdadjYdmd2(3,3),adjYdYdadjYdYd(3,3),adjYdYdadjYdTd(3,3),adjYdYdadjYumu2(3,3),     & 
& adjYdYdadjYuYu(3,3),adjYdYdadjYuTu(3,3),adjYdYdadjTdTd(3,3),adjYdTdadjYdYd(3,3),       & 
& adjYdTdadjYuYu(3,3),adjYdTdadjTdYd(3,3),adjYeme2YeadjYe(3,3),adjYeYeml2adjYe(3,3),     & 
& adjYeYeadjYeme2(3,3),adjYeYeadjYeYe(3,3),adjYeYeadjYeTe(3,3),adjYeYeadjTeTe(3,3),      & 
& adjYeTeadjYeYe(3,3),adjYeTeadjTeYe(3,3),adjYumu2YuadjYd(3,3),adjYumu2YuadjYu(3,3),     & 
& adjYuYumq2adjYd(3,3),adjYuYumq2adjYu(3,3),adjYuYuadjYdmd2(3,3),adjYuYuadjYdYd(3,3),    & 
& adjYuYuadjYdTd(3,3),adjYuYuadjYumu2(3,3),adjYuYuadjYuYu(3,3),adjYuYuadjYuTu(3,3),      & 
& adjYuYuadjTuTu(3,3),adjYuTuadjYdYd(3,3),adjYuTuadjYuYu(3,3),adjYuTuadjTuYu(3,3)

Complex(dp) :: adjTdYdadjYdTd(3,3),adjTdTdadjYdYd(3,3),adjTeYeadjYeTe(3,3),adjTeTeadjYeYe(3,3),       & 
& adjTuYuadjYuTu(3,3),adjTuTuadjYuYu(3,3),TdadjYdYdadjTd(3,3),TdadjYuYuadjTd(3,3),       & 
& TdadjTdYdadjYd(3,3),TdadjTuYuadjYd(3,3),TeadjYeYeadjTe(3,3),TeadjTeYeadjYe(3,3),       & 
& TuadjYdYdadjTu(3,3),TuadjYuYuadjTu(3,3),TuadjTdYdadjYu(3,3),TuadjTuYuadjYu(3,3),       & 
& md2YdadjYdYdadjYd(3,3),md2YdadjYuYuadjYd(3,3),me2YeadjYeYeadjYe(3,3),ml2adjYeYeadjYeYe(3,3),& 
& mq2adjYdYdadjYdYd(3,3),mq2adjYdYdadjYuYu(3,3),mq2adjYuYuadjYdYd(3,3),mq2adjYuYuadjYuYu(3,3),& 
& mu2YuadjYdYdadjYu(3,3),mu2YuadjYuYuadjYu(3,3),Ydmq2adjYdYdadjYd(3,3),Ydmq2adjYuYuadjYd(3,3),& 
& YdadjYdmd2YdadjYd(3,3),YdadjYdYdmq2adjYd(3,3),YdadjYdYdadjYdmd2(3,3),YdadjYdYdadjYdYd(3,3),& 
& YdadjYdYdadjYdTd(3,3),YdadjYdTdadjYdYd(3,3),YdadjYumu2YuadjYd(3,3),YdadjYuYumq2adjYd(3,3),& 
& YdadjYuYuadjYdmd2(3,3),YdadjYuYuadjYdYd(3,3),YdadjYuYuadjYdTd(3,3),YdadjYuYuadjYuYu(3,3),& 
& YdadjYuYuadjYuTu(3,3),YdadjYuTuadjYdYd(3,3),YdadjYuTuadjYuYu(3,3),Yeml2adjYeYeadjYe(3,3),& 
& YeadjYeme2YeadjYe(3,3),YeadjYeYeml2adjYe(3,3),YeadjYeYeadjYeme2(3,3),YeadjYeYeadjYeYe(3,3),& 
& YeadjYeYeadjYeTe(3,3),YeadjYeTeadjYeYe(3,3),Yumq2adjYdYdadjYu(3,3),Yumq2adjYuYuadjYu(3,3),& 
& YuadjYdmd2YdadjYu(3,3),YuadjYdYdmq2adjYu(3,3),YuadjYdYdadjYdYd(3,3),YuadjYdYdadjYdTd(3,3),& 
& YuadjYdYdadjYumu2(3,3),YuadjYdYdadjYuYu(3,3),YuadjYdYdadjYuTu(3,3),YuadjYdTdadjYdYd(3,3),& 
& YuadjYdTdadjYuYu(3,3),YuadjYumu2YuadjYu(3,3),YuadjYuYumq2adjYu(3,3),YuadjYuYuadjYumu2(3,3),& 
& YuadjYuYuadjYuYu(3,3),YuadjYuYuadjYuTu(3,3),YuadjYuTuadjYuYu(3,3),adjYdmd2YdadjYdYd(3,3),& 
& adjYdYdmq2adjYdYd(3,3),adjYdYdadjYdmd2Yd(3,3),adjYdYdadjYdYdmq2(3,3),adjYeme2YeadjYeYe(3,3),& 
& adjYeYeml2adjYeYe(3,3),adjYeYeadjYeme2Ye(3,3),adjYeYeadjYeYeml2(3,3),adjYumu2YuadjYuYu(3,3),& 
& adjYuYumq2adjYuYu(3,3),adjYuYuadjYumu2Yu(3,3),adjYuYuadjYuYumq2(3,3),TdadjYdYdadjYdYd(3,3),& 
& TdadjYuYuadjYdYd(3,3),TdadjYuYuadjYuYu(3,3),TeadjYeYeadjYeYe(3,3),TuadjYdYdadjYdYd(3,3),& 
& TuadjYdYdadjYuYu(3,3),TuadjYuYuadjYuYu(3,3)

Complex(dp) :: Trmd2,Trme2,Trml2,Trmq2,Trmu2,TrYdadjYd,TrYeadjYe,TrYuadjYu,TradjYdTd,TradjYeTe,      & 
& TradjYuTu,TradjL21T21,TradjL21T22,TradjL21T23,TradjL22T21,TradjL22T22,TradjL22T23,     & 
& TradjL23T21,TradjL23T22,TradjL23T23,TrCL11L11,TrCL11L12,TrCL11L13,TrCL11T11,           & 
& TrCL11T12,TrCL11T13,TrCL12L11,TrCL12L12,TrCL12L13,TrCL12T11,TrCL12T12,TrCL12T13,       & 
& TrCL13L11,TrCL13L12,TrCL13L13,TrCL13T11,TrCL13T12,TrCL13T13,TrCL21TpL21,               & 
& TrCL21TpL22,TrCL21TpL23,TrCL22TpL21,TrCL22TpL22,TrCL22TpL23,TrCL23TpL21,               & 
& TrCL23TpL22,TrCL23TpL23,TrCTdTpTd,TrCTeTpTe,TrCTuTpTu,TrCT11T11,TrCT11T12,             & 
& TrCT11T13,TrCT12T11,TrCT12T12,TrCT12T13,TrCT13T11,TrCT13T12,TrCT13T13,TrCT21TpT21,     & 
& TrCT21TpT22,TrCT21TpT23,TrCT22TpT21,TrCT22TpT22,TrCT22TpT23,TrCT23TpT21,               & 
& TrCT23TpT22,TrCT23TpT23,Trmd2YdadjYd,Trme2YeadjYe,Trml2adjYeYe,Trml2CL11L11,           & 
& Trml2CL11L12,Trml2CL11L13,Trml2CL12L11,Trml2CL12L12,Trml2CL12L13,Trml2CL13L11,         & 
& Trml2CL13L12,Trml2CL13L13,Trml2CL21TpL21,Trml2CL21TpL22,Trml2CL21TpL23,Trml2CL22TpL21, & 
& Trml2CL22TpL22,Trml2CL22TpL23,Trml2CL23TpL21,Trml2CL23TpL22,Trml2CL23TpL23,            & 
& Trmq2adjYdYd,Trmq2adjYuYu,Trmq2adjL21L21,Trmq2adjL21L22,Trmq2adjL21L23,Trmq2adjL22L21, & 
& Trmq2adjL22L22,Trmq2adjL22L23,Trmq2adjL23L21,Trmq2adjL23L22,Trmq2adjL23L23,            & 
& Trmu2YuadjYu

Complex(dp) :: TrCTdTpYd,TrCTeTpYe,TrCTuTpYu,Trml2L11CL11,Trml2L12CL12,Trml2L13CL13,Trml2L21adjL21,  & 
& Trml2L22adjL22,Trml2L23adjL23,Trmq2TpL21CL21,Trmq2TpL22CL22,Trmq2TpL23CL23,            & 
& TrYdadjYdCmd2,TrYdCmq2adjYd,TrYeadjYeCme2,TrYeCml2adjYe,TrYuadjYuCmu2,TrYuCmq2adjYu,   & 
& TrYdadjYdYdadjYd,TrYdadjYdTdadjYd,TrYdadjYdTdadjTd,TrYdadjYuYuadjYd,TrYdadjYuTuadjYd,  & 
& TrYdadjYuTuadjTd,TrYdadjTdTdadjYd,TrYdadjTuTuadjYd,TrYeadjYeYeadjYe,TrYeadjYeTeadjYe,  & 
& TrYeadjYeTeadjTe,TrYeadjTeTeadjYe,TrYuadjYdTdadjYu,TrYuadjYdTdadjTu,TrYuadjYuYuadjYu,  & 
& TrYuadjYuTuadjYu,TrYuadjYuTuadjTu,TrYuadjTdTdadjYu,TrYuadjTuTuadjYu,Trmd2YdadjYdYdadjYd,& 
& Trmd2YdadjYuYuadjYd,Trme2YeadjYeYeadjYe,Trml2adjYeYeadjYeYe,Trmq2adjYdYdadjYdYd,       & 
& Trmq2adjYdYdadjYuYu,Trmq2adjYuYuadjYdYd,Trmq2adjYuYuadjYuYu,Trmu2YuadjYdYdadjYu,       & 
& Trmu2YuadjYuYuadjYu

Real(dp) :: g1p2,g1p3,g2p2,g2p3,g3p2,g3p3

Complex(dp) :: sqrt3ov5,ooSqrt15

Real(dp) :: g1p4,g1p5,g2p4,g2p5,g3p4,g3p5

Complex(dp) :: L11(3,3), adjL11(3,3) 
Complex(dp) :: L12(3,3), adjL12(3,3) 
Complex(dp) :: L13(3,3), adjL13(3,3) 
Complex(dp) :: T11(3,3), adjT11(3,3) 
Complex(dp) :: T12(3,3), adjT12(3,3) 
Complex(dp) :: T13(3,3), adjT13(3,3) 
Complex(dp) :: L21(3,3), adjL21(3,3) 
Complex(dp) :: L22(3,3), adjL22(3,3) 
Complex(dp) :: L23(3,3), adjL23(3,3) 
Complex(dp) :: T21(3,3), adjT21(3,3) 
Complex(dp) :: T22(3,3), adjT22(3,3) 
Complex(dp) :: T23(3,3), adjT23(3,3) 
Iname = Iname +1 
NameOfUnit(Iname) = 'rge429' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters429(gy,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3)

L11=L1(:,:,1) 
Call Adjungate(L11,adjL11) 
L12=L1(:,:,2) 
Call Adjungate(L12,adjL12) 
L13=L1(:,:,3) 
Call Adjungate(L13,adjL13) 
T11=T1(:,:,1) 
Call Adjungate(T11,adjT11) 
T12=T1(:,:,2) 
Call Adjungate(T12,adjT12) 
T13=T1(:,:,3) 
Call Adjungate(T13,adjT13) 
L21=L2(:,:,1) 
Call Adjungate(L21,adjL21) 
L22=L2(:,:,2) 
Call Adjungate(L22,adjL22) 
L23=L2(:,:,3) 
Call Adjungate(L23,adjL23) 
T21=T2(:,:,1) 
Call Adjungate(T21,adjT21) 
T22=T2(:,:,2) 
Call Adjungate(T22,adjT22) 
T23=T2(:,:,3) 
Call Adjungate(T23,adjT23) 
AbsM1 = Conjg(M1)*M1
AbsM2 = Conjg(M2)*M2
AbsM3 = Conjg(M3)*M3
Call Adjungate(Yd,adjYd)
Call Adjungate(Ye,adjYe)
Call Adjungate(Yu,adjYu)
Call Adjungate(Td,adjTd)
Call Adjungate(Te,adjTe)
Call Adjungate(Tu,adjTu)
 md2Yd = Matmul(md2,Yd) 
 me2Ye = Matmul(me2,Ye) 
 ml2adjYe = Matmul(ml2,adjYe) 
 mq2adjYd = Matmul(mq2,adjYd) 
 mq2adjYu = Matmul(mq2,adjYu) 
 mu2Yu = Matmul(mu2,Yu) 
 Ydmq2 = Matmul(Yd,mq2) 
 YdadjYd = Matmul(Yd,adjYd) 
Forall(i2=1:3)  YdadjYd(i2,i2) =  Real(YdadjYd(i2,i2),dp) 
 Yeml2 = Matmul(Ye,ml2) 
 YeadjYe = Matmul(Ye,adjYe) 
Forall(i2=1:3)  YeadjYe(i2,i2) =  Real(YeadjYe(i2,i2),dp) 
 Yumq2 = Matmul(Yu,mq2) 
 YuadjYu = Matmul(Yu,adjYu) 
Forall(i2=1:3)  YuadjYu(i2,i2) =  Real(YuadjYu(i2,i2),dp) 
 adjYdmd2 = Matmul(adjYd,md2) 
 adjYdYd = Matmul(adjYd,Yd) 
Forall(i2=1:3)  adjYdYd(i2,i2) =  Real(adjYdYd(i2,i2),dp) 
 adjYdTd = Matmul(adjYd,Td) 
 adjYeme2 = Matmul(adjYe,me2) 
 adjYeYe = Matmul(adjYe,Ye) 
Forall(i2=1:3)  adjYeYe(i2,i2) =  Real(adjYeYe(i2,i2),dp) 
 adjYeTe = Matmul(adjYe,Te) 
 adjYumu2 = Matmul(adjYu,mu2) 
 adjYuYu = Matmul(adjYu,Yu) 
Forall(i2=1:3)  adjYuYu(i2,i2) =  Real(adjYuYu(i2,i2),dp) 
 adjYuTu = Matmul(adjYu,Tu) 
 adjL21L11 = Matmul(adjL21,L11) 
 adjL21L12 = Matmul(adjL21,L12) 
 adjL21L13 = Matmul(adjL21,L13) 
 adjL21L21 = Matmul(adjL21,L21) 
 adjL21L22 = Matmul(adjL21,L22) 
 adjL21L23 = Matmul(adjL21,L23) 
 adjL21T11 = Matmul(adjL21,T11) 
 adjL21T12 = Matmul(adjL21,T12) 
 adjL21T13 = Matmul(adjL21,T13) 
 adjL21T21 = Matmul(adjL21,T21) 
 adjL21T22 = Matmul(adjL21,T22) 
 adjL21T23 = Matmul(adjL21,T23) 
 adjL22L11 = Matmul(adjL22,L11) 
 adjL22L12 = Matmul(adjL22,L12) 
 adjL22L13 = Matmul(adjL22,L13) 
 adjL22L21 = Matmul(adjL22,L21) 
 adjL22L22 = Matmul(adjL22,L22) 
 adjL22L23 = Matmul(adjL22,L23) 
 adjL22T11 = Matmul(adjL22,T11) 
 adjL22T12 = Matmul(adjL22,T12) 
 adjL22T13 = Matmul(adjL22,T13) 
 adjL22T21 = Matmul(adjL22,T21) 
 adjL22T22 = Matmul(adjL22,T22) 
 adjL22T23 = Matmul(adjL22,T23) 
 adjL23L11 = Matmul(adjL23,L11) 
 adjL23L12 = Matmul(adjL23,L12) 
 adjL23L13 = Matmul(adjL23,L13) 
 adjL23L21 = Matmul(adjL23,L21) 
 adjL23L22 = Matmul(adjL23,L22) 
 adjL23L23 = Matmul(adjL23,L23) 
 adjL23T11 = Matmul(adjL23,T11) 
 adjL23T12 = Matmul(adjL23,T12) 
 adjL23T13 = Matmul(adjL23,T13) 
 adjL23T21 = Matmul(adjL23,T21) 
 adjL23T22 = Matmul(adjL23,T22) 
 adjL23T23 = Matmul(adjL23,T23) 
 adjTdTd = Matmul(adjTd,Td) 
 adjTeTe = Matmul(adjTe,Te) 
 adjTuTu = Matmul(adjTu,Tu) 
 adjT21T21 = Matmul(adjT21,T21) 
 adjT22T22 = Matmul(adjT22,T22) 
 adjT23T23 = Matmul(adjT23,T23) 
 Cml2L11 = Matmul(Conjg(ml2),L11) 
 Cml2L12 = Matmul(Conjg(ml2),L12) 
 Cml2L13 = Matmul(Conjg(ml2),L13) 
 Cml2L21 = Matmul(Conjg(ml2),L21) 
 Cml2L22 = Matmul(Conjg(ml2),L22) 
 Cml2L23 = Matmul(Conjg(ml2),L23) 
 Cmq2TpL21 = Matmul(Conjg(mq2),Transpose(L21)) 
 Cmq2TpL22 = Matmul(Conjg(mq2),Transpose(L22)) 
 Cmq2TpL23 = Matmul(Conjg(mq2),Transpose(L23)) 
 CYdTpL21 = Matmul(Conjg(Yd),Transpose(L21)) 
 CYdTpL22 = Matmul(Conjg(Yd),Transpose(L22)) 
 CYdTpL23 = Matmul(Conjg(Yd),Transpose(L23)) 
 CYdTpTd = Matmul(Conjg(Yd),Transpose(Td)) 
 CYdTpT21 = Matmul(Conjg(Yd),Transpose(T21)) 
 CYdTpT22 = Matmul(Conjg(Yd),Transpose(T22)) 
 CYdTpT23 = Matmul(Conjg(Yd),Transpose(T23)) 
 CYeL11 = Matmul(Conjg(Ye),L11) 
 CYeL12 = Matmul(Conjg(Ye),L12) 
 CYeL13 = Matmul(Conjg(Ye),L13) 
 CYeL21 = Matmul(Conjg(Ye),L21) 
 CYeL22 = Matmul(Conjg(Ye),L22) 
 CYeL23 = Matmul(Conjg(Ye),L23) 
 CYeTpTe = Matmul(Conjg(Ye),Transpose(Te)) 
 CYeT11 = Matmul(Conjg(Ye),T11) 
 CYeT12 = Matmul(Conjg(Ye),T12) 
 CYeT13 = Matmul(Conjg(Ye),T13) 
 CYeT21 = Matmul(Conjg(Ye),T21) 
 CYeT22 = Matmul(Conjg(Ye),T22) 
 CYeT23 = Matmul(Conjg(Ye),T23) 
 CL11L11 = Matmul(Conjg(L11),L11) 
 CL11L12 = Matmul(Conjg(L11),L12) 
 CL11L13 = Matmul(Conjg(L11),L13) 
 CL11L21 = Matmul(Conjg(L11),L21) 
 CL11L22 = Matmul(Conjg(L11),L22) 
 CL11L23 = Matmul(Conjg(L11),L23) 
 CL11TpYe = Matmul(Conjg(L11),Transpose(Ye)) 
 CL11TpTe = Matmul(Conjg(L11),Transpose(Te)) 
 CL11T11 = Matmul(Conjg(L11),T11) 
 CL11T12 = Matmul(Conjg(L11),T12) 
 CL11T13 = Matmul(Conjg(L11),T13) 
 CL11T21 = Matmul(Conjg(L11),T21) 
 CL11T22 = Matmul(Conjg(L11),T22) 
 CL11T23 = Matmul(Conjg(L11),T23) 
 CL12L11 = Matmul(Conjg(L12),L11) 
 CL12L12 = Matmul(Conjg(L12),L12) 
 CL12L13 = Matmul(Conjg(L12),L13) 
 CL12L21 = Matmul(Conjg(L12),L21) 
 CL12L22 = Matmul(Conjg(L12),L22) 
 CL12L23 = Matmul(Conjg(L12),L23) 
 CL12TpYe = Matmul(Conjg(L12),Transpose(Ye)) 
 CL12TpTe = Matmul(Conjg(L12),Transpose(Te)) 
 CL12T11 = Matmul(Conjg(L12),T11) 
 CL12T12 = Matmul(Conjg(L12),T12) 
 CL12T13 = Matmul(Conjg(L12),T13) 
 CL12T21 = Matmul(Conjg(L12),T21) 
 CL12T22 = Matmul(Conjg(L12),T22) 
 CL12T23 = Matmul(Conjg(L12),T23) 
 CL13L11 = Matmul(Conjg(L13),L11) 
 CL13L12 = Matmul(Conjg(L13),L12) 
 CL13L13 = Matmul(Conjg(L13),L13) 
 CL13L21 = Matmul(Conjg(L13),L21) 
 CL13L22 = Matmul(Conjg(L13),L22) 
 CL13L23 = Matmul(Conjg(L13),L23) 
 CL13TpYe = Matmul(Conjg(L13),Transpose(Ye)) 
 CL13TpTe = Matmul(Conjg(L13),Transpose(Te)) 
 CL13T11 = Matmul(Conjg(L13),T11) 
 CL13T12 = Matmul(Conjg(L13),T12) 
 CL13T13 = Matmul(Conjg(L13),T13) 
 CL13T21 = Matmul(Conjg(L13),T21) 
 CL13T22 = Matmul(Conjg(L13),T22) 
 CL13T23 = Matmul(Conjg(L13),T23) 
 CL21TpYd = Matmul(Conjg(L21),Transpose(Yd)) 
 CL21TpL21 = Matmul(Conjg(L21),Transpose(L21)) 
Forall(i2=1:3)  CL21TpL21(i2,i2) =  Real(CL21TpL21(i2,i2),dp) 
 CL21TpL22 = Matmul(Conjg(L21),Transpose(L22)) 
 CL21TpL23 = Matmul(Conjg(L21),Transpose(L23)) 
 CL21TpTd = Matmul(Conjg(L21),Transpose(Td)) 
 CL21TpT21 = Matmul(Conjg(L21),Transpose(T21)) 
 CL22TpYd = Matmul(Conjg(L22),Transpose(Yd)) 
 CL22TpL21 = Matmul(Conjg(L22),Transpose(L21)) 
 CL22TpL22 = Matmul(Conjg(L22),Transpose(L22)) 
Forall(i2=1:3)  CL22TpL22(i2,i2) =  Real(CL22TpL22(i2,i2),dp) 
 CL22TpL23 = Matmul(Conjg(L22),Transpose(L23)) 
 CL22TpTd = Matmul(Conjg(L22),Transpose(Td)) 
 CL22TpT22 = Matmul(Conjg(L22),Transpose(T22)) 
 CL23TpYd = Matmul(Conjg(L23),Transpose(Yd)) 
 CL23TpL21 = Matmul(Conjg(L23),Transpose(L21)) 
 CL23TpL22 = Matmul(Conjg(L23),Transpose(L22)) 
 CL23TpL23 = Matmul(Conjg(L23),Transpose(L23)) 
Forall(i2=1:3)  CL23TpL23(i2,i2) =  Real(CL23TpL23(i2,i2),dp) 
 CL23TpTd = Matmul(Conjg(L23),Transpose(Td)) 
 CL23TpT23 = Matmul(Conjg(L23),Transpose(T23)) 
 CTdTpTd = Matmul(Conjg(Td),Transpose(Td)) 
Forall(i2=1:3)  CTdTpTd(i2,i2) =  Real(CTdTpTd(i2,i2),dp) 
 CTeTpTe = Matmul(Conjg(Te),Transpose(Te)) 
Forall(i2=1:3)  CTeTpTe(i2,i2) =  Real(CTeTpTe(i2,i2),dp) 
 CTuTpTu = Matmul(Conjg(Tu),Transpose(Tu)) 
Forall(i2=1:3)  CTuTpTu(i2,i2) =  Real(CTuTpTu(i2,i2),dp) 
 CT11T11 = Matmul(Conjg(T11),T11) 
 CT11T12 = Matmul(Conjg(T11),T12) 
 CT11T13 = Matmul(Conjg(T11),T13) 
 CT12T11 = Matmul(Conjg(T12),T11) 
 CT12T12 = Matmul(Conjg(T12),T12) 
 CT12T13 = Matmul(Conjg(T12),T13) 
 CT13T11 = Matmul(Conjg(T13),T11) 
 CT13T12 = Matmul(Conjg(T13),T12) 
 CT13T13 = Matmul(Conjg(T13),T13) 
 CT21TpT21 = Matmul(Conjg(T21),Transpose(T21)) 
Forall(i2=1:3)  CT21TpT21(i2,i2) =  Real(CT21TpT21(i2,i2),dp) 
 CT21TpT22 = Matmul(Conjg(T21),Transpose(T22)) 
 CT21TpT23 = Matmul(Conjg(T21),Transpose(T23)) 
 CT22TpT21 = Matmul(Conjg(T22),Transpose(T21)) 
 CT22TpT22 = Matmul(Conjg(T22),Transpose(T22)) 
Forall(i2=1:3)  CT22TpT22(i2,i2) =  Real(CT22TpT22(i2,i2),dp) 
 CT22TpT23 = Matmul(Conjg(T22),Transpose(T23)) 
 CT23TpT21 = Matmul(Conjg(T23),Transpose(T21)) 
 CT23TpT22 = Matmul(Conjg(T23),Transpose(T22)) 
 CT23TpT23 = Matmul(Conjg(T23),Transpose(T23)) 
Forall(i2=1:3)  CT23TpT23(i2,i2) =  Real(CT23TpT23(i2,i2),dp) 
 L11ml2 = Matmul(L11,ml2) 
 L12ml2 = Matmul(L12,ml2) 
 L13ml2 = Matmul(L13,ml2) 
 L21mq2 = Matmul(L21,mq2) 
 L22mq2 = Matmul(L22,mq2) 
 L23mq2 = Matmul(L23,mq2) 
 TdadjTd = Matmul(Td,adjTd) 
 TeadjTe = Matmul(Te,adjTe) 
 TuadjTu = Matmul(Tu,adjTu) 
 TpL21ml2 = Matmul(Transpose(L21),ml2) 
 TpL22ml2 = Matmul(Transpose(L22),ml2) 
 TpL23ml2 = Matmul(Transpose(L23),ml2) 
 md2YdadjYd = Matmul(md2,YdadjYd) 
 me2YeadjYe = Matmul(me2,YeadjYe) 
 ml2adjYeYe = Matmul(ml2,adjYeYe) 
 ml2CL11L11 = Matmul(ml2,CL11L11) 
 ml2CL11L12 = Matmul(ml2,CL11L12) 
 ml2CL11L13 = Matmul(ml2,CL11L13) 
 ml2CL12L11 = Matmul(ml2,CL12L11) 
 ml2CL12L12 = Matmul(ml2,CL12L12) 
 ml2CL12L13 = Matmul(ml2,CL12L13) 
 ml2CL13L11 = Matmul(ml2,CL13L11) 
 ml2CL13L12 = Matmul(ml2,CL13L12) 
 ml2CL13L13 = Matmul(ml2,CL13L13) 
 ml2CL21TpL21 = Matmul(ml2,CL21TpL21) 
 ml2CL21TpL22 = Matmul(ml2,CL21TpL22) 
 ml2CL21TpL23 = Matmul(ml2,CL21TpL23) 
 ml2CL22TpL21 = Matmul(ml2,CL22TpL21) 
 ml2CL22TpL22 = Matmul(ml2,CL22TpL22) 
 ml2CL22TpL23 = Matmul(ml2,CL22TpL23) 
 ml2CL23TpL21 = Matmul(ml2,CL23TpL21) 
 ml2CL23TpL22 = Matmul(ml2,CL23TpL22) 
 ml2CL23TpL23 = Matmul(ml2,CL23TpL23) 
 mq2adjYdYd = Matmul(mq2,adjYdYd) 
 mq2adjYuYu = Matmul(mq2,adjYuYu) 
 mq2adjL21L21 = Matmul(mq2,adjL21L21) 
 mq2adjL21L22 = Matmul(mq2,adjL21L22) 
 mq2adjL21L23 = Matmul(mq2,adjL21L23) 
 mq2adjL22L21 = Matmul(mq2,adjL22L21) 
 mq2adjL22L22 = Matmul(mq2,adjL22L22) 
 mq2adjL22L23 = Matmul(mq2,adjL22L23) 
 mq2adjL23L21 = Matmul(mq2,adjL23L21) 
 mq2adjL23L22 = Matmul(mq2,adjL23L22) 
 mq2adjL23L23 = Matmul(mq2,adjL23L23) 
 mu2YuadjYu = Matmul(mu2,YuadjYu) 
 Ydmq2adjYd = Matmul(Yd,mq2adjYd) 
Forall(i2=1:3)  Ydmq2adjYd(i2,i2) =  Real(Ydmq2adjYd(i2,i2),dp) 
 YdadjYdmd2 = Matmul(Yd,adjYdmd2) 
 YdadjYdYd = Matmul(Yd,adjYdYd) 
 YdadjYdTd = Matmul(Yd,adjYdTd) 
 YdadjYuYu = Matmul(Yd,adjYuYu) 
 YdadjYuTu = Matmul(Yd,adjYuTu) 
 YdadjL21L21 = Matmul(Yd,adjL21L21) 
 YdadjL21L22 = Matmul(Yd,adjL21L22) 
 YdadjL21L23 = Matmul(Yd,adjL21L23) 
 YdadjL21T11 = Matmul(Yd,adjL21T11) 
 YdadjL21T12 = Matmul(Yd,adjL21T12) 
 YdadjL21T13 = Matmul(Yd,adjL21T13) 
 YdadjL21T21 = Matmul(Yd,adjL21T21) 
 YdadjL21T22 = Matmul(Yd,adjL21T22) 
 YdadjL21T23 = Matmul(Yd,adjL21T23) 
 YdadjL22L21 = Matmul(Yd,adjL22L21) 
 YdadjL22L22 = Matmul(Yd,adjL22L22) 
 YdadjL22L23 = Matmul(Yd,adjL22L23) 
 YdadjL22T11 = Matmul(Yd,adjL22T11) 
 YdadjL22T12 = Matmul(Yd,adjL22T12) 
 YdadjL22T13 = Matmul(Yd,adjL22T13) 
 YdadjL22T21 = Matmul(Yd,adjL22T21) 
 YdadjL22T22 = Matmul(Yd,adjL22T22) 
 YdadjL22T23 = Matmul(Yd,adjL22T23) 
 YdadjL23L21 = Matmul(Yd,adjL23L21) 
 YdadjL23L22 = Matmul(Yd,adjL23L22) 
 YdadjL23L23 = Matmul(Yd,adjL23L23) 
 YdadjL23T11 = Matmul(Yd,adjL23T11) 
 YdadjL23T12 = Matmul(Yd,adjL23T12) 
 YdadjL23T13 = Matmul(Yd,adjL23T13) 
 YdadjL23T21 = Matmul(Yd,adjL23T21) 
 YdadjL23T22 = Matmul(Yd,adjL23T22) 
 YdadjL23T23 = Matmul(Yd,adjL23T23) 
 Yeml2adjYe = Matmul(Ye,ml2adjYe) 
Forall(i2=1:3)  Yeml2adjYe(i2,i2) =  Real(Yeml2adjYe(i2,i2),dp) 
 YeadjYeme2 = Matmul(Ye,adjYeme2) 
 YeadjYeYe = Matmul(Ye,adjYeYe) 
 YeadjYeTe = Matmul(Ye,adjYeTe) 
 YeCL11L11 = Matmul(Ye,CL11L11) 
 YeCL11L21 = Matmul(Ye,CL11L21) 
 YeCL11L22 = Matmul(Ye,CL11L22) 
 YeCL11L23 = Matmul(Ye,CL11L23) 
 YeCL11T11 = Matmul(Ye,CL11T11) 
 YeCL11T12 = Matmul(Ye,CL11T12) 
 YeCL11T13 = Matmul(Ye,CL11T13) 
 YeCL11T21 = Matmul(Ye,CL11T21) 
 YeCL11T22 = Matmul(Ye,CL11T22) 
 YeCL11T23 = Matmul(Ye,CL11T23) 
 YeCL12L12 = Matmul(Ye,CL12L12) 
 YeCL12L21 = Matmul(Ye,CL12L21) 
 YeCL12L22 = Matmul(Ye,CL12L22) 
 YeCL12L23 = Matmul(Ye,CL12L23) 
 YeCL12T11 = Matmul(Ye,CL12T11) 
 YeCL12T12 = Matmul(Ye,CL12T12) 
 YeCL12T13 = Matmul(Ye,CL12T13) 
 YeCL12T21 = Matmul(Ye,CL12T21) 
 YeCL12T22 = Matmul(Ye,CL12T22) 
 YeCL12T23 = Matmul(Ye,CL12T23) 
 YeCL13L13 = Matmul(Ye,CL13L13) 
 YeCL13L21 = Matmul(Ye,CL13L21) 
 YeCL13L22 = Matmul(Ye,CL13L22) 
 YeCL13L23 = Matmul(Ye,CL13L23) 
 YeCL13T11 = Matmul(Ye,CL13T11) 
 YeCL13T12 = Matmul(Ye,CL13T12) 
 YeCL13T13 = Matmul(Ye,CL13T13) 
 YeCL13T21 = Matmul(Ye,CL13T21) 
 YeCL13T22 = Matmul(Ye,CL13T22) 
 YeCL13T23 = Matmul(Ye,CL13T23) 
 YeCL21TpL21 = Matmul(Ye,CL21TpL21) 
 YeCL21TpT21 = Matmul(Ye,CL21TpT21) 
 YeCL22TpL22 = Matmul(Ye,CL22TpL22) 
 YeCL22TpT22 = Matmul(Ye,CL22TpT22) 
 YeCL23TpL23 = Matmul(Ye,CL23TpL23) 
 YeCL23TpT23 = Matmul(Ye,CL23TpT23) 
 Yumq2adjYu = Matmul(Yu,mq2adjYu) 
Forall(i2=1:3)  Yumq2adjYu(i2,i2) =  Real(Yumq2adjYu(i2,i2),dp) 
 YuadjYdYd = Matmul(Yu,adjYdYd) 
 YuadjYdTd = Matmul(Yu,adjYdTd) 
 YuadjYumu2 = Matmul(Yu,adjYumu2) 
 YuadjYuYu = Matmul(Yu,adjYuYu) 
 YuadjYuTu = Matmul(Yu,adjYuTu) 
 YuadjL21L21 = Matmul(Yu,adjL21L21) 
 YuadjL21T21 = Matmul(Yu,adjL21T21) 
 YuadjL22L22 = Matmul(Yu,adjL22L22) 
 YuadjL22T22 = Matmul(Yu,adjL22T22) 
 YuadjL23L23 = Matmul(Yu,adjL23L23) 
 YuadjL23T23 = Matmul(Yu,adjL23T23) 
 adjYdmd2Yd = Matmul(adjYd,md2Yd) 
Forall(i2=1:3)  adjYdmd2Yd(i2,i2) =  Real(adjYdmd2Yd(i2,i2),dp) 
 adjYdYdmq2 = Matmul(adjYd,Ydmq2) 
 adjYeme2Ye = Matmul(adjYe,me2Ye) 
Forall(i2=1:3)  adjYeme2Ye(i2,i2) =  Real(adjYeme2Ye(i2,i2),dp) 
 adjYeYeml2 = Matmul(adjYe,Yeml2) 
 adjYumu2Yu = Matmul(adjYu,mu2Yu) 
Forall(i2=1:3)  adjYumu2Yu(i2,i2) =  Real(adjYumu2Yu(i2,i2),dp) 
 adjYuYumq2 = Matmul(adjYu,Yumq2) 
 adjL21Cml2L21 = Matmul(adjL21,Cml2L21) 
 adjL21L21mq2 = Matmul(adjL21,L21mq2) 
 adjL22Cml2L22 = Matmul(adjL22,Cml2L22) 
 adjL22L22mq2 = Matmul(adjL22,L22mq2) 
 adjL23Cml2L23 = Matmul(adjL23,Cml2L23) 
 adjL23L23mq2 = Matmul(adjL23,L23mq2) 
 CL11Cml2L11 = Matmul(Conjg(L11),Cml2L11) 
 CL11L11ml2 = Matmul(Conjg(L11),L11ml2) 
 CL12Cml2L12 = Matmul(Conjg(L12),Cml2L12) 
 CL12L12ml2 = Matmul(Conjg(L12),L12ml2) 
 CL13Cml2L13 = Matmul(Conjg(L13),Cml2L13) 
 CL13L13ml2 = Matmul(Conjg(L13),L13ml2) 
 CL21Cmq2TpL21 = Matmul(Conjg(L21),Cmq2TpL21) 
Forall(i2=1:3)  CL21Cmq2TpL21(i2,i2) =  Real(CL21Cmq2TpL21(i2,i2),dp) 
 CL21TpL21ml2 = Matmul(Conjg(L21),TpL21ml2) 
 CL22Cmq2TpL22 = Matmul(Conjg(L22),Cmq2TpL22) 
Forall(i2=1:3)  CL22Cmq2TpL22(i2,i2) =  Real(CL22Cmq2TpL22(i2,i2),dp) 
 CL22TpL22ml2 = Matmul(Conjg(L22),TpL22ml2) 
 CL23Cmq2TpL23 = Matmul(Conjg(L23),Cmq2TpL23) 
Forall(i2=1:3)  CL23Cmq2TpL23(i2,i2) =  Real(CL23Cmq2TpL23(i2,i2),dp) 
 CL23TpL23ml2 = Matmul(Conjg(L23),TpL23ml2) 
 L11adjYeYe = Matmul(L11,adjYeYe) 
 L11adjYeTe = Matmul(L11,adjYeTe) 
 L11CL11L11 = Matmul(L11,CL11L11) 
 L11CL11L12 = Matmul(L11,CL11L12) 
 L11CL11L13 = Matmul(L11,CL11L13) 
 L11CL11L21 = Matmul(L11,CL11L21) 
 L11CL11L22 = Matmul(L11,CL11L22) 
 L11CL11L23 = Matmul(L11,CL11L23) 
 L11CL11TpYe = Matmul(L11,CL11TpYe) 
 L11CL11TpTe = Matmul(L11,CL11TpTe) 
 L11CL11T11 = Matmul(L11,CL11T11) 
 L11CL11T12 = Matmul(L11,CL11T12) 
 L11CL11T13 = Matmul(L11,CL11T13) 
 L11CL11T21 = Matmul(L11,CL11T21) 
 L11CL11T22 = Matmul(L11,CL11T22) 
 L11CL11T23 = Matmul(L11,CL11T23) 
 L11CL12L12 = Matmul(L11,CL12L12) 
 L11CL12TpYe = Matmul(L11,CL12TpYe) 
 L11CL12TpTe = Matmul(L11,CL12TpTe) 
 L11CL12T12 = Matmul(L11,CL12T12) 
 L11CL13L13 = Matmul(L11,CL13L13) 
 L11CL13TpYe = Matmul(L11,CL13TpYe) 
 L11CL13TpTe = Matmul(L11,CL13TpTe) 
 L11CL13T13 = Matmul(L11,CL13T13) 
 L11CL21TpYd = Matmul(L11,CL21TpYd) 
 L11CL21TpL21 = Matmul(L11,CL21TpL21) 
 L11CL21TpTd = Matmul(L11,CL21TpTd) 
 L11CL21TpT21 = Matmul(L11,CL21TpT21) 
 L11CL22TpYd = Matmul(L11,CL22TpYd) 
 L11CL22TpL22 = Matmul(L11,CL22TpL22) 
 L11CL22TpTd = Matmul(L11,CL22TpTd) 
 L11CL22TpT22 = Matmul(L11,CL22TpT22) 
 L11CL23TpYd = Matmul(L11,CL23TpYd) 
 L11CL23TpL23 = Matmul(L11,CL23TpL23) 
 L11CL23TpTd = Matmul(L11,CL23TpTd) 
 L11CL23TpT23 = Matmul(L11,CL23TpT23) 
 L12adjYeYe = Matmul(L12,adjYeYe) 
 L12adjYeTe = Matmul(L12,adjYeTe) 
 L12CL11L11 = Matmul(L12,CL11L11) 
 L12CL11TpYe = Matmul(L12,CL11TpYe) 
 L12CL11TpTe = Matmul(L12,CL11TpTe) 
 L12CL11T11 = Matmul(L12,CL11T11) 
 L12CL12L11 = Matmul(L12,CL12L11) 
 L12CL12L12 = Matmul(L12,CL12L12) 
 L12CL12L13 = Matmul(L12,CL12L13) 
 L12CL12L21 = Matmul(L12,CL12L21) 
 L12CL12L22 = Matmul(L12,CL12L22) 
 L12CL12L23 = Matmul(L12,CL12L23) 
 L12CL12TpYe = Matmul(L12,CL12TpYe) 
 L12CL12TpTe = Matmul(L12,CL12TpTe) 
 L12CL12T11 = Matmul(L12,CL12T11) 
 L12CL12T12 = Matmul(L12,CL12T12) 
 L12CL12T13 = Matmul(L12,CL12T13) 
 L12CL12T21 = Matmul(L12,CL12T21) 
 L12CL12T22 = Matmul(L12,CL12T22) 
 L12CL12T23 = Matmul(L12,CL12T23) 
 L12CL13L13 = Matmul(L12,CL13L13) 
 L12CL13TpYe = Matmul(L12,CL13TpYe) 
 L12CL13TpTe = Matmul(L12,CL13TpTe) 
 L12CL13T13 = Matmul(L12,CL13T13) 
 L12CL21TpYd = Matmul(L12,CL21TpYd) 
 L12CL21TpL21 = Matmul(L12,CL21TpL21) 
 L12CL21TpTd = Matmul(L12,CL21TpTd) 
 L12CL21TpT21 = Matmul(L12,CL21TpT21) 
 L12CL22TpYd = Matmul(L12,CL22TpYd) 
 L12CL22TpL22 = Matmul(L12,CL22TpL22) 
 L12CL22TpTd = Matmul(L12,CL22TpTd) 
 L12CL22TpT22 = Matmul(L12,CL22TpT22) 
 L12CL23TpYd = Matmul(L12,CL23TpYd) 
 L12CL23TpL23 = Matmul(L12,CL23TpL23) 
 L12CL23TpTd = Matmul(L12,CL23TpTd) 
 L12CL23TpT23 = Matmul(L12,CL23TpT23) 
 L13adjYeYe = Matmul(L13,adjYeYe) 
 L13adjYeTe = Matmul(L13,adjYeTe) 
 L13CL11L11 = Matmul(L13,CL11L11) 
 L13CL11TpYe = Matmul(L13,CL11TpYe) 
 L13CL11TpTe = Matmul(L13,CL11TpTe) 
 L13CL11T11 = Matmul(L13,CL11T11) 
 L13CL12L12 = Matmul(L13,CL12L12) 
 L13CL12TpYe = Matmul(L13,CL12TpYe) 
 L13CL12TpTe = Matmul(L13,CL12TpTe) 
 L13CL12T12 = Matmul(L13,CL12T12) 
 L13CL13L11 = Matmul(L13,CL13L11) 
 L13CL13L12 = Matmul(L13,CL13L12) 
 L13CL13L13 = Matmul(L13,CL13L13) 
 L13CL13L21 = Matmul(L13,CL13L21) 
 L13CL13L22 = Matmul(L13,CL13L22) 
 L13CL13L23 = Matmul(L13,CL13L23) 
 L13CL13TpYe = Matmul(L13,CL13TpYe) 
 L13CL13TpTe = Matmul(L13,CL13TpTe) 
 L13CL13T11 = Matmul(L13,CL13T11) 
 L13CL13T12 = Matmul(L13,CL13T12) 
 L13CL13T13 = Matmul(L13,CL13T13) 
 L13CL13T21 = Matmul(L13,CL13T21) 
 L13CL13T22 = Matmul(L13,CL13T22) 
 L13CL13T23 = Matmul(L13,CL13T23) 
 L13CL21TpYd = Matmul(L13,CL21TpYd) 
 L13CL21TpL21 = Matmul(L13,CL21TpL21) 
 L13CL21TpTd = Matmul(L13,CL21TpTd) 
 L13CL21TpT21 = Matmul(L13,CL21TpT21) 
 L13CL22TpYd = Matmul(L13,CL22TpYd) 
 L13CL22TpL22 = Matmul(L13,CL22TpL22) 
 L13CL22TpTd = Matmul(L13,CL22TpTd) 
 L13CL22TpT22 = Matmul(L13,CL22TpT22) 
 L13CL23TpYd = Matmul(L13,CL23TpYd) 
 L13CL23TpL23 = Matmul(L13,CL23TpL23) 
 L13CL23TpTd = Matmul(L13,CL23TpTd) 
 L13CL23TpT23 = Matmul(L13,CL23TpT23) 
 L21adjYdYd = Matmul(L21,adjYdYd) 
 L21adjYdTd = Matmul(L21,adjYdTd) 
 L21adjYuYu = Matmul(L21,adjYuYu) 
 L21adjYuTu = Matmul(L21,adjYuTu) 
 L21adjL21L11 = Matmul(L21,adjL21L11) 
 L21adjL21L12 = Matmul(L21,adjL21L12) 
 L21adjL21L13 = Matmul(L21,adjL21L13) 
 L21adjL21L21 = Matmul(L21,adjL21L21) 
 L21adjL21L22 = Matmul(L21,adjL21L22) 
 L21adjL21L23 = Matmul(L21,adjL21L23) 
 L21adjL21T11 = Matmul(L21,adjL21T11) 
 L21adjL21T12 = Matmul(L21,adjL21T12) 
 L21adjL21T13 = Matmul(L21,adjL21T13) 
 L21adjL21T21 = Matmul(L21,adjL21T21) 
 L21adjL21T22 = Matmul(L21,adjL21T22) 
 L21adjL21T23 = Matmul(L21,adjL21T23) 
 L21adjL22L22 = Matmul(L21,adjL22L22) 
 L21adjL22T22 = Matmul(L21,adjL22T22) 
 L21adjL23L23 = Matmul(L21,adjL23L23) 
 L21adjL23T23 = Matmul(L21,adjL23T23) 
 L22adjYdYd = Matmul(L22,adjYdYd) 
 L22adjYdTd = Matmul(L22,adjYdTd) 
 L22adjYuYu = Matmul(L22,adjYuYu) 
 L22adjYuTu = Matmul(L22,adjYuTu) 
 L22adjL21L21 = Matmul(L22,adjL21L21) 
 L22adjL21T21 = Matmul(L22,adjL21T21) 
 L22adjL22L11 = Matmul(L22,adjL22L11) 
 L22adjL22L12 = Matmul(L22,adjL22L12) 
 L22adjL22L13 = Matmul(L22,adjL22L13) 
 L22adjL22L21 = Matmul(L22,adjL22L21) 
 L22adjL22L22 = Matmul(L22,adjL22L22) 
 L22adjL22L23 = Matmul(L22,adjL22L23) 
 L22adjL22T11 = Matmul(L22,adjL22T11) 
 L22adjL22T12 = Matmul(L22,adjL22T12) 
 L22adjL22T13 = Matmul(L22,adjL22T13) 
 L22adjL22T21 = Matmul(L22,adjL22T21) 
 L22adjL22T22 = Matmul(L22,adjL22T22) 
 L22adjL22T23 = Matmul(L22,adjL22T23) 
 L22adjL23L23 = Matmul(L22,adjL23L23) 
 L22adjL23T23 = Matmul(L22,adjL23T23) 
 L23adjYdYd = Matmul(L23,adjYdYd) 
 L23adjYdTd = Matmul(L23,adjYdTd) 
 L23adjYuYu = Matmul(L23,adjYuYu) 
 L23adjYuTu = Matmul(L23,adjYuTu) 
 L23adjL21L21 = Matmul(L23,adjL21L21) 
 L23adjL21T21 = Matmul(L23,adjL21T21) 
 L23adjL22L22 = Matmul(L23,adjL22L22) 
 L23adjL22T22 = Matmul(L23,adjL22T22) 
 L23adjL23L11 = Matmul(L23,adjL23L11) 
 L23adjL23L12 = Matmul(L23,adjL23L12) 
 L23adjL23L13 = Matmul(L23,adjL23L13) 
 L23adjL23L21 = Matmul(L23,adjL23L21) 
 L23adjL23L22 = Matmul(L23,adjL23L22) 
 L23adjL23L23 = Matmul(L23,adjL23L23) 
 L23adjL23T11 = Matmul(L23,adjL23T11) 
 L23adjL23T12 = Matmul(L23,adjL23T12) 
 L23adjL23T13 = Matmul(L23,adjL23T13) 
 L23adjL23T21 = Matmul(L23,adjL23T21) 
 L23adjL23T22 = Matmul(L23,adjL23T22) 
 L23adjL23T23 = Matmul(L23,adjL23T23) 
 TdadjYdYd = Matmul(Td,adjYdYd) 
 TdadjYuYu = Matmul(Td,adjYuYu) 
 TdadjL21L21 = Matmul(Td,adjL21L21) 
 TdadjL22L22 = Matmul(Td,adjL22L22) 
 TdadjL23L23 = Matmul(Td,adjL23L23) 
 TeadjYeYe = Matmul(Te,adjYeYe) 
 TeCL11L11 = Matmul(Te,CL11L11) 
 TeCL12L12 = Matmul(Te,CL12L12) 
 TeCL13L13 = Matmul(Te,CL13L13) 
 TeCL21TpL21 = Matmul(Te,CL21TpL21) 
 TeCL22TpL22 = Matmul(Te,CL22TpL22) 
 TeCL23TpL23 = Matmul(Te,CL23TpL23) 
 TuadjYdYd = Matmul(Tu,adjYdYd) 
 TuadjYuYu = Matmul(Tu,adjYuYu) 
 TuadjL21L21 = Matmul(Tu,adjL21L21) 
 TuadjL22L22 = Matmul(Tu,adjL22L22) 
 TuadjL23L23 = Matmul(Tu,adjL23L23) 
 TpYeCYeL11 = Matmul(Transpose(Ye),CYeL11) 
 TpYeCYeL12 = Matmul(Transpose(Ye),CYeL12) 
 TpYeCYeL13 = Matmul(Transpose(Ye),CYeL13) 
 TpYeCYeL21 = Matmul(Transpose(Ye),CYeL21) 
 TpYeCYeL22 = Matmul(Transpose(Ye),CYeL22) 
 TpYeCYeL23 = Matmul(Transpose(Ye),CYeL23) 
 TpYeCYeT11 = Matmul(Transpose(Ye),CYeT11) 
 TpYeCYeT12 = Matmul(Transpose(Ye),CYeT12) 
 TpYeCYeT13 = Matmul(Transpose(Ye),CYeT13) 
 TpYeCYeT21 = Matmul(Transpose(Ye),CYeT21) 
 TpYeCYeT22 = Matmul(Transpose(Ye),CYeT22) 
 TpYeCYeT23 = Matmul(Transpose(Ye),CYeT23) 
 TpL21CL11TpTe = Matmul(Transpose(L21),CL11TpTe) 
 TpL21CL12TpTe = Matmul(Transpose(L21),CL12TpTe) 
 TpL21CL13TpTe = Matmul(Transpose(L21),CL13TpTe) 
 TpL21CL21TpTd = Matmul(Transpose(L21),CL21TpTd) 
 TpL21CL22TpTd = Matmul(Transpose(L21),CL22TpTd) 
 TpL21CL23TpTd = Matmul(Transpose(L21),CL23TpTd) 
 TpL22CL11TpTe = Matmul(Transpose(L22),CL11TpTe) 
 TpL22CL12TpTe = Matmul(Transpose(L22),CL12TpTe) 
 TpL22CL13TpTe = Matmul(Transpose(L22),CL13TpTe) 
 TpL22CL21TpTd = Matmul(Transpose(L22),CL21TpTd) 
 TpL22CL22TpTd = Matmul(Transpose(L22),CL22TpTd) 
 TpL22CL23TpTd = Matmul(Transpose(L22),CL23TpTd) 
 TpL23CL11TpTe = Matmul(Transpose(L23),CL11TpTe) 
 TpL23CL12TpTe = Matmul(Transpose(L23),CL12TpTe) 
 TpL23CL13TpTe = Matmul(Transpose(L23),CL13TpTe) 
 TpL23CL21TpTd = Matmul(Transpose(L23),CL21TpTd) 
 TpL23CL22TpTd = Matmul(Transpose(L23),CL22TpTd) 
 TpL23CL23TpTd = Matmul(Transpose(L23),CL23TpTd) 
 TpTeCYeL11 = Matmul(Transpose(Te),CYeL11) 
 TpTeCYeL12 = Matmul(Transpose(Te),CYeL12) 
 TpTeCYeL13 = Matmul(Transpose(Te),CYeL13) 
 TpTeCYeL21 = Matmul(Transpose(Te),CYeL21) 
 TpTeCYeL22 = Matmul(Transpose(Te),CYeL22) 
 TpTeCYeL23 = Matmul(Transpose(Te),CYeL23) 
 T11adjYeYe = Matmul(T11,adjYeYe) 
 T11CL11L11 = Matmul(T11,CL11L11) 
 T11CL11L12 = Matmul(T11,CL11L12) 
 T11CL11L13 = Matmul(T11,CL11L13) 
 T11CL11L21 = Matmul(T11,CL11L21) 
 T11CL11L22 = Matmul(T11,CL11L22) 
 T11CL11L23 = Matmul(T11,CL11L23) 
 T11CL12L12 = Matmul(T11,CL12L12) 
 T11CL13L13 = Matmul(T11,CL13L13) 
 T11CL21TpL21 = Matmul(T11,CL21TpL21) 
 T11CL22TpL22 = Matmul(T11,CL22TpL22) 
 T11CL23TpL23 = Matmul(T11,CL23TpL23) 
 T12adjYeYe = Matmul(T12,adjYeYe) 
 T12CL11L11 = Matmul(T12,CL11L11) 
 T12CL12L11 = Matmul(T12,CL12L11) 
 T12CL12L12 = Matmul(T12,CL12L12) 
 T12CL12L13 = Matmul(T12,CL12L13) 
 T12CL12L21 = Matmul(T12,CL12L21) 
 T12CL12L22 = Matmul(T12,CL12L22) 
 T12CL12L23 = Matmul(T12,CL12L23) 
 T12CL13L13 = Matmul(T12,CL13L13) 
 T12CL21TpL21 = Matmul(T12,CL21TpL21) 
 T12CL22TpL22 = Matmul(T12,CL22TpL22) 
 T12CL23TpL23 = Matmul(T12,CL23TpL23) 
 T13adjYeYe = Matmul(T13,adjYeYe) 
 T13CL11L11 = Matmul(T13,CL11L11) 
 T13CL12L12 = Matmul(T13,CL12L12) 
 T13CL13L11 = Matmul(T13,CL13L11) 
 T13CL13L12 = Matmul(T13,CL13L12) 
 T13CL13L13 = Matmul(T13,CL13L13) 
 T13CL13L21 = Matmul(T13,CL13L21) 
 T13CL13L22 = Matmul(T13,CL13L22) 
 T13CL13L23 = Matmul(T13,CL13L23) 
 T13CL21TpL21 = Matmul(T13,CL21TpL21) 
 T13CL22TpL22 = Matmul(T13,CL22TpL22) 
 T13CL23TpL23 = Matmul(T13,CL23TpL23) 
 T21adjYdYd = Matmul(T21,adjYdYd) 
 T21adjYuYu = Matmul(T21,adjYuYu) 
 T21adjL21L11 = Matmul(T21,adjL21L11) 
 T21adjL21L12 = Matmul(T21,adjL21L12) 
 T21adjL21L13 = Matmul(T21,adjL21L13) 
 T21adjL21L21 = Matmul(T21,adjL21L21) 
 T21adjL21L22 = Matmul(T21,adjL21L22) 
 T21adjL21L23 = Matmul(T21,adjL21L23) 
 T21adjL22L22 = Matmul(T21,adjL22L22) 
 T21adjL23L23 = Matmul(T21,adjL23L23) 
 T22adjYdYd = Matmul(T22,adjYdYd) 
 T22adjYuYu = Matmul(T22,adjYuYu) 
 T22adjL21L21 = Matmul(T22,adjL21L21) 
 T22adjL22L11 = Matmul(T22,adjL22L11) 
 T22adjL22L12 = Matmul(T22,adjL22L12) 
 T22adjL22L13 = Matmul(T22,adjL22L13) 
 T22adjL22L21 = Matmul(T22,adjL22L21) 
 T22adjL22L22 = Matmul(T22,adjL22L22) 
 T22adjL22L23 = Matmul(T22,adjL22L23) 
 T22adjL23L23 = Matmul(T22,adjL23L23) 
 T23adjYdYd = Matmul(T23,adjYdYd) 
 T23adjYuYu = Matmul(T23,adjYuYu) 
 T23adjL21L21 = Matmul(T23,adjL21L21) 
 T23adjL22L22 = Matmul(T23,adjL22L22) 
 T23adjL23L11 = Matmul(T23,adjL23L11) 
 T23adjL23L12 = Matmul(T23,adjL23L12) 
 T23adjL23L13 = Matmul(T23,adjL23L13) 
 T23adjL23L21 = Matmul(T23,adjL23L21) 
 T23adjL23L22 = Matmul(T23,adjL23L22) 
 T23adjL23L23 = Matmul(T23,adjL23L23) 
 Trmd2 = Real(cTrace(md2),dp) 
 Trme2 = Real(cTrace(me2),dp) 
 Trml2 = Real(cTrace(ml2),dp) 
 Trmq2 = Real(cTrace(mq2),dp) 
 Trmu2 = Real(cTrace(mu2),dp) 
 TrYdadjYd = Real(cTrace(YdadjYd),dp) 
 TrYeadjYe = Real(cTrace(YeadjYe),dp) 
 TrYuadjYu = Real(cTrace(YuadjYu),dp) 
 TradjYdTd = cTrace(adjYdTd) 
 TradjYeTe = cTrace(adjYeTe) 
 TradjYuTu = cTrace(adjYuTu) 
 TradjL21T21 = cTrace(adjL21T21) 
 TradjL21T22 = cTrace(adjL21T22) 
 TradjL21T23 = cTrace(adjL21T23) 
 TradjL22T21 = cTrace(adjL22T21) 
 TradjL22T22 = cTrace(adjL22T22) 
 TradjL22T23 = cTrace(adjL22T23) 
 TradjL23T21 = cTrace(adjL23T21) 
 TradjL23T22 = cTrace(adjL23T22) 
 TradjL23T23 = cTrace(adjL23T23) 
 TrCL11L11 = cTrace(CL11L11) 
 TrCL11L12 = cTrace(CL11L12) 
 TrCL11L13 = cTrace(CL11L13) 
 TrCL11T11 = cTrace(CL11T11) 
 TrCL11T12 = cTrace(CL11T12) 
 TrCL11T13 = cTrace(CL11T13) 
 TrCL12L11 = cTrace(CL12L11) 
 TrCL12L12 = cTrace(CL12L12) 
 TrCL12L13 = cTrace(CL12L13) 
 TrCL12T11 = cTrace(CL12T11) 
 TrCL12T12 = cTrace(CL12T12) 
 TrCL12T13 = cTrace(CL12T13) 
 TrCL13L11 = cTrace(CL13L11) 
 TrCL13L12 = cTrace(CL13L12) 
 TrCL13L13 = cTrace(CL13L13) 
 TrCL13T11 = cTrace(CL13T11) 
 TrCL13T12 = cTrace(CL13T12) 
 TrCL13T13 = cTrace(CL13T13) 
 TrCL21TpL21 = Real(cTrace(CL21TpL21),dp) 
 TrCL21TpL22 = cTrace(CL21TpL22) 
 TrCL21TpL23 = cTrace(CL21TpL23) 
 TrCL22TpL21 = cTrace(CL22TpL21) 
 TrCL22TpL22 = Real(cTrace(CL22TpL22),dp) 
 TrCL22TpL23 = cTrace(CL22TpL23) 
 TrCL23TpL21 = cTrace(CL23TpL21) 
 TrCL23TpL22 = cTrace(CL23TpL22) 
 TrCL23TpL23 = Real(cTrace(CL23TpL23),dp) 
 TrCTdTpTd = Real(cTrace(CTdTpTd),dp) 
 TrCTeTpTe = Real(cTrace(CTeTpTe),dp) 
 TrCTuTpTu = Real(cTrace(CTuTpTu),dp) 
 TrCT11T11 = cTrace(CT11T11) 
 TrCT11T12 = cTrace(CT11T12) 
 TrCT11T13 = cTrace(CT11T13) 
 TrCT12T11 = cTrace(CT12T11) 
 TrCT12T12 = cTrace(CT12T12) 
 TrCT12T13 = cTrace(CT12T13) 
 TrCT13T11 = cTrace(CT13T11) 
 TrCT13T12 = cTrace(CT13T12) 
 TrCT13T13 = cTrace(CT13T13) 
 TrCT21TpT21 = Real(cTrace(CT21TpT21),dp) 
 TrCT21TpT22 = cTrace(CT21TpT22) 
 TrCT21TpT23 = cTrace(CT21TpT23) 
 TrCT22TpT21 = cTrace(CT22TpT21) 
 TrCT22TpT22 = Real(cTrace(CT22TpT22),dp) 
 TrCT22TpT23 = cTrace(CT22TpT23) 
 TrCT23TpT21 = cTrace(CT23TpT21) 
 TrCT23TpT22 = cTrace(CT23TpT22) 
 TrCT23TpT23 = Real(cTrace(CT23TpT23),dp) 
 Trmd2YdadjYd = cTrace(md2YdadjYd) 
 Trme2YeadjYe = cTrace(me2YeadjYe) 
 Trml2adjYeYe = cTrace(ml2adjYeYe) 
 Trml2CL11L11 = cTrace(ml2CL11L11) 
 Trml2CL11L12 = cTrace(ml2CL11L12) 
 Trml2CL11L13 = cTrace(ml2CL11L13) 
 Trml2CL12L11 = cTrace(ml2CL12L11) 
 Trml2CL12L12 = cTrace(ml2CL12L12) 
 Trml2CL12L13 = cTrace(ml2CL12L13) 
 Trml2CL13L11 = cTrace(ml2CL13L11) 
 Trml2CL13L12 = cTrace(ml2CL13L12) 
 Trml2CL13L13 = cTrace(ml2CL13L13) 
 Trml2CL21TpL21 = cTrace(ml2CL21TpL21) 
 Trml2CL21TpL22 = cTrace(ml2CL21TpL22) 
 Trml2CL21TpL23 = cTrace(ml2CL21TpL23) 
 Trml2CL22TpL21 = cTrace(ml2CL22TpL21) 
 Trml2CL22TpL22 = cTrace(ml2CL22TpL22) 
 Trml2CL22TpL23 = cTrace(ml2CL22TpL23) 
 Trml2CL23TpL21 = cTrace(ml2CL23TpL21) 
 Trml2CL23TpL22 = cTrace(ml2CL23TpL22) 
 Trml2CL23TpL23 = cTrace(ml2CL23TpL23) 
 Trmq2adjYdYd = cTrace(mq2adjYdYd) 
 Trmq2adjYuYu = cTrace(mq2adjYuYu) 
 Trmq2adjL21L21 = cTrace(mq2adjL21L21) 
 Trmq2adjL21L22 = cTrace(mq2adjL21L22) 
 Trmq2adjL21L23 = cTrace(mq2adjL21L23) 
 Trmq2adjL22L21 = cTrace(mq2adjL22L21) 
 Trmq2adjL22L22 = cTrace(mq2adjL22L22) 
 Trmq2adjL22L23 = cTrace(mq2adjL22L23) 
 Trmq2adjL23L21 = cTrace(mq2adjL23L21) 
 Trmq2adjL23L22 = cTrace(mq2adjL23L22) 
 Trmq2adjL23L23 = cTrace(mq2adjL23L23) 
 Trmu2YuadjYu = cTrace(mu2YuadjYu) 
 sqrt3ov5 =Sqrt(3._dp/5._dp) 
 ooSqrt15 =1._dp/sqrt(15._dp) 
 g1p2 =g1**2 
 g1p3 =g1**3 
 g2p2 =g2**2 
 g2p3 =g2**3 
 g3p2 =g3**2 
 g3p3 =g3**3 
 g1p4 =g1**4 
 g1p5 =g1**5 
 g2p4 =g2**4 
 g2p5 =g2**5 
 g3p4 =g3**4 
 g3p5 =g3**5 


If (TwoLoopRGE) Then 
 YdadjYu = Matmul(Yd,adjYu) 
 YdadjTd = Matmul(Yd,adjTd) 
 YdadjTu = Matmul(Yd,adjTu) 
 YeadjTe = Matmul(Ye,adjTe) 
 YuadjYd = Matmul(Yu,adjYd) 
 YuadjTd = Matmul(Yu,adjTd) 
 YuadjTu = Matmul(Yu,adjTu) 
 adjYdCmd2 = Matmul(adjYd,Conjg(md2)) 
 adjYeCme2 = Matmul(adjYe,Conjg(me2)) 
 adjYuCmu2 = Matmul(adjYu,Conjg(mu2)) 
 adjTdYd = Matmul(adjTd,Yd) 
 adjTeYe = Matmul(adjTe,Ye) 
 adjTuYu = Matmul(adjTu,Yu) 
 Cml2adjYe = Matmul(Conjg(ml2),adjYe) 
 Cmq2adjYd = Matmul(Conjg(mq2),adjYd) 
 Cmq2adjYu = Matmul(Conjg(mq2),adjYu) 
 CTdTpYd = Matmul(Conjg(Td),Transpose(Yd)) 
 CTeTpYe = Matmul(Conjg(Te),Transpose(Ye)) 
 CTuTpYu = Matmul(Conjg(Tu),Transpose(Yu)) 
 L11CL11 = Matmul(L11,Conjg(L11)) 
 L12CL12 = Matmul(L12,Conjg(L12)) 
 L13CL13 = Matmul(L13,Conjg(L13)) 
 L21adjL21 = Matmul(L21,adjL21) 
 L22adjL22 = Matmul(L22,adjL22) 
 L23adjL23 = Matmul(L23,adjL23) 
 TdadjYd = Matmul(Td,adjYd) 
 TdadjYu = Matmul(Td,adjYu) 
 TdadjTu = Matmul(Td,adjTu) 
 TeadjYe = Matmul(Te,adjYe) 
 TuadjYd = Matmul(Tu,adjYd) 
 TuadjYu = Matmul(Tu,adjYu) 
 TuadjTd = Matmul(Tu,adjTd) 
 TpL21CL21 = Matmul(Transpose(L21),Conjg(L21)) 
Forall(i2=1:3)  TpL21CL21(i2,i2) =  Real(TpL21CL21(i2,i2),dp) 
 TpL22CL22 = Matmul(Transpose(L22),Conjg(L22)) 
Forall(i2=1:3)  TpL22CL22(i2,i2) =  Real(TpL22CL22(i2,i2),dp) 
 TpL23CL23 = Matmul(Transpose(L23),Conjg(L23)) 
Forall(i2=1:3)  TpL23CL23(i2,i2) =  Real(TpL23CL23(i2,i2),dp) 
 md2YdadjYu = Matmul(md2,YdadjYu) 
 ml2L11CL11 = Matmul(ml2,L11CL11) 
 ml2L12CL12 = Matmul(ml2,L12CL12) 
 ml2L13CL13 = Matmul(ml2,L13CL13) 
 ml2L21adjL21 = Matmul(ml2,L21adjL21) 
 ml2L22adjL22 = Matmul(ml2,L22adjL22) 
 ml2L23adjL23 = Matmul(ml2,L23adjL23) 
 mq2TpL21CL21 = Matmul(mq2,TpL21CL21) 
 mq2TpL22CL22 = Matmul(mq2,TpL22CL22) 
 mq2TpL23CL23 = Matmul(mq2,TpL23CL23) 
 mu2YuadjYd = Matmul(mu2,YuadjYd) 
 Ydmq2adjYu = Matmul(Yd,mq2adjYu) 
 YdadjYdCmd2 = Matmul(Yd,adjYdCmd2) 
 YdadjYumu2 = Matmul(Yd,adjYumu2) 
 YdadjTdTd = Matmul(Yd,adjTdTd) 
 YdCmq2adjYd = Matmul(Yd,Cmq2adjYd) 
Forall(i2=1:3)  YdCmq2adjYd(i2,i2) =  Real(YdCmq2adjYd(i2,i2),dp) 
 YeadjYeCme2 = Matmul(Ye,adjYeCme2) 
 YeadjTeTe = Matmul(Ye,adjTeTe) 
 YeCml2adjYe = Matmul(Ye,Cml2adjYe) 
Forall(i2=1:3)  YeCml2adjYe(i2,i2) =  Real(YeCml2adjYe(i2,i2),dp) 
 Yumq2adjYd = Matmul(Yu,mq2adjYd) 
 YuadjYdmd2 = Matmul(Yu,adjYdmd2) 
 YuadjYuCmu2 = Matmul(Yu,adjYuCmu2) 
 YuadjTuTu = Matmul(Yu,adjTuTu) 
 YuCmq2adjYu = Matmul(Yu,Cmq2adjYu) 
Forall(i2=1:3)  YuCmq2adjYu(i2,i2) =  Real(YuCmq2adjYu(i2,i2),dp) 
 adjYdYdadjYd = Matmul(adjYd,YdadjYd) 
 adjYdYdadjYu = Matmul(adjYd,YdadjYu) 
 adjYdYdadjTd = Matmul(adjYd,YdadjTd) 
 adjYdYdadjTu = Matmul(adjYd,YdadjTu) 
 adjYdTdadjYd = Matmul(adjYd,TdadjYd) 
 adjYdTdadjYu = Matmul(adjYd,TdadjYu) 
 adjYdTdadjTd = Matmul(adjYd,TdadjTd) 
 adjYdTdadjTu = Matmul(adjYd,TdadjTu) 
 adjYeYeadjYe = Matmul(adjYe,YeadjYe) 
 adjYeYeadjTe = Matmul(adjYe,YeadjTe) 
 adjYeTeadjYe = Matmul(adjYe,TeadjYe) 
 adjYeTeadjTe = Matmul(adjYe,TeadjTe) 
 adjYuYuadjYd = Matmul(adjYu,YuadjYd) 
 adjYuYuadjYu = Matmul(adjYu,YuadjYu) 
 adjYuYuadjTd = Matmul(adjYu,YuadjTd) 
 adjYuYuadjTu = Matmul(adjYu,YuadjTu) 
 adjYuTuadjYd = Matmul(adjYu,TuadjYd) 
 adjYuTuadjYu = Matmul(adjYu,TuadjYu) 
 adjYuTuadjTd = Matmul(adjYu,TuadjTd) 
 adjYuTuadjTu = Matmul(adjYu,TuadjTu) 
 adjTdYdadjYd = Matmul(adjTd,YdadjYd) 
 adjTdYdadjYu = Matmul(adjTd,YdadjYu) 
 adjTdTdadjYd = Matmul(adjTd,TdadjYd) 
 adjTdTdadjYu = Matmul(adjTd,TdadjYu) 
 adjTeYeadjYe = Matmul(adjTe,YeadjYe) 
 adjTeTeadjYe = Matmul(adjTe,TeadjYe) 
 adjTuYuadjYd = Matmul(adjTu,YuadjYd) 
 adjTuYuadjYu = Matmul(adjTu,YuadjYu) 
 adjTuTuadjYd = Matmul(adjTu,TuadjYd) 
 adjTuTuadjYu = Matmul(adjTu,TuadjYu) 
 TdadjTdYd = Matmul(Td,adjTdYd) 
 TeadjTeYe = Matmul(Te,adjTeYe) 
 TuadjTuYu = Matmul(Tu,adjTuYu) 
 md2YdadjYdYd = Matmul(md2,YdadjYdYd) 
 me2YeadjYeYe = Matmul(me2,YeadjYeYe) 
 ml2adjYeYeadjYe = Matmul(ml2,adjYeYeadjYe) 
 mq2adjYdYdadjYd = Matmul(mq2,adjYdYdadjYd) 
 mq2adjYdYdadjYu = Matmul(mq2,adjYdYdadjYu) 
 mq2adjYuYuadjYd = Matmul(mq2,adjYuYuadjYd) 
 mq2adjYuYuadjYu = Matmul(mq2,adjYuYuadjYu) 
 mu2YuadjYuYu = Matmul(mu2,YuadjYuYu) 
 Ydmq2adjYdYd = Matmul(Yd,mq2adjYdYd) 
 YdadjYdmd2Yd = Matmul(Yd,adjYdmd2Yd) 
 YdadjYdYdmq2 = Matmul(Yd,adjYdYdmq2) 
 YdadjYdYdadjYd = Matmul(Yd,adjYdYdadjYd) 
Forall(i2=1:3)  YdadjYdYdadjYd(i2,i2) =  Real(YdadjYdYdadjYd(i2,i2),dp) 
 YdadjYdTdadjYd = Matmul(Yd,adjYdTdadjYd) 
 YdadjYdTdadjTd = Matmul(Yd,adjYdTdadjTd) 
 YdadjYuYuadjYd = Matmul(Yd,adjYuYuadjYd) 
Forall(i2=1:3)  YdadjYuYuadjYd(i2,i2) =  Real(YdadjYuYuadjYd(i2,i2),dp) 
 YdadjYuTuadjYd = Matmul(Yd,adjYuTuadjYd) 
 YdadjYuTuadjTd = Matmul(Yd,adjYuTuadjTd) 
 YdadjTdTdadjYd = Matmul(Yd,adjTdTdadjYd) 
 YdadjTuTuadjYd = Matmul(Yd,adjTuTuadjYd) 
 Yeml2adjYeYe = Matmul(Ye,ml2adjYeYe) 
 YeadjYeme2Ye = Matmul(Ye,adjYeme2Ye) 
 YeadjYeYeml2 = Matmul(Ye,adjYeYeml2) 
 YeadjYeYeadjYe = Matmul(Ye,adjYeYeadjYe) 
Forall(i2=1:3)  YeadjYeYeadjYe(i2,i2) =  Real(YeadjYeYeadjYe(i2,i2),dp) 
 YeadjYeTeadjYe = Matmul(Ye,adjYeTeadjYe) 
 YeadjYeTeadjTe = Matmul(Ye,adjYeTeadjTe) 
 YeadjTeTeadjYe = Matmul(Ye,adjTeTeadjYe) 
 Yumq2adjYuYu = Matmul(Yu,mq2adjYuYu) 
 YuadjYdYdadjYu = Matmul(Yu,adjYdYdadjYu) 
Forall(i2=1:3)  YuadjYdYdadjYu(i2,i2) =  Real(YuadjYdYdadjYu(i2,i2),dp) 
 YuadjYdTdadjYu = Matmul(Yu,adjYdTdadjYu) 
 YuadjYdTdadjTu = Matmul(Yu,adjYdTdadjTu) 
 YuadjYumu2Yu = Matmul(Yu,adjYumu2Yu) 
 YuadjYuYumq2 = Matmul(Yu,adjYuYumq2) 
 YuadjYuYuadjYu = Matmul(Yu,adjYuYuadjYu) 
Forall(i2=1:3)  YuadjYuYuadjYu(i2,i2) =  Real(YuadjYuYuadjYu(i2,i2),dp) 
 YuadjYuTuadjYu = Matmul(Yu,adjYuTuadjYu) 
 YuadjYuTuadjTu = Matmul(Yu,adjYuTuadjTu) 
 YuadjTdTdadjYu = Matmul(Yu,adjTdTdadjYu) 
 YuadjTuTuadjYu = Matmul(Yu,adjTuTuadjYu) 
 adjYdmd2YdadjYd = Matmul(adjYd,md2YdadjYd) 
 adjYdmd2YdadjYu = Matmul(adjYd,md2YdadjYu) 
 adjYdYdmq2adjYd = Matmul(adjYd,Ydmq2adjYd) 
 adjYdYdmq2adjYu = Matmul(adjYd,Ydmq2adjYu) 
 adjYdYdadjYdmd2 = Matmul(adjYd,YdadjYdmd2) 
 adjYdYdadjYdYd = Matmul(adjYd,YdadjYdYd) 
Forall(i2=1:3)  adjYdYdadjYdYd(i2,i2) =  Real(adjYdYdadjYdYd(i2,i2),dp) 
 adjYdYdadjYdTd = Matmul(adjYd,YdadjYdTd) 
 adjYdYdadjYumu2 = Matmul(adjYd,YdadjYumu2) 
 adjYdYdadjYuYu = Matmul(adjYd,YdadjYuYu) 
 adjYdYdadjYuTu = Matmul(adjYd,YdadjYuTu) 
 adjYdYdadjTdTd = Matmul(adjYd,YdadjTdTd) 
 adjYdTdadjYdYd = Matmul(adjYd,TdadjYdYd) 
 adjYdTdadjYuYu = Matmul(adjYd,TdadjYuYu) 
 adjYdTdadjTdYd = Matmul(adjYd,TdadjTdYd) 
 adjYeme2YeadjYe = Matmul(adjYe,me2YeadjYe) 
 adjYeYeml2adjYe = Matmul(adjYe,Yeml2adjYe) 
 adjYeYeadjYeme2 = Matmul(adjYe,YeadjYeme2) 
 adjYeYeadjYeYe = Matmul(adjYe,YeadjYeYe) 
Forall(i2=1:3)  adjYeYeadjYeYe(i2,i2) =  Real(adjYeYeadjYeYe(i2,i2),dp) 
 adjYeYeadjYeTe = Matmul(adjYe,YeadjYeTe) 
 adjYeYeadjTeTe = Matmul(adjYe,YeadjTeTe) 
 adjYeTeadjYeYe = Matmul(adjYe,TeadjYeYe) 
 adjYeTeadjTeYe = Matmul(adjYe,TeadjTeYe) 
 adjYumu2YuadjYd = Matmul(adjYu,mu2YuadjYd) 
 adjYumu2YuadjYu = Matmul(adjYu,mu2YuadjYu) 
 adjYuYumq2adjYd = Matmul(adjYu,Yumq2adjYd) 
 adjYuYumq2adjYu = Matmul(adjYu,Yumq2adjYu) 
 adjYuYuadjYdmd2 = Matmul(adjYu,YuadjYdmd2) 
 adjYuYuadjYdYd = Matmul(adjYu,YuadjYdYd) 
 adjYuYuadjYdTd = Matmul(adjYu,YuadjYdTd) 
 adjYuYuadjYumu2 = Matmul(adjYu,YuadjYumu2) 
 adjYuYuadjYuYu = Matmul(adjYu,YuadjYuYu) 
Forall(i2=1:3)  adjYuYuadjYuYu(i2,i2) =  Real(adjYuYuadjYuYu(i2,i2),dp) 
 adjYuYuadjYuTu = Matmul(adjYu,YuadjYuTu) 
 adjYuYuadjTuTu = Matmul(adjYu,YuadjTuTu) 
 adjYuTuadjYdYd = Matmul(adjYu,TuadjYdYd) 
 adjYuTuadjYuYu = Matmul(adjYu,TuadjYuYu) 
 adjYuTuadjTuYu = Matmul(adjYu,TuadjTuYu) 
 adjTdYdadjYdTd = Matmul(adjTd,YdadjYdTd) 
 adjTdTdadjYdYd = Matmul(adjTd,TdadjYdYd) 
 adjTeYeadjYeTe = Matmul(adjTe,YeadjYeTe) 
 adjTeTeadjYeYe = Matmul(adjTe,TeadjYeYe) 
 adjTuYuadjYuTu = Matmul(adjTu,YuadjYuTu) 
 adjTuTuadjYuYu = Matmul(adjTu,TuadjYuYu) 
 TdadjYdYdadjTd = Matmul(Td,adjYdYdadjTd) 
 TdadjYuYuadjTd = Matmul(Td,adjYuYuadjTd) 
 TdadjTdYdadjYd = Matmul(Td,adjTdYdadjYd) 
 TdadjTuYuadjYd = Matmul(Td,adjTuYuadjYd) 
 TeadjYeYeadjTe = Matmul(Te,adjYeYeadjTe) 
 TeadjTeYeadjYe = Matmul(Te,adjTeYeadjYe) 
 TuadjYdYdadjTu = Matmul(Tu,adjYdYdadjTu) 
 TuadjYuYuadjTu = Matmul(Tu,adjYuYuadjTu) 
 TuadjTdYdadjYu = Matmul(Tu,adjTdYdadjYu) 
 TuadjTuYuadjYu = Matmul(Tu,adjTuYuadjYu) 
 md2YdadjYdYdadjYd = Matmul(md2,YdadjYdYdadjYd) 
 md2YdadjYuYuadjYd = Matmul(md2,YdadjYuYuadjYd) 
 me2YeadjYeYeadjYe = Matmul(me2,YeadjYeYeadjYe) 
 ml2adjYeYeadjYeYe = Matmul(ml2,adjYeYeadjYeYe) 
 mq2adjYdYdadjYdYd = Matmul(mq2,adjYdYdadjYdYd) 
 mq2adjYdYdadjYuYu = Matmul(mq2,adjYdYdadjYuYu) 
 mq2adjYuYuadjYdYd = Matmul(mq2,adjYuYuadjYdYd) 
 mq2adjYuYuadjYuYu = Matmul(mq2,adjYuYuadjYuYu) 
 mu2YuadjYdYdadjYu = Matmul(mu2,YuadjYdYdadjYu) 
 mu2YuadjYuYuadjYu = Matmul(mu2,YuadjYuYuadjYu) 
 Ydmq2adjYdYdadjYd = Matmul(Yd,mq2adjYdYdadjYd) 
 Ydmq2adjYuYuadjYd = Matmul(Yd,mq2adjYuYuadjYd) 
 YdadjYdmd2YdadjYd = Matmul(Yd,adjYdmd2YdadjYd) 
Forall(i2=1:3)  YdadjYdmd2YdadjYd(i2,i2) =  Real(YdadjYdmd2YdadjYd(i2,i2),dp) 
 YdadjYdYdmq2adjYd = Matmul(Yd,adjYdYdmq2adjYd) 
 YdadjYdYdadjYdmd2 = Matmul(Yd,adjYdYdadjYdmd2) 
 YdadjYdYdadjYdYd = Matmul(Yd,adjYdYdadjYdYd) 
 YdadjYdYdadjYdTd = Matmul(Yd,adjYdYdadjYdTd) 
 YdadjYdTdadjYdYd = Matmul(Yd,adjYdTdadjYdYd) 
 YdadjYumu2YuadjYd = Matmul(Yd,adjYumu2YuadjYd) 
Forall(i2=1:3)  YdadjYumu2YuadjYd(i2,i2) =  Real(YdadjYumu2YuadjYd(i2,i2),dp) 
 YdadjYuYumq2adjYd = Matmul(Yd,adjYuYumq2adjYd) 
 YdadjYuYuadjYdmd2 = Matmul(Yd,adjYuYuadjYdmd2) 
 YdadjYuYuadjYdYd = Matmul(Yd,adjYuYuadjYdYd) 
 YdadjYuYuadjYdTd = Matmul(Yd,adjYuYuadjYdTd) 
 YdadjYuYuadjYuYu = Matmul(Yd,adjYuYuadjYuYu) 
 YdadjYuYuadjYuTu = Matmul(Yd,adjYuYuadjYuTu) 
 YdadjYuTuadjYdYd = Matmul(Yd,adjYuTuadjYdYd) 
 YdadjYuTuadjYuYu = Matmul(Yd,adjYuTuadjYuYu) 
 Yeml2adjYeYeadjYe = Matmul(Ye,ml2adjYeYeadjYe) 
 YeadjYeme2YeadjYe = Matmul(Ye,adjYeme2YeadjYe) 
Forall(i2=1:3)  YeadjYeme2YeadjYe(i2,i2) =  Real(YeadjYeme2YeadjYe(i2,i2),dp) 
 YeadjYeYeml2adjYe = Matmul(Ye,adjYeYeml2adjYe) 
 YeadjYeYeadjYeme2 = Matmul(Ye,adjYeYeadjYeme2) 
 YeadjYeYeadjYeYe = Matmul(Ye,adjYeYeadjYeYe) 
 YeadjYeYeadjYeTe = Matmul(Ye,adjYeYeadjYeTe) 
 YeadjYeTeadjYeYe = Matmul(Ye,adjYeTeadjYeYe) 
 Yumq2adjYdYdadjYu = Matmul(Yu,mq2adjYdYdadjYu) 
 Yumq2adjYuYuadjYu = Matmul(Yu,mq2adjYuYuadjYu) 
 YuadjYdmd2YdadjYu = Matmul(Yu,adjYdmd2YdadjYu) 
Forall(i2=1:3)  YuadjYdmd2YdadjYu(i2,i2) =  Real(YuadjYdmd2YdadjYu(i2,i2),dp) 
 YuadjYdYdmq2adjYu = Matmul(Yu,adjYdYdmq2adjYu) 
 YuadjYdYdadjYdYd = Matmul(Yu,adjYdYdadjYdYd) 
 YuadjYdYdadjYdTd = Matmul(Yu,adjYdYdadjYdTd) 
 YuadjYdYdadjYumu2 = Matmul(Yu,adjYdYdadjYumu2) 
 YuadjYdYdadjYuYu = Matmul(Yu,adjYdYdadjYuYu) 
 YuadjYdYdadjYuTu = Matmul(Yu,adjYdYdadjYuTu) 
 YuadjYdTdadjYdYd = Matmul(Yu,adjYdTdadjYdYd) 
 YuadjYdTdadjYuYu = Matmul(Yu,adjYdTdadjYuYu) 
 YuadjYumu2YuadjYu = Matmul(Yu,adjYumu2YuadjYu) 
Forall(i2=1:3)  YuadjYumu2YuadjYu(i2,i2) =  Real(YuadjYumu2YuadjYu(i2,i2),dp) 
 YuadjYuYumq2adjYu = Matmul(Yu,adjYuYumq2adjYu) 
 YuadjYuYuadjYumu2 = Matmul(Yu,adjYuYuadjYumu2) 
 YuadjYuYuadjYuYu = Matmul(Yu,adjYuYuadjYuYu) 
 YuadjYuYuadjYuTu = Matmul(Yu,adjYuYuadjYuTu) 
 YuadjYuTuadjYuYu = Matmul(Yu,adjYuTuadjYuYu) 
 adjYdmd2YdadjYdYd = Matmul(adjYd,md2YdadjYdYd) 
 adjYdYdmq2adjYdYd = Matmul(adjYd,Ydmq2adjYdYd) 
Forall(i2=1:3)  adjYdYdmq2adjYdYd(i2,i2) =  Real(adjYdYdmq2adjYdYd(i2,i2),dp) 
 adjYdYdadjYdmd2Yd = Matmul(adjYd,YdadjYdmd2Yd) 
 adjYdYdadjYdYdmq2 = Matmul(adjYd,YdadjYdYdmq2) 
 adjYeme2YeadjYeYe = Matmul(adjYe,me2YeadjYeYe) 
 adjYeYeml2adjYeYe = Matmul(adjYe,Yeml2adjYeYe) 
Forall(i2=1:3)  adjYeYeml2adjYeYe(i2,i2) =  Real(adjYeYeml2adjYeYe(i2,i2),dp) 
 adjYeYeadjYeme2Ye = Matmul(adjYe,YeadjYeme2Ye) 
 adjYeYeadjYeYeml2 = Matmul(adjYe,YeadjYeYeml2) 
 adjYumu2YuadjYuYu = Matmul(adjYu,mu2YuadjYuYu) 
 adjYuYumq2adjYuYu = Matmul(adjYu,Yumq2adjYuYu) 
Forall(i2=1:3)  adjYuYumq2adjYuYu(i2,i2) =  Real(adjYuYumq2adjYuYu(i2,i2),dp) 
 adjYuYuadjYumu2Yu = Matmul(adjYu,YuadjYumu2Yu) 
 adjYuYuadjYuYumq2 = Matmul(adjYu,YuadjYuYumq2) 
 TdadjYdYdadjYdYd = Matmul(Td,adjYdYdadjYdYd) 
 TdadjYuYuadjYdYd = Matmul(Td,adjYuYuadjYdYd) 
 TdadjYuYuadjYuYu = Matmul(Td,adjYuYuadjYuYu) 
 TeadjYeYeadjYeYe = Matmul(Te,adjYeYeadjYeYe) 
 TuadjYdYdadjYdYd = Matmul(Tu,adjYdYdadjYdYd) 
 TuadjYdYdadjYuYu = Matmul(Tu,adjYdYdadjYuYu) 
 TuadjYuYuadjYuYu = Matmul(Tu,adjYuYuadjYuYu) 
 TrCTdTpYd = cTrace(CTdTpYd)
 TrCTeTpYe = cTrace(CTeTpYe)
 TrCTuTpYu = cTrace(CTuTpYu)
 Trml2L11CL11 = cTrace(ml2L11CL11)
 Trml2L12CL12 = cTrace(ml2L12CL12)
 Trml2L13CL13 = cTrace(ml2L13CL13)
 Trml2L21adjL21 = cTrace(ml2L21adjL21)
 Trml2L22adjL22 = cTrace(ml2L22adjL22)
 Trml2L23adjL23 = cTrace(ml2L23adjL23)
 Trmq2TpL21CL21 = cTrace(mq2TpL21CL21)
 Trmq2TpL22CL22 = cTrace(mq2TpL22CL22)
 Trmq2TpL23CL23 = cTrace(mq2TpL23CL23)
 TrYdadjYdCmd2 = cTrace(YdadjYdCmd2)
 TrYdCmq2adjYd = Real(cTrace(YdCmq2adjYd),dp)  
 TrYeadjYeCme2 = cTrace(YeadjYeCme2)
 TrYeCml2adjYe = Real(cTrace(YeCml2adjYe),dp)  
 TrYuadjYuCmu2 = cTrace(YuadjYuCmu2)
 TrYuCmq2adjYu = Real(cTrace(YuCmq2adjYu),dp)  
 TrYdadjYdYdadjYd = Real(cTrace(YdadjYdYdadjYd),dp)  
 TrYdadjYdTdadjYd = cTrace(YdadjYdTdadjYd)
 TrYdadjYdTdadjTd = cTrace(YdadjYdTdadjTd)
 TrYdadjYuYuadjYd = Real(cTrace(YdadjYuYuadjYd),dp)  
 TrYdadjYuTuadjYd = cTrace(YdadjYuTuadjYd)
 TrYdadjYuTuadjTd = cTrace(YdadjYuTuadjTd)
 TrYdadjTdTdadjYd = cTrace(YdadjTdTdadjYd)
 TrYdadjTuTuadjYd = cTrace(YdadjTuTuadjYd)
 TrYeadjYeYeadjYe = Real(cTrace(YeadjYeYeadjYe),dp)  
 TrYeadjYeTeadjYe = cTrace(YeadjYeTeadjYe)
 TrYeadjYeTeadjTe = cTrace(YeadjYeTeadjTe)
 TrYeadjTeTeadjYe = cTrace(YeadjTeTeadjYe)
 TrYuadjYdTdadjYu = cTrace(YuadjYdTdadjYu)
 TrYuadjYdTdadjTu = cTrace(YuadjYdTdadjTu)
 TrYuadjYuYuadjYu = Real(cTrace(YuadjYuYuadjYu),dp)  
 TrYuadjYuTuadjYu = cTrace(YuadjYuTuadjYu)
 TrYuadjYuTuadjTu = cTrace(YuadjYuTuadjTu)
 TrYuadjTdTdadjYu = cTrace(YuadjTdTdadjYu)
 TrYuadjTuTuadjYu = cTrace(YuadjTuTuadjYu)
 Trmd2YdadjYdYdadjYd = cTrace(md2YdadjYdYdadjYd)
 Trmd2YdadjYuYuadjYd = cTrace(md2YdadjYuYuadjYd)
 Trme2YeadjYeYeadjYe = cTrace(me2YeadjYeYeadjYe)
 Trml2adjYeYeadjYeYe = cTrace(ml2adjYeYeadjYeYe)
 Trmq2adjYdYdadjYdYd = cTrace(mq2adjYdYdadjYdYd)
 Trmq2adjYdYdadjYuYu = cTrace(mq2adjYdYdadjYuYu)
 Trmq2adjYuYuadjYdYd = cTrace(mq2adjYuYuadjYdYd)
 Trmq2adjYuYuadjYuYu = cTrace(mq2adjYuYuadjYuYu)
 Trmu2YuadjYdYdadjYu = cTrace(mu2YuadjYdYdadjYu)
 Trmu2YuadjYuYuadjYu = cTrace(mu2YuadjYuYuadjYu)
 g1p4 =g1**4 
 g1p5 =g1**5 
 g2p4 =g2**4 
 g2p5 =g2**5 
 g3p4 =g3**4 
 g3p5 =g3**5 
End If 
 
 
Tr1(1) = g1*sqrt3ov5*(-1._dp*(mHd2) + mHu2 + Trmd2 + Trme2 - Trml2 + Trmq2 -          & 
&  2._dp*(Trmu2))

If (TwoLoopRGE) Then 
Tr2U1(1, 1) = (g1p2*(3._dp*(mHd2) + 3._dp*(mHu2) + 2._dp*(Trmd2) + 6._dp*(Trme2)      & 
&  + 3._dp*(Trml2) + Trmq2 + 8._dp*(Trmu2)))/10._dp

Tr3(1) = -(g1*ooSqrt15*(9*g1p2*mHd2 + 45*g2p2*mHd2 - 9*g1p2*mHu2 - 45*g2p2*mHu2 -     & 
&  4*(g1p2 + 20._dp*(g3p2))*Trmd2 - 36*g1p2*Trme2 + 9*g1p2*Trml2 + 45*g2p2*Trml2 +       & 
&  30._dp*(Trml2L11CL11) + 30._dp*(Trml2L12CL12) + 30._dp*(Trml2L13CL13) -               & 
&  90._dp*(Trml2L21adjL21) - 90._dp*(Trml2L22adjL22) - 90._dp*(Trml2L23adjL23)           & 
&  - g1p2*Trmq2 - 45*g2p2*Trmq2 - 80*g3p2*Trmq2 + 30._dp*(Trmq2TpL21CL21) +              & 
&  30._dp*(Trmq2TpL22CL22) + 30._dp*(Trmq2TpL23CL23) + 32*g1p2*Trmu2 + 160*g3p2*Trmu2 -  & 
&  90*mHd2*TrYdadjYd + 60._dp*(TrYdadjYdCmd2) + 30._dp*(TrYdCmq2adjYd) - 30*mHd2*TrYeadjYe +& 
&  60._dp*(TrYeadjYeCme2) - 30._dp*(TrYeCml2adjYe) + 90*mHu2*TrYuadjYu - 120._dp*(TrYuadjYuCmu2)& 
&  + 30._dp*(TrYuCmq2adjYu) + 60*TrCL21TpL21*md2(1,1) + 60*TrCL22TpL21*md2(1,            & 
& 2) + 60*TrCL23TpL21*md2(1,3) + 60*TrCL21TpL22*md2(2,1) + 60*TrCL22TpL22*md2(2,         & 
& 2) + 60*TrCL23TpL22*md2(2,3) + 60*TrCL21TpL23*md2(3,1) + 60*TrCL22TpL23*md2(3,         & 
& 2) + 60*TrCL23TpL23*md2(3,3) - 30*TrCL11L11*me2(1,1) - 30*TrCL12L11*me2(1,             & 
& 2) - 30*TrCL13L11*me2(1,3) - 30*TrCL11L12*me2(2,1) - 30*TrCL12L12*me2(2,               & 
& 2) - 30*TrCL13L12*me2(2,3) - 30*TrCL11L13*me2(3,1) - 30*TrCL12L13*me2(3,               & 
& 2) - 30*TrCL13L13*me2(3,3)))/20._dp

Tr2(2) = (mHd2 + mHu2 + Trml2 + 3._dp*(Trmq2))/2._dp

Tr2(3) = (Trmd2 + 2._dp*(Trmq2) + Trmu2)/2._dp

End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 33._dp*(g1p3)/5._dp

 
 
If (TwoLoopRGE) Then 
betag12 = 199._dp*(g1p5)/25._dp + (27*g1p3*g2p2)/5._dp + (88*g1p3*g3p2)/5._dp - (14*g1p3*TrYdadjYd)/5._dp -& 
&  (18*g1p3*TrYeadjYe)/5._dp - (26*g1p3*TrYuadjYu)/5._dp

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = g2p3

 
 
If (TwoLoopRGE) Then 
betag22 = (9*g1p2*g2p3)/5._dp + 25._dp*(g2p5) + 24*g2p3*g3p2 - 6*g2p3*TrYdadjYd -               & 
&  2*g2p3*TrYeadjYe - 6*g2p3*TrYuadjYu

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = -3._dp*(g3p3)

 
 
If (TwoLoopRGE) Then 
betag32 = (11*g1p2*g3p3)/5._dp + 9*g2p2*g3p3 + 14._dp*(g3p5) - 4*g3p3*TrYdadjYd -               & 
&  4*g3p3*TrYuadjYu

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! Yd 
!-------------------- 
 
betaYd1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYd1(i1,i2) = (-7*g1p2*Yd(i1,i2))/15._dp - 3*g2p2*Yd(i1,i2) - (16*g3p2*Yd(i1,i2))/3._dp +           & 
&  3*TrYdadjYd*Yd(i1,i2) + TrYeadjYe*Yd(i1,i2) + YdadjL21L21(i1,i2) + YdadjL22L22(i1,    & 
& i2) + YdadjL23L23(i1,i2) + 3*YdadjYdYd(i1,i2) + YdadjYuYu(i1,i2)
If (1.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL21*Yd(1,i2) + 2*TrCL22TpL21*Yd(2,i2) + 2*TrCL23TpL21*Yd(3,i2) +            & 
&  3*YdadjL21L21(1,i2) + 3*YdadjL22L21(2,i2) + 3*YdadjL23L21(3,i2) - YeCL11L21(1,        & 
& i2) - YeCL12L21(2,i2) - YeCL13L21(3,i2)
End If 
If (2.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL22*Yd(1,i2) + 2*TrCL22TpL22*Yd(2,i2) + 2*TrCL23TpL22*Yd(3,i2) +            & 
&  3*YdadjL21L22(1,i2) + 3*YdadjL22L22(2,i2) + 3*YdadjL23L22(3,i2) - YeCL11L22(1,        & 
& i2) - YeCL12L22(2,i2) - YeCL13L22(3,i2)
End If 
If (3.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL23*Yd(1,i2) + 2*TrCL22TpL23*Yd(2,i2) + 2*TrCL23TpL23*Yd(3,i2) +            & 
&  3*YdadjL21L23(1,i2) + 3*YdadjL22L23(2,i2) + 3*YdadjL23L23(3,i2) - YeCL11L23(1,        & 
& i2) - YeCL12L23(2,i2) - YeCL13L23(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaYd2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYd2(i1,i2) = (287*g1p4*Yd(i1,i2))/90._dp + g1p2*g2p2*Yd(i1,i2) + (15*g2p4*Yd(i1,i2))/2._dp +       & 
&  (8*g1p2*g3p2*Yd(i1,i2))/9._dp + 8*g2p2*g3p2*Yd(i1,i2) - (16*g3p4*Yd(i1,               & 
& i2))/9._dp - (2*g1p2*TrYdadjYd*Yd(i1,i2))/5._dp + 16*g3p2*TrYdadjYd*Yd(i1,             & 
& i2) - 9*TrYdadjYdYdadjYd*Yd(i1,i2) - 3*TrYdadjYuYuadjYd*Yd(i1,i2) + (6*g1p2*TrYeadjYe*Yd(i1,& 
& i2))/5._dp - 3*TrYeadjYeYeadjYe*Yd(i1,i2) + (4*g1p2*YdadjYdYd(i1,i2))/5._dp +          & 
&  6*g2p2*YdadjYdYd(i1,i2) - 9*TrYdadjYd*YdadjYdYd(i1,i2) - 3*TrYeadjYe*YdadjYdYd(i1,    & 
& i2) - 4*YdadjYdYdadjYdYd(i1,i2) + (4*g1p2*YdadjYuYu(i1,i2))/5._dp - 3*TrYuadjYu*YdadjYuYu(i1,& 
& i2) - 2*YdadjYuYuadjYdYd(i1,i2) - 2*YdadjYuYuadjYuYu(i1,i2)
End Do
End Do

 
DYd = oo16pi2*( betaYd1 + oo16pi2 * betaYd2 ) 

 
Else 
DYd = oo16pi2* betaYd1 
End If 
 
 
Call Chop(DYd) 

!-------------------- 
! Ye 
!-------------------- 
 
betaYe1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYe1(i1,i2) = (-9*g1p2*Ye(i1,i2))/5._dp - 3*g2p2*Ye(i1,i2) + 3*TrYdadjYd*Ye(i1,i2) + TrYeadjYe*Ye(i1,& 
& i2) + 3*YeadjYeYe(i1,i2) - YeCL11L11(i1,i2) - YeCL12L12(i1,i2) - YeCL13L13(i1,         & 
& i2) + 3*YeCL21TpL21(i1,i2) + 3*YeCL22TpL22(i1,i2) + 3*YeCL23TpL23(i1,i2)
If (1.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L11CL11TpYe(i2,1) - L11CL12TpYe(i2,2) - L11CL13TpYe(i2,3) - 3*L11CL21TpYd(i2,        & 
& 1) - 3*L11CL22TpYd(i2,2) - 3*L11CL23TpYd(i2,3) - TrCL11L11*Ye(1,i2) - TrCL12L11*Ye(2,  & 
& i2) - TrCL13L11*Ye(3,i2)
End If 
If (2.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L12CL11TpYe(i2,1) - L12CL12TpYe(i2,2) - L12CL13TpYe(i2,3) - 3*L12CL21TpYd(i2,        & 
& 1) - 3*L12CL22TpYd(i2,2) - 3*L12CL23TpYd(i2,3) - TrCL11L12*Ye(1,i2) - TrCL12L12*Ye(2,  & 
& i2) - TrCL13L12*Ye(3,i2)
End If 
If (3.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L13CL11TpYe(i2,1) - L13CL12TpYe(i2,2) - L13CL13TpYe(i2,3) - 3*L13CL21TpYd(i2,        & 
& 1) - 3*L13CL22TpYd(i2,2) - 3*L13CL23TpYd(i2,3) - TrCL11L13*Ye(1,i2) - TrCL12L13*Ye(2,  & 
& i2) - TrCL13L13*Ye(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaYe2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYe2(i1,i2) = (27*g1p4*Ye(i1,i2))/2._dp + (9*g1p2*g2p2*Ye(i1,i2))/5._dp + (15*g2p4*Ye(i1,           & 
& i2))/2._dp - (2*g1p2*TrYdadjYd*Ye(i1,i2))/5._dp + 16*g3p2*TrYdadjYd*Ye(i1,             & 
& i2) - 9*TrYdadjYdYdadjYd*Ye(i1,i2) - 3*TrYdadjYuYuadjYd*Ye(i1,i2) + (6*g1p2*TrYeadjYe*Ye(i1,& 
& i2))/5._dp - 3*TrYeadjYeYeadjYe*Ye(i1,i2) + 6*g2p2*YeadjYeYe(i1,i2) - 9*TrYdadjYd*YeadjYeYe(i1,& 
& i2) - 3*TrYeadjYe*YeadjYeYe(i1,i2) - 4*YeadjYeYeadjYeYe(i1,i2)
End Do
End Do

 
DYe = oo16pi2*( betaYe1 + oo16pi2 * betaYe2 ) 

 
Else 
DYe = oo16pi2* betaYe1 
End If 
 
 
Call Chop(DYe) 

!-------------------- 
! L1 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,1) = L11adjYeYe(i1,i2) - 2*L11CL11L11(i1,i2) - L11CL12L12(i1,i2) - L11CL13L13(i1,          & 
& i2) + 3*L11CL21TpL21(i1,i2) + 3*L11CL22TpL22(i1,i2) + 3*L11CL23TpL23(i1,               & 
& i2) - L12CL12L11(i1,i2) - L13CL13L11(i1,i2) + 3*L21adjL21L11(i1,i2) + 3*L22adjL22L11(i1,& 
& i2) + 3*L23adjL23L11(i1,i2) + TpYeCYeL11(i1,i2) - (9*g1p2*L11(i1,i2))/5._dp -          & 
&  3*g2p2*L11(i1,i2) - TrCL11L11*L11(i1,i2) - TrCL12L11*L12(i1,i2) - TrCL13L11*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,2) = -L11CL11L12(i1,i2) + L12adjYeYe(i1,i2) - L12CL11L11(i1,i2) - 2*L12CL12L12(i1,         & 
& i2) - L12CL13L13(i1,i2) + 3*L12CL21TpL21(i1,i2) + 3*L12CL22TpL22(i1,i2) +              & 
&  3*L12CL23TpL23(i1,i2) - L13CL13L12(i1,i2) + 3*L21adjL21L12(i1,i2) + 3*L22adjL22L12(i1,& 
& i2) + 3*L23adjL23L12(i1,i2) + TpYeCYeL12(i1,i2) - TrCL11L12*L11(i1,i2) -               & 
&  (9*g1p2*L12(i1,i2))/5._dp - 3*g2p2*L12(i1,i2) - TrCL12L12*L12(i1,i2) - TrCL13L12*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,3) = -L11CL11L13(i1,i2) - L12CL12L13(i1,i2) + L13adjYeYe(i1,i2) - L13CL11L11(i1,           & 
& i2) - L13CL12L12(i1,i2) - 2*L13CL13L13(i1,i2) + 3*L13CL21TpL21(i1,i2) + 3*L13CL22TpL22(i1,& 
& i2) + 3*L13CL23TpL23(i1,i2) + 3*L21adjL21L13(i1,i2) + 3*L22adjL22L13(i1,               & 
& i2) + 3*L23adjL23L13(i1,i2) + TpYeCYeL13(i1,i2) - TrCL11L13*L11(i1,i2) -               & 
&  TrCL12L13*L12(i1,i2) - (9*g1p2*L13(i1,i2))/5._dp - 3*g2p2*L13(i1,i2) - TrCL13L13*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL11(i1,i2,i3) = betaL11(i1,i2,i3)-3*CYdTpL21(1,i2)*Ye(i3,i1) - 3*CYdTpL22(2,i2)*Ye(i3,i1) - 3*CYdTpL23(3,              & 
& i2)*Ye(i3,i1) + CYeL11(1,i2)*Ye(i3,i1) + CYeL12(2,i2)*Ye(i3,i1) + CYeL13(3,            & 
& i2)*Ye(i3,i1) + 3*CYdTpL21(1,i1)*Ye(i3,i2) + 3*CYdTpL22(2,i1)*Ye(i3,i2) +              & 
&  3*CYdTpL23(3,i1)*Ye(i3,i2) - CYeL11(1,i1)*Ye(i3,i2) - CYeL12(2,i1)*Ye(i3,             & 
& i2) - CYeL13(3,i1)*Ye(i3,i2) + 2*YeadjYe(i3,1)*L11(i1,i2) + 2*YeadjYe(i3,              & 
& 2)*L12(i1,i2) + 2*YeadjYe(i3,3)*L13(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL12(i1,i2,i3) = betaL12(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DL1 = oo16pi2*( betaL11 + oo16pi2 * betaL12 ) 

 
Else 
DL1 = oo16pi2* betaL11 
End If 
 
 
!-------------------- 
! L2 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,1) = -L11CL11L21(i1,i2) - L12CL12L21(i1,i2) - L13CL13L21(i1,i2) + 4*L21adjL21L21(i1,       & 
& i2) + L21adjL22L22(i1,i2) + L21adjL23L23(i1,i2) + L21adjYdYd(i1,i2) + L21adjYuYu(i1,   & 
& i2) + 3*L22adjL22L21(i1,i2) + 3*L23adjL23L21(i1,i2) + TpYeCYeL21(i1,i2) -              & 
&  (7*g1p2*L21(i1,i2))/15._dp - 3*g2p2*L21(i1,i2) - (16*g3p2*L21(i1,i2))/3._dp +         & 
&  2*TrCL21TpL21*L21(i1,i2) + 2*TrCL22TpL21*L22(i1,i2) + 2*TrCL23TpL21*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,2) = -L11CL11L22(i1,i2) - L12CL12L22(i1,i2) - L13CL13L22(i1,i2) + 3*L21adjL21L22(i1,       & 
& i2) + L22adjL21L21(i1,i2) + 4*L22adjL22L22(i1,i2) + L22adjL23L23(i1,i2) +              & 
&  L22adjYdYd(i1,i2) + L22adjYuYu(i1,i2) + 3*L23adjL23L22(i1,i2) + TpYeCYeL22(i1,        & 
& i2) + 2*TrCL21TpL22*L21(i1,i2) - (7*g1p2*L22(i1,i2))/15._dp - 3*g2p2*L22(i1,           & 
& i2) - (16*g3p2*L22(i1,i2))/3._dp + 2*TrCL22TpL22*L22(i1,i2) + 2*TrCL23TpL22*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,3) = -L11CL11L23(i1,i2) - L12CL12L23(i1,i2) - L13CL13L23(i1,i2) + 3*L21adjL21L23(i1,       & 
& i2) + 3*L22adjL22L23(i1,i2) + L23adjL21L21(i1,i2) + L23adjL22L22(i1,i2) +              & 
&  4*L23adjL23L23(i1,i2) + L23adjYdYd(i1,i2) + L23adjYuYu(i1,i2) + TpYeCYeL23(i1,        & 
& i2) + 2*TrCL21TpL23*L21(i1,i2) + 2*TrCL22TpL23*L22(i1,i2) - (7*g1p2*L23(i1,            & 
& i2))/15._dp - 3*g2p2*L23(i1,i2) - (16*g3p2*L23(i1,i2))/3._dp + 2*TrCL23TpL23*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL21(i1,i2,i3) = betaL21(i1,i2,i3)+3*CYdTpL21(1,i1)*Yd(i3,i2) + 3*CYdTpL22(2,i1)*Yd(i3,i2) + 3*CYdTpL23(3,               & 
& i1)*Yd(i3,i2) - CYeL11(1,i1)*Yd(i3,i2) - CYeL12(2,i1)*Yd(i3,i2) - CYeL13(3,            & 
& i1)*Yd(i3,i2) + 2*YdadjYd(i3,1)*L21(i1,i2) + 2*YdadjYd(i3,2)*L22(i1,i2) +              & 
&  2*YdadjYd(i3,3)*L23(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL22(i1,i2,i3) = betaL22(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DL2 = oo16pi2*( betaL21 + oo16pi2 * betaL22 ) 

 
Else 
DL2 = oo16pi2* betaL21 
End If 
 
 
!-------------------- 
! Yu 
!-------------------- 
 
betaYu1  = (-13*g1p2*Yu)/15._dp - 3*g2p2*Yu - (16*g3p2*Yu)/3._dp + 3*TrYuadjYu*Yu +   & 
&  YuadjL21L21 + YuadjL22L22 + YuadjL23L23 + YuadjYdYd + 3._dp*(YuadjYuYu)

 
 
If (TwoLoopRGE) Then 
betaYu2 = (2743*g1p4*Yu)/450._dp + g1p2*g2p2*Yu + (15*g2p4*Yu)/2._dp + (136*g1p2*g3p2*Yu)/45._dp +& 
&  8*g2p2*g3p2*Yu - (16*g3p4*Yu)/9._dp - 3*TrYdadjYuYuadjYd*Yu + (4*g1p2*TrYuadjYu*Yu)/5._dp +& 
&  16*g3p2*TrYuadjYu*Yu - 9*TrYuadjYuYuadjYu*Yu + (2*g1p2*YuadjYdYd)/5._dp -             & 
&  3*TrYdadjYd*YuadjYdYd - TrYeadjYe*YuadjYdYd - 2._dp*(YuadjYdYdadjYdYd) -              & 
&  2._dp*(YuadjYdYdadjYuYu) + (2*g1p2*YuadjYuYu)/5._dp + 6*g2p2*YuadjYuYu -              & 
&  9*TrYuadjYu*YuadjYuYu - 4._dp*(YuadjYuYuadjYuYu)

 
DYu = oo16pi2*( betaYu1 + oo16pi2 * betaYu2 ) 

 
Else 
DYu = oo16pi2* betaYu1 
End If 
 
 
Call Chop(DYu) 

!-------------------- 
! Mu 
!-------------------- 
 
betaMu1  = (-3*g1p2*Mu)/5._dp - 3*g2p2*Mu + 3*TrYdadjYd*Mu + TrYeadjYe*Mu +           & 
&  3*TrYuadjYu*Mu

 
 
If (TwoLoopRGE) Then 
betaMu2 = (207*g1p4*Mu)/50._dp + (9*g1p2*g2p2*Mu)/5._dp + (15*g2p4*Mu)/2._dp - (2*g1p2*TrYdadjYd*Mu)/5._dp +& 
&  16*g3p2*TrYdadjYd*Mu - 9*TrYdadjYdYdadjYd*Mu - 6*TrYdadjYuYuadjYd*Mu + (6*g1p2*TrYeadjYe*Mu)/5._dp -& 
&  3*TrYeadjYeYeadjYe*Mu + (4*g1p2*TrYuadjYu*Mu)/5._dp + 16*g3p2*TrYuadjYu*Mu -          & 
&  9*TrYuadjYuYuadjYu*Mu

 
DMu = oo16pi2*( betaMu1 + oo16pi2 * betaMu2 ) 

 
Else 
DMu = oo16pi2* betaMu1 
End If 
 
 
Call Chop(DMu) 

!-------------------- 
! Td 
!-------------------- 
 
betaTd1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTd1(i1,i2) = TdadjL21L21(i1,i2) + TdadjL22L22(i1,i2) + TdadjL23L23(i1,i2) + 5*TdadjYdYd(i1,        & 
& i2) + TdadjYuYu(i1,i2) + (14*g1p2*M1*Yd(i1,i2))/15._dp + (32*g3p2*M3*Yd(i1,            & 
& i2))/3._dp + 6*g2p2*M2*Yd(i1,i2) + 6*TradjYdTd*Yd(i1,i2) + 2*TradjYeTe*Yd(i1,          & 
& i2) + 2*YdadjL21T21(i1,i2) + 2*YdadjL22T22(i1,i2) + 2*YdadjL23T23(i1,i2) +             & 
&  4*YdadjYdTd(i1,i2) + 2*YdadjYuTu(i1,i2) - (7*g1p2*Td(i1,i2))/15._dp - 3*g2p2*Td(i1,   & 
& i2) - (16*g3p2*Td(i1,i2))/3._dp + 3*TrYdadjYd*Td(i1,i2) + TrYeadjYe*Td(i1,i2)
If (1.eq.i1) Then 
betaTd1(i1,i2) = betaTd1(i1,i2)+2*TpL21CL11TpTe(i2,1) + 2*TpL21CL12TpTe(i2,2) + 2*TpL21CL13TpTe(i2,3) +               & 
&  6*TpL21CL21TpTd(i2,1) + 6*TpL21CL22TpTd(i2,2) + 6*TpL21CL23TpTd(i2,3) +               & 
&  4*TradjL21T21*Yd(1,i2) + 4*TradjL22T21*Yd(2,i2) + 4*TradjL23T21*Yd(3,i2) +            & 
&  3*YdadjL21T21(1,i2) + 3*YdadjL22T21(2,i2) + 3*YdadjL23T21(3,i2) - YeCL11T21(1,        & 
& i2) - YeCL12T21(2,i2) - YeCL13T21(3,i2) + 2*TrCL21TpL21*Td(1,i2) + 2*TrCL22TpL21*Td(2, & 
& i2) + 2*TrCL23TpL21*Td(3,i2)
End If 
If (2.eq.i1) Then 
betaTd1(i1,i2) = betaTd1(i1,i2)+2*TpL22CL11TpTe(i2,1) + 2*TpL22CL12TpTe(i2,2) + 2*TpL22CL13TpTe(i2,3) +               & 
&  6*TpL22CL21TpTd(i2,1) + 6*TpL22CL22TpTd(i2,2) + 6*TpL22CL23TpTd(i2,3) +               & 
&  4*TradjL21T22*Yd(1,i2) + 4*TradjL22T22*Yd(2,i2) + 4*TradjL23T22*Yd(3,i2) +            & 
&  3*YdadjL21T22(1,i2) + 3*YdadjL22T22(2,i2) + 3*YdadjL23T22(3,i2) - YeCL11T22(1,        & 
& i2) - YeCL12T22(2,i2) - YeCL13T22(3,i2) + 2*TrCL21TpL22*Td(1,i2) + 2*TrCL22TpL22*Td(2, & 
& i2) + 2*TrCL23TpL22*Td(3,i2)
End If 
If (3.eq.i1) Then 
betaTd1(i1,i2) = betaTd1(i1,i2)+2*TpL23CL11TpTe(i2,1) + 2*TpL23CL12TpTe(i2,2) + 2*TpL23CL13TpTe(i2,3) +               & 
&  6*TpL23CL21TpTd(i2,1) + 6*TpL23CL22TpTd(i2,2) + 6*TpL23CL23TpTd(i2,3) +               & 
&  4*TradjL21T23*Yd(1,i2) + 4*TradjL22T23*Yd(2,i2) + 4*TradjL23T23*Yd(3,i2) +            & 
&  3*YdadjL21T23(1,i2) + 3*YdadjL22T23(2,i2) + 3*YdadjL23T23(3,i2) - YeCL11T23(1,        & 
& i2) - YeCL12T23(2,i2) - YeCL13T23(3,i2) + 2*TrCL21TpL23*Td(1,i2) + 2*TrCL22TpL23*Td(2, & 
& i2) + 2*TrCL23TpL23*Td(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaTd2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTd2(i1,i2) = (6*g1p2*TdadjYdYd(i1,i2))/5._dp + 12*g2p2*TdadjYdYd(i1,i2) - 15*TrYdadjYd*TdadjYdYd(i1,& 
& i2) - 5*TrYeadjYe*TdadjYdYd(i1,i2) - 6*TdadjYdYdadjYdYd(i1,i2) + (4*g1p2*TdadjYuYu(i1, & 
& i2))/5._dp - 3*TrYuadjYu*TdadjYuYu(i1,i2) - 4*TdadjYuYuadjYdYd(i1,i2) - 2*TdadjYuYuadjYuYu(i1,& 
& i2) - (574*g1p4*M1*Yd(i1,i2))/45._dp - 2*g1p2*g2p2*M1*Yd(i1,i2) - (16*g1p2*g3p2*M1*Yd(i1,& 
& i2))/9._dp - (16*g1p2*g3p2*M3*Yd(i1,i2))/9._dp - 16*g2p2*g3p2*M3*Yd(i1,i2) +           & 
&  (64*g3p4*M3*Yd(i1,i2))/9._dp - 2*g1p2*g2p2*M2*Yd(i1,i2) - 30*g2p4*M2*Yd(i1,           & 
& i2) - 16*g2p2*g3p2*M2*Yd(i1,i2) - (4*g1p2*TradjYdTd*Yd(i1,i2))/5._dp + 32*g3p2*TradjYdTd*Yd(i1,& 
& i2) + (12*g1p2*TradjYeTe*Yd(i1,i2))/5._dp + (4*g1p2*M1*TrYdadjYd*Yd(i1,i2))/5._dp -    & 
&  32*g3p2*M3*TrYdadjYd*Yd(i1,i2) - 36*TrYdadjYdTdadjYd*Yd(i1,i2) - 6*TrYdadjYuTuadjYd*Yd(i1,& 
& i2) - (12*g1p2*M1*TrYeadjYe*Yd(i1,i2))/5._dp - 12*TrYeadjYeTeadjYe*Yd(i1,              & 
& i2) - 6*TrYuadjYdTdadjYu*Yd(i1,i2) + (6*g1p2*YdadjYdTd(i1,i2))/5._dp + 6*g2p2*YdadjYdTd(i1,& 
& i2) - 12*TrYdadjYd*YdadjYdTd(i1,i2) - 4*TrYeadjYe*YdadjYdTd(i1,i2) - 8*YdadjYdTdadjYdYd(i1,& 
& i2) - (8*g1p2*M1*YdadjYdYd(i1,i2))/5._dp - 12*g2p2*M2*YdadjYdYd(i1,i2) -               & 
&  18*TradjYdTd*YdadjYdYd(i1,i2) - 6*TradjYeTe*YdadjYdYd(i1,i2) - 6*YdadjYdYdadjYdTd(i1, & 
& i2) + (8*g1p2*YdadjYuTu(i1,i2))/5._dp - 6*TrYuadjYu*YdadjYuTu(i1,i2) - 4*YdadjYuTuadjYdYd(i1,& 
& i2) - 4*YdadjYuTuadjYuYu(i1,i2) - (8*g1p2*M1*YdadjYuYu(i1,i2))/5._dp - 6*TradjYuTu*YdadjYuYu(i1,& 
& i2) - 2*YdadjYuYuadjYdTd(i1,i2) - 4*YdadjYuYuadjYuTu(i1,i2) + (287*g1p4*Td(i1,         & 
& i2))/90._dp + g1p2*g2p2*Td(i1,i2) + (15*g2p4*Td(i1,i2))/2._dp + (8*g1p2*g3p2*Td(i1,    & 
& i2))/9._dp + 8*g2p2*g3p2*Td(i1,i2) - (16*g3p4*Td(i1,i2))/9._dp - (2*g1p2*TrYdadjYd*Td(i1,& 
& i2))/5._dp + 16*g3p2*TrYdadjYd*Td(i1,i2) - 9*TrYdadjYdYdadjYd*Td(i1,i2) -              & 
&  3*TrYdadjYuYuadjYd*Td(i1,i2) + (6*g1p2*TrYeadjYe*Td(i1,i2))/5._dp - 3*TrYeadjYeYeadjYe*Td(i1,i2)
End Do
End Do

 
DTd = oo16pi2*( betaTd1 + oo16pi2 * betaTd2 ) 

 
Else 
DTd = oo16pi2* betaTd1 
End If 
 
 
Call Chop(DTd) 

!-------------------- 
! Te 
!-------------------- 
 
betaTe1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTe1(i1,i2) = 5*TeadjYeYe(i1,i2) - TeCL11L11(i1,i2) - TeCL12L12(i1,i2) - TeCL13L13(i1,              & 
& i2) + 3*TeCL21TpL21(i1,i2) + 3*TeCL22TpL22(i1,i2) + 3*TeCL23TpL23(i1,i2) +             & 
&  (18*g1p2*M1*Ye(i1,i2))/5._dp + 6*g2p2*M2*Ye(i1,i2) + 6*TradjYdTd*Ye(i1,               & 
& i2) + 2*TradjYeTe*Ye(i1,i2) + 4*YeadjYeTe(i1,i2) - 2*YeCL11T11(i1,i2) - 2*YeCL12T12(i1,& 
& i2) - 2*YeCL13T13(i1,i2) + 6*YeCL21TpT21(i1,i2) + 6*YeCL22TpT22(i1,i2) +               & 
&  6*YeCL23TpT23(i1,i2) - (9*g1p2*Te(i1,i2))/5._dp - 3*g2p2*Te(i1,i2) + 3*TrYdadjYd*Te(i1,& 
& i2) + TrYeadjYe*Te(i1,i2)
If (1.eq.i1) Then 
betaTe1(i1,i2) = betaTe1(i1,i2)-2*L11CL11TpTe(i2,1) - 2*L11CL12TpTe(i2,2) - 2*L11CL13TpTe(i2,3) - 6*L11CL21TpTd(i2,  & 
& 1) - 6*L11CL22TpTd(i2,2) - 6*L11CL23TpTd(i2,3) + 3*YdadjL21T11(1,i2) + 3*YdadjL22T11(2,& 
& i2) + 3*YdadjL23T11(3,i2) - 2*TrCL11T11*Ye(1,i2) - 2*TrCL12T11*Ye(2,i2) -              & 
&  2*TrCL13T11*Ye(3,i2) - YeCL11T11(1,i2) - YeCL12T11(2,i2) - YeCL13T11(3,               & 
& i2) - TrCL11L11*Te(1,i2) - TrCL12L11*Te(2,i2) - TrCL13L11*Te(3,i2)
End If 
If (2.eq.i1) Then 
betaTe1(i1,i2) = betaTe1(i1,i2)-2*L12CL11TpTe(i2,1) - 2*L12CL12TpTe(i2,2) - 2*L12CL13TpTe(i2,3) - 6*L12CL21TpTd(i2,  & 
& 1) - 6*L12CL22TpTd(i2,2) - 6*L12CL23TpTd(i2,3) + 3*YdadjL21T12(1,i2) + 3*YdadjL22T12(2,& 
& i2) + 3*YdadjL23T12(3,i2) - 2*TrCL11T12*Ye(1,i2) - 2*TrCL12T12*Ye(2,i2) -              & 
&  2*TrCL13T12*Ye(3,i2) - YeCL11T12(1,i2) - YeCL12T12(2,i2) - YeCL13T12(3,               & 
& i2) - TrCL11L12*Te(1,i2) - TrCL12L12*Te(2,i2) - TrCL13L12*Te(3,i2)
End If 
If (3.eq.i1) Then 
betaTe1(i1,i2) = betaTe1(i1,i2)-2*L13CL11TpTe(i2,1) - 2*L13CL12TpTe(i2,2) - 2*L13CL13TpTe(i2,3) - 6*L13CL21TpTd(i2,  & 
& 1) - 6*L13CL22TpTd(i2,2) - 6*L13CL23TpTd(i2,3) + 3*YdadjL21T13(1,i2) + 3*YdadjL22T13(2,& 
& i2) + 3*YdadjL23T13(3,i2) - 2*TrCL11T13*Ye(1,i2) - 2*TrCL12T13*Ye(2,i2) -              & 
&  2*TrCL13T13*Ye(3,i2) - YeCL11T13(1,i2) - YeCL12T13(2,i2) - YeCL13T13(3,               & 
& i2) - TrCL11L13*Te(1,i2) - TrCL12L13*Te(2,i2) - TrCL13L13*Te(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaTe2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTe2(i1,i2) = (-6*g1p2*TeadjYeYe(i1,i2))/5._dp + 12*g2p2*TeadjYeYe(i1,i2) - 15*TrYdadjYd*TeadjYeYe(i1,& 
& i2) - 5*TrYeadjYe*TeadjYeYe(i1,i2) - 6*TeadjYeYeadjYeYe(i1,i2) - 54*g1p4*M1*Ye(i1,     & 
& i2) - (18*g1p2*g2p2*M1*Ye(i1,i2))/5._dp - (18*g1p2*g2p2*M2*Ye(i1,i2))/5._dp -          & 
&  30*g2p4*M2*Ye(i1,i2) - (4*g1p2*TradjYdTd*Ye(i1,i2))/5._dp + 32*g3p2*TradjYdTd*Ye(i1,  & 
& i2) + (12*g1p2*TradjYeTe*Ye(i1,i2))/5._dp + (4*g1p2*M1*TrYdadjYd*Ye(i1,i2))/5._dp -    & 
&  32*g3p2*M3*TrYdadjYd*Ye(i1,i2) - 36*TrYdadjYdTdadjYd*Ye(i1,i2) - 6*TrYdadjYuTuadjYd*Ye(i1,& 
& i2) - (12*g1p2*M1*TrYeadjYe*Ye(i1,i2))/5._dp - 12*TrYeadjYeTeadjYe*Ye(i1,              & 
& i2) - 6*TrYuadjYdTdadjYu*Ye(i1,i2) + (6*g1p2*YeadjYeTe(i1,i2))/5._dp + 6*g2p2*YeadjYeTe(i1,& 
& i2) - 12*TrYdadjYd*YeadjYeTe(i1,i2) - 4*TrYeadjYe*YeadjYeTe(i1,i2) - 8*YeadjYeTeadjYeYe(i1,& 
& i2) - 12*g2p2*M2*YeadjYeYe(i1,i2) - 18*TradjYdTd*YeadjYeYe(i1,i2) - 6*TradjYeTe*YeadjYeYe(i1,& 
& i2) - 6*YeadjYeYeadjYeTe(i1,i2) + (27*g1p4*Te(i1,i2))/2._dp + (9*g1p2*g2p2*Te(i1,      & 
& i2))/5._dp + (15*g2p4*Te(i1,i2))/2._dp - (2*g1p2*TrYdadjYd*Te(i1,i2))/5._dp +          & 
&  16*g3p2*TrYdadjYd*Te(i1,i2) - 9*TrYdadjYdYdadjYd*Te(i1,i2) - 3*TrYdadjYuYuadjYd*Te(i1,& 
& i2) + (6*g1p2*TrYeadjYe*Te(i1,i2))/5._dp - 3*TrYeadjYeYeadjYe*Te(i1,i2)
End Do
End Do

 
DTe = oo16pi2*( betaTe1 + oo16pi2 * betaTe2 ) 

 
Else 
DTe = oo16pi2* betaTe1 
End If 
 
 
Call Chop(DTe) 

!-------------------- 
! T1 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaT11(i1,i2,1) = 2*L11adjYeTe(i1,i2) - 3*L11CL11T11(i1,i2) - 2*L11CL12T12(i1,i2) - 2*L11CL13T13(i1,    & 
& i2) + 6*L11CL21TpT21(i1,i2) + 6*L11CL22TpT22(i1,i2) + 6*L11CL23TpT23(i1,               & 
& i2) - L12CL12T11(i1,i2) - L13CL13T11(i1,i2) + 3*L21adjL21T11(i1,i2) + 3*L22adjL22T11(i1,& 
& i2) + 3*L23adjL23T11(i1,i2) + T11adjYeYe(i1,i2) - 3*T11CL11L11(i1,i2) - T11CL12L12(i1, & 
& i2) - T11CL13L13(i1,i2) + 3*T11CL21TpL21(i1,i2) + 3*T11CL22TpL22(i1,i2) +              & 
&  3*T11CL23TpL23(i1,i2) - 2*T12CL12L11(i1,i2) - 2*T13CL13L11(i1,i2) + 6*T21adjL21L11(i1,& 
& i2) + 6*T22adjL22L11(i1,i2) + 6*T23adjL23L11(i1,i2) + 2*TpTeCYeL11(i1,i2) +            & 
&  TpYeCYeT11(i1,i2) + (18*g1p2*M1*L11(i1,i2))/5._dp + 6*g2p2*M2*L11(i1,i2) -            & 
&  2*TrCL11T11*L11(i1,i2) - 2*TrCL12T11*L12(i1,i2) - 2*TrCL13T11*L13(i1,i2) -            & 
&  (9*g1p2*T11(i1,i2))/5._dp - 3*g2p2*T11(i1,i2) - TrCL11L11*T11(i1,i2) - TrCL12L11*T12(i1,& 
& i2) - TrCL13L11*T13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT11(i1,i2,2) = -L11CL11T12(i1,i2) + 2*L12adjYeTe(i1,i2) - 2*L12CL11T11(i1,i2) - 3*L12CL12T12(i1,     & 
& i2) - 2*L12CL13T13(i1,i2) + 6*L12CL21TpT21(i1,i2) + 6*L12CL22TpT22(i1,i2) +            & 
&  6*L12CL23TpT23(i1,i2) - L13CL13T12(i1,i2) + 3*L21adjL21T12(i1,i2) + 3*L22adjL22T12(i1,& 
& i2) + 3*L23adjL23T12(i1,i2) - 2*T11CL11L12(i1,i2) + T12adjYeYe(i1,i2) - T12CL11L11(i1, & 
& i2) - 3*T12CL12L12(i1,i2) - T12CL13L13(i1,i2) + 3*T12CL21TpL21(i1,i2) + 3*T12CL22TpL22(i1,& 
& i2) + 3*T12CL23TpL23(i1,i2) - 2*T13CL13L12(i1,i2) + 6*T21adjL21L12(i1,i2) +            & 
&  6*T22adjL22L12(i1,i2) + 6*T23adjL23L12(i1,i2) + 2*TpTeCYeL12(i1,i2) + TpYeCYeT12(i1,  & 
& i2) - 2*TrCL11T12*L11(i1,i2) + (18*g1p2*M1*L12(i1,i2))/5._dp + 6*g2p2*M2*L12(i1,       & 
& i2) - 2*TrCL12T12*L12(i1,i2) - 2*TrCL13T12*L13(i1,i2) - TrCL11L12*T11(i1,              & 
& i2) - (9*g1p2*T12(i1,i2))/5._dp - 3*g2p2*T12(i1,i2) - TrCL12L12*T12(i1,i2) -           & 
&  TrCL13L12*T13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT11(i1,i2,3) = -L11CL11T13(i1,i2) - L12CL12T13(i1,i2) + 2*L13adjYeTe(i1,i2) - 2*L13CL11T11(i1,       & 
& i2) - 2*L13CL12T12(i1,i2) - 3*L13CL13T13(i1,i2) + 6*L13CL21TpT21(i1,i2) +              & 
&  6*L13CL22TpT22(i1,i2) + 6*L13CL23TpT23(i1,i2) + 3*L21adjL21T13(i1,i2) +               & 
&  3*L22adjL22T13(i1,i2) + 3*L23adjL23T13(i1,i2) - 2*T11CL11L13(i1,i2) - 2*T12CL12L13(i1,& 
& i2) + T13adjYeYe(i1,i2) - T13CL11L11(i1,i2) - T13CL12L12(i1,i2) - 3*T13CL13L13(i1,     & 
& i2) + 3*T13CL21TpL21(i1,i2) + 3*T13CL22TpL22(i1,i2) + 3*T13CL23TpL23(i1,               & 
& i2) + 6*T21adjL21L13(i1,i2) + 6*T22adjL22L13(i1,i2) + 6*T23adjL23L13(i1,               & 
& i2) + 2*TpTeCYeL13(i1,i2) + TpYeCYeT13(i1,i2) - 2*TrCL11T13*L11(i1,i2) -               & 
&  2*TrCL12T13*L12(i1,i2) + (18*g1p2*M1*L13(i1,i2))/5._dp + 6*g2p2*M2*L13(i1,            & 
& i2) - 2*TrCL13T13*L13(i1,i2) - TrCL11L13*T11(i1,i2) - TrCL12L13*T12(i1,i2) -           & 
&  (9*g1p2*T13(i1,i2))/5._dp - 3*g2p2*T13(i1,i2) - TrCL13L13*T13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT11(i1,i2,i3) = betaT11(i1,i2,i3)-6*CYdTpT21(1,i2)*Ye(i3,i1) - 6*CYdTpT22(2,i2)*Ye(i3,i1) - 6*CYdTpT23(3,              & 
& i2)*Ye(i3,i1) + 2*CYeT11(1,i2)*Ye(i3,i1) + 2*CYeT12(2,i2)*Ye(i3,i1) + 2*CYeT13(3,      & 
& i2)*Ye(i3,i1) + 6*CYdTpT21(1,i1)*Ye(i3,i2) + 6*CYdTpT22(2,i1)*Ye(i3,i2) +              & 
&  6*CYdTpT23(3,i1)*Ye(i3,i2) - 2*CYeT11(1,i1)*Ye(i3,i2) - 2*CYeT12(2,i1)*Ye(i3,         & 
& i2) - 2*CYeT13(3,i1)*Ye(i3,i2) + 4*CYeTpTe(1,i3)*L11(i1,i2) + 4*CYeTpTe(2,             & 
& i3)*L12(i1,i2) + 4*CYeTpTe(3,i3)*L13(i1,i2) - 3*CYdTpL21(1,i2)*Te(i3,i1) -             & 
&  3*CYdTpL22(2,i2)*Te(i3,i1) - 3*CYdTpL23(3,i2)*Te(i3,i1) + CYeL11(1,i2)*Te(i3,         & 
& i1) + CYeL12(2,i2)*Te(i3,i1) + CYeL13(3,i2)*Te(i3,i1) + 3*CYdTpL21(1,i1)*Te(i3,        & 
& i2) + 3*CYdTpL22(2,i1)*Te(i3,i2) + 3*CYdTpL23(3,i1)*Te(i3,i2) - CYeL11(1,              & 
& i1)*Te(i3,i2) - CYeL12(2,i1)*Te(i3,i2) - CYeL13(3,i1)*Te(i3,i2) + 2*YeadjYe(i3,        & 
& 1)*T11(i1,i2) + 2*YeadjYe(i3,2)*T12(i1,i2) + 2*YeadjYe(i3,3)*T13(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaT12(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT12(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT12(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT12(i1,i2,i3) = betaT12(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DT1 = oo16pi2*( betaT11 + oo16pi2 * betaT12 ) 

 
Else 
DT1 = oo16pi2* betaT11 
End If 
 
 
!-------------------- 
! T2 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaT21(i1,i2,1) = -L11CL11T21(i1,i2) - L12CL12T21(i1,i2) - L13CL13T21(i1,i2) + 5*L21adjL21T21(i1,       & 
& i2) + 2*L21adjL22T22(i1,i2) + 2*L21adjL23T23(i1,i2) + 2*L21adjYdTd(i1,i2) +            & 
&  2*L21adjYuTu(i1,i2) + 3*L22adjL22T21(i1,i2) + 3*L23adjL23T21(i1,i2) - 2*T11CL11L21(i1,& 
& i2) - 2*T12CL12L21(i1,i2) - 2*T13CL13L21(i1,i2) + 7*T21adjL21L21(i1,i2) +              & 
&  T21adjL22L22(i1,i2) + T21adjL23L23(i1,i2) + T21adjYdYd(i1,i2) + T21adjYuYu(i1,        & 
& i2) + 6*T22adjL22L21(i1,i2) + 6*T23adjL23L21(i1,i2) + 2*TpTeCYeL21(i1,i2) +            & 
&  TpYeCYeT21(i1,i2) + (14*g1p2*M1*L21(i1,i2))/15._dp + (32*g3p2*M3*L21(i1,              & 
& i2))/3._dp + 6*g2p2*M2*L21(i1,i2) + 4*TradjL21T21*L21(i1,i2) + 4*TradjL22T21*L22(i1,   & 
& i2) + 4*TradjL23T21*L23(i1,i2) - (7*g1p2*T21(i1,i2))/15._dp - 3*g2p2*T21(i1,           & 
& i2) - (16*g3p2*T21(i1,i2))/3._dp + 2*TrCL21TpL21*T21(i1,i2) + 2*TrCL22TpL21*T22(i1,    & 
& i2) + 2*TrCL23TpL21*T23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT21(i1,i2,2) = -L11CL11T22(i1,i2) - L12CL12T22(i1,i2) - L13CL13T22(i1,i2) + 3*L21adjL21T22(i1,       & 
& i2) + 2*L22adjL21T21(i1,i2) + 5*L22adjL22T22(i1,i2) + 2*L22adjL23T23(i1,               & 
& i2) + 2*L22adjYdTd(i1,i2) + 2*L22adjYuTu(i1,i2) + 3*L23adjL23T22(i1,i2) -              & 
&  2*T11CL11L22(i1,i2) - 2*T12CL12L22(i1,i2) - 2*T13CL13L22(i1,i2) + 6*T21adjL21L22(i1,  & 
& i2) + T22adjL21L21(i1,i2) + 7*T22adjL22L22(i1,i2) + T22adjL23L23(i1,i2) +              & 
&  T22adjYdYd(i1,i2) + T22adjYuYu(i1,i2) + 6*T23adjL23L22(i1,i2) + 2*TpTeCYeL22(i1,      & 
& i2) + TpYeCYeT22(i1,i2) + 4*TradjL21T22*L21(i1,i2) + (14*g1p2*M1*L22(i1,               & 
& i2))/15._dp + (32*g3p2*M3*L22(i1,i2))/3._dp + 6*g2p2*M2*L22(i1,i2) + 4*TradjL22T22*L22(i1,& 
& i2) + 4*TradjL23T22*L23(i1,i2) + 2*TrCL21TpL22*T21(i1,i2) - (7*g1p2*T22(i1,            & 
& i2))/15._dp - 3*g2p2*T22(i1,i2) - (16*g3p2*T22(i1,i2))/3._dp + 2*TrCL22TpL22*T22(i1,   & 
& i2) + 2*TrCL23TpL22*T23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT21(i1,i2,3) = -L11CL11T23(i1,i2) - L12CL12T23(i1,i2) - L13CL13T23(i1,i2) + 3*L21adjL21T23(i1,       & 
& i2) + 3*L22adjL22T23(i1,i2) + 2*L23adjL21T21(i1,i2) + 2*L23adjL22T22(i1,               & 
& i2) + 5*L23adjL23T23(i1,i2) + 2*L23adjYdTd(i1,i2) + 2*L23adjYuTu(i1,i2) -              & 
&  2*T11CL11L23(i1,i2) - 2*T12CL12L23(i1,i2) - 2*T13CL13L23(i1,i2) + 6*T21adjL21L23(i1,  & 
& i2) + 6*T22adjL22L23(i1,i2) + T23adjL21L21(i1,i2) + T23adjL22L22(i1,i2) +              & 
&  7*T23adjL23L23(i1,i2) + T23adjYdYd(i1,i2) + T23adjYuYu(i1,i2) + 2*TpTeCYeL23(i1,      & 
& i2) + TpYeCYeT23(i1,i2) + 4*TradjL21T23*L21(i1,i2) + 4*TradjL22T23*L22(i1,             & 
& i2) + (14*g1p2*M1*L23(i1,i2))/15._dp + (32*g3p2*M3*L23(i1,i2))/3._dp + 6*g2p2*M2*L23(i1,& 
& i2) + 4*TradjL23T23*L23(i1,i2) + 2*TrCL21TpL23*T21(i1,i2) + 2*TrCL22TpL23*T22(i1,      & 
& i2) - (7*g1p2*T23(i1,i2))/15._dp - 3*g2p2*T23(i1,i2) - (16*g3p2*T23(i1,i2))/3._dp +    & 
&  2*TrCL23TpL23*T23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT21(i1,i2,i3) = betaT21(i1,i2,i3)+6*CYdTpT21(1,i1)*Yd(i3,i2) + 6*CYdTpT22(2,i1)*Yd(i3,i2) + 6*CYdTpT23(3,               & 
& i1)*Yd(i3,i2) - 2*CYeT11(1,i1)*Yd(i3,i2) - 2*CYeT12(2,i1)*Yd(i3,i2) - 2*CYeT13(3,      & 
& i1)*Yd(i3,i2) + 4*CYdTpTd(1,i3)*L21(i1,i2) + 4*CYdTpTd(2,i3)*L22(i1,i2) +              & 
&  4*CYdTpTd(3,i3)*L23(i1,i2) + 3*CYdTpL21(1,i1)*Td(i3,i2) + 3*CYdTpL22(2,               & 
& i1)*Td(i3,i2) + 3*CYdTpL23(3,i1)*Td(i3,i2) - CYeL11(1,i1)*Td(i3,i2) - CYeL12(2,        & 
& i1)*Td(i3,i2) - CYeL13(3,i1)*Td(i3,i2) + 2*YdadjYd(i3,1)*T21(i1,i2) + 2*YdadjYd(i3,    & 
& 2)*T22(i1,i2) + 2*YdadjYd(i3,3)*T23(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaT22(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT22(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT22(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT22(i1,i2,i3) = betaT22(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DT2 = oo16pi2*( betaT21 + oo16pi2 * betaT22 ) 

 
Else 
DT2 = oo16pi2* betaT21 
End If 
 
 
!-------------------- 
! Tu 
!-------------------- 
 
betaTu1  = TuadjL21L21 + TuadjL22L22 + TuadjL23L23 + TuadjYdYd + 5._dp*(TuadjYuYu)    & 
&  + (26*g1p2*M1*Yu)/15._dp + (32*g3p2*M3*Yu)/3._dp + 6*g2p2*M2*Yu + 6*TradjYuTu*Yu +    & 
&  2._dp*(YuadjL21T21) + 2._dp*(YuadjL22T22) + 2._dp*(YuadjL23T23) + 2._dp*(YuadjYdTd)   & 
&  + 4._dp*(YuadjYuTu) - (13*g1p2*Tu)/15._dp - 3*g2p2*Tu - (16*g3p2*Tu)/3._dp +          & 
&  3*TrYuadjYu*Tu

 
 
If (TwoLoopRGE) Then 
betaTu2 = (2*g1p2*TuadjYdYd)/5._dp - 3*TrYdadjYd*TuadjYdYd - TrYeadjYe*TuadjYdYd -              & 
&  2._dp*(TuadjYdYdadjYdYd) - 4._dp*(TuadjYdYdadjYuYu) + 12*g2p2*TuadjYuYu -             & 
&  15*TrYuadjYu*TuadjYuYu - 6._dp*(TuadjYuYuadjYuYu) - (5486*g1p4*M1*Yu)/225._dp -       & 
&  2*g1p2*g2p2*M1*Yu - (272*g1p2*g3p2*M1*Yu)/45._dp - (272*g1p2*g3p2*M3*Yu)/45._dp -     & 
&  16*g2p2*g3p2*M3*Yu + (64*g3p4*M3*Yu)/9._dp - 2*g1p2*g2p2*M2*Yu - 30*g2p4*M2*Yu -      & 
&  16*g2p2*g3p2*M2*Yu + (8*g1p2*TradjYuTu*Yu)/5._dp + 32*g3p2*TradjYuTu*Yu -             & 
&  6*TrYdadjYuTuadjYd*Yu - 6*TrYuadjYdTdadjYu*Yu - (8*g1p2*M1*TrYuadjYu*Yu)/5._dp -      & 
&  32*g3p2*M3*TrYuadjYu*Yu - 36*TrYuadjYuTuadjYu*Yu + (4*g1p2*YuadjYdTd)/5._dp -         & 
&  6*TrYdadjYd*YuadjYdTd - 2*TrYeadjYe*YuadjYdTd - 4._dp*(YuadjYdTdadjYdYd) -            & 
&  4._dp*(YuadjYdTdadjYuYu) - (4*g1p2*M1*YuadjYdYd)/5._dp - 6*TradjYdTd*YuadjYdYd -      & 
&  2*TradjYeTe*YuadjYdYd - 4._dp*(YuadjYdYdadjYdTd) - 2._dp*(YuadjYdYdadjYuTu) +         & 
&  (6*g1p2*YuadjYuTu)/5._dp + 6*g2p2*YuadjYuTu - 12*TrYuadjYu*YuadjYuTu - 8._dp*(YuadjYuTuadjYuYu) -& 
&  (4*g1p2*M1*YuadjYuYu)/5._dp - 12*g2p2*M2*YuadjYuYu - 18*TradjYuTu*YuadjYuYu -         & 
&  6._dp*(YuadjYuYuadjYuTu) + (2743*g1p4*Tu)/450._dp + g1p2*g2p2*Tu + (15*g2p4*Tu)/2._dp +& 
&  (136*g1p2*g3p2*Tu)/45._dp + 8*g2p2*g3p2*Tu - (16*g3p4*Tu)/9._dp - 3*TrYdadjYuYuadjYd*Tu +& 
&  (4*g1p2*TrYuadjYu*Tu)/5._dp + 16*g3p2*TrYuadjYu*Tu - 9*TrYuadjYuYuadjYu*Tu

 
DTu = oo16pi2*( betaTu1 + oo16pi2 * betaTu2 ) 

 
Else 
DTu = oo16pi2* betaTu1 
End If 
 
 
Call Chop(DTu) 

!-------------------- 
! Bmu 
!-------------------- 
 
betaBmu1  = (6*g1p2*M1*Mu)/5._dp + 6*g2p2*M2*Mu + 6*TradjYdTd*Mu + 2*TradjYeTe*Mu +   & 
&  6*TradjYuTu*Mu - (3*g1p2*Bmu)/5._dp - 3*g2p2*Bmu + 3*TrYdadjYd*Bmu + TrYeadjYe*Bmu +  & 
&  3*TrYuadjYu*Bmu

 
 
If (TwoLoopRGE) Then 
betaBmu2 = (-414*g1p4*M1*Mu)/25._dp - (18*g1p2*g2p2*M1*Mu)/5._dp - (18*g1p2*g2p2*M2*Mu)/5._dp -  & 
&  30*g2p4*M2*Mu - (4*g1p2*TradjYdTd*Mu)/5._dp + 32*g3p2*TradjYdTd*Mu + (12*g1p2*TradjYeTe*Mu)/5._dp +& 
&  (8*g1p2*TradjYuTu*Mu)/5._dp + 32*g3p2*TradjYuTu*Mu + (4*g1p2*M1*TrYdadjYd*Mu)/5._dp - & 
&  32*g3p2*M3*TrYdadjYd*Mu - 36*TrYdadjYdTdadjYd*Mu - 12*TrYdadjYuTuadjYd*Mu -           & 
&  (12*g1p2*M1*TrYeadjYe*Mu)/5._dp - 12*TrYeadjYeTeadjYe*Mu - 12*TrYuadjYdTdadjYu*Mu -   & 
&  (8*g1p2*M1*TrYuadjYu*Mu)/5._dp - 32*g3p2*M3*TrYuadjYu*Mu - 36*TrYuadjYuTuadjYu*Mu +   & 
&  (207*g1p4*Bmu)/50._dp + (9*g1p2*g2p2*Bmu)/5._dp + (15*g2p4*Bmu)/2._dp -               & 
&  (2*g1p2*TrYdadjYd*Bmu)/5._dp + 16*g3p2*TrYdadjYd*Bmu - 9*TrYdadjYdYdadjYd*Bmu -       & 
&  6*TrYdadjYuYuadjYd*Bmu + (6*g1p2*TrYeadjYe*Bmu)/5._dp - 3*TrYeadjYeYeadjYe*Bmu +      & 
&  (4*g1p2*TrYuadjYu*Bmu)/5._dp + 16*g3p2*TrYuadjYu*Bmu - 9*TrYuadjYuYuadjYu*Bmu

 
DBmu = oo16pi2*( betaBmu1 + oo16pi2 * betaBmu2 ) 

 
Else 
DBmu = oo16pi2* betaBmu1 
End If 
 
 
Call Chop(DBmu) 

!-------------------- 
! mq2 
!-------------------- 
 
betamq21  = 2._dp*(adjL21Cml2L21) + adjL21L21mq2 + 2._dp*(adjL22Cml2L22)              & 
&  + adjL22L22mq2 + 2._dp*(adjL23Cml2L23) + adjL23L23mq2 + 2._dp*(adjT21T21)             & 
&  + 2._dp*(adjT22T22) + 2._dp*(adjT23T23) + 2._dp*(adjTdTd) + 2._dp*(adjTuTu)           & 
&  + 2._dp*(adjYdmd2Yd) + adjYdYdmq2 + 2._dp*(adjYumu2Yu) + adjYuYumq2 - (2*AbsM1*g1p2*id3R)& 
& /15._dp - 6*AbsM2*g2p2*id3R - (32*AbsM3*g3p2*id3R)/3._dp + 2*adjYdYd*mHd2 +            & 
&  2*adjYuYu*mHu2 + mq2adjL21L21 + mq2adjL22L22 + mq2adjL23L23 + mq2adjYdYd +            & 
&  mq2adjYuYu + 2*adjL21L21*md2(1,1) + 2*adjL21L22*md2(1,2) + 2*adjL21L23*md2(1,         & 
& 3) + 2*adjL22L21*md2(2,1) + 2*adjL22L22*md2(2,2) + 2*adjL22L23*md2(2,3) +              & 
&  2*adjL23L21*md2(3,1) + 2*adjL23L22*md2(3,2) + 2*adjL23L23*md2(3,3) + g1*id3R*ooSqrt15*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamq22 = -4._dp*(adjTdTdadjYdYd) - 4._dp*(adjTdYdadjYdTd) - 4._dp*(adjTuTuadjYuYu) -           & 
&  4._dp*(adjTuYuadjYuTu) - 4._dp*(adjYdmd2YdadjYdYd) - 4._dp*(adjYdTdadjTdYd) -         & 
&  4._dp*(adjYdYdadjTdTd) - 4._dp*(adjYdYdadjYdmd2Yd) - 2._dp*(adjYdYdadjYdYdmq2) -      & 
&  4._dp*(adjYdYdmq2adjYdYd) - 4._dp*(adjYumu2YuadjYuYu) - 4._dp*(adjYuTuadjTuYu) -      & 
&  4._dp*(adjYuYuadjTuTu) - 4._dp*(adjYuYuadjYumu2Yu) - 2._dp*(adjYuYuadjYuYumq2) -      & 
&  4._dp*(adjYuYumq2adjYuYu) + (4*adjTdTd*g1p2)/5._dp + (8*adjTuTu*g1p2)/5._dp +         & 
&  (4*adjYdmd2Yd*g1p2)/5._dp + (8*AbsM1*adjYdYd*g1p2)/5._dp + (2*adjYdYdmq2*g1p2)/5._dp +& 
&  (8*adjYumu2Yu*g1p2)/5._dp + (16*AbsM1*adjYuYu*g1p2)/5._dp + (4*adjYuYumq2*g1p2)/5._dp +& 
&  (199*AbsM1*g1p4*id3R)/75._dp + (2*AbsM1*g1p2*g2p2*id3R)/5._dp + (2*AbsM2*g1p2*g2p2*id3R)/5._dp +& 
&  33*AbsM2*g2p4*id3R + (32*AbsM1*g1p2*g3p2*id3R)/45._dp + (32*AbsM3*g1p2*g3p2*id3R)/45._dp +& 
&  32*AbsM2*g2p2*g3p2*id3R + 32*AbsM3*g2p2*g3p2*id3R - (128*AbsM3*g3p4*id3R)/3._dp -     & 
&  (4*adjTdYd*g1p2*M1)/5._dp - (8*adjTuYu*g1p2*M1)/5._dp - 8*adjYdYdadjYdYd*mHd2 +       & 
&  (4*adjYdYd*g1p2*mHd2)/5._dp - 8*adjYuYuadjYuYu*mHu2 + (8*adjYuYu*g1p2*mHu2)/5._dp +   & 
&  (2*g1p2*mq2adjYdYd)/5._dp - 2._dp*(mq2adjYdYdadjYdYd) + (4*g1p2*mq2adjYuYu)/5._dp -   & 
&  2._dp*(mq2adjYuYuadjYuYu) - 6*adjTdYd*TradjYdTd - 2*adjTdYd*TradjYeTe -               & 
&  6*adjTuYu*TradjYuTu - 6*adjYdYd*TrCTdTpTd - 6*adjYdTd*TrCTdTpYd - 2*adjYdYd*TrCTeTpTe -& 
&  2*adjYdTd*TrCTeTpYe - 6*adjYuYu*TrCTuTpTu - 6*adjYuTu*TrCTuTpYu - 6*adjYdYd*Trmd2YdadjYd -& 
&  2*adjYdYd*Trme2YeadjYe - 2*adjYdYd*Trml2adjYeYe - 6*adjYdYd*Trmq2adjYdYd -            & 
&  6*adjYuYu*Trmq2adjYuYu - 6*adjYuYu*Trmu2YuadjYu - 6*adjTdTd*TrYdadjYd -               & 
&  6*adjYdmd2Yd*TrYdadjYd - 3*adjYdYdmq2*TrYdadjYd - 12*adjYdYd*mHd2*TrYdadjYd -         & 
&  3*mq2adjYdYd*TrYdadjYd - 2*adjTdTd*TrYeadjYe - 2*adjYdmd2Yd*TrYeadjYe  
betamq22 =  betamq22- adjYdYdmq2*TrYeadjYe - 4*adjYdYd*mHd2*TrYeadjYe - mq2adjYdYd*TrYeadjYe -              & 
&  6*adjTuTu*TrYuadjYu - 6*adjYumu2Yu*TrYuadjYu - 3*adjYuYumq2*TrYuadjYu -               & 
&  12*adjYuYu*mHu2*TrYuadjYu - 3*mq2adjYuYu*TrYuadjYu - (4*adjYdTd*g1p2*Conjg(M1))/5._dp -& 
&  (8*adjYuTu*g1p2*Conjg(M1))/5._dp + (16*g1p2*g3p2*id3R*M3*Conjg(M1))/45._dp +          & 
&  (g1p2*g2p2*id3R*M2*Conjg(M1))/5._dp + (16*g1p2*g3p2*id3R*M1*Conjg(M3))/45._dp +       & 
&  16*g2p2*g3p2*id3R*M2*Conjg(M3) + (g1p2*g2p2*id3R*M1*Conjg(M2))/5._dp + 16*g2p2*g3p2*id3R*M3*Conjg(M2) +& 
&  6*g2p4*id3R*Tr2(2) + (32*g3p4*id3R*Tr2(3))/3._dp + (2*g1p2*id3R*Tr2U1(1,              & 
& 1))/15._dp + 4*g1*id3R*ooSqrt15*Tr3(1)

 
Dmq2 = oo16pi2*( betamq21 + oo16pi2 * betamq22 ) 

 
Else 
Dmq2 = oo16pi2* betamq21 
End If 
 
 
Call Chop(Dmq2) 

Forall(i1=1:3) Dmq2(i1,i1) =  Real(Dmq2(i1,i1),dp) 
Dmq2 = 0.5_dp*(Dmq2+ Conjg(Transpose(Dmq2)) ) 
!-------------------- 
! ml2 
!-------------------- 
 
betaml21  = 2._dp*(adjTeTe) + 2._dp*(adjYeme2Ye) + adjYeYeml2 - 2._dp*(CL11Cml2L11)   & 
&  - CL11L11ml2 - 2._dp*(CL12Cml2L12) - CL12L12ml2 - 2._dp*(CL13Cml2L13) -               & 
&  CL13L13ml2 + 6._dp*(CL21Cmq2TpL21) + 3._dp*(CL21TpL21ml2) + 6._dp*(CL22Cmq2TpL22)     & 
&  + 3._dp*(CL22TpL22ml2) + 6._dp*(CL23Cmq2TpL23) + 3._dp*(CL23TpL23ml2) -               & 
&  2._dp*(CT11T11) - 2._dp*(CT12T12) - 2._dp*(CT13T13) + 6._dp*(CT21TpT21)               & 
&  + 6._dp*(CT22TpT22) + 6._dp*(CT23TpT23) - (6*AbsM1*g1p2*id3R)/5._dp - 6*AbsM2*g2p2*id3R +& 
&  2*adjYeYe*mHd2 + ml2adjYeYe - ml2CL11L11 - ml2CL12L12 - ml2CL13L13 + 3._dp*(ml2CL21TpL21)& 
&  + 3._dp*(ml2CL22TpL22) + 3._dp*(ml2CL23TpL23) + 6*CL21TpL21*md2(1,1) + 6*CL21TpL22*md2(1,& 
& 2) + 6*CL21TpL23*md2(1,3) + 6*CL22TpL21*md2(2,1) + 6*CL22TpL22*md2(2,2) +              & 
&  6*CL22TpL23*md2(2,3) + 6*CL23TpL21*md2(3,1) + 6*CL23TpL22*md2(3,2) + 6*CL23TpL23*md2(3,& 
& 3) - 2*CL11L11*me2(1,1) - 2*CL11L12*me2(1,2) - 2*CL11L13*me2(1,3) - 2*CL12L11*me2(2,   & 
& 1) - 2*CL12L12*me2(2,2) - 2*CL12L13*me2(2,3) - 2*CL13L11*me2(3,1) - 2*CL13L12*me2(3,   & 
& 2) - 2*CL13L13*me2(3,3) - g1*id3R*sqrt3ov5*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betaml22 = -4._dp*(adjTeTeadjYeYe) - 4._dp*(adjTeYeadjYeTe) - 4._dp*(adjYeme2YeadjYeYe) -        & 
&  4._dp*(adjYeTeadjTeYe) - 4._dp*(adjYeYeadjTeTe) - 4._dp*(adjYeYeadjYeme2Ye) -         & 
&  2._dp*(adjYeYeadjYeYeml2) - 4._dp*(adjYeYeml2adjYeYe) + (12*adjTeTe*g1p2)/5._dp +     & 
&  (12*adjYeme2Ye*g1p2)/5._dp + (24*AbsM1*adjYeYe*g1p2)/5._dp + (6*adjYeYeml2*g1p2)/5._dp +& 
&  (621*AbsM1*g1p4*id3R)/25._dp + (18*AbsM1*g1p2*g2p2*id3R)/5._dp + (18*AbsM2*g1p2*g2p2*id3R)/5._dp +& 
&  33*AbsM2*g2p4*id3R - (12*adjTeYe*g1p2*M1)/5._dp - 8*adjYeYeadjYeYe*mHd2 +             & 
&  (12*adjYeYe*g1p2*mHd2)/5._dp + (6*g1p2*ml2adjYeYe)/5._dp - 2._dp*(ml2adjYeYeadjYeYe) -& 
&  6*adjTeYe*TradjYdTd - 2*adjTeYe*TradjYeTe - 6*adjYeYe*TrCTdTpTd - 6*adjYeTe*TrCTdTpYd -& 
&  2*adjYeYe*TrCTeTpTe - 2*adjYeTe*TrCTeTpYe - 6*adjYeYe*Trmd2YdadjYd - 2*adjYeYe*Trme2YeadjYe -& 
&  2*adjYeYe*Trml2adjYeYe - 6*adjYeYe*Trmq2adjYdYd - 6*adjTeTe*TrYdadjYd -               & 
&  6*adjYeme2Ye*TrYdadjYd - 3*adjYeYeml2*TrYdadjYd - 12*adjYeYe*mHd2*TrYdadjYd -         & 
&  3*ml2adjYeYe*TrYdadjYd - 2*adjTeTe*TrYeadjYe - 2*adjYeme2Ye*TrYeadjYe -               & 
&  adjYeYeml2*TrYeadjYe - 4*adjYeYe*mHd2*TrYeadjYe - ml2adjYeYe*TrYeadjYe -              & 
&  (12*adjYeTe*g1p2*Conjg(M1))/5._dp + (9*g1p2*g2p2*id3R*M2*Conjg(M1))/5._dp +           & 
&  (9*g1p2*g2p2*id3R*M1*Conjg(M2))/5._dp + 6*g2p4*id3R*Tr2(2) + (6*g1p2*id3R*Tr2U1(1,    & 
& 1))/5._dp - 4*g1*id3R*sqrt3ov5*Tr3(1)

 
Dml2 = oo16pi2*( betaml21 + oo16pi2 * betaml22 ) 

 
Else 
Dml2 = oo16pi2* betaml21 
End If 
 
 
Call Chop(Dml2) 

Forall(i1=1:3) Dml2(i1,i1) =  Real(Dml2(i1,i1),dp) 
Dml2 = 0.5_dp*(Dml2+ Conjg(Transpose(Dml2)) ) 
!-------------------- 
! mHd2 
!-------------------- 
 
betamHd21  = (-6*AbsM1*g1p2)/5._dp - 6*AbsM2*g2p2 + 6._dp*(TrCTdTpTd) +               & 
&  2._dp*(TrCTeTpTe) + 6._dp*(Trmd2YdadjYd) + 2._dp*(Trme2YeadjYe) + 2._dp*(Trml2adjYeYe)& 
&  + 6._dp*(Trmq2adjYdYd) + 6*mHd2*TrYdadjYd + 2*mHd2*TrYeadjYe - g1*sqrt3ov5*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamHd22 = (621*AbsM1*g1p4)/25._dp + (18*AbsM1*g1p2*g2p2)/5._dp + (18*AbsM2*g1p2*g2p2)/5._dp +   & 
&  33*AbsM2*g2p4 - (4*g1p2*TrCTdTpTd)/5._dp + 32*g3p2*TrCTdTpTd + (4*g1p2*M1*TrCTdTpYd)/5._dp -& 
&  32*g3p2*M3*TrCTdTpYd + (12*g1p2*TrCTeTpTe)/5._dp - (12*g1p2*M1*TrCTeTpYe)/5._dp -     & 
&  (4*g1p2*Trmd2YdadjYd)/5._dp + 32*g3p2*Trmd2YdadjYd - 36._dp*(Trmd2YdadjYdYdadjYd) -   & 
&  6._dp*(Trmd2YdadjYuYuadjYd) + (12*g1p2*Trme2YeadjYe)/5._dp - 12._dp*(Trme2YeadjYeYeadjYe) +& 
&  (12*g1p2*Trml2adjYeYe)/5._dp - 12._dp*(Trml2adjYeYeadjYeYe) - (4*g1p2*Trmq2adjYdYd)/5._dp +& 
&  32*g3p2*Trmq2adjYdYd - 36._dp*(Trmq2adjYdYdadjYdYd) - 6._dp*(Trmq2adjYdYdadjYuYu) -   & 
&  6._dp*(Trmq2adjYuYuadjYdYd) - 6._dp*(Trmu2YuadjYdYdadjYu) - 36._dp*(TrYdadjTdTdadjYd) -& 
&  6._dp*(TrYdadjTuTuadjYd) - (8*AbsM1*g1p2*TrYdadjYd)/5._dp + 64*AbsM3*g3p2*TrYdadjYd - & 
&  (4*g1p2*mHd2*TrYdadjYd)/5._dp + 32*g3p2*mHd2*TrYdadjYd - 36._dp*(TrYdadjYdTdadjTd) -  & 
&  36*mHd2*TrYdadjYdYdadjYd - 6._dp*(TrYdadjYuTuadjTd) - 6*mHd2*TrYdadjYuYuadjYd -       & 
&  6*mHu2*TrYdadjYuYuadjYd - 12._dp*(TrYeadjTeTeadjYe) + (24*AbsM1*g1p2*TrYeadjYe)/5._dp +& 
&  (12*g1p2*mHd2*TrYeadjYe)/5._dp - 12._dp*(TrYeadjYeTeadjTe) - 12*mHd2*TrYeadjYeYeadjYe -& 
&  6._dp*(TrYuadjTdTdadjYu) - 6._dp*(TrYuadjYdTdadjTu) + (9*g1p2*g2p2*M2*Conjg(M1))/5._dp +& 
&  (4*g1p2*TradjYdTd*Conjg(M1))/5._dp - (12*g1p2*TradjYeTe*Conjg(M1))/5._dp -            & 
&  32*g3p2*TradjYdTd*Conjg(M3) + (9*g1p2*g2p2*M1*Conjg(M2))/5._dp + 6*g2p4*Tr2(2) +      & 
&  (6*g1p2*Tr2U1(1,1))/5._dp - 4*g1*sqrt3ov5*Tr3(1)

 
DmHd2 = oo16pi2*( betamHd21 + oo16pi2 * betamHd22 ) 

 
Else 
DmHd2 = oo16pi2* betamHd21 
End If 
 
 
!-------------------- 
! mHu2 
!-------------------- 
 
betamHu21  = (-6*AbsM1*g1p2)/5._dp - 6*AbsM2*g2p2 + 6._dp*(TrCTuTpTu) +               & 
&  6._dp*(Trmq2adjYuYu) + 6._dp*(Trmu2YuadjYu) + 6*mHu2*TrYuadjYu + g1*sqrt3ov5*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamHu22 = (621*AbsM1*g1p4)/25._dp + (18*AbsM1*g1p2*g2p2)/5._dp + (18*AbsM2*g1p2*g2p2)/5._dp +   & 
&  33*AbsM2*g2p4 + (8*g1p2*TrCTuTpTu)/5._dp + 32*g3p2*TrCTuTpTu - (8*g1p2*M1*TrCTuTpYu)/5._dp -& 
&  32*g3p2*M3*TrCTuTpYu - 6._dp*(Trmd2YdadjYuYuadjYd) - 6._dp*(Trmq2adjYdYdadjYuYu) +    & 
&  (8*g1p2*Trmq2adjYuYu)/5._dp + 32*g3p2*Trmq2adjYuYu - 6._dp*(Trmq2adjYuYuadjYdYd) -    & 
&  36._dp*(Trmq2adjYuYuadjYuYu) - 6._dp*(Trmu2YuadjYdYdadjYu) + (8*g1p2*Trmu2YuadjYu)/5._dp +& 
&  32*g3p2*Trmu2YuadjYu - 36._dp*(Trmu2YuadjYuYuadjYu) - 6._dp*(TrYdadjTuTuadjYd) -      & 
&  6._dp*(TrYdadjYuTuadjTd) - 6*mHd2*TrYdadjYuYuadjYd - 6*mHu2*TrYdadjYuYuadjYd -        & 
&  6._dp*(TrYuadjTdTdadjYu) - 36._dp*(TrYuadjTuTuadjYu) - 6._dp*(TrYuadjYdTdadjTu) +     & 
&  (16*AbsM1*g1p2*TrYuadjYu)/5._dp + 64*AbsM3*g3p2*TrYuadjYu + (8*g1p2*mHu2*TrYuadjYu)/5._dp +& 
&  32*g3p2*mHu2*TrYuadjYu - 36._dp*(TrYuadjYuTuadjTu) - 36*mHu2*TrYuadjYuYuadjYu +       & 
&  (9*g1p2*g2p2*M2*Conjg(M1))/5._dp - (8*g1p2*TradjYuTu*Conjg(M1))/5._dp -               & 
&  32*g3p2*TradjYuTu*Conjg(M3) + (9*g1p2*g2p2*M1*Conjg(M2))/5._dp + 6*g2p4*Tr2(2) +      & 
&  (6*g1p2*Tr2U1(1,1))/5._dp + 4*g1*sqrt3ov5*Tr3(1)

 
DmHu2 = oo16pi2*( betamHu21 + oo16pi2 * betamHu22 ) 

 
Else 
DmHu2 = oo16pi2* betamHu21 
End If 
 
 
!-------------------- 
! md2 
!-------------------- 
 
betamd21 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betamd21(i1,i2) = 2*md2YdadjYd(i1,i2) + 4*TdadjTd(i1,i2) + 4*mHd2*YdadjYd(i1,i2) + 2*YdadjYdmd2(i1,     & 
& i2) + 4*Ydmq2adjYd(i1,i2)
If (1.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+4*TrCT21TpT21*Kronecker(1,i2) + 4*Trml2CL21TpL21*Kronecker(1,i2) + 4*Trmq2adjL21L21*Kronecker(1,& 
& i2) + 4*TrCT22TpT21*Kronecker(2,i2) + 4*Trml2CL22TpL21*Kronecker(2,i2) +               & 
&  4*Trmq2adjL22L21*Kronecker(2,i2) + 4*TrCT23TpT21*Kronecker(3,i2) + 4*Trml2CL23TpL21*Kronecker(3,& 
& i2) + 4*Trmq2adjL23L21*Kronecker(3,i2) + 2*TrCL21TpL21*md2(1,i2) + 2*TrCL22TpL21*md2(2,& 
& i2) + 2*TrCL23TpL21*md2(3,i2)
End If 
If (2.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+4*TrCT21TpT22*Kronecker(1,i2) + 4*Trml2CL21TpL22*Kronecker(1,i2) + 4*Trmq2adjL21L22*Kronecker(1,& 
& i2) + 4*TrCT22TpT22*Kronecker(2,i2) + 4*Trml2CL22TpL22*Kronecker(2,i2) +               & 
&  4*Trmq2adjL22L22*Kronecker(2,i2) + 4*TrCT23TpT22*Kronecker(3,i2) + 4*Trml2CL23TpL22*Kronecker(3,& 
& i2) + 4*Trmq2adjL23L22*Kronecker(3,i2) + 2*TrCL21TpL22*md2(1,i2) + 2*TrCL22TpL22*md2(2,& 
& i2) + 2*TrCL23TpL22*md2(3,i2)
End If 
If (3.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+4*TrCT21TpT23*Kronecker(1,i2) + 4*Trml2CL21TpL23*Kronecker(1,i2) + 4*Trmq2adjL21L23*Kronecker(1,& 
& i2) + 4*TrCT22TpT23*Kronecker(2,i2) + 4*Trml2CL22TpL23*Kronecker(2,i2) +               & 
&  4*Trmq2adjL22L23*Kronecker(2,i2) + 4*TrCT23TpT23*Kronecker(3,i2) + 4*Trml2CL23TpL23*Kronecker(3,& 
& i2) + 4*Trmq2adjL23L23*Kronecker(3,i2) + 2*TrCL21TpL23*md2(1,i2) + 2*TrCL22TpL23*md2(2,& 
& i2) + 2*TrCL23TpL23*md2(3,i2)
End If 
If (1.eq.i2) Then 
betamd21(i1,i2) = betamd21(i1,i2)+2*TrCL21TpL21*md2(i1,1) + 2*TrCL21TpL22*md2(i1,2) + 2*TrCL21TpL23*md2(i1,3)
End If 
If (2.eq.i2) Then 
betamd21(i1,i2) = betamd21(i1,i2)+2*TrCL22TpL21*md2(i1,1) + 2*TrCL22TpL22*md2(i1,2) + 2*TrCL22TpL23*md2(i1,3)
End If 
If (3.eq.i2) Then 
betamd21(i1,i2) = betamd21(i1,i2)+2*TrCL23TpL21*md2(i1,1) + 2*TrCL23TpL22*md2(i1,2) + 2*TrCL23TpL23*md2(i1,3)
End If 
If (i2.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+((-8*AbsM1*g1p2)/15._dp - (32*AbsM3*g3p2)/3._dp + 2*g1*ooSqrt15*Tr1(1))
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betamd22 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betamd22(i1,i2) = (2*g1p2*md2YdadjYd(i1,i2))/5._dp + 6*g2p2*md2YdadjYd(i1,i2) - 6*TrYdadjYd*md2YdadjYd(i1,& 
& i2) - 2*TrYeadjYe*md2YdadjYd(i1,i2) - 2*md2YdadjYdYdadjYd(i1,i2) - 2*md2YdadjYuYuadjYd(i1,& 
& i2) + (4*g1p2*TdadjTd(i1,i2))/5._dp + 12*g2p2*TdadjTd(i1,i2) - 12*TrYdadjYd*TdadjTd(i1,& 
& i2) - 4*TrYeadjYe*TdadjTd(i1,i2) - 4*TdadjTdYdadjYd(i1,i2) - 4*TdadjTuYuadjYd(i1,      & 
& i2) - 12*TrCTdTpYd*TdadjYd(i1,i2) - 4*TrCTeTpYe*TdadjYd(i1,i2) - (4*g1p2*Conjg(M1)*TdadjYd(i1,& 
& i2))/5._dp - 12*g2p2*Conjg(M2)*TdadjYd(i1,i2) - 4*TdadjYdYdadjTd(i1,i2) -              & 
&  4*TdadjYuYuadjTd(i1,i2) - (4*g1p2*M1*YdadjTd(i1,i2))/5._dp - 12*g2p2*M2*YdadjTd(i1,   & 
& i2) - 12*TradjYdTd*YdadjTd(i1,i2) - 4*TradjYeTe*YdadjTd(i1,i2) - 4*YdadjTdTdadjYd(i1,  & 
& i2) - 4*YdadjTuTuadjYd(i1,i2) + (8*AbsM1*g1p2*YdadjYd(i1,i2))/5._dp + 24*AbsM2*g2p2*YdadjYd(i1,& 
& i2) + (4*g1p2*mHd2*YdadjYd(i1,i2))/5._dp + 12*g2p2*mHd2*YdadjYd(i1,i2) -               & 
&  12*TrCTdTpTd*YdadjYd(i1,i2) - 4*TrCTeTpTe*YdadjYd(i1,i2) - 12*Trmd2YdadjYd*YdadjYd(i1,& 
& i2) - 4*Trme2YeadjYe*YdadjYd(i1,i2) - 4*Trml2adjYeYe*YdadjYd(i1,i2) - 12*Trmq2adjYdYd*YdadjYd(i1,& 
& i2) - 24*mHd2*TrYdadjYd*YdadjYd(i1,i2) - 8*mHd2*TrYeadjYe*YdadjYd(i1,i2) +             & 
&  (2*g1p2*YdadjYdmd2(i1,i2))/5._dp + 6*g2p2*YdadjYdmd2(i1,i2) - 6*TrYdadjYd*YdadjYdmd2(i1,& 
& i2) - 2*TrYeadjYe*YdadjYdmd2(i1,i2) - 4*YdadjYdmd2YdadjYd(i1,i2) - 4*YdadjYdTdadjTd(i1,& 
& i2) - 8*mHd2*YdadjYdYdadjYd(i1,i2) - 2*YdadjYdYdadjYdmd2(i1,i2) - 4*YdadjYdYdmq2adjYd(i1,& 
& i2) - 4*YdadjYumu2YuadjYd(i1,i2) - 4*YdadjYuTuadjTd(i1,i2) - 4*mHd2*YdadjYuYuadjYd(i1, & 
& i2) - 4*mHu2*YdadjYuYuadjYd(i1,i2) - 2*YdadjYuYuadjYdmd2(i1,i2) - 4*YdadjYuYumq2adjYd(i1,& 
& i2) + (4*g1p2*Ydmq2adjYd(i1,i2))/5._dp + 12*g2p2*Ydmq2adjYd(i1,i2) - 12*TrYdadjYd*Ydmq2adjYd(i1,& 
& i2) - 4*TrYeadjYe*Ydmq2adjYd(i1,i2) - 4*Ydmq2adjYdYdadjYd(i1,i2) - 4*Ydmq2adjYuYuadjYd(i1,i2)
If (i2.eq.i1) Then 
betamd22(i1,i2) = betamd22(i1,i2)+(808*AbsM1*g1p4)/75._dp + (128*AbsM1*g1p2*g3p2)/45._dp + (128*AbsM3*g1p2*g3p2)/45._dp -& 
&  (128*AbsM3*g3p4)/3._dp + (64*g1p2*g3p2*M3*Conjg(M1))/45._dp + (64*g1p2*g3p2*M1*Conjg(M3))/45._dp +& 
&  (32*g3p4*Tr2(3))/3._dp + (8*g1p2*Tr2U1(1,1))/15._dp + 8*g1*ooSqrt15*Tr3(1)
End If 
End Do
End Do

 
Dmd2 = oo16pi2*( betamd21 + oo16pi2 * betamd22 ) 

 
Else 
Dmd2 = oo16pi2* betamd21 
End If 
 
 
Call Chop(Dmd2) 

Forall(i1=1:3) Dmd2(i1,i1) =  Real(Dmd2(i1,i1),dp) 
Dmd2 = 0.5_dp*(Dmd2+ Conjg(Transpose(Dmd2)) ) 
!-------------------- 
! mu2 
!-------------------- 
 
betamu21  = (-32*AbsM1*g1p2*id3R)/15._dp - (32*AbsM3*g3p2*id3R)/3._dp +               & 
&  2._dp*(mu2YuadjYu) + 4._dp*(TuadjTu) + 4*mHu2*YuadjYu + 2._dp*(YuadjYumu2)            & 
&  + 4._dp*(Yumq2adjYu) - 4*g1*id3R*ooSqrt15*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamu22 = (3424*AbsM1*g1p4*id3R)/75._dp + (512*AbsM1*g1p2*g3p2*id3R)/45._dp + (512*AbsM3*g1p2*g3p2*id3R)/45._dp -& 
&  (128*AbsM3*g3p4*id3R)/3._dp - 2._dp*(mu2YuadjYdYdadjYu) - (2*g1p2*mu2YuadjYu)/5._dp + & 
&  6*g2p2*mu2YuadjYu - 2._dp*(mu2YuadjYuYuadjYu) - 6*mu2YuadjYu*TrYuadjYu -              & 
&  4._dp*(TuadjTdYdadjYu) - (4*g1p2*TuadjTu)/5._dp + 12*g2p2*TuadjTu - 12*TrYuadjYu*TuadjTu -& 
&  4._dp*(TuadjTuYuadjYu) - 4._dp*(TuadjYdYdadjTu) - 12*TrCTuTpYu*TuadjYu -              & 
&  4._dp*(TuadjYuYuadjTu) - 4._dp*(YuadjTdTdadjYu) + (4*g1p2*M1*YuadjTu)/5._dp -         & 
&  12*g2p2*M2*YuadjTu - 12*TradjYuTu*YuadjTu - 4._dp*(YuadjTuTuadjYu) - 4._dp*(YuadjYdmd2YdadjYu) -& 
&  4._dp*(YuadjYdTdadjTu) - 4*mHd2*YuadjYdYdadjYu - 4*mHu2*YuadjYdYdadjYu -              & 
&  2._dp*(YuadjYdYdadjYumu2) - 4._dp*(YuadjYdYdmq2adjYu) - (8*AbsM1*g1p2*YuadjYu)/5._dp +& 
&  24*AbsM2*g2p2*YuadjYu - (4*g1p2*mHu2*YuadjYu)/5._dp + 12*g2p2*mHu2*YuadjYu -          & 
&  12*TrCTuTpTu*YuadjYu - 12*Trmq2adjYuYu*YuadjYu - 12*Trmu2YuadjYu*YuadjYu -            & 
&  24*mHu2*TrYuadjYu*YuadjYu - (2*g1p2*YuadjYumu2)/5._dp + 6*g2p2*YuadjYumu2 -           & 
&  6*TrYuadjYu*YuadjYumu2 - 4._dp*(YuadjYumu2YuadjYu) - 4._dp*(YuadjYuTuadjTu) -         & 
&  8*mHu2*YuadjYuYuadjYu - 2._dp*(YuadjYuYuadjYumu2) - 4._dp*(YuadjYuYumq2adjYu) -       & 
&  4._dp*(Yumq2adjYdYdadjYu) - (4*g1p2*Yumq2adjYu)/5._dp + 12*g2p2*Yumq2adjYu -          & 
&  12*TrYuadjYu*Yumq2adjYu - 4._dp*(Yumq2adjYuYuadjYu) + (256*g1p2*g3p2*id3R*M3*Conjg(M1))/45._dp +& 
&  (4*g1p2*TuadjYu*Conjg(M1))/5._dp + (256*g1p2*g3p2*id3R*M1*Conjg(M3))/45._dp -         & 
&  12*g2p2*TuadjYu*Conjg(M2) + (32*g3p4*id3R*Tr2(3))/3._dp + (32*g1p2*id3R*Tr2U1(1,      & 
& 1))/15._dp - 16*g1*id3R*ooSqrt15*Tr3(1)

 
Dmu2 = oo16pi2*( betamu21 + oo16pi2 * betamu22 ) 

 
Else 
Dmu2 = oo16pi2* betamu21 
End If 
 
 
Call Chop(Dmu2) 

Forall(i1=1:3) Dmu2(i1,i1) =  Real(Dmu2(i1,i1),dp) 
Dmu2 = 0.5_dp*(Dmu2+ Conjg(Transpose(Dmu2)) ) 
!-------------------- 
! me2 
!-------------------- 
 
betame21 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betame21(i1,i2) = 2*me2YeadjYe(i1,i2) + 4*TeadjTe(i1,i2) + 4*mHd2*YeadjYe(i1,i2) + 2*YeadjYeme2(i1,     & 
& i2) + 4*Yeml2adjYe(i1,i2)
If (1.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)-2*TrCT11T11*Kronecker(1,i2) - 4*Trml2CL11L11*Kronecker(1,i2) - 2*TrCT12T11*Kronecker(2,& 
& i2) - 4*Trml2CL12L11*Kronecker(2,i2) - 2*TrCT13T11*Kronecker(3,i2) - 4*Trml2CL13L11*Kronecker(3,& 
& i2) - TrCL11L11*me2(1,i2) - TrCL12L11*me2(2,i2) - TrCL13L11*me2(3,i2)
End If 
If (2.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)-2*TrCT11T12*Kronecker(1,i2) - 4*Trml2CL11L12*Kronecker(1,i2) - 2*TrCT12T12*Kronecker(2,& 
& i2) - 4*Trml2CL12L12*Kronecker(2,i2) - 2*TrCT13T12*Kronecker(3,i2) - 4*Trml2CL13L12*Kronecker(3,& 
& i2) - TrCL11L12*me2(1,i2) - TrCL12L12*me2(2,i2) - TrCL13L12*me2(3,i2)
End If 
If (3.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)-2*TrCT11T13*Kronecker(1,i2) - 4*Trml2CL11L13*Kronecker(1,i2) - 2*TrCT12T13*Kronecker(2,& 
& i2) - 4*Trml2CL12L13*Kronecker(2,i2) - 2*TrCT13T13*Kronecker(3,i2) - 4*Trml2CL13L13*Kronecker(3,& 
& i2) - TrCL11L13*me2(1,i2) - TrCL12L13*me2(2,i2) - TrCL13L13*me2(3,i2)
End If 
If (1.eq.i2) Then 
betame21(i1,i2) = betame21(i1,i2)-(TrCL11L11*me2(i1,1)) - TrCL11L12*me2(i1,2) - TrCL11L13*me2(i1,3)
End If 
If (2.eq.i2) Then 
betame21(i1,i2) = betame21(i1,i2)-(TrCL12L11*me2(i1,1)) - TrCL12L12*me2(i1,2) - TrCL12L13*me2(i1,3)
End If 
If (3.eq.i2) Then 
betame21(i1,i2) = betame21(i1,i2)-(TrCL13L11*me2(i1,1)) - TrCL13L12*me2(i1,2) - TrCL13L13*me2(i1,3)
End If 
If (i2.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)+((-24*AbsM1*g1p2)/5._dp + 2*g1*sqrt3ov5*Tr1(1))
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betame22 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betame22(i1,i2) = (-6*g1p2*me2YeadjYe(i1,i2))/5._dp + 6*g2p2*me2YeadjYe(i1,i2) - 6*TrYdadjYd*me2YeadjYe(i1,& 
& i2) - 2*TrYeadjYe*me2YeadjYe(i1,i2) - 2*me2YeadjYeYeadjYe(i1,i2) - (12*g1p2*TeadjTe(i1,& 
& i2))/5._dp + 12*g2p2*TeadjTe(i1,i2) - 12*TrYdadjYd*TeadjTe(i1,i2) - 4*TrYeadjYe*TeadjTe(i1,& 
& i2) - 4*TeadjTeYeadjYe(i1,i2) - 12*TrCTdTpYd*TeadjYe(i1,i2) - 4*TrCTeTpYe*TeadjYe(i1,  & 
& i2) + (12*g1p2*Conjg(M1)*TeadjYe(i1,i2))/5._dp - 12*g2p2*Conjg(M2)*TeadjYe(i1,         & 
& i2) - 4*TeadjYeYeadjTe(i1,i2) + (12*g1p2*M1*YeadjTe(i1,i2))/5._dp - 12*g2p2*M2*YeadjTe(i1,& 
& i2) - 12*TradjYdTd*YeadjTe(i1,i2) - 4*TradjYeTe*YeadjTe(i1,i2) - 4*YeadjTeTeadjYe(i1,  & 
& i2) - (24*AbsM1*g1p2*YeadjYe(i1,i2))/5._dp + 24*AbsM2*g2p2*YeadjYe(i1,i2) -            & 
&  (12*g1p2*mHd2*YeadjYe(i1,i2))/5._dp + 12*g2p2*mHd2*YeadjYe(i1,i2) - 12*TrCTdTpTd*YeadjYe(i1,& 
& i2) - 4*TrCTeTpTe*YeadjYe(i1,i2) - 12*Trmd2YdadjYd*YeadjYe(i1,i2) - 4*Trme2YeadjYe*YeadjYe(i1,& 
& i2) - 4*Trml2adjYeYe*YeadjYe(i1,i2) - 12*Trmq2adjYdYd*YeadjYe(i1,i2) - 24*mHd2*TrYdadjYd*YeadjYe(i1,& 
& i2) - 8*mHd2*TrYeadjYe*YeadjYe(i1,i2) - (6*g1p2*YeadjYeme2(i1,i2))/5._dp +             & 
&  6*g2p2*YeadjYeme2(i1,i2) - 6*TrYdadjYd*YeadjYeme2(i1,i2) - 2*TrYeadjYe*YeadjYeme2(i1, & 
& i2) - 4*YeadjYeme2YeadjYe(i1,i2) - 4*YeadjYeTeadjTe(i1,i2) - 8*mHd2*YeadjYeYeadjYe(i1, & 
& i2) - 2*YeadjYeYeadjYeme2(i1,i2) - 4*YeadjYeYeml2adjYe(i1,i2) - (12*g1p2*Yeml2adjYe(i1,& 
& i2))/5._dp + 12*g2p2*Yeml2adjYe(i1,i2) - 12*TrYdadjYd*Yeml2adjYe(i1,i2) -              & 
&  4*TrYeadjYe*Yeml2adjYe(i1,i2) - 4*Yeml2adjYeYeadjYe(i1,i2)
If (i2.eq.i1) Then 
betame22(i1,i2) = betame22(i1,i2)+(2808*AbsM1*g1p4)/25._dp + (24*g1p2*Tr2U1(1,1))/5._dp + 8*g1*sqrt3ov5*Tr3(1)
End If 
End Do
End Do

 
Dme2 = oo16pi2*( betame21 + oo16pi2 * betame22 ) 

 
Else 
Dme2 = oo16pi2* betame21 
End If 
 
 
Call Chop(Dme2) 

Forall(i1=1:3) Dme2(i1,i1) =  Real(Dme2(i1,i1),dp) 
Dme2 = 0.5_dp*(Dme2+ Conjg(Transpose(Dme2)) ) 
!-------------------- 
! M1 
!-------------------- 
 
betaM11  = (66*g1p2*M1)/5._dp

 
 
If (TwoLoopRGE) Then 
betaM12 = (796*g1p4*M1)/25._dp + (54*g1p2*g2p2*M1)/5._dp + (176*g1p2*g3p2*M1)/5._dp +           & 
&  (176*g1p2*g3p2*M3)/5._dp + (54*g1p2*g2p2*M2)/5._dp + (28*g1p2*TradjYdTd)/5._dp +      & 
&  (36*g1p2*TradjYeTe)/5._dp + (52*g1p2*TradjYuTu)/5._dp - (28*g1p2*M1*TrYdadjYd)/5._dp -& 
&  (36*g1p2*M1*TrYeadjYe)/5._dp - (52*g1p2*M1*TrYuadjYu)/5._dp

 
DM1 = oo16pi2*( betaM11 + oo16pi2 * betaM12 ) 

 
Else 
DM1 = oo16pi2* betaM11 
End If 
 
 
Call Chop(DM1) 

!-------------------- 
! M2 
!-------------------- 
 
betaM21  = 2*g2p2*M2

 
 
If (TwoLoopRGE) Then 
betaM22 = (18*g1p2*g2p2*M1)/5._dp + 48*g2p2*g3p2*M3 + (18*g1p2*g2p2*M2)/5._dp + 100*g2p4*M2 +   & 
&  48*g2p2*g3p2*M2 + 12*g2p2*TradjYdTd + 4*g2p2*TradjYeTe + 12*g2p2*TradjYuTu -          & 
&  12*g2p2*M2*TrYdadjYd - 4*g2p2*M2*TrYeadjYe - 12*g2p2*M2*TrYuadjYu

 
DM2 = oo16pi2*( betaM21 + oo16pi2 * betaM22 ) 

 
Else 
DM2 = oo16pi2* betaM21 
End If 
 
 
Call Chop(DM2) 

!-------------------- 
! M3 
!-------------------- 
 
betaM31  = -6*g3p2*M3

 
 
If (TwoLoopRGE) Then 
betaM32 = (22*g1p2*g3p2*M1)/5._dp + (22*g1p2*g3p2*M3)/5._dp + 18*g2p2*g3p2*M3 + 56*g3p4*M3 +    & 
&  18*g2p2*g3p2*M2 + 8*g3p2*TradjYdTd + 8*g3p2*TradjYuTu - 8*g3p2*M3*TrYdadjYd -         & 
&  8*g3p2*M3*TrYuadjYu

 
DM3 = oo16pi2*( betaM31 + oo16pi2 * betaM32 ) 

 
Else 
DM3 = oo16pi2* betaM31 
End If 
 
 
Call Chop(DM3) 

Call ParametersToG429(Dg1,Dg2,Dg3,DYd,DYe,DL1,DL2,DYu,DMu,DTd,DTe,DT1,DT2,            & 
& DTu,DBmu,Dmq2,Dml2,DmHd2,DmHu2,Dmd2,Dmu2,Dme2,DM1,DM2,DM3,f)

Iname = Iname - 1 
 
End Subroutine rge429  

Subroutine GToParameters431(g,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,              & 
& Bmu,mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu)

Implicit None 
Real(dp), Intent(in) :: g(431) 
Real(dp),Intent(out) :: g1,g2,g3,mHd2,mHu2,vd,vu

Complex(dp),Intent(out) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters431' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yd(i1,i2) = Cmplx( g(SumI+4), g(SumI+5), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Ye(i1,i2) = Cmplx( g(SumI+22), g(SumI+23), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
L1(i1,i2,i3) = Cmplx( g(SumI+40), g(SumI+41), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
L2(i1,i2,i3) = Cmplx( g(SumI+94), g(SumI+95), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yu(i1,i2) = Cmplx( g(SumI+148), g(SumI+149), dp) 
End Do 
 End Do 
 
Mu= Cmplx(g(166),g(167),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Td(i1,i2) = Cmplx( g(SumI+168), g(SumI+169), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Te(i1,i2) = Cmplx( g(SumI+186), g(SumI+187), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
T1(i1,i2,i3) = Cmplx( g(SumI+204), g(SumI+205), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
T2(i1,i2,i3) = Cmplx( g(SumI+258), g(SumI+259), dp) 
End Do 
 End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Tu(i1,i2) = Cmplx( g(SumI+312), g(SumI+313), dp) 
End Do 
 End Do 
 
Bmu= Cmplx(g(330),g(331),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
mq2(i1,i2) = Cmplx( g(SumI+332), g(SumI+333), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
ml2(i1,i2) = Cmplx( g(SumI+350), g(SumI+351), dp) 
End Do 
 End Do 
 
mHd2= g(368) 
mHu2= g(369) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
md2(i1,i2) = Cmplx( g(SumI+370), g(SumI+371), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
mu2(i1,i2) = Cmplx( g(SumI+388), g(SumI+389), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
me2(i1,i2) = Cmplx( g(SumI+406), g(SumI+407), dp) 
End Do 
 End Do 
 
M1= Cmplx(g(424),g(425),dp) 
M2= Cmplx(g(426),g(427),dp) 
M3= Cmplx(g(428),g(429),dp) 
vd= g(430) 
vu= g(431) 
Do i1=1,431 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters431

Subroutine ParametersToG431(g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,            & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu,g)

Implicit None 
Real(dp), Intent(out) :: g(431) 
Real(dp), Intent(in) :: g1,g2,g3,mHd2,mHu2,vd,vu

Complex(dp), Intent(in) :: Yd(3,3),Ye(3,3),L1(3,3,3),L2(3,3,3),Yu(3,3),Mu,Td(3,3),Te(3,3),T1(3,3,3),             & 
& T2(3,3,3),Tu(3,3),Bmu,mq2(3,3),ml2(3,3),md2(3,3),mu2(3,3),me2(3,3),M1,M2,M3

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG431' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+4) = Real(Yd(i1,i2), dp) 
g(SumI+5) = Aimag(Yd(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+22) = Real(Ye(i1,i2), dp) 
g(SumI+23) = Aimag(Ye(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+40) = Real(L1(i1,i2,i3), dp) 
g(SumI+41) = Aimag(L1(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+94) = Real(L2(i1,i2,i3), dp) 
g(SumI+95) = Aimag(L2(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+148) = Real(Yu(i1,i2), dp) 
g(SumI+149) = Aimag(Yu(i1,i2)) 
End Do 
End Do 

g(166) = Real(Mu,dp)  
g(167) = Aimag(Mu)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+168) = Real(Td(i1,i2), dp) 
g(SumI+169) = Aimag(Td(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+186) = Real(Te(i1,i2), dp) 
g(SumI+187) = Aimag(Te(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+204) = Real(T1(i1,i2,i3), dp) 
g(SumI+205) = Aimag(T1(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
SumI = (i3-1) + (i2-1)*3 + (i1-1)*9
SumI = SumI*2 
g(SumI+258) = Real(T2(i1,i2,i3), dp) 
g(SumI+259) = Aimag(T2(i1,i2,i3)) 
End Do 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+312) = Real(Tu(i1,i2), dp) 
g(SumI+313) = Aimag(Tu(i1,i2)) 
End Do 
End Do 

g(330) = Real(Bmu,dp)  
g(331) = Aimag(Bmu)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+332) = Real(mq2(i1,i2), dp) 
g(SumI+333) = Aimag(mq2(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+350) = Real(ml2(i1,i2), dp) 
g(SumI+351) = Aimag(ml2(i1,i2)) 
End Do 
End Do 

g(368) = mHd2  
g(369) = mHu2  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+370) = Real(md2(i1,i2), dp) 
g(SumI+371) = Aimag(md2(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+388) = Real(mu2(i1,i2), dp) 
g(SumI+389) = Aimag(mu2(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+406) = Real(me2(i1,i2), dp) 
g(SumI+407) = Aimag(me2(i1,i2)) 
End Do 
End Do 

g(424) = Real(M1,dp)  
g(425) = Aimag(M1)  
g(426) = Real(M2,dp)  
g(427) = Aimag(M2)  
g(428) = Real(M3,dp)  
g(429) = Aimag(M3)  
g(430) = vd  
g(431) = vu  
Iname = Iname - 1 
 
End Subroutine ParametersToG431

Subroutine rge431(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,         & 
& Dg3,mHd2,betamHd21,betamHd22,DmHd2,mHu2,betamHu21,betamHu22,DmHu2,vd,betavd1,          & 
& betavd2,Dvd,vu,betavu1,betavu2,Dvu
Complex(dp) :: Yd(3,3),betaYd1(3,3),betaYd2(3,3),DYd(3,3),adjYd(3,3),Ye(3,3)          & 
& ,betaYe1(3,3),betaYe2(3,3),DYe(3,3),adjYe(3,3),L1(3,3,3),betaL11(3,3,3),               & 
& betaL12(3,3,3),DL1(3,3,3),L2(3,3,3),betaL21(3,3,3),betaL22(3,3,3),DL2(3,3,3)           & 
& ,Yu(3,3),betaYu1(3,3),betaYu2(3,3),DYu(3,3),adjYu(3,3),Mu,betaMu1,betaMu2,             & 
& DMu,Td(3,3),betaTd1(3,3),betaTd2(3,3),DTd(3,3),adjTd(3,3),Te(3,3),betaTe1(3,3)         & 
& ,betaTe2(3,3),DTe(3,3),adjTe(3,3),T1(3,3,3),betaT11(3,3,3),betaT12(3,3,3)              & 
& ,DT1(3,3,3),T2(3,3,3),betaT21(3,3,3),betaT22(3,3,3),DT2(3,3,3),Tu(3,3),betaTu1(3,3)    & 
& ,betaTu2(3,3),DTu(3,3),adjTu(3,3),Bmu,betaBmu1,betaBmu2,DBmu,mq2(3,3),betamq21(3,3)    & 
& ,betamq22(3,3),Dmq2(3,3),ml2(3,3),betaml21(3,3),betaml22(3,3),Dml2(3,3),               & 
& md2(3,3),betamd21(3,3),betamd22(3,3),Dmd2(3,3),mu2(3,3),betamu21(3,3),betamu22(3,3)    & 
& ,Dmu2(3,3),me2(3,3),betame21(3,3),betame22(3,3),Dme2(3,3),M1,betaM11,betaM12,          & 
& DM1,M2,betaM21,betaM22,DM2,M3,betaM31,betaM32,DM3
Real(dp) :: Tr1(3),Tr2(3),Tr3(3) 
Real(dp) :: Tr2U1(3,3) 
Real(dp) :: AbsM1,AbsM2,AbsM3
Complex(dp) :: md2Yd(3,3),me2Ye(3,3),ml2adjYe(3,3),mq2adjYd(3,3),mq2adjYu(3,3),mu2Yu(3,3),           & 
& Ydmq2(3,3),YdadjYd(3,3),Yeml2(3,3),YeadjYe(3,3),Yumq2(3,3),YuadjYu(3,3),               & 
& adjYdmd2(3,3),adjYdYd(3,3),adjYdTd(3,3),adjYeme2(3,3),adjYeYe(3,3),adjYeTe(3,3),       & 
& adjYumu2(3,3),adjYuYu(3,3),adjYuTu(3,3),adjL21L11(3,3),adjL21L12(3,3),adjL21L13(3,3),  & 
& adjL21L21(3,3),adjL21L22(3,3),adjL21L23(3,3),adjL21T11(3,3),adjL21T12(3,3),            & 
& adjL21T13(3,3),adjL21T21(3,3),adjL21T22(3,3),adjL21T23(3,3),adjL22L11(3,3),            & 
& adjL22L12(3,3),adjL22L13(3,3),adjL22L21(3,3),adjL22L22(3,3),adjL22L23(3,3),            & 
& adjL22T11(3,3),adjL22T12(3,3),adjL22T13(3,3),adjL22T21(3,3),adjL22T22(3,3),            & 
& adjL22T23(3,3),adjL23L11(3,3),adjL23L12(3,3),adjL23L13(3,3),adjL23L21(3,3),            & 
& adjL23L22(3,3),adjL23L23(3,3),adjL23T11(3,3),adjL23T12(3,3),adjL23T13(3,3),            & 
& adjL23T21(3,3),adjL23T22(3,3),adjL23T23(3,3),adjTdTd(3,3),adjTeTe(3,3),adjTuTu(3,3),   & 
& adjT21T21(3,3),adjT22T22(3,3),adjT23T23(3,3),Cml2L11(3,3),Cml2L12(3,3),Cml2L13(3,3),   & 
& Cml2L21(3,3),Cml2L22(3,3),Cml2L23(3,3),Cmq2TpL21(3,3),Cmq2TpL22(3,3),Cmq2TpL23(3,3),   & 
& CYdTpL21(3,3),CYdTpL22(3,3),CYdTpL23(3,3),CYdTpTd(3,3),CYdTpT21(3,3),CYdTpT22(3,3),    & 
& CYdTpT23(3,3),CYeL11(3,3),CYeL12(3,3),CYeL13(3,3),CYeL21(3,3),CYeL22(3,3),             & 
& CYeL23(3,3),CYeTpTe(3,3),CYeT11(3,3),CYeT12(3,3),CYeT13(3,3),CYeT21(3,3),              & 
& CYeT22(3,3),CYeT23(3,3),CL11L11(3,3),CL11L12(3,3),CL11L13(3,3),CL11L21(3,3),           & 
& CL11L22(3,3),CL11L23(3,3),CL11TpYe(3,3),CL11TpTe(3,3),CL11T11(3,3),CL11T12(3,3),       & 
& CL11T13(3,3),CL11T21(3,3),CL11T22(3,3),CL11T23(3,3),CL12L11(3,3),CL12L12(3,3),         & 
& CL12L13(3,3),CL12L21(3,3),CL12L22(3,3),CL12L23(3,3),CL12TpYe(3,3),CL12TpTe(3,3),       & 
& CL12T11(3,3),CL12T12(3,3),CL12T13(3,3),CL12T21(3,3),CL12T22(3,3),CL12T23(3,3),         & 
& CL13L11(3,3),CL13L12(3,3),CL13L13(3,3),CL13L21(3,3),CL13L22(3,3),CL13L23(3,3),         & 
& CL13TpYe(3,3),CL13TpTe(3,3),CL13T11(3,3),CL13T12(3,3),CL13T13(3,3),CL13T21(3,3),       & 
& CL13T22(3,3),CL13T23(3,3),CL21TpYd(3,3),CL21TpL21(3,3),CL21TpL22(3,3),CL21TpL23(3,3),  & 
& CL21TpTd(3,3),CL21TpT21(3,3),CL22TpYd(3,3),CL22TpL21(3,3),CL22TpL22(3,3),              & 
& CL22TpL23(3,3),CL22TpTd(3,3),CL22TpT22(3,3),CL23TpYd(3,3),CL23TpL21(3,3),              & 
& CL23TpL22(3,3),CL23TpL23(3,3),CL23TpTd(3,3),CL23TpT23(3,3),CTdTpTd(3,3),               & 
& CTeTpTe(3,3),CTuTpTu(3,3),CT11T11(3,3),CT11T12(3,3),CT11T13(3,3),CT12T11(3,3),         & 
& CT12T12(3,3),CT12T13(3,3),CT13T11(3,3),CT13T12(3,3),CT13T13(3,3),CT21TpT21(3,3),       & 
& CT21TpT22(3,3),CT21TpT23(3,3),CT22TpT21(3,3),CT22TpT22(3,3),CT22TpT23(3,3),            & 
& CT23TpT21(3,3),CT23TpT22(3,3),CT23TpT23(3,3),L11ml2(3,3),L12ml2(3,3),L13ml2(3,3),      & 
& L21mq2(3,3),L22mq2(3,3),L23mq2(3,3),TdadjTd(3,3),TeadjTe(3,3),TuadjTu(3,3),            & 
& TpL21ml2(3,3),TpL22ml2(3,3),TpL23ml2(3,3),md2YdadjYd(3,3),me2YeadjYe(3,3),             & 
& ml2adjYeYe(3,3),ml2CL11L11(3,3),ml2CL11L12(3,3),ml2CL11L13(3,3),ml2CL12L11(3,3),       & 
& ml2CL12L12(3,3),ml2CL12L13(3,3),ml2CL13L11(3,3),ml2CL13L12(3,3),ml2CL13L13(3,3),       & 
& ml2CL21TpL21(3,3),ml2CL21TpL22(3,3),ml2CL21TpL23(3,3),ml2CL22TpL21(3,3),               & 
& ml2CL22TpL22(3,3),ml2CL22TpL23(3,3),ml2CL23TpL21(3,3),ml2CL23TpL22(3,3)

Complex(dp) :: ml2CL23TpL23(3,3),mq2adjYdYd(3,3),mq2adjYuYu(3,3),mq2adjL21L21(3,3),mq2adjL21L22(3,3), & 
& mq2adjL21L23(3,3),mq2adjL22L21(3,3),mq2adjL22L22(3,3),mq2adjL22L23(3,3),               & 
& mq2adjL23L21(3,3),mq2adjL23L22(3,3),mq2adjL23L23(3,3),mu2YuadjYu(3,3),Ydmq2adjYd(3,3), & 
& YdadjYdmd2(3,3),YdadjYdYd(3,3),YdadjYdTd(3,3),YdadjYuYu(3,3),YdadjYuTu(3,3),           & 
& YdadjL21L21(3,3),YdadjL21L22(3,3),YdadjL21L23(3,3),YdadjL21T11(3,3),YdadjL21T12(3,3),  & 
& YdadjL21T13(3,3),YdadjL21T21(3,3),YdadjL21T22(3,3),YdadjL21T23(3,3),YdadjL22L21(3,3),  & 
& YdadjL22L22(3,3),YdadjL22L23(3,3),YdadjL22T11(3,3),YdadjL22T12(3,3),YdadjL22T13(3,3),  & 
& YdadjL22T21(3,3),YdadjL22T22(3,3),YdadjL22T23(3,3),YdadjL23L21(3,3),YdadjL23L22(3,3),  & 
& YdadjL23L23(3,3),YdadjL23T11(3,3),YdadjL23T12(3,3),YdadjL23T13(3,3),YdadjL23T21(3,3),  & 
& YdadjL23T22(3,3),YdadjL23T23(3,3),Yeml2adjYe(3,3),YeadjYeme2(3,3),YeadjYeYe(3,3),      & 
& YeadjYeTe(3,3),YeCL11L11(3,3),YeCL11L21(3,3),YeCL11L22(3,3),YeCL11L23(3,3),            & 
& YeCL11T11(3,3),YeCL11T12(3,3),YeCL11T13(3,3),YeCL11T21(3,3),YeCL11T22(3,3),            & 
& YeCL11T23(3,3),YeCL12L12(3,3),YeCL12L21(3,3),YeCL12L22(3,3),YeCL12L23(3,3),            & 
& YeCL12T11(3,3),YeCL12T12(3,3),YeCL12T13(3,3),YeCL12T21(3,3),YeCL12T22(3,3),            & 
& YeCL12T23(3,3),YeCL13L13(3,3),YeCL13L21(3,3),YeCL13L22(3,3),YeCL13L23(3,3),            & 
& YeCL13T11(3,3),YeCL13T12(3,3),YeCL13T13(3,3),YeCL13T21(3,3),YeCL13T22(3,3),            & 
& YeCL13T23(3,3),YeCL21TpL21(3,3),YeCL21TpT21(3,3),YeCL22TpL22(3,3),YeCL22TpT22(3,3),    & 
& YeCL23TpL23(3,3),YeCL23TpT23(3,3),Yumq2adjYu(3,3),YuadjYdYd(3,3),YuadjYdTd(3,3),       & 
& YuadjYumu2(3,3),YuadjYuYu(3,3),YuadjYuTu(3,3),YuadjL21L21(3,3),YuadjL21T21(3,3),       & 
& YuadjL22L22(3,3),YuadjL22T22(3,3),YuadjL23L23(3,3),YuadjL23T23(3,3),adjYdmd2Yd(3,3),   & 
& adjYdYdmq2(3,3),adjYeme2Ye(3,3),adjYeYeml2(3,3),adjYumu2Yu(3,3),adjYuYumq2(3,3),       & 
& adjL21Cml2L21(3,3),adjL21L21mq2(3,3),adjL22Cml2L22(3,3),adjL22L22mq2(3,3),             & 
& adjL23Cml2L23(3,3),adjL23L23mq2(3,3),CL11Cml2L11(3,3),CL11L11ml2(3,3),CL12Cml2L12(3,3),& 
& CL12L12ml2(3,3),CL13Cml2L13(3,3),CL13L13ml2(3,3),CL21Cmq2TpL21(3,3),CL21TpL21ml2(3,3), & 
& CL22Cmq2TpL22(3,3),CL22TpL22ml2(3,3),CL23Cmq2TpL23(3,3),CL23TpL23ml2(3,3),             & 
& L11adjYeYe(3,3),L11adjYeTe(3,3),L11CL11L11(3,3),L11CL11L12(3,3),L11CL11L13(3,3),       & 
& L11CL11L21(3,3),L11CL11L22(3,3),L11CL11L23(3,3),L11CL11TpYe(3,3),L11CL11TpTe(3,3),     & 
& L11CL11T11(3,3),L11CL11T12(3,3),L11CL11T13(3,3),L11CL11T21(3,3),L11CL11T22(3,3),       & 
& L11CL11T23(3,3),L11CL12L12(3,3),L11CL12TpYe(3,3),L11CL12TpTe(3,3),L11CL12T12(3,3),     & 
& L11CL13L13(3,3),L11CL13TpYe(3,3),L11CL13TpTe(3,3),L11CL13T13(3,3),L11CL21TpYd(3,3),    & 
& L11CL21TpL21(3,3),L11CL21TpTd(3,3),L11CL21TpT21(3,3),L11CL22TpYd(3,3),L11CL22TpL22(3,3),& 
& L11CL22TpTd(3,3),L11CL22TpT22(3,3),L11CL23TpYd(3,3),L11CL23TpL23(3,3),L11CL23TpTd(3,3),& 
& L11CL23TpT23(3,3),L12adjYeYe(3,3),L12adjYeTe(3,3),L12CL11L11(3,3),L12CL11TpYe(3,3),    & 
& L12CL11TpTe(3,3),L12CL11T11(3,3),L12CL12L11(3,3),L12CL12L12(3,3),L12CL12L13(3,3),      & 
& L12CL12L21(3,3),L12CL12L22(3,3),L12CL12L23(3,3),L12CL12TpYe(3,3),L12CL12TpTe(3,3),     & 
& L12CL12T11(3,3),L12CL12T12(3,3),L12CL12T13(3,3),L12CL12T21(3,3),L12CL12T22(3,3),       & 
& L12CL12T23(3,3),L12CL13L13(3,3),L12CL13TpYe(3,3),L12CL13TpTe(3,3),L12CL13T13(3,3)

Complex(dp) :: L12CL21TpYd(3,3),L12CL21TpL21(3,3),L12CL21TpTd(3,3),L12CL21TpT21(3,3),L12CL22TpYd(3,3),& 
& L12CL22TpL22(3,3),L12CL22TpTd(3,3),L12CL22TpT22(3,3),L12CL23TpYd(3,3),L12CL23TpL23(3,3),& 
& L12CL23TpTd(3,3),L12CL23TpT23(3,3),L13adjYeYe(3,3),L13adjYeTe(3,3),L13CL11L11(3,3),    & 
& L13CL11TpYe(3,3),L13CL11TpTe(3,3),L13CL11T11(3,3),L13CL12L12(3,3),L13CL12TpYe(3,3),    & 
& L13CL12TpTe(3,3),L13CL12T12(3,3),L13CL13L11(3,3),L13CL13L12(3,3),L13CL13L13(3,3),      & 
& L13CL13L21(3,3),L13CL13L22(3,3),L13CL13L23(3,3),L13CL13TpYe(3,3),L13CL13TpTe(3,3),     & 
& L13CL13T11(3,3),L13CL13T12(3,3),L13CL13T13(3,3),L13CL13T21(3,3),L13CL13T22(3,3),       & 
& L13CL13T23(3,3),L13CL21TpYd(3,3),L13CL21TpL21(3,3),L13CL21TpTd(3,3),L13CL21TpT21(3,3), & 
& L13CL22TpYd(3,3),L13CL22TpL22(3,3),L13CL22TpTd(3,3),L13CL22TpT22(3,3),L13CL23TpYd(3,3),& 
& L13CL23TpL23(3,3),L13CL23TpTd(3,3),L13CL23TpT23(3,3),L21adjYdYd(3,3),L21adjYdTd(3,3),  & 
& L21adjYuYu(3,3),L21adjYuTu(3,3),L21adjL21L11(3,3),L21adjL21L12(3,3),L21adjL21L13(3,3), & 
& L21adjL21L21(3,3),L21adjL21L22(3,3),L21adjL21L23(3,3),L21adjL21T11(3,3),               & 
& L21adjL21T12(3,3),L21adjL21T13(3,3),L21adjL21T21(3,3),L21adjL21T22(3,3),               & 
& L21adjL21T23(3,3),L21adjL22L22(3,3),L21adjL22T22(3,3),L21adjL23L23(3,3),               & 
& L21adjL23T23(3,3),L22adjYdYd(3,3),L22adjYdTd(3,3),L22adjYuYu(3,3),L22adjYuTu(3,3),     & 
& L22adjL21L21(3,3),L22adjL21T21(3,3),L22adjL22L11(3,3),L22adjL22L12(3,3),               & 
& L22adjL22L13(3,3),L22adjL22L21(3,3),L22adjL22L22(3,3),L22adjL22L23(3,3),               & 
& L22adjL22T11(3,3),L22adjL22T12(3,3),L22adjL22T13(3,3),L22adjL22T21(3,3),               & 
& L22adjL22T22(3,3),L22adjL22T23(3,3),L22adjL23L23(3,3),L22adjL23T23(3,3),               & 
& L23adjYdYd(3,3),L23adjYdTd(3,3),L23adjYuYu(3,3),L23adjYuTu(3,3),L23adjL21L21(3,3),     & 
& L23adjL21T21(3,3),L23adjL22L22(3,3),L23adjL22T22(3,3),L23adjL23L11(3,3),               & 
& L23adjL23L12(3,3),L23adjL23L13(3,3),L23adjL23L21(3,3),L23adjL23L22(3,3),               & 
& L23adjL23L23(3,3),L23adjL23T11(3,3),L23adjL23T12(3,3),L23adjL23T13(3,3),               & 
& L23adjL23T21(3,3),L23adjL23T22(3,3),L23adjL23T23(3,3),TdadjYdYd(3,3),TdadjYuYu(3,3),   & 
& TdadjL21L21(3,3),TdadjL22L22(3,3),TdadjL23L23(3,3),TeadjYeYe(3,3),TeCL11L11(3,3),      & 
& TeCL12L12(3,3),TeCL13L13(3,3),TeCL21TpL21(3,3),TeCL22TpL22(3,3),TeCL23TpL23(3,3),      & 
& TuadjYdYd(3,3),TuadjYuYu(3,3),TuadjL21L21(3,3),TuadjL22L22(3,3),TuadjL23L23(3,3),      & 
& TpYeCYeL11(3,3),TpYeCYeL12(3,3),TpYeCYeL13(3,3),TpYeCYeL21(3,3),TpYeCYeL22(3,3),       & 
& TpYeCYeL23(3,3),TpYeCYeT11(3,3),TpYeCYeT12(3,3),TpYeCYeT13(3,3),TpYeCYeT21(3,3),       & 
& TpYeCYeT22(3,3),TpYeCYeT23(3,3),TpL21CL11TpTe(3,3),TpL21CL12TpTe(3,3),TpL21CL13TpTe(3,3),& 
& TpL21CL21TpTd(3,3),TpL21CL22TpTd(3,3),TpL21CL23TpTd(3,3),TpL22CL11TpTe(3,3),           & 
& TpL22CL12TpTe(3,3),TpL22CL13TpTe(3,3),TpL22CL21TpTd(3,3),TpL22CL22TpTd(3,3),           & 
& TpL22CL23TpTd(3,3),TpL23CL11TpTe(3,3),TpL23CL12TpTe(3,3),TpL23CL13TpTe(3,3),           & 
& TpL23CL21TpTd(3,3),TpL23CL22TpTd(3,3),TpL23CL23TpTd(3,3),TpTeCYeL11(3,3),              & 
& TpTeCYeL12(3,3),TpTeCYeL13(3,3),TpTeCYeL21(3,3),TpTeCYeL22(3,3),TpTeCYeL23(3,3),       & 
& T11adjYeYe(3,3),T11CL11L11(3,3),T11CL11L12(3,3),T11CL11L13(3,3),T11CL11L21(3,3),       & 
& T11CL11L22(3,3),T11CL11L23(3,3),T11CL12L12(3,3),T11CL13L13(3,3),T11CL21TpL21(3,3)

Complex(dp) :: T11CL22TpL22(3,3),T11CL23TpL23(3,3),T12adjYeYe(3,3),T12CL11L11(3,3),T12CL12L11(3,3),   & 
& T12CL12L12(3,3),T12CL12L13(3,3),T12CL12L21(3,3),T12CL12L22(3,3),T12CL12L23(3,3),       & 
& T12CL13L13(3,3),T12CL21TpL21(3,3),T12CL22TpL22(3,3),T12CL23TpL23(3,3),T13adjYeYe(3,3), & 
& T13CL11L11(3,3),T13CL12L12(3,3),T13CL13L11(3,3),T13CL13L12(3,3),T13CL13L13(3,3),       & 
& T13CL13L21(3,3),T13CL13L22(3,3),T13CL13L23(3,3),T13CL21TpL21(3,3),T13CL22TpL22(3,3),   & 
& T13CL23TpL23(3,3),T21adjYdYd(3,3),T21adjYuYu(3,3),T21adjL21L11(3,3),T21adjL21L12(3,3), & 
& T21adjL21L13(3,3),T21adjL21L21(3,3),T21adjL21L22(3,3),T21adjL21L23(3,3),               & 
& T21adjL22L22(3,3),T21adjL23L23(3,3),T22adjYdYd(3,3),T22adjYuYu(3,3),T22adjL21L21(3,3), & 
& T22adjL22L11(3,3),T22adjL22L12(3,3),T22adjL22L13(3,3),T22adjL22L21(3,3),               & 
& T22adjL22L22(3,3),T22adjL22L23(3,3),T22adjL23L23(3,3),T23adjYdYd(3,3),T23adjYuYu(3,3), & 
& T23adjL21L21(3,3),T23adjL22L22(3,3),T23adjL23L11(3,3),T23adjL23L12(3,3),               & 
& T23adjL23L13(3,3),T23adjL23L21(3,3),T23adjL23L22(3,3),T23adjL23L23(3,3)

Complex(dp) :: YdadjYu(3,3),YdadjTd(3,3),YdadjTu(3,3),YeadjTe(3,3),YuadjYd(3,3),YuadjTd(3,3),        & 
& YuadjTu(3,3),adjYdCmd2(3,3),adjYeCme2(3,3),adjYuCmu2(3,3),adjTdYd(3,3),adjTeYe(3,3),   & 
& adjTuYu(3,3),Cml2adjYe(3,3),Cmq2adjYd(3,3),Cmq2adjYu(3,3),CTdTpYd(3,3),CTeTpYe(3,3),   & 
& CTuTpYu(3,3),L11CL11(3,3),L12CL12(3,3),L13CL13(3,3),L21adjL21(3,3),L22adjL22(3,3),     & 
& L23adjL23(3,3),TdadjYd(3,3),TdadjYu(3,3),TdadjTu(3,3),TeadjYe(3,3),TuadjYd(3,3),       & 
& TuadjYu(3,3),TuadjTd(3,3),TpL21CL21(3,3),TpL22CL22(3,3),TpL23CL23(3,3),md2YdadjYu(3,3),& 
& ml2L11CL11(3,3),ml2L12CL12(3,3),ml2L13CL13(3,3),ml2L21adjL21(3,3),ml2L22adjL22(3,3),   & 
& ml2L23adjL23(3,3),mq2TpL21CL21(3,3),mq2TpL22CL22(3,3),mq2TpL23CL23(3,3),               & 
& mu2YuadjYd(3,3),Ydmq2adjYu(3,3),YdadjYdCmd2(3,3),YdadjYumu2(3,3),YdadjTdTd(3,3),       & 
& YdCmq2adjYd(3,3),YeadjYeCme2(3,3),YeadjTeTe(3,3),YeCml2adjYe(3,3),Yumq2adjYd(3,3),     & 
& YuadjYdmd2(3,3),YuadjYuCmu2(3,3),YuadjTuTu(3,3),YuCmq2adjYu(3,3),adjYdYdadjYd(3,3),    & 
& adjYdYdadjYu(3,3),adjYdYdadjTd(3,3),adjYdYdadjTu(3,3),adjYdTdadjYd(3,3),               & 
& adjYdTdadjYu(3,3),adjYdTdadjTd(3,3),adjYdTdadjTu(3,3),adjYeYeadjYe(3,3),               & 
& adjYeYeadjTe(3,3),adjYeTeadjYe(3,3),adjYeTeadjTe(3,3),adjYuYuadjYd(3,3),               & 
& adjYuYuadjYu(3,3),adjYuYuadjTd(3,3),adjYuYuadjTu(3,3),adjYuTuadjYd(3,3),               & 
& adjYuTuadjYu(3,3),adjYuTuadjTd(3,3),adjYuTuadjTu(3,3),adjTdYdadjYd(3,3),               & 
& adjTdYdadjYu(3,3),adjTdTdadjYd(3,3),adjTdTdadjYu(3,3),adjTeYeadjYe(3,3),               & 
& adjTeTeadjYe(3,3),adjTuYuadjYd(3,3),adjTuYuadjYu(3,3),adjTuTuadjYd(3,3),               & 
& adjTuTuadjYu(3,3),TdadjTdYd(3,3),TeadjTeYe(3,3),TuadjTuYu(3,3),md2YdadjYdYd(3,3),      & 
& me2YeadjYeYe(3,3),ml2adjYeYeadjYe(3,3),mq2adjYdYdadjYd(3,3),mq2adjYdYdadjYu(3,3),      & 
& mq2adjYuYuadjYd(3,3),mq2adjYuYuadjYu(3,3),mu2YuadjYuYu(3,3),Ydmq2adjYdYd(3,3),         & 
& YdadjYdmd2Yd(3,3),YdadjYdYdmq2(3,3),YdadjYdYdadjYd(3,3),YdadjYdTdadjYd(3,3),           & 
& YdadjYdTdadjTd(3,3),YdadjYuYuadjYd(3,3),YdadjYuTuadjYd(3,3),YdadjYuTuadjTd(3,3),       & 
& YdadjTdTdadjYd(3,3),YdadjTuTuadjYd(3,3),Yeml2adjYeYe(3,3),YeadjYeme2Ye(3,3),           & 
& YeadjYeYeml2(3,3),YeadjYeYeadjYe(3,3),YeadjYeTeadjYe(3,3),YeadjYeTeadjTe(3,3),         & 
& YeadjTeTeadjYe(3,3),Yumq2adjYuYu(3,3),YuadjYdYdadjYu(3,3),YuadjYdTdadjYu(3,3),         & 
& YuadjYdTdadjTu(3,3),YuadjYumu2Yu(3,3),YuadjYuYumq2(3,3),YuadjYuYuadjYu(3,3),           & 
& YuadjYuTuadjYu(3,3),YuadjYuTuadjTu(3,3),YuadjTdTdadjYu(3,3),YuadjTuTuadjYu(3,3),       & 
& adjYdmd2YdadjYd(3,3),adjYdmd2YdadjYu(3,3),adjYdYdmq2adjYd(3,3),adjYdYdmq2adjYu(3,3),   & 
& adjYdYdadjYdmd2(3,3),adjYdYdadjYdYd(3,3),adjYdYdadjYdTd(3,3),adjYdYdadjYumu2(3,3),     & 
& adjYdYdadjYuYu(3,3),adjYdYdadjYuTu(3,3),adjYdYdadjTdTd(3,3),adjYdTdadjYdYd(3,3),       & 
& adjYdTdadjYuYu(3,3),adjYdTdadjTdYd(3,3),adjYeme2YeadjYe(3,3),adjYeYeml2adjYe(3,3),     & 
& adjYeYeadjYeme2(3,3),adjYeYeadjYeYe(3,3),adjYeYeadjYeTe(3,3),adjYeYeadjTeTe(3,3),      & 
& adjYeTeadjYeYe(3,3),adjYeTeadjTeYe(3,3),adjYumu2YuadjYd(3,3),adjYumu2YuadjYu(3,3),     & 
& adjYuYumq2adjYd(3,3),adjYuYumq2adjYu(3,3),adjYuYuadjYdmd2(3,3),adjYuYuadjYdYd(3,3),    & 
& adjYuYuadjYdTd(3,3),adjYuYuadjYumu2(3,3),adjYuYuadjYuYu(3,3),adjYuYuadjYuTu(3,3),      & 
& adjYuYuadjTuTu(3,3),adjYuTuadjYdYd(3,3),adjYuTuadjYuYu(3,3),adjYuTuadjTuYu(3,3)

Complex(dp) :: adjTdYdadjYdTd(3,3),adjTdTdadjYdYd(3,3),adjTeYeadjYeTe(3,3),adjTeTeadjYeYe(3,3),       & 
& adjTuYuadjYuTu(3,3),adjTuTuadjYuYu(3,3),TdadjYdYdadjTd(3,3),TdadjYuYuadjTd(3,3),       & 
& TdadjTdYdadjYd(3,3),TdadjTuYuadjYd(3,3),TeadjYeYeadjTe(3,3),TeadjTeYeadjYe(3,3),       & 
& TuadjYdYdadjTu(3,3),TuadjYuYuadjTu(3,3),TuadjTdYdadjYu(3,3),TuadjTuYuadjYu(3,3),       & 
& md2YdadjYdYdadjYd(3,3),md2YdadjYuYuadjYd(3,3),me2YeadjYeYeadjYe(3,3),ml2adjYeYeadjYeYe(3,3),& 
& mq2adjYdYdadjYdYd(3,3),mq2adjYdYdadjYuYu(3,3),mq2adjYuYuadjYdYd(3,3),mq2adjYuYuadjYuYu(3,3),& 
& mu2YuadjYdYdadjYu(3,3),mu2YuadjYuYuadjYu(3,3),Ydmq2adjYdYdadjYd(3,3),Ydmq2adjYuYuadjYd(3,3),& 
& YdadjYdmd2YdadjYd(3,3),YdadjYdYdmq2adjYd(3,3),YdadjYdYdadjYdmd2(3,3),YdadjYdYdadjYdYd(3,3),& 
& YdadjYdYdadjYdTd(3,3),YdadjYdTdadjYdYd(3,3),YdadjYumu2YuadjYd(3,3),YdadjYuYumq2adjYd(3,3),& 
& YdadjYuYuadjYdmd2(3,3),YdadjYuYuadjYdYd(3,3),YdadjYuYuadjYdTd(3,3),YdadjYuYuadjYuYu(3,3),& 
& YdadjYuYuadjYuTu(3,3),YdadjYuTuadjYdYd(3,3),YdadjYuTuadjYuYu(3,3),Yeml2adjYeYeadjYe(3,3),& 
& YeadjYeme2YeadjYe(3,3),YeadjYeYeml2adjYe(3,3),YeadjYeYeadjYeme2(3,3),YeadjYeYeadjYeYe(3,3),& 
& YeadjYeYeadjYeTe(3,3),YeadjYeTeadjYeYe(3,3),Yumq2adjYdYdadjYu(3,3),Yumq2adjYuYuadjYu(3,3),& 
& YuadjYdmd2YdadjYu(3,3),YuadjYdYdmq2adjYu(3,3),YuadjYdYdadjYdYd(3,3),YuadjYdYdadjYdTd(3,3),& 
& YuadjYdYdadjYumu2(3,3),YuadjYdYdadjYuYu(3,3),YuadjYdYdadjYuTu(3,3),YuadjYdTdadjYdYd(3,3),& 
& YuadjYdTdadjYuYu(3,3),YuadjYumu2YuadjYu(3,3),YuadjYuYumq2adjYu(3,3),YuadjYuYuadjYumu2(3,3),& 
& YuadjYuYuadjYuYu(3,3),YuadjYuYuadjYuTu(3,3),YuadjYuTuadjYuYu(3,3),adjYdmd2YdadjYdYd(3,3),& 
& adjYdYdmq2adjYdYd(3,3),adjYdYdadjYdmd2Yd(3,3),adjYdYdadjYdYdmq2(3,3),adjYeme2YeadjYeYe(3,3),& 
& adjYeYeml2adjYeYe(3,3),adjYeYeadjYeme2Ye(3,3),adjYeYeadjYeYeml2(3,3),adjYumu2YuadjYuYu(3,3),& 
& adjYuYumq2adjYuYu(3,3),adjYuYuadjYumu2Yu(3,3),adjYuYuadjYuYumq2(3,3),TdadjYdYdadjYdYd(3,3),& 
& TdadjYuYuadjYdYd(3,3),TdadjYuYuadjYuYu(3,3),TeadjYeYeadjYeYe(3,3),TuadjYdYdadjYdYd(3,3),& 
& TuadjYdYdadjYuYu(3,3),TuadjYuYuadjYuYu(3,3)

Complex(dp) :: Trmd2,Trme2,Trml2,Trmq2,Trmu2,TrYdadjYd,TrYeadjYe,TrYuadjYu,TradjYdTd,TradjYeTe,      & 
& TradjYuTu,TradjL21T21,TradjL21T22,TradjL21T23,TradjL22T21,TradjL22T22,TradjL22T23,     & 
& TradjL23T21,TradjL23T22,TradjL23T23,TrCL11L11,TrCL11L12,TrCL11L13,TrCL11T11,           & 
& TrCL11T12,TrCL11T13,TrCL12L11,TrCL12L12,TrCL12L13,TrCL12T11,TrCL12T12,TrCL12T13,       & 
& TrCL13L11,TrCL13L12,TrCL13L13,TrCL13T11,TrCL13T12,TrCL13T13,TrCL21TpL21,               & 
& TrCL21TpL22,TrCL21TpL23,TrCL22TpL21,TrCL22TpL22,TrCL22TpL23,TrCL23TpL21,               & 
& TrCL23TpL22,TrCL23TpL23,TrCTdTpTd,TrCTeTpTe,TrCTuTpTu,TrCT11T11,TrCT11T12,             & 
& TrCT11T13,TrCT12T11,TrCT12T12,TrCT12T13,TrCT13T11,TrCT13T12,TrCT13T13,TrCT21TpT21,     & 
& TrCT21TpT22,TrCT21TpT23,TrCT22TpT21,TrCT22TpT22,TrCT22TpT23,TrCT23TpT21,               & 
& TrCT23TpT22,TrCT23TpT23,Trmd2YdadjYd,Trme2YeadjYe,Trml2adjYeYe,Trml2CL11L11,           & 
& Trml2CL11L12,Trml2CL11L13,Trml2CL12L11,Trml2CL12L12,Trml2CL12L13,Trml2CL13L11,         & 
& Trml2CL13L12,Trml2CL13L13,Trml2CL21TpL21,Trml2CL21TpL22,Trml2CL21TpL23,Trml2CL22TpL21, & 
& Trml2CL22TpL22,Trml2CL22TpL23,Trml2CL23TpL21,Trml2CL23TpL22,Trml2CL23TpL23,            & 
& Trmq2adjYdYd,Trmq2adjYuYu,Trmq2adjL21L21,Trmq2adjL21L22,Trmq2adjL21L23,Trmq2adjL22L21, & 
& Trmq2adjL22L22,Trmq2adjL22L23,Trmq2adjL23L21,Trmq2adjL23L22,Trmq2adjL23L23,            & 
& Trmu2YuadjYu

Complex(dp) :: TrCTdTpYd,TrCTeTpYe,TrCTuTpYu,Trml2L11CL11,Trml2L12CL12,Trml2L13CL13,Trml2L21adjL21,  & 
& Trml2L22adjL22,Trml2L23adjL23,Trmq2TpL21CL21,Trmq2TpL22CL22,Trmq2TpL23CL23,            & 
& TrYdadjYdCmd2,TrYdCmq2adjYd,TrYeadjYeCme2,TrYeCml2adjYe,TrYuadjYuCmu2,TrYuCmq2adjYu,   & 
& TrYdadjYdYdadjYd,TrYdadjYdTdadjYd,TrYdadjYdTdadjTd,TrYdadjYuYuadjYd,TrYdadjYuTuadjYd,  & 
& TrYdadjYuTuadjTd,TrYdadjTdTdadjYd,TrYdadjTuTuadjYd,TrYeadjYeYeadjYe,TrYeadjYeTeadjYe,  & 
& TrYeadjYeTeadjTe,TrYeadjTeTeadjYe,TrYuadjYdTdadjYu,TrYuadjYdTdadjTu,TrYuadjYuYuadjYu,  & 
& TrYuadjYuTuadjYu,TrYuadjYuTuadjTu,TrYuadjTdTdadjYu,TrYuadjTuTuadjYu,Trmd2YdadjYdYdadjYd,& 
& Trmd2YdadjYuYuadjYd,Trme2YeadjYeYeadjYe,Trml2adjYeYeadjYeYe,Trmq2adjYdYdadjYdYd,       & 
& Trmq2adjYdYdadjYuYu,Trmq2adjYuYuadjYdYd,Trmq2adjYuYuadjYuYu,Trmu2YuadjYdYdadjYu,       & 
& Trmu2YuadjYuYuadjYu

Real(dp) :: g1p2,g1p3,g2p2,g2p3,g3p2,g3p3

Complex(dp) :: sqrt3ov5,ooSqrt15

Real(dp) :: g1p4,g1p5,g2p4,g2p5,g3p4,g3p5

Complex(dp) :: Xip2

Complex(dp) :: L11(3,3), adjL11(3,3) 
Complex(dp) :: L12(3,3), adjL12(3,3) 
Complex(dp) :: L13(3,3), adjL13(3,3) 
Complex(dp) :: T11(3,3), adjT11(3,3) 
Complex(dp) :: T12(3,3), adjT12(3,3) 
Complex(dp) :: T13(3,3), adjT13(3,3) 
Complex(dp) :: L21(3,3), adjL21(3,3) 
Complex(dp) :: L22(3,3), adjL22(3,3) 
Complex(dp) :: L23(3,3), adjL23(3,3) 
Complex(dp) :: T21(3,3), adjT21(3,3) 
Complex(dp) :: T22(3,3), adjT22(3,3) 
Complex(dp) :: T23(3,3), adjT23(3,3) 
Iname = Iname +1 
NameOfUnit(Iname) = 'rge431' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters431(gy,g1,g2,g3,Yd,Ye,L1,L2,Yu,Mu,Td,Te,T1,T2,Tu,Bmu,               & 
& mq2,ml2,mHd2,mHu2,md2,mu2,me2,M1,M2,M3,vd,vu)

L11=L1(:,:,1) 
Call Adjungate(L11,adjL11) 
L12=L1(:,:,2) 
Call Adjungate(L12,adjL12) 
L13=L1(:,:,3) 
Call Adjungate(L13,adjL13) 
T11=T1(:,:,1) 
Call Adjungate(T11,adjT11) 
T12=T1(:,:,2) 
Call Adjungate(T12,adjT12) 
T13=T1(:,:,3) 
Call Adjungate(T13,adjT13) 
L21=L2(:,:,1) 
Call Adjungate(L21,adjL21) 
L22=L2(:,:,2) 
Call Adjungate(L22,adjL22) 
L23=L2(:,:,3) 
Call Adjungate(L23,adjL23) 
T21=T2(:,:,1) 
Call Adjungate(T21,adjT21) 
T22=T2(:,:,2) 
Call Adjungate(T22,adjT22) 
T23=T2(:,:,3) 
Call Adjungate(T23,adjT23) 
AbsM1 = Conjg(M1)*M1
AbsM2 = Conjg(M2)*M2
AbsM3 = Conjg(M3)*M3
Call Adjungate(Yd,adjYd)
Call Adjungate(Ye,adjYe)
Call Adjungate(Yu,adjYu)
Call Adjungate(Td,adjTd)
Call Adjungate(Te,adjTe)
Call Adjungate(Tu,adjTu)
 md2Yd = Matmul(md2,Yd) 
 me2Ye = Matmul(me2,Ye) 
 ml2adjYe = Matmul(ml2,adjYe) 
 mq2adjYd = Matmul(mq2,adjYd) 
 mq2adjYu = Matmul(mq2,adjYu) 
 mu2Yu = Matmul(mu2,Yu) 
 Ydmq2 = Matmul(Yd,mq2) 
 YdadjYd = Matmul(Yd,adjYd) 
Forall(i2=1:3)  YdadjYd(i2,i2) =  Real(YdadjYd(i2,i2),dp) 
 Yeml2 = Matmul(Ye,ml2) 
 YeadjYe = Matmul(Ye,adjYe) 
Forall(i2=1:3)  YeadjYe(i2,i2) =  Real(YeadjYe(i2,i2),dp) 
 Yumq2 = Matmul(Yu,mq2) 
 YuadjYu = Matmul(Yu,adjYu) 
Forall(i2=1:3)  YuadjYu(i2,i2) =  Real(YuadjYu(i2,i2),dp) 
 adjYdmd2 = Matmul(adjYd,md2) 
 adjYdYd = Matmul(adjYd,Yd) 
Forall(i2=1:3)  adjYdYd(i2,i2) =  Real(adjYdYd(i2,i2),dp) 
 adjYdTd = Matmul(adjYd,Td) 
 adjYeme2 = Matmul(adjYe,me2) 
 adjYeYe = Matmul(adjYe,Ye) 
Forall(i2=1:3)  adjYeYe(i2,i2) =  Real(adjYeYe(i2,i2),dp) 
 adjYeTe = Matmul(adjYe,Te) 
 adjYumu2 = Matmul(adjYu,mu2) 
 adjYuYu = Matmul(adjYu,Yu) 
Forall(i2=1:3)  adjYuYu(i2,i2) =  Real(adjYuYu(i2,i2),dp) 
 adjYuTu = Matmul(adjYu,Tu) 
 adjL21L11 = Matmul(adjL21,L11) 
 adjL21L12 = Matmul(adjL21,L12) 
 adjL21L13 = Matmul(adjL21,L13) 
 adjL21L21 = Matmul(adjL21,L21) 
 adjL21L22 = Matmul(adjL21,L22) 
 adjL21L23 = Matmul(adjL21,L23) 
 adjL21T11 = Matmul(adjL21,T11) 
 adjL21T12 = Matmul(adjL21,T12) 
 adjL21T13 = Matmul(adjL21,T13) 
 adjL21T21 = Matmul(adjL21,T21) 
 adjL21T22 = Matmul(adjL21,T22) 
 adjL21T23 = Matmul(adjL21,T23) 
 adjL22L11 = Matmul(adjL22,L11) 
 adjL22L12 = Matmul(adjL22,L12) 
 adjL22L13 = Matmul(adjL22,L13) 
 adjL22L21 = Matmul(adjL22,L21) 
 adjL22L22 = Matmul(adjL22,L22) 
 adjL22L23 = Matmul(adjL22,L23) 
 adjL22T11 = Matmul(adjL22,T11) 
 adjL22T12 = Matmul(adjL22,T12) 
 adjL22T13 = Matmul(adjL22,T13) 
 adjL22T21 = Matmul(adjL22,T21) 
 adjL22T22 = Matmul(adjL22,T22) 
 adjL22T23 = Matmul(adjL22,T23) 
 adjL23L11 = Matmul(adjL23,L11) 
 adjL23L12 = Matmul(adjL23,L12) 
 adjL23L13 = Matmul(adjL23,L13) 
 adjL23L21 = Matmul(adjL23,L21) 
 adjL23L22 = Matmul(adjL23,L22) 
 adjL23L23 = Matmul(adjL23,L23) 
 adjL23T11 = Matmul(adjL23,T11) 
 adjL23T12 = Matmul(adjL23,T12) 
 adjL23T13 = Matmul(adjL23,T13) 
 adjL23T21 = Matmul(adjL23,T21) 
 adjL23T22 = Matmul(adjL23,T22) 
 adjL23T23 = Matmul(adjL23,T23) 
 adjTdTd = Matmul(adjTd,Td) 
 adjTeTe = Matmul(adjTe,Te) 
 adjTuTu = Matmul(adjTu,Tu) 
 adjT21T21 = Matmul(adjT21,T21) 
 adjT22T22 = Matmul(adjT22,T22) 
 adjT23T23 = Matmul(adjT23,T23) 
 Cml2L11 = Matmul(Conjg(ml2),L11) 
 Cml2L12 = Matmul(Conjg(ml2),L12) 
 Cml2L13 = Matmul(Conjg(ml2),L13) 
 Cml2L21 = Matmul(Conjg(ml2),L21) 
 Cml2L22 = Matmul(Conjg(ml2),L22) 
 Cml2L23 = Matmul(Conjg(ml2),L23) 
 Cmq2TpL21 = Matmul(Conjg(mq2),Transpose(L21)) 
 Cmq2TpL22 = Matmul(Conjg(mq2),Transpose(L22)) 
 Cmq2TpL23 = Matmul(Conjg(mq2),Transpose(L23)) 
 CYdTpL21 = Matmul(Conjg(Yd),Transpose(L21)) 
 CYdTpL22 = Matmul(Conjg(Yd),Transpose(L22)) 
 CYdTpL23 = Matmul(Conjg(Yd),Transpose(L23)) 
 CYdTpTd = Matmul(Conjg(Yd),Transpose(Td)) 
 CYdTpT21 = Matmul(Conjg(Yd),Transpose(T21)) 
 CYdTpT22 = Matmul(Conjg(Yd),Transpose(T22)) 
 CYdTpT23 = Matmul(Conjg(Yd),Transpose(T23)) 
 CYeL11 = Matmul(Conjg(Ye),L11) 
 CYeL12 = Matmul(Conjg(Ye),L12) 
 CYeL13 = Matmul(Conjg(Ye),L13) 
 CYeL21 = Matmul(Conjg(Ye),L21) 
 CYeL22 = Matmul(Conjg(Ye),L22) 
 CYeL23 = Matmul(Conjg(Ye),L23) 
 CYeTpTe = Matmul(Conjg(Ye),Transpose(Te)) 
 CYeT11 = Matmul(Conjg(Ye),T11) 
 CYeT12 = Matmul(Conjg(Ye),T12) 
 CYeT13 = Matmul(Conjg(Ye),T13) 
 CYeT21 = Matmul(Conjg(Ye),T21) 
 CYeT22 = Matmul(Conjg(Ye),T22) 
 CYeT23 = Matmul(Conjg(Ye),T23) 
 CL11L11 = Matmul(Conjg(L11),L11) 
 CL11L12 = Matmul(Conjg(L11),L12) 
 CL11L13 = Matmul(Conjg(L11),L13) 
 CL11L21 = Matmul(Conjg(L11),L21) 
 CL11L22 = Matmul(Conjg(L11),L22) 
 CL11L23 = Matmul(Conjg(L11),L23) 
 CL11TpYe = Matmul(Conjg(L11),Transpose(Ye)) 
 CL11TpTe = Matmul(Conjg(L11),Transpose(Te)) 
 CL11T11 = Matmul(Conjg(L11),T11) 
 CL11T12 = Matmul(Conjg(L11),T12) 
 CL11T13 = Matmul(Conjg(L11),T13) 
 CL11T21 = Matmul(Conjg(L11),T21) 
 CL11T22 = Matmul(Conjg(L11),T22) 
 CL11T23 = Matmul(Conjg(L11),T23) 
 CL12L11 = Matmul(Conjg(L12),L11) 
 CL12L12 = Matmul(Conjg(L12),L12) 
 CL12L13 = Matmul(Conjg(L12),L13) 
 CL12L21 = Matmul(Conjg(L12),L21) 
 CL12L22 = Matmul(Conjg(L12),L22) 
 CL12L23 = Matmul(Conjg(L12),L23) 
 CL12TpYe = Matmul(Conjg(L12),Transpose(Ye)) 
 CL12TpTe = Matmul(Conjg(L12),Transpose(Te)) 
 CL12T11 = Matmul(Conjg(L12),T11) 
 CL12T12 = Matmul(Conjg(L12),T12) 
 CL12T13 = Matmul(Conjg(L12),T13) 
 CL12T21 = Matmul(Conjg(L12),T21) 
 CL12T22 = Matmul(Conjg(L12),T22) 
 CL12T23 = Matmul(Conjg(L12),T23) 
 CL13L11 = Matmul(Conjg(L13),L11) 
 CL13L12 = Matmul(Conjg(L13),L12) 
 CL13L13 = Matmul(Conjg(L13),L13) 
 CL13L21 = Matmul(Conjg(L13),L21) 
 CL13L22 = Matmul(Conjg(L13),L22) 
 CL13L23 = Matmul(Conjg(L13),L23) 
 CL13TpYe = Matmul(Conjg(L13),Transpose(Ye)) 
 CL13TpTe = Matmul(Conjg(L13),Transpose(Te)) 
 CL13T11 = Matmul(Conjg(L13),T11) 
 CL13T12 = Matmul(Conjg(L13),T12) 
 CL13T13 = Matmul(Conjg(L13),T13) 
 CL13T21 = Matmul(Conjg(L13),T21) 
 CL13T22 = Matmul(Conjg(L13),T22) 
 CL13T23 = Matmul(Conjg(L13),T23) 
 CL21TpYd = Matmul(Conjg(L21),Transpose(Yd)) 
 CL21TpL21 = Matmul(Conjg(L21),Transpose(L21)) 
Forall(i2=1:3)  CL21TpL21(i2,i2) =  Real(CL21TpL21(i2,i2),dp) 
 CL21TpL22 = Matmul(Conjg(L21),Transpose(L22)) 
 CL21TpL23 = Matmul(Conjg(L21),Transpose(L23)) 
 CL21TpTd = Matmul(Conjg(L21),Transpose(Td)) 
 CL21TpT21 = Matmul(Conjg(L21),Transpose(T21)) 
 CL22TpYd = Matmul(Conjg(L22),Transpose(Yd)) 
 CL22TpL21 = Matmul(Conjg(L22),Transpose(L21)) 
 CL22TpL22 = Matmul(Conjg(L22),Transpose(L22)) 
Forall(i2=1:3)  CL22TpL22(i2,i2) =  Real(CL22TpL22(i2,i2),dp) 
 CL22TpL23 = Matmul(Conjg(L22),Transpose(L23)) 
 CL22TpTd = Matmul(Conjg(L22),Transpose(Td)) 
 CL22TpT22 = Matmul(Conjg(L22),Transpose(T22)) 
 CL23TpYd = Matmul(Conjg(L23),Transpose(Yd)) 
 CL23TpL21 = Matmul(Conjg(L23),Transpose(L21)) 
 CL23TpL22 = Matmul(Conjg(L23),Transpose(L22)) 
 CL23TpL23 = Matmul(Conjg(L23),Transpose(L23)) 
Forall(i2=1:3)  CL23TpL23(i2,i2) =  Real(CL23TpL23(i2,i2),dp) 
 CL23TpTd = Matmul(Conjg(L23),Transpose(Td)) 
 CL23TpT23 = Matmul(Conjg(L23),Transpose(T23)) 
 CTdTpTd = Matmul(Conjg(Td),Transpose(Td)) 
Forall(i2=1:3)  CTdTpTd(i2,i2) =  Real(CTdTpTd(i2,i2),dp) 
 CTeTpTe = Matmul(Conjg(Te),Transpose(Te)) 
Forall(i2=1:3)  CTeTpTe(i2,i2) =  Real(CTeTpTe(i2,i2),dp) 
 CTuTpTu = Matmul(Conjg(Tu),Transpose(Tu)) 
Forall(i2=1:3)  CTuTpTu(i2,i2) =  Real(CTuTpTu(i2,i2),dp) 
 CT11T11 = Matmul(Conjg(T11),T11) 
 CT11T12 = Matmul(Conjg(T11),T12) 
 CT11T13 = Matmul(Conjg(T11),T13) 
 CT12T11 = Matmul(Conjg(T12),T11) 
 CT12T12 = Matmul(Conjg(T12),T12) 
 CT12T13 = Matmul(Conjg(T12),T13) 
 CT13T11 = Matmul(Conjg(T13),T11) 
 CT13T12 = Matmul(Conjg(T13),T12) 
 CT13T13 = Matmul(Conjg(T13),T13) 
 CT21TpT21 = Matmul(Conjg(T21),Transpose(T21)) 
Forall(i2=1:3)  CT21TpT21(i2,i2) =  Real(CT21TpT21(i2,i2),dp) 
 CT21TpT22 = Matmul(Conjg(T21),Transpose(T22)) 
 CT21TpT23 = Matmul(Conjg(T21),Transpose(T23)) 
 CT22TpT21 = Matmul(Conjg(T22),Transpose(T21)) 
 CT22TpT22 = Matmul(Conjg(T22),Transpose(T22)) 
Forall(i2=1:3)  CT22TpT22(i2,i2) =  Real(CT22TpT22(i2,i2),dp) 
 CT22TpT23 = Matmul(Conjg(T22),Transpose(T23)) 
 CT23TpT21 = Matmul(Conjg(T23),Transpose(T21)) 
 CT23TpT22 = Matmul(Conjg(T23),Transpose(T22)) 
 CT23TpT23 = Matmul(Conjg(T23),Transpose(T23)) 
Forall(i2=1:3)  CT23TpT23(i2,i2) =  Real(CT23TpT23(i2,i2),dp) 
 L11ml2 = Matmul(L11,ml2) 
 L12ml2 = Matmul(L12,ml2) 
 L13ml2 = Matmul(L13,ml2) 
 L21mq2 = Matmul(L21,mq2) 
 L22mq2 = Matmul(L22,mq2) 
 L23mq2 = Matmul(L23,mq2) 
 TdadjTd = Matmul(Td,adjTd) 
 TeadjTe = Matmul(Te,adjTe) 
 TuadjTu = Matmul(Tu,adjTu) 
 TpL21ml2 = Matmul(Transpose(L21),ml2) 
 TpL22ml2 = Matmul(Transpose(L22),ml2) 
 TpL23ml2 = Matmul(Transpose(L23),ml2) 
 md2YdadjYd = Matmul(md2,YdadjYd) 
 me2YeadjYe = Matmul(me2,YeadjYe) 
 ml2adjYeYe = Matmul(ml2,adjYeYe) 
 ml2CL11L11 = Matmul(ml2,CL11L11) 
 ml2CL11L12 = Matmul(ml2,CL11L12) 
 ml2CL11L13 = Matmul(ml2,CL11L13) 
 ml2CL12L11 = Matmul(ml2,CL12L11) 
 ml2CL12L12 = Matmul(ml2,CL12L12) 
 ml2CL12L13 = Matmul(ml2,CL12L13) 
 ml2CL13L11 = Matmul(ml2,CL13L11) 
 ml2CL13L12 = Matmul(ml2,CL13L12) 
 ml2CL13L13 = Matmul(ml2,CL13L13) 
 ml2CL21TpL21 = Matmul(ml2,CL21TpL21) 
 ml2CL21TpL22 = Matmul(ml2,CL21TpL22) 
 ml2CL21TpL23 = Matmul(ml2,CL21TpL23) 
 ml2CL22TpL21 = Matmul(ml2,CL22TpL21) 
 ml2CL22TpL22 = Matmul(ml2,CL22TpL22) 
 ml2CL22TpL23 = Matmul(ml2,CL22TpL23) 
 ml2CL23TpL21 = Matmul(ml2,CL23TpL21) 
 ml2CL23TpL22 = Matmul(ml2,CL23TpL22) 
 ml2CL23TpL23 = Matmul(ml2,CL23TpL23) 
 mq2adjYdYd = Matmul(mq2,adjYdYd) 
 mq2adjYuYu = Matmul(mq2,adjYuYu) 
 mq2adjL21L21 = Matmul(mq2,adjL21L21) 
 mq2adjL21L22 = Matmul(mq2,adjL21L22) 
 mq2adjL21L23 = Matmul(mq2,adjL21L23) 
 mq2adjL22L21 = Matmul(mq2,adjL22L21) 
 mq2adjL22L22 = Matmul(mq2,adjL22L22) 
 mq2adjL22L23 = Matmul(mq2,adjL22L23) 
 mq2adjL23L21 = Matmul(mq2,adjL23L21) 
 mq2adjL23L22 = Matmul(mq2,adjL23L22) 
 mq2adjL23L23 = Matmul(mq2,adjL23L23) 
 mu2YuadjYu = Matmul(mu2,YuadjYu) 
 Ydmq2adjYd = Matmul(Yd,mq2adjYd) 
Forall(i2=1:3)  Ydmq2adjYd(i2,i2) =  Real(Ydmq2adjYd(i2,i2),dp) 
 YdadjYdmd2 = Matmul(Yd,adjYdmd2) 
 YdadjYdYd = Matmul(Yd,adjYdYd) 
 YdadjYdTd = Matmul(Yd,adjYdTd) 
 YdadjYuYu = Matmul(Yd,adjYuYu) 
 YdadjYuTu = Matmul(Yd,adjYuTu) 
 YdadjL21L21 = Matmul(Yd,adjL21L21) 
 YdadjL21L22 = Matmul(Yd,adjL21L22) 
 YdadjL21L23 = Matmul(Yd,adjL21L23) 
 YdadjL21T11 = Matmul(Yd,adjL21T11) 
 YdadjL21T12 = Matmul(Yd,adjL21T12) 
 YdadjL21T13 = Matmul(Yd,adjL21T13) 
 YdadjL21T21 = Matmul(Yd,adjL21T21) 
 YdadjL21T22 = Matmul(Yd,adjL21T22) 
 YdadjL21T23 = Matmul(Yd,adjL21T23) 
 YdadjL22L21 = Matmul(Yd,adjL22L21) 
 YdadjL22L22 = Matmul(Yd,adjL22L22) 
 YdadjL22L23 = Matmul(Yd,adjL22L23) 
 YdadjL22T11 = Matmul(Yd,adjL22T11) 
 YdadjL22T12 = Matmul(Yd,adjL22T12) 
 YdadjL22T13 = Matmul(Yd,adjL22T13) 
 YdadjL22T21 = Matmul(Yd,adjL22T21) 
 YdadjL22T22 = Matmul(Yd,adjL22T22) 
 YdadjL22T23 = Matmul(Yd,adjL22T23) 
 YdadjL23L21 = Matmul(Yd,adjL23L21) 
 YdadjL23L22 = Matmul(Yd,adjL23L22) 
 YdadjL23L23 = Matmul(Yd,adjL23L23) 
 YdadjL23T11 = Matmul(Yd,adjL23T11) 
 YdadjL23T12 = Matmul(Yd,adjL23T12) 
 YdadjL23T13 = Matmul(Yd,adjL23T13) 
 YdadjL23T21 = Matmul(Yd,adjL23T21) 
 YdadjL23T22 = Matmul(Yd,adjL23T22) 
 YdadjL23T23 = Matmul(Yd,adjL23T23) 
 Yeml2adjYe = Matmul(Ye,ml2adjYe) 
Forall(i2=1:3)  Yeml2adjYe(i2,i2) =  Real(Yeml2adjYe(i2,i2),dp) 
 YeadjYeme2 = Matmul(Ye,adjYeme2) 
 YeadjYeYe = Matmul(Ye,adjYeYe) 
 YeadjYeTe = Matmul(Ye,adjYeTe) 
 YeCL11L11 = Matmul(Ye,CL11L11) 
 YeCL11L21 = Matmul(Ye,CL11L21) 
 YeCL11L22 = Matmul(Ye,CL11L22) 
 YeCL11L23 = Matmul(Ye,CL11L23) 
 YeCL11T11 = Matmul(Ye,CL11T11) 
 YeCL11T12 = Matmul(Ye,CL11T12) 
 YeCL11T13 = Matmul(Ye,CL11T13) 
 YeCL11T21 = Matmul(Ye,CL11T21) 
 YeCL11T22 = Matmul(Ye,CL11T22) 
 YeCL11T23 = Matmul(Ye,CL11T23) 
 YeCL12L12 = Matmul(Ye,CL12L12) 
 YeCL12L21 = Matmul(Ye,CL12L21) 
 YeCL12L22 = Matmul(Ye,CL12L22) 
 YeCL12L23 = Matmul(Ye,CL12L23) 
 YeCL12T11 = Matmul(Ye,CL12T11) 
 YeCL12T12 = Matmul(Ye,CL12T12) 
 YeCL12T13 = Matmul(Ye,CL12T13) 
 YeCL12T21 = Matmul(Ye,CL12T21) 
 YeCL12T22 = Matmul(Ye,CL12T22) 
 YeCL12T23 = Matmul(Ye,CL12T23) 
 YeCL13L13 = Matmul(Ye,CL13L13) 
 YeCL13L21 = Matmul(Ye,CL13L21) 
 YeCL13L22 = Matmul(Ye,CL13L22) 
 YeCL13L23 = Matmul(Ye,CL13L23) 
 YeCL13T11 = Matmul(Ye,CL13T11) 
 YeCL13T12 = Matmul(Ye,CL13T12) 
 YeCL13T13 = Matmul(Ye,CL13T13) 
 YeCL13T21 = Matmul(Ye,CL13T21) 
 YeCL13T22 = Matmul(Ye,CL13T22) 
 YeCL13T23 = Matmul(Ye,CL13T23) 
 YeCL21TpL21 = Matmul(Ye,CL21TpL21) 
 YeCL21TpT21 = Matmul(Ye,CL21TpT21) 
 YeCL22TpL22 = Matmul(Ye,CL22TpL22) 
 YeCL22TpT22 = Matmul(Ye,CL22TpT22) 
 YeCL23TpL23 = Matmul(Ye,CL23TpL23) 
 YeCL23TpT23 = Matmul(Ye,CL23TpT23) 
 Yumq2adjYu = Matmul(Yu,mq2adjYu) 
Forall(i2=1:3)  Yumq2adjYu(i2,i2) =  Real(Yumq2adjYu(i2,i2),dp) 
 YuadjYdYd = Matmul(Yu,adjYdYd) 
 YuadjYdTd = Matmul(Yu,adjYdTd) 
 YuadjYumu2 = Matmul(Yu,adjYumu2) 
 YuadjYuYu = Matmul(Yu,adjYuYu) 
 YuadjYuTu = Matmul(Yu,adjYuTu) 
 YuadjL21L21 = Matmul(Yu,adjL21L21) 
 YuadjL21T21 = Matmul(Yu,adjL21T21) 
 YuadjL22L22 = Matmul(Yu,adjL22L22) 
 YuadjL22T22 = Matmul(Yu,adjL22T22) 
 YuadjL23L23 = Matmul(Yu,adjL23L23) 
 YuadjL23T23 = Matmul(Yu,adjL23T23) 
 adjYdmd2Yd = Matmul(adjYd,md2Yd) 
Forall(i2=1:3)  adjYdmd2Yd(i2,i2) =  Real(adjYdmd2Yd(i2,i2),dp) 
 adjYdYdmq2 = Matmul(adjYd,Ydmq2) 
 adjYeme2Ye = Matmul(adjYe,me2Ye) 
Forall(i2=1:3)  adjYeme2Ye(i2,i2) =  Real(adjYeme2Ye(i2,i2),dp) 
 adjYeYeml2 = Matmul(adjYe,Yeml2) 
 adjYumu2Yu = Matmul(adjYu,mu2Yu) 
Forall(i2=1:3)  adjYumu2Yu(i2,i2) =  Real(adjYumu2Yu(i2,i2),dp) 
 adjYuYumq2 = Matmul(adjYu,Yumq2) 
 adjL21Cml2L21 = Matmul(adjL21,Cml2L21) 
 adjL21L21mq2 = Matmul(adjL21,L21mq2) 
 adjL22Cml2L22 = Matmul(adjL22,Cml2L22) 
 adjL22L22mq2 = Matmul(adjL22,L22mq2) 
 adjL23Cml2L23 = Matmul(adjL23,Cml2L23) 
 adjL23L23mq2 = Matmul(adjL23,L23mq2) 
 CL11Cml2L11 = Matmul(Conjg(L11),Cml2L11) 
 CL11L11ml2 = Matmul(Conjg(L11),L11ml2) 
 CL12Cml2L12 = Matmul(Conjg(L12),Cml2L12) 
 CL12L12ml2 = Matmul(Conjg(L12),L12ml2) 
 CL13Cml2L13 = Matmul(Conjg(L13),Cml2L13) 
 CL13L13ml2 = Matmul(Conjg(L13),L13ml2) 
 CL21Cmq2TpL21 = Matmul(Conjg(L21),Cmq2TpL21) 
Forall(i2=1:3)  CL21Cmq2TpL21(i2,i2) =  Real(CL21Cmq2TpL21(i2,i2),dp) 
 CL21TpL21ml2 = Matmul(Conjg(L21),TpL21ml2) 
 CL22Cmq2TpL22 = Matmul(Conjg(L22),Cmq2TpL22) 
Forall(i2=1:3)  CL22Cmq2TpL22(i2,i2) =  Real(CL22Cmq2TpL22(i2,i2),dp) 
 CL22TpL22ml2 = Matmul(Conjg(L22),TpL22ml2) 
 CL23Cmq2TpL23 = Matmul(Conjg(L23),Cmq2TpL23) 
Forall(i2=1:3)  CL23Cmq2TpL23(i2,i2) =  Real(CL23Cmq2TpL23(i2,i2),dp) 
 CL23TpL23ml2 = Matmul(Conjg(L23),TpL23ml2) 
 L11adjYeYe = Matmul(L11,adjYeYe) 
 L11adjYeTe = Matmul(L11,adjYeTe) 
 L11CL11L11 = Matmul(L11,CL11L11) 
 L11CL11L12 = Matmul(L11,CL11L12) 
 L11CL11L13 = Matmul(L11,CL11L13) 
 L11CL11L21 = Matmul(L11,CL11L21) 
 L11CL11L22 = Matmul(L11,CL11L22) 
 L11CL11L23 = Matmul(L11,CL11L23) 
 L11CL11TpYe = Matmul(L11,CL11TpYe) 
 L11CL11TpTe = Matmul(L11,CL11TpTe) 
 L11CL11T11 = Matmul(L11,CL11T11) 
 L11CL11T12 = Matmul(L11,CL11T12) 
 L11CL11T13 = Matmul(L11,CL11T13) 
 L11CL11T21 = Matmul(L11,CL11T21) 
 L11CL11T22 = Matmul(L11,CL11T22) 
 L11CL11T23 = Matmul(L11,CL11T23) 
 L11CL12L12 = Matmul(L11,CL12L12) 
 L11CL12TpYe = Matmul(L11,CL12TpYe) 
 L11CL12TpTe = Matmul(L11,CL12TpTe) 
 L11CL12T12 = Matmul(L11,CL12T12) 
 L11CL13L13 = Matmul(L11,CL13L13) 
 L11CL13TpYe = Matmul(L11,CL13TpYe) 
 L11CL13TpTe = Matmul(L11,CL13TpTe) 
 L11CL13T13 = Matmul(L11,CL13T13) 
 L11CL21TpYd = Matmul(L11,CL21TpYd) 
 L11CL21TpL21 = Matmul(L11,CL21TpL21) 
 L11CL21TpTd = Matmul(L11,CL21TpTd) 
 L11CL21TpT21 = Matmul(L11,CL21TpT21) 
 L11CL22TpYd = Matmul(L11,CL22TpYd) 
 L11CL22TpL22 = Matmul(L11,CL22TpL22) 
 L11CL22TpTd = Matmul(L11,CL22TpTd) 
 L11CL22TpT22 = Matmul(L11,CL22TpT22) 
 L11CL23TpYd = Matmul(L11,CL23TpYd) 
 L11CL23TpL23 = Matmul(L11,CL23TpL23) 
 L11CL23TpTd = Matmul(L11,CL23TpTd) 
 L11CL23TpT23 = Matmul(L11,CL23TpT23) 
 L12adjYeYe = Matmul(L12,adjYeYe) 
 L12adjYeTe = Matmul(L12,adjYeTe) 
 L12CL11L11 = Matmul(L12,CL11L11) 
 L12CL11TpYe = Matmul(L12,CL11TpYe) 
 L12CL11TpTe = Matmul(L12,CL11TpTe) 
 L12CL11T11 = Matmul(L12,CL11T11) 
 L12CL12L11 = Matmul(L12,CL12L11) 
 L12CL12L12 = Matmul(L12,CL12L12) 
 L12CL12L13 = Matmul(L12,CL12L13) 
 L12CL12L21 = Matmul(L12,CL12L21) 
 L12CL12L22 = Matmul(L12,CL12L22) 
 L12CL12L23 = Matmul(L12,CL12L23) 
 L12CL12TpYe = Matmul(L12,CL12TpYe) 
 L12CL12TpTe = Matmul(L12,CL12TpTe) 
 L12CL12T11 = Matmul(L12,CL12T11) 
 L12CL12T12 = Matmul(L12,CL12T12) 
 L12CL12T13 = Matmul(L12,CL12T13) 
 L12CL12T21 = Matmul(L12,CL12T21) 
 L12CL12T22 = Matmul(L12,CL12T22) 
 L12CL12T23 = Matmul(L12,CL12T23) 
 L12CL13L13 = Matmul(L12,CL13L13) 
 L12CL13TpYe = Matmul(L12,CL13TpYe) 
 L12CL13TpTe = Matmul(L12,CL13TpTe) 
 L12CL13T13 = Matmul(L12,CL13T13) 
 L12CL21TpYd = Matmul(L12,CL21TpYd) 
 L12CL21TpL21 = Matmul(L12,CL21TpL21) 
 L12CL21TpTd = Matmul(L12,CL21TpTd) 
 L12CL21TpT21 = Matmul(L12,CL21TpT21) 
 L12CL22TpYd = Matmul(L12,CL22TpYd) 
 L12CL22TpL22 = Matmul(L12,CL22TpL22) 
 L12CL22TpTd = Matmul(L12,CL22TpTd) 
 L12CL22TpT22 = Matmul(L12,CL22TpT22) 
 L12CL23TpYd = Matmul(L12,CL23TpYd) 
 L12CL23TpL23 = Matmul(L12,CL23TpL23) 
 L12CL23TpTd = Matmul(L12,CL23TpTd) 
 L12CL23TpT23 = Matmul(L12,CL23TpT23) 
 L13adjYeYe = Matmul(L13,adjYeYe) 
 L13adjYeTe = Matmul(L13,adjYeTe) 
 L13CL11L11 = Matmul(L13,CL11L11) 
 L13CL11TpYe = Matmul(L13,CL11TpYe) 
 L13CL11TpTe = Matmul(L13,CL11TpTe) 
 L13CL11T11 = Matmul(L13,CL11T11) 
 L13CL12L12 = Matmul(L13,CL12L12) 
 L13CL12TpYe = Matmul(L13,CL12TpYe) 
 L13CL12TpTe = Matmul(L13,CL12TpTe) 
 L13CL12T12 = Matmul(L13,CL12T12) 
 L13CL13L11 = Matmul(L13,CL13L11) 
 L13CL13L12 = Matmul(L13,CL13L12) 
 L13CL13L13 = Matmul(L13,CL13L13) 
 L13CL13L21 = Matmul(L13,CL13L21) 
 L13CL13L22 = Matmul(L13,CL13L22) 
 L13CL13L23 = Matmul(L13,CL13L23) 
 L13CL13TpYe = Matmul(L13,CL13TpYe) 
 L13CL13TpTe = Matmul(L13,CL13TpTe) 
 L13CL13T11 = Matmul(L13,CL13T11) 
 L13CL13T12 = Matmul(L13,CL13T12) 
 L13CL13T13 = Matmul(L13,CL13T13) 
 L13CL13T21 = Matmul(L13,CL13T21) 
 L13CL13T22 = Matmul(L13,CL13T22) 
 L13CL13T23 = Matmul(L13,CL13T23) 
 L13CL21TpYd = Matmul(L13,CL21TpYd) 
 L13CL21TpL21 = Matmul(L13,CL21TpL21) 
 L13CL21TpTd = Matmul(L13,CL21TpTd) 
 L13CL21TpT21 = Matmul(L13,CL21TpT21) 
 L13CL22TpYd = Matmul(L13,CL22TpYd) 
 L13CL22TpL22 = Matmul(L13,CL22TpL22) 
 L13CL22TpTd = Matmul(L13,CL22TpTd) 
 L13CL22TpT22 = Matmul(L13,CL22TpT22) 
 L13CL23TpYd = Matmul(L13,CL23TpYd) 
 L13CL23TpL23 = Matmul(L13,CL23TpL23) 
 L13CL23TpTd = Matmul(L13,CL23TpTd) 
 L13CL23TpT23 = Matmul(L13,CL23TpT23) 
 L21adjYdYd = Matmul(L21,adjYdYd) 
 L21adjYdTd = Matmul(L21,adjYdTd) 
 L21adjYuYu = Matmul(L21,adjYuYu) 
 L21adjYuTu = Matmul(L21,adjYuTu) 
 L21adjL21L11 = Matmul(L21,adjL21L11) 
 L21adjL21L12 = Matmul(L21,adjL21L12) 
 L21adjL21L13 = Matmul(L21,adjL21L13) 
 L21adjL21L21 = Matmul(L21,adjL21L21) 
 L21adjL21L22 = Matmul(L21,adjL21L22) 
 L21adjL21L23 = Matmul(L21,adjL21L23) 
 L21adjL21T11 = Matmul(L21,adjL21T11) 
 L21adjL21T12 = Matmul(L21,adjL21T12) 
 L21adjL21T13 = Matmul(L21,adjL21T13) 
 L21adjL21T21 = Matmul(L21,adjL21T21) 
 L21adjL21T22 = Matmul(L21,adjL21T22) 
 L21adjL21T23 = Matmul(L21,adjL21T23) 
 L21adjL22L22 = Matmul(L21,adjL22L22) 
 L21adjL22T22 = Matmul(L21,adjL22T22) 
 L21adjL23L23 = Matmul(L21,adjL23L23) 
 L21adjL23T23 = Matmul(L21,adjL23T23) 
 L22adjYdYd = Matmul(L22,adjYdYd) 
 L22adjYdTd = Matmul(L22,adjYdTd) 
 L22adjYuYu = Matmul(L22,adjYuYu) 
 L22adjYuTu = Matmul(L22,adjYuTu) 
 L22adjL21L21 = Matmul(L22,adjL21L21) 
 L22adjL21T21 = Matmul(L22,adjL21T21) 
 L22adjL22L11 = Matmul(L22,adjL22L11) 
 L22adjL22L12 = Matmul(L22,adjL22L12) 
 L22adjL22L13 = Matmul(L22,adjL22L13) 
 L22adjL22L21 = Matmul(L22,adjL22L21) 
 L22adjL22L22 = Matmul(L22,adjL22L22) 
 L22adjL22L23 = Matmul(L22,adjL22L23) 
 L22adjL22T11 = Matmul(L22,adjL22T11) 
 L22adjL22T12 = Matmul(L22,adjL22T12) 
 L22adjL22T13 = Matmul(L22,adjL22T13) 
 L22adjL22T21 = Matmul(L22,adjL22T21) 
 L22adjL22T22 = Matmul(L22,adjL22T22) 
 L22adjL22T23 = Matmul(L22,adjL22T23) 
 L22adjL23L23 = Matmul(L22,adjL23L23) 
 L22adjL23T23 = Matmul(L22,adjL23T23) 
 L23adjYdYd = Matmul(L23,adjYdYd) 
 L23adjYdTd = Matmul(L23,adjYdTd) 
 L23adjYuYu = Matmul(L23,adjYuYu) 
 L23adjYuTu = Matmul(L23,adjYuTu) 
 L23adjL21L21 = Matmul(L23,adjL21L21) 
 L23adjL21T21 = Matmul(L23,adjL21T21) 
 L23adjL22L22 = Matmul(L23,adjL22L22) 
 L23adjL22T22 = Matmul(L23,adjL22T22) 
 L23adjL23L11 = Matmul(L23,adjL23L11) 
 L23adjL23L12 = Matmul(L23,adjL23L12) 
 L23adjL23L13 = Matmul(L23,adjL23L13) 
 L23adjL23L21 = Matmul(L23,adjL23L21) 
 L23adjL23L22 = Matmul(L23,adjL23L22) 
 L23adjL23L23 = Matmul(L23,adjL23L23) 
 L23adjL23T11 = Matmul(L23,adjL23T11) 
 L23adjL23T12 = Matmul(L23,adjL23T12) 
 L23adjL23T13 = Matmul(L23,adjL23T13) 
 L23adjL23T21 = Matmul(L23,adjL23T21) 
 L23adjL23T22 = Matmul(L23,adjL23T22) 
 L23adjL23T23 = Matmul(L23,adjL23T23) 
 TdadjYdYd = Matmul(Td,adjYdYd) 
 TdadjYuYu = Matmul(Td,adjYuYu) 
 TdadjL21L21 = Matmul(Td,adjL21L21) 
 TdadjL22L22 = Matmul(Td,adjL22L22) 
 TdadjL23L23 = Matmul(Td,adjL23L23) 
 TeadjYeYe = Matmul(Te,adjYeYe) 
 TeCL11L11 = Matmul(Te,CL11L11) 
 TeCL12L12 = Matmul(Te,CL12L12) 
 TeCL13L13 = Matmul(Te,CL13L13) 
 TeCL21TpL21 = Matmul(Te,CL21TpL21) 
 TeCL22TpL22 = Matmul(Te,CL22TpL22) 
 TeCL23TpL23 = Matmul(Te,CL23TpL23) 
 TuadjYdYd = Matmul(Tu,adjYdYd) 
 TuadjYuYu = Matmul(Tu,adjYuYu) 
 TuadjL21L21 = Matmul(Tu,adjL21L21) 
 TuadjL22L22 = Matmul(Tu,adjL22L22) 
 TuadjL23L23 = Matmul(Tu,adjL23L23) 
 TpYeCYeL11 = Matmul(Transpose(Ye),CYeL11) 
 TpYeCYeL12 = Matmul(Transpose(Ye),CYeL12) 
 TpYeCYeL13 = Matmul(Transpose(Ye),CYeL13) 
 TpYeCYeL21 = Matmul(Transpose(Ye),CYeL21) 
 TpYeCYeL22 = Matmul(Transpose(Ye),CYeL22) 
 TpYeCYeL23 = Matmul(Transpose(Ye),CYeL23) 
 TpYeCYeT11 = Matmul(Transpose(Ye),CYeT11) 
 TpYeCYeT12 = Matmul(Transpose(Ye),CYeT12) 
 TpYeCYeT13 = Matmul(Transpose(Ye),CYeT13) 
 TpYeCYeT21 = Matmul(Transpose(Ye),CYeT21) 
 TpYeCYeT22 = Matmul(Transpose(Ye),CYeT22) 
 TpYeCYeT23 = Matmul(Transpose(Ye),CYeT23) 
 TpL21CL11TpTe = Matmul(Transpose(L21),CL11TpTe) 
 TpL21CL12TpTe = Matmul(Transpose(L21),CL12TpTe) 
 TpL21CL13TpTe = Matmul(Transpose(L21),CL13TpTe) 
 TpL21CL21TpTd = Matmul(Transpose(L21),CL21TpTd) 
 TpL21CL22TpTd = Matmul(Transpose(L21),CL22TpTd) 
 TpL21CL23TpTd = Matmul(Transpose(L21),CL23TpTd) 
 TpL22CL11TpTe = Matmul(Transpose(L22),CL11TpTe) 
 TpL22CL12TpTe = Matmul(Transpose(L22),CL12TpTe) 
 TpL22CL13TpTe = Matmul(Transpose(L22),CL13TpTe) 
 TpL22CL21TpTd = Matmul(Transpose(L22),CL21TpTd) 
 TpL22CL22TpTd = Matmul(Transpose(L22),CL22TpTd) 
 TpL22CL23TpTd = Matmul(Transpose(L22),CL23TpTd) 
 TpL23CL11TpTe = Matmul(Transpose(L23),CL11TpTe) 
 TpL23CL12TpTe = Matmul(Transpose(L23),CL12TpTe) 
 TpL23CL13TpTe = Matmul(Transpose(L23),CL13TpTe) 
 TpL23CL21TpTd = Matmul(Transpose(L23),CL21TpTd) 
 TpL23CL22TpTd = Matmul(Transpose(L23),CL22TpTd) 
 TpL23CL23TpTd = Matmul(Transpose(L23),CL23TpTd) 
 TpTeCYeL11 = Matmul(Transpose(Te),CYeL11) 
 TpTeCYeL12 = Matmul(Transpose(Te),CYeL12) 
 TpTeCYeL13 = Matmul(Transpose(Te),CYeL13) 
 TpTeCYeL21 = Matmul(Transpose(Te),CYeL21) 
 TpTeCYeL22 = Matmul(Transpose(Te),CYeL22) 
 TpTeCYeL23 = Matmul(Transpose(Te),CYeL23) 
 T11adjYeYe = Matmul(T11,adjYeYe) 
 T11CL11L11 = Matmul(T11,CL11L11) 
 T11CL11L12 = Matmul(T11,CL11L12) 
 T11CL11L13 = Matmul(T11,CL11L13) 
 T11CL11L21 = Matmul(T11,CL11L21) 
 T11CL11L22 = Matmul(T11,CL11L22) 
 T11CL11L23 = Matmul(T11,CL11L23) 
 T11CL12L12 = Matmul(T11,CL12L12) 
 T11CL13L13 = Matmul(T11,CL13L13) 
 T11CL21TpL21 = Matmul(T11,CL21TpL21) 
 T11CL22TpL22 = Matmul(T11,CL22TpL22) 
 T11CL23TpL23 = Matmul(T11,CL23TpL23) 
 T12adjYeYe = Matmul(T12,adjYeYe) 
 T12CL11L11 = Matmul(T12,CL11L11) 
 T12CL12L11 = Matmul(T12,CL12L11) 
 T12CL12L12 = Matmul(T12,CL12L12) 
 T12CL12L13 = Matmul(T12,CL12L13) 
 T12CL12L21 = Matmul(T12,CL12L21) 
 T12CL12L22 = Matmul(T12,CL12L22) 
 T12CL12L23 = Matmul(T12,CL12L23) 
 T12CL13L13 = Matmul(T12,CL13L13) 
 T12CL21TpL21 = Matmul(T12,CL21TpL21) 
 T12CL22TpL22 = Matmul(T12,CL22TpL22) 
 T12CL23TpL23 = Matmul(T12,CL23TpL23) 
 T13adjYeYe = Matmul(T13,adjYeYe) 
 T13CL11L11 = Matmul(T13,CL11L11) 
 T13CL12L12 = Matmul(T13,CL12L12) 
 T13CL13L11 = Matmul(T13,CL13L11) 
 T13CL13L12 = Matmul(T13,CL13L12) 
 T13CL13L13 = Matmul(T13,CL13L13) 
 T13CL13L21 = Matmul(T13,CL13L21) 
 T13CL13L22 = Matmul(T13,CL13L22) 
 T13CL13L23 = Matmul(T13,CL13L23) 
 T13CL21TpL21 = Matmul(T13,CL21TpL21) 
 T13CL22TpL22 = Matmul(T13,CL22TpL22) 
 T13CL23TpL23 = Matmul(T13,CL23TpL23) 
 T21adjYdYd = Matmul(T21,adjYdYd) 
 T21adjYuYu = Matmul(T21,adjYuYu) 
 T21adjL21L11 = Matmul(T21,adjL21L11) 
 T21adjL21L12 = Matmul(T21,adjL21L12) 
 T21adjL21L13 = Matmul(T21,adjL21L13) 
 T21adjL21L21 = Matmul(T21,adjL21L21) 
 T21adjL21L22 = Matmul(T21,adjL21L22) 
 T21adjL21L23 = Matmul(T21,adjL21L23) 
 T21adjL22L22 = Matmul(T21,adjL22L22) 
 T21adjL23L23 = Matmul(T21,adjL23L23) 
 T22adjYdYd = Matmul(T22,adjYdYd) 
 T22adjYuYu = Matmul(T22,adjYuYu) 
 T22adjL21L21 = Matmul(T22,adjL21L21) 
 T22adjL22L11 = Matmul(T22,adjL22L11) 
 T22adjL22L12 = Matmul(T22,adjL22L12) 
 T22adjL22L13 = Matmul(T22,adjL22L13) 
 T22adjL22L21 = Matmul(T22,adjL22L21) 
 T22adjL22L22 = Matmul(T22,adjL22L22) 
 T22adjL22L23 = Matmul(T22,adjL22L23) 
 T22adjL23L23 = Matmul(T22,adjL23L23) 
 T23adjYdYd = Matmul(T23,adjYdYd) 
 T23adjYuYu = Matmul(T23,adjYuYu) 
 T23adjL21L21 = Matmul(T23,adjL21L21) 
 T23adjL22L22 = Matmul(T23,adjL22L22) 
 T23adjL23L11 = Matmul(T23,adjL23L11) 
 T23adjL23L12 = Matmul(T23,adjL23L12) 
 T23adjL23L13 = Matmul(T23,adjL23L13) 
 T23adjL23L21 = Matmul(T23,adjL23L21) 
 T23adjL23L22 = Matmul(T23,adjL23L22) 
 T23adjL23L23 = Matmul(T23,adjL23L23) 
 Trmd2 = Real(cTrace(md2),dp) 
 Trme2 = Real(cTrace(me2),dp) 
 Trml2 = Real(cTrace(ml2),dp) 
 Trmq2 = Real(cTrace(mq2),dp) 
 Trmu2 = Real(cTrace(mu2),dp) 
 TrYdadjYd = Real(cTrace(YdadjYd),dp) 
 TrYeadjYe = Real(cTrace(YeadjYe),dp) 
 TrYuadjYu = Real(cTrace(YuadjYu),dp) 
 TradjYdTd = cTrace(adjYdTd) 
 TradjYeTe = cTrace(adjYeTe) 
 TradjYuTu = cTrace(adjYuTu) 
 TradjL21T21 = cTrace(adjL21T21) 
 TradjL21T22 = cTrace(adjL21T22) 
 TradjL21T23 = cTrace(adjL21T23) 
 TradjL22T21 = cTrace(adjL22T21) 
 TradjL22T22 = cTrace(adjL22T22) 
 TradjL22T23 = cTrace(adjL22T23) 
 TradjL23T21 = cTrace(adjL23T21) 
 TradjL23T22 = cTrace(adjL23T22) 
 TradjL23T23 = cTrace(adjL23T23) 
 TrCL11L11 = cTrace(CL11L11) 
 TrCL11L12 = cTrace(CL11L12) 
 TrCL11L13 = cTrace(CL11L13) 
 TrCL11T11 = cTrace(CL11T11) 
 TrCL11T12 = cTrace(CL11T12) 
 TrCL11T13 = cTrace(CL11T13) 
 TrCL12L11 = cTrace(CL12L11) 
 TrCL12L12 = cTrace(CL12L12) 
 TrCL12L13 = cTrace(CL12L13) 
 TrCL12T11 = cTrace(CL12T11) 
 TrCL12T12 = cTrace(CL12T12) 
 TrCL12T13 = cTrace(CL12T13) 
 TrCL13L11 = cTrace(CL13L11) 
 TrCL13L12 = cTrace(CL13L12) 
 TrCL13L13 = cTrace(CL13L13) 
 TrCL13T11 = cTrace(CL13T11) 
 TrCL13T12 = cTrace(CL13T12) 
 TrCL13T13 = cTrace(CL13T13) 
 TrCL21TpL21 = Real(cTrace(CL21TpL21),dp) 
 TrCL21TpL22 = cTrace(CL21TpL22) 
 TrCL21TpL23 = cTrace(CL21TpL23) 
 TrCL22TpL21 = cTrace(CL22TpL21) 
 TrCL22TpL22 = Real(cTrace(CL22TpL22),dp) 
 TrCL22TpL23 = cTrace(CL22TpL23) 
 TrCL23TpL21 = cTrace(CL23TpL21) 
 TrCL23TpL22 = cTrace(CL23TpL22) 
 TrCL23TpL23 = Real(cTrace(CL23TpL23),dp) 
 TrCTdTpTd = Real(cTrace(CTdTpTd),dp) 
 TrCTeTpTe = Real(cTrace(CTeTpTe),dp) 
 TrCTuTpTu = Real(cTrace(CTuTpTu),dp) 
 TrCT11T11 = cTrace(CT11T11) 
 TrCT11T12 = cTrace(CT11T12) 
 TrCT11T13 = cTrace(CT11T13) 
 TrCT12T11 = cTrace(CT12T11) 
 TrCT12T12 = cTrace(CT12T12) 
 TrCT12T13 = cTrace(CT12T13) 
 TrCT13T11 = cTrace(CT13T11) 
 TrCT13T12 = cTrace(CT13T12) 
 TrCT13T13 = cTrace(CT13T13) 
 TrCT21TpT21 = Real(cTrace(CT21TpT21),dp) 
 TrCT21TpT22 = cTrace(CT21TpT22) 
 TrCT21TpT23 = cTrace(CT21TpT23) 
 TrCT22TpT21 = cTrace(CT22TpT21) 
 TrCT22TpT22 = Real(cTrace(CT22TpT22),dp) 
 TrCT22TpT23 = cTrace(CT22TpT23) 
 TrCT23TpT21 = cTrace(CT23TpT21) 
 TrCT23TpT22 = cTrace(CT23TpT22) 
 TrCT23TpT23 = Real(cTrace(CT23TpT23),dp) 
 Trmd2YdadjYd = cTrace(md2YdadjYd) 
 Trme2YeadjYe = cTrace(me2YeadjYe) 
 Trml2adjYeYe = cTrace(ml2adjYeYe) 
 Trml2CL11L11 = cTrace(ml2CL11L11) 
 Trml2CL11L12 = cTrace(ml2CL11L12) 
 Trml2CL11L13 = cTrace(ml2CL11L13) 
 Trml2CL12L11 = cTrace(ml2CL12L11) 
 Trml2CL12L12 = cTrace(ml2CL12L12) 
 Trml2CL12L13 = cTrace(ml2CL12L13) 
 Trml2CL13L11 = cTrace(ml2CL13L11) 
 Trml2CL13L12 = cTrace(ml2CL13L12) 
 Trml2CL13L13 = cTrace(ml2CL13L13) 
 Trml2CL21TpL21 = cTrace(ml2CL21TpL21) 
 Trml2CL21TpL22 = cTrace(ml2CL21TpL22) 
 Trml2CL21TpL23 = cTrace(ml2CL21TpL23) 
 Trml2CL22TpL21 = cTrace(ml2CL22TpL21) 
 Trml2CL22TpL22 = cTrace(ml2CL22TpL22) 
 Trml2CL22TpL23 = cTrace(ml2CL22TpL23) 
 Trml2CL23TpL21 = cTrace(ml2CL23TpL21) 
 Trml2CL23TpL22 = cTrace(ml2CL23TpL22) 
 Trml2CL23TpL23 = cTrace(ml2CL23TpL23) 
 Trmq2adjYdYd = cTrace(mq2adjYdYd) 
 Trmq2adjYuYu = cTrace(mq2adjYuYu) 
 Trmq2adjL21L21 = cTrace(mq2adjL21L21) 
 Trmq2adjL21L22 = cTrace(mq2adjL21L22) 
 Trmq2adjL21L23 = cTrace(mq2adjL21L23) 
 Trmq2adjL22L21 = cTrace(mq2adjL22L21) 
 Trmq2adjL22L22 = cTrace(mq2adjL22L22) 
 Trmq2adjL22L23 = cTrace(mq2adjL22L23) 
 Trmq2adjL23L21 = cTrace(mq2adjL23L21) 
 Trmq2adjL23L22 = cTrace(mq2adjL23L22) 
 Trmq2adjL23L23 = cTrace(mq2adjL23L23) 
 Trmu2YuadjYu = cTrace(mu2YuadjYu) 
 sqrt3ov5 =Sqrt(3._dp/5._dp) 
 ooSqrt15 =1._dp/sqrt(15._dp) 
 g1p2 =g1**2 
 g1p3 =g1**3 
 g2p2 =g2**2 
 g2p3 =g2**3 
 g3p2 =g3**2 
 g3p3 =g3**3 
 g1p4 =g1**4 
 g1p5 =g1**5 
 g2p4 =g2**4 
 g2p5 =g2**5 
 g3p4 =g3**4 
 g3p5 =g3**5 
 Xip2 =Xi**2 


If (TwoLoopRGE) Then 
 YdadjYu = Matmul(Yd,adjYu) 
 YdadjTd = Matmul(Yd,adjTd) 
 YdadjTu = Matmul(Yd,adjTu) 
 YeadjTe = Matmul(Ye,adjTe) 
 YuadjYd = Matmul(Yu,adjYd) 
 YuadjTd = Matmul(Yu,adjTd) 
 YuadjTu = Matmul(Yu,adjTu) 
 adjYdCmd2 = Matmul(adjYd,Conjg(md2)) 
 adjYeCme2 = Matmul(adjYe,Conjg(me2)) 
 adjYuCmu2 = Matmul(adjYu,Conjg(mu2)) 
 adjTdYd = Matmul(adjTd,Yd) 
 adjTeYe = Matmul(adjTe,Ye) 
 adjTuYu = Matmul(adjTu,Yu) 
 Cml2adjYe = Matmul(Conjg(ml2),adjYe) 
 Cmq2adjYd = Matmul(Conjg(mq2),adjYd) 
 Cmq2adjYu = Matmul(Conjg(mq2),adjYu) 
 CTdTpYd = Matmul(Conjg(Td),Transpose(Yd)) 
 CTeTpYe = Matmul(Conjg(Te),Transpose(Ye)) 
 CTuTpYu = Matmul(Conjg(Tu),Transpose(Yu)) 
 L11CL11 = Matmul(L11,Conjg(L11)) 
 L12CL12 = Matmul(L12,Conjg(L12)) 
 L13CL13 = Matmul(L13,Conjg(L13)) 
 L21adjL21 = Matmul(L21,adjL21) 
 L22adjL22 = Matmul(L22,adjL22) 
 L23adjL23 = Matmul(L23,adjL23) 
 TdadjYd = Matmul(Td,adjYd) 
 TdadjYu = Matmul(Td,adjYu) 
 TdadjTu = Matmul(Td,adjTu) 
 TeadjYe = Matmul(Te,adjYe) 
 TuadjYd = Matmul(Tu,adjYd) 
 TuadjYu = Matmul(Tu,adjYu) 
 TuadjTd = Matmul(Tu,adjTd) 
 TpL21CL21 = Matmul(Transpose(L21),Conjg(L21)) 
Forall(i2=1:3)  TpL21CL21(i2,i2) =  Real(TpL21CL21(i2,i2),dp) 
 TpL22CL22 = Matmul(Transpose(L22),Conjg(L22)) 
Forall(i2=1:3)  TpL22CL22(i2,i2) =  Real(TpL22CL22(i2,i2),dp) 
 TpL23CL23 = Matmul(Transpose(L23),Conjg(L23)) 
Forall(i2=1:3)  TpL23CL23(i2,i2) =  Real(TpL23CL23(i2,i2),dp) 
 md2YdadjYu = Matmul(md2,YdadjYu) 
 ml2L11CL11 = Matmul(ml2,L11CL11) 
 ml2L12CL12 = Matmul(ml2,L12CL12) 
 ml2L13CL13 = Matmul(ml2,L13CL13) 
 ml2L21adjL21 = Matmul(ml2,L21adjL21) 
 ml2L22adjL22 = Matmul(ml2,L22adjL22) 
 ml2L23adjL23 = Matmul(ml2,L23adjL23) 
 mq2TpL21CL21 = Matmul(mq2,TpL21CL21) 
 mq2TpL22CL22 = Matmul(mq2,TpL22CL22) 
 mq2TpL23CL23 = Matmul(mq2,TpL23CL23) 
 mu2YuadjYd = Matmul(mu2,YuadjYd) 
 Ydmq2adjYu = Matmul(Yd,mq2adjYu) 
 YdadjYdCmd2 = Matmul(Yd,adjYdCmd2) 
 YdadjYumu2 = Matmul(Yd,adjYumu2) 
 YdadjTdTd = Matmul(Yd,adjTdTd) 
 YdCmq2adjYd = Matmul(Yd,Cmq2adjYd) 
Forall(i2=1:3)  YdCmq2adjYd(i2,i2) =  Real(YdCmq2adjYd(i2,i2),dp) 
 YeadjYeCme2 = Matmul(Ye,adjYeCme2) 
 YeadjTeTe = Matmul(Ye,adjTeTe) 
 YeCml2adjYe = Matmul(Ye,Cml2adjYe) 
Forall(i2=1:3)  YeCml2adjYe(i2,i2) =  Real(YeCml2adjYe(i2,i2),dp) 
 Yumq2adjYd = Matmul(Yu,mq2adjYd) 
 YuadjYdmd2 = Matmul(Yu,adjYdmd2) 
 YuadjYuCmu2 = Matmul(Yu,adjYuCmu2) 
 YuadjTuTu = Matmul(Yu,adjTuTu) 
 YuCmq2adjYu = Matmul(Yu,Cmq2adjYu) 
Forall(i2=1:3)  YuCmq2adjYu(i2,i2) =  Real(YuCmq2adjYu(i2,i2),dp) 
 adjYdYdadjYd = Matmul(adjYd,YdadjYd) 
 adjYdYdadjYu = Matmul(adjYd,YdadjYu) 
 adjYdYdadjTd = Matmul(adjYd,YdadjTd) 
 adjYdYdadjTu = Matmul(adjYd,YdadjTu) 
 adjYdTdadjYd = Matmul(adjYd,TdadjYd) 
 adjYdTdadjYu = Matmul(adjYd,TdadjYu) 
 adjYdTdadjTd = Matmul(adjYd,TdadjTd) 
 adjYdTdadjTu = Matmul(adjYd,TdadjTu) 
 adjYeYeadjYe = Matmul(adjYe,YeadjYe) 
 adjYeYeadjTe = Matmul(adjYe,YeadjTe) 
 adjYeTeadjYe = Matmul(adjYe,TeadjYe) 
 adjYeTeadjTe = Matmul(adjYe,TeadjTe) 
 adjYuYuadjYd = Matmul(adjYu,YuadjYd) 
 adjYuYuadjYu = Matmul(adjYu,YuadjYu) 
 adjYuYuadjTd = Matmul(adjYu,YuadjTd) 
 adjYuYuadjTu = Matmul(adjYu,YuadjTu) 
 adjYuTuadjYd = Matmul(adjYu,TuadjYd) 
 adjYuTuadjYu = Matmul(adjYu,TuadjYu) 
 adjYuTuadjTd = Matmul(adjYu,TuadjTd) 
 adjYuTuadjTu = Matmul(adjYu,TuadjTu) 
 adjTdYdadjYd = Matmul(adjTd,YdadjYd) 
 adjTdYdadjYu = Matmul(adjTd,YdadjYu) 
 adjTdTdadjYd = Matmul(adjTd,TdadjYd) 
 adjTdTdadjYu = Matmul(adjTd,TdadjYu) 
 adjTeYeadjYe = Matmul(adjTe,YeadjYe) 
 adjTeTeadjYe = Matmul(adjTe,TeadjYe) 
 adjTuYuadjYd = Matmul(adjTu,YuadjYd) 
 adjTuYuadjYu = Matmul(adjTu,YuadjYu) 
 adjTuTuadjYd = Matmul(adjTu,TuadjYd) 
 adjTuTuadjYu = Matmul(adjTu,TuadjYu) 
 TdadjTdYd = Matmul(Td,adjTdYd) 
 TeadjTeYe = Matmul(Te,adjTeYe) 
 TuadjTuYu = Matmul(Tu,adjTuYu) 
 md2YdadjYdYd = Matmul(md2,YdadjYdYd) 
 me2YeadjYeYe = Matmul(me2,YeadjYeYe) 
 ml2adjYeYeadjYe = Matmul(ml2,adjYeYeadjYe) 
 mq2adjYdYdadjYd = Matmul(mq2,adjYdYdadjYd) 
 mq2adjYdYdadjYu = Matmul(mq2,adjYdYdadjYu) 
 mq2adjYuYuadjYd = Matmul(mq2,adjYuYuadjYd) 
 mq2adjYuYuadjYu = Matmul(mq2,adjYuYuadjYu) 
 mu2YuadjYuYu = Matmul(mu2,YuadjYuYu) 
 Ydmq2adjYdYd = Matmul(Yd,mq2adjYdYd) 
 YdadjYdmd2Yd = Matmul(Yd,adjYdmd2Yd) 
 YdadjYdYdmq2 = Matmul(Yd,adjYdYdmq2) 
 YdadjYdYdadjYd = Matmul(Yd,adjYdYdadjYd) 
Forall(i2=1:3)  YdadjYdYdadjYd(i2,i2) =  Real(YdadjYdYdadjYd(i2,i2),dp) 
 YdadjYdTdadjYd = Matmul(Yd,adjYdTdadjYd) 
 YdadjYdTdadjTd = Matmul(Yd,adjYdTdadjTd) 
 YdadjYuYuadjYd = Matmul(Yd,adjYuYuadjYd) 
Forall(i2=1:3)  YdadjYuYuadjYd(i2,i2) =  Real(YdadjYuYuadjYd(i2,i2),dp) 
 YdadjYuTuadjYd = Matmul(Yd,adjYuTuadjYd) 
 YdadjYuTuadjTd = Matmul(Yd,adjYuTuadjTd) 
 YdadjTdTdadjYd = Matmul(Yd,adjTdTdadjYd) 
 YdadjTuTuadjYd = Matmul(Yd,adjTuTuadjYd) 
 Yeml2adjYeYe = Matmul(Ye,ml2adjYeYe) 
 YeadjYeme2Ye = Matmul(Ye,adjYeme2Ye) 
 YeadjYeYeml2 = Matmul(Ye,adjYeYeml2) 
 YeadjYeYeadjYe = Matmul(Ye,adjYeYeadjYe) 
Forall(i2=1:3)  YeadjYeYeadjYe(i2,i2) =  Real(YeadjYeYeadjYe(i2,i2),dp) 
 YeadjYeTeadjYe = Matmul(Ye,adjYeTeadjYe) 
 YeadjYeTeadjTe = Matmul(Ye,adjYeTeadjTe) 
 YeadjTeTeadjYe = Matmul(Ye,adjTeTeadjYe) 
 Yumq2adjYuYu = Matmul(Yu,mq2adjYuYu) 
 YuadjYdYdadjYu = Matmul(Yu,adjYdYdadjYu) 
Forall(i2=1:3)  YuadjYdYdadjYu(i2,i2) =  Real(YuadjYdYdadjYu(i2,i2),dp) 
 YuadjYdTdadjYu = Matmul(Yu,adjYdTdadjYu) 
 YuadjYdTdadjTu = Matmul(Yu,adjYdTdadjTu) 
 YuadjYumu2Yu = Matmul(Yu,adjYumu2Yu) 
 YuadjYuYumq2 = Matmul(Yu,adjYuYumq2) 
 YuadjYuYuadjYu = Matmul(Yu,adjYuYuadjYu) 
Forall(i2=1:3)  YuadjYuYuadjYu(i2,i2) =  Real(YuadjYuYuadjYu(i2,i2),dp) 
 YuadjYuTuadjYu = Matmul(Yu,adjYuTuadjYu) 
 YuadjYuTuadjTu = Matmul(Yu,adjYuTuadjTu) 
 YuadjTdTdadjYu = Matmul(Yu,adjTdTdadjYu) 
 YuadjTuTuadjYu = Matmul(Yu,adjTuTuadjYu) 
 adjYdmd2YdadjYd = Matmul(adjYd,md2YdadjYd) 
 adjYdmd2YdadjYu = Matmul(adjYd,md2YdadjYu) 
 adjYdYdmq2adjYd = Matmul(adjYd,Ydmq2adjYd) 
 adjYdYdmq2adjYu = Matmul(adjYd,Ydmq2adjYu) 
 adjYdYdadjYdmd2 = Matmul(adjYd,YdadjYdmd2) 
 adjYdYdadjYdYd = Matmul(adjYd,YdadjYdYd) 
Forall(i2=1:3)  adjYdYdadjYdYd(i2,i2) =  Real(adjYdYdadjYdYd(i2,i2),dp) 
 adjYdYdadjYdTd = Matmul(adjYd,YdadjYdTd) 
 adjYdYdadjYumu2 = Matmul(adjYd,YdadjYumu2) 
 adjYdYdadjYuYu = Matmul(adjYd,YdadjYuYu) 
 adjYdYdadjYuTu = Matmul(adjYd,YdadjYuTu) 
 adjYdYdadjTdTd = Matmul(adjYd,YdadjTdTd) 
 adjYdTdadjYdYd = Matmul(adjYd,TdadjYdYd) 
 adjYdTdadjYuYu = Matmul(adjYd,TdadjYuYu) 
 adjYdTdadjTdYd = Matmul(adjYd,TdadjTdYd) 
 adjYeme2YeadjYe = Matmul(adjYe,me2YeadjYe) 
 adjYeYeml2adjYe = Matmul(adjYe,Yeml2adjYe) 
 adjYeYeadjYeme2 = Matmul(adjYe,YeadjYeme2) 
 adjYeYeadjYeYe = Matmul(adjYe,YeadjYeYe) 
Forall(i2=1:3)  adjYeYeadjYeYe(i2,i2) =  Real(adjYeYeadjYeYe(i2,i2),dp) 
 adjYeYeadjYeTe = Matmul(adjYe,YeadjYeTe) 
 adjYeYeadjTeTe = Matmul(adjYe,YeadjTeTe) 
 adjYeTeadjYeYe = Matmul(adjYe,TeadjYeYe) 
 adjYeTeadjTeYe = Matmul(adjYe,TeadjTeYe) 
 adjYumu2YuadjYd = Matmul(adjYu,mu2YuadjYd) 
 adjYumu2YuadjYu = Matmul(adjYu,mu2YuadjYu) 
 adjYuYumq2adjYd = Matmul(adjYu,Yumq2adjYd) 
 adjYuYumq2adjYu = Matmul(adjYu,Yumq2adjYu) 
 adjYuYuadjYdmd2 = Matmul(adjYu,YuadjYdmd2) 
 adjYuYuadjYdYd = Matmul(adjYu,YuadjYdYd) 
 adjYuYuadjYdTd = Matmul(adjYu,YuadjYdTd) 
 adjYuYuadjYumu2 = Matmul(adjYu,YuadjYumu2) 
 adjYuYuadjYuYu = Matmul(adjYu,YuadjYuYu) 
Forall(i2=1:3)  adjYuYuadjYuYu(i2,i2) =  Real(adjYuYuadjYuYu(i2,i2),dp) 
 adjYuYuadjYuTu = Matmul(adjYu,YuadjYuTu) 
 adjYuYuadjTuTu = Matmul(adjYu,YuadjTuTu) 
 adjYuTuadjYdYd = Matmul(adjYu,TuadjYdYd) 
 adjYuTuadjYuYu = Matmul(adjYu,TuadjYuYu) 
 adjYuTuadjTuYu = Matmul(adjYu,TuadjTuYu) 
 adjTdYdadjYdTd = Matmul(adjTd,YdadjYdTd) 
 adjTdTdadjYdYd = Matmul(adjTd,TdadjYdYd) 
 adjTeYeadjYeTe = Matmul(adjTe,YeadjYeTe) 
 adjTeTeadjYeYe = Matmul(adjTe,TeadjYeYe) 
 adjTuYuadjYuTu = Matmul(adjTu,YuadjYuTu) 
 adjTuTuadjYuYu = Matmul(adjTu,TuadjYuYu) 
 TdadjYdYdadjTd = Matmul(Td,adjYdYdadjTd) 
 TdadjYuYuadjTd = Matmul(Td,adjYuYuadjTd) 
 TdadjTdYdadjYd = Matmul(Td,adjTdYdadjYd) 
 TdadjTuYuadjYd = Matmul(Td,adjTuYuadjYd) 
 TeadjYeYeadjTe = Matmul(Te,adjYeYeadjTe) 
 TeadjTeYeadjYe = Matmul(Te,adjTeYeadjYe) 
 TuadjYdYdadjTu = Matmul(Tu,adjYdYdadjTu) 
 TuadjYuYuadjTu = Matmul(Tu,adjYuYuadjTu) 
 TuadjTdYdadjYu = Matmul(Tu,adjTdYdadjYu) 
 TuadjTuYuadjYu = Matmul(Tu,adjTuYuadjYu) 
 md2YdadjYdYdadjYd = Matmul(md2,YdadjYdYdadjYd) 
 md2YdadjYuYuadjYd = Matmul(md2,YdadjYuYuadjYd) 
 me2YeadjYeYeadjYe = Matmul(me2,YeadjYeYeadjYe) 
 ml2adjYeYeadjYeYe = Matmul(ml2,adjYeYeadjYeYe) 
 mq2adjYdYdadjYdYd = Matmul(mq2,adjYdYdadjYdYd) 
 mq2adjYdYdadjYuYu = Matmul(mq2,adjYdYdadjYuYu) 
 mq2adjYuYuadjYdYd = Matmul(mq2,adjYuYuadjYdYd) 
 mq2adjYuYuadjYuYu = Matmul(mq2,adjYuYuadjYuYu) 
 mu2YuadjYdYdadjYu = Matmul(mu2,YuadjYdYdadjYu) 
 mu2YuadjYuYuadjYu = Matmul(mu2,YuadjYuYuadjYu) 
 Ydmq2adjYdYdadjYd = Matmul(Yd,mq2adjYdYdadjYd) 
 Ydmq2adjYuYuadjYd = Matmul(Yd,mq2adjYuYuadjYd) 
 YdadjYdmd2YdadjYd = Matmul(Yd,adjYdmd2YdadjYd) 
Forall(i2=1:3)  YdadjYdmd2YdadjYd(i2,i2) =  Real(YdadjYdmd2YdadjYd(i2,i2),dp) 
 YdadjYdYdmq2adjYd = Matmul(Yd,adjYdYdmq2adjYd) 
 YdadjYdYdadjYdmd2 = Matmul(Yd,adjYdYdadjYdmd2) 
 YdadjYdYdadjYdYd = Matmul(Yd,adjYdYdadjYdYd) 
 YdadjYdYdadjYdTd = Matmul(Yd,adjYdYdadjYdTd) 
 YdadjYdTdadjYdYd = Matmul(Yd,adjYdTdadjYdYd) 
 YdadjYumu2YuadjYd = Matmul(Yd,adjYumu2YuadjYd) 
Forall(i2=1:3)  YdadjYumu2YuadjYd(i2,i2) =  Real(YdadjYumu2YuadjYd(i2,i2),dp) 
 YdadjYuYumq2adjYd = Matmul(Yd,adjYuYumq2adjYd) 
 YdadjYuYuadjYdmd2 = Matmul(Yd,adjYuYuadjYdmd2) 
 YdadjYuYuadjYdYd = Matmul(Yd,adjYuYuadjYdYd) 
 YdadjYuYuadjYdTd = Matmul(Yd,adjYuYuadjYdTd) 
 YdadjYuYuadjYuYu = Matmul(Yd,adjYuYuadjYuYu) 
 YdadjYuYuadjYuTu = Matmul(Yd,adjYuYuadjYuTu) 
 YdadjYuTuadjYdYd = Matmul(Yd,adjYuTuadjYdYd) 
 YdadjYuTuadjYuYu = Matmul(Yd,adjYuTuadjYuYu) 
 Yeml2adjYeYeadjYe = Matmul(Ye,ml2adjYeYeadjYe) 
 YeadjYeme2YeadjYe = Matmul(Ye,adjYeme2YeadjYe) 
Forall(i2=1:3)  YeadjYeme2YeadjYe(i2,i2) =  Real(YeadjYeme2YeadjYe(i2,i2),dp) 
 YeadjYeYeml2adjYe = Matmul(Ye,adjYeYeml2adjYe) 
 YeadjYeYeadjYeme2 = Matmul(Ye,adjYeYeadjYeme2) 
 YeadjYeYeadjYeYe = Matmul(Ye,adjYeYeadjYeYe) 
 YeadjYeYeadjYeTe = Matmul(Ye,adjYeYeadjYeTe) 
 YeadjYeTeadjYeYe = Matmul(Ye,adjYeTeadjYeYe) 
 Yumq2adjYdYdadjYu = Matmul(Yu,mq2adjYdYdadjYu) 
 Yumq2adjYuYuadjYu = Matmul(Yu,mq2adjYuYuadjYu) 
 YuadjYdmd2YdadjYu = Matmul(Yu,adjYdmd2YdadjYu) 
Forall(i2=1:3)  YuadjYdmd2YdadjYu(i2,i2) =  Real(YuadjYdmd2YdadjYu(i2,i2),dp) 
 YuadjYdYdmq2adjYu = Matmul(Yu,adjYdYdmq2adjYu) 
 YuadjYdYdadjYdYd = Matmul(Yu,adjYdYdadjYdYd) 
 YuadjYdYdadjYdTd = Matmul(Yu,adjYdYdadjYdTd) 
 YuadjYdYdadjYumu2 = Matmul(Yu,adjYdYdadjYumu2) 
 YuadjYdYdadjYuYu = Matmul(Yu,adjYdYdadjYuYu) 
 YuadjYdYdadjYuTu = Matmul(Yu,adjYdYdadjYuTu) 
 YuadjYdTdadjYdYd = Matmul(Yu,adjYdTdadjYdYd) 
 YuadjYdTdadjYuYu = Matmul(Yu,adjYdTdadjYuYu) 
 YuadjYumu2YuadjYu = Matmul(Yu,adjYumu2YuadjYu) 
Forall(i2=1:3)  YuadjYumu2YuadjYu(i2,i2) =  Real(YuadjYumu2YuadjYu(i2,i2),dp) 
 YuadjYuYumq2adjYu = Matmul(Yu,adjYuYumq2adjYu) 
 YuadjYuYuadjYumu2 = Matmul(Yu,adjYuYuadjYumu2) 
 YuadjYuYuadjYuYu = Matmul(Yu,adjYuYuadjYuYu) 
 YuadjYuYuadjYuTu = Matmul(Yu,adjYuYuadjYuTu) 
 YuadjYuTuadjYuYu = Matmul(Yu,adjYuTuadjYuYu) 
 adjYdmd2YdadjYdYd = Matmul(adjYd,md2YdadjYdYd) 
 adjYdYdmq2adjYdYd = Matmul(adjYd,Ydmq2adjYdYd) 
Forall(i2=1:3)  adjYdYdmq2adjYdYd(i2,i2) =  Real(adjYdYdmq2adjYdYd(i2,i2),dp) 
 adjYdYdadjYdmd2Yd = Matmul(adjYd,YdadjYdmd2Yd) 
 adjYdYdadjYdYdmq2 = Matmul(adjYd,YdadjYdYdmq2) 
 adjYeme2YeadjYeYe = Matmul(adjYe,me2YeadjYeYe) 
 adjYeYeml2adjYeYe = Matmul(adjYe,Yeml2adjYeYe) 
Forall(i2=1:3)  adjYeYeml2adjYeYe(i2,i2) =  Real(adjYeYeml2adjYeYe(i2,i2),dp) 
 adjYeYeadjYeme2Ye = Matmul(adjYe,YeadjYeme2Ye) 
 adjYeYeadjYeYeml2 = Matmul(adjYe,YeadjYeYeml2) 
 adjYumu2YuadjYuYu = Matmul(adjYu,mu2YuadjYuYu) 
 adjYuYumq2adjYuYu = Matmul(adjYu,Yumq2adjYuYu) 
Forall(i2=1:3)  adjYuYumq2adjYuYu(i2,i2) =  Real(adjYuYumq2adjYuYu(i2,i2),dp) 
 adjYuYuadjYumu2Yu = Matmul(adjYu,YuadjYumu2Yu) 
 adjYuYuadjYuYumq2 = Matmul(adjYu,YuadjYuYumq2) 
 TdadjYdYdadjYdYd = Matmul(Td,adjYdYdadjYdYd) 
 TdadjYuYuadjYdYd = Matmul(Td,adjYuYuadjYdYd) 
 TdadjYuYuadjYuYu = Matmul(Td,adjYuYuadjYuYu) 
 TeadjYeYeadjYeYe = Matmul(Te,adjYeYeadjYeYe) 
 TuadjYdYdadjYdYd = Matmul(Tu,adjYdYdadjYdYd) 
 TuadjYdYdadjYuYu = Matmul(Tu,adjYdYdadjYuYu) 
 TuadjYuYuadjYuYu = Matmul(Tu,adjYuYuadjYuYu) 
 TrCTdTpYd = cTrace(CTdTpYd)
 TrCTeTpYe = cTrace(CTeTpYe)
 TrCTuTpYu = cTrace(CTuTpYu)
 Trml2L11CL11 = cTrace(ml2L11CL11)
 Trml2L12CL12 = cTrace(ml2L12CL12)
 Trml2L13CL13 = cTrace(ml2L13CL13)
 Trml2L21adjL21 = cTrace(ml2L21adjL21)
 Trml2L22adjL22 = cTrace(ml2L22adjL22)
 Trml2L23adjL23 = cTrace(ml2L23adjL23)
 Trmq2TpL21CL21 = cTrace(mq2TpL21CL21)
 Trmq2TpL22CL22 = cTrace(mq2TpL22CL22)
 Trmq2TpL23CL23 = cTrace(mq2TpL23CL23)
 TrYdadjYdCmd2 = cTrace(YdadjYdCmd2)
 TrYdCmq2adjYd = Real(cTrace(YdCmq2adjYd),dp)  
 TrYeadjYeCme2 = cTrace(YeadjYeCme2)
 TrYeCml2adjYe = Real(cTrace(YeCml2adjYe),dp)  
 TrYuadjYuCmu2 = cTrace(YuadjYuCmu2)
 TrYuCmq2adjYu = Real(cTrace(YuCmq2adjYu),dp)  
 TrYdadjYdYdadjYd = Real(cTrace(YdadjYdYdadjYd),dp)  
 TrYdadjYdTdadjYd = cTrace(YdadjYdTdadjYd)
 TrYdadjYdTdadjTd = cTrace(YdadjYdTdadjTd)
 TrYdadjYuYuadjYd = Real(cTrace(YdadjYuYuadjYd),dp)  
 TrYdadjYuTuadjYd = cTrace(YdadjYuTuadjYd)
 TrYdadjYuTuadjTd = cTrace(YdadjYuTuadjTd)
 TrYdadjTdTdadjYd = cTrace(YdadjTdTdadjYd)
 TrYdadjTuTuadjYd = cTrace(YdadjTuTuadjYd)
 TrYeadjYeYeadjYe = Real(cTrace(YeadjYeYeadjYe),dp)  
 TrYeadjYeTeadjYe = cTrace(YeadjYeTeadjYe)
 TrYeadjYeTeadjTe = cTrace(YeadjYeTeadjTe)
 TrYeadjTeTeadjYe = cTrace(YeadjTeTeadjYe)
 TrYuadjYdTdadjYu = cTrace(YuadjYdTdadjYu)
 TrYuadjYdTdadjTu = cTrace(YuadjYdTdadjTu)
 TrYuadjYuYuadjYu = Real(cTrace(YuadjYuYuadjYu),dp)  
 TrYuadjYuTuadjYu = cTrace(YuadjYuTuadjYu)
 TrYuadjYuTuadjTu = cTrace(YuadjYuTuadjTu)
 TrYuadjTdTdadjYu = cTrace(YuadjTdTdadjYu)
 TrYuadjTuTuadjYu = cTrace(YuadjTuTuadjYu)
 Trmd2YdadjYdYdadjYd = cTrace(md2YdadjYdYdadjYd)
 Trmd2YdadjYuYuadjYd = cTrace(md2YdadjYuYuadjYd)
 Trme2YeadjYeYeadjYe = cTrace(me2YeadjYeYeadjYe)
 Trml2adjYeYeadjYeYe = cTrace(ml2adjYeYeadjYeYe)
 Trmq2adjYdYdadjYdYd = cTrace(mq2adjYdYdadjYdYd)
 Trmq2adjYdYdadjYuYu = cTrace(mq2adjYdYdadjYuYu)
 Trmq2adjYuYuadjYdYd = cTrace(mq2adjYuYuadjYdYd)
 Trmq2adjYuYuadjYuYu = cTrace(mq2adjYuYuadjYuYu)
 Trmu2YuadjYdYdadjYu = cTrace(mu2YuadjYdYdadjYu)
 Trmu2YuadjYuYuadjYu = cTrace(mu2YuadjYuYuadjYu)
 g1p4 =g1**4 
 g1p5 =g1**5 
 g2p4 =g2**4 
 g2p5 =g2**5 
 g3p4 =g3**4 
 g3p5 =g3**5 
 Xip2 =Xi**2 
End If 
 
 
Tr1(1) = g1*sqrt3ov5*(-1._dp*(mHd2) + mHu2 + Trmd2 + Trme2 - Trml2 + Trmq2 -          & 
&  2._dp*(Trmu2))

If (TwoLoopRGE) Then 
Tr2U1(1, 1) = (g1p2*(3._dp*(mHd2) + 3._dp*(mHu2) + 2._dp*(Trmd2) + 6._dp*(Trme2)      & 
&  + 3._dp*(Trml2) + Trmq2 + 8._dp*(Trmu2)))/10._dp

Tr3(1) = -(g1*ooSqrt15*(9*g1p2*mHd2 + 45*g2p2*mHd2 - 9*g1p2*mHu2 - 45*g2p2*mHu2 -     & 
&  4*(g1p2 + 20._dp*(g3p2))*Trmd2 - 36*g1p2*Trme2 + 9*g1p2*Trml2 + 45*g2p2*Trml2 +       & 
&  30._dp*(Trml2L11CL11) + 30._dp*(Trml2L12CL12) + 30._dp*(Trml2L13CL13) -               & 
&  90._dp*(Trml2L21adjL21) - 90._dp*(Trml2L22adjL22) - 90._dp*(Trml2L23adjL23)           & 
&  - g1p2*Trmq2 - 45*g2p2*Trmq2 - 80*g3p2*Trmq2 + 30._dp*(Trmq2TpL21CL21) +              & 
&  30._dp*(Trmq2TpL22CL22) + 30._dp*(Trmq2TpL23CL23) + 32*g1p2*Trmu2 + 160*g3p2*Trmu2 -  & 
&  90*mHd2*TrYdadjYd + 60._dp*(TrYdadjYdCmd2) + 30._dp*(TrYdCmq2adjYd) - 30*mHd2*TrYeadjYe +& 
&  60._dp*(TrYeadjYeCme2) - 30._dp*(TrYeCml2adjYe) + 90*mHu2*TrYuadjYu - 120._dp*(TrYuadjYuCmu2)& 
&  + 30._dp*(TrYuCmq2adjYu) + 60*TrCL21TpL21*md2(1,1) + 60*TrCL22TpL21*md2(1,            & 
& 2) + 60*TrCL23TpL21*md2(1,3) + 60*TrCL21TpL22*md2(2,1) + 60*TrCL22TpL22*md2(2,         & 
& 2) + 60*TrCL23TpL22*md2(2,3) + 60*TrCL21TpL23*md2(3,1) + 60*TrCL22TpL23*md2(3,         & 
& 2) + 60*TrCL23TpL23*md2(3,3) - 30*TrCL11L11*me2(1,1) - 30*TrCL12L11*me2(1,             & 
& 2) - 30*TrCL13L11*me2(1,3) - 30*TrCL11L12*me2(2,1) - 30*TrCL12L12*me2(2,               & 
& 2) - 30*TrCL13L12*me2(2,3) - 30*TrCL11L13*me2(3,1) - 30*TrCL12L13*me2(3,               & 
& 2) - 30*TrCL13L13*me2(3,3)))/20._dp

Tr2(2) = (mHd2 + mHu2 + Trml2 + 3._dp*(Trmq2))/2._dp

Tr2(3) = (Trmd2 + 2._dp*(Trmq2) + Trmu2)/2._dp

End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 33._dp*(g1p3)/5._dp

 
 
If (TwoLoopRGE) Then 
betag12 = 199._dp*(g1p5)/25._dp + (27*g1p3*g2p2)/5._dp + (88*g1p3*g3p2)/5._dp - (14*g1p3*TrYdadjYd)/5._dp -& 
&  (18*g1p3*TrYeadjYe)/5._dp - (26*g1p3*TrYuadjYu)/5._dp

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = g2p3

 
 
If (TwoLoopRGE) Then 
betag22 = (9*g1p2*g2p3)/5._dp + 25._dp*(g2p5) + 24*g2p3*g3p2 - 6*g2p3*TrYdadjYd -               & 
&  2*g2p3*TrYeadjYe - 6*g2p3*TrYuadjYu

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = -3._dp*(g3p3)

 
 
If (TwoLoopRGE) Then 
betag32 = (11*g1p2*g3p3)/5._dp + 9*g2p2*g3p3 + 14._dp*(g3p5) - 4*g3p3*TrYdadjYd -               & 
&  4*g3p3*TrYuadjYu

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! Yd 
!-------------------- 
 
betaYd1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYd1(i1,i2) = (-7*g1p2*Yd(i1,i2))/15._dp - 3*g2p2*Yd(i1,i2) - (16*g3p2*Yd(i1,i2))/3._dp +           & 
&  3*TrYdadjYd*Yd(i1,i2) + TrYeadjYe*Yd(i1,i2) + YdadjL21L21(i1,i2) + YdadjL22L22(i1,    & 
& i2) + YdadjL23L23(i1,i2) + 3*YdadjYdYd(i1,i2) + YdadjYuYu(i1,i2)
If (1.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL21*Yd(1,i2) + 2*TrCL22TpL21*Yd(2,i2) + 2*TrCL23TpL21*Yd(3,i2) +            & 
&  3*YdadjL21L21(1,i2) + 3*YdadjL22L21(2,i2) + 3*YdadjL23L21(3,i2) - YeCL11L21(1,        & 
& i2) - YeCL12L21(2,i2) - YeCL13L21(3,i2)
End If 
If (2.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL22*Yd(1,i2) + 2*TrCL22TpL22*Yd(2,i2) + 2*TrCL23TpL22*Yd(3,i2) +            & 
&  3*YdadjL21L22(1,i2) + 3*YdadjL22L22(2,i2) + 3*YdadjL23L22(3,i2) - YeCL11L22(1,        & 
& i2) - YeCL12L22(2,i2) - YeCL13L22(3,i2)
End If 
If (3.eq.i1) Then 
betaYd1(i1,i2) = betaYd1(i1,i2)+2*TrCL21TpL23*Yd(1,i2) + 2*TrCL22TpL23*Yd(2,i2) + 2*TrCL23TpL23*Yd(3,i2) +            & 
&  3*YdadjL21L23(1,i2) + 3*YdadjL22L23(2,i2) + 3*YdadjL23L23(3,i2) - YeCL11L23(1,        & 
& i2) - YeCL12L23(2,i2) - YeCL13L23(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaYd2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYd2(i1,i2) = (287*g1p4*Yd(i1,i2))/90._dp + g1p2*g2p2*Yd(i1,i2) + (15*g2p4*Yd(i1,i2))/2._dp +       & 
&  (8*g1p2*g3p2*Yd(i1,i2))/9._dp + 8*g2p2*g3p2*Yd(i1,i2) - (16*g3p4*Yd(i1,               & 
& i2))/9._dp - (2*g1p2*TrYdadjYd*Yd(i1,i2))/5._dp + 16*g3p2*TrYdadjYd*Yd(i1,             & 
& i2) - 9*TrYdadjYdYdadjYd*Yd(i1,i2) - 3*TrYdadjYuYuadjYd*Yd(i1,i2) + (6*g1p2*TrYeadjYe*Yd(i1,& 
& i2))/5._dp - 3*TrYeadjYeYeadjYe*Yd(i1,i2) + (4*g1p2*YdadjYdYd(i1,i2))/5._dp +          & 
&  6*g2p2*YdadjYdYd(i1,i2) - 9*TrYdadjYd*YdadjYdYd(i1,i2) - 3*TrYeadjYe*YdadjYdYd(i1,    & 
& i2) - 4*YdadjYdYdadjYdYd(i1,i2) + (4*g1p2*YdadjYuYu(i1,i2))/5._dp - 3*TrYuadjYu*YdadjYuYu(i1,& 
& i2) - 2*YdadjYuYuadjYdYd(i1,i2) - 2*YdadjYuYuadjYuYu(i1,i2)
End Do
End Do

 
DYd = oo16pi2*( betaYd1 + oo16pi2 * betaYd2 ) 

 
Else 
DYd = oo16pi2* betaYd1 
End If 
 
 
Call Chop(DYd) 

!-------------------- 
! Ye 
!-------------------- 
 
betaYe1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYe1(i1,i2) = (-9*g1p2*Ye(i1,i2))/5._dp - 3*g2p2*Ye(i1,i2) + 3*TrYdadjYd*Ye(i1,i2) + TrYeadjYe*Ye(i1,& 
& i2) + 3*YeadjYeYe(i1,i2) - YeCL11L11(i1,i2) - YeCL12L12(i1,i2) - YeCL13L13(i1,         & 
& i2) + 3*YeCL21TpL21(i1,i2) + 3*YeCL22TpL22(i1,i2) + 3*YeCL23TpL23(i1,i2)
If (1.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L11CL11TpYe(i2,1) - L11CL12TpYe(i2,2) - L11CL13TpYe(i2,3) - 3*L11CL21TpYd(i2,        & 
& 1) - 3*L11CL22TpYd(i2,2) - 3*L11CL23TpYd(i2,3) - TrCL11L11*Ye(1,i2) - TrCL12L11*Ye(2,  & 
& i2) - TrCL13L11*Ye(3,i2)
End If 
If (2.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L12CL11TpYe(i2,1) - L12CL12TpYe(i2,2) - L12CL13TpYe(i2,3) - 3*L12CL21TpYd(i2,        & 
& 1) - 3*L12CL22TpYd(i2,2) - 3*L12CL23TpYd(i2,3) - TrCL11L12*Ye(1,i2) - TrCL12L12*Ye(2,  & 
& i2) - TrCL13L12*Ye(3,i2)
End If 
If (3.eq.i1) Then 
betaYe1(i1,i2) = betaYe1(i1,i2)-L13CL11TpYe(i2,1) - L13CL12TpYe(i2,2) - L13CL13TpYe(i2,3) - 3*L13CL21TpYd(i2,        & 
& 1) - 3*L13CL22TpYd(i2,2) - 3*L13CL23TpYd(i2,3) - TrCL11L13*Ye(1,i2) - TrCL12L13*Ye(2,  & 
& i2) - TrCL13L13*Ye(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaYe2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaYe2(i1,i2) = (27*g1p4*Ye(i1,i2))/2._dp + (9*g1p2*g2p2*Ye(i1,i2))/5._dp + (15*g2p4*Ye(i1,           & 
& i2))/2._dp - (2*g1p2*TrYdadjYd*Ye(i1,i2))/5._dp + 16*g3p2*TrYdadjYd*Ye(i1,             & 
& i2) - 9*TrYdadjYdYdadjYd*Ye(i1,i2) - 3*TrYdadjYuYuadjYd*Ye(i1,i2) + (6*g1p2*TrYeadjYe*Ye(i1,& 
& i2))/5._dp - 3*TrYeadjYeYeadjYe*Ye(i1,i2) + 6*g2p2*YeadjYeYe(i1,i2) - 9*TrYdadjYd*YeadjYeYe(i1,& 
& i2) - 3*TrYeadjYe*YeadjYeYe(i1,i2) - 4*YeadjYeYeadjYeYe(i1,i2)
End Do
End Do

 
DYe = oo16pi2*( betaYe1 + oo16pi2 * betaYe2 ) 

 
Else 
DYe = oo16pi2* betaYe1 
End If 
 
 
Call Chop(DYe) 

!-------------------- 
! L1 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,1) = L11adjYeYe(i1,i2) - 2*L11CL11L11(i1,i2) - L11CL12L12(i1,i2) - L11CL13L13(i1,          & 
& i2) + 3*L11CL21TpL21(i1,i2) + 3*L11CL22TpL22(i1,i2) + 3*L11CL23TpL23(i1,               & 
& i2) - L12CL12L11(i1,i2) - L13CL13L11(i1,i2) + 3*L21adjL21L11(i1,i2) + 3*L22adjL22L11(i1,& 
& i2) + 3*L23adjL23L11(i1,i2) + TpYeCYeL11(i1,i2) - (9*g1p2*L11(i1,i2))/5._dp -          & 
&  3*g2p2*L11(i1,i2) - TrCL11L11*L11(i1,i2) - TrCL12L11*L12(i1,i2) - TrCL13L11*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,2) = -L11CL11L12(i1,i2) + L12adjYeYe(i1,i2) - L12CL11L11(i1,i2) - 2*L12CL12L12(i1,         & 
& i2) - L12CL13L13(i1,i2) + 3*L12CL21TpL21(i1,i2) + 3*L12CL22TpL22(i1,i2) +              & 
&  3*L12CL23TpL23(i1,i2) - L13CL13L12(i1,i2) + 3*L21adjL21L12(i1,i2) + 3*L22adjL22L12(i1,& 
& i2) + 3*L23adjL23L12(i1,i2) + TpYeCYeL12(i1,i2) - TrCL11L12*L11(i1,i2) -               & 
&  (9*g1p2*L12(i1,i2))/5._dp - 3*g2p2*L12(i1,i2) - TrCL12L12*L12(i1,i2) - TrCL13L12*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL11(i1,i2,3) = -L11CL11L13(i1,i2) - L12CL12L13(i1,i2) + L13adjYeYe(i1,i2) - L13CL11L11(i1,           & 
& i2) - L13CL12L12(i1,i2) - 2*L13CL13L13(i1,i2) + 3*L13CL21TpL21(i1,i2) + 3*L13CL22TpL22(i1,& 
& i2) + 3*L13CL23TpL23(i1,i2) + 3*L21adjL21L13(i1,i2) + 3*L22adjL22L13(i1,               & 
& i2) + 3*L23adjL23L13(i1,i2) + TpYeCYeL13(i1,i2) - TrCL11L13*L11(i1,i2) -               & 
&  TrCL12L13*L12(i1,i2) - (9*g1p2*L13(i1,i2))/5._dp - 3*g2p2*L13(i1,i2) - TrCL13L13*L13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL11(i1,i2,i3) = betaL11(i1,i2,i3)-3*CYdTpL21(1,i2)*Ye(i3,i1) - 3*CYdTpL22(2,i2)*Ye(i3,i1) - 3*CYdTpL23(3,              & 
& i2)*Ye(i3,i1) + CYeL11(1,i2)*Ye(i3,i1) + CYeL12(2,i2)*Ye(i3,i1) + CYeL13(3,            & 
& i2)*Ye(i3,i1) + 3*CYdTpL21(1,i1)*Ye(i3,i2) + 3*CYdTpL22(2,i1)*Ye(i3,i2) +              & 
&  3*CYdTpL23(3,i1)*Ye(i3,i2) - CYeL11(1,i1)*Ye(i3,i2) - CYeL12(2,i1)*Ye(i3,             & 
& i2) - CYeL13(3,i1)*Ye(i3,i2) + 2*YeadjYe(i3,1)*L11(i1,i2) + 2*YeadjYe(i3,              & 
& 2)*L12(i1,i2) + 2*YeadjYe(i3,3)*L13(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL12(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL12(i1,i2,i3) = betaL12(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DL1 = oo16pi2*( betaL11 + oo16pi2 * betaL12 ) 

 
Else 
DL1 = oo16pi2* betaL11 
End If 
 
 
!-------------------- 
! L2 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,1) = -L11CL11L21(i1,i2) - L12CL12L21(i1,i2) - L13CL13L21(i1,i2) + 4*L21adjL21L21(i1,       & 
& i2) + L21adjL22L22(i1,i2) + L21adjL23L23(i1,i2) + L21adjYdYd(i1,i2) + L21adjYuYu(i1,   & 
& i2) + 3*L22adjL22L21(i1,i2) + 3*L23adjL23L21(i1,i2) + TpYeCYeL21(i1,i2) -              & 
&  (7*g1p2*L21(i1,i2))/15._dp - 3*g2p2*L21(i1,i2) - (16*g3p2*L21(i1,i2))/3._dp +         & 
&  2*TrCL21TpL21*L21(i1,i2) + 2*TrCL22TpL21*L22(i1,i2) + 2*TrCL23TpL21*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,2) = -L11CL11L22(i1,i2) - L12CL12L22(i1,i2) - L13CL13L22(i1,i2) + 3*L21adjL21L22(i1,       & 
& i2) + L22adjL21L21(i1,i2) + 4*L22adjL22L22(i1,i2) + L22adjL23L23(i1,i2) +              & 
&  L22adjYdYd(i1,i2) + L22adjYuYu(i1,i2) + 3*L23adjL23L22(i1,i2) + TpYeCYeL22(i1,        & 
& i2) + 2*TrCL21TpL22*L21(i1,i2) - (7*g1p2*L22(i1,i2))/15._dp - 3*g2p2*L22(i1,           & 
& i2) - (16*g3p2*L22(i1,i2))/3._dp + 2*TrCL22TpL22*L22(i1,i2) + 2*TrCL23TpL22*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL21(i1,i2,3) = -L11CL11L23(i1,i2) - L12CL12L23(i1,i2) - L13CL13L23(i1,i2) + 3*L21adjL21L23(i1,       & 
& i2) + 3*L22adjL22L23(i1,i2) + L23adjL21L21(i1,i2) + L23adjL22L22(i1,i2) +              & 
&  4*L23adjL23L23(i1,i2) + L23adjYdYd(i1,i2) + L23adjYuYu(i1,i2) + TpYeCYeL23(i1,        & 
& i2) + 2*TrCL21TpL23*L21(i1,i2) + 2*TrCL22TpL23*L22(i1,i2) - (7*g1p2*L23(i1,            & 
& i2))/15._dp - 3*g2p2*L23(i1,i2) - (16*g3p2*L23(i1,i2))/3._dp + 2*TrCL23TpL23*L23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL21(i1,i2,i3) = betaL21(i1,i2,i3)+3*CYdTpL21(1,i1)*Yd(i3,i2) + 3*CYdTpL22(2,i1)*Yd(i3,i2) + 3*CYdTpL23(3,               & 
& i1)*Yd(i3,i2) - CYeL11(1,i1)*Yd(i3,i2) - CYeL12(2,i1)*Yd(i3,i2) - CYeL13(3,            & 
& i1)*Yd(i3,i2) + 2*YdadjYd(i3,1)*L21(i1,i2) + 2*YdadjYd(i3,2)*L22(i1,i2) +              & 
&  2*YdadjYd(i3,3)*L23(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaL22(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaL22(i1,i2,i3) = betaL22(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DL2 = oo16pi2*( betaL21 + oo16pi2 * betaL22 ) 

 
Else 
DL2 = oo16pi2* betaL21 
End If 
 
 
!-------------------- 
! Yu 
!-------------------- 
 
betaYu1  = (-13*g1p2*Yu)/15._dp - 3*g2p2*Yu - (16*g3p2*Yu)/3._dp + 3*TrYuadjYu*Yu +   & 
&  YuadjL21L21 + YuadjL22L22 + YuadjL23L23 + YuadjYdYd + 3._dp*(YuadjYuYu)

 
 
If (TwoLoopRGE) Then 
betaYu2 = (2743*g1p4*Yu)/450._dp + g1p2*g2p2*Yu + (15*g2p4*Yu)/2._dp + (136*g1p2*g3p2*Yu)/45._dp +& 
&  8*g2p2*g3p2*Yu - (16*g3p4*Yu)/9._dp - 3*TrYdadjYuYuadjYd*Yu + (4*g1p2*TrYuadjYu*Yu)/5._dp +& 
&  16*g3p2*TrYuadjYu*Yu - 9*TrYuadjYuYuadjYu*Yu + (2*g1p2*YuadjYdYd)/5._dp -             & 
&  3*TrYdadjYd*YuadjYdYd - TrYeadjYe*YuadjYdYd - 2._dp*(YuadjYdYdadjYdYd) -              & 
&  2._dp*(YuadjYdYdadjYuYu) + (2*g1p2*YuadjYuYu)/5._dp + 6*g2p2*YuadjYuYu -              & 
&  9*TrYuadjYu*YuadjYuYu - 4._dp*(YuadjYuYuadjYuYu)

 
DYu = oo16pi2*( betaYu1 + oo16pi2 * betaYu2 ) 

 
Else 
DYu = oo16pi2* betaYu1 
End If 
 
 
Call Chop(DYu) 

!-------------------- 
! Mu 
!-------------------- 
 
betaMu1  = (-3*g1p2*Mu)/5._dp - 3*g2p2*Mu + 3*TrYdadjYd*Mu + TrYeadjYe*Mu +           & 
&  3*TrYuadjYu*Mu

 
 
If (TwoLoopRGE) Then 
betaMu2 = (207*g1p4*Mu)/50._dp + (9*g1p2*g2p2*Mu)/5._dp + (15*g2p4*Mu)/2._dp - (2*g1p2*TrYdadjYd*Mu)/5._dp +& 
&  16*g3p2*TrYdadjYd*Mu - 9*TrYdadjYdYdadjYd*Mu - 6*TrYdadjYuYuadjYd*Mu + (6*g1p2*TrYeadjYe*Mu)/5._dp -& 
&  3*TrYeadjYeYeadjYe*Mu + (4*g1p2*TrYuadjYu*Mu)/5._dp + 16*g3p2*TrYuadjYu*Mu -          & 
&  9*TrYuadjYuYuadjYu*Mu

 
DMu = oo16pi2*( betaMu1 + oo16pi2 * betaMu2 ) 

 
Else 
DMu = oo16pi2* betaMu1 
End If 
 
 
Call Chop(DMu) 

!-------------------- 
! Td 
!-------------------- 
 
betaTd1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTd1(i1,i2) = TdadjL21L21(i1,i2) + TdadjL22L22(i1,i2) + TdadjL23L23(i1,i2) + 5*TdadjYdYd(i1,        & 
& i2) + TdadjYuYu(i1,i2) + (14*g1p2*M1*Yd(i1,i2))/15._dp + (32*g3p2*M3*Yd(i1,            & 
& i2))/3._dp + 6*g2p2*M2*Yd(i1,i2) + 6*TradjYdTd*Yd(i1,i2) + 2*TradjYeTe*Yd(i1,          & 
& i2) + 2*YdadjL21T21(i1,i2) + 2*YdadjL22T22(i1,i2) + 2*YdadjL23T23(i1,i2) +             & 
&  4*YdadjYdTd(i1,i2) + 2*YdadjYuTu(i1,i2) - (7*g1p2*Td(i1,i2))/15._dp - 3*g2p2*Td(i1,   & 
& i2) - (16*g3p2*Td(i1,i2))/3._dp + 3*TrYdadjYd*Td(i1,i2) + TrYeadjYe*Td(i1,i2)
If (1.eq.i1) Then 
betaTd1(i1,i2) = betaTd1(i1,i2)+2*TpL21CL11TpTe(i2,1) + 2*TpL21CL12TpTe(i2,2) + 2*TpL21CL13TpTe(i2,3) +               & 
&  6*TpL21CL21TpTd(i2,1) + 6*TpL21CL22TpTd(i2,2) + 6*TpL21CL23TpTd(i2,3) +               & 
&  4*TradjL21T21*Yd(1,i2) + 4*TradjL22T21*Yd(2,i2) + 4*TradjL23T21*Yd(3,i2) +            & 
&  3*YdadjL21T21(1,i2) + 3*YdadjL22T21(2,i2) + 3*YdadjL23T21(3,i2) - YeCL11T21(1,        & 
& i2) - YeCL12T21(2,i2) - YeCL13T21(3,i2) + 2*TrCL21TpL21*Td(1,i2) + 2*TrCL22TpL21*Td(2, & 
& i2) + 2*TrCL23TpL21*Td(3,i2)
End If 
If (2.eq.i1) Then 
betaTd1(i1,i2) = betaTd1(i1,i2)+2*TpL22CL11TpTe(i2,1) + 2*TpL22CL12TpTe(i2,2) + 2*TpL22CL13TpTe(i2,3) +               & 
&  6*TpL22CL21TpTd(i2,1) + 6*TpL22CL22TpTd(i2,2) + 6*TpL22CL23TpTd(i2,3) +               & 
&  4*TradjL21T22*Yd(1,i2) + 4*TradjL22T22*Yd(2,i2) + 4*TradjL23T22*Yd(3,i2) +            & 
&  3*YdadjL21T22(1,i2) + 3*YdadjL22T22(2,i2) + 3*YdadjL23T22(3,i2) - YeCL11T22(1,        & 
& i2) - YeCL12T22(2,i2) - YeCL13T22(3,i2) + 2*TrCL21TpL22*Td(1,i2) + 2*TrCL22TpL22*Td(2, & 
& i2) + 2*TrCL23TpL22*Td(3,i2)
End If 
If (3.eq.i1) Then 
betaTd1(i1,i2) = betaTd1(i1,i2)+2*TpL23CL11TpTe(i2,1) + 2*TpL23CL12TpTe(i2,2) + 2*TpL23CL13TpTe(i2,3) +               & 
&  6*TpL23CL21TpTd(i2,1) + 6*TpL23CL22TpTd(i2,2) + 6*TpL23CL23TpTd(i2,3) +               & 
&  4*TradjL21T23*Yd(1,i2) + 4*TradjL22T23*Yd(2,i2) + 4*TradjL23T23*Yd(3,i2) +            & 
&  3*YdadjL21T23(1,i2) + 3*YdadjL22T23(2,i2) + 3*YdadjL23T23(3,i2) - YeCL11T23(1,        & 
& i2) - YeCL12T23(2,i2) - YeCL13T23(3,i2) + 2*TrCL21TpL23*Td(1,i2) + 2*TrCL22TpL23*Td(2, & 
& i2) + 2*TrCL23TpL23*Td(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaTd2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTd2(i1,i2) = (6*g1p2*TdadjYdYd(i1,i2))/5._dp + 12*g2p2*TdadjYdYd(i1,i2) - 15*TrYdadjYd*TdadjYdYd(i1,& 
& i2) - 5*TrYeadjYe*TdadjYdYd(i1,i2) - 6*TdadjYdYdadjYdYd(i1,i2) + (4*g1p2*TdadjYuYu(i1, & 
& i2))/5._dp - 3*TrYuadjYu*TdadjYuYu(i1,i2) - 4*TdadjYuYuadjYdYd(i1,i2) - 2*TdadjYuYuadjYuYu(i1,& 
& i2) - (574*g1p4*M1*Yd(i1,i2))/45._dp - 2*g1p2*g2p2*M1*Yd(i1,i2) - (16*g1p2*g3p2*M1*Yd(i1,& 
& i2))/9._dp - (16*g1p2*g3p2*M3*Yd(i1,i2))/9._dp - 16*g2p2*g3p2*M3*Yd(i1,i2) +           & 
&  (64*g3p4*M3*Yd(i1,i2))/9._dp - 2*g1p2*g2p2*M2*Yd(i1,i2) - 30*g2p4*M2*Yd(i1,           & 
& i2) - 16*g2p2*g3p2*M2*Yd(i1,i2) - (4*g1p2*TradjYdTd*Yd(i1,i2))/5._dp + 32*g3p2*TradjYdTd*Yd(i1,& 
& i2) + (12*g1p2*TradjYeTe*Yd(i1,i2))/5._dp + (4*g1p2*M1*TrYdadjYd*Yd(i1,i2))/5._dp -    & 
&  32*g3p2*M3*TrYdadjYd*Yd(i1,i2) - 36*TrYdadjYdTdadjYd*Yd(i1,i2) - 6*TrYdadjYuTuadjYd*Yd(i1,& 
& i2) - (12*g1p2*M1*TrYeadjYe*Yd(i1,i2))/5._dp - 12*TrYeadjYeTeadjYe*Yd(i1,              & 
& i2) - 6*TrYuadjYdTdadjYu*Yd(i1,i2) + (6*g1p2*YdadjYdTd(i1,i2))/5._dp + 6*g2p2*YdadjYdTd(i1,& 
& i2) - 12*TrYdadjYd*YdadjYdTd(i1,i2) - 4*TrYeadjYe*YdadjYdTd(i1,i2) - 8*YdadjYdTdadjYdYd(i1,& 
& i2) - (8*g1p2*M1*YdadjYdYd(i1,i2))/5._dp - 12*g2p2*M2*YdadjYdYd(i1,i2) -               & 
&  18*TradjYdTd*YdadjYdYd(i1,i2) - 6*TradjYeTe*YdadjYdYd(i1,i2) - 6*YdadjYdYdadjYdTd(i1, & 
& i2) + (8*g1p2*YdadjYuTu(i1,i2))/5._dp - 6*TrYuadjYu*YdadjYuTu(i1,i2) - 4*YdadjYuTuadjYdYd(i1,& 
& i2) - 4*YdadjYuTuadjYuYu(i1,i2) - (8*g1p2*M1*YdadjYuYu(i1,i2))/5._dp - 6*TradjYuTu*YdadjYuYu(i1,& 
& i2) - 2*YdadjYuYuadjYdTd(i1,i2) - 4*YdadjYuYuadjYuTu(i1,i2) + (287*g1p4*Td(i1,         & 
& i2))/90._dp + g1p2*g2p2*Td(i1,i2) + (15*g2p4*Td(i1,i2))/2._dp + (8*g1p2*g3p2*Td(i1,    & 
& i2))/9._dp + 8*g2p2*g3p2*Td(i1,i2) - (16*g3p4*Td(i1,i2))/9._dp - (2*g1p2*TrYdadjYd*Td(i1,& 
& i2))/5._dp + 16*g3p2*TrYdadjYd*Td(i1,i2) - 9*TrYdadjYdYdadjYd*Td(i1,i2) -              & 
&  3*TrYdadjYuYuadjYd*Td(i1,i2) + (6*g1p2*TrYeadjYe*Td(i1,i2))/5._dp - 3*TrYeadjYeYeadjYe*Td(i1,i2)
End Do
End Do

 
DTd = oo16pi2*( betaTd1 + oo16pi2 * betaTd2 ) 

 
Else 
DTd = oo16pi2* betaTd1 
End If 
 
 
Call Chop(DTd) 

!-------------------- 
! Te 
!-------------------- 
 
betaTe1 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTe1(i1,i2) = 5*TeadjYeYe(i1,i2) - TeCL11L11(i1,i2) - TeCL12L12(i1,i2) - TeCL13L13(i1,              & 
& i2) + 3*TeCL21TpL21(i1,i2) + 3*TeCL22TpL22(i1,i2) + 3*TeCL23TpL23(i1,i2) +             & 
&  (18*g1p2*M1*Ye(i1,i2))/5._dp + 6*g2p2*M2*Ye(i1,i2) + 6*TradjYdTd*Ye(i1,               & 
& i2) + 2*TradjYeTe*Ye(i1,i2) + 4*YeadjYeTe(i1,i2) - 2*YeCL11T11(i1,i2) - 2*YeCL12T12(i1,& 
& i2) - 2*YeCL13T13(i1,i2) + 6*YeCL21TpT21(i1,i2) + 6*YeCL22TpT22(i1,i2) +               & 
&  6*YeCL23TpT23(i1,i2) - (9*g1p2*Te(i1,i2))/5._dp - 3*g2p2*Te(i1,i2) + 3*TrYdadjYd*Te(i1,& 
& i2) + TrYeadjYe*Te(i1,i2)
If (1.eq.i1) Then 
betaTe1(i1,i2) = betaTe1(i1,i2)-2*L11CL11TpTe(i2,1) - 2*L11CL12TpTe(i2,2) - 2*L11CL13TpTe(i2,3) - 6*L11CL21TpTd(i2,  & 
& 1) - 6*L11CL22TpTd(i2,2) - 6*L11CL23TpTd(i2,3) + 3*YdadjL21T11(1,i2) + 3*YdadjL22T11(2,& 
& i2) + 3*YdadjL23T11(3,i2) - 2*TrCL11T11*Ye(1,i2) - 2*TrCL12T11*Ye(2,i2) -              & 
&  2*TrCL13T11*Ye(3,i2) - YeCL11T11(1,i2) - YeCL12T11(2,i2) - YeCL13T11(3,               & 
& i2) - TrCL11L11*Te(1,i2) - TrCL12L11*Te(2,i2) - TrCL13L11*Te(3,i2)
End If 
If (2.eq.i1) Then 
betaTe1(i1,i2) = betaTe1(i1,i2)-2*L12CL11TpTe(i2,1) - 2*L12CL12TpTe(i2,2) - 2*L12CL13TpTe(i2,3) - 6*L12CL21TpTd(i2,  & 
& 1) - 6*L12CL22TpTd(i2,2) - 6*L12CL23TpTd(i2,3) + 3*YdadjL21T12(1,i2) + 3*YdadjL22T12(2,& 
& i2) + 3*YdadjL23T12(3,i2) - 2*TrCL11T12*Ye(1,i2) - 2*TrCL12T12*Ye(2,i2) -              & 
&  2*TrCL13T12*Ye(3,i2) - YeCL11T12(1,i2) - YeCL12T12(2,i2) - YeCL13T12(3,               & 
& i2) - TrCL11L12*Te(1,i2) - TrCL12L12*Te(2,i2) - TrCL13L12*Te(3,i2)
End If 
If (3.eq.i1) Then 
betaTe1(i1,i2) = betaTe1(i1,i2)-2*L13CL11TpTe(i2,1) - 2*L13CL12TpTe(i2,2) - 2*L13CL13TpTe(i2,3) - 6*L13CL21TpTd(i2,  & 
& 1) - 6*L13CL22TpTd(i2,2) - 6*L13CL23TpTd(i2,3) + 3*YdadjL21T13(1,i2) + 3*YdadjL22T13(2,& 
& i2) + 3*YdadjL23T13(3,i2) - 2*TrCL11T13*Ye(1,i2) - 2*TrCL12T13*Ye(2,i2) -              & 
&  2*TrCL13T13*Ye(3,i2) - YeCL11T13(1,i2) - YeCL12T13(2,i2) - YeCL13T13(3,               & 
& i2) - TrCL11L13*Te(1,i2) - TrCL12L13*Te(2,i2) - TrCL13L13*Te(3,i2)
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betaTe2 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betaTe2(i1,i2) = (-6*g1p2*TeadjYeYe(i1,i2))/5._dp + 12*g2p2*TeadjYeYe(i1,i2) - 15*TrYdadjYd*TeadjYeYe(i1,& 
& i2) - 5*TrYeadjYe*TeadjYeYe(i1,i2) - 6*TeadjYeYeadjYeYe(i1,i2) - 54*g1p4*M1*Ye(i1,     & 
& i2) - (18*g1p2*g2p2*M1*Ye(i1,i2))/5._dp - (18*g1p2*g2p2*M2*Ye(i1,i2))/5._dp -          & 
&  30*g2p4*M2*Ye(i1,i2) - (4*g1p2*TradjYdTd*Ye(i1,i2))/5._dp + 32*g3p2*TradjYdTd*Ye(i1,  & 
& i2) + (12*g1p2*TradjYeTe*Ye(i1,i2))/5._dp + (4*g1p2*M1*TrYdadjYd*Ye(i1,i2))/5._dp -    & 
&  32*g3p2*M3*TrYdadjYd*Ye(i1,i2) - 36*TrYdadjYdTdadjYd*Ye(i1,i2) - 6*TrYdadjYuTuadjYd*Ye(i1,& 
& i2) - (12*g1p2*M1*TrYeadjYe*Ye(i1,i2))/5._dp - 12*TrYeadjYeTeadjYe*Ye(i1,              & 
& i2) - 6*TrYuadjYdTdadjYu*Ye(i1,i2) + (6*g1p2*YeadjYeTe(i1,i2))/5._dp + 6*g2p2*YeadjYeTe(i1,& 
& i2) - 12*TrYdadjYd*YeadjYeTe(i1,i2) - 4*TrYeadjYe*YeadjYeTe(i1,i2) - 8*YeadjYeTeadjYeYe(i1,& 
& i2) - 12*g2p2*M2*YeadjYeYe(i1,i2) - 18*TradjYdTd*YeadjYeYe(i1,i2) - 6*TradjYeTe*YeadjYeYe(i1,& 
& i2) - 6*YeadjYeYeadjYeTe(i1,i2) + (27*g1p4*Te(i1,i2))/2._dp + (9*g1p2*g2p2*Te(i1,      & 
& i2))/5._dp + (15*g2p4*Te(i1,i2))/2._dp - (2*g1p2*TrYdadjYd*Te(i1,i2))/5._dp +          & 
&  16*g3p2*TrYdadjYd*Te(i1,i2) - 9*TrYdadjYdYdadjYd*Te(i1,i2) - 3*TrYdadjYuYuadjYd*Te(i1,& 
& i2) + (6*g1p2*TrYeadjYe*Te(i1,i2))/5._dp - 3*TrYeadjYeYeadjYe*Te(i1,i2)
End Do
End Do

 
DTe = oo16pi2*( betaTe1 + oo16pi2 * betaTe2 ) 

 
Else 
DTe = oo16pi2* betaTe1 
End If 
 
 
Call Chop(DTe) 

!-------------------- 
! T1 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaT11(i1,i2,1) = 2*L11adjYeTe(i1,i2) - 3*L11CL11T11(i1,i2) - 2*L11CL12T12(i1,i2) - 2*L11CL13T13(i1,    & 
& i2) + 6*L11CL21TpT21(i1,i2) + 6*L11CL22TpT22(i1,i2) + 6*L11CL23TpT23(i1,               & 
& i2) - L12CL12T11(i1,i2) - L13CL13T11(i1,i2) + 3*L21adjL21T11(i1,i2) + 3*L22adjL22T11(i1,& 
& i2) + 3*L23adjL23T11(i1,i2) + T11adjYeYe(i1,i2) - 3*T11CL11L11(i1,i2) - T11CL12L12(i1, & 
& i2) - T11CL13L13(i1,i2) + 3*T11CL21TpL21(i1,i2) + 3*T11CL22TpL22(i1,i2) +              & 
&  3*T11CL23TpL23(i1,i2) - 2*T12CL12L11(i1,i2) - 2*T13CL13L11(i1,i2) + 6*T21adjL21L11(i1,& 
& i2) + 6*T22adjL22L11(i1,i2) + 6*T23adjL23L11(i1,i2) + 2*TpTeCYeL11(i1,i2) +            & 
&  TpYeCYeT11(i1,i2) + (18*g1p2*M1*L11(i1,i2))/5._dp + 6*g2p2*M2*L11(i1,i2) -            & 
&  2*TrCL11T11*L11(i1,i2) - 2*TrCL12T11*L12(i1,i2) - 2*TrCL13T11*L13(i1,i2) -            & 
&  (9*g1p2*T11(i1,i2))/5._dp - 3*g2p2*T11(i1,i2) - TrCL11L11*T11(i1,i2) - TrCL12L11*T12(i1,& 
& i2) - TrCL13L11*T13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT11(i1,i2,2) = -L11CL11T12(i1,i2) + 2*L12adjYeTe(i1,i2) - 2*L12CL11T11(i1,i2) - 3*L12CL12T12(i1,     & 
& i2) - 2*L12CL13T13(i1,i2) + 6*L12CL21TpT21(i1,i2) + 6*L12CL22TpT22(i1,i2) +            & 
&  6*L12CL23TpT23(i1,i2) - L13CL13T12(i1,i2) + 3*L21adjL21T12(i1,i2) + 3*L22adjL22T12(i1,& 
& i2) + 3*L23adjL23T12(i1,i2) - 2*T11CL11L12(i1,i2) + T12adjYeYe(i1,i2) - T12CL11L11(i1, & 
& i2) - 3*T12CL12L12(i1,i2) - T12CL13L13(i1,i2) + 3*T12CL21TpL21(i1,i2) + 3*T12CL22TpL22(i1,& 
& i2) + 3*T12CL23TpL23(i1,i2) - 2*T13CL13L12(i1,i2) + 6*T21adjL21L12(i1,i2) +            & 
&  6*T22adjL22L12(i1,i2) + 6*T23adjL23L12(i1,i2) + 2*TpTeCYeL12(i1,i2) + TpYeCYeT12(i1,  & 
& i2) - 2*TrCL11T12*L11(i1,i2) + (18*g1p2*M1*L12(i1,i2))/5._dp + 6*g2p2*M2*L12(i1,       & 
& i2) - 2*TrCL12T12*L12(i1,i2) - 2*TrCL13T12*L13(i1,i2) - TrCL11L12*T11(i1,              & 
& i2) - (9*g1p2*T12(i1,i2))/5._dp - 3*g2p2*T12(i1,i2) - TrCL12L12*T12(i1,i2) -           & 
&  TrCL13L12*T13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT11(i1,i2,3) = -L11CL11T13(i1,i2) - L12CL12T13(i1,i2) + 2*L13adjYeTe(i1,i2) - 2*L13CL11T11(i1,       & 
& i2) - 2*L13CL12T12(i1,i2) - 3*L13CL13T13(i1,i2) + 6*L13CL21TpT21(i1,i2) +              & 
&  6*L13CL22TpT22(i1,i2) + 6*L13CL23TpT23(i1,i2) + 3*L21adjL21T13(i1,i2) +               & 
&  3*L22adjL22T13(i1,i2) + 3*L23adjL23T13(i1,i2) - 2*T11CL11L13(i1,i2) - 2*T12CL12L13(i1,& 
& i2) + T13adjYeYe(i1,i2) - T13CL11L11(i1,i2) - T13CL12L12(i1,i2) - 3*T13CL13L13(i1,     & 
& i2) + 3*T13CL21TpL21(i1,i2) + 3*T13CL22TpL22(i1,i2) + 3*T13CL23TpL23(i1,               & 
& i2) + 6*T21adjL21L13(i1,i2) + 6*T22adjL22L13(i1,i2) + 6*T23adjL23L13(i1,               & 
& i2) + 2*TpTeCYeL13(i1,i2) + TpYeCYeT13(i1,i2) - 2*TrCL11T13*L11(i1,i2) -               & 
&  2*TrCL12T13*L12(i1,i2) + (18*g1p2*M1*L13(i1,i2))/5._dp + 6*g2p2*M2*L13(i1,            & 
& i2) - 2*TrCL13T13*L13(i1,i2) - TrCL11L13*T11(i1,i2) - TrCL12L13*T12(i1,i2) -           & 
&  (9*g1p2*T13(i1,i2))/5._dp - 3*g2p2*T13(i1,i2) - TrCL13L13*T13(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT11(i1,i2,i3) = betaT11(i1,i2,i3)-6*CYdTpT21(1,i2)*Ye(i3,i1) - 6*CYdTpT22(2,i2)*Ye(i3,i1) - 6*CYdTpT23(3,              & 
& i2)*Ye(i3,i1) + 2*CYeT11(1,i2)*Ye(i3,i1) + 2*CYeT12(2,i2)*Ye(i3,i1) + 2*CYeT13(3,      & 
& i2)*Ye(i3,i1) + 6*CYdTpT21(1,i1)*Ye(i3,i2) + 6*CYdTpT22(2,i1)*Ye(i3,i2) +              & 
&  6*CYdTpT23(3,i1)*Ye(i3,i2) - 2*CYeT11(1,i1)*Ye(i3,i2) - 2*CYeT12(2,i1)*Ye(i3,         & 
& i2) - 2*CYeT13(3,i1)*Ye(i3,i2) + 4*CYeTpTe(1,i3)*L11(i1,i2) + 4*CYeTpTe(2,             & 
& i3)*L12(i1,i2) + 4*CYeTpTe(3,i3)*L13(i1,i2) - 3*CYdTpL21(1,i2)*Te(i3,i1) -             & 
&  3*CYdTpL22(2,i2)*Te(i3,i1) - 3*CYdTpL23(3,i2)*Te(i3,i1) + CYeL11(1,i2)*Te(i3,         & 
& i1) + CYeL12(2,i2)*Te(i3,i1) + CYeL13(3,i2)*Te(i3,i1) + 3*CYdTpL21(1,i1)*Te(i3,        & 
& i2) + 3*CYdTpL22(2,i1)*Te(i3,i2) + 3*CYdTpL23(3,i1)*Te(i3,i2) - CYeL11(1,              & 
& i1)*Te(i3,i2) - CYeL12(2,i1)*Te(i3,i2) - CYeL13(3,i1)*Te(i3,i2) + 2*YeadjYe(i3,        & 
& 1)*T11(i1,i2) + 2*YeadjYe(i3,2)*T12(i1,i2) + 2*YeadjYe(i3,3)*T13(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaT12(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT12(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT12(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT12(i1,i2,i3) = betaT12(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DT1 = oo16pi2*( betaT11 + oo16pi2 * betaT12 ) 

 
Else 
DT1 = oo16pi2* betaT11 
End If 
 
 
!-------------------- 
! T2 
!-------------------- 
 
Do i1 = 1,3
Do i2 = 1,3
betaT21(i1,i2,1) = -L11CL11T21(i1,i2) - L12CL12T21(i1,i2) - L13CL13T21(i1,i2) + 5*L21adjL21T21(i1,       & 
& i2) + 2*L21adjL22T22(i1,i2) + 2*L21adjL23T23(i1,i2) + 2*L21adjYdTd(i1,i2) +            & 
&  2*L21adjYuTu(i1,i2) + 3*L22adjL22T21(i1,i2) + 3*L23adjL23T21(i1,i2) - 2*T11CL11L21(i1,& 
& i2) - 2*T12CL12L21(i1,i2) - 2*T13CL13L21(i1,i2) + 7*T21adjL21L21(i1,i2) +              & 
&  T21adjL22L22(i1,i2) + T21adjL23L23(i1,i2) + T21adjYdYd(i1,i2) + T21adjYuYu(i1,        & 
& i2) + 6*T22adjL22L21(i1,i2) + 6*T23adjL23L21(i1,i2) + 2*TpTeCYeL21(i1,i2) +            & 
&  TpYeCYeT21(i1,i2) + (14*g1p2*M1*L21(i1,i2))/15._dp + (32*g3p2*M3*L21(i1,              & 
& i2))/3._dp + 6*g2p2*M2*L21(i1,i2) + 4*TradjL21T21*L21(i1,i2) + 4*TradjL22T21*L22(i1,   & 
& i2) + 4*TradjL23T21*L23(i1,i2) - (7*g1p2*T21(i1,i2))/15._dp - 3*g2p2*T21(i1,           & 
& i2) - (16*g3p2*T21(i1,i2))/3._dp + 2*TrCL21TpL21*T21(i1,i2) + 2*TrCL22TpL21*T22(i1,    & 
& i2) + 2*TrCL23TpL21*T23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT21(i1,i2,2) = -L11CL11T22(i1,i2) - L12CL12T22(i1,i2) - L13CL13T22(i1,i2) + 3*L21adjL21T22(i1,       & 
& i2) + 2*L22adjL21T21(i1,i2) + 5*L22adjL22T22(i1,i2) + 2*L22adjL23T23(i1,               & 
& i2) + 2*L22adjYdTd(i1,i2) + 2*L22adjYuTu(i1,i2) + 3*L23adjL23T22(i1,i2) -              & 
&  2*T11CL11L22(i1,i2) - 2*T12CL12L22(i1,i2) - 2*T13CL13L22(i1,i2) + 6*T21adjL21L22(i1,  & 
& i2) + T22adjL21L21(i1,i2) + 7*T22adjL22L22(i1,i2) + T22adjL23L23(i1,i2) +              & 
&  T22adjYdYd(i1,i2) + T22adjYuYu(i1,i2) + 6*T23adjL23L22(i1,i2) + 2*TpTeCYeL22(i1,      & 
& i2) + TpYeCYeT22(i1,i2) + 4*TradjL21T22*L21(i1,i2) + (14*g1p2*M1*L22(i1,               & 
& i2))/15._dp + (32*g3p2*M3*L22(i1,i2))/3._dp + 6*g2p2*M2*L22(i1,i2) + 4*TradjL22T22*L22(i1,& 
& i2) + 4*TradjL23T22*L23(i1,i2) + 2*TrCL21TpL22*T21(i1,i2) - (7*g1p2*T22(i1,            & 
& i2))/15._dp - 3*g2p2*T22(i1,i2) - (16*g3p2*T22(i1,i2))/3._dp + 2*TrCL22TpL22*T22(i1,   & 
& i2) + 2*TrCL23TpL22*T23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT21(i1,i2,3) = -L11CL11T23(i1,i2) - L12CL12T23(i1,i2) - L13CL13T23(i1,i2) + 3*L21adjL21T23(i1,       & 
& i2) + 3*L22adjL22T23(i1,i2) + 2*L23adjL21T21(i1,i2) + 2*L23adjL22T22(i1,               & 
& i2) + 5*L23adjL23T23(i1,i2) + 2*L23adjYdTd(i1,i2) + 2*L23adjYuTu(i1,i2) -              & 
&  2*T11CL11L23(i1,i2) - 2*T12CL12L23(i1,i2) - 2*T13CL13L23(i1,i2) + 6*T21adjL21L23(i1,  & 
& i2) + 6*T22adjL22L23(i1,i2) + T23adjL21L21(i1,i2) + T23adjL22L22(i1,i2) +              & 
&  7*T23adjL23L23(i1,i2) + T23adjYdYd(i1,i2) + T23adjYuYu(i1,i2) + 2*TpTeCYeL23(i1,      & 
& i2) + TpYeCYeT23(i1,i2) + 4*TradjL21T23*L21(i1,i2) + 4*TradjL22T23*L22(i1,             & 
& i2) + (14*g1p2*M1*L23(i1,i2))/15._dp + (32*g3p2*M3*L23(i1,i2))/3._dp + 6*g2p2*M2*L23(i1,& 
& i2) + 4*TradjL23T23*L23(i1,i2) + 2*TrCL21TpL23*T21(i1,i2) + 2*TrCL22TpL23*T22(i1,      & 
& i2) - (7*g1p2*T23(i1,i2))/15._dp - 3*g2p2*T23(i1,i2) - (16*g3p2*T23(i1,i2))/3._dp +    & 
&  2*TrCL23TpL23*T23(i1,i2)
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT21(i1,i2,i3) = betaT21(i1,i2,i3)+6*CYdTpT21(1,i1)*Yd(i3,i2) + 6*CYdTpT22(2,i1)*Yd(i3,i2) + 6*CYdTpT23(3,               & 
& i1)*Yd(i3,i2) - 2*CYeT11(1,i1)*Yd(i3,i2) - 2*CYeT12(2,i1)*Yd(i3,i2) - 2*CYeT13(3,      & 
& i1)*Yd(i3,i2) + 4*CYdTpTd(1,i3)*L21(i1,i2) + 4*CYdTpTd(2,i3)*L22(i1,i2) +              & 
&  4*CYdTpTd(3,i3)*L23(i1,i2) + 3*CYdTpL21(1,i1)*Td(i3,i2) + 3*CYdTpL22(2,               & 
& i1)*Td(i3,i2) + 3*CYdTpL23(3,i1)*Td(i3,i2) - CYeL11(1,i1)*Td(i3,i2) - CYeL12(2,        & 
& i1)*Td(i3,i2) - CYeL13(3,i1)*Td(i3,i2) + 2*YdadjYd(i3,1)*T21(i1,i2) + 2*YdadjYd(i3,    & 
& 2)*T22(i1,i2) + 2*YdadjYd(i3,3)*T23(i1,i2)
End Do
End Do
End Do

 
 
If (TwoLoopRGE) Then 
Do i1 = 1,3
Do i2 = 1,3
betaT22(i1,i2,1) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT22(i1,i2,2) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
betaT22(i1,i2,3) = 0
End Do
End Do
Do i1 = 1,3
Do i2 = 1,3
Do i3 = 1,3
betaT22(i1,i2,i3) = betaT22(i1,i2,i3)+(0)
End Do
End Do
End Do

 
DT2 = oo16pi2*( betaT21 + oo16pi2 * betaT22 ) 

 
Else 
DT2 = oo16pi2* betaT21 
End If 
 
 
!-------------------- 
! Tu 
!-------------------- 
 
betaTu1  = TuadjL21L21 + TuadjL22L22 + TuadjL23L23 + TuadjYdYd + 5._dp*(TuadjYuYu)    & 
&  + (26*g1p2*M1*Yu)/15._dp + (32*g3p2*M3*Yu)/3._dp + 6*g2p2*M2*Yu + 6*TradjYuTu*Yu +    & 
&  2._dp*(YuadjL21T21) + 2._dp*(YuadjL22T22) + 2._dp*(YuadjL23T23) + 2._dp*(YuadjYdTd)   & 
&  + 4._dp*(YuadjYuTu) - (13*g1p2*Tu)/15._dp - 3*g2p2*Tu - (16*g3p2*Tu)/3._dp +          & 
&  3*TrYuadjYu*Tu

 
 
If (TwoLoopRGE) Then 
betaTu2 = (2*g1p2*TuadjYdYd)/5._dp - 3*TrYdadjYd*TuadjYdYd - TrYeadjYe*TuadjYdYd -              & 
&  2._dp*(TuadjYdYdadjYdYd) - 4._dp*(TuadjYdYdadjYuYu) + 12*g2p2*TuadjYuYu -             & 
&  15*TrYuadjYu*TuadjYuYu - 6._dp*(TuadjYuYuadjYuYu) - (5486*g1p4*M1*Yu)/225._dp -       & 
&  2*g1p2*g2p2*M1*Yu - (272*g1p2*g3p2*M1*Yu)/45._dp - (272*g1p2*g3p2*M3*Yu)/45._dp -     & 
&  16*g2p2*g3p2*M3*Yu + (64*g3p4*M3*Yu)/9._dp - 2*g1p2*g2p2*M2*Yu - 30*g2p4*M2*Yu -      & 
&  16*g2p2*g3p2*M2*Yu + (8*g1p2*TradjYuTu*Yu)/5._dp + 32*g3p2*TradjYuTu*Yu -             & 
&  6*TrYdadjYuTuadjYd*Yu - 6*TrYuadjYdTdadjYu*Yu - (8*g1p2*M1*TrYuadjYu*Yu)/5._dp -      & 
&  32*g3p2*M3*TrYuadjYu*Yu - 36*TrYuadjYuTuadjYu*Yu + (4*g1p2*YuadjYdTd)/5._dp -         & 
&  6*TrYdadjYd*YuadjYdTd - 2*TrYeadjYe*YuadjYdTd - 4._dp*(YuadjYdTdadjYdYd) -            & 
&  4._dp*(YuadjYdTdadjYuYu) - (4*g1p2*M1*YuadjYdYd)/5._dp - 6*TradjYdTd*YuadjYdYd -      & 
&  2*TradjYeTe*YuadjYdYd - 4._dp*(YuadjYdYdadjYdTd) - 2._dp*(YuadjYdYdadjYuTu) +         & 
&  (6*g1p2*YuadjYuTu)/5._dp + 6*g2p2*YuadjYuTu - 12*TrYuadjYu*YuadjYuTu - 8._dp*(YuadjYuTuadjYuYu) -& 
&  (4*g1p2*M1*YuadjYuYu)/5._dp - 12*g2p2*M2*YuadjYuYu - 18*TradjYuTu*YuadjYuYu -         & 
&  6._dp*(YuadjYuYuadjYuTu) + (2743*g1p4*Tu)/450._dp + g1p2*g2p2*Tu + (15*g2p4*Tu)/2._dp +& 
&  (136*g1p2*g3p2*Tu)/45._dp + 8*g2p2*g3p2*Tu - (16*g3p4*Tu)/9._dp - 3*TrYdadjYuYuadjYd*Tu +& 
&  (4*g1p2*TrYuadjYu*Tu)/5._dp + 16*g3p2*TrYuadjYu*Tu - 9*TrYuadjYuYuadjYu*Tu

 
DTu = oo16pi2*( betaTu1 + oo16pi2 * betaTu2 ) 

 
Else 
DTu = oo16pi2* betaTu1 
End If 
 
 
Call Chop(DTu) 

!-------------------- 
! Bmu 
!-------------------- 
 
betaBmu1  = (6*g1p2*M1*Mu)/5._dp + 6*g2p2*M2*Mu + 6*TradjYdTd*Mu + 2*TradjYeTe*Mu +   & 
&  6*TradjYuTu*Mu - (3*g1p2*Bmu)/5._dp - 3*g2p2*Bmu + 3*TrYdadjYd*Bmu + TrYeadjYe*Bmu +  & 
&  3*TrYuadjYu*Bmu

 
 
If (TwoLoopRGE) Then 
betaBmu2 = (-414*g1p4*M1*Mu)/25._dp - (18*g1p2*g2p2*M1*Mu)/5._dp - (18*g1p2*g2p2*M2*Mu)/5._dp -  & 
&  30*g2p4*M2*Mu - (4*g1p2*TradjYdTd*Mu)/5._dp + 32*g3p2*TradjYdTd*Mu + (12*g1p2*TradjYeTe*Mu)/5._dp +& 
&  (8*g1p2*TradjYuTu*Mu)/5._dp + 32*g3p2*TradjYuTu*Mu + (4*g1p2*M1*TrYdadjYd*Mu)/5._dp - & 
&  32*g3p2*M3*TrYdadjYd*Mu - 36*TrYdadjYdTdadjYd*Mu - 12*TrYdadjYuTuadjYd*Mu -           & 
&  (12*g1p2*M1*TrYeadjYe*Mu)/5._dp - 12*TrYeadjYeTeadjYe*Mu - 12*TrYuadjYdTdadjYu*Mu -   & 
&  (8*g1p2*M1*TrYuadjYu*Mu)/5._dp - 32*g3p2*M3*TrYuadjYu*Mu - 36*TrYuadjYuTuadjYu*Mu +   & 
&  (207*g1p4*Bmu)/50._dp + (9*g1p2*g2p2*Bmu)/5._dp + (15*g2p4*Bmu)/2._dp -               & 
&  (2*g1p2*TrYdadjYd*Bmu)/5._dp + 16*g3p2*TrYdadjYd*Bmu - 9*TrYdadjYdYdadjYd*Bmu -       & 
&  6*TrYdadjYuYuadjYd*Bmu + (6*g1p2*TrYeadjYe*Bmu)/5._dp - 3*TrYeadjYeYeadjYe*Bmu +      & 
&  (4*g1p2*TrYuadjYu*Bmu)/5._dp + 16*g3p2*TrYuadjYu*Bmu - 9*TrYuadjYuYuadjYu*Bmu

 
DBmu = oo16pi2*( betaBmu1 + oo16pi2 * betaBmu2 ) 

 
Else 
DBmu = oo16pi2* betaBmu1 
End If 
 
 
Call Chop(DBmu) 

!-------------------- 
! mq2 
!-------------------- 
 
betamq21  = 2._dp*(adjL21Cml2L21) + adjL21L21mq2 + 2._dp*(adjL22Cml2L22)              & 
&  + adjL22L22mq2 + 2._dp*(adjL23Cml2L23) + adjL23L23mq2 + 2._dp*(adjT21T21)             & 
&  + 2._dp*(adjT22T22) + 2._dp*(adjT23T23) + 2._dp*(adjTdTd) + 2._dp*(adjTuTu)           & 
&  + 2._dp*(adjYdmd2Yd) + adjYdYdmq2 + 2._dp*(adjYumu2Yu) + adjYuYumq2 - (2*AbsM1*g1p2*id3R)& 
& /15._dp - 6*AbsM2*g2p2*id3R - (32*AbsM3*g3p2*id3R)/3._dp + 2*adjYdYd*mHd2 +            & 
&  2*adjYuYu*mHu2 + mq2adjL21L21 + mq2adjL22L22 + mq2adjL23L23 + mq2adjYdYd +            & 
&  mq2adjYuYu + 2*adjL21L21*md2(1,1) + 2*adjL21L22*md2(1,2) + 2*adjL21L23*md2(1,         & 
& 3) + 2*adjL22L21*md2(2,1) + 2*adjL22L22*md2(2,2) + 2*adjL22L23*md2(2,3) +              & 
&  2*adjL23L21*md2(3,1) + 2*adjL23L22*md2(3,2) + 2*adjL23L23*md2(3,3) + g1*id3R*ooSqrt15*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamq22 = -4._dp*(adjTdTdadjYdYd) - 4._dp*(adjTdYdadjYdTd) - 4._dp*(adjTuTuadjYuYu) -           & 
&  4._dp*(adjTuYuadjYuTu) - 4._dp*(adjYdmd2YdadjYdYd) - 4._dp*(adjYdTdadjTdYd) -         & 
&  4._dp*(adjYdYdadjTdTd) - 4._dp*(adjYdYdadjYdmd2Yd) - 2._dp*(adjYdYdadjYdYdmq2) -      & 
&  4._dp*(adjYdYdmq2adjYdYd) - 4._dp*(adjYumu2YuadjYuYu) - 4._dp*(adjYuTuadjTuYu) -      & 
&  4._dp*(adjYuYuadjTuTu) - 4._dp*(adjYuYuadjYumu2Yu) - 2._dp*(adjYuYuadjYuYumq2) -      & 
&  4._dp*(adjYuYumq2adjYuYu) + (4*adjTdTd*g1p2)/5._dp + (8*adjTuTu*g1p2)/5._dp +         & 
&  (4*adjYdmd2Yd*g1p2)/5._dp + (8*AbsM1*adjYdYd*g1p2)/5._dp + (2*adjYdYdmq2*g1p2)/5._dp +& 
&  (8*adjYumu2Yu*g1p2)/5._dp + (16*AbsM1*adjYuYu*g1p2)/5._dp + (4*adjYuYumq2*g1p2)/5._dp +& 
&  (199*AbsM1*g1p4*id3R)/75._dp + (2*AbsM1*g1p2*g2p2*id3R)/5._dp + (2*AbsM2*g1p2*g2p2*id3R)/5._dp +& 
&  33*AbsM2*g2p4*id3R + (32*AbsM1*g1p2*g3p2*id3R)/45._dp + (32*AbsM3*g1p2*g3p2*id3R)/45._dp +& 
&  32*AbsM2*g2p2*g3p2*id3R + 32*AbsM3*g2p2*g3p2*id3R - (128*AbsM3*g3p4*id3R)/3._dp -     & 
&  (4*adjTdYd*g1p2*M1)/5._dp - (8*adjTuYu*g1p2*M1)/5._dp - 8*adjYdYdadjYdYd*mHd2 +       & 
&  (4*adjYdYd*g1p2*mHd2)/5._dp - 8*adjYuYuadjYuYu*mHu2 + (8*adjYuYu*g1p2*mHu2)/5._dp +   & 
&  (2*g1p2*mq2adjYdYd)/5._dp - 2._dp*(mq2adjYdYdadjYdYd) + (4*g1p2*mq2adjYuYu)/5._dp -   & 
&  2._dp*(mq2adjYuYuadjYuYu) - 6*adjTdYd*TradjYdTd - 2*adjTdYd*TradjYeTe -               & 
&  6*adjTuYu*TradjYuTu - 6*adjYdYd*TrCTdTpTd - 6*adjYdTd*TrCTdTpYd - 2*adjYdYd*TrCTeTpTe -& 
&  2*adjYdTd*TrCTeTpYe - 6*adjYuYu*TrCTuTpTu - 6*adjYuTu*TrCTuTpYu - 6*adjYdYd*Trmd2YdadjYd -& 
&  2*adjYdYd*Trme2YeadjYe - 2*adjYdYd*Trml2adjYeYe - 6*adjYdYd*Trmq2adjYdYd -            & 
&  6*adjYuYu*Trmq2adjYuYu - 6*adjYuYu*Trmu2YuadjYu - 6*adjTdTd*TrYdadjYd -               & 
&  6*adjYdmd2Yd*TrYdadjYd - 3*adjYdYdmq2*TrYdadjYd - 12*adjYdYd*mHd2*TrYdadjYd -         & 
&  3*mq2adjYdYd*TrYdadjYd - 2*adjTdTd*TrYeadjYe - 2*adjYdmd2Yd*TrYeadjYe  
betamq22 =  betamq22- adjYdYdmq2*TrYeadjYe - 4*adjYdYd*mHd2*TrYeadjYe - mq2adjYdYd*TrYeadjYe -              & 
&  6*adjTuTu*TrYuadjYu - 6*adjYumu2Yu*TrYuadjYu - 3*adjYuYumq2*TrYuadjYu -               & 
&  12*adjYuYu*mHu2*TrYuadjYu - 3*mq2adjYuYu*TrYuadjYu - (4*adjYdTd*g1p2*Conjg(M1))/5._dp -& 
&  (8*adjYuTu*g1p2*Conjg(M1))/5._dp + (16*g1p2*g3p2*id3R*M3*Conjg(M1))/45._dp +          & 
&  (g1p2*g2p2*id3R*M2*Conjg(M1))/5._dp + (16*g1p2*g3p2*id3R*M1*Conjg(M3))/45._dp +       & 
&  16*g2p2*g3p2*id3R*M2*Conjg(M3) + (g1p2*g2p2*id3R*M1*Conjg(M2))/5._dp + 16*g2p2*g3p2*id3R*M3*Conjg(M2) +& 
&  6*g2p4*id3R*Tr2(2) + (32*g3p4*id3R*Tr2(3))/3._dp + (2*g1p2*id3R*Tr2U1(1,              & 
& 1))/15._dp + 4*g1*id3R*ooSqrt15*Tr3(1)

 
Dmq2 = oo16pi2*( betamq21 + oo16pi2 * betamq22 ) 

 
Else 
Dmq2 = oo16pi2* betamq21 
End If 
 
 
Call Chop(Dmq2) 

Forall(i1=1:3) Dmq2(i1,i1) =  Real(Dmq2(i1,i1),dp) 
Dmq2 = 0.5_dp*(Dmq2+ Conjg(Transpose(Dmq2)) ) 
!-------------------- 
! ml2 
!-------------------- 
 
betaml21  = 2._dp*(adjTeTe) + 2._dp*(adjYeme2Ye) + adjYeYeml2 - 2._dp*(CL11Cml2L11)   & 
&  - CL11L11ml2 - 2._dp*(CL12Cml2L12) - CL12L12ml2 - 2._dp*(CL13Cml2L13) -               & 
&  CL13L13ml2 + 6._dp*(CL21Cmq2TpL21) + 3._dp*(CL21TpL21ml2) + 6._dp*(CL22Cmq2TpL22)     & 
&  + 3._dp*(CL22TpL22ml2) + 6._dp*(CL23Cmq2TpL23) + 3._dp*(CL23TpL23ml2) -               & 
&  2._dp*(CT11T11) - 2._dp*(CT12T12) - 2._dp*(CT13T13) + 6._dp*(CT21TpT21)               & 
&  + 6._dp*(CT22TpT22) + 6._dp*(CT23TpT23) - (6*AbsM1*g1p2*id3R)/5._dp - 6*AbsM2*g2p2*id3R +& 
&  2*adjYeYe*mHd2 + ml2adjYeYe - ml2CL11L11 - ml2CL12L12 - ml2CL13L13 + 3._dp*(ml2CL21TpL21)& 
&  + 3._dp*(ml2CL22TpL22) + 3._dp*(ml2CL23TpL23) + 6*CL21TpL21*md2(1,1) + 6*CL21TpL22*md2(1,& 
& 2) + 6*CL21TpL23*md2(1,3) + 6*CL22TpL21*md2(2,1) + 6*CL22TpL22*md2(2,2) +              & 
&  6*CL22TpL23*md2(2,3) + 6*CL23TpL21*md2(3,1) + 6*CL23TpL22*md2(3,2) + 6*CL23TpL23*md2(3,& 
& 3) - 2*CL11L11*me2(1,1) - 2*CL11L12*me2(1,2) - 2*CL11L13*me2(1,3) - 2*CL12L11*me2(2,   & 
& 1) - 2*CL12L12*me2(2,2) - 2*CL12L13*me2(2,3) - 2*CL13L11*me2(3,1) - 2*CL13L12*me2(3,   & 
& 2) - 2*CL13L13*me2(3,3) - g1*id3R*sqrt3ov5*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betaml22 = -4._dp*(adjTeTeadjYeYe) - 4._dp*(adjTeYeadjYeTe) - 4._dp*(adjYeme2YeadjYeYe) -        & 
&  4._dp*(adjYeTeadjTeYe) - 4._dp*(adjYeYeadjTeTe) - 4._dp*(adjYeYeadjYeme2Ye) -         & 
&  2._dp*(adjYeYeadjYeYeml2) - 4._dp*(adjYeYeml2adjYeYe) + (12*adjTeTe*g1p2)/5._dp +     & 
&  (12*adjYeme2Ye*g1p2)/5._dp + (24*AbsM1*adjYeYe*g1p2)/5._dp + (6*adjYeYeml2*g1p2)/5._dp +& 
&  (621*AbsM1*g1p4*id3R)/25._dp + (18*AbsM1*g1p2*g2p2*id3R)/5._dp + (18*AbsM2*g1p2*g2p2*id3R)/5._dp +& 
&  33*AbsM2*g2p4*id3R - (12*adjTeYe*g1p2*M1)/5._dp - 8*adjYeYeadjYeYe*mHd2 +             & 
&  (12*adjYeYe*g1p2*mHd2)/5._dp + (6*g1p2*ml2adjYeYe)/5._dp - 2._dp*(ml2adjYeYeadjYeYe) -& 
&  6*adjTeYe*TradjYdTd - 2*adjTeYe*TradjYeTe - 6*adjYeYe*TrCTdTpTd - 6*adjYeTe*TrCTdTpYd -& 
&  2*adjYeYe*TrCTeTpTe - 2*adjYeTe*TrCTeTpYe - 6*adjYeYe*Trmd2YdadjYd - 2*adjYeYe*Trme2YeadjYe -& 
&  2*adjYeYe*Trml2adjYeYe - 6*adjYeYe*Trmq2adjYdYd - 6*adjTeTe*TrYdadjYd -               & 
&  6*adjYeme2Ye*TrYdadjYd - 3*adjYeYeml2*TrYdadjYd - 12*adjYeYe*mHd2*TrYdadjYd -         & 
&  3*ml2adjYeYe*TrYdadjYd - 2*adjTeTe*TrYeadjYe - 2*adjYeme2Ye*TrYeadjYe -               & 
&  adjYeYeml2*TrYeadjYe - 4*adjYeYe*mHd2*TrYeadjYe - ml2adjYeYe*TrYeadjYe -              & 
&  (12*adjYeTe*g1p2*Conjg(M1))/5._dp + (9*g1p2*g2p2*id3R*M2*Conjg(M1))/5._dp +           & 
&  (9*g1p2*g2p2*id3R*M1*Conjg(M2))/5._dp + 6*g2p4*id3R*Tr2(2) + (6*g1p2*id3R*Tr2U1(1,    & 
& 1))/5._dp - 4*g1*id3R*sqrt3ov5*Tr3(1)

 
Dml2 = oo16pi2*( betaml21 + oo16pi2 * betaml22 ) 

 
Else 
Dml2 = oo16pi2* betaml21 
End If 
 
 
Call Chop(Dml2) 

Forall(i1=1:3) Dml2(i1,i1) =  Real(Dml2(i1,i1),dp) 
Dml2 = 0.5_dp*(Dml2+ Conjg(Transpose(Dml2)) ) 
!-------------------- 
! mHd2 
!-------------------- 
 
betamHd21  = (-6*AbsM1*g1p2)/5._dp - 6*AbsM2*g2p2 + 6._dp*(TrCTdTpTd) +               & 
&  2._dp*(TrCTeTpTe) + 6._dp*(Trmd2YdadjYd) + 2._dp*(Trme2YeadjYe) + 2._dp*(Trml2adjYeYe)& 
&  + 6._dp*(Trmq2adjYdYd) + 6*mHd2*TrYdadjYd + 2*mHd2*TrYeadjYe - g1*sqrt3ov5*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamHd22 = (621*AbsM1*g1p4)/25._dp + (18*AbsM1*g1p2*g2p2)/5._dp + (18*AbsM2*g1p2*g2p2)/5._dp +   & 
&  33*AbsM2*g2p4 - (4*g1p2*TrCTdTpTd)/5._dp + 32*g3p2*TrCTdTpTd + (4*g1p2*M1*TrCTdTpYd)/5._dp -& 
&  32*g3p2*M3*TrCTdTpYd + (12*g1p2*TrCTeTpTe)/5._dp - (12*g1p2*M1*TrCTeTpYe)/5._dp -     & 
&  (4*g1p2*Trmd2YdadjYd)/5._dp + 32*g3p2*Trmd2YdadjYd - 36._dp*(Trmd2YdadjYdYdadjYd) -   & 
&  6._dp*(Trmd2YdadjYuYuadjYd) + (12*g1p2*Trme2YeadjYe)/5._dp - 12._dp*(Trme2YeadjYeYeadjYe) +& 
&  (12*g1p2*Trml2adjYeYe)/5._dp - 12._dp*(Trml2adjYeYeadjYeYe) - (4*g1p2*Trmq2adjYdYd)/5._dp +& 
&  32*g3p2*Trmq2adjYdYd - 36._dp*(Trmq2adjYdYdadjYdYd) - 6._dp*(Trmq2adjYdYdadjYuYu) -   & 
&  6._dp*(Trmq2adjYuYuadjYdYd) - 6._dp*(Trmu2YuadjYdYdadjYu) - 36._dp*(TrYdadjTdTdadjYd) -& 
&  6._dp*(TrYdadjTuTuadjYd) - (8*AbsM1*g1p2*TrYdadjYd)/5._dp + 64*AbsM3*g3p2*TrYdadjYd - & 
&  (4*g1p2*mHd2*TrYdadjYd)/5._dp + 32*g3p2*mHd2*TrYdadjYd - 36._dp*(TrYdadjYdTdadjTd) -  & 
&  36*mHd2*TrYdadjYdYdadjYd - 6._dp*(TrYdadjYuTuadjTd) - 6*mHd2*TrYdadjYuYuadjYd -       & 
&  6*mHu2*TrYdadjYuYuadjYd - 12._dp*(TrYeadjTeTeadjYe) + (24*AbsM1*g1p2*TrYeadjYe)/5._dp +& 
&  (12*g1p2*mHd2*TrYeadjYe)/5._dp - 12._dp*(TrYeadjYeTeadjTe) - 12*mHd2*TrYeadjYeYeadjYe -& 
&  6._dp*(TrYuadjTdTdadjYu) - 6._dp*(TrYuadjYdTdadjTu) + (9*g1p2*g2p2*M2*Conjg(M1))/5._dp +& 
&  (4*g1p2*TradjYdTd*Conjg(M1))/5._dp - (12*g1p2*TradjYeTe*Conjg(M1))/5._dp -            & 
&  32*g3p2*TradjYdTd*Conjg(M3) + (9*g1p2*g2p2*M1*Conjg(M2))/5._dp + 6*g2p4*Tr2(2) +      & 
&  (6*g1p2*Tr2U1(1,1))/5._dp - 4*g1*sqrt3ov5*Tr3(1)

 
DmHd2 = oo16pi2*( betamHd21 + oo16pi2 * betamHd22 ) 

 
Else 
DmHd2 = oo16pi2* betamHd21 
End If 
 
 
!-------------------- 
! mHu2 
!-------------------- 
 
betamHu21  = (-6*AbsM1*g1p2)/5._dp - 6*AbsM2*g2p2 + 6._dp*(TrCTuTpTu) +               & 
&  6._dp*(Trmq2adjYuYu) + 6._dp*(Trmu2YuadjYu) + 6*mHu2*TrYuadjYu + g1*sqrt3ov5*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamHu22 = (621*AbsM1*g1p4)/25._dp + (18*AbsM1*g1p2*g2p2)/5._dp + (18*AbsM2*g1p2*g2p2)/5._dp +   & 
&  33*AbsM2*g2p4 + (8*g1p2*TrCTuTpTu)/5._dp + 32*g3p2*TrCTuTpTu - (8*g1p2*M1*TrCTuTpYu)/5._dp -& 
&  32*g3p2*M3*TrCTuTpYu - 6._dp*(Trmd2YdadjYuYuadjYd) - 6._dp*(Trmq2adjYdYdadjYuYu) +    & 
&  (8*g1p2*Trmq2adjYuYu)/5._dp + 32*g3p2*Trmq2adjYuYu - 6._dp*(Trmq2adjYuYuadjYdYd) -    & 
&  36._dp*(Trmq2adjYuYuadjYuYu) - 6._dp*(Trmu2YuadjYdYdadjYu) + (8*g1p2*Trmu2YuadjYu)/5._dp +& 
&  32*g3p2*Trmu2YuadjYu - 36._dp*(Trmu2YuadjYuYuadjYu) - 6._dp*(TrYdadjTuTuadjYd) -      & 
&  6._dp*(TrYdadjYuTuadjTd) - 6*mHd2*TrYdadjYuYuadjYd - 6*mHu2*TrYdadjYuYuadjYd -        & 
&  6._dp*(TrYuadjTdTdadjYu) - 36._dp*(TrYuadjTuTuadjYu) - 6._dp*(TrYuadjYdTdadjTu) +     & 
&  (16*AbsM1*g1p2*TrYuadjYu)/5._dp + 64*AbsM3*g3p2*TrYuadjYu + (8*g1p2*mHu2*TrYuadjYu)/5._dp +& 
&  32*g3p2*mHu2*TrYuadjYu - 36._dp*(TrYuadjYuTuadjTu) - 36*mHu2*TrYuadjYuYuadjYu +       & 
&  (9*g1p2*g2p2*M2*Conjg(M1))/5._dp - (8*g1p2*TradjYuTu*Conjg(M1))/5._dp -               & 
&  32*g3p2*TradjYuTu*Conjg(M3) + (9*g1p2*g2p2*M1*Conjg(M2))/5._dp + 6*g2p4*Tr2(2) +      & 
&  (6*g1p2*Tr2U1(1,1))/5._dp + 4*g1*sqrt3ov5*Tr3(1)

 
DmHu2 = oo16pi2*( betamHu21 + oo16pi2 * betamHu22 ) 

 
Else 
DmHu2 = oo16pi2* betamHu21 
End If 
 
 
!-------------------- 
! md2 
!-------------------- 
 
betamd21 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betamd21(i1,i2) = 2*md2YdadjYd(i1,i2) + 4*TdadjTd(i1,i2) + 4*mHd2*YdadjYd(i1,i2) + 2*YdadjYdmd2(i1,     & 
& i2) + 4*Ydmq2adjYd(i1,i2)
If (1.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+4*TrCT21TpT21*Kronecker(1,i2) + 4*Trml2CL21TpL21*Kronecker(1,i2) + 4*Trmq2adjL21L21*Kronecker(1,& 
& i2) + 4*TrCT22TpT21*Kronecker(2,i2) + 4*Trml2CL22TpL21*Kronecker(2,i2) +               & 
&  4*Trmq2adjL22L21*Kronecker(2,i2) + 4*TrCT23TpT21*Kronecker(3,i2) + 4*Trml2CL23TpL21*Kronecker(3,& 
& i2) + 4*Trmq2adjL23L21*Kronecker(3,i2) + 2*TrCL21TpL21*md2(1,i2) + 2*TrCL22TpL21*md2(2,& 
& i2) + 2*TrCL23TpL21*md2(3,i2)
End If 
If (2.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+4*TrCT21TpT22*Kronecker(1,i2) + 4*Trml2CL21TpL22*Kronecker(1,i2) + 4*Trmq2adjL21L22*Kronecker(1,& 
& i2) + 4*TrCT22TpT22*Kronecker(2,i2) + 4*Trml2CL22TpL22*Kronecker(2,i2) +               & 
&  4*Trmq2adjL22L22*Kronecker(2,i2) + 4*TrCT23TpT22*Kronecker(3,i2) + 4*Trml2CL23TpL22*Kronecker(3,& 
& i2) + 4*Trmq2adjL23L22*Kronecker(3,i2) + 2*TrCL21TpL22*md2(1,i2) + 2*TrCL22TpL22*md2(2,& 
& i2) + 2*TrCL23TpL22*md2(3,i2)
End If 
If (3.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+4*TrCT21TpT23*Kronecker(1,i2) + 4*Trml2CL21TpL23*Kronecker(1,i2) + 4*Trmq2adjL21L23*Kronecker(1,& 
& i2) + 4*TrCT22TpT23*Kronecker(2,i2) + 4*Trml2CL22TpL23*Kronecker(2,i2) +               & 
&  4*Trmq2adjL22L23*Kronecker(2,i2) + 4*TrCT23TpT23*Kronecker(3,i2) + 4*Trml2CL23TpL23*Kronecker(3,& 
& i2) + 4*Trmq2adjL23L23*Kronecker(3,i2) + 2*TrCL21TpL23*md2(1,i2) + 2*TrCL22TpL23*md2(2,& 
& i2) + 2*TrCL23TpL23*md2(3,i2)
End If 
If (1.eq.i2) Then 
betamd21(i1,i2) = betamd21(i1,i2)+2*TrCL21TpL21*md2(i1,1) + 2*TrCL21TpL22*md2(i1,2) + 2*TrCL21TpL23*md2(i1,3)
End If 
If (2.eq.i2) Then 
betamd21(i1,i2) = betamd21(i1,i2)+2*TrCL22TpL21*md2(i1,1) + 2*TrCL22TpL22*md2(i1,2) + 2*TrCL22TpL23*md2(i1,3)
End If 
If (3.eq.i2) Then 
betamd21(i1,i2) = betamd21(i1,i2)+2*TrCL23TpL21*md2(i1,1) + 2*TrCL23TpL22*md2(i1,2) + 2*TrCL23TpL23*md2(i1,3)
End If 
If (i2.eq.i1) Then 
betamd21(i1,i2) = betamd21(i1,i2)+((-8*AbsM1*g1p2)/15._dp - (32*AbsM3*g3p2)/3._dp + 2*g1*ooSqrt15*Tr1(1))
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betamd22 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betamd22(i1,i2) = (2*g1p2*md2YdadjYd(i1,i2))/5._dp + 6*g2p2*md2YdadjYd(i1,i2) - 6*TrYdadjYd*md2YdadjYd(i1,& 
& i2) - 2*TrYeadjYe*md2YdadjYd(i1,i2) - 2*md2YdadjYdYdadjYd(i1,i2) - 2*md2YdadjYuYuadjYd(i1,& 
& i2) + (4*g1p2*TdadjTd(i1,i2))/5._dp + 12*g2p2*TdadjTd(i1,i2) - 12*TrYdadjYd*TdadjTd(i1,& 
& i2) - 4*TrYeadjYe*TdadjTd(i1,i2) - 4*TdadjTdYdadjYd(i1,i2) - 4*TdadjTuYuadjYd(i1,      & 
& i2) - 12*TrCTdTpYd*TdadjYd(i1,i2) - 4*TrCTeTpYe*TdadjYd(i1,i2) - (4*g1p2*Conjg(M1)*TdadjYd(i1,& 
& i2))/5._dp - 12*g2p2*Conjg(M2)*TdadjYd(i1,i2) - 4*TdadjYdYdadjTd(i1,i2) -              & 
&  4*TdadjYuYuadjTd(i1,i2) - (4*g1p2*M1*YdadjTd(i1,i2))/5._dp - 12*g2p2*M2*YdadjTd(i1,   & 
& i2) - 12*TradjYdTd*YdadjTd(i1,i2) - 4*TradjYeTe*YdadjTd(i1,i2) - 4*YdadjTdTdadjYd(i1,  & 
& i2) - 4*YdadjTuTuadjYd(i1,i2) + (8*AbsM1*g1p2*YdadjYd(i1,i2))/5._dp + 24*AbsM2*g2p2*YdadjYd(i1,& 
& i2) + (4*g1p2*mHd2*YdadjYd(i1,i2))/5._dp + 12*g2p2*mHd2*YdadjYd(i1,i2) -               & 
&  12*TrCTdTpTd*YdadjYd(i1,i2) - 4*TrCTeTpTe*YdadjYd(i1,i2) - 12*Trmd2YdadjYd*YdadjYd(i1,& 
& i2) - 4*Trme2YeadjYe*YdadjYd(i1,i2) - 4*Trml2adjYeYe*YdadjYd(i1,i2) - 12*Trmq2adjYdYd*YdadjYd(i1,& 
& i2) - 24*mHd2*TrYdadjYd*YdadjYd(i1,i2) - 8*mHd2*TrYeadjYe*YdadjYd(i1,i2) +             & 
&  (2*g1p2*YdadjYdmd2(i1,i2))/5._dp + 6*g2p2*YdadjYdmd2(i1,i2) - 6*TrYdadjYd*YdadjYdmd2(i1,& 
& i2) - 2*TrYeadjYe*YdadjYdmd2(i1,i2) - 4*YdadjYdmd2YdadjYd(i1,i2) - 4*YdadjYdTdadjTd(i1,& 
& i2) - 8*mHd2*YdadjYdYdadjYd(i1,i2) - 2*YdadjYdYdadjYdmd2(i1,i2) - 4*YdadjYdYdmq2adjYd(i1,& 
& i2) - 4*YdadjYumu2YuadjYd(i1,i2) - 4*YdadjYuTuadjTd(i1,i2) - 4*mHd2*YdadjYuYuadjYd(i1, & 
& i2) - 4*mHu2*YdadjYuYuadjYd(i1,i2) - 2*YdadjYuYuadjYdmd2(i1,i2) - 4*YdadjYuYumq2adjYd(i1,& 
& i2) + (4*g1p2*Ydmq2adjYd(i1,i2))/5._dp + 12*g2p2*Ydmq2adjYd(i1,i2) - 12*TrYdadjYd*Ydmq2adjYd(i1,& 
& i2) - 4*TrYeadjYe*Ydmq2adjYd(i1,i2) - 4*Ydmq2adjYdYdadjYd(i1,i2) - 4*Ydmq2adjYuYuadjYd(i1,i2)
If (i2.eq.i1) Then 
betamd22(i1,i2) = betamd22(i1,i2)+(808*AbsM1*g1p4)/75._dp + (128*AbsM1*g1p2*g3p2)/45._dp + (128*AbsM3*g1p2*g3p2)/45._dp -& 
&  (128*AbsM3*g3p4)/3._dp + (64*g1p2*g3p2*M3*Conjg(M1))/45._dp + (64*g1p2*g3p2*M1*Conjg(M3))/45._dp +& 
&  (32*g3p4*Tr2(3))/3._dp + (8*g1p2*Tr2U1(1,1))/15._dp + 8*g1*ooSqrt15*Tr3(1)
End If 
End Do
End Do

 
Dmd2 = oo16pi2*( betamd21 + oo16pi2 * betamd22 ) 

 
Else 
Dmd2 = oo16pi2* betamd21 
End If 
 
 
Call Chop(Dmd2) 

Forall(i1=1:3) Dmd2(i1,i1) =  Real(Dmd2(i1,i1),dp) 
Dmd2 = 0.5_dp*(Dmd2+ Conjg(Transpose(Dmd2)) ) 
!-------------------- 
! mu2 
!-------------------- 
 
betamu21  = (-32*AbsM1*g1p2*id3R)/15._dp - (32*AbsM3*g3p2*id3R)/3._dp +               & 
&  2._dp*(mu2YuadjYu) + 4._dp*(TuadjTu) + 4*mHu2*YuadjYu + 2._dp*(YuadjYumu2)            & 
&  + 4._dp*(Yumq2adjYu) - 4*g1*id3R*ooSqrt15*Tr1(1)

 
 
If (TwoLoopRGE) Then 
betamu22 = (3424*AbsM1*g1p4*id3R)/75._dp + (512*AbsM1*g1p2*g3p2*id3R)/45._dp + (512*AbsM3*g1p2*g3p2*id3R)/45._dp -& 
&  (128*AbsM3*g3p4*id3R)/3._dp - 2._dp*(mu2YuadjYdYdadjYu) - (2*g1p2*mu2YuadjYu)/5._dp + & 
&  6*g2p2*mu2YuadjYu - 2._dp*(mu2YuadjYuYuadjYu) - 6*mu2YuadjYu*TrYuadjYu -              & 
&  4._dp*(TuadjTdYdadjYu) - (4*g1p2*TuadjTu)/5._dp + 12*g2p2*TuadjTu - 12*TrYuadjYu*TuadjTu -& 
&  4._dp*(TuadjTuYuadjYu) - 4._dp*(TuadjYdYdadjTu) - 12*TrCTuTpYu*TuadjYu -              & 
&  4._dp*(TuadjYuYuadjTu) - 4._dp*(YuadjTdTdadjYu) + (4*g1p2*M1*YuadjTu)/5._dp -         & 
&  12*g2p2*M2*YuadjTu - 12*TradjYuTu*YuadjTu - 4._dp*(YuadjTuTuadjYu) - 4._dp*(YuadjYdmd2YdadjYu) -& 
&  4._dp*(YuadjYdTdadjTu) - 4*mHd2*YuadjYdYdadjYu - 4*mHu2*YuadjYdYdadjYu -              & 
&  2._dp*(YuadjYdYdadjYumu2) - 4._dp*(YuadjYdYdmq2adjYu) - (8*AbsM1*g1p2*YuadjYu)/5._dp +& 
&  24*AbsM2*g2p2*YuadjYu - (4*g1p2*mHu2*YuadjYu)/5._dp + 12*g2p2*mHu2*YuadjYu -          & 
&  12*TrCTuTpTu*YuadjYu - 12*Trmq2adjYuYu*YuadjYu - 12*Trmu2YuadjYu*YuadjYu -            & 
&  24*mHu2*TrYuadjYu*YuadjYu - (2*g1p2*YuadjYumu2)/5._dp + 6*g2p2*YuadjYumu2 -           & 
&  6*TrYuadjYu*YuadjYumu2 - 4._dp*(YuadjYumu2YuadjYu) - 4._dp*(YuadjYuTuadjTu) -         & 
&  8*mHu2*YuadjYuYuadjYu - 2._dp*(YuadjYuYuadjYumu2) - 4._dp*(YuadjYuYumq2adjYu) -       & 
&  4._dp*(Yumq2adjYdYdadjYu) - (4*g1p2*Yumq2adjYu)/5._dp + 12*g2p2*Yumq2adjYu -          & 
&  12*TrYuadjYu*Yumq2adjYu - 4._dp*(Yumq2adjYuYuadjYu) + (256*g1p2*g3p2*id3R*M3*Conjg(M1))/45._dp +& 
&  (4*g1p2*TuadjYu*Conjg(M1))/5._dp + (256*g1p2*g3p2*id3R*M1*Conjg(M3))/45._dp -         & 
&  12*g2p2*TuadjYu*Conjg(M2) + (32*g3p4*id3R*Tr2(3))/3._dp + (32*g1p2*id3R*Tr2U1(1,      & 
& 1))/15._dp - 16*g1*id3R*ooSqrt15*Tr3(1)

 
Dmu2 = oo16pi2*( betamu21 + oo16pi2 * betamu22 ) 

 
Else 
Dmu2 = oo16pi2* betamu21 
End If 
 
 
Call Chop(Dmu2) 

Forall(i1=1:3) Dmu2(i1,i1) =  Real(Dmu2(i1,i1),dp) 
Dmu2 = 0.5_dp*(Dmu2+ Conjg(Transpose(Dmu2)) ) 
!-------------------- 
! me2 
!-------------------- 
 
betame21 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betame21(i1,i2) = 2*me2YeadjYe(i1,i2) + 4*TeadjTe(i1,i2) + 4*mHd2*YeadjYe(i1,i2) + 2*YeadjYeme2(i1,     & 
& i2) + 4*Yeml2adjYe(i1,i2)
If (1.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)-2*TrCT11T11*Kronecker(1,i2) - 4*Trml2CL11L11*Kronecker(1,i2) - 2*TrCT12T11*Kronecker(2,& 
& i2) - 4*Trml2CL12L11*Kronecker(2,i2) - 2*TrCT13T11*Kronecker(3,i2) - 4*Trml2CL13L11*Kronecker(3,& 
& i2) - TrCL11L11*me2(1,i2) - TrCL12L11*me2(2,i2) - TrCL13L11*me2(3,i2)
End If 
If (2.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)-2*TrCT11T12*Kronecker(1,i2) - 4*Trml2CL11L12*Kronecker(1,i2) - 2*TrCT12T12*Kronecker(2,& 
& i2) - 4*Trml2CL12L12*Kronecker(2,i2) - 2*TrCT13T12*Kronecker(3,i2) - 4*Trml2CL13L12*Kronecker(3,& 
& i2) - TrCL11L12*me2(1,i2) - TrCL12L12*me2(2,i2) - TrCL13L12*me2(3,i2)
End If 
If (3.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)-2*TrCT11T13*Kronecker(1,i2) - 4*Trml2CL11L13*Kronecker(1,i2) - 2*TrCT12T13*Kronecker(2,& 
& i2) - 4*Trml2CL12L13*Kronecker(2,i2) - 2*TrCT13T13*Kronecker(3,i2) - 4*Trml2CL13L13*Kronecker(3,& 
& i2) - TrCL11L13*me2(1,i2) - TrCL12L13*me2(2,i2) - TrCL13L13*me2(3,i2)
End If 
If (1.eq.i2) Then 
betame21(i1,i2) = betame21(i1,i2)-(TrCL11L11*me2(i1,1)) - TrCL11L12*me2(i1,2) - TrCL11L13*me2(i1,3)
End If 
If (2.eq.i2) Then 
betame21(i1,i2) = betame21(i1,i2)-(TrCL12L11*me2(i1,1)) - TrCL12L12*me2(i1,2) - TrCL12L13*me2(i1,3)
End If 
If (3.eq.i2) Then 
betame21(i1,i2) = betame21(i1,i2)-(TrCL13L11*me2(i1,1)) - TrCL13L12*me2(i1,2) - TrCL13L13*me2(i1,3)
End If 
If (i2.eq.i1) Then 
betame21(i1,i2) = betame21(i1,i2)+((-24*AbsM1*g1p2)/5._dp + 2*g1*sqrt3ov5*Tr1(1))
End If 
End Do
End Do

 
 
If (TwoLoopRGE) Then 
betame22 = 0._dp 
Do i1 = 1,3
Do i2 = 1,3
betame22(i1,i2) = (-6*g1p2*me2YeadjYe(i1,i2))/5._dp + 6*g2p2*me2YeadjYe(i1,i2) - 6*TrYdadjYd*me2YeadjYe(i1,& 
& i2) - 2*TrYeadjYe*me2YeadjYe(i1,i2) - 2*me2YeadjYeYeadjYe(i1,i2) - (12*g1p2*TeadjTe(i1,& 
& i2))/5._dp + 12*g2p2*TeadjTe(i1,i2) - 12*TrYdadjYd*TeadjTe(i1,i2) - 4*TrYeadjYe*TeadjTe(i1,& 
& i2) - 4*TeadjTeYeadjYe(i1,i2) - 12*TrCTdTpYd*TeadjYe(i1,i2) - 4*TrCTeTpYe*TeadjYe(i1,  & 
& i2) + (12*g1p2*Conjg(M1)*TeadjYe(i1,i2))/5._dp - 12*g2p2*Conjg(M2)*TeadjYe(i1,         & 
& i2) - 4*TeadjYeYeadjTe(i1,i2) + (12*g1p2*M1*YeadjTe(i1,i2))/5._dp - 12*g2p2*M2*YeadjTe(i1,& 
& i2) - 12*TradjYdTd*YeadjTe(i1,i2) - 4*TradjYeTe*YeadjTe(i1,i2) - 4*YeadjTeTeadjYe(i1,  & 
& i2) - (24*AbsM1*g1p2*YeadjYe(i1,i2))/5._dp + 24*AbsM2*g2p2*YeadjYe(i1,i2) -            & 
&  (12*g1p2*mHd2*YeadjYe(i1,i2))/5._dp + 12*g2p2*mHd2*YeadjYe(i1,i2) - 12*TrCTdTpTd*YeadjYe(i1,& 
& i2) - 4*TrCTeTpTe*YeadjYe(i1,i2) - 12*Trmd2YdadjYd*YeadjYe(i1,i2) - 4*Trme2YeadjYe*YeadjYe(i1,& 
& i2) - 4*Trml2adjYeYe*YeadjYe(i1,i2) - 12*Trmq2adjYdYd*YeadjYe(i1,i2) - 24*mHd2*TrYdadjYd*YeadjYe(i1,& 
& i2) - 8*mHd2*TrYeadjYe*YeadjYe(i1,i2) - (6*g1p2*YeadjYeme2(i1,i2))/5._dp +             & 
&  6*g2p2*YeadjYeme2(i1,i2) - 6*TrYdadjYd*YeadjYeme2(i1,i2) - 2*TrYeadjYe*YeadjYeme2(i1, & 
& i2) - 4*YeadjYeme2YeadjYe(i1,i2) - 4*YeadjYeTeadjTe(i1,i2) - 8*mHd2*YeadjYeYeadjYe(i1, & 
& i2) - 2*YeadjYeYeadjYeme2(i1,i2) - 4*YeadjYeYeml2adjYe(i1,i2) - (12*g1p2*Yeml2adjYe(i1,& 
& i2))/5._dp + 12*g2p2*Yeml2adjYe(i1,i2) - 12*TrYdadjYd*Yeml2adjYe(i1,i2) -              & 
&  4*TrYeadjYe*Yeml2adjYe(i1,i2) - 4*Yeml2adjYeYeadjYe(i1,i2)
If (i2.eq.i1) Then 
betame22(i1,i2) = betame22(i1,i2)+(2808*AbsM1*g1p4)/25._dp + (24*g1p2*Tr2U1(1,1))/5._dp + 8*g1*sqrt3ov5*Tr3(1)
End If 
End Do
End Do

 
Dme2 = oo16pi2*( betame21 + oo16pi2 * betame22 ) 

 
Else 
Dme2 = oo16pi2* betame21 
End If 
 
 
Call Chop(Dme2) 

Forall(i1=1:3) Dme2(i1,i1) =  Real(Dme2(i1,i1),dp) 
Dme2 = 0.5_dp*(Dme2+ Conjg(Transpose(Dme2)) ) 
!-------------------- 
! M1 
!-------------------- 
 
betaM11  = (66*g1p2*M1)/5._dp

 
 
If (TwoLoopRGE) Then 
betaM12 = (796*g1p4*M1)/25._dp + (54*g1p2*g2p2*M1)/5._dp + (176*g1p2*g3p2*M1)/5._dp +           & 
&  (176*g1p2*g3p2*M3)/5._dp + (54*g1p2*g2p2*M2)/5._dp + (28*g1p2*TradjYdTd)/5._dp +      & 
&  (36*g1p2*TradjYeTe)/5._dp + (52*g1p2*TradjYuTu)/5._dp - (28*g1p2*M1*TrYdadjYd)/5._dp -& 
&  (36*g1p2*M1*TrYeadjYe)/5._dp - (52*g1p2*M1*TrYuadjYu)/5._dp

 
DM1 = oo16pi2*( betaM11 + oo16pi2 * betaM12 ) 

 
Else 
DM1 = oo16pi2* betaM11 
End If 
 
 
Call Chop(DM1) 

!-------------------- 
! M2 
!-------------------- 
 
betaM21  = 2*g2p2*M2

 
 
If (TwoLoopRGE) Then 
betaM22 = (18*g1p2*g2p2*M1)/5._dp + 48*g2p2*g3p2*M3 + (18*g1p2*g2p2*M2)/5._dp + 100*g2p4*M2 +   & 
&  48*g2p2*g3p2*M2 + 12*g2p2*TradjYdTd + 4*g2p2*TradjYeTe + 12*g2p2*TradjYuTu -          & 
&  12*g2p2*M2*TrYdadjYd - 4*g2p2*M2*TrYeadjYe - 12*g2p2*M2*TrYuadjYu

 
DM2 = oo16pi2*( betaM21 + oo16pi2 * betaM22 ) 

 
Else 
DM2 = oo16pi2* betaM21 
End If 
 
 
Call Chop(DM2) 

!-------------------- 
! M3 
!-------------------- 
 
betaM31  = -6*g3p2*M3

 
 
If (TwoLoopRGE) Then 
betaM32 = (22*g1p2*g3p2*M1)/5._dp + (22*g1p2*g3p2*M3)/5._dp + 18*g2p2*g3p2*M3 + 56*g3p4*M3 +    & 
&  18*g2p2*g3p2*M2 + 8*g3p2*TradjYdTd + 8*g3p2*TradjYuTu - 8*g3p2*M3*TrYdadjYd -         & 
&  8*g3p2*M3*TrYuadjYu

 
DM3 = oo16pi2*( betaM31 + oo16pi2 * betaM32 ) 

 
Else 
DM3 = oo16pi2* betaM31 
End If 
 
 
Call Chop(DM3) 

!-------------------- 
! vd 
!-------------------- 
 
betavd1  = (3*g1p2*vd)/20._dp + (3*g2p2*vd)/4._dp - 3*TrYdadjYd*vd - TrYeadjYe*vd +   & 
&  (3*g1p2*vd*Xi)/20._dp + (3*g2p2*vd*Xi)/4._dp

 
 
If (TwoLoopRGE) Then 
betavd2 = (-207*g1p4*vd)/200._dp - (9*g1p2*g2p2*vd)/20._dp - 3*g2p4*vd + (2*g1p2*TrYdadjYd*vd)/5._dp -& 
&  16*g3p2*TrYdadjYd*vd + 9*TrYdadjYdYdadjYd*vd + 3*TrYdadjYuYuadjYd*vd - (6*g1p2*TrYeadjYe*vd)/5._dp +& 
&  3*TrYeadjYeYeadjYe*vd - (9*g1p4*vd*Xi)/400._dp - (9*g1p2*g2p2*vd*Xi)/40._dp +         & 
&  (35*g2p4*vd*Xi)/16._dp - (9*g1p2*TrYdadjYd*vd*Xi)/10._dp - (9*g2p2*TrYdadjYd*vd*Xi)/2._dp -& 
&  (3*g1p2*TrYeadjYe*vd*Xi)/10._dp - (3*g2p2*TrYeadjYe*vd*Xi)/2._dp + (9*g1p4*vd*Xip2)/400._dp +& 
&  (9*g1p2*g2p2*vd*Xip2)/40._dp - (9*g2p4*vd*Xip2)/16._dp

 
Dvd = oo16pi2*( betavd1 + oo16pi2 * betavd2 ) 

 
Else 
Dvd = oo16pi2* betavd1 
End If 
 
 
!-------------------- 
! vu 
!-------------------- 
 
betavu1  = (3*g1p2*vu)/20._dp + (3*g2p2*vu)/4._dp - 3*TrYuadjYu*vu + (3*g1p2*vu*Xi)   & 
& /20._dp + (3*g2p2*vu*Xi)/4._dp

 
 
If (TwoLoopRGE) Then 
betavu2 = (-207*g1p4*vu)/200._dp - (9*g1p2*g2p2*vu)/20._dp - 3*g2p4*vu + 3*TrYdadjYuYuadjYd*vu -& 
&  (4*g1p2*TrYuadjYu*vu)/5._dp - 16*g3p2*TrYuadjYu*vu + 9*TrYuadjYuYuadjYu*vu -          & 
&  (9*g1p4*vu*Xi)/400._dp - (9*g1p2*g2p2*vu*Xi)/40._dp + (35*g2p4*vu*Xi)/16._dp -        & 
&  (9*g1p2*TrYuadjYu*vu*Xi)/10._dp - (9*g2p2*TrYuadjYu*vu*Xi)/2._dp + (9*g1p4*vu*Xip2)/400._dp +& 
&  (9*g1p2*g2p2*vu*Xip2)/40._dp - (9*g2p4*vu*Xip2)/16._dp

 
Dvu = oo16pi2*( betavu1 + oo16pi2 * betavu2 ) 

 
Else 
Dvu = oo16pi2* betavu1 
End If 
 
 
Call ParametersToG431(Dg1,Dg2,Dg3,DYd,DYe,DL1,DL2,DYu,DMu,DTd,DTe,DT1,DT2,            & 
& DTu,DBmu,Dmq2,Dml2,DmHd2,DmHu2,Dmd2,Dmu2,Dme2,DM1,DM2,DM3,Dvd,Dvu,f)

Iname = Iname - 1 
 
End Subroutine rge431  

End Module RGEs_MSSMTriLnV 
 
