/* $Id: WorkspaceObservable.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        WorkspaceObservable.h                                            *
*                                                                              *
* Description Class for observables provided in a Root Workspace               *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*     	      published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_WORKSPACEOBSERVABLE_H
#define FITTINO_WORKSPACEOBSERVABLE_H

class RooAbsReal;
class RooWorkspace;
class TFile;

#include "ObservableBase.h"

/*!
 *  \brief Fittino namepsace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Class for observables provided in a Root Workspace.
   */
  class WorkspaceObservable : public ObservableBase {

    public:
      /*!
       *  Constructor.
       */
                    WorkspaceObservable( std::string name,
                                         int id,
                                         std::string fileName,
                                         std::string workspaceName,
                                         std::string predictionFileName );
      /*!
       *  Standard destructor.
       */
                    ~WorkspaceObservable();
      /*!
       *  Update prediction for new set of parameters.
       */
      void          UpdatePrediction();

      /*! \cond UML */
    private:
      /*!
       *  The value of the _logLikelihood for the background (SM) hypothesis.
       */
      double        _llBG;
      /*!
       *  Name of file from which the predicted value has to be updated.
       */
      std::string   _predictionFileName;
      /*!
       *  RooStats object for the full likelihood - from this the Chi2 is calculated.
       */
      RooAbsReal*   _logLikelihood;
      /*!
       *  The workspace to be read from _workspaceFile containing the full analysis.
       */
      RooWorkspace* _workspace;
      /*!
       *  The rootfile containing the workspace including the full analysis.
       */
      TFile*        _workspaceFile;

    private:
      /*!
       *  Calculate chi2 contribution from this observable.
       */
      //void          CalculateChi2();

      /*! \endcond UML */

  };

}

#endif // FITTINO_WORKSPAECEOBSERVABLE_H
