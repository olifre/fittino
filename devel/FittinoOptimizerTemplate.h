/* $Id: FittinoOptimizerTemplate.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoOptimizerTemplate.h                                       *
*                                                                              *
* Description Fittino optimizer template                                       *
*                                                                              *
* Authors     Name Surname  <email@domain>                                     *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FITTINOOPTIMIZERTEMPLATE_H
#define FITTINO_FITTINOOPTIMIZERTEMPLATE_H

// Include additional needed classes here (remove this comment when done).

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Add a brief description this optimizer here.
   */
  class FittinoOptimizerTemplate : public OptimizerBase {

    public:
      /*!
       *  Add a brief description of the constructor of this opitmizer here.
       */
                   FittinoOptimizerTemplate( ModelBase* model );
      /*!
       *  Add a brief description of the destructor of this opitmizer here.
       */
                   ~FittinoOptimizerTemplate();

    // Insert a sorted list of the steering parameters of your optimizer here. Make them private
    // (remove this comment when done).

    // private:
    //   ParameterType _parameterName;
    //   ...

    private:
      virtual void PrintSteeringParameters();
      /*!
       *  Add a brief description on how this function is implemented in this optimizer here.
       */
      virtual void UpdateModel();

  };

}

#endif // FITTINO_FITTINOOPTIMIZERTEMPLATE_H
