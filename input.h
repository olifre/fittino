/***************************************************************************
                                   input.h
                             -------------------    
    Class that parses a given input file, stores the read values and
    makes them available.
                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : November 30, 2003
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

#ifndef FITTINO_INPUT_H
#define FITTINO_INPUT_H

#include <misc.h>


class Input {
private:
    vector<MeasuredValue>  fMeasuredVec;

    CorrelationMatrix      fMeasuredCorrelationMatrix;
    void CheckDefault(string name, int ID, double value, double error);
    void Fill_IDs();
    void FillCrossSectionProduction();
public:
    Input(const char* inputfile);
    virtual ~Input();

    const vector<MeasuredValue>&  GetMeasuredVector() const { return fMeasuredVec; }
    const CorrelationMatrix&      GetMeasuredCorrelationMatrix() const { return fMeasuredCorrelationMatrix; }
    int ReturnParticleID(string name);
    string ReturnParticleName(int ID);
    void FillNameMap();
    void DumpMeasuredVector();
    void ScatterObservablesBefore();
};

#endif
