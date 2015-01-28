/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FormulaQuantity.h                                                *
*                                                                              *
* Description                                      *
*                                                                              *
* Authors                               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FORMULAQUANTITY_H
#define FITTINO_FORMULAQUANTITY_H

#include <vector>

#include "Quantity.h"

class TFormula;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class ModelBase;

  /*!
   *  \ingroup calculators
   *  \brief
   */
  class FormulaQuantity : public Quantity {

    public:

      FormulaQuantity( std::string name, std::string formula, const ModelBase* model );

      ~FormulaQuantity();

      void Update();

    private:

        TFormula* _formula;
        std::vector<const Quantity*> _parameters;
  };

}

#endif
