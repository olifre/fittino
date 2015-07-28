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

#include <vector>
#include <string>
#include <map>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Measurement;
    class Quantity;

    /*!
   *  \ingroup calculators
   *  \brief
     *  A helper class of Chi2Calculator.
     *
     *  Represents a correlation rho^Name_ij between the uncertainty with name Name of the observables i and j.
   */
  class Correlation {

    public:

      /*!
       * \param[in] observables
       * \copydoc _observables
       * \param[in] ptree Configuration consisting of the following nodes:
       * - _string_ __Name__ The name of the correlation and the corresponding uncertainties. Restricted to non-empty values.
       * - _double_ __Value__ \copydoc _correlation
       *
       * - _string_ <b>%Observable</b> Name of the observable this correlation refers to.
       */
      Correlation( const std::vector<const Measurement*>&  observables,
                   const boost::property_tree::ptree& ptree );
      /*!
       *
       */
      ~Correlation();
      /*!
       * \return
       * \copydoc _covariance
       *
       */
      const double& GetCovariance() const;
    /*!
       * \return
       * \copydoc _id
       */
      const std::pair<std::string, std::pair<unsigned int, unsigned int>>& GetID() const;

    /*!
     * Updated the covariance according to the current values of the uncertainties of the observables.
     */
      void Update();

    private:
      /*!
       * \param[in] observable The name of an observable contained in the vector \ref _observables.
       * \return
       * The position of the observable with the given name in the vector \ref _observables.
       */
      unsigned int GetIndex( std::string observable ) const;

    private:
      /*!
       * %Correlation coefficient.
       */
      double _correlation;
      /*!
       * The covariance rho_ij*sigma_i*sigma_j
       */
      double _covariance;
      /*!
       * A vector of observables containing the two observables this correlation refers to.
       */
      const std::vector<const Measurement*>& _observables;

      /*!
       * The ID of the correlation, i.e. a pair of its name and its indices.
       * The name of the correlation is also the name of the corresponding uncertainties.
       * The indices of the correlation are also the positions of the corresponding observables.
       * The ID uniquely identfies the correlation.
       */
      std::pair<std::string, std::pair<unsigned int, unsigned int>> _id;

  };

}

#endif
