/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RandomGenerator.h                                                *
*                                                                              *
* Description Singleton wrapper class for random number generator              *
*                                                                              *
* Authors     Matthias Hamer      <mhamer@cbpf.br>                             *
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

  class RandomGenerator {

    public:
      /*!
       *  Returns a static pointer to the unique instance of this class.
       */
      static RandomGenerator*           GetInstance();
      /*!
       *  Set the random seed for the generator
       */
      void                              SetSeed( unsigned int randomSeed );
      /*!
       *  Get the random seed
       */
      unsigned int                      GetSeed();
      /*!
       *  Get a Gaussian random number with mean mu and standard deviation sigma
       */
      double                            Gaus( double mu, double sigma );
      /*! 
       * Get a Poissonian random number with mean value lambda
       */
      double                            Poisson( double lambda );
      /*!
       * Get the actual random generator. 
       * Do we want this? Or should we stick to wrapper functions for every pdf?
       */
      TRandom3*                         GetGenerator();

    private:
      /*!
       *  Pointer to the unique instance of this class.
       */
      static RandomGenerator*           _instance;

    private:
      /*
       * The pointer to a TRandom3 generator.
       */
       TRandom3*                        _generator;
      /*
       * The random seed
       */
       int                              _randomSeed;
    
    private:
      /*!
       *  Standard constructor.
       */
      RandomGenerator();
      /*!
       *  Standard destructor.
       */
      ~RandomGenerator();

  };

}

#endif // FITTINO_RANDOMGENERATOR_H
