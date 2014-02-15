/* $Id: SimpleOptimizer.h 1843 2014-01-30 22:04:27Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleOptimizer.h                                                *
*                                                                              *
* Description Class for simple parameter optimizer                             *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLEOPTIMIZER_H
#define FITTINO_SIMPLEOPTIMIZER_H

#include "OptimizerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup optimizers
   *  \brief Class for simple parameter optimizer.
   */
  class SimpleOptimizer : public OptimizerBase {

    public:
      /*!
       *  Standard constructor.
       */
      SimpleOptimizer( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SimpleOptimizer();

      /*! \cond UML */
    private:
      unsigned int       _bestEntry;
      unsigned int       _iEntry;
      const unsigned int _stepWidth;
      std::string        _inputFileName;

    private:
      virtual void       PrintSteeringParameters() const;
      virtual void       UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_SIMPLEOPTIMIZER_H
