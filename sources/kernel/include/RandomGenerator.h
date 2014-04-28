/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RandomGenerator.h                                                *
*                                                                              *
* Description Singleton wrapper class for random number generator              *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_RANDOMGENERATOR_H
#define FITTINO_RANDOMGENERATOR_H

class TRandom3;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Singleton wrapper class for random number generator.
   */
  class RandomGenerator {

    public:
      /*!
       *  Returns a static pointer to the unique instance of this class.
       */
      static RandomGenerator* GetInstance();

    public:
      /*!
       *  Get a Gaussian random number with mean mu and standard deviation sigma.
       */
      double                  Gaus( double mu, double sigma );
      /*!
       *  Get a Poissonian random number with mean value lambda.
       */
      double                  Poisson( double lambda );
      /*!
       * Get a Uniform random number r with 0 < r <= x
       */
      double                  Uniform( double x );
      /*!
       * Get a Uniform random number r with x1 < r <= x2
       */
      double                  Uniform( double x1, double x2 );
      /*!
       * Get an Integer random number r with 0 <= r <= imax -1
       */
      unsigned int            Integer( unsigned int imax );
      /*!
       *  Get the random seed.
       */
      unsigned int            GetSeed();
      /*!
       *  Set the random seed for the generator.
       */
      void                    SetSeed( unsigned int randomSeed );
      /*!
       *  Get the actual random generator.
       *  Do we want this? Or should we stick to wrapper functions for every pdf?
       */
      TRandom3*               GetGenerator();

      /*! \cond UML */
    private:
      /*!
       *  Pointer to the unique instance of this class.
       */
      static RandomGenerator* _instance;

    private:
      /*!
       *  The random seed.
       */
      int                     _randomSeed;
      /*!
       *  The pointer to a TRandom3 generator.
       */
      TRandom3*               _generator;

    private:
      /*!
       *  Standard constructor.
       */
      RandomGenerator();
      /*!
       *  Standard destructor.
       */
      ~RandomGenerator();

      /*! \endcond UML */

  };

}

#endif // FITTINO_RANDOMGENERATOR_H
