/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.h                                                      *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELBASE_H
#define FITTINO_MODELBASE_H

#include <map>
#include <string>
#include <vector>

#include "TRandom3.h"

#include "Collection.h"
#include "PredictionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Chi2ContributionBase;
  class ModelParameterBase;
  class PredictionBase;

  /*!
   *  \defgroup models
   */
  /*!
   *  \ingroup models
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
       *  Returns the chi2 of the comparison between the predicted observables of the model and\n
       *  the measured observables. In the case of a test model simply returns the function value.
       */
      double                                            GetChi2();
      /*!
       *  Returns the number of chi2 contributions which add up to the total chi2.
       */
      int                                               GetNumberOfChi2Contributions() const;
      /*!
       *  Returns the number of parameters of the model.
       */
      int                                               GetNumberOfParameters() const;
      /*!
       *  Returns the number of predictions of the model.
       */
      int                                               GetNumberOfPredictions() const;
      /*!
       *  Adds a parameter to the model.
       */
      void                                              AddParameter( ModelParameterBase* parameter );
      /*!
       *  Adds a prediction to the model.
       */
      void                                              AddPrediction( PredictionBase* prediction );	
      /*!
       *  Returns the name of the model.
       */
      std::string                                       GetName() const;

    public:  
      /*!
       *  Returns the parameters of the model as a map.
       */
      const std::map<std::string, ModelParameterBase*>* GetParameterMap() const;
      /*!
       *  Returns the chi2 contributions of the model as a vector.
       */
      const std::vector<Chi2ContributionBase*>*         GetChi2ContributionVector() const;
      /*!
       *  Returns the parameters of the model as a vector.
       */
      const std::vector<ModelParameterBase*>*           GetParameterVector() const;
      /*!
       *  Returns the predictions of the model as a vector.
       */
      const std::vector<PredictionBase*>*               GetPredictionVector() const;
      /*!
       *  Returns the predictions of the model as a collection.
       */
      const Collection<PredictionBase*>&                GetCollectionOfPredictions() const;

    public:
      virtual void                                      PrintStatus() const = 0;
      /*!
       *  Returns a pointer to a copy of the model.
       */
      virtual ModelBase*                                Clone() const = 0;
			/*!
			 *  Smears the observables (if existent)
			 */
			virtual void																			SmearObservables( TRandom3* ) = 0;
			

    protected:
      /*!
       *  Name of the model.
       */
      std::string                                       _name;
      /*!
       *  Stores the chi2 contributions of the model.
       */
      std::vector<Chi2ContributionBase*>                _chi2ContributionVector;
      /*!
       *  Stores the predictions.
       */
      std::vector<PredictionBase*>                      _predictionVector;

    protected:
      /*!
       *  This function is mainly used to provide a dedicated command to print the model\n
       *  configuration to the screen and is usually called at the end of the model constructor\n
       *  after the actual "initialization" of the model is already finished. Therefore, it should\n
       *  not be used to alter the state of the model. However, since third party code (like e.g.\n
       *  model calculators) sometimes does not differ between initialization and printing, this\n
       *  is also the place where third party code is initialized.
       */
      virtual void                                      Initialize() const = 0;

      /*! \cond UML */
    private:   
      /*!
       *  Value returned by Evaluate(). 
       */
      double                                            _chi2;
      /*!
       *  Stores the model parameters.
       */
      std::vector<ModelParameterBase*>                  _parameterVector;
      /*!
       *  Stores the model parameters.
       */
      std::map<std::string, ModelParameterBase*>        _parameterMap;
      /*!
       *  Stores the predictions.
       */
      Collection<PredictionBase*>                       _collectionOfPredictions;

    private:
      /*!
       *  Evaluates the chi2 function.  
       */
      virtual double                                    Evaluate() = 0;
			
      /*! \endcond UML */

  };

}

#endif // FITTINO_MODELBASE_H
