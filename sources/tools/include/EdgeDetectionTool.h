/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        EdgeDetectionTool.h                                              *
*                                                                              *
* Description Class to run an Edge Detection for finding buggy points          *
*                                                                              *
* Authors     Matthias Hamer       <mhamer@cbpf.br>                            *
*             Mathias  Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>             *
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

  /*!
   *  \defgroup tools
   */
  /*!
   *  \ingroup tools
   *  \brief Class to run an Edge Detection for finding buggy points.
   */
  class EdgeDetectionTool : public Tool {

    public:
      
      EdgeDetectionTool( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~EdgeDetectionTool();

    protected:
      void                        UpdateModel(); 

      /*! \cond UML */
    
    private:
      void                        Execute();
      void                        InitializeTool();
      
      void                        PrintResult() const;
      
      void                        PrintSteeringParameters() const;
      void                        Terminate();
      void                        WriteResultToFile() const;

      /*! \endcond UML */

      std::vector<TH2D*>          _histogramVector;
      std::vector<std::string>    _histogramNameVector;
      std::string                 _histogramFileName;
      std::vector<TSpline*>       _splineVector;
      unsigned int                _numberOfCleaningSteps;

  };

}

#endif // FITTINO_EDGEDETECTIONTOOL_H
