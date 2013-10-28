/* $Id: Quantity.h 1432 2013-07-12 22:04:21Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Quantity.h                                                       *
*                                                                              *
* Description Base class for quantities                                        *
*                                                                              *
* Authors     Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_QUANTITY_H
#define FITTINO_QUANTITY_H

#include <string>

#include <boost/property_tree/ptree.hpp>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for quantities.
   */
  class Quantity {

    public:
      /*!
       *  Takes as input the name and value of the quantity as well as
       *  information for plotting.
       */
                            Quantity( std::string name,
                                      std::string plotName,
                                      double      value,
                                      double      plotLowerBound,
                                      double      plotUpperBound );
      /*!
       *  Standard constructor
       */
                            Quantity( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                            ~Quantity();
      double                GetPlotLowerBound() const;
      double                GetPlotUpperBound() const;
       /*!
       *  Returns the name of the quantity.
       */
      std::string           GetName() const;

    public:
      /*!
       *  Returns the value of the quantity.
       */
      virtual const double& GetValue() const;
      /*!
       *  Prints the quantity status on screen.
       */
      virtual void          PrintStatus() const;
      /*!
       *  Sets the value of the quantity.
       */
      virtual void          SetValue( double value );
      /*!
       *  Returns the name of the axis title.
       */
      virtual std::string   GetPlotName() const;

    protected:
      double                _plotLowerBound;
      double                _plotUpperBound;
      /*!
       *  Value of the quantity.
       */
      double                _value;
      /*!
       *  Name of the quantity.
       */
      std::string           _name;
      /*!
       *  Name of the axis in the plot.
       */
      std::string           _plotName;

  };

}

#endif // FITTINO_QUANTITY_H
