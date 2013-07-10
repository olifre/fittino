typedef struct {
  double fbb;	//fix to 0		// Coefficient of PhiFS(B)FS(B)Phi
   double fww;			// Coefficient of PhiFS(W)FS(W)Phi
   double fgg;			// Coefficient of PhiFS(G)FS(G)Phi
   double fb;			// Coefficient of (DPhi)FS(B)(DPhi)
   double fw;			// Coefficient of (DPhi)FS(W)(DPhi)
   
   /* Additional Yukawa Coefficients */
  double fuph; // fix in fit to 0
  double fdoh; //
  double fchh;//
  double fsth;//

   double ftoh;
   double fboh;
   
  double felh; //fix
  double fmuh; // fix 

   double ftah;
   
   /* Calculated Couplings to tensor structure */
   /* This coefficients have to be calculated from above given parameters */

  //   double ghgg;
   double ghyy;
   double g1hzy;
   double g2hzy;
   double g1hzz;
   double g2hzz;
  double g3hzz; // fix
   double g1hww;
   double g2hww;
  double g3hww; // fix
} effinputs;
