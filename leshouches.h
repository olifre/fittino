/***************************************************************************
                                leshouches.h
                             -------------------    
    Everything needed to parse Les Houches files.
                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : December 07, 2003
    authors              : Philip Bechtle, Peter Wienemann
    email                : philip.bechtle@desy.de, peter.wienemann@desy.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef LESHOUCHES_H
#define LESHOUCHES_H

#include <stdio.h>
#include <vector.h>
#include <map.h>
extern FILE* yyin;

extern "C" {
int yylex(void);
void yyerror(char*);
int yyparse(void);
int yywrap(void);
}


extern double yyScale;
extern double yyMassZ;
extern double yyG_F;
extern double yyoneoveralpha_em_mz;
extern double yyalpha_s_mz;
extern double yyMass_b;
extern double yyMass_t;
extern double yyMass_tau;
extern int    yyModel;
extern double yy_Qmax;
extern double yytanb;
extern double yy_m0;
extern double yy_m12;
extern double yy_signmu;
extern double yy_A;
extern double yyMinput;
extern double yyM1;
extern map<int,double> yyMass;


typedef vector<double> doubleVec_t;

typedef struct {
  double TWidth;
  vector<doubleVec_t> decays;
} decay_element_t;

extern map<int,decay_element_t> branching_ratios;

typedef struct {
  int initials[2];
  double ecm;
  double polarisation[2];
  int isr;
  vector<doubleVec_t> xs;
} xs_element_t;

extern map<doubleVec_t,xs_element_t> cross_sections;

extern double give_br ( int id, int decay, int element );
extern double give_xs ( int initial, int channel, int element );

extern char yy_spectrum_calc_name[256];
extern char yy_spectrum_calc_version[256];
extern char yy_warnings[1024];
extern char yy_errors[1024];
extern char yy_error_codes[1024];

#endif
