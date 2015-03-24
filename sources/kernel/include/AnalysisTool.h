/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AnalysisTool.h                                                   *
*                                                                              *
* Description Abstract class which provides basic functionality for analysis   *
*             tools like optimizers or samplers                                *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ANALYSISTOOL_H
#define FITTINO_ANALYSISTOOL_H

#include "Tool.h"

class TTree;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;
  class RandomGenerator;

  /*!
   *  \ingroup kernel
   *  \brief Abstract class which provides basic functionality for analysis tools like optimizers or
   *  samplers.
   *
   *  This class contains auxiliary objects needed by every analysis tool such as the tool's name,\n
   *  a pointer to the model to be analysed, a counter for the number of iteration steps and a\n
   *  random number generator.
   */
  class AnalysisTool : public Tool {

    public:
      /*!
       *  Takes as input a pointer to the model to be analysed. Via this pointer an association\n
       *  between a model and any class deriving from AnalysisTool (especially the concrete\n
       *  optimizer or sampler classes) is established.
       */
      AnalysisTool( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~AnalysisTool();

    protected:
      /*!
       *  Stores the status parameters.
       *  \todo Short-term: Replace vector with Collection.
       */
      std::vector<Quantity*>        _statusParameterVector;

    protected:
      /*!
       *  Saves some of the meta data for a run: measured values of observables and the
       *  uncertainties.
       *  \todo Move into ExecuteAnalysisTool() (and make private) once observable smearing is
       *  fixed.
       */
      void                          FillMetaDataTree();
      /*!
       *  Saves the tool's current status (steering parameters, model parameters and observable\n
       *  predictions at a certain iteration step) which is eventually written to an output file.\n
       *  At which point of the analysis this is done has to be specified by any concrete analysis\n
       *  tool.
       */
      void                          FillTree();
      void                          PrintSteeringParameters() const;
      /*!
       *  Returns the list of status parameters.
       *  \todo Short-term: Eventually replace with GetCollectionOfStatusParameters().
       */
      const std::vector<Quantity*>* GetStatusParameterVector() const;

      /*! \cond UML */
    private:
      /*!
       *  Saves the default status for the model Quantities:\n
       *  true: All Quantities except for those specified in _noOutputModelQuantitites are written\n
       *  to the output tree.\n
       *  false: Only Quantities specified in _outputModelQuantitiies are written to the output\n
       *  tree.
       */
      bool                          _writeAllModelQuantities;
      std::string                   _chi2Name;
      std::string                   _iterationCounterName;
      std::vector<std::string>      _noOutputModelQuantities;
      std::vector<std::string>      _outputModelQuantities;
      const TString                 _metaDataTreeName;
      const TString                 _treeName;
      /*!
       *  The tree for the metadata.
       */
      TTree*                        _metaDataTree;

    private:
      /*!
       *  Returns the number of status parameters.
       */
      int                           GetNumberOfStatusParameters() const;
      /*!
       *  Adds branch to tree.
       *  \todo Create a wrapper class for TTree and make this a member function of that class.
       */
      void                          AddBranch( TTree* tree, std::string name, const double& value );
      /*!
       *  Adds branch to tree.
       *  \todo Create a wrapper class for TTree and make this a member function of that class.
       */
      void                          AddBranch( TTree* tree, std::string name, const std::string& value );
      /*!
       *  Checks for uniqueness of the branch name.
       *  \todo Create a wrapper class for TTree and make this a member function of that class.
       */
      void                          CheckUniqueness( TTree* tree, std::string name ) const;
      void                          InitializeBranches();
      void                          InitializeTool();
      void                          WriteResultToFile() const;

      /*! \endcond UML */

      // Sorted out of ususal order because initialization depends on items declared earlier.

    protected:
      /*!
       *  Random number generator.
       */
      RandomGenerator*              _randomGenerator;
      /*!
       *  The output tree.
       */
      TTree*                        _tree;

  };

}

#endif // FITTINO_ANALYSISTOOL_H
