
/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleSampler.h                                             *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SimpleSampler_H
#define FITTINO_SimpleSampler_H

#include "SamplerBase.h"
#include <vector>


namespace Fittino {


  class SimpleSampler : public SamplerBase {

    public:

                             SimpleSampler( ModelBase* model );

                             ~SimpleSampler();


    private:
      std::vector<double>    _incrementValues;
      std::vector<double>    _upperBoundValues;
      std::vector<double>    _lowerBoundValues;
      int                    _delta1Points;
      int                    _delta2Points;
      int                    _allPoints;

    private:
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();
      virtual void           Scan(int index);
      virtual void           UpdateValues(int i);
      virtual void           ResetValues(int i);


  };

}

#endif // FITTINO_SimpleSampler_H

