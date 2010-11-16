/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.h                                                      *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELBASE_H
#define FITTINO_MODELBASE_H

#include <string>
#include <vector>

#include "Parameter.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Base class for Fittino models. 
   */
  class ModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                              ModelBase();
      /*!
       *  Standard destructor.
       */
                              ~ModelBase();
      /*!
       *  Returns the number of parameters of the model.
       */
      int                     GetNumberOfParameters() const;
      /*!
       *  Returns the name of the model.
       */
      std::string             GetName() const;
      /*!
       *  Returns the parameters of the model as a vector.
       */
      std::vector<Parameter>* GetParameterVector();
      /*!
       *  Returns the chi2 of the comparison between the predicted observables of the model and\n
       *  the measured observables. In the case of a test model simply returns the function value.
       */
      virtual double          Evaluate() = 0;
      /*!
       *  Returns a pointer to a copy of the model.
       */
      virtual ModelBase*      Clone() const = 0;

    protected:
      /*!
       *  Number of the model parameters.
       */
      int                     _numberOfParameters;
      /*!
       *  Name of the model.
       */
      std::string             _name;
      /*!
       *  Stores the model parameters.
       */
      std::vector<Parameter>  _parameterVector;

    protected:
      /*!
       *  Initializes the model with a name and the starting values for the parameters.
       */
      void                    InitializeModel() const;
      /*!
       *  Prints the configuration of the model, i.e. its name and the starting values of the\n
       *  parameters
       */
      void                    PrintConfiguration() const;

  };

}

#endif // FITTINO_MODELBASE_H
