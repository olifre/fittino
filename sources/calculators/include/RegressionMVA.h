/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RegressionMVA.h                                                  *
*                                                                              *
* Description Helper class for RegressionCalculator                            *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_REGRESSIONMVA_H
#define FITTINO_REGRESSIONMVA_H

#include "Collection.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare > class basic_ptree;
    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

namespace TMVA {

  class Reader;

}

namespace Fittino {

  class PredictionBase;

  /*!
   *  \ingroup calculators
   *  \brief Helper class for RegressionCalculator representing a multivariate analysis
   */
  class RegressionMVA {

  public:
    RegressionMVA( TMVA::Reader& reader, const boost::property_tree::ptree& ptree );
    ~RegressionMVA( );

  public:
    void                                    Update();
    Collection< PredictionBase*>&           GetCollectionOfQuantities() ;

  public:
    const std::string&                      GetName() const;
    
  private:
    std::string                            _name;
    std::vector<double*>                   _vectorOfDoubleTargets;
    std::vector<float >                    _vectorOfFloatTargets;
    TMVA::Reader&                          _reader;  
    Collection<PredictionBase*>            _collectionOfQuantities;

  };

}


#endif
