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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
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
   *  \ingroup kernel
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
                double      lowerBound,
                double      upperBound );
      Quantity( std::string name,
                std::string plotName,
                double      value,
                std::string unit,
                std::string plotUnit,
                double      lowerBound,
                double      upperBound );
      /*!
       *  Standard constructor
       */
      Quantity( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Quantity();
      /*!
       *  Returns the lower bound of the quantity.
       */
      double                GetLowerBound() const;
      /*!
       *  Returns the upper bound of the quantity.
       */
      double                GetUpperBound() const;
      /*!
      *  Returns the name of the quantity.
      */
      std::string           GetName() const;
      /*!
       *  Returns the name of the axis title.
       */
      std::string           GetPlotName() const;

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

    protected:
      /*!
       *  Value of the quantity.
       */
      double                _value;
      /*!
       *  Name of the quantity.
       */
      std::string           _name;
      std::string           _unit;

    private:
      /*!
       *  Lower bound of the quantity.
       */
      double                _lowerBound;
      /*!
       *  Upper bound of the quantity.
       */
      double                _upperBound;
      /*!
       *  Name of the axis in the plot.
       */
      std::string           _plotName;
      std::string           _plotUnit;

  };

}

#endif // FITTINO_QUANTITY_H
