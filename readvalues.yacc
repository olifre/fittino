%{
#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <map.h>
#include <leshouches.h>
#include <yy.h>
#include <misc.h>
%}

%union {
    int      integer;
    double   real;
    char     name[255];
};

%token <name> T_KEY T_WORD
%token <real> T_NUMBER
%token <integer> T_ENERGYUNIT T_SWITCHSTATE T_CROSSSECTIONUNIT
%token T_ERRORSIGN T_BRA T_KET T_COMMA T_GOESTO T_ALIAS
%token T_BLOCK T_SCALE T_DECAY T_NEWLINE T_XS T_GENERATOR T_XSBR T_BRRATIO
%token <name> T_COMPARATOR T_UNIVERSALITY T_PATH
 
%type <name> sentence
%type <real> value err

%%

input:
            /* empty */
            | input T_NEWLINE
            | input block
            | input decay
            | input xs
              {
//                  printf("xs input\n");
              }
	    | input T_KEY value
	      {
	        if (!strcmp($2,"NumberOfMinimizations")) {
		  // cout << "FOUND NUMBER OF MINIMIZATIONS "<<$3<<endl;
		  if ($3>0) {
                    yyNumberOfMinimizations = $3;
                  }
		}
	        else if (!strcmp($2,"ErrDef")) {
		  // cout << "FOUND ErrDef "<<$3<<endl;
		  if ($3>0) {
                    yyErrDef = $3;
                  }
                } 	        
	        else if (!strcmp($2,"MaxCallsSimAnn")) {
		  // cout << "FOUND MaxCallsSimAnn "<<$3<<endl;
		  if ($3>0) {
                    yyMaxCallsSimAnn = $3;
                  }
                } 	        
	        else if (!strcmp($2,"TempRedSimAnn")) {
		  // cout << "FOUND TempRedSimAnn "<<$3<<endl;
		  if ($3>0) {
                    yyTempRedSimAnn = $3;
                  }
                } 	        
                else if (!strcmp($2,"NumberPulls")) {
		  // cout << "FOUND NumberPulls "<<$3<<endl;
		  if ($3>0) {
                    yyNumberPulls = $3;
                  }
                } else {
		  found = 0;
		  for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
		    if (!yyMeasuredVec[i].name.compare($2)) {
		      found = 1;
		      yyMeasuredVec[i].value = $3;
		      yyMeasuredVec[i].error = -1;
		      break;
		    }
		  }
		  if (found == 0) {
		      MeasuredValue tmpValue;
                      tmpValue.nofit = false;
		      tmpValue.name = $2;
		      tmpValue.type = mass;
		      tmpValue.value = $3;
		      tmpValue.error = -1;
		      tmpValue.theovalue  = 0;
		      tmpValue.alias = 0;
		      tmpValue.bound_low = 0.;
		      tmpValue.bound_up = 0.;
		      if (!strncmp($2, "mass", 4))tmpValue.type = mass;
		      else tmpValue.type = other;
		      yyMeasuredVec.push_back(tmpValue);
//		      cout << "filling "<< $2 <<endl;
		  }
                }
	      }
	    | input T_KEY value err
	      {
		  found = 0;
		  for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
		    if (!yyMeasuredVec[i].name.compare($2)) {
		      found = 1;
		      yyMeasuredVec[i].value = $3;
		      yyMeasuredVec[i].error = $4;
		      break;
		    }
		  }
		  if (found == 0) {
		      MeasuredValue tmpValue;
                      tmpValue.nofit = false;
		      tmpValue.name = $2;
		      tmpValue.value = $3;
		      tmpValue.error = $4;
		      tmpValue.type = mass;
		      tmpValue.theovalue  = 0;
		      tmpValue.bound_low = 0.;
		      tmpValue.bound_up = 0.;
		      tmpValue.alias = 0;
		      if (!strncmp($2, "mass", 4))tmpValue.type = mass;
		      else tmpValue.type = other;
		      yyMeasuredVec.push_back(tmpValue);
		  }
	      }
	    | input T_UNIVERSALITY sentence
	      {
		 MeasuredValue tmpValue;
        	 string str;
	         str.erase();
		 str = $3;
//		 cout << "decompositing string "<<str<< endl;
		 char tmpstr5[255];
		 unsigned int pos = 0, newpos = 0;
		 int anti = 1;
	         int i = 0;
	         MeasuredValue tmpval;
	         string        firstname;
		 while ((newpos = str.find(" ", pos)) != string::npos) {
		      str.copy(tmpstr5, newpos - pos, pos);
	              tmpstr5[newpos-pos] = '\0';
	              cout << "tmpstr5 after str.copy "<<tmpstr5<< endl;
                      if (!pos) {
                          firstname.erase();
                          firstname.append(tmpstr5);
                      }
	              else {
	                  tmpval.name.erase();
	                  tmpval.name.append(tmpstr5);
                          tmpval.universality = firstname;
                          yyUniversalityVec.push_back(tmpval);
                      }
//                      cout<<"pos = "<<pos<<"   newpos = "<<newpos<<endl;
		      pos = newpos + 1;
                 }		 					
              }	
	    | input T_KEY T_WORD T_WORD value
	      {
		  if (!strcmp($2, "correlationCoefficient")) {
	              int i = 0;
		      int j = 0;
                      int aliasnumber;
                      char* charnumber;
		      if (!strncmp($3,"sigma",5)) {
                        charnumber = strchr($3,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == xsection) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    i = k;
                            cout << "found correlation with xs " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
		      else if (!strncmp($3,"br",2)) {
                        charnumber = strchr($3,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == br) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    i = k;
                            cout << "found correlation with br " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
		      else if (!strncmp($3,"edge",2)) {
                        charnumber = strchr($3,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == Pedge) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    i = k;
                            cout << "found correlation with edge " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
		      else if (!strncmp($3,"width",2)) {
                        charnumber = strchr($3,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == Pwidth) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    i = k;
                            cout << "found correlation with width " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
                      else {
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if (!yyMeasuredVec[k].name.compare($3)) {
			    i = k;
                            cout << "found correlation with " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }			
                      }
		      if (!strncmp($4,"sigma",5)) {
                        charnumber = strchr($4,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == xsection) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    j = k;
                            cout << "found correlation with xs " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
		      else if (!strncmp($4,"br",2)) {
                        charnumber = strchr($4,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == br) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    j = k;
                            cout << "found correlation with br " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
		      else if (!strncmp($4,"edge",2)) {
                        charnumber = strchr($4,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == Pedge) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    j = k;
                            cout << "found correlation with edge " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
		      else if (!strncmp($4,"width",2)) {
                        charnumber = strchr($4,'_');
                        if (charnumber == 0) yyerror ("Underscore not found");
		        aliasnumber = atof((charnumber+1));
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if ((yyMeasuredVec[k].type == Pwidth) && (yyMeasuredVec[k].alias == aliasnumber)) {
			    j = k;
                            cout << "found correlation with width " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }
                      }
                      else {
                        for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
                          if (!yyMeasuredVec[k].name.compare($4)) {
			    j = k;
                            cout << "found correlation with " <<  yyMeasuredVec[k].name << endl;
			    break;
			  }
                        }			
                      }

//	              cout << "filling correlation coefficient for " << $3 << " " << $4 << " " << $5 << endl;
		      yyMeasuredCorrelationMatrix.add(i, j, $5);
		  }
	      }
	    | input T_KEY value value
	      {
		  if (!strcmp($2, "XScanRange")) {
		    yyXscanlow = $3;
		    cout << "yyXscanlow = " << yyXscanlow << endl;
		    yyXscanhigh = $4;
		    cout << "yyXscanhigh = " << yyXscanhigh << endl;
		  }
	      }
	    | input T_KEY T_SWITCHSTATE
	      {
		  if (!strcmp($2, "LoopCorrections")) {
		      if ($3 == on) yyUseLoopCorrections = true;
		      else yyUseLoopCorrections = false;

		  }
		  if (!strcmp($2, "CalcPullDist")) {
		      if ($3 == on) yyCalcPullDist = true;
		      else yyCalcPullDist = false;
		  }
		  if (!strcmp($2, "ScanParameters")) {
		      if ($3 == on) yyScanParameters = true;
		      else yyScanParameters = false;
		  }
		  if (!strcmp($2, "CalcIndChisqContr")) {
		      if ($3 == on) yyCalcIndChisqContr = true;
		      else yyCalcIndChisqContr = false;
		  }
		  if (!strcmp($2, "ISR")) {
		      if ($3 == on) yyISR = true;
		      else yyISR = false;
		  }
		  if (!strcmp($2, "UseMinos")) {
		      if ($3 == on) yyUseMinos = true;
		      else yyUseMinos = false;
		  } 
		  //yyGetContours
		  if (!strcmp($2, "GetContours")) {
		      if ($3 == on) yyGetContours = true;
		      else yyGetContours = false;
		  } 		  
		  if (!strcmp($2, "UseHesse")) {
		      if ($3 == on) yyUseHesse = true;
		      else yyUseHesse = false;
		  }
		  if (!strcmp($2, "UseSimAnnBefore")) {
		      if ($3 == on) yyUseSimAnnBefore = true;
		      else yyUseSimAnnBefore = false;
		  }
		  if (!strcmp($2, "UseSimAnnWhile")) {
		      if ($3 == on) yyUseSimAnnWhile = true;
		      else yyUseSimAnnWhile = false;
		  }
		  if (!strcmp($2, "UseGivenStartValues")) {
		      if ($3 == on) yyUseGivenStartValues = true;
		      else yyUseGivenStartValues = false;
		  }
		  if (!strcmp($2, "BoundsOnX")) {
		      if ($3 == off) yyBoundsOnX = false;
		      else yyBoundsOnX = true;
		  }
		  if (!strcmp($2, "FitAllDirectly")) {
		      if ($3 == on) yyFitAllDirectly = true;
		      else yyFitAllDirectly = false;
		  }
		  if (!strcmp($2, "SepFitTanbX")) {
		      if ($3 == on) yySepFitTanbX = true;
		      else yySepFitTanbX = false;
		  }
		  if (!strcmp($2, "SepFitTanbMu")) {
		      if ($3 == on) yySepFitTanbMu = true;
		      else yySepFitTanbMu = false;
		  } 
		  // yySepFitmA
		  if (!strcmp($2, "SepFitmA")) {
		      if ($3 == on) yySepFitmA = true;
		      else yySepFitmA = false;
		  } 		  
		  if (!strcmp($2, "ScanX")) {
		      if ($3 == on) yyScanX = true;
		      else yyScanX = false;
		  }
	      }
	    | input T_GENERATOR T_WORD
	      {
		   if (!strcmp($3, "SPHENO")) {
		      yyGenerator = SPHENO;
		   }
		   if (!strcmp($3, "SUSPECT")) {
		      yyGenerator = SUSPECT;
		   }
	      }
	    | input T_GENERATOR T_WORD T_PATH
	      {
		   if (!strcmp($3, "SPHENO")) {
		      yyGenerator = SPHENO;
		   }
		   if (!strcmp($3, "SUSPECT")) {
		      yyGenerator = SUSPECT;
		   }
	           yyGeneratorPath = $4;
	      }
	    | input T_KEY T_WORD value
	      {
		  if (!strcmp($2, "fixParameter")) {
	            parameter_t tmpparam;
                    tmpparam.name = $3;
                    tmpparam.value = $4;
                    yyFixedPar.push_back(tmpparam);
		  }
		  else if (!strcmp($2, "fitParameter")) {
	            parameter_t tmpparam;
                    tmpparam.name = $3;
                    tmpparam.value = $4;
                    yyFittedPar.push_back(tmpparam);
		  }
                  else {
                     yyerror ("Syntax error in Fixed or Fitted Par 1");
                  }
	      }
	    | input T_KEY T_WORD T_COMPARATOR value
	      {
		  if (!strcmp($2, "limit")) {
		      MeasuredValue tmpValue;
                      tmpValue.nofit = false;
		      tmpValue.theovalue  = 0;
		      tmpValue.name = $3;
		      tmpValue.error = -1.;
                      tmpValue.nofit = false;
		      if (strcmp($4, ">")) {
			  tmpValue.value = 1.2*$5;
			  tmpValue.bound_low = $5;
			  tmpValue.bound_up = 1.E+6;
		      } else {
			  tmpValue.value = 0.8*$5;
			  tmpValue.bound_low = -1.E+6;
			  tmpValue.bound_up = $5;
		      }
		      yyMeasuredVec.push_back(tmpValue);
		  }
	      }
	    | input T_KEY T_WORD value err
	      {

		  if (!strcmp($2, "nofit")) {
		      MeasuredValue tmpValue;
		      tmpValue.theovalue  = 0;
		      tmpValue.name = $3;
		      tmpValue.value = $4;
		      tmpValue.error = $5;
	              tmpValue.bound_low = -1.E+6;
	              tmpValue.bound_up = 1.E+6;
                      tmpValue.nofit = true;
		      yyMeasuredVec.push_back(tmpValue);
		  }
		  else if (!strcmp($2, "fitParameter")) {
	            parameter_t tmpparam;
                    tmpparam.name = $3;
                    tmpparam.value = $4;
                    tmpparam.error = $5;
                    yyFittedPar.push_back(tmpparam);
		  }
		  else if (!strcmp($2, "fixParameter")) {
	            parameter_t tmpparam;
                    tmpparam.name = $3;
                    tmpparam.value = $4;
                    yyFixedPar.push_back(tmpparam);
		  }
                  else {
		     cout << "name = " << $3 << endl;
                     yyerror ("Syntax error in Fixed or Fitted Par 2");
                  }

	      }
	    | input T_KEY T_NUMBER T_NUMBER sentence value err
	      {
		if (!strcmp($2, "edge")) {
		  MeasuredValue tmpValue;
                  tmpValue.nofit = false;
		  tmpValue.theovalue  = 0;
		  tmpValue.name = "edge ";
		  tmpValue.name.append($5);
		  tmpValue.type  = Pedge;
		  tmpValue.id    = $4;
		  if (tmpValue.id==1) {
                    tmpValue.name.append("+ ");
                  } 
	          else if (tmpValue.id==2) {
		    tmpValue.name.append("- ");
                  } else {
                    yyerror("edge type not implemented");
		  }
		  string str;
	          str.erase();
		  str = $5;
//		  cout << "decompositing string "<<str<< endl;
		  char tmpstr2[255];
		  unsigned int pos = 0, newpos = 0;
		  int anti = 1;
	          int i = 0;
		  while ((newpos = str.find(" ", pos)) != string::npos) {
		      str.copy(tmpstr2, newpos - pos, pos);
//	              cout << "tmpstr2 after str.copy "<<tmpstr2<< endl;
	              tmpstr2[newpos-pos] = '\0';
		      if (tmpstr2[newpos-pos-1] == '~') {
			  tmpstr2[newpos-pos-1] = '\0';
		      }
                      if (!strncmp(tmpstr2,"mass",4)) {
//			cout << "substracting mass" << endl;
                        while (tmpstr2[i] != '\0') {
                          tmpstr2[i] = tmpstr2[i+4];
			  i++;
                        }
                        i = 0;
                      }
		      else {
			  tmpstr2[newpos-pos] = '\0';
		      }
		      pos = newpos + 1;
//		      cout << "Adding Element: " << tmpstr2 << " with ID " <<  yyParticleIDs[tmpstr2] << endl;
		      tmpValue.daughters.push_back(yyParticleIDs[tmpstr2]);
		  }
		  tmpValue.value = $6;
		  tmpValue.error = $7;
		  tmpValue.alias = (int)$3;
		  tmpValue.bound_up = 1e+6;
		  tmpValue.bound_low = 0.;
		  yyMeasuredVec.push_back(tmpValue);
		  cout << "added edge" << endl;

		}
		
              }
	     | input T_KEY T_NUMBER T_BRA T_WORD T_GOESTO sentence T_KET value err T_ALIAS T_NUMBER
	      {
		  MeasuredValue tmpValue;
                  tmpValue.nofit = false;
		  tmpValue.type  = br;
		  tmpValue.theovalue  = 0;
		  tmpValue.name  = $5;
		  tmpValue.id    = yyParticleIDs[$5];
		  tmpValue.name.append(" -> ");
		  tmpValue.name.append($7);
		  string str;
	          str.erase();
		  str = $7;
		  char tmpstr3[255];
		  unsigned int pos = 0, newpos = 0;
		  int anti = 1;
		  while ((newpos = str.find(" ", pos)) != string::npos) {
		      str.copy(tmpstr3, newpos - pos, pos);
		      if (tmpstr3[newpos-pos-1] == '~') {
			  tmpstr3[newpos-pos-1] = '\0';
			  anti = -1;
		      }
		      else {
			  tmpstr3[newpos-pos] = '\0';
			  anti = 1;
		      }
		      pos = newpos + 1;
		      tmpValue.daughters.push_back(anti * yyParticleIDs[tmpstr3]);
		  }
		  tmpValue.value = $9;
		  tmpValue.error = $10;
		  tmpValue.alias = (int)$12;
		  tmpValue.bound_up = 1e+6;
		  tmpValue.bound_low = 0.;
		  yyMeasuredVec.push_back(tmpValue);
//		  cout << "Added branching ratio " << tmpValue.name << endl;
	          strcpy($7,"");
	      }
	     | input T_KEY T_BRA sentence T_GOESTO sentence T_COMMA value T_COMMA value T_COMMA value T_KET value err T_ALIAS T_NUMBER
	      {
		  MeasuredValue tmpValue;
                  tmpValue.nofit = false;
		  tmpValue.name.erase();
		  tmpValue.type  = xsection;
		  tmpValue.theovalue  = 0;
		  tmpValue.name  = $4;
//	          cout << "in xs: $4 = " << $4 << endl;
		  tmpValue.id    = 11;
		  tmpValue.name.append(" -> ");
		  tmpValue.name.append($6);
		  string str;
	          str.erase();
	          str = $6;
		  char tmpstr4[255];
		  unsigned int pos = 0, newpos = 0;
		  int anti = 1;
		  while ((newpos = str.find(" ", pos)) != string::npos) {
		      str.copy(tmpstr4, newpos - pos, pos);
		      if (tmpstr4[newpos-pos-1] == '~') {
			  tmpstr4[newpos-pos-1] = '\0';
			  anti = -1;
		      }
		      else {
			  tmpstr4[newpos-pos] = '\0';
			  anti = 1;
		      }
		      pos = newpos + 1;
		      tmpValue.products.push_back(anti * yyParticleIDs[tmpstr4]);
		  }
		  tmpValue.sqrts = $8;
		  tmpValue.polarisation1 = $10;
		  tmpValue.polarisation2 = $12;
		  tmpValue.value = $14;
		  tmpValue.error = $15;
		  tmpValue.alias = (int)$17;
		  tmpValue.bound_up = 1e+9;
		  tmpValue.bound_low = 0.;
		  yyMeasuredVec.push_back(tmpValue);
//		  cout << "Added cross section " << tmpValue.name << endl;
		  tmpStrings.clear();
	          tmpNumbers.clear();
		  strcpy($4,"                     ");
	          strcpy($4,"");
		  strcpy($6,"                     ");
	          strcpy($6,"");
	      }
	     | input T_KEY T_BRA sentence T_KET  value err T_ALIAS T_NUMBER
	      {
		if (!strcmp($2,"xsbr")) {
		  int i = 0;
		  int j = 0;
		  int aliasnumber;
		  char* charnumber;
		  MeasuredValue tmpValue;
                  tmpValue.nofit = false;
		  tmpValue.name.erase();
		  tmpValue.type  = xsbr;
		  tmpValue.theovalue  = 0;
		  tmpValue.value = $6;
		  tmpValue.error = $7;
		  tmpValue.name  = $4;
		  tmpValue.alias = (int)$9;
		  tmpValue.bound_up = 1e+9;
		  tmpValue.bound_low = 0.;
		  cout << "xsbr found" << endl;
		  // break sentence in pieces:
		  string str;
	          str.erase();
		  str = $4;
		  char tmpstr3[255];
		  unsigned int pos = 0, newpos = 0;
		  bool found_br = false;
		  int anti = 1;
		  while ((newpos = str.find(" ", pos)) != string::npos) {
		    str.copy(tmpstr3, newpos - pos, pos);
		    if (tmpstr3[newpos-pos-1] == '~') {
		      tmpstr3[newpos-pos-1] = '\0';
		      anti = -1;
		    }
		    else {
		      tmpstr3[newpos-pos] = '\0';
		      anti = 1;
		    }
		    pos = newpos + 1;
		    // break up:
		    if (!strncmp(tmpstr3,"sigma",5)) {
		      charnumber = strchr(tmpstr3,'_');
		      if (charnumber == 0) yyerror ("Underscore not found");
		      aliasnumber = atof((charnumber+1));
		      found_br = false;
		      for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
			if ((yyMeasuredVec[k].type == xsection) && (yyMeasuredVec[k].alias == aliasnumber)) {
			  i = k;
			  found_br = true;
			  cout << "found xs " <<  yyMeasuredVec[k].name << endl;
			  break;
			}
		      }
		      if (!found_br) {
			cout << "sigma " << aliasnumber << " not found, alias: " << tmpValue.alias <<  endl;
			yyerror (" ");			
		      }
		      // remove cross section from the list
		      cout << "removing xs from the list" << endl;
		      yyMeasuredVec[k].nofit = true;
		      tmpValue.sqrts = yyMeasuredVec[k].sqrts;
		      tmpValue.products.push_back(k);
		    }
		    else if (!strncmp(tmpstr3,"br",2)) {
		      charnumber = strchr(tmpstr3,'_');
		      if (charnumber == 0) yyerror ("Underscore not found");
		      aliasnumber = atof((charnumber+1));
		      found_br = false;
		      for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
			if ((yyMeasuredVec[k].type == br) && (yyMeasuredVec[k].alias == aliasnumber)) {
			  i = k;
			  found_br = true;
			  cout << "found br " <<  yyMeasuredVec[k].name << endl;
			  break;
			}
		      }
		      if (!found_br) {
			cout << "br " << aliasnumber << " not found, alias: " << tmpValue.alias <<  endl;
			yyerror (" ");			
		      }
		      // remove br from the list
		      cout << "removing br from the list" << endl;
		      yyMeasuredVec[k].nofit = true;
		      tmpValue.daughters.push_back(k);
		    }
		  }
		  yyMeasuredVec.push_back(tmpValue);
		}
		else if (!strcmp($2,"brratio")) {
		  int i = 0;
		  int j = 0;
		  int aliasnumber;
		  char* charnumber;
		  MeasuredValue tmpValue;
                  tmpValue.nofit = false;
		  tmpValue.name.erase();
		  tmpValue.type  = brratio;
		  tmpValue.theovalue  = 0;
		  tmpValue.value = $6;
		  tmpValue.error = $7;
		  tmpValue.name  = $4;
		  tmpValue.alias = (int)$9;
		  tmpValue.bound_up = 1e+9;
		  tmpValue.bound_low = 0.;
		  cout << "brratio found" << endl;
		  // break sentence in pieces:
		  string str;
	          str.erase();
		  str = $4;
		  char tmpstr3[255];
		  unsigned int pos = 0, newpos = 0;
		  int anti = 1;
		  bool found_br = false;
		  int countbrs = 0;
		  while ((newpos = str.find(" ", pos)) != string::npos) {
		    countbrs++;
		    if (countbrs>=3) {
		      cout << "syntax error in brratio: too many br, alias: " << tmpValue.alias <<  endl;
		      yyerror (" ");		      
		    }
		    str.copy(tmpstr3, newpos - pos, pos);
		    if (tmpstr3[newpos-pos-1] == '~') {
		      tmpstr3[newpos-pos-1] = '\0';
		      anti = -1;
		    }
		    else {
		      tmpstr3[newpos-pos] = '\0';
		      anti = 1;
		    }
		    pos = newpos + 1;
		    // break up:
		    if (!strncmp(tmpstr3,"br",2)) {
		      charnumber = strchr(tmpstr3,'_');
		      if (charnumber == 0) yyerror ("Underscore not found");
		      aliasnumber = atof((charnumber+1));
		      found_br = false;
		      for (unsigned int k = 0; k<yyMeasuredVec.size();k++) {
			if ((yyMeasuredVec[k].type == br) && (yyMeasuredVec[k].alias == aliasnumber)) {
			  i = k;
			  found_br = true;
			  cout << "found br " <<  yyMeasuredVec[k].name << endl;
			  break;
			}
		      }
		      if (!found_br) {
			cout << "br " << aliasnumber << " not found, alias: " << tmpValue.alias <<  endl;
			yyerror (" ");			
		      }
		      // remove br from the list
		      cout << "removing br from the list" << endl;
		      yyMeasuredVec[k].nofit = true;
		      tmpValue.daughters.push_back(k);
		    }
		    else {
		      cout << "syntax error in brratio, alias: " << tmpValue.alias <<  endl;
		      yyerror (" ");
		    }
		  }
		  if (countbrs<2) {
		      cout << "syntax error in brratio: not enough br, alias: " << tmpValue.alias <<  endl;
		      yyerror (" ");		      		    
		  }
		  yyMeasuredVec.push_back(tmpValue);
		}
	      }
            ;

//========================================================================
//========================================================================
//========================================================================
//========================================================================
block:      T_BLOCK T_WORD T_NEWLINE parameters
              {
//                  printf("Reading block %s...\n", $2);

//========================================================================
                  if (!strcmp($2, "MODSEL")) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
            
                          switch (int(tmpParams[i][0])) {
                          case 1:
                              yyModel = (int)tmpParams[i][1];
                              break;
			  default:
                              yyerror("Parameter in MODSEL not known");
                          }
                      }
                  }
//========================================================================
                  if (!strcmp($2, "SMINPUTS")) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
            
                          switch (int(tmpParams[i][0])) {
                          case 1:
                              yyoneoveralpha_em_mz =  tmpParams[i][1];
                              break;
                          case 2:
                              yyG_F =  tmpParams[i][1];
                              break;
                          case 3:
                              yyalpha_s_mz =  tmpParams[i][1];
                              break;
                          case 4:
                              yyMassZ = tmpParams[i][1];
			      break;
                          case 5:
                              yyMass_b = tmpParams[i][1];
			      break;
                          case 6:
                              yyMass_t = tmpParams[i][1];
			      break;
                          case 7:
                              yyMass_tau = tmpParams[i][1];
			      break;
			  default:
                              yyerror("Parameter in SMINPUTS not known");
                          }
                      }
                  }
//========================================================================
                  if (!strcmp($2, "MINPAR")) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
            		  if (int(tmpParams[i][0])==3) {
                              yytanb =  tmpParams[i][1];
                              continue;
                          }
                          if (yyModel==1) {              // mSUGRA
                              switch (int(tmpParams[i][0])) {
                              case 0:
                                  yy_Qmax =  tmpParams[i][1];
                                  break;
                              case 1:
                                  yy_m0 =  tmpParams[i][1];
                                  break;
                              case 2:
                                  yy_m12 =  tmpParams[i][1];
                                  break;
                              case 4:
                                  yy_signmu =  tmpParams[i][1];
                                  break;
                              case 5:
                                  yy_A =  tmpParams[i][1];
                                  break;
			      default:
                                  yyerror("Parameter in MINPAR not known");
                              }
                          }
                      }
                  }
//========================================================================
                  if (!strcmp($2, "SPINFO")) {
//		      cout << "tmpStrings.size()" << tmpStrings.size() << endl;
                      for (unsigned int i=0; i<tmpStrings.size(); i++) {
            
                          switch (int(tmpNumbers[i])) {
                          case 1:
                              strcpy(yy_spectrum_calc_name,tmpStrings[i].tmpname);
                              break;
                          case 2:
                              strcpy(yy_spectrum_calc_version,tmpStrings[i].tmpname);
                              break;
                          case 3:
                              strcat(yy_warnings,tmpStrings[i].tmpname);
                              break;
                          case 4:
                              strcat(yy_errors,tmpStrings[i].tmpname);
                              break;
                          case 5:
                              strcpy(yy_error_codes,tmpStrings[i].tmpname);
                              break;
			  default:
//			      cout << "tmpNumbers["<<i<<"]: "<< int(tmpNumbers[i]) << endl;
                              yyerror("Parameter in SPINFO not known");
                          }
                      }
		      tmpNumbers.clear();
                      tmpStrings.clear();
//		      cout << "after clear: tmpStrings.size()" << tmpStrings.size() << endl;
                  }
//========================================================================
                  if (!strcmp($2, "SPhenoINFO")) {
		    cout << "reading SPhenoINFO " << endl;
		  }
//========================================================================
                  if (!strcmp($2, "EXTPAR")) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
            
                          switch (int(tmpParams[i][0])) {
                          case 0:
                              yyMinput =  tmpParams[i][1];
                              break;
                          case 1:
                              yyM1 =  tmpParams[i][1];
                              break;
                          case 2:
                              yyM2 =  tmpParams[i][1];
                              break;
                          case 3:
                              yyM3 =  tmpParams[i][1];
                              break;
                          case 11:
                              yy_At =  tmpParams[i][1];
                              break;
                          case 12:
                              yy_Ab =  tmpParams[i][1];
                              break;
                          case 13:
                              yy_Atau =  tmpParams[i][1];
                              break;
                          case 21:
                              yy_m2Hd =  tmpParams[i][1];
                              break;
                          case 22:
                              yy_m2Hu =  tmpParams[i][1];
                              break;
                          case 23:
                              yy_mu =  tmpParams[i][1];
                              break;
                          case 24:
                              yy_MassA =  tmpParams[i][1];
                              break;
                          case 31:
                              yy_mse1L =  tmpParams[i][1];
                              break;
                          case 32:
                              yy_mse2L =  tmpParams[i][1];
                              break;
                          case 33:
                              yy_mse3L =  tmpParams[i][1];
                              break;
                          case 34:
                              yy_mse1R =  tmpParams[i][1];
                              break;
                          case 35:
                              yy_mse2R =  tmpParams[i][1];
                              break;
                          case 36:
                              yy_mse3R =  tmpParams[i][1];
                              break;
                          case 41:
                              yy_msq1L =  tmpParams[i][1];
                              break;
                          case 42:
                              yy_msq2L =  tmpParams[i][1];
                              break;
                          case 43:
                              yy_msq3L =  tmpParams[i][1];
                              break;
                          case 44:
                              yy_msu1R =  tmpParams[i][1];
                              break;
                          case 45:
                              yy_msu2R =  tmpParams[i][1];
                              break;
                          case 46:
                              yy_msu3R =  tmpParams[i][1];
                              break;
                          case 47:
                              yy_msd1R =  tmpParams[i][1];
                              break;
                          case 48:
                              yy_msd2R =  tmpParams[i][1];
                              break;
                          case 49:
                              yy_msd3R =  tmpParams[i][1];
                              break;
                          case 51:
                              yy_N51 =  tmpParams[i][1];
                              break;
                          case 52:
                              yy_N52 =  tmpParams[i][1];
                              break;
                          case 53:
                              yy_N53 =  tmpParams[i][1];
                              break;
			  
			  default:
                              yyerror("Parameter in EXTPAR not known");
                          }
                      }
                  }
//========================================================================
                  if (!strcmp($2, "MASS")) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
     			  yyMass[(unsigned int)tmpParams[i][0]]=tmpParams[i][1];     
                      }
                  }

		  // SPhenoLowEnergy 
//========================================================================
                  if (!strcmp($2, "SPhenoLowEnergy")) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
			if ((unsigned int)tmpParams[i][0]==1) {
     			  yybsg=tmpParams[i][1];     
			}
			else if ((unsigned int)tmpParams[i][0]==2) {
     			  yygmin2=tmpParams[i][1];     
			}
			else if ((unsigned int)tmpParams[i][0]==3) {
     			  yydrho=tmpParams[i][1];     
			}
                      }
                  }

//========================================================================
                  if (!strcmp($2, "SPhenoCrossSections")) {
		    cout << "starting to read XS..." << endl;
                  }

                  tmpParams.clear();
              }

//========================================================================
//========================================================================
            | T_BLOCK T_WORD T_SCALE T_NUMBER T_NEWLINE parameters
              {
                  yyScale = $4;
//                  printf("Reading block %s at scale %f...\n", $2, $4);

                  tmpParams.clear();
              }
            ;

//========================================================================
//========================================================================
//========================================================================
//========================================================================
decay:      T_DECAY T_NUMBER T_NUMBER T_NEWLINE parameters
              {
//                  printf("Reading decay %i...\n", (int)$2);
                  tmp_branch.decays.clear();
//                  cout << "branch cleared, tmpParams.size() = "<<tmpParams.size() << endl;
		  if (tmpParams.size()>0) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
//                         cout << "loop "<<i<<endl;
                         tmpVec.clear();
                         tmpVec.push_back(tmpParams[i][0]);
                         tmpVec.push_back(tmpParams[i][1]);
//                         cout << "filled BR and no of daughters" << endl;
        	         for (unsigned int j=2; j<2+tmpParams[i][1]; j++) {
//                             cout << "tmpParams["<<i<<"]["<<j<<"] = "<<tmpParams[i][j]<<endl;
    		             tmpVec.push_back(tmpParams[i][j]);
                         }
                         tmp_branch.decays.push_back(tmpVec);
                      }
    		  tmp_branch.TWidth = $3;
    		  branching_ratios[(int)$2] = tmp_branch;
		  } else {
    		      tmp_branch.TWidth = 0.;	
		      tmpVec.clear();
                      tmpVec.push_back(0.);
                      tmpVec.push_back(0.);
                      tmp_branch.decays.push_back(tmpVec);
       		      branching_ratios[(int)$2] = tmp_branch;
                  }
		  tmpParams.clear();
              }
            ;	

//========================================================================
//========================================================================
//========================================================================
//========================================================================
xs:         T_XS T_NUMBER T_NUMBER T_NUMBER T_NUMBER T_NUMBER T_NUMBER T_NEWLINE parameters
              {
                  printf("Reading xs %i...\n", (int)$2);

                  tmp_xs.xs.clear();
//                  cout << "branch cleared, tmpParams.size() = "<<tmpParams.size() << endl;
		  if (tmpParams.size()>0) {
                      for (unsigned int i=0; i<tmpParams.size(); i++) {
//                         cout << "loop "<<i<<endl;
                         tmpVec.clear();
                         tmpVec.push_back(tmpParams[i][0]);
                         tmpVec.push_back(tmpParams[i][1]);
//                         cout << "filled XS and no of primaries" << endl;
	                 for (unsigned int j=2; j<2+tmpParams[i][1]; j++) {
//                             cout << "tmpParams["<<i<<"]["<<j<<"] = "<<tmpParams[i][j]<<endl;
		             tmpVec.push_back(tmpParams[i][j]);
                         }
                         tmp_xs.xs.push_back(tmpVec);
                      }
		      tmp_xs.initials[0] = (int)$2;
		      tmp_xs.initials[1] = (int)$3;
		      tmp_xs.ecm = $4;
		      tmp_xs.polarisation[0] = $5;
		      tmp_xs.polarisation[1] = $6;
		      tmp_xs.isr = (int)$7;
		      tmp2Vec.clear();
		      tmp2Vec.push_back($2);
		      tmp2Vec.push_back($4);
		      tmp2Vec.push_back($5);
		      tmp2Vec.push_back($6);
		      cross_sections[tmp2Vec] = tmp_xs;
//                      cout << "filling xs for " << $2 << " " << $5 << " " << $6 << endl;
//		      for (unsigned int k=0; k<tmp_xs.xs.size();k++ ) {
//		       cout <<  " k = " << k << " products " << tmp_xs.xs[k][2] << 
//                              " " << tmp_xs.xs[k][3] << endl;
//                      }
		  } else {
		      tmp_xs.initials[0] = (int)$2;
		      tmp_xs.initials[1] = (int)$3;
		      tmp_xs.ecm = $4;
		      tmp_xs.polarisation[0] = $5;
		      tmp_xs.polarisation[1] = $6;
		      tmp_xs.isr = (int)$7;
		      tmpVec.clear();
                      tmpVec.push_back(0.);
                      tmpVec.push_back(0.);
                      tmp_xs.xs.push_back(tmpVec);
		      tmp2Vec.clear();
		      tmp2Vec.push_back($2);
		      tmp2Vec.push_back($5);
		      tmp2Vec.push_back($6);
		      cross_sections[tmp2Vec] = tmp_xs;
                  }

		  tmpParams.clear();
              }
            ;	

//========================================================================
//========================================================================
//========================================================================
//========================================================================
parameters: /* empty */
            | parameters T_NEWLINE
            | parameters T_NUMBER T_NUMBER T_NEWLINE
              {
                  tmpVec.clear();
                  tmpVec.push_back($2);
                  tmpVec.push_back($3);                  
                  tmpParams.push_back(tmpVec);
              }
            | parameters T_NUMBER T_NUMBER T_NUMBER T_NEWLINE
              {
                  tmpVec.clear();
                  tmpVec.push_back($2);
                  tmpVec.push_back($3);                  
                  tmpVec.push_back($4);
                  tmpParams.push_back(tmpVec);
              }
            | parameters T_NUMBER T_NUMBER T_NUMBER T_NUMBER T_NEWLINE
              {
                  tmpVec.clear();
                  tmpVec.push_back($2);
                  tmpVec.push_back($3);                  
                  tmpVec.push_back($4);
                  tmpVec.push_back($5);
                  tmpParams.push_back(tmpVec);
              }
            | parameters T_NUMBER T_NUMBER T_NUMBER T_NUMBER T_NUMBER T_NEWLINE
              {
                  tmpVec.clear();
                  tmpVec.push_back($2);
                  tmpVec.push_back($3);                  
                  tmpVec.push_back($4);
                  tmpVec.push_back($5);
                  tmpVec.push_back($6);
                  tmpParams.push_back(tmpVec);
              }
            | parameters T_NUMBER sentence T_NEWLINE
              {
//	         cout << "parsing string for tmpStrings" << endl;
//                 cout << "$1 = " << $1 << "$2 = " << $2 << endl;
		 strcpy(tmpstr.tmpname,$3);
                 tmpStrings.push_back(tmpstr);
                 tmpNumbers.push_back((int)$2);
                 strcpy($3,"");
              }
           | parameters T_NUMBER T_NEWLINE
              {
	         
	      }
            ;

//===================================================================
//===================================================================
//===================================================================
//===================================================================
sentence:   T_WORD
              {
//                 cout << "found lonely word" << endl;
                 strcpy($$,$1);			 
                 strcat($$," ");			 
              }
            | sentence T_WORD 
              {
//                  cout << "appending string "<< $2 << " to string " << $$ << endl;
                  strcat($$,$2);
		  strcpy($2,"");
                  strcat($$," ");
//                  cout << "having appended "<< $2 << " to string " << $$ << endl;
              }
            ; 

err:       T_ERRORSIGN value
             {
                 $$ = $2;
             }
           | err T_ERRORSIGN value
             {
                 $$ = TMath::Sqrt($1 * $1 + $3 * $3);
             }
           ;
 
value:     T_NUMBER                        { $$ = $1; }
           | T_NUMBER T_ENERGYUNIT         { $$ = $1 * TMath::Power(10, $2); }
           | T_NUMBER T_CROSSSECTIONUNIT   { $$ = $1 * TMath::Power(10, $2); }
           ;

%%

void yyerror(char* s) {
    fprintf(stderr, "Error while reading input file: %s\n", s);
    exit(EXIT_FAILURE);
}

char yyBlockName[255];
double yyScale;
// SMINPUTS
double yyG_F;		     
double yyoneoveralpha_em_mz; 
double yyalpha_s_mz;	     
double yyMassZ;		     
double yyMass_b;	     
double yyMass_t;	     
double yyMass_tau;              
//MODEL
int    yyModel;
// MINPAR
double yy_Qmax;
double yytanb;
double yy_m0;
double yy_m12;
double yy_signmu;
double yy_A;
// EXTPAR
double yyMinput;
double yyM1;
double yyM2;
double yyM3;
double yy_At;
double yy_Ab;
double yy_Atau;
double yy_m2Hd;
double yy_m2Hu;
double yy_mu;
double yy_MassA;
double yy_mse1L;
double yy_mse2L;
double yy_mse3L;
double yy_mse1R;
double yy_mse2R;
double yy_mse3R;
double yy_msq1L;
double yy_msq2L;
double yy_msq3L;
double yy_msu1R;
double yy_msu2R;
double yy_msu3R;
double yy_msd1R;
double yy_msd2R;
double yy_msd3R;
double yy_N51;
double yy_N52;
double yy_N53;

// SPINFO
char yy_spectrum_calc_name[256];
char yy_spectrum_calc_version[256];
char yy_warnings[1024];
char yy_errors[1024];
char yy_error_codes[1024];
typedef struct {
    char tmpname[256];
} tmpstr_t;
tmpstr_t tmpstr;
vector<tmpstr_t> tmpStrings;
vector<int> tmpNumbers;


// MASS
map<int,double> yyMass;


// DECAY
decay_element_t tmp_branch;
map<int,decay_element_t> branching_ratios;


// XS
xs_element_t tmp_xs;
map<doubleVec_t,xs_element_t> cross_sections;



doubleVec_t tmpVec, tmp2Vec;
vector<doubleVec_t> tmpParams;

int found;
 
vector<MeasuredValue> yyMeasuredVec; // contains measured observables
vector<MeasuredValue> yyThrownVec;   // contains smeared observables
 
vector<MeasuredValue> yyFittedVec; // contains mu, M1, M2 ...
vector<MeasuredValue> yyUniversalityVec;
vector<MeasuredValue> yyFixedVec;  // contains mu, M1, M2 ...
 
CorrelationMatrix     yyMeasuredCorrelationMatrix(&yyMeasuredVec);
CorrelationMatrix     yyFittedCorrelationMatrix(&yyFittedVec);

vector <parameter_t> yyFixedPar;
vector <parameter_t> yyFittedPar;
vector <parameter_t> indchisq_vec;
 
bool          yyUseLoopCorrections;
bool          yyCalcPullDist;
bool          yyScanParameters;
bool          yyISR;
bool          yyGeneratorError;
bool          yyUseMinos;
bool          yyGetContours = false;
bool          yyUseHesse;
bool          yyUseSimAnnBefore = false;
bool          yyUseSimAnnWhile = false;
bool          yyUseGivenStartValues;
bool          yyFitAllDirectly;
bool          yyCalcIndChisqContr;
bool          yyBoundsOnX = true;
bool          yySepFitTanbX = true;
bool          yySepFitTanbMu = false;
bool          yySepFitmA = false;
bool          yyScanX = true;

unsigned int yyGenerator;
string       yyGeneratorPath = "";
 
map<int,string> yyParticleNames;
map<string,int> yyParticleIDs;

int           yyParseError = 0;
int           yyNumberOfMinimizations = 1;
double        yyErrDef = 1.;
int           yyMaxCallsSimAnn = 300000;
double        yyTempRedSimAnn = 0.4;
int           yyNumberPulls = 0;

double        yyXscanlow = -6000.;
double        yyXscanhigh = 2000.;

double        yybsg = -10000.;
double        yygmin2 = -10000.;
double        yydrho  = -10000.;
