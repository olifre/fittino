//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//
// LIBRARY FOR SUSY ENDPOINT FORMULAS
//
// MAIN REFs: 
// <Paige, Hinchliffe et al: various papers>
// JHEP 0009 (2000) 004 [hep-ph/0007009]      (HIERARCHY 1: ENDPOINTS NOT INVOLVING GLUINOS)
// JHEP 0506 (2005) 015 [hep-ph/0501033]      (HIERARCHY 1: ENDPOINTS INVOLVING GLUINOS)
// JHEP 0010 (2007) 051 [hep-ph/0609298]      (HIERARCHY 2: ENDPOINTS NOT INVOLVING GLUINOS)
// <REF NOT YET AVAILABLE, WILL APPEAR SOON>  (HIERARCHY 2: ENDPOINTS INVOLVING GLUINOS)
//
//
// AUTHOR: BORGE KILE GJELSTEN (GJELSTEN@CERN.CH)
//
// - NOVEMBER 2007: FIRST VERSION READY
//
//
//////////////////////////////////////////////////////////////////////////
//
// IMPLEMENTED HIERARCHIES: 
//   HIERARCHY 1: m_gl > m_qL > m_N2 > m_slepton > m_N1
//   HIERARCHY 2: m_gl > m_qL > m_slepton > m_N2 > m_N1  (slepton mass not accessed)
//
//
// COMMENTS: 
//   - The accomanying script EndpointFormulas_example.C shows examples of usage
//   - The endpoint of m(qql)_lower for hierarchy 2 has not yet been calculated
//   - Not all the functions given below are in use
//   - The formulas have been well tested. Bugs may however have entered in 
//     the rewriting for the current version. Please give feedback on any 
//     odd behaviour.
//
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

#include <TMath.h>

//SOME GLOBAL VARIABLES
double mhiggs=116;
double mZ=91.2; 

//////////////////////////////////////////////////////////////////////////
//////// ENDPOINTS INVOLVING HIGGS/Z (same for hierarchy 1 and 2) ////////
//////////////////////////////////////////////////////////////////////////

double NEqFZmin(double m[5]) { //only sign of r is different from max (me,B,C)
  double mX2=mZ*mZ;
  double r=pow(m[2]-mX2-m[0],2)-4*mX2*m[0];
  if(r>0) r=sqrt(r);
  else return -1; //NB: is not always kinematically allowed, e.g. not at p250.
  double res=mX2+(m[3]-m[2])*(m[2]+mX2-m[0]-r)/(2*m[2]);
  return sqrt(res);
}
double NEqFZmax(double m[5]) { 
  double mX2=mZ*mZ;
  double r=pow(m[2]-mX2-m[0],2)-4*mX2*m[0];
  if(r>0) r=sqrt(r);
  else return -1; //NB: is not always kinematically allowed, e.g. not at p250.
  double res=mX2+(m[3]-m[2])*(m[2]+mX2-m[0]+r)/(2*m[2]);
  return sqrt(res);
}
//same expressions as above, but now with higgs mass, not Z mass.
double NEqFhmin(double m[5]) { //only sign of r is different from max (me,B,C)
  double mX2=mhiggs*mhiggs;
  double r=pow(m[2]-mX2-m[0],2)-4*mX2*m[0];
  if(r>0) r=sqrt(r);
  else return -1; //NB: is not always kinematically allowed, e.g. not at p250.
  double res=mX2+(m[3]-m[2])*(m[2]+mX2-m[0]-r)/(2*m[2]);
  return sqrt(res);
}
double NEqFhmax(double m[5]) { 
  double mX2=mhiggs*mhiggs;
  double r=pow(m[2]-mX2-m[0],2)-4*mX2*m[0];
  if(r>0) r=sqrt(r);
  else return -1; //NB: is not always kinematically allowed, e.g. not at p250.
  double res=mX2+(m[3]-m[2])*(m[2]+mX2-m[0]+r)/(2*m[2]);
  return sqrt(res);
}



////////////////////////////////////////////
///// ENDPOINT EXPRESSIONS HIERARCHY 1 /////
////////////////////////////////////////////

double Tq1ll(double m[5]) {
  double v,r;
  r=pow(m[2]+m[1],2)*pow(m[1]+m[0],2)-16*m[2]*m[1]*m[1]*m[0];
  if(r<0){return -1;} //NB
  v=( 2*m[1]*(m[3]-m[2])*(m[2]-m[0]) 
      + (m[3]+m[2])*(m[2]-m[1])*(m[1]-m[0])
      - (m[3]-m[2])*sqrt(r) )/(4*m[1]*m[2]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Ell(double m[5]) {
  double v=(m[2]-m[1])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1ll(double m[5]) {
  double v=(m[3]-m[2])*(m[2]-m[0])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1ll_2(double m[5]) {
  double v=(m[3]-m[1])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1ll_3(double m[5]) {
  double v=(m[3]*m[1]-m[2]*m[0])*(m[2]-m[1])/m[2]/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1ll_4(double m[5]) {
  double v=sqrt(m[3])-sqrt(m[0]);
  return v;
}
double Eq1lm(double m[5]) {
  double v=(m[3]-m[2])*(m[2]-m[1])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1lNear(double m[5]) {
  double v=(m[3]-m[2])*(m[2]-m[1])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1lFar(double m[5]) {
  double v=(m[3]-m[2])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1lmin_2(double m[5]) {
  double v=(m[3]-m[2])*(m[1]-m[0])/(2*m[1]-m[0]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq1lM(double m[5]) {
  double v=(m[3]-m[2])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eqq(double m[5]) {
  double v=(m[4]-m[3])*(m[3]-m[2])/m[3];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq2ll(double m[5]) {
  double v=(m[4]-m[3])*(m[2]-m[0])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq2lm(double m[5]) {
  double v=(m[4]-m[3])*(m[2]-m[1])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq2lM(double m[5]) {
  double v=(m[4]-m[3])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eqqll_Case1(double m[5]) {
  double v=(m[4]-m[3])*(m[3]-m[0])/m[3];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eqqll_Case2(double m[5]) {
  double v=(m[4]*m[2]-m[3]*m[0])*(m[3]-m[2])/m[3]/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eqqll_Case3(double m[5]) {
  double v=(m[4]*m[1]-m[2]*m[0])*(m[2]-m[1])/m[2]/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eqqll_Case4(double m[5]) {
  double v=(m[4]-m[1])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eqqll_Rest(double m[5]) {
  double v=sqrt(m[4])-sqrt(m[0]);
  return v;
}
double Eqqlm(double m[5]) {
  double v=(m[4]*m[2]-m[3]*m[1])*(m[3]-m[2])/m[3]/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double EqqlM(double m[5]) {
  double v=(m[4]*m[1]-m[3]*m[0])*(m[3]-m[2])/m[3]/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double EqqlNear(double m[5]) { 
  double v=(m[4]*m[2]-m[3]*m[1])*(m[3]-m[2])/m[3]/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double EqqlFar(double m[5]) {
  double v=(m[4]*m[1]-m[3]*m[0])*(m[3]-m[2])/m[3]/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq2lNear(double m[5]) {
  double v=(m[4]-m[3])*(m[2]-m[1])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double Eq2lFar(double m[5]) {
  double v=(m[4]-m[3])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}

//-----------------------------------------------------------

//Attempts of general ones
double NEqqlNear_1(double m[5]) {
  double v=(m[4]-m[3])*(m[3]-m[1])/m[3];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqqlNear_2(double m[5]) {
  double v=(m[4]-m[2])*(m[2]-m[1])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqqlNear_3(double m[5]) {
  double v=(m[4]*m[2]-m[3]*m[1])*(m[3]-m[2])/(m[3]*m[2]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqqlNear_4(double m[5]) {
  double v=sqrt(m[4])-sqrt(m[1]);
  return v;
}
double NEqqlFar_L1(double m[5]) {
  double v=(m[4]-m[2])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqqlFar_L2(double m[5]) {
  double v=(m[4]-m[3])*(m[3]*m[1]-m[2]*m[0])/m[3]/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqqlFar_L3(double m[5]) {
  double v=(m[3]-m[2])*(m[4]*m[1]-m[3]*m[0])/m[3]/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqqlFar_4(double m[5]) {
  double v=(sqrt(m[4]*m[1])-sqrt(m[2]*m[0]))/sqrt(m[1]);
  return v;
}
double NEqNl_equal(double m[5]) { 
  double v=(m[4]-m[3])*(m[1]-m[0])/(2*m[1]-m[0]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqNll_general(double m[5]) {
  double v=m[4]-m[3]+m[2]+m[0]-2*sqrt(m[0])*sqrt(m[4]-m[3]+m[2]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqNll_ppm(double m[5]) {
  double v=(m[4]-m[3]+m[2]-m[1])*(m[1]-m[0])/m[1];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqNll_pmp(double m[5]) {
  double v=((m[4]-m[3])*m[1]+(m[1]-m[0])*m[2])*(m[2]-m[1])/(m[2]*m[1]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double NEqNll_pmm(double m[5]) {
  double v=(m[4]-m[3])*(m[2]-m[0])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}




double GEqNll(double *m,int &Mode) { //also used by qFll (with mX instead of mqL)
  double res;
  if(Mode==0) {
    if     (m[3]/m[2] > m[2]/m[1] * m[1]/m[0]) {res=Eq1ll(m);Mode=1;}
    else if(m[1]/m[0] > m[3]/m[2] * m[2]/m[1]) {res=Eq1ll_2(m);Mode=2;} //NB order
    else if(m[2]/m[1] > m[1]/m[0] * m[3]/m[2]) {res=Eq1ll_3(m);Mode=3;} //NB order
    else {res=Eq1ll_4(m);Mode=4;}
  }
  else if(Mode==1) res=Eq1ll(m);
  else if(Mode==2) res=Eq1ll_2(m);
  else if(Mode==3) res=Eq1ll_3(m);
  else if(Mode==4) res=Eq1ll_4(m);
  else res=-8;
  return res;
}
double CosB_mqql_eq(double m[5],double pqq,double SIGN=-1) { //SIGN=-1 is CB2
  //testing CosB for mqql_eq solutions. Must require |CosB|<1 or else no eq solution
  double A=m[2];
  double B=-2*sqrt(m[2])*(m[0]+m[2]-2*m[1]);
  double C=-(m[4]+m[2])*(2*m[1]-m[0])+m[2]*m[2];
  double X=sqrt(m[4]+pqq*pqq);
  double ins=A*X*X+B*X+C;
  if(ins<0) {return -99;}
  double res=(m[1]*(m[0]+m[2]-2*m[1])*(X-sqrt(m[2])) + SIGN* sqrt(m[2])*(m[1]-m[0])*sqrt(ins))/
    (2*m[1]-m[0])/(m[2]-m[1])/pqq;
  return res;
} 
double X_mqql_eqCrit(double m[5]) {
  return (2*sqrt(m[1])*(m[0]+m[2]-2*m[1]) 
	  + (3*m[1]-m[0])*sqrt(m[4]+2*m[1]-m[0]-m[2]))/2/sqrt(m[2]*m[1]);
  //solution with minus square root is never physical
}
double X_mqql_eqCosBpm1(double m[5]) { //same X for all four situations (true?)
  double res=(-pow(m[1]*m[1]-m[0]*m[2],2) + (2*m[2]*m[1]-m[1]*m[1]-m[0]*m[2])
	      *sqrt(pow(m[1]*m[1]-m[0]*m[2],2)+4*m[4]*m[1]*(m[2]-m[1])*(m[1]-m[0])) ) /
    (4*m[1]*sqrt(m[2])*(m[2]-m[1])*(m[1]-m[0]));
  return res;
}
double pqq_mqql_eqCosBpm1_new(double m[5],double SIGN) { 
  //CB=+1: SIGN=1; CB=-1: SIGN=-1;
  double res=SIGN*(m[0]*m[2]-m[1]*m[1])/4/sqrt(m[2])/m[1]/(m[2]-m[1])/(m[1]-m[0]) * 
    ( -(2*m[2]*m[1]-m[2]*m[0]-m[1]*m[1]) 
      + sqrt(pow(m[0]*m[2]-m[1]*m[1],2)+4*m[4]*m[1]*(m[2]-m[1])*(m[1]-m[0])) );
  return res;
}
double mqql_eqXCosB(double m[5],double X,double cosB) {
  double pqq=sqrt(X*X-m[4]);
  double res=((m[4]+m[1])*sqrt(m[2]) - (m[2]+m[1])*X - cosB*(m[2]-m[1])*pqq)/sqrt(m[2]);
  if(res<0)return -sqrt(res);else return sqrt(res);
}
double mqql_eq_Align(double m[5]) { //SIGN?
  double v=(m[4]-m[2])*(m[1]-m[0])/(2*m[1]-m[0]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double mqql_eq_AntiAlign(double m[5],double SIGN=-1) { 
  //A,B,C are common for AntiAlign and Critical and CosB
  double A=m[2];
  double B=-2*sqrt(m[2])*(m[0]+m[2]-2*m[1]);
  double C=-(m[4]+m[2])*(2*m[1]-m[0])+m[2]*m[2];
  double X=(m[4]*m[2]+m[3]*m[3])/2/m[3]/sqrt(m[2]);
  double AA=-(3*m[1]-m[0])*(m[4]*m[2]+m[3]*m[3]) + 2*((2*m[1]-m[0])*m[4]+m[2]*m[1])*m[3];
  double ins=A*X*X+B*X+C;
  if(ins<0) {printf("mqql_eq_AntiAlign:complex\n");return -99;}
  double v=(AA -SIGN* 2*m[3]*(m[1]-m[0])*sqrt(ins))/2/m[3]/(2*m[1]-m[0]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double mqql_eq_Critical(double m[5],double SIGN=-1) { 
  //A,B,C are common for AntiAlign and Critical
  double A=m[2];
  double B=-2*sqrt(m[2])*(m[0]+m[2]-2*m[1]);
  double C=-(m[4]+m[2])*(2*m[1]-m[0])+m[2]*m[2];
  double X=(2*sqrt(m[1])*(m[0]+m[2]-2*m[1]) 
	    + (3*m[1]-m[0])*sqrt(m[4]+2*m[1]-m[0]-m[2]))/2/sqrt(m[2]*m[1]);
  double ins=A*X*X+B*X+C;
  if(ins<0) {printf("mqql_eq_Complex:complex\n");return -99;}
  double v=m[4]+(m[2]*m[1]-(3*m[1]-m[0])*sqrt(m[2])*X -SIGN* (m[1]-m[0])*sqrt(ins))/(2*m[1]-m[0]);
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}



//////////////////////////////////
///  MAIN FUNCTION HIERARCHY 1 ///
//////////////////////////////////

double EdT(int N,double m[],int &Mode) {     

  double res=-9;

  //SOME VARIABLES:
  double N12=m[0], lR2=m[1], N22=m[2], qL2=m[3], gl2=m[4]; //(masses squared is what enters)
  double N1=sqrt(N12), lR=sqrt(lR2), N2=sqrt(N22), qL=sqrt(qL2), gl=sqrt(gl2); 

  if(N==0) res=Ell(m);
  else if(N==1) res=GEqNll(m,Mode); 
  else if(N==2) res=Tq1ll(m);
  else if(N==3) res=Eq1lNear(m);
  else if(N==4) res=Eq1lFar(m);
  else if(N==5) { //Eq1lmin
    if(Mode==0) {
      double r1=Eq1lNear(m),r2=Eq1lmin_2(m);
      if(r1<=r2) {res=r1;Mode=1;}
      if(r2<=r1) {res=r2;Mode=2;}
    }
    else if(Mode==1) res=Eq1lNear(m);
    else if(Mode==2) res=Eq1lmin_2(m);
    else res=-8;
  }
  else if(N==6) { //Eq1lmax
    if(Mode==0) {
      double r1=Eq1lNear(m),r2=Eq1lFar(m);
      if(r1>=r2){res=r1;Mode=1;}
      else {res=r2;Mode=2;}
    }
    else if(Mode==1) res=Eq1lNear(m);
    else if(Mode==2) res=Eq1lFar(m);
    else res=-8;
  }
  else if(N==7) res=Eqq(m);
  else if(N==8) {
    if(Mode==0) {
      if     (m[4]/m[3] > m[3]/m[2] * m[2]/m[1] * m[1]/m[0]) {res=Eqqll_Case1(m);Mode=1;}
      else if(m[3]/m[2] > m[4]/m[3] * m[2]/m[1] * m[1]/m[0]) {res=Eqqll_Case2(m);Mode=2;}
      else if(m[2]/m[1] > m[4]/m[3] * m[3]/m[2] * m[1]/m[0]) {res=Eqqll_Case3(m);Mode=3;}
      else if(m[1]/m[0] > m[4]/m[3] * m[3]/m[2] * m[2]/m[1]) {res=Eqqll_Case4(m);Mode=4;}
      else {res=Eqqll_Rest(m);Mode=5;}
    }
    else if(Mode==1) res=Eqqll_Case1(m);
    else if(Mode==2) res=Eqqll_Case2(m);
    else if(Mode==3) res=Eqqll_Case3(m);
    else if(Mode==4) res=Eqqll_Case4(m);
    else if(Mode==5) res=Eqqll_Rest(m);
    else res=-8;
  }
  else if(N==9) {
    double mm[5]={lR2,N22,qL2,gl2}; //redefined masses
    res=GEqNll(mm,Mode);
  }    
  else if(N==10) { //qqlF 
    double mm[5]={N12*N22/lR2,N22,qL2,gl2}; //redefined masses
    res=GEqNll(mm,Mode);
  }

  else if(N==11) { //qql_lower: This is by far the most complicated endpoint
    int mode11=0;
    if(Mode==0) {

      int CaseN,CaseF;
      double MqqlN=EdT(9,m,CaseN=0),MqqlF=EdT(10,m,CaseF=0);
      int SN=(MqqlN<MqqlF),SF=!SN;
      int Ntriv=(N12+N22<2*lR2);
      int alsoCaseN1=(lR2*(gl2-qL2)*(N22-lR2) < qL2*(qL2-N22)*(lR2-N12));         //never
      int alsoCaseN2=(qL2*lR2*(qL2-N22)*(N22-lR2) < N22*N22*(gl2-qL2)*(lR2-N12)); //never
      int alsoCaseN4=(lR*(gl-lR)*(N22-lR2) < (gl*lR-N22)*(lR2-N12));              //never
      int alsoCaseF1=(N22*N22*(gl2-qL2)*(lR2-N12) < qL2*lR2*(qL2-N22)*(N22-lR2));
      int alsoCaseF2=(qL2*(qL2-N22)*(lR2-N12) < lR2*(gl2-qL2)*(N22-lR2));
      int alsoCaseF4=((gl*lR-N2*N1)*(lR2-N12)*N22 < (gl*N1-N2*lR)*(N22-lR2)*N1*lR);

      if(Ntriv && !SN && gl>qL && qL>N2 && N2>lR && lR>N1) {printf("Does this ever happen?\n");}

      //Special case qqlN:
      if     (SN && Ntriv) {res=EdT(9,m,mode11=0);Mode=1;return res;} //regardless of CaseN
      else if(SN && CaseN==1 && alsoCaseN1) {res=EdT(9,m,mode11=0);Mode=2;return res;} //never 
      else if(SN && CaseN==3 && alsoCaseN2) {res=EdT(9,m,mode11=0);Mode=3;return res;} //never //NB 2<->3
      else if(SN && CaseN==4 && alsoCaseN4) {res=EdT(9,m,mode11=0);Mode=4;return res;} //never
      else if(SF && CaseF==1 && alsoCaseF1) {res=EdT(10,m,mode11=0);Mode=6;return res;} 
      else if(SF && CaseF==3 && alsoCaseF2) {res=EdT(10,m,mode11=0);Mode=7;return res;} //NB 2<->3
      else if(SF && CaseF==4 && alsoCaseF4) {res=EdT(10,m,mode11=0);Mode=8;return res;} 
      
      //---EQUAL SOLUTIONS
      else {
	int neq=0;
	double meq[20]; 
	for(int i=0;i<20;i++)meq[i]=-1;
	double pqqA=(gl2-N22)/2/N2; //Align
	double pqqAA=TMath::Abs((gl2*N22-qL2*qL2)/2/qL2/N2); //AntiAlign

	//CRITICAL CB2:
	double XC=X_mqql_eqCrit(m); //apparently XC1=XC2
	double pqqC;
	if(XC*XC>=gl*gl+pqqAA*pqqAA) { //Dec15
	  pqqC=sqrt(XC*XC-gl*gl);
	  int okpqqC=(pqqC>=pqqAA && pqqC<=pqqA);
	  double zCB1=CosB_mqql_eq(m,pqqC,1);
	  if(0 && TMath::Abs(zCB1)<1 && okpqqC) {
	    meq[0]=mqql_eq_Critical(m,1); //could still be negative/imaginary
	    neq++;
	  }
	  double zCB2=CosB_mqql_eq(m,pqqC,-1);
	  if(TMath::Abs(zCB2)<1 && okpqqC) {
	    meq[1]=mqql_eq_Critical(m,-1); //could still be negative/imaginary
	    neq++;
	  }
	}

	//---RAND1: cosB=\pm1
	double ppm1,XCBpm1=-3;
	ppm1=TMath::Abs(pqq_mqql_eqCosBpm1_new(m,1));
	int okppm1=0;
	if(pqqAA<=ppm1 && ppm1<=pqqA) {okppm1=1;XCBpm1=sqrt(ppm1*ppm1+gl2);}

	//CosB=+1:
	if(N1*N2>lR2 && okppm1) {meq[4]=mqql_eqXCosB(m,XCBpm1, 1);neq++;}
	//CosB=-1:
	if(N1*N2<lR2 && okppm1) {meq[5]=mqql_eqXCosB(m,XCBpm1,-1);neq++;}


	//---RAND2: A and AA
	double zCB2_A=CosB_mqql_eq(m,pqqA,-1);
	double zCB2_AA=CosB_mqql_eq(m,pqqAA,-1);
	if(TMath::Abs(zCB2_A)<=1)  {meq[8]=mqql_eq_Align(m);neq++;}
	if(TMath::Abs(zCB2_AA)<=1) {meq[9]=mqql_eq_AntiAlign(m);neq++;}
	
	
	double randmax=-9999;
	for(int i=0;i<20;i++)if(meq[i]>=randmax){randmax=meq[i];Mode=10+i;}
	double randmax2=-9999;
	for(int i=0;i<20;i++)if(meq[i]>=randmax2 && i!=Mode-10){randmax2=meq[i];} 
	
	return randmax;
      }
    }
    else if(Mode==1) res=EdT(9,m,mode11=0);
    else if(Mode==2) res=EdT(10,m,mode11=0);
    else if(Mode==3) res=mqql_eq_Critical(m);
    else if(Mode==4) res=mqql_eq_Critical(m,1); //SIGN
    else if(Mode==5) res=mqql_eq_Align(m);
    else if(Mode==6) res=mqql_eq_AntiAlign(m);
    else if(Mode==7) res=mqql_eq_AntiAlign(m,1); //SIGN
    else res=-8;
  }

  else if(N==12) { //qqlmax
    int mode12=0;
    double r1=EdT(9,m,mode12=0),r2=EdT(10,m,mode12=0); //recursive
    if(r1>r2){res=r1;Mode=1;}
    if(r2>r1){res=r2;Mode=2;}
  }
  else if(N==13) { 
    double mX=sqrt(m[4]-m[3]+m[2]);
    double m3bak=m[3];
    m[3]=mX*mX;
    res=GEqNll(m,Mode);
    m[3]=m3bak; //restore 
  }
  else if(N==14) res=Eq2lNear(m);
  else if(N==15) res=Eq2lFar(m);
  else if(N==16) { //q2l_lower
    if(Mode==0) {
      if(N22+N12<2*lR2) {
	res=Eq2lNear(m);Mode=1;
      }
      else {res=NEqNl_equal(m);Mode=2;}
    }
    else if(Mode==1) res=Eq2lNear(m);
    else if(Mode==2) res=NEqNl_equal(m);
    else res=-8;
  }
  else if(N==17) { //q2l_upper
    double r1=Eq2lNear(m),r2=Eq2lFar(m);
    if(r1>=r2) {res=r1;Mode=1;}
    else {res=r2;Mode=2;}
  }
  else if(N==18) { //qFZmin
    res=NEqFZmin(m);
  }
  else if(N==19) { //qFZmax
    res=NEqFZmax(m);
  }
  else if(N==20) { //qFhmin
    res=NEqFhmin(m);
  }
  else if(N==21) { //qFhmax
    res=NEqFhmax(m);
  }
  else res=-11;
  return res;

}


/////////////////////////////////////
///// ENDPOINTS FOR HIERARCHY 2 /////
/////////////////////////////////////

double TB_Ell(double *m) {
  return sqrt(m[2])-sqrt(m[0]);
}
double TB_EqFll_Case1(double *m) {
  double v=(m[3]-m[2])*(m[2]-m[0])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_EqFll_Rest(double *m) {
  return sqrt(m[3])-sqrt(m[0]);
}
double TB_EqFl_Upper(double *m) {
  return TB_EqFll_Case1(m);
}
double TB_EqFl_Lower(double *m) {
  return TB_EqFl_Upper(m)/sqrt(2.); 
}
double TB_Eqqll_Case1(double *m) {
  double v=(m[4]-m[3])*(m[3]-m[0])/m[3];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_Eqqll_Case2(double *m) {
  double v=(m[3]-m[2])*(m[4]*m[2]-m[3]*m[0])/m[3]/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_Eqqll_Rest(double *m) {
  return sqrt(m[4])-sqrt(m[0]);
}
double TB_Eqql_Upper_Case3(double *m) {
  double v=(m[4]-m[2])*(m[2]-m[0])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_EqNll_Case1(double *m) {
  double v=(m[4]-m[3])*(m[2]-m[0])/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_EqNll_QRest(double *m) {
  return sqrt(m[4]-m[3]+m[2])-sqrt(m[0]);
}
double TB_Eqql_Lower_Case1(double *m) {
  double v=(m[4]-m[3])*(m[3]-(m[2]-m[0])/2.)/m[3];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_Eqql_Lower_Case2(double *m) {
  double v=(m[3]-m[2])*( (m[4]-m[3])*m[2]+m[4]*(m[2]-m[0])/2.)/m[3]/m[2];
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}
double TB_TqFll(double m[5]) {
  double z=m[0], a=m[2], c=m[3]; 
  double sq=a*a+z*z+4*sqrt(a*z)*(a+z)-10*a*z; 
  if(sq<0) {printf("TB_TqFll: negative inside sqrt: %f\n",sq); return -11;}
  double v = pow(sqrt(a)-sqrt(z),2)/2 + (c-a)/(4*a) * (3*a-z-2*sqrt(a*z)-sqrt(sq)); 
  if(v<0){v=-sqrt(-v);}else{v=sqrt(v);}; return v;
}



//////////////////////////////////
///  MAIN FUNCTION HIERARCHY 2 ///
//////////////////////////////////

double TB_EdT(int N,double m[],int &Mode) {
  double res=-6;
  if(N==0) res=TB_Ell(m);
  else if(N==1) {
    if(Mode==0) {
      if(m[3]*m[0]>m[2]*m[2]) {res=TB_EqFll_Case1(m);Mode=1;}
      else {res=TB_EqFll_Rest(m);Mode=2;}
    }
    else if(Mode==1) res=TB_EqFll_Case1(m);
    else if(Mode==2) res=TB_EqFll_Rest(m);
    else res=-8;
  }
  else if(N==2) res=TB_TqFll(m);
  else if(N==3) res=TB_EqFl_Upper(m);
  else if(N==4) res=TB_EqFl_Upper(m);
  else if(N==5) res=TB_EqFl_Lower(m);
  else if(N==6) res=TB_EqFl_Upper(m);
  else if(N==7) res=Eqq(m);
  else if(N==8) { //qqll
    if(Mode==0) {
      if     (m[4]/m[3] > m[3]/m[2] * m[2]/m[0]) {res=TB_Eqqll_Case1(m);Mode=1;}
      else if(m[3]/m[2] > m[4]/m[3] * m[2]/m[0]) {res=TB_Eqqll_Case2(m);Mode=2;}
      else {res=TB_Eqqll_Rest(m);Mode=3;}
    }
    else if(Mode==1) res=TB_Eqqll_Case1(m);
    else if(Mode==2) res=TB_Eqqll_Case2(m);
    else if(Mode==3) res=TB_Eqqll_Rest(m);
    else res=-8;
  }
  else if(N==9 || N==10 || N==12) { //qql_upper
    if(Mode==0) {
      if     (m[4]/m[3] > m[3]/m[2] * m[2]/m[0]) {res=TB_Eqqll_Case1(m);Mode=1;}
      else if(m[3]/m[2] > m[4]/m[3] * m[2]/m[0]) {res=TB_Eqqll_Case2(m);Mode=2;}
      else if(m[2]/m[0] > m[4]/m[3] * m[3]/m[2]) {res=TB_Eqql_Upper_Case3(m);Mode=3;}
      else {res=TB_Eqqll_Rest(m);Mode=4;}
    }
    else if(Mode==1)res=TB_Eqqll_Case1(m);
    else if(Mode==2)TB_Eqqll_Case2(m);
    else if(Mode==3)res=TB_Eqql_Upper_Case3(m);
    else if(Mode==4)res=TB_Eqqll_Rest(m);
    else res=-8;
  }
  else if(N==11) { //qql_lower
    if(Mode==0) {
      printf("EndpointFormulas: qql_lower has not been fully calculated for hierarchy2. The output is most likely wrong.\n"); 
      if(m[4]*(m[2]+m[0])/2. > m[3]*m[3]) {res=TB_Eqql_Lower_Case1(m);Mode=1;}
      else if(m[2]*(m[3]*m[3]-m[4]*m[2]) > m[4]*m[3]*(m[2]-m[0])/2.) {res=TB_Eqql_Lower_Case2(m);Mode=2;}
      else res=-8;
    }
    else res=-8;
  }
  else if(N==13) { //qNll
    if(Mode==0) {
      if(m[0]*(m[4]+m[2]) > m[2]*m[2]+m[3]*m[0]) {res=TB_EqNll_Case1(m);Mode=1;}
      else {res=TB_EqNll_QRest(m);Mode=2;}
    }
    else if(Mode==1) res=TB_EqNll_Case1(m);
    else if(Mode==2) res=TB_EqNll_QRest(m);
    else res=-8;
  } 
  else if(N==14 || N==15 || N==16 || N==17) {
    //qNlN, qNlF, qNl_Lower, qNl_Upper
    res=TB_EqNll_Case1(m);
    if(N==16) res/=sqrt(2.);
  }
  else res=-11;
  return res;

  //STATUS: 11 is not complete, and may well be that Case1/2 (implemented) are wrong.

}




///////////////////////////////////////////////////
////////////// SOME HELPER FUNCTIONS //////////////
///////////////////////////////////////////////////
#include <TString.h>

TString EndpointName(int N) {
  char c[200];
  sprintf(c,"NoEdge");
  if(N==0) sprintf(c,"ll");
  if(N==1) sprintf(c,"qFll");
  if(N==2) sprintf(c,"qFllTh");
  if(N==3) sprintf(c,"qFlNear");
  if(N==4) sprintf(c,"qFlFar");
  if(N==5) sprintf(c,"qFlm");
  if(N==6) sprintf(c,"qFlM");
  if(N==7) sprintf(c,"qq");
  if(N==8) sprintf(c,"qqll");
  if(N==9) sprintf(c,"qqlNear");
  if(N==10)sprintf(c,"qqlFar");
  if(N==11)sprintf(c,"qqlm");
  if(N==12)sprintf(c,"qqlM");
  if(N==13)sprintf(c,"qNll");
  if(N==14)sprintf(c,"qNlNear");
  if(N==15)sprintf(c,"qNlFar");
  if(N==16)sprintf(c,"qNlm");
  if(N==17)sprintf(c,"qNlM");
  if(N==18)sprintf(c,"qFZmin"); 
  if(N==19)sprintf(c,"qFZmax"); 
  if(N==20)sprintf(c,"qFhmin"); 
  if(N==21)sprintf(c,"qFhmax"); 
  return c;
}
TString EndpointNameb(int N) {
  char c[200];
  sprintf(c,"NoEdge");
  if(N==0) sprintf(c,"ll");
  if(N==1) sprintf(c,"bFll");
  if(N==2) sprintf(c,"bFllTh");
  if(N==3) sprintf(c,"bFlNear");
  if(N==4) sprintf(c,"bFlFar");
  if(N==5) sprintf(c,"bFlm");
  if(N==6) sprintf(c,"bFlM");
  if(N==7) sprintf(c,"bb");
  if(N==8) sprintf(c,"bbll");
  if(N==9) sprintf(c,"bblNear");
  if(N==10)sprintf(c,"bblFar");
  if(N==11)sprintf(c,"bblm");
  if(N==12)sprintf(c,"bblM");
  if(N==13)sprintf(c,"bNll");
  if(N==14)sprintf(c,"bNlNear");
  if(N==15)sprintf(c,"bNlFar");
  if(N==16)sprintf(c,"bNlm");
  if(N==17)sprintf(c,"bNlM");
  if(N==18)sprintf(c,"bFZmin"); 
  if(N==19)sprintf(c,"bFZmax"); 
  if(N==20)sprintf(c,"bFhmin"); 
  if(N==21)sprintf(c,"bFhmax"); 
  return c;
}





///////////////////////////////////////////////////////
/////////////////// MAIN FUNCTION /////////////////////
///////////////////////////////////////////////////////

double Endpoint(int N, double mass[], int &mode, int &forcehierarchy) {
  //     <this Endpoint function allows for some inspection of the various endpoint expressions>
  //
  //N    : Which endpoint (can use function EndpointName(N) to show which mass corresponds to N)
  //mass : masses of sparticles (m_N1, m_slepton, m_N2, m_squark, m_gluino)  (NB: m_slepton must also be given for hierarchy 2)
  //mode : Relates to which expression is being/has been used 
  //       (there are usually many expressions for a given endpoint, the mass constellation determines which one is used)
  //        - To use the correct expression use mode=0 [This is the behaviour of the default function Endpoint(int N, double mass[]).]
  //        - Expressions appropriate for other mass constellations can be used (e.g. for comparison) by specifying the given mode
  //          (will then need to go into the function and see what modes are available)
  //        - The variable mode returns which mode has been used
  //forcehierarchy : By default the appropriate hierarchy is chosen. Hierarchies 1 and 2 can be chosen by setting forcehierarchy to 1 or 2
  //                 The variable returns which hierarchy has been used. 


  //Find hierarchy: 
  int hierarchy;
  if(mass[1]<mass[2]) hierarchy=1; else hierarchy=2; 
  if(forcehierarchy!=0) hierarchy=forcehierarchy; 
  else forcehierarchy=hierarchy; 

  //Construct masses squared (since this is the quantity most used)
  double mm[5];
  for(int i=0;i<5;i++) mm[i]=mass[i]*mass[i];

  //Calculate endpoint
  if(hierarchy==1) return EdT(N,mm,mode); 
  else if(hierarchy==2) return TB_EdT(N,mm,mode); 
  else return -99;
}

double Endpoint(int N, double mass[], int &mode) {
  //     <this Endpoint function allows for some inspection of the various endpoint expressions>
  //
  //N    : Which endpoint (can use function EndpointName(N) to show which mass corresponds to N)
  //mass : masses of sparticles (m_N1, m_slepton, m_N2, m_squark, m_gluino)  (NB: m_slepton must also be given for hierarchy 2)
  //mode : Relates to which expression is being/has been used 
  //       (there are usually many expressions for a given endpoint, the mass constellation determines which one is used)
  //        - To use the correct expression use mode=0 [This is the behaviour of the default function Endpoint(int N, double mass[]).]
  //        - Expressions appropriate for other mass constellations can be used (e.g. for comparison) by specifying the given mode
  //          (will then need to go into the function and see what modes are available)
  //        - The variable mode returns which mode has been used

  int hierarchy=0;
  return Endpoint(N,mass,mode,hierarchy); 
}

double Endpoint(int N, double mass[]) {
  //     <this is the default Endpoint function>
  //N    : Which endpoint (can use function EndpointName(N) to show which mass corresponds to N)
  //mass : masses of sparticles (m_N1, m_slepton, m_N2, m_squark, m_gluino)  (NB: m_slepton must also be given for hierarchy 2)

  int mode=0;
  return Endpoint(N,mass,mode);
}
