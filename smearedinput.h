/***************************************************************************
                               smearedinput.h
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

#ifndef FITTINO_SMEAREDINPUT_H
#define FITTINO_SMEAREDINPUT_H

#include <misc.h>

class Input;

class SmearedInput {
public:
    SmearedInput(const Input* input);
    virtual ~SmearedInput();

    void          setToMean();
    void          throwDice();

    const MeasuredValue&  GetValue(const string& name) const;

    const vector<MeasuredValue>&  GetThrownVector() const { return fThrownVec; }

protected:
    const Input*  fInput;

    vector<MeasuredValue>  fThrownVec;
};

#endif
