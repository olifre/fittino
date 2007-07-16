/***************************************************************************
                              smearedinput.cpp
                             -------------------
    Class that provides gaussian smeared values around the values given
    in the Input class object passed to constructor
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

#include <TMath.h>
#include <smearedinput.h>
#include <input.h>

#include <TRandom.h>


SmearedInput::SmearedInput(const Input* input)
{
    fInput = input;

    setToMean();
}


SmearedInput::~SmearedInput()
{
    fThrownVec.clear();
}


void SmearedInput::setToMean()
{
    fThrownVec = fInput->GetMeasuredVector();
}


void SmearedInput::throwDice()
{
  // WARNING: For the time being correlations are not taken into account!!!
  // ======================================================================
  // cout << "correlation: "<< fInput->GetMeasuredCorrelationMatrix().GetCorrelation(0, 0)<< endl;
  //cout << "covariance : "<< fInput->GetMeasuredCorrelationMatrix().GetCovariance(0, 0)<< endl;

  for (unsigned int i=0; i<fInput->GetMeasuredVector().size(); i++) {
    fThrownVec[i].value = gRandom->Gaus(fInput->GetMeasuredVector()[i].value, TMath::Sqrt(fInput->GetMeasuredCorrelationMatrix().GetCovariance(i, i)));
  }
}


const MeasuredValue& SmearedInput::GetValue(const string& name) const
{
  for (unsigned int i=0; i<fThrownVec.size(); i++) {
      if (fThrownVec[i].name == name) return fThrownVec[i];
  }

  cerr<<"Value "<<name<<" not found"<<endl;
  exit(EXIT_FAILURE);
}
