/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        EdgeDetectionTool.h                                              *
*                                                                              *
* Description Derived class to run an Edge Detection for finding buggy points  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Matthias Hamer      <mhamer@cbpf.br>                             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EDGEDETECTIONTOOL_H
#define FITTINO_EDGEDETECTIONTOOL_H

#include "Tool.h"


class TFile;
class TH2D;
class TSpline;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class EdgeDetectionTool : public Tool {

    public:
      
      EdgeDetectionTool( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~EdgeDetectionTool();

    protected:
      virtual void                UpdateModel(); 

      /*! \cond UML */
    
    private:
      virtual void                Execute();
      virtual void                InitializeTool();
      
      virtual void                PrintResult() const;
      
      virtual void                PrintSteeringParameters() const;
      virtual void                Terminate();
      virtual void                WriteResultsToFile() const;

      /*! \endcond UML */

      std::vector<TH2D*>          _histogramVector;
      std::vector<std::string>    _histogramNameVector;
      std::string                 _histogramFileName;
      std::vector<TSpline*>       _splineVector;
      unsigned int                _numberOfCleaningSteps;

  };

}

#endif // FITTINO_EDGEDETECTIONTOOL_H
