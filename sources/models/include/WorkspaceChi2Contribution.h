/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        WorkspaceChi2Contribution.h                                      *
*                                                                              *
* Description Class for chi2 contribution provided in a Root Workspace         *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*     	      published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_WORKSPACECHI2CONTRIBUTION_H
#define FITTINO_WORKSPACECHI2CONTRIBUTION_H

#include <boost/property_tree/ptree.hpp>

#include "Chi2ContributionBase.h"

class RooAbsReal;
class RooWorkspace;
class TFile;

/*!
 *  \brief Fittino namepsace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Class for observables provided in a Root Workspace.
   */
  class WorkspaceChi2Contribution : public Chi2ContributionBase {

    public:
      /*!
       *  Constructor.
       */
                    WorkspaceChi2Contribution( std::string name,
                                               std::string fileName,
                                               std::string workspaceName,
                                               std::string predictionFileName );
      /*!
       *  Standard constructor
       */
                    WorkspaceChi2Contribution( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                    ~WorkspaceChi2Contribution();
      /*!
       *  Update prediction for new set of parameters.
       */
      virtual void  UpdateValue();

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

      /*! \endcond UML */

  };

}

#endif // FITTINO_WORKSPAECEOBSERVABLE_H
