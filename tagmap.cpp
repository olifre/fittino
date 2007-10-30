/***************************************************************************
                                 tagmap.cpp
                             -------------------    
    Class which provides correlated error tagmap.
                             -------------------
    $Id: tagmap.cpp 151 2007-07-31 10:11:23Z uhlenbrock $
    $Name$
                             -------------------

    begin             : September 10, 2003
    authors           : Philip Bechtle, Mathias Uhlenbrock, Peter Wienemann
    email             : philip.bechtle@desy.de, peter.wienemann@desy.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "misc.h"

TagMap::TagMap(vector<MeasuredValue>* measuredvector) {
   fMeasuredVector = measuredvector;
   /* filling the tagmap */
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (map<string, double>::iterator correrrorentry = (*fMeasuredVector)[i].correrror.begin(); correrrorentry != (*fMeasuredVector)[i].correrror.end(); correrrorentry++) {
	 if (this->empty() || (this->count(correrrorentry->first) == 0)) {
	    /* insert new entry */
	    vector<MeasuredValue*> newvector;
	    newvector.push_back(&(*fMeasuredVector)[i]);
	    pair<string, vector<MeasuredValue*> > newentry(correrrorentry->first, newvector);
	    this->insert(newentry);
	 }
	 /* adding new vector component to existent entry */
	 else (*this)[correrrorentry->first].push_back(&(*fMeasuredVector)[i]);
      }
   }
}

void TagMap::Print() {
   cout << "printing tagmap information:" << endl;
   cout << "tagmap size: " << this->size() << endl;
   cout << "tagmap structure:" << endl;
   cout << endl;
   for (map<string, vector<MeasuredValue*> >::iterator mapentry = this->begin(); mapentry != this->end(); mapentry++) {
      cout << mapentry->first << endl;
      for (unsigned int i=0; i<mapentry->second.size(); i++) {
	 cout << mapentry->second[i]->position << " " << mapentry->second[i]->correrror[mapentry->first] << endl;
      }
      cout << endl;
   }
}
