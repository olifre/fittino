/* $Id: Messenger.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Messenger.h                                                      *
*                                                                              *
* Description Class for printing messages of various priority                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MESSENGER_H
#define FITTINO_MESSENGER_H

#include <string>

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for printing messages of various priority.
   */
  class Messenger {

    public:
      enum OutputLevel { INFO, DEBUG, VERBOSE, ALWAYS };

    public:
      static Messenger* GetInstance();

    public:
      /*!
       *  Standard constructor.
       */
                        Messenger();
      /*!
       *  Standard destructor.
       */
                        ~Messenger();
      void              PrintALWAYSMessage( std::string alwaysMessage );
      void              PrintDEBUGMessage( std::string debugMessage );
      void              PrintINFOMessage( std::string infoMessage );
      void              PrintVERBOSEMessage( std::string verboseMessage );

    private:
      static Messenger* _instance;

    private:
      OutputLevel       _outputLevel;

  };

}

#endif // FITTINO_MESSENGER_H
