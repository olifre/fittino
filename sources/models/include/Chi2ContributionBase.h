/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Chi2ContributionBase.h                                           *
*                                                                              *
* Description Base class for chi2 contributions                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CHI2CONTRIBUTIONBASE_H
#define FITTINO_CHI2CONTRIBUTIONBASE_H

#include <string>

#include <boost/property_tree/ptree.hpp>

class TRandom3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for chi2 contributions.
   */
  class Chi2ContributionBase {

    public:
      /*!
       *  Constructor taking a name as an argument.
       */
                   Chi2ContributionBase( std::string name );
      /*!
       *  Standard Constructor
       */ 
                   Chi2ContributionBase( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                   ~Chi2ContributionBase();
      virtual void UpdateValue() = 0;
      virtual void SmearObservation( TRandom3* ) = 0;

    public:
      double       GetValue() const;
      void         SetValue( double chi2 );
      void         PrintStatus() const;
      std::string  GetName() const;
      
    protected:
      double       _chi2;
      std::string  _name;

  };

}

#endif // FITTINO_CHI2CONTRIBUTIONBASE_H
