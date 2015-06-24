/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Correlation.h                                                    *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*    	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CORRELATION_H
#define FITTINO_CORRELATION_H

#include<vector>
#include<string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Measurement;
    class Quantity;

    /*!
   *  \ingroup calculators
   *  \brief .
   */
  class Correlation {

    public:

                             Correlation( const std::vector<Measurement*>& measurements,
                                          const boost::property_tree::ptree& ptree );
                             ~Correlation();
      double                 GetCovariance() const;
      const std::vector<const Quantity*>&  GetUncertainties() const;
      const std::vector<unsigned int>& GetIndices() const;

    private:
      double                           _correlation;
      std::vector<unsigned int>        _indices;
      std::vector<const Quantity*>     _uncertainties;
      const std::vector<Measurement*>& _measurements;

    private:
      void                          AddUncertainty( std::string name );

  };

}

#endif
