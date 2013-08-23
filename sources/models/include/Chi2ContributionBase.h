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
       *  Standard constructor.
       */
                   Chi2ContributionBase( std::string name );
      /*!
       *  Standard destructor.
       */
                   ~Chi2ContributionBase();
      virtual void UpdateValue() = 0;

    public:
      double       GetValue() const;
      void         PrintStatus() const;
      std::string  GetName() const;

    protected:
      double       _chi2;
      std::string  _name;

  };

}

#endif // FITTINO_CHI2CONTRIBUTIONBASE_H
