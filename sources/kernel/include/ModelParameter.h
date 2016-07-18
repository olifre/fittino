/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelParameter.h                                                 *
*                                                                              *
* Description Class for model parameters                                       *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELPARAMETER_H
#define FITTINO_MODELPARAMETER_H

#include "Quantity.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Class for model parameters.
   */
  class ModelParameter : public Quantity {

    public:
      /*!
       *  Standard constructor.
       */
      ModelParameter( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ModelParameter();
      bool                         IsFixed() const;
      /*!
       *  Returns true when the parameter value has been set.
       */
      bool                         IsUpdated() const;
      /*!
       *  Returns the error of the parameter.
       */
      double                       GetError() const;
      double                       GetMinError() const;
      void                         Initialize() const;
      void                         PrintStatus() const;
      /*!
       *  Sets the return value of IsUpdated().
       */
      void                         SetUpdated( bool updated );
      /*!
        *  Sets the value of the parameter.
        */
      void                         SetValue( double value );
      /*!
        *  Update property tree.
        */
      void                         UpdatePropertyTree();

    protected:
      /*!
       *  If true, the parameter value is not updated by the analysis tool. Per default it is set\n
       *  to false.
       */
      bool                         _fixed;
      /*!
       *  Error of the parameter. Analysis tools use this value as the parameter-dependent\n
       *  "stepwidth".
       */
      bool                         _updated;
      double                       _error;
      double                       _minError;

      /*! \cond UML */
    private:
      boost::property_tree::ptree& _ptree;

    private:
      void                         ConsistencyCheck() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_MODELPARAMETER_H
