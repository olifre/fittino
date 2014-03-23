/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RegressionMVA.h                                                  *
*                                                                              *
* Description Helper class for RegressionCalculator representing a             *
*             multivariate analysis                                            *
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
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief TMVA namespace.
 */
namespace TMVA {

  class Reader;

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PredictionBase;

  /*!
   *  \ingroup calculators
   *  \brief Helper class for RegressionCalculator representing a multivariate analysis.
   */
  class RegressionMVA {

    public:
      RegressionMVA( TMVA::Reader& reader, const boost::property_tree::ptree& ptree );
      ~RegressionMVA();
      void                         Update();
      const std::string&           GetName() const;
      Collection<PredictionBase*>& GetCollectionOfQuantities();

    private:
      std::string                  _name;
      std::vector<double*>         _vectorOfDoubleTargets;
      std::vector<float >          _vectorOfFloatTargets;
      TMVA::Reader&                _reader;
      Collection<PredictionBase*>  _collectionOfQuantities;

  };

}

#endif // FITTINO_REGRESSIONMVA_H
