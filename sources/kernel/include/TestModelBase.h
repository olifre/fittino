/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TestModelBase.h                                                  *
*                                                                              *
* Description Base class for Fittino test models                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_TESTMODELBASE_H
#define FITTINO_TESTMODELBASE_H

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Base class for Fittino test models.
   */
  class TestModelBase : public ModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      TestModelBase( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~TestModelBase();

    public:
      virtual void                               PrintStatus() const;
      /*!
       *  \todo Remove when no longer used by derived classes (Matthias).
       */
      virtual const Collection<CalculatorBase*>& GetCollectionOfCalculators() const {
        return *( new Collection<CalculatorBase*> );
      }

    protected:
      virtual void                               Initialize();

      /*! \cond UML */
    private:
      virtual void Evaluate();
      virtual double                             TestModelFunction() = 0;

      /*! \endcond UML */

  };

}

#endif // FITTINO_TESTMODELBASE_H
