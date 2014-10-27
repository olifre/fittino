/* $Id$ */

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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MESSENGER_H
#define FITTINO_MESSENGER_H

#include <sstream>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Class for printing messages of various priority.
   */
  class Messenger : public std::ostringstream {

    public:
      /*!
       *  This string can be used to visually seperate individual processing steps in Fittino.
       */
      const static std::string& _dashedLine;

    public:
      enum                      VerbosityLevel { DEBUG, INFO, ALWAYS };

    public:
      static Messenger&         Endl( Messenger& messenger );
      static Messenger&         GetInstance();

    public:
      void                      SetVerbosityLevel( const std::string& verbosityLevel );
      VerbosityLevel            GetVerbosityLevel() const;

    public:
      Messenger&                operator<<( std::ios & ( *_f )( std::ios& ) );
      Messenger&                operator<<( std::ostream & ( *_f )( std::ostream& ) );
      Messenger&                operator<<( Messenger & ( *_f )( Messenger& ) );
      Messenger&                operator<<( VerbosityLevel verbosityLevel );

    public:
      template<class T>
      Messenger&                operator<<( T arg );

      /*! \cond UML */
    private:
      VerbosityLevel            _verbosityLevel;
      VerbosityLevel            _actualVerbosityLevel;

    private:
      /*!
       *  Standard constructor.
       */
      Messenger();
      /*!
       *  Standard destructor.
       */
      ~Messenger();
      void                      Send();
      void                      SetVerbosityLevel( const VerbosityLevel& verbosityLevel );

      /*! \endcond UML */

  };

}

template<class T>
Fittino::Messenger& Fittino::Messenger::operator<<( T arg ) {

  if ( _actualVerbosityLevel >= _verbosityLevel ) {

    *( std::ostringstream* )this << arg;

  }

  return *this;

}

#endif // FITTINO_MESSENGER_H
