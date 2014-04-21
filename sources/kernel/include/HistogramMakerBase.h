/* $Id: HistogramMakerBase.h 1899 2014-02-15 12:57:55Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HistogramMakerBase.h                                             *
*                                                                              *
* Description Base class for histogram makers                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HISTOGRAMMAKERBASE_H
#define FITTINO_HISTOGRAMMAKERBASE_H

#include "Tool.h"

class TH1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Base class for histogram makers.
   */
  class HistogramMakerBase : public Tool {

    public:
      /*!
       *  Standard constructor.
       */
      HistogramMakerBase( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HistogramMakerBase();

    protected:
      unsigned int              _iEntry;
      std::vector<double>       _lowerBound;
      std::vector<double>       _upperBound;
      std::vector<unsigned int> _numberOfBins;
      std::vector<std::string>  _plotName;
      std::vector<std::string>  _quantityName;
      std::vector<TH1*>         _histogramVector;

    protected:
      void                      PrintSteeringParameters() const;

      /*! \cond UML */
    private:
      void                      Execute();
      void                      InitializeTool();
      void                      PrintResult() const;
      void                      Terminate();
      void                      WriteResultToFile() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_HISTOGRAMMAKERBASE_H
