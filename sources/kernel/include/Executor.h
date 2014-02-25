/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Executor.h                                                       *
*                                                                              *
* Description Executes an external program                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EXECUTOR_H
#define FITTINO_EXECUTOR_H

#include <string>
#include <vector>

struct timespec;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Executes an external program
   */
  class Executor {

    public:
      Executor( std::string path, std::string arg0 );
      ~Executor();
      int                      Execute();
      void                     AddArgument( std::string argument );
      void                     SetCompletionTimeout( double timeout );
      void                     SetCreationTimeout( double timeout );


    private:
      double                   _completionTimeout;
      int                      _pid;
      int                      _pipefds[2];
      int                      _rc;
      timespec*                _creationTimeout;
      std::string _path;
      std::vector<std::string> _args;

    private:
      void                     Child();
      void                     Parent();
      void                     Read();
      void                     Wait();

  };

}

#endif  // FITTINO_EXECUTOR_H
