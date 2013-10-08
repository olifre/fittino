/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCModelCalculator.h                                             *
*                                                                              *
* Description Base class for LHC model calculators                 *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*    	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_LHCMODELCALCULATOR_H
#define FITTINO_LHCMODELCALCULATOR_H

#include <map>
#include <vector>
#include <string>

#include "ModelCalculatorBase.h"
#include "THnSparse.h"

class TH1D;
class TH2D;
class TH3D;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Base class for LHC model calculators.
   */
  class LHCModelCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                           LHCModelCalculator( const PhysicsModelBase* model );
      /*!
       *  Standard destructor.
       */
                           ~LHCModelCalculator();
    
    public:
      virtual void        CalculatePredictions();
      virtual void        CallFunction();
      virtual void        CallExecutable();
      virtual void        ConfigureInput();
      virtual void        Initialize() const;
      void                AddAnalysis( std::string name, std::string fileName, std::string histName, std::vector<std::string> relevantParameters );
      void                UpdateAnalysisHistogram( std::string name, std::string fileName, std::string newHistogramName, std::vector<std::string> relevantParameters );

    private:
      std::map<std::string, TH1D*>                    _chi2Histograms1D;
      std::map<std::string, TH2D*>                    _chi2Histograms2D;
      std::map<std::string, TH3D*>                    _chi2Histograms3D;
      std::map<std::string, THnSparseD*>              _chi2HistogramsnD;
      std::map<std::string, std::vector<std::string> > _relevantParametersMap;

  };

}

#endif // FITTINO_LHCMODELCALCULATOR_H
