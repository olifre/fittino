/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Tool.h                                                           *
*                                                                              *
* Description Abstract class which provides basic functionality for all tools  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_TOOL_H
#define FITTINO_TOOL_H

#include <string>

#include <boost/property_tree/ptree.hpp>

#include "TString.h"

#include "Messenger.h"

class TFile;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup kernel
   *  \brief Abstract class which provides basic functionality for all tools.
   *
   */
  class Tool {

    public:
      /*!
       *  Takes as input a pointer to the model to be analysed. Via this pointer an association\n
       *  between a model and any class deriving from Tool (especially the concrete\n
       *  optimizer or sampler classes) is established.
       */
      Tool( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Tool();
      /*!
       *  Subdivides the tool's action into three distinct phases. It is usually called directly\n
       *  after the creation of a concrete tool.
       */
      void                        PerformTask();
      /*!
       *  Function to retrieve the updated property tree from this tool.
       */
      boost::property_tree::ptree GetPropertyTree();

    protected:
      /*!
       *  The chi2 of the model.
       */
      double                      _chi2;
      /*!
       *  Counts the number of calls to UpdateModel().
       */
      unsigned int                _iterationCounter;
      /*!
       *  Name of the analysis tool.
       */
      std::string                 _name;
      /*!
       *  Pointer to the model to be analysed. Via this pointer an association between the model\n
       *  and any class deriving from Tool (especially the concrete optimizer or sampler\n
       *  classes) is established.
       */
      ModelBase*                  _model;

    protected:
      /*!
       *  Prints the tool's status to screen.
       */
      void                        PrintStatus() const;
      /*!
       *  Prints one configuration item to screen.
       */
      template<class T> void      PrintItem( const std::string& item, const T& value ) const;

    protected:
      /*!
       *  Causes the tool to propose a new model. How this is done has to be specified by any\n
       *  concrete analysis tool.
       */
      virtual void                UpdateModel() = 0;

      /*! \cond UML */
    private:
      /*!
       *  A copy of the input property tree, to be used for storing information for output-xml files
       *  (e.g. interface files for concatenating Markov Chains.
       */
      boost::property_tree::ptree _ptree;
      const TString               _outputFileName;
      /*!
       *  A ROOT file which stores the tool's output. The default name of the file is\n
       *  "Fittino.out.root".
       */
      TFile*                      _outputFile;

    private:
      /*!
       *  Checks for uniqueness of the branch name and adds branch to tree.
       *  \todo Create a wrapper class for TTree and make this a member function of that class.
       */
      void                        ExecuteTool();
      void                        PrintConfiguration() const;
      void                        TerminateTool();
      /*!
       *  Function to update values in the output property tree. Hm, maybe this has to become
       *  virtual?
       */
      void                        UpdatePropertyTree();

    private:
      virtual void                Execute() = 0;
      virtual void                InitializeTool() = 0;
      /*!
       *  Prints the result of the execution of a particuar analysis tool. It is declared virtual\n
       *  because the result output is different for optimizers and samplers.
       */
      virtual void                PrintResult() const = 0;
      /*!
       *  Prints the steering parameters of a particuar analysis tool.
       */
      virtual void                PrintSteeringParameters() const = 0;
      virtual void                Terminate() = 0;
      virtual void                WriteResultToFile() const = 0;

      /*! \endcond UML */

  };

}

template<class T>
void Fittino::Tool::PrintItem( const std::string& item, const T& value ) const {

  Messenger& messenger = Messenger::GetInstance();

  const std::string& indent  = std::string( 4, ' ' );
  const std::string& spacing = std::string( 51 - item.length(), ' ' );

  messenger << Messenger::ALWAYS << indent + item + spacing << value << Messenger::Endl;

};

#endif // FITTINO_TOOL_H
