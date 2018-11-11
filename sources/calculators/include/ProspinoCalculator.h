/* $Id: MadGraphCalculator.h 2775 2016-11-15 12:41:43Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MadGraphCalculator.h                                             *
*                                                                              *
* Description Wrapper class for MadGraph                                       *
*                                                                              *
* Authors       <@>                                                            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PROSPINOCALCULATOR_H
#define FITTINO_PROSPINOCALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "Executor.h"
#include "InputFile.h"
#include "SLHACalculatorBase.h"
#include <map>

class TTree;
class TFile;
class TGraph;
class TF1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \defgroup calculators
   */
  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for MadGraph
   */
  class ProspinoCalculator : public SLHACalculatorBase{


    public:
      /*!
       *  Standard constructor.
       */
                          ProspinoCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~ProspinoCalculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize();
      virtual void        SetupMeasuredValues();
      void                ReadFile();
     private:
    InputFile*             _inputFile;

     //InputFile _inputFile;
   //  Executor  _executor;
    std::string _ProOutput;
    std::string _SLHAFileForProspino;
    std::string _executable; 
     double _weight;
      double _nevents;
      double _XSgogo;
      double _XSb1b1;
      double _XSb2b2;
      double _XSt1t1;
      double _XSt2t2;
      double _XSgosq;
      double _XSsqsq;
      double _XSsqasq;

     std::string _SLHAFile;

//     std::map<std::string, int> _pdgIds;
    
     std::string _name;

  };

}

#endif // FITTINO_PROSPINOCALCULATOR
